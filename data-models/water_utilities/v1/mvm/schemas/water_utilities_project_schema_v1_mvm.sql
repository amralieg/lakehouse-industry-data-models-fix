-- Schema for Domain: project | Business: Water Utilities | Version: v1_mvm
-- Generated on: 2026-05-06 01:37:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `water_utilities_ecm`.`project` COMMENT 'Capital improvement program (CIP) and project management including project planning, design management, construction management, contractor coordination, project budgeting and cost control, schedule tracking, change order management, commissioning, and asset handover. Manages infrastructure expansion, rehabilitation, and renewal projects from concept through operational turnover.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `water_utilities_ecm`.`project`.`cip_project` (
    `cip_project_id` BIGINT COMMENT 'Unique identifier for the CIP project. Primary key for the cip_project data product.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: CIP projects require environmental/discharge permits before construction. Project managers track permit compliance for regulatory approval and construction authorization. Essential for permit complian',
    `conservation_program_id` BIGINT COMMENT 'Foreign key linking to service.conservation_program. Business justification: CIP projects are frequently initiated to support or fulfill conservation program mandates (e.g., recycled water infrastructure, AMI deployment for demand management). Water utilities track capital inv',
    `debt_instrument_id` BIGINT COMMENT 'Foreign key linking to finance.debt_instrument. Business justification: Water utility revenue bonds and SRF loans are issued to fund specific CIP projects. Bond proceeds must be tracked by project for IRS arbitrage compliance, bond covenant reporting, and CAFR disclosure.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: CIP projects are scoped to specific treatment facilities for capital planning, budget tracking, and regulatory reporting. Water utility capital programs are organized by facility (WTP, WWTP). A projec',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Capital projects are justified by service capacity needs for specific offerings (e.g., potable water treatment expansion, industrial wastewater service). Project business cases and regulatory filings ',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to finance.finance_rate_case. Business justification: Water utilities rate case filings require listing specific CIP projects as capital expenditure justification for rate increases. Regulators review individual projects within the rate case. Linking CIP',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Capital projects are often mandated by regulatory requirements (Lead and Copper Rule, SDWA standards, consent decrees). Tracking the driving requirement justifies capital expenditure and enables compl',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: CIP projects are funded through specific tariff mechanisms (infrastructure surcharges, connection fee tariffs, system development charges). Linking cip_project to tariff enables rate case cost recover',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Every capital project serves or expands a specific service territory. Project planning, regulatory permit applications, rate case justifications, and asset handover to operations all require territory',
    `water_system_id` BIGINT COMMENT 'Foreign key linking to quality.water_system. Business justification: Every CIP project is executed on a specific water system. Water utilities track capital investment by water system for rate-setting, regulatory reporting by PWSID, and asset management. cip_project.se',
    `actual_completion_date` DATE COMMENT 'Actual date the project was completed and accepted for operational turnover. Null if project is not yet complete.',
    `actual_cost_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual expenditures incurred on the project from inception through the current reporting period. Includes committed and paid amounts.',
    `actual_start_date` DATE COMMENT 'Actual date the project or construction phase commenced. Null if project has not yet started.',
    `asset_class` STRING COMMENT 'Type of asset being constructed, rehabilitated, or replaced (e.g., water_main, pump_station, treatment_plant, storage_tank, meter_infrastructure, SCADA_system). Aligns with asset registry classification.',
    `authorized_budget_amount` DECIMAL(18,2) COMMENT 'Total budget amount authorized for the project by governing board or executive approval. Represents the funding ceiling for all project expenditures including design, construction, contingency, and administrative costs.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all project financial amounts (e.g., USD for United States Dollar).. Valid values are `^[A-Z]{3}$`',
    `change_order_count` STRING COMMENT 'Total number of approved change orders issued for the project. Indicates scope changes, unforeseen conditions, or design modifications.',
    `cip_program_year` STRING COMMENT 'Fiscal year in which the project was authorized and budgeted within the CIP plan (e.g., 2024). Used for multi-year CIP planning and tracking.',
    `cost_variance_amount` DECIMAL(18,2) COMMENT 'Dollar amount the project is under (negative) or over (positive) budget. Calculated as estimated total cost minus authorized budget amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CIP project record was first created in the system. Represents the initial capture of the project in the data platform.',
    `design_capacity_mgd` DECIMAL(18,2) COMMENT 'Design capacity of the asset being constructed or upgraded, measured in million gallons per day (MGD). Applicable to treatment plants, pump stations, and conveyance infrastructure. Null for non-capacity projects.',
    `environmental_review_status` STRING COMMENT 'Status of environmental review process (NEPA, CEQA, or state equivalent): not_required (no review needed), pending (not yet started), in_progress (under review), completed (review finished), approved (clearance granted).. Valid values are `not_required|pending|in_progress|completed|approved`',
    `estimated_customers_impacted` STRING COMMENT 'Estimated number of customer accounts or service connections affected by the project during construction or upon completion. Used for outreach planning and benefit analysis.',
    `estimated_total_cost` DECIMAL(18,2) COMMENT 'Current estimate of total project cost including all phases, change orders, and contingencies. Updated throughout project lifecycle as scope and conditions evolve.',
    `forecast_completion_date` DATE COMMENT 'Current forecast for project completion based on progress, schedule changes, and known delays. Updated regularly throughout project lifecycle.',
    `funding_source` STRING COMMENT 'Primary source of project funding (e.g., revenue_bonds, general_obligation_bonds, state_revolving_fund, federal_grant, rate_revenue, developer_contribution). May reference multiple sources for blended financing.',
    `infrastructure_category` STRING COMMENT 'Primary infrastructure system served by the project: water (treatment and distribution), wastewater (collection and treatment), shared (benefits both systems), stormwater (drainage and management), or other.. Valid values are `water|wastewater|shared|stormwater|other`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in the CIP project record. Used for change tracking and data freshness monitoring.',
    `operational_turnover_date` DATE COMMENT 'Date the completed asset was formally transferred from the project team to operations and maintenance for ongoing management. Marks the end of the project lifecycle and start of asset operational life.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Current percentage of project completion based on earned value, milestones achieved, or physical progress. Range 0.00 to 100.00.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether the project requires regulatory permits (e.g., construction permits, environmental permits, discharge permits). True if permits are required; false otherwise.',
    `planned_completion_date` DATE COMMENT 'Originally planned date for project completion and operational turnover. Used for baseline schedule tracking and variance analysis.',
    `planned_start_date` DATE COMMENT 'Originally planned date for project initiation or construction start. Used for baseline schedule tracking and variance analysis.',
    `priority_tier` STRING COMMENT 'Business priority ranking for the project based on risk, regulatory mandate, service impact, and strategic alignment. Critical projects address immediate safety or compliance issues; deferred projects are postponed pending funding.. Valid values are `critical|high|medium|low|deferred`',
    `project_description` STRING COMMENT 'Detailed narrative describing the project scope, objectives, and expected outcomes. Includes technical specifications, service area impact, and business justification.',
    `project_manager_name` STRING COMMENT 'Full name of the project manager assigned to lead the CIP project. Denormalized for reporting convenience.',
    `project_name` STRING COMMENT 'Full descriptive name of the CIP project (e.g., Main Street Water Main Replacement Phase 2, North WWTP Clarifier Upgrade).',
    `project_number` STRING COMMENT 'Business identifier for the CIP project, typically formatted as program code followed by sequential number (e.g., WTP-2024-001). Used in external communications, contracts, and regulatory filings.. Valid values are `^[A-Z0-9]{2,4}-[0-9]{4,6}$`',
    `project_phase` STRING COMMENT 'Current lifecycle phase of the CIP project: concept (initial scoping), planning (feasibility and alternatives analysis), design (engineering drawings and specifications), procurement (contractor selection), construction (field execution), commissioning (testing and startup), closeout (final documentation and handover), operational (asset in service). [ENUM-REF-CANDIDATE: concept|planning|design|procurement|construction|commissioning|closeout|operational — 8 candidates stripped; promote to reference product]',
    `project_status` STRING COMMENT 'Current operational status of the project: active (work progressing), on_hold (temporarily paused), delayed (behind schedule), cancelled (terminated before completion), completed (finished and closed).. Valid values are `active|on_hold|delayed|cancelled|completed`',
    `project_type` STRING COMMENT 'Classification of the CIP project by nature of work: expansion (capacity increase), rehabilitation (restore to original condition), renewal (extend useful life), replacement (like-for-like), upgrade (improve performance), new_construction (greenfield), or regulatory_compliance (mandated by regulation). [ENUM-REF-CANDIDATE: expansion|rehabilitation|renewal|replacement|upgrade|new_construction|regulatory_compliance — 7 candidates stripped; promote to reference product]',
    `regulatory_driver` STRING COMMENT 'Regulatory mandate or compliance requirement driving the project (e.g., SDWA Lead and Copper Rule Revisions, NPDES permit condition, consent decree requirement, state water quality standard). Null for non-compliance projects.',
    `schedule_variance_days` STRING COMMENT 'Number of days the project is ahead (negative) or behind (positive) the baseline schedule. Calculated as forecast completion date minus planned completion date.',
    `sponsoring_department` STRING COMMENT 'Organizational department or division that owns and sponsors the project (e.g., Water Operations, Wastewater Treatment, Engineering, Asset Management). Responsible for project outcomes and operational handover.',
    `substantial_completion_date` DATE COMMENT 'Date the project reached substantial completion per contract terms, meaning the asset is functional and can be used for its intended purpose, though minor punch-list items may remain.',
    `warranty_expiration_date` DATE COMMENT 'Date the contractor warranty period expires for the completed project. Typically one year from substantial completion for construction work.',
    CONSTRAINT pk_cip_project PRIMARY KEY(`cip_project_id`)
) COMMENT 'Master record for Capital Improvement Program (CIP) projects covering infrastructure expansion, rehabilitation, and renewal initiatives. Tracks project identity, scope, classification (water/wastewater/shared), CIP program year, funding authorization, project phase (planning, design, construction, commissioning, closeout), priority tier, sponsoring department, project manager assignment, phase classification, project type classification, and lifecycle dates from concept through operational turnover. The authoritative SSOT for all CIP project identity, classification, and status within the utility.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`project`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'Unique identifier for the WBS element. Primary key.',
    `asset_class_id` BIGINT COMMENT 'Reference to the asset class to which completed work from this WBS element will be capitalized. Used for asset handover and capitalization.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent CIP project to which this WBS element belongs.',
    `parent_wbs_element_id` BIGINT COMMENT 'Reference to the parent WBS element in the hierarchy. Null for top-level elements.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: WBS elements for treatment upgrades, infrastructure replacements, or monitoring installations are often driven by specific regulatory requirements. This link supports regulatory capital planning repor',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for executing and managing this WBS element.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.territory. Business justification: WBS elements are geographically scoped to service territories for cost allocation, regulatory reporting, and capital investment tracking by service area. Water utilities report capital spend by territ',
    `account_assignment_category` STRING COMMENT 'Classification of costs for this WBS element as capital expenditure (CAPEX), operating expenditure (OPEX), or mixed.. Valid values are `capital|operating|mixed`',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual costs incurred to date for this WBS element. Includes labor, materials, equipment, and contractor costs.',
    `actual_finish_date` DATE COMMENT 'Actual date when this WBS element was completed. Null if not yet finished.',
    `actual_start_date` DATE COMMENT 'Actual date when work on this WBS element commenced. Null if not yet started.',
    `baseline_finish_date` DATE COMMENT 'Baseline (original approved) finish date for this WBS element, used for schedule variance analysis.',
    `baseline_start_date` DATE COMMENT 'Baseline (original approved) start date for this WBS element, used for schedule variance analysis.',
    `billing_element_flag` BOOLEAN COMMENT 'Indicates whether this WBS element is a billing element (True) or a planning element only (False). Billing elements can be invoiced to external parties or internal cost centers.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated to this WBS element. Supports granular cost control at the work package level.',
    `change_order_count` STRING COMMENT 'Number of approved change orders affecting this WBS element. Used for change management tracking and trend analysis.',
    `commissioning_required_flag` BOOLEAN COMMENT 'Indicates whether formal commissioning and testing are required before this WBS element can be closed (True/False).',
    `committed_cost` DECIMAL(18,2) COMMENT 'Total committed costs (purchase orders, contracts) against this WBS element. Used for funds reservation tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this WBS element record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this WBS element (e.g., USD, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `earned_value` DECIMAL(18,2) COMMENT 'Earned Value (EV) for Earned Value Management (EVM). Represents the budgeted cost of work actually completed to date.',
    `functional_area` STRING COMMENT 'Functional area classification for this WBS element (e.g., Water Treatment, Distribution, Wastewater, Asset Management). Supports cross-functional reporting.',
    `geographic_location` STRING COMMENT 'Geographic location or service area where this WBS element work is being performed (e.g., district, municipality, facility name).',
    `hierarchy_level` STRING COMMENT 'Numeric level in the WBS hierarchy (1 = top-level phase, 2 = deliverable, 3 = work package, etc.). Supports multi-level decomposition.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this WBS element record was last modified.',
    `notes` STRING COMMENT 'Free-text notes and comments related to this WBS element. Used for documenting decisions, issues, and coordination details.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Physical percent complete of this WBS element (0.00 to 100.00). Used for progress tracking and earned value calculation.',
    `planned_finish_date` DATE COMMENT 'Planned completion date for this WBS element.',
    `planned_start_date` DATE COMMENT 'Planned start date for work on this WBS element.',
    `planned_value` DECIMAL(18,2) COMMENT 'Planned Value (PV) for Earned Value Management (EVM). Represents the budgeted cost of work scheduled to be completed by a given date.',
    `priority_code` STRING COMMENT 'Priority classification for this WBS element (critical, high, medium, low). Used for resource allocation and schedule conflict resolution.. Valid values are `critical|high|medium|low`',
    `regulatory_permit_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory permits or approvals are required for this WBS element (True/False). Relevant for environmental compliance and construction permits.',
    `responsible_manager_name` STRING COMMENT 'Name of the manager or project lead responsible for this WBS element.',
    `risk_level` STRING COMMENT 'Risk assessment level for this WBS element (high, medium, low). Reflects technical, schedule, and cost risk exposure.. Valid values are `high|medium|low`',
    `settlement_rule` STRING COMMENT 'Rule defining how costs from this WBS element are settled to fixed assets, cost centers, or other receivers upon project completion.',
    `wbs_element_code` STRING COMMENT 'Externally visible unique code for the WBS element, typically hierarchical (e.g., P-12345.01.02). Used for reporting and integration with financial systems.',
    `wbs_element_description` STRING COMMENT 'Detailed description of the scope, deliverables, and objectives of this WBS element.',
    `wbs_element_name` STRING COMMENT 'Short descriptive name of the WBS element (e.g., Design Phase, Pipeline Installation, Pump Station Construction).',
    `wbs_element_status` STRING COMMENT 'Current lifecycle status of the WBS element (planned, released, in progress, completed, closed, cancelled).. Valid values are `planned|released|in_progress|completed|closed|cancelled`',
    `wbs_element_type` STRING COMMENT 'Classification of the WBS element by its role in the project structure (phase, deliverable, work package, milestone, planning element).. Valid values are `phase|deliverable|work_package|milestone|planning_element`',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Work Breakdown Structure (WBS) element representing a hierarchical decomposition of a CIP project into manageable work packages. Each WBS element carries its own budget, schedule, and cost tracking. Supports multi-level hierarchy (phase, deliverable, work package) aligned to SAP PS WBS structure. Tracks element code, description, level, responsible cost center, planned/actual start and finish dates, and budget allocation. Enables granular cost control and earned value management (EVM) at the work package level.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`project`.`milestone` (
    `milestone_id` BIGINT COMMENT 'Unique identifier for the project milestone record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent CIP project to which this milestone belongs. Links milestone to the overall infrastructure expansion, rehabilitation, or renewal project.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Operational turnover and substantial completion milestones in water utility CIP projects directly trigger asset commissioning — the point an asset enters operational service in the registry. Role-pref',
    `primary_predecessor_milestone_id` BIGINT COMMENT 'Reference to the preceding milestone that must be completed before this milestone can begin. Used for schedule dependency tracking. Null if no predecessor.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Milestones in CIP project management are associated with specific WBS elements (e.g., Design Complete milestone belongs to the Design WBS element). Adding wbs_element_id to milestone enables milesto',
    `acceptance_criteria` STRING COMMENT 'Specific criteria or conditions that must be met for the milestone to be considered complete and accepted. Used for quality control and stakeholder sign-off.',
    `actual_date` DATE COMMENT 'Actual date when the milestone was achieved or completed. Null if milestone is not yet completed. Used for schedule performance measurement.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or role who approved the milestone completion. Used for accountability and audit trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the milestone completion was formally approved. Null if not yet approved. Used for audit trail and compliance documentation.',
    `baseline_date` DATE COMMENT 'Original planned date for milestone completion as established in the approved project baseline schedule. Used as the reference point for schedule variance analysis.',
    `budget_impact_amount` DECIMAL(18,2) COMMENT 'Financial impact or cost associated with achieving this milestone, expressed in US dollars. May include design fees, permit costs, contractor payments, or other milestone-specific expenditures.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of work completed toward achieving this milestone, expressed as a decimal (0.00 to 100.00). Used for progress tracking and earned value analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this milestone record was first created in the system. Used for audit trail and data lineage.',
    `deliverable_description` STRING COMMENT 'Description of the tangible deliverable or outcome associated with this milestone (e.g., signed design drawings, issued permit, executed contract, commissioned asset). Defines what constitutes milestone completion.',
    `forecast_date` DATE COMMENT 'Current projected date for milestone completion based on latest schedule updates and progress assessments. May differ from baseline due to delays or accelerations.',
    `is_critical_path` BOOLEAN COMMENT 'Flag indicating whether this milestone is on the project critical path. True if any delay to this milestone will delay the overall project completion; false otherwise.',
    `is_regulatory_milestone` BOOLEAN COMMENT 'Flag indicating whether this milestone is tied to a regulatory requirement or consent order deadline (e.g., EPA consent decree, state compliance order). True if regulatory; false otherwise.',
    `milestone_name` STRING COMMENT 'Descriptive name of the milestone event (e.g., Design Completion, Permit Issuance, Notice to Proceed, Substantial Completion, Final Completion, Asset Handover).',
    `milestone_number` STRING COMMENT 'Business identifier or sequence number for the milestone within the project (e.g., M-001, M-002). Used for external reporting and communication.',
    `milestone_status` STRING COMMENT 'Current lifecycle status of the milestone. Indicates whether the milestone is planned, in progress, completed, delayed, cancelled, or on hold.. Valid values are `planned|in_progress|completed|delayed|cancelled|on_hold`',
    `milestone_type` STRING COMMENT 'Category of milestone within the project lifecycle. Classifies the phase or functional area of the milestone event.. Valid values are `design|permitting|procurement|construction|commissioning|closeout`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this milestone record was last updated. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to the milestone. May include lessons learned, stakeholder feedback, or other relevant information for project team reference.',
    `regulatory_reference` STRING COMMENT 'Reference number or citation for the regulatory requirement or consent order associated with this milestone (e.g., consent decree docket number, permit condition reference). Null if not a regulatory milestone.',
    `responsible_party` STRING COMMENT 'Name or identifier of the party responsible for achieving this milestone (e.g., design consultant, contractor, utility staff, regulatory agency). May be individual or organization.',
    `responsible_party_type` STRING COMMENT 'Classification of the responsible party. Indicates whether the party is internal utility staff, external contractor, consultant, vendor, or regulatory agency.. Valid values are `internal|contractor|consultant|vendor|regulatory_agency`',
    `risk_level` STRING COMMENT 'Assessment of the risk level associated with achieving this milestone on schedule. Considers factors such as complexity, dependencies, resource availability, and external constraints.. Valid values are `low|medium|high|critical`',
    `variance_commentary` STRING COMMENT 'Narrative explanation of any schedule variance, including root causes of delays or early completions, corrective actions taken, and impact on downstream milestones. Used for project status reporting.',
    `variance_days` STRING COMMENT 'Number of days between baseline date and actual or forecast date. Positive values indicate delay; negative values indicate early completion. Used for schedule performance reporting.',
    CONSTRAINT pk_milestone PRIMARY KEY(`milestone_id`)
) COMMENT 'Scheduled and actual milestone events within a CIP project lifecycle including design completion, permit issuance, notice to proceed (NTP), substantial completion, final completion, and asset handover. Tracks milestone type, baseline date, forecast date, actual date, responsible party, completion status, and any variance commentary. Used for schedule performance reporting and regulatory deadline tracking (e.g., consent order milestones).';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`project`.`project_budget` (
    `project_budget_id` BIGINT COMMENT 'Unique identifier for the project budget record. Primary key for the project budget entity.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent Capital Improvement Program (CIP) project or capital project for which this budget is authorized.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Project budgets allocate to cost centers for overhead allocation, departmental accountability, and indirect cost recovery calculations required for rate-making and grant compliance.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Project budgets must tie to specific utility funds for GASB fund accounting compliance, rate case documentation, and fund balance management. Essential for governmental accounting standards.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Project budgets map to GL accounts for financial reporting, budget-to-actual variance analysis, and GASB capital asset classification. Critical for financial statement preparation.',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to service.tariff. Business justification: Project budgets track rate revenue as a funding source (rate_revenue_amount attribute exists). Linking project_budget directly to tariff enables precise rate case cost recovery reporting — showing whi',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: project_budget has a denormalized STRING column wbs_element that should be replaced with a proper FK to wbs_element. In CIP accounting, budgets are allocated at the WBS element level — this is stand',
    `actual_expenditure_amount` DECIMAL(18,2) COMMENT 'Total actual expenditures posted to this budget to date. Sum of all invoices, payments, and costs charged against this project budget.',
    `appropriation_ordinance_number` STRING COMMENT 'Municipal ordinance or resolution number that legally authorized this budget appropriation. Required for public sector utilities subject to legislative budget approval.',
    `approval_date` DATE COMMENT 'Date on which this budget was formally approved by the governing authority such as the utility board, city council, or public utilities commission.',
    `approved_amendments_amount` DECIMAL(18,2) COMMENT 'Total cumulative amount of approved budget amendments, change orders, and supplemental appropriations that have been added to or subtracted from the original budget.',
    `bond_amount` DECIMAL(18,2) COMMENT 'Portion of the budget funded by municipal bonds, revenue bonds, or general obligation bonds issued to finance capital improvements.',
    `budget_category` STRING COMMENT 'High-level budget category classification such as treatment plant upgrades, distribution system expansion, wastewater collection rehabilitation, or meter replacement program.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget record indicating approval state and whether the budget is active for expenditure tracking.. Valid values are `draft|submitted|approved|active|closed|cancelled`',
    `capex_amount` DECIMAL(18,2) COMMENT 'Portion of the budget classified as capital expenditure (CAPEX) that will be capitalized as a fixed asset. Represents investment in long-term infrastructure assets.',
    `contingency_amount` DECIMAL(18,2) COMMENT 'Budget amount set aside as contingency reserve for unforeseen costs, scope changes, or risk mitigation. Typically a percentage of the base construction budget.',
    `contingency_percentage` DECIMAL(18,2) COMMENT 'Contingency reserve expressed as a percentage of the base project budget. Common practice is 10-20% for water utility CIP projects depending on project complexity and risk.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the system. Supports audit trail and budget lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget record. Typically USD for U.S. water utilities.. Valid values are `^[A-Z]{3}$`',
    `current_approved_budget_amount` DECIMAL(18,2) COMMENT 'Current total authorized budget amount including original budget plus all approved amendments. This is the active budget ceiling for expenditure control.',
    `effective_date` DATE COMMENT 'Date from which this budget becomes effective and available for expenditure authorization. May differ from approval date due to fiscal year or appropriation timing.',
    `encumbered_amount` DECIMAL(18,2) COMMENT 'Total amount of budget that has been encumbered through purchase orders, contracts, or commitments but not yet expended. Represents committed but unspent funds.',
    `expiration_date` DATE COMMENT 'Date on which this budget authorization expires if not fully expended or encumbered. Multi-year CIP budgets may have extended expiration dates.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which this budget is authorized, typically a four-digit year (e.g., 2024). Aligns with municipal or utility fiscal calendar.',
    `funding_source_primary` STRING COMMENT 'Primary funding source for this budget allocation such as revenue bonds, general obligation bonds, grants, rate revenue, developer contributions, or state revolving fund loans.',
    `funding_source_secondary` STRING COMMENT 'Secondary or supplemental funding source if the project budget is financed from multiple sources. Supports blended financing structures common in large CIP projects.',
    `grant_amount` DECIMAL(18,2) COMMENT 'Portion of the budget funded by federal, state, or local grants such as EPA Water Infrastructure Finance and Innovation Act (WIFIA) or state drinking water revolving fund grants.',
    `is_multi_year_budget` BOOLEAN COMMENT 'Flag indicating whether this budget spans multiple fiscal years. True for large CIP projects with multi-year appropriations; false for single-year budgets.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was last updated or modified. Tracks most recent change to budget amounts, status, or attributes.',
    `last_revision_date` DATE COMMENT 'Date of the most recent budget revision, amendment, or change order that modified the approved budget amount or allocation.',
    `notes` STRING COMMENT 'Free-text notes documenting budget assumptions, constraints, special conditions, or explanations for amendments and revisions. Supports audit trail and budget justification.',
    `opex_amount` DECIMAL(18,2) COMMENT 'Portion of the budget classified as operating expenditure (OPEX) that will be expensed in the current period. Represents operational costs not capitalized.',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'Initial authorized budget amount at the time of project appropriation or budget approval. Baseline budget before any amendments or revisions.',
    `owner` STRING COMMENT 'Name or identifier of the project manager, department head, or budget owner responsible for managing expenditures against this budget allocation.',
    `phase` STRING COMMENT 'Project phase to which this budget allocation applies. CIP projects typically have budgets segmented by planning, design, construction, contingency, and inspection phases.. Valid values are `planning|design|construction|contingency|inspection|closeout`',
    `rate_revenue_amount` DECIMAL(18,2) COMMENT 'Portion of the budget funded directly from water and wastewater rate revenue collected from customers. Pay-as-you-go financing from operating cash flow.',
    `remaining_budget_amount` DECIMAL(18,2) COMMENT 'Remaining unencumbered and unexpended budget available for future commitments. Calculated as current approved budget minus encumbrances minus actual expenditures.',
    `revision_number` STRING COMMENT 'Sequential revision number tracking the count of budget amendments or changes. Starts at 0 for original budget and increments with each approved revision.',
    `version` STRING COMMENT 'Version type of the budget record indicating whether this is the original appropriation, a revised budget after amendments, or the current approved budget.. Valid values are `original|revised|amended|current|forecast`',
    CONSTRAINT pk_project_budget PRIMARY KEY(`project_budget_id`)
) COMMENT 'Authorized budget record for a CIP project or WBS element capturing total project appropriation, budget by phase (planning, design, construction, contingency, inspection), CAPEX vs OPEX split, funding source allocations, budget revision history, and current approved budget. Tracks original budget, approved amendments, current budget, encumbrances, actual expenditures, and remaining budget. Integrates with SAP FI/CO for financial control and Tyler Munis for municipal budget appropriation.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`project`.`budget_amendment` (
    `budget_amendment_id` BIGINT COMMENT 'Unique identifier for the budget amendment record. Primary key for the budget amendment entity.',
    `cip_project_id` BIGINT COMMENT 'Reference to the CIP project for which this budget amendment applies. Links the amendment to the parent capital project.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget amendments adjust cost center budgets and require cost center manager approval for budget reallocation. Essential for departmental budget control.',
    `enforcement_action_id` BIGINT COMMENT 'Foreign key linking to compliance.enforcement_action. Business justification: Budget amendments are required when enforcement actions mandate unplanned capital expenditures (civil penalties, required infrastructure upgrades, SEP costs). Finance and compliance teams need this li',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Budget amendments adjust fund appropriations and require fund manager approval. Critical for fund balance management and compliance with appropriation ordinances.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Budget amendments adjust GL account budgets for financial planning and control. Required for budget-to-actual reporting and variance analysis.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to project.project_budget. Business justification: A budget_amendment formally modifies a specific project_budget record. The budget_amendment has cip_project_id but no FK to the specific budget being amended. Adding project_budget_id creates the esse',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Budget amendments in CIP projects are often scoped to specific WBS elements (e.g., amending the budget for a particular work package). Adding wbs_element_id to budget_amendment allows amendments to be',
    `amendment_amount` DECIMAL(18,2) COMMENT 'The dollar value of the budget change. Positive values indicate budget increases; negative values indicate budget decreases or deobligations.',
    `amendment_number` STRING COMMENT 'Sequential or coded identifier for this amendment within the project lifecycle. Used for tracking and referencing specific budget modifications.. Valid values are `^[A-Z0-9]{2,20}$`',
    `amendment_status` STRING COMMENT 'Current state of the amendment in the approval workflow. Tracks progression from draft through final approval or rejection. [ENUM-REF-CANDIDATE: draft|pending_review|pending_approval|approved|rejected|withdrawn|superseded — 7 candidates stripped; promote to reference product]',
    `amendment_type` STRING COMMENT 'Classification of the amendment based on the nature of the budget change. Indicates whether the amendment is due to scope changes, contingency usage, emergency needs, cost overruns, schedule adjustments, or funding reallocations.. Valid values are `scope_change|contingency_draw|emergency_authorization|cost_overrun|schedule_adjustment|funding_reallocation`',
    `approval_authority` STRING COMMENT 'The governance level or role authorized to approve this amendment. Indicates whether board/commission approval was required or if the amendment was within delegated authority thresholds.. Valid values are `board|commission|executive_director|finance_director|project_manager|delegated_authority`',
    `approval_date` DATE COMMENT 'The date on which the budget amendment received final approval from the designated authority. Establishes the effective date for the revised budget.',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'The dollar threshold that determines the required approval authority level for this amendment. Amendments exceeding this threshold require higher-level governance approval.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or governance body that granted final approval for the amendment. Documents authorization in the approval workflow.',
    `audit_trail_notes` STRING COMMENT 'Free-text field for capturing additional audit and compliance notes related to the amendment. Supports regulatory reporting and internal controls documentation.',
    `board_resolution_number` STRING COMMENT 'Official resolution or ordinance number issued by the governing board or commission authorizing the amendment. Required for amendments exceeding delegated authority thresholds.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `contingency_amount_used` DECIMAL(18,2) COMMENT 'The dollar amount of project contingency reserve consumed by this amendment. Tracks depletion of risk mitigation funds.',
    `contingency_impact_flag` BOOLEAN COMMENT 'Indicates whether this amendment draws from or affects the project contingency reserve. True if contingency funds are utilized; false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget amendment record was first created in the system. Provides audit trail for record inception.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this amendment record. Typically USD for U.S. water utilities.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date from which the amended budget is in force and governs project financial management. May differ from approval date based on governance rules.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget amendment record was most recently updated. Tracks the latest change to the record for audit and data quality purposes.',
    `meeting_date` DATE COMMENT 'The date of the board or commission meeting at which the amendment was presented and approved. Provides governance audit trail.',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'The project budget amount prior to this amendment. Provides baseline for calculating the revised budget and tracking cumulative changes.',
    `reason_code` STRING COMMENT 'Standardized code indicating the specific reason for the budget amendment. Used for categorization, reporting, and trend analysis of budget modifications.. Valid values are `^[A-Z0-9_]{2,15}$`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the business justification and circumstances necessitating the budget amendment. Provides context for audit and governance review.',
    `remaining_contingency` DECIMAL(18,2) COMMENT 'The balance of contingency funds available after this amendment. Provides visibility into remaining risk buffer for the project.',
    `request_date` DATE COMMENT 'The date on which the budget amendment was formally requested. Marks the initiation of the amendment approval workflow.',
    `requested_by` STRING COMMENT 'Name or identifier of the individual or role who initiated the budget amendment request. Provides accountability and audit trail.',
    `revised_budget_amount` DECIMAL(18,2) COMMENT 'The resulting total project budget after applying this amendment. Calculated as original budget plus amendment amount.',
    `schedule_impact_days` STRING COMMENT 'The number of calendar days by which the project schedule is extended or compressed as a result of this amendment. Positive values indicate delays; negative values indicate acceleration.',
    `scope_change_description` STRING COMMENT 'Detailed description of any project scope modifications associated with this budget amendment. Documents changes to deliverables, specifications, or project boundaries.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or URI to supporting documentation for the amendment, such as cost estimates, change orders, engineering reports, or board memos.',
    CONSTRAINT pk_budget_amendment PRIMARY KEY(`budget_amendment_id`)
) COMMENT 'Formal record of an approved change to a project budget appropriation including amendment number, reason code (scope change, contingency draw, emergency authorization), amount delta (increase or decrease), approval authority, approval date, and resulting revised budget total. Maintains a complete audit trail of all budget modifications from original appropriation through project closeout. Supports board/commission approval workflows for amendments exceeding threshold amounts.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`project`.`design_contract` (
    `design_contract_id` BIGINT COMMENT 'Unique identifier for the engineering and design services contract record. Primary key for the design contract entity.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent CIP project for which this design contract was executed. Links the design services agreement to the infrastructure project it supports.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Design contracts charge to cost centers for project overhead allocation and departmental budget tracking. Required for indirect cost recovery.',
    `vendor_id` BIGINT COMMENT 'Reference to the professional engineering firm or consultant providing design services under this contract. Links to the vendor or party master record.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Design contracts are funded from specific utility funds and require fund commitment tracking for multi-year appropriation control. Essential for fund accounting.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Design contracts are scoped to specific service offerings (potable water, recycled water, wastewater). The offering type drives design standards, regulatory requirements, and deliverables. Water utili',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Design contracts for pipe rehabilitation or replacement reference the specific pipe main being designed. Engineers and project managers need this link to track which design contract produced the desig',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Design contracts for pressure zone improvements (PRV stations, pump stations, storage tanks) must reference the specific pressure zone being served for hydraulic modeling, design criteria selection, a',
    `primary_design_vendor_id` BIGINT COMMENT 'Reference to the professional engineering firm or consultant providing design services under this contract. Links to the vendor or party master record.',
    `pump_station_id` BIGINT COMMENT 'Foreign key linking to distribution.pump_station. Business justification: Design contracts for pump station upgrades or new construction reference the specific pump station being designed. Project managers need this link to track which engineering firm designed a specific p',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Design contracts must incorporate specific regulatory standards (Ten States Standards, EPA design criteria, state-specific requirements). Engineers reference requirements during design review and subm',
    `storage_tank_id` BIGINT COMMENT 'Foreign key linking to distribution.storage_tank. Business justification: Design contracts for tank rehabilitation or new construction reference the specific storage tank being designed. Project managers need this link to track which engineering firm designed a specific tan',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Design contracts specify the service territory for regulatory compliance (jurisdiction-specific design standards, permit requirements) and cost allocation. Engineering firms need territory context for',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Design contracts in CIP projects are scoped to specific WBS elements (e.g., the design contract covers the Preliminary Engineering or Final Design WBS element). Adding wbs_element_id to design_con',
    `actual_completion_date` DATE COMMENT 'Actual date on which all design services were completed and final deliverables were accepted by the utility. Used to measure schedule performance.',
    `amendment_value` DECIMAL(18,2) COMMENT 'Cumulative value in US dollars of all executed contract amendments and change orders. Positive values represent scope additions; negative values represent reductions. Sum of all amendment amounts applied to the original contract value.',
    `construction_administration_included` BOOLEAN COMMENT 'Boolean flag indicating whether the design contract includes construction administration (CA) services during the build phase. CA services typically include shop drawing review, site visits, request for information (RFI) responses, and substantial completion certification.',
    `contract_duration_days` STRING COMMENT 'Total number of calendar days allocated for completion of design services, from notice to proceed to scheduled completion. Baseline duration established at contract execution.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the design services contract. Used in procurement documents, invoices, and regulatory filings.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the design services contract. Draft contracts are being prepared; pending approval awaits authorization; executed contracts are signed but work has not started; active contracts have ongoing work; suspended contracts are temporarily paused; completed contracts have delivered all services; closed contracts are administratively finalized; terminated contracts were ended early. [ENUM-REF-CANDIDATE: draft|pending_approval|executed|active|suspended|completed|closed|terminated — 8 candidates stripped; promote to reference product]',
    `contract_title` STRING COMMENT 'Descriptive title of the design services contract, typically including the project name and scope summary (e.g., Preliminary Engineering Report and Design for Main Street Water Treatment Plant (WTP) Expansion).',
    `contract_type` STRING COMMENT 'Classification of the professional services contract pricing structure. Lump sum contracts have a fixed price for defined deliverables; time and materials (T&M) contracts bill actual hours and expenses; cost-plus contracts reimburse costs plus a fee or percentage; unit price contracts pay per defined unit of work; indefinite delivery contracts establish rates for on-call services.. Valid values are `lump_sum|time_and_materials|cost_plus_fixed_fee|cost_plus_percentage|unit_price|indefinite_delivery`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this design contract record was first created in the system. Used for audit trail and data lineage tracking.',
    `current_contract_value` DECIMAL(18,2) COMMENT 'Current total contract value in US dollars, calculated as original contract value plus all executed amendments. Represents the current authorized budget for design services.',
    `deliverable_schedule` STRING COMMENT 'Structured schedule of key design deliverables and their due dates. Typically includes milestones such as preliminary engineering report (PER) submission, 30% design review, 60% design review, 90% design review, final construction documents, and permit applications.',
    `design_phase` STRING COMMENT 'Current or primary phase of design services covered by this contract. Preliminary engineering includes feasibility studies and PER; conceptual and schematic design establish project approach; detailed design produces technical specifications; construction documents are bid-ready plans; bidding support assists procurement; construction administration provides oversight during build. [ENUM-REF-CANDIDATE: preliminary_engineering|conceptual_design|schematic_design|detailed_design|construction_documents|bidding_support|construction_administration — 7 candidates stripped; promote to reference product]',
    `design_standard_reference` STRING COMMENT 'Reference to the primary design standards and codes governing the engineering work. Typically includes AWWA standards, Ten States Standards (for water and wastewater), state-specific design manuals, and local utility design criteria.',
    `disadvantaged_business_enterprise_participation` DECIMAL(18,2) COMMENT 'Percentage of contract value committed to disadvantaged business enterprise (DBE) or minority/women-owned business enterprise (M/WBE) participation. Required for federally-funded projects to meet EPA and USDA diversity goals.',
    `engineering_firm_name` STRING COMMENT 'Legal name of the engineering firm or consultant providing design services. Captured for reporting and audit purposes.',
    `environmental_review_status` STRING COMMENT 'Status of environmental review and compliance documentation required for the project. May include National Environmental Policy Act (NEPA) review, State Environmental Quality Review Act (SEQRA), or equivalent state-level environmental assessment.. Valid values are `not_required|pending|in_progress|completed|approved`',
    `execution_date` DATE COMMENT 'Date on which the design services contract was fully executed (signed by all parties). Establishes the legal effective date of the agreement.',
    `grant_number` STRING COMMENT 'Identifier for any federal or state grant funding supporting this design contract. Used for compliance tracking and reporting to funding agencies such as EPA, USDA, or state environmental agencies.',
    `insurance_certificate_received` BOOLEAN COMMENT 'Boolean flag indicating whether the engineering firm has provided required professional liability insurance and general liability insurance certificates. Required before notice to proceed can be issued.',
    `insurance_expiration_date` DATE COMMENT 'Expiration date of the engineering firms professional liability insurance policy. Monitored to ensure continuous coverage throughout the contract period.',
    `invoiced_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount in US dollars invoiced by the engineering firm to date. Used to track contract spend and remaining budget.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this design contract record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional notes, comments, or special conditions related to the design contract. May include lessons learned, performance observations, or administrative notes.',
    `notice_to_proceed_date` DATE COMMENT 'Date on which the utility issued formal notice to proceed (NTP) authorizing the engineering firm to begin design work. Triggers contract performance period and milestone schedule.',
    `original_contract_value` DECIMAL(18,2) COMMENT 'Initial total contract value in US dollars as executed at contract award, before any amendments or change orders. Represents the baseline budget for design services.',
    `paid_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount in US dollars paid to the engineering firm to date. May differ from invoiced amount due to payment processing lag or retainage.',
    `performance_bond_required` BOOLEAN COMMENT 'Boolean flag indicating whether a performance bond is required for this design services contract. Typically not required for professional services but may be mandated for high-value or high-risk projects.',
    `permit_support_included` BOOLEAN COMMENT 'Boolean flag indicating whether the design contract includes services for preparing and submitting regulatory permit applications. Common permits include NPDES discharge permits, Safe Drinking Water Act (SDWA) construction permits, wetland permits, and local building permits.',
    `procurement_method` STRING COMMENT 'Method used to select and award the design services contract. Qualifications-based selection (QBS) is the standard for professional engineering services per Brooks Act; competitive sealed proposals may be used for design-build; sole source for unique expertise; emergency for urgent needs; cooperative purchasing leverages existing contracts.. Valid values are `qualifications_based_selection|competitive_sealed_proposals|sole_source|emergency_procurement|cooperative_purchasing`',
    `quality_assurance_review_required` BOOLEAN COMMENT 'Boolean flag indicating whether an independent quality assurance (QA) or quality control (QC) review of design documents is required. Often mandated for large or complex projects, or when using federal funding.',
    `retainage_amount` DECIMAL(18,2) COMMENT 'Amount in US dollars withheld from payments as retainage to ensure contract performance and deliverable quality. Typically released upon final acceptance of design documents.',
    `retainage_percentage` DECIMAL(18,2) COMMENT 'Percentage of each invoice withheld as retainage. Common values are 5% or 10% for professional services contracts.',
    `scheduled_completion_date` DATE COMMENT 'Contractually scheduled date for completion of all design services and delivery of final deliverables. Baseline date established at contract execution.',
    `scope_of_services` STRING COMMENT 'Detailed description of the engineering and design services to be provided under this contract. Typically includes phases such as preliminary engineering report (PER), conceptual design, detailed design, construction documents, permitting support, bidding assistance, and construction administration.',
    `subconsultant_list` STRING COMMENT 'List of subconsultants and specialty firms engaged by the prime engineering firm to support design services. May include geotechnical engineers, environmental consultants, surveying firms, and other specialists.',
    CONSTRAINT pk_design_contract PRIMARY KEY(`design_contract_id`)
) COMMENT 'Engineering and design services contract record for a CIP project covering professional services agreements with engineering firms for preliminary engineering reports (PER), design development, construction documents, and construction administration. Tracks contract number, engineering firm, contract type (lump sum, T&M, cost-plus), original contract value, executed amendments, current contract value, scope of services, deliverable schedule, and NTP/completion dates. Distinct from construction contracts — design contracts follow a professional services procurement workflow.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`project`.`construction_contract` (
    `construction_contract_id` BIGINT COMMENT 'Unique identifier for the construction contract record. Primary key for the construction contract entity.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent CIP project for which this construction contract was awarded. Links the contract to the broader capital project scope.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Construction contracts must comply with permit conditions (NPDES discharge limits during construction, erosion control, stormwater management). Contract administrators track permit compliance and ensu',
    `vendor_id` BIGINT COMMENT 'Reference to the general contractor or prime contractor awarded this construction contract. Links to the vendor/contractor master record.',
    `construction_vendor_id` BIGINT COMMENT 'Reference to the general contractor or prime contractor awarded this construction contract. Links to the vendor/contractor master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Construction contracts charge to cost centers for project cost allocation and overhead recovery. Essential for full-cost accounting and departmental performance measurement.',
    `dma_id` BIGINT COMMENT 'Foreign key linking to distribution.dma. Business justification: DMA-specific construction (meter installations, valve replacements, main rehabilitation) requires DMA attribution for NRW program tracking, performance measurement, and before/after leakage comparison',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Construction contracts are funded from specific utility funds and require multi-year fund commitment tracking for appropriation control and cash flow planning.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Construction contracts build infrastructure for specific service offerings. Linking to offering enables capital investment reporting by service type (potable, recycled, wastewater) — a standard water ',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: A construction contract for pipe replacement or rehabilitation directly references the specific pipe main being replaced. Contract administrators and project managers need this link for contract scope',
    `pressure_zone_id` BIGINT COMMENT 'Foreign key linking to distribution.pressure_zone. Business justification: Construction contracts for zone-specific infrastructure need pressure zone attribution for operations coordination, isolation planning, SCADA integration, and hydraulic model updates during constructi',
    `pump_station_id` BIGINT COMMENT 'Foreign key linking to distribution.pump_station. Business justification: Construction contracts for pump station construction or major upgrades reference the specific pump station. Contract administrators need this link for scope verification, progress tracking, and post-c',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Construction contracts are executed within specific service territories for permitting, prevailing wage compliance (varies by jurisdiction), and asset handover to the correct operations district. Cont',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Construction contracts in CIP projects are associated with specific WBS elements representing the construction work package. Adding wbs_element_id to construction_contract enables construction cost tr',
    `award_date` DATE COMMENT 'Date the construction contract was officially awarded to the contractor by the utilitys governing authority (board, commission, or management).',
    `awarded_contract_value` DECIMAL(18,2) COMMENT 'Contract value at the time of award, after any bid negotiations or adjustments. This is the baseline contract amount before any change orders.',
    `bid_advertisement_date` DATE COMMENT 'Date the construction contract opportunity was publicly advertised for competitive bidding. Marks the start of the procurement process.',
    `bid_amount` DECIMAL(18,2) COMMENT 'Original bid amount submitted by the contractor during the competitive bidding process, before any negotiations or adjustments. Represents the contractors initial price proposal.',
    `bid_opening_date` DATE COMMENT 'Date when sealed bids were publicly opened and read. Establishes the official bid prices for evaluation.',
    `change_order_count` STRING COMMENT 'Total number of change orders issued against this construction contract. Indicates scope volatility and contract management complexity.',
    `contract_description` STRING COMMENT 'Detailed description of the construction scope of work, including infrastructure type (water main, wastewater treatment, pump station), work type (new construction, rehabilitation, replacement), and key deliverables.',
    `contract_duration_days` STRING COMMENT 'Original contract duration in calendar days from NTP to substantial completion. Used to calculate original completion date and assess schedule performance.',
    `contract_name` STRING COMMENT 'Descriptive name of the construction contract, typically reflecting the scope of work (e.g., Main Street Water Main Replacement, WWTP Clarifier Rehabilitation).',
    `contract_number` STRING COMMENT 'Externally-known unique contract identifier assigned by the utility for procurement tracking and reference. Used in all contract documentation, invoices, and correspondence.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the construction contract. Tracks progression from bid advertisement through contract closeout and final payment. [ENUM-REF-CANDIDATE: draft|advertised|bid_received|awarded|executed|active|substantially_complete|final_complete|closed — 9 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Type of construction contract pricing structure. Lump sum = fixed price for entire scope; unit price = payment per measured unit of work; GMP = guaranteed maximum price with cost sharing; cost plus = reimbursable costs plus fee; time and materials = hourly labor plus materials.. Valid values are `lump_sum|unit_price|cost_plus_fixed_fee|cost_plus_percentage|gmp|time_and_materials`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this construction contract record was first created in the system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this contract. Typically USD for U.S. water utilities.. Valid values are `USD|CAD|EUR|GBP|AUD`',
    `current_completion_date` DATE COMMENT 'Current contractual deadline for substantial completion, adjusted for any approved time extensions due to change orders, weather delays, or other contract modifications.',
    `current_contract_value` DECIMAL(18,2) COMMENT 'Current total contract value including all approved change orders and amendments. Represents the up-to-date financial commitment for the construction work.',
    `execution_date` DATE COMMENT 'Date the construction contract was fully executed (signed by both parties). Establishes the legally binding agreement.',
    `final_completion_date` DATE COMMENT 'Actual date all contract work including punch list items was completed and accepted by the utility. Triggers final payment and contract closeout.',
    `insurance_certificate_received` BOOLEAN COMMENT 'Indicates whether the contractor has provided proof of required insurance coverage (general liability, workers compensation, auto liability) per contract requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this construction contract record was last updated. Tracks most recent change for audit and synchronization purposes.',
    `liquidated_damages_assessed` DECIMAL(18,2) COMMENT 'Total dollar amount of liquidated damages assessed against the contractor for late completion. Calculated as days late multiplied by daily rate.',
    `liquidated_damages_rate` DECIMAL(18,2) COMMENT 'Daily dollar amount of liquidated damages assessed for each calendar day the contractor fails to achieve substantial completion by the contract deadline. Pre-agreed damages for delay, not a penalty.',
    `ntp_date` DATE COMMENT 'Date the utility issued the Notice to Proceed authorizing the contractor to begin construction work. Starts the contract time clock for completion deadlines.',
    `original_completion_date` DATE COMMENT 'Original contractual deadline for substantial completion of the work, calculated from NTP date plus contract duration. Baseline for schedule performance tracking.',
    `payment_bond_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the payment bond, typically 100% of the contract value. Ensures subcontractors and material suppliers are paid.',
    `payment_bond_required` BOOLEAN COMMENT 'Indicates whether a payment bond (labor and material bond) is required to protect subcontractors and suppliers from non-payment by the general contractor.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Current percentage of contract work completed based on earned value or physical progress assessment. Used for progress reporting and payment calculations.',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the performance bond, typically 100% of the contract value. Provides financial protection if contractor fails to complete the work.',
    `performance_bond_required` BOOLEAN COMMENT 'Indicates whether a performance bond is required from the contractor to guarantee completion of the work per contract terms. Typically required for contracts above a threshold amount.',
    `retainage_amount` DECIMAL(18,2) COMMENT 'Total dollar amount currently held in retainage. Calculated as cumulative payments multiplied by retainage percentage, less any retainage released.',
    `retainage_percentage` DECIMAL(18,2) COMMENT 'Percentage of each progress payment withheld by the utility until substantial or final completion to ensure contractor performance and warranty obligations. Typical range 5-10%.',
    `substantial_completion_date` DATE COMMENT 'Actual date the work reached substantial completion, meaning the facility can be used for its intended purpose despite minor punch list items remaining. Triggers warranty period start and retainage release milestones.',
    `time_extensions_days` STRING COMMENT 'Total number of calendar days of approved time extensions granted through change orders or contract modifications. Adjusts the completion deadline.',
    `total_change_order_amount` DECIMAL(18,2) COMMENT 'Cumulative dollar value of all approved change orders (positive and negative). Represents the net change from awarded contract value to current contract value.',
    `total_paid_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount paid to the contractor through all progress payments and partial payments, excluding retainage. Used to track payment status and remaining contract balance.',
    `warranty_expiration_date` DATE COMMENT 'Date the contractors warranty period expires. Calculated as substantial completion date plus warranty period months. After this date, the utility assumes full maintenance responsibility.',
    `warranty_period_months` STRING COMMENT 'Duration in months of the contractors warranty period for workmanship and materials, starting from substantial completion date. Typical range 12-24 months for water utility construction.',
    CONSTRAINT pk_construction_contract PRIMARY KEY(`construction_contract_id`)
) COMMENT 'Construction contract record for a CIP project covering agreements with general contractors and specialty subcontractors for infrastructure construction, rehabilitation, or renewal work. Tracks contract number, contractor, contract type (lump sum, unit price, GMP), bid amount, awarded contract value, current contract value (including change orders), retainage percentage, bonding and insurance requirements, NTP date, substantial completion date, final completion date, and liquidated damages provisions. Manages the full construction procurement lifecycle from bid advertisement through final payment.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`project`.`change_order` (
    `change_order_id` BIGINT COMMENT 'Unique identifier for the change order record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Reference to the contractor or vendor responsible for executing the work described in the change order.',
    `change_vendor_id` BIGINT COMMENT 'Reference to the contractor or vendor responsible for executing the work described in the change order.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent CIP project under which this change order is issued.',
    `construction_contract_id` BIGINT COMMENT 'Reference to the originating construction or design contract to which this change order applies.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Change orders affect cost center budgets and require cost center manager approval for budget reallocation. Essential for departmental budget control.',
    `design_contract_id` BIGINT COMMENT 'Foreign key linking to project.design_contract. Business justification: The change_order description explicitly states it documents approved modifications to a construction or design contract. The change_order already has construction_contract_id for construction contra',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Change orders impact fund budgets and require fund availability verification before approval. Critical for fund balance management and appropriation control.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Change orders adjust GL account budgets and require GL coding for proper capitalization vs. expense classification. Required for accurate financial reporting.',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Change orders in water utility construction are frequently triggered by new or modified permit conditions discovered during construction (e.g., additional treatment requirements). change_order has reg',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Change orders driven by regulatory requirements (e.g., new EPA rule requiring additional treatment capability mid-construction) need structured linkage to the regulatory_requirement. change_order.regu',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Change orders in CIP construction affect specific WBS elements — the cost and schedule impact of a change order must be allocated to the appropriate WBS element for cost control and earned value manag',
    `work_order_id` BIGINT COMMENT 'Reference to the associated work order or field service ticket in the CMMS that tracks the physical execution of the change order scope, if applicable.',
    `approval_authority` STRING COMMENT 'Name, title, or role of the individual or governing body authorized to approve this change order (e.g., Director of Engineering, Board of Commissioners, City Council) based on approval thresholds and delegation of authority.',
    `approval_date` DATE COMMENT 'Date on which the change order was formally approved by the designated approval authority, authorizing execution of the modified scope.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the change order record, such as revised drawings, cost estimates, technical specifications, or approval memos.',
    `change_order_description` STRING COMMENT 'Detailed narrative description of the scope change, including work to be added, deleted, or substituted, technical specifications, and justification for the modification.',
    `change_order_number` STRING COMMENT 'Business-assigned unique identifier for the change order, typically sequential within a contract (e.g., CO-001, CO-002).',
    `change_order_status` STRING COMMENT 'Current lifecycle status of the change order: draft (being prepared), submitted (sent for review), under review (being evaluated by stakeholders), approved (authorized for execution), rejected (denied), executed (work completed and invoiced), or closed (final reconciliation complete). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|executed|closed — 7 candidates stripped; promote to reference product]',
    `change_order_type` STRING COMMENT 'Classification of the change order by originating cause: owner-directed modifications, differing site conditions discovered during construction, design errors or omissions, unforeseen subsurface or environmental conditions, scope additions or deletions, time extensions without cost impact, value engineering proposals, or force majeure events. [ENUM-REF-CANDIDATE: owner_directed|differing_site_conditions|design_error|unforeseen_conditions|scope_change|time_extension|value_engineering|force_majeure — 8 candidates stripped; promote to reference product]',
    `cost_impact_amount` DECIMAL(18,2) COMMENT 'Net financial impact of the change order on the contract value. Positive values represent cost additions; negative values represent cost deductions or credits to the owner.',
    `cost_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost impact amount. Typically USD for U.S. water utilities.. Valid values are `USD`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the change order record was first created in the system.',
    `cumulative_change_order_value` DECIMAL(18,2) COMMENT 'Running total of all approved change order cost impacts for this contract through the current change order, used to track total contract growth or reduction.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the change order has environmental implications requiring additional permitting, mitigation, or compliance documentation. True if environmental impact exists; False otherwise.',
    `execution_date` DATE COMMENT 'Date on which the change order was fully executed by all parties (owner and contractor signatures obtained) and became a binding contract amendment.',
    `initiated_by` STRING COMMENT 'Name or identifier of the individual or role who originated the change order request (e.g., project manager, contractor, design engineer, regulatory inspector).',
    `initiated_date` DATE COMMENT 'Date on which the change order request was formally initiated or drafted.',
    `justification` STRING COMMENT 'Business and technical rationale for the change order, including regulatory requirements, operational needs, safety considerations, or cost-benefit analysis supporting the modification.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified the change order record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the change order record was last updated or modified in the system.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, clarifications, or internal coordination notes related to the change order processing and execution.',
    `original_contract_value` DECIMAL(18,2) COMMENT 'The baseline contract value at the time of original award, before any change orders. Used to calculate cumulative change order percentage for cost control reporting.',
    `priority` STRING COMMENT 'Business priority level assigned to the change order based on urgency, regulatory compliance requirements, safety impact, or operational criticality.. Valid values are `critical|high|medium|low`',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether the change order is driven by a regulatory compliance requirement (e.g., EPA mandate, state permit condition, SDWA or CWA obligation). True if regulatory-driven; False otherwise.',
    `rejection_date` DATE COMMENT 'Date on which the change order was formally rejected or denied by the approval authority, if applicable.',
    `rejection_reason` STRING COMMENT 'Explanation or rationale provided for the rejection of the change order, including budgetary constraints, scope misalignment, or technical concerns.',
    `revised_completion_date` DATE COMMENT 'Updated contract substantial completion date after applying the schedule impact of this change order.',
    `safety_impact_flag` BOOLEAN COMMENT 'Indicates whether the change order addresses a safety hazard or improves worker or public safety conditions. True if safety-related; False otherwise.',
    `schedule_impact_days` STRING COMMENT 'Number of calendar days added to or subtracted from the contract completion date as a result of this change order. Positive values extend the schedule; negative values accelerate it.',
    `scope_addition_flag` BOOLEAN COMMENT 'Indicates whether the change order adds new work scope to the contract. True if scope is added; False if scope is deleted or substituted.',
    `scope_deletion_flag` BOOLEAN COMMENT 'Indicates whether the change order removes or deletes work scope from the contract. True if scope is deleted; False otherwise.',
    `submitted_date` DATE COMMENT 'Date on which the change order was formally submitted to the owner or approval authority for review.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the nature of the change order for quick identification and reporting.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created the change order record.',
    CONSTRAINT pk_change_order PRIMARY KEY(`change_order_id`)
) COMMENT 'Formal change order record documenting approved modifications to a construction or design contract including scope additions, deletions, or substitutions, time extensions, and associated cost adjustments. Tracks change order number, originating contract, change order type (owner-directed, differing site conditions, design error, unforeseen conditions), description of change, cost impact (add/deduct), schedule impact (days), approval status, approval authority, and execution date. Maintains running total of all change orders against original contract value for cost control reporting.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`project`.`pay_application` (
    `pay_application_id` BIGINT COMMENT 'Unique identifier for the contractor payment application record. Primary key.',
    `cip_project_id` BIGINT COMMENT 'Reference to the capital improvement program (CIP) project for which work is being billed.',
    `construction_contract_id` BIGINT COMMENT 'Reference to the construction contract under which this payment application is submitted.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Contractor payments charge to cost centers for project cost allocation and overhead recovery. Required for full-cost accounting and departmental budget tracking.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Contractor payment applications draw from specific funds and require fund balance verification before payment authorization. Essential for cash flow management and fund accounting.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Contractor payments post to GL accounts for cash flow management, financial reporting, and construction-in-progress tracking. Required for accurate financial statements.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Water utility CIP project accounting requires linking contractor pay applications to the corresponding AP/owner invoice record for payment processing and GL reconciliation. Finance teams track which b',
    `vendor_id` BIGINT COMMENT 'Reference to the contractor or vendor submitting the payment application.',
    `pay_vendor_id` BIGINT COMMENT 'Reference to the contractor or vendor submitting the payment application.',
    `vendor_invoice_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_invoice. Business justification: Approved contractor pay applications generate vendor invoices in the AP system for payment processing. Linking pay_application to vendor_invoice enables reconciliation between engineer-certified payme',
    `application_number` STRING COMMENT 'Sequential payment application number assigned by the contractor for this billing period (e.g., Pay App #5).',
    `application_status` STRING COMMENT 'Current workflow status of the payment application in the approval and payment process. [ENUM-REF-CANDIDATE: draft|submitted|under_review|certified|approved|rejected|paid|void — 8 candidates stripped; promote to reference product]',
    `balance_to_finish_amount` DECIMAL(18,2) COMMENT 'Remaining contract value yet to be earned, calculated as current contract amount minus total earned to date.',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period covered by this payment application.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period covered by this payment application.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment application record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payment application (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `current_contract_amount` DECIMAL(18,2) COMMENT 'Current total contract sum including original contract amount plus approved change orders.',
    `current_payment_due_amount` DECIMAL(18,2) COMMENT 'Net amount due to the contractor for this payment application, calculated as total earned less retainage minus previous payments.',
    `engineer_certification_date` DATE COMMENT 'Date the engineer or architect certified the payment application as accurate and compliant with contract requirements.',
    `engineer_certified_amount` DECIMAL(18,2) COMMENT 'Amount certified by the engineer or architect for payment, which may differ from the contractor-requested amount if adjustments are made.',
    `materials_stored_amount` DECIMAL(18,2) COMMENT 'Value of materials and equipment suitably stored on-site or off-site but not yet incorporated into the work.',
    `notes` STRING COMMENT 'Additional comments, clarifications, or special instructions related to this payment application.',
    `original_contract_amount` DECIMAL(18,2) COMMENT 'The original total contract sum before any approved change orders.',
    `owner_approval_date` DATE COMMENT 'Date the owner or authorized representative approved the payment application for disbursement.',
    `owner_approved_amount` DECIMAL(18,2) COMMENT 'Final amount approved by the owner for payment, which may differ from engineer-certified amount due to owner adjustments or disputes.',
    `payment_date` DATE COMMENT 'Date the payment was actually disbursed to the contractor through accounts payable.',
    `payment_reference_number` STRING COMMENT 'Check number, wire transfer reference, or electronic payment confirmation number for the disbursed payment.',
    `percent_complete` DECIMAL(18,2) COMMENT 'Percentage of the total contract work completed as of this billing period, calculated as total earned to date divided by current contract amount.',
    `previous_payments_amount` DECIMAL(18,2) COMMENT 'Sum of all payments previously made to the contractor on this contract through prior payment applications.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the engineer or owner if the payment application was rejected or returned for correction.',
    `retainage_amount` DECIMAL(18,2) COMMENT 'Dollar amount of retainage withheld from the total earned to date based on the retainage percentage.',
    `retainage_percentage` DECIMAL(18,2) COMMENT 'Percentage of earned amount withheld by the owner as retainage to ensure contract completion and quality (typically 5-10%).',
    `submission_date` DATE COMMENT 'Date the contractor submitted the payment application to the owner or engineer for review.',
    `total_earned_less_retainage_amount` DECIMAL(18,2) COMMENT 'Total earned to date minus retainage withheld, representing the gross amount eligible for payment.',
    `total_earned_to_date_amount` DECIMAL(18,2) COMMENT 'Sum of work completed to date and materials stored, representing total amount earned by the contractor through this billing period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payment application record was last modified.',
    `work_completed_to_date_amount` DECIMAL(18,2) COMMENT 'Total value of work completed and in place as of the end of this billing period, based on the schedule of values (AIA G703).',
    CONSTRAINT pk_pay_application PRIMARY KEY(`pay_application_id`)
) COMMENT 'Contractor payment application (pay app) record submitted for work completed during a billing period on a construction contract. Tracks application number, contract reference, billing period, scheduled value by cost item, work completed to date, materials stored on-site, total earned to date, retainage withheld, previous payments, and net amount due. Supports the AIA G702/G703 schedule of values workflow including engineer certification, owner approval, and payment processing. Integrates with SAP FI accounts payable for payment disbursement.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`project`.`cost_transaction` (
    `cost_transaction_id` BIGINT COMMENT 'Unique identifier for the project cost transaction record. Primary key.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Project cost transactions are sourced from AP invoices in water utilities ERP systems. The plain-text invoice_number on cost_transaction is a denormalization of the AP invoice. Linking enables direc',
    `change_order_id` BIGINT COMMENT 'Foreign key linking to project.change_order. Business justification: cost_transaction has a denormalized STRING column change_order_number that should be replaced with a proper FK to change_order. Cost transactions resulting from approved change orders must be tracea',
    `cip_project_id` BIGINT COMMENT 'Reference to the CIP project or WBS element against which this cost transaction is posted. Links to the parent capital project for infrastructure expansion, rehabilitation, or renewal.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Project costs allocate to cost centers for indirect cost recovery, overhead distribution, and departmental performance tracking. Essential for full-cost pricing and rate-making.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Capital cost transactions are posted against treatment facilities for asset capitalization and facility-level financial reporting. Utility rate cases and regulatory filings require capital expenditure',
    `fund_id` BIGINT COMMENT 'Foreign key linking to finance.fund. Business justification: Project costs must be charged to specific funds for regulatory reporting, rate base calculations, and fund financial statements. Required for GASB 34 compliance.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Project costs post to GL accounts for financial statement preparation, audit trails, and asset capitalization decisions. Required for proper GAAP/GASB accounting.',
    `original_transaction_cost_transaction_id` BIGINT COMMENT 'Reference to the original project cost transaction ID that this reversal transaction is correcting. Null for original postings; populated only for reversal entries.',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to treatment.process_unit. Business justification: Capital cost transactions settle to specific process unit assets during project closeout (SAP asset capitalization). This enables accurate fixed asset register creation, unit-level depreciation, and a',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Project cost transactions sourced from purchase orders must reference the originating PO for cost commitment tracking, three-way match, and CIP capitalization audit trails. The plain-text purchase_or',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier who provided the materials, equipment, or services for this cost transaction. Null for internal labor charges.',
    `vendor_invoice_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_invoice. Business justification: Project cost transactions originating from vendor invoices must reference the source AP invoice for audit trails, three-way match verification, and CIP cost capitalization. Water utilities project acc',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: cost_transaction has a denormalized STRING column wbs_element that should be replaced with a proper FK to wbs_element. Cost transactions in CIP projects are always posted against WBS elements for co',
    `approval_date` DATE COMMENT 'The date on which this cost transaction was approved for posting by the project manager or financial controller. Null for transactions that do not require approval.',
    `asset_class` STRING COMMENT 'The asset class code to which this cost will be capitalized upon project closeout (e.g., water treatment plant, distribution mains, pumping stations). Null for non-capitalizable costs.',
    `capitalization_flag` BOOLEAN COMMENT 'Boolean indicator of whether this cost transaction is eligible for capitalization as a fixed asset upon project completion. True indicates the cost will be capitalized; False indicates it will be expensed.',
    `commitment_item` STRING COMMENT 'Reference to the budget commitment or encumbrance item that this actual cost is drawn against. Enables commitment vs. actual cost tracking for budget control.',
    `cost_element` STRING COMMENT 'The SAP CO cost element code that categorizes the nature of the expense (e.g., direct labor, materials, external services). Maps to the chart of accounts for financial reporting.',
    `cost_transaction_description` STRING COMMENT 'Free-text description of the cost transaction providing additional context about the work performed, materials purchased, or services rendered. Supports audit and cost review processes.',
    `cost_type` STRING COMMENT 'Classification of the cost transaction by type: labor charges, material purchases, equipment rentals, subcontractor invoices, overhead allocations, or other miscellaneous costs.. Valid values are `labor|material|equipment|subcontract|overhead|other`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost transaction record was first created in the lakehouse silver layer. Supports data lineage and audit trail requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount (e.g., USD, CAD, EUR). Supports multi-currency project accounting for international projects or vendors.. Valid values are `^[A-Z]{3}$`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which this cost transaction was posted. Supports monthly cost control and earned value reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this cost transaction was posted. Enables year-over-year cost analysis and budget variance reporting.',
    `invoice_date` DATE COMMENT 'The date on the vendor invoice or billing document. Used for payment terms calculation and aging analysis.',
    `payment_date` DATE COMMENT 'The date on which payment was made to the vendor for this cost transaction. Supports cash flow analysis and vendor payment tracking.',
    `posting_status` STRING COMMENT 'Current status of the cost transaction in the financial system. Posted indicates the transaction is final; Pending indicates it is awaiting approval; Reversed indicates it has been reversed; Rejected indicates it was not accepted.. Valid values are `posted|pending|reversed|rejected`',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of the resource consumed or purchased in this transaction (e.g., labor hours, material units, equipment rental days). Enables unit cost analysis and earned value calculations.',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator of whether this transaction is a reversal or correction of a previously posted cost. True indicates a reversal entry; False indicates an original posting.',
    `source_document_reference` STRING COMMENT 'The unique document identifier in the source system (e.g., SAP document number, Maximo work order ID). Enables traceability back to the originating transaction.',
    `source_system` STRING COMMENT 'The source operational system from which this cost transaction was extracted (e.g., SAP FI/CO, Maximo, Tyler Munis). Supports data lineage and reconciliation.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary value of the cost transaction in the project currency. Represents the actual cost incurred for labor, materials, equipment, or services.',
    `transaction_date` DATE COMMENT 'The date on which the cost transaction was posted to the project ledger. This is the accounting date for financial reporting and cost control purposes.',
    `transaction_number` STRING COMMENT 'The externally-known document number or voucher number from the source financial system (SAP FI/CO) that uniquely identifies this cost posting.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the transaction quantity (e.g., hours, each, linear feet, cubic yards). Standardizes quantity reporting across different cost types.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost transaction record was last updated in the lakehouse silver layer. Tracks the most recent modification for change data capture and audit purposes.',
    `work_order_number` STRING COMMENT 'The work order or maintenance order number that generated this cost transaction. Links project costs to field work execution and asset maintenance activities.',
    CONSTRAINT pk_cost_transaction PRIMARY KEY(`cost_transaction_id`)
) COMMENT 'Individual cost transaction posted against a CIP project or WBS element including labor charges, material purchases, equipment rentals, contractor invoices, and overhead allocations. Tracks transaction date, cost type (labor, material, equipment, subcontract, overhead), vendor or employee reference, purchase order or work order reference, amount, cost center, fund, GL account, and posting period. Provides the granular cost ledger for project cost control, earned value management, budget vs actual reporting, and capitalization at project closeout. Sourced from SAP FI/CO actual cost postings and integrated with pay application approvals.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`project`.`project_permit` (
    `project_permit_id` BIGINT COMMENT 'Unique identifier for the project permit record. Primary key for the project permit entity.',
    `cip_project_id` BIGINT COMMENT 'Reference to the parent CIP project requiring this permit. Links permit to the capital project for which regulatory approval is required.',
    `compliance_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Project-specific construction/discharge permits reference master operational permits held by the utility. Links temporary project permits to permanent facility permits for comprehensive compliance tra',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Project permits are issued for specific service types (e.g., recycled water reuse permits, potable water infrastructure permits). Linking project_permit to offering enables regulatory compliance track',
    `permit_condition_id` BIGINT COMMENT 'Foreign key linking to compliance.permit_condition. Business justification: Project permits (e.g., construction permits, environmental permits) are often required to satisfy specific operating permit conditions. This link enables traceability from the project permit back to t',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Encroachment permits, excavation permits, and right-of-way permits are issued for work on specific pipe mains. Permit managers need to link project permits to the specific pipe main being worked on fo',
    `pump_station_id` BIGINT COMMENT 'Foreign key linking to distribution.pump_station. Business justification: Building permits, environmental permits, and operating permits are issued for pump station construction or upgrades and reference the specific pump station. Permit managers need this link for regulato',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Project permits are obtained to satisfy specific regulatory requirements (Safe Drinking Water Act, Clean Water Act). Direct FK from project_permit to regulatory_requirement enables regulatory traceabi',
    `sampling_point_id` BIGINT COMMENT 'Foreign key linking to quality.sampling_point. Business justification: Regulatory permits for new water infrastructure often specify required sampling point locations and monitoring frequencies. Permit compliance tracking requires linking permit conditions to established',
    `storage_tank_id` BIGINT COMMENT 'Foreign key linking to distribution.storage_tank. Business justification: Building permits, environmental permits, and operating permits for tank construction or rehabilitation reference the specific storage tank. Permit managers need this link for regulatory compliance tra',
    `territory_id` BIGINT COMMENT 'Foreign key linking to service.service_territory. Business justification: Permits are issued by regulatory agencies with jurisdiction over specific service territories. Compliance tracking, renewal management, and regulatory reporting require linking permits to the territor',
    `amendment_count` STRING COMMENT 'Number of amendments or modifications made to the original permit. Tracks permit change history and complexity.',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Recurring annual fee required to maintain the permit. Common for environmental permits such as NPDES. Recorded in US dollars. Null if no annual fee applies.',
    `appeal_filed` BOOLEAN COMMENT 'Indicates whether an administrative appeal or legal challenge was filed against the permit decision. Appeals can delay permit effectiveness and project schedules.',
    `appeal_status` STRING COMMENT 'Current status of any administrative appeal or legal challenge. Null if no appeal was filed.. Valid values are `pending|upheld|overturned|withdrawn|settled`',
    `application_date` DATE COMMENT 'Date the permit application was submitted to the issuing agency. Critical for tracking permit processing timelines and schedule impacts.',
    `application_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the issuing agency for processing the permit application. Recorded in US dollars.',
    `application_submitted_by` STRING COMMENT 'Name of the individual or organization that submitted the permit application on behalf of the utility. May be internal staff, consultant, or contractor.',
    `bond_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the required performance or surety bond. Null if no bond is required. Recorded in US dollars.',
    `bond_required` BOOLEAN COMMENT 'Indicates whether a performance or surety bond is required as a condition of the permit. Common for construction and right-of-way permits.',
    `compliance_requirements` STRING COMMENT 'Specific compliance obligations the permit holder must meet, including monitoring, reporting, record-keeping, and operational requirements. Distinct from permit conditions in that these are ongoing obligations during permit validity.',
    `conditions` STRING COMMENT 'Detailed text of conditions, restrictions, and requirements imposed by the issuing agency as part of the permit. May include construction methods, environmental protections, monitoring requirements, reporting obligations, and mitigation measures.',
    `contact_email` STRING COMMENT 'Email address of the primary permit contact. Organizational contact data classified as confidential business information.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary contact person for permit-related communications and coordination. May be project manager, environmental compliance officer, or consultant.',
    `contact_phone` STRING COMMENT 'Phone number of the primary permit contact. Organizational contact data classified as confidential business information.',
    `coverage_area_description` STRING COMMENT 'Textual description of the geographic area or project site covered by the permit. May include street addresses, parcel numbers, legal descriptions, or geographic coordinates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was first created in the system. Audit trail for data lineage and record lifecycle tracking.',
    `effective_date` DATE COMMENT 'Date the permit becomes legally effective and work may commence. May differ from issued date if there is a waiting period or appeal window.',
    `environmental_impact_category` STRING COMMENT 'Classification of the environmental impact level associated with the permitted activity. Determines level of environmental review and mitigation requirements.. Valid values are `none|minimal|moderate|significant`',
    `expiration_date` DATE COMMENT 'Date the permit expires and is no longer valid. Critical for tracking permit renewals and ensuring continuous compliance. Null for permits with no expiration.',
    `insurance_required` BOOLEAN COMMENT 'Indicates whether proof of insurance coverage is required as a condition of the permit. Common for construction permits requiring general liability and workers compensation coverage.',
    `issued_date` DATE COMMENT 'Date the permit was officially issued by the regulatory agency. Marks the start of permit validity and authorization to proceed with permitted activities.',
    `issuing_agency_jurisdiction` STRING COMMENT 'Level of government jurisdiction for the issuing agency. Determines regulatory authority and appeal processes.. Valid values are `federal|state|county|municipal|regional`',
    `issuing_agency_name` STRING COMMENT 'Name of the regulatory or governmental agency that issued the permit. Examples: EPA, State Department of Environmental Quality, County Building Department, City Public Works Department, U.S. Army Corps of Engineers.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent compliance inspection conducted by the issuing agency. Null if no inspections have occurred.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was last updated in the system. Audit trail for change tracking and data quality monitoring.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the primary permit site location in decimal degrees. Used for GIS mapping and spatial analysis of permit coverage.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the primary permit site location in decimal degrees. Used for GIS mapping and spatial analysis of permit coverage.',
    `mitigation_measures` STRING COMMENT 'Description of required environmental mitigation measures to offset impacts of the permitted activity. May include wetland restoration, stormwater controls, erosion prevention, habitat protection, or compensatory mitigation.',
    `monitoring_requirements` STRING COMMENT 'Description of required monitoring activities, including parameters to be monitored, frequency, methods, and reporting schedules. Common for environmental permits requiring water quality, air quality, or stormwater monitoring.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special considerations related to the permit. May include coordination notes, schedule impacts, or lessons learned.',
    `permit_number` STRING COMMENT 'Official permit number or identifier assigned by the issuing regulatory agency. This is the externally-recognized unique identifier for the permit.',
    `permit_status` STRING COMMENT 'Current lifecycle status of the permit. Tracks progression from application through issuance, active use, and closure. Critical for project schedule management and compliance tracking. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|issued|active|expired|revoked|suspended|closed — 10 candidates stripped; promote to reference product]',
    `permit_type` STRING COMMENT 'Classification of the permit based on regulatory domain. Environmental permits include NPDES, Section 404/401 wetlands, state water quality certifications. Construction permits include building, grading, excavation. Utility coordination and right-of-way permits govern work in public spaces.. Valid values are `environmental|construction|utility_coordination|right_of_way|encroachment|other`',
    `public_comment_period_end_date` DATE COMMENT 'Date the public comment period closed for the permit application. Null if no public comment period was required.',
    `public_notice_date` DATE COMMENT 'Date public notice was published for the permit application. Null if no public notice was required.',
    `public_notice_required` BOOLEAN COMMENT 'Indicates whether public notice and comment period was required for this permit. Common for major environmental permits and permits with significant public interest.',
    `renewal_application_date` DATE COMMENT 'Date the permit renewal application was submitted. Typically required 180 days before expiration for NPDES permits. Null if permit does not require renewal or renewal has not been initiated.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the permit requires periodic renewal. Common for environmental permits with fixed terms such as NPDES permits which typically require renewal every 5 years.',
    `reporting_frequency` STRING COMMENT 'Frequency at which compliance reports must be submitted to the issuing agency. Common for NPDES permits requiring monthly or quarterly discharge monitoring reports. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annually|as_required|none — 7 candidates stripped; promote to reference product]',
    `responsible_party_name` STRING COMMENT 'Name of the individual or organization legally responsible for permit compliance. Typically the permit holder or designated responsible official.',
    `subtype` STRING COMMENT 'Detailed classification within the permit type. Examples: NPDES Construction Stormwater, Section 404 Wetlands Fill, Building Permit Commercial, Grading Permit, Encroachment Permit Street Opening, Right-of-Way Temporary Occupancy.',
    `total_fees_paid` DECIMAL(18,2) COMMENT 'Cumulative total of all fees paid for this permit, including application, annual, renewal, and amendment fees. Recorded in US dollars.',
    `violation_count` STRING COMMENT 'Number of permit violations or non-compliance events recorded for this permit. Critical for compliance tracking and enforcement risk assessment.',
    CONSTRAINT pk_project_permit PRIMARY KEY(`project_permit_id`)
) COMMENT 'Regulatory and construction permit record required for CIP project execution including environmental permits (NPDES, Section 404/401, state water quality certifications), construction permits (building, grading, encroachment, right-of-way), and utility coordination permits. Tracks permit type, issuing agency, application date, issued date, expiration date, permit conditions, compliance requirements, associated fees, and permit status. Critical for project schedule management as permit delays are a leading cause of construction schedule impacts.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`project`.`inspection_report` (
    `inspection_report_id` BIGINT COMMENT 'Unique identifier for the construction inspection report. Primary key.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Construction inspection reports document field verification of specific installed assets (pipe segments, valves, pumps). Linking to asset registry establishes the post-construction condition baseline ',
    `cip_project_id` BIGINT COMMENT 'Reference to the capital improvement program (CIP) project under which this inspection was conducted.',
    `construction_contract_id` BIGINT COMMENT 'Foreign key linking to project.construction_contract. Business justification: Inspection reports are conducted under a specific construction contract — the resident project representative (RPR) or owners inspector performs inspections on work being performed by the contractor ',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Construction inspection reports for treatment facility projects reference the facility being built or upgraded. Inspectors document work at a specific WTP or WWTP. Facility-level reporting of construc',
    `vendor_id` BIGINT COMMENT 'Reference to the general contractor or prime contractor performing the work being inspected.',
    `inspection_vendor_id` BIGINT COMMENT 'Reference to the general contractor or prime contractor performing the work being inspected.',
    `network_valve_id` BIGINT COMMENT 'Foreign key linking to distribution.network_valve. Business justification: Construction inspection reports during valve installation or replacement CIP projects must reference the specific network valve being installed and inspected. Required for project QA/QC, asset commiss',
    `pay_application_id` BIGINT COMMENT 'Foreign key linking to project.pay_application. Business justification: The inspection_report has a pay_application_certification_status STRING field indicating that inspection reports are used to certify pay applications. Adding pay_application_id creates the direct FK',
    `pipe_main_id` BIGINT COMMENT 'Foreign key linking to distribution.pipe_main. Business justification: Daily construction inspection reports for pipeline installation must reference the specific main segment being installed for as-built documentation, quality assurance records, and construction defect ',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to treatment.process_unit. Business justification: Construction inspections often focus on specific process units being installed (new filter media, UV system, clarifier). Linking inspection reports to the specific process unit enables commissioning q',
    `project_permit_id` BIGINT COMMENT 'Foreign key linking to project.project_permit. Business justification: Construction inspections often verify compliance with specific project permits (environmental permits, construction permits, etc.). Adding project_permit_id to inspection_report enables permit complia',
    `prv_station_id` BIGINT COMMENT 'Foreign key linking to distribution.prv_station. Business justification: Construction inspection reports for PRV station installation CIP projects must reference the specific PRV station being installed. Required for project QA/QC, commissioning documentation, and linking ',
    `pump_station_id` BIGINT COMMENT 'Foreign key linking to distribution.pump_station. Business justification: Station construction inspection reports must link to the specific pump_station for equipment installation verification, punch list tracking, and as-built documentation of mechanical and electrical sys',
    `regulatory_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_inspection. Business justification: Regulatory inspectors visiting construction sites generate both a project inspection report and a regulatory inspection record. Linking these allows compliance staff to cross-reference construction pr',
    `storage_tank_id` BIGINT COMMENT 'Foreign key linking to distribution.storage_tank. Business justification: Construction inspection reports for tank rehabilitation or new construction CIP projects must reference the specific storage tank. Required for project QA/QC, regulatory inspection documentation, and ',
    `wbs_element_id` BIGINT COMMENT 'Reference to the specific WBS element or work package being inspected during this site visit.',
    `approved_by` STRING COMMENT 'Name of the project manager or authorized representative who approved this inspection report.',
    `approved_date` DATE COMMENT 'Date when the inspection report was formally approved.',
    `change_order_recommended_flag` BOOLEAN COMMENT 'Indicates whether the inspector recommends a change order based on field conditions, design changes, or unforeseen circumstances observed during the inspection.',
    `contractor_crew_size` STRING COMMENT 'Number of contractor personnel on-site during the inspection, used to assess resource deployment and progress correlation.',
    `corrective_action_required` STRING COMMENT 'Description of corrective actions required to address identified non-conformance items, including deadlines and responsible parties.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection report record was first created in the system.',
    `daily_progress_narrative` STRING COMMENT 'Comprehensive narrative describing the overall progress of construction activities, contractor performance, site conditions, and any issues or delays encountered. Provides the contemporaneous field record for project documentation.',
    `drawings_referenced` STRING COMMENT 'List of construction drawings, plans, or specifications referenced during the inspection, including drawing numbers and revision dates.',
    `equipment_on_site` STRING COMMENT 'List or description of major construction equipment present on-site during the inspection (e.g., excavators, cranes, concrete pumps, pipe layers).',
    `inspection_date` DATE COMMENT 'The calendar date on which the field inspection was conducted. Principal business event timestamp for this report.',
    `inspection_end_time` TIMESTAMP COMMENT 'Timestamp when the inspector completed the site visit and departed.',
    `inspection_report_number` STRING COMMENT 'Business identifier for the inspection report, typically a sequential or project-specific numbering scheme used for external reference and filing.',
    `inspection_start_time` TIMESTAMP COMMENT 'Timestamp when the inspector arrived on-site and began the inspection activities.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection report record was last updated or modified.',
    `materials_delivered` STRING COMMENT 'Description of construction materials delivered to the site during the inspection period, including quantities and supplier information where relevant.',
    `materials_tested` STRING COMMENT 'Description of materials tested or sampled during the inspection (e.g., concrete cylinders, soil compaction, pipe pressure tests), including test types and sample identifiers.',
    `non_conformance_description` STRING COMMENT 'Detailed description of any non-conformance items identified, including location, nature of deficiency, and reference to violated specification sections.',
    `non_conformance_identified_flag` BOOLEAN COMMENT 'Indicates whether any non-conformance items, deficiencies, or deviations from plans and specifications were identified during this inspection.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations not captured in other structured fields, providing supplementary context for the inspection record.',
    `pay_application_certification_status` STRING COMMENT 'Status of the inspectors certification for contractor pay application based on the work progress documented in this report. Used to support or dispute contractor payment requests.. Valid values are `certified|not_certified|partial|pending_review`',
    `percent_complete` DECIMAL(18,2) COMMENT 'Estimated percentage of work complete for the inspected work package or activity as of the inspection date, used for progress tracking and earned value analysis.',
    `photos_attached_count` STRING COMMENT 'Number of photographs attached to this inspection report for visual documentation of site conditions, work progress, and non-conformance items.',
    `report_status` STRING COMMENT 'Current lifecycle status of the inspection report in the review and approval workflow.. Valid values are `draft|submitted|reviewed|approved|archived`',
    `rfi_generated_flag` BOOLEAN COMMENT 'Indicates whether a Request for Information (RFI) was generated as a result of this inspection due to ambiguities, conflicts, or clarifications needed in the contract documents.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a safety incident or near-miss occurred during the inspection period.',
    `safety_observations` STRING COMMENT 'Documentation of safety conditions observed during the inspection, including compliance with Occupational Safety and Health Administration (OSHA) requirements, personal protective equipment (PPE) usage, and any safety concerns or violations.',
    `subcontractor_name` STRING COMMENT 'Name of the subcontractor performing the specific work activities observed during this inspection, if applicable.',
    `submitted_date` DATE COMMENT 'Date when the inspection report was formally submitted for review and approval.',
    `temperature_fahrenheit` DECIMAL(18,2) COMMENT 'Ambient temperature in degrees Fahrenheit at the time of inspection, critical for concrete curing, asphalt placement, and coating application compliance.',
    `test_results_summary` STRING COMMENT 'Summary of field test results or observations from materials testing conducted during or immediately following the inspection.',
    `visitors_on_site` STRING COMMENT 'List of visitors present on-site during the inspection (e.g., project managers, engineers, regulatory inspectors, utility representatives), relevant for documentation and coordination.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions during the inspection (e.g., clear, rain, snow, temperature range), relevant for documenting construction conditions and potential impacts on work quality.',
    `work_activities_observed` STRING COMMENT 'Detailed narrative of construction activities observed during the inspection, including specific tasks, locations, and methods employed by the contractor.',
    `work_stoppage_flag` BOOLEAN COMMENT 'Indicates whether work was stopped or suspended during the inspection due to non-conformance, safety issues, or other reasons.',
    `work_stoppage_reason` STRING COMMENT 'Explanation of the reason for work stoppage if the work stoppage flag is true, including corrective actions required before work may resume.',
    CONSTRAINT pk_inspection_report PRIMARY KEY(`inspection_report_id`)
) COMMENT 'Construction inspection report documenting field observations by the owners inspector or resident project representative (RPR) during construction activities. Tracks inspection date, inspector name, weather conditions, contractor crew size, equipment on-site, work activities observed, materials tested or sampled, non-conformance items identified, safety observations, daily progress narrative, and percentage of work complete. Provides the contemporaneous field record supporting contractor pay application certification and dispute resolution.';

CREATE OR REPLACE TABLE `water_utilities_ecm`.`project`.`schedule_of_values_line` (
    `schedule_of_values_line_id` BIGINT COMMENT 'Primary key for the schedule_of_values_line association',
    `change_order_id` BIGINT COMMENT 'Foreign key linking to the approved change order that this SOV line item represents.',
    `pay_application_id` BIGINT COMMENT 'Foreign key linking to the pay application in which this SOV line item is being billed.',
    `amount_billed_this_period` DECIMAL(18,2) COMMENT 'The dollar amount billed against this change order line item in the current pay application billing period. Belongs to the intersection of pay application and change order, not to either entity alone. Sourced from detection phase relationship data.',
    `approved_change_orders_amount` DECIMAL(18,2) COMMENT 'Net total of all approved change orders that modify the contract sum. [Moved from pay_application: This is a rolled-up aggregate of all change order SOV lines and belongs as a derived/summary value, not a stored attribute on pay_application. The granular per-change-order billing data now lives in schedule_of_values_line, making this a computable total. However, it may be retained on pay_application as a denormalized summary for AIA G702 reporting convenience — flagged for review rather than mandatory removal.]',
    `cumulative_amount_billed` DECIMAL(18,2) COMMENT 'Total amount billed against this change order line item across all pay applications to date, including the current period. Tracks running billing progress for this specific change order. Sourced from detection phase relationship data.',
    `percent_complete_this_period` DECIMAL(18,2) COMMENT 'Percentage of this change orders scope of work completed as of this billing period. Belongs to the specific pay application and change order combination. Sourced from detection phase relationship data.',
    `retainage_amount` DECIMAL(18,2) COMMENT 'Dollar amount of retainage withheld on this change order line item for this pay application period. Retainage is tracked per SOV line per pay period. Sourced from detection phase relationship data.',
    `scheduled_value` DECIMAL(18,2) COMMENT 'The approved contract value of this change order as established on the Schedule of Values. Represents the total value allocated to this SOV line item. Sourced from detection phase relationship data.',
    CONSTRAINT pk_schedule_of_values_line PRIMARY KEY(`schedule_of_values_line_id`)
) COMMENT 'This association product represents the Schedule of Values (SOV) Line — the AIA G703 industry-standard billing line that tracks the progress of a specific change order across pay applications. Each record links one pay_application to one change_order and captures the billing data that exists only in the context of that specific pay period and change order combination: the scheduled value of the change order, the amount billed in the current period, cumulative amount billed to date, percent complete, and retainage withheld. This is the operational entity that construction contract administrators create, certify, and audit each billing cycle.. Existence Justification: In AIA G702/G703 construction payment administration, each approved change order gets a line item on the Schedule of Values (SOV), and each pay application records billing progress against every SOV line item — meaning one pay application bills against many change orders, and one change order is billed across many pay applications (one per billing period). The pay application change order line is a well-recognized operational entity in construction contract administration that humans actively create, update, and certify each billing cycle. This relationship carries its own data (scheduled value, amount billed this period, cumulative amount billed, percent complete, retainage) that belongs to neither the pay application nor the change order alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ADD CONSTRAINT `fk_project_wbs_element_parent_wbs_element_id` FOREIGN KEY (`parent_wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_primary_predecessor_milestone_id` FOREIGN KEY (`primary_predecessor_milestone_id`) REFERENCES `water_utilities_ecm`.`project`.`milestone`(`milestone_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ADD CONSTRAINT `fk_project_milestone_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ADD CONSTRAINT `fk_project_project_budget_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_project_budget_id` FOREIGN KEY (`project_budget_id`) REFERENCES `water_utilities_ecm`.`project`.`project_budget`(`project_budget_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ADD CONSTRAINT `fk_project_budget_amendment_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ADD CONSTRAINT `fk_project_design_contract_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ADD CONSTRAINT `fk_project_construction_contract_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `water_utilities_ecm`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_design_contract_id` FOREIGN KEY (`design_contract_id`) REFERENCES `water_utilities_ecm`.`project`.`design_contract`(`design_contract_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ADD CONSTRAINT `fk_project_change_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ADD CONSTRAINT `fk_project_pay_application_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `water_utilities_ecm`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `water_utilities_ecm`.`project`.`change_order`(`change_order_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_original_transaction_cost_transaction_id` FOREIGN KEY (`original_transaction_cost_transaction_id`) REFERENCES `water_utilities_ecm`.`project`.`cost_transaction`(`cost_transaction_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ADD CONSTRAINT `fk_project_cost_transaction_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ADD CONSTRAINT `fk_project_project_permit_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_cip_project_id` FOREIGN KEY (`cip_project_id`) REFERENCES `water_utilities_ecm`.`project`.`cip_project`(`cip_project_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_construction_contract_id` FOREIGN KEY (`construction_contract_id`) REFERENCES `water_utilities_ecm`.`project`.`construction_contract`(`construction_contract_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_pay_application_id` FOREIGN KEY (`pay_application_id`) REFERENCES `water_utilities_ecm`.`project`.`pay_application`(`pay_application_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_project_permit_id` FOREIGN KEY (`project_permit_id`) REFERENCES `water_utilities_ecm`.`project`.`project_permit`(`project_permit_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ADD CONSTRAINT `fk_project_inspection_report_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `water_utilities_ecm`.`project`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`schedule_of_values_line` ADD CONSTRAINT `fk_project_schedule_of_values_line_change_order_id` FOREIGN KEY (`change_order_id`) REFERENCES `water_utilities_ecm`.`project`.`change_order`(`change_order_id`);
ALTER TABLE `water_utilities_ecm`.`project`.`schedule_of_values_line` ADD CONSTRAINT `fk_project_schedule_of_values_line_pay_application_id` FOREIGN KEY (`pay_application_id`) REFERENCES `water_utilities_ecm`.`project`.`pay_application`(`pay_application_id`);

-- ========= TAGS =========
ALTER SCHEMA `water_utilities_ecm`.`project` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `water_utilities_ecm`.`project` SET TAGS ('dbx_domain' = 'project');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project ID');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `conservation_program_id` SET TAGS ('dbx_business_glossary_term' = 'Conservation Program Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `debt_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Rate Case Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `water_system_id` SET TAGS ('dbx_business_glossary_term' = 'Water System Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `actual_cost_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost To Date');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `authorized_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorized Budget Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `change_order_count` SET TAGS ('dbx_business_glossary_term' = 'Change Order Count');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `cip_program_year` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Program Year');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `cost_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `design_capacity_mgd` SET TAGS ('dbx_business_glossary_term' = 'Design Capacity Million Gallons per Day (MGD)');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `environmental_review_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Review Status');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `environmental_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|approved');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `estimated_customers_impacted` SET TAGS ('dbx_business_glossary_term' = 'Estimated Customers Impacted');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `estimated_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Cost');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `forecast_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Completion Date');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `infrastructure_category` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Category');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `infrastructure_category` SET TAGS ('dbx_value_regex' = 'water|wastewater|shared|stormwater|other');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `operational_turnover_date` SET TAGS ('dbx_business_glossary_term' = 'Operational Turnover Date');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|deferred');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `project_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Name');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `project_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}-[0-9]{4,6}$');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|delayed|cancelled|completed');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `schedule_variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance Days');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `sponsoring_department` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Department');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `substantial_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Substantial Completion Date');
ALTER TABLE `water_utilities_ecm`.`project`.`cip_project` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `asset_class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project ID');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `parent_wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Cost Center ID');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'capital|operating|mixed');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `actual_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Date');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `baseline_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Finish Date');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `baseline_start_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Start Date');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `billing_element_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Element Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `change_order_count` SET TAGS ('dbx_business_glossary_term' = 'Change Order Count');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `commissioning_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Required Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `committed_cost` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `earned_value` SET TAGS ('dbx_business_glossary_term' = 'Earned Value (EV) for Earned Value Management (EVM)');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `geographic_location` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `planned_value` SET TAGS ('dbx_business_glossary_term' = 'Planned Value (PV) for Earned Value Management (EVM)');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `regulatory_permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Permit Required Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `responsible_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Name');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `wbs_element_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Code');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `wbs_element_description` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Description');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `wbs_element_name` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Name');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `wbs_element_status` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Status');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `wbs_element_status` SET TAGS ('dbx_value_regex' = 'planned|released|in_progress|completed|closed|cancelled');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `wbs_element_type` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element Type');
ALTER TABLE `water_utilities_ecm`.`project`.`wbs_element` ALTER COLUMN `wbs_element_type` SET TAGS ('dbx_value_regex' = 'phase|deliverable|work_package|milestone|planning_element');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Project Milestone Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioned Asset Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `primary_predecessor_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Milestone Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Milestone Acceptance Criteria');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Milestone Completion Date');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Milestone Approved By');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Milestone Approval Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Milestone Date');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `budget_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Impact Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `budget_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Milestone Completion Percentage');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Deliverable Description');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `forecast_date` SET TAGS ('dbx_business_glossary_term' = 'Forecast Milestone Date');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `is_critical_path` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Indicator');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `is_regulatory_milestone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Milestone Indicator');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `milestone_number` SET TAGS ('dbx_business_glossary_term' = 'Milestone Number');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|delayed|cancelled|on_hold');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'design|permitting|procurement|construction|commissioning|closeout');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Milestone Notes');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_value_regex' = 'internal|contractor|consultant|vendor|regulatory_agency');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Milestone Risk Level');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `variance_commentary` SET TAGS ('dbx_business_glossary_term' = 'Variance Commentary');
ALTER TABLE `water_utilities_ecm`.`project`.`milestone` ALTER COLUMN `variance_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Variance in Days');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` SET TAGS ('dbx_subdomain' = 'budget_control');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget ID');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `actual_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Expenditure Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `appropriation_ordinance_number` SET TAGS ('dbx_business_glossary_term' = 'Appropriation Ordinance Number');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `approved_amendments_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amendments Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bond Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|closed|cancelled');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `capex_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `contingency_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `current_approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Approved Budget Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective Date');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `encumbered_amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbered Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Expiration Date');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `funding_source_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Funding Source');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `funding_source_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Funding Source');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `grant_amount` SET TAGS ('dbx_business_glossary_term' = 'Grant Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `is_multi_year_budget` SET TAGS ('dbx_business_glossary_term' = 'Is Multi-Year Budget');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `last_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revision Date');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `opex_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Budget Phase');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'planning|design|construction|contingency|inspection|closeout');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `rate_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Revenue Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `remaining_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `water_utilities_ecm`.`project`.`project_budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'original|revised|amended|current|forecast');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` SET TAGS ('dbx_subdomain' = 'budget_control');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `budget_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Amendment Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `amendment_amount` SET TAGS ('dbx_business_glossary_term' = 'Amendment Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'scope_change|contingency_draw|emergency_authorization|cost_overrun|schedule_adjustment|funding_reallocation');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `approval_authority` SET TAGS ('dbx_value_regex' = 'board|commission|executive_director|finance_director|project_manager|delegated_authority');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `board_resolution_number` SET TAGS ('dbx_business_glossary_term' = 'Board Resolution Number');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `board_resolution_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `contingency_amount_used` SET TAGS ('dbx_business_glossary_term' = 'Contingency Amount Used');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `contingency_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Contingency Impact Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Meeting Date');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,15}$');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `remaining_contingency` SET TAGS ('dbx_business_glossary_term' = 'Remaining Contingency');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `requested_by` SET TAGS ('dbx_business_glossary_term' = 'Requested By');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `revised_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `scope_change_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Description');
ALTER TABLE `water_utilities_ecm`.`project`.`budget_amendment` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `design_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Design Contract Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Firm Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `primary_design_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Firm Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `amendment_value` SET TAGS ('dbx_business_glossary_term' = 'Amendment Value');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `construction_administration_included` SET TAGS ('dbx_business_glossary_term' = 'Construction Administration Included Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `contract_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration in Days');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Design Contract Number');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Design Contract Status');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `contract_title` SET TAGS ('dbx_business_glossary_term' = 'Design Contract Title');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Design Contract Type');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'lump_sum|time_and_materials|cost_plus_fixed_fee|cost_plus_percentage|unit_price|indefinite_delivery');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `current_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Current Contract Value');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `deliverable_schedule` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Schedule');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `design_phase` SET TAGS ('dbx_business_glossary_term' = 'Design Phase');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `design_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'Design Standard Reference');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `disadvantaged_business_enterprise_participation` SET TAGS ('dbx_business_glossary_term' = 'Disadvantaged Business Enterprise (DBE) Participation Percentage');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `engineering_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Engineering Firm Name');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `environmental_review_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Review Status');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `environmental_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|approved');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `grant_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Number');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `insurance_certificate_received` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Received Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `invoiced_to_date` SET TAGS ('dbx_business_glossary_term' = 'Invoiced to Date');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `notice_to_proceed_date` SET TAGS ('dbx_business_glossary_term' = 'Notice to Proceed (NTP) Date');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `original_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Original Contract Value');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `paid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Paid to Date');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `performance_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `permit_support_included` SET TAGS ('dbx_business_glossary_term' = 'Permit Support Included Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `procurement_method` SET TAGS ('dbx_value_regex' = 'qualifications_based_selection|competitive_sealed_proposals|sole_source|emergency_procurement|cooperative_purchasing');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `quality_assurance_review_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Review Required Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `retainage_amount` SET TAGS ('dbx_business_glossary_term' = 'Retainage Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `retainage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retainage Percentage');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `scope_of_services` SET TAGS ('dbx_business_glossary_term' = 'Scope of Services');
ALTER TABLE `water_utilities_ecm`.`project`.`design_contract` ALTER COLUMN `subconsultant_list` SET TAGS ('dbx_business_glossary_term' = 'Subconsultant List');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract ID');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project ID');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `construction_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `dma_id` SET TAGS ('dbx_business_glossary_term' = 'Dma Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `pressure_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `awarded_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Awarded Contract Value');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `bid_advertisement_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Advertisement Date');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `bid_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `bid_opening_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Opening Date');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `change_order_count` SET TAGS ('dbx_business_glossary_term' = 'Change Order Count');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `contract_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration Days');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'lump_sum|unit_price|cost_plus_fixed_fee|cost_plus_percentage|gmp|time_and_materials');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|AUD');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `current_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Current Completion Date');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `current_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Current Contract Value');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `final_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Final Completion Date');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `insurance_certificate_received` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Received');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `liquidated_damages_assessed` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Assessed');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `liquidated_damages_rate` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Damages Rate');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `ntp_date` SET TAGS ('dbx_business_glossary_term' = 'Notice to Proceed (NTP) Date');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `original_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Original Completion Date');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `payment_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Bond Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `payment_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Payment Bond Required');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `performance_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `retainage_amount` SET TAGS ('dbx_business_glossary_term' = 'Retainage Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `retainage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retainage Percentage');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `substantial_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Substantial Completion Date');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `time_extensions_days` SET TAGS ('dbx_business_glossary_term' = 'Time Extensions Days');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `total_change_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Change Order Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `total_paid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Total Paid to Date');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `water_utilities_ecm`.`project`.`construction_contract` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period Months');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Change Order Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `change_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `design_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Design Contract Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `change_order_description` SET TAGS ('dbx_business_glossary_term' = 'Change Order Description');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `change_order_number` SET TAGS ('dbx_business_glossary_term' = 'Change Order Number');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `change_order_status` SET TAGS ('dbx_business_glossary_term' = 'Change Order Status');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `change_order_type` SET TAGS ('dbx_business_glossary_term' = 'Change Order Type');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `cost_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `cost_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Currency Code');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `cost_impact_currency` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `cumulative_change_order_value` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Change Order Value');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Change Order Initiated By');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Initiated Date');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Change Order Justification');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Change Order Notes');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `original_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Original Contract Value');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Change Order Priority');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `revised_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Completion Date');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `safety_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `schedule_impact_days` SET TAGS ('dbx_business_glossary_term' = 'Schedule Impact Days');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `scope_addition_flag` SET TAGS ('dbx_business_glossary_term' = 'Scope Addition Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `scope_deletion_flag` SET TAGS ('dbx_business_glossary_term' = 'Scope Deletion Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Change Order Submitted Date');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Change Order Title');
ALTER TABLE `water_utilities_ecm`.`project`.`change_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `pay_application_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Application ID');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `pay_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `balance_to_finish_amount` SET TAGS ('dbx_business_glossary_term' = 'Balance to Finish Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `current_contract_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Contract Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `current_payment_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Payment Due Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `engineer_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Engineer Certification Date');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `engineer_certified_amount` SET TAGS ('dbx_business_glossary_term' = 'Engineer Certified Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `materials_stored_amount` SET TAGS ('dbx_business_glossary_term' = 'Materials Stored Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `original_contract_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Contract Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `owner_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Owner Approval Date');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `owner_approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Owner Approved Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `previous_payments_amount` SET TAGS ('dbx_business_glossary_term' = 'Previous Payments Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `retainage_amount` SET TAGS ('dbx_business_glossary_term' = 'Retainage Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `retainage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retainage Percentage');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `total_earned_less_retainage_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Earned Less Retainage Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `total_earned_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Earned to Date Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`pay_application` ALTER COLUMN `work_completed_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Work Completed to Date Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` SET TAGS ('dbx_subdomain' = 'budget_control');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Project Cost Transaction ID');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Change Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project ID');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `original_transaction_cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `capitalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Eligibility Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `commitment_item` SET TAGS ('dbx_business_glossary_term' = 'Commitment Item Reference');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `cost_element` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `cost_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type Classification');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `cost_type` SET TAGS ('dbx_value_regex' = 'labor|material|equipment|subcontract|overhead|other');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|rejected');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Transaction Quantity');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Transaction Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document ID');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Posting Date');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Document Number');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`cost_transaction` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` SET TAGS ('dbx_subdomain' = 'project_planning');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `project_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Project Permit Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project Identifier (ID)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `compliance_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `sampling_point_id` SET TAGS ('dbx_business_glossary_term' = 'Sampling Point Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Permit Amendment Count');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Permit Fee Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `appeal_filed` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|upheld|overturned|withdrawn|settled');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Application Date');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `application_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Permit Application Fee Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `application_submitted_by` SET TAGS ('dbx_business_glossary_term' = 'Application Submitted By');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bond Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `bond_required` SET TAGS ('dbx_business_glossary_term' = 'Bond Required Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `conditions` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Permit Contact Email Address');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Permit Contact Name');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Permit Contact Phone Number');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `coverage_area_description` SET TAGS ('dbx_business_glossary_term' = 'Permit Coverage Area Description');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `environmental_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Category');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `environmental_impact_category` SET TAGS ('dbx_value_regex' = 'none|minimal|moderate|significant');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issued Date');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `issuing_agency_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency Jurisdiction');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `issuing_agency_jurisdiction` SET TAGS ('dbx_value_regex' = 'federal|state|county|municipal|regional');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `issuing_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency Name');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Permit Inspection Date');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Permit Site Latitude');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Permit Site Longitude');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Environmental Mitigation Measures');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `monitoring_requirements` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Requirements');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Permit Notes');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'environmental|construction|utility_coordination|right_of_way|encroachment|other');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `public_comment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Public Comment Period End Date');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `public_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Date');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `public_notice_required` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Required Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `renewal_application_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Date');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Permit Subtype');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `total_fees_paid` SET TAGS ('dbx_business_glossary_term' = 'Total Permit Fees Paid');
ALTER TABLE `water_utilities_ecm`.`project`.`project_permit` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Permit Violation Count');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` SET TAGS ('dbx_subdomain' = 'budget_control');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `inspection_report_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report ID');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `construction_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Contract Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `inspection_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `network_valve_id` SET TAGS ('dbx_business_glossary_term' = 'Network Valve Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `pay_application_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Application Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `pipe_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipe Main Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Process Unit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `project_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Project Permit Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `prv_station_id` SET TAGS ('dbx_business_glossary_term' = 'Prv Station Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `pump_station_id` SET TAGS ('dbx_business_glossary_term' = 'Pump Station Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `regulatory_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Inspection Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `storage_tank_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Tank Id (Foreign Key)');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `change_order_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Change Order Recommended Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `contractor_crew_size` SET TAGS ('dbx_business_glossary_term' = 'Contractor Crew Size');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `daily_progress_narrative` SET TAGS ('dbx_business_glossary_term' = 'Daily Progress Narrative');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `drawings_referenced` SET TAGS ('dbx_business_glossary_term' = 'Drawings Referenced');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `equipment_on_site` SET TAGS ('dbx_business_glossary_term' = 'Equipment On-Site');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `inspection_end_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Time');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `inspection_report_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Number');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `inspection_start_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Time');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `materials_delivered` SET TAGS ('dbx_business_glossary_term' = 'Materials Delivered');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `materials_tested` SET TAGS ('dbx_business_glossary_term' = 'Materials Tested');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `non_conformance_description` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Description');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `non_conformance_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Identified Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `pay_application_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Pay Application Certification Status');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `pay_application_certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|partial|pending_review');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `percent_complete` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `photos_attached_count` SET TAGS ('dbx_business_glossary_term' = 'Photos Attached Count');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|reviewed|approved|archived');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `rfi_generated_flag` SET TAGS ('dbx_business_glossary_term' = 'Request for Information (RFI) Generated Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `safety_observations` SET TAGS ('dbx_business_glossary_term' = 'Safety Observations');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `subcontractor_name` SET TAGS ('dbx_business_glossary_term' = 'Subcontractor Name');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Submitted Date');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `temperature_fahrenheit` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Fahrenheit)');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `test_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Results Summary');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `visitors_on_site` SET TAGS ('dbx_business_glossary_term' = 'Visitors On-Site');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `work_activities_observed` SET TAGS ('dbx_business_glossary_term' = 'Work Activities Observed');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `work_stoppage_flag` SET TAGS ('dbx_business_glossary_term' = 'Work Stoppage Flag');
ALTER TABLE `water_utilities_ecm`.`project`.`inspection_report` ALTER COLUMN `work_stoppage_reason` SET TAGS ('dbx_business_glossary_term' = 'Work Stoppage Reason');
ALTER TABLE `water_utilities_ecm`.`project`.`schedule_of_values_line` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `water_utilities_ecm`.`project`.`schedule_of_values_line` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `water_utilities_ecm`.`project`.`schedule_of_values_line` SET TAGS ('dbx_association_edges' = 'project.pay_application,project.change_order');
ALTER TABLE `water_utilities_ecm`.`project`.`schedule_of_values_line` ALTER COLUMN `schedule_of_values_line_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Of Values Line - Schedule Of Values Line Id');
ALTER TABLE `water_utilities_ecm`.`project`.`schedule_of_values_line` ALTER COLUMN `change_order_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Of Values Line - Change Order Id');
ALTER TABLE `water_utilities_ecm`.`project`.`schedule_of_values_line` ALTER COLUMN `pay_application_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Of Values Line - Pay Application Id');
ALTER TABLE `water_utilities_ecm`.`project`.`schedule_of_values_line` ALTER COLUMN `amount_billed_this_period` SET TAGS ('dbx_business_glossary_term' = 'Amount Billed This Period');
ALTER TABLE `water_utilities_ecm`.`project`.`schedule_of_values_line` ALTER COLUMN `approved_change_orders_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Change Orders Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`schedule_of_values_line` ALTER COLUMN `cumulative_amount_billed` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Amount Billed');
ALTER TABLE `water_utilities_ecm`.`project`.`schedule_of_values_line` ALTER COLUMN `percent_complete_this_period` SET TAGS ('dbx_business_glossary_term' = 'Percent Complete This Period');
ALTER TABLE `water_utilities_ecm`.`project`.`schedule_of_values_line` ALTER COLUMN `retainage_amount` SET TAGS ('dbx_business_glossary_term' = 'Retainage Amount');
ALTER TABLE `water_utilities_ecm`.`project`.`schedule_of_values_line` ALTER COLUMN `scheduled_value` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Value');
