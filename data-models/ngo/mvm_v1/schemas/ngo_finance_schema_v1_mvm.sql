-- Schema for Domain: finance | Business: Ngo | Version: v1_mvm
-- Generated on: 2026-05-07 03:36:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ngo_ecm`.`finance` COMMENT 'Authoritative domain for fund accounting, general ledger (GL), Chart of Accounts (CoA), Budget vs. Actual (BvA) tracking, accounts payable (AP), accounts receivable (AR), restricted fund tracking, NICRA (Negotiated Indirect Cost Rate Agreement), grant financial management, and cost allocation. Ensures compliance with FASB ASC 958, GAAP for nonprofits, and OMB Uniform Guidance in SAP S/4HANA and Unit4 ERP.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ngo_ecm`.`finance`.`finance_fund` (
    `finance_fund_id` BIGINT COMMENT 'Unique identifier for the fund record. Primary key for the finance_fund product.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Restricted funds must track applicable compliance obligations (donor reporting schedules, audit requirements, IATI publication). Fund managers need to know which obligations apply to each fund for com',
    `constituent_id` BIGINT COMMENT 'Reference to the donor or funding source that provided the resources for this fund. Links to Salesforce Nonprofit Cloud constituent records.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: finance_fund has fiscal_period (STRING) and fiscal_year (STRING) as scalar fields but no fiscal_period_id FK. Fund master records must reference the fiscal period for fund lifecycle management, period',
    `funding_source_id` BIGINT COMMENT 'Reference to the specific funding source record that channels resources into this fund. May represent government agencies, foundations, or institutional donors.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Finance funds are managed and administered by specific org units (country offices, program units) in NGOs; FK enables fund portfolio reporting by org unit and supports organizational accountability fo',
    `parent_fund_finance_fund_id` BIGINT COMMENT 'Reference to a parent fund if this fund is a sub-fund or component of a larger fund structure. Enables hierarchical fund accounting and roll-up reporting.',
    `allowable_cost_categories` STRING COMMENT 'Comma-separated list or description of cost categories that are allowable charges to this fund per donor restrictions or OMB Uniform Guidance. Guides expense posting and audit compliance.',
    `audit_required_flag` BOOLEAN COMMENT 'Indicates whether this fund is subject to external audit requirements under OMB Uniform Guidance Single Audit provisions or donor-specific audit clauses.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total budgeted amount allocated to the fund for the current fiscal period. Used as the baseline for Budget versus Actual (BvA) variance analysis.',
    `chart_of_accounts_segment` STRING COMMENT 'The fund dimension segment code in the organizations Chart of Accounts structure. Used for General Ledger posting and financial reporting in SAP S/4HANA.. Valid values are `^[0-9]{4,10}$`',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when the fund was officially closed. Marks the completion of the fund lifecycle and triggers closeout procedures per OMB Uniform Guidance.',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total amount committed through purchase orders, contracts, or other encumbrances but not yet expended. Used for fund availability calculations.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the fund is currently in compliance with all donor conditions, OMB Uniform Guidance requirements, and internal policies. False triggers compliance review workflows.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fund record was first created in the system. Audit trail for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the funds primary currency. Essential for multi-currency fund management and foreign exchange reporting.. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'The current available balance in the fund after all posted transactions. Updated in real-time by the ERP system for fund availability checking.',
    `donor_reporting_frequency` STRING COMMENT 'The frequency at which financial reports must be submitted to the donor or funding source. Drives reporting calendar and compliance workflows.. Valid values are `monthly|quarterly|semi_annually|annually|upon_request|none`',
    `effective_end_date` DATE COMMENT 'The date when the fund expires or is scheduled to close. Critical for grant closeout planning and restricted fund compliance.',
    `effective_start_date` DATE COMMENT 'The date when the fund becomes active and available for transactions. Aligns with grant award start dates or board approval dates.',
    `expended_amount` DECIMAL(18,2) COMMENT 'Total amount expended from the fund during the current fiscal period. Tracks actual spending against budget for BvA reporting.',
    `fund_code` STRING COMMENT 'Unique alphanumeric code assigned to the fund for identification in financial systems and reporting. Used as the business identifier across SAP S/4HANA and Unit4 ERP.. Valid values are `^[A-Z0-9]{3,20}$`',
    `fund_name` STRING COMMENT 'Full descriptive name of the fund as it appears in financial statements and donor reports.',
    `fund_status` STRING COMMENT 'Current operational status of the fund in the financial system. Determines whether transactions can be posted to the fund.. Valid values are `active|inactive|closed|suspended|pending_approval`',
    `fund_type` STRING COMMENT 'Classification of the fund based on restriction type and purpose. Determines how funds can be used and reported per FASB ASC 958 net asset classification requirements.. Valid values are `unrestricted|temporarily_restricted|permanently_restricted|board_designated|donor_restricted|project_specific`',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The Negotiated Indirect Cost Rate Agreement (NICRA) percentage applicable to this fund. Used for Facilities and Administration (F&A) cost allocation per OMB Uniform Guidance.',
    `last_audit_date` DATE COMMENT 'The date of the most recent external audit that included this fund. Used for audit cycle tracking and compliance monitoring.',
    `last_report_date` DATE COMMENT 'The date when the most recent financial report was submitted to the donor for this fund. Tracks reporting compliance and timeliness.',
    `manager_name` STRING COMMENT 'Name of the staff member or department responsible for managing and overseeing the fund. Accountable for fund stewardship and compliance.',
    `match_fulfilled_amount` DECIMAL(18,2) COMMENT 'The total amount of matching funds or in-kind contributions fulfilled to date. Tracked for grant reporting and compliance verification.',
    `match_requirement_percentage` DECIMAL(18,2) COMMENT 'The percentage of matching funds or cost share required by the donor or grant agreement. Critical for tracking cost share commitments and compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this fund record was last modified. Supports change tracking and audit compliance.',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next external audit covering this fund. Supports audit planning and documentation preparation.',
    `next_report_due_date` DATE COMMENT 'The due date for the next scheduled financial report to the donor. Critical for compliance and relationship management.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or contextual information about the fund. Used by fund managers for operational guidance.',
    `opening_balance` DECIMAL(18,2) COMMENT 'The fund balance at the beginning of the current fiscal year or at fund inception. Represents the starting financial position for Budget versus Actual (BvA) tracking.',
    `program_code` STRING COMMENT 'The program or project code linked to the fund. Enables program-level financial reporting and Monitoring Evaluation and Learning (MEL) integration.. Valid values are `^[A-Z0-9]{3,15}$`',
    `purpose` STRING COMMENT 'Detailed description of the intended use and purpose of the fund, including any donor-specified restrictions or programmatic objectives.',
    `restriction_type` STRING COMMENT 'Specific nature of restrictions placed on the fund by donors or the board. Governs allowable expenditures and compliance requirements under OMB Uniform Guidance 2 CFR 200.. Valid values are `unrestricted|donor_restricted|time_restricted|purpose_restricted|board_designated|endowment`',
    `unallowable_cost_categories` STRING COMMENT 'Comma-separated list or description of cost categories that are explicitly unallowable for this fund. Prevents non-compliant expense posting.',
    CONSTRAINT pk_finance_fund PRIMARY KEY(`finance_fund_id`)
) COMMENT 'Master record for each restricted or unrestricted fund managed by the NGO. Captures fund name, fund code, restriction type (donor-restricted, board-designated, unrestricted), associated grant or donor source, fund purpose, opening balance, currency, fiscal year, fund status, and compliance flags per OMB Uniform Guidance 2 CFR 200 and FASB ASC 958. The SSOT for fund identity used across grant financial management, cost allocation, and BvA reporting in Unit4 ERP and SAP S/4HANA.';

CREATE OR REPLACE TABLE `ngo_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center. Primary key for the cost center master record.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Cost centers (programs/field offices) have specific compliance obligations (CHS commitments, sphere standards, donor-specific requirements). Program managers track obligations by cost center for opera',
    `parent_cost_center_id` BIGINT COMMENT 'Reference to the parent cost center in the organizational hierarchy. Enables roll-up reporting from field offices to regional hubs to headquarters. Nullable for top-level cost centers.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member who is accountable for budget performance, expense approval, and financial stewardship of this cost center. Used in RACI (Responsible Accountable Consulted Informed) matrices and budget versus actual (BvA) reporting.',
    `activity_type` STRING COMMENT 'The primary activity or service provided by this cost center (e.g., beneficiary registration, field assessment, grant management, financial reporting, volunteer coordination). Used for activity-based costing and internal service billing.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'The total approved budget amount for this cost center for the current fiscal year. Used in Budget versus Actual (BvA) variance analysis and financial stewardship reporting.',
    `approval_status` STRING COMMENT 'Workflow approval status for new or modified cost centers. Draft cost centers are under construction; pending approval cost centers await finance or executive review; approved cost centers are active; rejected cost centers require revision.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center was approved for activation. Used for audit trail and compliance reporting. Nullable for cost centers not yet approved.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost centers budget and financial reporting. Used for multi-currency organizations with country offices operating in local currencies.. Valid values are `^[A-Z]{3}$`',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center was permanently closed and all balances were transferred or reconciled. Used for grant closeout, project completion, and organizational restructuring. Nullable for active cost centers.',
    `company_code` STRING COMMENT 'The SAP S/4HANA or Unit4 ERP company code representing the legal entity to which this cost center belongs. Used for multi-entity consolidation and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area` STRING COMMENT 'The SAP S/4HANA controlling area (CO module) to which this cost center is assigned. Controlling areas represent organizational units for internal cost accounting and management reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_allocation_method` STRING COMMENT 'The methodology used to allocate shared or indirect costs to this cost center. Direct allocation assigns costs explicitly; proportional uses a percentage driver; headcount allocates by staff count; square footage uses physical space; activity-based costing (ABC) uses cost drivers; not allocated for cost centers that do not receive shared cost allocations.. Valid values are `direct|proportional|headcount|square_footage|activity_based|not_allocated`',
    `cost_center_category` STRING COMMENT 'SAP S/4HANA cost center category classification. Production cost centers deliver direct program services; service cost centers provide internal support; administrative cost centers manage overhead; auxiliary cost centers support shared services; project cost centers are time-bound; temporary cost centers are short-term or pilot initiatives.. Valid values are `production|service|administrative|auxiliary|project|temporary`',
    `cost_center_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying the cost center in SAP S/4HANA and Unit4 ERP. Used in general ledger posting, budget tracking, and financial reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `cost_center_description` STRING COMMENT 'Detailed narrative description of the cost centers purpose, scope, and responsibilities. Includes information on program activities, geographic coverage, donor restrictions, and organizational context.',
    `cost_center_name` STRING COMMENT 'The full descriptive name of the cost center as it appears in financial reports and organizational charts.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active cost centers accept expense postings; inactive cost centers are temporarily disabled; suspended cost centers are under review; closed cost centers are permanently retired; pending activation cost centers are awaiting approval.. Valid values are `active|inactive|suspended|closed|pending_activation`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by functional expense category per GAAP for nonprofits. Program cost centers support direct mission delivery; administrative cost centers support organizational management; fundraising cost centers support donor cultivation and gift processing; general and administrative (G&A) support overall operations; mission support provides enabling services; field operations manage country office and site-level activities.. Valid values are `program|administrative|fundraising|general_and_administrative|mission_support|field_operations`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the primary geographic location of this cost center. Used for country office cost centers, field operations, and regional program management. Nullable for headquarters or global cost centers.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was first created in the system. Used for audit trail and data lineage tracking.',
    `department` STRING COMMENT 'The functional department or division to which this cost center belongs (e.g., Health Programs, WASH, Education, Finance, Human Resources, Monitoring Evaluation and Learning). Used for cross-cutting organizational reporting.',
    `effective_end_date` DATE COMMENT 'The date on which this cost center ceases to be active. Nullable for open-ended cost centers. Used for project-specific or time-bound organizational units.',
    `effective_start_date` DATE COMMENT 'The date from which this cost center becomes active and can accept expense allocations and budget assignments.',
    `external_reference_code` STRING COMMENT 'The unique identifier for this cost center in external systems such as donor grant management systems (GMS), partner organization ERPs, or government reporting portals. Used for cross-system reconciliation and International Aid Transparency Initiative (IATI) reporting.',
    `functional_expense_classification` STRING COMMENT 'GAAP functional expense category per FASB ASC 958-720. Program services are mission-delivery activities; management and general (M&G) are administrative overhead; fundraising supports donor cultivation; membership development supports constituent engagement. Required for Form 990 and audited financial statements.. Valid values are `program_services|management_and_general|fundraising|membership_development`',
    `fund_restriction_type` STRING COMMENT 'Classification of donor-imposed restrictions on funds allocated to this cost center per FASB ASC 958-205. Unrestricted funds have no donor-imposed restrictions; temporarily restricted funds have time or purpose restrictions that will lapse; permanently restricted funds (endowments) must be maintained in perpetuity.. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `hierarchy_level` STRING COMMENT 'The depth of this cost center in the organizational hierarchy tree. Level 1 represents headquarters or top-level divisions; higher numbers represent nested field offices, country offices, or project sites.',
    `indirect_cost_eligible_flag` BOOLEAN COMMENT 'Indicates whether expenses posted to this cost center are eligible for indirect cost recovery under the organizations Negotiated Indirect Cost Rate Agreement (NICRA). True for direct program cost centers; false for administrative or already-indirect cost centers. Used in Facilities and Administration (F&A) cost allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost center record was most recently updated. Used for change tracking and audit trail.',
    `nicra_base_category` STRING COMMENT 'The indirect cost base category used for calculating indirect cost recovery for this cost center per the organizations NICRA with the federal government. Modified Total Direct Costs (MTDC) is the most common base; direct salaries and wages is used for some research organizations; total direct costs includes all direct expenses. Not applicable for cost centers that do not participate in indirect cost allocation.. Valid values are `modified_total_direct_costs|direct_salaries_and_wages|total_direct_costs|other|not_applicable`',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, donor conditions, compliance requirements, or historical context relevant to this cost center.',
    `profit_center` STRING COMMENT 'The profit center code for organizations using profit center accounting in SAP S/4HANA. Used for segment reporting and internal performance measurement. Nullable for nonprofits not using profit center structures.. Valid values are `^[A-Z0-9]{4,10}$`',
    `program_area` STRING COMMENT 'The thematic program area or sector this cost center supports (e.g., WASH - Water Sanitation and Hygiene, GBV - Gender-Based Violence, Health, Education, Livelihoods, Emergency Response). Used for Sustainable Development Goal (SDG) alignment and donor reporting.',
    `region` STRING COMMENT 'Geographic region for multi-country or regional cost centers. Used for regional program offices, humanitarian response hubs, and Development Assistance Committee (DAC) reporting. [ENUM-REF-CANDIDATE: africa|asia_pacific|europe|latin_america_caribbean|middle_east|north_america|global — 7 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'The operational system of record from which this cost center master data originated. Used for data lineage tracking and reconciliation between SAP S/4HANA, Unit4 ERP, and legacy systems.. Valid values are `sap_s4hana|unit4_erp|manual_entry|data_migration`',
    `year_to_date_actual_amount` DECIMAL(18,2) COMMENT 'The cumulative actual expenses posted to this cost center from the start of the fiscal year to the current reporting period. Used in BvA reporting and burn rate analysis.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Master record for organizational cost centers used to allocate expenses across programs, departments, country offices, and projects. Captures cost center code, name, type (program, administrative, fundraising), responsible manager, parent cost center (for hierarchy), organizational hierarchy level, associated country or region, active status, and functional expense classification per GAAP. The SSOT for organizational cost structure used in SAP S/4HANA and Unit4 ERP for cost allocation, indirect cost recovery, NICRA base calculations, and Budget vs. Actual reporting.';

CREATE OR REPLACE TABLE `ngo_ecm`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique identifier for the general ledger account. Primary key for the GL account master data.',
    `account_description` STRING COMMENT 'Detailed business description of the GL account purpose, usage guidelines, and what types of transactions should be posted to this account.',
    `account_group` STRING COMMENT 'The account group or category within the Chart of Accounts structure (e.g., Current Assets, Fixed Assets, Restricted Contributions, Program Expenses).',
    `account_name` STRING COMMENT 'The human-readable descriptive name of the GL account (e.g., Cash - Operating Account, Grant Revenue - USAID, Program Salaries - WASH).',
    `account_number` STRING COMMENT 'The externally-known unique account number within the Chart of Accounts (CoA) structure. This is the business identifier used in SAP S/4HANA and Unit4 ERP for all financial transactions and reporting.. Valid values are `^[0-9]{4,10}$`',
    `account_owner` STRING COMMENT 'The name or identifier of the business owner or responsible party for this GL account (e.g., Finance Director, Program Manager, Grant Manager).',
    `account_status` STRING COMMENT 'The current lifecycle status of the GL account: active (available for posting), inactive (temporarily suspended), blocked (posting prohibited), or closed (permanently retired).. Valid values are `active|inactive|blocked|closed`',
    `account_type` STRING COMMENT 'The fundamental accounting classification of the GL account: asset, liability, net asset (equity for nonprofits per FASB ASC 958), revenue, or expense.. Valid values are `asset|liability|net_asset|revenue|expense`',
    `budget_control_flag` BOOLEAN COMMENT 'Indicates whether this account is subject to budget control and Budget versus Actual (BvA) monitoring. When true, transactions require budget availability checking before posting.',
    `coa_structure_code` STRING COMMENT 'The Chart of Accounts structure identifier or version code. Nonprofits may maintain multiple CoA structures for different legal entities or reporting requirements.',
    `consolidation_account_number` STRING COMMENT 'The GL account number used for consolidated financial reporting across multiple legal entities or country offices. Used when the nonprofit has a multi-entity structure.',
    `cost_allocation_base_flag` BOOLEAN COMMENT 'Indicates whether this account serves as an allocation base for distributing indirect costs across programs and grants (e.g., direct salaries, total direct costs).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account record was first created in the system.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for this GL account (e.g., USD, EUR, GBP). Nonprofits operating internationally may maintain accounts in multiple currencies.. Valid values are `^[A-Z]{3}$`',
    `dac_sector_code` STRING COMMENT 'The OECD Development Assistance Committee sector classification code for international development activities. Required for International Aid Transparency Initiative (IATI) reporting.',
    `donor_restricted_flag` BOOLEAN COMMENT 'Indicates whether this account tracks donor-restricted funds requiring specific usage compliance and separate reporting per donor agreements and FASB ASC 958.',
    `effective_end_date` DATE COMMENT 'The date when this GL account was closed or became inactive. Null for currently active accounts.',
    `effective_start_date` DATE COMMENT 'The date when this GL account became active and available for transaction posting in the Chart of Accounts.',
    `external_reporting_code` STRING COMMENT 'The mapping code used for external regulatory reporting (e.g., IRS Form 990 line item, IATI activity code, donor-specific reporting category).',
    `financial_statement_classification` STRING COMMENT 'The primary financial statement where this account appears: balance sheet (statement of financial position), statement of activities (income statement equivalent for nonprofits), statement of functional expenses, statement of cash flows, or off-balance-sheet.. Valid values are `balance_sheet|statement_of_activities|statement_of_functional_expenses|statement_of_cash_flows|off_balance_sheet`',
    `functional_expense_category` STRING COMMENT 'The functional expense classification required by FASB ASC 958 for expense accounts: program services, management and general (administrative), fundraising, or not applicable (for non-expense accounts). Used for Form 990 reporting and functional expense allocation.. Valid values are `program|management_general|fundraising|not_applicable`',
    `fund_restriction_class` STRING COMMENT 'The net asset restriction classification per FASB ASC 958: unrestricted (no donor restrictions), temporarily restricted (time or purpose restrictions), or permanently restricted (endowment principal). Critical for nonprofit fund accounting and donor compliance.. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `grant_eligible_flag` BOOLEAN COMMENT 'Indicates whether expenses posted to this account are eligible for reimbursement under federal grants per OMB Uniform Guidance 2 CFR 200. Critical for grant financial management and cost allocation.',
    `hierarchy_level` STRING COMMENT 'The level of this account within the Chart of Accounts hierarchy (e.g., 1 for top-level summary accounts, 2 for sub-accounts, 3 for detail posting accounts).',
    `indirect_cost_pool_flag` BOOLEAN COMMENT 'Indicates whether this account is part of the indirect cost pool for Negotiated Indirect Cost Rate Agreement (NICRA) calculations and Facilities and Administration (F&A) cost allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account record was most recently updated.',
    `last_posting_date` DATE COMMENT 'The date of the most recent transaction posted to this GL account. Used for account activity monitoring and dormant account identification.',
    `natural_expense_classification` STRING COMMENT 'The natural classification of expense by type (e.g., salaries, benefits, travel, supplies, professional fees, rent, utilities). Used alongside functional classification for comprehensive expense reporting per FASB ASC 958.',
    `normal_balance_indicator` STRING COMMENT 'Indicates whether this account normally carries a debit or credit balance per double-entry accounting principles.. Valid values are `debit|credit`',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this GL account usage, restrictions, or compliance requirements.',
    `posting_eligible_flag` BOOLEAN COMMENT 'Indicates whether transactions can be directly posted to this account (true for detail accounts) or if it is a summary/roll-up account that only receives aggregated balances (false).',
    `program_service_code` STRING COMMENT 'The program or service line code that this account supports (e.g., WASH, Health, Education, Emergency Response). Used for program-level financial reporting and Monitoring Evaluation and Learning (MEL).',
    `reconciliation_account_flag` BOOLEAN COMMENT 'Indicates whether this account requires regular reconciliation (e.g., bank accounts, accounts receivable, accounts payable control accounts). Used for internal control and audit compliance.',
    `sdg_alignment_code` STRING COMMENT 'The United Nations Sustainable Development Goal(s) that activities posted to this account contribute toward (e.g., SDG 1 - No Poverty, SDG 6 - Clean Water and Sanitation). Used for impact reporting.',
    `tax_relevance_indicator` STRING COMMENT 'Indicates the tax treatment of transactions posted to this account: taxable income, non-taxable, tax-exempt per IRS 501(c)(3) regulations, or not applicable.. Valid values are `taxable|non_taxable|exempt|not_applicable`',
    `unrelated_business_income_flag` BOOLEAN COMMENT 'Indicates whether revenue posted to this account constitutes Unrelated Business Income (UBI) subject to taxation under IRS regulations for tax-exempt organizations.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'Authoritative master of the nonprofits Chart of Accounts (CoA) and General Ledger account structure in SAP S/4HANA and Unit4 ERP. Each record represents a GL account within the CoA hierarchy, capturing GL account number, account description, account group, parent account (for CoA hierarchy navigation), hierarchy level, CoA structure code, account type (asset, liability, net asset, revenue, expense), balance sheet or income statement classification, normal debit/credit indicator, currency, fund restriction class (unrestricted, temporarily restricted, permanently restricted per FASB ASC 958), functional expense category (program, management & general, fundraising), natural expense classification, tax relevance, reconciliation account flag, and posting eligibility. Serves as the single authoritative reference (SSOT) for all fund accounting, grant financial management, budget planning, BvA reporting, and GAAP-compliant financial reporting. Subsumes the Chart of Accounts structure — no separate CoA entity exists.';

CREATE OR REPLACE TABLE `ngo_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record. Primary key for the journal entry entity.',
    `award_id` BIGINT COMMENT 'Foreign key reference to the grant or award that this journal entry is financially associated with. Critical for grant-specific financial tracking, budget versus actual reporting, and donor reporting compliance.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: journal_entry has no bank_account_id FK. Bank-related journal entries (bank reconciliation adjustments, bank charges, interest income) must reference the specific bank account they affect. Adding bank',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entries are allocated to cost centers at the header level. This FK enables cost center reporting and management analysis.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Journal entries are often specific to a country office. Finance needs country-level expense tracking for management reporting, donor reporting, and HQ consolidation.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Finance tracks which staff member created each journal entry for audit trail and accountability - fundamental accounting control requirement in nonprofit financial management.',
    `field_deployment_id` BIGINT COMMENT 'Foreign key linking to field.deployment. Business justification: Deployment costs are recorded via journal entries. Finance needs to link JEs to deployments for cost tracking, audit trail, and deployment cost analysis.',
    `field_team_id` BIGINT COMMENT 'Foreign key linking to field.team. Business justification: Team operating costs are recorded via journal entries. Finance needs to link JEs to teams for team budget tracking and team cost analysis.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Journal entries are allocated to funds at the header level. This FK enables fund-level reporting and ensures compliance with donor restrictions.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Journal entries are posted to specific fiscal periods for financial reporting and period close processes. The existing fiscal_year (INT) and fiscal_period (INT) columns are denormalized representation',
    `intervention_id` BIGINT COMMENT 'Foreign key reference to the program or project that this journal entry supports. Enables program-level cost tracking, budget monitoring, and Results-Based Management (RBM) financial reporting.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Many journal entries relate to specific field sites (site operating costs, site setup costs). Finance needs to track expenses by site for management reporting and site cost analysis.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry was approved for posting. Null if not yet approved. Part of the audit trail for approval workflow compliance.',
    `audit_trail_notes` STRING COMMENT 'Additional free-text notes or comments added for audit trail purposes, explaining unusual circumstances, supporting documentation references, or special handling instructions.',
    `batch_number` STRING COMMENT 'Batch identifier grouping multiple journal entries that were posted together as a single batch. Used for batch-level approval workflows and mass reversal operations.',
    `company_code` STRING COMMENT 'Legal entity or company code within the ERP system to which this journal entry belongs. Essential for multi-entity nonprofit organizations with separate legal entities or country offices.',
    `compliance_flag` STRING COMMENT 'Compliance status flag indicating whether this journal entry has been reviewed for regulatory compliance (OMB Uniform Guidance, FASB ASC 958, donor restrictions). Used for compliance monitoring and audit preparation.. Valid values are `compliant|under_review|exception|non_compliant`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry record was first created in the system. Foundational audit timestamp for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the transaction currency of this journal entry (e.g., USD, EUR, GBP). Essential for multi-currency grant accounting and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date the journal entry document was created or originated, which may differ from the posting date. Used for audit trail and document sequencing.',
    `document_number` STRING COMMENT 'The externally-known unique document number assigned to this journal entry in the ERP system (SAP S/4HANA or Unit4). Used for audit trails and cross-system reconciliation.',
    `document_type` STRING COMMENT 'Classification of the journal entry document type indicating the nature of the posting: original entry, reversal of prior entry, accrual for period-end, cost allocation, reclassification between accounts, or manual adjustment.. Valid values are `original|reversal|accrual|allocation|reclassification|adjustment`',
    `entry_description` STRING COMMENT 'Detailed narrative description of the business purpose and nature of this journal entry. Provides context for financial reviewers, auditors, and future reference.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert transaction currency amounts to the organizations functional currency (typically USD). Null for entries in functional currency. Critical for multi-currency grant financial management.',
    `functional_area` STRING COMMENT 'Functional area classification (e.g., program services, management and general, fundraising) required for nonprofit functional expense reporting per FASB ASC 958. Supports Form 990 and donor reporting.',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 code for the organizations functional reporting currency. All journal entries are ultimately reported in this currency for consolidated financial statements.. Valid values are `^[A-Z]{3}$`',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The Negotiated Indirect Cost Rate Agreement (NICRA) rate applied to this journal entry for facilities and administration (F&A) cost allocation. Expressed as a decimal (e.g., 0.1500 for 15%). Critical for federal grant compliance.',
    `is_adjustment` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a manual adjustment or correction entry (as opposed to a system-generated or routine operational entry). True for adjustments; false for standard entries.',
    `is_inter_company` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry represents an inter-company or inter-entity transaction requiring elimination in consolidated financial statements. True for inter-company entries; false otherwise.',
    `ledger_group` STRING COMMENT 'Ledger group or ledger type identifier (e.g., leading ledger, extension ledger, parallel accounting ledger) used in systems supporting multiple parallel accounting views. Supports GAAP and IFRS parallel reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this journal entry was last modified. Null if never modified. Critical for audit trail and change history tracking.',
    `posting_date` DATE COMMENT 'The business date on which this journal entry was posted to the general ledger. This is the effective date for financial reporting and determines which fiscal period the entry impacts.',
    `posting_key` STRING COMMENT 'System-specific posting key code (from SAP or Unit4) that determines the account type (debit/credit) and controls which fields are required during entry. Technical control field for ERP posting logic.',
    `posting_status` STRING COMMENT 'Current lifecycle status of the journal entry in the approval and posting workflow. Tracks progression from draft creation through approval to final posting in the general ledger.. Valid values are `draft|pending_approval|approved|posted|reversed|cancelled`',
    `reference_document_number` STRING COMMENT 'External reference number linking this journal entry to source documents such as invoices, payment vouchers, grant agreements, or other originating transactions. Supports audit trail and source document traceability.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a reversal of a previously posted entry. True if this entry reverses another entry; false otherwise.',
    `reversal_reason` STRING COMMENT 'Free-text explanation of why this journal entry was reversed. Required for audit compliance and internal control documentation when reversal_indicator is true.',
    `reversed_document_number` STRING COMMENT 'The document number of the original journal entry that this entry reverses. Populated only when reversal_indicator is true. Maintains bidirectional audit trail for reversals.',
    `source_system` STRING COMMENT 'Identifier of the system or interface that originated this journal entry. Distinguishes between entries created directly in the ERP (SAP S/4HANA, Unit4), manual entries, or entries interfaced from subsidiary systems.. Valid values are `SAP_S4HANA|UNIT4_ERP|MANUAL|INTERFACE|OTHER`',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Transactional record of every GL journal entry posted in SAP S/4HANA or Unit4 ERP. Captures document number, posting date, fiscal period, fiscal year, document type (original, reversal, accrual, allocation), posting key, currency, exchange rate, reference document, posting user, approval status, reversal indicator, and source system. The foundational transactional entity for all financial reporting, audit trails, and GAAP-compliant fund accounting. Each journal entry has one or more journal_entry_line records.';

CREATE OR REPLACE TABLE `ngo_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line item. Primary key for the journal entry line product.',
    `award_id` BIGINT COMMENT 'Reference to the grant or award that this line item is charged to. Enables grant financial management and compliance reporting per OMB Uniform Guidance 2 CFR 200.',
    `budget_line_id` BIGINT COMMENT 'Reference to the budget line item against which this actual expenditure or revenue is tracked. Enables Budget versus Actual (BvA) variance analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entry lines are allocated to cost centers for expense tracking and management reporting. This FK enables joining to get cost center hierarchy, manager, and program area.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Journal entry lines are allocated to funds for fund accounting and donor restriction tracking. This FK enables joining to get fund type, restriction type, and donor information.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: journal_entry_line has fiscal_period (INT) and fiscal_year (INT) as raw scalar fields rather than a proper FK to fiscal_period. Adding fiscal_period_id normalizes this to reference the authoritative f',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Every journal entry line posts to a GL account. This is the core relationship for the general ledger. The FK enables joining to get account type, financial statement classification, and CoA hierarchy.',
    `journal_entry_id` BIGINT COMMENT 'Reference to the parent journal entry header that contains this line item. Links the line to its transaction header.',
    `original_line_journal_entry_line_id` BIGINT COMMENT 'Reference to the original journal entry line ID that this line reverses or corrects. Null if this is not a reversal. Supports audit trail and error correction tracking.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier associated with this line item for accounts payable transactions. Supports vendor payment tracking and procurement compliance.',
    `allowable_cost_flag` BOOLEAN COMMENT 'Boolean indicator of whether this cost is allowable under the applicable grant or award terms per OMB Uniform Guidance. Used for grant financial compliance.',
    `approval_status` STRING COMMENT 'The approval status of this journal entry line within the financial workflow. Tracks whether the line has been reviewed, approved, and posted to the GL.. Valid values are `pending|approved|rejected|posted`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry line was approved. Supports audit trails and compliance reporting.',
    `approved_by` STRING COMMENT 'The user ID or name of the person who approved this journal entry line. Supports internal controls and audit trails per OMB Uniform Guidance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry line record was first created in the system. Supports audit trails and data lineage.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The credit amount for this journal entry line in the functional currency. Null or zero if this is a debit line. Used for double-entry bookkeeping per GAAP.',
    `debit_amount` DECIMAL(18,2) COMMENT 'The debit amount for this journal entry line in the functional currency. Null or zero if this is a credit line. Used for double-entry bookkeeping per GAAP.',
    `direct_cost_flag` BOOLEAN COMMENT 'Boolean indicator of whether this line item represents a direct cost (true) or an indirect/overhead cost (false). Used for cost allocation and grant compliance.',
    `donor_restriction_type` STRING COMMENT 'Classification of donor restrictions on the funds used in this line item per FASB ASC 958: unrestricted, temporarily restricted (time or purpose), or permanently restricted (endowment).. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `effective_date` DATE COMMENT 'The effective date of the transaction represented by this line item. May differ from posting date for accruals, deferrals, and period adjustments.',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the functional currency in which the debit and credit amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `functional_expense_category` STRING COMMENT 'Classification of the expense by functional category as required by FASB ASC 958: program services, management and general, or fundraising. Used for Form 990 and donor reporting.. Valid values are `program_services|management_and_general|fundraising`',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The Negotiated Indirect Cost Rate Agreement (NICRA) rate applied to this line item for Facilities and Administration (F&A) cost allocation per OMB Uniform Guidance.',
    `intercompany_flag` BOOLEAN COMMENT 'Boolean indicator of whether this line item represents an intercompany or inter-entity transaction between organizational units or affiliated entities.',
    `invoice_number` STRING COMMENT 'The vendor invoice number or internal invoice reference associated with this line item. Used for accounts payable reconciliation and audit trails.. Valid values are `^[A-Z0-9-]{1,30}$`',
    `line_description` STRING COMMENT 'Narrative description of the journal entry line item. Provides context and explanation for the transaction, supporting audit trails and financial transparency.',
    `line_number` STRING COMMENT 'Sequential line number within the journal entry, used for ordering and referencing individual line items within the parent entry.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified this journal entry line. Supports audit trails and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry line record was last modified. Supports audit trails and change tracking.',
    `natural_account_classification` STRING COMMENT 'The natural classification of the expense by type of expenditure (e.g., salaries, benefits, travel, supplies). Complements functional expense reporting per FASB ASC 958. [ENUM-REF-CANDIDATE: salary|benefits|travel|supplies|equipment|occupancy|professional_services — 7 candidates stripped; promote to reference product]',
    `payment_reference` STRING COMMENT 'The payment reference or check number associated with this line item for accounts payable or accounts receivable transactions. Supports cash reconciliation.. Valid values are `^[A-Z0-9-]{1,30}$`',
    `posting_date` DATE COMMENT 'The date on which this journal entry line was posted to the general ledger. Used for period-end closing and financial reporting cutoff.',
    `profit_center_code` STRING COMMENT 'The profit center or revenue-generating unit associated with this line item. Used for revenue attribution and financial performance analysis by business unit.. Valid values are `^[A-Z0-9]{2,10}$`',
    `program_code` STRING COMMENT 'The program or project code to which this line item is allocated. Supports program-level financial tracking and Results-Based Management (RBM) reporting.. Valid values are `^[A-Z0-9]{2,15}$`',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator of whether this line item is a reversal or correction of a previous journal entry line. Used for audit trails and error correction tracking.',
    `source_document_reference` STRING COMMENT 'Reference to the source document or transaction that generated this journal entry line (e.g., invoice ID, payroll batch ID, grant disbursement ID). Supports audit trails.',
    `source_system_code` STRING COMMENT 'Identifier of the source system or module from which this journal entry line originated (e.g., AP, AR, Payroll, Grant Management). Supports data lineage and reconciliation.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `tax_code` STRING COMMENT 'Tax code or VAT code applicable to this line item. Used for tax compliance, reporting, and recovery in jurisdictions where the nonprofit operates.. Valid values are `^[A-Z0-9]{1,10}$`',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this journal entry line. Supports audit trails and data lineage.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit or credit line item within a GL journal entry. Captures line number, GL account, cost center, fund, grant reference, program code, debit or credit amount, functional expense category, natural account classification, tax code, profit center, and narrative description. Enables granular fund accounting, cost allocation, and grant financial reporting at the transaction line level per FASB ASC 958 and OMB Uniform Guidance.';

CREATE OR REPLACE TABLE `ngo_ecm`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Budgets must include costs for compliance obligations (audit fees, external review costs, certification expenses). Budget planning requires identifying applicable obligations to ensure adequate fundin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budgets are allocated to cost centers for budget vs. actual tracking. This FK enables joining to get cost center hierarchy, manager, and program area.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Country office budgets are standard. Finance needs to track budgets by country office for country-level financial management and HQ consolidation.',
    `constituent_id` BIGINT COMMENT 'Foreign key reference to the donor or funding organization that provided the resources for this budget. Essential for donor-specific financial reporting and stewardship.',
    `donor_fund_id` BIGINT COMMENT 'Foreign key reference to the fund associated with this budget. Links the budget to the fund accounting structure for restricted and unrestricted fund tracking per FASB ASC 958.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: budget has fiscal_year (STRING) as a scalar but no fiscal_period_id FK. Budget records must be anchored to specific fiscal periods for BvA tracking and period-end reporting. Adding fiscal_period_id li',
    `award_id` BIGINT COMMENT 'Foreign key reference to the grant award record if this is a grant-type budget. Links the budget to the specific donor award for compliance tracking and financial reporting.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: NGO budgets are owned and managed by org units; FK enables organizational budget reporting, accountability assignment, and supports consolidated financial planning across the org hierarchy — essential',
    `approval_date` DATE COMMENT 'The date when this budget was formally approved by the designated authority (e.g., Finance Director, Board of Directors, donor). Marks the transition from draft to approved status.',
    `approved_modifications_count` STRING COMMENT 'The number of formal modifications or amendments that have been approved for this budget since initial approval. Tracks budget revision history and compliance with donor prior-approval requirements.',
    `approving_authority` STRING COMMENT 'The name or title of the individual or body that approved this budget (e.g., Chief Financial Officer, Executive Director, Board of Directors, Donor Program Officer).',
    `award_ceiling_amount` DECIMAL(18,2) COMMENT 'The maximum allowable expenditure under the grant award, including all approved modifications. For grant-type budgets, this represents the donors total funding commitment and cannot be exceeded without prior approval.',
    `budget_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying this budget in financial systems and donor reports. Used as the business identifier for budget tracking and reference.. Valid values are `^[A-Z0-9]{6,20}$`',
    `budget_name` STRING COMMENT 'Descriptive name of the budget, typically including program or grant reference for easy identification by finance and program staff.',
    `budget_status` STRING COMMENT 'Current lifecycle state of the budget. Draft indicates initial preparation; submitted means under review; approved indicates formal authorization; revised indicates modifications post-approval; active indicates currently in use; closed indicates budget period ended; cancelled indicates budget was terminated before completion. [ENUM-REF-CANDIDATE: draft|submitted|approved|revised|active|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the budget by its purpose and funding nature. Operational budgets support ongoing organizational activities; project budgets are tied to specific initiatives; grant budgets are donor-funded and compliance-driven; capital budgets fund long-term assets; restricted budgets have donor-imposed limitations; unrestricted budgets have no donor restrictions.. Valid values are `operational|project|grant|capital|restricted|unrestricted`',
    `burn_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total approved budget that has been expended to date. Calculated as (total_actual_expenditure / total_approved_amount) * 100. Used to monitor spending pace and forecast budget depletion.',
    `compliance_notes` STRING COMMENT 'Free-text field capturing special compliance requirements, donor conditions, or restrictions specific to this budget (e.g., procurement rules, allowable cost categories, geographic restrictions). Used by finance and program staff to ensure adherence to donor terms.',
    `cost_share_requirement_amount` DECIMAL(18,2) COMMENT 'The amount of cost-sharing or matching funds required by the donor as a condition of the grant. Represents the organizations commitment to contribute resources beyond the donor award.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amounts (e.g., USD, EUR, GBP). Essential for multi-currency grant management and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `direct_cost_budget` DECIMAL(18,2) COMMENT 'The portion of the total budget allocated to direct costs that can be specifically attributed to program activities, such as salaries, supplies, and travel directly supporting the program or grant.',
    `donor_reporting_frequency` STRING COMMENT 'The frequency at which financial reports must be submitted to the donor for this budget. Drives the cadence of Budget vs. Actual (BvA) reporting and compliance monitoring.. Valid values are `monthly|quarterly|semi-annually|annually|upon_request`',
    `icr_rate_applied` DECIMAL(18,2) COMMENT 'The indirect cost rate percentage applied to calculate the indirect cost budget. Expressed as a percentage (e.g., 15.00 for 15%). May be based on NICRA or donor-imposed rate caps.',
    `indirect_cost_budget` DECIMAL(18,2) COMMENT 'The portion of the total budget allocated to indirect costs (overhead, facilities, administration) that support the organization but cannot be directly attributed to a single program or grant. Calculated using the Indirect Cost Rate (ICR).',
    `last_modification_date` DATE COMMENT 'The date of the most recent approved modification to this budget. Used to track budget revision history and ensure compliance with donor reporting timelines.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `owner` STRING COMMENT 'The name or identifier of the individual responsible for managing and monitoring this budget (e.g., Program Manager, Finance Manager). Accountable for budget performance and variance management.',
    `period_end_date` DATE COMMENT 'The date when this budget period ends. For grant budgets, this aligns with the award period end date. Used to calculate burn rate and remaining budget availability.',
    `period_start_date` DATE COMMENT 'The date when this budget period begins. For grant budgets, this aligns with the award period start date. Critical for Budget vs. Actual (BvA) tracking and compliance reporting.',
    `prior_approval_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which budget modifications or reallocations require prior written approval from the donor. Varies by donor and grant terms (e.g., USAID, DFID, UN agencies).',
    `program_code` STRING COMMENT 'The program or project code associated with this budget. Links the budget to specific programmatic activities for Monitoring, Evaluation, and Learning (MEL) and Results-Based Management (RBM) reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `total_actual_expenditure` DECIMAL(18,2) COMMENT 'The cumulative actual expenditure recorded against this budget to date. Used in Budget vs. Actual (BvA) variance analysis and burn rate calculations.',
    `total_approved_amount` DECIMAL(18,2) COMMENT 'The total approved budget amount for this budget period, including both direct and indirect costs. Represents the authorized spending ceiling.',
    `total_variance_amount` DECIMAL(18,2) COMMENT 'The difference between the total approved budget amount and the total actual expenditure. Positive variance indicates under-spending; negative variance indicates over-spending. Key metric for Budget vs. Actual (BvA) reporting.',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Master budget record for an approved financial plan associated with a grant, program, cost center, or organizational unit. Captures budget code, budget name, budget type (operational, project, grant, capital), fiscal year, total approved amount, currency, budget status (draft, approved, revised, closed), approval date, approving authority, associated fund or grant reference, donor reference, direct cost budget, indirect cost budget, ICR rate applied, NICRA rate reference, budget period start and end dates, approved modifications, cost-share requirement amount, and BvA summary metrics (total actual expenditure, total variance, burn rate). For grant-type budgets, carries grant-specific compliance attributes per OMB 2 CFR 200 and donor requirements (USAID, DFID, UN) including award ceiling, cost-share obligations, and prior approval thresholds. The single SSOT for all approved budget baselines — operational, programmatic, and grant-specific — used in Budget vs. Actual tracking and donor financial reporting.';

CREATE OR REPLACE TABLE `ngo_ecm`.`finance`.`budget_line` (
    `budget_line_id` BIGINT COMMENT 'Unique identifier for the budget line item. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the grant award this budget line belongs to. Links budget line to the parent grant award for financial tracking and compliance.',
    `budget_id` BIGINT COMMENT 'Reference to the parent budget document or budget version that contains this line item. Enables tracking of budget revisions and amendments.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to supply.commodity. Business justification: NGO grant budget lines are frequently commodity-specific (e.g., Therapeutic food - RUTF, Shelter kits). Linking budget lines to commodity master enables budget vs. actual commodity cost tracking a',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget lines are allocated to cost centers for expense tracking and reporting. The cost_center_code string should be replaced with a proper FK to cost_center. This enables joining to get cost center h',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Budget lines must map to specific donor compliance requirements (allowable cost categories, cost-sharing mandates, prior approval thresholds). Grant managers verify budget line compliance against dono',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Budget lines are allocated to specific funds (restricted or unrestricted). The fund_code string should be replaced with FK to finance_fund to enable joining for fund restriction type, donor, and balan',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: budget_line has budget_period_type (STRING) but no fiscal_period_id FK. Budget lines must be anchored to specific fiscal periods for period-specific BvA analysis and grant financial reporting. Adding ',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Budget lines can be site-specific (site operating budget, site setup budget). Finance needs site-level budget detail for planning, tracking, and site cost management.',
    `activity_code` STRING COMMENT 'Specific program activity or intervention this budget line funds. Supports Logical Framework (LogFrame) and Theory of Change (ToC) budget alignment.. Valid values are `^[A-Z0-9]{2,20}$`',
    `allocation_method` STRING COMMENT 'Method used to allocate shared or indirect costs to this budget line. Ensures transparent and auditable cost allocation per OMB Uniform Guidance.. Valid values are `direct|fte|square_footage|headcount|usage|other`',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total cost allocated to this budget line when using proportional allocation methods. Expressed as a decimal (e.g., 0.2500 for 25%).',
    `approval_date` DATE COMMENT 'Date when this budget line was formally approved by the authorized budget authority or donor. Establishes the baseline for BvA tracking.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or role who approved this budget line. Supports audit trail and accountability.',
    `budget_line_status` STRING COMMENT 'Current lifecycle status of the budget line. Tracks approval workflow and budget lock-down for financial control.. Valid values are `draft|submitted|approved|revised|frozen|closed`',
    `budget_narrative` STRING COMMENT 'Detailed justification and description of the budget line item. Explains the purpose, calculation basis, and alignment with program activities. Required for donor budget submissions.',
    `budget_period_type` STRING COMMENT 'Granularity of the budget period for this line item. Determines reporting frequency and BvA tracking intervals.. Valid values are `monthly|quarterly|annual|project_life`',
    `cost_share_source` STRING COMMENT 'Source of cost-sharing contribution for this budget line. Distinguishes between organizational funds, third-party contributions, in-kind, or cash match.. Valid values are `organizational|third_party|in_kind|cash`',
    `cost_type` STRING COMMENT 'Classification of cost as direct (attributable to a single program), indirect (Facilities and Administration / F&A), or shared (allocated across multiple programs). Critical for NICRA compliance.. Valid values are `direct|indirect|shared`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget line record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for budget amounts. Essential for multi-currency grant management and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `donor_budget_category` STRING COMMENT 'Donor-specific budget category or line item code as required by the funding source. Maps internal budget structure to donor reporting templates.',
    `expense_category` STRING COMMENT 'High-level classification of the budget line expenditure type. Aligns with OMB Uniform Guidance cost categories and donor budget templates. [ENUM-REF-CANDIDATE: personnel|travel|equipment|supplies|contractual|other_direct|indirect — 7 candidates stripped; promote to reference product]',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Negotiated Indirect Cost Rate Agreement (NICRA) percentage applied to this budget line if it is an indirect cost. Expressed as a decimal (e.g., 0.1500 for 15%).',
    `is_allowable` BOOLEAN COMMENT 'Indicates whether this budget line represents an allowable cost under the grant terms and OMB Uniform Guidance. Used for compliance validation.',
    `is_cost_share` BOOLEAN COMMENT 'Indicates whether this budget line represents a cost-sharing or matching contribution required by the donor. Critical for grant compliance tracking.',
    `line_number` STRING COMMENT 'Sequential or hierarchical line number within the budget document. Used for ordering and referencing specific budget lines in donor reports and financial statements.. Valid values are `^[A-Z0-9]{1,20}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget line record was last modified. Tracks data currency and change history.',
    `notes` STRING COMMENT 'Additional comments, assumptions, or clarifications related to this budget line. Provides supplementary context for budget reviewers and auditors.',
    `original_amount` DECIMAL(18,2) COMMENT 'Initial planned expenditure or revenue amount for this budget line as approved in the original budget submission. Baseline for tracking budget changes.',
    `program_code` STRING COMMENT 'Program or project code this budget line supports. Enables program-level budget tracking and Results-Based Management (RBM) reporting.. Valid values are `^[A-Z0-9]{2,20}$`',
    `quantity` DECIMAL(18,2) COMMENT 'Number of units planned for this budget line. Used in conjunction with unit cost to calculate total budget amount.',
    `revised_amount` DECIMAL(18,2) COMMENT 'Current approved budget amount after amendments, reallocations, or donor-approved modifications. Used for current-period BvA tracking.',
    `revision_number` STRING COMMENT 'Sequential version number tracking amendments and modifications to this budget line. Enables budget change history and audit compliance.',
    `revision_reason` STRING COMMENT 'Explanation for the most recent revision to this budget line. Documents the business justification for budget amendments.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit for this budget line. Multiplied by quantity to derive the total budget amount. Supports transparent budget calculation.',
    `unit_description` STRING COMMENT 'Description of the unit of measure for this budget line (e.g., staff month, trip, item, training session). Provides context for quantity-based budget calculations.',
    CONSTRAINT pk_budget_line PRIMARY KEY(`budget_line_id`)
) COMMENT 'Individual line item within an approved budget, representing the planned expenditure or revenue for a specific GL account, cost center, fund, program activity, or period. Captures budget line number, GL account, cost center, fund, program code, budget period (monthly, quarterly, annual), planned amount, revised amount, budget narrative, and expense category. Enables granular BvA tracking, grant financial management, and donor budget reporting at the line level.';

CREATE OR REPLACE TABLE `ngo_ecm`.`finance`.`payable` (
    `payable_id` BIGINT COMMENT 'Primary key for payable',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: NGO Uniform Guidance audits flag specific payables as questioned costs. Linking payable to audit_finding enables finance staff to track which invoices are under audit scrutiny, supports corrective act',
    `award_id` BIGINT COMMENT 'Reference to the grant or award against which this payable is charged. Critical for restricted fund tracking and grant financial management.',
    `bank_account_id` BIGINT COMMENT 'Reference to the organizations bank account from which payment was disbursed. Used for cash management and bank reconciliation.',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: payable has no budget_line_id FK. AP invoices in nonprofit organizations must be charged against specific budget lines for BvA tracking and donor reporting. Adding budget_line_id links each payable to',
    `cost_center_id` BIGINT COMMENT 'Reference to the organizational cost center responsible for this expenditure. Used for budget control and cost allocation.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Payables are processed at country office level. Finance needs to track payables by country office for country-level AP management and cash flow planning.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Finance tracks which staff member created each payable invoice for accountability and audit trail in accounts payable processing.',
    `distribution_event_id` BIGINT COMMENT 'Foreign key linking to field.distribution_event. Business justification: Vendor invoices for distribution supplies/services link to specific distributions. Finance needs this for distribution cost tracking, audit trail, and distribution cost analysis.',
    `field_deployment_id` BIGINT COMMENT 'Foreign key linking to field.field_deployment. Business justification: Deployment invoices (travel, accommodation, per diem) are payables tied to specific field deployments. Linking payable to field_deployment enables deployment cost tracking and budget vs. actuals for e',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: payable has is_restricted_fund (BOOLEAN) flag but no finance_fund_id FK. In nonprofit fund accounting, every AP invoice must be charged to a specific fund (restricted or unrestricted) for FASB ASC 958',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Payables are posted to fiscal periods for accounts payable aging, accrual accounting, and financial statement preparation. The existing fiscal_year (INT) and fiscal_period (INT) columns are denormaliz',
    `gl_account_id` BIGINT COMMENT 'Reference to the general ledger account code in the Chart of Accounts (CoA) where this payable expense is recorded.',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document confirming delivery of goods or services. Used in three-way match process. Null if goods receipt not applicable.',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: payable has is_grant_eligible (BOOLEAN) flag but no grant_budget_id FK. AP invoices charged to grants must reference the specific grant budget for expenditure tracking, prior approval threshold enforc',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: payable has clearing_document_number (STRING) as a scalar reference but no journal_entry_id FK. Every AP invoice posting creates a journal entry in the GL (debit expense, credit AP liability). Adding ',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Vendor invoices often relate to specific sites (site supplies, site services). Finance needs to track payables by site for site cost management and budget tracking.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the originating purchase order for three-way match validation (PO, goods receipt, invoice). Null for non-PO invoices.',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: Vendor payments require sanctions screening before disbursement per OFAC/UN sanctions compliance. Treasury operations link each payable to screening result to document compliance and prevent prohibite',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to supply.shipment. Business justification: Freight forwarder and customs broker invoices (payables) reference specific shipments in NGO logistics. Linking payables to shipments enables freight cost reconciliation per shipment and supports duty',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Payables are issued to subrecipients against specific subawards for disbursement processing. Finance tracks which subaward each payable belongs to for disbursement monitoring, FFATA reporting, subawar',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier from whom goods or services were procured. Links to the vendor master data.',
    `waybill_id` BIGINT COMMENT 'Foreign key linking to supply.waybill. Business justification: Transport invoices (payables) are matched to waybills in NGO logistics finance — a 3-way match process (PO, waybill, invoice) for freight payments. Direct FK from payable to waybill enables transport ',
    `approval_status` STRING COMMENT 'Current approval workflow status. Invoices must be approved before payment per internal controls and segregation of duties requirements.. Valid values are `pending|approved|rejected|escalated`',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the invoice for payment. Required for audit trail and accountability per OMB Uniform Guidance.',
    `approved_date` DATE COMMENT 'Date the invoice was approved for payment. Used for workflow tracking and compliance reporting. Format: yyyy-MM-dd.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payable invoice record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early payment discount or negotiated discount amount applied to the invoice. Reduces the net payable amount. In invoice currency.',
    `dispute_date` DATE COMMENT 'Date the invoice was flagged as disputed. Used for vendor relationship management and dispute resolution tracking. Format: yyyy-MM-dd.',
    `dispute_reason` STRING COMMENT 'Reason code or description if the invoice is disputed (e.g., pricing discrepancy, quantity mismatch, quality issue). Null if not disputed.',
    `due_date` DATE COMMENT 'Date by which payment is due per the payment terms. Used for cash flow planning and to avoid late payment penalties. Format: yyyy-MM-dd.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert invoice currency to the organizations functional currency (typically USD for US-based nonprofits). Rate at invoice date or payment date per accounting policy.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Invoice net amount converted to the organizations functional currency using the exchange rate. Used for general ledger posting and financial reporting.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Negotiated Indirect Cost Rate Agreement (NICRA) rate applied to this expenditure for Facilities and Administration (F&A) cost allocation. Critical for federal grant compliance.',
    `invoice_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, EUR, GBP). Required for multi-currency operations and exchange rate tracking.. Valid values are `^[A-Z]{3}$`',
    `invoice_date` DATE COMMENT 'Date the vendor issued the invoice. Used to calculate payment terms and aging. Format: yyyy-MM-dd.',
    `invoice_description` STRING COMMENT 'Free-text description of the goods or services covered by this invoice. Provides business context for the expenditure.',
    `invoice_gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before taxes and adjustments. Base amount for goods or services procured, in invoice currency.',
    `invoice_net_amount` DECIMAL(18,2) COMMENT 'Net payable amount after applying taxes, withholding tax, and discounts. This is the amount to be paid to the vendor. In invoice currency.',
    `invoice_number` STRING COMMENT 'Vendor-provided invoice number. Business identifier for the payable transaction. Must be unique per vendor for audit trail and reconciliation.',
    `invoice_received_date` DATE COMMENT 'Date the invoice was received by the organization. Used for processing time tracking and internal controls. Format: yyyy-MM-dd.',
    `is_grant_eligible` BOOLEAN COMMENT 'Flag indicating whether this expenditure is allowable and allocable to the associated grant per OMB Uniform Guidance cost principles. True if eligible, False if not.',
    `is_restricted_fund` BOOLEAN COMMENT 'Flag indicating whether this payable is charged to a restricted fund with donor-imposed limitations. True if restricted, False if unrestricted. Critical for FASB ASC 958 compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the payable invoice record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `payment_date` DATE COMMENT 'Actual date the payment was disbursed to the vendor. Null if payment has not yet been made. Format: yyyy-MM-dd.',
    `payment_document_number` STRING COMMENT 'System-generated payment document number or check number. Links the payable to the actual payment transaction for reconciliation and audit.',
    `payment_method` STRING COMMENT 'Method used to disburse payment to the vendor. Critical for cash management, bank reconciliation, and audit trail documentation.. Valid values are `wire_transfer|check|ach|mobile_money|credit_card|cash`',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payable invoice in the procure-to-pay process. Tracks progression from invoice receipt through payment disbursement. [ENUM-REF-CANDIDATE: open|scheduled|partially_paid|paid|disputed|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `payment_terms` STRING COMMENT 'Contractual payment terms agreed with the vendor (e.g., Net 30, Net 60, 2/10 Net 30). Determines due date calculation and early payment discount eligibility.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the invoice (VAT, sales tax, GST, etc.). In invoice currency. Used for tax reporting and compliance.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match validation comparing purchase order, goods receipt, and invoice. Matched status is required for automated payment approval per internal controls.. Valid values are `matched|unmatched|partially_matched|not_applicable|override`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of tax withheld at source per local tax regulations. Reduces the net payment to vendor. In invoice currency.',
    CONSTRAINT pk_payable PRIMARY KEY(`payable_id`)
) COMMENT 'Unified Accounts Payable (AP) record in SAP S/4HANA managing the full procure-to-pay lifecycle from invoice receipt through payment disbursement. Captures invoice number, vendor reference, invoice date, due date, payment terms, invoice currency, total amount, tax amount, withholding tax, three-way match status (PO, goods receipt, invoice), payment status (open, partially paid, paid, disputed, cancelled), payment date, payment method (wire transfer, check, ACH, mobile money), payment document number, bank account, clearing document reference, payment run ID, exchange rate, cost center, fund, and grant reference. Supports procurement-to-pay cycle, grant expenditure documentation, cash management, and financial audit compliance per OMB Uniform Guidance.';

CREATE OR REPLACE TABLE `ngo_ecm`.`finance`.`payable_payment` (
    `payable_payment_id` BIGINT COMMENT 'Unique identifier for the accounts payable payment transaction. Primary key for the payable payment record.',
    `award_id` BIGINT COMMENT 'Identifier of the grant or award that is funding this payment. Links to the grant master data for grant expenditure tracking and donor reporting compliance.',
    `bank_account_id` BIGINT COMMENT 'Identifier of the organizational bank account from which the payment is disbursed. Links to the bank account master data for cash management and reconciliation.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payments are allocated to cost centers for expense tracking. This FK enables joining to get cost center details and hierarchy for management reporting.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Payments are allocated to funds for fund accounting and donor restriction compliance. This FK enables joining to get fund restriction type and donor information.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: payable_payment has no fiscal_period_id FK. AP payment transactions must be tracked by fiscal period for cash disbursement reporting, period-end close, and OMB Uniform Guidance compliance. Adding fisc',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Payments post to GL accounts for financial reporting. This FK enables joining to get account classification and financial statement mapping.',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: payable_payment has is_grant_funded (BOOLEAN) flag but no grant_budget_id FK. Grant-funded AP payments must be tracked against specific grant budgets for expenditure reporting and OMB Uniform Guidance',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: payable_payment has clearing_document_number (STRING) as a scalar but no journal_entry_id FK. AP payment clearing creates a journal entry (debit AP liability, credit bank). Adding journal_entry_id lin',
    `payable_id` BIGINT COMMENT 'Foreign key linking to finance.payable. Business justification: Payments apply to payable invoices. This FK enables joining to get the invoice details, vendor, purchase order, and three-way match status.',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: OFAC and donor AML requirements mandate sanctions screening at the point of payment disbursement, not just invoice approval. The payable has a screening FK, but the actual payment record must also ref',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor, partner, or service provider receiving the payment. Links to the vendor master data in the procurement or partner management system.',
    `activity_code` STRING COMMENT 'The specific activity or sub-project code within the program that this payment funds. Supports detailed grant budget tracking and Results-Based Management (RBM).',
    `approval_date` DATE COMMENT 'The date on which the payment was approved by the authorized signatory or approval workflow. Part of the internal control and audit trail.',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved the payment. Used for segregation of duties and audit compliance.',
    `clearing_date` DATE COMMENT 'The date on which the payment cleared the bank and the funds were successfully transferred to the vendor. Used for cash reconciliation and liquidity management.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country where the payment was made or the vendor is located. Used for geographic reporting and compliance with country-specific regulations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment record was first created in the ERP system. Part of the audit trail for financial transactions.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The amount of early payment discount or other reduction applied to the payment. Used for cash management optimization and vendor relationship management.',
    `due_date` DATE COMMENT 'The date by which the payment is due to the vendor according to the payment terms. Used for cash flow forecasting and avoiding late payment penalties.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the payment amount to the organizational reporting currency. Used for multi-currency grant financial management and consolidation.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The payment amount converted to the organizational functional currency using the exchange rate. Used for consolidated financial reporting and budget versus actual analysis.',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 code for the organizational functional or reporting currency (e.g., USD for US-based NGOs). Used for financial consolidation and donor reporting.. Valid values are `^[A-Z]{3}$`',
    `is_grant_funded` BOOLEAN COMMENT 'Boolean flag indicating whether this payment is funded by a specific grant or donor award. Used for grant expenditure tracking and donor reporting.',
    `is_indirect_cost` BOOLEAN COMMENT 'Boolean flag indicating whether this payment represents an indirect cost (Facilities and Administration) subject to the Negotiated Indirect Cost Rate Agreement (NICRA). Used for federal grant compliance.',
    `is_restricted_fund` BOOLEAN COMMENT 'Boolean flag indicating whether this payment is charged to a restricted fund (temporarily or permanently restricted). Critical for FASB ASC 958 net asset classification.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment record was last modified or updated. Used for change tracking and audit compliance.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The final net amount disbursed to the vendor after applying discounts, withholding taxes, and other adjustments. This is the actual cash outflow.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The total gross amount of the payment in the payment currency before any adjustments or deductions. This is the principal monetary value of the disbursement.',
    `payment_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment transaction (e.g., USD, EUR, GBP). Supports multi-currency operations in international humanitarian programs.. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The date on which the payment was executed or is scheduled to be executed. This is the business event date for cash management and grant expenditure reporting.',
    `payment_description` STRING COMMENT 'A detailed description of the purpose or nature of the payment. Provides context for financial reporting, audit, and grant compliance.',
    `payment_document_number` STRING COMMENT 'The externally-known payment document number assigned by the ERP system (SAP S/4HANA or Unit4). Used for reconciliation and audit trail purposes.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to disburse funds to the vendor or partner (e.g., wire transfer, check, ACH, mobile money for field operations).. Valid values are `wire_transfer|check|ach|mobile_money|cash|credit_card`',
    `payment_reference` STRING COMMENT 'Free-text reference or memo field for additional payment details, remittance information, or special instructions. Often included in payment advice to vendors.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction in the accounts payable workflow. Tracks progression from draft through approval to final clearing or cancellation. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|in_process|cleared|cancelled|failed|reversed — 8 candidates stripped; promote to reference product]',
    `payment_terms` STRING COMMENT 'The agreed payment terms with the vendor (e.g., Net 30, Net 60, 2/10 Net 30). Used for cash flow planning and vendor relationship management.',
    `payment_type` STRING COMMENT 'Classification of the payment by its business purpose or recipient category. Distinguishes between vendor payments, partner disbursements, grant advances, staff reimbursements, and other payment types. [ENUM-REF-CANDIDATE: vendor_payment|partner_payment|grant_advance|reimbursement|petty_cash|salary|consultant_fee — 7 candidates stripped; promote to reference product]',
    `program_code` STRING COMMENT 'The program or project code that this payment supports. Used for program-level financial tracking, Monitoring Evaluation and Learning (MEL), and donor reporting.',
    `source_system` STRING COMMENT 'The name of the source ERP system from which this payment record originated (e.g., SAP S/4HANA, Unit4 ERP). Used for data lineage and integration troubleshooting.. Valid values are `SAP_S4HANA|Unit4_ERP|Dynamics365|Other`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of tax withheld from the payment as required by local tax regulations. Common for consultant fees and international vendor payments.',
    CONSTRAINT pk_payable_payment PRIMARY KEY(`payable_payment_id`)
) COMMENT 'Accounts Payable (AP) payment transaction recording the disbursement of funds to vendors, partners, or service providers from SAP S/4HANA. Captures payment document number, payment date, payment method (wire transfer, check, ACH, mobile money), bank account, payment currency, exchange rate, total payment amount, clearing document reference, fund, cost center, grant reference, and payment run ID. Supports cash management, grant expenditure reporting, and financial audit compliance.';

CREATE OR REPLACE TABLE `ngo_ecm`.`finance`.`receivable` (
    `receivable_id` BIGINT COMMENT 'Primary key for receivable',
    `award_id` BIGINT COMMENT 'Reference to the grant or award under which this receivable was generated, enabling grant drawdown tracking and fund accounting.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: receivable has bank_account_number (STRING) as a scalar but no FK to bank_account. The designated collection bank account for each receivable should reference the authoritative bank_account master rec',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: receivable has no budget_line_id FK. Grant drawdown receivables and donor billing must be tracked against specific budget lines to monitor revenue recognition against approved budget. Adding budget_li',
    `constituent_id` BIGINT COMMENT 'Reference to the donor, government agency, sub-grantee, or cost-sharing partner responsible for payment of this invoice.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Receivables are allocated to cost centers for revenue tracking and program reporting. This FK enables joining to get cost center hierarchy and program area.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Receivables (grant drawdowns, reimbursements) are processed at country office level. Finance needs to track receivables by country office for AR management and cash flow planning.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Finance tracks which staff member created each receivable invoice for accountability in revenue recognition and billing processes.',
    `donor_fund_id` BIGINT COMMENT 'Reference to the restricted or unrestricted fund to which this receivable is allocated, supporting fund accounting and donor restrictions.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: NGO receivables (donor drawdown requests, grant billings) are triggered by specific donor reporting and billing requirements. Linking receivable to donor_requirement enables compliance tracking of whe',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Emergency-specific donor receivables (CERF tranches, flash appeal drawdowns) must reference the emergency for fund accountability and donor reporting. NGO finance teams track emergency receivables sep',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: receivable has no fiscal_period_id FK. AR invoices must be tracked by fiscal period for aging analysis, period-end close, and revenue recognition reporting. Adding fiscal_period_id links each receivab',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Receivables post to GL accounts for financial reporting. This FK enables joining to get account classification and financial statement mapping.',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: receivable has no grant_budget_id FK. Grant drawdown receivables and billing invoices to government agencies must reference the specific grant budget they draw against. Adding grant_budget_id links ea',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: receivable has clearing_document_reference (STRING) as a scalar but no journal_entry_id FK. Every AR invoice posting creates a journal entry (debit AR, credit revenue). Adding journal_entry_id links t',
    `aging_days` STRING COMMENT 'Number of days the receivable has been outstanding since the invoice date, used for aging analysis and collection prioritization.',
    `allowance_for_doubtful_accounts` DECIMAL(18,2) COMMENT 'Estimated amount of this receivable that may not be collectible, supporting the contra-asset allowance account per GAAP.',
    `billing_contact_email` STRING COMMENT 'Email address of the billing contact at the payer organization for invoice delivery and payment coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'Name of the contact person at the payer organization responsible for processing and approving payment of this invoice.',
    `billing_contact_phone` STRING COMMENT 'Phone number of the billing contact at the payer organization for follow-up on payment status and dispute resolution.',
    `billing_description` STRING COMMENT 'Narrative description of the goods, services, or grant deliverables for which this invoice was issued to the payer.',
    `collection_status` STRING COMMENT 'Current status of the receivable in the collection lifecycle, tracking progress from issuance through final resolution.. Valid values are `open|partially_collected|collected|written_off|disputed|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this receivable invoice record was first created in the financial system, supporting audit trail and data lineage.',
    `deposit_confirmation_number` STRING COMMENT 'Bank-provided confirmation or transaction number for the deposit, enabling bank reconciliation and audit trail.',
    `dispute_flag` BOOLEAN COMMENT 'Indicator of whether the payer has disputed this invoice, triggering special handling and resolution processes.',
    `dispute_reason` STRING COMMENT 'Reason provided by the payer for disputing the invoice, supporting resolution and adjustment processes.',
    `dispute_resolution_date` DATE COMMENT 'Date on which the invoice dispute was resolved, allowing the receivable to return to normal collection status.',
    `due_date` DATE COMMENT 'Date by which payment is expected from the payer according to the agreed payment terms.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied when converting the invoice currency to the organizations functional currency for accounting purposes.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Invoice amount converted to the organizations functional currency using the applicable exchange rate for general ledger posting.',
    `invoice_amount` DECIMAL(18,2) COMMENT 'Total amount billed on the invoice in the invoice currency, representing the full receivable value at issuance.',
    `invoice_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the invoice was issued (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `invoice_date` DATE COMMENT 'Date on which the invoice was issued to the payer, marking the start of the payment terms period.',
    `invoice_delivery_method` STRING COMMENT 'Method by which the invoice was delivered to the payer (e.g., email, postal mail, electronic portal).. Valid values are `email|postal_mail|electronic_portal|fax|hand_delivery`',
    `invoice_number` STRING COMMENT 'Externally-known unique invoice number issued to the payer for billing and payment reference purposes.',
    `invoice_sent_date` DATE COMMENT 'Date on which the invoice was sent or delivered to the payer, establishing the start of the payment terms period.',
    `last_reminder_date` DATE COMMENT 'Date on which the most recent payment reminder or collection notice was sent to the payer.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this receivable invoice record, supporting accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this receivable invoice record was last modified, supporting audit trail and change tracking.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current unpaid balance remaining on the invoice after applying all receipts, adjustments, and write-offs.',
    `payment_terms` STRING COMMENT 'Contractual payment terms agreed with the payer, defining the number of days allowed for payment after invoice date.. Valid values are `net_15|net_30|net_45|net_60|net_90|due_on_receipt`',
    `program_code` STRING COMMENT 'Program or project code to which this receivable is allocated, enabling program-level financial reporting and grant compliance.',
    `receipt_date` DATE COMMENT 'Date on which payment was received from the payer, marking the cash receipt event for this receivable.',
    `receipt_document_number` STRING COMMENT 'Internal document number or reference assigned to the cash receipt transaction in the financial system.',
    `receipt_method` STRING COMMENT 'Method or instrument by which payment was received from the payer (e.g., wire transfer, check, ACH, online payment).. Valid values are `wire_transfer|check|ach|online_payment|credit_card|cash`',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue associated with this receivable was recognized in the general ledger per FASB ASC 958 revenue recognition principles.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount written off as uncollectible bad debt, reducing the outstanding balance and recognized as bad debt expense.',
    `write_off_date` DATE COMMENT 'Date on which the receivable was written off as uncollectible, marking the removal from active accounts receivable.',
    `write_off_reason` STRING COMMENT 'Business reason or justification for writing off the receivable, supporting audit trail and financial controls.',
    CONSTRAINT pk_receivable PRIMARY KEY(`receivable_id`)
) COMMENT 'Unified Accounts Receivable (AR) record in SAP S/4HANA managing the full donor-billing-to-collection lifecycle from invoice issuance through cash receipt. Captures invoice number, payer reference (donor, government agency, sub-grantee, cost-sharing partner), invoice date, due date, payment terms, invoice currency, total amount, outstanding balance, collection status (open, partially collected, collected, written off), receipt date, receipt method (wire transfer, check, online payment), receipt document number, bank account, clearing document reference, deposit confirmation number, exchange rate, fund, grant reference, and revenue recognition date. Supports grant drawdown tracking, donor billing, revenue recognition per FASB ASC 958, and cash flow management.';

CREATE OR REPLACE TABLE `ngo_ecm`.`finance`.`receivable_receipt` (
    `receivable_receipt_id` BIGINT COMMENT 'Unique identifier for the accounts receivable cash receipt transaction. Primary key for the receivable receipt record.',
    `award_id` BIGINT COMMENT 'Reference to the grant award or funding agreement against which this receipt is applied. Links to the grant domain award master for restricted fund tracking.',
    `bank_account_id` BIGINT COMMENT 'Reference to the organizations bank account into which the funds were deposited. Used for cash management and bank reconciliation.',
    `constituent_id` BIGINT COMMENT 'Reference to the constituent (donor, government agency, or sub-grantee) who made the payment. Links to the donor domain constituent master.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: receivable_receipt has no cost_center_id FK. Cash receipts in nonprofit fund accounting must be attributed to cost centers for program-level revenue tracking and functional expense classification. Add',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Finance tracks which staff member recorded each receipt for accountability in cash receipts and revenue recognition processes.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: receivable_receipt has restriction_type and donor_restriction_purpose (STRING) scalars but no finance_fund_id FK. Cash receipts for restricted donations and grant drawdowns must be tracked against spe',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Receivable receipts are posted to fiscal periods for revenue recognition and cash flow reporting. The existing fiscal_year (INT) and fiscal_period (INT) columns are denormalized representations that s',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: receivable_receipt has gl_posting_reference (STRING) but no gl_account_id FK. Cash receipts post to specific GL accounts (revenue recognition, deferred revenue, or AR clearing). Adding gl_account_id l',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: receivable_receipt has gl_posting_reference (STRING) as a scalar but no journal_entry_id FK. Cash receipt posting creates a journal entry (debit bank, credit AR). Adding journal_entry_id links the rec',
    `receivable_id` BIGINT COMMENT 'Foreign key linking to finance.receivable. Business justification: Receipts apply to receivable invoices. This FK enables joining to get the invoice details, constituent, and outstanding balance. No visible redundant column to remove.',
    `check_number` STRING COMMENT 'The check number if the receipt method is check. Used for tracking and reconciliation of paper-based payments.',
    `clearing_document_number` STRING COMMENT 'Reference to the clearing document in the financial system that links this receipt to the original accounts receivable invoice or pledge. Used for AR reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this receivable receipt record was first created in the system. Used for audit trails and data lineage.',
    `deposit_confirmation_number` STRING COMMENT 'Bank-provided confirmation or transaction reference number for the deposit. Used for bank reconciliation and audit verification.',
    `deposit_date` DATE COMMENT 'The date when funds were physically deposited into the bank account. Used for bank reconciliation and cash flow analysis.',
    `donor_restriction_purpose` STRING COMMENT 'Description of the donor-imposed restriction on the use of funds (e.g., specific program, geographic area, or time period). Critical for restricted fund compliance.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the receipt amount to the organizations functional currency (typically USD). Used for multi-currency grant accounting.',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The receipt amount converted to the organizations functional currency using the exchange rate. Used for consolidated financial reporting and general ledger posting.',
    `grant_drawdown_request_number` STRING COMMENT 'Reference to the grant drawdown or reimbursement request submitted to the donor or government agency. Links receipt to the originating funding request for compliance tracking.',
    `is_in_kind_conversion` BOOLEAN COMMENT 'Indicates whether this cash receipt represents the monetization or conversion of a previously recorded in-kind donation (e.g., sale of donated goods).',
    `is_matching_gift` BOOLEAN COMMENT 'Indicates whether this receipt is a matching gift from a corporate donor or foundation matching an individual donors contribution.',
    `is_refund` BOOLEAN COMMENT 'Indicates whether this receipt is a refund or return of funds previously disbursed (e.g., sub-grantee returning unused funds, vendor refund).',
    `modified_by_user` STRING COMMENT 'The username or identifier of the system user who last modified this receipt record. Used for accountability and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this receivable receipt record was last modified. Used for change tracking and audit trails.',
    `notes` STRING COMMENT 'Free-text notes or comments about the receipt, including special handling instructions, donor communications, or reconciliation issues.',
    `payer_reference` STRING COMMENT 'External reference or remittance information provided by the payer (donor, government agency, or sub-grantee) to identify the purpose of the payment.',
    `posting_date` DATE COMMENT 'The date when the receipt was posted to the general ledger. May differ from receipt_date due to batch processing or period-end adjustments.',
    `receipt_amount` DECIMAL(18,2) COMMENT 'The total amount of cash received in the receipt currency. This is the gross amount before any adjustments or allocations.',
    `receipt_channel` STRING COMMENT 'The interface or channel through which the payment was received (e.g., bank transfer, mail, online donor portal, mobile app, in-person at field office).. Valid values are `bank_transfer|mail|online_portal|mobile_app|in_person|third_party_processor`',
    `receipt_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the payment was received (e.g., USD, EUR, GBP). Critical for multi-currency grant management.. Valid values are `^[A-Z]{3}$`',
    `receipt_date` DATE COMMENT 'The business date when the cash receipt was received or deposited. This is the principal business event timestamp for revenue recognition and cash flow reporting.',
    `receipt_document_number` STRING COMMENT 'The externally-known unique document number assigned to this cash receipt in the financial system (SAP S/4HANA or Unit4 ERP). Used for audit trails and reconciliation.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `receipt_method` STRING COMMENT 'The payment instrument or mechanism used to remit funds (e.g., wire transfer, ACH, check, credit card, online payment platform). [ENUM-REF-CANDIDATE: wire_transfer|ach|check|credit_card|debit_card|online_payment|mobile_payment|cash — 8 candidates stripped; promote to reference product]',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the cash receipt in the accounts receivable workflow. Tracks progression from initial entry through final reconciliation.. Valid values are `draft|posted|cleared|reversed|voided|reconciled`',
    `reconciliation_date` DATE COMMENT 'The date when this receipt was successfully reconciled with the bank statement. Used for cash management and audit compliance.',
    `reconciliation_status` STRING COMMENT 'Status of bank reconciliation for this receipt. Tracks whether the receipt has been matched to the bank statement and any discrepancies resolved.. Valid values are `pending|reconciled|discrepancy|under_review`',
    `restriction_type` STRING COMMENT 'The net asset classification of the receipt under FASB ASC 958: unrestricted, temporarily restricted (time or purpose), or permanently restricted (endowment).. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `revenue_recognition_date` DATE COMMENT 'The date when revenue is recognized for this receipt under FASB ASC 958 revenue recognition rules. May differ from receipt_date for conditional grants or pledges.',
    `wire_transfer_reference` STRING COMMENT 'Bank wire transfer reference number or SWIFT message identifier for electronic fund transfers. Used for high-value grant drawdowns and major gifts.',
    CONSTRAINT pk_receivable_receipt PRIMARY KEY(`receivable_receipt_id`)
) COMMENT 'Accounts Receivable (AR) cash receipt recording the collection of funds from donors, government agencies, or sub-grantees in SAP S/4HANA. Captures receipt document number, receipt date, payer reference, receipt method (wire transfer, check, online payment), bank account, receipt currency, exchange rate, amount received, clearing document reference, fund, grant reference, and deposit confirmation number. Supports grant drawdown reconciliation, donor payment tracking, and cash flow management.';

CREATE OR REPLACE TABLE `ngo_ecm`.`finance`.`grant_budget` (
    `grant_budget_id` BIGINT COMMENT 'Unique identifier for the grant budget record. Primary key for the grant budget entity in Unit4 ERP.',
    `award_id` BIGINT COMMENT 'Reference to the parent grant award for which this budget was approved. Links to the grant award master record.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: grant_budget is a grant-specific budget master in Unit4 ERP while budget is the general budget master. A grant_budget should reference its corresponding general budget record to enable consolidated Bv',
    `staff_member_id` BIGINT COMMENT 'FK to workforce.staff_member',
    `constituent_id` BIGINT COMMENT 'Reference to the donor organization providing the grant funding. Links to the donor constituent master record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: grant_budget has no cost_center_id FK. Grant budgets in nonprofit organizations are managed through cost centers for overhead allocation and NICRA rate application. Adding cost_center_id links the gra',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Grant budgets are managed at country office level. Finance needs to track grant budgets by country office for country-level grant management and reporting.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Grant budgets must satisfy donor-specific compliance requirements (budget format, cost categories, indirect cost limitations). Award managers link budgets to requirements for compliance verification d',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Grant budgets are frequently created specifically for emergency responses (CERF, ECHO emergency grants). Linking grant_budget to emergency enables emergency-specific grant financial management and don',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Grant budgets are allocated to funds for fund accounting. This FK enables joining to get fund restriction type, donor, and balance information.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: grant_budget has budget_period_start_date and budget_period_end_date as scalar dates but no fiscal_period_id FK. Grant budgets must be aligned to fiscal periods for OMB Uniform Guidance reporting and ',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that this grant budget supports. Links to the program master record for Monitoring Evaluation and Learning (MEL) tracking.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Grant budgets are administered by specific org units (country offices, program units); FK enables org-level grant portfolio reporting and supports donor requirements for organizational accountability ',
    `approved_modification_count` STRING COMMENT 'Number of approved budget modifications or amendments made since the original budget approval. Tracks budget revision history.',
    `budget_approval_date` DATE COMMENT 'Date when the grant budget was officially approved by the donor and became effective for expenditure authorization.',
    `budget_category` STRING COMMENT 'Classification of the budget by funding purpose and restriction type. Aligns with FASB ASC 958 net asset classification requirements.. Valid values are `program|project|core|emergency|restricted|unrestricted`',
    `budget_closeout_date` DATE COMMENT 'Date when the grant budget was officially closed out after all financial reporting and reconciliation requirements were completed.',
    `budget_narrative` STRING COMMENT 'Detailed narrative justification and explanation of the budget line items, cost assumptions, and allocation methodology submitted to the donor.',
    `budget_notes` STRING COMMENT 'Additional notes, comments, or special instructions related to budget management, donor restrictions, or compliance requirements.',
    `budget_period_end_date` DATE COMMENT 'End date of the budget period. Expenditures after this date may require prior approval or budget modification.',
    `budget_period_start_date` DATE COMMENT 'Start date of the budget period during which approved funds may be obligated and expended.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the grant budget. Tracks progression from draft through approval to active execution and eventual closure. [ENUM-REF-CANDIDATE: draft|submitted|approved|active|amended|closed|suspended — 7 candidates stripped; promote to reference product]',
    `budget_submission_date` DATE COMMENT 'Date when the grant budget was submitted to the donor for review and approval.',
    `budget_version_number` STRING COMMENT 'Version number of the budget document. Increments with each approved modification or amendment to maintain audit trail.',
    `compliance_framework` STRING COMMENT 'Primary regulatory or donor compliance framework governing this grant budget (e.g., OMB 2 CFR 200, USAID ADS, DFID Terms and Conditions, UN Financial Rules). [ENUM-REF-CANDIDATE: OMB_2_CFR_200|USAID_ADS|DFID_TC|UN_Financial_Rules|EU_FPA|Private_Foundation|Other — promote to reference product]',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Required cost-sharing or matching contribution amount that the organization must provide from non-grant sources to meet donor requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this grant budget record was first created in Unit4 ERP system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `direct_cost_budget` DECIMAL(18,2) COMMENT 'Approved budget amount allocated to direct costs that can be specifically attributed to the grant program activities (salaries, supplies, travel, equipment).',
    `donor_reference_number` STRING COMMENT 'External reference number or grant agreement number assigned by the donor organization (USAID, DFID, UN agency, private foundation).',
    `icr_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to calculate indirect costs. Expressed as a percentage of the direct cost base (e.g., 15.00 represents 15%).',
    `indirect_cost_budget` DECIMAL(18,2) COMMENT 'Approved budget amount allocated to indirect costs (Facilities and Administration or F&A costs) that support the grant but cannot be directly attributed to specific activities.',
    `is_multi_year` BOOLEAN COMMENT 'Indicates whether this budget spans multiple fiscal years (True) or is contained within a single fiscal year (False).',
    `last_modification_date` DATE COMMENT 'Date of the most recent approved budget modification or amendment.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this grant budget record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this grant budget record was last modified in Unit4 ERP system.',
    `nicra_rate` DECIMAL(18,2) COMMENT 'Federally negotiated indirect cost rate established through a Negotiated Indirect Cost Rate Agreement (NICRA) with the cognizant federal agency. May differ from the ICR rate applied if donor caps indirect costs.',
    `total_award_amount` DECIMAL(18,2) COMMENT 'Total approved funding amount for the grant award. Represents the ceiling for all expenditures under this budget.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this grant budget record.',
    CONSTRAINT pk_grant_budget PRIMARY KEY(`grant_budget_id`)
) COMMENT 'Grant-specific budget master record in Unit4 ERP representing the approved financial plan for a single grant award. Captures grant reference, donor reference, grant budget code, total award amount, direct cost budget, indirect cost budget, ICR rate applied, NICRA rate, budget period start and end dates, budget status, approved modifications, cost-share requirement amount, and currency. Distinct from the general budget entity as it carries grant-specific compliance attributes per OMB 2 CFR 200 and donor requirements (USAID, DFID, UN).';

CREATE OR REPLACE TABLE `ngo_ecm`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Unique identifier for the cost allocation transaction record. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the grant award to which this cost allocation applies. Links the allocation to specific donor funding agreements.',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: cost_allocation has no budget_line_id FK. Cost allocations in nonprofit fund accounting must be tracked against specific budget lines to enable BvA analysis at the allocation level. Adding budget_line',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Cost allocations target country offices (HQ costs allocated to countries). Finance needs to track allocations by country office for country-level cost management and full cost accounting.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Finance tracks which staff member created each cost allocation for accountability in cost allocation processes and grant compliance.',
    `distribution_order_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_order. Business justification: Distribution orders trigger cost allocations in NGO operations — distribution costs (transport, handling, staff) are allocated across funds and cost centers based on distribution order volume. Direct ',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Donor requirements govern allowable cost allocation methodologies (e.g., NICRA rates, direct vs. indirect splits). Linking cost_allocation to donor_requirement enables compliance verification that eac',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Emergency response cost allocations must reference the specific emergency for CERF/flash appeal fund management and donor accountability reporting. NGO finance teams allocate shared costs to emergenci',
    `field_team_id` BIGINT COMMENT 'Foreign key linking to field.team. Business justification: Shared costs can be allocated to specific teams. Finance needs this for team cost tracking and accurate team budget vs. actual reporting.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Cost allocations are posted to specific fiscal periods for indirect cost distribution and financial reporting. The existing fiscal_year (INT) and fiscal_period (STRING) columns are denormalized repres',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Cost allocations post to specific GL accounts. This FK enables joining to get account classification, financial statement mapping, and account hierarchy for proper financial reporting.',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: cost_allocation has no grant_budget_id FK. Cost allocations in nonprofit organizations are frequently tied to specific grant budgets for NICRA indirect cost rate application and OMB Uniform Guidance c',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project to which this cost allocation applies. Links the allocation to specific programmatic activities.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: cost_allocation has allocation_document_number (STRING) as a scalar reference but no FK to journal_entry. Every cost allocation posting creates a corresponding journal entry in the GL. Adding journal_',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Cost allocations often target specific sites (shared costs allocated to sites). Finance needs to track allocations by site for site cost management and full cost accounting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocations originate from a source cost center. This FK enables tracking which cost center is the source of allocated costs. Label prefix source_ distinguishes this from target_cost_center_id.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Cost allocations originate from a source fund. This FK enables tracking which fund is the source of allocated costs and ensures compliance with donor restrictions. Label prefix source_ distinguishes',
    `target_cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `target_finance_fund_id` BIGINT COMMENT 'FK to finance.finance_fund',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The monetary value of the cost being allocated from the source to the target. Represents the actual dollar amount distributed in this allocation transaction.',
    `allocation_basis` STRING COMMENT 'The quantitative basis or driver used to calculate the allocation distribution, such as headcount, square footage, direct costs, full-time equivalents (FTE), revenue, beneficiary count, transaction volume, or time spent. [ENUM-REF-CANDIDATE: headcount|square_footage|direct_costs|fte|revenue|beneficiary_count|transaction_volume|time_spent — 8 candidates stripped; promote to reference product]',
    `allocation_basis_quantity` DECIMAL(18,2) COMMENT 'The quantitative measure of the allocation basis used in the calculation (e.g., number of employees, square feet, total direct costs). Used in conjunction with allocation_rate to compute allocated_amount.',
    `allocation_basis_unit` STRING COMMENT 'The unit of measure for the allocation basis quantity (e.g., employees, square_feet, USD, FTE, hours).',
    `allocation_date` DATE COMMENT 'The business date on which the cost allocation was executed and recorded in the general ledger.',
    `allocation_method` STRING COMMENT 'The methodology used to distribute costs across grants, programs, or cost centers. Common methods include direct assignment, proportional distribution, NICRA-based rates, step-down allocation, activity-based costing, headcount-based, or square footage-based. [ENUM-REF-CANDIDATE: direct|proportional|nicra_based|step_down|activity_based|headcount|square_footage — 7 candidates stripped; promote to reference product]',
    `allocation_notes` STRING COMMENT 'Free-text notes or comments providing additional context, justification, or documentation for this cost allocation transaction.',
    `allocation_rate` DECIMAL(18,2) COMMENT 'The rate or percentage applied to the allocation basis to calculate the allocated amount. For NICRA-based allocations, this represents the negotiated indirect cost rate.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the cost allocation transaction: draft (being prepared), pending approval (awaiting review), approved (authorized), posted (recorded in GL), reversed (cancelled), or rejected (not approved).. Valid values are `draft|pending_approval|approved|posted|reversed|rejected`',
    `approval_date` DATE COMMENT 'The date on which this cost allocation was approved by the authorized financial manager or controller.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this cost allocation transaction.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this cost allocation to supporting documentation, audit logs, or source system transaction records for compliance and audit purposes.',
    `compliance_flag` STRING COMMENT 'Indicator of whether this cost allocation meets OMB Uniform Guidance and donor compliance requirements: compliant, non-compliant, under review, or exempt.. Valid values are `compliant|non_compliant|under_review|exempt`',
    `cost_category` STRING COMMENT 'Classification of the cost being allocated: direct program costs, indirect costs, facilities and administration (F&A), shared services, or overhead.. Valid values are `direct|indirect|facilities|administration|shared_services|overhead`',
    `cost_pool` STRING COMMENT 'The name or identifier of the cost pool from which costs are being allocated. Cost pools aggregate similar indirect costs for distribution.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocated amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `is_fa_cost` BOOLEAN COMMENT 'Boolean flag indicating whether this allocation represents Facilities and Administration (F&A) costs, also known as indirect costs, that are recoverable under federal grants.',
    `is_restricted_fund` BOOLEAN COMMENT 'Boolean flag indicating whether the target fund is a restricted fund with donor-imposed limitations on the use of resources.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost allocation record was last modified or updated in the system.',
    `posting_date` DATE COMMENT 'The date on which this cost allocation was posted to the general ledger and became part of the official financial records.',
    `reversal_date` DATE COMMENT 'The date on which this cost allocation was reversed or cancelled, if applicable. Null if the allocation has not been reversed.',
    `reversal_reason` STRING COMMENT 'Explanation for why this cost allocation was reversed or cancelled, if applicable.',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Transactional record of indirect cost and shared cost allocations distributed across grants, programs, cost centers, and funds. Captures allocation document number, allocation date, allocation method (direct, proportional, NICRA-based, step-down), source cost center, target cost center, source fund, target fund, grant reference, allocated amount, allocation basis (headcount, square footage, direct costs), allocation rate applied, fiscal period, and approval status. Supports F&A (Facilities and Administration) cost recovery and OMB Uniform Guidance compliance.';

CREATE OR REPLACE TABLE `ngo_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the bank account record. Primary key for the bank account entity.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Bank accounts are owned and operated by country offices — a fundamental NGO treasury management relationship. office_location is a denormalized representation of the country office. Linking enables co',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Finance tracks which staff member created each bank account record for accountability in bank account setup and treasury management.',
    `constituent_id` BIGINT COMMENT 'FK to donor.constituent',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Bank accounts are designated for specific funds (restricted or unrestricted). This FK enables joining to get fund restriction type, donor, and balance information.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Bank accounts map to GL accounts for financial reporting. This FK enables joining to get the GL account classification and financial statement mapping.',
    `award_id` BIGINT COMMENT 'Foreign key reference to the specific grant award associated with this bank account, if the account is dedicated to a single grant or project. Supports grant financial management and compliance reporting.',
    `statutory_registration_id` BIGINT COMMENT 'Foreign key linking to compliance.statutory_registration. Business justification: NGO field office bank accounts are opened under a specific country statutory registration (legal entity). Linking bank_account to statutory_registration supports legal entity-level financial reporting',
    `account_name` STRING COMMENT 'The official name or title of the bank account as registered with the financial institution. Typically reflects the organization name, office, or fund designation.',
    `account_number` STRING COMMENT 'The full bank account number as issued by the financial institution. May be masked for security purposes in reporting layers. Critical for payment processing, reconciliation, and fund transfers.',
    `account_number_masked` STRING COMMENT 'Partially masked version of the bank account number for display in reports and user interfaces (e.g., ****1234). Protects sensitive financial data while allowing account identification.',
    `account_status` STRING COMMENT 'Current lifecycle status of the bank account. Active accounts are operational for transactions; dormant accounts have no recent activity but remain open; closed accounts are permanently deactivated; frozen accounts are temporarily suspended due to compliance or security issues; pending activation accounts are newly opened but not yet operational.. Valid values are `active|dormant|closed|frozen|pending_activation`',
    `account_type` STRING COMMENT 'Classification of the bank account based on its operational purpose. Operating accounts support general organizational expenses; restricted accounts hold donor-restricted funds; payroll accounts are dedicated to staff compensation; project accounts are tied to specific grants or programs; donor-specific accounts are ring-fenced per donor requirements. [ENUM-REF-CANDIDATE: operating|restricted|payroll|project|donor_specific|savings|escrow|petty_cash — 8 candidates stripped; promote to reference product]',
    `available_balance` DECIMAL(18,2) COMMENT 'The available balance in the bank account, accounting for pending transactions, holds, and minimum balance requirements. Represents the actual funds available for disbursement. Denominated in the account currency.',
    `bank_branch_code` STRING COMMENT 'The unique code assigned to the bank branch by the financial institution or national banking authority. Used for domestic payment routing and reconciliation.',
    `bank_branch_name` STRING COMMENT 'The name or identifier of the specific bank branch where the account is domiciled. Supports localized banking operations and correspondence.',
    `bank_contact_email` STRING COMMENT 'The email address of the primary contact person at the financial institution for this bank account. Used for correspondence and issue resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `bank_contact_name` STRING COMMENT 'The name of the primary contact person at the financial institution for this bank account. Supports relationship management and issue resolution.',
    `bank_contact_phone` STRING COMMENT 'The phone number of the primary contact person at the financial institution for this bank account. Used for urgent inquiries and issue resolution.',
    `bank_name` STRING COMMENT 'The legal name of the financial institution where the account is held. Essential for payment routing, reconciliation, and financial reporting.',
    `closing_date` DATE COMMENT 'The date when the bank account was officially closed. Null for active or dormant accounts. Marks the end of the account lifecycle.',
    `country_code` STRING COMMENT 'The 3-letter ISO 3166-1 alpha-3 country code representing the country where the bank account is domiciled. Supports geographic reporting, compliance monitoring, and regional cash management.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The 3-letter ISO 4217 currency code representing the denomination of the bank account (e.g., USD, EUR, GBP, CHF). Critical for multi-currency cash management and foreign exchange tracking.. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'The current balance of the bank account as of the last update or reconciliation. Denominated in the account currency. Used for cash flow monitoring and liquidity management.',
    `donor_restriction_flag` BOOLEAN COMMENT 'Indicates whether this bank account holds donor-restricted funds that can only be used for specific purposes as stipulated by the donor. True if restricted; false if unrestricted. Critical for FASB ASC 958 compliance and donor stewardship.',
    `iban` STRING COMMENT 'The International Bank Account Number, a standardized international numbering system for bank accounts. Used primarily in Europe and other regions for cross-border payments. Format varies by country but always starts with 2-letter country code followed by 2 check digits.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]+$`',
    `interest_bearing_flag` BOOLEAN COMMENT 'Indicates whether this bank account earns interest on deposited funds. True if interest-bearing; false otherwise. Relevant for savings accounts and certain restricted fund accounts.',
    `interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate applied to this bank account, expressed as a decimal (e.g., 0.0250 for 2.5%). Applicable only for interest-bearing accounts. Used for interest income forecasting and financial planning.',
    `last_reconciliation_date` DATE COMMENT 'The date when the bank account was last successfully reconciled against the General Ledger (GL). Used to monitor compliance with reconciliation frequency requirements and identify overdue reconciliations.',
    `last_transaction_date` DATE COMMENT 'The date of the most recent transaction (deposit, withdrawal, or transfer) on this bank account. Used to identify dormant accounts and monitor account activity.',
    `minimum_balance_requirement` DECIMAL(18,2) COMMENT 'The minimum balance that must be maintained in this bank account to avoid fees or penalties, as stipulated by the financial institution. Denominated in the account currency.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this bank account. May include donor stipulations, operational constraints, or historical context.',
    `opening_date` DATE COMMENT 'The date when the bank account was officially opened with the financial institution. Marks the start of the account lifecycle.',
    `overdraft_limit` DECIMAL(18,2) COMMENT 'The maximum overdraft amount permitted on this bank account, if overdraft protection is enabled. Denominated in the account currency. Null if no overdraft protection exists.',
    `overdraft_protection_flag` BOOLEAN COMMENT 'Indicates whether this bank account has overdraft protection enabled. True if overdraft protection is active; false otherwise. Overdraft protection allows transactions to proceed even if the account balance is insufficient, subject to bank terms.',
    `reconciliation_frequency` STRING COMMENT 'The required frequency for reconciling this bank account against the General Ledger (GL). High-volume or high-risk accounts may require daily reconciliation; lower-activity accounts may be reconciled monthly or quarterly per internal controls policy.. Valid values are `daily|weekly|monthly|quarterly`',
    `routing_number` STRING COMMENT 'The 9-digit routing transit number (RTN) used in the United States for domestic wire transfers, ACH transactions, and check processing. Identifies the financial institution in the US banking system.. Valid values are `^[0-9]{9}$`',
    `signatory_requirement` STRING COMMENT 'The number and level of authorized signatories required to approve transactions on this bank account. Single signatory allows one authorized person; dual signatory requires two; triple requires three; board approval requires formal board resolution. Supports segregation of duties and fraud prevention.. Valid values are `single|dual|triple|board_approval`',
    `signatory_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold above which elevated signatory requirements apply. For example, transactions below this amount may require single signatory, while transactions above require dual or board approval. Denominated in the account currency.',
    `swift_code` STRING COMMENT 'The Society for Worldwide Interbank Financial Telecommunication (SWIFT) code, also known as Bank Identifier Code (BIC). An 8 or 11-character code used for international wire transfers and cross-border payments. Format: 4-letter bank code, 2-letter country code, 2-character location code, optional 3-character branch code.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was last updated in the system. Supports audit trail and change tracking.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Master record for all organizational bank accounts managed by the NGO across headquarters, regional offices, and country offices. Captures bank account number (masked), bank name, bank branch, SWIFT/BIC code, IBAN, account currency, account type (operating, restricted, payroll, project, donor-specific), country, account status (active, dormant, closed), signatory requirements and thresholds, fund association for restricted accounts, GL reconciliation account reference, and reconciliation frequency. Supports multi-currency cash management, restricted fund segregation, donor ring-fencing requirements, and financial controls across global operations.';

CREATE OR REPLACE TABLE `ngo_ecm`.`finance`.`fiscal_period` (
    `fiscal_period_id` BIGINT COMMENT 'Primary key for fiscal_period',
    `primary_prior_year_period_fiscal_period_id` BIGINT COMMENT 'Reference to the corresponding fiscal period in the prior fiscal year. Enables year-over-year comparative analysis.',
    `audit_required_flag` BOOLEAN COMMENT 'Indicates whether this fiscal period requires external audit review, typically for annual periods or grant compliance.',
    `closed_date` DATE COMMENT 'The date when the fiscal period was officially closed. Nullable if period is still open or future.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiscal period record was first created in the system.',
    `days_in_period` STRING COMMENT 'Total number of calendar days in the fiscal period. Used for prorations, accruals, and time-weighted calculations.',
    `end_date` DATE COMMENT 'The last day of the fiscal period. Defines when the period closes for financial transactions and reporting.',
    `exchange_rate_date` DATE COMMENT 'The date for which exchange rates are locked for multi-currency translation in this fiscal period. Nullable for single-currency organizations.',
    `fiscal_period_description` STRING COMMENT 'Detailed description or notes about the fiscal period, including any special considerations, adjustments, or organizational context.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this period belongs (e.g., 2024). Supports non-calendar fiscal years common in nonprofit organizations.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this fiscal period record is currently active and available for use in financial transactions and reporting.',
    `is_adjustment_period` BOOLEAN COMMENT 'Indicates whether this is a special adjustment period (typically Period 13) used for year-end closing entries and corrections.',
    `is_year_end_period` BOOLEAN COMMENT 'Indicates whether this is the final period of the fiscal year, requiring special year-end closing procedures and financial statement preparation.',
    `locked_date` DATE COMMENT 'The date when the fiscal period was permanently locked, preventing any further modifications. Nullable if not yet locked.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiscal period record was last modified. Updated whenever period status or attributes change.',
    `opened_date` DATE COMMENT 'The date when the fiscal period was officially opened for transaction posting. May differ from start_date due to administrative processes.',
    `period_code` STRING COMMENT 'Short alphanumeric code representing the fiscal period (e.g., FY24-Q1, P01-2024). Used as a business identifier for reporting and reference.',
    `period_name` STRING COMMENT 'Human-readable name of the fiscal period (e.g., January 2024, Q1 FY2024, Period 1 - FY2024).',
    `period_number` STRING COMMENT 'Sequential number of the period within the fiscal year (e.g., 1 for January, 4 for Q1, 12 for December). Used for ordering and reporting.',
    `period_status` STRING COMMENT 'Current lifecycle status of the fiscal period. Open allows transactions; closed prevents new entries but allows adjustments; locked is final and immutable; future indicates not yet active.',
    `period_type` STRING COMMENT 'Classification of the fiscal period by duration and frequency (monthly, quarterly, semi-annual, annual, or custom).',
    `quarter_number` STRING COMMENT 'The fiscal quarter number (1-4) to which this period belongs. Nullable for non-quarterly periods.',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial reporting in this period (e.g., USD, EUR, GBP). Supports multi-currency nonprofit operations.',
    `start_date` DATE COMMENT 'The first day of the fiscal period. Defines when the period becomes effective for financial transactions and reporting.',
    `working_days_in_period` STRING COMMENT 'Number of business working days in the fiscal period, excluding weekends and holidays. Used for operational metrics and staffing calculations.',
    CONSTRAINT pk_fiscal_period PRIMARY KEY(`fiscal_period_id`)
) COMMENT 'Master reference table for fiscal_period. Referenced by fiscal_period_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_parent_fund_finance_fund_id` FOREIGN KEY (`parent_fund_finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `ngo_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ngo_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_original_line_journal_entry_line_id` FOREIGN KEY (`original_line_journal_entry_line_id`) REFERENCES `ngo_ecm`.`finance`.`journal_entry_line`(`journal_entry_line_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ADD CONSTRAINT `fk_finance_budget_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `ngo_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable` ADD CONSTRAINT `fk_finance_payable_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ngo_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `ngo_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ngo_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ADD CONSTRAINT `fk_finance_payable_payment_payable_id` FOREIGN KEY (`payable_id`) REFERENCES `ngo_ecm`.`finance`.`payable`(`payable_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `ngo_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ADD CONSTRAINT `fk_finance_receivable_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ngo_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `ngo_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ngo_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ADD CONSTRAINT `fk_finance_receivable_receipt_receivable_id` FOREIGN KEY (`receivable_id`) REFERENCES `ngo_ecm`.`finance`.`receivable`(`receivable_id`);
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_budget_id` FOREIGN KEY (`budget_id`) REFERENCES `ngo_ecm`.`finance`.`budget`(`budget_id`);
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ADD CONSTRAINT `fk_finance_grant_budget_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_budget_line_id` FOREIGN KEY (`budget_line_id`) REFERENCES `ngo_ecm`.`finance`.`budget_line`(`budget_line_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_grant_budget_id` FOREIGN KEY (`grant_budget_id`) REFERENCES `ngo_ecm`.`finance`.`grant_budget`(`grant_budget_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `ngo_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_target_cost_center_id` FOREIGN KEY (`target_cost_center_id`) REFERENCES `ngo_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_target_finance_fund_id` FOREIGN KEY (`target_finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `ngo_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `ngo_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `ngo_ecm`.`finance`.`fiscal_period` ADD CONSTRAINT `fk_finance_fiscal_period_primary_prior_year_period_fiscal_period_id` FOREIGN KEY (`primary_prior_year_period_fiscal_period_id`) REFERENCES `ngo_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);

-- ========= TAGS =========
ALTER SCHEMA `ngo_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `ngo_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Identifier (ID)');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Identifier (ID)');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Managing Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `parent_fund_finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Fund Identifier (ID)');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `allowable_cost_categories` SET TAGS ('dbx_business_glossary_term' = 'Allowable Cost Categories');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `chart_of_accounts_segment` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (CoA) Segment');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `chart_of_accounts_segment` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `donor_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Frequency');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `donor_reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|upon_request|none');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `expended_amount` SET TAGS ('dbx_business_glossary_term' = 'Expended Amount');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Name');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_business_glossary_term' = 'Fund Status');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended|pending_approval');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted|board_designated|donor_restricted|project_specific');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `last_report_date` SET TAGS ('dbx_business_glossary_term' = 'Last Report Date');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Manager Name');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `match_fulfilled_amount` SET TAGS ('dbx_business_glossary_term' = 'Match Fulfilled Amount');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `match_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Match Requirement Percentage');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `next_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Report Due Date');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fund Notes');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Fund Purpose');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|donor_restricted|time_restricted|purpose_restricted|board_designated|endowment');
ALTER TABLE `ngo_ecm`.`finance`.`finance_fund` ALTER COLUMN `unallowable_cost_categories` SET TAGS ('dbx_business_glossary_term' = 'Unallowable Cost Categories');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|proportional|headcount|square_footage|activity_based|not_allocated');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'production|service|administrative|auxiliary|project|temporary');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending_activation');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'program|administrative|fundraising|general_and_administrative|mission_support|field_operations');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_expense_classification` SET TAGS ('dbx_business_glossary_term' = 'Functional Expense Classification');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_expense_classification` SET TAGS ('dbx_value_regex' = 'program_services|management_and_general|fundraising|membership_development');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `indirect_cost_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Eligible Flag');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `nicra_base_category` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Indirect Cost Rate Agreement (NICRA) Base Category');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `nicra_base_category` SET TAGS ('dbx_value_regex' = 'modified_total_direct_costs|direct_salaries_and_wages|total_direct_costs|other|not_applicable');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Notes');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `program_area` SET TAGS ('dbx_business_glossary_term' = 'Program Area');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'sap_s4hana|unit4_erp|manual_entry|data_migration');
ALTER TABLE `ngo_ecm`.`finance`.`cost_center` ALTER COLUMN `year_to_date_actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Actual Amount');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'ledger_accounts');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `account_description` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Description');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `account_owner` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Owner');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|closed');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|net_asset|revenue|expense');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `budget_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Control Flag');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `coa_structure_code` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (CoA) Structure Code');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_business_glossary_term' = 'Consolidation General Ledger (GL) Account Number');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `consolidation_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_allocation_base_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Base Flag');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `donor_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Restricted Flag');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `external_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Code');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `financial_statement_classification` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Classification');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `financial_statement_classification` SET TAGS ('dbx_value_regex' = 'balance_sheet|statement_of_activities|statement_of_functional_expenses|statement_of_cash_flows|off_balance_sheet');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `functional_expense_category` SET TAGS ('dbx_business_glossary_term' = 'Functional Expense Category');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `functional_expense_category` SET TAGS ('dbx_value_regex' = 'program|management_general|fundraising|not_applicable');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `fund_restriction_class` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Class');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `fund_restriction_class` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `grant_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Grant Eligible Flag');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (CoA) Hierarchy Level');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `indirect_cost_pool_flag` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Pool Flag');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `last_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Last Posting Date');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `natural_expense_classification` SET TAGS ('dbx_business_glossary_term' = 'Natural Expense Classification');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `normal_balance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance Indicator');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `normal_balance_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Notes');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `posting_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Eligible Flag');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `program_service_code` SET TAGS ('dbx_business_glossary_term' = 'Program Service Code');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `reconciliation_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Flag');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `sdg_alignment_code` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment Code');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_relevance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Relevance Indicator');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_relevance_indicator` SET TAGS ('dbx_value_regex' = 'taxable|non_taxable|exempt|not_applicable');
ALTER TABLE `ngo_ecm`.`finance`.`gl_account` ALTER COLUMN `unrelated_business_income_flag` SET TAGS ('dbx_business_glossary_term' = 'Unrelated Business Income (UBI) Flag');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'ledger_accounts');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `field_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Deployment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `field_team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|under_review|exception|non_compliant');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'original|reversal|accrual|allocation|reclassification|adjustment');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_description` SET TAGS ('dbx_business_glossary_term' = 'Entry Description');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `is_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Indicator');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `is_inter_company` SET TAGS ('dbx_business_glossary_term' = 'Inter-Company Indicator');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|reversed|cancelled');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|UNIT4_ERP|MANUAL|INTERFACE|OTHER');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'ledger_accounts');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `original_line_journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Original Line ID');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `allowable_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Allowable Cost Flag');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|posted');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `direct_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Cost Flag');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `donor_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Donor Restriction Type');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `donor_restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_expense_category` SET TAGS ('dbx_business_glossary_term' = 'Functional Expense Category');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_expense_category` SET TAGS ('dbx_value_regex' = 'program_services|management_and_general|fundraising');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `intercompany_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Flag');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,30}$');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `natural_account_classification` SET TAGS ('dbx_business_glossary_term' = 'Natural Account Classification');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `payment_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,30}$');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,15}$');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `ngo_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `ngo_ecm`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Constituent ID');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `donor_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Award ID');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `approved_modifications_count` SET TAGS ('dbx_business_glossary_term' = 'Approved Modifications Count');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `award_ceiling_amount` SET TAGS ('dbx_business_glossary_term' = 'Award Ceiling Amount');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'operational|project|grant|capital|restricted|unrestricted');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `burn_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Burn Rate Percentage');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `cost_share_requirement_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Requirement Amount');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `direct_cost_budget` SET TAGS ('dbx_business_glossary_term' = 'Direct Cost Budget');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `donor_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Frequency');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `donor_reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annually|annually|upon_request');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `icr_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR) Applied');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `indirect_cost_budget` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Budget');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `last_modification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modification Date');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `prior_approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Prior Approval Threshold Amount');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `total_actual_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Expenditure');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `total_approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Budget Amount');
ALTER TABLE `ngo_ecm`.`finance`.`budget` ALTER COLUMN `total_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Amount');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Code');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `activity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|fte|square_footage|headcount|usage|other');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Approval Date');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|revised|frozen|closed');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_narrative` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Narrative');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_period_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Type');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `budget_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|project_life');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_share_source` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Source');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_share_source` SET TAGS ('dbx_value_regex' = 'organizational|third_party|in_kind|cash');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `cost_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|shared');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `donor_budget_category` SET TAGS ('dbx_business_glossary_term' = 'Donor Budget Category');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `expense_category` SET TAGS ('dbx_business_glossary_term' = 'Expense Category');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `is_allowable` SET TAGS ('dbx_business_glossary_term' = 'Is Allowable Cost');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `is_cost_share` SET TAGS ('dbx_business_glossary_term' = 'Is Cost Share');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Number');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `line_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Quantity');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Revision Number');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Reason');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `ngo_ecm`.`finance`.`budget_line` ALTER COLUMN `unit_description` SET TAGS ('dbx_business_glossary_term' = 'Unit Description');
ALTER TABLE `ngo_ecm`.`finance`.`payable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`finance`.`payable` SET TAGS ('dbx_subdomain' = 'payable_receivable');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `payable_id` SET TAGS ('dbx_business_glossary_term' = 'Payable Identifier');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `field_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Field Deployment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `waybill_id` SET TAGS ('dbx_business_glossary_term' = 'Waybill Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `invoice_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `invoice_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `invoice_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Gross Amount');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `invoice_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Net Amount');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `invoice_received_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `is_grant_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Grant Eligible');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `is_restricted_fund` SET TAGS ('dbx_business_glossary_term' = 'Is Restricted Fund');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|ach|mobile_money|credit_card|cash');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partially_matched|not_applicable|override');
ALTER TABLE `ngo_ecm`.`finance`.`payable` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` SET TAGS ('dbx_subdomain' = 'payable_receivable');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `payable_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payable Payment ID');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `payable_id` SET TAGS ('dbx_business_glossary_term' = 'Payable Invoice Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Code');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Approval Date');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `is_grant_funded` SET TAGS ('dbx_business_glossary_term' = 'Is Grant Funded');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `is_indirect_cost` SET TAGS ('dbx_business_glossary_term' = 'Is Indirect Cost');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `is_restricted_fund` SET TAGS ('dbx_business_glossary_term' = 'Is Restricted Fund');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|ach|mobile_money|cash|credit_card');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|Unit4_ERP|Dynamics365|Other');
ALTER TABLE `ngo_ecm`.`finance`.`payable_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` SET TAGS ('dbx_subdomain' = 'payable_receivable');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Receivable Identifier');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `donor_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `allowance_for_doubtful_accounts` SET TAGS ('dbx_business_glossary_term' = 'Allowance for Doubtful Accounts');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Phone Number');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `billing_description` SET TAGS ('dbx_business_glossary_term' = 'Billing Description');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'open|partially_collected|collected|written_off|disputed|under_review');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `deposit_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Deposit Confirmation Number');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Total Amount');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `invoice_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `invoice_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|electronic_portal|fax|hand_delivery');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `invoice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Sent Date');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `last_reminder_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Reminder Date');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Amount');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|net_90|due_on_receipt');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Receipt Date');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `receipt_document_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Document Number');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `receipt_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Receipt Method');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `receipt_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|ach|online_payment|credit_card|cash');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `ngo_ecm`.`finance`.`receivable` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` SET TAGS ('dbx_subdomain' = 'payable_receivable');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `receivable_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Receivable Receipt ID');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent ID');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Receivable Invoice Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `deposit_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Deposit Confirmation Number');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Date');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `donor_restriction_purpose` SET TAGS ('dbx_business_glossary_term' = 'Donor Restriction Purpose');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `grant_drawdown_request_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Drawdown Request Number');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `is_in_kind_conversion` SET TAGS ('dbx_business_glossary_term' = 'Is In-Kind Conversion');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `is_matching_gift` SET TAGS ('dbx_business_glossary_term' = 'Is Matching Gift');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `is_refund` SET TAGS ('dbx_business_glossary_term' = 'Is Refund');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Receipt Notes');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `payer_reference` SET TAGS ('dbx_business_glossary_term' = 'Payer Reference');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_amount` SET TAGS ('dbx_business_glossary_term' = 'Receipt Amount');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_channel` SET TAGS ('dbx_business_glossary_term' = 'Receipt Channel');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_channel` SET TAGS ('dbx_value_regex' = 'bank_transfer|mail|online_portal|mobile_app|in_person|third_party_processor');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Receipt Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_document_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Document Number');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_method` SET TAGS ('dbx_business_glossary_term' = 'Receipt Method');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'draft|posted|cleared|reversed|voided|reconciled');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|discrepancy|under_review');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `ngo_ecm`.`finance`.`receivable_receipt` ALTER COLUMN `wire_transfer_reference` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Reference');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` SET TAGS ('dbx_subdomain' = 'budget_planning');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Identifier (ID)');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Identifier (ID)');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `approved_modification_count` SET TAGS ('dbx_business_glossary_term' = 'Approved Modification Count');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `budget_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'program|project|core|emergency|restricted|unrestricted');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `budget_closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Closeout Date');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `budget_narrative` SET TAGS ('dbx_business_glossary_term' = 'Budget Narrative');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `budget_notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `budget_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `budget_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Status');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `budget_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Submission Date');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `budget_version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Requirement Amount');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `direct_cost_budget` SET TAGS ('dbx_business_glossary_term' = 'Direct Cost Budget');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `donor_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Donor Reference Number');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `icr_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `indirect_cost_budget` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Budget');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `is_multi_year` SET TAGS ('dbx_business_glossary_term' = 'Multi-Year Budget Indicator');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `last_modification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modification Date');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `nicra_rate` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Indirect Cost Rate Agreement (NICRA) Rate');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `total_award_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Award Amount');
ALTER TABLE `ngo_ecm`.`finance`.`grant_budget` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Identifier (ID)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `distribution_order_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `field_team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Source Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Source Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `target_cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `target_finance_fund_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Quantity');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis_unit` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis Unit of Measure');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_rate` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rate');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|reversed|rejected');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|exempt');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'direct|indirect|facilities|administration|shared_services|overhead');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_pool` SET TAGS ('dbx_business_glossary_term' = 'Cost Pool');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `is_fa_cost` SET TAGS ('dbx_business_glossary_term' = 'Is Facilities and Administration (F&A) Cost');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `is_restricted_fund` SET TAGS ('dbx_business_glossary_term' = 'Is Restricted Fund');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `ngo_ecm`.`finance`.`cost_allocation` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'fund_management');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `constituent_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Award ID');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `statutory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Registration Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Masked Bank Account Number');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|dormant|closed|frozen|pending_activation');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Code');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Email');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Name');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Phone');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closing Date');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `donor_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Restriction Flag');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]+$');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_bearing_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Bearing Flag');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `minimum_balance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Requirement');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opening Date');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_limit` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Limit');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `overdraft_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdraft Protection Flag');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Signatory Requirement');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_requirement` SET TAGS ('dbx_value_regex' = 'single|dual|triple|board_approval');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Signatory Threshold Amount');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Code');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ngo_ecm`.`finance`.`bank_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ngo_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_subdomain' = 'ledger_accounts');
ALTER TABLE `ngo_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Identifier');
