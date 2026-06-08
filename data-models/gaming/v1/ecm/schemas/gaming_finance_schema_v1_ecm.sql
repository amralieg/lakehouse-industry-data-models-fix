-- Schema for Domain: finance | Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`finance` COMMENT 'Owns enterprise financial reporting, general ledger, cost center management, budgeting, EBITDA/ROI reporting sourced from SAP S/4HANA FI/CO modules, studio P&L, title-level profitability, royalty accruals, and regulatory financial disclosures. Distinct from billing: billing owns transactional payment records; finance owns the consolidated accounting and reporting layer.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`general_ledger` (
    `general_ledger_id` BIGINT COMMENT 'Unique identifier for the general ledger entry. Primary key for the general ledger data product.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: general_ledger has gl_account_code and gl_account_description (STRING) referencing chart of accounts. Normalize by adding chart_of_accounts_id FK to chart_of_accounts.chart_of_accounts_id and removing',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: general_ledger has cost_center (STRING) for cost allocation. Normalize by adding cost_center_id FK to cost_center.cost_center_id and removing cost_center string.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: general_ledger postings originate from journal entries. general_ledger.document_number (STRING) references journal_entry.document_number. Normalize by adding journal_entry_id FK to journal_entry.journ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: general_ledger has company_code (STRING) identifying the legal entity for the GL posting. Normalize by adding legal_entity_id FK to legal_entity.legal_entity_id and removing company_code string.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: general_ledger has profit_center (STRING) for P&L allocation. Normalize by adding profit_center_id FK to profit_center.profit_center_id and removing profit_center string.',
    `account_type` STRING COMMENT 'Classification of the GL account into financial statement categories: asset, liability, equity, revenue, or expense.. Valid values are `asset|liability|equity|revenue|expense`',
    `assignment_field` STRING COMMENT 'Free-text field used for grouping related entries for clearing, reconciliation, or reporting purposes.',
    `baseline_date` DATE COMMENT 'The date from which payment terms are calculated for payables and receivables.',
    `business_area` STRING COMMENT 'Four-character code identifying the business area or division (e.g., game publishing, esports, licensing) for cross-company code reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `clearing_date` DATE COMMENT 'The date on which this open item was cleared. Null if not cleared.',
    `clearing_document_number` STRING COMMENT 'The document number that cleared this open item (for receivables, payables, or other clearing accounts). Null if not cleared.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The credit amount posted to the GL account in the document currency. Zero if the entry is a debit.',
    `debit_amount` DECIMAL(18,2) COMMENT 'The debit amount posted to the GL account in the document currency. Zero if the entry is a credit.',
    `document_currency` STRING COMMENT 'Three-letter ISO 4217 currency code of the original transaction (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date on the source document (invoice date, receipt date, etc.). May differ from posting date.',
    `document_type` STRING COMMENT 'Two-character code classifying the accounting document type (e.g., SA=GL account document, DR=customer invoice, KR=vendor invoice, DZ=payment document).. Valid values are `^[A-Z]{2}$`',
    `entry_date` DATE COMMENT 'The date on which the document was entered into the system by the user.',
    `entry_timestamp` TIMESTAMP COMMENT 'The precise date and time when the document was entered into the system.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate used to convert document currency to local or group currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year, typically 1-12 for regular periods, with additional periods (13-16) for year-end adjustments.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the accounting entry was posted. Four-digit year format (e.g., 2024).',
    `functional_area` STRING COMMENT 'Classification of the entry by functional area (e.g., game development, marketing, operations) for cost-of-sales and functional expense reporting.. Valid values are `^[A-Z0-9]{16}$`',
    `group_currency` STRING COMMENT 'Three-letter ISO 4217 currency code of the enterprise group reporting currency (typically USD for global gaming companies).. Valid values are `^[A-Z]{3}$`',
    `group_currency_credit_amount` DECIMAL(18,2) COMMENT 'The credit amount converted to the group reporting currency for consolidated financial statements.',
    `group_currency_debit_amount` DECIMAL(18,2) COMMENT 'The debit amount converted to the group reporting currency for consolidated financial statements.',
    `ledger_group` STRING COMMENT 'Two-character code identifying the ledger (e.g., 0L=leading ledger, 2L=IFRS ledger, 3L=local GAAP ledger) for parallel accounting.. Valid values are `^[A-Z0-9]{2}$`',
    `local_currency` STRING COMMENT 'Three-letter ISO 4217 currency code of the company code local currency.. Valid values are `^[A-Z]{3}$`',
    `local_currency_credit_amount` DECIMAL(18,2) COMMENT 'The credit amount converted to the company code local currency for statutory reporting.',
    `local_currency_debit_amount` DECIMAL(18,2) COMMENT 'The debit amount converted to the company code local currency for statutory reporting.',
    `payment_terms` STRING COMMENT 'Four-character code defining the payment terms (e.g., net 30, 2/10 net 30) for this entry.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'The date on which the accounting entry was posted to the general ledger. Determines the fiscal period assignment.',
    `posting_key` STRING COMMENT 'Two-digit code that controls the posting behavior (debit or credit) and account type. Standard SAP posting keys: 40=debit GL, 50=credit GL, 01=debit customer, 11=credit customer, 31=debit vendor, 21=credit vendor.. Valid values are `^[0-9]{2}$`',
    `reference_key` STRING COMMENT 'Free-text reference field containing additional document identifiers such as invoice numbers, purchase order numbers, or payment references.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this entry is a reversal of a previous posting. True if reversal, False otherwise.',
    `reversed_document_number` STRING COMMENT 'The document number of the original entry that this reversal entry is reversing. Null if not a reversal.',
    `segment` STRING COMMENT 'Segment code for IFRS 8 and GAAP ASC 280 segment reporting, typically aligned with game titles, platforms, or geographic regions.. Valid values are `^[A-Z0-9]{10}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount calculated and posted for this entry in document currency.',
    `tax_code` STRING COMMENT 'Two-character code identifying the tax jurisdiction and rate applied to this entry (e.g., V1=standard VAT, I0=input tax exempt).. Valid values are `^[A-Z0-9]{2}$`',
    `text_description` STRING COMMENT 'Free-text description providing additional context about the accounting entry (e.g., Deferred revenue recognition for Q1 season pass sales).',
    `user_name` STRING COMMENT 'The SAP user ID of the person who posted this accounting entry.',
    CONSTRAINT pk_general_ledger PRIMARY KEY(`general_ledger_id`)
) COMMENT 'The authoritative SAP S/4HANA FI general ledger for Gaming, capturing all posted accounting entries across company codes, fiscal periods, and posting keys, along with the enterprise chart of accounts defining all GL account codes, account descriptions, account types (P&L, balance sheet), account groups, and applicable company codes. Includes gaming-industry-specific accounts for deferred revenue (GaaS subscriptions, season passes), game development cost capitalization, virtual currency liability, platform fee expense, and esports prize pool accruals. Serves as the enterprise-wide SSOT for all financial balances, account structure, and period-end closing. Supports GAAP, IFRS, and local statutory reporting requirements.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry document in the general ledger. Primary key for this entity.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Journal entries post to GL accounts defined in the chart of accounts. Each journal entry must reference a specific GL account code for proper accounting. This is a fundamental accounting relationship ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: journal_entry has cost_center (STRING) for cost allocation at header level. Normalize by adding cost_center_id FK to cost_center.cost_center_id and removing cost_center string.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: journal_entry has company_code (STRING) identifying the legal entity for the journal entry. Normalize by adding legal_entity_id FK to legal_entity.legal_entity_id and removing company_code string.',
    `employee_id` BIGINT COMMENT 'The user ID of the person who posted this journal entry. Used for audit trail and accountability.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: journal_entry has profit_center (STRING) for P&L allocation at header level. Normalize by adding profit_center_id FK to profit_center.profit_center_id and removing profit_center string.',
    `tertiary_journal_approved_by_user_employee_id` BIGINT COMMENT 'The user ID of the person who approved this journal entry. Populated when workflow approval is required and has been completed.',
    `approved_timestamp` TIMESTAMP COMMENT 'The timestamp when this journal entry was approved. Populated when workflow approval is required and has been completed.',
    `assignment_reference` STRING COMMENT 'Assignment field used for grouping and sorting journal entries. Often contains project numbers, order numbers, or other business reference keys for reconciliation purposes.',
    `baseline_date` DATE COMMENT 'The baseline date for payment terms calculation. Used to determine due dates and discount periods for payables and receivables.',
    `business_area` STRING COMMENT 'Business area or division within the company to which this journal entry is assigned. Used for segment reporting and internal management accounting.',
    `changed_timestamp` TIMESTAMP COMMENT 'The timestamp when the journal entry was last modified. Null if the entry has never been changed after initial posting.',
    `clearing_date` DATE COMMENT 'The date when open items in this journal entry were cleared or reconciled. Applicable primarily to customer and vendor account postings.',
    `clearing_document_number` STRING COMMENT 'The document number of the clearing document that reconciled open items in this journal entry.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the journal entry amounts are denominated (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date on the source document (invoice date, receipt date, etc.). May differ from posting date when documents are entered after their original date.',
    `document_header_text` STRING COMMENT 'Free-text description or memo at the document header level providing context about the purpose or nature of the journal entry.',
    `document_number` STRING COMMENT 'The externally-known accounting document number assigned by SAP S/4HANA FI. This is the business identifier used in financial reporting and audit trails.',
    `document_status` STRING COMMENT 'Current lifecycle status of the journal entry document. Draft entries are not yet posted; parked entries are saved but not yet final; posted entries are active in the ledger; cleared entries have been reconciled; reversed entries have been cancelled; cancelled entries are voided.. Valid values are `draft|posted|parked|cleared|reversed|cancelled`',
    `document_type` STRING COMMENT 'Classification of the accounting document indicating its origin and purpose. Examples include manual journal entries (SA), customer invoices (DR), vendor invoices (KR), payment documents (DZ), accruals (AA), and period-end adjustments.',
    `due_date` DATE COMMENT 'The calculated due date for payment based on payment terms and baseline date. Applicable to payable and receivable entries.',
    `entry_date` DATE COMMENT 'The date when the journal entry was physically entered into the system by the user. Used for audit trail and data quality monitoring.',
    `entry_time` TIMESTAMP COMMENT 'The timestamp when the journal entry was created in the system. Provides precise audit trail for when the entry was recorded.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate used to convert transaction currency amounts to local currency. Applicable when transaction currency differs from local currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year when this journal entry was posted. Typically 1-12 for monthly periods or 1-4 for quarterly periods.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this journal entry is posted. Used for period-based financial reporting and year-end closing processes.',
    `functional_area` STRING COMMENT 'Functional area classification for this journal entry (e.g., production, sales, administration, R&D). Used for cost-of-sales accounting and functional reporting.',
    `ledger_group` STRING COMMENT 'Identifier for the ledger or ledger group to which this journal entry is posted. Supports parallel accounting scenarios (e.g., local GAAP, IFRS, management reporting).',
    `local_currency_code` STRING COMMENT 'The local currency of the company code. All journal entries are also recorded in local currency for statutory reporting purposes.. Valid values are `^[A-Z]{3}$`',
    `payment_terms` STRING COMMENT 'Payment terms code applicable to this journal entry when it represents a payable or receivable (e.g., Net 30, 2/10 Net 30).',
    `posting_date` DATE COMMENT 'The date on which the journal entry was posted to the general ledger. This is the principal business event timestamp that determines when the financial impact is recognized in the books.',
    `posting_key` STRING COMMENT 'Two-digit key that controls the type of posting (debit or credit) and the account type (general ledger, customer, vendor, asset). Standard keys include 40 (debit GL), 50 (credit GL), 01 (debit customer), 11 (credit customer), 31 (debit vendor), 21 (credit vendor).',
    `reference_document_number` STRING COMMENT 'External reference number from the source document (invoice number, purchase order number, contract number, etc.). Used to trace the journal entry back to its originating business transaction.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry is a reversal of a previous entry. True if this document reverses another document.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for reversing the original journal entry (e.g., error correction, period adjustment, cancellation).',
    `reversed_document_number` STRING COMMENT 'The document number of the original journal entry that this entry reverses. Populated only when reversal_indicator is true.',
    `source_system_code` STRING COMMENT 'Identifier of the source system or module that originated this journal entry (e.g., FI, CO, SD, MM, HR). Used to trace automated postings back to their originating business process.',
    `tax_code` STRING COMMENT 'Tax code that determines the tax rate and tax accounts for this journal entry. Used for automatic tax calculation and tax reporting.',
    `trading_partner` STRING COMMENT 'Identifier of the trading partner company code for intercompany transactions. Used to track and eliminate intercompany balances in consolidated reporting.',
    `transaction_code` STRING COMMENT 'The SAP transaction code (T-code) used to create this journal entry (e.g., FB01 for manual entry, F-02 for general posting, MIRO for invoice verification).',
    `withholding_tax_code` STRING COMMENT 'Withholding tax code applicable to this journal entry. Used for automatic withholding tax calculation on vendor payments and certain revenue transactions.',
    `workflow_status` STRING COMMENT 'Status of the approval workflow for this journal entry. Manual journal entries and certain automated postings may require approval before final posting.. Valid values are `pending_approval|approved|rejected|no_approval_required`',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Individual double-entry accounting documents posted to the general ledger in SAP S/4HANA FI. Captures debit/credit line items, posting date, document type, reference document, fiscal year/period, currency, and posting user. Covers manual journal entries, automated postings from SD/MM/CO, and period-end accruals including royalty accruals and deferred revenue from game title sales.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center. Primary key.',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game development studio to which this cost center belongs. Null for non-studio cost centers. Supports studio-level P&L and cost analysis.',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title to which this cost center is dedicated. Null for shared or non-title-specific cost centers. Supports title-level profitability analysis.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: cost_center has company_code (STRING) identifying the legal entity that owns the cost center. Normalize by adding legal_entity_id FK to legal_entity.legal_entity_id and removing company_code string.',
    `parent_cost_center_id` BIGINT COMMENT 'Identifier of the parent cost center in the cost center hierarchy. Supports roll-up reporting and organizational structure analysis. Null for top-level cost centers.',
    `profit_center_id` BIGINT COMMENT 'Identifier of the profit center to which this cost center is assigned. Supports internal P&L reporting and profitability analysis.',
    `allocation_method` STRING COMMENT 'The method used to allocate costs from this cost center to receiving cost centers or profit centers. Supports internal cost allocation cycles and recharge calculations.. Valid values are `direct|headcount|revenue_share|usage_based|fixed_percentage|activity_based`',
    `budget_amount` DECIMAL(18,2) COMMENT 'The approved budget amount for this cost center for the current fiscal period. Used for budget vs. actuals variance analysis.',
    `business_area` STRING COMMENT 'The SAP Business Area representing a segment of the business (e.g., console games, mobile games, esports). Supports segment reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area` STRING COMMENT 'The SAP Controlling Area (CO) to which this cost center belongs. Represents the organizational unit for cost accounting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_category` STRING COMMENT 'Classification of the cost center by functional area. Supports EBITDA decomposition and organizational cost analysis. [ENUM-REF-CANDIDATE: studio|game_title|platform_engineering|esports_operations|live_ops|corporate_overhead|shared_services|marketing|qa|support — 10 candidates stripped; promote to reference product]',
    `cost_center_code` STRING COMMENT 'The externally-known unique alphanumeric code identifying the cost center in SAP S/4HANA CO module. Used in financial reporting, budget allocation, and internal cost allocation cycles.. Valid values are `^[A-Z0-9]{4,10}$`',
    `cost_center_description` STRING COMMENT 'Detailed description of the cost centers purpose, scope, and responsibilities within the organization.',
    `cost_center_name` STRING COMMENT 'The human-readable name of the cost center (e.g., Studio Alpha - Engineering, Live Ops Team, Platform Infrastructure).',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active cost centers can receive postings; inactive cost centers are closed; blocked cost centers are temporarily suspended; planned cost centers are not yet operational.. Valid values are `active|inactive|blocked|planned`',
    `cost_center_type` STRING COMMENT 'Type of cost center indicating its role in the cost allocation hierarchy (production centers directly contribute to game development; service centers provide internal support; administrative centers are overhead; auxiliary centers support production indirectly).. Valid values are `production|service|administrative|auxiliary`',
    `cost_element_group` STRING COMMENT 'The primary cost element group associated with this cost center (e.g., personnel costs, infrastructure costs, licensing fees). Supports cost type analysis.',
    `created_by_user` STRING COMMENT 'The username or identifier of the user who created this cost center record. Supports audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost center record was first created in the system. Supports audit trail and data lineage.',
    `currency` STRING COMMENT 'The currency in which costs are recorded for this cost center. ISO 4217 three-letter currency code.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'The department code representing the organizational department to which this cost center belongs. Supports departmental cost roll-up.. Valid values are `^[A-Z0-9]{2,6}$`',
    `fiscal_year` STRING COMMENT 'The fiscal year for which the budget amount is applicable. Supports multi-year budget tracking.',
    `functional_area` STRING COMMENT 'The functional area or department classification of the cost center (e.g., development, operations, marketing). Used for functional cost analysis. [ENUM-REF-CANDIDATE: development|operations|sales|marketing|administration|support|infrastructure — 7 candidates stripped; promote to reference product]',
    `headcount_allocation_key` DECIMAL(18,2) COMMENT 'The headcount-based allocation key used to distribute shared costs. Represents the proportion of total headcount assigned to this cost center.',
    `hierarchy_level` STRING COMMENT 'The level of this cost center in the organizational hierarchy (1 = top level, increasing for nested levels). Supports hierarchical roll-up and drill-down reporting.',
    `is_allocable` BOOLEAN COMMENT 'Indicates whether costs from this cost center can be allocated to other cost centers or profit centers. True for shared services and overhead cost centers; false for final cost centers.',
    `is_overhead` BOOLEAN COMMENT 'Indicates whether this cost center represents corporate overhead or indirect costs. True for overhead cost centers; false for direct production cost centers.',
    `is_shared_service` BOOLEAN COMMENT 'Indicates whether this cost center provides shared services to multiple business units or titles. True for shared service centers; false for dedicated cost centers.',
    `last_modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this cost center record. Supports change tracking and audit compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this cost center record was last modified. Supports change tracking and audit compliance.',
    `location_code` STRING COMMENT 'Three-letter code representing the geographic location or office where this cost center operates. Supports location-based cost analysis.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text notes or comments about the cost center. Used for additional context, special instructions, or historical information.',
    `revenue_allocation_key` DECIMAL(18,2) COMMENT 'The revenue-based allocation key used to distribute shared costs. Represents the proportion of total revenue attributed to this cost center.',
    `valid_from_date` DATE COMMENT 'The date from which this cost center is valid and can receive cost postings. Supports time-dependent cost center master data.',
    `valid_to_date` DATE COMMENT 'The date until which this cost center is valid. Null for open-ended validity. Supports time-dependent cost center master data and historical analysis.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'SAP S/4HANA CO cost center master data and allocation activity representing organizational units responsible for cost accumulation and distribution within Gaming. Includes studio cost centers (by team/discipline), game title development cost centers, platform engineering cost centers, esports operations cost centers, live ops cost centers, and corporate overhead. Each cost center has a responsible manager, validity period, hierarchy assignment, and cost center category. Also captures internal cost allocation and recharge records distributing shared costs (shared services, platform infrastructure, corporate overhead, engine licensing fees) across receiving cost centers and profit centers using defined allocation keys (headcount, revenue share, server usage). Supports internal cost allocation cycles, budget vs. actuals reporting, headcount cost tracking, EBITDA decomposition by organizational unit, and accurate title-level and studio-level P&L construction.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique identifier for the profit center. Primary key for this entity.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: profit_center has company_code (STRING) identifying the legal entity that owns the profit center. Normalize by adding legal_entity_id FK to legal_entity.legal_entity_id and removing company_code strin',
    `parent_profit_center_id` BIGINT COMMENT 'Reference to the parent profit center in a hierarchical structure. Enables roll-up reporting from title-level to studio-level to business-line-level P&L. Nullable for top-level profit centers.',
    `budget_amount` DECIMAL(18,2) COMMENT 'The approved annual budget for this profit center in the profit centers reporting currency. Used for budget vs actual variance analysis and EBITDA forecasting.',
    `budget_fiscal_year` STRING COMMENT 'The fiscal year for which the budget_amount is defined (e.g., 2024). Enables multi-year budget tracking and year-over-year variance analysis.',
    `business_area_code` STRING COMMENT 'The SAP business area code representing a cross-company-code segment for consolidated financial statements (e.g., Console Games, Mobile Games, Esports).. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area_code` STRING COMMENT 'The SAP Controlling Area to which this profit center belongs. Controlling areas represent organizational units for cost accounting and internal reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_group` STRING COMMENT 'The cost center group code that aggregates multiple cost centers feeding into this profit center. Used for indirect cost allocation and overhead absorption.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_by_user` STRING COMMENT 'The username or employee ID of the person who created this profit center record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this profit center record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code in which this profit centers financial results are reported (e.g., USD, EUR, GBP). Typically aligned with the company codes local currency.. Valid values are `^[A-Z]{3}$`',
    `esrb_rating` STRING COMMENT 'The ESRB content rating for title-level profit centers: EC (Early Childhood), E (Everyone), E10 (Everyone 10+), T (Teen), M (Mature 17+), AO (Adults Only 18+), RP (Rating Pending), not_applicable (non-title profit centers). Impacts marketing strategy and regional distribution. [ENUM-REF-CANDIDATE: EC|E|E10|T|M|AO|RP|not_applicable — 8 candidates stripped; promote to reference product]',
    `functional_area` STRING COMMENT 'The primary functional area of the profit center: development (game creation), publishing (distribution), live_ops (GaaS management), marketing (player acquisition), esports (competitive gaming), licensing (IP/engine), corporate_services (shared functions). [ENUM-REF-CANDIDATE: development|publishing|live_ops|marketing|esports|licensing|corporate_services — 7 candidates stripped; promote to reference product]',
    `game_genre` STRING COMMENT 'The primary game genre for title-level profit centers (e.g., Battle Royale, Sports Simulation, MMORPG, Puzzle). Nullable for non-title profit centers. Used for genre-level profitability benchmarking. [ENUM-REF-CANDIDATE: action|adventure|rpg|strategy|sports|racing|simulation|puzzle|shooter|fighting|platformer|mmo|battle_royale|moba|card_game|casual — promote to reference product]',
    `hierarchy_level` STRING COMMENT 'The depth of this profit center in the organizational hierarchy (1=top-level business line, 2=studio, 3=game title, etc.). Used for aggregation and drill-down reporting.',
    `is_first_party` BOOLEAN COMMENT 'Indicates whether this profit center represents a first-party title (developed and published by the console manufacturer) or third-party title (external developer/publisher). Impacts revenue share and platform certification requirements.',
    `is_live_service` BOOLEAN COMMENT 'Indicates whether this profit center operates as a live service (GaaS) with ongoing content updates, events, and player engagement. Impacts cost structure (live ops team) and revenue forecasting (LTV vs upfront).',
    `last_modified_by_user` STRING COMMENT 'The username or employee ID of the person who last modified this profit center record. Used for audit trail and change accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this profit center record was last updated. Used for change tracking and data freshness validation.',
    `launch_date` DATE COMMENT 'The official launch date (hard launch) for title-level profit centers. Used for post-launch profitability tracking, D1/D7/D30 retention correlation, and LTV modeling. Nullable for non-title profit centers.',
    `lock_indicator` BOOLEAN COMMENT 'Indicates whether this profit center is locked for posting transactions. Set to true during period-end close or when a profit center is being archived. Prevents accidental postings to closed periods.',
    `monetization_model` STRING COMMENT 'The primary revenue model for this profit center: f2p (Free-to-Play with MTX), premium (upfront purchase), gaas (Game-as-a-Service), subscription (recurring fee), ad_supported (advertising revenue), hybrid (multiple models), not_applicable (non-revenue profit centers). [ENUM-REF-CANDIDATE: f2p|premium|gaas|subscription|ad_supported|hybrid|not_applicable — 7 candidates stripped; promote to reference product]',
    `platform_category` STRING COMMENT 'The primary gaming platform category for this profit center. Used for platform-level P&L segmentation and platform strategy analysis. Set to not_applicable for non-platform profit centers (e.g., corporate services). [ENUM-REF-CANDIDATE: console|pc|mobile|cross_platform|cloud_gaming|vr_ar|not_applicable — 7 candidates stripped; promote to reference product]',
    `profit_center_code` STRING COMMENT 'The externally-known unique alphanumeric code for the profit center as defined in SAP S/4HANA CO module. Used for reporting and integration with external systems.. Valid values are `^[A-Z0-9]{4,10}$`',
    `profit_center_description` STRING COMMENT 'A detailed description of the profit centers scope, business purpose, and key responsibilities. Used for onboarding new finance team members and audit documentation.',
    `profit_center_name` STRING COMMENT 'The human-readable name of the profit center (e.g., Fortnite Live Ops, EA Sports FC Studio, Mobile F2P Portfolio).',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center: active (operational and reporting), inactive (temporarily suspended), planned (future launch), sunset (end-of-life phase), archived (historical record only).. Valid values are `active|inactive|planned|sunset|archived`',
    `profit_center_type` STRING COMMENT 'Classification of the profit center by organizational structure: game_title (individual game P&L), studio (development studio), platform (console/PC/mobile), business_line (F2P/premium/GaaS), esports_league (competitive gaming), licensing (engine/IP licensing), corporate (shared services). [ENUM-REF-CANDIDATE: game_title|studio|platform|business_line|esports_league|licensing|corporate — 7 candidates stripped; promote to reference product]',
    `responsible_person_email` STRING COMMENT 'The email address of the person responsible for this profit center. Used for automated P&L distribution and budget variance alerts.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_person_name` STRING COMMENT 'The name of the executive or manager accountable for this profit centers financial performance (e.g., Studio Head, Game Director, VP of Platform).',
    `royalty_rate_pct` DECIMAL(18,2) COMMENT 'The royalty rate percentage applied to revenue for licensed IP or third-party publishing agreements (e.g., 15.00 represents 15%). Used for royalty accrual calculations and licensor reporting. Nullable for wholly-owned IP.',
    `segment_code` STRING COMMENT 'The segment code for IFRS 8 Operating Segments reporting. Segments represent distinguishable components of the business for which discrete financial information is available.. Valid values are `^[A-Z0-9]{4,10}$`',
    `sunset_date` DATE COMMENT 'The planned or actual date when a game title or service is discontinued. Used for end-of-life cost planning and player migration strategies. Nullable for active profit centers.',
    `target_ebitda_margin_pct` DECIMAL(18,2) COMMENT 'The target EBITDA margin percentage for this profit center (e.g., 25.00 represents 25%). Used for performance evaluation and executive compensation metrics.',
    `valid_from_date` DATE COMMENT 'The date from which this profit center becomes effective for financial reporting and P&L tracking. Aligns with fiscal period start or game launch date.',
    `valid_to_date` DATE COMMENT 'The date through which this profit center remains effective. Nullable for open-ended profit centers. Set when a game is sunset or a studio is closed.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'SAP S/4HANA CO profit center master data representing autonomous business segments for internal P&L reporting within Gaming. Profit centers are aligned to game titles, studios, platforms, and business lines (F2P, premium, esports, licensing). Enables title-level profitability, studio P&L, and segment-level EBITDA reporting without requiring legal entity separation.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`finance_budget` (
    `finance_budget_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: budget has gl_account_code (STRING) referencing chart of accounts. Normalize by adding chart_of_accounts_id FK to chart_of_accounts.chart_of_accounts_id and removing redundant gl_account_code string.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: budget has cost_center_code (STRING) referencing cost center master data. Normalize by adding cost_center_id FK to cost_center.cost_center_id and removing redundant cost_center_code string.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Budgets are prepared at the legal entity level for consolidation and regulatory reporting purposes. This FK enables proper multi-entity budget consolidation and ensures budgets are attributed to the c',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: budget has profit_center_code (STRING) referencing profit center master data. Normalize by adding profit_center_id FK to profit_center.profit_center_id and removing redundant profit_center_code string',
    `amount` DECIMAL(18,2) COMMENT 'The planned budget amount in the base currency for this fiscal period, cost center, and GL account combination. Represents the approved spending or revenue target.',
    `approval_date` DATE COMMENT 'The date when this budget version was formally approved by finance leadership or the board. Establishes the baseline for variance analysis.',
    `approved_by` STRING COMMENT 'The name or identifier of the executive or finance leader who approved this budget version. Supports audit trail and accountability.',
    `budget_category` STRING COMMENT 'The high-level category of the budget: opex (operating expenses), capex (capital expenditures for game development and infrastructure), revenue (top-line targets), headcount (FTE budget).. Valid values are `opex|capex|revenue|headcount`',
    `budget_status` STRING COMMENT 'The current lifecycle status of the budget record: draft (in preparation), submitted (awaiting approval), approved (active for spending), rejected (not approved), active (in execution), closed (fiscal period ended).. Valid values are `draft|submitted|approved|rejected|active|closed`',
    `business_unit_code` STRING COMMENT 'The business unit code representing the organizational division (e.g., game_publishing, esports, engine_licensing, live_ops). Enables business-unit-level financial reporting.',
    `campaign_code` STRING COMMENT 'The marketing campaign code for campaign-specific budget allocation. Links budget to player acquisition and retention campaigns.',
    `cost_element_code` STRING COMMENT 'The cost element code from controlling (CO) module, representing the type of cost (primary or secondary) for internal cost allocation and activity-based costing.',
    `created_by_user` STRING COMMENT 'The username or identifier of the user who created this budget record. Supports accountability and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the budget amount (e.g., USD, EUR, GBP). Supports multi-currency budget planning for global operations.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date until which this budget version is effective. Nullable for the current active version. Enables temporal budget analysis.',
    `effective_start_date` DATE COMMENT 'The date from which this budget version becomes effective. Supports point-in-time budget queries and historical comparison.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year (1-12). Enables monthly budget tracking and variance analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget applies (e.g., 2024, 2025). Represents the annual planning cycle.',
    `game_title_code` STRING COMMENT 'The code of the game title to which this budget is allocated. Enables title-level P&L and budget tracking for individual games or franchises.',
    `headcount_fte` DECIMAL(18,2) COMMENT 'The budgeted headcount in full-time equivalents for this cost center and period. Supports workforce planning and personnel cost budgeting.',
    `internal_order_number` STRING COMMENT 'The internal order number for project-based budgeting (e.g., game development projects, marketing campaigns, infrastructure initiatives). Enables project cost tracking.',
    `is_locked` BOOLEAN COMMENT 'Boolean flag indicating whether this budget record is locked for editing (true) or open for changes (false). Prevents unauthorized modifications to approved budgets.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this budget record. Tracks change ownership for audit purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was last modified. Tracks changes and supports audit trail for budget revisions.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context for this budget line (e.g., assumptions, dependencies, risks, special considerations).',
    `platform_code` STRING COMMENT 'The gaming platform code (e.g., console, PC, mobile, VR) for platform-specific budget allocation and ROI analysis.',
    `region_code` STRING COMMENT 'The geographic region code for regional budget allocation (e.g., NAM, EMEA, APAC, LATAM). Supports regional P&L and budget tracking.',
    `revision_reason` STRING COMMENT 'The business reason for a revised or forecast budget version (e.g., game_launch_delay, live_ops_performance_change, market_conditions, headcount_adjustment). Provides context for mid-year changes.',
    `scenario_name` STRING COMMENT 'The name of the planning scenario (e.g., base, upside, downside, aggressive_launch, conservative_ops). Used for scenario planning and sensitivity analysis.',
    `source_record_reference` STRING COMMENT 'The unique identifier of this budget record in the source system. Enables traceability back to the originating system for reconciliation and troubleshooting.',
    `source_system` STRING COMMENT 'The name of the source system from which this budget record originated (e.g., SAP_S4HANA, Excel_Upload, BPC, Anaplan). Supports data lineage and reconciliation.',
    `studio_code` STRING COMMENT 'The code of the game development studio responsible for this budget line. Supports studio-level financial reporting and resource allocation.',
    `subcategory` STRING COMMENT 'The detailed subcategory within the budget category (e.g., marketing_spend, server_infrastructure, game_development, royalty_payments, personnel_costs).',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'The acceptable variance threshold percentage for budget vs. actuals comparison. Triggers alerts when actual spending exceeds this threshold (e.g., 10.00 for 10%).',
    `version_type` STRING COMMENT 'The type of budget version: original (initial approved budget), revised (mid-year adjustments), forecast (rolling forecast updates), scenario (what-if planning scenarios).. Valid values are `original|revised|forecast|scenario`',
    CONSTRAINT pk_finance_budget PRIMARY KEY(`finance_budget_id`)
) COMMENT 'Annual and rolling budget plans for Gaming across cost centers, profit centers, and internal orders, including all versioned snapshots (original budget, revised budget, rolling forecast, scenario plans) and their lifecycle from draft through approval to actuals comparison. Captures approved budget amounts by fiscal year, fiscal period, GL account, cost element, organizational unit, version type (original/revised/forecast), and scenario (base/upside/downside). Supports budget vs. actuals variance analysis, headcount budget, capex/opex budget for game development projects, marketing spend budgets by title and campaign, mid-year revisions triggered by game launch delays or live ops performance changes, and rolling forecast updates. Each budget record carries version metadata enabling point-in-time comparison and audit trail of budget evolution.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`budget_version` (
    `budget_version_id` BIGINT COMMENT 'Unique identifier for the budget version snapshot. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Budget versions reference specific GL accounts from the chart of accounts to ensure budget line items align with the financial reporting structure. This FK enables budget-to-actual variance analysis a',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center this budget version is allocated to. Supports departmental and functional budget tracking (e.g., marketing, QA, live operations).',
    `finance_budget_id` BIGINT COMMENT 'Reference to the parent budget plan that this version belongs to. Links to the master budget entity.',
    `game_studio_id` BIGINT COMMENT 'Reference to the game development studio this budget version applies to. Nullable for enterprise-wide budgets. Supports studio-level P&L and cost center management.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title this budget version applies to. Nullable for enterprise-wide or studio-level budgets. Enables title-level profit and loss (P&L) tracking.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Budget versions model KPI-based planning scenarios (optimistic/pessimistic DAU, ARPU assumptions). Finance teams version budgets by KPI forecast, enabling scenario planning and sensitivity analysis. S',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Budget versions must be associated with legal entities for multi-entity budget consolidation and variance analysis. This FK enables rolling up budget versions across the legal entity hierarchy for gro',
    `employee_id` BIGINT COMMENT 'Reference to the user (typically CFO, finance director, or budget owner) who approved this budget version. Nullable for draft or rejected versions.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: budget_version should have direct FK to profit_center for reporting and analysis. While parent budget has profit_center_code, budget_version needs its own link for version-specific profit center assig',
    `quaternary_budget_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this budget version record. Supports audit trail and change tracking.',
    `tertiary_budget_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who created this budget version record. Supports audit trail and accountability.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this budget version was approved. Nullable for draft or rejected versions. Supports audit trail and compliance reporting.',
    `budget_version_status` STRING COMMENT 'Current lifecycle status of the budget version: draft (in preparation), submitted (awaiting approval), approved (finalized and active), rejected (not approved), active (currently in use), superseded (replaced by newer version), archived (historical record). [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|active|superseded|archived — 7 candidates stripped; promote to reference product]',
    `capex_budget_amount` DECIMAL(18,2) COMMENT 'The total budgeted capital expenditures for this version. Includes game development costs capitalized as assets, infrastructure investments, and technology platform upgrades.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this budget version record was first created in the system. Audit field for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amounts (e.g., USD, EUR, GBP). All amounts in this version are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `ebitda_budget_amount` DECIMAL(18,2) COMMENT 'The budgeted EBITDA for this version. Key profitability metric used for studio performance evaluation and title-level return on investment (ROI) analysis.',
    `effective_end_date` DATE COMMENT 'The date until which this budget version remains effective. Nullable for open-ended versions. When a new version is approved, this date is set on the prior version.',
    `effective_start_date` DATE COMMENT 'The date from which this budget version becomes effective and is used for financial planning and reporting.',
    `fiscal_period` STRING COMMENT 'The fiscal period or quarter this version covers (e.g., Q1, Q2, FY, P01 for period 1). Supports both quarterly and monthly period granularity.',
    `fiscal_year` STRING COMMENT 'The fiscal year this budget version applies to (e.g., 2024). Aligns with the companys fiscal calendar.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this budget version is currently active and being used for financial planning and reporting. Only one version per budget plan should be active at a time.',
    `is_baseline` BOOLEAN COMMENT 'Boolean flag indicating whether this version serves as the baseline for variance analysis. Typically the original approved budget is marked as baseline.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this budget version record was last modified. Audit field for change tracking and compliance.',
    `notes` STRING COMMENT 'Free-text notes and comments about this budget version. Used to capture additional context, assumptions, or special considerations not covered by structured fields.',
    `opex_budget_amount` DECIMAL(18,2) COMMENT 'The total budgeted operating expenses for this version. Includes studio operations, live operations (LiveOps), marketing, player support, and general administrative costs.',
    `planning_cycle` STRING COMMENT 'The planning cycle frequency this budget version belongs to: annual (yearly budget), quarterly (quarterly reforecast), monthly (monthly budget update), or rolling forecast (continuous forward-looking projection).. Valid values are `annual|quarterly|monthly|rolling_forecast`',
    `revenue_budget_amount` DECIMAL(18,2) COMMENT 'The total budgeted revenue for this version. Includes all revenue streams: game sales, in-app purchases (IAP), microtransactions (MTX), subscriptions, licensing, and esports.',
    `revision_reason` STRING COMMENT 'Business justification for creating this revised budget version. Captures triggers such as game launch delays, live operations (LiveOps) performance changes, market shifts, or strategic pivots.',
    `scenario_description` STRING COMMENT 'Detailed description of the scenario assumptions for this budget version. Used for scenario planning (e.g., Assumes game launch delay by 2 quarters, Upside case with 20% higher Daily Active Users (DAU)).',
    `source_system` STRING COMMENT 'The name or identifier of the source system from which this budget version was imported or created (e.g., SAP S/4HANA, Excel Planning Tool, Anaplan). Supports data lineage and reconciliation.',
    `source_system_code` STRING COMMENT 'The unique identifier of this budget version in the source system. Enables traceability and reconciliation back to the originating system.',
    `submitted_timestamp` TIMESTAMP COMMENT 'The date and time when this budget version was submitted for approval. Nullable for draft versions.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'The total budgeted amount across all cost centers, general ledger (GL) accounts, and line items for this version. Represents the aggregate financial plan.',
    `variance_threshold_percentage` DECIMAL(18,2) COMMENT 'The acceptable variance threshold percentage for this budget version. Used to trigger alerts when actual spend deviates from budget by more than this percentage (e.g., 10.00 for 10%).',
    `version_name` STRING COMMENT 'Human-readable name or label for this budget version (e.g., FY2024 Original Budget, Q2 Revised Forecast, Post-Launch Upside Scenario).',
    `version_number` STRING COMMENT 'Sequential version number within the budget plan lifecycle (e.g., 1 for original, 2 for first revision, 3 for second revision). Used to track iteration history.',
    `version_type` STRING COMMENT 'Classification of the budget version: original budget (initial approved plan), revised budget (mid-year adjustment), forecast (rolling projection), actuals (actual spend to date), or scenario planning variants (base case, upside, downside). [ENUM-REF-CANDIDATE: original_budget|revised_budget|forecast|actuals|scenario_base|scenario_upside|scenario_downside — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_budget_version PRIMARY KEY(`budget_version_id`)
) COMMENT 'Versioned snapshots of budget plans within Gamings planning cycle, capturing original budget, revised budget, forecast, and actuals-to-date for each fiscal period. Supports rolling forecast updates, mid-year budget revisions triggered by game launch delays or live ops performance, and scenario planning (base case, upside, downside) for title P&L projections.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`title_pl` (
    `title_pl_id` BIGINT COMMENT 'Unique identifier for the title-level profit and loss statement record. Primary key for title P&L reporting.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `game_studio_id` BIGINT COMMENT 'Foreign key reference to the development studio responsible for this title. Used for studio-level P&L rollup.',
    `game_title_id` BIGINT COMMENT 'Foreign key reference to the game title for which this P&L statement is prepared. Links to the master game title entity.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: title_pl has reporting_entity_code (STRING) identifying the legal entity for the title P&L. Normalize by adding legal_entity_id FK to legal_entity.legal_entity_id and removing reporting_entity_code st',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `approved_by` STRING COMMENT 'Name or user ID of the finance manager or controller who approved this P&L statement for final reporting.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this P&L statement was approved and locked for reporting.',
    `arppu` DECIMAL(18,2) COMMENT 'Average Revenue Per Paying User calculated as net revenue divided by the number of paying users. Measures monetization among payers only.',
    `arpu` DECIMAL(18,2) COMMENT 'Average Revenue Per User calculated as net revenue divided by MAU. Measures monetization efficiency across all users.',
    `brand_marketing_spend` DECIMAL(18,2) COMMENT 'Brand and awareness marketing spend including influencer campaigns, esports sponsorships, PR, community events, and above-the-line advertising.',
    `cdn_costs` DECIMAL(18,2) COMMENT 'Content Delivery Network costs for distributing game patches, updates, and downloadable content to players globally.',
    `chargebacks_amount` DECIMAL(18,2) COMMENT 'Total value of payment chargebacks (disputed transactions reversed by payment processors) during the period.',
    `cogs_total` DECIMAL(18,2) COMMENT 'Total Cost of Goods Sold, summing development amortization, server/CDN costs, QA costs, royalties, and other direct costs attributable to delivering the game service.',
    `conversion_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of active users who made a purchase during the period, calculated as (paying_user_count / MAU) * 100.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this P&L statement record was first created in the system.',
    `dau_average` STRING COMMENT 'Average Daily Active Users for the title during the reporting period. Key engagement metric for GaaS titles.',
    `development_amortization` DECIMAL(18,2) COMMENT 'Amortized development costs allocated to this period, representing the capitalized development investment spread over the titles commercial lifecycle.',
    `ebitda` DECIMAL(18,2) COMMENT 'EBITDA for the title, adding back depreciation and amortization to operating income. Used for cash flow and valuation analysis.',
    `fiscal_period` STRING COMMENT 'The fiscal reporting period for this P&L statement in format YYYY-QN for quarters or YYYY-MM for months (e.g., 2024-Q1, 2024-03).. Valid values are `^[0-9]{4}-(Q[1-4]|[0-9]{2})$`',
    `fiscal_year` STRING COMMENT 'The fiscal year for this P&L statement (e.g., 2024).',
    `gross_margin_percent` DECIMAL(18,2) COMMENT 'Gross margin as a percentage of net revenue, calculated as (gross_profit / net_revenue) * 100. Key profitability indicator for title performance.',
    `gross_profit` DECIMAL(18,2) COMMENT 'Gross profit calculated as net revenue minus total COGS. Represents the profit before marketing and operating expenses.',
    `gross_revenue` DECIMAL(18,2) COMMENT 'Total gross sales revenue generated by the title before any deductions, including all In-App Purchases (IAP), Downloadable Content (DLC), Microtransactions (MTX), and initial game sales.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this P&L statement record was last updated or revised.',
    `mau_average` STRING COMMENT 'Average Monthly Active Users for the title during the reporting period. Broader engagement metric than DAU.',
    `net_revenue` DECIMAL(18,2) COMMENT 'Net revenue after deducting platform fees, refunds, and chargebacks from gross revenue. This is the revenue retained by the publisher.',
    `notes` STRING COMMENT 'Free-text notes and commentary on this P&L statement, including explanations of variances, one-time adjustments, or accounting policy changes.',
    `operating_expenses` DECIMAL(18,2) COMMENT 'Other operating expenses allocated to the title including player support, community management, live operations staff, and administrative overhead.',
    `operating_income` DECIMAL(18,2) COMMENT 'Operating income (EBIT) calculated as gross profit minus total marketing spend and operating expenses. Primary measure of title profitability.',
    `operating_margin_percent` DECIMAL(18,2) COMMENT 'Operating margin as a percentage of net revenue, calculated as (operating_income / net_revenue) * 100. Key indicator of title operational efficiency.',
    `paying_user_count` STRING COMMENT 'Total number of unique users who made at least one purchase during the reporting period.',
    `pl_status` STRING COMMENT 'Current status of this P&L statement in the financial close and reporting workflow.. Valid values are `draft|preliminary|final|audited|restated`',
    `platform_fees` DECIMAL(18,2) COMMENT 'Total fees paid to platform holders (Apple App Store, Google Play, Steam, Epic Games Store, console first parties) as a percentage of gross revenue. Typically 15-30% of gross sales.',
    `qa_testing_costs` DECIMAL(18,2) COMMENT 'Quality Assurance and playtesting costs allocated to this title for the period, including internal QA staff and external testing services.',
    `refunds_amount` DECIMAL(18,2) COMMENT 'Total value of refunds issued to players during the period, reducing net revenue.',
    `reporting_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all monetary amounts in this P&L are reported (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `roi_percent` DECIMAL(18,2) COMMENT 'Return on Investment calculated as (operating_income / total_marketing_spend) * 100. Measures marketing efficiency and profitability.',
    `royalty_expenses` DECIMAL(18,2) COMMENT 'Royalty payments to Intellectual Property (IP) licensors, game engine providers (Unity, Unreal), middleware vendors, and talent (voice actors, composers) based on revenue or unit sales.',
    `server_hosting_costs` DECIMAL(18,2) COMMENT 'Cloud infrastructure and game server hosting costs for live operations, including compute, storage, and database services for Game-as-a-Service (GaaS) titles.',
    `total_marketing_spend` DECIMAL(18,2) COMMENT 'Total marketing expenditure combining user acquisition and brand marketing spend for the title during the period.',
    `user_acquisition_spend` DECIMAL(18,2) COMMENT 'Total marketing spend on user acquisition campaigns, including Cost Per Install (CPI), Cost Per Mille (CPM), and paid advertising across mobile, social, and digital channels.',
    CONSTRAINT pk_title_pl PRIMARY KEY(`title_pl_id`)
) COMMENT 'Title-level profit and loss statement consolidating all revenue and cost lines attributable to a specific game title across its full commercial lifecycle. Aggregates net revenue (gross sales minus platform fees, refunds, chargebacks), COGS (development amortization, server/CDN costs, QA), gross margin, marketing spend (CPI, CPM, UA campaigns), and operating income. Sourced from SAP CO profit center accounting and billing domain revenue feeds. Primary instrument for GaaS title financial health monitoring.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`studio_pl` (
    `studio_pl_id` BIGINT COMMENT 'Unique identifier for the studio profit and loss statement record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: studio_pl has cost_center_code (STRING) for cost center reporting. Normalize by adding cost_center_id FK to cost_center.cost_center_id and removing cost_center_code string.',
    `game_studio_id` BIGINT COMMENT 'Reference to the development studio for which this P&L statement is prepared. Links to the studio master entity.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: studio_pl has company_code (STRING) identifying the legal entity for the studio P&L. Normalize by adding legal_entity_id FK to legal_entity.legal_entity_id and removing company_code string.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: studio_pl has profit_center_code (STRING) for profit center reporting. Normalize by adding profit_center_id FK to profit_center.profit_center_id and removing profit_center_code string.',
    `allocated_overhead` DECIMAL(18,2) COMMENT 'Corporate overhead costs allocated to the studio based on allocation keys (e.g., headcount, revenue share).',
    `approval_date` DATE COMMENT 'The date on which this P&L statement was approved by finance leadership.',
    `approved_by` STRING COMMENT 'Name or identifier of the finance executive who approved this P&L statement.',
    `business_unit` STRING COMMENT 'The business unit or division to which the studio is organizationally aligned (e.g., Console Games, Mobile Games, Esports).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this P&L statement record was first created in the system.',
    `depreciation_amortization` DECIMAL(18,2) COMMENT 'Depreciation of studio assets and amortization of intangible assets (e.g., acquired IP, capitalized development costs).',
    `ebitda` DECIMAL(18,2) COMMENT 'Studio earnings before interest, taxes, depreciation, and amortization, a key profitability metric for investment decisions.',
    `engine_licensing_revenue` DECIMAL(18,2) COMMENT 'Revenue earned from licensing proprietary game engine technology to third parties.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year (e.g., 1-12 for monthly, 1-4 for quarterly).',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this P&L statement is prepared (e.g., 2024).',
    `geographic_region` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary geographic location of the studio.. Valid values are `^[A-Z]{3}$`',
    `gross_profit` DECIMAL(18,2) COMMENT 'Total revenue minus total direct costs, representing the studios contribution margin before overhead allocation.',
    `headcount_cost` DECIMAL(18,2) COMMENT 'Total personnel costs including salaries, benefits, bonuses, and payroll taxes for studio employees.',
    `headcount_fte` DECIMAL(18,2) COMMENT 'Average full-time equivalent headcount employed by the studio during the reporting period.',
    `infrastructure_cost` DECIMAL(18,2) COMMENT 'Costs for cloud services, on-premise servers, build farms, and IT infrastructure supporting studio operations.',
    `marketing_cost` DECIMAL(18,2) COMMENT 'Marketing, advertising, and promotional expenses directly attributable to the studio or its titles.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this P&L statement record was last modified.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, explanations, or commentary on the P&L statement.',
    `operating_profit` DECIMAL(18,2) COMMENT 'Gross profit minus allocated overhead, depreciation, and royalty accruals, representing the studios operating income.',
    `other_direct_cost` DECIMAL(18,2) COMMENT 'Miscellaneous direct costs not classified under standard categories.',
    `other_revenue` DECIMAL(18,2) COMMENT 'Miscellaneous revenue streams not classified under title royalties, work-for-hire, or engine licensing.',
    `outsourcing_cost` DECIMAL(18,2) COMMENT 'Costs for external contractors, freelancers, and outsourced development services.',
    `platform_certification_cost` DECIMAL(18,2) COMMENT 'Fees and costs associated with platform certification and compliance (console manufacturers, app stores).',
    `qa_testing_cost` DECIMAL(18,2) COMMENT 'Costs for quality assurance, playtesting, user acceptance testing, and certification processes.',
    `reporting_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which this P&L statement is reported (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `reporting_period_end_date` DATE COMMENT 'The end date of the fiscal period covered by this P&L statement.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the fiscal period covered by this P&L statement.',
    `royalty_accrual` DECIMAL(18,2) COMMENT 'Accrued royalty obligations owed to external IP holders, talent, or partners based on studio performance.',
    `statement_status` STRING COMMENT 'The approval and finalization status of this P&L statement.. Valid values are `draft|preliminary|final|audited|restated`',
    `studio_name` STRING COMMENT 'The business name of the development studio for reporting and display purposes.',
    `studio_status` STRING COMMENT 'Current operational status of the studio during this reporting period.. Valid values are `active|inactive|divested|merged|closed`',
    `studio_type` STRING COMMENT 'Classification of the studio ownership and operational model: internal (wholly-owned first-party), external (third-party partner), acquired (recently integrated), joint venture, or work-for-hire contractor.. Valid values are `internal|external|acquired|joint_venture|work_for_hire`',
    `title_royalty_revenue` DECIMAL(18,2) COMMENT 'Revenue earned by the studio from royalties on published game titles during the reporting period.',
    `tooling_cost` DECIMAL(18,2) COMMENT 'Costs for development tools, software licenses, middleware, and third-party SDKs used by the studio.',
    `total_direct_cost` DECIMAL(18,2) COMMENT 'Sum of all direct costs incurred by the studio during the reporting period.',
    `total_revenue` DECIMAL(18,2) COMMENT 'Sum of all revenue streams for the studio during the reporting period.',
    `work_for_hire_revenue` DECIMAL(18,2) COMMENT 'Revenue earned from contracted development services provided to external publishers or partners.',
    CONSTRAINT pk_studio_pl PRIMARY KEY(`studio_pl_id`)
) COMMENT 'Studio-level profit and loss statement consolidating financial performance for each internal and external development studio within Gamings portfolio. Captures studio revenue (title royalties, work-for-hire fees, engine licensing revenue), direct costs (headcount, tooling, infrastructure), allocated overhead, and studio EBITDA. Supports make-vs-buy decisions, studio investment prioritization, and acquisition due diligence.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`royalty_accrual` (
    `royalty_accrual_id` BIGINT COMMENT 'Unique identifier for the royalty accrual record. Primary key for the royalty accrual entity.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: royalty_accrual has gl_account_code (STRING) for the royalty accrual GL account. Normalize by adding chart_of_accounts_id FK to chart_of_accounts.chart_of_accounts_id and removing gl_account_code stri',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: royalty_accrual has cost_center_code (STRING) for cost allocation. Normalize by adding cost_center_id FK to cost_center.cost_center_id and removing cost_center_code string.',
    `employee_id` BIGINT COMMENT 'The user ID of the finance approver who approved this royalty accrual. Null if not yet approved.',
    `game_title_id` BIGINT COMMENT 'Identifier for the game title generating the royalty-bearing revenue or usage. Null if royalty applies across multiple titles or at portfolio level.',
    `ip_agreement_id` BIGINT COMMENT 'Identifier for the licensing or royalty agreement governing this accrual. Links to the master contract defining royalty terms, rates, and payment schedules.',
    `licensee_id` BIGINT COMMENT 'Identifier for the royalty counterparty (IP licensor, music rights holder, engine licensor, external developer partner) to whom royalties are owed.',
    `royalty_statement_id` BIGINT COMMENT 'Unique identifier for the formal royalty statement issued to the counterparty for this accrual period. Null if statement not yet generated.',
    `accrual_period_end_date` DATE COMMENT 'The end date of the period for which royalties are being accrued. Defines the close of the revenue or usage measurement window.',
    `accrual_period_start_date` DATE COMMENT 'The start date of the period for which royalties are being accrued. Defines the beginning of the revenue or usage measurement window.',
    `accrual_status` STRING COMMENT 'Current lifecycle status of the royalty accrual: draft (in preparation), calculated (computation complete), approved (finance approved), posted (posted to GL), settled (payment issued), disputed (under review), or cancelled. [ENUM-REF-CANDIDATE: draft|calculated|approved|posted|settled|disputed|cancelled — 7 candidates stripped; promote to reference product]',
    `accrued_royalty_amount` DECIMAL(18,2) COMMENT 'The total royalty amount accrued for this period, calculated as royalty_base_amount multiplied by royalty_rate_percent, adjusted for any tiers or thresholds.',
    `advance_recouped_amount` DECIMAL(18,2) COMMENT 'The portion of previously paid advances that is recouped (offset) against this accrual periods royalty. Reduces the net payable to the counterparty.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this royalty accrual was approved by finance for posting and payment processing. Null if not yet approved.',
    `audit_trail_notes` STRING COMMENT 'Free-text notes capturing key audit events, adjustments, or manual overrides applied to this accrual for compliance and audit trail purposes.',
    `calculation_method` STRING COMMENT 'The method used to calculate the royalty: flat rate (single percentage), tiered (rate varies by revenue bands), threshold-based (rate changes after threshold), hybrid (combination), or manual (manually entered).. Valid values are `flat_rate|tiered|threshold_based|hybrid|manual`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this royalty accrual record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the accrued royalty amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this royalty accrual is currently under dispute by the counterparty or internal audit.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for the dispute, if dispute_flag is True. Null if no dispute.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year for this royalty accrual, used for financial reporting and period-end close processes.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this royalty accrual period falls, used for financial reporting and period-end close processes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this royalty accrual record was last updated or modified.',
    `net_royalty_payable` DECIMAL(18,2) COMMENT 'The net royalty amount payable to the counterparty after deducting advance recoupment and any other adjustments. This is the amount due for payment.',
    `payment_date` DATE COMMENT 'The date on which the royalty payment was issued to the counterparty. Null if not yet paid.',
    `payment_reference_number` STRING COMMENT 'The reference number of the payment transaction that settled this royalty accrual. Null if not yet paid.',
    `posting_date` DATE COMMENT 'The date on which this royalty accrual was posted to the general ledger. Null if not yet posted.',
    `royalty_base_amount` DECIMAL(18,2) COMMENT 'The total revenue or usage amount (in the accrual period) on which the royalty is calculated, before applying the royalty rate.',
    `royalty_base_type` STRING COMMENT 'The revenue or usage metric on which the royalty calculation is based: net revenue, gross revenue, units sold, in-app purchase (IAP) revenue, downloadable content (DLC) revenue, or subscription revenue.. Valid values are `net_revenue|gross_revenue|units_sold|iap_revenue|dlc_revenue|subscription_revenue`',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'The percentage rate applied to the royalty base to calculate the accrued royalty amount. May vary by tier or threshold as defined in the agreement.',
    `royalty_type` STRING COMMENT 'The category of royalty being accrued: IP license (intellectual property), music rights, engine license (e.g., Unreal, Unity), developer revenue share, platform fee, or other.. Valid values are `ip_license|music_rights|engine_license|developer_revenue_share|platform_fee|other`',
    `source_system` STRING COMMENT 'The name of the source system or module from which the royalty base data was extracted (e.g., SAP S/4HANA SD, GameAnalytics, Steamworks).',
    `statement_due_date` DATE COMMENT 'The date by which payment of the net royalty payable is due to the counterparty, as defined in the agreement payment terms.',
    `statement_issue_date` DATE COMMENT 'The date on which the formal royalty statement was issued to the counterparty. Null if not yet issued.',
    CONSTRAINT pk_royalty_accrual PRIMARY KEY(`royalty_accrual_id`)
) COMMENT 'Royalty accrual, calculation, and statement records representing the complete royalty lifecycle for IP licensors, music rights holders, third-party engine licensors, and external developer partners. Captures accrual period, royalty base (net revenue, units sold, IAP revenue), applicable rate tiers, accrued amount, payment schedule, settlement status, formal statement details (statement period, counterparty breakdown, advances recouped, net payable/receivable), and statement issuance/receipt tracking. Supports royalty calculation, period-end accrual posting, statement generation and issuance to counterparties, royalty audit, dispute resolution, advance recoupment tracking, and accounting accrual posting to GL. Distinct from billing payments — this is the accounting accrual, reporting, and counterparty communication layer.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`royalty_statement` (
    `royalty_statement_id` BIGINT COMMENT 'Unique identifier for the royalty statement. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Royalty statements reference GL accounts for expense and liability posting. This FK enables integration with the general ledger and ensures royalty transactions are posted to the correct GL accounts f',
    `contract_ip_agreement_id` BIGINT COMMENT 'Reference to the master royalty contract or licensing agreement governing the terms of this statement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Royalty expenses are typically allocated to cost centers for operational expense tracking and budget variance analysis. This FK enables cost center managers to track royalty obligations against their ',
    `employee_id` BIGINT COMMENT 'Reference to the internal user who approved this royalty statement for issuance.',
    `game_title_id` BIGINT COMMENT 'Reference to the primary game title or intellectual property (IP) for which royalties are calculated. Null if statement covers multiple titles.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Royalty statements are generated from license agreements to track payment obligations. Finance needs to reference the governing agreement for rate validation, audit trails, and dispute resolution. Ess',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Royalty statements are issued by or to specific legal entities, particularly important for intercompany royalty arrangements and tax withholding compliance. This FK enables proper legal entity attribu',
    `licensee_id` BIGINT COMMENT 'Reference to the royalty counterparty (IP licensor, developer partner, music rights organization, or other rights holder) to whom this statement is issued or from whom it is received.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Royalty statements should be tracked by profit center for title-level or studio-level P&L attribution. This FK enables proper allocation of royalty expenses to the business segments that benefit from ',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Manual or contractual adjustments applied to the royalty (e.g., prior period corrections, dispute settlements, bonus payments).',
    `advance_recoupment_amount` DECIMAL(18,2) COMMENT 'Amount of previously paid advances recouped (offset) against the calculated royalty in this statement period.',
    `approval_status` STRING COMMENT 'Internal approval status of the royalty statement before issuance.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the royalty statement was approved.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this statement to detailed audit trail records for compliance and dispute resolution.',
    `calculated_royalty_amount` DECIMAL(18,2) COMMENT 'Gross royalty amount calculated by applying the royalty rate to the net royalty base (net royalty base × royalty rate).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this royalty statement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this statement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deduction_amount` DECIMAL(18,2) COMMENT 'Total deductions applied to gross revenue (e.g., platform fees, returns, refunds, marketing costs) per contract terms.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the counterparty has raised a dispute or audit query regarding this statement.',
    `dispute_reason` STRING COMMENT 'Free-text description of the dispute reason or audit finding, if dispute_flag is true.',
    `dispute_resolution_date` DATE COMMENT 'Date on which the dispute was resolved or closed. Null if dispute is ongoing.',
    `gross_revenue_amount` DECIMAL(18,2) COMMENT 'Total gross revenue generated during the reporting period before any deductions, used as the starting point for royalty calculation.',
    `marketing_cost_amount` DECIMAL(18,2) COMMENT 'Marketing and promotional costs allocated to this title and deducted per contract terms.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this royalty statement record was last modified.',
    `net_payable_amount` DECIMAL(18,2) COMMENT 'Final net amount payable to the counterparty after all recoupments and adjustments (calculated royalty minus advance recoupment plus/minus adjustments).',
    `net_royalty_base_amount` DECIMAL(18,2) COMMENT 'Net revenue base after deductions, upon which the royalty rate is applied (gross revenue minus deductions).',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this royalty statement, including special terms, exceptions, or clarifications.',
    `payment_date` DATE COMMENT 'Actual date on which payment was made or received. Null if payment is pending.',
    `payment_due_date` DATE COMMENT 'Contractual due date by which the net payable amount must be paid or received.',
    `payment_reference_number` STRING COMMENT 'External payment reference or transaction identifier linking this statement to the payment record.',
    `platform_fees_amount` DECIMAL(18,2) COMMENT 'Total platform distribution fees (e.g., Steam, Epic Games Store, console platform fees) deducted from gross revenue.',
    `reporting_period_end_date` DATE COMMENT 'End date of the period covered by this royalty statement (e.g., quarter end, month end).',
    `reporting_period_start_date` DATE COMMENT 'Start date of the period covered by this royalty statement (e.g., quarter start, month start).',
    `return_refund_amount` DECIMAL(18,2) COMMENT 'Total value of product returns and customer refunds deducted from gross revenue.',
    `royalty_rate_percentage` DECIMAL(18,2) COMMENT 'Effective royalty rate percentage applied to the net royalty base for this statement period. May reflect tiered or blended rates.',
    `royalty_tier` STRING COMMENT 'Tiered royalty bracket applied for this statement period (e.g., Tier 1, Tier 2, Tier 3) if contract uses tiered rates based on revenue thresholds.',
    `statement_issued_date` DATE COMMENT 'Date on which the royalty statement was formally issued to the counterparty.',
    `statement_number` STRING COMMENT 'Externally-known unique identifier for this royalty statement, used for audit and dispute resolution.',
    `statement_status` STRING COMMENT 'Current lifecycle status of the royalty statement in the approval and settlement workflow.. Valid values are `draft|issued|acknowledged|disputed|settled|cancelled`',
    `statement_type` STRING COMMENT 'Indicates whether this statement represents a royalty payable (owed to counterparty) or receivable (owed by counterparty).. Valid values are `payable|receivable`',
    `territory_code` STRING COMMENT 'Geographic territory or region code for which this royalty statement applies (e.g., USA, EUR, APAC). Null if statement is global.',
    `units_sold` BIGINT COMMENT 'Total number of units (game copies, DLC, in-app purchases, or other SKUs) sold during the reporting period that contribute to this royalty calculation.',
    CONSTRAINT pk_royalty_statement PRIMARY KEY(`royalty_statement_id`)
) COMMENT 'Formal royalty statement documents issued to or received from royalty counterparties (IP licensors, developer partners, music rights organizations) summarizing royalty calculations for a defined reporting period. Captures statement period, counterparty, title/SKU breakdown, gross revenue, deductions, net royalty base, applicable rate tiers, calculated royalty, advances recouped, and net payable/receivable. Supports royalty audit and dispute resolution.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`capex_project` (
    `capex_project_id` BIGINT COMMENT 'Unique identifier for the capital expenditure project record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: capex_project has cost_center_code (STRING) referencing the cost center responsible for the project. Normalize by adding cost_center_id FK to cost_center.cost_center_id and removing cost_center_code s',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: capex_project can result in tangible fixed assets (studio equipment, facilities). Add nullable fixed_asset_id FK for projects that capitalize to tangible assets rather than intangible. Asset_number is',
    `game_studio_id` BIGINT COMMENT 'Foreign key reference to the studio master data indicating which development studio or business unit owns this capital project. Used for P&L allocation and studio-level profitability reporting.',
    `game_title_id` BIGINT COMMENT 'Foreign key reference to the game title master data if this capital project is specific to a single game title (e.g., development costs for a specific AAA title). Nullable for non-title-specific projects (infrastructure, engine technology).',
    `intangible_asset_id` BIGINT COMMENT 'Foreign key linking to finance.intangible_asset. Business justification: capex_project tracks game development projects that become intangible assets upon capitalization. capex_project.asset_number (STRING) references the resulting intangible asset. Normalize by adding int',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Capital expenditure projects are owned by specific legal entities for asset capitalization, depreciation, and tax purposes. This FK is essential for proper asset ownership tracking, intercompany asset',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Capital projects are typically allocated to profit centers for P&L tracking, ROI analysis, and segment reporting. This FK enables tracking of capital investment by business segment and supports title-',
    `accounting_standard` STRING COMMENT 'The accounting framework under which this project is capitalized: GAAP (US Generally Accepted Accounting Principles, ASC 350-40 for internal-use software) or IFRS (International Financial Reporting Standards, IAS 38 for intangible assets).. Valid values are `GAAP|IFRS`',
    `accumulated_amortization` DECIMAL(18,2) COMMENT 'Total amortization expense recognized to date for this capitalized asset. Contra-asset account reducing the net book value.',
    `actual_spend_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual capital expenditure incurred on this project from capitalization start date through the current reporting period. Sourced from SAP S/4HANA FI/CO actual postings.',
    `amortization_method` STRING COMMENT 'The depreciation method applied to this asset: straight_line (equal expense each period), accelerated (higher expense in early periods), or units_of_production (based on usage metrics such as player sessions or revenue).. Valid values are `straight_line|accelerated|units_of_production`',
    `amortization_period_months` STRING COMMENT 'The total number of months over which the capitalized asset will be amortized (depreciated). Typically 36-60 months for software and technology assets, per company policy and accounting standards.',
    `amortization_start_date` DATE COMMENT 'The date on which amortization (depreciation) of the capitalized asset begins, typically the go-live date or the first day of the month following go-live.',
    `approval_date` DATE COMMENT 'The date on which the capital project budget was formally approved by finance and executive leadership.',
    `approved_budget_amount` DECIMAL(18,2) COMMENT 'Total capital expenditure budget approved for this project by finance and executive leadership. Represents the maximum authorized spend for capitalization.',
    `asset_class` STRING COMMENT 'Fixed asset classification for the capitalized asset: software (internal-use software, game code), technology (servers, network equipment), building (owned real estate), equipment (hardware, furniture), leasehold_improvement (tenant improvements), or other.. Valid values are `software|technology|building|equipment|leasehold_improvement|other`',
    `asset_under_construction_balance` DECIMAL(18,2) COMMENT 'Current balance sheet value of the asset under construction (AUC) for this project. Represents capitalized costs accumulated but not yet placed in service. Transfers to fixed asset or intangible asset account upon go-live.',
    `audit_trail_notes` STRING COMMENT 'Free-text field for finance and audit teams to document key decisions, adjustments, impairment assessments, or other material events related to this capital project. Used for SOX compliance and external audit support.',
    `business_justification` STRING COMMENT 'Executive summary of the business case and strategic rationale for this capital investment (e.g., expected ROI, competitive advantage, platform expansion, regulatory compliance).',
    `capitalization_end_date` DATE COMMENT 'The date on which the project exited the capitalization phase, typically when the asset is placed in service (go-live date for software, completion date for infrastructure). Nullable for projects still in progress.',
    `capitalization_start_date` DATE COMMENT 'The date on which the project entered the capitalization phase, meaning costs incurred from this date forward qualify for capitalization under the applicable accounting standard (typically when technological feasibility is established for software projects).',
    `capitalization_status` STRING COMMENT 'Current lifecycle status of the capital project: planning (pre-approval), approved (budget authorized), in_progress (active spend phase), capitalized (asset placed in service, amortization started), amortizing (ongoing depreciation), closed (project complete and fully amortized or written off).. Valid values are `planning|approved|in_progress|capitalized|amortizing|closed`',
    `committed_amount` DECIMAL(18,2) COMMENT 'Total value of purchase orders and contractual commitments issued against this project that have not yet been invoiced or paid. Used for budget tracking and forecasting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capital project record was first created in the system. Audit field for data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this record (e.g., USD, EUR, GBP). Typically the functional currency of the owning studio or corporate entity.. Valid values are `^[A-Z]{3}$`',
    `expected_roi_percent` DECIMAL(18,2) COMMENT 'Projected return on investment for this capital project, expressed as a percentage. Used for investment prioritization and post-launch performance evaluation.',
    `go_live_date` DATE COMMENT 'The date the capitalized asset was placed into production use (e.g., game launch date, engine release date, infrastructure cutover date). Triggers the start of amortization. Nullable for projects not yet live.',
    `impairment_indicator_flag` BOOLEAN COMMENT 'Boolean flag indicating whether an impairment indicator has been identified for this asset (e.g., project cancellation, significant underperformance, technology obsolescence). Triggers impairment testing per ASC 350-30 or IAS 36.',
    `impairment_loss_amount` DECIMAL(18,2) COMMENT 'Total impairment loss recognized for this asset to date. Represents write-downs when the carrying value exceeds recoverable amount. Nullable if no impairment has occurred.',
    `internal_order_number` STRING COMMENT 'SAP S/4HANA internal order number used to collect costs for this capital project. Alternative to WBS element for simpler project structures.. Valid values are `^[A-Z0-9]{6,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this capital project record was last updated. Audit field for change tracking.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current net book value of the capitalized asset: asset_under_construction_balance (or capitalized cost if live) minus accumulated_amortization. Represents the carrying value on the balance sheet.',
    `project_code` STRING COMMENT 'Business identifier for the capital project, typically aligned with SAP S/4HANA internal order or Work Breakdown Structure (WBS) element code. Used for cross-system reference and financial reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `project_description` STRING COMMENT 'Detailed business description of the capital project scope, objectives, and deliverables. Used for reporting and audit documentation.',
    `project_name` STRING COMMENT 'Human-readable name of the capital project (e.g., Unreal Engine 5 Migration, New Studio Build-Out Seattle, Cloud Infrastructure Expansion EMEA).',
    `project_type` STRING COMMENT 'Classification of the capital project by business purpose: game development (title-specific capitalized development costs), engine technology (game engine licensing or internal development), infrastructure (servers, CDN, cloud), studio facility (physical office or production space), platform integration (console SDK, storefront integration), or other.. Valid values are `game_development|engine_technology|infrastructure|studio_facility|platform_integration|other`',
    `record_source_system` STRING COMMENT 'Name of the source system from which this capital project record originated (e.g., SAP S/4HANA, Jira, internal project management tool). Used for data lineage and reconciliation.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this capital project has specific regulatory compliance requirements (e.g., GDPR data infrastructure, PCI DSS payment systems, platform certification costs).',
    `remaining_budget` DECIMAL(18,2) COMMENT 'Calculated remaining budget available for this project: approved_budget_amount minus (actual_spend_to_date plus committed_amount). May be negative if project is over budget.',
    `wbs_element` STRING COMMENT 'SAP S/4HANA Project System (PS) Work Breakdown Structure element code for this capital project. Hierarchical project structure used for detailed cost tracking and reporting.. Valid values are `^[A-Z0-9-.]{6,24}$`',
    CONSTRAINT pk_capex_project PRIMARY KEY(`capex_project_id`)
) COMMENT 'Capital expenditure project records tracking game development projects, engine technology investments, and infrastructure build-outs that qualify for capitalization under GAAP/IFRS (ASC 350-40 internal-use software, IAS 38 intangible assets). Captures project code, capitalization start/end dates, total approved capex budget, spend-to-date, asset under construction balance, and amortization schedule upon go-live. Links to SAP internal orders and WBS elements.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`intangible_asset` (
    `intangible_asset_id` BIGINT COMMENT 'Unique identifier for the intangible asset record. Primary key for the intangible asset register.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: intangible_asset has gl_account_code (STRING) for the intangible asset account. Normalize by adding chart_of_accounts_id FK to chart_of_accounts.chart_of_accounts_id and removing gl_account_code strin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: intangible_asset has cost_center_code (STRING) identifying the cost center responsible for the asset. Normalize by adding cost_center_id FK to cost_center.cost_center_id and removing cost_center_code ',
    `game_studio_id` BIGINT COMMENT 'Foreign key reference to the studio that developed or owns this intangible asset. Applicable for studio-specific IP, development costs, and acquired goodwill from studio acquisitions.',
    `game_title_id` BIGINT COMMENT 'Foreign key reference to the game title this intangible asset is associated with. Applicable for game IP, development costs, and title-specific brands. Null for corporate-level assets like goodwill or enterprise engine technology.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Intangible assets (capitalized game development costs, acquired IP, engine technology) are owned by specific legal entities for asset ownership, amortization, and tax purposes. This FK is essential fo',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: When licensed IP is acquired or capitalized (e.g., purchased engine licenses, acquired IP rights), it becomes an intangible asset. Required for impairment testing, amortization tracking, and linking a',
    `ml_model_registry_id` BIGINT COMMENT 'Foreign key linking to analytics.ml_model_registry. Business justification: ML models meeting capitalization criteria (internally developed, future economic benefit, technical feasibility) are recorded as intangible assets under IFRS/GAAP. Finance links asset records to model',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Intangible assets may be allocated to profit centers for segment-level asset tracking and ROI analysis. This FK enables tracking of intangible asset investment by business segment (e.g., title-level o',
    `accounting_standard` STRING COMMENT 'Accounting standard under which this intangible asset is recorded and reported. US GAAP follows ASC 350/985. IFRS follows IAS 38. Local GAAP applies jurisdiction-specific standards.. Valid values are `US_GAAP|IFRS|local_GAAP`',
    `accumulated_amortization` DECIMAL(18,2) COMMENT 'Total amortization expense recognized to date since the asset was placed in service. Contra-asset account that reduces gross carrying amount to arrive at net book value.',
    `accumulated_impairment` DECIMAL(18,2) COMMENT 'Total impairment charges recognized to date for this intangible asset. Impairment occurs when the carrying amount exceeds recoverable amount per ASC 360 or IAS 36. Common for game IP when actual performance falls short of projections.',
    `acquisition_date` DATE COMMENT 'Date the intangible asset was acquired or the date capitalized development costs were first recognized. For internally developed assets, this is the date development costs began to be capitalized per ASC 985-20.',
    `acquisition_method` STRING COMMENT 'Method by which the intangible asset was acquired. Internal development represents capitalized development costs. Business acquisition represents assets acquired through studio or company acquisitions. Asset purchase represents direct purchase of IP or technology. License acquisition represents purchased licenses with capitalized costs.. Valid values are `internal_development|business_acquisition|asset_purchase|license_acquisition`',
    `amortization_end_date` DATE COMMENT 'Expected date when the intangible asset will be fully amortized based on useful life and amortization method. Null for indefinite-lived assets.',
    `amortization_method` STRING COMMENT 'Method used to amortize the intangible asset. Straight-line spreads cost evenly over useful life. Units-of-production amortizes based on actual revenue or usage relative to expected total (common for game development costs per ASC 985-20). Declining balance accelerates amortization. Not amortized applies to indefinite-lived assets like goodwill.. Valid values are `straight_line|units_of_production|declining_balance|not_amortized`',
    `amortization_start_date` DATE COMMENT 'Date amortization of the intangible asset began. Typically the same as capitalization date when the asset is placed in service.',
    `asset_class` STRING COMMENT 'Classification of the intangible asset type. Game IP includes intellectual property rights for game titles and franchises. Engine technology includes proprietary game engines and middleware. Development costs represent capitalized game development expenditures. Goodwill arises from studio acquisitions. Player relationships represent acquired user bases. Licenses include third-party IP licenses. [ENUM-REF-CANDIDATE: game_ip|engine_technology|brand|goodwill|player_relationships|development_costs|licenses — 7 candidates stripped; promote to reference product]',
    `asset_name` STRING COMMENT 'Human-readable name of the intangible asset (e.g., Fortnite IP, Unreal Engine Technology, Studio XYZ Acquisition Goodwill).',
    `asset_number` STRING COMMENT 'Business identifier for the intangible asset, typically assigned by the finance system. Used for external reporting and audit trails.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `asset_subclass` STRING COMMENT 'Detailed sub-classification within the asset class (e.g., AAA Title IP, Mobile Game IP, Physics Engine, Rendering Technology, Character Brand, Studio Brand).',
    `capitalization_date` DATE COMMENT 'Date the intangible asset was placed in service and amortization began. For game development costs, this is typically the commercial release date (Gold Master or Hard Launch).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this intangible asset record was first created in the system. Audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts (gross carrying amount, accumulated amortization, net book value). Typically USD for US-based gaming companies.. Valid values are `^[A-Z]{3}$`',
    `disposal_date` DATE COMMENT 'Date the intangible asset was disposed of through sale, abandonment, or write-off. Null for assets still held.',
    `disposal_gain_loss` DECIMAL(18,2) COMMENT 'Gain or loss recognized on disposal of the intangible asset. Calculated as disposal proceeds minus net book value at disposal date. Positive values indicate gain, negative values indicate loss.',
    `disposal_method` STRING COMMENT 'Method by which the intangible asset was disposed. Sale indicates the asset was sold to a third party. Abandonment indicates the asset was voluntarily relinquished. Write-off indicates the asset was removed due to impairment or obsolescence. Transfer indicates the asset was transferred to another entity within the group.. Valid values are `sale|abandonment|write_off|transfer`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Cash or fair value of consideration received from disposal of the intangible asset. Used to calculate gain or loss on disposal. Null for assets not yet disposed or disposed without proceeds.',
    `gross_carrying_amount` DECIMAL(18,2) COMMENT 'Original cost or fair value of the intangible asset at acquisition or capitalization, before any accumulated amortization or impairment. Represents the total capitalized cost for internally developed assets or purchase price for acquired assets.',
    `is_indefinite_lived` BOOLEAN COMMENT 'Flag indicating whether the intangible asset has an indefinite useful life. True for goodwill and certain brands that are expected to generate cash flows indefinitely. Indefinite-lived assets are not amortized but tested annually for impairment.',
    `is_internally_developed` BOOLEAN COMMENT 'Flag indicating whether the intangible asset was internally developed (true) or externally acquired (false). Internally developed assets follow ASC 985-20 capitalization rules for game development costs.',
    `last_impairment_charge_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent impairment charge recognized. Represents the write-down from carrying amount to recoverable amount. Null if no impairment has been recorded.',
    `last_impairment_charge_date` DATE COMMENT 'Date of the most recent impairment charge recognized for this intangible asset. Null if no impairment has been recorded.',
    `last_impairment_test_date` DATE COMMENT 'Date of the most recent impairment test performed on this intangible asset. Goodwill and indefinite-lived intangibles must be tested annually per ASC 350. Finite-lived intangibles are tested when indicators of impairment exist per ASC 360.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this intangible asset record was last updated. Audit trail for data lineage and compliance.',
    `lifecycle_status` STRING COMMENT 'Current state of the intangible asset in its lifecycle. Active indicates the asset is in use and being amortized. Fully amortized indicates the asset has reached the end of its useful life but may still be in use. Impaired indicates the asset has suffered an impairment charge. Disposed indicates the asset has been sold or written off. Under development indicates capitalized costs not yet placed in service.. Valid values are `active|fully_amortized|impaired|disposed|under_development`',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the intangible asset on the balance sheet. Calculated as gross carrying amount minus accumulated amortization minus accumulated impairment. Represents the unamortized cost remaining.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the intangible asset. May include details about acquisition terms, impairment triggers, or special accounting treatments.',
    `residual_value` DECIMAL(18,2) COMMENT 'Estimated residual or salvage value of the intangible asset at the end of its useful life. Typically zero for most intangible assets, but may have value for certain IP or technology that can be sold or licensed after primary use.',
    `tax_basis` DECIMAL(18,2) COMMENT 'Tax basis of the intangible asset for income tax purposes. May differ from book basis due to different capitalization and amortization rules. Used to calculate deferred tax assets or liabilities per ASC 740.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Estimated useful life of the intangible asset in years. For game IP, typically 2-5 years based on expected revenue generation period. For engine technology, typically 5-10 years. For goodwill, indefinite (not amortized but tested for impairment annually). Null for indefinite-lived assets.',
    CONSTRAINT pk_intangible_asset PRIMARY KEY(`intangible_asset_id`)
) COMMENT 'Intangible asset register for Gamings capitalized game development costs, acquired IP, engine technology, and brand assets. Captures asset class, acquisition/capitalization date, useful life, amortization method (straight-line, units-of-production), gross carrying amount, accumulated amortization, net book value, impairment charges, and disposal records. Supports GAAP ASC 350/985 and IFRS IAS 38 compliance for game development cost capitalization.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Unique identifier for the cost allocation record. Primary key for the cost allocation entity.',
    `allocation_cycle_id` BIGINT COMMENT 'Identifier of the allocation cycle or run during which this cost allocation was executed. Links to the batch or period in which allocations were processed.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: cost_allocation has cost_element_code and cost_element_name (STRING) referencing chart of accounts cost elements. Normalize by adding chart_of_accounts_id FK and removing redundant cost_element_code a',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game development studio to which the allocated cost is attributed. Used for studio-level P&L reporting. Nullable if allocation is not studio-specific.',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title to which the allocated cost is attributed. Used for title-level profitability analysis and P&L construction. Nullable if allocation is not title-specific.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Cost allocations occur within legal entity boundaries for proper accounting and to prevent improper intercompany allocations. This FK ensures allocations are tracked by legal entity for consolidation ',
    `original_allocation_cost_allocation_id` BIGINT COMMENT 'Identifier of the original cost allocation record that this entry reverses or adjusts. Nullable if this is not a reversal or adjustment.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center that is the source of the allocated cost. References the cost center that incurred the original expense being distributed.',
    `profit_center_id` BIGINT COMMENT 'Identifier of the profit center receiving the allocated cost. Used for title-level and studio-level P&L (Profit and Loss) construction.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Monetary amount of cost allocated from the sender cost center to the receiver cost center or profit center. Expressed in the reporting currency.',
    `allocation_base_unit` STRING COMMENT 'Unit of measure for the allocation base value. Examples: FTE (Full-Time Equivalent), USD, hours, square_meters, transactions.',
    `allocation_base_value` DECIMAL(18,2) COMMENT 'Quantitative value of the allocation key driver for the receiver. For example, headcount number, revenue amount, server hours, or square meters used by the receiver.',
    `allocation_key_code` STRING COMMENT 'Code representing the allocation key or driver used to distribute costs. Examples include headcount, revenue share, server usage, square footage, or transaction volume.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `allocation_key_name` STRING COMMENT 'Descriptive name of the allocation key or driver used for cost distribution. Human-readable label for the allocation basis.',
    `allocation_method` STRING COMMENT 'Method used to perform the cost allocation. Direct assigns costs directly to receivers; step-down allocates in a sequential hierarchy; reciprocal accounts for mutual service exchanges; activity-based uses activity drivers.. Valid values are `direct|step_down|reciprocal|activity_based`',
    `allocation_notes` STRING COMMENT 'Free-text notes or comments providing additional context or explanation for this cost allocation. Used for documentation and audit purposes.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total sender cost center expense allocated to this receiver. Represents the proportional share of the allocation key driver.',
    `allocation_run_date` DATE COMMENT 'Date on which the allocation cycle was executed and this allocation record was created. Represents the processing date of the allocation batch.',
    `allocation_status` STRING COMMENT 'Current status of the cost allocation record in its lifecycle. Indicates whether the allocation is preliminary, finalized, or has been adjusted or reversed.. Valid values are `draft|posted|reversed|adjusted|final`',
    `controlling_area` STRING COMMENT 'Controlling area code representing the organizational unit for cost accounting purposes. Defines the scope of cost center and profit center accounting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_type` STRING COMMENT 'High-level category of the cost being allocated. Classifies the nature of the shared cost for reporting and analysis purposes. [ENUM-REF-CANDIDATE: shared_services|platform_infrastructure|corporate_overhead|engine_licensing|it_services|facilities|hr_services|finance_services|legal_services|other — 10 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost allocation record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocated amount. Standard currency identifier for financial reporting.. Valid values are `^[A-Z]{3}$`',
    `document_number` STRING COMMENT 'Unique document number assigned by the financial system for this cost allocation posting. Used for audit trail and reconciliation with general ledger.. Valid values are `^[A-Z0-9]{8,20}$`',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year to which this cost allocation applies. Typically 1-12 for monthly periods or 1-4 for quarterly periods.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this cost allocation applies. Four-digit year representing the financial reporting period.',
    `modified_by` STRING COMMENT 'Username or identifier of the user or system process that last modified this cost allocation record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost allocation record was last modified. Used for audit trail and change tracking.',
    `posting_date` DATE COMMENT 'Date on which the cost allocation was posted to the general ledger and cost accounting modules. Represents the accounting effective date.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this allocation record is a reversal of a previous allocation. True if this is a reversal entry; False otherwise.',
    `source_system` STRING COMMENT 'Name or identifier of the source system from which this cost allocation record originated. Typically SAP S/4HANA FI/CO or a custom allocation engine.',
    `source_system_code` STRING COMMENT 'Unique identifier of this cost allocation record in the source system. Used for data lineage and reconciliation with upstream systems.',
    `created_by` STRING COMMENT 'Username or identifier of the user or system process that created this cost allocation record. Used for audit trail and accountability.',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Internal cost allocation and recharge records distributing shared costs (shared services, platform infrastructure, corporate overhead, engine licensing fees) across receiving cost centers and profit centers using defined allocation keys (headcount, revenue share, server usage). Captures sender cost center, receiver cost center/profit center, allocation cycle, allocation key, allocated amount, and fiscal period. Supports accurate title-level and studio-level P&L construction.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique identifier for the intercompany transaction record. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: intercompany_transaction has gl_account_code (STRING) for the intercompany GL account. Normalize by adding chart_of_accounts_id FK to chart_of_accounts.chart_of_accounts_id and removing gl_account_cod',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: intercompany_transaction has cost_center_code (STRING) for cost allocation. Normalize by adding cost_center_id FK to cost_center.cost_center_id and removing cost_center_code string.',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game development studio associated with the intercompany transaction, if applicable (e.g., cost recharges to a studio).',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title associated with the intercompany transaction, if applicable (e.g., royalty transfers for a specific game).',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity originating the intercompany transaction (e.g., parent company, studio subsidiary, regional publishing entity).',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: intercompany_transaction has profit_center_code (STRING) for P&L allocation. Normalize by adding profit_center_id FK to profit_center.profit_center_id and removing profit_center_code string.',
    `receiving_entity_legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity receiving the intercompany transaction (e.g., studio subsidiary, esports subsidiary, regional entity).',
    `approval_status` STRING COMMENT 'Indicates the approval workflow status of the intercompany transaction.. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'The username or identifier of the person who approved the intercompany transaction.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was first created in the system.',
    `due_date` DATE COMMENT 'The date by which the intercompany transaction amount is due for settlement between entities.',
    `elimination_date` DATE COMMENT 'The date on which the intercompany transaction was eliminated in the consolidation process.',
    `elimination_status` STRING COMMENT 'Indicates whether the intercompany transaction has been eliminated in the consolidated financial statements to avoid double-counting.. Valid values are `pending|eliminated|partially_eliminated|not_applicable`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the transaction currency to the functional or group currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year in which the intercompany transaction is recorded.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the intercompany transaction is recorded for financial reporting purposes.',
    `functional_currency` STRING COMMENT 'The three-letter ISO 4217 currency code representing the functional currency of the sending entity.. Valid values are `^[A-Z]{3}$`',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the functional currency of the sending entity for local reporting.',
    `group_currency` STRING COMMENT 'The three-letter ISO 4217 currency code representing the group-level reporting currency (typically USD for Gaming).. Valid values are `^[A-Z]{3}$`',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the group reporting currency for consolidated financial statements.',
    `intercompany_transaction_description` STRING COMMENT 'Free-text description providing additional context or details about the intercompany transaction.',
    `modified_by` STRING COMMENT 'The username or identifier of the person who last modified the intercompany transaction record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the intercompany transaction record was last modified in the system.',
    `payment_terms` STRING COMMENT 'The agreed payment terms for the intercompany transaction (e.g., Net 30, Net 60, Due on Receipt).',
    `posting_date` DATE COMMENT 'The date on which the intercompany transaction was posted to the general ledger, which may differ from the transaction date for period-end adjustments.',
    `reconciliation_reference` STRING COMMENT 'Reference number or identifier linking this transaction to the corresponding entry in the receiving entitys books for reconciliation purposes.',
    `reconciliation_status` STRING COMMENT 'Indicates whether the intercompany transaction has been reconciled between the sending and receiving entities.. Valid values are `matched|unmatched|disputed|resolved`',
    `settlement_date` DATE COMMENT 'The date on which the intercompany transaction was fully settled (paid) between the entities.',
    `settlement_status` STRING COMMENT 'Indicates whether the intercompany transaction has been settled (paid) between the entities.. Valid values are `unsettled|partially_settled|fully_settled|written_off`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount calculated on the intercompany transaction in the transaction currency.',
    `tax_code` STRING COMMENT 'The tax code applied to the intercompany transaction for VAT, GST, or other applicable taxes.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary value of the intercompany transaction in the transaction currency.',
    `transaction_currency` STRING COMMENT 'The three-letter ISO 4217 currency code in which the intercompany transaction was originally denominated.. Valid values are `^[A-Z]{3}$`',
    `transaction_date` DATE COMMENT 'The date on which the intercompany transaction was executed or recorded in the financial system.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number or document reference for the intercompany transaction, typically generated by the ERP system.',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction indicating the nature of the financial flow between entities. [ENUM-REF-CANDIDATE: intercompany_loan|management_fee|royalty_transfer|cost_recharge|service_fee|license_fee|dividend|equity_contribution — 8 candidates stripped; promote to reference product]',
    `transfer_pricing_method` STRING COMMENT 'The transfer pricing methodology applied to determine the intercompany transaction price for tax compliance and regulatory purposes.. Valid values are `cost_plus|market_price|negotiated|comparable_uncontrolled_price|resale_price|profit_split`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The withholding tax amount deducted from the intercompany transaction, if applicable for cross-border transactions.',
    `created_by` STRING COMMENT 'The username or identifier of the person who created the intercompany transaction record in the system.',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Intercompany financial transactions between Gamings legal entities (parent company, studio subsidiaries, regional publishing entities, esports subsidiaries). Captures transaction type (intercompany loan, management fee, royalty transfer, cost recharge), sending entity, receiving entity, transaction amount, currency, elimination status, and reconciliation reference. Supports consolidated financial statement preparation and intercompany elimination in SAP FI.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity. Primary key for the legal entity master data table.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: legal_entity has chart_of_accounts_code (STRING) identifying the chart of accounts used by the entity. Normalize by adding chart_of_accounts_id FK to chart_of_accounts.chart_of_accounts_id and removin',
    `parent_entity_legal_entity_id` BIGINT COMMENT 'Reference to the immediate parent legal entity in the corporate ownership hierarchy. Used to construct consolidation hierarchies and organizational reporting structures.',
    `primary_ultimate_parent_entity_legal_entity_id` BIGINT COMMENT 'Reference to the top-level parent entity in the corporate group. Used for ultimate consolidation and group-level regulatory reporting.',
    `audit_opinion_type` STRING COMMENT 'The type of audit opinion issued by the external auditor for the most recent fiscal year. Unqualified is clean; qualified indicates exceptions; adverse indicates material misstatement; disclaimer indicates scope limitation.. Valid values are `unqualified|qualified|adverse|disclaimer`',
    `auditor_name` STRING COMMENT 'Name of the external audit firm responsible for statutory audit of this legal entity. Used for audit coordination and regulatory compliance.',
    `business_segment` STRING COMMENT 'The primary business segment or operating division to which this legal entity belongs. Used for segment reporting under IFRS 8 and management reporting.. Valid values are `game_development|game_publishing|esports_operations|game_engine_licensing|platform_services`',
    `company_code` STRING COMMENT 'The SAP S/4HANA company code representing this legal entity in the ERP system. Used as the organizational unit for financial accounting and statutory reporting.',
    `consolidation_group_code` STRING COMMENT 'Identifier for the consolidation group or reporting unit to which this entity belongs. Used for segment reporting and management consolidation hierarchies.',
    `consolidation_method` STRING COMMENT 'The accounting method used to consolidate this entity into group financial statements. Full consolidation for subsidiaries, proportional for joint ventures, equity method for associates, none for non-consolidated entities.. Valid values are `full|proportional|equity|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was first created in the system. Used for audit trail and data lineage tracking.',
    `dissolution_date` DATE COMMENT 'The date on which the legal entity was officially dissolved or deregistered. Null for active entities. Used for entity lifecycle tracking and historical reporting.',
    `entity_status` STRING COMMENT 'Current operational and legal status of the entity. Active entities are operational and reporting; dormant entities are registered but inactive; liquidation and dissolved entities are in wind-down or closed.. Valid values are `active|dormant|liquidation|dissolved|suspended|pending_incorporation`',
    `entity_type` STRING COMMENT 'Classification of the legal entity structure. Determines consolidation treatment and reporting requirements.. Valid values are `holding_company|subsidiary|joint_venture|branch|special_purpose_vehicle|partnership`',
    `fiscal_year_end_month` STRING COMMENT 'The month number (1-12) in which the entitys fiscal year ends. Used for statutory reporting deadlines and audit planning.',
    `fiscal_year_variant` STRING COMMENT 'Code representing the fiscal year calendar configuration for this entity. Defines the number of periods, period start/end dates, and year-end closing rules.',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the primary economic environment currency in which the entity operates. Used for financial statement preparation and consolidation.. Valid values are `^[A-Z]{3}$`',
    `geographic_region` STRING COMMENT 'The geographic region in which the entity primarily operates. Used for geographic segment reporting and regional performance analysis.. Valid values are `north_america|europe|asia_pacific|latin_america|middle_east_africa`',
    `incorporation_date` DATE COMMENT 'The date on which the legal entity was officially incorporated or registered in its jurisdiction. Used for statutory reporting and entity lifecycle tracking.',
    `intercompany_partner_number` STRING COMMENT 'Unique identifier used for intercompany transactions and transfer pricing documentation. Links to intercompany reconciliation and elimination processes.',
    `is_regulated_entity` BOOLEAN COMMENT 'Boolean flag indicating whether the entity is subject to industry-specific regulatory oversight beyond standard corporate law (e.g., gaming commissions, financial services regulators). True if regulated, false otherwise.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the jurisdiction where the entity is legally incorporated or registered. Determines applicable legal and tax frameworks.. Valid values are `^[A-Z]{3}$`',
    `last_audit_date` DATE COMMENT 'The date on which the most recent statutory audit was completed and the audit report was issued.',
    `legal_name` STRING COMMENT 'The official registered legal name of the entity as recorded in the jurisdiction of incorporation. Used for statutory filings, contracts, and regulatory reporting.',
    `lei_code` STRING COMMENT 'The 20-character ISO 17442 Legal Entity Identifier used for global financial reporting and regulatory transparency. Required for entities engaged in financial transactions.. Valid values are `^[A-Z0-9]{20}$`',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'The percentage of equity ownership held by the parent company or controlling entity. Used to determine consolidation treatment and minority interest calculations.',
    `primary_contact_email` STRING COMMENT 'Primary email address for official correspondence with the legal entity. Used for statutory notices and regulatory communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the legal entity. Used for official communications and regulatory inquiries.',
    `registered_address_line1` STRING COMMENT 'First line of the official registered address of the legal entity as recorded with the jurisdiction authority. Used for statutory correspondence and legal notices.',
    `registered_address_line2` STRING COMMENT 'Second line of the official registered address, typically containing suite, floor, or building information.',
    `registered_city` STRING COMMENT 'City or municipality of the registered address.',
    `registered_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the registered address.. Valid values are `^[A-Z]{3}$`',
    `registered_postal_code` STRING COMMENT 'Postal or ZIP code of the registered address.',
    `registered_state_province` STRING COMMENT 'State, province, or administrative region of the registered address.',
    `registration_number` STRING COMMENT 'The official registration or incorporation number assigned by the jurisdiction authority. Used for statutory filings and regulatory compliance.',
    `regulatory_authority` STRING COMMENT 'Name of the primary regulatory body with oversight authority over this entity. Applicable for regulated entities such as those holding gaming licenses or financial services licenses.',
    `regulatory_filing_requirement` STRING COMMENT 'Classification of the entitys regulatory filing obligations. Public entities file with securities regulators; private entities file with corporate registries; exempt entities have reduced filing requirements.. Valid values are `public|private|exempt`',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used for consolidated group reporting. May differ from functional currency for subsidiaries operating in different economic environments.. Valid values are `^[A-Z]{3}$`',
    `short_name` STRING COMMENT 'Abbreviated or trading name used for internal reporting and operational purposes. Commonly used in dashboards and management reports.',
    `stock_exchange_listing` STRING COMMENT 'The stock exchange and ticker symbol if the entity is publicly traded. Null for private entities. Used for investor relations and market data integration.',
    `tax_identification_number` STRING COMMENT 'The primary tax identification number assigned by the jurisdiction tax authority. Used for tax filings, transfer pricing documentation, and regulatory compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was last modified. Used for change tracking and audit trail.',
    `vat_registration_number` STRING COMMENT 'The VAT or GST registration number for jurisdictions requiring indirect tax registration. Used for VAT returns and cross-border transaction reporting.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master data for Gamings legal entities including parent holding company, wholly-owned studio subsidiaries, joint ventures, regional publishing entities, esports operating companies, and special purpose vehicles for IP holding. Captures legal entity name, registration number, jurisdiction, functional currency, consolidation method (full, proportional, equity), consolidation group, tax identification numbers, fiscal year variant, chart of accounts assignment, and intercompany partner number. Serves as the organizational anchor for all financial reporting hierarchies, statutory filings, and transfer pricing documentation.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the chart of accounts entry. Primary key for this master resource entity.',
    `account_category` STRING COMMENT 'The primary financial statement category indicating whether this account appears on the balance sheet, profit and loss statement, or is used for statistical tracking only.. Valid values are `balance_sheet|profit_and_loss|statistical`',
    `account_description` STRING COMMENT 'Detailed description of the GL account explaining its purpose, usage, and what types of transactions should be posted to it.',
    `account_group` STRING COMMENT 'The hierarchical grouping code used to organize accounts into logical clusters for reporting and analysis. Gaming-specific groups include game development costs, platform fees, virtual currency liability, and esports operations.',
    `account_name` STRING COMMENT 'The short descriptive name of the GL account used for display and identification purposes.',
    `account_status` STRING COMMENT 'The current lifecycle status of the account indicating whether it is active for use, blocked from new postings, or marked for deletion.. Valid values are `active|blocked|marked_for_deletion`',
    `account_subgroup` STRING COMMENT 'Secondary level of account grouping providing finer granularity within account groups for detailed financial analysis and reporting.',
    `account_type` STRING COMMENT 'The fundamental financial statement classification of the account indicating whether it represents assets, liabilities, equity, revenue, or expenses.. Valid values are `asset|liability|equity|revenue|expense`',
    `balance_sheet_classification` STRING COMMENT 'For balance sheet accounts, indicates whether the account represents current or non-current assets/liabilities, or equity. Not applicable for P&L accounts.. Valid values are `current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable`',
    `business_area_required_indicator` BOOLEAN COMMENT 'Flag indicating whether a business area assignment is mandatory when posting to this account, enabling cross-company business segment reporting.',
    `capitalization_eligible_indicator` BOOLEAN COMMENT 'Flag indicating whether costs posted to this account are eligible for capitalization as game development assets under ASC 985-20 software development cost accounting.',
    `company_code` STRING COMMENT 'The SAP company code to which this account is assigned, representing the legal entity for financial reporting purposes. Multiple company codes may use the same account structure.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidation_account_code` STRING COMMENT 'The account code used in group consolidation reporting, enabling mapping from local company chart of accounts to standardized group reporting structure.',
    `controlling_area` STRING COMMENT 'The SAP Controlling (CO) area code used for management accounting and cost center reporting, enabling cross-company cost analysis.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_required_indicator` BOOLEAN COMMENT 'Flag indicating whether a cost center assignment is mandatory when posting to this account, enabling departmental cost tracking.',
    `cost_element_category` STRING COMMENT 'For accounts that are cost elements, indicates whether they are primary cost elements (linked to GL accounts) or secondary cost elements (used for internal allocations only).. Valid values are `primary|secondary|not_applicable`',
    `cost_element_indicator` BOOLEAN COMMENT 'Flag indicating whether this GL account is also defined as a cost element in SAP CO for cost center and internal order postings.',
    `created_by_user` STRING COMMENT 'The SAP user ID of the person who created this account master record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this account master record was first created in the system.',
    `currency_type` STRING COMMENT 'Indicates which currency types are maintained for this account: local currency only, group currency, transaction currency, or all currency types for multi-currency reporting.. Valid values are `local|group|transaction|all`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether increases to this account are recorded as debits or credits, following standard accounting conventions for the account type.. Valid values are `debit|credit`',
    `esports_category` STRING COMMENT 'For esports-related accounts, indicates the specific esports financial category (e.g., prize pool accruals, tournament operations, sponsorship revenue, broadcast rights, team salaries) to enable esports P&L tracking.',
    `field_status_group` STRING COMMENT 'The SAP field status group code that controls which fields are required, optional, or suppressed when posting to this account.. Valid values are `^[A-Z0-9]{4}$`',
    `financial_statement_line_item` STRING COMMENT 'The specific line item on published financial statements where this account balance is reported, enabling mapping from GL detail to external reporting.',
    `functional_area` STRING COMMENT 'The functional area code used for segment reporting and cost-of-sales accounting, enabling analysis by business function (e.g., game development, publishing, live ops, esports).',
    `gaming_account_purpose` STRING COMMENT 'Gaming-industry-specific classification describing the specialized purpose of this account (e.g., deferred revenue for GaaS subscriptions, season pass liability, game development cost capitalization, virtual currency liability, platform fee expense, esports prize pool accruals, royalty accruals, DLC revenue, MTX revenue, licensing revenue).',
    `gl_account_code` STRING COMMENT 'The unique account number used to identify this GL account in the financial system. This is the externally-known business identifier used in all financial transactions and reporting.. Valid values are `^[0-9]{6,10}$`',
    `last_modified_by_user` STRING COMMENT 'The SAP user ID of the person who last modified this account master record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this account master record was last modified.',
    `line_item_display_indicator` BOOLEAN COMMENT 'Flag indicating whether individual line item detail is stored and displayable for this account, or only summary balances are maintained.',
    `open_item_management_indicator` BOOLEAN COMMENT 'Flag indicating whether this account uses open item management for tracking and clearing individual transactions (common for receivables, payables, and clearing accounts).',
    `platform_fee_category` STRING COMMENT 'For platform fee expense accounts, indicates the platform or distribution channel (e.g., Steam, Epic Games Store, PlayStation, Xbox, Apple App Store, Google Play) to enable platform-specific profitability analysis.',
    `posting_allowed_indicator` BOOLEAN COMMENT 'Flag indicating whether direct manual or automated postings are allowed to this account, or if it only receives postings through specific processes.',
    `profit_center_required_indicator` BOOLEAN COMMENT 'Flag indicating whether a profit center assignment is mandatory when posting to this account, enabling studio-level and title-level P&L tracking.',
    `reconciliation_account_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a reconciliation account used to summarize subledger balances (e.g., accounts receivable, accounts payable, fixed assets).',
    `revenue_recognition_pattern` STRING COMMENT 'For revenue accounts, indicates whether revenue is recognized at a point in time (e.g., game sales, DLC purchases) or over time (e.g., GaaS subscriptions, season passes), per ASC 606 guidance.. Valid values are `point_in_time|over_time|not_applicable`',
    `royalty_type` STRING COMMENT 'For royalty accrual accounts, indicates the type of royalty (e.g., developer royalty, IP licensing royalty, engine licensing royalty, music licensing royalty) to support royalty reporting and payment processing.',
    `sort_key` STRING COMMENT 'The field used to sort line items within this account for display and reporting purposes (e.g., posting date, document number, assignment field).',
    `subledger_type` STRING COMMENT 'For reconciliation accounts, indicates which subledger module (AR, AP, AA, MM, HR) feeds into this GL account.. Valid values are `customer|vendor|asset|material|employee|not_applicable`',
    `tax_category` STRING COMMENT 'The tax classification code indicating how transactions posted to this account should be treated for tax reporting purposes (e.g., taxable revenue, exempt, input tax, output tax).',
    `valid_from_date` DATE COMMENT 'The date from which this account definition becomes effective and available for use in financial transactions.',
    `valid_to_date` DATE COMMENT 'The date after which this account definition is no longer valid for new postings. Null indicates the account is valid indefinitely.',
    `virtual_economy_indicator` BOOLEAN COMMENT 'Flag indicating whether this account is used to track virtual currency liabilities, virtual goods inventory, or other virtual economy financial elements requiring specialized accounting treatment.',
    CONSTRAINT pk_chart_of_accounts PRIMARY KEY(`chart_of_accounts_id`)
) COMMENT 'Gamings enterprise chart of accounts defining all GL account codes, account descriptions, account types (P&L, balance sheet), account groups, and applicable company codes. Includes gaming-industry-specific accounts for deferred revenue (GaaS subscriptions, season passes), game development cost capitalization, virtual currency liability, platform fee expense, and esports prize pool accruals. Sourced from SAP FI account master.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`finance_tax_record` (
    `finance_tax_record_id` BIGINT COMMENT 'Unique identifier for the tax compliance record. Primary key for the finance_tax_record product.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: finance_tax_record has gl_account_code (STRING) for the tax GL account. Normalize by adding chart_of_accounts_id FK to chart_of_accounts.chart_of_accounts_id and removing gl_account_code string.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: finance_tax_record has cost_center (STRING) for cost allocation. Normalize by adding cost_center_id FK to cost_center.cost_center_id and removing cost_center string.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Tax records are inherently jurisdiction-specific (VAT in EU, sales tax in US states, digital services tax in various countries). Gaming companies must link tax filings to jurisdictions for rate lookup',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: finance_tax_record has company_code (STRING) identifying the legal entity filing the tax. Normalize by adding legal_entity_id FK to legal_entity.legal_entity_id and removing company_code string.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: finance_tax_record has profit_center (STRING) for P&L allocation. Normalize by adding profit_center_id FK to profit_center.profit_center_id and removing profit_center string.',
    `assessed_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount determined by the tax authority in an assessment or audit, which may differ from the originally filed amount. Null if no assessment issued.',
    `assessment_date` DATE COMMENT 'Date the tax authority issued an assessment or audit finding, in yyyy-MM-dd format. Null if no assessment issued.',
    `assessment_reference` STRING COMMENT 'Reference number for any tax assessment or notice issued by the tax authority, including audit findings or adjustments.',
    `business_area` STRING COMMENT 'SAP business area representing the line of business or product segment (e.g., Console Games, Mobile Games, Esports) to which this tax obligation relates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax record was first created in the system, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `document_number` STRING COMMENT 'SAP FI document number for the accounting entry that recorded this tax accrual or payment.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert local currency tax amount to group currency, expressed as group currency per unit of local currency.',
    `filing_date` DATE COMMENT 'Actual date the tax return was filed with the tax authority, in yyyy-MM-dd format. Null if not yet filed.',
    `filing_due_date` DATE COMMENT 'Statutory due date for filing the tax return with the tax authority, in yyyy-MM-dd format.',
    `filing_period_end_date` DATE COMMENT 'End date of the tax filing period covered by this record, in yyyy-MM-dd format.',
    `filing_period_start_date` DATE COMMENT 'Start date of the tax filing period covered by this record, in yyyy-MM-dd format.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month or quarter) within the fiscal year, typically 1-12 for monthly or 1-4 for quarterly reporting.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which the tax obligation is recorded, in YYYY format.',
    `group_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the corporate group reporting currency (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `group_currency_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount converted to the corporate group reporting currency for consolidated financial reporting.',
    `interest_amount` DECIMAL(18,2) COMMENT 'Interest amount charged by the tax authority on late or underpaid taxes. Zero if no interest.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax record was last updated, in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `local_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the local currency in which the tax is calculated and remitted (e.g., USD, GBP, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text notes providing additional context, explanations, or audit trail information for this tax record (e.g., basis for rate applied, special exemptions, audit findings summary).',
    `payment_date` DATE COMMENT 'Actual date the tax payment was remitted to the tax authority, in yyyy-MM-dd format. Null if not yet paid.',
    `payment_due_date` DATE COMMENT 'Statutory due date for remitting the tax payment to the tax authority, in yyyy-MM-dd format.',
    `payment_reference_number` STRING COMMENT 'Reference number or transaction ID for the tax payment, used for reconciliation with tax authority records.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Penalty amount assessed by the tax authority for late filing, late payment, or underpayment. Zero if no penalty.',
    `posting_date` DATE COMMENT 'Date the tax transaction was posted to the general ledger, in yyyy-MM-dd format.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Calculated tax amount due or accrued for this period, in local currency.',
    `tax_authority_name` STRING COMMENT 'Name of the government tax authority or revenue agency responsible for this tax (e.g., IRS, HMRC, Direction Générale des Finances Publiques, Indian Income Tax Department).',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate as a decimal (e.g., 0.2000 for 20% VAT). Varies by jurisdiction and tax type.',
    `tax_registration_number` STRING COMMENT 'Companys tax registration number or VAT identification number with the tax authority in this jurisdiction (e.g., VAT number, TIN, EIN). Business-confidential identifier.',
    `tax_return_reference` STRING COMMENT 'Official reference number or filing ID assigned by the tax authority upon submission of the tax return.',
    `tax_status` STRING COMMENT 'Current lifecycle status of the tax obligation: ACCRUED (recognized but not yet filed), FILED (return submitted), PAID (remitted to authority), ASSESSED (authority issued assessment), UNDER_AUDIT (subject to tax audit), DISPUTED (under appeal), REFUNDED (overpayment returned). [ENUM-REF-CANDIDATE: ACCRUED|FILED|PAID|ASSESSED|UNDER_AUDIT|DISPUTED|REFUNDED — 7 candidates stripped; promote to reference product]',
    `tax_type` STRING COMMENT 'Type of tax obligation: VAT (Value Added Tax), GST (Goods and Services Tax), DST (Digital Services Tax), WHT (Withholding Tax), CIT (Corporate Income Tax), R&D_CREDIT (Research and Development Tax Credit), TRANSFER_PRICING (Transfer Pricing Documentation). [ENUM-REF-CANDIDATE: VAT|GST|DST|WHT|CIT|R&D_CREDIT|TRANSFER_PRICING — 7 candidates stripped; promote to reference product]',
    `taxable_base_amount` DECIMAL(18,2) COMMENT 'The taxable base amount (revenue, income, or transaction value) upon which the tax is calculated, in local currency.',
    `transaction_category` STRING COMMENT 'Category of underlying transactions subject to this tax (e.g., Digital Goods Sales, Royalty Payments, Intercompany Services, In-App Purchases, DLC Sales). Provides business context for the tax obligation.',
    CONSTRAINT pk_finance_tax_record PRIMARY KEY(`finance_tax_record_id`)
) COMMENT 'Tax compliance and obligation records for Gaming covering VAT/GST on digital goods sales by jurisdiction, withholding tax on cross-border royalty payments, digital services tax (DST) obligations in applicable markets (UK, France, Italy, India), corporate income tax provisions, R&D tax credit claims for game development, and transfer pricing documentation for intercompany transactions. Captures tax type, jurisdiction, taxable base, applicable rate, tax amount, filing period, remittance status, and assessment/audit references. Supports multi-jurisdiction tax compliance for a global digital entertainment company.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` (
    `regulatory_disclosure_id` BIGINT COMMENT 'Unique identifier for the regulatory disclosure filing record.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Financial disclosures are filed in specific jurisdictions with distinct requirements (SEC for US, FCA for UK, etc.). Gaming companies operating globally must track which jurisdiction each disclosure s',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: regulatory_disclosure has company_code and legal_entity_name (STRING) identifying the legal entity filing the disclosure. Normalize by adding legal_entity_id FK to legal_entity.legal_entity_id and rem',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Financial regulatory disclosures (10-K, 10-Q, earnings reports) fulfill specific regulatory obligations tracked in compliance. Gaming companies must link SEC filings to underlying GAAP/IFRS requiremen',
    `acceptance_date` DATE COMMENT 'Date when the regulatory authority or stock exchange officially accepted the filing as complete and compliant.',
    `accounting_standard` STRING COMMENT 'Accounting framework used for the financial statements in this disclosure (US GAAP, IFRS, or local GAAP).. Valid values are `US_GAAP|IFRS|local_GAAP`',
    `amendment_number` STRING COMMENT 'Sequential amendment number if this is an amended filing (1 for first amendment, 2 for second, etc.; null if original filing).',
    `audit_opinion` STRING COMMENT 'Type of audit opinion issued by the external auditor on the financial statements (unqualified/clean opinion, qualified opinion, adverse opinion, disclaimer of opinion).. Valid values are `unqualified|qualified|adverse|disclaimer`',
    `audit_report_date` DATE COMMENT 'Date when the external auditor signed and issued their audit report on the financial statements.',
    `cik_number` STRING COMMENT 'SEC Central Index Key number assigned to the filer for EDGAR system identification (10-digit number used by SEC).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory disclosure record was first created in the system.',
    `disclosure_type` STRING COMMENT 'Type of regulatory disclosure filing (10-K annual report, 10-Q quarterly report, 8-K current report, 20-F foreign issuer annual report, annual report, statutory accounts, proxy statement, registration statement, prospectus). [ENUM-REF-CANDIDATE: 10-K|10-Q|8-K|20-F|annual_report|statutory_accounts|proxy_statement|registration_statement|prospectus — 9 candidates stripped; promote to reference product]',
    `document_url` STRING COMMENT 'URL or file path to the full regulatory disclosure document (e.g., EDGAR filing URL, internal document repository path).',
    `ebitda_reported` DECIMAL(18,2) COMMENT 'EBITDA figure disclosed for the reporting period, representing operating performance before non-cash charges and financing costs.',
    `esports_prize_pool_liability` DECIMAL(18,2) COMMENT 'Total accrued liability for esports tournament prize pools that are committed but not yet paid as of the reporting period end date.',
    `exchange_code` STRING COMMENT 'Stock exchange where the company is listed and where the disclosure is filed (NYSE, NASDAQ, LSE, TSE, etc.). [ENUM-REF-CANDIDATE: NYSE|NASDAQ|LSE|TSE|HKEX|SSE|SZSE|ASX|TSX|BSE|NSE|EURONEXT — 12 candidates stripped; promote to reference product]',
    `external_auditor_name` STRING COMMENT 'Name of the external audit firm that audited the financial statements included in this disclosure (e.g., Deloitte, PwC, EY, KPMG).',
    `filing_deadline_date` DATE COMMENT 'Regulatory deadline by which the disclosure must be filed to remain compliant (e.g., 60 days after quarter end for 10-Q, 90 days for 10-K).',
    `filing_number` STRING COMMENT 'Official filing number or reference code assigned by the regulatory authority or stock exchange (e.g., SEC accession number, EDGAR filing number).',
    `filing_status` STRING COMMENT 'Current status of the regulatory disclosure filing in its lifecycle (draft, pending review, submitted, accepted by regulator, rejected, amended, withdrawn). [ENUM-REF-CANDIDATE: draft|pending_review|submitted|accepted|rejected|amended|withdrawn — 7 candidates stripped; promote to reference product]',
    `fiscal_period` STRING COMMENT 'Fiscal period designation (Q1, Q2, Q3, Q4 for quarters; FY for full year; H1, H2 for half-year). [ENUM-REF-CANDIDATE: Q1|Q2|Q3|Q4|FY|H1|H2 — 7 candidates stripped; promote to reference product]',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the disclosure reporting period belongs (e.g., 2023, 2024).',
    `game_development_impairment_amount` DECIMAL(18,2) COMMENT 'Total impairment charges recognized for capitalized game development costs during the reporting period (write-downs of in-development or released game titles).',
    `internal_control_opinion` STRING COMMENT 'Management and auditor assessment of internal controls over financial reporting effectiveness (effective, material weakness identified, significant deficiency, not applicable for smaller reporting companies).. Valid values are `effective|material_weakness|significant_deficiency|not_applicable`',
    `ip_write_down_amount` DECIMAL(18,2) COMMENT 'Total write-down or impairment charges for intellectual property assets (game franchises, licenses, trademarks) during the reporting period.',
    `is_amended` BOOLEAN COMMENT 'Indicates whether this disclosure is an amendment to a previously filed disclosure (True if amended, False if original filing).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory disclosure record was last updated or modified.',
    `material_disclosure_summary` STRING COMMENT 'Summary of material disclosures, events, or items requiring special attention in this filing (e.g., game development impairments, IP write-downs, esports prize pool liabilities, litigation, restructuring charges, goodwill impairment, going concern issues).',
    `net_income_reported` DECIMAL(18,2) COMMENT 'Net income (profit after tax) figure disclosed for the reporting period in the filing currency.',
    `original_filing_number` STRING COMMENT 'Filing number of the original disclosure that this amendment corrects or updates (null if this is an original filing).',
    `prepared_by_user` STRING COMMENT 'Username or identifier of the internal user who prepared the disclosure filing.',
    `publication_date` DATE COMMENT 'Date when the disclosure was made publicly available to investors and the market.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or stock exchange to which the disclosure is submitted (e.g., SEC, FCA, BaFin, NYSE, NASDAQ, LSE, TSE).',
    `reporting_currency` STRING COMMENT 'Currency in which the financial figures in the disclosure are reported (3-letter ISO 4217 currency code). [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|KRW|CAD|AUD|INR|BRL|MXN — 11 candidates stripped; promote to reference product]',
    `reporting_period_end_date` DATE COMMENT 'End date of the financial reporting period covered by this disclosure (e.g., end of fiscal quarter or year).',
    `reporting_period_start_date` DATE COMMENT 'Start date of the financial reporting period covered by this disclosure (e.g., beginning of fiscal quarter or year).',
    `reviewed_by_user` STRING COMMENT 'Username or identifier of the internal user who reviewed and approved the disclosure filing before submission.',
    `sox_certification_status` STRING COMMENT 'Status of Sarbanes-Oxley Act Section 302 and 906 CEO/CFO certifications for this disclosure (certified, not certified, pending).. Valid values are `certified|not_certified|pending`',
    `stockholders_equity_reported` DECIMAL(18,2) COMMENT 'Total stockholders equity (shareholders equity) figure disclosed on the balance sheet as of the reporting period end date.',
    `submission_date` DATE COMMENT 'Date when the disclosure filing was submitted to the regulatory authority or stock exchange.',
    `ticker_symbol` STRING COMMENT 'Stock ticker symbol under which the company trades on the stock exchange (e.g., GAME, GMNG).',
    `total_assets_reported` DECIMAL(18,2) COMMENT 'Total assets figure disclosed on the balance sheet as of the reporting period end date.',
    `total_liabilities_reported` DECIMAL(18,2) COMMENT 'Total liabilities figure disclosed on the balance sheet as of the reporting period end date.',
    `total_revenue_reported` DECIMAL(18,2) COMMENT 'Total revenue figure disclosed for the reporting period in the filing currency.',
    CONSTRAINT pk_regulatory_disclosure PRIMARY KEY(`regulatory_disclosure_id`)
) COMMENT 'Regulatory financial disclosure filings and submissions made by Gaming to financial regulators, stock exchanges, and statutory authorities. Captures disclosure type (10-K, 10-Q, annual report, statutory accounts), filing jurisdiction, reporting period, submission date, filing status, material disclosures (game development impairments, IP write-downs, esports prize pool liabilities), and external auditor sign-off. Supports SOX compliance and investor relations reporting.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`deferred_revenue` (
    `deferred_revenue_id` BIGINT COMMENT 'Unique identifier for the deferred revenue liability record.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for delivering the performance obligation (typically the studio or live ops team).',
    `game_title_id` BIGINT COMMENT 'Reference to the game title associated with this deferred revenue liability.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: deferred_revenue has gl_account_code (STRING) for the liability account. Normalize by adding liability_chart_of_accounts_id FK to chart_of_accounts.chart_of_accounts_id and removing gl_account_code st',
    `player_account_id` BIGINT COMMENT 'Reference to the player who made the purchase, enabling player-level revenue recognition analysis.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: deferred_revenue has profit_center (STRING) for P&L allocation. Normalize by adding profit_center_id FK to profit_center.profit_center_id and removing profit_center string.',
    `storefront_id` BIGINT COMMENT 'Reference to the platform (console, PC, mobile) where the transaction occurred.',
    `title_sku_id` BIGINT COMMENT 'Reference to the specific SKU (season pass, DLC bundle, virtual currency pack, battle pass, subscription tier) that generated this deferred revenue.',
    `iap_transaction_id` BIGINT COMMENT 'Reference to the originating billing transaction that created this deferred revenue liability.',
    `cancellation_date` DATE COMMENT 'The date when the liability was cancelled (e.g., subscription cancelled, season pass refunded).',
    `cancellation_reason` STRING COMMENT 'Business reason for cancellation (player request, service termination, policy violation, technical issue).',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity that holds this deferred revenue liability on its balance sheet.',
    `content_delivery_schedule` STRING COMMENT 'Planned schedule for content delivery milestones that trigger revenue recognition events (e.g., Season 1: March, Season 2: June, Season 3: September, Season 4: December).',
    `contract_liability_number` STRING COMMENT 'Business identifier for the contract liability, used for external reporting and audit trail under ASC 606 / IFRS 15.',
    `created_by_user` STRING COMMENT 'User ID or system identifier that created this deferred revenue liability record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this deferred revenue liability record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the deferred revenue amounts.. Valid values are `^[A-Z]{3}$`',
    `deferred_revenue_status` STRING COMMENT 'Current lifecycle status of the deferred revenue liability (open, partially recognized, fully recognized, refunded, cancelled).. Valid values are `open|partially_recognized|fully_recognized|refunded|cancelled`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when this liability was initially recorded.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this deferred revenue liability was initially recorded.',
    `initial_liability_amount` DECIMAL(18,2) COMMENT 'The original deferred revenue liability amount recorded at the time of cash receipt, representing the total performance obligation value.',
    `is_pre_order` BOOLEAN COMMENT 'Flag indicating whether this deferred revenue originated from a game pre-order (True) or post-launch purchase (False).',
    `is_subscription` BOOLEAN COMMENT 'Flag indicating whether this deferred revenue is part of a recurring subscription model (True) or a one-time purchase (False).',
    `last_modified_by_user` STRING COMMENT 'User ID or system identifier that last modified this deferred revenue liability record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this deferred revenue liability record.',
    `last_recognition_date` DATE COMMENT 'The date of the most recent revenue recognition event for this liability.',
    `liability_type` STRING COMMENT 'Classification of the deferred revenue liability based on the type of performance obligation (season pass, annual subscription, game pre-order, DLC bundle, virtual currency, battle pass).. Valid values are `season_pass|subscription|pre_order|dlc_bundle|virtual_currency|battle_pass`',
    `next_recognition_date` DATE COMMENT 'The scheduled date for the next revenue recognition event, used for forward-looking revenue forecasting.',
    `notes` STRING COMMENT 'Free-text notes for special circumstances, manual adjustments, or audit trail documentation.',
    `performance_obligation_description` STRING COMMENT 'Detailed description of the performance obligation that must be satisfied for revenue recognition (e.g., deliver 4 seasonal content drops, provide 12 months of online service access).',
    `purchase_date` DATE COMMENT 'The date when the player made the purchase that created this deferred revenue liability.',
    `purchase_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the purchase transaction was completed, used for detailed revenue timing analysis.',
    `recognition_end_date` DATE COMMENT 'The date when revenue recognition is expected to complete, representing the end of the performance obligation period.',
    `recognition_frequency` STRING COMMENT 'The frequency at which revenue recognition events occur (daily, weekly, monthly, quarterly, event-based for content drops, usage-based for virtual currency spend).. Valid values are `daily|weekly|monthly|quarterly|event_based|usage_based`',
    `recognition_method` STRING COMMENT 'The method used to recognize revenue over time (straight-line for season passes, usage-based for virtual currency, milestone-based for content drops, time-elapsed for subscriptions, content-delivery for DLC).. Valid values are `straight_line|usage_based|milestone_based|time_elapsed|content_delivery`',
    `recognition_period_months` STRING COMMENT 'The total number of months over which revenue will be recognized, used for straight-line recognition calculations.',
    `recognition_start_date` DATE COMMENT 'The date when revenue recognition begins for this liability, typically the service start date or content availability date.',
    `recognized_revenue_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount of revenue recognized from this liability since inception, representing satisfied performance obligations.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total amount refunded to the player, reducing the deferred revenue liability balance.',
    `refund_date` DATE COMMENT 'The date when a refund was processed, if applicable.',
    `remaining_liability_balance` DECIMAL(18,2) COMMENT 'The current outstanding deferred revenue liability balance that has not yet been recognized as earned revenue.',
    `revenue_gl_account_code` STRING COMMENT 'General ledger account code for the revenue account where recognized amounts are posted.',
    CONSTRAINT pk_deferred_revenue PRIMARY KEY(`deferred_revenue_id`)
) COMMENT 'Deferred revenue liability records tracking amounts received from players but not yet recognized as revenue under ASC 606 / IFRS 15. Covers GaaS season pass sales, annual subscription fees (Game Pass-style), game pre-orders, DLC bundles, virtual currency purchases, and battle pass revenue where performance obligations are satisfied over time. Captures contract liability balance, recognition schedule (straight-line over content delivery period, usage-based for virtual currency), recognition trigger events, associated title/SKU, platform, and period-by-period release to earned revenue. Critical for accurate P&L reporting of live-service games where revenue timing differs significantly from cash receipt.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`period_close` (
    `period_close_id` BIGINT COMMENT 'Unique identifier for the period close record. Primary key. Role: TRANSACTION_HEADER.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: period_close has cost_center_code (STRING) for close task assignment. Normalize by adding cost_center_id FK to cost_center.cost_center_id and removing cost_center_code string.',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game development studio for which this close task is being performed, supporting studio-level P&L close.',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title for which this close task is being performed, supporting title-level profitability close.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: period_close has company_code (STRING) identifying the legal entity for the close process. Normalize by adding legal_entity_id FK to legal_entity.legal_entity_id and removing company_code string.',
    `predecessor_task_period_close_id` BIGINT COMMENT 'Identifier of the predecessor close task that must be completed before this task can begin, supporting workflow dependencies.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or user responsible for completing this close task.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: period_close has profit_center_code (STRING) for close task assignment. Normalize by adding profit_center_id FK to profit_center.profit_center_id and removing profit_center_code string.',
    `quaternary_period_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this period close record.',
    `tertiary_period_created_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who created this period close record.',
    `prior_period_close_id` BIGINT COMMENT 'Self-referencing FK on period_close (prior_period_close_id)',
    `accelerated_close_flag` BOOLEAN COMMENT 'Indicator of whether this close task is part of an accelerated close initiative with compressed timelines (True) or follows standard close calendar (False).',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Actual date and time when the close task was completed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when work on the close task began.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit trail records for this close task, supporting compliance and audit requirements.',
    `automation_enabled_flag` BOOLEAN COMMENT 'Indicator of whether this close task is automated through RPA (Robotic Process Automation) or other automation tools (True) or performed manually (False).',
    `blocking_issue_description` STRING COMMENT 'Detailed description of any blocking issue or impediment preventing the completion of the close task.',
    `blocking_issue_flag` BOOLEAN COMMENT 'Indicator of whether there is a blocking issue preventing the completion of this close task (True) or not (False).',
    `close_status` STRING COMMENT 'Current lifecycle status of the period close process: not started, in progress, pending review, approved, completed, or reopened for adjustments.. Valid values are `not_started|in_progress|pending_review|approved|completed|reopened`',
    `close_task_name` STRING COMMENT 'Name of the specific close task or step being tracked (e.g., Subledger Reconciliation, Intercompany Elimination, FX Revaluation, Accrual Postings, Management Review).',
    `close_type` STRING COMMENT 'Type of financial close being executed: month-end, quarter-end, year-end, or special close.. Valid values are `month_end|quarter_end|year_end|special`',
    `comments` STRING COMMENT 'Free-text comments or notes related to the close task execution, issues encountered, or special circumstances.',
    `control_evidence_document_url` STRING COMMENT 'URL or file path to the control evidence documentation supporting the completion of this close task for audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this period close record was first created in the system.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year for which the close is being performed (1-12 for monthly close, or 13-16 for special periods).',
    `fiscal_year` STRING COMMENT 'The fiscal year for which the period close is being performed (e.g., 2024).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this period close record was last modified or updated.',
    `planned_completion_date` DATE COMMENT 'Scheduled date when the close task is planned to be completed according to the close calendar.',
    `planned_start_date` DATE COMMENT 'Scheduled date when the close task is planned to begin according to the close calendar.',
    `resolution_notes` STRING COMMENT 'Notes documenting how blocking issues were resolved or any special actions taken during task completion.',
    `responsible_owner_name` STRING COMMENT 'Full name of the employee or user responsible for completing this close task.',
    `sign_off_timestamp` TIMESTAMP COMMENT 'Date and time when the close task was formally signed off and approved by the responsible owner or reviewer.',
    `sign_off_user_name` STRING COMMENT 'Full name of the user who signed off on the completion of the close task.',
    `sox_control_reference` STRING COMMENT 'Reference number or identifier of the SOX control that this close task supports or evidences.',
    `task_category` STRING COMMENT 'Functional category of the close task: reconciliation, posting, elimination, revaluation, review, approval, or reporting. [ENUM-REF-CANDIDATE: reconciliation|posting|elimination|revaluation|review|approval|reporting — 7 candidates stripped; promote to reference product]',
    `task_sequence_number` STRING COMMENT 'Sequential order of the close task within the overall close process, used to enforce task dependencies and workflow.',
    `task_status` STRING COMMENT 'Current status of the individual close task: not started, in progress, completed, blocked, or deferred.. Valid values are `not_started|in_progress|completed|blocked|deferred`',
    `variance_explanation` STRING COMMENT 'Explanation of any significant variances or deviations from expected results identified during the close task.',
    CONSTRAINT pk_period_close PRIMARY KEY(`period_close_id`)
) COMMENT 'Period-end and year-end close management records tracking the status of each closing step (subledger reconciliation, intercompany elimination, FX revaluation, accrual postings, management review) for each fiscal period and company code. Captures close task, responsible owner, completion status, sign-off timestamp, and blocking issues. Supports close calendar management, accelerated close initiatives, and SOX control evidence for Gamings multi-entity financial close process.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record. Primary key. Role: MASTER_RESOURCE.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: fixed_asset has gl_account_code (STRING) for the asset account. Normalize by adding asset_chart_of_accounts_id FK to chart_of_accounts.chart_of_accounts_id and removing gl_account_code string. Labeled',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: fixed_asset has cost_center_code (STRING) identifying the cost center responsible for the asset. Normalize by adding cost_center_id FK to cost_center.cost_center_id and removing cost_center_code strin',
    `game_studio_id` BIGINT COMMENT 'Identifier of the game development studio that owns or uses this fixed asset. Links asset to studio for P&L and resource allocation reporting.',
    `game_title_id` BIGINT COMMENT 'Identifier of the specific game title project this asset is dedicated to or primarily used for. Enables title-level asset tracking and profitability analysis.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: fixed_asset has company_code (STRING) identifying the legal entity that owns the asset. Normalize by adding legal_entity_id FK to legal_entity.legal_entity_id and removing company_code string.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Fixed assets (game development hardware, studio facilities) may be allocated to profit centers for segment-level asset tracking and depreciation allocation. This FK enables tracking of tangible asset ',
    `parent_fixed_asset_id` BIGINT COMMENT 'Self-referencing FK on fixed_asset (parent_fixed_asset_id)',
    `accounting_standard` STRING COMMENT 'Accounting standard framework applied to this asset for depreciation and reporting (GAAP ASC 360, IFRS IAS 16, or local GAAP).. Valid values are `GAAP|IFRS|local_GAAP`',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since the asset was placed in service. Contra-asset account that reduces the gross carrying amount.',
    `accumulated_depreciation_gl_account_code` STRING COMMENT 'General ledger contra-asset account code where accumulated depreciation is recorded.',
    `accumulated_impairment` DECIMAL(18,2) COMMENT 'Total impairment losses recognized to date when the assets recoverable amount falls below its carrying value. Reduces net book value.',
    `acquisition_date` DATE COMMENT 'Date when the fixed asset was acquired or purchased by the company. Used as the starting point for depreciation calculations.',
    `asset_class` STRING COMMENT 'Primary classification category of the fixed asset for accounting and reporting purposes. Segments the PP&E (Property, Plant, and Equipment) portfolio by business function.. Valid values are `game_development_hardware|server_infrastructure|studio_office_fitout|esports_broadcast_equipment|motion_capture_equipment|performance_capture_rig`',
    `asset_description` STRING COMMENT 'Detailed description of the fixed asset including specifications, model, manufacturer, and distinguishing characteristics.',
    `asset_name` STRING COMMENT 'Human-readable name or title of the fixed asset (e.g., Motion Capture Studio A, Dev Kit PS5 Batch 12, Esports Broadcast Rig).',
    `asset_number` STRING COMMENT 'Externally-known unique asset tag or registration number assigned to the fixed asset for tracking and identification purposes. Used for physical labeling and inventory management.. Valid values are `^[A-Z0-9]{6,20}$`',
    `asset_subclass` STRING COMMENT 'Secondary classification or subcategory within the asset class for granular tracking (e.g., Console Dev Kit, PC Workstation, Rack Server, Camera System).',
    `capitalization_date` DATE COMMENT 'Date when the asset was placed in service and capitalization began. May differ from acquisition date for assets under construction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixed asset record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the original cost and all monetary amounts associated with this asset.. Valid values are `^[A-Z]{3}$`',
    `depreciation_gl_account_code` STRING COMMENT 'General ledger account code to which periodic depreciation expense is posted.',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate periodic depreciation expense for this asset. Determines how the asset cost is allocated over its useful life.. Valid values are `straight_line|declining_balance|double_declining_balance|units_of_production|sum_of_years_digits`',
    `disposal_date` DATE COMMENT 'Date when the asset was disposed of, sold, scrapped, or retired from service. Marks the end of the assets lifecycle.',
    `disposal_gain_loss` DECIMAL(18,2) COMMENT 'Calculated gain or loss on disposal, computed as disposal proceeds minus net book value at disposal date. Positive values indicate gain, negative indicate loss.',
    `disposal_method` STRING COMMENT 'Method by which the asset was disposed of. Determines accounting treatment for disposal gain or loss.. Valid values are `sale|scrap|donation|trade_in|retirement|transfer`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Amount received from the sale or disposal of the asset. Used to calculate gain or loss on disposal.',
    `impairment_indicator_flag` BOOLEAN COMMENT 'Boolean flag indicating whether there are indicators that the asset may be impaired and requires formal impairment testing.',
    `last_impairment_test_date` DATE COMMENT 'Date when the most recent impairment test was performed to assess whether the assets carrying value exceeds its recoverable amount.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fixed asset record was last updated or modified. Audit trail for record changes.',
    `lifecycle_status` STRING COMMENT 'Current operational state of the fixed asset in its lifecycle. Determines whether depreciation is active and whether the asset is available for use.. Valid values are `in_service|under_construction|idle|retired|disposed|impaired`',
    `location_code` STRING COMMENT 'Code identifying the physical location or site where the asset is deployed (e.g., studio location, data center, office building).',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the asset calculated as original cost minus accumulated depreciation and accumulated impairment. Represents the asset value on the balance sheet.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the asset.',
    `original_cost` DECIMAL(18,2) COMMENT 'Initial acquisition cost or cost basis of the fixed asset including purchase price, delivery, installation, and any costs necessary to bring the asset to working condition.',
    `residual_value` DECIMAL(18,2) COMMENT 'Estimated salvage or residual value of the asset at the end of its useful life. The amount expected to be recovered upon disposal.',
    `responsible_person_name` STRING COMMENT 'Name of the individual responsible for the custody, maintenance, or management of this asset.',
    `serial_number` STRING COMMENT 'Manufacturers serial number or unique device identifier for the asset. Used for warranty tracking and support.',
    `tax_basis` DECIMAL(18,2) COMMENT 'Tax basis or book value of the asset for tax depreciation purposes. May differ from financial accounting basis due to different depreciation methods.',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Estimated useful life of the asset in years over which depreciation will be calculated. Reflects the expected period the asset will provide economic benefit.',
    `vendor_name` STRING COMMENT 'Name of the vendor or supplier from whom the asset was purchased.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer or vendor warranty coverage expires for this asset.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Tangible fixed asset register for Gamings property, plant, and equipment including game development hardware (dev kits, motion capture studios, performance capture rigs), server infrastructure (on-premise data center equipment), studio office fit-outs, and esports broadcast equipment. Captures asset class, acquisition date, cost basis, depreciation method (straight-line, declining balance), useful life, accumulated depreciation, net book value, location/cost center assignment, and disposal records. Supports GAAP ASC 360 / IFRS IAS 16 compliance and provides the PP&E balance for consolidated financial statements.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`compliance_allocation` (
    `compliance_allocation_id` BIGINT COMMENT 'Unique identifier for this compliance allocation record. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Compliance allocations may reference GL accounts for tracking compliance-related costs (e.g., regulatory fees, audit costs). This FK enables financial reporting of compliance costs by GL account categ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to the cost center responsible for compliance with this obligation',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Compliance allocations occur within legal entity boundaries as regulatory obligations are entity-specific. This FK ensures compliance costs are properly attributed to the legal entities that bear the ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the regulatory obligation that applies to this cost center',
    `allocation_effective_date` DATE COMMENT 'Date when this compliance obligation was assigned to this cost center. Supports historical tracking of compliance responsibility changes.',
    `allocation_end_date` DATE COMMENT 'Date when this compliance obligation assignment to this cost center ends or ended. NULL for ongoing allocations. Supports organizational restructuring and compliance responsibility transfers.',
    `compliance_budget_amount` DECIMAL(18,2) COMMENT 'Budget amount allocated by this cost center specifically for compliance activities related to this regulatory obligation. Represents the financial resources dedicated to meeting this specific obligation.',
    `compliance_status` STRING COMMENT 'Current compliance status of this cost center with respect to this specific regulatory obligation. Tracks whether the cost center has met the requirements of this obligation.',
    `last_assessment_date` DATE COMMENT 'Date when this cost center was last assessed for compliance with this specific regulatory obligation. Supports audit trail and assessment frequency tracking.',
    `next_assessment_date` DATE COMMENT 'Scheduled date for the next compliance assessment of this cost center against this regulatory obligation. Supports proactive compliance management and audit planning.',
    `responsible_officer` STRING COMMENT 'Name or identifier of the individual within this cost center who is responsible for ensuring compliance with this specific regulatory obligation. May differ from the cost center manager.',
    `risk_mitigation_plan` STRING COMMENT 'Description of the specific risk mitigation plan or compliance approach this cost center has implemented for this regulatory obligation. Captures cost center-specific compliance strategies.',
    CONSTRAINT pk_compliance_allocation PRIMARY KEY(`compliance_allocation_id`)
) COMMENT 'This association product represents the assignment of regulatory compliance obligations to cost centers within Gaming. It captures the compliance responsibility allocation, budget allocation for compliance activities, and assessment tracking. Each record links one cost center to one regulatory obligation with attributes that exist only in the context of this compliance responsibility assignment.. Existence Justification: In Gaming operations, regulatory compliance obligations (GDPR, COPPA, age ratings, loot box disclosures, platform-specific requirements) apply across multiple organizational cost centers, and each cost center must comply with multiple regulatory obligations simultaneously. The compliance team actively manages these allocations by assigning obligations to cost centers, budgeting compliance activities per cost center-obligation pair, tracking compliance status for each assignment, and scheduling assessments. This is an operational compliance management process where the allocation itself is a managed business entity.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`budget_approval` (
    `budget_approval_id` BIGINT COMMENT 'Unique identifier for this budget approval authority record. Primary key.',
    `assigned_by_employee_id` BIGINT COMMENT 'Employee ID of the finance leader or executive who assigned this approval authority. Required for SOX compliance audit trail.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget approval authority is often delegated by cost center, allowing cost center managers to approve budgets within their scope. This FK enables cost-center-scoped approval workflows and delegation r',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who has approval authority over the budget',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to the budget record over which approval authority is granted',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Budget approval authority is delegated within legal entities for proper governance and segregation of duties. This FK ensures approval workflows respect legal entity boundaries and supports multi-enti',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budget approval authority is often delegated by profit center, allowing segment leaders to approve budgets within their business unit. This FK enables profit-center-scoped approval workflows and deleg',
    `revoked_by_employee_id` BIGINT COMMENT 'Employee ID of the finance leader who revoked this approval authority. Required for SOX compliance audit trail.',
    `approval_level` STRING COMMENT 'The hierarchical level of approval authority (L1=first-line, L2=manager, L3=director, L4=executive). Determines approval workflow sequence. Explicitly identified in detection reasoning.',
    `approval_role` STRING COMMENT 'The role this employee plays in the budget approval process. Determines approval sequence and authority level. Explicitly identified in detection reasoning.',
    `assigned_date` DATE COMMENT 'The date when this approval authority was originally assigned to the employee. Supports audit trail and compliance reporting.',
    `authority_currency` STRING COMMENT 'The currency code for the spending authority limit. Supports multi-currency budget approval in global gaming operations.',
    `delegation_end_date` DATE COMMENT 'The date until which this employees approval authority remains effective. Null for permanent authority assignments. Supports temporary delegation tracking. Explicitly identified in detection reasoning.',
    `delegation_start_date` DATE COMMENT 'The date from which this employees approval authority becomes effective. Supports temporary delegation during vacations or organizational changes. Explicitly identified in detection reasoning.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this approval authority is currently active. Supports temporary suspension without deletion for audit trail.',
    `notes` STRING COMMENT 'Free-text notes explaining special conditions, delegation reasons, or compliance exceptions for this approval authority assignment.',
    `revoked_date` DATE COMMENT 'The date when this approval authority was revoked. Null for active authorities. Supports compliance audit trail.',
    `spending_authority_limit` DECIMAL(18,2) COMMENT 'The maximum budget amount this employee can approve in their assigned role. Required for SOX compliance and financial controls. Explicitly identified in detection reasoning.',
    CONSTRAINT pk_budget_approval PRIMARY KEY(`budget_approval_id`)
) COMMENT 'This association product represents the approval authority relationship between employees and budgets in the gaming enterprise. It captures which employees have approval rights over which budgets, including their approval role (budget owner, finance approver, executive sponsor), approval level, delegation periods for temporary authority transfers, and spending limits for SOX compliance and financial controls. Each record links one employee to one budget with attributes that exist only in the context of this approval relationship.. Existence Justification: In gaming enterprises, budget approval is a multi-stakeholder governance process where multiple employees have approval authority over each budget (budget owner, finance approver, executive sponsor, studio head), and senior employees have approval authority over multiple budgets across cost centers and projects. The detection reasoning explicitly identifies this as an operational approval workflow with relationship-specific data (approval_role, approval_level, delegation periods, spending_authority_limit) required for SOX compliance and financial controls. This is not an analytical correlation but an actively managed business process.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`entity_registration` (
    `entity_registration_id` BIGINT COMMENT 'Unique identifier for this legal entity jurisdictional registration record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to the jurisdiction in which the legal entity is registered',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to the legal entity that holds this jurisdictional registration',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this registration is currently active and the entity is authorized to operate in this jurisdiction.',
    `compliance_officer_contact` STRING COMMENT 'Internal compliance officer or contact responsible for managing this entitys compliance obligations in this jurisdiction.',
    `effective_date` DATE COMMENT 'Date from which this registration record became effective for operational and compliance purposes.',
    `expiration_date` DATE COMMENT 'Date on which this registration record expires or is no longer applicable. Null indicates ongoing registration.',
    `license_expiry_date` DATE COMMENT 'The date on which the license or registration expires and must be renewed. Explicitly identified in detection reasoning as relationship data.',
    `license_number` STRING COMMENT 'The license, registration, or authorization number issued by this jurisdictions regulatory authority to this legal entity. Explicitly identified in detection reasoning as relationship data.',
    `license_status` STRING COMMENT 'Current regulatory status of the entitys license or registration in this jurisdiction. Explicitly identified in detection reasoning as relationship data.',
    `local_entity_name` STRING COMMENT 'The legal entity name as registered in this specific jurisdiction, which may differ from the global legal name due to local language requirements or regulatory naming conventions.',
    `notes` STRING COMMENT 'Free-text field for additional notes about this specific entity-jurisdiction registration, including special conditions, restrictions, or compliance considerations.',
    `registration_date` DATE COMMENT 'The date on which the legal entity was officially registered or licensed in this specific jurisdiction. Explicitly identified in detection reasoning as relationship data.',
    `registration_type` STRING COMMENT 'Type of registration or authorization in this jurisdiction (e.g., full incorporation, branch office, foreign entity registration, gaming license, publishing license, data processing registration).',
    `regulatory_authority_contact` STRING COMMENT 'Contact information (email or reference) for the specific regulatory authority or contact person managing this entitys registration in this jurisdiction. Explicitly identified in detection reasoning as relationship data.',
    `tax_registration_number` STRING COMMENT 'Tax identification or registration number specific to this entity in this jurisdiction (may differ from the entitys primary tax ID if registered in multiple jurisdictions).',
    CONSTRAINT pk_entity_registration PRIMARY KEY(`entity_registration_id`)
) COMMENT 'This association product represents the jurisdictional registration relationship between legal entities and the jurisdictions in which they are registered, licensed, or authorized to operate. Gaming operates legal entities across multiple jurisdictions (a UK studio may be registered in UK, have EU regulatory licenses, and US state registrations), and each jurisdiction hosts multiple legal entities. Each record captures jurisdiction-specific registration details, license numbers, regulatory status, and compliance contacts that exist only in the context of a specific entity operating in a specific jurisdiction.. Existence Justification: Gaming legal entities operate across multiple jurisdictions simultaneously (e.g., a UK studio entity is incorporated in UK, holds EU publishing licenses, and has US state registrations for digital distribution). Each jurisdiction hosts multiple legal entities from the Gaming corporate group. The business actively manages jurisdictional registrations as operational compliance records, tracking license numbers, expiry dates, regulatory status, and jurisdiction-specific contacts for each entity-jurisdiction combination.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`allocation_cycle` (
    `allocation_cycle_id` BIGINT COMMENT 'Primary key for allocation_cycle',
    `business_unit_id` BIGINT COMMENT 'The business unit or division responsible for this allocation cycle.',
    `chart_of_accounts_id` BIGINT COMMENT 'The general ledger account to which allocation entries are posted.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Allocation cycles operate within legal entity boundaries to prevent improper intercompany allocations. This FK ensures allocation rules are scoped to the correct legal entity for compliance and audit ',
    `cost_center_id` BIGINT COMMENT 'The cost center from which costs are being allocated in this cycle.',
    `storefront_id` BIGINT COMMENT 'The gaming platform (console, PC, mobile) associated with this allocation cycle, if applicable.',
    `game_studio_id` BIGINT COMMENT 'The game development studio associated with this allocation cycle, if applicable to studio-level cost allocations.',
    `game_title_id` BIGINT COMMENT 'The game title associated with this allocation cycle, if applicable to title-level profitability allocations.',
    `previous_allocation_cycle_id` BIGINT COMMENT 'Self-referencing FK on allocation_cycle (previous_allocation_cycle_id)',
    `allocation_basis` STRING COMMENT 'The driver or basis used to calculate allocation proportions (e.g., headcount, revenue, square footage, usage hours).',
    `allocation_method` STRING COMMENT 'The calculation methodology used to distribute costs or revenues across target entities within this cycle.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Fixed percentage used for allocation when the method is percentage-based. Value between 0.00 and 100.00.',
    `allocation_rule_set` STRING COMMENT 'The named set of business rules and logic governing how allocations are calculated and distributed in this cycle.',
    `approval_date` DATE COMMENT 'The date on which this allocation cycle was formally approved.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this allocation cycle requires formal approval before execution.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this allocation cycle for execution.',
    `controlling_area` STRING COMMENT 'The controlling area (CO area) under which this allocation cycle is managed.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation cycle record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for amounts in this allocation cycle.',
    `cycle_code` STRING COMMENT 'Business identifier code for the allocation cycle, used for external reference and reporting.',
    `cycle_name` STRING COMMENT 'Human-readable name describing the allocation cycle purpose and scope.',
    `cycle_type` STRING COMMENT 'Classification of the allocation cycle based on the allocation methodology and target entities.',
    `effective_end_date` DATE COMMENT 'The date on which this allocation cycle ceases to be active. Null indicates an open-ended cycle.',
    `effective_start_date` DATE COMMENT 'The date from which this allocation cycle becomes active and applicable for financial allocations.',
    `execution_count` STRING COMMENT 'The total number of times this allocation cycle has been executed since creation.',
    `execution_date` DATE COMMENT 'The date on which this allocation cycle was executed and posted to the general ledger.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter number) within the fiscal year for this allocation cycle.',
    `fiscal_year` STRING COMMENT 'The fiscal year for which this allocation cycle is applicable.',
    `frequency` STRING COMMENT 'The recurring schedule on which this allocation cycle is executed.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this allocation cycle is a recurring cycle that executes automatically on a schedule.',
    `last_execution_date` DATE COMMENT 'The date of the most recent execution of this allocation cycle.',
    `modified_by` STRING COMMENT 'User or system identifier of the person or process that last modified this allocation cycle record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this allocation cycle record was last modified.',
    `next_execution_date` DATE COMMENT 'The scheduled date for the next execution of this recurring allocation cycle. Null for non-recurring cycles.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, special instructions, or documentation for this allocation cycle.',
    `reversal_date` DATE COMMENT 'The date on which this allocation cycle was reversed. Null if not reversed.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this allocation cycle has been reversed or cancelled after execution.',
    `reversal_reason` STRING COMMENT 'Business justification for reversing this allocation cycle.',
    `allocation_cycle_status` STRING COMMENT 'Current lifecycle status of the allocation cycle indicating its operational state.',
    `total_amount_allocated` DECIMAL(18,2) COMMENT 'The total monetary amount distributed through this allocation cycle in the base currency.',
    `version_number` STRING COMMENT 'Version number of this allocation cycle configuration, incremented with each modification to support change tracking.',
    `created_by` STRING COMMENT 'User or system identifier of the person or process that created this allocation cycle record.',
    CONSTRAINT pk_allocation_cycle PRIMARY KEY(`allocation_cycle_id`)
) COMMENT 'Master reference table for allocation_cycle. Referenced by allocation_cycle_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`finance`.`business_unit` (
    `business_unit_id` BIGINT COMMENT 'Primary key for business_unit',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total approved annual operating budget for the business unit in its functional currency, used for variance analysis and performance tracking.',
    `business_area_code` STRING COMMENT 'SAP business area code for cross-company code reporting and segment analysis in multi-entity gaming enterprises.',
    `business_unit_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the business unit for external reporting and system integration (e.g., STU01, PUB02, ESPT03).',
    `business_unit_type` STRING COMMENT 'Classification of the business unit by its primary function within the gaming enterprise (studio for game development, publishing for distribution, platform for online services, esports for competitive gaming, technology for engine/tools, corporate for headquarters, shared services for support functions).',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity to which this business unit belongs for financial reporting and statutory compliance.',
    `consolidation_unit_code` STRING COMMENT 'Code identifying the financial consolidation unit or reporting segment to which this business unit rolls up for statutory and management reporting.',
    `controlling_area_code` STRING COMMENT 'SAP controlling area code representing the organizational unit for cost accounting and internal management reporting.',
    `cost_center_code` STRING COMMENT 'SAP cost center code associated with this business unit for expense tracking and allocation in the FI/CO module.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country of operation or legal domicile of the business unit (e.g., USA, GBR, JPN).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the business unit record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the functional currency of the business unit used in financial reporting (e.g., USD, EUR, JPY).',
    `business_unit_description` STRING COMMENT 'Detailed description of the business units purpose, scope of operations, and strategic role within the gaming enterprise.',
    `effective_end_date` DATE COMMENT 'Date when the business unit ceased operations or was dissolved. Null for currently active units.',
    `effective_start_date` DATE COMMENT 'Date when the business unit became operational and began recording financial transactions.',
    `establishment_date` DATE COMMENT 'Date when the business unit was formally established or incorporated, used for historical tracking and anniversary reporting.',
    `external_reporting_segment` STRING COMMENT 'Segment classification for external financial reporting and investor disclosures per IFRS 8 or ASC 280 operating segment requirements.',
    `finance_contact_employee_id` BIGINT COMMENT 'Reference to the finance business partner or controller responsible for financial reporting and analysis for this business unit.',
    `functional_area` STRING COMMENT 'Primary functional area or department classification for the business unit within the gaming enterprise organizational structure.',
    `geographic_region` STRING COMMENT 'Primary geographic region of operation for the business unit, used for regional financial reporting and market analysis.',
    `headcount_planned` STRING COMMENT 'Approved full-time equivalent (FTE) headcount allocation for the business unit, used for workforce planning and cost modeling.',
    `intercompany_billing_enabled` BOOLEAN COMMENT 'Flag indicating whether the business unit participates in intercompany billing and transfer pricing arrangements with other business units.',
    `internal_order_number` STRING COMMENT 'SAP internal order number used for project-based cost collection and allocation within the business unit.',
    `is_cost_center_only` BOOLEAN COMMENT 'Flag indicating whether the business unit operates purely as a cost center without profit/loss accountability (true for support functions, false for P&L-responsible units).',
    `is_revenue_generating` BOOLEAN COMMENT 'Flag indicating whether the business unit directly generates external revenue (true for studios, publishing, platforms; false for corporate, shared services).',
    `last_modified_by_user_id` STRING COMMENT 'User identifier of the person who last modified the business unit record, supporting audit and governance requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the business unit record was last updated, used for audit trail and change tracking.',
    `legal_entity_name` STRING COMMENT 'Full legal name of the entity under which the business unit operates, used for statutory reporting and compliance.',
    `manager_employee_id` BIGINT COMMENT 'Reference to the employee who serves as the general manager or head of this business unit, accountable for its financial performance.',
    `business_unit_name` STRING COMMENT 'Full legal or operational name of the business unit (e.g., North America Studios, European Publishing Division, Asia-Pacific Esports).',
    `parent_business_unit_id` BIGINT COMMENT 'Reference to the parent business unit in the organizational hierarchy, enabling multi-level business unit structures (e.g., regional studio reporting to global studio division). Null for top-level units.',
    `profit_center_code` STRING COMMENT 'SAP profit center code for this business unit, used for internal P&L reporting and profitability analysis in the CO-PA module.',
    `royalty_accrual_required` BOOLEAN COMMENT 'Flag indicating whether the business unit must accrue royalty expenses for third-party IP, talent, or platform fees in its financial reporting.',
    `short_name` STRING COMMENT 'Abbreviated name or acronym for the business unit used in reports and dashboards (e.g., NA Studios, EU Pub, APAC Esports).',
    `business_unit_status` STRING COMMENT 'Current operational status of the business unit in its lifecycle (active for operating units, inactive for temporarily suspended, pending for units under formation, dissolved for closed units, merged for units consolidated into others).',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the primary tax jurisdiction for the business unit, used for tax allocation and compliance reporting.',
    `wbs_element` STRING COMMENT 'SAP Project System WBS element code for project-based business units or title-specific development organizations.',
    CONSTRAINT pk_business_unit PRIMARY KEY(`business_unit_id`)
) COMMENT 'Master reference table for business_unit. Referenced by business_unit_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `gaming_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ADD CONSTRAINT `fk_finance_budget_version_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ADD CONSTRAINT `fk_finance_title_pl_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ADD CONSTRAINT `fk_finance_title_pl_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ADD CONSTRAINT `fk_finance_title_pl_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ADD CONSTRAINT `fk_finance_studio_pl_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ADD CONSTRAINT `fk_finance_studio_pl_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ADD CONSTRAINT `fk_finance_studio_pl_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ADD CONSTRAINT `fk_finance_royalty_accrual_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ADD CONSTRAINT `fk_finance_royalty_accrual_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ADD CONSTRAINT `fk_finance_royalty_accrual_royalty_statement_id` FOREIGN KEY (`royalty_statement_id`) REFERENCES `gaming_ecm`.`finance`.`royalty_statement`(`royalty_statement_id`);
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ADD CONSTRAINT `fk_finance_royalty_statement_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ADD CONSTRAINT `fk_finance_royalty_statement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ADD CONSTRAINT `fk_finance_royalty_statement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ADD CONSTRAINT `fk_finance_royalty_statement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `gaming_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_intangible_asset_id` FOREIGN KEY (`intangible_asset_id`) REFERENCES `gaming_ecm`.`finance`.`intangible_asset`(`intangible_asset_id`);
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ADD CONSTRAINT `fk_finance_capex_project_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ADD CONSTRAINT `fk_finance_intangible_asset_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ADD CONSTRAINT `fk_finance_intangible_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ADD CONSTRAINT `fk_finance_intangible_asset_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ADD CONSTRAINT `fk_finance_intangible_asset_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_allocation_cycle_id` FOREIGN KEY (`allocation_cycle_id`) REFERENCES `gaming_ecm`.`finance`.`allocation_cycle`(`allocation_cycle_id`);
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_original_allocation_cost_allocation_id` FOREIGN KEY (`original_allocation_cost_allocation_id`) REFERENCES `gaming_ecm`.`finance`.`cost_allocation`(`cost_allocation_id`);
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_receiving_entity_legal_entity_id` FOREIGN KEY (`receiving_entity_legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_entity_legal_entity_id` FOREIGN KEY (`parent_entity_legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_primary_ultimate_parent_entity_legal_entity_id` FOREIGN KEY (`primary_ultimate_parent_entity_legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ADD CONSTRAINT `fk_finance_finance_tax_record_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ADD CONSTRAINT `fk_finance_finance_tax_record_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ADD CONSTRAINT `fk_finance_finance_tax_record_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ADD CONSTRAINT `fk_finance_finance_tax_record_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ADD CONSTRAINT `fk_finance_regulatory_disclosure_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ADD CONSTRAINT `fk_finance_deferred_revenue_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_predecessor_task_period_close_id` FOREIGN KEY (`predecessor_task_period_close_id`) REFERENCES `gaming_ecm`.`finance`.`period_close`(`period_close_id`);
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ADD CONSTRAINT `fk_finance_period_close_prior_period_close_id` FOREIGN KEY (`prior_period_close_id`) REFERENCES `gaming_ecm`.`finance`.`period_close`(`period_close_id`);
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_parent_fixed_asset_id` FOREIGN KEY (`parent_fixed_asset_id`) REFERENCES `gaming_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ADD CONSTRAINT `fk_finance_compliance_allocation_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ADD CONSTRAINT `fk_finance_compliance_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ADD CONSTRAINT `fk_finance_compliance_allocation_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ADD CONSTRAINT `fk_finance_budget_approval_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ADD CONSTRAINT `fk_finance_budget_approval_finance_budget_id` FOREIGN KEY (`finance_budget_id`) REFERENCES `gaming_ecm`.`finance`.`finance_budget`(`finance_budget_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ADD CONSTRAINT `fk_finance_budget_approval_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ADD CONSTRAINT `fk_finance_budget_approval_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `gaming_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ADD CONSTRAINT `fk_finance_entity_registration_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_business_unit_id` FOREIGN KEY (`business_unit_id`) REFERENCES `gaming_ecm`.`finance`.`business_unit`(`business_unit_id`);
ALTER TABLE `gaming_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_chart_of_accounts_id` FOREIGN KEY (`chart_of_accounts_id`) REFERENCES `gaming_ecm`.`finance`.`chart_of_accounts`(`chart_of_accounts_id`);
ALTER TABLE `gaming_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `gaming_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `gaming_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `gaming_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `gaming_ecm`.`finance`.`allocation_cycle` ADD CONSTRAINT `fk_finance_allocation_cycle_previous_allocation_cycle_id` FOREIGN KEY (`previous_allocation_cycle_id`) REFERENCES `gaming_ecm`.`finance`.`allocation_cycle`(`allocation_cycle_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `gaming_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Entry ID');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `document_currency` SET TAGS ('dbx_business_glossary_term' = 'Document Currency');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `document_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entry Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `functional_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{16}$');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `group_currency` SET TAGS ('dbx_business_glossary_term' = 'Group Currency');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `group_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `group_currency_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Credit Amount');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `group_currency_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Debit Amount');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `ledger_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `local_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `local_currency_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Credit Amount');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `local_currency_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Debit Amount');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `reference_key` SET TAGS ('dbx_business_glossary_term' = 'Reference Key');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `text_description` SET TAGS ('dbx_business_glossary_term' = 'Text Description');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `user_name` SET TAGS ('dbx_business_glossary_term' = 'User Name');
ALTER TABLE `gaming_ecm`.`finance`.`general_ledger` ALTER COLUMN `user_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posting User ID');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `tertiary_journal_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `tertiary_journal_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `assignment_reference` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reference');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Changed Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_header_text` SET TAGS ('dbx_business_glossary_term' = 'Document Header Text');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'draft|posted|parked|cleared|reversed|cancelled');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_time` SET TAGS ('dbx_business_glossary_term' = 'Entry Time');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `trading_partner` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Code');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `withholding_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Code');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `gaming_ecm`.`finance`.`journal_entry` ALTER COLUMN `workflow_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected|no_approval_required');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|headcount|revenue_share|usage_based|fixed_percentage|activity_based');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|planned');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'production|service|administrative|auxiliary');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Group');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Currency');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `headcount_allocation_key` SET TAGS ('dbx_business_glossary_term' = 'Headcount Allocation Key');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `is_allocable` SET TAGS ('dbx_business_glossary_term' = 'Is Allocable Flag');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `is_overhead` SET TAGS ('dbx_business_glossary_term' = 'Is Overhead Flag');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `is_shared_service` SET TAGS ('dbx_business_glossary_term' = 'Is Shared Service Flag');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Notes');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `revenue_allocation_key` SET TAGS ('dbx_business_glossary_term' = 'Revenue Allocation Key');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `gaming_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center ID');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `budget_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Fiscal Year');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO) Code');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `esrb_rating` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Software Rating Board (ESRB) Rating');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `game_genre` SET TAGS ('dbx_business_glossary_term' = 'Game Genre');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `is_first_party` SET TAGS ('dbx_business_glossary_term' = 'Is First Party');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `is_live_service` SET TAGS ('dbx_business_glossary_term' = 'Is Live Service');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `monetization_model` SET TAGS ('dbx_business_glossary_term' = 'Monetization Model');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `platform_category` SET TAGS ('dbx_business_glossary_term' = 'Platform Category');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|sunset|archived');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Email');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `responsible_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Name');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `royalty_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `royalty_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Sunset Date');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `target_ebitda_margin_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Earnings Before Interest, Taxes, Depreciation, and Amortization (EBITDA) Margin Percentage');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `target_ebitda_margin_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `gaming_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'opex|capex|revenue|headcount');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|active|closed');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Code');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `cost_element_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Code');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `game_title_code` SET TAGS ('dbx_business_glossary_term' = 'Game Title Code');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `headcount_fte` SET TAGS ('dbx_business_glossary_term' = 'Headcount Full-Time Equivalent (FTE)');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `is_locked` SET TAGS ('dbx_business_glossary_term' = 'Budget Locked Flag');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Reason');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `scenario_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Scenario Name');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `studio_code` SET TAGS ('dbx_business_glossary_term' = 'Studio Code');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Budget Subcategory');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `variance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Type');
ALTER TABLE `gaming_ecm`.`finance`.`finance_budget` ALTER COLUMN `version_type` SET TAGS ('dbx_value_regex' = 'original|revised|forecast|scenario');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `budget_version_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Identifier (ID)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Identifier (ID)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Identifier (ID)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `quaternary_budget_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `quaternary_budget_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `quaternary_budget_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `tertiary_budget_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `tertiary_budget_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `tertiary_budget_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `budget_version_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Status');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `capex_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Budget Amount');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `ebitda_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Budget Amount');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `is_baseline` SET TAGS ('dbx_business_glossary_term' = 'Is Baseline Flag');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Notes');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `opex_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Expense (OPEX) Budget Amount');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `planning_cycle` SET TAGS ('dbx_business_glossary_term' = 'Planning Cycle');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `planning_cycle` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|rolling_forecast');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `revenue_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Budget Amount');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Scenario Description');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `variance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `version_name` SET TAGS ('dbx_business_glossary_term' = 'Version Name');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `gaming_ecm`.`finance`.`budget_version` ALTER COLUMN `version_type` SET TAGS ('dbx_business_glossary_term' = 'Version Type');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` SET TAGS ('dbx_subdomain' = 'performance_reporting');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `title_pl_id` SET TAGS ('dbx_business_glossary_term' = 'Title Profit and Loss (P&L) Statement ID');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `arppu` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per Paying User (ARPPU)');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `arpu` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per User (ARPU)');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `brand_marketing_spend` SET TAGS ('dbx_business_glossary_term' = 'Brand Marketing Spend');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `cdn_costs` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Network (CDN) Costs');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `chargebacks_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargebacks Amount');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `cogs_total` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Total');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `conversion_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate Percentage');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `dau_average` SET TAGS ('dbx_business_glossary_term' = 'Daily Active Users (DAU) Average');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `development_amortization` SET TAGS ('dbx_business_glossary_term' = 'Development Amortization');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `ebitda` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA)');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|[0-9]{2})$');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `gross_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percentage');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `gross_profit` SET TAGS ('dbx_business_glossary_term' = 'Gross Profit');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `gross_revenue` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `mau_average` SET TAGS ('dbx_business_glossary_term' = 'Monthly Active Users (MAU) Average');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `net_revenue` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'P&L Statement Notes');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `operating_expenses` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenses');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `operating_income` SET TAGS ('dbx_business_glossary_term' = 'Operating Income');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `operating_margin_percent` SET TAGS ('dbx_business_glossary_term' = 'Operating Margin Percentage');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `paying_user_count` SET TAGS ('dbx_business_glossary_term' = 'Paying User Count');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `pl_status` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Statement Status');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `pl_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|audited|restated');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `platform_fees` SET TAGS ('dbx_business_glossary_term' = 'Platform Fees');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `qa_testing_costs` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Testing Costs');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `refunds_amount` SET TAGS ('dbx_business_glossary_term' = 'Refunds Amount');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percentage');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `royalty_expenses` SET TAGS ('dbx_business_glossary_term' = 'Royalty Expenses');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `royalty_expenses` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `server_hosting_costs` SET TAGS ('dbx_business_glossary_term' = 'Server Hosting Costs');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `total_marketing_spend` SET TAGS ('dbx_business_glossary_term' = 'Total Marketing Spend');
ALTER TABLE `gaming_ecm`.`finance`.`title_pl` ALTER COLUMN `user_acquisition_spend` SET TAGS ('dbx_business_glossary_term' = 'User Acquisition (UA) Spend');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` SET TAGS ('dbx_subdomain' = 'performance_reporting');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `studio_pl_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Profit and Loss (P&L) Statement ID');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `allocated_overhead` SET TAGS ('dbx_business_glossary_term' = 'Allocated Overhead');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `depreciation_amortization` SET TAGS ('dbx_business_glossary_term' = 'Depreciation and Amortization');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `ebitda` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest, Taxes, Depreciation, and Amortization (EBITDA)');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `engine_licensing_revenue` SET TAGS ('dbx_business_glossary_term' = 'Game Engine Licensing Revenue');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `gross_profit` SET TAGS ('dbx_business_glossary_term' = 'Gross Profit');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `headcount_cost` SET TAGS ('dbx_business_glossary_term' = 'Headcount Cost');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `headcount_fte` SET TAGS ('dbx_business_glossary_term' = 'Headcount Full-Time Equivalent (FTE)');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `infrastructure_cost` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Cost');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `marketing_cost` SET TAGS ('dbx_business_glossary_term' = 'Marketing and Promotion Cost');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Statement Notes');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `operating_profit` SET TAGS ('dbx_business_glossary_term' = 'Operating Profit');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `other_direct_cost` SET TAGS ('dbx_business_glossary_term' = 'Other Direct Cost');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `other_revenue` SET TAGS ('dbx_business_glossary_term' = 'Other Revenue');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `outsourcing_cost` SET TAGS ('dbx_business_glossary_term' = 'Outsourcing and Contractor Cost');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `platform_certification_cost` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Cost');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `qa_testing_cost` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) and Testing Cost');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `royalty_accrual` SET TAGS ('dbx_business_glossary_term' = 'Royalty Accrual');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Status');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `statement_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|audited|restated');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `studio_name` SET TAGS ('dbx_business_glossary_term' = 'Studio Name');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `studio_status` SET TAGS ('dbx_business_glossary_term' = 'Studio Operational Status');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `studio_status` SET TAGS ('dbx_value_regex' = 'active|inactive|divested|merged|closed');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `studio_type` SET TAGS ('dbx_business_glossary_term' = 'Studio Type');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `studio_type` SET TAGS ('dbx_value_regex' = 'internal|external|acquired|joint_venture|work_for_hire');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `title_royalty_revenue` SET TAGS ('dbx_business_glossary_term' = 'Title Royalty Revenue');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `tooling_cost` SET TAGS ('dbx_business_glossary_term' = 'Tooling and Software Cost');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `total_direct_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Direct Cost');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `total_revenue` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue');
ALTER TABLE `gaming_ecm`.`finance`.`studio_pl` ALTER COLUMN `work_for_hire_revenue` SET TAGS ('dbx_business_glossary_term' = 'Work-for-Hire Revenue');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` SET TAGS ('dbx_subdomain' = 'performance_reporting');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `royalty_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Accrual ID');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement ID');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Statement ID');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `accrual_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period End Date');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `accrual_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period Start Date');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `accrual_status` SET TAGS ('dbx_business_glossary_term' = 'Accrual Status');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `accrued_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Royalty Amount');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `advance_recouped_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Recouped Amount');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'flat_rate|tiered|threshold_based|hybrid|manual');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `net_royalty_payable` SET TAGS ('dbx_business_glossary_term' = 'Net Royalty Payable');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `royalty_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Base Amount');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `royalty_base_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Base Type');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `royalty_base_type` SET TAGS ('dbx_value_regex' = 'net_revenue|gross_revenue|units_sold|iap_revenue|dlc_revenue|subscription_revenue');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `royalty_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Type');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `royalty_type` SET TAGS ('dbx_value_regex' = 'ip_license|music_rights|engine_license|developer_revenue_share|platform_fee|other');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `statement_due_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Due Date');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_accrual` ALTER COLUMN `statement_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Issue Date');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` SET TAGS ('dbx_subdomain' = 'performance_reporting');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `royalty_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Statement ID');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `contract_ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `advance_recoupment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Recoupment Amount');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `calculated_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Calculated Royalty Amount');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `deduction_amount` SET TAGS ('dbx_business_glossary_term' = 'Deduction Amount');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue Amount');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `marketing_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Marketing Cost Amount');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `net_payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `net_royalty_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Royalty Base Amount');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `platform_fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Platform Fees Amount');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `return_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Return and Refund Amount');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `royalty_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `royalty_tier` SET TAGS ('dbx_business_glossary_term' = 'Royalty Tier');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `statement_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Issued Date');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Statement Number');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Status');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_value_regex' = 'draft|issued|acknowledged|disputed|settled|cancelled');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Statement Type');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_value_regex' = 'payable|receivable');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `gaming_ecm`.`finance`.`royalty_statement` ALTER COLUMN `units_sold` SET TAGS ('dbx_business_glossary_term' = 'Units Sold');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` SET TAGS ('dbx_subdomain' = 'performance_reporting');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CapEx) Project ID');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `intangible_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intangible Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'GAAP|IFRS');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `accumulated_amortization` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Amortization');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `actual_spend_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend To Date');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `amortization_method` SET TAGS ('dbx_business_glossary_term' = 'Amortization Method');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `amortization_method` SET TAGS ('dbx_value_regex' = 'straight_line|accelerated|units_of_production');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `amortization_period_months` SET TAGS ('dbx_business_glossary_term' = 'Amortization Period (Months)');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `amortization_start_date` SET TAGS ('dbx_business_glossary_term' = 'Amortization Start Date');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'software|technology|building|equipment|leasehold_improvement|other');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `asset_under_construction_balance` SET TAGS ('dbx_business_glossary_term' = 'Asset Under Construction (AUC) Balance');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `business_justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `capitalization_end_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization End Date');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `capitalization_start_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Start Date');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `capitalization_status` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Status');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `capitalization_status` SET TAGS ('dbx_value_regex' = 'planning|approved|in_progress|capitalized|amortizing|closed');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Amount');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `expected_roi_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Return on Investment (ROI) Percent');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `impairment_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator Flag');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `impairment_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss Amount');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'game_development|engine_technology|infrastructure|studio_facility|platform_integration|other');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `remaining_budget` SET TAGS ('dbx_business_glossary_term' = 'Remaining Budget');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `gaming_ecm`.`finance`.`capex_project` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-.]{6,24}$');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `intangible_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intangible Asset ID');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `ml_model_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Ml Model Registry Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'US_GAAP|IFRS|local_GAAP');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `accumulated_amortization` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Amortization');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `accumulated_amortization` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `accumulated_impairment` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Impairment');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `accumulated_impairment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Method');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_value_regex' = 'internal_development|business_acquisition|asset_purchase|license_acquisition');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `amortization_end_date` SET TAGS ('dbx_business_glossary_term' = 'Amortization End Date');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `amortization_method` SET TAGS ('dbx_business_glossary_term' = 'Amortization Method');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `amortization_method` SET TAGS ('dbx_value_regex' = 'straight_line|units_of_production|declining_balance|not_amortized');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `amortization_start_date` SET TAGS ('dbx_business_glossary_term' = 'Amortization Start Date');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `asset_subclass` SET TAGS ('dbx_business_glossary_term' = 'Asset Subclass');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `disposal_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Disposal Gain or Loss');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `disposal_gain_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sale|abandonment|write_off|transfer');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `gross_carrying_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Carrying Amount');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `gross_carrying_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `is_indefinite_lived` SET TAGS ('dbx_business_glossary_term' = 'Is Indefinite Lived');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `is_internally_developed` SET TAGS ('dbx_business_glossary_term' = 'Is Internally Developed');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `last_impairment_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Impairment Charge Amount');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `last_impairment_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `last_impairment_charge_date` SET TAGS ('dbx_business_glossary_term' = 'Last Impairment Charge Date');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `last_impairment_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Impairment Test Date');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|fully_amortized|impaired|disposed|under_development');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `residual_value` SET TAGS ('dbx_business_glossary_term' = 'Residual Value');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `residual_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `tax_basis` SET TAGS ('dbx_business_glossary_term' = 'Tax Basis');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `tax_basis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`intangible_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation ID');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle ID');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `original_allocation_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Original Allocation ID');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Cost Center ID');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Profit Center ID');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_base_unit` SET TAGS ('dbx_business_glossary_term' = 'Allocation Base Unit of Measure');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_base_value` SET TAGS ('dbx_business_glossary_term' = 'Allocation Base Value');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_key_code` SET TAGS ('dbx_business_glossary_term' = 'Allocation Key Code');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_key_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_key_name` SET TAGS ('dbx_business_glossary_term' = 'Allocation Key Name');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'direct|step_down|reciprocal|activity_based');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_run_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Run Date');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|adjusted|final');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `gaming_ecm`.`finance`.`cost_allocation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'governance_compliance');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Legal Entity ID');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Legal Entity ID');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_date` SET TAGS ('dbx_business_glossary_term' = 'Elimination Date');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Elimination Status');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_value_regex' = 'pending|eliminated|partially_eliminated|not_applicable');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `functional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency` SET TAGS ('dbx_business_glossary_term' = 'Group Reporting Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_reference` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Reference Number');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Reconciliation Status');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|disputed|resolved');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'unsettled|partially_settled|fully_settled|written_off');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Amount');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Date');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Number');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'cost_plus|market_price|negotiated|comparable_uncontrolled_price|resale_price|profit_split');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `gaming_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'governance_compliance');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Legal Entity ID');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_ultimate_parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Legal Entity ID');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `audit_opinion_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Opinion Type');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `audit_opinion_type` SET TAGS ('dbx_value_regex' = 'unqualified|qualified|adverse|disclaimer');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `business_segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `business_segment` SET TAGS ('dbx_value_regex' = 'game_development|game_publishing|esports_operations|game_engine_licensing|platform_services');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_group_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Code');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_value_regex' = 'full|proportional|equity|none');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Dissolution');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Status');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_value_regex' = 'active|dormant|liquidation|dissolved|suspended|pending_incorporation');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'holding_company|subsidiary|joint_venture|branch|special_purpose_vehicle|partnership');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_end_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Month');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'north_america|europe|asia_pacific|latin_america|middle_east_africa');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Incorporation');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `intercompany_partner_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Partner Number');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `is_regulated_entity` SET TAGS ('dbx_business_glossary_term' = 'Is Regulated Entity Flag');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction of Incorporation Code');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Completion Date');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Code');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Country Code');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_business_glossary_term' = 'Registered State or Province');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Registration Number');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Authority');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `regulatory_filing_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Requirement');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `regulatory_filing_requirement` SET TAGS ('dbx_value_regex' = 'public|private|exempt');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Short Name');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `stock_exchange_listing` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Listing Code');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `gaming_ecm`.`finance`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts ID');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_category` SET TAGS ('dbx_business_glossary_term' = 'Account Category');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_category` SET TAGS ('dbx_value_regex' = 'balance_sheet|profit_and_loss|statistical');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'Account Group');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|blocked|marked_for_deletion');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_subgroup` SET TAGS ('dbx_business_glossary_term' = 'Account Subgroup');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Classification');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_value_regex' = 'current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `business_area_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Business Area Required Indicator');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `capitalization_eligible_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Eligible Indicator');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `consolidation_account_code` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Code');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_center_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Required Indicator');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|not_applicable');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `cost_element_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Indicator');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `currency_type` SET TAGS ('dbx_business_glossary_term' = 'Currency Type');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `currency_type` SET TAGS ('dbx_value_regex' = 'local|group|transaction|all');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit Credit Indicator');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `esports_category` SET TAGS ('dbx_business_glossary_term' = 'Esports Category');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `field_status_group` SET TAGS ('dbx_business_glossary_term' = 'Field Status Group');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `field_status_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `financial_statement_line_item` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Line Item');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `gaming_account_purpose` SET TAGS ('dbx_business_glossary_term' = 'Gaming Account Purpose');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `line_item_display_indicator` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Indicator');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `open_item_management_indicator` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Indicator');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `platform_fee_category` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Category');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `posting_allowed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Posting Allowed Indicator');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `profit_center_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Required Indicator');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `reconciliation_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Indicator');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `revenue_recognition_pattern` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Pattern');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `revenue_recognition_pattern` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|not_applicable');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `royalty_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Type');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Sort Key');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `subledger_type` SET TAGS ('dbx_business_glossary_term' = 'Subledger Type');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `subledger_type` SET TAGS ('dbx_value_regex' = 'customer|vendor|asset|material|employee|not_applicable');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `gaming_ecm`.`finance`.`chart_of_accounts` ALTER COLUMN `virtual_economy_indicator` SET TAGS ('dbx_business_glossary_term' = 'Virtual Economy Indicator');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` SET TAGS ('dbx_subdomain' = 'governance_compliance');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `finance_tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Tax Record ID');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `assessed_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Assessed Tax Amount');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessment Date');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `assessment_reference` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessment Reference Number');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Tax Filing Date');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `filing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Due Date');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `filing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `filing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `group_currency` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `group_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `group_currency_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Tax Amount');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Interest Amount');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `local_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Notes');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Tax Payment Date');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Payment Due Date');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Payment Reference Number');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Penalty Amount');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `tax_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Name');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `tax_return_reference` SET TAGS ('dbx_business_glossary_term' = 'Tax Return Reference Number');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `tax_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Obligation Status');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `taxable_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Base Amount');
ALTER TABLE `gaming_ecm`.`finance`.`finance_tax_record` ALTER COLUMN `transaction_category` SET TAGS ('dbx_business_glossary_term' = 'Transaction Category');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` SET TAGS ('dbx_subdomain' = 'governance_compliance');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `regulatory_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Disclosure ID');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'US_GAAP|IFRS|local_GAAP');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `audit_opinion` SET TAGS ('dbx_business_glossary_term' = 'Audit Opinion');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `audit_opinion` SET TAGS ('dbx_value_regex' = 'unqualified|qualified|adverse|disclaimer');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `audit_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Date');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `cik_number` SET TAGS ('dbx_business_glossary_term' = 'Central Index Key (CIK) Number');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `disclosure_type` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Type');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `ebitda_reported` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Reported');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `esports_prize_pool_liability` SET TAGS ('dbx_business_glossary_term' = 'Esports Prize Pool Liability');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Exchange Code');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `external_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Name');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `filing_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline Date');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `game_development_impairment_amount` SET TAGS ('dbx_business_glossary_term' = 'Game Development Impairment Amount');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `internal_control_opinion` SET TAGS ('dbx_business_glossary_term' = 'Internal Control Opinion');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `internal_control_opinion` SET TAGS ('dbx_value_regex' = 'effective|material_weakness|significant_deficiency|not_applicable');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `ip_write_down_amount` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Write-Down Amount');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `is_amended` SET TAGS ('dbx_business_glossary_term' = 'Is Amended');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `material_disclosure_summary` SET TAGS ('dbx_business_glossary_term' = 'Material Disclosure Summary');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `net_income_reported` SET TAGS ('dbx_business_glossary_term' = 'Net Income Reported');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `original_filing_number` SET TAGS ('dbx_business_glossary_term' = 'Original Filing Number');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `prepared_by_user` SET TAGS ('dbx_business_glossary_term' = 'Prepared By User');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `reviewed_by_user` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By User');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `sox_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Certification Status');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `sox_certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|pending');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `stockholders_equity_reported` SET TAGS ('dbx_business_glossary_term' = 'Stockholders Equity Reported');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `ticker_symbol` SET TAGS ('dbx_business_glossary_term' = 'Ticker Symbol');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `total_assets_reported` SET TAGS ('dbx_business_glossary_term' = 'Total Assets Reported');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `total_liabilities_reported` SET TAGS ('dbx_business_glossary_term' = 'Total Liabilities Reported');
ALTER TABLE `gaming_ecm`.`finance`.`regulatory_disclosure` ALTER COLUMN `total_revenue_reported` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Reported');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `deferred_revenue_id` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue ID');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `content_delivery_schedule` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Schedule');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `contract_liability_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Liability Number');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `deferred_revenue_status` SET TAGS ('dbx_business_glossary_term' = 'Liability Status');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `deferred_revenue_status` SET TAGS ('dbx_value_regex' = 'open|partially_recognized|fully_recognized|refunded|cancelled');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `initial_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Liability Amount');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `is_pre_order` SET TAGS ('dbx_business_glossary_term' = 'Is Pre-Order');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `is_subscription` SET TAGS ('dbx_business_glossary_term' = 'Is Subscription');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `last_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Last Recognition Date');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `liability_type` SET TAGS ('dbx_business_glossary_term' = 'Liability Type');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `liability_type` SET TAGS ('dbx_value_regex' = 'season_pass|subscription|pre_order|dlc_bundle|virtual_currency|battle_pass');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `next_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recognition Date');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `performance_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Description');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `purchase_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Purchase Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `recognition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition End Date');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `recognition_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recognition Frequency');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `recognition_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|event_based|usage_based');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'straight_line|usage_based|milestone_based|time_elapsed|content_delivery');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `recognition_period_months` SET TAGS ('dbx_business_glossary_term' = 'Recognition Period Months');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `recognition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Recognition Start Date');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `recognized_revenue_to_date` SET TAGS ('dbx_business_glossary_term' = 'Recognized Revenue To Date');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `remaining_liability_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Liability Balance');
ALTER TABLE `gaming_ecm`.`finance`.`deferred_revenue` ALTER COLUMN `revenue_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue General Ledger (GL) Account Code');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Period Close ID');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `predecessor_task_period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Task ID');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner ID');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `quaternary_period_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `quaternary_period_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `quaternary_period_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `tertiary_period_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `tertiary_period_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `tertiary_period_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `prior_period_close_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `accelerated_close_flag` SET TAGS ('dbx_business_glossary_term' = 'Accelerated Close Flag');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `automation_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Automation Enabled Flag');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `blocking_issue_description` SET TAGS ('dbx_business_glossary_term' = 'Blocking Issue Description');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `blocking_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocking Issue Flag');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `close_status` SET TAGS ('dbx_business_glossary_term' = 'Close Status');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `close_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|pending_review|approved|completed|reopened');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `close_task_name` SET TAGS ('dbx_business_glossary_term' = 'Close Task Name');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `close_type` SET TAGS ('dbx_business_glossary_term' = 'Close Type');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `close_type` SET TAGS ('dbx_value_regex' = 'month_end|quarter_end|year_end|special');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `control_evidence_document_url` SET TAGS ('dbx_business_glossary_term' = 'Control Evidence Document URL');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `planned_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Completion Date');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `responsible_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Name');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `sign_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `sign_off_user_name` SET TAGS ('dbx_business_glossary_term' = 'Sign-Off User Name');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `sign_off_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `sign_off_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `sox_control_reference` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley) Control Reference');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `task_category` SET TAGS ('dbx_business_glossary_term' = 'Task Category');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `task_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Task Sequence Number');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|blocked|deferred');
ALTER TABLE `gaming_ecm`.`finance`.`period_close` ALTER COLUMN `variance_explanation` SET TAGS ('dbx_business_glossary_term' = 'Variance Explanation');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `parent_fixed_asset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standard');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accounting_standard` SET TAGS ('dbx_value_regex' = 'GAAP|IFRS|local_GAAP');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation General Ledger (GL) Account Code');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_impairment` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Impairment');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'game_development_hardware|server_infrastructure|studio_office_fitout|esports_broadcast_equipment|motion_capture_equipment|performance_capture_rig');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_subclass` SET TAGS ('dbx_business_glossary_term' = 'Asset Subclass');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'Depreciation General Ledger (GL) Account Code');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|double_declining_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Disposal Gain or Loss');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sale|scrap|donation|trade_in|retirement|transfer');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator Flag');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_impairment_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Impairment Test Date');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'in_service|under_construction|idle|retired|disposed|impaired');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `original_cost` SET TAGS ('dbx_business_glossary_term' = 'Original Cost');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `residual_value` SET TAGS ('dbx_business_glossary_term' = 'Residual Value');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Name');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `responsible_person_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_basis` SET TAGS ('dbx_business_glossary_term' = 'Tax Basis');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `gaming_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` SET TAGS ('dbx_subdomain' = 'governance_compliance');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` SET TAGS ('dbx_association_edges' = 'finance.cost_center,compliance.regulatory_obligation');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ALTER COLUMN `compliance_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Allocation ID');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Allocation - Cost Center Id');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Allocation - Regulatory Obligation Id');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ALTER COLUMN `allocation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ALTER COLUMN `compliance_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Compliance Budget Amount');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ALTER COLUMN `next_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Date');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ALTER COLUMN `responsible_officer` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer');
ALTER TABLE `gaming_ecm`.`finance`.`compliance_allocation` ALTER COLUMN `risk_mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Plan');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` SET TAGS ('dbx_association_edges' = 'workforce.employee,finance.budget');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `budget_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Authority Identifier');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `assigned_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authority Assigner Employee');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `assigned_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `assigned_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval - Employee Id');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval - Budget Id');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `revoked_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authority Revoker Employee');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `revoked_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `revoked_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `approval_role` SET TAGS ('dbx_business_glossary_term' = 'Approval Role Type');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Authority Assignment Date');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `authority_currency` SET TAGS ('dbx_business_glossary_term' = 'Authority Limit Currency');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `delegation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delegation Period End Date');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `delegation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delegation Period Start Date');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Authority Status');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Notes');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `revoked_date` SET TAGS ('dbx_business_glossary_term' = 'Authority Revocation Date');
ALTER TABLE `gaming_ecm`.`finance`.`budget_approval` ALTER COLUMN `spending_authority_limit` SET TAGS ('dbx_business_glossary_term' = 'Spending Authority Limit Amount');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` SET TAGS ('dbx_subdomain' = 'governance_compliance');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` SET TAGS ('dbx_association_edges' = 'finance.legal_entity,compliance.jurisdiction');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `entity_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Entity Registration Identifier');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Entity Registration - Jurisdiction Id');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Entity Registration - Legal Entity Id');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Registration Flag');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `compliance_officer_contact` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Contact');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction-Specific License Number');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `local_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Local Entity Name');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Registration Notes');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `regulatory_authority_contact` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Contact');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction-Specific Tax Registration Number');
ALTER TABLE `gaming_ecm`.`finance`.`entity_registration` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`allocation_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`finance`.`allocation_cycle` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `gaming_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `allocation_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Cycle Identifier');
ALTER TABLE `gaming_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `previous_allocation_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`allocation_cycle` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`business_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`finance`.`business_unit` SET TAGS ('dbx_subdomain' = 'governance_compliance');
ALTER TABLE `gaming_ecm`.`finance`.`business_unit` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier');
ALTER TABLE `gaming_ecm`.`finance`.`business_unit` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`finance`.`business_unit` ALTER COLUMN `headcount_planned` SET TAGS ('dbx_confidential' = 'true');
