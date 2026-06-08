-- Schema for Domain: finance | Business: Genomics Biotech | Version: v1_ecm
-- Generated on: 2026-05-06 13:04:42

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`finance` COMMENT 'Owns enterprise financial management — general ledger, cost centers, accounts payable/receivable, revenue recognition, budgeting, R&D capitalization, COGS allocation, financial consolidation, and SOX-compliant reporting. Manages EBITDA tracking, ROI analysis, multi-entity P&L, and capital expenditures. Integrates SAP FI/CO as the primary ERP financial system of record.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` (
    `general_ledger_id` BIGINT COMMENT 'Unique identifier for the general ledger entry. Primary key for the general ledger data product.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to commercial.commercial_contract. Business justification: Contracts generate specific GL postings (deferred revenue, contract assets, contract liabilities). Essential for ASC 606 compliance, contract accounting, and financial statement preparation. Standard ',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: general_ledger represents detailed posting lines that belong to a journal_entry header document. This is a classic header-line relationship. GL lines inherit document-level attributes from the JE head',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: High-value opportunities may require GL reserve postings (bad debt provisions, warranty reserves, contract loss provisions). Critical for revenue risk management, deal-specific accounting, and audit t',
    `quality_issue_id` BIGINT COMMENT 'Foreign key linking to data.quality_issue. Business justification: Quality issues in GL data must reference specific GL line items for root cause analysis and correction. Core data governance process for maintaining financial data integrity and audit compliance.',
    `account_type` STRING COMMENT 'High-level classification of the GL account into one of the five fundamental accounting categories. Determines financial statement placement and normal balance (debit or credit).. Valid values are `asset|liability|equity|revenue|expense`',
    `amount_transaction_currency` DECIMAL(18,2) COMMENT 'Original transaction amount in the currency in which the business transaction occurred. Preserved for audit trail and foreign exchange gain/loss calculation.',
    `assignment` STRING COMMENT 'Free-text field used for additional reference information, payment allocation, or internal tracking codes. Often used for bank reconciliation and payment matching.',
    `business_area` STRING COMMENT 'Cross-company code organizational unit representing a business segment or division for segment reporting. Enables consolidated balance sheet by business area.. Valid values are `^[A-Z0-9]{4}$`',
    `clearing_date` DATE COMMENT 'Date when open items (receivables, payables) were cleared or settled. Null for non-clearable accounts or open items. Format: yyyy-MM-dd.',
    `clearing_document` STRING COMMENT 'Document number of the clearing document that settled this open item. Populated only for cleared items. Links payment to invoice.. Valid values are `^[0-9]{10}$`',
    `company_code` STRING COMMENT 'Four-character alphanumeric code identifying the legal entity within the SAP S/4HANA enterprise structure. Represents the smallest organizational unit for which a complete self-contained set of accounts can be drawn up for purposes of external reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center` STRING COMMENT 'Organizational unit code from SAP CO (Controlling) representing the department or functional area responsible for the cost or revenue. Used for internal management reporting and cost allocation.. Valid values are `^[A-Z0-9]{6,10}$`',
    `credit_amount_group` DECIMAL(18,2) COMMENT 'Credit amount translated into the group reporting currency for consolidated financial statements. Zero if the posting is a debit. Enables multi-entity consolidation.',
    `credit_amount_local` DECIMAL(18,2) COMMENT 'Credit amount posted to the GL account in the local currency of the company code. Zero if the posting is a debit. Used for trial balance and financial statement preparation.',
    `debit_amount_group` DECIMAL(18,2) COMMENT 'Debit amount translated into the group reporting currency for consolidated financial statements. Zero if the posting is a credit. Enables multi-entity consolidation.',
    `debit_amount_local` DECIMAL(18,2) COMMENT 'Debit amount posted to the GL account in the local currency of the company code. Zero if the posting is a credit. Used for trial balance and financial statement preparation.',
    `document_line_item` STRING COMMENT 'Sequential line item number within the accounting document. Combined with document_number, uniquely identifies each individual debit or credit posting.',
    `entry_date` DATE COMMENT 'Date when the document was entered into the SAP system. Used for audit trail and document control. Format: yyyy-MM-dd.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate used to translate local currency amounts to group currency. Stored with five decimal precision for accuracy in multi-currency consolidation.',
    `financial_statement_item` STRING COMMENT 'Mapping to the specific line item on the financial statements (P&L, balance sheet, cash flow statement) where this account balance is reported. Enables automated financial statement generation.',
    `fiscal_period` STRING COMMENT 'Two-digit posting period within the fiscal year (01-12 for regular periods, 13-16 for special closing periods). Used for period-end close and financial reporting.. Valid values are `^(0[1-9]|1[0-6])$`',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year in which the transaction was posted. May differ from calendar year depending on company fiscal calendar configuration.. Valid values are `^[0-9]{4}$`',
    `functional_area` STRING COMMENT 'Classification of costs and revenues by business function (e.g., R&D, manufacturing, sales, administration) for cost-of-sales accounting and functional P&L reporting.. Valid values are `^[A-Z0-9]{6}$`',
    `gl_account_name` STRING COMMENT 'Descriptive name of the GL account providing business context for the account classification (e.g., Sequencing Reagent Revenue, R&D Salaries, Instrument COGS).',
    `gl_account_number` STRING COMMENT 'Unique account number from the chart of accounts identifying the GL account. Defines the classification of the transaction (revenue, COGS, R&D expense, SG&A, asset, liability, equity).. Valid values are `^[0-9]{6,10}$`',
    `group_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the corporate groups reporting currency used in consolidated financial statements (typically USD for US-based multinationals).. Valid values are `^[A-Z]{3}$`',
    `ledger_group` STRING COMMENT 'Identifier for parallel accounting ledgers (e.g., 0L=leading ledger, 2L=IFRS ledger, 3L=tax ledger). Enables simultaneous accounting under multiple GAAPs.. Valid values are `^[A-Z0-9]{2}$`',
    `local_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the company codes local currency (e.g., USD, EUR, GBP). All local amounts are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `posting_key` STRING COMMENT 'Two-digit code controlling the posting characteristics (debit/credit, account type, field status). Determines which fields are required or optional during posting.. Valid values are `^[0-9]{2}$`',
    `profit_center` STRING COMMENT 'Management-oriented organizational unit for internal profit and loss reporting. Enables P&L analysis by product line, business unit, or geographic region.. Valid values are `^[A-Z0-9]{6,10}$`',
    `reference_key` STRING COMMENT 'Reference identifier linking the GL posting to the originating business transaction (e.g., sales order number, purchase order number, invoice number). Enables drill-back to source documents.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this posting is a reversal of a previous entry. True if this is a reversal document, False otherwise. Used for audit trail and error correction tracking.',
    `reversed_document_number` STRING COMMENT 'Document number of the original posting that this entry reverses. Populated only when reversal_indicator is True. Maintains audit trail for corrections.. Valid values are `^[0-9]{10}$`',
    `segment` STRING COMMENT 'Organizational unit for segment reporting under IFRS 8 and GAAP ASC 280. Represents reportable business segments for external financial reporting.. Valid values are `^[A-Z0-9]{6}$`',
    `special_gl_indicator` STRING COMMENT 'Single-character code identifying special GL transactions such as down payments, bills of exchange, or guarantees. Blank for standard postings.. Valid values are `^[A-Z]$`',
    `tax_amount_local` DECIMAL(18,2) COMMENT 'Tax amount calculated and posted in local currency. Separated from base amount for tax reporting and reconciliation purposes.',
    `tax_code` STRING COMMENT 'Code identifying the tax jurisdiction and tax rate applied to the transaction. Used for automatic tax calculation and tax reporting compliance.. Valid values are `^[A-Z0-9]{2,4}$`',
    `text` STRING COMMENT 'Descriptive text providing business context for the posting. May include vendor name, customer name, or transaction description for audit and reporting purposes.',
    `trading_partner` STRING COMMENT 'Company code of the intercompany trading partner for intercompany transactions. Used for intercompany reconciliation and elimination entries in consolidation.. Valid values are `^[A-Z0-9]{6}$`',
    `transaction_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the original business transaction was denominated. May differ from local_currency for foreign currency transactions.. Valid values are `^[A-Z]{3}$`',
    `user_name` STRING COMMENT 'SAP user ID of the person who posted the document. Used for audit trail and SOX compliance to track who made financial postings.',
    CONSTRAINT pk_general_ledger PRIMARY KEY(`general_ledger_id`)
) COMMENT 'SAP FI-GL authoritative ledger and chart of accounts master for Genomics Biotech — defines all GL account codes (revenue, COGS, R&D expense, SG&A, capitalized development, balance sheet) and captures every debit/credit posting across company codes, fiscal periods, and currencies. Serves as the SSOT for trial balance, P&L, and balance sheet reporting. Includes account type classification, financial statement mapping, tax category, and currency settings. Supports multi-entity consolidation, period-end close controls, and SOX-compliant audit trails.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique identifier for the journal entry document in SAP FI. Primary key for the journal entry record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SOX compliance and segregation of duties validation require tracking which employee posted each journal entry. Critical for audit trail, maker-checker controls, and access certification reviews in GxP',
    `quality_issue_id` BIGINT COMMENT 'Foreign key linking to data.quality_issue. Business justification: Quality issues detected in financial data must link to affected journal entries for investigation and correction. Enables remediation workflow and audit trail for data quality incidents in financial r',
    `baseline_date` DATE COMMENT 'Baseline date for payment terms calculation. Used to determine due date and cash discount periods for payables and receivables.',
    `batch_input_session` STRING COMMENT 'Batch input session name if this journal entry was created through batch processing. Used for mass data upload tracking and error resolution.',
    `business_area` STRING COMMENT 'Business area code representing a segment or division for internal management reporting. Used for segment reporting and P&L analysis.. Valid values are `^[A-Z0-9]{4}$`',
    `changed_timestamp` TIMESTAMP COMMENT 'System timestamp when this journal entry record was last modified. Used for audit trail and change tracking.',
    `clearing_date` DATE COMMENT 'Date when this journal entry was cleared. Null if the document remains open. Used for accounts payable and receivable aging analysis.',
    `clearing_document_number` STRING COMMENT 'Document number of the clearing document if this journal entry has been cleared (e.g., payment clearing an invoice). Used for open item management.',
    `company_code` STRING COMMENT 'Four-character company code representing the legal entity in SAP FI. Used for financial consolidation and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center` STRING COMMENT 'Cost center code for cost allocation and overhead tracking. Used for departmental expense management and budget control.. Valid values are `^[A-Z0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this journal entry record was created in the SAP FI system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the document currency. Represents the currency in which the journal entry amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'Date on the source document that originated this journal entry. Represents the business transaction date.',
    `document_header_text` STRING COMMENT 'Free-text description at the document header level providing context about the journal entry purpose or business transaction.',
    `document_number` STRING COMMENT 'SAP FI document number assigned to this journal entry. Unique business identifier for the accounting document within the fiscal year and company code.. Valid values are `^[A-Z0-9]{10}$`',
    `document_type` STRING COMMENT 'Two-character SAP document type code that classifies the journal entry by business transaction category (e.g., SA=GL account document, DR=customer invoice, KR=vendor invoice, DZ=customer payment, KZ=vendor payment).. Valid values are `^[A-Z]{2}$`',
    `entry_date` DATE COMMENT 'Date when the journal entry document was created in the system. Used for audit trail and document tracking.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert foreign currency amounts to local currency. Applied at the time of posting for multi-currency transactions.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the journal entry was posted. Used for period-based financial reporting and year-end closing.',
    `ledger_group` STRING COMMENT 'Ledger group identifier for parallel accounting scenarios (e.g., IFRS, US GAAP, local GAAP). Used for multi-standard financial reporting.',
    `line_item_count` STRING COMMENT 'Number of line items contained in this journal entry document. Used for document completeness validation and processing efficiency analysis.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Total document amount in local currency (company code currency). Used for statutory reporting and financial consolidation.',
    `originating_process` STRING COMMENT 'Business process that originated this journal entry. Identifies the source transaction type for traceability and process-specific reporting. [ENUM-REF-CANDIDATE: revenue_recognition|cogs_allocation|rd_capitalization|payroll|procurement|asset_depreciation|intercompany|manual_adjustment|accrual|tax_provision|other — 11 candidates stripped; promote to reference product]',
    `parked_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry is in parked status (saved but not yet posted). Parked documents do not update the general ledger until posted.',
    `payment_terms` STRING COMMENT 'Payment terms code defining due date calculation and cash discount conditions. Used for accounts payable and receivable management.',
    `posting_date` DATE COMMENT 'Date when the journal entry was posted to the general ledger. Determines the fiscal period assignment and affects financial statement reporting.',
    `posting_key` STRING COMMENT 'Two-digit posting key that controls the type of posting (debit/credit) and account type. Standard SAP FI posting keys include 40 (debit GL), 50 (credit GL), 01 (debit customer), 11 (credit customer), 31 (debit vendor), 21 (credit vendor).. Valid values are `^[0-9]{2}$`',
    `posting_period` STRING COMMENT 'Posting period within the fiscal year (1-12 for regular periods, 13-16 for special periods). Used for monthly financial close and reporting.',
    `profit_center` STRING COMMENT 'Profit center code for internal profitability analysis. Used for management accounting and EBITDA tracking by business unit.. Valid values are `^[A-Z0-9]{10}$`',
    `reference_document_number` STRING COMMENT 'External reference number linking this journal entry to source documents such as invoices, purchase orders, or contracts. Used for cross-system reconciliation.',
    `reversal_date` DATE COMMENT 'Date when this journal entry was reversed. Null if the document has not been reversed.',
    `reversal_document_number` STRING COMMENT 'Document number of the reversing journal entry. Null if this document has not been reversed.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry has been reversed. True if the document has been reversed, false otherwise.',
    `reversed_document_number` STRING COMMENT 'Document number of the original journal entry that this document reverses. Populated only if this is a reversal document.',
    `source_system` STRING COMMENT 'Name or identifier of the system that originated this journal entry (e.g., SAP FI, SAP CO, external interface, manual entry). Used for data lineage and reconciliation.',
    `sox_control_flag` BOOLEAN COMMENT 'Flag indicating whether this journal entry is subject to SOX internal controls and requires additional approval or documentation. Used for financial reporting compliance.',
    `tax_code` STRING COMMENT 'Tax code applied to this journal entry for automatic tax calculation. Determines tax rate, tax type, and GL account assignment for tax postings.',
    `trading_partner` STRING COMMENT 'Trading partner company code for intercompany transactions. Used for intercompany reconciliation and elimination in consolidated financial statements.',
    `transaction_currency_amount` DECIMAL(18,2) COMMENT 'Total document amount in transaction currency. Sum of all line item amounts in the original transaction currency.',
    `withholding_tax_code` STRING COMMENT 'Withholding tax code for vendor payments or customer receipts subject to tax withholding. Used for statutory withholding tax reporting.',
    `workflow_status` STRING COMMENT 'Current workflow status of the journal entry document. Used for approval workflows and SOX controls on manual journal entries.. Valid values are `draft|pending_approval|approved|posted|rejected|cancelled`',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Individual accounting journal entry document in SAP FI — records the business transaction that drives a general ledger posting. Captures document type, posting date, reference document, reversal status, and the originating business process (e.g., revenue recognition, COGS allocation, R&D capitalization). Each journal entry contains one or more line items and is the atomic unit of financial recording.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center within the SAP CO (Controlling) module. Primary key for cost center master data.',
    `market_segment_target_id` BIGINT COMMENT 'Foreign key linking to commercial.market_segment_target. Business justification: Market segments often have dedicated cost centers for segment P&L reporting. Enables segment profitability analysis, resource allocation decisions, and strategic investment tracking. Common in genomic',
    `mdm_policy_id` BIGINT COMMENT 'Foreign key linking to data.mdm_policy. Business justification: Cost centers are master data entities subject to MDM policies governing naming conventions, hierarchies, ownership, and lifecycle. Required for master data governance and organizational structure mana',
    `parent_cost_center_id` BIGINT COMMENT 'Reference to the parent cost center in the organizational hierarchy. Enables roll-up reporting and hierarchical cost allocation.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the responsible manager or cost center owner. Accountable for budget and cost performance.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to commercial.territory. Business justification: Sales territories commonly map to cost centers for expense allocation and P&L reporting. Enables territory profitability analysis, sales expense management, and headcount planning. Standard practice i',
    `activity_type` STRING COMMENT 'Primary activity type or service provided by this cost center for activity-based costing (e.g., sequencing runs, bioinformatics compute hours, QC testing hours). Used for internal cost allocation.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total annual budget allocated to this cost center in the local currency. Used for budget vs. actual variance analysis and cost control.',
    `budget_allocation_flag` BOOLEAN COMMENT 'Indicates whether this cost center has a formal budget allocation. True if budget is assigned and tracked, false otherwise.',
    `business_area` STRING COMMENT 'Business area assignment for segment reporting (e.g., Sequencing Instruments, Reagent Kits, Clinical Genomics Services, Agricultural Genomics). Enables cross-company-code P&L analysis.',
    `capitalization_eligible_flag` BOOLEAN COMMENT 'Indicates whether costs from this cost center are eligible for R&D capitalization under accounting standards. True for development-stage R&D activities meeting capitalization criteria.',
    `cogs_allocation_flag` BOOLEAN COMMENT 'Indicates whether costs from this cost center are allocated to COGS. True for manufacturing, production, and direct service delivery cost centers.',
    `company_code` STRING COMMENT 'SAP FI company code to which this cost center is assigned. Represents the legal entity for financial consolidation and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area` STRING COMMENT 'SAP CO controlling area that governs this cost center. Defines the organizational unit for cost accounting and internal reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_allocation_method` STRING COMMENT 'Method used for allocating costs from this cost center to other cost objects: direct (direct assignment), activity-based (ABC costing), step-down (sequential allocation), reciprocal (mutual services), or none (no allocation).. Valid values are `direct|activity_based|step_down|reciprocal|none`',
    `cost_center_category` STRING COMMENT 'Functional category of the cost center: production (manufacturing and operations), research and development (R&D activities), sales and marketing, administration (corporate overhead), quality assurance (QA/QC), or regulatory affairs.. Valid values are `production|research_development|sales_marketing|administration|quality_assurance|regulatory_affairs`',
    `cost_center_code` STRING COMMENT 'Business identifier for the cost center (e.g., NGS-OPS-001, BIO-ENG-002, R&D-CRISPR-003). Externally-known unique code used in financial reporting and cost allocation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `cost_center_group` STRING COMMENT 'Grouping classification for aggregated reporting (e.g., All R&D Centers, All Manufacturing Centers, All Clinical Centers). Enables multi-dimensional analysis.',
    `cost_center_name` STRING COMMENT 'Full descriptive name of the cost center (e.g., NGS Operations, Bioinformatics Engineering, Clinical Assay Validation, R&D Gene Editing, Manufacturing GMP).',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center: active (operational and accepting postings), inactive (closed, no postings allowed), blocked (temporarily suspended), or planned (future activation).. Valid values are `active|inactive|blocked|planned`',
    `cost_center_type` STRING COMMENT 'Classification of the organizational unit: cost center (cost tracking only), profit center (revenue and cost), investment center (ROI tracking), revenue center (revenue focus), or service center (internal services).. Valid values are `cost_center|profit_center|investment_center|revenue_center|service_center`',
    `cost_element_group` STRING COMMENT 'Primary cost element group associated with this cost center (e.g., labor, materials, overhead, depreciation). Used for cost structure analysis.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this cost center record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost center record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost center transactions and budgets (e.g., USD, EUR, GBP). Defines the local currency for cost accounting.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Department code to which this cost center belongs. Links cost center to organizational structure for workforce and operational reporting.',
    `functional_area` STRING COMMENT 'Functional area classification for cost-of-sales accounting (e.g., COGS, R&D, SG&A). Used for P&L reporting by function.',
    `gmp_regulated_flag` BOOLEAN COMMENT 'Indicates whether this cost center operates under GMP regulations. True for manufacturing and quality centers subject to FDA/EMA GMP requirements.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the cost center hierarchy (1 = top level, increasing for deeper levels). Used for hierarchical reporting and aggregation.',
    `last_modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this cost center record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost center record was last modified. Used for audit trail and change tracking.',
    `location_code` STRING COMMENT 'Physical location or site code where the cost center operates (e.g., facility, campus, building). Used for geographic cost analysis.',
    `notes` STRING COMMENT 'Free-text notes and comments about the cost center, including special instructions, organizational changes, or audit remarks.',
    `segment_code` STRING COMMENT 'Business segment code for segment reporting (e.g., Sequencing Instruments, Reagent Kits, Clinical Services, Agricultural Genomics). Enables segment-level P&L and EBITDA tracking.',
    `short_description` STRING COMMENT 'Abbreviated description of the cost center for display in reports and dashboards.',
    `sox_compliance_flag` BOOLEAN COMMENT 'Indicates whether this cost center is subject to SOX internal controls and audit requirements. True for cost centers involved in financial reporting processes.',
    `transfer_pricing_flag` BOOLEAN COMMENT 'Indicates whether this cost center participates in intercompany transfer pricing. True for profit centers involved in cross-entity transactions requiring transfer pricing documentation.',
    `valid_from_date` DATE COMMENT 'Effective start date for this cost center. Defines when the cost center becomes active and can accept cost postings.',
    `valid_to_date` DATE COMMENT 'Effective end date for this cost center. Defines when the cost center is closed and no longer accepts cost postings. Null for open-ended cost centers.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'SAP CO organizational master data representing cost and profit objects within Genomics Biotech — encompasses cost centers (NGS Operations, Bioinformatics Engineering, Clinical Assay Validation, R&D Gene Editing, Manufacturing GMP), profit centers (Sequencing Instruments, Reagent Kits, Clinical Genomics Services, Agricultural Genomics), and business segments. Tracks hierarchy, responsible manager, valid-from/to dates, currency, company code assignment, and parent node. Enables multi-dimensional P&L reporting, internal cost allocation, ROI analysis by business unit, segment-level EBITDA tracking, and transfer pricing documentation by profit center.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` (
    `accounts_payable_id` BIGINT COMMENT 'Unique identifier for the accounts payable transaction record. Primary key for the accounts payable entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to commercial.campaign. Business justification: Marketing campaigns generate vendor invoices (agencies, event vendors, media buys) that flow through AP. Essential for campaign expense accrual, budget reconciliation, and marketing ROI calculation. G',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Replace string cost_center with FK for proper cost allocation reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Replace string profit_center with FK to enable profit‑center level analysis of payables.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier or vendor from whom goods or services were procured. Links to the vendor master record.',
    `baseline_date` DATE COMMENT 'The reference date from which payment terms are calculated. Typically the invoice date or goods receipt date depending on payment term configuration.',
    `business_area` STRING COMMENT 'The business area or division to which this payable is assigned. Enables cross-company code financial reporting by business segment.',
    `company_code` STRING COMMENT 'Four-character alphanumeric code representing the legal entity within the enterprise for which this payable is recorded. Used for financial consolidation and reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the invoice record was first created in the system. Used for audit trail and process performance analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The cash discount amount available if payment is made within the discount period as defined in payment terms.',
    `document_date` DATE COMMENT 'The date of the accounting document in the system. May differ from invoice date and posting date depending on document workflow.',
    `due_date` DATE COMMENT 'The date by which payment must be made to the vendor according to the agreed payment terms. Critical for cash flow forecasting and avoiding late payment penalties.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert foreign currency invoice amounts to the company code local currency. Null for local currency invoices.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the invoice was posted. Used for period-based financial reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the invoice was posted. Derived from the posting date and company code fiscal year variant.',
    `gl_account` STRING COMMENT 'The general ledger account number to which the expense portion of this invoice is posted. Determines the expense classification in financial statements.',
    `goods_receipt_number` STRING COMMENT 'The goods receipt document number confirming physical receipt of materials or services. Critical for GR/IR (Goods Receipt/Invoice Receipt) clearing and three-way match.',
    `invoice_date` DATE COMMENT 'The date on which the vendor issued the invoice. Used for aging analysis and payment term calculation.',
    `invoice_description` STRING COMMENT 'Free-text description of the invoice contents. May include details about the goods or services procured, project references, or special instructions.',
    `invoice_gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount including all taxes, fees, and charges before any discounts or adjustments.',
    `invoice_number` STRING COMMENT 'The unique invoice number assigned by the vendor. This is the externally-known identifier for the invoice document.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice. Draft invoices are being prepared; posted invoices are in the ledger; blocked invoices require approval; approved invoices are ready for payment; paid invoices are settled; cancelled invoices are voided.. Valid values are `draft|posted|blocked|approved|paid|cancelled`',
    `invoice_type` STRING COMMENT 'Classification of the invoice document type. Standard invoices are for goods/services received; credit memos reduce payables; debit memos increase payables; down payments and prepayments are advance payments.. Valid values are `standard|credit_memo|debit_memo|down_payment|prepayment|recurring`',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The invoice amount converted to the company code local currency using the exchange rate. Used for consolidated financial reporting.',
    `modified_by` STRING COMMENT 'The user ID of the person who last modified the invoice record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the invoice record was last modified. Used for audit trail and SOX compliance.',
    `net_payable_amount` DECIMAL(18,2) COMMENT 'The net amount payable to the vendor after applying all taxes, discounts, and adjustments. This is the amount that will be paid.',
    `payment_block_code` STRING COMMENT 'Code indicating why payment is blocked. Common reasons include pending approval, price variance, quantity variance, or quality issues. Null if no block is active.',
    `payment_date` DATE COMMENT 'The actual date on which payment was made to the vendor. Null if invoice is unpaid. Used for cash flow analysis and vendor payment performance tracking.',
    `payment_method` STRING COMMENT 'The method by which payment will be or was made to the vendor. Determines payment processing workflow and bank account selection.. Valid values are `check|wire_transfer|ach|eft|credit_card|virtual_card`',
    `payment_reference_number` STRING COMMENT 'The reference number of the payment run or payment document that settled this invoice. Null if invoice is unpaid.',
    `payment_terms` STRING COMMENT 'Code representing the agreed payment terms with the vendor (e.g., Net 30, 2/10 Net 30). Defines discount periods and due date calculation logic.',
    `posting_date` DATE COMMENT 'The date on which the invoice was posted to the general ledger. Determines the fiscal period for financial reporting.',
    `price_variance_amount` DECIMAL(18,2) COMMENT 'The difference between the invoice price and the purchase order price. Positive values indicate the invoice price exceeds PO price; negative values indicate invoice price is lower.',
    `purchase_order_number` STRING COMMENT 'The purchase order number against which this invoice is being verified. Used for three-way match (PO-GR-Invoice) validation.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'The difference between the invoiced quantity and the goods receipt quantity. Used to identify over-billing or under-billing situations.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount included in the invoice. May include VAT, sales tax, withholding tax, or other applicable taxes.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match validation comparing purchase order, goods receipt, and invoice. Matched indicates all three documents agree within tolerance; variances indicate discrepancies requiring resolution.. Valid values are `matched|price_variance|quantity_variance|not_applicable|pending`',
    `vendor_reference` STRING COMMENT 'Additional reference information provided by the vendor, such as their internal order number, delivery note number, or contract reference.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax deducted from the vendor payment. This amount is remitted to tax authorities on behalf of the vendor.',
    `withholding_tax_code` STRING COMMENT 'Code representing the withholding tax type and rate applied to this invoice. Required for tax compliance in jurisdictions with withholding tax requirements.',
    `created_by` STRING COMMENT 'The user ID of the person who created or entered the invoice record in the system. Used for audit trail and accountability.',
    CONSTRAINT pk_accounts_payable PRIMARY KEY(`accounts_payable_id`)
) COMMENT 'SAP FI-AP vendor invoice and payable transaction record — captures supplier invoices received for raw materials, reagent components, CRO/CMO services, instrument parts, and third-party bioinformatics tools. Tracks invoice amount, due date, payment terms, withholding tax, GR/IR clearing status, and payment block. Supports three-way match (PO–GR–Invoice) and cash flow forecasting.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` (
    `accounts_receivable_id` BIGINT COMMENT 'Unique identifier for the accounts receivable transaction record. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer entity (research institution, clinical lab, biopharma partner, or agricultural genomics customer) who owes this receivable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Link receivable to cost center for accurate cost tracking.',
    `header_id` BIGINT COMMENT 'Reference to the originating sales order that generated this receivable (instrument sale, reagent kit order, sequencing service, clinical assay).',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: AR is created from closed-won opportunities upon invoicing. Critical for order-to-cash reconciliation, DSO analysis by deal type, and sales-to-collections pipeline tracking. Standard in genomics for l',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Link receivable to profit center for profitability reporting.',
    `reagent_subscription_id` BIGINT COMMENT 'Foreign key linking to commercial.reagent_subscription. Business justification: Subscription billing creates recurring AR invoices. Essential for subscription revenue recognition, collections management, and churn analysis. Critical in genomics for reagent rental and consumables ',
    `aging_bucket` STRING COMMENT 'Classification of receivable age for aging analysis (current, 1-30 days, 31-60 days, 61-90 days, over 90 days past due).. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `ar_status` STRING COMMENT 'Current lifecycle status of the receivable indicating whether it is open, partially paid, fully cleared, overdue, written off, or under dispute.. Valid values are `open|partially_paid|cleared|overdue|written_off|disputed`',
    `billing_block_code` STRING COMMENT 'Code indicating if billing is blocked for this receivable pending resolution of credit hold, compliance check, or other business rule.',
    `clearing_date` DATE COMMENT 'The date the receivable was fully cleared through payment or other settlement mechanism. Null if still open.',
    `collection_agency` STRING COMMENT 'Name of the third-party collection agency to which this overdue receivable has been assigned for recovery, if applicable.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity that owns this receivable for financial consolidation and reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `created_by_user` STRING COMMENT 'User ID or username of the person who created this receivable record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this accounts receivable record was first created in the system.',
    `credit_memo_reference` STRING COMMENT 'Reference number of any credit memo issued against this invoice for returns, adjustments, or billing corrections.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction (USD, EUR, GBP, JPY, etc.).. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Business segment classification of the customer for this receivable (research institution, clinical lab, biopharma partner, agricultural genomics, government, academic).. Valid values are `research_institution|clinical_lab|biopharma_partner|agricultural_genomics|government|academic`',
    `days_sales_outstanding` STRING COMMENT 'Number of days this receivable has been outstanding since invoice date. Key metric for cash flow and working capital management.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Cash discount or early payment discount amount offered to the customer if payment is received within discount terms.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator whether this receivable is currently under dispute by the customer (True=disputed, False=not disputed).',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason the customer is disputing this receivable (pricing error, quality issue, delivery problem, etc.).',
    `distribution_channel` STRING COMMENT 'SAP distribution channel code indicating how the product or service was sold (direct, distributor, OEM, online).. Valid values are `^[A-Z0-9]{2}$`',
    `document_type` STRING COMMENT 'Classification of the accounts receivable document type (invoice, credit memo, debit memo, payment on account, down payment request).. Valid values are `invoice|credit_memo|debit_memo|payment_on_account|down_payment`',
    `due_date` DATE COMMENT 'The date by which payment is contractually due from the customer based on agreed payment terms.',
    `dunning_level` STRING COMMENT 'Current dunning escalation level for overdue receivables (0=no dunning, 1=first reminder, 2=second reminder, 3=final notice, 4=collections).',
    `gl_account` STRING COMMENT 'General ledger account number to which this receivable is posted in the chart of accounts.. Valid values are `^[0-9]{6,10}$`',
    `invoice_amount` DECIMAL(18,2) COMMENT 'The gross invoice amount billed to the customer before any adjustments, discounts, or payments.',
    `invoice_date` DATE COMMENT 'The date the invoice was issued to the customer. Principal business event timestamp for this receivable transaction.',
    `invoice_number` STRING COMMENT 'The externally-known invoice document number issued to the customer for this receivable. Unique business identifier for the billing document.. Valid values are `^[A-Z0-9]{8,20}$`',
    `last_dunning_date` DATE COMMENT 'The date the most recent dunning notice or payment reminder was sent to the customer.',
    `modified_by_user` STRING COMMENT 'User ID or username of the person who last modified this receivable record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this accounts receivable record was last modified or updated.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net receivable amount after applying all adjustments, discounts, and credits. The amount the customer owes.',
    `outstanding_amount` DECIMAL(18,2) COMMENT 'Current outstanding balance remaining unpaid on this receivable. Equals net amount minus payments received.',
    `payment_method` STRING COMMENT 'The payment instrument or method expected or used by the customer (wire transfer, ACH, check, credit card, letter of credit, cash).. Valid values are `wire_transfer|ach|check|credit_card|letter_of_credit|cash`',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms agreed with the customer (e.g., Net 30, Net 60, 2/10 Net 30).. Valid values are `^[A-Z0-9]{2,10}$`',
    `posting_date` DATE COMMENT 'The date the receivable transaction was posted to the general ledger and accounts receivable subledger.',
    `reference_document` STRING COMMENT 'External reference document number such as customer purchase order number, contract number, or delivery note associated with this receivable.',
    `revenue_type` STRING COMMENT 'Classification of the revenue stream this receivable represents (instrument sales, reagent kits, sequencing services, clinical assay fees, consumables, software licenses, maintenance contracts). [ENUM-REF-CANDIDATE: instrument_sales|reagent_kits|sequencing_services|clinical_assay_fees|consumables|software_licenses|maintenance_contracts — 7 candidates stripped; promote to reference product]',
    `sales_organization` STRING COMMENT 'SAP sales organization code responsible for this receivable transaction (regional or product-line based).. Valid values are `^[A-Z0-9]{4}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount included in the invoice (sales tax, VAT, GST) based on customer jurisdiction and product taxability.',
    `write_off_date` DATE COMMENT 'The date this receivable was written off as bad debt. Null if not written off.',
    `write_off_flag` BOOLEAN COMMENT 'Boolean indicator whether this receivable has been written off as uncollectible bad debt (True=written off, False=active).',
    CONSTRAINT pk_accounts_receivable PRIMARY KEY(`accounts_receivable_id`)
) COMMENT 'SAP FI-AR customer receivable transaction record — captures open and cleared receivables from research institutions, clinical labs, biopharma partners, and agricultural genomics customers for instrument sales, reagent kit orders, sequencing services, and clinical assay fees. Tracks invoice amount, due date, payment terms, dunning level, credit memo status, and DSO contribution.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction record in SAP FI. Primary key for the payment entity.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Payments clear AP invoices. payment.invoice_reference_number (STRING) should be replaced with a proper FK to accounts_payable. This enables direct navigation from payment to the AP invoice being clear',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Payments clear AR invoices (customer payments). This FK links payment to the specific AR invoice being cleared. Distinct from payment.account_id (which references the customer entity cross-domain). Th',
    `approver_employee_id` BIGINT COMMENT 'Reference to the employee who authorized the payment for processing. Required for SOX segregation of duties and payment authorization audit trail.',
    `channel_partner_id` BIGINT COMMENT 'Foreign key linking to commercial.channel_partner. Business justification: Partner commission and rebate payments processed through AP/payment systems. Critical for partner incentive management, accrual reconciliation, and channel program financial tracking. Standard in geno',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Replace cost_center_code with FK to cost_center for payment cost allocation.',
    `employee_id` BIGINT COMMENT 'SAP user ID of the person who created the payment document. Part of the audit trail for SOX compliance and segregation of duties verification.. Valid values are `^[A-Z0-9]{8,12}$`',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Payments create journal entries that post cash movements and clear payables/receivables (debit AP/AR, credit cash for vendor payments; debit cash, credit AR for customer payments). payment.clearing_do',
    `modified_by_user_employee_id` BIGINT COMMENT 'SAP user ID of the person who last modified the payment document. Required for SOX change tracking and audit trail completeness.. Valid values are `^[A-Z0-9]{8,12}$`',
    `account_id` BIGINT COMMENT 'Reference to the customer master record making the incoming payment. Includes research institutions, clinical laboratories, and biopharma partners purchasing sequencing services or instruments.',
    `payment_bank_account_id` BIGINT COMMENT 'Reference to the house bank account used for the payment transaction. Links to bank master data containing account number, routing information, and bank details.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Replace profit_center_code with FK to profit_center for payment profitability analysis.',
    `supplier_id` BIGINT COMMENT 'Reference to the vendor master record receiving the outgoing payment. Includes reagent suppliers, contract research organizations (CROs), contract manufacturing organizations (CMOs), and instrument component vendors.',
    `amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the payment transaction in the payment currency. Represents the total amount transferred before any bank fees or charges.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was approved by the authorized approver. Part of the SOX-compliant audit trail for payment authorization workflow.',
    `bank_charges` DECIMAL(18,2) COMMENT 'Bank fees and charges deducted for processing the payment transaction (wire fees, foreign exchange fees, intermediary bank charges). Allocated to treasury cost center.',
    `bank_reference_number` STRING COMMENT 'Unique reference number assigned by the bank for the payment transaction. Used for bank statement reconciliation and payment tracking with financial institutions.. Valid values are `^[A-Z0-9]{10,35}$`',
    `block_code` STRING COMMENT 'Single-character code indicating if payment is blocked for processing (A=blocked for approval, Q=blocked for quality issue, blank=not blocked). Supports SOX segregation of duties controls.. Valid values are `^[A-Z]{1}$|^$`',
    `block_reason` STRING COMMENT 'Free-text explanation for why the payment is blocked. Examples: pending invoice verification, disputed amount, missing receiving documentation, compliance hold.',
    `clearing_date` DATE COMMENT 'Date when the payment cleared the bank and was reconciled against the bank statement. Used for bank reconciliation and cash management reporting.',
    `company_code` STRING COMMENT 'Four-character SAP company code representing the legal entity executing the payment. Used for multi-entity financial consolidation and SOX compliance segregation.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the payment record was first created in SAP FI. Used for payment processing turnaround time (TAT) analysis and audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment transaction (USD, EUR, GBP, JPY, CNY). Required for multi-currency treasury management and foreign exchange reporting.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Cash discount amount taken if payment was made within the discount period defined in payment_terms_code. Reduces COGS and improves working capital efficiency.',
    `document_number` STRING COMMENT 'SAP FI payment document number assigned during payment run processing. Externally visible business identifier for the payment transaction.. Valid values are `^[0-9]{10}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert payment_amount to local_amount. Sourced from treasury rate table at value_date for accurate financial reporting and EBITDA calculation.',
    `general_ledger_account` STRING COMMENT 'General ledger account number to which the payment is posted. Determines financial statement line item classification (cash, accounts payable, expense) for SOX-compliant reporting.. Valid values are `^[0-9]{6,10}$`',
    `local_amount` DECIMAL(18,2) COMMENT 'Payment amount converted to the company code local currency for financial consolidation and P&L reporting. Used when payment_currency differs from company_code base currency.',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the company code local currency. Typically USD for US entities, EUR for European entities.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the payment record was last modified. Tracks payment status changes, amount adjustments, and reprocessing for audit and compliance purposes.',
    `partial_payment_flag` BOOLEAN COMMENT 'Indicates whether this payment represents a partial settlement of the invoice (True) or full settlement (False). Used for open item management and aging analysis.',
    `payment_date` DATE COMMENT 'The date the payment transaction was executed or posted in the financial system. Used for cash flow reporting and financial period closing.',
    `payment_method` STRING COMMENT 'Payment instrument used to execute the transaction (wire transfer for international suppliers, ACH for domestic vendors, check for small suppliers, credit card for travel expenses, direct debit for recurring charges).. Valid values are `wire_transfer|ach|check|credit_card|direct_debit|paypal`',
    `payment_run_number` STRING COMMENT 'Identifier for the automated payment run batch that generated this payment. Used for grouping payments processed together and tracking payment proposal execution.. Valid values are `^PR[0-9]{8}$`',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction in the payment processing workflow. Supports SOX payment authorization controls and audit trail requirements. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|sent|cleared|reconciled|failed|cancelled — 8 candidates stripped; promote to reference product]',
    `payment_type` STRING COMMENT 'Classification of payment direction and counterparty type. Outgoing vendor payments include reagent suppliers, CROs, CMOs, instrument component vendors. Incoming customer payments include research institutions, clinical labs, biopharma partners.. Valid values are `outgoing_vendor|incoming_customer|intercompany|employee_reimbursement|tax_payment|refund`',
    `reconciliation_status` STRING COMMENT 'Bank statement reconciliation status indicating whether the payment has been matched to a bank statement line item. Critical for cash management and SOX cash reconciliation controls.. Valid values are `not_reconciled|reconciled|exception|under_review`',
    `reference_text` STRING COMMENT 'Free-text field for additional payment details, remittance information, or special instructions. Appears on bank transfer and vendor remittance advice.',
    `terms_code` STRING COMMENT 'SAP payment terms code defining the due date calculation and discount conditions (e.g., Net 30, 2/10 Net 30). Drives automatic payment proposal and cash discount capture.. Valid values are `^[A-Z0-9]{4}$`',
    `value_date` DATE COMMENT 'The effective date when funds are debited or credited for interest calculation and cash position management. May differ from payment_date for bank processing timing.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount withheld from the payment per local tax regulations and remitted directly to tax authorities. Common for cross-border payments and contractor payments.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Financial payment transaction record in SAP FI — captures outgoing vendor payments (reagent suppliers, CROs, CMOs, instrument component vendors) and incoming customer payments (research institutions, clinical labs, biopharma partners). Records payment method, bank account, clearing document, payment run ID, value date, exchange rate, partial payment status, and bank reconciliation reference. Supports cash management, bank statement reconciliation, cash flow reporting, and SOX payment authorization controls.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` (
    `revenue_recognition_id` BIGINT COMMENT 'Unique identifier for the revenue recognition record. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer entity to whom the goods or services were delivered and for whom revenue is being recognized.',
    `contract_id` BIGINT COMMENT 'Reference to the master commercial contract or customer agreement governing this revenue recognition event.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Replace cost_center_code with FK to cost_center for revenue recognition cost tracking.',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or account manager responsible for this revenue-generating transaction, used for commission calculation and sales performance tracking.',
    `header_id` BIGINT COMMENT 'Reference to the sales order or transaction that triggered this revenue recognition event.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Revenue recognition events create journal entries that post revenue (debit deferred revenue, credit revenue; or debit AR, credit revenue). This FK links the revenue recognition schedule/event to its a',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: Revenue is recognized from closed opportunities per ASC 606. Critical for revenue waterfall reporting (pipeline → bookings → revenue), sales effectiveness analysis, and forecast accuracy. Standard pra',
    `original_recognition_revenue_recognition_id` BIGINT COMMENT 'For reversal or adjustment records, references the revenue_recognition_id of the original recognition event being corrected. Null for original recognition events.',
    `performance_obligation_id` BIGINT COMMENT 'Reference to the specific performance obligation within the contract that this revenue recognition event satisfies.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Replace profit_center_code with FK to profit_center for revenue recognition profitability analysis.',
    `sku_id` BIGINT COMMENT 'Reference to the product or service (instrument, reagent kit, sequencing service, assay license) for which revenue is being recognized.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The portion of the transaction price allocated to this specific performance obligation using the standalone selling price method per ASC 606 Step 4.',
    `audit_trail_reference` STRING COMMENT 'Unique reference number linking this revenue recognition event to supporting documentation (contracts, delivery confirmations, acceptance certificates) for audit and compliance purposes.. Valid values are `^[A-Z0-9-]{10,30}$`',
    `business_unit` STRING COMMENT 'The business unit or division responsible for this revenue stream, used for segment reporting and multi-entity P&L consolidation.. Valid values are `^[A-Z0-9]{2,6}$`',
    `cogs_amount` DECIMAL(18,2) COMMENT 'The cost of goods sold associated with this revenue recognition event, used for gross margin calculation and profitability analysis. Sourced from SAP CO product costing.',
    `commission_eligible_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition event is eligible for sales commission calculation (True) or excluded from commission (False), based on company commission policy.',
    `contract_end_date` DATE COMMENT 'The effective end date of the contract or performance obligation period, used for over-time revenue recognition calculations and deferred revenue amortization schedules.',
    `contract_start_date` DATE COMMENT 'The effective start date of the contract or performance obligation period, used for over-time revenue recognition calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this revenue recognition record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this revenue recognition record (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `deferred_amount` DECIMAL(18,2) COMMENT 'The remaining unearned revenue balance that has been invoiced but not yet recognized, representing future performance obligations. Calculated as allocated_amount minus recognized_amount.',
    `fulfillment_date` DATE COMMENT 'The date on which the performance obligation was fulfilled (goods delivered, service completed, milestone achieved), triggering the revenue recognition event.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this revenue recognition event is posted in the financial system.. Valid values are `^[0-9]{6,10}$`',
    `gross_margin` DECIMAL(18,2) COMMENT 'The gross profit margin for this revenue recognition event, calculated as recognized_amount minus cogs_amount. Used for profitability analysis and pricing strategy evaluation.',
    `invoice_date` DATE COMMENT 'The date the customer invoice was issued. May differ from recognition_date if revenue is deferred or recognized over time.',
    `invoice_number` STRING COMMENT 'The unique invoice number issued to the customer for this transaction, linking the revenue recognition event to the billing document.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `modification_date` DATE COMMENT 'The date on which a contract modification was executed that affected this revenue recognition event. Null if modification_flag is False.',
    `modification_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition event resulted from a contract modification (True) or is part of the original contract terms (False). Contract modifications require re-evaluation of performance obligations and transaction price allocation per ASC 606.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this revenue recognition record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional context, explanations, or special circumstances related to this revenue recognition event. Used for audit documentation and business user annotations.',
    `percentage_complete` DECIMAL(18,2) COMMENT 'For over-time revenue recognition, the percentage of the performance obligation that has been satisfied as of the recognition date. Used to calculate recognized_amount. Range: 0.00 to 100.00.',
    `recognition_date` DATE COMMENT 'The accounting date on which revenue was recognized and posted to the general ledger. This is the date the performance obligation was satisfied per ASC 606.',
    `recognition_method` STRING COMMENT 'The method by which revenue is recognized: point in time (upon delivery), over time (ratable recognition), milestone-based (upon achievement of contract milestones), usage-based (per unit consumed), or subscription ratable (monthly/quarterly allocation).. Valid values are `point_in_time|over_time|milestone_based|usage_based|subscription_ratable`',
    `recognition_period` STRING COMMENT 'The fiscal period (YYYY-MM format) in which this revenue was recognized, used for period-based financial reporting and consolidation.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `recognition_status` STRING COMMENT 'Current lifecycle status of the revenue recognition event: pending (awaiting fulfillment), recognized (posted to GL), deferred (not yet earned), partially recognized (multi-period recognition in progress), reversed (corrected), or adjusted (modified post-recognition).. Valid values are `pending|recognized|deferred|partially_recognized|reversed|adjusted`',
    `recognized_amount` DECIMAL(18,2) COMMENT 'The amount of revenue recognized in the current accounting period for this performance obligation. For point-in-time recognition, equals allocated_amount; for over-time recognition, represents the period-specific portion.',
    `revenue_category` STRING COMMENT 'Business category of the revenue: instrument sales, reagent kits, consumables, sequencing services, bioinformatics services, clinical assay licensing, support contracts, training, or other. [ENUM-REF-CANDIDATE: instrument|reagent|consumable|sequencing_service|bioinformatics_service|clinical_assay|support_contract|training|other — 9 candidates stripped; promote to reference product]',
    `revenue_stream` STRING COMMENT 'High-level revenue stream classification for strategic reporting: core product sales, aftermarket (consumables/reagents), service revenue, subscription revenue, licensing/royalties, or other.. Valid values are `core_product|aftermarket|service|subscription|licensing|other`',
    `revenue_type` STRING COMMENT 'Classification of the revenue stream: product sale (instruments, arrays), service revenue (sequencing services), subscription revenue (reagent kits), license fee (assay licensing), royalty, maintenance contract, or consumable sale. [ENUM-REF-CANDIDATE: product_sale|service_revenue|subscription_revenue|license_fee|royalty|maintenance_contract|consumable_sale — 7 candidates stripped; promote to reference product]',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this record represents a reversal (True) of previously recognized revenue due to returns, cancellations, or corrections. False for original recognition events.',
    `reversal_reason` STRING COMMENT 'The business reason for revenue reversal: customer return, contract cancellation, pricing adjustment, billing error, performance failure, or other. Populated only when reversal_flag is True.. Valid values are `customer_return|contract_cancellation|pricing_adjustment|billing_error|performance_failure|other`',
    `sales_region` STRING COMMENT 'Three-letter geographic region code where the revenue was generated (e.g., USA, EUR, CHN, JPN), used for regional revenue analysis and geographic segment reporting.. Valid values are `^[A-Z]{3}$`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition event is subject to SOX internal controls and audit requirements (True) based on materiality thresholds and risk assessment. False for immaterial transactions.',
    `transaction_price` DECIMAL(18,2) COMMENT 'The total transaction price allocated to this performance obligation per ASC 606 Step 3, representing the amount of consideration the entity expects to receive in exchange for transferring goods or services.',
    CONSTRAINT pk_revenue_recognition PRIMARY KEY(`revenue_recognition_id`)
) COMMENT 'Revenue recognition schedule and event record for Genomics Biotech commercial transactions — manages ASC 606 / IFRS 15 compliant revenue recognition for multi-element arrangements including instrument sales with service contracts, reagent kit subscriptions, sequencing service agreements, and clinical assay licensing. Tracks performance obligation fulfillment, deferred revenue balance, recognized amount per period, and contract modification events.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` (
    `finance_budget_id` BIGINT COMMENT 'Unique identifier for the budget record. Primary key for the finance budget entity.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to commercial.campaign. Business justification: Campaign budgets are formal finance budget line items requiring approval and variance tracking. Critical for marketing budget planning, quarterly forecasting, and spend control. Genomics companies man',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which this budget is allocated. Cost centers represent organizational units that incur costs (e.g., R&D sequencing lab, manufacturing reagent production, clinical validation).',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Budget ownership requires employee linkage for accountability in variance analysis, budget transfer approval authority, and organizational change impact (when budget owner changes roles). Critical for',
    `profit_center_id` BIGINT COMMENT 'Reference to the profit center responsible for this budget. Profit centers represent business segments that generate revenue and incur costs (e.g., NGS instruments, array products, CRISPR tools).',
    `project_id` BIGINT COMMENT 'Reference to the project or program to which this budget is allocated. Enables project-level budget tracking for R&D initiatives (e.g., NGS pipeline development, CRISPR construct optimization), CAPEX projects (e.g., new instrument line installation), or clinical validation studies.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to commercial.territory. Business justification: Territory quotas have corresponding budget allocations for headcount, travel, and sales support. Essential for sales capacity planning, territory ROI analysis, and quota-to-budget alignment. Standard ',
    `actual_amount` DECIMAL(18,2) COMMENT 'The actual spend or revenue posted to the general ledger for this budget line as of the reporting date. Used for budget-vs-actuals variance analysis and performance tracking.',
    `amount` DECIMAL(18,2) COMMENT 'The planned budget amount for this cost center, profit center, GL account, and fiscal period combination. Represents the financial target or allocation in the base currency.',
    `approval_status` STRING COMMENT 'The current approval state of this budget record. Draft (in preparation), pending approval (submitted for review), approved (finalized and active), rejected (not accepted), or locked (approved and frozen for the period).. Valid values are `draft|pending_approval|approved|rejected|locked`',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved this budget record. Supports audit trail and accountability for financial planning decisions.',
    `approved_date` DATE COMMENT 'The date on which this budget record was approved. Establishes the baseline date for budget-vs-actuals variance tracking.',
    `available_budget` DECIMAL(18,2) COMMENT 'The remaining available budget calculated as budget_amount minus commitment_amount minus actual_amount. Indicates the unencumbered budget available for future spending.',
    `budget_category` STRING COMMENT 'The detailed budget category or sub-classification (e.g., salaries, reagent materials, instrument depreciation, travel, consulting, software licenses). Provides granular budget segmentation for detailed variance analysis.',
    `budget_type` STRING COMMENT 'The category of budget. OPEX (operating expenses such as reagent production, clinical validation), CAPEX (capital expenditures such as instrument lines, HPC infrastructure), R&D (research and development for NGS pipelines, CRISPR programs), headcount (FTE planning), or revenue (sales targets).. Valid values are `opex|capex|r_and_d|headcount|revenue`',
    `business_unit` STRING COMMENT 'The business unit or product line to which this budget is assigned (e.g., Sequencing Instruments, Array Products, Gene Editing Tools, Bioinformatics Software). Enables business-unit-level financial planning and EBITDA tracking.',
    `capitalization_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether this R&D budget is eligible for capitalization under accounting standards (e.g., software development costs, patent filing costs). Supports R&D capitalization tracking per GAAP/IFRS.',
    `commitment_amount` DECIMAL(18,2) COMMENT 'The amount of budget that has been committed through purchase orders or contracts but not yet invoiced. Supports commitment tracking and available budget calculation (budget - commitment - actuals).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was first created in the system. Establishes the initial entry date for audit and lifecycle tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the budget amount (e.g., USD, EUR, GBP). Supports multi-currency budget planning for global operations.. Valid values are `^[A-Z]{3}$`',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year (1-12). Enables monthly budget granularity for rolling forecasts and variance analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget applies (e.g., 2024, 2025). Represents the annual planning cycle.',
    `forecast_amount` DECIMAL(18,2) COMMENT 'The latest forecast estimate for this budget line. Updated periodically (monthly or quarterly) to reflect current business expectations. Used for budget-vs-forecast gap analysis.',
    `forecast_horizon` STRING COMMENT 'The time horizon for this forecast. Monthly (rolling 12-month forecast), quarterly (rolling 4-quarter forecast), annual (single-year plan), or multi-year (strategic 3-5 year plan).. Valid values are `monthly|quarterly|annual|multi_year`',
    `functional_area` STRING COMMENT 'The functional area or business division to which this budget belongs (e.g., Research and Development, Manufacturing, Clinical Operations, Sales and Marketing, General and Administrative). Supports functional P&L reporting.',
    `geography` STRING COMMENT 'The geographic region or country to which this budget applies (e.g., North America, EMEA, APAC, USA, DEU, CHN). Enables regional budget planning and performance tracking.',
    `headcount_fte` DECIMAL(18,2) COMMENT 'The planned headcount in full-time equivalents for this budget line. Used for workforce planning and labor cost budgeting. Supports FTE-based budget allocation for R&D teams, manufacturing staff, and clinical operations.',
    `is_capital_expenditure` BOOLEAN COMMENT 'Boolean flag indicating whether this budget line represents a capital expenditure (true) or an operating expense (false). CAPEX includes long-term assets such as instrument manufacturing lines, HPC infrastructure, and facility improvements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget record was last modified. Supports audit trail and change tracking for budget revisions and forecast updates.',
    `legal_entity` STRING COMMENT 'The legal entity or subsidiary to which this budget belongs. Supports multi-entity financial consolidation and statutory reporting requirements.',
    `notes` STRING COMMENT 'Free-text notes or comments about this budget record. Used to document assumptions, justifications, or special considerations (e.g., one-time CAPEX for new HPC cluster, increased R&D spend for CRISPR program acceleration).',
    `planning_scenario` STRING COMMENT 'The planning scenario or sensitivity case for this budget record. Base case (most likely), best case (optimistic), worst case (conservative), or stretch target (aspirational). Supports scenario planning and risk analysis.. Valid values are `base_case|best_case|worst_case|stretch_target`',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this budget record is subject to SOX internal controls and audit requirements. Typically true for material budget lines that impact financial statements.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The calculated variance between budget and forecast (forecast_amount - budget_amount). Positive values indicate forecast exceeds budget; negative values indicate forecast is below budget. Supports variance analysis reporting.',
    `version` STRING COMMENT 'The version of the budget record. Tracks whether this is the approved baseline, the latest forecast estimate, a prior estimate, the original plan, or a revised plan. Enables comparison across planning cycles.. Valid values are `approved|latest_estimate|prior_estimate|original|revised`',
    `wbs_element` STRING COMMENT 'The work breakdown structure element code for project-based budgets. Provides hierarchical project structure for detailed budget allocation and tracking within large R&D or CAPEX programs.',
    CONSTRAINT pk_finance_budget PRIMARY KEY(`finance_budget_id`)
) COMMENT 'Financial planning master for Genomics Biotech — captures approved annual/multi-year budgets and rolling forecasts by cost center, profit center, GL account, and fiscal period. Supports R&D budget planning (NGS pipeline, CRISPR programs), CAPEX budgets (instrument lines, HPC), OPEX budgets (reagent production, clinical validation), and headcount planning. Tracks budget/forecast version (approved, latest estimate, prior estimate), approval status, forecast horizon, and budget owner. Enables budget-vs-actuals variance analysis at any granularity (cost center, project, GL account), forecast-to-budget gap tracking, and EBITDA bridge reporting for quarterly business reviews. Serves as the authoritative source for all financial planning targets against which actual GL postings are compared.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`internal_order` (
    `internal_order_id` BIGINT COMMENT 'Unique identifier for the SAP CO internal order. Primary key for tracking project-specific costs, R&D programs, and capital investments.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to commercial.campaign. Business justification: Large campaigns (conferences, product launches) often have dedicated internal orders for cost collection and settlement. Enables campaign cost capitalization decisions, multi-period cost tracking, and',
    `capex_request_id` BIGINT COMMENT 'Foreign key linking to finance.capex_request. Business justification: Internal orders are often created to track execution of approved CAPEX requests. This FK links the internal order (cost tracking object) to the originating CAPEX request (approval/budget object), enab',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Internal orders for R&D projects track costs against products under development. Project accounting in genomics requires linking development costs to target products for capitalization decisions and p',
    `conference_event_id` BIGINT COMMENT 'Foreign key linking to commercial.conference_event. Business justification: Conference participation tracked via internal orders for cost collection and settlement. Enables event cost capitalization decisions, multi-period cost tracking, and event ROI analysis. Standard in ge',
    `fixed_asset_id` BIGINT COMMENT 'Identifier of the asset under construction to which capitalized costs from this internal order are settled. Used for capital investment projects that will result in fixed assets.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for managing this internal order. Accountable for budget adherence, deliverable completion, and cost control.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center responsible for managing and executing this internal order. Links to the organizational unit accountable for budget and deliverables.',
    `primary_internal_technical_lead_employee_id` BIGINT COMMENT 'Identifier of the employee serving as technical lead for this internal order. Responsible for technical execution and quality of deliverables.',
    `profit_center_id` BIGINT COMMENT 'Identifier of the profit center to which costs and revenues from this internal order are allocated. Used for internal P&L reporting and profitability analysis.',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element to which this internal order is assigned. Links internal order costs to specific project phases or deliverables in SAP PS.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Total actual costs posted to this internal order to date. Includes direct costs, allocations, and internal activity charges.',
    `actual_end_date` DATE COMMENT 'Actual date when work was completed on this internal order. Recorded when the order is set to technically complete status.',
    `actual_start_date` DATE COMMENT 'Actual date when work commenced on this internal order. Recorded when the first cost posting or activity confirmation is made.',
    `budget_profile` STRING COMMENT 'SAP CO budget profile code defining budget control parameters: tolerance limits, availability checks, and budget release procedures for this internal order.. Valid values are `^[A-Z0-9]{6}$`',
    `business_area` STRING COMMENT 'SAP business area code for cross-company code reporting and segment analysis. Used to track profitability by product line or business segment.. Valid values are `^[A-Z0-9]{4}$`',
    `capitalization_eligible_flag` BOOLEAN COMMENT 'Indicates whether costs incurred on this internal order are eligible for capitalization under ASC 730 (R&D) or IAS 38 (Intangible Assets). True for development-phase projects meeting capitalization criteria; false for research-phase or expense-only projects.',
    `committed_cost_amount` DECIMAL(18,2) COMMENT 'Total committed costs from purchase requisitions and purchase orders assigned to this internal order. Represents future obligations not yet invoiced.',
    `company_code` STRING COMMENT 'SAP FI company code representing the legal entity to which this internal order belongs. Used for financial consolidation and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area` STRING COMMENT 'SAP CO controlling area code representing the organizational unit for cost accounting. May span multiple company codes for consolidated management reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `created_by_user` STRING COMMENT 'SAP user ID of the person who created this internal order record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this internal order record was created in SAP CO. Recorded in ISO 8601 format with timezone.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this internal order. Typically matches the company code currency.. Valid values are `^[A-Z]{3}$`',
    `current_budget_amount` DECIMAL(18,2) COMMENT 'Current approved budget amount including all supplements, returns, and transfers. Represents the total available funding for cost postings.',
    `functional_area` STRING COMMENT 'High-level functional classification of the internal order for financial statement reporting. Aligns costs to R&D, manufacturing, sales/marketing, or general administration for GAAP/IFRS compliance.. Valid values are `research_development|manufacturing|sales_marketing|general_administration`',
    `gxp_relevant_flag` BOOLEAN COMMENT 'Indicates whether this internal order is subject to GxP regulations (GMP, GLP, GCP). True for manufacturing, laboratory, or clinical projects requiring validated processes and audit trails.',
    `last_modified_by_user` STRING COMMENT 'SAP user ID of the person who last modified this internal order record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this internal order record was last modified in SAP CO. Recorded in ISO 8601 format with timezone.',
    `long_description` STRING COMMENT 'Detailed description of the internal order purpose, scope, and objectives. Used for comprehensive project documentation and audit trails.',
    `order_category` STRING COMMENT 'Business category of the internal order defining the nature of cost tracking: R&D programs, capital investments, overhead allocation, marketing campaigns, quality initiatives, or manufacturing projects.. Valid values are `research_development|capital_investment|overhead|marketing_campaign|quality_project|manufacturing_project`',
    `order_number` STRING COMMENT 'Business-facing internal order number used in SAP CO for cost tracking and reporting. Externally visible identifier for projects, R&D programs, or capital investments.. Valid values are `^[A-Z0-9]{8,12}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the internal order. Created orders are in draft; released orders accept cost postings; technically complete orders are finished but not yet settled; closed orders are fully settled and archived; locked orders cannot accept new postings.. Valid values are `created|released|technically_complete|closed|locked`',
    `order_type` STRING COMMENT 'Classification of internal order as real (actual cost posting) or statistical (informational tracking only). Real orders allow direct cost postings; statistical orders are used for parallel cost tracking.. Valid values are `real|statistical`',
    `original_budget_amount` DECIMAL(18,2) COMMENT 'Initial approved budget amount for this internal order in the company code currency. Represents the baseline funding allocation before any supplements or returns.',
    `planning_end_date` DATE COMMENT 'Planned completion date for this internal order. Used for project scheduling, milestone tracking, and settlement planning.',
    `planning_start_date` DATE COMMENT 'Planned start date for work on this internal order. Used for project scheduling and resource planning.',
    `priority` STRING COMMENT 'Business priority level for this internal order. Used for resource allocation decisions and budget approval workflows.. Valid values are `critical|high|medium|low`',
    `regulatory_program_flag` BOOLEAN COMMENT 'Indicates whether this internal order supports a regulatory submission or compliance program requiring FDA, EMA, or other regulatory body approval. True for IVD validation studies, clinical assay development, or GxP facility upgrades.',
    `settlement_profile` STRING COMMENT 'SAP CO settlement profile code defining the rules for allocating internal order costs to receiving cost objects (cost centers, assets, G/L accounts) at period-end.. Valid values are `^[A-Z0-9]{6}$`',
    `settlement_rule` STRING COMMENT 'Detailed settlement rule specification defining target cost objects, allocation percentages, and settlement types for distributing internal order costs.',
    `short_description` STRING COMMENT 'Brief descriptive name of the internal order, typically 40 characters or less, used for quick identification in reports and transaction screens.',
    `sox_relevant_flag` BOOLEAN COMMENT 'Indicates whether this internal order is subject to SOX financial controls and audit requirements. True for orders involving capitalized R&D, fixed asset construction, or material financial statement impacts.',
    CONSTRAINT pk_internal_order PRIMARY KEY(`internal_order_id`)
) COMMENT 'SAP CO internal order master used to track costs for specific projects, R&D programs, or capital investments within Genomics Biotech — e.g., CRISPR tool development programs, clinical assay validation projects, instrument engineering initiatives, GMP facility upgrades. Captures order type (real/statistical), settlement rule, budget, actual costs, and capitalization eligibility for R&D capitalization under ASC 730 / IAS 38.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier for the fixed asset record in SAP FI-AA. Primary key for the fixed asset master data.',
    `capex_request_id` BIGINT COMMENT 'Foreign key linking to finance.capex_request. Business justification: Fixed assets are acquired based on approved CAPEX requests. This FK links the asset back to its originating capital expenditure request, enabling tracking of request-to-asset lifecycle and comparing a',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Manufacturing equipment and instruments are often dedicated to specific product lines (e.g., NovaSeq for sequencing products). Asset utilization analysis, depreciation allocation, and capacity plannin',
    `cost_center_id` BIGINT COMMENT 'Cost center to which the asset is assigned. Depreciation expense is posted to this cost center for internal cost allocation and P&L reporting.',
    `employee_id` BIGINT COMMENT 'Employee assigned as the custodian or responsible party for the asset. Used for accountability and asset audit trails.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date since acquisition. Subtracted from acquisition cost to calculate net book value.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase price or capitalized cost of the fixed asset including installation, freight, and other capitalizable costs. Basis for depreciation calculation.',
    `acquisition_date` DATE COMMENT 'Date when the asset was acquired or placed in service. Used as the starting point for depreciation calculations.',
    `annual_depreciation_amount` DECIMAL(18,2) COMMENT 'Calculated annual depreciation expense for the asset based on depreciation method and useful life. Used for budgeting and P&L forecasting.',
    `asset_class` STRING COMMENT 'Classification of the fixed asset type for accounting and depreciation purposes. Determines depreciation method and useful life defaults. [ENUM-REF-CANDIDATE: sequencing_instrument|array_scanner|hpc_infrastructure|gmp_manufacturing_equipment|laboratory_automation|leasehold_improvement|office_equipment|vehicle — 8 candidates stripped; promote to reference product]',
    `asset_description` STRING COMMENT 'Detailed description of the fixed asset including model, specifications, and configuration details.',
    `asset_location` STRING COMMENT 'Physical location of the asset (e.g., building, room, facility site). Critical for asset audits, SOX compliance, and insurance purposes.',
    `asset_main_number` STRING COMMENT 'SAP FI-AA main asset number for parent asset when this record represents a sub-asset or component. Used for hierarchical asset reporting.',
    `asset_name` STRING COMMENT 'Human-readable name or title of the fixed asset (e.g., NovaSeq 6000 Sequencer Unit 3, HPC Cluster Node 12, GMP Clean Room HVAC System).',
    `asset_number` STRING COMMENT 'Externally-known unique asset identifier assigned by SAP FI-AA. Used for asset tracking, reporting, and SOX compliance documentation.. Valid values are `^[A-Z0-9]{8,12}$`',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset. Determines whether depreciation is active and whether the asset is included in net book value calculations.. Valid values are `in_service|under_construction|retired|disposed|transferred|impaired`',
    `asset_subnumber` STRING COMMENT 'SAP FI-AA subnumber used to track major components or sub-assets within a parent asset (e.g., flow cells within a sequencer). Enables component-level depreciation.',
    `asset_value_date` DATE COMMENT 'Reference date for asset valuation. Used for revaluation, impairment testing, and fair value reporting under IFRS.',
    `business_area` STRING COMMENT 'Business segment or division to which the asset is allocated (e.g., Sequencing, Arrays, CRISPR, Bioinformatics). Used for segment reporting and EBITDA analysis.',
    `capitalization_date` DATE COMMENT 'Date when the asset was formally capitalized in the general ledger. May differ from acquisition date for assets under construction or R&D projects.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity that owns the asset. Required for multi-entity financial consolidation and SOX reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset record was first created in SAP FI-AA. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts (acquisition cost, depreciation, net book value). Required for multi-currency consolidation.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Accounting method used to allocate the cost of the asset over its useful life. Straight-line is most common for genomics equipment.. Valid values are `straight_line|declining_balance|units_of_production|sum_of_years_digits`',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation posting begins. May differ from acquisition date if asset is under construction or not yet in service.',
    `disposal_date` DATE COMMENT 'Date when the asset was retired, sold, scrapped, or otherwise disposed. Triggers final depreciation calculation and removal from active asset register.',
    `disposal_method` STRING COMMENT 'Method by which the asset was disposed. Determines accounting treatment for gain/loss on disposal and regulatory reporting requirements.. Valid values are `sale|scrap|donation|trade_in|transfer`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Amount received from sale or trade-in of the asset. Used to calculate gain or loss on disposal for P&L reporting.',
    `impairment_amount` DECIMAL(18,2) COMMENT 'Cumulative impairment loss recognized on the asset due to obsolescence, damage, or market value decline. Reduces net book value below depreciated cost.',
    `insurance_policy_number` STRING COMMENT 'Insurance policy covering the asset. Used for risk management and claims processing in case of damage or loss.',
    `investment_order_number` STRING COMMENT 'SAP CO internal order number used to accumulate costs during asset construction or R&D capitalization. Settled to fixed asset upon completion.',
    `is_fully_depreciated` BOOLEAN COMMENT 'Flag indicating whether the asset has been fully depreciated (net book value equals zero or salvage value). Fully depreciated assets may still be in service.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fixed asset record. Used for change tracking and SOX audit trails.',
    `last_physical_inventory_date` DATE COMMENT 'Date of the most recent physical verification of the asset. Required for SOX compliance and internal control testing.',
    `manufacturer` STRING COMMENT 'Name of the equipment manufacturer or vendor (e.g., Illumina, Thermo Fisher, Agilent). Used for vendor management and service contract tracking.',
    `model_number` STRING COMMENT 'Manufacturer model or part number of the asset. Used for spare parts procurement and technical support.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current carrying value of the asset calculated as acquisition cost minus accumulated depreciation. Used for balance sheet reporting and SOX asset controls.',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'Number of years remaining in the assets useful life. Used for forecasting future depreciation expense and asset replacement planning.',
    `serial_number` STRING COMMENT 'Manufacturer serial number or unique equipment identifier. Used for warranty tracking, service contracts, and asset verification during physical audits.',
    `tax_depreciation_method` STRING COMMENT 'Depreciation method used for tax reporting purposes. May differ from book depreciation method to optimize tax deductions.. Valid values are `straight_line|macrs|declining_balance|section_179`',
    `useful_life_years` DECIMAL(18,2) COMMENT 'Expected economic life of the asset in years over which depreciation is calculated. Varies by asset class (e.g., 5 years for sequencing instruments, 10 years for buildings).',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty expires. Used to plan service contract renewals and budget for maintenance costs.',
    `wbs_element` STRING COMMENT 'SAP PS WBS element for capital projects. Used to track CAPEX spending and link assets to strategic initiatives or facility expansions.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset master record in SAP FI-AA — covers all capitalized assets of Genomics Biotech including sequencing instruments, array scanners, HPC clusters, GMP manufacturing equipment, laboratory automation systems, and leasehold improvements. Tracks asset class, acquisition cost, accumulated depreciation, net book value, depreciation method (straight-line/declining balance), useful life, asset location, and disposal status. Supports CAPEX reporting and SOX asset controls.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` (
    `rd_capitalization_id` BIGINT COMMENT 'Unique identifier for the R&D capitalization record. Primary key for tracking capitalization decisions and postings.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Capitalized R&D costs must be tied to specific products for amortization, impairment testing, and regulatory compliance (ASC 985/IAS 38). Financial reporting and audit trail require linking capitaliza',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Link R&D capitalization to cost center for proper cost allocation.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: R&D capitalization decisions result in creation of or addition to fixed assets. rd_capitalization.asset_number and asset_class (STRING) should be replaced with a proper FK to fixed_asset. This links t',
    `gene_annotation_track_id` BIGINT COMMENT 'Foreign key linking to reference.gene_annotation_track. Business justification: Capitalized genomic assay/panel development projects must document which gene annotation version was used for target selection and clinical claims. Required for regulatory submissions (510k, PMA) and ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: R&D costs are accumulated in internal orders before capitalization decisions are made. rd_capitalization.internal_order_number (STRING) should be replaced with a proper FK to internal_order. This link',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: R&D capitalization events create journal entries that move costs from expense accounts to asset accounts (debit fixed asset, credit R&D expense or WIP). rd_capitalization.document_number (STRING) shou',
    `pipeline_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline. Business justification: R&D capitalization decisions directly reference which bioinformatics pipelines achieved technical feasibility and commercial viability milestones, determining whether development costs are capitalized',
    `pipeline_version_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_version. Business justification: Capitalization accounting must track specific pipeline versions that met regulatory validation and technical feasibility criteria for asset recognition. Provides audit trail linking financial asset cr',
    `project_id` BIGINT COMMENT 'Reference to the R&D project or initiative being evaluated for capitalization. Links to the research project master.',
    `amortization_method` STRING COMMENT 'Method used to amortize the capitalized intangible asset over its useful life.. Valid values are `straight_line|units_of_production|declining_balance`',
    `amortization_period_months` STRING COMMENT 'Expected useful life of the intangible asset in months. Used to calculate monthly amortization expense.',
    `amortization_start_date` DATE COMMENT 'Date when amortization of the capitalized intangible asset begins. Typically aligned with product launch or regulatory approval.',
    `approval_authority` STRING COMMENT 'Name or role of the individual or committee that approved the capitalization decision (e.g., CFO, Finance Committee).',
    `approval_date` DATE COMMENT 'Date when the capitalization decision was formally approved by the designated authority.',
    `capitalization_decision_number` STRING COMMENT 'Unique business identifier for the capitalization assessment decision. Used for audit trail and cross-reference with approval documentation.',
    `capitalization_status` STRING COMMENT 'Current status of the capitalization decision workflow. Tracks approval state and posting status.. Valid values are `pending_review|approved_capitalize|approved_expense|rejected|reversed`',
    `capitalized_amount` DECIMAL(18,2) COMMENT 'Amount of R&D expenditure approved for capitalization as intangible asset. Posted to balance sheet rather than expensed.',
    `commercial_viability_confirmed_flag` BOOLEAN COMMENT 'Indicates whether commercial viability and market potential have been confirmed. Required criterion for capitalization under IAS 38.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capitalization record was first created in the system. Used for audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record.. Valid values are `^[A-Z]{3}$`',
    `eligibility_determination_date` DATE COMMENT 'Date when the capitalization eligibility assessment was completed and decision was made.',
    `expensed_amount` DECIMAL(18,2) COMMENT 'Amount of R&D expenditure that does not qualify for capitalization and is immediately expensed to P&L.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year when the capitalization was posted. Used for monthly financial close.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the capitalization decision and posting occurred. Used for period-based financial reporting.',
    `gl_account_asset` STRING COMMENT 'General ledger account number for capitalized intangible asset. Used when development costs are capitalized to balance sheet.',
    `gl_account_expense` STRING COMMENT 'General ledger account number for R&D expense posting. Used when costs are immediately expensed.',
    `impairment_indicator_flag` BOOLEAN COMMENT 'Indicates whether impairment indicators have been identified for the capitalized asset requiring impairment testing under ASC 360 / IAS 36.',
    `intended_use_classification` STRING COMMENT 'Regulatory classification of intended product use. RUO (Research Use Only) vs IVD (In Vitro Diagnostic) impacts capitalization eligibility.. Valid values are `ruo|ivd|ldt|clinical_trial`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this capitalization record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, justification, or special considerations for the capitalization decision.',
    `product_type` STRING COMMENT 'Type of genomics product being developed. Determines applicable regulatory pathway and capitalization criteria. [ENUM-REF-CANDIDATE: ngs_assay|array_product|crispr_tool|bioinformatics_pipeline|reagent_kit|instrument|software — 7 candidates stripped; promote to reference product]',
    `project_phase` STRING COMMENT 'Current phase of the R&D project lifecycle. Research phase costs are expensed; development phase costs may qualify for capitalization under ASC 730 / IAS 38.. Valid values are `research|development|commercialization|post_launch`',
    `regulatory_approval_date` DATE COMMENT 'Date when regulatory approval was received (FDA 510k, PMA, CE-IVD, etc.). Often triggers amortization start for capitalized development costs.',
    `regulatory_approval_milestone` STRING COMMENT 'Current regulatory approval milestone status for IVD products. Critical trigger for capitalization decisions in genomics biotech.. Valid values are `pre_submission|fda_510k_submitted|fda_pma_submitted|ce_ivd_submitted|approved|not_applicable`',
    `reversal_date` DATE COMMENT 'Date when the capitalization entry was reversed. Populated only if reversal_flag is true.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this capitalization entry has been reversed due to project cancellation or eligibility reassessment.',
    `reversal_reason` STRING COMMENT 'Business reason for reversing the capitalization (e.g., project cancelled, technical feasibility not sustained, regulatory rejection).',
    `sox_control_attestation` STRING COMMENT 'Reference to SOX control documentation and attestation for this capitalization decision. Required for SOX 404 compliance.',
    `technical_feasibility_achieved_flag` BOOLEAN COMMENT 'Indicates whether technical feasibility has been established for the project. Key criterion for capitalization eligibility under ASC 730.',
    `technical_feasibility_date` DATE COMMENT 'Date when technical feasibility was established. Marks the earliest point at which development costs may be capitalized.',
    `technology_platform` STRING COMMENT 'Underlying technology platform for the R&D project (e.g., Illumina NGS, CRISPR-Cas9, microarray). Used for portfolio analysis.',
    `therapeutic_area` STRING COMMENT 'Clinical or research therapeutic area targeted by the product (e.g., oncology, rare disease, reproductive health). Used for strategic reporting.',
    `total_expenditure_amount` DECIMAL(18,2) COMMENT 'Total R&D expenditure amount for the project or period being evaluated for capitalization. Gross amount before capitalization split.',
    `wbs_element` STRING COMMENT 'SAP WBS element identifier for project-based cost tracking. Used when R&D costs are tracked via project system rather than internal orders.',
    CONSTRAINT pk_rd_capitalization PRIMARY KEY(`rd_capitalization_id`)
) COMMENT 'R&D capitalization assessment and posting record — manages the determination and recording of which R&D expenditures qualify for capitalization as intangible assets under ASC 730 / IAS 38 vs. immediate expensing. Captures project phase (research vs. development), capitalization eligibility criteria met, capitalized amount, associated internal order or WBS element, amortization start date, and regulatory approval milestone triggers. Critical for genomics biotech where CRISPR tool development, novel assay development, and bioinformatics platform builds may qualify.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` (
    `intercompany_transaction_id` BIGINT COMMENT 'Unique identifier for the intercompany transaction record. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Add FK to cost_center for intercompany transaction cost allocation.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Intercompany transactions are posted to the general ledger via journal entries. intercompany_transaction.reference_document_number (STRING) should be replaced with a proper FK to journal_entry. This l',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Add FK to profit_center for intercompany transaction profitability tracking.',
    `reversed_transaction_intercompany_transaction_id` BIGINT COMMENT 'Foreign key reference to the original intercompany transaction that this record reverses, if applicable. Null if not a reversal.',
    `approval_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this intercompany transaction requires management approval before posting based on materiality thresholds or policy rules.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the intercompany transaction was approved. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `approved_by` STRING COMMENT 'Name or user identifier of the individual who approved the intercompany transaction for posting.',
    `business_purpose` STRING COMMENT 'Textual description of the business rationale and purpose for the intercompany transaction (e.g., shared service charge for IT support, royalty for IP licensing, cost allocation for R&D).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the intercompany transaction record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `elimination_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this intercompany transaction should be eliminated during financial consolidation to avoid double-counting in group reporting.',
    `elimination_status` STRING COMMENT 'Status of the consolidation elimination process for this intercompany transaction (not required, pending, completed, failed).. Valid values are `not_required|pending|completed|failed`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate used to convert the transaction currency to local or group currency at the time of posting.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when the transaction is recorded (1-12).',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the intercompany transaction is recorded for financial reporting purposes.',
    `group_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the group reporting currency for consolidated financial statements.',
    `group_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the group reporting currency (typically USD for Genomics Biotech).. Valid values are `^[A-Z]{3}$`',
    `intercompany_account_code` STRING COMMENT 'General Ledger (GL) account code used for posting the intercompany transaction. Typically a dedicated intercompany receivable or payable account in the chart of accounts.. Valid values are `^[0-9]{6,10}$`',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The transaction amount converted to the local currency of the sending company code for local statutory reporting.',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the local currency of the sending legal entity.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the intercompany transaction record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text field for additional comments, explanations, or audit notes related to the intercompany transaction.',
    `posted_by` STRING COMMENT 'Name or user identifier of the individual who posted the intercompany transaction to the general ledger.',
    `receiving_company_code` STRING COMMENT 'SAP company code of the legal entity receiving or being charged in the intercompany transaction. Four-character alphanumeric code representing the destination entity.. Valid values are `^[A-Z0-9]{4}$`',
    `receiving_jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the tax jurisdiction of the receiving legal entity (e.g., USA, DEU, SGP).. Valid values are `^[A-Z]{3}$`',
    `receiving_legal_entity_name` STRING COMMENT 'Full legal name of the entity receiving the intercompany transaction (e.g., Genomics Biotech APAC Pte Ltd).',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this intercompany transaction is a reversal or correction of a previously posted transaction.',
    `sending_company_code` STRING COMMENT 'SAP company code of the legal entity initiating or sending the intercompany transaction. Four-character alphanumeric code representing the originating entity.. Valid values are `^[A-Z0-9]{4}$`',
    `sending_jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the tax jurisdiction of the sending legal entity (e.g., USA, DEU, SGP).. Valid values are `^[A-Z]{3}$`',
    `sending_legal_entity_name` STRING COMMENT 'Full legal name of the entity initiating the intercompany transaction (e.g., Genomics Biotech Inc., Genomics Biotech EU GmbH).',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) marking whether this intercompany transaction is subject to SOX internal control testing and audit procedures.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the intercompany transaction in the transaction currency before any adjustments or taxes.',
    `transaction_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the intercompany transaction was originally denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `transaction_number` STRING COMMENT 'Business-facing unique identifier for the intercompany transaction, typically following format IC followed by 10 digits. Used for external reference and audit trails.. Valid values are `^IC[0-9]{10}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the intercompany transaction in the financial workflow (draft, pending approval, approved, posted, eliminated, rejected, cancelled). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|posted|eliminated|rejected|cancelled — 7 candidates stripped; promote to reference product]',
    `transaction_type` STRING COMMENT 'Classification of the intercompany transaction indicating the nature of the cross-entity financial activity (charge, loan, royalty, transfer pricing, service fee, cost allocation).. Valid values are `charge|loan|royalty|transfer_pricing|service_fee|cost_allocation`',
    `transfer_pricing_documentation_reference` STRING COMMENT 'Reference identifier or document number linking to the supporting transfer pricing documentation, master file, or local file that justifies the pricing of this intercompany transaction.',
    `transfer_pricing_method` STRING COMMENT 'The OECD transfer pricing method applied to determine the arms length price for this intercompany transaction (CUP: Comparable Uncontrolled Price, Resale Price, Cost Plus, TNMM: Transactional Net Margin Method, Profit Split, Not Applicable).. Valid values are `cup|resale_price|cost_plus|tnmm|profit_split|not_applicable`',
    CONSTRAINT pk_intercompany_transaction PRIMARY KEY(`intercompany_transaction_id`)
) COMMENT 'Intercompany financial transaction record for multi-entity Genomics Biotech group — captures cross-entity charges, loans, royalties, and transfer pricing transactions between legal entities (e.g., US parent, EU subsidiary, APAC entity). Tracks sending/receiving company codes, intercompany account, transaction type, elimination flag, and transfer pricing documentation reference. Supports financial consolidation, OECD transfer pricing compliance, and SOX intercompany controls.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` (
    `tax_posting_id` BIGINT COMMENT 'Unique identifier for the tax posting transaction record in SAP FI. Primary key for tax transaction tracking across all jurisdictions.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to commercial.commercial_contract. Business justification: Contracts have specific tax treatment (VAT exemptions for research use, sales tax nexus, withholding tax). Essential for contract tax compliance, audit trail, and tax authority reporting. Critical in ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Add FK to cost_center for tax posting cost allocation.',
    `account_id` BIGINT COMMENT 'Reference to the general ledger account to which this tax posting is recorded. Links to the chart of accounts structure.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Tax postings are specialized journal entries that record tax transactions (VAT, GST, withholding tax, etc.). tax_posting.document_number (STRING) should be replaced with a proper FK to journal_entry. ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Add FK to profit_center for tax posting profitability reporting.',
    `business_area` STRING COMMENT 'SAP business area for segment reporting. Examples: sequencing, arrays, gene_editing, reagents. Enables tax analysis by product line.. Valid values are `^[A-Z0-9]{4}$`',
    `clearing_date` DATE COMMENT 'Date on which the tax liability was settled with the tax authority or the tax receivable was refunded. Null if not yet cleared.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity for which the tax posting is recorded. Used for multi-entity consolidation and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax posting record was first created in the system. Used for audit trail and data lineage tracking.',
    `customer_tax_number` STRING COMMENT 'Tax identification number of the customer for output tax postings. Used for reverse charge VAT and cross-border transaction reporting.',
    `deferred_tax_flag` BOOLEAN COMMENT 'Indicates whether this tax posting represents a deferred tax asset or liability. True for deferred tax entries, false for current tax postings.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate used to convert transaction currency amounts to local currency. Rate applied at posting date.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the tax posting was recorded. Used for period-based tax reporting and reconciliation.',
    `jurisdiction_code` STRING COMMENT 'Code identifying the tax jurisdiction (country, state, province) where the tax obligation arises. Examples: US-CA (California), GB (United Kingdom), DE (Germany), SG (Singapore).. Valid values are `^[A-Z]{2,5}$`',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the local reporting currency of the company code. Used for statutory reporting.. Valid values are `^[A-Z]{3}$`',
    `local_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount converted to local reporting currency using the exchange rate at posting date. Used for statutory financial reporting.',
    `local_tax_base_amount` DECIMAL(18,2) COMMENT 'Tax base amount converted to local reporting currency using the exchange rate at posting date. Used for statutory financial reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax posting record was last modified. Used for change tracking and audit compliance.',
    `payment_reference` STRING COMMENT 'Reference number of the payment transaction used to settle this tax liability with the tax authority. Links to payment document for reconciliation.',
    `posting_status` STRING COMMENT 'Current status of the tax posting in the financial system. Posted (finalized), parked (draft), cleared (settled with tax authority), reversed (corrected), cancelled (voided).. Valid values are `posted|parked|cleared|reversed|cancelled`',
    `rd_project_code` STRING COMMENT 'Project code for R&D activities eligible for tax credits. Links tax postings to qualifying R&D expenditure for credit claim substantiation.. Valid values are `^[A-Z0-9]{6,12}$`',
    `rd_tax_credit_flag` BOOLEAN COMMENT 'Indicates whether this posting relates to R&D tax credit claims (Section 41 US, HMRC UK R&D relief). True for R&D tax credit transactions.',
    `reversal_document_number` STRING COMMENT 'Document number of the reversal entry if this posting has been reversed. Used to track corrections and adjustments for tax reconciliation.. Valid values are `^[A-Z0-9]{10}$`',
    `reverse_charge_flag` BOOLEAN COMMENT 'Indicates whether the reverse charge mechanism applies (customer self-assesses VAT/GST instead of supplier charging it). True for reverse charge transactions.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this tax posting is subject to SOX internal control testing and audit procedures. True for material tax transactions requiring enhanced controls.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount for this posting. Positive for tax payable/output tax, negative for tax receivable/input tax. Denominated in transaction currency.',
    `tax_authority` STRING COMMENT 'Name of the tax authority or revenue agency to which the tax is owed or from which a credit is claimed. Examples: IRS, HMRC, Finanzamt, IRAS.',
    `tax_base_amount` DECIMAL(18,2) COMMENT 'The taxable base amount (net amount before tax) on which the tax calculation is performed. Denominated in transaction currency.',
    `tax_code` STRING COMMENT 'SAP tax code that defines the tax type, rate, and calculation method. Examples: V0 (VAT 0%), V1 (VAT standard rate), I1 (input VAT), U1 (US sales tax).. Valid values are `^[A-Z0-9]{2,10}$`',
    `tax_direction` STRING COMMENT 'Indicates whether the tax is input (paid to suppliers), output (collected from customers), payable (owed to tax authority), or receivable (refund/credit from tax authority).. Valid values are `input|output|payable|receivable`',
    `tax_exemption_certificate_number` STRING COMMENT 'Reference number of the tax exemption certificate or ruling that supports the exemption claim. Used for audit trail and compliance verification.',
    `tax_exemption_code` STRING COMMENT 'Code indicating the reason for tax exemption or reduced rate. Examples: export (zero-rated export), RUO (research use only exempt), IVD_exempt. Blank if no exemption applies.. Valid values are `^[A-Z0-9]{2,10}$`',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'The tax rate percentage applied to the tax base amount. Examples: 20.00 (UK VAT), 7.00 (California sales tax), 19.00 (German VAT).',
    `tax_registration_number` STRING COMMENT 'Tax registration or identification number of the company code in the jurisdiction. Examples: VAT number (EU), GST registration (Singapore), EIN (US). Used for tax return filing.',
    `tax_return_period` STRING COMMENT 'Tax reporting period to which this posting belongs. Format: YYYY-QN for quarterly (e.g., 2024-Q1) or YYYY-MNN for monthly (e.g., 2024-M03). Determines which tax return filing includes this transaction.. Valid values are `^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$`',
    `tax_type` STRING COMMENT 'Classification of the tax transaction type. Includes VAT (Value Added Tax), GST (Goods and Services Tax), sales tax, withholding tax, use tax, excise tax, customs duty, and R&D tax credit. [ENUM-REF-CANDIDATE: VAT|GST|sales_tax|withholding_tax|use_tax|excise_tax|customs_duty|rd_tax_credit — 8 candidates stripped; promote to reference product]',
    `transaction_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction. Examples: USD, EUR, GBP, SGD.. Valid values are `^[A-Z]{3}$`',
    `vendor_tax_number` STRING COMMENT 'Tax identification number of the vendor or supplier for input tax postings. Used for VAT/GST reclaim validation and withholding tax reporting.',
    `withholding_tax_flag` BOOLEAN COMMENT 'Indicates whether this posting represents withholding tax deducted at source from payments to vendors or employees. True for withholding tax entries.',
    CONSTRAINT pk_tax_posting PRIMARY KEY(`tax_posting_id`)
) COMMENT 'Tax transaction posting record in SAP FI — captures VAT, GST, sales tax, withholding tax, and R&D tax credit postings for Genomics Biotech across jurisdictions (US, EU, APAC). Tracks tax code, tax base amount, tax amount, jurisdiction code, tax return period, and deferred tax classification. Supports indirect tax compliance, R&D tax credit claims (Section 41 US, HMRC UK), and multi-jurisdiction tax reporting.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`capex_request` (
    `capex_request_id` BIGINT COMMENT 'Unique identifier for the capital expenditure request. Primary key for the CAPEX request record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Link CAPEX request to cost center for budgeting and approval workflow.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to commercial.opportunity. Business justification: Large strategic deals may trigger customer-specific capex (demo units, beta installations, custom configurations). Critical for strategic account investment approval, deal economics analysis, and asse',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Link CAPEX request to profit center for investment performance measurement.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Capital expenditure requests must track the requesting employee for approval workflow routing (based on org hierarchy), budget accountability, post-implementation review assignment, and audit trail. E',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Replace WBS element code with FK to wbs_element for project accounting linkage.',
    `approval_date` DATE COMMENT 'Date when the capital expenditure request was formally approved by the authorized governance body. Null if not yet approved. Format: yyyy-MM-dd.',
    `approval_status` STRING COMMENT 'Current status of the CAPEX request in the approval workflow: draft (not yet submitted), submitted (awaiting review), under_review (in governance committee), approved (authorized for execution), rejected (denied), on_hold (pending additional information), or cancelled (withdrawn by requester). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|on_hold|cancelled — 7 candidates stripped; promote to reference product]',
    `approved_amount` DECIMAL(18,2) COMMENT 'Capital expenditure amount approved by the governance committee or authorized approver. May differ from requested amount due to budget constraints or scope adjustments. Null if not yet approved.',
    `approved_by_name` STRING COMMENT 'Full name of the executive or committee chair who authorized the capital expenditure. Null if not yet approved.',
    `asset_class` STRING COMMENT 'Category of asset being acquired or developed through this capital expenditure: sequencing instrument, manufacturing equipment (GMP production lines), facility (building/cleanroom expansion), IT infrastructure (HPC/cloud), laboratory automation, or other.. Valid values are `sequencing_instrument|manufacturing_equipment|facility|it_infrastructure|laboratory_automation|other`',
    `budget_version` STRING COMMENT 'Budget version identifier (e.g., PLAN, FORECAST, REVISED) indicating which budget cycle this CAPEX request is associated with.. Valid values are `^[A-Z0-9]{2,10}$`',
    `budget_year` STRING COMMENT 'Fiscal year for which the capital expenditure is budgeted and planned. Format: YYYY (e.g., 2024).',
    `business_unit` STRING COMMENT 'Name of the business unit or division submitting the capital expenditure request (e.g., Sequencing, Clinical Genomics, Manufacturing).',
    `capitalization_eligible_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the expenditure qualifies for capitalization under GAAP/IFRS accounting standards (True) or must be expensed immediately (False).',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity submitting the capital expenditure request. Used for financial consolidation and SOX compliance.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAPEX request record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the requested and approved amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Accounting method to be used for depreciating the capital asset: straight_line (equal annual expense), declining_balance (accelerated depreciation), units_of_production (usage-based), or not_applicable (non-depreciable asset).. Valid values are `straight_line|declining_balance|units_of_production|not_applicable`',
    `environmental_impact_assessment` STRING COMMENT 'Summary of the capital projects environmental impact, including energy consumption, waste generation, and sustainability considerations. Required for facility and manufacturing equipment investments.',
    `investment_program` STRING COMMENT 'Name of the strategic investment program or portfolio to which this CAPEX request belongs (e.g., NGS Platform Expansion 2024, GMP Facility Modernization).',
    `irr_percentage` DECIMAL(18,2) COMMENT 'Internal rate of return for the capital investment, expressed as a percentage. Represents the discount rate at which NPV equals zero. Used to assess investment attractiveness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the CAPEX request record was last updated. Used for audit trail and change tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `npv_amount` DECIMAL(18,2) COMMENT 'Calculated net present value of the capital investment, representing the present value of expected future cash flows minus the initial investment. Used for investment prioritization.',
    `payback_period_months` STRING COMMENT 'Number of months required to recover the initial capital investment through generated cash flows or cost savings. Used for liquidity and risk assessment.',
    `project_category` STRING COMMENT 'Strategic classification of the capital project: strategic (long-term competitive advantage), operational (business-as-usual improvement), or mandatory (regulatory/compliance-driven).. Valid values are `strategic|operational|mandatory`',
    `regulatory_driver` STRING COMMENT 'Specific regulatory requirement or compliance mandate driving the capital expenditure (e.g., FDA 21 CFR Part 11, IVDR 2017/746, ISO 13485). Null if not compliance-driven.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the approver or governance committee for rejecting the capital expenditure request. Null if not rejected.',
    `request_date` DATE COMMENT 'Date when the capital expenditure request was formally submitted for approval. Format: yyyy-MM-dd.',
    `request_description` STRING COMMENT 'Detailed business justification and description of the capital expenditure request, including strategic rationale, expected benefits, and project scope.',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the capital expenditure request, used for tracking and reference in approval workflows and financial reporting.. Valid values are `^CAPEX-[0-9]{6,10}$`',
    `request_title` STRING COMMENT 'Short descriptive title of the capital expenditure request, summarizing the investment purpose.',
    `request_type` STRING COMMENT 'Classification of the capital expenditure request by investment purpose: expansion (capacity growth), replacement (asset renewal), new product (R&D commercialization), efficiency (cost reduction), compliance (regulatory requirement), or infrastructure (IT/facility upgrade).. Valid values are `expansion|replacement|new_product|efficiency|compliance|infrastructure`',
    `requested_amount` DECIMAL(18,2) COMMENT 'Total capital expenditure amount requested by the business unit, in the companys reporting currency. Includes all project costs: equipment, installation, training, and contingency.',
    `required_by_date` DATE COMMENT 'Target date by which the capital asset or project must be operational to meet business objectives. Used for prioritization and resource planning. Format: yyyy-MM-dd.',
    `risk_rating` STRING COMMENT 'Overall risk assessment for the capital investment project: low (proven technology, low execution risk), medium (moderate complexity), high (significant technical or market uncertainty), or critical (high probability of failure or cost overrun).. Valid values are `low|medium|high|critical`',
    `roi_percentage` DECIMAL(18,2) COMMENT 'Expected return on investment expressed as a percentage of the capital expenditure. Calculated as (expected benefit - investment cost) / investment cost * 100.',
    `sox_control_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this CAPEX request is subject to SOX internal control requirements due to materiality thresholds or financial statement impact.',
    `sponsor_name` STRING COMMENT 'Full name of the executive sponsor or business owner accountable for the capital investment. Typically a VP or C-level executive.',
    `strategic_alignment_score` STRING COMMENT 'Quantitative score (typically 1-10) assessing how well the capital investment aligns with corporate strategic priorities. Used in governance committee prioritization.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the capital asset in years, used for depreciation calculation and asset accounting. Null if not applicable or not yet determined.',
    CONSTRAINT pk_capex_request PRIMARY KEY(`capex_request_id`)
) COMMENT 'Capital expenditure (CAPEX) request and approval record — manages the lifecycle of investment proposals for Genomics Biotech capital projects including new sequencing instrument lines, GMP facility expansions, HPC infrastructure upgrades, and laboratory automation investments. Tracks requested amount, business justification, NPV/IRB/payback period, approval workflow status, approved amount, asset class, and WBS element linkage. Supports CAPEX governance and SOX investment controls.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`sox_control` (
    `sox_control_id` BIGINT COMMENT 'Unique identifier for the SOX control. Primary key for the sox_control data product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: SOX control ownership must link to employee master for responsibility tracking, organizational change impact analysis, access reviews, and control testing assignments. Essential for SOX 404 compliance',
    `mdm_policy_id` BIGINT COMMENT 'Foreign key linking to data.mdm_policy. Business justification: SOX controls enforce MDM policies on financial master data (chart of accounts, cost centers, legal entities). Required for demonstrating control over master data governance in financial reporting.',
    `quality_assessment_id` BIGINT COMMENT 'Foreign key linking to data.quality_assessment. Business justification: SOX controls require documented quality assessments as evidence of control execution. Links control testing to data quality validation results for audit trail and compliance documentation.',
    `quality_rule_id` BIGINT COMMENT 'Foreign key linking to data.quality_rule. Business justification: SOX controls enforce specific data quality rules on financial reporting data (completeness checks, reconciliation rules). Required for demonstrating control effectiveness and audit evidence in regulat',
    `compensating_control_description` STRING COMMENT 'Description of any compensating or mitigating controls in place while a deficiency is being remediated. Compensating controls provide interim assurance that risks are managed during the remediation period.',
    `control_description` STRING COMMENT 'Detailed narrative describing the control objective, procedures performed, evidence retained, and how the control mitigates the identified risk. Includes who performs the control, what is reviewed, and acceptance criteria.',
    `control_documentation_reference` STRING COMMENT 'Reference to the formal control documentation (e.g., process narrative, flowchart, risk-control matrix document ID) that provides detailed control design specifications.',
    `control_frequency` STRING COMMENT 'How often the control is performed or operates. Continuous controls operate in real-time (e.g., system access restrictions), while periodic controls operate at defined intervals (e.g., monthly reconciliations). [ENUM-REF-CANDIDATE: continuous|daily|weekly|monthly|quarterly|annually|event_driven — 7 candidates stripped; promote to reference product]',
    `control_nature` STRING COMMENT 'Describes the execution mechanism of the control: manual (performed entirely by people), automated (system-enforced), IT-dependent manual (manual control relying on system reports), or IT general control (infrastructure/access control).. Valid values are `manual|automated|it_dependent_manual|it_general_control`',
    `control_number` STRING COMMENT 'Business-facing unique identifier for the control, typically formatted as domain prefix followed by sequential number (e.g., FIN-001, IT-GC-045). Used in audit documentation and management reporting.. Valid values are `^[A-Z]{2,4}-[0-9]{3,5}$`',
    `control_performer_name` STRING COMMENT 'Name of the individual or role that executes the control activity. May differ from control owner. For automated controls, this may reference the system or application name.',
    `control_status` STRING COMMENT 'Current lifecycle status of the control. Active controls are in operation and subject to testing. Inactive or retired controls are no longer in effect.. Valid values are `active|inactive|in_design|pending_approval|retired`',
    `control_title` STRING COMMENT 'Short descriptive title of the control activity (e.g., Journal Entry Approval Over $50K, Segregation of Duties - AP Processing).',
    `control_type` STRING COMMENT 'Classification of the control based on its timing and purpose: preventive (stops errors before they occur), detective (identifies errors after occurrence), or corrective (remediates identified issues).. Valid values are `preventive|detective|corrective`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this control record was first created in the system. Part of the audit trail for control lifecycle management.',
    `deficiency_classification` STRING COMMENT 'Severity classification of any identified control deficiency. Control deficiency: minor issue. Significant deficiency: important enough to merit attention by those charged with governance. Material weakness: reasonable possibility of material misstatement not being prevented or detected.. Valid values are `none|control_deficiency|significant_deficiency|material_weakness`',
    `deficiency_description` STRING COMMENT 'Detailed description of the control deficiency identified during testing, including root cause analysis, impact assessment, and specific instances where the control failed to operate as designed.',
    `effective_date` DATE COMMENT 'Date when the control became operational and subject to SOX compliance testing requirements. Used to determine testing scope for annual audits.',
    `external_auditor_reliance` BOOLEAN COMMENT 'Flag indicating whether external auditors plan to rely on this control for their financial statement audit. Controls with auditor reliance require more rigorous testing and documentation.',
    `financial_statement_assertion` STRING COMMENT 'The financial statement assertion(s) addressed by this control: existence/occurrence, completeness, valuation/allocation, rights/obligations, presentation/disclosure. Multiple assertions may be listed if applicable.',
    `fiscal_year` STRING COMMENT 'Fiscal year for which this control record and testing results apply. Supports year-over-year trending and historical audit trail.',
    `key_control_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a key control upon which external auditors may place reliance for financial statement audit purposes. Key controls are subject to more rigorous testing requirements.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the person who last modified this control record. Supports accountability and change tracking for SOX compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this control record was most recently updated. Used to track changes to control design, ownership, or testing results.',
    `last_test_date` DATE COMMENT 'Date when the control was most recently tested for design and operating effectiveness. Used to track testing currency and plan future testing cycles.',
    `management_review_conclusion` STRING COMMENT 'Managements assessment of control effectiveness based on testing results and operational performance. Used for Section 302/404 certifications and disclosure decisions.. Valid values are `effective|ineffective|needs_improvement|not_reviewed`',
    `management_review_date` DATE COMMENT 'Date when management last reviewed the control design and operating effectiveness as part of their Section 302/404 certification process.',
    `next_test_due_date` DATE COMMENT 'Scheduled date for the next control testing activity. Calculated based on control frequency, risk rating, and prior test results. Used for test planning and resource allocation.',
    `process_area` STRING COMMENT 'The business process or financial cycle to which this control belongs (e.g., Revenue Recognition, Accounts Payable, Inventory Valuation, Payroll Processing, Fixed Assets, Period-End Close).',
    `remediation_owner` STRING COMMENT 'Name of the individual accountable for executing the remediation plan and achieving control effectiveness. May differ from the control owner if organizational changes are required.',
    `remediation_plan` STRING COMMENT 'Documented action plan to address identified control deficiencies. Includes specific corrective actions, responsible parties, resources required, and interim compensating controls if applicable.',
    `remediation_status` STRING COMMENT 'Current progress status of remediation activities. Completed indicates actions are finished; validated indicates retesting confirmed effectiveness.. Valid values are `not_started|in_progress|completed|validated|overdue`',
    `remediation_target_date` DATE COMMENT 'Committed date by which the control deficiency will be fully remediated and the control will operate effectively. Used for management tracking and external auditor follow-up.',
    `reviewer_name` STRING COMMENT 'Name of the individual who reviews and approves the control execution evidence. Required for controls with a review component to demonstrate segregation of duties.',
    `risk_description` STRING COMMENT 'Description of the financial reporting risk that this control is designed to mitigate. Articulates what could go wrong in the absence of the control (e.g., Unauthorized journal entries could result in material misstatement).',
    `risk_rating` STRING COMMENT 'Assessment of the inherent risk level associated with the process area before considering control effectiveness. Used to prioritize testing and monitoring activities.. Valid values are `low|medium|high|critical`',
    `sample_size` STRING COMMENT 'Number of control instances or transactions selected for testing. Determined based on control frequency, population size, and desired confidence level.',
    `segregation_of_duties_matrix_reference` STRING COMMENT 'Reference to the documented segregation of duties matrix that defines incompatible functions and role assignments. Links this control to the broader SOD framework.',
    `system_application` STRING COMMENT 'Name of the primary system or application in which the control operates or from which control evidence is generated (e.g., SAP FI, Oracle Cloud HCM, Veeva Vault). Critical for IT general control mapping.',
    `test_approach` STRING COMMENT 'Primary testing methodology used to evaluate control effectiveness: inquiry (asking questions), observation (watching execution), inspection (reviewing evidence), reperformance (executing control independently), or data analytics (statistical sampling).. Valid values are `inquiry|observation|inspection|reperformance|data_analytics`',
    `test_evidence_location` STRING COMMENT 'File path, document management system reference, or repository location where control testing evidence is stored. Required for audit trail and external auditor review.',
    `test_status` STRING COMMENT 'Current status of control testing for the active testing period. Passed indicates effective operation; failed indicates a deficiency requiring remediation.. Valid values are `not_tested|in_progress|passed|failed|not_applicable`',
    CONSTRAINT pk_sox_control PRIMARY KEY(`sox_control_id`)
) COMMENT 'SOX (Sarbanes-Oxley) internal control master for Genomics Biotech financial processes — documents each key control including journal entry approval thresholds, segregation of duties matrices, period-end close checklists, revenue recognition reviews, fixed asset physical verification, and IT general controls over financial systems. Tracks control ID, owner, type (preventive/detective/corrective), frequency (continuous/daily/monthly/quarterly), testing status, test evidence, deficiency classification (control deficiency/significant deficiency/material weakness), and remediation plan with target date. Supports external audit reliance, management certification (Section 302/404), and SEC reporting.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Primary key for profit_center',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Add FK to cost_center for profit center cost allocation hierarchy.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for overseeing the profit center.',
    `parent_profit_center_id` BIGINT COMMENT 'Self-referencing FK on profit_center (parent_profit_center_id)',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Total actual expenditures recorded for the profit center during the fiscal period.',
    `allocation_method` STRING COMMENT 'Method used to allocate shared costs to the profit center.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned annual budget allocated to the profit center, expressed in the reporting currency.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code representing the primary country of the profit center.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the profit center record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for financial reporting of the profit center.',
    `profit_center_description` STRING COMMENT 'Free‑form text describing the purpose, scope, and responsibilities of the profit center.',
    `effective_end_date` DATE COMMENT 'Date when the profit center ceases to be financially active; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the profit center becomes financially active.',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether the profit center is included in external financial reporting.',
    `profit_center_name` STRING COMMENT 'Human‑readable name of the profit center used in reports and dashboards.',
    `profit_center_code` STRING COMMENT 'External code or alphanumeric identifier assigned to the profit center (e.g., PC‑001).',
    `profit_center_type` STRING COMMENT 'Category that defines the nature of the profit center within the organization.',
    `profit_margin_percent` DECIMAL(18,2) COMMENT 'Calculated profit margin percentage for the profit center (gross profit divided by revenue).',
    `region` STRING COMMENT 'Geographic region (e.g., APAC, EMEA, Americas) where the profit center operates.',
    `profit_center_status` STRING COMMENT 'Current operational status of the profit center.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the profit center record.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Master reference table for profit_center. Referenced by profit_center_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'Primary key for wbs_element',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Add FK to cost_center for WBS element cost tracking.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Add FK to profit_center for WBS element profitability reporting.',
    `parent_wbs_element_id` BIGINT COMMENT 'Self-referencing FK on wbs_element (parent_wbs_element_id)',
    `actual_amount` DECIMAL(18,2) COMMENT 'Actual cost incurred to date for the WBS element.',
    `actual_effort_hours` DECIMAL(18,2) COMMENT 'Actual effort recorded to date for the WBS element, expressed in hours.',
    `allocation_method` STRING COMMENT 'Method used to allocate costs from this WBS element to higher‑level objects.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage value applied when the allocation method is percentage.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Amount budgeted for the WBS element, expressed in the functional currency.',
    `compliance_status` STRING COMMENT 'Indicates whether the WBS element complies with applicable regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the WBS element record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the functional currency used for budget and actual amounts.',
    `wbs_element_description` STRING COMMENT 'Detailed description of the purpose and scope of the WBS element.',
    `end_date` DATE COMMENT 'Actual end date of the work represented by the WBS element.',
    `estimated_effort_hours` DECIMAL(18,2) COMMENT 'Projected effort required to complete the work, expressed in hours.',
    `external_reference` STRING COMMENT 'Identifier used by external systems to reference this WBS element.',
    `financial_year` STRING COMMENT 'Fiscal year to which the WBS elements financial data belongs.',
    `fiscal_period` STRING COMMENT 'Quarter of the fiscal year for the WBS element.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether costs incurred on the WBS element are billable to a customer.',
    `is_capitalized` BOOLEAN COMMENT 'Indicates whether the costs of the WBS element are eligible for R&D capitalization.',
    `last_review_date` DATE COMMENT 'Date when the WBS element was last reviewed for compliance or performance.',
    `wbs_element_name` STRING COMMENT 'Human‑readable name of the WBS element.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the WBS element.',
    `parent_wbs_code` STRING COMMENT 'Code of the immediate parent WBS element in the hierarchy.',
    `planned_end_date` DATE COMMENT 'Planned end date for the WBS element as defined in the project plan.',
    `planned_start_date` DATE COMMENT 'Planned start date for the WBS element as defined in the project plan.',
    `project_code` STRING COMMENT 'Code of the top‑level project to which this WBS element belongs.',
    `responsible_organization` STRING COMMENT 'Name of the organizational unit that owns the WBS element.',
    `review_status` STRING COMMENT 'Outcome of the most recent governance review.',
    `risk_level` STRING COMMENT 'Risk classification assigned to the WBS element.',
    `start_date` DATE COMMENT 'Actual start date of the work represented by the WBS element.',
    `wbs_element_status` STRING COMMENT 'Current lifecycle status of the WBS element.',
    `wbs_element_type` STRING COMMENT 'Category of the WBS element indicating its role in the project hierarchy.',
    `unit_of_measure` STRING COMMENT 'Unit used for effort and quantity measurements associated with the WBS element.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the WBS element record.',
    `wbs_code` STRING COMMENT 'Alphanumeric code that uniquely identifies the WBS element within the project hierarchy.',
    `wbs_level` STRING COMMENT 'Depth level of the WBS element within the project hierarchy (1 = top level).',
    `wbs_path` STRING COMMENT 'Slash‑delimited path representing the elements position in the hierarchy (e.g., 01/02/03).',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Master reference table for wbs_element. Referenced by wbs_element_id.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`finance`.`performance_obligation` (
    `performance_obligation_id` BIGINT COMMENT 'Primary key for performance_obligation',
    `contract_id` BIGINT COMMENT 'Identifier of the master contract to which this performance obligation belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Add FK to cost_center for performance obligation cost attribution.',
    `parent_performance_obligation_id` BIGINT COMMENT 'Self-referencing FK on performance_obligation (parent_performance_obligation_id)',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Quantity actually delivered or achieved to date.',
    `billing_schedule` STRING COMMENT 'Frequency or trigger for billing associated with the obligation.',
    `compliance_status` STRING COMMENT 'Current compliance status of the obligation with relevant regulations.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost associated with fulfilling the performance obligation.',
    `cost_currency` STRING COMMENT 'Currency in which the cost amount is expressed.',
    `cost_recognition_method` STRING COMMENT 'Method used to expense or capitalize the cost.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance obligation record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the total amount.',
    `department_code` STRING COMMENT 'Department within the organization that owns the obligation.',
    `performance_obligation_description` STRING COMMENT 'Free‑text description of the performance obligation.',
    `effective_end_date` DATE COMMENT 'Date when the performance obligation ends or expires; null if open-ended.',
    `effective_start_date` DATE COMMENT 'Date when the performance obligation becomes effective.',
    `external_reference_code` STRING COMMENT 'Reference identifier used in external systems for this obligation.',
    `is_capitalized` BOOLEAN COMMENT 'Indicates whether the cost of the obligation is capitalized (true) or expensed (false).',
    `metric_unit` STRING COMMENT 'Unit of measure for the performance metric.',
    `notes` STRING COMMENT 'Additional notes or comments related to the obligation.',
    `obligation_name` STRING COMMENT 'Descriptive name of the performance obligation.',
    `obligation_number` STRING COMMENT 'External reference number assigned to the performance obligation.',
    `obligation_type` STRING COMMENT 'Category of the performance obligation indicating the nature of deliverable.',
    `performance_metric` STRING COMMENT 'Metric used to measure fulfillment of the obligation (e.g., units delivered, milestones).',
    `performance_status_reason` STRING COMMENT 'Explanation for the current status of the performance obligation.',
    `recognition_end_date` DATE COMMENT 'Date when revenue recognition for the obligation ends.',
    `recognition_start_date` DATE COMMENT 'Date when revenue recognition for the obligation begins.',
    `recognized_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue amount that has been recognized to date for this obligation.',
    `region_code` STRING COMMENT 'Three‑letter code representing the geographic region relevant to the obligation.',
    `revenue_recognition_method` STRING COMMENT 'Method used to recognize revenue (point‑in‑time or over‑time).',
    `segment_code` STRING COMMENT 'Business segment classification for reporting purposes.',
    `performance_obligation_status` STRING COMMENT 'Current lifecycle status of the performance obligation.',
    `target_quantity` DECIMAL(18,2) COMMENT 'Planned quantity or amount to be delivered under the obligation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount calculated on the total amount.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total monetary value promised under the performance obligation.',
    `unrecognized_revenue_amount` DECIMAL(18,2) COMMENT 'Revenue amount remaining to be recognized for this obligation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_performance_obligation PRIMARY KEY(`performance_obligation_id`)
) COMMENT 'Master reference table for performance_obligation. Referenced by performance_obligation_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ADD CONSTRAINT `fk_finance_payment_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_original_recognition_revenue_recognition_id` FOREIGN KEY (`original_recognition_revenue_recognition_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ADD CONSTRAINT `fk_finance_revenue_recognition_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ADD CONSTRAINT `fk_finance_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_capex_request_id` FOREIGN KEY (`capex_request_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`capex_request`(`capex_request_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_capex_request_id` FOREIGN KEY (`capex_request_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`capex_request`(`capex_request_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ADD CONSTRAINT `fk_finance_rd_capitalization_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ADD CONSTRAINT `fk_finance_intercompany_transaction_reversed_transaction_intercompany_transaction_id` FOREIGN KEY (`reversed_transaction_intercompany_transaction_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`intercompany_transaction`(`intercompany_transaction_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ADD CONSTRAINT `fk_finance_tax_posting_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_parent_wbs_element_id` FOREIGN KEY (`parent_wbs_element_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `genomics_biotech_ecm`.`finance`.`performance_obligation` ADD CONSTRAINT `fk_finance_performance_obligation_parent_performance_obligation_id` FOREIGN KEY (`parent_performance_obligation_id`) REFERENCES `genomics_biotech_ecm`.`finance`.`performance_obligation`(`performance_obligation_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `genomics_biotech_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Contract Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `quality_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `amount_transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Transaction Currency');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `assignment` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `clearing_document` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `clearing_document` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `credit_amount_group` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount in Group Currency');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `credit_amount_local` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount in Local Currency');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `debit_amount_group` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount in Group Currency');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `debit_amount_local` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount in Local Currency');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `document_line_item` SET TAGS ('dbx_business_glossary_term' = 'Document Line Item Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `financial_statement_item` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Item');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(0[1-9]|1[0-6])$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `functional_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `group_currency` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `group_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `ledger_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `local_currency` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `local_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `reference_key` SET TAGS ('dbx_business_glossary_term' = 'Reference Key');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `special_gl_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special General Ledger (GL) Indicator');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `special_gl_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `tax_amount_local` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount in Local Currency');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `trading_partner` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Company Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `trading_partner` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `user_name` SET TAGS ('dbx_business_glossary_term' = 'User Name');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`general_ledger` ALTER COLUMN `user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `quality_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Issue Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `batch_input_session` SET TAGS ('dbx_business_glossary_term' = 'Batch Input Session');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Changed Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_header_text` SET TAGS ('dbx_business_glossary_term' = 'Document Header Text');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_group` SET TAGS ('dbx_business_glossary_term' = 'Ledger Group');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `originating_process` SET TAGS ('dbx_business_glossary_term' = 'Originating Process');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `parked_indicator` SET TAGS ('dbx_business_glossary_term' = 'Parked Indicator');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Control Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `trading_partner` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `withholding_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`journal_entry` ALTER COLUMN `workflow_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|rejected|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `market_segment_target_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Target Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `mdm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Mdm Policy Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `capitalization_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Capitalization Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `cogs_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Allocation Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|activity_based|step_down|reciprocal|none');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'production|research_development|sales_marketing|administration|quality_assurance|regulatory_affairs');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|planned');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'cost_center|profit_center|investment_center|revenue_center|service_center');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Group');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `gmp_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Regulated Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Notes');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Business Segment Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Short Description');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `sox_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Compliance Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `transfer_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Gross Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|posted|blocked|approved|paid|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|down_payment|prepayment|recurring');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `net_payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_block_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|wire_transfer|ach|eft|credit_card|virtual_card');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `price_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|price_variance|quantity_variance|not_applicable|pending');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `vendor_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Reference');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `withholding_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_payable` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `reagent_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Subscription Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `ar_status` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `ar_status` SET TAGS ('dbx_value_regex' = 'open|partially_paid|cleared|overdue|written_off|disputed');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `billing_block_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Block Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `collection_agency` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `credit_memo_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Reference');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'research_institution|clinical_lab|biopharma_partner|agricultural_genomics|government|academic');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `days_sales_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'invoice|credit_memo|debit_memo|payment_on_account|down_payment');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gl_account` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `last_dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `outstanding_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|letter_of_credit|cash');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `reference_document` SET TAGS ('dbx_business_glossary_term' = 'Reference Document');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `revenue_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `sales_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `channel_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Partner Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `payment_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `payment_bank_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `bank_charges` SET TAGS ('dbx_business_glossary_term' = 'Bank Charges');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `bank_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `bank_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,35}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `block_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `block_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$|^$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `local_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `partial_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Payment Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|direct_debit|paypal');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `payment_run_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `payment_run_number` SET TAGS ('dbx_value_regex' = '^PR[0-9]{8}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'outgoing_vendor|incoming_customer|intercompany|employee_reimbursement|tax_payment|refund');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'not_reconciled|reconciled|exception|under_review');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `reference_text` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Text');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `original_recognition_revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Original Revenue Recognition ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,30}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `business_unit` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `cogs_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `cogs_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `commission_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `deferred_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Fulfillment Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `gross_margin` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `gross_margin` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `modification_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Modification Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `modification_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Modification Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Notes');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `percentage_complete` SET TAGS ('dbx_business_glossary_term' = 'Percentage of Completion');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|milestone_based|usage_based|subscription_ratable');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_period` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Period');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognition_status` SET TAGS ('dbx_value_regex' = 'pending|recognized|deferred|partially_recognized|reversed|adjusted');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Revenue Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_stream` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Classification');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_stream` SET TAGS ('dbx_value_regex' = 'core_product|aftermarket|service|subscription|licensing|other');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `revenue_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Reversal Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Revenue Reversal Reason');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_value_regex' = 'customer_return|contract_cancellation|pricing_adjustment|billing_error|performance_failure|other');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `sales_region` SET TAGS ('dbx_business_glossary_term' = 'Sales Region Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `sales_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`revenue_recognition` ALTER COLUMN `transaction_price` SET TAGS ('dbx_business_glossary_term' = 'Transaction Price');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` SET TAGS ('dbx_subdomain' = 'asset_planning');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `actual_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|locked');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `available_budget` SET TAGS ('dbx_business_glossary_term' = 'Available Budget');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'opex|capex|r_and_d|headcount|revenue');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `capitalization_eligible` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Eligible');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Commitment Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `forecast_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `forecast_horizon` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `forecast_horizon` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|multi_year');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `headcount_fte` SET TAGS ('dbx_business_glossary_term' = 'Headcount Full-Time Equivalent (FTE)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `is_capital_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Is Capital Expenditure (CAPEX)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `legal_entity` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_business_glossary_term' = 'Planning Scenario');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `planning_scenario` SET TAGS ('dbx_value_regex' = 'base_case|best_case|worst_case|stretch_target');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = 'approved|latest_estimate|prior_estimate|original|revised');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`finance_budget` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Request Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `conference_event_id` SET TAGS ('dbx_business_glossary_term' = 'Conference Event Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Under Construction (AUC) ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Order Manager Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Cost Center ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `primary_internal_technical_lead_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Lead Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `primary_internal_technical_lead_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `primary_internal_technical_lead_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_profile` SET TAGS ('dbx_business_glossary_term' = 'Budget Profile');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_profile` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `capitalization_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `committed_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Committed Cost Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `current_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Budget Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `functional_area` SET TAGS ('dbx_value_regex' = 'research_development|manufacturing|sales_marketing|general_administration');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `gxp_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Relevant Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Long Description');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `order_category` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Category');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `order_category` SET TAGS ('dbx_value_regex' = 'research_development|capital_investment|overhead|marketing_campaign|quality_project|manufacturing_project');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'created|released|technically_complete|closed|locked');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'real|statistical');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `original_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Budget Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `planning_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning End Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `planning_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Start Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Priority');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `regulatory_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_profile` SET TAGS ('dbx_business_glossary_term' = 'Settlement Profile');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_profile` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Short Description');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`internal_order` ALTER COLUMN `sox_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Relevant Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_planning');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Request Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `annual_depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Depreciation Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_location` SET TAGS ('dbx_business_glossary_term' = 'Asset Location');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_main_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Main Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'in_service|under_construction|retired|disposed|transferred|impaired');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_subnumber` SET TAGS ('dbx_business_glossary_term' = 'Asset Subnumber');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_value_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Value Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|sum_of_years_digits');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sale|scrap|donation|trade_in|transfer');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `investment_order_number` SET TAGS ('dbx_business_glossary_term' = 'Investment Order Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `is_fully_depreciated` SET TAGS ('dbx_business_glossary_term' = 'Is Fully Depreciated');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_physical_inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inventory Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Depreciation Method');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|macrs|declining_balance|section_179');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`fixed_asset` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` SET TAGS ('dbx_subdomain' = 'asset_planning');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `rd_capitalization_id` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Capitalization ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `gene_annotation_track_id` SET TAGS ('dbx_business_glossary_term' = 'Gene Annotation Track Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `pipeline_version_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Research Project ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `amortization_method` SET TAGS ('dbx_business_glossary_term' = 'Amortization Method');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `amortization_method` SET TAGS ('dbx_value_regex' = 'straight_line|units_of_production|declining_balance');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `amortization_period_months` SET TAGS ('dbx_business_glossary_term' = 'Amortization Period Months');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `amortization_start_date` SET TAGS ('dbx_business_glossary_term' = 'Amortization Start Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `capitalization_decision_number` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Decision Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `capitalization_status` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `capitalization_status` SET TAGS ('dbx_value_regex' = 'pending_review|approved_capitalize|approved_expense|rejected|reversed');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `capitalized_amount` SET TAGS ('dbx_business_glossary_term' = 'Capitalized Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `commercial_viability_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Viability Confirmed Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `eligibility_determination_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Determination Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `expensed_amount` SET TAGS ('dbx_business_glossary_term' = 'Expensed Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `gl_account_asset` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Asset');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `gl_account_expense` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Expense');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `impairment_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `intended_use_classification` SET TAGS ('dbx_business_glossary_term' = 'Intended Use Classification');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `intended_use_classification` SET TAGS ('dbx_value_regex' = 'ruo|ivd|ldt|clinical_trial');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'research|development|commercialization|post_launch');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `regulatory_approval_milestone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Milestone');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `regulatory_approval_milestone` SET TAGS ('dbx_value_regex' = 'pre_submission|fda_510k_submitted|fda_pma_submitted|ce_ivd_submitted|approved|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `sox_control_attestation` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Attestation');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `technical_feasibility_achieved_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Feasibility Achieved Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `technical_feasibility_date` SET TAGS ('dbx_business_glossary_term' = 'Technical Feasibility Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `technology_platform` SET TAGS ('dbx_business_glossary_term' = 'Technology Platform');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `total_expenditure_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Expenditure Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`rd_capitalization` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversed_transaction_intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Transaction ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `business_purpose` SET TAGS ('dbx_business_glossary_term' = 'Business Purpose');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Elimination Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_business_glossary_term' = 'Elimination Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `elimination_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|completed|failed');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_account_code` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Account Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `intercompany_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `posted_by` SET TAGS ('dbx_business_glossary_term' = 'Posted By');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Company Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Receiving Jurisdiction');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `receiving_legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Legal Entity Name');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Company Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Sending Jurisdiction');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sending_legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Sending Legal Entity Name');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^IC[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'charge|loan|royalty|transfer_pricing|service_fee|cost_allocation');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Documentation Reference');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Method');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`intercompany_transaction` ALTER COLUMN `transfer_pricing_method` SET TAGS ('dbx_value_regex' = 'cup|resale_price|cost_plus|tnmm|profit_split|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_posting_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Posting Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Contract Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Clearing Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `customer_tax_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Tax Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `customer_tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `deferred_tax_flag` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `local_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Tax Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `local_tax_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Tax Base Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Tax Payment Reference');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|parked|cleared|reversed|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `rd_project_code` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Project Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `rd_project_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `rd_tax_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Tax Credit Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `reverse_charge_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Charge Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_authority` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Base Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_direction` SET TAGS ('dbx_business_glossary_term' = 'Tax Direction');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_direction` SET TAGS ('dbx_value_regex' = 'input|output|payable|receivable');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_exemption_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_exemption_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_return_period` SET TAGS ('dbx_business_glossary_term' = 'Tax Return Period');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_return_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `vendor_tax_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tax Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `vendor_tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`tax_posting` ALTER COLUMN `withholding_tax_flag` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` SET TAGS ('dbx_subdomain' = 'asset_planning');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Request ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `approved_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'sequencing_instrument|manufacturing_equipment|facility|it_infrastructure|laboratory_automation|other');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `budget_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `capitalization_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Eligible Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `environmental_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `investment_program` SET TAGS ('dbx_business_glossary_term' = 'Investment Program');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `irr_percentage` SET TAGS ('dbx_business_glossary_term' = 'Internal Rate of Return (IRR) Percentage');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `irr_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `npv_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (NPV) Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `npv_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `payback_period_months` SET TAGS ('dbx_business_glossary_term' = 'Payback Period (Months)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `payback_period_months` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `project_category` SET TAGS ('dbx_business_glossary_term' = 'Project Category');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `project_category` SET TAGS ('dbx_value_regex' = 'strategic|operational|mandatory');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `request_description` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Request Description');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Request Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^CAPEX-[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `request_title` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Request Title');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Request Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'expansion|replacement|new_product|efficiency|compliance|infrastructure');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `requested_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `requested_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Required By Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percentage');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_business_glossary_term' = 'Executive Sponsor Name');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `sponsor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `strategic_alignment_score` SET TAGS ('dbx_business_glossary_term' = 'Strategic Alignment Score');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`capex_request` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley) Control ID');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `mdm_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Mdm Policy Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `quality_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assessment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `quality_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Rule Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `compensating_control_description` SET TAGS ('dbx_business_glossary_term' = 'Compensating Control Description');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `control_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Control Documentation Reference');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `control_frequency` SET TAGS ('dbx_business_glossary_term' = 'Control Frequency');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `control_nature` SET TAGS ('dbx_business_glossary_term' = 'Control Nature');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `control_nature` SET TAGS ('dbx_value_regex' = 'manual|automated|it_dependent_manual|it_general_control');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `control_number` SET TAGS ('dbx_business_glossary_term' = 'Control Number');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `control_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{3,5}$');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `control_performer_name` SET TAGS ('dbx_business_glossary_term' = 'Control Performer Name');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|in_design|pending_approval|retired');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `control_title` SET TAGS ('dbx_business_glossary_term' = 'Control Title');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'preventive|detective|corrective');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `deficiency_classification` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Classification');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `deficiency_classification` SET TAGS ('dbx_value_regex' = 'none|control_deficiency|significant_deficiency|material_weakness');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `external_auditor_reliance` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Reliance Indicator');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `financial_statement_assertion` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Assertion');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `key_control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Key Control Indicator');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `management_review_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Management Review Conclusion');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `management_review_conclusion` SET TAGS ('dbx_value_regex' = 'effective|ineffective|needs_improvement|not_reviewed');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `management_review_date` SET TAGS ('dbx_business_glossary_term' = 'Management Review Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `next_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Test Due Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `process_area` SET TAGS ('dbx_business_glossary_term' = 'Process Area');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `remediation_owner` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|validated|overdue');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `remediation_target_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Target Date');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `segregation_of_duties_matrix_reference` SET TAGS ('dbx_business_glossary_term' = 'Segregation of Duties (SOD) Matrix Reference');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `system_application` SET TAGS ('dbx_business_glossary_term' = 'System Application');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `test_approach` SET TAGS ('dbx_business_glossary_term' = 'Test Approach');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `test_approach` SET TAGS ('dbx_value_regex' = 'inquiry|observation|inspection|reperformance|data_analytics');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `test_evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Test Evidence Location');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`sox_control` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'not_tested|in_progress|passed|failed|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_subdomain' = 'cost_management');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Identifier');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`wbs_element` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`wbs_element` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`wbs_element` ALTER COLUMN `parent_wbs_element_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`performance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`performance_obligation` SET TAGS ('dbx_subdomain' = 'financial_accounting');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`performance_obligation` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Identifier');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`performance_obligation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`finance`.`performance_obligation` ALTER COLUMN `parent_performance_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
