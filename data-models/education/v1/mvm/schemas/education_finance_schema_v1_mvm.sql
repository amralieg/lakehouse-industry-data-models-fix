-- Schema for Domain: finance | Business: Education | Version: v1_mvm
-- Generated on: 2026-05-06 15:14:02

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`finance` COMMENT 'Manages institutional financial operations including general ledger, accounts payable, accounts receivable, budgeting, purchasing, fund accounting, cost centers, grants accounting, endowment management, and fiscal year cycles. Supports GASB/FASB compliance, NACUBO reporting, F&A cost rate calculations, and Oracle PeopleSoft Financials ERP operations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`finance`.`ledger_account` (
    `ledger_account_id` BIGINT COMMENT 'Unique identifier for the general ledger account in the institutional chart of accounts. Primary key for the ledger account master data.',
    `finance_fund_id` BIGINT COMMENT 'Reference to the fund to which this account belongs. Higher education institutions use fund accounting to segregate resources by purpose and restriction (e.g., unrestricted operating, restricted grants, endowment, plant).',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department or cost center that owns or is responsible for this account. Used for departmental budgeting and expense tracking.',
    `parent_account_ledger_account_id` BIGINT COMMENT 'Reference to the parent account in the chart of accounts hierarchy. Null for top-level accounts. Enables roll-up reporting and hierarchical financial analysis.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Chart of accounts structured to support GASB, FASB, and IPEDS reporting requirements. Controllers map accounts to regulatory reporting categories (NACUBO functional classification, IPEDS finance surve',
    `account_code` STRING COMMENT 'The externally-known unique account number used to identify this GL account across all financial transactions and reports. Typically a 4-10 digit numeric code structured to reflect account hierarchy and type.. Valid values are `^[0-9]{4,10}$`',
    `account_description` STRING COMMENT 'Extended textual description of the accounts purpose, usage guidelines, and any special handling instructions for financial staff.',
    `account_name` STRING COMMENT 'The human-readable descriptive name of the GL account used in financial reports and user interfaces.',
    `account_owner_email` STRING COMMENT 'The email address of the account owner for notifications, approvals, and budget alerts.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `account_owner_name` STRING COMMENT 'The name of the individual (typically a department head, dean, or financial manager) who is responsible for the financial activity and budget management of this account.',
    `account_status` STRING COMMENT 'Current lifecycle status of the account. Active accounts accept transactions; inactive accounts are temporarily disabled; suspended accounts are under review; closed accounts are permanently retired and appear only in historical reports.. Valid values are `active|inactive|suspended|closed`',
    `account_subtype` STRING COMMENT 'A more granular classification within the account type, such as current asset, fixed asset, current liability, long-term liability, operating revenue, non-operating revenue, personnel expense, or non-personnel expense.',
    `account_type` STRING COMMENT 'The fundamental accounting classification of the account indicating its role in the financial statements. Asset and liability accounts appear on the balance sheet; revenue and expense accounts appear on the income statement; net position represents equity for governmental entities.. Valid values are `asset|liability|net_position|revenue|expense`',
    `budget_control_flag` BOOLEAN COMMENT 'Indicates whether this account is subject to budget checking and control. When true, transactions posting to this account will be validated against available budget before posting.',
    `budget_pool_flag` BOOLEAN COMMENT 'Indicates whether this account participates in budget pooling, allowing budget to be shared across multiple accounts within a defined pool.',
    `cash_account_flag` BOOLEAN COMMENT 'Indicates whether this is a cash or cash-equivalent account used in cash flow reporting and treasury management.',
    `created_by_user` STRING COMMENT 'The system user ID or name of the person who created this ledger account record. Audit trail field for data governance and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this ledger account record was first created in the system. Audit trail field for data governance and compliance.',
    `effective_end_date` DATE COMMENT 'The date on which this account was or will be inactivated. Null for currently active accounts with no planned end date. Supports date-effective chart of accounts management.',
    `effective_start_date` DATE COMMENT 'The date on which this account became active and available for use in financial transactions. Supports date-effective chart of accounts management.',
    `encumbrance_flag` BOOLEAN COMMENT 'Indicates whether this account supports encumbrance accounting, which reserves budget for outstanding purchase orders and commitments before actual expenditure.',
    `fa_rate_eligible_flag` BOOLEAN COMMENT 'Indicates whether expenses in this account are included in the modified total direct cost (MTDC) base for calculating F&A (indirect cost) recovery on sponsored projects.',
    `fasb_classification` STRING COMMENT 'Classification code or label aligning this account with FASB reporting requirements for private institutions, including net asset classification (unrestricted, temporarily restricted, permanently restricted) and functional expense category.',
    `fiscal_year_created` STRING COMMENT 'The fiscal year in which this account was originally established in the chart of accounts, expressed as a four-digit year (e.g., 2024).. Valid values are `^[0-9]{4}$`',
    `gasb_classification` STRING COMMENT 'Classification code or label aligning this account with GASB reporting requirements for public institutions, including fund type, activity classification, and statement presentation category.',
    `grant_eligible_flag` BOOLEAN COMMENT 'Indicates whether expenses charged to this account are eligible for reimbursement under sponsored research grants and contracts. Used to enforce allowable cost policies.',
    `hierarchy_level` STRING COMMENT 'Numeric indicator of the accounts position in the chart of accounts hierarchy. Level 1 represents top-level summary accounts; higher numbers represent increasingly detailed sub-accounts.',
    `ipeds_reporting_category` STRING COMMENT 'Classification code mapping this account to IPEDS Finance Survey reporting categories for federal reporting compliance.',
    `last_modified_by_user` STRING COMMENT 'The system user ID or name of the person who most recently modified this ledger account record. Audit trail field for data governance and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this ledger account record was most recently updated. Audit trail field for data governance and compliance.',
    `last_transaction_date` DATE COMMENT 'The date of the most recent financial transaction posted to this account. Used to identify dormant accounts for cleanup and archival.',
    `nacubo_function_code` STRING COMMENT 'Two-digit code classifying the account into NACUBO functional expense categories such as instruction, research, public service, academic support, student services, institutional support, operation and maintenance of plant, scholarships and fellowships, and auxiliary enterprises.. Valid values are `^[0-9]{2}$`',
    `normal_balance` STRING COMMENT 'Indicates whether this account normally carries a debit or credit balance. Assets and expenses typically have debit balances; liabilities, net position, and revenues typically have credit balances.. Valid values are `debit|credit`',
    `reconciliation_required_flag` BOOLEAN COMMENT 'Indicates whether this account requires periodic reconciliation to external statements or subsidiary ledgers (e.g., bank accounts, investment accounts, loan accounts).',
    `statistical_account_flag` BOOLEAN COMMENT 'Indicates whether this is a statistical account used to track non-monetary units such as FTE (Full-Time Equivalent), credit hours, or square footage for operational metrics and ratio analysis.',
    CONSTRAINT pk_ledger_account PRIMARY KEY(`ledger_account_id`)
) COMMENT 'Chart of accounts master data representing all GL account codes in the institutional general ledger. Captures account number, account type (asset, liability, net position, revenue, expense), fund affiliation, NACUBO functional expense category, GASB/FASB classification, account hierarchy level, budget control flag, and active status. Serves as the SSOT for all account coding across the institution, supporting multi-dimensional chartfield accounting in Oracle PeopleSoft Financials.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`finance_fund` (
    `finance_fund_id` BIGINT COMMENT 'Unique identifier for the fund entity. Primary key for the finance fund master data table.',
    `cost_center_id` BIGINT COMMENT 'Reference to the primary cost center or organizational unit responsible for managing this fund. Links fund accounting to organizational budgeting and responsibility reporting.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Finance funds track balances and activity by fiscal period. Adding fiscal_period_id FK allows joining to fiscal_period master for period_name, period dates, status flags, and reporting attributes. Rem',
    `employee_id` BIGINT COMMENT 'FK to hr.employee',
    `parent_fund_finance_fund_id` BIGINT COMMENT 'Reference to the parent fund in a hierarchical fund structure, enabling roll-up reporting and multi-level fund organization. Null for top-level funds.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Institutional fund management policies (investment policy, spending rate policy, gift acceptance policy) govern how each fund is administered. Fund administrators reference specific policies for allow',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Restricted and federal funds are governed by specific regulatory requirements (e.g., Title IV fund restrictions, endowment spending regulations, federal award terms). Fund managers must track which re',
    `account_string_segment` STRING COMMENT 'The fund segment of the institutional chart of accounts string used in Oracle PeopleSoft Financials. Represents the fund component of the multi-segment account code (e.g., fund-department-account-program).. Valid values are `^[A-Z0-9-]{5,30}$`',
    `allow_deficit_spending` BOOLEAN COMMENT 'Boolean flag indicating whether the fund is permitted to carry a negative balance or deficit. True if deficit spending is allowed; false if the fund must maintain a positive balance.',
    `balance` DECIMAL(18,2) COMMENT 'The current fund balance representing the net assets available in the fund. Calculated as assets minus liabilities for the fund entity. Updated through the general ledger posting process.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The approved budget allocation for the fund for the current fiscal year. Represents the planned expenditure authority or revenue target.',
    `carryforward_allowed` BOOLEAN COMMENT 'Boolean flag indicating whether unspent fund balances are permitted to carry forward to the next fiscal year. True if carryforward is allowed; false if balances must be returned or reallocated at fiscal year end.',
    `closure_date` DATE COMMENT 'The date on which the fund was officially closed and removed from active use. Null for funds that remain open.',
    `compliance_requirement` STRING COMMENT 'Description of specific compliance requirements, regulations, or reporting obligations associated with the fund, such as federal grant compliance, donor restrictions, or audit requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fund record was first created in the system. Supports audit trail and data lineage tracking.',
    `encumbrance_amount` DECIMAL(18,2) COMMENT 'The total amount of outstanding encumbrances (purchase orders, contracts, commitments) charged against the fund. Represents committed but not yet expended resources.',
    `endowment_principal` DECIMAL(18,2) COMMENT 'The permanently restricted principal amount of an endowment fund that must be maintained in perpetuity. Only applicable to endowment fund types. Null for non-endowment funds.',
    `establishment_date` DATE COMMENT 'The date on which the fund was officially established and authorized for use in the institutional chart of accounts.',
    `expenditure_to_date` DECIMAL(18,2) COMMENT 'The cumulative expenditures posted to the fund for the current fiscal year to date. Includes all expense transactions recorded in the general ledger.',
    `external_reporting_required` BOOLEAN COMMENT 'Boolean flag indicating whether the fund requires external financial reporting to donors, sponsors, regulatory agencies, or other external stakeholders. True if external reporting is required; false otherwise.',
    `fund_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying the fund in the institutional chart of accounts. Used in Oracle PeopleSoft Financials and all financial transactions.. Valid values are `^[A-Z0-9]{4,12}$`',
    `fund_name` STRING COMMENT 'The full descriptive name of the fund as it appears in financial reports and institutional documentation.',
    `fund_status` STRING COMMENT 'The current lifecycle status of the fund. Active funds are operational and accept transactions; inactive funds are dormant but not closed; closed funds are permanently terminated; suspended funds are temporarily halted; pending approval funds await authorization.. Valid values are `active|inactive|closed|suspended|pending_approval`',
    `fund_type` STRING COMMENT 'The primary classification of the fund according to higher education fund accounting principles. Current unrestricted funds support general operations; current restricted funds have donor or sponsor restrictions; endowment funds are permanently invested; plant funds support capital assets; loan funds support student lending; agency funds hold assets for others.. Valid values are `current_unrestricted|current_restricted|endowment|plant|loan|agency`',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The federally negotiated indirect cost rate applied to sponsored projects and grants managed through this fund. Expressed as a decimal percentage (e.g., 0.5400 for 54%). Used to calculate facilities and administrative cost recovery.',
    `last_audit_date` DATE COMMENT 'The date of the most recent internal or external audit conducted on this fund. Used to track audit compliance and schedule future audits.',
    `net_asset_classification` STRING COMMENT 'The GASB net asset classification indicating the level of restriction on the fund resources. Unrestricted assets have no donor-imposed restrictions; temporarily restricted assets have time or purpose restrictions that will expire; permanently restricted assets must be maintained in perpetuity.. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the fund management, restrictions, or operational considerations.',
    `program_code` STRING COMMENT 'The program or functional classification code associated with the fund, used for program-based budgeting and reporting. Aligns with institutional program taxonomy.. Valid values are `^[A-Z0-9]{2,10}$`',
    `purpose_description` STRING COMMENT 'Detailed narrative describing the intended purpose and allowable uses of the fund resources, including any donor intent, programmatic focus, or operational scope.',
    `reporting_category` STRING COMMENT 'The financial statement reporting category or line item to which this fund maps for external financial reporting purposes, such as GASB or FASB statement presentation.',
    `restriction_type` STRING COMMENT 'The nature of restrictions placed on the fund resources. Donor-restricted funds have limitations imposed by external donors; sponsor-restricted funds are limited by grant or contract terms; board-designated funds have internal restrictions set by the governing board; regulatory-restricted funds are constrained by law or regulation; time-restricted funds have temporal limitations.. Valid values are `none|donor_restricted|sponsor_restricted|board_designated|regulatory_restricted|time_restricted`',
    `revenue_to_date` DECIMAL(18,2) COMMENT 'The cumulative revenue posted to the fund for the current fiscal year to date. Includes all revenue transactions recorded in the general ledger.',
    `spending_rate` DECIMAL(18,2) COMMENT 'The annual spending rate applied to endowment funds, expressed as a decimal percentage (e.g., 0.0450 for 4.5%). Determines the amount available for annual distribution from endowment earnings. Only applicable to endowment fund types.',
    `sponsoring_entity` STRING COMMENT 'The name of the external or internal entity that established or sponsors the fund, such as a donor name, foundation, government agency, or academic department.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this fund record was last modified in the system. Supports audit trail and change tracking.',
    CONSTRAINT pk_finance_fund PRIMARY KEY(`finance_fund_id`)
) COMMENT 'Fund master data representing the self-balancing accounting entities used in higher-education fund accounting. Captures fund code, fund type (current unrestricted, current restricted, endowment, plant, loan, agency), GASB net asset classification, restriction type, purpose description, sponsoring entity, fund balance, fiscal year, and compliance requirements. Supports GASB 34/35 fund-based financial reporting and NACUBO fund accounting standards.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center. Primary key for the cost center master data table. Serves as the organizational dimension in the PeopleSoft chartfield string for financial accountability and budget tracking.',
    `parent_cost_center_id` BIGINT COMMENT 'Reference to the parent cost center in the organizational hierarchy. Enables roll-up reporting from departments to colleges to divisions to institution. Null for top-level cost centers (e.g., Presidents Office, Provost).',
    `accreditation_body` STRING COMMENT 'The specialized or programmatic accreditation agency that oversees this cost centers academic programs (e.g., AACSB for business schools, ABET for engineering programs, ABA for law schools, LCME for medical schools). Used for compliance tracking and accreditation reporting. Null for non-accredited programs and administrative units.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total approved operating budget for the current fiscal year in US dollars. Includes all fund sources (general fund, restricted funds, auxiliary funds). Used for budget variance analysis, financial planning, and resource allocation decisions.',
    `cip_code` STRING COMMENT 'The six-digit CIP code that classifies the primary instructional program or academic discipline of this cost center. Format: XX.XXXX (e.g., 11.0701 for Computer Science, 52.0201 for Business Administration). Used for IPEDS reporting, program review, and academic planning. Applicable only to academic departments and programs.. Valid values are `^[0-9]{2}.[0-9]{4}$`',
    `cost_center_code` STRING COMMENT 'The business identifier code for the cost center used in financial transactions and reporting. Typically a 4-10 character alphanumeric code that appears on general ledger entries, budget documents, and financial statements. Primary organizational chartfield in PeopleSoft.. Valid values are `^[A-Z0-9]{4,10}$`',
    `cost_center_description` STRING COMMENT 'Detailed narrative description of the cost centers mission, scope of operations, and organizational purpose. Used for organizational documentation, budget justification, and institutional knowledge management.',
    `cost_center_name` STRING COMMENT 'The full descriptive name of the cost center (e.g., Department of Computer Science, Office of Financial Aid, College of Engineering Deans Office). Used for human-readable reporting and organizational identification.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active cost centers accept charges and have budget authority; inactive cost centers are temporarily disabled; pending cost centers are awaiting approval; closed cost centers are permanently retired; suspended cost centers are under review or restructuring.. Valid values are `active|inactive|pending|closed|suspended`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by organizational purpose. Academic departments deliver instruction and research; administrative units provide institutional support; research centers conduct sponsored and non-sponsored research; service units provide internal services; auxiliary enterprises are self-supporting operations; capital projects track construction and renovation.. Valid values are `academic_department|administrative_unit|research_center|service_unit|auxiliary_enterprise|capital_project`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost center record was first created in the system. Used for audit trail and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `degrees_awarded_annual` STRING COMMENT 'Total number of degrees and certificates awarded by this cost centers academic program(s) in the most recent academic year. Includes associate, bachelors, masters, doctoral, and professional degrees. Used for IPEDS completions reporting, program productivity analysis, and accreditation review. Applicable only to academic departments offering degree programs.',
    `effective_date` DATE COMMENT 'The date when this cost center became active and began accepting financial transactions. Used for historical reporting and organizational change tracking. Format: yyyy-MM-dd.',
    `faculty_fte` DECIMAL(18,2) COMMENT 'Full-time equivalent count of faculty assigned to this cost center. Includes tenured, tenure-track, and non-tenure-track instructional faculty. Used for student-faculty ratio calculations, accreditation reporting, and instructional cost analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which the annual budget amount applies. Typically a four-digit year representing the end of the fiscal period (e.g., 2024 for FY 2023-2024). Most higher education institutions use July 1 - June 30 fiscal years.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Total full-time equivalent employee count allocated to this cost center. Includes faculty, staff, and student workers converted to FTE. Used for IPEDS Human Resources reporting, CUPA-HR benchmarking, and productivity analysis. Calculated as sum of individual employee FTE assignments.',
    `functional_category` STRING COMMENT 'NACUBO functional expense classification used for IPEDS reporting and GASB/FASB compliance. Instruction includes teaching and departmental research; research includes organized research and sponsored programs; public service includes community engagement; academic support includes libraries and academic administration; student services includes admissions, registrar, and student life; institutional support includes executive management, fiscal operations, and HR; operation and maintenance includes facilities and utilities; scholarships and fellowships includes financial aid; auxiliary enterprises includes housing, dining, and bookstores. [ENUM-REF-CANDIDATE: instruction|research|public_service|academic_support|student_services|institutional_support|operation_maintenance|scholarships_fellowships|auxiliary_enterprises|hospital_services|independent_operations — 11 candidates stripped; promote to reference product]',
    `fund_source_primary` STRING COMMENT 'The primary fund source that supports this cost centers operations. General fund represents unrestricted institutional operating funds; restricted fund represents donor-restricted or externally-restricted funds; designated fund represents internally-restricted funds; auxiliary fund represents self-supporting operations; endowment fund represents endowment income; grant fund represents sponsored program funds.. Valid values are `general_fund|restricted_fund|designated_fund|auxiliary_fund|endowment_fund|grant_fund`',
    `grant_eligible_flag` BOOLEAN COMMENT 'Indicates whether this cost center is eligible to serve as the administrative home for sponsored research grants and contracts. True for research-active departments and centers; false for administrative units and non-research departments. Used for proposal routing and award setup in Kuali Research.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the organizational hierarchy tree. Level 1 represents institution-wide (President, Provost); Level 2 represents divisions (Vice Presidents); Level 3 represents colleges/schools; Level 4 represents departments; Level 5 represents sub-departments or programs. Used for roll-up reporting and organizational analysis.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The federally-negotiated indirect cost rate (also called F&A rate) applicable to sponsored programs administered by this cost center. Expressed as a percentage of modified total direct costs. Used for grant budgeting and cost recovery calculations. Null for non-research cost centers.',
    `last_review_date` DATE COMMENT 'The date when this cost centers budget, organizational structure, or performance was last formally reviewed by institutional leadership. Used for governance tracking and periodic review scheduling. Format: yyyy-MM-dd.',
    `majors_enrolled_count` STRING COMMENT 'Total number of students currently enrolled with a declared major in this cost centers academic program(s). Includes undergraduate and graduate students. Used for program size analysis, advising workload planning, and accreditation reporting. Applicable only to academic departments offering degree programs.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review of this cost centers budget, organizational structure, or performance. Used for governance planning and compliance tracking. Format: yyyy-MM-dd.',
    `notes` STRING COMMENT 'Free-form notes field for capturing additional context, special instructions, organizational changes, or administrative comments about the cost center. Used for institutional knowledge management and operational documentation.',
    `research_classification` STRING COMMENT 'Classification of the primary research activity conducted by this cost center. Basic research seeks fundamental knowledge; applied research addresses specific practical problems; development translates research into products or processes; non-research indicates no significant research activity. Used for NSF HERD survey reporting and research portfolio analysis.. Valid values are `basic_research|applied_research|development|non_research`',
    `short_name` STRING COMMENT 'Abbreviated name or acronym for the cost center used in space-constrained reports and dashboards (e.g., CS Dept, Fin Aid, COE Dean).',
    `space_square_feet` DECIMAL(18,2) COMMENT 'Total assignable square feet of space allocated to this cost center. Includes offices, classrooms, laboratories, and support spaces. Used for space utilization analysis, facilities cost allocation, and capital planning. Sourced from Archibus facilities management system.',
    `staff_fte` DECIMAL(18,2) COMMENT 'Full-time equivalent count of administrative and support staff assigned to this cost center. Includes professional staff, clerical staff, and technical staff. Used for operational efficiency analysis and CUPA-HR benchmarking.',
    `student_credit_hours_annual` DECIMAL(18,2) COMMENT 'Total student credit hours generated by this cost center in the most recent academic year. Calculated as sum of course enrollments multiplied by credit hours. Used for instructional productivity analysis, cost-per-credit-hour calculations, and resource allocation. Applicable only to academic departments offering courses.',
    `termination_date` DATE COMMENT 'The date when this cost center was closed or inactivated. Null for active cost centers. Used for historical reporting, organizational change tracking, and audit trail. Format: yyyy-MM-dd.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost center record was last modified. Used for audit trail, change tracking, and data quality monitoring. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Organizational cost center master data representing departmental and programmatic units used for financial accountability, budget tracking, and NACUBO functional expense classification. Captures cost center code, name, responsible manager, organizational hierarchy level, college/school affiliation, functional category (instruction, research, public service, academic support, student services, institutional support, O&M, scholarships), FTE allocation, and active status. Primary organizational dimension in the PeopleSoft chartfield string.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry record in the general ledger system. Primary key for the journal entry header.',
    `employee_id` BIGINT COMMENT 'The employee or user ID of the person who approved this journal entry for posting. Null if not yet approved or if approval is not required.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to facility.capital_project. Business justification: Capitalization journal entries, project cost transfers, and construction-in-progress (CIP) reclassification entries must reference the capital project for project cost ledger reporting and GASB 34 CIP',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entries can be associated with organizational cost centers for header-level tracking. Adding cost_center_id FK allows joining to cost_center master for cost_center_name, hierarchy, manager, an',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Journal entries can be associated with funds for header-level tracking. Adding fund_id FK allows joining to finance_fund master for fund_name, fund_type, net_asset_classification, and restriction attr',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Journal entries are posted to fiscal periods for accounting cycle management. Adding fiscal_period_id FK allows joining to fiscal_period master for period_name, period dates, status flags, and reporti',
    `grant_account_id` BIGINT COMMENT 'The grant or sponsored project identifier if this journal entry is associated with externally funded research or grant activity. Links to Kuali Research system.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Journal entry policies define approval hierarchies, supporting documentation requirements, and posting rules. Controllers enforce segregation of duties and materiality thresholds per institutional pol',
    `primary_journal_employee_id` BIGINT COMMENT 'The employee or user ID of the person who prepared or created this journal entry. Links to HR or user management system for accountability.',
    `primary_reversed_by_journal_journal_entry_id` BIGINT COMMENT 'The journal_entry_id of the reversing entry that reversed this journal entry. Null if this entry has not been reversed.',
    `approval_date` DATE COMMENT 'The date on which the journal entry was approved. Null if not yet approved or if approval is not required.',
    `approver_name` STRING COMMENT 'The full name of the person who approved this journal entry. Stored for reporting and audit trail purposes.',
    `budget_check_status` STRING COMMENT 'Result of the budget availability check performed when this journal entry was created. Indicates whether sufficient budget was available, check failed, was bypassed by authorized user, or was not applicable.. Valid values are `PASSED|FAILED|BYPASSED|NOT_APPLICABLE`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry record was first created in the system. Used for audit trails and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the journal entry amounts (e.g., USD for US Dollar, EUR for Euro). Supports multi-currency institutions and international research grants.. Valid values are `^[A-Z]{3}$`',
    `encumbrance_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry creates or relieves an encumbrance (True) or is a standard cash-basis entry (False). Used in commitment accounting.',
    `intercompany_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry represents an intercompany or inter-fund transaction (True) or a single-entity transaction (False). Critical for consolidation and elimination entries.',
    `journal_category` STRING COMMENT 'Fund accounting category for the journal entry: operating funds, capital funds, endowment funds, restricted funds, unrestricted funds, or agency funds. Critical for higher education fund accounting and GASB compliance.. Valid values are `OPERATING|CAPITAL|ENDOWMENT|RESTRICTED|UNRESTRICTED|AGENCY`',
    `journal_date` DATE COMMENT 'The business date on which the journal entry transaction occurred or is effective. Determines the accounting period and fiscal year assignment.',
    `journal_entry_description` STRING COMMENT 'Free-text description of the purpose and nature of this journal entry. Provides business context for the transaction.',
    `journal_number` STRING COMMENT 'Business-facing unique journal entry number assigned by Oracle PeopleSoft Financials GL module. Used for external reference and audit trails.. Valid values are `^JE[0-9]{8,12}$`',
    `journal_source` STRING COMMENT 'The originating system or module that created this journal entry. Indicates whether the entry was generated from Accounts Payable, Accounts Receivable, Payroll, manual entry, budget upload, Financial Aid, Grants Accounting, encumbrance processing, or cost allocation. [ENUM-REF-CANDIDATE: AP|AR|PAYROLL|MANUAL|BUDGET|FA|GRANTS|ENCUMBRANCE|ALLOCATION — 9 candidates stripped; promote to reference product]',
    `journal_type` STRING COMMENT 'Classification of the journal entry by its accounting purpose: standard operating entry, period-end adjusting entry, fiscal year closing entry, auto-reversing entry, recurring template entry, or statistical (non-monetary) entry.. Valid values are `STANDARD|ADJUSTING|CLOSING|REVERSING|RECURRING|STATISTICAL`',
    `last_modified_by` STRING COMMENT 'The user ID or name of the person who last modified this journal entry record. Used for accountability and audit trails.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry record was last updated or modified. Used for change tracking and audit trails.',
    `posted_date` DATE COMMENT 'The date on which the journal entry was officially posted to the general ledger and became part of the financial record. Null if not yet posted.',
    `posted_timestamp` TIMESTAMP COMMENT 'The precise date and time when the journal entry was posted to the general ledger. Used for audit trails and transaction sequencing.',
    `posting_status` STRING COMMENT 'Current lifecycle status of the journal entry in the GL posting workflow. Tracks progression from draft creation through approval and final posting to the general ledger.. Valid values are `DRAFT|PENDING_APPROVAL|APPROVED|POSTED|REJECTED|CANCELLED`',
    `preparer_name` STRING COMMENT 'The full name of the person who prepared this journal entry. Stored for reporting and audit trail purposes.',
    `program_code` STRING COMMENT 'The program or functional area code for this journal entry (e.g., instruction, research, public service, academic support). Used for functional expense reporting per GASB and IPEDS.',
    `reference_number` STRING COMMENT 'External reference number or document identifier associated with this journal entry (e.g., invoice number, grant award number, payroll batch ID). Used for cross-system reconciliation.',
    `reversal_date` DATE COMMENT 'The date on which this journal entry will automatically reverse, if it is a reversing entry. Null for non-reversing entries.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this journal entry is a reversing entry (True) or a standard entry (False). Reversing entries automatically reverse in the next accounting period.',
    `supporting_documentation_reference` STRING COMMENT 'Reference to supporting documentation for this journal entry (e.g., file path, document management system ID, URL). Required for audit compliance.',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'The sum of all credit amounts across all line items in this journal entry. Must equal total_debit_amount for a balanced entry.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'The sum of all debit amounts across all line items in this journal entry. Must equal total_credit_amount for a balanced entry.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'General ledger journal entry header record capturing all financial transactions posted to the institutional ledger. Records journal ID, journal date, accounting period, fiscal year, journal source (AP, AR, payroll, manual, budget), journal type, total debit amount, total credit amount, posting status, preparer, approver, reversal indicator, reversal date, and supporting documentation reference. Sourced from Oracle PeopleSoft Financials GL module. Core transactional record for all financial activity.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`journal_line` (
    `journal_line_id` BIGINT COMMENT 'Unique identifier for the journal line. Primary key for the journal line entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal lines are charged to organizational cost centers. Adding cost_center_id FK allows joining to cost_center master for cost_center_name, hierarchy, manager, and budget attributes. Removes redunda',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Journal lines are charged to funds (self-balancing accounting entities). Adding fund_id FK allows joining to finance_fund master for fund_name, fund_type, net_asset_classification, and restriction att',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Journal lines are posted to fiscal periods for accounting cycle management. Adding fiscal_period_id FK allows joining to fiscal_period master for period_name, period dates, status flags, and reporting',
    `journal_entry_id` BIGINT COMMENT 'Foreign key reference to the parent journal entry header. Links this line to its containing journal entry transaction.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Journal lines are posted to GL accounts. Adding ledger_account_id FK allows joining to ledger_account master for account_name, account_type, hierarchy, and classification attributes. Removes redundant',
    `employee_id` BIGINT COMMENT 'User ID of the person who approved this journal line. Null if not yet approved or approval not required.',
    `reversed_journal_line_id` BIGINT COMMENT 'Reference to the original journal line being reversed by this line. Null if this is not a reversal line.',
    `tertiary_journal_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person or system process that last modified this journal line. Supports audit trail requirements.',
    `accounting_date` DATE COMMENT 'Effective accounting date for this journal line. Determines the fiscal period to which the transaction is recorded.',
    `activity_code` STRING COMMENT 'Activity classification code for detailed sub-functional expense tracking. Supports granular financial analysis.. Valid values are `^[A-Z0-9]{2,10}$`',
    `adjustment_type` STRING COMMENT 'Classification of the journal line by adjustment purpose. Distinguishes regular transactions from corrections and period-end adjustments.. Valid values are `regular|prior_period|year_end_close|audit|reclassification|correction`',
    `approval_status` STRING COMMENT 'Workflow approval status for this journal line. Tracks whether required approvals have been obtained.. Valid values are `pending|approved|rejected|not_required`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this journal line was approved. Null if not yet approved or approval not required.',
    `budget_check_status` STRING COMMENT 'Result of budget availability checking for this line. Indicates whether sufficient budget exists for the transaction.. Valid values are `passed|failed|warning|bypassed|not_applicable`',
    `budget_period_code` STRING COMMENT 'Fiscal period or budget year to which this line is posted. Supports multi-year budgeting and fiscal year tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `chartfield_combination_valid_indicator` BOOLEAN COMMENT 'Flag indicating whether the combination of chartfields (account, fund, cost center, program, project) passes validation rules. False indicates an invalid or restricted combination.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this journal line record was first created in the system. Supports audit trail and data lineage.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Monetary credit amount for this journal line. Null or zero if this is a debit line. Must balance with debit amounts at the journal entry level.',
    `debit_amount` DECIMAL(18,2) COMMENT 'Monetary debit amount for this journal line. Null or zero if this is a credit line. Must balance with credit amounts at the journal entry level.',
    `encumbrance_indicator` BOOLEAN COMMENT 'Flag indicating whether this line represents an encumbrance (commitment of funds) rather than an actual expenditure. True for purchase orders and commitments.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate applied to convert transaction currency to functional currency. Null if currencies are the same.',
    `functional_currency_credit_amount` DECIMAL(18,2) COMMENT 'Credit amount converted to the institutions functional reporting currency. Used when transaction currency differs from base currency.',
    `functional_currency_debit_amount` DECIMAL(18,2) COMMENT 'Debit amount converted to the institutions functional reporting currency. Used when transaction currency differs from base currency.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Facilities and Administrative (F&A) indirect cost rate applied to this line for sponsored research. Expressed as a decimal (e.g., 0.5400 for 54%).',
    `intercompany_affiliate_code` STRING COMMENT 'Code identifying the affiliated entity or campus for intercompany transactions. Used in multi-campus or foundation consolidations.. Valid values are `^[A-Z0-9]{2,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this journal line record was last modified. Supports audit trail and change tracking.',
    `line_description` STRING COMMENT 'Detailed textual description of the purpose and nature of this journal line. Provides audit trail and business context.',
    `line_sequence_number` STRING COMMENT 'Sequential ordering of this line within the parent journal entry. Determines display and processing order.',
    `posted_date` DATE COMMENT 'Date when this journal line was posted to the general ledger. Null if not yet posted.',
    `posting_status` STRING COMMENT 'Current posting status of this journal line in the general ledger. Tracks the lines lifecycle from draft to final posting.. Valid values are `draft|pending|posted|error|reversed`',
    `program_code` STRING COMMENT 'Academic or administrative program code for functional expense classification. Supports GASB functional reporting requirements.. Valid values are `^[A-Z0-9]{2,10}$`',
    `project_grant_code` STRING COMMENT 'Project or grant identifier for sponsored research and restricted funds. Links to research administration and grant accounting.. Valid values are `^[A-Z0-9]{3,15}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this line is part of a reversing journal entry. True if this line reverses a prior entry.',
    `source_system_code` STRING COMMENT 'Identifier of the originating system that created this journal line (e.g., BANNER_AR, WORKDAY_PAYROLL, KUALI_RESEARCH). Supports data lineage and reconciliation.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `source_transaction_reference` STRING COMMENT 'Original transaction identifier from the source system. Enables traceability back to originating transaction.',
    `statistical_amount` DECIMAL(18,2) COMMENT 'Non-monetary statistical quantity for this line (e.g., FTE count, credit hours, square footage). Used for cost allocation and rate calculations.',
    `statistical_unit_of_measure` STRING COMMENT 'Unit of measure for the statistical amount field. Defines what the statistical quantity represents.. Valid values are `FTE|credit_hours|square_feet|headcount|enrollments|other`',
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction. Supports multi-currency accounting for international operations.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_journal_line PRIMARY KEY(`journal_line_id`)
) COMMENT 'Individual debit or credit line within a GL journal entry. Captures line sequence number, ledger account code, fund, cost center, program code, project/grant chartfield, debit amount, credit amount, line description, budget period, and statistical amount. Supports full chartfield string decomposition required for PeopleSoft Financials multi-dimensional accounting and GASB/FASB functional expense reporting.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the institutional budget record. Primary key for the budget entity.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Finance creates budgets specifically for academic programs (instructional budget, program operating budget). Program budget vs. actual reporting, accreditation financial documentation, and IPEDS progr',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to facility.capital_project. Business justification: Capital project budgets are formally approved by the board and tracked in the finance budget module. Linking budget records to capital projects enables project budget-vs-actual variance reporting, enc',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budgets are allocated to organizational cost centers. Adding cost_center_id FK allows joining to cost_center master for cost_center_name, hierarchy, manager, and other attributes. Removes redundant co',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Budgets are allocated by fund (self-balancing accounting entity). Adding fund_id FK allows joining to finance_fund master for fund_name, fund_type, net_asset_classification, and other fund attributes.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Budgets are tied to fiscal periods for accounting cycle management. Adding fiscal_period_id FK allows joining to fiscal_period master for period_name, period dates, status flags, and reporting attribu',
    `grant_account_id` BIGINT COMMENT 'Foreign key linking to finance.grant_account. Business justification: Budgets can be allocated to sponsored project/grant accounts. Adding grant_account_id FK allows joining to grant_account master for award_title, sponsoring_agency, award dates, and compliance attribut',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Budgets are allocated to specific GL accounts. Adding ledger_account_id FK allows joining to ledger_account master for account_name, account_type, hierarchy, and other account attributes. Removes redu',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Budget ownership and approval in higher-ed requires linking budgets to responsible employees for NACUBO functional reporting, budget variance analysis, and annual budget certification. manager_name/ma',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Institutional budget policies (deficit spending, budget transfer, carryforward policies) govern budget approval workflows. Budget managers reference specific institutional policies during budget prepa',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Federal and restricted budgets in higher education are governed by specific regulatory requirements (e.g., OMB Uniform Guidance §200, Title IV fund usage rules). Budget officers and auditors must trac',
    `actual_expenditure_amount` DECIMAL(18,2) COMMENT 'The cumulative actual expenditures posted against this budget to date within the fiscal year. Used for budget-to-actual variance analysis.',
    `approval_date` DATE COMMENT 'The date on which this budget was formally approved by the designated authority (e.g., board of trustees, provost, CFO). Null if not yet approved.',
    `approving_authority` STRING COMMENT 'The name or title of the individual or body that approved this budget (e.g., Board of Trustees, Chief Financial Officer, Provost, Dean). Provides accountability and audit trail.',
    `available_balance` DECIMAL(18,2) COMMENT 'The remaining budget balance available for spending, calculated as budgeted amount minus actual expenditures minus encumbrances. Key metric for budget managers.',
    `budget_category` STRING COMMENT 'High-level categorization of the budget line for reporting and analysis purposes. Personnel covers salaries and wages, fringe benefits covers employee benefits, travel covers business travel, equipment covers capital equipment, supplies covers consumables, contractual covers subcontracts and consultants, other direct covers miscellaneous direct costs, and indirect covers F&A costs. [ENUM-REF-CANDIDATE: personnel|fringe_benefits|travel|equipment|supplies|contractual|other_direct|indirect — 8 candidates stripped; promote to reference product]',
    `budget_number` STRING COMMENT 'Externally-known business identifier for the budget record, typically used in financial reports and budget communications. Human-readable reference number.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget record. Draft indicates initial development, submitted means under review, approved indicates board or authority approval, active means currently in effect, closed indicates the budget period has ended, and cancelled means the budget was withdrawn.. Valid values are `draft|submitted|approved|active|closed|cancelled`',
    `budget_type` STRING COMMENT 'Classification of the budget by its purpose and funding nature. Operating budgets cover day-to-day operations, capital budgets cover long-term assets, grant budgets track sponsored project funding, auxiliary budgets cover self-supporting units, and restricted/unrestricted indicate fund usage constraints.. Valid values are `operating|capital|grant|auxiliary|restricted|unrestricted`',
    `budgeted_amount` DECIMAL(18,2) COMMENT 'The total approved budget amount for this fund, cost center, and account combination for the fiscal year. Represents the financial plan allocation in the institutional currency.',
    `carry_forward_amount` DECIMAL(18,2) COMMENT 'The amount of unspent budget from the prior fiscal year that is carried forward into the current budget period. Common in higher education for certain fund types and grant budgets.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was first created in the source system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budgeted amount (e.g., USD for US Dollar, EUR for Euro). Most US institutions use USD.. Valid values are `^[A-Z]{3}$`',
    `encumbrance_balance` DECIMAL(18,2) COMMENT 'The total amount of outstanding purchase orders and commitments that have been encumbered against this budget but not yet expensed. Critical for budget availability calculations.',
    `fte_count` DECIMAL(18,2) COMMENT 'The number of full-time equivalent positions funded by this budget line. Used for workforce planning and IPEDS reporting. Null for non-personnel budgets.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The federally negotiated indirect cost rate (also called F&A rate) applied to grant budgets to recover institutional overhead costs. Expressed as a decimal (e.g., 0.5400 for 54%). Null for non-grant budgets.',
    `is_restricted` BOOLEAN COMMENT 'Boolean flag indicating whether this budget is subject to donor or sponsor restrictions on how funds may be used. True for restricted funds, false for unrestricted funds. Critical for GASB/FASB net asset classification.',
    `is_salary_budget` BOOLEAN COMMENT 'Boolean flag indicating whether this budget line is designated for personnel salaries and wages. Used for position control and FTE (Full-Time Equivalent) tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget record was last updated in the source system. Supports change tracking and audit trail.',
    `last_revision_date` DATE COMMENT 'The date of the most recent budget revision. Null if no revisions have been made since original approval.',
    `narrative` STRING COMMENT 'Detailed textual description and justification for the budget allocation. Explains the purpose, assumptions, and strategic rationale for the budgeted amount. Used in budget presentations and approval processes.',
    `notes` STRING COMMENT 'Additional free-form notes or comments about this budget record. Used for internal documentation, special instructions, or contextual information not captured in other fields.',
    `period_end_date` DATE COMMENT 'The end date of the budget period. Typically aligns with the end of the fiscal year (e.g., June 30 for many institutions).',
    `period_start_date` DATE COMMENT 'The start date of the budget period. Typically aligns with the beginning of the fiscal year (e.g., July 1 for many institutions).',
    `pool_code` STRING COMMENT 'Optional code identifying a budget pool or shared resource allocation from which this budget draws (e.g., central IT pool, facilities pool, strategic initiative pool).',
    `revision_number` STRING COMMENT 'Sequential number tracking the count of revisions made to this budget record. Starts at 0 for original budget, increments with each approved revision. Supports audit trail.',
    `revision_reason` STRING COMMENT 'Textual explanation for the most recent budget revision. Documents the business justification for mid-year budget adjustments (e.g., enrollment variance, grant award change, strategic reallocation).',
    `source_system` STRING COMMENT 'The name of the source system from which this budget record originated (e.g., Oracle PeopleSoft Financials, Workday Financials). Used for data lineage and reconciliation.',
    `version` STRING COMMENT 'The version status of the budget reflecting the stage in the budget development and approval cycle. Original represents the initially proposed budget, revised reflects mid-year adjustments, final is the board-approved version, working is used for planning, and proposed is submitted for approval.. Valid values are `original|revised|final|working|proposed`',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Institutional budget master record representing approved financial plans by fund, cost center, account, and fiscal year. Captures budget version (original, revised, final), budget type (operating, capital, grant), total budgeted amount, budget period, approval status, approving authority, budget narrative, carry-forward amount, and encumbrance balance. Supports annual budget development cycle, mid-year revisions, and NACUBO budget reporting. Sourced from Oracle PeopleSoft Financials Budgeting module.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record in the institutional finance system. Primary key for vendor master data.',
    `parent_vendor_finance_vendor_id` BIGINT COMMENT 'Reference to the parent vendor record if this vendor is a subsidiary or division of a larger corporate entity. Used for consolidated spend reporting and corporate relationship management.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Vendor compliance includes debarment checks (SAM.gov), OFAC sanctions screening, and 1099 reporting requirements. Procurement officers validate regulatory compliance before vendor activation. Required',
    `activation_date` DATE COMMENT 'The date on which the vendor record was activated and approved for use in procurement and accounts payable transactions.',
    `bank_account_name` STRING COMMENT 'The name on the vendors bank account for electronic payment processing. Must match the legal name or DBA name for ACH and wire transfer compliance.',
    `bank_account_number` STRING COMMENT 'The vendors bank account number for electronic payment processing via ACH or wire transfer. Highly sensitive financial information requiring restricted access controls.',
    `bank_account_type` STRING COMMENT 'The type of bank account for electronic payments: checking or savings. Required for ACH payment processing.. Valid values are `checking|savings`',
    `bank_routing_number` STRING COMMENT 'The nine-digit ABA routing number for the vendors bank account, used for ACH and wire transfer payments. Also known as routing transit number (RTN).',
    `contact_email` STRING COMMENT 'The email address of the primary contact person at the vendor organization. Used for invoice inquiries, payment notifications, and procurement communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'The name of the primary contact person at the vendor organization for accounts payable and procurement inquiries.',
    `contact_phone` STRING COMMENT 'The phone number of the primary contact person at the vendor organization.',
    `created_date` DATE COMMENT 'The date on which this vendor record was first created in the institutional finance system. Used for audit trail and vendor relationship history tracking.',
    `currency_code` STRING COMMENT 'The default currency in which this vendor invoices and receives payment. Uses three-letter ISO 4217 currency codes. Most US higher education institutions transact primarily in USD.. Valid values are `USD|CAD|GBP|EUR|JPY|AUD`',
    `dba_name` STRING COMMENT 'The trade name or doing business as name under which the vendor operates, if different from the legal name. Used for vendor search and identification.',
    `debarment_check_date` DATE COMMENT 'The date on which the vendors debarment status was last verified against the SAM Exclusions database. Institutions typically verify this annually or before major contract awards.',
    `debarment_status` STRING COMMENT 'Current debarment or suspension status of the vendor as listed in the federal System for Award Management (SAM) Exclusions database. Institutions must verify vendors are not debarred before awarding contracts, especially for federally-funded purchases.. Valid values are `clear|debarred|suspended|proposed_debarment`',
    `inactivation_date` DATE COMMENT 'The date on which the vendor record was inactivated and removed from active use. Inactivated vendors are retained for historical reporting and audit purposes.',
    `last_modified_date` DATE COMMENT 'The date on which this vendor record was most recently updated. Used for audit trail and data quality monitoring.',
    `last_payment_date` DATE COMMENT 'The date of the most recent payment issued to this vendor. Used to identify inactive vendors and support vendor relationship analysis.',
    `legal_name` STRING COMMENT 'The official legal name of the vendor entity as registered with government authorities and used for tax reporting and legal contracts.',
    `minority_owned` BOOLEAN COMMENT 'Boolean flag indicating whether the vendor is certified as a minority-owned business enterprise. Used for diversity spend reporting and supplier diversity program compliance.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional information about the vendor, including special handling instructions, payment preferences, or historical context not captured in structured fields.',
    `payment_method` STRING COMMENT 'The vendors preferred method for receiving payments from the institution. ACH (Automated Clearing House) is the most common method for electronic funds transfer.. Valid values are `ACH|wire_transfer|check|credit_card|procurement_card`',
    `payment_terms` STRING COMMENT 'The negotiated payment terms for this vendor, specifying the number of days within which payment is due after invoice receipt (e.g., Net 30, Net 45, 2/10 Net 30 for early payment discounts).',
    `remittance_address_line1` STRING COMMENT 'The first line of the vendors remittance address where payments and payment notifications should be sent. May differ from the vendors physical business address.',
    `remittance_address_line2` STRING COMMENT 'The second line of the vendors remittance address, typically used for suite numbers, department names, or additional location details.',
    `remittance_city` STRING COMMENT 'The city component of the vendors remittance address.',
    `remittance_country` STRING COMMENT 'The country component of the vendors remittance address. Use three-letter ISO 3166-1 alpha-3 country codes (e.g., USA, CAN, GBR).',
    `remittance_postal_code` STRING COMMENT 'The postal code or ZIP code component of the vendors remittance address.',
    `remittance_state` STRING COMMENT 'The state or province component of the vendors remittance address. Use standard two-letter postal abbreviations for US states.',
    `requires_1099` BOOLEAN COMMENT 'Boolean flag indicating whether payments to this vendor must be reported to the IRS on Form 1099-MISC or 1099-NEC. True for most US-based vendors receiving payments for services; false for corporations and certain exempt entities.',
    `small_business` BOOLEAN COMMENT 'Boolean flag indicating whether the vendor qualifies as a small business under federal Small Business Administration (SBA) size standards. Used for small business procurement goal tracking.',
    `tax_id_type` STRING COMMENT 'The type of tax identification number provided by the vendor: Employer Identification Number for businesses, Social Security Number for individuals, or Individual Taxpayer Identification Number.. Valid values are `EIN|SSN|ITIN`',
    `tax_identifier` STRING COMMENT 'The vendors federal tax identification number, either an Employer Identification Number (EIN) or Social Security Number (SSN) for individual vendors. Required for IRS 1099 reporting and tax compliance.',
    `vendor_number` STRING COMMENT 'The externally-known unique vendor identifier assigned by the institution for procurement and accounts payable operations. Used on purchase orders, invoices, and payment documents.',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor record in the institutional procurement system. Active vendors can receive purchase orders and payments; inactive vendors are retained for historical reporting but cannot be used for new transactions.. Valid values are `active|inactive|suspended|pending_approval`',
    `vendor_type` STRING COMMENT 'Classification of the vendor based on the nature of goods or services provided to the institution. Determines procurement workflows and approval requirements. [ENUM-REF-CANDIDATE: supplier|contractor|consultant|utility|government|individual|non_profit — 7 candidates stripped; promote to reference product]',
    `veteran_owned` BOOLEAN COMMENT 'Boolean flag indicating whether the vendor is certified as a veteran-owned or service-disabled veteran-owned business. Used for diversity spend reporting.',
    `w9_received_date` DATE COMMENT 'The date on which the institution received a completed W-9 form from the vendor. Used to track compliance and determine when forms need to be refreshed.',
    `w9_status` STRING COMMENT 'Current status of the IRS Form W-9 (Request for Taxpayer Identification Number and Certification) on file for this vendor. Required for tax reporting compliance.. Valid values are `received|pending|expired|not_required`',
    `women_owned` BOOLEAN COMMENT 'Boolean flag indicating whether the vendor is certified as a women-owned business enterprise. Used for diversity spend reporting and supplier diversity program compliance.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Vendor and supplier master data for all external parties from whom the institution procures goods and services. Captures vendor ID, legal name, DBA name, vendor type (supplier, contractor, consultant, utility, government), tax ID (EIN/SSN), W-9 status, payment terms, preferred payment method, remittance address, 1099 reporting flag, minority/women-owned business enterprise (MWBE) classification, debarment status, and active status. Sourced from Oracle PeopleSoft Financials AP Vendor Master.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order record. Primary key for the purchase order entity.',
    `capital_project_id` BIGINT COMMENT 'Identifier for the research project or capital project associated with this purchase, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Purchase orders are charged to organizational cost centers. Adding cost_center_id FK allows joining to cost_center master for cost_center_name, hierarchy, manager, and budget attributes. Removes redun',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Purchase orders are charged to funds (self-balancing accounting entities). Adding fund_id FK allows joining to finance_fund master for fund_name, fund_type, net_asset_classification, and restriction a',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Purchase orders create budget encumbrances that must be tracked within fiscal periods. The purchase_order table has po_date but no fiscal_period_id FK. In higher-education fund accounting, PO encumbra',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Purchase orders are charged to GL accounts for header-level tracking. Adding ledger_account_id FK allows joining to ledger_account master for account_name, account_type, hierarchy, and classification ',
    `org_unit_id` BIGINT COMMENT 'Identifier for the academic or administrative department requesting the purchase.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Procurement policies set competitive bidding thresholds, sole-source justification requirements, and approval limits. Purchasing officers enforce policy compliance for each PO. Required for Uniform Gu',
    `employee_id` BIGINT COMMENT 'Identifier for the purchasing agent or buyer responsible for managing this purchase order.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Federal procurement regulations (Uniform Guidance §200.317-320, Buy American Act, Davis-Bacon Act) govern purchase orders on federally-funded projects. Procurement officers and auditors must trace POs',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Purchase orders for grant-funded goods and services reference the research award for encumbrance, budget control, and allowability verification. The grant_number plain text attribute is a direct denor',
    `vendor_id` BIGINT COMMENT 'Identifier for the vendor or supplier from whom goods or services are being procured.',
    `approval_status` STRING COMMENT 'Current approval workflow status indicating whether the purchase order has received necessary authorizations.. Valid values are `not_submitted|pending|approved|rejected|returned`',
    `approved_by` STRING COMMENT 'Name of the approving authority who authorized this purchase order.',
    `approved_date` DATE COMMENT 'Date when the purchase order received final approval and became a binding commitment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase order monetary values.. Valid values are `^[A-Z]{3}$`',
    `encumbrance_amount` DECIMAL(18,2) COMMENT 'Amount encumbered (reserved) in the general ledger to ensure budget availability for this purchase order.',
    `fob_point` STRING COMMENT 'Free On Board point indicating where ownership and liability transfer from vendor to institution.. Valid values are `origin|destination`',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'Cumulative amount that has been invoiced by the vendor against this purchase order.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order record was last modified. Audit trail for record updates.',
    `notes` STRING COMMENT 'Free-text notes or special instructions related to this purchase order for vendor or internal reference.',
    `payment_terms` STRING COMMENT 'Payment terms negotiated with the vendor (e.g., Net 30, Net 60, 2/10 Net 30).',
    `po_date` DATE COMMENT 'The date when the purchase order was officially created and issued. Principal business event timestamp for the procurement transaction.',
    `po_number` STRING COMMENT 'The externally-known unique purchase order number assigned by the purchasing system. Business identifier used for vendor communication and tracking.. Valid values are `^PO[0-9]{8}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order indicating its position in the procurement workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|open|partially_received|closed|cancelled|on_hold — 8 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order indicating the procurement method and terms structure.. Valid values are `standard|blanket|contract|standing|emergency`',
    `program_code` STRING COMMENT 'Program chartfield code identifying the academic program or functional area benefiting from this purchase.',
    `promised_delivery_date` DATE COMMENT 'Date the vendor has committed to deliver the goods or services.',
    `received_amount` DECIMAL(18,2) COMMENT 'Cumulative monetary value of goods or services that have been received against this purchase order.',
    `required_delivery_date` DATE COMMENT 'Date by which the goods or services must be delivered to meet business needs.',
    `requisition_number` STRING COMMENT 'Reference to the originating purchase requisition that initiated this purchase order.',
    `ship_to_address_line1` STRING COMMENT 'First line of the delivery street address for this purchase order.',
    `ship_to_city` STRING COMMENT 'City name for the delivery address.',
    `ship_to_country` STRING COMMENT 'Three-letter ISO country code for the delivery address.. Valid values are `^[A-Z]{3}$`',
    `ship_to_location` STRING COMMENT 'Delivery address or campus location code where goods should be shipped.',
    `ship_to_postal_code` STRING COMMENT 'Postal or ZIP code for the delivery address.',
    `ship_to_state` STRING COMMENT 'State or province code for the delivery address.',
    `shipping_method` STRING COMMENT 'Method of shipment or delivery specified for this purchase order (e.g., ground, overnight, freight).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this purchase order.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order including all line items before tax.',
    `total_amount_with_tax` DECIMAL(18,2) COMMENT 'Net total purchase order amount including tax. Final commitment amount.',
    `vendor_site_code` STRING COMMENT 'Code identifying the specific vendor location or site for delivery and payment purposes.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Purchase order header record representing a formal commitment to procure goods or services from a vendor. Captures PO number, PO date, vendor reference, requisition reference, PO type (standard, blanket, contract), total PO amount, encumbrance amount, fund and cost center chartfield, buyer name, department, delivery address, required delivery date, approval status, and PO status (open, partially received, closed, cancelled). Sourced from Oracle PeopleSoft Financials Purchasing module.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`purchase_order_line` (
    `purchase_order_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key for this entity.',
    `capital_project_id` BIGINT COMMENT 'Foreign key reference to a specific project or grant if this line is charged to project-based funding. Used for grant accounting and project cost tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Purchase order lines are charged to organizational cost centers. Adding cost_center_id FK allows joining to cost_center master for cost_center_name, hierarchy, manager, and budget attributes. Removes ',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Purchase order lines are charged to funds (self-balancing accounting entities). Adding fund_id FK allows joining to finance_fund master for fund_name, fund_type, net_asset_classification, and restrict',
    `grant_account_id` BIGINT COMMENT 'Foreign key reference to a sponsored research grant if this line is charged to grant funding. Used for grant compliance and Facilities and Administrative (F&A) cost allocation.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Purchase order lines are charged to GL accounts. Adding ledger_account_id FK allows joining to ledger_account master for account_name, account_type, hierarchy, and classification attributes. Removes r',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the procurement staff member responsible for managing this purchase order line.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the parent purchase order header. Establishes the header-detail relationship for this line item.',
    `requester_employee_id` BIGINT COMMENT 'Foreign key reference to the employee or faculty member who originally requested this item or service.',
    `actual_delivery_date` DATE COMMENT 'The actual date the goods were received or services were completed. Used for vendor performance analysis and three-way match validation.',
    `cancellation_reason` STRING COMMENT 'Textual explanation for why this purchase order line was cancelled. Used for procurement process improvement and vendor relationship management.',
    `cancelled_date` DATE COMMENT 'The date this purchase order line was cancelled. Applicable when the line is terminated before fulfillment.',
    `closed_date` DATE COMMENT 'The date this purchase order line was formally closed. Indicates completion of all receipt, invoicing, and payment activities.',
    `commodity_code` STRING COMMENT 'Standardized classification code for the type of goods or services being purchased. Used for spend analysis and procurement reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line record was first created in the system. Used for audit trail and process timing analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary amounts on this line (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any negotiated discount amount applied to this line. Reduces the extended amount for payment calculation.',
    `encumbrance_amount` DECIMAL(18,2) COMMENT 'The amount of budget funds encumbered (reserved) for this line. Represents the commitment of funds at the time the PO is approved.',
    `extended_amount` DECIMAL(18,2) COMMENT 'The total line amount calculated as quantity ordered multiplied by unit price. Represents the total cost for this line before taxes and adjustments.',
    `inspection_required_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the received goods require quality inspection before acceptance. Used for quality assurance workflows.',
    `item_code` BIGINT COMMENT 'Foreign key reference to the catalog item or inventory item being procured on this line.',
    `item_description` STRING COMMENT 'Detailed textual description of the goods or services being procured on this line. May include specifications, model numbers, or service details.',
    `last_modified_by` STRING COMMENT 'The username or identifier of the person who last modified this purchase order line record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line record was last updated. Used for audit trail and change tracking.',
    `line_number` STRING COMMENT 'Sequential line number within the purchase order. Used for ordering and referencing specific line items within the PO.',
    `line_status` STRING COMMENT 'Current lifecycle status of this purchase order line. Tracks progression from open through receipt to closure or cancellation.. Valid values are `open|partially_received|fully_received|closed|cancelled`',
    `liquidated_amount` DECIMAL(18,2) COMMENT 'The cumulative amount of encumbrance that has been liquidated (released) through receipts and invoices. Used for encumbrance tracking and budget reconciliation.',
    `manufacturer_name` STRING COMMENT 'The name of the manufacturer of the goods being procured. Used for quality tracking and warranty management.',
    `manufacturer_part_number` STRING COMMENT 'The manufacturers part or model number for the item. Used for precise item identification and warranty claims.',
    `need_by_date` DATE COMMENT 'The date by which the goods or services are required by the requesting department. Used for delivery scheduling and vendor performance tracking.',
    `notes` STRING COMMENT 'Free-form text field for additional instructions, specifications, or comments related to this purchase order line.',
    `program_code` STRING COMMENT 'Program or functional area code for tracking expenditures by institutional program or initiative. Part of the chartfield distribution.',
    `promised_delivery_date` DATE COMMENT 'The date the vendor has committed to deliver the goods or complete the services. Used for vendor performance evaluation.',
    `quantity_invoiced` DECIMAL(18,2) COMMENT 'The cumulative quantity that has been invoiced by the vendor against this line to date. Used for three-way match validation.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of goods or services ordered on this line, expressed in the unit of measure. Original order quantity before any receipts or adjustments.',
    `quantity_received` DECIMAL(18,2) COMMENT 'The cumulative quantity of goods or services that have been received against this line to date. Used for three-way match validation.',
    `receipt_required_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether a formal receipt transaction is required before payment can be processed. True for goods, typically false for services.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applicable to this line (sales tax, use tax, VAT). Calculated based on tax jurisdiction and item taxability.',
    `unit_of_measure` STRING COMMENT 'The unit in which the quantity is measured (e.g., each, box, hour, pound). Defines how the item is counted or measured for procurement purposes. [ENUM-REF-CANDIDATE: each|box|case|dozen|hour|day|month|year|pound|kilogram|liter|gallon — 12 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit of measure for the item being procured. Negotiated or catalog price before any discounts or taxes.',
    `vendor_item_number` STRING COMMENT 'The vendors catalog or part number for this item. Used for order accuracy and vendor communication.',
    CONSTRAINT pk_purchase_order_line PRIMARY KEY(`purchase_order_line_id`)
) COMMENT 'Individual line item within a purchase order specifying the goods or services being procured. Captures line number, item description, commodity code, unit of measure, quantity ordered, unit price, extended amount, chartfield distribution (fund, cost center, account, project), receipt status, and invoiced amount. Supports three-way match (PO, receipt, invoice) and encumbrance liquidation in PeopleSoft Financials.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'Unique identifier for the accounts payable invoice record. Primary key.',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to facility.capital_project. Business justification: Capital construction/renovation invoices (AIA payment applications, contractor billings) must reference the capital project for project budget tracking, draw schedule management, and GASB 34 capitaliz',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AP invoices are charged to organizational cost centers. Adding cost_center_id FK allows joining to cost_center master for cost_center_name, hierarchy, manager, and budget attributes. Removes redundant',
    `event_id` BIGINT COMMENT 'Foreign key linking to advancement.event. Business justification: Advancement event expense tracking: fundraising and stewardship events (galas, donor recognition dinners) generate AP invoices for vendor services. Finance codes these invoices to the specific advance',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: AP invoices are charged to funds (self-balancing accounting entities). Adding fund_id FK allows joining to finance_fund master for fund_name, fund_type, net_asset_classification, and restriction attri',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: AP invoices are posted to fiscal periods for accounting cycle management. Adding fiscal_period_id FK allows joining to fiscal_period master for period_name, period dates, status flags, and reporting a',
    `grant_account_id` BIGINT COMMENT 'Reference to the research grant or sponsored project if this invoice is charged to grant funds. Null for non-grant invoices.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: AP invoices generate journal entries when posted to the general ledger. Adding journal_entry_id FK (nullable) allows linking to the GL posting. Populated during posting process. No columns removed as ',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: AP invoices are charged to GL accounts. Adding ledger_account_id FK allows joining to ledger_account master for account_name, account_type, hierarchy, and classification attributes. Removes redundant ',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice is matched. Null for non-PO invoices.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: AP invoices for federally-funded expenditures must demonstrate allowability under specific regulatory requirements (2 CFR 200 Uniform Guidance). Single Audit procedures require tracing invoices to gov',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor who submitted this invoice for payment.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to facility.work_order. Business justification: Contractor and vendor invoices for facilities maintenance and repair must be matched to the originating work order for three-way match (PO/receipt/invoice), cost-per-work-order reporting, and faciliti',
    `ap_invoice_description` STRING COMMENT 'Textual description of the goods or services covered by this invoice.',
    `approval_status` STRING COMMENT 'Current status of the invoice in the approval workflow.. Valid values are `pending|approved|rejected|not_required`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the invoice for payment.',
    `approved_date` DATE COMMENT 'The date the invoice was approved for payment.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this invoice record was first created in the AP system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amount.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early payment discount amount available if paid by discount due date.',
    `discount_due_date` DATE COMMENT 'The date by which payment must be made to qualify for early payment discount. Null if no discount offered.',
    `dispute_reason` STRING COMMENT 'Explanation for why the invoice is disputed. Null if not disputed.',
    `due_date` DATE COMMENT 'The date by which payment is due to the vendor per the payment terms.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied for foreign currency invoices to convert to institutional base currency.',
    `form_1099_amount` DECIMAL(18,2) COMMENT 'The portion of the invoice amount that is reportable on IRS Form 1099.',
    `form_1099_reportable_flag` BOOLEAN COMMENT 'Indicates whether this invoice amount is reportable on IRS Form 1099 for the vendor.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Shipping and freight charges included in the invoice.',
    `gross_invoice_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before any discounts or adjustments.',
    `hold_reason` STRING COMMENT 'Explanation for why the invoice is on hold and not being processed for payment. Null if not on hold.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. Used for aging analysis and payment term calculation.',
    `invoice_number` STRING COMMENT 'The vendor-assigned invoice number as printed on the invoice document. Business identifier for external reference.',
    `invoice_received_date` DATE COMMENT 'The date the institution received the invoice from the vendor.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts payable workflow. [ENUM-REF-CANDIDATE: entered|matched|approved|paid|on_hold|cancelled|disputed — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice transaction type.. Valid values are `standard|credit_memo|debit_memo|prepayment|recurring`',
    `last_modified_by` STRING COMMENT 'Name or identifier of the user who last modified this invoice record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this invoice record was last updated.',
    `match_status` STRING COMMENT 'Indicates whether the invoice has been matched to a purchase order and/or receipt (two-way or three-way match).. Valid values are `not_matched|two_way_matched|three_way_matched|forced_match`',
    `net_invoice_amount` DECIMAL(18,2) COMMENT 'The final payable amount after applying discounts, taxes, and adjustments.',
    `payment_date` DATE COMMENT 'The date payment was issued to the vendor. Null if not yet paid.',
    `payment_method` STRING COMMENT 'The method used to pay the invoice.. Valid values are `check|ach|wire|credit_card|procurement_card`',
    `payment_reference_number` STRING COMMENT 'Check number, ACH trace number, or wire confirmation number for the payment.',
    `payment_terms` STRING COMMENT 'The payment terms specified by the vendor (e.g., Net 30, 2/10 Net 30). Defines discount eligibility and due date calculation.',
    `program_code` STRING COMMENT 'The academic or administrative program code to which this expense is allocated.',
    `remit_to_location` STRING COMMENT 'The vendor location or address to which payment should be remitted.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the invoice (sales tax, use tax, VAT).',
    `voucher_number` STRING COMMENT 'Internal voucher or document number assigned by the AP system for tracking and audit purposes.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts payable invoice record representing a vendors request for payment for goods or services delivered to the institution. Captures invoice number, invoice date, vendor reference, PO reference, invoice amount, tax amount, discount amount, due date, payment terms, invoice status (entered, matched, approved, paid, on hold), approval workflow status, and 1099 reportable flag. Sourced from Oracle PeopleSoft Financials AP module. Supports three-way match and GASB expense recognition.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'Unique identifier for the accounts payable payment disbursement record. Primary key.',
    `bank_account_id` BIGINT COMMENT 'Unique identifier of the institutional bank account from which the payment was disbursed.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AP payments are charged to organizational cost centers. Adding cost_center_id FK allows joining to cost_center master for cost_center_name, hierarchy, manager, and budget attributes. Removes redundant',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: AP payments are charged to funds (self-balancing accounting entities). Adding fund_id FK allows joining to finance_fund master for fund_name, fund_type, net_asset_classification, and restriction attri',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: AP payments are posted to fiscal periods for accounting cycle management. Adding fiscal_period_id FK allows joining to fiscal_period master for period_name, period dates, status flags, and reporting a',
    `grant_account_id` BIGINT COMMENT 'Unique identifier of the research grant or sponsored project if the payment is charged to grant funds. Links to grant accounting records.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: AP payments generate journal entries when posted to the general ledger. Adding journal_entry_id FK (nullable) allows linking to the GL posting. Populated during posting process. No columns removed as ',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee or user who approved the payment for disbursement.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor or supplier receiving the payment. Links to the vendor master record.',
    `approver_name` STRING COMMENT 'The name of the employee or user who approved the payment for disbursement.',
    `check_number` STRING COMMENT 'The physical check number if the payment method is check. Null for electronic payment methods.',
    `cleared_date` DATE COMMENT 'The date on which the payment cleared the bank and was reconciled. Used for cash flow tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the payment record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_taken_amount` DECIMAL(18,2) COMMENT 'The amount of early payment discount taken by the institution, reducing the net payment amount.',
    `last_modified_by` STRING COMMENT 'The username or identifier of the user who last modified the payment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the payment record was last updated or modified. Audit trail for record changes.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The final net amount disbursed after applying discounts and adjustments. Represents the actual cash outflow.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The total gross amount of the payment disbursed to the vendor before any adjustments.',
    `payment_approval_date` DATE COMMENT 'The date on which the payment was approved for disbursement by an authorized approver.',
    `payment_date` DATE COMMENT 'The date on which the payment was issued or disbursed to the vendor. Principal business event timestamp for the payment transaction.',
    `payment_description` STRING COMMENT 'Textual description or memo explaining the purpose or nature of the payment.',
    `payment_method` STRING COMMENT 'The instrument or mechanism used to disburse the payment (check, ACH/EFT, wire transfer, purchasing card).. Valid values are `check|ach|eft|wire_transfer|credit_card|pcard`',
    `payment_number` STRING COMMENT 'Externally-known unique payment reference number assigned by the Oracle PeopleSoft Financials AP Payment module. Used for tracking and reconciliation.',
    `payment_source_system` STRING COMMENT 'The name of the source system or module that originated the payment record (e.g., Oracle PeopleSoft Financials AP, Workday Financials).',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment disbursement indicating its processing state.. Valid values are `issued|cleared|voided|stale_dated|cancelled|pending`',
    `payment_type` STRING COMMENT 'Classification of the payment by its business purpose or nature (regular vendor payment, refund, advance, employee reimbursement).. Valid values are `regular|refund|advance|reimbursement|petty_cash`',
    `preparer_name` STRING COMMENT 'The name of the employee or user who prepared or initiated the payment record.',
    `program_code` STRING COMMENT 'The academic or administrative program code associated with the payment, supporting program-level financial analysis.',
    `reconciliation_date` DATE COMMENT 'The date on which the payment was reconciled with the bank statement.',
    `reconciliation_status` STRING COMMENT 'Indicates whether the payment has been reconciled with the bank statement.. Valid values are `unreconciled|reconciled|outstanding|exception`',
    `remittance_advice_sent_date` DATE COMMENT 'The date on which remittance advice was sent to the vendor.',
    `remittance_advice_sent_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether remittance advice was sent to the vendor notifying them of the payment details.',
    `tax_reporting_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this payment requires tax reporting (e.g., 1099 reporting for vendors).',
    `vendor_site_code` STRING COMMENT 'The specific vendor site or location code to which the payment is directed, supporting multi-location vendor management.',
    `void_date` DATE COMMENT 'The date on which the payment was voided or cancelled. Null if payment was not voided.',
    `void_reason` STRING COMMENT 'Business reason or explanation for voiding the payment (e.g., duplicate payment, vendor request, incorrect amount).',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Accounts payable payment disbursement record capturing actual payments made to vendors. Records payment reference number, payment date, payment method (check, ACH/EFT, wire transfer), bank account, payment amount, discount taken, vendor reference, invoice references paid, payment status (issued, cleared, voided, stale-dated), and bank reconciliation status. Sourced from Oracle PeopleSoft Financials AP Payment module.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`ar_invoice` (
    `ar_invoice_id` BIGINT COMMENT 'Unique system identifier for the accounts receivable invoice record. Primary key for the AR invoice entity.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: AR invoices post to AR control GL accounts. Adding ar_ledger_account_id FK allows joining to ledger_account master for account_name, account_type, hierarchy, and classification attributes. Removes red',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AR invoices are credited to organizational cost centers. Adding cost_center_id FK allows joining to cost_center master for cost_center_name, hierarchy, manager, and budget attributes. Removes redundan',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: AR invoices are credited to funds (self-balancing accounting entities). Adding fund_id FK allows joining to finance_fund master for fund_name, fund_type, net_asset_classification, and restriction attr',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: AR invoices must be associated with a fiscal period for revenue recognition, period-end close, and GASB/FASB reporting. The ar_invoice table has invoice_date and revenue_recognition_date but no fiscal',
    `grant_account_id` BIGINT COMMENT 'Reference to the sponsored research grant or contract if this invoice represents grant-related billing (e.g., F&A cost recovery, direct cost reimbursement). Links to the research grant entity.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: AR invoices generate journal entries when posted to the general ledger. Adding journal_entry_id FK (nullable) allows linking to the GL posting. Populated during posting process. No columns removed as ',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: AR invoices for sponsored research are generated against specific research awards for cost reimbursement billing. This link supports award-level billing status tracking, invoice-to-award reconciliatio',
    `room_booking_id` BIGINT COMMENT 'Foreign key linking to facility.room_booking. Business justification: External event/conference room rentals generate AR invoices billed to outside organizations. Higher-ed conference services and auxiliary operations require the AR invoice to reference the room booking',
    `sponsor_id` BIGINT COMMENT 'Foreign key linking to research.sponsor. Business justification: Universities bill sponsors via AR invoices for sponsored project cost reimbursement and drawdowns. The customer_name plain attribute is a denormalization signal. Linking AR invoices to sponsors suppor',
    `aging_bucket` STRING COMMENT 'Classification of invoice age relative to due date for accounts receivable aging analysis. Used to assess collectability and allowance for doubtful accounts.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `amount_outstanding` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the invoice. Calculated as net_amount minus amount_paid.',
    `amount_paid` DECIMAL(18,2) COMMENT 'Total amount paid against this invoice to date. Used to calculate outstanding balance and track partial payments.',
    `ar_invoice_description` STRING COMMENT 'Detailed narrative description of the goods or services being invoiced. Provides context for the charges and supports customer inquiries.',
    `billing_address_line1` STRING COMMENT 'First line of the customer billing address (street number and name). Organizational contact data classified as confidential.',
    `billing_address_line2` STRING COMMENT 'Second line of the customer billing address (suite, floor, building). Optional field for additional address details.',
    `billing_city` STRING COMMENT 'City name for the customer billing address.',
    `billing_contact_email` STRING COMMENT 'Email address of the billing contact for invoice delivery and payment communication. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'Name of the primary contact person at the customer organization for billing inquiries and payment coordination.',
    `billing_contact_phone` STRING COMMENT 'Phone number of the billing contact for invoice inquiries and payment coordination. Organizational contact data classified as confidential.. Valid values are `^+?[0-9]{10,15}$`',
    `billing_country_code` STRING COMMENT 'Three-letter ISO country code for the customer billing address.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the customer billing address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `billing_state_province` STRING COMMENT 'Two-letter state or province code for the customer billing address.. Valid values are `^[A-Z]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this invoice record was first created in the AR system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the invoice amounts. Most higher education institutions operate primarily in USD but may invoice international customers in other currencies.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the invoice. May include early payment discounts, volume discounts, or negotiated rate reductions.',
    `due_date` DATE COMMENT 'Date by which payment is expected based on invoice date and payment terms. Used for aging calculations and collections prioritization.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before tax and adjustments. Represents the base charges for goods or services provided.',
    `invoice_date` DATE COMMENT 'Date the invoice was issued to the customer. Represents the business event timestamp for revenue recognition and aging calculations.',
    `invoice_number` STRING COMMENT 'Externally-visible unique invoice number assigned by the AR system. Used for customer communication and payment reference.. Valid values are `^[A-Z0-9]{6,20}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice indicating payment state and collectability.. Valid values are `open|partially_paid|paid|written_off|cancelled|disputed`',
    `invoice_type` STRING COMMENT 'Classification of the invoice transaction type. Standard invoices represent new charges; credit memos reduce amounts owed; debit memos increase amounts owed.. Valid values are `standard|credit_memo|debit_memo|prepayment|recurring`',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this invoice record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this invoice record was last updated. Used for audit trail and change tracking.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received against this invoice. Used for payment tracking and customer payment behavior analysis.',
    `net_amount` DECIMAL(18,2) COMMENT 'Total amount due from the customer after applying tax and discounts. Calculated as gross_amount + tax_amount - discount_amount.',
    `payment_method` STRING COMMENT 'Preferred or expected payment instrument for this invoice. Indicates how the customer typically remits payment.. Valid values are `check|wire_transfer|ach|credit_card|electronic_funds_transfer`',
    `payment_terms` STRING COMMENT 'Contractual payment terms specifying when payment is due. Common terms include net 30 (due in 30 days) or 2/10 net 30 (2% discount if paid within 10 days, otherwise due in 30 days). [ENUM-REF-CANDIDATE: net_15|net_30|net_45|net_60|net_90|due_on_receipt|2_10_net_30 — 7 candidates stripped; promote to reference product]',
    `program_code` STRING COMMENT 'Program or project chartfield identifying the specific initiative or activity generating this revenue. Used for program-level financial analysis.. Valid values are `^[A-Z0-9]{2,10}$`',
    `reference_number` STRING COMMENT 'External reference number such as customer purchase order number, contract number, or requisition number. Used for customer reconciliation and payment matching.',
    `revenue_account_code` STRING COMMENT 'General ledger account code for the revenue recognition. Maps to the chart of accounts for financial reporting and revenue classification.. Valid values are `^[0-9]{4,10}$`',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue from this invoice is recognized in the general ledger. May differ from invoice date based on revenue recognition policies and service delivery timing.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice. May include sales tax, use tax, or VAT depending on jurisdiction and customer tax status.',
    `writeoff_date` DATE COMMENT 'Date the invoice was written off as uncollectible. Populated only when invoice status is written_off.',
    `writeoff_reason` STRING COMMENT 'Business reason for writing off the invoice. Used for bad debt analysis and collections process improvement.. Valid values are `bankruptcy|customer_dispute|uncollectible|administrative_error|goodwill_adjustment`',
    CONSTRAINT pk_ar_invoice PRIMARY KEY(`ar_invoice_id`)
) COMMENT 'Accounts receivable invoice for non-student institutional receivables billed to external parties (government agencies, corporations, foundations, other universities, and auxiliary enterprise customers). Captures invoice number, date, customer/payor, billing address, amount, tax, due date, payment terms, AR account, fund and cost center chartfield, invoice status (open, partially paid, paid, written off), aging bucket, and revenue recognition date. Distinct from student billing invoices owned by the billing domain. Sourced from Oracle PeopleSoft Financials AR module.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`ar_receipt` (
    `ar_receipt_id` BIGINT COMMENT 'Unique identifier for the accounts receivable cash receipt record. Primary key for the AR receipt entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the staff member or supervisor who approved the receipt for posting, if approval workflow is required.',
    `bank_account_id` BIGINT COMMENT 'Identifier of the institutional bank account into which the payment was deposited.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AR receipts are credited to organizational cost centers. Adding cost_center_id FK allows joining to cost_center master for cost_center_name, hierarchy, manager, and budget attributes. Removes redundan',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: AR receipts are credited to funds (self-balancing accounting entities). Adding fund_id FK allows joining to finance_fund master for fund_name, fund_type, net_asset_classification, and restriction attr',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: AR receipts are posted to fiscal periods for accounting cycle management. Adding fiscal_period_id FK allows joining to fiscal_period master for period_name, period dates, status flags, and reporting a',
    `grant_account_id` BIGINT COMMENT 'Identifier of the grant or sponsored project to which the receipt is attributed, if applicable for grant-funded activities.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: AR receipts generate journal entries when posted to the general ledger. Adding journal_entry_id FK (nullable) allows linking to the GL posting. Populated during posting process. No columns removed as ',
    `primary_ar_employee_id` BIGINT COMMENT 'Identifier of the staff member or system user who entered or prepared the receipt record in the AR system.',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Sponsor payments (AR receipts) are applied against research awards for cash receipt tracking and award balance management. Grants accountants require this link to reconcile sponsor payments against aw',
    `sponsor_id` BIGINT COMMENT 'Foreign key linking to research.sponsor. Business justification: AR receipts from sponsors must be traced to the sponsor for cash management, sponsor relationship reporting, and SAM/debarment compliance verification. The customer_name plain attribute is a denormali',
    `applied_amount` DECIMAL(18,2) COMMENT 'Portion of the receipt amount that has been applied to outstanding AR invoices or charges.',
    `approval_date` DATE COMMENT 'The date on which the receipt was approved for posting by the designated approver.',
    `approver_name` STRING COMMENT 'Name of the staff member who approved the receipt, captured for audit and accountability purposes.',
    `bank_deposit_reference` STRING COMMENT 'Reference number or identifier from the bank deposit slip or electronic deposit confirmation, used for bank reconciliation.',
    `check_number` STRING COMMENT 'Check number provided by the customer when payment method is check, used for tracking and reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the receipt record was first created in the AR system, supporting audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the payment was received (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deposit_date` DATE COMMENT 'The date on which the payment was deposited into the institutional bank account.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount allowed to the customer at the time of payment, such as early payment discounts or negotiated settlement reductions.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified the receipt record, supporting audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the receipt record was last updated or modified in the AR system, supporting change tracking and audit compliance.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the receipt, such as payment exceptions or follow-up actions.',
    `payment_channel` STRING COMMENT 'The interface or channel through which the payment was submitted by the customer (e.g., online portal, mail, in-person, phone, mobile app).. Valid values are `online_portal|mail|in_person|phone|mobile_app|bank_transfer`',
    `payment_method` STRING COMMENT 'The instrument or mechanism used by the customer to remit payment (e.g., check, wire transfer, ACH, credit card, cash, lockbox).. Valid values are `check|wire_transfer|ach|credit_card|cash|lockbox`',
    `posted_date` DATE COMMENT 'The date on which the receipt was posted to the general ledger and became part of the official financial records.',
    `posted_timestamp` TIMESTAMP COMMENT 'The precise date and time when the receipt was posted to the general ledger, supporting audit trail and transaction sequencing.',
    `preparer_name` STRING COMMENT 'Name of the staff member who prepared the receipt record, captured for audit and accountability purposes.',
    `program_code` STRING COMMENT 'Program or project code associated with the receipt, used for grant accounting and program-level financial reporting.',
    `receipt_amount` DECIMAL(18,2) COMMENT 'Total gross amount received from the customer in the payment transaction, before any application to invoices or discounts.',
    `receipt_date` DATE COMMENT 'The date on which the payment was received from the customer. This is the business event date for the cash receipt transaction.',
    `receipt_number` STRING COMMENT 'Business identifier for the cash receipt, typically a sequential or formatted number assigned by the AR system for external reference and reconciliation.',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the cash receipt indicating its processing state within the AR workflow.. Valid values are `draft|posted|reversed|voided|reconciled|unreconciled`',
    `reconciliation_date` DATE COMMENT 'The date on which the receipt was successfully reconciled with the bank statement.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether the receipt has been reconciled with the bank statement and deposit records.. Valid values are `unreconciled|reconciled|pending|exception`',
    `reference_number` STRING COMMENT 'External reference number provided by the customer or payment processor, such as a wire transfer confirmation number or transaction ID.',
    `remittance_advice` STRING COMMENT 'Free-text field capturing remittance advice or payment notes provided by the customer indicating which invoices or charges the payment is intended to cover.',
    `reversal_date` DATE COMMENT 'The date on which the receipt was reversed or voided, if applicable.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this receipt has been reversed or voided in a subsequent transaction.',
    `reversal_reason` STRING COMMENT 'Explanation or reason code for why the receipt was reversed, such as NSF (non-sufficient funds), customer dispute, or data entry error.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'Portion of the receipt amount that remains unapplied and is held as a credit on the customer account, available for future application.',
    CONSTRAINT pk_ar_receipt PRIMARY KEY(`ar_receipt_id`)
) COMMENT 'Accounts receivable cash receipt record capturing payments received from external customers against AR invoices. Records receipt number, receipt date, payment method, bank deposit reference, amount received, discount allowed, customer reference, invoice references applied, unapplied cash amount, and bank reconciliation status. Sourced from Oracle PeopleSoft Financials AR module.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`grant_account` (
    `grant_account_id` BIGINT COMMENT 'Unique identifier for the grant account financial entity. Primary key for the grant account master record representing the financial accounting view of a sponsored project or externally funded award.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Research grants are tied to specific academic programs for IPEDS research expenditure reporting, indirect cost rate application, and accreditation standards (AACSB research activity, ABET). A higher-e',
    `award_budget_id` BIGINT COMMENT 'Foreign key linking to research.award_budget. Business justification: Grant accounts implement approved award budgets. Budget periods, IDC rates, cost categories from award_budget drive grant_account financial controls and spending authority. Required for budget vs actu',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Grant accounts generate specific compliance obligations (progress reports, financial reports, invention disclosures, training requirements for grant personnel). Grant compliance officers track these o',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Grant accounts in higher education are administered by specific departments/cost centers (e.g., the Chemistry Department administers an NSF grant). The grant_account table currently links to hr.org_un',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: In higher-education fund accounting, every grant account is associated with a specific restricted fund (the self-balancing accounting entity). The grant_account table has a fund_code STRING column tha',
    `org_unit_id` BIGINT COMMENT 'Foreign key reference to the department that administratively owns this grant account.',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key reference to the faculty member serving as Principal Investigator for this grant.',
    `proposal_id` BIGINT COMMENT 'Foreign key linking to research.proposal. Business justification: Grant accounts originate from awarded proposals. Pre-award to post-award transition requires tracking which proposal generated each grant account for audit trail, compliance reporting, and institution',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Federal grants cite specific regulatory requirements (2 CFR 200, OMB Circulars, agency-specific terms). Grant administrators must track applicable regulations for allowability determinations, audit co',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Core 1:1 relationship - every research award generates exactly one grant account for financial tracking. Award terms, budget periods, compliance requirements flow from award to grant account. Essentia',
    `account_manager_email` STRING COMMENT 'Email address of the research administrator or grants accountant managing this grant account.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `account_manager_name` STRING COMMENT 'Name of the research administrator or grants accountant assigned to manage the financial administration of this grant account.',
    `account_setup_date` DATE COMMENT 'Date when the grant account was established in the financial system and made available for transactions.',
    `account_status` STRING COMMENT 'Current lifecycle status of the grant account: pending (award received but not yet activated), active (open for transactions), suspended (temporarily frozen), closed (project ended and final reporting complete).. Valid values are `pending|active|suspended|closed`',
    `award_notice_date` DATE COMMENT 'Date when the institution received official notification of the award from the sponsoring agency.',
    `closeout_date` DATE COMMENT 'Date when the grant account was officially closed after all financial reporting, final invoicing, and sponsor closeout requirements were completed.',
    `cost_sharing_amount` DECIMAL(18,2) COMMENT 'The total dollar value of institutional cost sharing or matching commitment required for this award. Null if no cost sharing is required.',
    `cost_sharing_required` BOOLEAN COMMENT 'Boolean flag indicating whether the institution is required to contribute matching funds or in-kind resources as a condition of the award.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this grant account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the award amount (e.g., USD for US Dollar, EUR for Euro, GBP for British Pound).. Valid values are `^[A-Z]{3}$`',
    `current_budget_period_amount` DECIMAL(18,2) COMMENT 'The funding amount authorized for the current budget period. Multi-year awards are typically funded incrementally by budget period.',
    `current_budget_period_end_date` DATE COMMENT 'End date of the current budget period for multi-year awards that are funded incrementally.',
    `current_budget_period_start_date` DATE COMMENT 'Start date of the current budget period for multi-year awards that are funded incrementally.',
    `fa_base_type` STRING COMMENT 'The cost base to which the F&A rate is applied: MTDC (Modified Total Direct Costs - most common federal base), TDC (Total Direct Costs), salaries and wages only, or other sponsor-specific base.. Valid values are `MTDC|TDC|salaries_wages|other`',
    `fa_rate` DECIMAL(18,2) COMMENT 'The indirect cost rate (expressed as a percentage) applied to this grant to recover institutional overhead costs. Also known as IDC (Indirect Cost) rate. Negotiated with federal cognizant agency.',
    `federal_award_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this is a federal award subject to Uniform Guidance (2 CFR 200) and Single Audit requirements.',
    `flow_through_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this grant includes subawards to other institutions (institution acts as pass-through entity).',
    `grant_account_number` STRING COMMENT 'The externally-known unique account number assigned to this sponsored project or grant for financial tracking and reporting. This is the business identifier used across financial systems and in communications with sponsors.. Valid values are `^[A-Z0-9]{6,20}$`',
    `last_modified_by` STRING COMMENT 'Username or identifier of the person who last modified this grant account record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this grant account record was most recently updated.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent financial transaction posted to this grant account.',
    `notes` STRING COMMENT 'Free-text field for additional information, special terms and conditions, or administrative notes about this grant account.',
    `prime_institution_name` STRING COMMENT 'If this is a subaward, the name of the prime recipient institution that passes through funding to this institution. Null for prime awards.',
    `prime_sponsor_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this is a prime award (institution receives funding directly from sponsor) or a subaward (institution receives funding as a subrecipient through another institution).',
    `project_code` STRING COMMENT 'The project dimension code used in the financial system to track all transactions related to this specific grant or sponsored project.',
    `sponsor_type` STRING COMMENT 'Classification of the sponsoring organization: federal agency, state government, local government, nonprofit foundation, corporate/industry sponsor, or foreign government/entity.. Valid values are `federal|state|local|nonprofit|corporate|foreign`',
    CONSTRAINT pk_grant_account PRIMARY KEY(`grant_account_id`)
) COMMENT 'Sponsored project/grant account master record representing the financial accounting entity for an externally funded research or program award. Captures grant account number, award title, sponsoring agency (NSF, NIH, DOE, private foundation), award amount, project start and end dates, F&A (indirect cost) rate, F&A base type, PI name, administering department, CFDA number for federal awards, cost-sharing requirement, budget period, and account status. Distinct from the research domains award record — this is the financial accounting view. Sourced from Oracle PeopleSoft Financials Projects/Grants module and Kuali Research.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`fiscal_period` (
    `fiscal_period_id` BIGINT COMMENT 'Unique identifier for the fiscal period record. Primary key.',
    `adjustment_period_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a special adjustment period (e.g., Period 13) used for year-end adjustments, accruals, and closing entries after the regular fiscal year periods have closed.',
    `ap_close_date` DATE COMMENT 'Actual calendar date when the Accounts Payable module was closed for this fiscal period. Null if the period is still open.',
    `ap_status` STRING COMMENT 'Current open/closed status of the period for Accounts Payable module transactions. Controls whether AP vouchers and payments can be posted to this period.. Valid values are `open|closed|future|locked`',
    `ar_close_date` DATE COMMENT 'Actual calendar date when the Accounts Receivable module was closed for this fiscal period. Null if the period is still open.',
    `ar_status` STRING COMMENT 'Current open/closed status of the period for Accounts Receivable module transactions. Controls whether AR invoices and receipts can be posted to this period.. Valid values are `open|closed|future|locked`',
    `budget_carryforward_flag` BOOLEAN COMMENT 'Flag indicating whether unspent budget balances from this period are eligible to carry forward to the next fiscal year. Institutional policy determines carryforward eligibility.',
    `budget_close_date` DATE COMMENT 'Actual calendar date when the Budget module was closed for this fiscal period. Null if the period is still open.',
    `budget_status` STRING COMMENT 'Current open/closed status of the period for budget transactions and budget checking. Controls whether budget entries and adjustments can be posted to this period.. Valid values are `open|closed|future|locked`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiscal period record was first created in the system.',
    `encumbrance_rollover_flag` BOOLEAN COMMENT 'Flag indicating whether open encumbrances from this period are eligible to roll forward to the next fiscal year. Typically true for the final period of the fiscal year.',
    `fa_rate_calculation_period_flag` BOOLEAN COMMENT 'Flag indicating whether this period is included in the base period for calculating Facilities and Administrative (F&A) indirect cost rates for sponsored research. True for periods used in F&A rate proposals.',
    `fasb_reporting_period_flag` BOOLEAN COMMENT 'Flag indicating whether this period is included in FASB financial statement reporting. True for periods that contribute to annual FASB-compliant financial statements for private institutions.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year to which this period belongs (e.g., 2024). Aligns with institutional fiscal year cycle and GASB/FASB reporting requirements.. Valid values are `^[0-9]{4}$`',
    `gasb_reporting_period_flag` BOOLEAN COMMENT 'Flag indicating whether this period is included in GASB financial statement reporting. True for periods that contribute to annual GASB-compliant financial statements for public institutions.',
    `gl_close_date` DATE COMMENT 'Actual calendar date when the General Ledger module was closed for this fiscal period. Null if the period is still open.',
    `gl_closed_by_user` STRING COMMENT 'Username or identifier of the user who performed the General Ledger close for this fiscal period.',
    `gl_status` STRING COMMENT 'Current open/closed status of the period for General Ledger module transactions. Open periods accept new journal entries; closed periods are locked for posting.. Valid values are `open|closed|future|locked`',
    `ipeds_reporting_year` STRING COMMENT 'The IPEDS reporting year to which this fiscal period maps for federal reporting purposes. IPEDS fiscal year typically runs July 1 through June 30 for most institutions.. Valid values are `^[0-9]{4}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fiscal period record was last updated or modified.',
    `nacubo_reporting_category` STRING COMMENT 'NACUBO reporting category or classification to which this fiscal period maps for benchmarking and comparative financial reporting purposes.',
    `period_description` STRING COMMENT 'Additional descriptive text or notes about the fiscal period, including any special circumstances, adjustments, or institutional context relevant to this period.',
    `period_end_date` DATE COMMENT 'Last calendar date of the fiscal period. Defines the end of the accounting period for transaction posting and reporting.',
    `period_name` STRING COMMENT 'Human-readable name or label for the fiscal period (e.g., July 2024, Period 01 FY2024, Year-End Adjustment Period).',
    `period_number` STRING COMMENT 'Sequential numeric identifier for the period within the fiscal year (e.g., 1 through 12 for monthly periods, or 1 through 13 for institutions with a 13th adjustment period).',
    `period_start_date` DATE COMMENT 'First calendar date of the fiscal period. Defines the beginning of the accounting period for transaction posting and reporting.',
    `period_status` STRING COMMENT 'Overall lifecycle status of the fiscal period record. Active periods are current or future; inactive periods are historical but accessible; archived periods are retained for compliance but not actively used.. Valid values are `active|inactive|archived`',
    `period_type` STRING COMMENT 'Classification of the fiscal period type. Regular periods are standard monthly/quarterly periods; adjustment periods are used for year-end entries; opening/closing periods mark fiscal year boundaries.. Valid values are `regular|adjustment|opening|closing`',
    `purchasing_close_date` DATE COMMENT 'Actual calendar date when the Purchasing module was closed for this fiscal period. Null if the period is still open.',
    `purchasing_status` STRING COMMENT 'Current open/closed status of the period for Purchasing module transactions. Controls whether purchase orders and requisitions can be posted to this period.. Valid values are `open|closed|future|locked`',
    `quarter_number` STRING COMMENT 'Fiscal quarter to which this period belongs within the fiscal year (1, 2, 3, or 4). Used for quarterly financial reporting and analysis.',
    `year_end_close_indicator` BOOLEAN COMMENT 'Flag indicating whether this period is designated as the year-end closing period for the fiscal year. True if this is the final period or adjustment period for fiscal year-end close activities.',
    CONSTRAINT pk_fiscal_period PRIMARY KEY(`fiscal_period_id`)
) COMMENT 'Institutional fiscal calendar reference data defining accounting periods, fiscal years, and key financial close dates. Captures fiscal year, fiscal period number, period name, period start date, period end date, open/closed status for each module (GL, AP, AR, purchasing), year-end close indicator, IPEDS reporting year alignment, and GASB reporting period flag. Serves as the authoritative fiscal calendar for all financial transactions and reporting across Oracle PeopleSoft Financials modules.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the institutional bank account record. Primary key for the bank account master data.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Bank accounts are assigned to organizational cost centers for budget and responsibility tracking. Adding cost_center_id FK allows joining to cost_center master for cost_center_name, hierarchy, manager',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Bank accounts are assigned to funds (self-balancing accounting entities) for fund accounting. Adding fund_id FK allows joining to finance_fund master for fund_name, fund_type, net_asset_classification',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Bank accounts map to GL cash accounts for general ledger integration. Adding gl_cash_ledger_account_id FK allows joining to ledger_account master for account_name, account_type, hierarchy, and classif',
    `account_closed_date` DATE COMMENT 'The date when the bank account was officially closed. Null for active accounts. Used for historical record-keeping and audit trail purposes.',
    `account_manager_email` STRING COMMENT 'The email address of the institutional employee responsible for managing this bank account. Used for notifications, workflow routing, and audit inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `account_manager_name` STRING COMMENT 'The name of the institutional employee responsible for managing this bank account, including reconciliation, transaction monitoring, and relationship coordination.',
    `account_name` STRING COMMENT 'The descriptive name or title assigned to the bank account for internal identification and reporting purposes (e.g., General Operating Account, Payroll Disbursement Account, Restricted Grant Account).',
    `account_number` STRING COMMENT 'The full bank account number assigned by the financial institution. Typically masked in reporting for security purposes. Used for deposits, disbursements, and reconciliation.',
    `account_number_masked` STRING COMMENT 'Partially masked version of the bank account number for display purposes (e.g., ****1234). Used in reports and user interfaces to protect sensitive financial data while maintaining reference capability.',
    `account_opened_date` DATE COMMENT 'The date when the bank account was originally opened with the financial institution. Used for account history tracking and relationship management.',
    `account_purpose` STRING COMMENT 'The primary business purpose or functional use of the bank account within institutional operations. Aligns with fund accounting and treasury management practices. [ENUM-REF-CANDIDATE: operating|payroll|disbursement|deposit|grant|endowment|auxiliary|agency|loan|construction — 10 candidates stripped; promote to reference product]',
    `account_status` STRING COMMENT 'Current lifecycle status of the bank account. Determines whether the account is available for transactions, reconciliation, and cash management operations.. Valid values are `active|inactive|closed|frozen|pending_closure|suspended`',
    `account_type` STRING COMMENT 'Classification of the bank account based on its financial instrument type. Determines transaction capabilities, interest accrual, and liquidity characteristics. [ENUM-REF-CANDIDATE: checking|savings|money_market|sweep|payroll|restricted|investment|escrow — 8 candidates stripped; promote to reference product]',
    `ach_enabled_flag` BOOLEAN COMMENT 'Indicates whether the account is enabled for ACH transactions (direct deposits, electronic payments). Critical for payroll, vendor payments, and student refunds.',
    `authorized_signatories` STRING COMMENT 'Comma-separated list of names or identifiers of individuals authorized to sign checks, initiate wire transfers, or approve transactions on this account. Critical for internal controls and segregation of duties.',
    `available_balance` DECIMAL(18,2) COMMENT 'The available balance in the account after accounting for outstanding checks, pending deposits, and holds. Represents funds available for immediate disbursement.',
    `bank_branch_address` STRING COMMENT 'The physical street address of the bank branch where the account is held. Used for correspondence and audit documentation.',
    `bank_branch_name` STRING COMMENT 'The name or identifier of the specific bank branch where the account is maintained. Used for relationship management and service coordination.',
    `bank_contact_email` STRING COMMENT 'The email address of the bank relationship manager or account representative for electronic communication regarding account matters.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `bank_contact_name` STRING COMMENT 'The name of the primary relationship manager or account representative at the financial institution responsible for this account.',
    `bank_contact_phone` STRING COMMENT 'The telephone number of the bank relationship manager or account representative for account inquiries and issue resolution.',
    `bank_name` STRING COMMENT 'The legal name of the financial institution where the account is held (e.g., Bank of America, Wells Fargo, PNC Bank).',
    `bank_routing_number` STRING COMMENT 'The nine-digit American Bankers Association (ABA) routing transit number that identifies the financial institution for electronic funds transfers, wire transfers, and ACH transactions.. Valid values are `^[0-9]{9}$`',
    `collateral_type` STRING COMMENT 'The type of collateral pledged by the financial institution to secure deposits (e.g., US Treasury securities, agency securities, municipal bonds). Used for risk assessment and compliance monitoring.',
    `collateral_value` DECIMAL(18,2) COMMENT 'The current market value of collateral pledged by the financial institution to secure deposits. Must meet or exceed required collateralization percentage per institutional policy.',
    `collateralization_required_flag` BOOLEAN COMMENT 'Indicates whether the financial institution is required to provide collateral for deposits exceeding FDIC insurance limits. Common for large public fund deposits per state law.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this bank account record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code representing the denomination of the bank account (e.g., USD for US Dollar, EUR for Euro, GBP for British Pound). Most institutional accounts are USD.. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'The current available balance in the bank account as of the last reconciliation or bank statement. Used for cash management and liquidity monitoring.',
    `dual_signature_threshold` DECIMAL(18,2) COMMENT 'The transaction amount threshold above which dual signatures are required for disbursements. Used to enforce internal control policies and mitigate fraud risk.',
    `fdic_coverage_amount` DECIMAL(18,2) COMMENT 'The maximum amount of FDIC insurance coverage applicable to this account (typically $250,000 per depositor per institution). Used for risk assessment and collateralization monitoring.',
    `fdic_insured_flag` BOOLEAN COMMENT 'Indicates whether the bank account is covered by FDIC insurance up to the statutory limit. Critical for risk management and investment policy compliance.',
    `interest_accrual_method` STRING COMMENT 'The frequency and method by which interest is calculated and credited to the account. Determines timing of interest income recognition.. Valid values are `daily|monthly|quarterly|annual|none`',
    `interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate percentage applied to the account balance for interest-bearing accounts. Expressed as a decimal (e.g., 0.0250 for 2.50%).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this bank account record was most recently updated. Used for change tracking and audit compliance.',
    `last_reconciliation_date` DATE COMMENT 'The date when the most recent bank reconciliation was completed for this account. Used to monitor compliance with reconciliation policies and identify overdue reconciliations.',
    `minimum_balance_required` DECIMAL(18,2) COMMENT 'The minimum balance that must be maintained in the account to avoid fees or meet contractual requirements with the financial institution.',
    `next_reconciliation_due_date` DATE COMMENT 'The date by which the next bank reconciliation must be completed based on the reconciliation frequency policy. Used for workflow management and compliance monitoring.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or contextual information about the bank account. Used for documentation of unique account characteristics or restrictions.',
    `online_banking_enabled_flag` BOOLEAN COMMENT 'Indicates whether online banking access is enabled for this account. Determines availability of electronic statements, transaction history, and real-time balance inquiries.',
    `positive_pay_enabled_flag` BOOLEAN COMMENT 'Indicates whether positive pay fraud prevention service is enabled for this account. Matches issued checks against presented checks to prevent fraudulent payments.',
    `reconciliation_frequency` STRING COMMENT 'The required frequency for performing bank reconciliation procedures to match institutional records with bank statements. Critical for internal controls and audit compliance.. Valid values are `daily|weekly|monthly|quarterly`',
    `signatory_requirement` STRING COMMENT 'The number of authorized signatures required to approve transactions above specified thresholds. Supports internal control policies and fraud prevention.. Valid values are `single|dual|triple`',
    `wire_transfer_enabled_flag` BOOLEAN COMMENT 'Indicates whether the account is enabled for domestic and international wire transfers. Used for large-value payments, grant disbursements, and international transactions.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Institutional bank account master record for all depository and disbursement accounts maintained by the institution. Captures bank name, bank routing number, account number (masked), account type (checking, money market, sweep, payroll, restricted), account purpose, currency, bank contact, authorized signatories, reconciliation frequency, and active status. Supports bank reconciliation, cash management, and treasury operations in PeopleSoft Financials.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key for institutional capitalized property, plant, and equipment tracking.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: Fixed assets are typically acquired through vendor invoices processed via accounts payable. While fixed_asset already has purchase_order_id linking to the PO, the AP invoice is the actual payment docu',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Fixed assets are placed in service during a specific fiscal period, which determines the start of depreciation calculations, GASB reporting period, and capitalization timing. The fixed_asset table has',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fixed assets are assigned to custodial cost centers for responsibility tracking. Adding custodial_cost_center_id FK allows joining to cost_center master for cost_center_name, hierarchy, manager, and b',
    `donor_id` BIGINT COMMENT 'Reference to the individual or organization that donated funds or the asset itself. Used for stewardship reporting and recognition when funding source is gift.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to facility.asset. Business justification: The finance fixed asset register and facilities asset inventory must reconcile for GASB 34/35 capital asset reporting and annual physical inventory audits. Higher-ed controllers and facilities directo',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Fixed assets need structured building location for physical inventory audits, insurance valuation, capital planning, and asset disposal processes. The existing building_code text field should be repla',
    `room_id` BIGINT COMMENT 'Foreign key linking to facility.room. Business justification: Equipment and movable assets require room-level location tracking for annual physical inventory audits, asset transfers, theft prevention, and custodial responsibility. Room-level precision is essenti',
    `grant_account_id` BIGINT COMMENT 'Reference to the sponsored research grant or award that funded the asset acquisition. Required for federal and sponsor compliance reporting when funding source is grant.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Fixed assets must be associated with a GL ledger account (e.g., asset account code for PP&E, accumulated depreciation account). This FK enables proper capitalization accounting, GASB 34/35 reporting, ',
    `capital_project_id` BIGINT COMMENT 'Foreign key linking to facility.capital_project. Business justification: Fixed assets created through capital construction or renovation projects must reference the originating project for capitalization closeout, project-to-asset transfer reporting, and GASB 34 infrastruc',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Capitalization policies define thresholds, useful life tables, depreciation methods, and disposal procedures. Controllers enforce policy for GASB 34/35 compliance and financial statement accuracy. Pol',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to finance.purchase_order. Business justification: Fixed assets are acquired via purchase orders. Adding purchase_order_id FK allows joining to purchase_order for PO details, vendor, dates, and approval information. Removes redundant purchase_order_nu',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Federally-funded equipment is subject to specific regulatory requirements (2 CFR 200.313 equipment management, export control regulations for research equipment). Fixed asset managers must track which',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to finance.vendor. Business justification: Fixed assets are acquired from vendors. Adding vendor_id FK allows joining to vendor master for legal_name, contact information, payment terms, and vendor classification attributes. Removes redundant ',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since acquisition. Contra-asset account that reduces the gross book value to calculate net book value.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total capitalized cost of the asset including purchase price, freight, installation, and other costs necessary to place the asset into service. Historical cost basis for depreciation.',
    `acquisition_date` DATE COMMENT 'Date the institution obtained legal ownership or placed the asset into service, whichever is earlier. Used as the starting point for depreciation calculation.',
    `asset_category` STRING COMMENT 'Primary classification of the fixed asset type for depreciation, reporting, and GASB 34 compliance. Determines capitalization threshold and useful life assignment.. Valid values are `land|buildings|equipment|library_collections|software|construction_in_progress`',
    `asset_description` STRING COMMENT 'Detailed narrative description of the fixed asset including make, model, specifications, and distinguishing characteristics for identification and inventory purposes.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the asset indicating its operational state and availability for use. Drives depreciation continuation and inventory reporting. [ENUM-REF-CANDIDATE: active|in_storage|under_repair|retired|disposed|missing|transferred — 7 candidates stripped; promote to reference product]',
    `asset_subcategory` STRING COMMENT 'Secondary classification providing granular detail within the primary asset category (e.g., laboratory equipment, instructional technology, administrative software, rare books).',
    `asset_tag_number` STRING COMMENT 'Externally visible unique identifier affixed to physical asset for inventory control and tracking. Barcode or RFID tag number used in physical audits.. Valid values are `^[A-Z0-9]{6,20}$`',
    `capitalization_threshold_met` BOOLEAN COMMENT 'Indicates whether the asset acquisition cost met or exceeded the institutional capitalization threshold policy. Determines if asset is capitalized or expensed.',
    `condition_assessment` STRING COMMENT 'Qualitative evaluation of the asset physical condition and operational functionality recorded during physical inventory or maintenance inspection.. Valid values are `excellent|good|fair|poor|obsolete`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the fixed asset record was first created in the asset management system. Audit trail for data governance and compliance.',
    `custodian_email` STRING COMMENT 'Email address of the assigned custodian for asset verification notifications and inventory audit communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `custodian_name` STRING COMMENT 'Name of the faculty or staff member assigned primary responsibility for the asset. Contact person for physical verification and condition assessment.',
    `depreciation_method` STRING COMMENT 'Accounting method used to allocate the cost of the asset over its useful life. Straight-line is standard for higher education institutions per GASB guidance.. Valid values are `straight_line|declining_balance|units_of_production|none`',
    `disposal_date` DATE COMMENT 'Date the asset was removed from service through sale, donation, trade-in, or retirement. Triggers final depreciation calculation and gain/loss recognition.',
    `disposal_method` STRING COMMENT 'Method by which the asset was removed from institutional inventory. Required for financial reporting and compliance with property disposition regulations. [ENUM-REF-CANDIDATE: sale|donation|trade_in|scrap|theft|casualty_loss|transfer — 7 candidates stripped; promote to reference product]',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Cash or fair market value received from the disposal of the asset. Used to calculate gain or loss on disposal for financial statement reporting.',
    `federal_property_indicator` BOOLEAN COMMENT 'Indicates whether the asset was acquired with federal funds and remains subject to federal property management requirements and disposition approval per OMB Uniform Guidance.',
    `funding_source` STRING COMMENT 'Primary source of funds used to acquire the asset. Critical for grant compliance, donor stewardship, and facilities and administrative (F&A) cost rate calculations.. Valid values are `institutional|grant|gift|bond|state_appropriation|federal`',
    `gasb_classification` STRING COMMENT 'GASB Statement 34 capital asset classification code for external financial reporting. Maps institutional asset categories to standardized government reporting requirements.',
    `in_service_date` DATE COMMENT 'Date the asset was placed into active operational use. May differ from acquisition date for assets requiring installation or construction completion.',
    `insurance_required` BOOLEAN COMMENT 'Indicates whether the asset requires specific insurance coverage beyond general institutional property insurance due to high value, portability, or specialized nature.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the fixed asset record was most recently updated. Tracks data currency and supports change audit requirements.',
    `last_physical_inventory_date` DATE COMMENT 'Date of the most recent physical verification of the asset location and condition. Required for audit compliance and inventory accuracy certification.',
    `lease_indicator` BOOLEAN COMMENT 'Indicates whether the asset is leased rather than owned. Triggers different accounting treatment under GASB 87 lease accounting standards.',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactured or produced the asset. Used for warranty claims, maintenance contracts, and vendor management.',
    `model_number` STRING COMMENT 'Manufacturer model or part number identifying the specific product configuration. Essential for replacement parts ordering and technical support.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the asset calculated as acquisition cost minus accumulated depreciation. Represents the undepreciated portion reported on the balance sheet.',
    `notes` STRING COMMENT 'Free-form text field for additional information about the asset including special handling requirements, historical significance, donor restrictions, or unique characteristics.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. Subtracted from acquisition cost to determine the depreciable base.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number for equipment identification, warranty tracking, and theft recovery. Critical for high-value technology and scientific equipment.',
    `title_holder` STRING COMMENT 'Legal owner of the asset. May differ from custodian for federally-owned equipment, leased assets, or property with donor restrictions on title transfer.. Valid values are `institution|federal_government|state_government|donor|lessor`',
    `useful_life_years` STRING COMMENT 'Expected service life of the asset in years as determined by institutional policy and GASB guidelines. Used to calculate annual depreciation expense.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or vendor warranty coverage ends. Used to plan maintenance contract purchases and budget for repair costs.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Institutional fixed asset master record for capitalized property, plant, and equipment. Captures asset tag number, asset description, asset category (land, buildings, equipment, library collections, software, construction in progress), acquisition date, acquisition cost, funding source (institutional, grant, gift), useful life, depreciation method (straight-line), accumulated depreciation, net book value, physical location (building/room), custodial department, disposal date, and GASB 34 capital asset classification. Sourced from Oracle PeopleSoft Financials Asset Management module.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`ap_payment_application` (
    `ap_payment_application_id` BIGINT COMMENT 'Primary key for the ap_payment_application association',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to the vendor invoice being settled by this payment application.',
    `ap_payment_id` BIGINT COMMENT 'Foreign key linking to the accounts payable payment disbursement record that is being applied.',
    `amount_applied` DECIMAL(18,2) COMMENT 'The portion of the payment amount applied to this specific invoice. Belongs to the application record because a single payment may be split across multiple invoices and a single invoice may receive partial payments from multiple disbursements.',
    `application_status` STRING COMMENT 'Current status of this payment application record (e.g., applied, reversed, pending, voided). Belongs to the application record because a payment application can be reversed independently of the payment or invoice status.',
    `discount_taken_amount` DECIMAL(18,2) COMMENT 'The early payment discount amount captured at the time of this specific payment application against this invoice. Belongs to the application record because the discount is realized per invoice per payment event, not at the payment or invoice level alone.',
    `invoice_count` STRING COMMENT 'The number of vendor invoices paid by this single payment disbursement. Supports batch payment analysis. [Moved from ap_payment: invoice_count on ap_payment is a derived aggregate (count of invoices paid by this payment) that becomes redundant and computable once the ap_payment_application association table exists. It does not belong on the payment record itself — it is a property of the payment-to-invoice relationship set, derivable via COUNT(*) on ap_payment_application grouped by ap_payment_id.]',
    `payment_application_date` DATE COMMENT 'The date on which this payment was applied to this invoice in the AP system. Belongs to the application record as it records when the settlement event occurred for this specific payment-invoice pairing.',
    CONSTRAINT pk_ap_payment_application PRIMARY KEY(`ap_payment_application_id`)
) COMMENT 'This association product represents the Payment Application event between ap_payment and ap_invoice. It captures the operational record of how a specific payment disbursement is applied against a specific vendor invoice, including the amount applied, any discount taken at application time, the application date, and the application status. Each record links one ap_payment to one ap_invoice and is the authoritative source for vendor ledger reconciliation, audit compliance, and cash flow reporting in the institutional accounts payable process.. Existence Justification: In accounts payable operations, a single payment disbursement (ap_payment) routinely settles multiple vendor invoices simultaneously — this is the standard payment run process in ERP systems like Oracle PeopleSoft. Conversely, a single invoice can be partially paid across multiple payment disbursements (partial payments, installment arrangements, or split payment runs). The business actively manages this payment application process, tracking exactly how much of each payment was applied to each invoice, with its own attributes (amount_applied, discount_taken, application_date, status) that belong to neither the payment nor the invoice alone.';

CREATE OR REPLACE TABLE `education_ecm`.`finance`.`ar_receipt_application` (
    `ar_receipt_application_id` BIGINT COMMENT 'Primary key for the ar_receipt_application association',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to the AR invoice being satisfied by this application. Identifies which outstanding invoice is being reduced by this cash application.',
    `ar_receipt_id` BIGINT COMMENT 'Foreign key linking to the cash receipt being applied. Identifies which payment transaction is the source of funds for this application.',
    `application_date` DATE COMMENT 'The date on which this specific receipt-to-invoice application was posted in the AR system. May differ from the receipt date (when payment was received) and the invoice date. Required for period-accurate AR aging and sponsored program reporting.',
    `application_status` STRING COMMENT 'Lifecycle status of this specific receipt-to-invoice application record. Tracks whether the application is fully posted, partially applied, or has been reversed (e.g., due to a returned check or correction). Belongs to the application event, not to the receipt or invoice independently.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the receipt amount applied to this specific invoice in this application record. Belongs to the application event, not to the receipt total or the invoice balance alone. Summing applied_amount across all applications for a receipt yields the receipts total applied amount; summing across all applications for an invoice yields amount_paid.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount granted on this specific receipt-to-invoice application (e.g., early payment discount). Distinct from the receipt-level discount_amount aggregate and the invoice-level discount_amount. Belongs to the application event.',
    `invoice_references` STRING COMMENT 'Comma-separated list or concatenated string of invoice numbers to which this receipt has been applied, for quick reference and reporting. [Moved from ar_receipt: This STRING column is a denormalized workaround storing multiple invoice numbers as a comma-separated list. Its data is fully replaced by the ar_receipt_application association table, where each receipt-to-invoice link is a proper relational row. Removing this column eliminates the normalization violation and enables proper FK-based querying, reporting, and audit tracing.]',
    CONSTRAINT pk_ar_receipt_application PRIMARY KEY(`ar_receipt_application_id`)
) COMMENT 'This association product represents the Cash Application event between ar_receipt and ar_invoice. It captures the operational record of how a specific cash receipt is applied — in full or in part — against a specific AR invoice, including the amount applied, any discount granted, the application date, and the lifecycle status of the application. Each record links one ar_receipt to one ar_invoice and carries attributes that exist only in the context of this receipt-to-invoice application. Required for GASB compliance, sponsored program financial reporting, and AR aging accuracy.. Existence Justification: In higher-education AR operations, a single cash receipt (e.g., a lump-sum payment from a government sponsor) is routinely applied across multiple outstanding invoices simultaneously, and a single invoice can receive partial payments from multiple separate receipts over its lifecycle. This is the standard cash application or receipt application process in Oracle PeopleSoft AR. The relationship is actively managed by AR staff who create, update, and close application records — it is not derivable from joins alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ADD CONSTRAINT `fk_finance_ledger_account_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ADD CONSTRAINT `fk_finance_ledger_account_parent_account_ledger_account_id` FOREIGN KEY (`parent_account_ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ADD CONSTRAINT `fk_finance_finance_fund_parent_fund_finance_fund_id` FOREIGN KEY (`parent_fund_finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_primary_reversed_by_journal_journal_entry_id` FOREIGN KEY (`primary_reversed_by_journal_journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_line` ADD CONSTRAINT `fk_finance_journal_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_line` ADD CONSTRAINT `fk_finance_journal_line_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_line` ADD CONSTRAINT `fk_finance_journal_line_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_line` ADD CONSTRAINT `fk_finance_journal_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_line` ADD CONSTRAINT `fk_finance_journal_line_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`finance`.`journal_line` ADD CONSTRAINT `fk_finance_journal_line_reversed_journal_line_id` FOREIGN KEY (`reversed_journal_line_id`) REFERENCES `education_ecm`.`finance`.`journal_line`(`journal_line_id`);
ALTER TABLE `education_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`finance`.`vendor` ADD CONSTRAINT `fk_finance_vendor_parent_vendor_finance_vendor_id` FOREIGN KEY (`parent_vendor_finance_vendor_id`) REFERENCES `education_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ADD CONSTRAINT `fk_finance_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `education_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ADD CONSTRAINT `fk_finance_purchase_order_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ADD CONSTRAINT `fk_finance_purchase_order_line_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ADD CONSTRAINT `fk_finance_purchase_order_line_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ADD CONSTRAINT `fk_finance_purchase_order_line_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ADD CONSTRAINT `fk_finance_purchase_order_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `education_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `education_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `education_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `education_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ADD CONSTRAINT `fk_finance_ap_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `education_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ADD CONSTRAINT `fk_finance_ar_invoice_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `education_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ADD CONSTRAINT `fk_finance_ar_receipt_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `education_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`finance`.`grant_account` ADD CONSTRAINT `fk_finance_grant_account_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_finance_fund_id` FOREIGN KEY (`finance_fund_id`) REFERENCES `education_ecm`.`finance`.`finance_fund`(`finance_fund_id`);
ALTER TABLE `education_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `education_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_fiscal_period_id` FOREIGN KEY (`fiscal_period_id`) REFERENCES `education_ecm`.`finance`.`fiscal_period`(`fiscal_period_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `education_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_grant_account_id` FOREIGN KEY (`grant_account_id`) REFERENCES `education_ecm`.`finance`.`grant_account`(`grant_account_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_ledger_account_id` FOREIGN KEY (`ledger_account_id`) REFERENCES `education_ecm`.`finance`.`ledger_account`(`ledger_account_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `education_ecm`.`finance`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `education_ecm`.`finance`.`vendor`(`vendor_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_payment_application` ADD CONSTRAINT `fk_finance_ap_payment_application_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `education_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `education_ecm`.`finance`.`ap_payment_application` ADD CONSTRAINT `fk_finance_ap_payment_application_ap_payment_id` FOREIGN KEY (`ap_payment_id`) REFERENCES `education_ecm`.`finance`.`ap_payment`(`ap_payment_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_receipt_application` ADD CONSTRAINT `fk_finance_ar_receipt_application_ar_invoice_id` FOREIGN KEY (`ar_invoice_id`) REFERENCES `education_ecm`.`finance`.`ar_invoice`(`ar_invoice_id`);
ALTER TABLE `education_ecm`.`finance`.`ar_receipt_application` ADD CONSTRAINT `fk_finance_ar_receipt_application_ar_receipt_id` FOREIGN KEY (`ar_receipt_id`) REFERENCES `education_ecm`.`finance`.`ar_receipt`(`ar_receipt_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `education_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `parent_account_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Ledger Account Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `account_description` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Description');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `account_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Account Owner Email Address');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `account_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `account_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `account_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `account_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Account Owner Name');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Status');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `account_subtype` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Subtype');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Type');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|net_position|revenue|expense');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `budget_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Control Flag');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `budget_pool_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Pool Flag');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `cash_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash Account Flag');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `encumbrance_flag` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Flag');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `fa_rate_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Facilities and Administrative (F&A) Rate Eligible Flag');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `fasb_classification` SET TAGS ('dbx_business_glossary_term' = 'Financial Accounting Standards Board (FASB) Classification');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `fiscal_year_created` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Created');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `fiscal_year_created` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `gasb_classification` SET TAGS ('dbx_business_glossary_term' = 'Governmental Accounting Standards Board (GASB) Classification');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `grant_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Grant Eligible Flag');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Level');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `ipeds_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reporting Category');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `nacubo_function_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of College and University Business Officers (NACUBO) Functional Expense Category Code');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `nacubo_function_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `normal_balance` SET TAGS ('dbx_business_glossary_term' = 'Normal Balance Indicator');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `normal_balance` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `reconciliation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Required Flag');
ALTER TABLE `education_ecm`.`finance`.`ledger_account` ALTER COLUMN `statistical_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Account Flag');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `parent_fund_finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Fund Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `account_string_segment` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account String Segment');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `account_string_segment` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,30}$');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `allow_deficit_spending` SET TAGS ('dbx_business_glossary_term' = 'Allow Deficit Spending Flag');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `balance` SET TAGS ('dbx_business_glossary_term' = 'Fund Balance');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `carryforward_allowed` SET TAGS ('dbx_business_glossary_term' = 'Carryforward Allowed Flag');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Closure Date');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `encumbrance_amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Amount');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `endowment_principal` SET TAGS ('dbx_business_glossary_term' = 'Endowment Principal');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `establishment_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Establishment Date');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `expenditure_to_date` SET TAGS ('dbx_business_glossary_term' = 'Expenditure to Date');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `external_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'External Reporting Required Flag');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Name');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_business_glossary_term' = 'Fund Status');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended|pending_approval');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_value_regex' = 'current_unrestricted|current_restricted|endowment|plant|loan|agency');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Facilities and Administrative (F&A) Indirect Cost Rate (IDC)');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `net_asset_classification` SET TAGS ('dbx_business_glossary_term' = 'Governmental Accounting Standards Board (GASB) Net Asset Classification');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `net_asset_classification` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fund Notes');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `purpose_description` SET TAGS ('dbx_business_glossary_term' = 'Fund Purpose Description');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Category');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'none|donor_restricted|sponsor_restricted|board_designated|regulatory_restricted|time_restricted');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `revenue_to_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue to Date');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `spending_rate` SET TAGS ('dbx_business_glossary_term' = 'Endowment Spending Rate');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `sponsoring_entity` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Entity');
ALTER TABLE `education_ecm`.`finance`.`finance_fund` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Specialized Accreditation Body');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `cip_code` SET TAGS ('dbx_business_glossary_term' = 'Classification of Instructional Programs (CIP) Code');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `cip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{4}$');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|suspended');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'academic_department|administrative_unit|research_center|service_unit|auxiliary_enterprise|capital_project');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `degrees_awarded_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Degrees Awarded');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `faculty_fte` SET TAGS ('dbx_business_glossary_term' = 'Faculty Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_category` SET TAGS ('dbx_business_glossary_term' = 'Functional Category');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `fund_source_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Fund Source');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `fund_source_primary` SET TAGS ('dbx_value_regex' = 'general_fund|restricted_fund|designated_fund|auxiliary_fund|endowment_fund|grant_fund');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `grant_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Grant Eligible Flag');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Organizational Hierarchy Level');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (IDC) or Facilities and Administrative (F&A) Rate');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `majors_enrolled_count` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Majors Count');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Notes');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `research_classification` SET TAGS ('dbx_business_glossary_term' = 'Research Classification');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `research_classification` SET TAGS ('dbx_value_regex' = 'basic_research|applied_research|development|non_research');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Short Name');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `space_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Assignable Square Feet (ASF)');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `staff_fte` SET TAGS ('dbx_business_glossary_term' = 'Staff Full-Time Equivalent (FTE)');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `student_credit_hours_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Student Credit Hours (SCH)');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `education_ecm`.`finance`.`cost_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `primary_journal_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `primary_reversed_by_journal_journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed By Journal Entry Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `budget_check_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Check Status');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `budget_check_status` SET TAGS ('dbx_value_regex' = 'PASSED|FAILED|BYPASSED|NOT_APPLICABLE');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `encumbrance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Indicator');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Indicator');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_category` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Category');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_category` SET TAGS ('dbx_value_regex' = 'OPERATING|CAPITAL|ENDOWMENT|RESTRICTED|UNRESTRICTED|AGENCY');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_date` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Date');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Description');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_number` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Number');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_number` SET TAGS ('dbx_value_regex' = '^JE[0-9]{8,12}$');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_source` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Source System');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_type` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Type');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_type` SET TAGS ('dbx_value_regex' = 'STANDARD|ADJUSTING|CLOSING|REVERSING|RECURRING|STATISTICAL');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `posted_date` SET TAGS ('dbx_business_glossary_term' = 'Posted Date');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'DRAFT|PENDING_APPROVAL|APPROVED|POSTED|REJECTED|CANCELLED');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `education_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Amount');
ALTER TABLE `education_ecm`.`finance`.`journal_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`finance`.`journal_line` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `journal_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Line Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `reversed_journal_line_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Journal Line Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `tertiary_journal_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `tertiary_journal_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `tertiary_journal_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `accounting_date` SET TAGS ('dbx_business_glossary_term' = 'Accounting Date');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Code');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `activity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'regular|prior_period|year_end_close|audit|reclassification|correction');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `budget_check_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Check Status');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `budget_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|bypassed|not_applicable');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `budget_period_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Code');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `budget_period_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `chartfield_combination_valid_indicator` SET TAGS ('dbx_business_glossary_term' = 'Chartfield Combination Valid Indicator');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `encumbrance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Indicator');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `functional_currency_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Credit Amount');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `functional_currency_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Debit Amount');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost (IDC) Rate');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `intercompany_affiliate_code` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Affiliate Code');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `intercompany_affiliate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `posted_date` SET TAGS ('dbx_business_glossary_term' = 'Posted Date');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|pending|posted|error|reversed');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `project_grant_code` SET TAGS ('dbx_business_glossary_term' = 'Project/Grant Code');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `project_grant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `statistical_amount` SET TAGS ('dbx_business_glossary_term' = 'Statistical Amount');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `statistical_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Statistical Unit of Measure');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `statistical_unit_of_measure` SET TAGS ('dbx_value_regex' = 'FTE|credit_hours|square_feet|headcount|enrollments|other');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `education_ecm`.`finance`.`journal_line` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Manager Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `actual_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Expenditure Amount');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Balance');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|closed|cancelled');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'operating|capital|grant|auxiliary|restricted|unrestricted');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `budgeted_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Amount');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `carry_forward_amount` SET TAGS ('dbx_business_glossary_term' = 'Carry Forward Amount');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `encumbrance_balance` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Balance');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `fte_count` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Count');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (IDC) / Facilities and Administrative (F&A) Rate');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `is_restricted` SET TAGS ('dbx_business_glossary_term' = 'Is Restricted Flag');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `is_salary_budget` SET TAGS ('dbx_business_glossary_term' = 'Is Salary Budget Flag');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `is_salary_budget` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `is_salary_budget` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `last_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revision Date');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `narrative` SET TAGS ('dbx_business_glossary_term' = 'Budget Narrative');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `pool_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Pool Code');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `education_ecm`.`finance`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'original|revised|final|working|proposed');
ALTER TABLE `education_ecm`.`finance`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`finance`.`vendor` SET TAGS ('dbx_subdomain' = 'payables_procurement');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Vendor ID');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `parent_vendor_finance_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Vendor ID');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Activation Date');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `bank_account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `bank_account_type` SET TAGS ('dbx_value_regex' = 'checking|savings');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `bank_account_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `bank_account_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Default Currency Code');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|GBP|EUR|JPY|AUD');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `debarment_check_date` SET TAGS ('dbx_business_glossary_term' = 'Debarment Check Date');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `debarment_status` SET TAGS ('dbx_business_glossary_term' = 'Debarment Status');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `debarment_status` SET TAGS ('dbx_value_regex' = 'clear|debarred|suspended|proposed_debarment');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `inactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Inactivation Date');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `minority_owned` SET TAGS ('dbx_business_glossary_term' = 'Minority-Owned Business Enterprise (MBE) Flag');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notes');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire_transfer|check|credit_card|procurement_card');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Remittance Address Line 1');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Remittance Address Line 2');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_city` SET TAGS ('dbx_business_glossary_term' = 'Remittance City');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_country` SET TAGS ('dbx_business_glossary_term' = 'Remittance Country');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Remittance Postal Code');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_state` SET TAGS ('dbx_business_glossary_term' = 'Remittance State or Province');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `remittance_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `requires_1099` SET TAGS ('dbx_business_glossary_term' = '1099 Reporting Required Flag');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `small_business` SET TAGS ('dbx_business_glossary_term' = 'Small Business Flag');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Type');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_value_regex' = 'EIN|SSN|ITIN');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `vendor_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Number');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `veteran_owned` SET TAGS ('dbx_business_glossary_term' = 'Veteran-Owned Business Flag');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `w9_received_date` SET TAGS ('dbx_business_glossary_term' = 'W-9 Received Date');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `w9_status` SET TAGS ('dbx_business_glossary_term' = 'W-9 Form Status');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `w9_status` SET TAGS ('dbx_value_regex' = 'received|pending|expired|not_required');
ALTER TABLE `education_ecm`.`finance`.`vendor` ALTER COLUMN `women_owned` SET TAGS ('dbx_business_glossary_term' = 'Women-Owned Business Enterprise (WBE) Flag');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` SET TAGS ('dbx_subdomain' = 'payables_procurement');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending|approved|rejected|returned');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `encumbrance_amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Amount');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `fob_point` SET TAGS ('dbx_business_glossary_term' = 'Free On Board (FOB) Point');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `fob_point` SET TAGS ('dbx_value_regex' = 'origin|destination');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Amount');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Notes');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^PO[0-9]{8}$');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|contract|standing|emergency');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `received_amount` SET TAGS ('dbx_business_glossary_term' = 'Received Amount');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Ship To Address Line 1');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_business_glossary_term' = 'Ship To City');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_business_glossary_term' = 'Ship To Country');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ship_to_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ship_to_location` SET TAGS ('dbx_business_glossary_term' = 'Ship To Location');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Ship To Postal Code');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ship_to_state` SET TAGS ('dbx_business_glossary_term' = 'Ship To State');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ship_to_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `ship_to_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Amount');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `total_amount_with_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Amount With Tax');
ALTER TABLE `education_ecm`.`finance`.`purchase_order` ALTER COLUMN `vendor_site_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Code');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` SET TAGS ('dbx_subdomain' = 'payables_procurement');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Identifier');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Identifier');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Identifier');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `cancelled_date` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Date');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `encumbrance_amount` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Amount');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `extended_amount` SET TAGS ('dbx_business_glossary_term' = 'Extended Amount');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `inspection_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Indicator');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `item_code` SET TAGS ('dbx_business_glossary_term' = 'Item Identifier');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Status');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|closed|cancelled');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `liquidated_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Amount');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `need_by_date` SET TAGS ('dbx_business_glossary_term' = 'Need By Date');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `quantity_invoiced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Invoiced');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `receipt_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Receipt Required Indicator');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `education_ecm`.`finance`.`purchase_order_line` ALTER COLUMN `vendor_item_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Number');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'payables_procurement');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Event Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_due_date` SET TAGS ('dbx_business_glossary_term' = 'Discount Due Date');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `form_1099_amount` SET TAGS ('dbx_business_glossary_term' = 'Form 1099 Amount');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `form_1099_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Form 1099 Reportable Flag');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gross_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_received_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|recurring');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'not_matched|two_way_matched|three_way_matched|forced_match');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `net_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|wire|credit_card|procurement_card');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `remit_to_location` SET TAGS ('dbx_business_glossary_term' = 'Remit To Location');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `education_ecm`.`finance`.`ap_invoice` ALTER COLUMN `voucher_number` SET TAGS ('dbx_business_glossary_term' = 'Voucher Number');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` SET TAGS ('dbx_subdomain' = 'payables_procurement');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Payment ID');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Cleared Date');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `discount_taken_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken Amount');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Approval Date');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|eft|wire_transfer|credit_card|pcard');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Payment Source System');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'issued|cleared|voided|stale_dated|cancelled|pending');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'regular|refund|advance|reimbursement|petty_cash');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Reconciliation Date');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Reconciliation Status');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|outstanding|exception');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `remittance_advice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Date');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `remittance_advice_sent_indicator` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Sent Indicator');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `tax_reporting_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Indicator');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `vendor_site_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Code');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Void Date');
ALTER TABLE `education_ecm`.`finance`.`ap_payment` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` SET TAGS ('dbx_subdomain' = 'receivables_banking');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Invoice Identifier');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `room_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Room Booking Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `amount_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Amount Outstanding');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `ar_invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Phone Number');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'open|partially_paid|paid|written_off|cancelled|disputed');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|recurring');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|wire_transfer|ach|credit_card|electronic_funds_transfer');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `revenue_account_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Account Code');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `revenue_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `writeoff_date` SET TAGS ('dbx_business_glossary_term' = 'Write-off Date');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `writeoff_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-off Reason');
ALTER TABLE `education_ecm`.`finance`.`ar_invoice` ALTER COLUMN `writeoff_reason` SET TAGS ('dbx_value_regex' = 'bankruptcy|customer_dispute|uncollectible|administrative_error|goodwill_adjustment');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` SET TAGS ('dbx_subdomain' = 'receivables_banking');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `ar_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Receipt ID');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `primary_ar_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer ID');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `primary_ar_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `primary_ar_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `bank_deposit_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Deposit Reference');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Date');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'online_portal|mail|in_person|phone|mobile_app|bank_transfer');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|wire_transfer|ach|credit_card|cash|lockbox');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `posted_date` SET TAGS ('dbx_business_glossary_term' = 'Posted Date');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `preparer_name` SET TAGS ('dbx_business_glossary_term' = 'Preparer Name');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `receipt_amount` SET TAGS ('dbx_business_glossary_term' = 'Receipt Amount');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|voided|reconciled|unreconciled');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Reconciliation Status');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|pending|exception');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `remittance_advice` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `education_ecm`.`finance`.`grant_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`finance`.`grant_account` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Department Identifier');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator (PI) Identifier');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Email Address');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `account_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Name');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `account_setup_date` SET TAGS ('dbx_business_glossary_term' = 'Account Setup Date');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Status');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|closed');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `award_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Award Notice Date');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Date');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `cost_sharing_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Amount');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `cost_sharing_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Required Indicator');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `current_budget_period_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Budget Period Amount');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `current_budget_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Current Budget Period End Date');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `current_budget_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Current Budget Period Start Date');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `fa_base_type` SET TAGS ('dbx_business_glossary_term' = 'Facilities and Administrative (F&A) Base Type');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `fa_base_type` SET TAGS ('dbx_value_regex' = 'MTDC|TDC|salaries_wages|other');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `fa_rate` SET TAGS ('dbx_business_glossary_term' = 'Facilities and Administrative (F&A) Rate');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `federal_award_indicator` SET TAGS ('dbx_business_glossary_term' = 'Federal Award Indicator');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `flow_through_indicator` SET TAGS ('dbx_business_glossary_term' = 'Flow Through Indicator');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `grant_account_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Number');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `grant_account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `grant_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `grant_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Notes');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `prime_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Prime Institution Name');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `prime_sponsor_indicator` SET TAGS ('dbx_business_glossary_term' = 'Prime Sponsor Indicator');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `sponsor_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Type');
ALTER TABLE `education_ecm`.`finance`.`grant_account` ALTER COLUMN `sponsor_type` SET TAGS ('dbx_value_regex' = 'federal|state|local|nonprofit|corporate|foreign');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `adjustment_period_indicator` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Period Indicator');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `ap_close_date` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Close Date');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `ap_status` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Status');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `ap_status` SET TAGS ('dbx_value_regex' = 'open|closed|future|locked');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `ar_close_date` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Close Date');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `ar_status` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Status');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `ar_status` SET TAGS ('dbx_value_regex' = 'open|closed|future|locked');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `budget_carryforward_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Carryforward Flag');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `budget_close_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Close Date');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'open|closed|future|locked');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `encumbrance_rollover_flag` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Rollover Flag');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fa_rate_calculation_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Facilities and Administrative (F&A) Rate Calculation Period Flag');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fasb_reporting_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Accounting Standards Board (FASB) Reporting Period Flag');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `gasb_reporting_period_flag` SET TAGS ('dbx_business_glossary_term' = 'Governmental Accounting Standards Board (GASB) Reporting Period Flag');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `gl_close_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Close Date');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `gl_closed_by_user` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Closed By User');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `gl_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Status');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `gl_status` SET TAGS ('dbx_value_regex' = 'open|closed|future|locked');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `ipeds_reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Integrated Postsecondary Education Data System (IPEDS) Reporting Year');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `ipeds_reporting_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `nacubo_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'National Association of College and University Business Officers (NACUBO) Reporting Category');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_description` SET TAGS ('dbx_business_glossary_term' = 'Period Description');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Name');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Number');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Status');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'regular|adjustment|opening|closing');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `purchasing_close_date` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Close Date');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `purchasing_status` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Status');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `purchasing_status` SET TAGS ('dbx_value_regex' = 'open|closed|future|locked');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `quarter_number` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter Number');
ALTER TABLE `education_ecm`.`finance`.`fiscal_period` ALTER COLUMN `year_end_close_indicator` SET TAGS ('dbx_business_glossary_term' = 'Year-End Close Indicator');
ALTER TABLE `education_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'receivables_banking');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Cash Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Email Address');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Name');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Masked Bank Account Number');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_purpose` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Purpose');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Status');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|frozen|pending_closure|suspended');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `ach_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Clearing House (ACH) Enabled Flag');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `authorized_signatories` SET TAGS ('dbx_business_glossary_term' = 'Authorized Signatories');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `authorized_signatories` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_business_glossary_term' = 'Available Account Balance');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `available_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Address');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Email Address');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Name');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Phone Number');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number (ABA)');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Collateral Value');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `collateralization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateralization Required Flag');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Account Balance');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `dual_signature_threshold` SET TAGS ('dbx_business_glossary_term' = 'Dual Signature Threshold Amount');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `fdic_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Federal Deposit Insurance Corporation (FDIC) Coverage Amount');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `fdic_insured_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Deposit Insurance Corporation (FDIC) Insured Flag');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Method');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_accrual_method` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|annual|none');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percentage');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `minimum_balance_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Balance Required');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `next_reconciliation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reconciliation Due Date');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `online_banking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Banking Enabled Flag');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `positive_pay_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Positive Pay Enabled Flag');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Signatory Requirement');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `signatory_requirement` SET TAGS ('dbx_value_regex' = 'single|dual|triple');
ALTER TABLE `education_ecm`.`finance`.`bank_account` ALTER COLUMN `wire_transfer_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Wire Transfer Enabled Flag');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'general_ledger');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Ap Invoice Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Custodial Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Asset Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Room Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capital_project_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Capital Project Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_value_regex' = 'land|buildings|equipment|library_collections|software|construction_in_progress');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Asset Subcategory');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalization_threshold_met` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Threshold Met Indicator');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `condition_assessment` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `condition_assessment` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|obsolete');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `custodian_email` SET TAGS ('dbx_business_glossary_term' = 'Custodian Email Address');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `custodian_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `custodian_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Name');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|none');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `federal_property_indicator` SET TAGS ('dbx_business_glossary_term' = 'Federal Property Indicator');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'institutional|grant|gift|bond|state_appropriation|federal');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `gasb_classification` SET TAGS ('dbx_business_glossary_term' = 'Governmental Accounting Standards Board (GASB) Classification');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Indicator');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_physical_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inventory Date');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lease Indicator');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Asset Notes');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `title_holder` SET TAGS ('dbx_business_glossary_term' = 'Title Holder');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `title_holder` SET TAGS ('dbx_value_regex' = 'institution|federal_government|state_government|donor|lessor');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life in Years');
ALTER TABLE `education_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `education_ecm`.`finance`.`ap_payment_application` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`finance`.`ap_payment_application` SET TAGS ('dbx_subdomain' = 'payables_procurement');
ALTER TABLE `education_ecm`.`finance`.`ap_payment_application` SET TAGS ('dbx_association_edges' = 'finance.ap_payment,finance.ap_invoice');
ALTER TABLE `education_ecm`.`finance`.`ap_payment_application` ALTER COLUMN `ap_payment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Payment Application - Ap Payment Application Id');
ALTER TABLE `education_ecm`.`finance`.`ap_payment_application` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Payment Application - Ap Invoice Id');
ALTER TABLE `education_ecm`.`finance`.`ap_payment_application` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Payment Application - Ap Payment Id');
ALTER TABLE `education_ecm`.`finance`.`ap_payment_application` ALTER COLUMN `amount_applied` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `education_ecm`.`finance`.`ap_payment_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `education_ecm`.`finance`.`ap_payment_application` ALTER COLUMN `discount_taken_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken at Application');
ALTER TABLE `education_ecm`.`finance`.`ap_payment_application` ALTER COLUMN `invoice_count` SET TAGS ('dbx_business_glossary_term' = 'Invoice Count');
ALTER TABLE `education_ecm`.`finance`.`ap_payment_application` ALTER COLUMN `payment_application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt_application` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt_application` SET TAGS ('dbx_subdomain' = 'receivables_banking');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt_application` SET TAGS ('dbx_association_edges' = 'finance.ar_receipt,finance.ar_invoice');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt_application` ALTER COLUMN `ar_receipt_application_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Receipt Application - Ar Receipt Application Id');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt_application` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Receipt Application - Ar Invoice Id');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt_application` ALTER COLUMN `ar_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Receipt Application - Ar Receipt Id');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt_application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt_application` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt_application` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Application Discount Amount');
ALTER TABLE `education_ecm`.`finance`.`ar_receipt_application` ALTER COLUMN `invoice_references` SET TAGS ('dbx_business_glossary_term' = 'Invoice References');
