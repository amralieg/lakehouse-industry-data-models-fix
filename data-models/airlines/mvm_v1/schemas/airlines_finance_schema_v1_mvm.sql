-- Schema for Domain: finance | Business: Airlines | Version: v1_mvm
-- Generated on: 2026-05-07 15:14:29

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`finance` COMMENT 'Corporate financial management SSOT covering general ledger, accounts payable/receivable, cost centre accounting, budget planning, financial consolidation, CASK (Cost per Available Seat Kilometer) reporting, fuel cost accounting, lease liability (IFRS 16), interline billing settlements, treasury operations, and regulatory financial reporting. Aligns with SAP S/4HANA FI/CO modules.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`finance`.`general_ledger` (
    `general_ledger_id` BIGINT COMMENT 'Unique surrogate identifier for each general ledger journal entry line item record in the SAP S/4HANA FI-GL module. Serves as the immutable primary key for the silver layer lakehouse table.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Each GL entry belongs to ONE company code. The general_ledger table has company_code (STRING) which should be replaced with a FK to the company_code master. This is a mandatory dimension in SAP FI-GL.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Each GL entry can be assigned to ONE cost center for CO allocation. The general_ledger table has cost_centre (STRING) which should be replaced with a FK to the cost_centre master.',
    `accounting_principle` STRING COMMENT 'The accounting standard under which this posting is recorded. Supports dual-reporting requirements for airlines operating across multiple jurisdictions. IFRS16 specifically tracks right-of-use asset and lease liability postings for aircraft operating leases.. Valid values are `IFRS|GAAP|IFRS16|LOCAL`',
    `amount_company_currency` DECIMAL(18,2) COMMENT 'The posting amount converted to the company codes local currency (BSEG-DMBTR). Used for statutory financial reporting, local GAAP compliance, and period-end balance sheet preparation.',
    `amount_group_currency` DECIMAL(18,2) COMMENT 'The posting amount translated to the group reporting currency (BSEG-KURSF-based calculation, stored as parallel ledger amount). Supports consolidated financial statements and group-level CASK/RASK reporting across all airline entities.',
    `amount_transaction_currency` DECIMAL(18,2) COMMENT 'The gross posting amount in the original transaction currency (BSEG-WRBTR). Represents the raw financial value before currency conversion. Used for interline billing settlements, BSP reconciliation, and multi-currency financial reporting.',
    `assignment_number` STRING COMMENT 'Free-form assignment field used for sorting and grouping line items in account statements (BSEG-ZUONR). Typically populated with flight number, route code, or cost object reference to facilitate operational cost reconciliation.',
    `company_currency` STRING COMMENT 'ISO 4217 three-letter currency code of the company codes local (functional) currency (T001-WAERS). The currency in which statutory accounts are prepared for the legal entity.. Valid values are `^[A-Z]{3}$`',
    `cost_element` STRING COMMENT 'SAP CO cost element corresponding to the GL account for cost and revenue postings (BSEG-KOSTL-linked KSTAR). Bridges FI and CO modules, enabling detailed cost analysis for fuel uplift, crew costs, MRO expenses, and lease payments.. Valid values are `^[0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the accounting document was first created in SAP (BKPF-CPUDT + BKPF-CPUTM combined). Provides the immutable audit creation timestamp for the journal entry, distinct from the business posting_date.',
    `debit_credit_indicator` STRING COMMENT 'SAP indicator specifying whether the line item is a debit (S = Soll) or credit (H = Haben) posting (BSEG-SHKZG). Fundamental to double-entry bookkeeping and ensures the document balances to zero.. Valid values are `S|H`',
    `document_date` DATE COMMENT 'The date of the original source document (invoice, receipt, contract) that triggered the accounting entry (BKPF-BLDAT). May differ from posting_date for accruals, prepayments, or late-received invoices.',
    `document_number` STRING COMMENT 'SAP FI accounting document number uniquely identifying the journal entry header within a company code and fiscal year. Corresponds to BKPF-BELNR in SAP. All line items sharing the same document number belong to the same posting event.. Valid values are `^[0-9]{10}$`',
    `document_type` STRING COMMENT 'SAP document type code classifying the nature of the accounting entry (BKPF-BLART). Controls number ranges and account types. Common airline values include SA (GL account document), KR (vendor invoice), DR (customer invoice), ZP (payment), AA (asset posting), AB (accounting document). [ENUM-REF-CANDIDATE: SA|KR|DR|ZP|AA|AB|RV|WA — promote to reference product]. Valid values are `^[A-Z0-9]{2}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign currency exchange rate applied to convert the transaction currency amount to the company code currency at the time of posting (BKPF-KURSF). Critical for IFRS IAS 21 compliance and interline settlement reconciliation.',
    `fiscal_period` STRING COMMENT 'Accounting period (1–16) within the fiscal year to which the posting belongs (BKPF-MONAT in SAP). Periods 13–16 are special closing periods used for year-end adjustments, accruals, and audit corrections.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which the accounting document belongs (BKPF-GJAHR in SAP). Used for period-end close, annual financial reporting, and year-over-year variance analysis.',
    `functional_area` STRING COMMENT 'SAP functional area classifying the business function of the posting for cost-of-sales accounting (BSEG-FKBER). Enables income statement presentation by function (e.g., Flight Operations, Sales & Distribution, Administration) per IFRS IAS 1.. Valid values are `^[A-Z0-9]{1,16}$`',
    `gl_account_code` STRING COMMENT 'The GL account number from the chart of accounts to which this line item is posted (BSEG-HKONT / SKA1-SAKNR). Represents the financial classification of the transaction (e.g., fuel expense, lease liability, revenue, accrued liabilities). Core to CASK reporting and financial consolidation.. Valid values are `^[0-9]{6,10}$`',
    `gl_account_name` STRING COMMENT 'Human-readable description of the GL account (SKA1-TXT50). Denormalised from the chart of accounts for reporting convenience and audit trail completeness. Examples: Jet Fuel Expense, Aircraft Lease Liability (IFRS 16), Interline Receivable.',
    `header_text` STRING COMMENT 'Free-text description at the accounting document header level (BKPF-BKTXT). Provides overall context for the journal entry, shared across all line items of the same document. Used for audit trail and period-end close documentation.',
    `intercompany_indicator` BOOLEAN COMMENT 'Flag indicating whether this posting is an intercompany transaction between two legal entities within the airline group (BKPF-BVTYP populated). True = intercompany posting requiring elimination in group consolidation. Critical for IFRS 10 consolidation.',
    `internal_order` STRING COMMENT 'SAP CO internal order number used to collect costs for specific projects, campaigns, or temporary cost objects (BSEG-AUFNR). Used in aviation for aircraft modification projects, route launch campaigns, and MRO work orders.. Valid values are `^[A-Z0-9]{1,12}$`',
    `last_changed_timestamp` TIMESTAMP COMMENT 'The date and time when the accounting document was last modified in SAP. Tracks changes to parked documents, header text updates, or clearing events. Supports change audit trail requirements under SOX and IFRS.',
    `ledger_code` STRING COMMENT 'SAP parallel ledger identifier (BKPF-RLDNR) supporting dual IFRS and local GAAP reporting. Common values: 0L = leading ledger (IFRS), N1 = local GAAP ledger. Enables simultaneous reporting under multiple accounting standards required for multinational airline operations.. Valid values are `^[A-Z0-9]{2}$`',
    `line_item_number` STRING COMMENT 'Sequential line item number within the accounting document (BSEG-BUZEI in SAP). Identifies the specific debit or credit posting line within the journal entry. Combined with document_number and company_code forms the natural key of a GL line item.',
    `posting_date` DATE COMMENT 'The date on which the accounting document is posted to the general ledger (BKPF-BUDAT). Determines the fiscal period assignment and is the primary date used for financial reporting and period-end close.',
    `posting_status` STRING COMMENT 'Current lifecycle status of the accounting document. posted = active GL entry; reversed = entry has been reversed by a reversal document; parked = document saved but not yet posted; held = incomplete document; cleared = open item has been cleared against a payment or offsetting entry.. Valid values are `posted|reversed|parked|held|cleared`',
    `posting_text` STRING COMMENT 'Free-text description of the individual line item posting (BSEG-SGTXT). Provides narrative context for the accounting entry, e.g., Jet fuel uplift JFK-LHR 15-Jan, IFRS 16 lease liability accrual Q1, Interline settlement IATA BSP Jan.',
    `posting_user` STRING COMMENT 'SAP user ID of the person or system process that created the accounting document (BKPF-USNAM). Essential for SOX audit trail, segregation of duties controls, and financial fraud detection. May be a batch job ID for automated postings.',
    `profit_centre` STRING COMMENT 'SAP Controlling profit centre representing a business unit responsible for its own profitability (BSEG-PRCTR / CEPC-PRCTR). Used for route-level, hub-level, or business-segment P&L reporting. Supports RASK and yield analysis by profit centre.. Valid values are `^[A-Z0-9]{4,10}$`',
    `reference_document_number` STRING COMMENT 'External reference number from the source document (BKPF-XBLNR), such as a vendor invoice number, AWB (Air Waybill) number, PNR, interline billing statement number, or BSP settlement reference. Enables traceability from the GL back to the originating business transaction.',
    `reversal_document_number` STRING COMMENT 'The document number of the corresponding reversal or reversed document (BKPF-STBLG). Populated when reversal_indicator is true, enabling bidirectional traceability between original and reversal entries for audit and compliance purposes.. Valid values are `^[0-9]{10}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this document is a reversal of a previously posted document (BKPF-STBLG is populated). True = this is a reversal document. Supports audit trail integrity and period-end close accuracy.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount (VAT/GST/PFC) associated with this line item in the transaction currency (BSEG-WMWST). Supports tax reconciliation, VAT return preparation, and Passenger Facility Charge (PFC) reporting to airport authorities.',
    `tax_code` STRING COMMENT 'SAP tax code determining the applicable tax rate and tax account for the posting (BSEG-MWSKZ). Relevant for VAT/GST on airline ancillary services, ground handling charges, and MRO procurement. Supports tax reporting to national revenue authorities.. Valid values are `^[A-Z0-9]{2}$`',
    `trading_partner_company_code` STRING COMMENT 'Company code of the intercompany trading partner for intercompany postings (BSEG-VBUND). Populated when intercompany_indicator is true. Used for automated intercompany elimination during group financial consolidation.. Valid values are `^[A-Z0-9]{4}$`',
    `transaction_currency` STRING COMMENT 'ISO 4217 three-letter currency code of the original transaction (BSEG-WAERS). Identifies the currency in which the business event was denominated, e.g., USD for US routes, EUR for European operations, GBP for UK operations.. Valid values are `^[A-Z]{3}$`',
    `wbs_element` STRING COMMENT 'SAP Project System WBS element for project-based cost assignment (BSEG-PS_PSP_PNR). Used for capital expenditure projects such as fleet acquisition, terminal construction, and major MRO overhauls. Supports IFRS IAS 16 capitalisation tracking.',
    CONSTRAINT pk_general_ledger PRIMARY KEY(`general_ledger_id`)
) COMMENT 'SAP S/4HANA FI-GL SSOT for all accounting entries across the airlines chart of accounts. Each record represents a journal entry document (posting) with header attributes (document number, posting date, fiscal period, document type, company code, reference, reversal indicator, posting user) and line items (debit/credit amounts, GL account, cost centre, profit centre, functional area, cost element, currency, exchange rate). Supports IFRS and local GAAP dual reporting, period-end close, intercompany postings, accruals, provisions, and financial consolidation across all legal entities. Serves as the immutable audit trail for regulatory financial reporting and the single authoritative source for all financial postings.';

CREATE OR REPLACE TABLE `airlines_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'Unique surrogate identifier for each journal entry record in the general ledger. Primary key for the journal_entry data product in the finance domain silver layer.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Each journal entry belongs to ONE company code (legal entity). The journal_entry table has company_code (STRING) which should be replaced with a FK to the company_code master. Company code is a mandat',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Each journal entry can be assigned to ONE cost center for CO allocation. The journal_entry table has cost_center (STRING) which should be replaced with a FK to the cost_centre master. This is a standa',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Each journal entry posts to ONE GL account. The journal_entry table has gl_account_code (STRING) which should be replaced with a FK to the general_ledger master. This is a standard SAP FI relationship',
    `account_type` STRING COMMENT 'SAP FI account type indicating the subledger category for this posting: A=Asset, D=Customer (Debtor/Accounts Receivable), K=Vendor (Creditor/Accounts Payable), M=Material, S=General Ledger. Determines which subledger is updated.. Valid values are `A|D|K|M|S`',
    `amount_document_currency` DECIMAL(18,2) COMMENT 'The transaction amount in the original document currency (transaction currency). May differ from amount_local_currency when the source document is in a foreign currency, such as interline billing settlements in USD or EUR.',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'The gross transaction amount in the company codes local (functional) currency. This is the primary monetary value for statutory reporting and forms part of the MONETARY_TRIPLET for this transaction.',
    `assignment_number` STRING COMMENT 'SAP FI assignment field used for sorting and matching open items during clearing (e.g., flight number, route code, cost object reference). Supports automated payment matching and interline settlement reconciliation.',
    `business_area` STRING COMMENT 'SAP FI business area code representing an organizational unit for which an internal balance sheet and P&L can be produced (e.g., passenger operations, cargo, MRO, loyalty). Supports segment reporting under IFRS 8.. Valid values are `^[A-Z0-9]{4}$`',
    `clearing_date` DATE COMMENT 'The date on which this open item was cleared (matched against a payment or offsetting entry). Used for accounts receivable aging analysis, days sales outstanding (DSO) calculation, and cash flow reporting.',
    `clearing_document_number` STRING COMMENT 'The SAP FI document number of the clearing transaction that matched and closed this open item (e.g., payment document clearing an invoice, credit memo clearing a debit). Populated when posting_status is cleared.',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether this journal entry line is a debit (D) or credit (C) posting. Fundamental to double-entry bookkeeping and ensures the general ledger remains in balance. Aligns with SAP FI posting key logic.. Valid values are `D|C`',
    `document_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code of the original document currency (e.g., USD, EUR, GBP). Critical for interline billing, BSP settlements, and multi-currency treasury operations.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date of the original source document (invoice date, payment date, contract date) that triggered this journal entry. May differ from posting_date when documents are processed with a lag.',
    `document_number` STRING COMMENT 'The externally visible SAP FI document number uniquely identifying this accounting document within the company code and fiscal year. Used as the primary business reference for audit trail and reconciliation.. Valid values are `^[0-9]{10}$`',
    `document_type` STRING COMMENT 'SAP FI document type code classifying the nature of the accounting document (e.g., SA=General Ledger, KR=Vendor Invoice, DR=Customer Invoice, ZP=Payment, AB=Accounting Document). Drives number range assignment and posting rules. [ENUM-REF-CANDIDATE: SA|KR|DR|ZP|AB|RE|RV|KZ|DZ — promote to reference product]. Valid values are `^[A-Z0-9]{2}$`',
    `entry_timestamp` TIMESTAMP COMMENT 'The precise date and time when this journal entry record was created in the SAP S/4HANA system. Serves as the RECORD_AUDIT_CREATED timestamp for audit trail and data lineage purposes.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign currency exchange rate applied to translate the document currency amount to the local currency amount at the time of posting. Sourced from SAP exchange rate tables and aligned with treasury hedging policies.',
    `fiscal_period` STRING COMMENT 'The accounting period (1–16, including special periods 13–16 for year-end adjustments) within the fiscal year in which this journal entry is posted. Aligns with SAP S/4HANA posting period control.',
    `fiscal_year` STRING COMMENT 'The accounting fiscal year in which this journal entry is recorded, as defined by the airlines fiscal year variant in SAP S/4HANA. May differ from the calendar year for airlines with non-calendar fiscal years.',
    `functional_area` STRING COMMENT 'SAP CO functional area classifying the cost by business function (e.g., PROD=Production/Flight Operations, SELL=Sales, ADMN=Administration, MAINT=Maintenance). Supports cost-of-sales accounting and CASK component analysis.. Valid values are `^[A-Z0-9]{4,16}$`',
    `header_text` STRING COMMENT 'Free-text description at the document header level providing business context for the journal entry (e.g., Monthly fuel accrual JFK hub, IFRS 16 lease liability Q3, Interline BSP settlement October). Supports audit review and financial analysis.',
    `internal_order_number` STRING COMMENT 'SAP CO internal order number used to collect costs for specific projects or events (e.g., aircraft heavy maintenance C-check, airport terminal renovation, fleet acquisition project). Enables project-level cost tracking.',
    `last_changed_timestamp` TIMESTAMP COMMENT 'The date and time when this journal entry record was last modified in the source system. Supports incremental data loading, change data capture, and audit trail requirements.',
    `line_item_text` STRING COMMENT 'Free-text description at the individual line item level providing specific context for this debit or credit posting (e.g., Jet-A fuel uplift LHR 15-Oct, ACMI wet lease payment, Crew hotel deadhead expense).',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code of the company codes local (functional) currency. Defines the base currency for statutory financial reporting for the legal entity.. Valid values are `^[A-Z]{3}$`',
    `posting_date` DATE COMMENT 'The date on which the journal entry is posted to the general ledger and determines the fiscal period assignment. This is the authoritative accounting date for period-end close and financial reporting.',
    `posting_key` STRING COMMENT 'SAP FI two-digit posting key controlling the account type, debit/credit indicator, and field selection for this line item (e.g., 40=GL Debit, 50=GL Credit, 31=Vendor Credit, 01=Customer Debit). Determines the accounting treatment applied.. Valid values are `^[0-9]{2}$`',
    `posting_status` STRING COMMENT 'Current lifecycle status of the journal entry in the general ledger workflow. Posted indicates a completed, immutable entry; parked is a draft pending approval; reversed indicates a correcting entry has been applied; cleared indicates the open item has been matched.. Valid values are `posted|parked|held|reversed|cleared|blocked`',
    `profit_center_code` STRING COMMENT 'SAP CO profit center identifying the business segment (e.g., route, hub, cabin class, cargo) responsible for this posting. Supports profitability analysis by route, fleet type, and business unit.. Valid values are `^[A-Z0-9]{4,10}$`',
    `reference_document_number` STRING COMMENT 'External reference number from the originating source document (e.g., vendor invoice number, PNR, AWB number, interline billing statement number, lease contract reference). Enables cross-system reconciliation and audit trail linkage.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this journal entry is a reversal document (True) or an original posting (False). Reversal entries are created to correct erroneous postings and maintain audit integrity in the general ledger.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax component (VAT, GST, PFC, or other applicable taxes) included in or associated with this journal entry posting. Part of the MONETARY_TRIPLET adjustment component. Supports tax reporting and PFC (Passenger Facility Charge) reconciliation.',
    `tax_code` STRING COMMENT 'SAP tax code identifying the applicable tax type and rate for this posting (e.g., V1=Input VAT 19%, A1=Output VAT 19%). Drives automatic tax calculation and tax return preparation.. Valid values are `^[A-Z0-9]{2}$`',
    `wbs_element` STRING COMMENT 'SAP PS Work Breakdown Structure (WBS) element for project-based cost assignments, such as aircraft acquisition, fleet modification programs, or major infrastructure projects. Supports capital expenditure tracking under IFRS IAS 16.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Individual accounting posting records in the general ledger representing debits and credits for every financial transaction across the airline. Captures document type, posting date, fiscal period, currency, exchange rate, reference document, reversal indicators, and posting user. Aligns with SAP FI document posting model and supports audit trail for regulatory financial reporting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`finance`.`cost_centre` (
    `cost_centre_id` BIGINT COMMENT 'Unique surrogate identifier for the cost centre record in the lakehouse silver layer. Primary key for the cost_centre data product.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Each cost center belongs to ONE company code. The cost_centre table has company_code (STRING) which should be replaced with a FK to the company_code master. Cost centers are assigned to company codes ',
    `activity_type_code` STRING COMMENT 'Primary SAP CO activity type associated with this cost centre, defining the unit of output for internal activity allocation (e.g., FLT-HRS = flight hours, BLK-HRS = block hours, MRO-MHR = maintenance man-hours, GND-TRN = ground turns). Used to calculate internal activity rates for cost allocation between centres.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Total approved annual budget allocated to this cost centre for the current fiscal year, in the controlling area currency. Represents the authorised spending limit for departmental P&L management. Used in budget vs. actual variance reporting and financial planning.',
    `budget_version` STRING COMMENT 'SAP CO planning version identifier for the budget associated with this cost centre (e.g., 000 = actuals, 001 = original budget, 002 = revised forecast, PLAN = annual plan). Enables comparison of actuals vs. budget vs. forecast in variance reporting.. Valid values are `^[A-Z0-9_-]{1,10}$`',
    `business_area_code` STRING COMMENT 'SAP FI business area assigned to this cost centre, representing a distinct area of operations for internal balance sheet and P&L reporting (e.g., PASS = Passenger, CARG = Cargo, MRO = Maintenance). Enables segment reporting per IFRS 8 without full profit centre accounting.. Valid values are `^[A-Z0-9]{1,4}$`',
    `cask_allocation_key` STRING COMMENT 'Allocation driver used to apportion this cost centres costs to Available Seat Kilometers (ASK) for CASK reporting. ask = direct ASK-based allocation; block_hours = by block hours flown; departures = by number of departures; pax = by passenger count; revenue = by revenue share; equal = equal split; manual = manually defined percentages. Critical for unit cost benchmarking. [ENUM-REF-CANDIDATE: ask|block_hours|departures|pax|revenue|equal|manual — 7 candidates stripped; promote to reference product]',
    `category_code` STRING COMMENT 'SAP CO cost centre category that classifies the functional nature of the centre (e.g., F = Flight Operations, M = Maintenance, G = Ground Handling, A = Administration, C = Cargo, L = Loyalty). Controls which activity types and statistical key figures can be posted. [ENUM-REF-CANDIDATE: F|M|G|A|C|L|S|T — promote to reference product]',
    `centre_type` STRING COMMENT 'Classification of the responsibility centre by financial accountability type. cost centres track expenditure only (e.g., maintenance base); profit centres track both revenue and cost for P&L reporting (e.g., route group, cargo division); investment centres include capital employed; revenue centres track revenue attribution (e.g., lounge, ancillary). Drives CASK/RASK allocation methodology.. Valid values are `cost|profit|investment|revenue`',
    `controlling_area_code` STRING COMMENT 'SAP CO controlling area to which this cost centre belongs. The controlling area defines the organisational unit within which cost accounting is performed (e.g., AA01 for the airline group). Determines currency, fiscal year variant, and chart of accounts applicable to this centre.. Valid values are `^[A-Z0-9]{1,4}$`',
    `corsia_emissions_flag` BOOLEAN COMMENT 'Indicates whether this cost centre is subject to CORSIA (Carbon Offsetting and Reduction Scheme for International Aviation) emissions monitoring and offset cost accounting. True for international route operations cost centres. Drives inclusion in ICAO CORSIA compliance reporting and carbon offset cost allocation.',
    `cost_centre_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the cost centre within the SAP CO controlling area. Used in journal entries, budget allocations, and management reporting (e.g., FLT-OPS-001, MRO-BASE-LHR, CARGO-HUB-JFK). Aligns with SAP CO cost centre number.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `cost_centre_description` STRING COMMENT 'Long-form narrative description of the cost centres business purpose, scope of operations, and cost accountability. Provides context for financial analysts and auditors beyond the short name (e.g., Responsible for all direct operating costs of widebody long-haul fleet on North Atlantic routes including fuel uplift, crew costs, and ATC charges).',
    `cost_centre_name` STRING COMMENT 'Full descriptive name of the cost centre as maintained in SAP CO master data (e.g., Flight Operations — North Atlantic Hub, Cabin Crew Training — Base London, MRO Line Maintenance — Frankfurt). Used in financial reports and management dashboards.',
    `cost_centre_status` STRING COMMENT 'Current lifecycle status of the cost centre in SAP CO. active = open for postings; inactive = temporarily suspended; locked = blocked for new postings (period-end); pending_activation = created but not yet released; closed = permanently deactivated with no further postings permitted.. Valid values are `active|inactive|locked|pending_activation|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost centre master record was first created in the source SAP CO system. Used for audit trail, data lineage tracking, and compliance with financial record retention requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost centres controlling currency (e.g., USD, EUR, GBP). Determines the currency in which budgets are planned, actuals are recorded, and variance reports are produced. May differ from company code currency for international operations.. Valid values are `^[A-Z]{3}$`',
    `fiscal_year` STRING COMMENT 'The fiscal year to which the cost centres budget and planning data applies (e.g., 2024). Aligns with the SAP CO fiscal year variant configured for the controlling area. Used to version budget records and support multi-year trend analysis.',
    `fuel_cost_flag` BOOLEAN COMMENT 'Indicates whether this cost centre is designated for fuel cost accounting and uplift tracking. True for flight operations and route cost centres where jet fuel (Jet-A/A1) costs are directly attributed. Enables fuel cost per ASK (fuel CASK) component reporting and hedging P&L attribution.',
    `functional_area_code` STRING COMMENT 'SAP FI/CO functional area classifying the cost centre by business function for cost-of-sales accounting and segment reporting (e.g., PROD = Production/Operations, SELL = Sales, ADMN = Administration, R&D = Research). Required for IFRS income statement by function of expense.',
    `gl_account_group` STRING COMMENT 'SAP FI general ledger account group associated with primary cost postings for this cost centre. Defines the range of GL accounts permissible for postings, ensuring cost classification consistency (e.g., OPEX for operating expenses, FUEL for fuel costs, LABOR for crew and staff costs).. Valid values are `^[A-Z0-9]{1,10}$`',
    `hierarchy_area` STRING COMMENT 'Node identifier within the standard cost centre hierarchy (SAP CO standard hierarchy) to which this centre is assigned. Enables roll-up reporting by business segment, division, or region (e.g., FLIGHT-OPS, MRO-EMEA, CARGO-APAC). Used for group-level CASK reporting and segment P&L consolidation.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this cost centre within the standard hierarchy tree (1 = top-level division, 2 = sub-division, 3 = department, 4 = operational unit, etc.). Used to control report aggregation and drill-down navigation in management accounting dashboards.',
    `hub_airport_code` STRING COMMENT 'IATA three-letter airport code of the hub or base airport associated with this cost centre, where applicable (e.g., LHR for London Heathrow hub operations, JFK for New York hub, FRA for Frankfurt MRO base). Enables geographic cost attribution and hub-level CASK analysis. Null for non-location-specific centres.. Valid values are `^[A-Z]{3}$`',
    `iata_cost_category` STRING COMMENT 'IATA standard cost category classification for airline management accounting and industry benchmarking (e.g., Flight Operations, Maintenance, Passenger Services, Sales and Distribution, General and Administration). Enables CASK component benchmarking against IATA industry data. [ENUM-REF-CANDIDATE: Flight Operations|Maintenance|Passenger Services|Sales and Distribution|General and Administration|Cargo|Ground Operations — promote to reference product]',
    `ifrs16_lease_flag` BOOLEAN COMMENT 'Indicates whether this cost centre carries IFRS 16 right-of-use asset and lease liability obligations (e.g., aircraft operating leases, airport gate leases, hangar leases). True triggers inclusion in IFRS 16 lease liability reporting and depreciation of right-of-use assets. Critical for airline balance sheet compliance.',
    `interline_settlement_flag` BOOLEAN COMMENT 'Indicates whether this cost centre participates in interline billing settlement processes (IATA BSP/ARC). True for cost centres associated with interline revenue sharing, prorate agreements, and bilateral settlement with partner carriers. Drives inclusion in interline financial reconciliation workflows.',
    `internal_activity_rate` DECIMAL(18,2) COMMENT 'Planned cost rate per unit of activity output for this cost centre (in controlling area currency). Used for internal cost allocation between cost centres (e.g., cost per block hour charged from Flight Operations to Route cost centres). Recalculated each planning cycle. Classified confidential as it reflects internal transfer pricing.',
    `last_changed_by` STRING COMMENT 'SAP user ID of the person who last modified this cost centre master record. Supports audit trail requirements for financial master data governance and SOX compliance controls over cost centre maintenance.',
    `last_changed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this cost centre master record in SAP CO. Used for change tracking, incremental data extraction (delta loads), and audit compliance. Corresponds to SAP CDHDR change document header timestamp.',
    `profit_centre_code` STRING COMMENT 'SAP CO profit centre to which this cost centre is assigned for internal P&L reporting. Enables revenue attribution and profitability analysis at route, hub, or business segment level. Supports RASK/CASK analysis by profit centre.',
    `rask_attribution_flag` BOOLEAN COMMENT 'Indicates whether this cost centre participates in Revenue per Available Seat Kilometer (RASK) attribution for route profitability analysis. True for profit centres and revenue-generating units (e.g., route groups, lounges, ancillary services); False for pure cost centres (e.g., corporate functions, back-office).',
    `region_code` STRING COMMENT 'Geographic region code to which this cost centre is assigned for regional management reporting (e.g., EMEA, NORAM, APAC, LATAM, DOM for domestic). Supports regional P&L roll-up, CASK benchmarking by region, and DOT/EASA regional regulatory reporting.. Valid values are `^[A-Z]{2,6}$`',
    `short_name` STRING COMMENT 'Abbreviated name of the cost centre used in condensed reports, dashboards, and system displays where space is limited. Corresponds to SAP CO short text field (up to 20 characters).. Valid values are `^.{1,20}$`',
    `valid_from` DATE COMMENT 'Date from which this cost centre is valid and open for financial postings in SAP CO. Supports time-dependent master data management — cost centre attributes may change over time with new validity periods. Aligns with fiscal year planning cycles.',
    `valid_to` DATE COMMENT 'Date until which this cost centre is valid for financial postings. Null or 31-Dec-9999 indicates an open-ended validity. Used to manage cost centre lifecycle, seasonal operations (e.g., charter season cost centres), and organisational restructuring.',
    CONSTRAINT pk_cost_centre PRIMARY KEY(`cost_centre_id`)
) COMMENT 'SAP CO organisational unit master representing cost-incurring and profit-bearing responsibility centres within the airline — e.g., flight operations, cabin crew, MRO line/base stations, ground handling, airport lounges, cargo division, route groups (by hub, region), and corporate functions. Stores centre type (cost/profit), hierarchy level and parent, responsible manager, controlling area, validity periods, budget allocation references, revenue attribution rules, CASK/RASK allocation keys, and internal activity rates. Enables departmental P&L reporting, CASK component attribution, route profitability analysis, and management accounting by business segment.';

CREATE OR REPLACE TABLE `airlines_ecm`.`finance`.`accounts_payable` (
    `accounts_payable_id` BIGINT COMMENT 'Unique surrogate primary key for each vendor invoice record in the accounts payable ledger. Generated by the Databricks Silver Layer ingestion pipeline from SAP FI-AP document entries.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Each AP invoice belongs to ONE company code. The accounts_payable table has company_code (STRING) which should be replaced with a FK to the company_code master. This is a mandatory dimension in SAP FI',
    `cost_centre_id` BIGINT COMMENT 'Reference to the cost center to which this invoice expense is allocated, supporting CASK (Cost per Available Seat Kilometer) reporting and departmental cost accounting within SAP CO.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: AP invoices can be for the purchase or capitalization of fixed assets (aircraft, engines, ground equipment). A FK from accounts_payable to fixed_asset links the payment obligation to the asset being a',
    `fleet_order_id` BIGINT COMMENT 'Foreign key linking to fleet.fleet_order. Business justification: Aircraft purchase progress payments and delivery milestone invoices are AP transactions that must reference the originating fleet order for three-way matching, CAPEX payment tracking, and purchase ord',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: AP invoices and payments generate GL postings in SAP FI-AP. Every accounts_payable record corresponds to one or more GL entries. This FK normalizes the relationship between the AP sub-ledger and the g',
    `ground_handler_id` BIGINT COMMENT 'Foreign key linking to airport.ground_handler. Business justification: AP invoices are issued by ground handlers for ramp, baggage, and passenger handling services. Linking AP to the ground_handler vendor record enables vendor payment tracking, SLA-linked invoice validat',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: AP invoices for IFRS 16 lease payments should be linked to the lease contract. The accounts_payable table has ifrs16_lease_flag (BOOLEAN) indicating lease-related invoices, but no explicit FK. Adding ',
    `approval_status` STRING COMMENT 'Current status of the invoice within the internal approval workflow, reflecting authorization levels required before payment execution. Supports segregation of duties and internal controls per SOX compliance requirements.. Valid values are `pending|approved|rejected|escalated`',
    `bsp_arc_settlement_ref` STRING COMMENT 'The IATA Billing and Settlement Plan (BSP) or Airlines Reporting Corporation (ARC) settlement reference number for invoices settled through interline or agency billing cycles. Applicable for GDS provider fees, interline billing, and travel agency commission settlements.',
    `clearing_document_number` STRING COMMENT 'The SAP accounting document number of the payment document that cleared (settled) this open invoice item. Populated upon successful payment execution. Corresponds to SAP field AUGBL (Clearing Document). Null for unpaid invoices.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this accounts payable record was first created in the SAP FI-AP system, representing the initial document entry time. Used for audit trail, SLA monitoring of invoice processing cycle time, and data lineage.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The cash discount amount available if payment is made by the discount_due_date, as negotiated in the vendor payment terms. Supports working capital optimization and supplier relationship management.',
    `discount_due_date` DATE COMMENT 'The deadline by which early payment must be made to qualify for the cash discount offered under the vendors payment terms (e.g., 2/10 net 30). Supports cash flow optimization and working capital management.',
    `due_date` DATE COMMENT 'The calculated date by which payment must be made to the vendor to comply with agreed payment terms and avoid late payment penalties. Derived from invoice date plus payment term days. Corresponds to SAP field FAEDT (Net Due Date).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to translate the invoice currency amount to the local currency at the time of posting. Sourced from SAP exchange rate table (TCURR). Critical for FX exposure reporting and treasury operations.',
    `fiscal_period` STRING COMMENT 'The fiscal posting period (1–16, including special periods) within the fiscal year in which this invoice is recorded. Supports monthly accrual management and period-end close processes in SAP FI.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this vendor invoice is posted in SAP FI. Used for period-end closing, financial reporting, and year-over-year cost analysis. Corresponds to SAP field GJAHR.',
    `fuel_uplift_volume_liters` DECIMAL(18,2) COMMENT 'For fuel vendor invoices, the volume of jet fuel (Jet-A or Jet-A1) uplifted in liters as recorded on the fuel receipt. Supports fuel cost per liter analysis, CASK fuel component reporting, and CORSIA carbon emissions accounting. Null for non-fuel invoices.',
    `gl_account_code` STRING COMMENT 'The SAP general ledger account number to which the invoice expense is posted, enabling cost classification for financial reporting and CASK component analysis (e.g., fuel cost GL, MRO cost GL, airport charges GL). Corresponds to SAP field HKONT.. Valid values are `^[0-9]{6,10}$`',
    `goods_receipt_date` DATE COMMENT 'The date on which goods or services were confirmed as received, forming the third leg of the three-way match (PO → Goods Receipt → Invoice). Critical for MRO parts, fuel uplift, and catering deliveries. Corresponds to SAP MIGO goods receipt posting date.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total gross amount of the vendor invoice before deduction of taxes, withholding tax, or discounts, expressed in the invoice currency. Represents the full obligation as stated on the vendors invoice document.',
    `ifrs16_lease_flag` BOOLEAN COMMENT 'Indicates whether this invoice relates to a lease obligation subject to IFRS 16 Leases accounting treatment (e.g., aircraft dry lease, wet lease, ACMI lease payments, airport gate lease). When true, the payment is classified as a lease liability repayment rather than an operating expense.',
    `invoice_currency` STRING COMMENT 'The ISO 4217 three-letter currency code in which the vendor invoice is denominated (e.g., USD, EUR, GBP). May differ from the company code local currency, requiring foreign exchange translation for GL posting. Corresponds to SAP field WAERS.. Valid values are `^[A-Z]{3}$`',
    `invoice_date` DATE COMMENT 'The date printed on the vendors invoice document, representing the business event date for the supply of goods or services. Used as the baseline for payment term calculation and tax point determination. Corresponds to SAP field BLDAT.',
    `invoice_number` STRING COMMENT 'The externally-assigned invoice number as printed on the vendors invoice document. Used for vendor reconciliation, dispute resolution, and audit trail. Corresponds to SAP field BELNR (Accounting Document Number) or XBLNR (Reference Document Number).',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the vendor invoice within the SAP FI-AP workflow. open = posted and awaiting payment; parked = saved but not yet posted; blocked = payment block applied; in_approval = pending workflow approval; cleared = fully paid and cleared; cancelled = reversed/cancelled document.. Valid values are `open|parked|blocked|in_approval|cleared|cancelled`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this accounts payable record, capturing changes to approval status, payment block, or clearing information. Supports change data capture (CDC) in the Databricks Silver Layer pipeline.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The net payable amount translated into the company codes local (functional) currency using the exchange rate at posting date. Used for GL posting, financial reporting, and CASK calculation in the airlines reporting currency.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net amount payable to the vendor after deducting withholding tax and any applicable cash discounts from the gross invoice amount. Represents the actual cash outflow obligation. Calculated as gross_amount minus withholding_tax_amount minus discount_amount.',
    `payment_block_reason` STRING COMMENT 'Reason code explaining why a payment block has been applied to this invoice, preventing it from being included in the next payment run. Corresponds to SAP field ZLSPR (Payment Block Key). Null when no block is active.. Valid values are `dispute|price_variance|missing_gr|manual_hold|audit_review`',
    `payment_date` DATE COMMENT 'The actual date on which payment was executed to the vendor, either via bank transfer, cheque, or BSP/ARC settlement. Populated upon payment run completion. Corresponds to SAP clearing document value date.',
    `payment_method` STRING COMMENT 'The method by which payment is executed to the vendor. bank_transfer = SWIFT/SEPA wire; cheque = paper cheque; bsp_settlement = IATA Billing and Settlement Plan net settlement; arc_settlement = Airlines Reporting Corporation settlement; direct_debit = automated debit. Corresponds to SAP field ZLSCH.. Valid values are `bank_transfer|cheque|bsp_settlement|arc_settlement|direct_debit`',
    `payment_terms_code` STRING COMMENT 'The SAP payment terms key (e.g., NT30, NT60, 2/10N30) defining the agreed payment schedule, discount percentages, and due date calculation rules for this vendor. Corresponds to SAP field ZTERM.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'The date on which the vendor invoice is posted to the SAP general ledger, determining the accounting period for recognition. May differ from invoice date due to processing delays. Corresponds to SAP field BUDAT.',
    `sap_document_number` STRING COMMENT 'The internal SAP FI accounting document number (BELNR) assigned upon posting of the vendor invoice in the general ledger. Uniquely identifies the FI document within a company code and fiscal year.. Valid values are `^[0-9]{10}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount (VAT, GST, or applicable local tax) charged on the vendor invoice. Corresponds to SAP field WMWST. Used for input tax recovery and tax reporting to national revenue authorities.',
    `tax_code` STRING COMMENT 'The SAP tax code identifying the applicable tax rate and tax type (input VAT, zero-rated, exempt) for this invoice line. Drives automated tax calculation and input tax recovery reporting. Corresponds to SAP field MWSKZ.. Valid values are `^[A-Z0-9]{2}$`',
    `three_way_match_status` STRING COMMENT 'Result of the automated three-way match validation comparing the purchase order, goods receipt, and vendor invoice for quantity and price alignment. matched = all three documents agree; price_variance = invoice price differs from PO; quantity_variance = invoice quantity differs from GR; pending_gr = goods receipt not yet confirmed; failed = match failed requiring manual review.. Valid values are `matched|price_variance|quantity_variance|pending_gr|failed`',
    `vendor_category` STRING COMMENT 'Classification of the vendor type supplying goods or services to the airline. Drives cost allocation to CASK components and supports spend analytics by supplier category. [ENUM-REF-CANDIDATE: mro_supplier|fuel_vendor|airport_authority|gds_provider|catering|ground_handling|bsp_arc — promote to reference product]',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax (WHT) to be deducted from the vendor payment and remitted to the tax authority on behalf of the vendor. Applicable for cross-border supplier payments subject to bilateral tax treaties. Corresponds to SAP Extended Withholding Tax (WITH_ITEM).',
    CONSTRAINT pk_accounts_payable PRIMARY KEY(`accounts_payable_id`)
) COMMENT 'SAP FI-AP vendor invoice and payment obligation records for the airline covering MRO suppliers, fuel vendors, airport authorities, GDS providers, catering contractors, and ground handling agents. Each record represents a vendor invoice document with invoice number, vendor ID, invoice date, line items, tax amounts, purchase order reference, goods receipt reference, three-way match status, payment terms, due dates, withholding tax, approval workflow status, payment execution details (method, bank, value date, clearing document), and BSP/ARC settlement obligations. Supports procure-to-pay lifecycle, cash flow forecasting, and supplier payment runs.';

CREATE OR REPLACE TABLE `airlines_ecm`.`finance`.`accounts_receivable` (
    `accounts_receivable_id` BIGINT COMMENT 'Unique surrogate identifier for each accounts receivable record in the SAP FI-AR module. Primary key for the silver layer lakehouse table.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Each AR document belongs to ONE company code. The accounts_receivable table has company_code (STRING) which should be replaced with a FK to the company_code master. This is a mandatory dimension in SA',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: AR invoices and collections generate GL postings in SAP FI-AR. Every accounts_receivable record corresponds to GL entries. This FK normalizes the AR sub-ledger to general ledger relationship, consiste',
    `interline_billing_id` BIGINT COMMENT 'Foreign key linking to finance.interline_billing. Business justification: Interline billing settlements generate AR records when partner airlines owe the airline money. An AR record for interline revenue should reference the originating interline_billing record. This FK lin',
    `ageing_bucket` STRING COMMENT 'Ageing classification of the open receivable based on days past due date: CURRENT (not yet due), 1_30_DAYS, 31_60_DAYS, 61_90_DAYS, 91_120_DAYS, OVER_120_DAYS. Drives credit risk assessment and bad debt provisioning under IFRS 9 expected credit loss model.. Valid values are `CURRENT|1_30_DAYS|31_60_DAYS|61_90_DAYS|91_120_DAYS|OVER_120_DAYS`',
    `ar_status` STRING COMMENT 'Current lifecycle status of the receivable: OPEN (unpaid), PARTIALLY_PAID (partial payment received), CLEARED (fully paid and matched), DISPUTED (customer dispute raised), WRITTEN_OFF (bad debt write-off applied), IN_DUNNING (active dunning process initiated).. Valid values are `OPEN|PARTIALLY_PAID|CLEARED|DISPUTED|WRITTEN_OFF|IN_DUNNING`',
    `bank_value_date` DATE COMMENT 'Value date on which funds were credited to the airlines bank account for this receivable. Distinct from posting date; used for treasury cash flow forecasting and bank reconciliation.',
    `bsp_arc_billing_period` STRING COMMENT 'IATA BSP or ARC billing period identifier (e.g., 2024-W03 for weekly cycle) to which this agency receivable belongs. Supports settlement reconciliation and dispute management with travel agencies.',
    `clearing_date` DATE COMMENT 'Date on which the receivable was fully cleared (matched against incoming payment or credit memo) in SAP. Null for open items. Used for Days Sales Outstanding (DSO) calculation.',
    `clearing_document_number` STRING COMMENT 'SAP document number of the payment or credit memo that cleared this receivable. Enables end-to-end payment reconciliation and audit trail from invoice to settlement.',
    `cost_center` STRING COMMENT 'SAP cost center associated with the receivable for internal cost allocation and CASK (Cost per Available Seat Kilometer) reporting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the AR record was first created in the source SAP FI-AR system. Provides audit trail for record origination and supports data lineage in the lakehouse silver layer.',
    `credit_control_area` STRING COMMENT 'SAP credit control area (KKBER) under which the customers credit limit is managed. Groups customers for credit exposure monitoring across company codes.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Approved credit limit assigned to the customer in the credit control area, expressed in the credit control area currency. Used for credit exposure monitoring and order block decisions.',
    `customer_account_number` STRING COMMENT 'SAP debtor account number (KUNNR) identifying the customer — travel agency, corporate account, interline carrier, or cargo shipper — against whom the receivable is raised.',
    `customer_name` STRING COMMENT 'Legal name of the debtor customer as maintained in SAP customer master. Covers travel agencies, corporate accounts, interline carriers, and cargo clients.',
    `days_overdue` STRING COMMENT 'Number of calendar days the receivable is past its due date as of the last refresh date. Negative values indicate days until due. Used for DSO reporting and credit risk monitoring.',
    `dispute_reason_code` STRING COMMENT 'Standardized code identifying the reason for a customer dispute on this receivable (e.g., pricing discrepancy, duplicate billing, service not rendered, ADM — Agency Debit Memo dispute). Null when no dispute exists. [ENUM-REF-CANDIDATE: PRICE_DISCREPANCY|DUPLICATE_BILLING|SERVICE_NOT_RENDERED|ADM_DISPUTE|CREDIT_NOT_APPLIED|INTERLINE_PRORATE_DIFF — promote to reference product]',
    `document_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the AR document amounts are denominated (e.g., USD, EUR, GBP). Supports multi-currency airline operations and foreign exchange reporting.. Valid values are `^[A-Z]{3}$`',
    `document_number` STRING COMMENT 'SAP FI-AR accounting document number uniquely identifying the receivable posting within the company code. Corresponds to BELNR field in SAP BSID/BSAD tables.',
    `document_type` STRING COMMENT 'SAP document type code classifying the nature of the AR posting: DR (customer invoice), DG (credit memo), DA (customer document), RV (billing document transfer), AB (accounting document). Drives posting logic and account determination.. Valid values are `DR|DG|DA|RV|AB`',
    `due_date` DATE COMMENT 'Date by which payment is contractually due from the customer, calculated from invoice date plus payment terms (e.g., BSP weekly settlement cycle, net 30 corporate terms). Key input for ageing bucket classification and dunning.',
    `dunning_level` STRING COMMENT 'Current dunning level (1–4) assigned to this receivable in SAP dunning program, indicating the escalation stage of the collection notice. Level 0 means no dunning initiated.',
    `fiscal_period` STRING COMMENT 'Accounting period (1–16 including special periods) within the fiscal year in which the AR document was posted. Supports month-end and period-end financial close.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the AR document was posted, as defined in the SAP fiscal year variant. Used for period-end close and financial consolidation reporting.',
    `gl_account` STRING COMMENT 'SAP general ledger account number to which the receivable is posted (e.g., trade receivables, interline receivables, cargo receivables). Drives financial statement classification.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount of the receivable before any discounts, taxes, or adjustments, expressed in the document currency. Represents the face value of the invoice or billing document.',
    `interline_carrier_code` STRING COMMENT 'Two or three-character IATA airline designator code of the interline partner carrier for interline receivable types. Null for non-interline receivables. Supports interline prorate and settlement reconciliation.. Valid values are `^[A-Z0-9]{2,3}$`',
    `invoice_date` DATE COMMENT 'Date on which the invoice or billing document was issued to the customer. Used for revenue recognition, ageing bucket calculation, and payment terms baseline.',
    `last_dunning_date` DATE COMMENT 'Date on which the most recent dunning notice was issued to the customer for this receivable. Used to track collection activity and enforce dunning intervals.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the AR record in the source SAP FI-AR system, including payment postings, dunning updates, or status changes. Supports incremental data loading in the lakehouse.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Open receivable amount translated to the company code local currency using the SAP exchange rate type at posting date. Required for statutory financial reporting and consolidation.',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the company code local (functional) currency to which document amounts are translated for statutory reporting.. Valid values are `^[A-Z]{3}$`',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount due from the customer after deducting applicable discounts and adjustments but before tax. Used for revenue recognition and working capital reporting.',
    `open_amount` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the receivable at the current point in time, calculated as gross amount minus payments received and credit memos applied. Core field for working capital management and ageing analysis.',
    `payment_method` STRING COMMENT 'Method by which payment was or is expected to be received: BANK_TRANSFER (wire/SWIFT), BSP_SETTLEMENT (IATA Billing and Settlement Plan automated settlement), ARC_SETTLEMENT (Airlines Reporting Corporation settlement), CREDIT_CARD, DIRECT_DEBIT, CHEQUE.. Valid values are `BANK_TRANSFER|BSP_SETTLEMENT|ARC_SETTLEMENT|CREDIT_CARD|DIRECT_DEBIT|CHEQUE`',
    `payment_terms_code` STRING COMMENT 'SAP payment terms key (ZTERM) defining the contractual payment conditions, discount periods, and due date calculation rules applicable to this receivable (e.g., BSP weekly, net 30, net 60).',
    `posting_date` DATE COMMENT 'Date on which the AR document was posted to the general ledger in SAP. Determines the fiscal period assignment and is the basis for period-end cut-off.',
    `profit_center` STRING COMMENT 'SAP profit center to which the receivable revenue is attributed, enabling segment-level P&L reporting by route, cabin class, or business unit within the airline.',
    `receivable_type` STRING COMMENT 'Classification of the receivable by originating business channel: BSP_AGENCY (IATA Billing and Settlement Plan agency), ARC_AGENCY (Airlines Reporting Corporation agency), CORPORATE (direct corporate account billing), INTERLINE (interline carrier settlement), CARGO_AWB (Air Waybill cargo collection), ANCILLARY (ancillary service charges such as excess baggage, upgrades).. Valid values are `BSP_AGENCY|ARC_AGENCY|CORPORATE|INTERLINE|CARGO_AWB|ANCILLARY`',
    `reconciliation_status` STRING COMMENT 'Status of the receivable reconciliation against the originating billing system (BSP, ARC, cargo system, or ancillary billing): MATCHED (confirmed and reconciled), UNMATCHED (discrepancy identified), DISPUTED (formal dispute raised), PENDING_REVIEW (awaiting finance review).. Valid values are `MATCHED|UNMATCHED|DISPUTED|PENDING_REVIEW`',
    `reference_document` STRING COMMENT 'External reference number associated with the receivable, such as the BSP billing period reference, ARC settlement report number, Air Waybill (AWB) number for cargo, or PNR for passenger billings. Enables cross-system reconciliation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the receivable including applicable government taxes, Passenger Facility Charges (PFC), and other statutory levies included in the invoice. Supports tax reporting and reconciliation.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount written off as bad debt for this receivable, in document currency. Populated when ar_status is WRITTEN_OFF. Supports bad debt expense reporting and IFRS 9 expected credit loss provisioning.',
    CONSTRAINT pk_accounts_receivable PRIMARY KEY(`accounts_receivable_id`)
) COMMENT 'SAP FI-AR customer receivable and collection records for the airline covering travel agency BSP/ARC settlements, corporate account billings, interline receivables, cargo AWB collections, ancillary service charges, and incoming payment receipts. Tracks invoice issuance, payment receipt (method, bank, value date, clearing reference), dunning status, credit limits, ageing buckets, and reconciliation status. Supports revenue recognition, working capital management, and customer credit risk monitoring.';

CREATE OR REPLACE TABLE `airlines_ecm`.`finance`.`budget_plan` (
    `budget_plan_id` BIGINT COMMENT 'Unique surrogate identifier for the budget plan record in the finance data product. Primary key for the budget_plan entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Each budget plan belongs to ONE company code. The budget_plan table has company_code (STRING) which should be replaced with a FK to the company_code master. Budget plans are company-code specific in S',
    `general_ledger_id` BIGINT COMMENT 'Reference to the General Ledger account code in SAP FI against which this budget plan is posted. Enables GL-level budget vs. actuals reporting.',
    `cost_centre_id` BIGINT COMMENT 'Reference to the SAP CO cost centre to which this budget plan is assigned. Enables cost centre-level budget tracking and variance analysis across airline operational divisions.',
    `approval_date` DATE COMMENT 'The date on which the budget plan received final approval from the designated authority (CFO, board, or budget committee). Marks the transition from submitted to approved status in the workflow.',
    `ask_budget` DECIMAL(18,2) COMMENT 'Budgeted Available Seat Kilometers (ASK) for the planning period, representing planned capacity output. ASK is the industry-standard capacity metric (seats × kilometers flown). Used as the denominator for CASK and RASK budget calculations.',
    `budget_category` STRING COMMENT 'High-level financial category of the budget plan. OPEX = Operating Expenditure; CAPEX = Capital Expenditure; REVENUE = Revenue budget; MIXED = combined OPEX and CAPEX plan. Aligns with SAP CO-PA cost element categories.. Valid values are `OPEX|CAPEX|REVENUE|MIXED`',
    `capex_budget_amount` DECIMAL(18,2) COMMENT 'Budgeted amount allocated to capital expenditure (CAPEX) within this plan, including aircraft acquisitions, fleet modifications, and infrastructure investments. Supports IFRS 16 lease liability planning.',
    `cask_budget` DECIMAL(18,2) COMMENT 'Budgeted Cost per Available Seat Kilometer (CASK), calculated as total OPEX budget divided by ASK budget. Expressed in currency units per ASK. Primary airline unit cost efficiency metric used in board-level financial planning and investor reporting.',
    `consolidation_level` STRING COMMENT 'The organisational level at which this budget plan is consolidated. entity = legal entity; division = business division (e.g., cargo, MRO); group = airline group; segment = IFRS 8 reportable segment. Supports financial consolidation and group reporting.. Valid values are `entity|division|group|segment`',
    `controlling_area_code` STRING COMMENT 'The SAP CO controlling area code under which this budget plan is managed. The controlling area defines the organisational unit for internal cost accounting and profitability analysis in SAP CO-PA.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget plan record was first created in the system. Supports audit trail requirements and data lineage tracking in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the budget amounts are denominated (e.g., USD, EUR, GBP). Supports multi-currency airline operations and IATA BSP settlement reporting.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'The start date from which this budget plan is effective and binding for financial control purposes. Aligns with the fiscal period start in SAP FI.',
    `effective_until` DATE COMMENT 'The end date through which this budget plan remains effective. Null for open-ended multi-year plans. Aligns with fiscal period end in SAP FI.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget plan primarily applies (e.g., 2025). Used for period-based financial reporting and alignment with SAP FI fiscal year variants.',
    `forecast_cycle` STRING COMMENT 'The frequency at which this rolling forecast budget plan is updated and resubmitted. Applicable only when is_rolling_forecast is True. Supports planning cadence governance.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `fuel_cost_budget_amount` DECIMAL(18,2) COMMENT 'Budgeted amount specifically allocated to jet fuel procurement and uplift costs. Fuel is typically the largest single OPEX line for airlines. Supports fuel cost accounting and hedging strategy alignment.',
    `interline_settlement_budget_amount` DECIMAL(18,2) COMMENT 'Budgeted net interline billing settlement amount payable or receivable through IATA BSP/ARC for interline ticketing agreements with partner carriers. Supports interline prorate and billing reconciliation planning.',
    `is_rolling_forecast` BOOLEAN COMMENT 'Indicates whether this budget plan is part of a rolling forecast cycle (True) or a fixed annual budget (False). Rolling forecasts are updated periodically (monthly/quarterly) to reflect current business conditions.',
    `lease_liability_budget_amount` DECIMAL(18,2) COMMENT 'Budgeted amount for aircraft and facility lease liabilities recognised under IFRS 16. Covers both operating lease right-of-use asset depreciation and interest on lease liabilities for dry lease and ACMI arrangements.',
    `load_factor_budget_pct` DECIMAL(18,2) COMMENT 'Budgeted passenger load factor expressed as a percentage (e.g., 82.50 = 82.5%). Load factor is the percentage of available seats filled by revenue passengers. Used in revenue budget planning and yield management alignment.',
    `locked_date` DATE COMMENT 'The date on which the budget plan was locked to prevent further modifications, marking the start of the execution period. Locked budgets serve as the baseline for variance reporting.',
    `notes` STRING COMMENT 'Free-text field for budget planners and approvers to record assumptions, justifications, revision rationale, or board commentary associated with this budget plan version.',
    `opex_budget_amount` DECIMAL(18,2) COMMENT 'Budgeted amount allocated to operating expenditure (OPEX) within this plan, including fuel, crew, maintenance, airport charges, and overhead. Key input for CASK (Cost per Available Seat Kilometer) reporting.',
    `plan_name` STRING COMMENT 'Human-readable descriptive name of the budget plan (e.g., FY2025 Annual Operating Budget, Q3 2025 Rolling Forecast). Used for display and reporting purposes.',
    `plan_number` STRING COMMENT 'Externally-known alphanumeric identifier for the budget plan, aligned with SAP BPC plan version numbering (e.g., BP-2025-001). Used for cross-system reference and audit trails.',
    `plan_status` STRING COMMENT 'Current lifecycle state of the budget plan within the approval workflow. draft = in preparation; submitted = awaiting review; under_review = being evaluated; approved = board/CFO approved; rejected = returned for revision; locked = frozen for execution; archived = superseded. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|locked|archived — promote to reference product]',
    `plan_type` STRING COMMENT 'Classification of the budget plan by planning methodology. annual = full-year fixed budget; rolling_forecast = continuously updated forecast; supplemental = mid-year adjustment; capital = CAPEX-specific plan; zero_based = zero-based budgeting cycle.. Valid values are `annual|rolling_forecast|supplemental|capital|zero_based`',
    `plan_version` STRING COMMENT 'Version identifier of the budget plan, supporting iterative planning cycles (e.g., v1.0, v2.3, RF-Q2). Enables tracking of revisions and rolling forecast iterations within SAP BPC.',
    `planning_horizon_years` STRING COMMENT 'Number of years covered by this budget plan (e.g., 1 for annual, 3 or 5 for multi-year strategic plans). Supports long-range financial planning and IFRS 16 lease liability projections.',
    `rask_budget` DECIMAL(18,2) COMMENT 'Budgeted Revenue per Available Seat Kilometer (RASK), calculated as total revenue budget divided by ASK budget. Expressed in currency units per ASK. Key airline revenue productivity metric for strategic planning and investor reporting.',
    `revenue_budget_amount` DECIMAL(18,2) COMMENT 'Budgeted revenue target for the planning period, covering passenger revenue, cargo revenue, ancillary services, and loyalty program income. Supports RASK (Revenue per Available Seat Kilometer) planning.',
    `submission_date` DATE COMMENT 'The date on which the budget plan was formally submitted for review and approval. Supports planning cycle governance and deadline tracking.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'The gross total budgeted amount for this plan in the plan currency, covering all line items. Represents the top-line financial commitment approved for the planning period. Used for board-level financial reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this budget plan record was last modified. Tracks the most recent change for audit trail, version control, and incremental data pipeline processing in the Databricks Silver Layer.',
    `variance_threshold_amount` DECIMAL(18,2) COMMENT 'The maximum allowable absolute monetary deviation between budgeted and actual amounts before a variance alert is triggered. Complements the percentage threshold for large-value budget lines where a fixed amount cap is more appropriate.',
    `variance_threshold_pct` DECIMAL(18,2) COMMENT 'The maximum allowable percentage deviation between budgeted and actual amounts before a variance alert is triggered for management review. Expressed as a percentage (e.g., 5.00 = 5%). Supports financial control and exception reporting.',
    CONSTRAINT pk_budget_plan PRIMARY KEY(`budget_plan_id`)
) COMMENT 'Annual and multi-year financial budget plans for the airline covering operating expenditure (OPEX), capital expenditure (CAPEX), and revenue budgets by cost centre, profit centre, and GL account. Stores budget version, planning horizon, approval status, budget owner, and variance thresholds. Supports rolling forecast cycles and board-level financial planning aligned with SAP CO-PA and BPC modules.';

CREATE OR REPLACE TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` (
    `fuel_cost_transaction_id` BIGINT COMMENT 'Unique surrogate identifier for each fuel cost transaction record in the finance domain silver layer. Primary key for this data product.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Fuel uplifts generate AP invoices from fuel suppliers. fuel_cost_transaction has supplier_invoice_number (STRING) which is a denormalized reference to the AP document. A direct FK to accounts_payable ',
    `cost_centre_id` BIGINT COMMENT 'Reference to the cost centre in SAP S/4HANA CO to which the fuel cost is allocated. Enables departmental cost accountability and CASK fuel component reporting by operating unit.',
    `flight_leg_id` BIGINT COMMENT 'Reference to the specific flight leg for which fuel was uplifted. Enables CASK (Cost per Available Seat Kilometer) fuel component attribution at the flight level.',
    `fuel_uplift_id` BIGINT COMMENT 'Reference to the physical fuel uplift event recorded in flight operations (Jeppesen / NetLine/Ops). Links the financial accounting entry back to the operational fuel uplift record for CASK reconciliation.',
    `general_ledger_id` BIGINT COMMENT 'Reference to the General Ledger account in SAP S/4HANA FI to which this fuel cost is posted. Supports financial consolidation and regulatory financial reporting.',
    `accounting_period` STRING COMMENT 'Financial accounting period (YYYY-MM) to which this fuel cost is assigned in SAP S/4HANA FI. Determines which monthly P&L period absorbs the cost. May differ from the uplift month due to accruals or late invoices.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `airport_iata_code` STRING COMMENT 'Three-letter IATA airport code identifying the station where the fuel uplift occurred (e.g., LHR, JFK, DXB). Used for geographic cost analysis, into-plane agent reconciliation, and fuel price benchmarking by station.. Valid values are `^[A-Z]{3}$`',
    `carbon_emission_kg` DECIMAL(18,2) COMMENT 'Estimated CO2-equivalent carbon emissions in kilograms attributable to this fuel uplift, calculated using ICAO/CORSIA emission factors applied to the fuel quantity and SAF blend. Required for CORSIA offsetting obligations and ESG regulatory reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel cost transaction record was first created in the source system (SAP S/4HANA). Supports audit trail and data lineage requirements.',
    `dispute_reference` STRING COMMENT 'Reference number of any active or resolved supplier dispute raised against this fuel cost transaction (e.g., quantity discrepancy, pricing error). Populated when transaction_status = disputed. Used for accounts payable dispute management.',
    `fiscal_year` STRING COMMENT 'Fiscal year (e.g., 2024) to which this fuel cost transaction belongs in SAP S/4HANA FI. Used for annual financial reporting, budget vs. actual variance analysis, and year-end close.',
    `fuel_density` DECIMAL(18,2) COMMENT 'Measured fuel density in kilograms per litre at the time of uplift, as recorded on the fuel delivery receipt. Used to reconcile volumetric (litres) and mass (kg) quantities and to validate fuel quality compliance.',
    `fuel_supplier_name` STRING COMMENT 'Name of the fuel supplier (oil major or independent) who provided the fuel (e.g., Shell Aviation, BP Aviation, ExxonMobil Aviation, World Fuel Services). Used for supplier spend analysis and contract compliance monitoring.',
    `fuel_type` STRING COMMENT 'Type of aviation fuel uplifted. Jet-A1 is the standard international jet fuel; SAF is Sustainable Aviation Fuel; Jet-A is the US domestic equivalent; TS-1 is Russian-standard jet fuel; JP-8 is military-grade. Critical for CORSIA carbon accounting and SAF blending cost tracking.. Valid values are `Jet-A1|SAF|Jet-A|TS-1|JP-8`',
    `functional_currency_amount` DECIMAL(18,2) COMMENT 'Net fuel cost translated into the airlines functional (reporting) currency using the exchange rate at the posting date. Required for consolidated P&L reporting and CASK calculation in a single currency.',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert the transaction currency amount to the functional currency at the posting date. Sourced from SAP S/4HANA treasury exchange rate tables. Required for IFRS IAS 21 compliance.',
    `gross_cost_amount` DECIMAL(18,2) COMMENT 'Total gross cost of the fuel uplift before any discounts, surcharges, or tax adjustments, in the transaction currency. Calculated as quantity × unit price. Base figure for CASK fuel component reporting.',
    `hedge_gain_loss_amount` DECIMAL(18,2) COMMENT 'Monetary gain or loss on the fuel hedge for this uplift, calculated as (hedged_unit_price - actual unit_price) × quantity. Positive = hedge gain (actual price exceeded hedged price); negative = hedge loss. Posted to the hedge reserve in OCI under IFRS 9.',
    `hedged_unit_price` DECIMAL(18,2) COMMENT 'The locked-in fuel price per litre from the hedging contract applicable to this uplift. Compared against the actual unit_price to calculate hedge gain/loss and measure hedge effectiveness per IFRS 9.',
    `ifrs16_lease_flag` BOOLEAN COMMENT 'Indicates whether the fuel cost is associated with a wet lease or ACMI (Aircraft Crew Maintenance Insurance) arrangement where fuel costs are embedded in the lease liability under IFRS 16. True = IFRS 16 lease-related fuel cost; False = standard fuel purchase.',
    `into_plane_agent_name` STRING COMMENT 'Name of the into-plane fuelling agent responsible for the physical delivery of fuel to the aircraft at the airport (may differ from the fuel supplier). Into-plane agents are contracted separately and charge a service fee included in the surcharge amount.',
    `net_cost_amount` DECIMAL(18,2) COMMENT 'Net total cost of the fuel uplift after applying discounts and adjustments but inclusive of taxes and surcharges, in the transaction currency. This is the amount posted to the General Ledger and used for CASK fuel component reporting.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the fuel accounting team regarding this transaction (e.g., reason for reversal, manual adjustment justification, AOG emergency uplift context). Supports audit trail and exception management.',
    `posting_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel cost was posted to the General Ledger in SAP S/4HANA FI. Used for period-end close, accrual management, and financial reporting cut-off.',
    `purchase_order_number` STRING COMMENT 'SAP S/4HANA purchase order number raised for the fuel procurement at this station. Links the financial posting to the procurement process for three-way matching and spend analytics.',
    `quantity_kg` DECIMAL(18,2) COMMENT 'Mass of fuel uplifted expressed in kilograms. The operationally authoritative unit for flight planning and weight-and-balance. Used for CASK fuel component calculation (cost per ASK) and fuel hedge effectiveness measurement.',
    `quantity_litres` DECIMAL(18,2) COMMENT 'Volume of fuel uplifted expressed in litres. Standard volumetric unit used for into-plane agent invoicing and fuel supplier billing. Used alongside quantity_kg for density reconciliation.',
    `saf_blend_percentage` DECIMAL(18,2) COMMENT 'Percentage of Sustainable Aviation Fuel (SAF) in the total fuel uplift volume (0.00–100.00). Required for CORSIA carbon offsetting calculations, SAF mandate compliance reporting, and ESG/sustainability disclosures.',
    `tax_and_surcharge_amount` DECIMAL(18,2) COMMENT 'Total taxes, levies, and into-plane service surcharges applied to the fuel uplift in the transaction currency. Includes Passenger Facility Charges (PFC) where applicable, fuel throughput fees, and local fuel taxes.',
    `transaction_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the fuel cost transaction is denominated (e.g., USD, EUR, GBP). May differ from the company code currency requiring FX translation for consolidated reporting.. Valid values are `^[A-Z]{3}$`',
    `transaction_number` STRING COMMENT 'Externally-known business document number assigned by SAP S/4HANA FI at the time of financial posting (e.g., FI document number or material document number). Used for audit trail and cross-system reconciliation.',
    `transaction_status` STRING COMMENT 'Current lifecycle state of the fuel cost transaction in the financial system. posted = FI document posted to GL; reversed = reversal document created; pending = awaiting invoice matching; disputed = under supplier dispute; cancelled = voided prior to posting.. Valid values are `posted|reversed|pending|disputed|cancelled`',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per litre (or per metric tonne where applicable) charged by the fuel supplier or into-plane agent for this uplift. Commercially sensitive. Used for fuel price variance analysis and hedge effectiveness measurement.',
    `unit_price_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the unit price is denominated (e.g., USD, EUR, GBP). Fuel is typically priced in USD at international stations; local currency may apply at domestic stations.. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this fuel cost transaction record. Tracks reversals, price adjustments, and dispute resolutions for audit compliance.',
    `uplift_source_type` STRING COMMENT 'Method by which fuel was delivered to the aircraft: hydrant = airport hydrant system; bowser = mobile fuel tanker truck; pipeline = direct pipeline connection; barge = waterborne fuel barge (seaplane/amphibious operations). Affects into-plane service fee rates.. Valid values are `hydrant|bowser|pipeline|barge`',
    `uplift_timestamp` TIMESTAMP COMMENT 'Date and time (UTC) when the physical fuel uplift occurred at the airport. This is the principal real-world business event time, distinct from the financial posting timestamp. Critical for matching operational fuel records to financial entries.',
    CONSTRAINT pk_fuel_cost_transaction PRIMARY KEY(`fuel_cost_transaction_id`)
) COMMENT 'Granular fuel uplift cost records linking each physical fuel uplift event (from flight operations) to its financial accounting entry. Captures fuel quantity (litres/kg), unit price, total cost, currency, fuel supplier, into-plane agent, airport IATA code, fuel type (Jet-A1, SAF), hedging contract reference, and cost centre allocation. Critical for CASK fuel component reporting and fuel hedge effectiveness measurement.';

CREATE OR REPLACE TABLE `airlines_ecm`.`finance`.`lease_contract` (
    `lease_contract_id` BIGINT COMMENT 'Unique surrogate identifier for the IFRS 16 lease contract record within the finance data platform. Primary key for the lease_contract data product.',
    `base_id` BIGINT COMMENT 'Foreign key linking to crew.crew_base. Business justification: Aircraft and facility leases associated with crew bases for base operating cost allocation, hub economics analysis, and IFRS 16 lease accounting. Essential for base profitability and cost attribution.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: IFRS 16 lease contracts are entered into by a specific legal entity represented as a company_code in SAP. Every lease contract must be associated with the company code of the lessee entity for financi',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Each lease contract is assigned to ONE cost center for cost allocation. The lease_contract table has cost_centre_code (STRING) which should be replaced with a FK to the cost_centre master.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: The legal_entity product description explicitly states it is Referenced by lessee_entity_id, confirming that lease_contract should carry a lessee_entity_id FK to legal_entity. Under IFRS 16, the les',
    `asset_category` STRING COMMENT 'High-level asset class of the underlying leased asset. Used for IFRS 16 disclosure note groupings (right-of-use asset classes) and fleet planning integration.. Valid values are `aircraft|engine|spare_part_pool|property`',
    `asset_registration` STRING COMMENT 'ICAO/national civil aviation authority tail number or asset registration identifier for the leased aircraft or engine (e.g., N-number, G-prefix). Null for property leases and spare part pool agreements. Links to fleet planning and MRO systems.',
    `commencement_date` DATE COMMENT 'Date on which the lessor makes the underlying asset available for use by the lessee. This is the IFRS 16 commencement date from which the right-of-use (ROU) asset and lease liability are initially recognised on the balance sheet.',
    `contract_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which lease payments are denominated (e.g., USD for US Dollar, EUR for Euro). Aircraft leases are predominantly USD-denominated. Drives FX translation to functional currency for IFRS reporting.. Valid values are `^[A-Z]{3}$`',
    `contract_number` STRING COMMENT 'Externally-known, human-readable contract reference number assigned by the lessor or jointly agreed at execution. Used for correspondence, audit trails, and SAP S/4HANA FI-AA lease object identification.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the lease contract. Drives IFRS 16 accounting treatment and GL journal generation. modified indicates a lease modification event has been processed per IFRS 16 paragraph 44.. Valid values are `draft|active|modified|terminated|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lease contract record was first created in the finance data platform. Supports audit trail, data lineage, and IFRS 16 initial recognition date verification.',
    `discount_rate_pct` DECIMAL(18,2) COMMENT 'Annual discount rate used to calculate the present value of future lease payments. Represents the rate implicit in the lease if readily determinable; otherwise the lessees incremental borrowing rate (IBR) as determined by the treasury function. Stored as a decimal fraction (e.g., 0.045000 = 4.5%).',
    `expiry_date` DATE COMMENT 'Contractual end date of the non-cancellable lease term as stated in the executed agreement, before consideration of renewal or termination options. Used as the base for lease term calculation and amortisation schedule generation.',
    `functional_currency` STRING COMMENT 'ISO 4217 three-letter currency code of the reporting entitys functional currency. Used for translating the lease liability and ROU asset from contract currency to functional currency per IAS 21.. Valid values are `^[A-Z]{3}$`',
    `gl_lease_liability_account` STRING COMMENT 'SAP S/4HANA GL account code for the lease liability balance sheet line. Supports automated posting of opening balance, interest accrual, and principal repayment journal entries.',
    `gl_rou_asset_account` STRING COMMENT 'SAP S/4HANA GL account code for the right-of-use asset balance sheet line. Used for automated journal entry generation for initial recognition, depreciation, and derecognition of the ROU asset.',
    `governing_law` STRING COMMENT 'Legal jurisdiction whose laws govern the lease contract (e.g., English Law, New York Law, Irish Law). Relevant for dispute resolution, enforcement, and cross-border lease structuring common in aviation.',
    `ifrs16_exemption_type` STRING COMMENT 'Indicates whether the lease qualifies for a recognition exemption under IFRS 16. short_term = lease term of 12 months or less at commencement; low_value = underlying asset value below the entitys low-value threshold (typically USD 5,000); none = full IFRS 16 recognition required.. Valid values are `none|short_term|low_value`',
    `last_modification_date` DATE COMMENT 'Date of the most recent lease modification event (e.g., extension of lease term, change in lease payments, change in scope). Triggers remeasurement of the lease liability at the revised discount rate.',
    `lease_liability_opening` DECIMAL(18,2) COMMENT 'Present value of the lease payments not yet made at the commencement date, discounted at the incremental borrowing rate (IBR) or the rate implicit in the lease. This is the initial recognition amount of the lease liability on the balance sheet.',
    `lease_term_months` STRING COMMENT 'Total lease term in whole months as determined under IFRS 16, including the non-cancellable period plus any optional renewal periods that the lessee is reasonably certain to exercise, and excluding optional termination periods the lessee is reasonably certain to exercise.',
    `lease_type` STRING COMMENT 'Classification of the lease by asset category and operational arrangement. Dry lease = aircraft without crew; wet lease / ACMI (Aircraft Crew Maintenance Insurance) = aircraft with crew, maintenance, and insurance; engine_lease = standalone engine; spare_part_pool = access agreement for pooled spare parts; property_lease = airport lounges, hangars, office space. Determines IFRS 16 scope and disclosure grouping.. Valid values are `dry_lease|wet_lease_acmi|engine_lease|spare_part_pool|property_lease`',
    `lessor_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the lessors registered jurisdiction. Relevant for withholding tax treatment, OECD transfer pricing, and cross-border lease disclosure.. Valid values are `^[A-Z]{3}$`',
    `maintenance_reserve_flag` BOOLEAN COMMENT 'Indicates whether the lease contract includes maintenance reserve payments (common in aircraft dry leases). Maintenance reserves are typically excluded from IFRS 16 lease liability measurement and treated as variable lease payments or prepaid maintenance.',
    `modification_count` STRING COMMENT 'Running count of the number of lease modifications processed against this contract since commencement. Each modification triggers remeasurement of the lease liability and ROU asset per IFRS 16 paragraphs 44–46. Supports audit trail and modification history tracking.',
    `payment_frequency` STRING COMMENT 'Frequency at which fixed lease payments are contractually due. Determines the period length used in the amortisation schedule and GL journal entry generation cadence.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `payment_in_advance_flag` BOOLEAN COMMENT 'Indicates whether lease payments are due at the beginning (True) or end (False) of each payment period. Affects the timing of interest expense accrual and principal repayment in the IFRS 16 amortisation schedule.',
    `periodic_lease_payment` DECIMAL(18,2) COMMENT 'Fixed lease payment amount due per payment period (monthly, quarterly, or annually as defined by payment_frequency). Excludes variable lease payments not dependent on an index or rate. Used as the primary input to the amortisation schedule.',
    `purchase_option_flag` BOOLEAN COMMENT 'Indicates whether the lease contract includes an option for the lessee to purchase the underlying asset. If the lessee is reasonably certain to exercise the purchase option, the option price is included in the lease liability measurement.',
    `purchase_option_price` DECIMAL(18,2) COMMENT 'Contractual price at which the lessee may purchase the underlying asset if the purchase option is exercised. Included in the lease liability present value calculation when the lessee is reasonably certain to exercise. Null when purchase_option_flag is False.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the lease contract contains one or more renewal options exercisable by the lessee. When True, renewal_option_reasonably_certain_flag must be assessed for IFRS 16 lease term determination.',
    `renewal_option_reasonably_certain` BOOLEAN COMMENT 'Managements assessment of whether the lessee is reasonably certain to exercise the renewal option. When True, the optional renewal period is included in the IFRS 16 lease term and the lease liability is remeasured accordingly.',
    `residual_value_guarantee` DECIMAL(18,2) COMMENT 'Amount of any residual value guarantee provided by the lessee to the lessor, representing the lessees exposure to the residual value of the leased asset at lease end. Included in the IFRS 16 lease liability measurement as a lease payment.',
    `rou_asset_value` DECIMAL(18,2) COMMENT 'Initial carrying amount of the right-of-use (ROU) asset recognised on the balance sheet at the lease commencement date, comprising the initial lease liability measurement plus any initial direct costs, prepaid lease payments, and estimated dismantling costs, less any lease incentives received. Expressed in the contract currency.',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'Cash security deposit paid to the lessor at lease commencement, refundable at lease expiry subject to asset return conditions. Classified as a financial asset (receivable) on the lessees balance sheet, separate from the lease liability.',
    `termination_option_flag` BOOLEAN COMMENT 'Indicates whether the lease contract contains a termination option exercisable by the lessee before the contractual expiry date. Affects IFRS 16 lease term and liability measurement.',
    `termination_option_reasonably_certain` BOOLEAN COMMENT 'Managements assessment of whether the lessee is reasonably certain to exercise the termination option. When True, the lease term is shortened to the termination date and the liability is remeasured.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lease contract record in the finance data platform. Used for incremental data pipeline processing, change detection, and audit compliance.',
    `variable_payment_terms` STRING COMMENT 'Free-text description of any variable lease payment clauses, including index-linked escalation (e.g., CPI, LIBOR/SOFR), utilisation-based payments (e.g., per flight hour for ACMI), or maintenance reserve adjustments. Required for IFRS 16 disclosure notes.',
    CONSTRAINT pk_lease_contract PRIMARY KEY(`lease_contract_id`)
) COMMENT 'IFRS 16 lease contract master and full amortisation schedule for aircraft dry leases, wet leases (ACMI), engine leases, spare part pool access agreements, and property leases (airport lounges, hangars, office space). Stores lessor details, lease commencement and expiry dates, lease term, right-of-use asset value, lease liability opening balance, discount rate (incremental borrowing rate), variable lease payment terms, renewal/termination options, modification history, and complete period-by-period liability amortisation schedule (opening balance, interest expense, lease payment, principal repayment, closing balance). Supports automated GL journal entry generation, IFRS 16 disclosure notes, lease vs buy analysis, fleet planning integration, and auditor reconciliation.';

CREATE OR REPLACE TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` (
    `lease_liability_schedule_id` BIGINT COMMENT 'Unique surrogate identifier for each lease liability amortisation schedule record in the IFRS 16 ledger. Primary key for this table.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Each lease liability schedule line is assigned to ONE cost center for cost allocation. The lease_liability_schedule table has cost_centre_code (STRING) which should be replaced with a FK to the cost_c',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Each lease liability schedule line posts to ONE GL account. The lease_liability_schedule table has gl_account_code (STRING) which should be replaced with a FK to the general_ledger master. This links ',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: lease_liability_schedule has journal_entry_document_number (STRING) and journal_entry_posted_flag (BOOLEAN) indicating that each schedule period generates a journal entry. A direct FK to journal_entry',
    `lease_contract_id` BIGINT COMMENT 'Reference to the parent lease contract master record from which this amortisation schedule is derived. Links each period row back to the originating lease agreement.',
    `asset_registration` STRING COMMENT 'ICAO/national civil aviation authority aircraft registration mark (e.g., N-number, G-prefix) or property/equipment asset identifier for the underlying leased asset. Links the financial schedule to the physical asset in the fleet or property register.',
    `closing_balance` DECIMAL(18,2) COMMENT 'Carrying amount of the lease liability at the end of the period (opening balance + interest expense − principal repayment). Becomes the next periods opening balance. Key IFRS 16 balance sheet figure.',
    `commencement_date` DATE COMMENT 'Date on which the lessor makes the underlying asset available for use by the lessee. This is the date from which the right-of-use (ROU) asset and lease liability are initially recognised on the balance sheet.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lease liability schedule record was first created in the data platform, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the lease liability amounts are denominated (e.g., USD, EUR, GBP). Aircraft leases are frequently denominated in USD regardless of the airlines functional currency.. Valid values are `^[A-Z]{3}$`',
    `discount_rate` DECIMAL(18,2) COMMENT 'The interest rate used to discount future lease payments to present value, typically the lessees incremental borrowing rate (IBR) or the implicit rate in the lease if determinable. Expressed as an annual decimal (e.g., 0.045 = 4.5%).',
    `extension_option_flag` BOOLEAN COMMENT 'Indicates whether the lease term used in the liability calculation includes one or more extension option periods that management has assessed as reasonably certain to be exercised.',
    `fiscal_period` STRING COMMENT 'Numeric accounting period (1–12 for monthly, 1–4 for quarterly) within the fiscal year. Drives journal entry posting period in SAP S/4HANA FI.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year to which this amortisation period belongs, as defined in the airlines SAP S/4HANA fiscal year variant. Used for annual IFRS 16 disclosure aggregation.',
    `functional_currency_code` STRING COMMENT 'Three-letter ISO 4217 code for the airlines functional currency used for consolidated financial reporting. Enables FX translation of foreign-currency lease liabilities for IFRS disclosure.. Valid values are `^[A-Z]{3}$`',
    `fx_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to translate lease liability amounts from the lease currency to the functional currency at the period end date. Sourced from the treasury system or SAP S/4HANA exchange rate table.',
    `initial_recognition_amount` DECIMAL(18,2) COMMENT 'Present value of future lease payments at the commencement date, representing the lease liability recognised on the balance sheet at inception. Equals the initial ROU asset cost (before initial direct costs and lease incentives).',
    `interest_expense` DECIMAL(18,2) COMMENT 'Finance charge accrued during the period calculated by applying the incremental borrowing rate (or implicit rate) to the opening lease liability balance. Posted to the P&L interest expense account.',
    `journal_entry_posted_flag` BOOLEAN COMMENT 'Indicates whether the automated IFRS 16 journal entries (interest accrual and principal repayment) for this period have been successfully posted to the SAP S/4HANA general ledger. Supports period-close control and reconciliation.',
    `lease_end_date` DATE COMMENT 'Contractual end date of the lease term, including any reasonably certain extension options. Used to determine the remaining lease term for present value calculations and maturity analysis disclosures.',
    `lease_payment` DECIMAL(18,2) COMMENT 'Total cash payment made to the lessor during the period, comprising both the principal repayment and the interest component. Corresponds to the cash outflow in the statement of cash flows.',
    `lease_status` STRING COMMENT 'Current lifecycle state of the lease contract as of the period. Drives whether amortisation rows continue to be generated and whether remeasurement events have occurred.. Valid values are `active|terminated|expired|modified|subleased`',
    `lease_type` STRING COMMENT 'Classification of the lease by asset category and IFRS 16 lease classification (finance vs. operating). Aircraft leases dominate the airline balance sheet; property leases cover airport lounges, offices, and hangars. [ENUM-REF-CANDIDATE: aircraft_operating|aircraft_finance|property_operating|property_finance|equipment_operating|equipment_finance — promote to reference product]. Valid values are `aircraft_operating|aircraft_finance|property_operating|property_finance|equipment_operating|equipment_finance`',
    `lessor_name` STRING COMMENT 'Legal name of the lessor (aircraft leasing company, property owner, or equipment provider) from whom the asset is leased. Common aviation lessors include AerCap, Air Lease Corporation, SMBC Aviation Capital.',
    `low_value_asset_flag` BOOLEAN COMMENT 'Indicates whether the lease qualifies for the IFRS 16 low-value asset exemption (underlying asset value when new is approximately USD 5,000 or below). When true, payments are expensed and no liability is recognised.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Carrying amount of the lease liability at the beginning of the period before any payments or interest accrual. Equals the prior periods closing balance. Core IFRS 16 disclosure figure.',
    `period_end_date` DATE COMMENT 'Last calendar date of the amortisation period covered by this schedule row. Typically the last day of the accounting month or quarter.',
    `period_sequence` STRING COMMENT 'Sequential integer identifying the ordinal position of this amortisation period within the full lease term (e.g., 1 = first period, 24 = twenty-fourth period). Enables ordered traversal of the schedule.',
    `period_start_date` DATE COMMENT 'First calendar date of the amortisation period covered by this schedule row. Aligns with the accounting period open date in the general ledger.',
    `principal_repayment` DECIMAL(18,2) COMMENT 'Portion of the lease payment that reduces the lease liability principal (lease payment minus interest expense). Classified as a financing cash outflow under IAS 7.',
    `profit_centre_code` STRING COMMENT 'SAP S/4HANA CO profit centre associated with the leased asset, enabling segment-level IFRS 16 reporting (e.g., narrow-body fleet, wide-body fleet, cargo operations).',
    `remeasurement_amount` DECIMAL(18,2) COMMENT 'Adjustment to the lease liability arising from a remeasurement event (e.g., lease modification, change in extension option assessment, change in index/rate). Positive values increase the liability; negative values decrease it.',
    `remeasurement_date` DATE COMMENT 'Date on which the lease liability was remeasured due to a triggering event such as a lease modification, reassessment of extension option, or change in variable lease payments linked to an index. Null if no remeasurement occurred in this period.',
    `remeasurement_reason` STRING COMMENT 'Reason code explaining why the lease liability was remeasured in this period. Required for IFRS 16 disclosure notes and auditor reconciliation. Null if no remeasurement occurred.. Valid values are `lease_modification|extension_option_change|termination_option_change|index_rate_change|purchase_option_change`',
    `short_term_lease_flag` BOOLEAN COMMENT 'Indicates whether the lease qualifies for the IFRS 16 short-term lease exemption (lease term of 12 months or less at commencement). When true, payments are expensed on a straight-line basis and no liability is recognised.',
    `termination_option_flag` BOOLEAN COMMENT 'Indicates whether the lease contains a termination option and whether management has assessed it as reasonably certain NOT to be exercised (i.e., the full term is included in the liability measurement).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this lease liability schedule record, in ISO 8601 format. Captures remeasurement postings, corrections, and period-close adjustments.',
    `variable_lease_payment` DECIMAL(18,2) COMMENT 'Lease payments that depend on an index or rate (e.g., CPI-linked rent escalations) included in the lease liability measurement. Excludes purely variable payments not based on an index or rate, which are expensed as incurred.',
    CONSTRAINT pk_lease_liability_schedule PRIMARY KEY(`lease_liability_schedule_id`)
) COMMENT 'IFRS 16 lease liability amortisation schedule records for each lease contract, detailing period-by-period opening balance, interest expense, lease payment, principal repayment, and closing balance. Supports automated journal entry generation for right-of-use asset depreciation and interest accrual. Enables IFRS 16 disclosure notes and auditor reconciliation for aircraft and property leases.';

CREATE OR REPLACE TABLE `airlines_ecm`.`finance`.`interline_billing` (
    `interline_billing_id` BIGINT COMMENT 'Unique identifier for the interline billing record. Primary key.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Interline billing generates payables when the airline owes settlement amounts to partner airlines (e.g., for passengers carried on the airlines flights but ticketed by a partner). A FK from interline',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Each interline billing record is assigned to ONE cost center for cost allocation. The interline_billing table has cost_center_code (STRING) which should be replaced with a FK to the cost_centre master',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: Interline billing is for a specific operated flight leg on a specific date. The interline_billing product denormalizes flight_number and flight_date; a FK to flight_leg enforces referential integrity ',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Each interline billing record posts to ONE GL account. The interline_billing table has gl_account_code (STRING) which should be replaced with a FK to the general_ledger master. This links interline se',
    `interline_agreement_id` BIGINT COMMENT 'Foreign key linking to route.interline_agreement. Business justification: Interline billing transactions are generated under a governing interline agreement that defines proration rates, settlement terms, and liability limits. Finance teams reconcile billing records against',
    `accounting_period` STRING COMMENT 'Accounting period (YYYY-MM format) to which this interline billing transaction is posted in the general ledger. Used for financial reporting and period close.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `awb_number` STRING COMMENT 'Eleven-digit Air Waybill number (format: 3-digit airline code + 8-digit serial number) for cargo interline billing. Links billing to the cargo shipment.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `billing_document_number` STRING COMMENT 'Unique externally-known billing document number or reference assigned to this interline billing transaction. Used for reconciliation and audit trail.',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period covered by this interline billing record. Defines the close of the settlement window.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period covered by this interline billing record. Defines the beginning of the settlement window.',
    `billing_status` STRING COMMENT 'Current lifecycle status of the interline billing record. Tracks the billing through submission, acceptance, dispute resolution, and final settlement stages.. Valid values are `draft|submitted|accepted|disputed|settled|cancelled`',
    `billing_type` STRING COMMENT 'Type of interline billing transaction. Categorizes the nature of the settlement: passenger ticketing, cargo waybill, ancillary services, or billing adjustment.. Valid values are `passenger|cargo|ancillary|adjustment`',
    `cabin_class` STRING COMMENT 'Cabin class of service for the interline segment. Used for proration calculation and revenue allocation between partner airlines.. Valid values are `first|business|premium_economy|economy`',
    `commission_amount` DECIMAL(18,2) COMMENT 'Commission or handling fee amount deducted from the gross billing amount. May represent agent commission or interline handling charges.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interline billing record was first created in the system. Audit trail for record origination.',
    `destination_airport_iata_code` STRING COMMENT 'Three-letter IATA airport code for the destination of the interline segment. Identifies the arrival point for billing allocation.. Valid values are `^[A-Z]{3}$`',
    `dispute_reason_code` STRING COMMENT 'Standardized code indicating the reason for billing dispute if status is disputed. Used for tracking and resolving interline billing disagreements.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate applied to convert original transaction currency to settlement currency. Used for multi-currency interline billing reconciliation.',
    `fare_basis_code` STRING COMMENT 'Fare basis code associated with the ticket or segment being billed. Defines the fare rules and proration methodology for interline revenue sharing.',
    `gross_billing_amount` DECIMAL(18,2) COMMENT 'Total gross amount billed before any adjustments, fees, or commissions. Base amount for the interline transaction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this interline billing record was last updated. Audit trail for tracking changes and dispute resolution activity.',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'Final net amount to be settled between airlines after all adjustments, commissions, and taxes. This is the actual payable or receivable amount.',
    `origin_airport_iata_code` STRING COMMENT 'Three-letter IATA airport code for the origin of the interline segment. Identifies the departure point for billing allocation.. Valid values are `^[A-Z]{3}$`',
    `original_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code of the original transaction before currency conversion for settlement. Used for reconciliation and audit purposes.. Valid values are `^[A-Z]{3}$`',
    `partner_airline_iata_code` STRING COMMENT 'Two-character IATA airline designator code of the partner carrier involved in the interline agreement. Identifies the counterparty airline for billing settlement.. Valid values are `^[A-Z0-9]{2}$`',
    `pnr_locator` STRING COMMENT 'Six-character alphanumeric Passenger Name Record locator code associated with this interline billing transaction. Links billing to the original passenger reservation.. Valid values are `^[A-Z0-9]{6}$`',
    `proration_amount` DECIMAL(18,2) COMMENT 'Revenue or cost amount allocated to the partner airline based on interline proration rules. Represents the partners share of the total ticket or waybill value.',
    `remarks` STRING COMMENT 'Free-text remarks or notes associated with this interline billing record. Used for clarifications, special instructions, or dispute documentation.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the interline settlement is denominated. Defines the currency for all monetary amounts in this billing record.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'Actual date when the interline billing was settled and payment was processed. Null if settlement is pending.',
    `settlement_due_date` DATE COMMENT 'Date by which the interline settlement payment is due. Defines the payment deadline per IATA settlement cycle rules.',
    `settlement_method` STRING COMMENT 'Method used for interline settlement. BSP (Billing and Settlement Plan) for passenger, ARC (Airlines Reporting Corporation) for US market, CASS (Cargo Accounts Settlement System) for cargo, direct bilateral billing, or ICH (IATA Clearing House).. Valid values are `bsp|arc|cass|direct_billing|ich`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount included in the interline billing. Covers applicable aviation taxes, fees, and surcharges allocated to the partner carrier.',
    `ticket_number` STRING COMMENT 'Thirteen-digit electronic ticket number (e-ticket) associated with this interline billing record. Unique identifier for the passenger ticket in interline transactions.. Valid values are `^[0-9]{13}$`',
    `transaction_type` STRING COMMENT 'Specific transaction type within the billing record. Indicates whether this is a debit memo (amount owed to partner), credit memo (amount owed by partner), proration allocation, or final settlement.. Valid values are `debit_memo|credit_memo|proration|settlement`',
    CONSTRAINT pk_interline_billing PRIMARY KEY(`interline_billing_id`)
) COMMENT 'Interline billing and settlement records for revenue and cost flows between the airline and partner carriers under interline ticketing agreements. Captures IATA billing and settlement plan (BSP) transactions, interline proration amounts, debit memos, credit memos, billing period, partner airline IATA code, and settlement currency. Supports IATA CASS (Cargo Accounts Settlement System) and passenger interline reconciliation.';

CREATE OR REPLACE TABLE `airlines_ecm`.`finance`.`tax_transaction` (
    `tax_transaction_id` BIGINT COMMENT 'Unique surrogate identifier for each tax posting record in the finance domain. Primary key for the tax_transaction data product.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Tax transactions (VAT/GST on supplier invoices, withholding tax) are directly associated with AP invoices. tax_transaction has source_document_reference and source_document_type as generic string refe',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Tax transactions on customer-facing revenue (e.g., VAT on ancillary services, airport taxes collected) are associated with AR records. A direct FK to accounts_receivable provides a typed link for AR-r',
    `booking_payment_id` BIGINT COMMENT 'Foreign key linking to reservation.booking_payment. Business justification: Airport taxes and surcharges collected at booking are remitted to tax authorities. Tax_transaction must reference the booking_payment that collected the tax to support tax remittance reconciliation, a',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Each tax transaction belongs to ONE company code. The tax_transaction table has company_code (STRING) which should be replaced with a FK to the company_code master. Tax transactions are company-code s',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Each tax transaction can be assigned to ONE cost center for cost allocation. The tax_transaction table has cost_center (STRING) which should be replaced with a FK to the cost_centre master.',
    `e_ticket_id` BIGINT COMMENT 'Foreign key linking to reservation.e_ticket. Business justification: E-tickets are the primary source documents for passenger tax obligations (departure taxes, VAT, PFC). Tax_transaction must reference the e_ticket to support BSP tax reporting, government remittance re',
    `general_ledger_id` BIGINT COMMENT 'Reference to the general ledger account to which this tax posting is recorded, aligning with SAP S/4HANA FI chart of accounts.',
    `profile_id` BIGINT COMMENT 'Reference to the customer or passenger party associated with this tax transaction, applicable for output VAT/GST on ancillary services, passenger facility charges, and airport taxes.',
    `refund_transaction_id` BIGINT COMMENT 'Foreign key linking to reservation.refund_transaction. Business justification: When tickets are refunded, collected taxes must be reversed and refunded to passengers, requiring tax authority notification. Tax_transaction records the reversal and must reference the originating re',
    `airport_code` STRING COMMENT 'Three-letter IATA airport code associated with this tax transaction, applicable for airport taxes, Passenger Facility Charges (PFC), and slot-related levies. Identifies the airport at which the tax obligation arises.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this tax transaction record was first created in the data platform, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `document_date` DATE COMMENT 'The date of the originating source document (invoice, receipt, or tax certificate) that triggered this tax posting. May differ from posting_date due to processing lag.',
    `document_number` STRING COMMENT 'Externally-known accounting document number assigned by SAP S/4HANA FI at the time of tax posting. Used as the primary business reference for audit and reconciliation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the transaction currency tax amounts to local currency at the posting date. Sourced from SAP FI exchange rate tables aligned with IATA rate publications.',
    `filing_reference` STRING COMMENT 'The reference number assigned by the tax authority or internal tax filing system when this tax transaction is included in a periodic tax return or remittance filing (e.g., VAT return reference, PFC quarterly report number, WHT certificate number).',
    `fiscal_period` STRING COMMENT 'The fiscal period number (1–16 in SAP, including special periods) within the fiscal year to which this tax transaction is assigned. Supports period-end close and tax accrual reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this tax transaction is assigned in the airlines financial calendar. Used for annual tax provision, corporate income tax filing, and IFRS financial statement preparation.',
    `is_recoverable` BOOLEAN COMMENT 'Indicates whether this input tax amount is recoverable (reclaimable) from the tax authority as a credit against output tax liability. True for recoverable input VAT/GST; False for irrecoverable taxes such as non-deductible VAT on entertainment or blocked input tax.',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the company codes local (functional) currency (e.g., USD for a US entity, EUR for a German entity). Used for statutory reporting and local tax filings.. Valid values are `^[A-Z]{3}$`',
    `local_currency_tax_amount` DECIMAL(18,2) COMMENT 'The tax amount translated into the company codes local (functional) currency using the exchange rate at posting date. Required for statutory financial reporting and local tax authority filings.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net amount after tax, representing the total transaction value inclusive of tax (taxable_base_amount + tax_amount). Used for financial statement presentation and settlement reconciliation.',
    `posting_date` DATE COMMENT 'The date on which the tax transaction was posted to the general ledger. Determines the fiscal period assignment and is the principal business event date for this transaction.',
    `profit_center` STRING COMMENT 'SAP CO profit center associated with this tax transaction, enabling profitability analysis by route, fleet type, or business unit. Supports RASK (Revenue per Available Seat Kilometer) and segment reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `remittance_date` DATE COMMENT 'The date on which the tax amount was remitted (paid) to the relevant tax authority. Null until payment is made. Used to confirm compliance with statutory payment deadlines and avoid late payment penalties.',
    `reversal_document_number` STRING COMMENT 'The SAP FI document number of the reversal posting if this tax transaction has been reversed or cancelled. Null for active postings. Supports audit trail and reconciliation of corrected tax entries.',
    `reversal_reason_code` STRING COMMENT 'SAP FI reversal reason code explaining why this tax posting was reversed (e.g., data entry error, duplicate posting, credit note issued). Null for non-reversed transactions.',
    `source_document_reference` STRING COMMENT 'The reference number of the originating source document (e.g., vendor invoice number, AWB number for cargo customs, PNR for passenger-related taxes, BSP billing reference). Enables traceability from tax posting back to the originating business transaction.',
    `source_document_type` STRING COMMENT 'Type of the originating business document that generated this tax posting. INVOICE=vendor or customer invoice; CREDIT_NOTE=credit memo; PAYMENT=payment document; JOURNAL=manual journal entry; CUSTOMS_DECL=customs declaration for cargo; PFC_REPORT=Passenger Facility Charge quarterly report; WHT_CERT=withholding tax certificate. [ENUM-REF-CANDIDATE: INVOICE|CREDIT_NOTE|PAYMENT|JOURNAL|CUSTOMS_DECL|PFC_REPORT|WHT_CERT — 7 candidates stripped; promote to reference product]',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount in the transaction currency. Represents the actual tax liability or recoverable tax for this posting. Core monetary component of the MONETARY_TRIPLET.',
    `tax_authority_name` STRING COMMENT 'Name of the government or regulatory body to which this tax is remitted (e.g., IRS, HMRC, Bundeszentralamt für Steuern, FAA - PFC). Required for tax filing and regulatory reporting.',
    `tax_code` STRING COMMENT 'SAP FI-TX tax code identifying the applicable tax type and rate combination (e.g., V1 for standard VAT, W1 for withholding tax, PF for Passenger Facility Charge). Drives automatic tax calculation and account determination.. Valid values are `^[A-Z0-9]{1,4}$`',
    `tax_direction` STRING COMMENT 'Indicates whether this is an input tax (recoverable tax paid on purchases/vendor invoices) or output tax (tax collected from customers on sales of ancillary services and tickets). Drives VAT/GST net settlement calculation.. Valid values are `INPUT|OUTPUT`',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the tax jurisdiction (country, state, or municipality) that levies this tax. Supports multi-jurisdiction tax compliance across the airlines global route network. Aligns with SAP FI-TX jurisdiction configuration.. Valid values are `^[A-Z]{2,10}$`',
    `tax_jurisdiction_name` STRING COMMENT 'Human-readable name of the tax jurisdiction (e.g., United States Federal, Germany VAT, New York State, London Heathrow Airport). Supports tax reporting and audit documentation.',
    `tax_period` STRING COMMENT 'The fiscal tax reporting period in YYYY-MM format to which this tax transaction belongs. Used for VAT/GST return filing, withholding tax remittance, and corporate income tax provision reporting.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `tax_rate` DECIMAL(18,2) COMMENT 'The applicable tax rate as a percentage (e.g., 20.0000 for 20% VAT, 7.5000 for 7.5% WHT). Sourced from the tax code configuration in SAP FI-TX and validated against jurisdiction-specific statutory rates.',
    `tax_return_period` STRING COMMENT 'The period identifier for the tax return in which this transaction is reported to the tax authority. May be monthly (YYYY-MM) or quarterly (YYYY-Q1 through YYYY-Q4) depending on jurisdiction requirements.. Valid values are `^d{4}-(Q[1-4]|0[1-9]|1[0-2])$`',
    `tax_type` STRING COMMENT 'Classification of the tax category applicable to this transaction. VAT=Value Added Tax, GST=Goods and Services Tax, WHT=Withholding Tax, PFC=Passenger Facility Charge, AIRPORT_TAX=Airport-levied tax, CORP_INCOME_TAX=Corporate Income Tax provision, EXCISE=Fuel/aviation excise duty, CUSTOMS=Import/export customs duty on cargo. [ENUM-REF-CANDIDATE: VAT|GST|WHT|PFC|AIRPORT_TAX|CORP_INCOME_TAX|EXCISE|CUSTOMS — 8 candidates stripped; promote to reference product]',
    `taxable_base_amount` DECIMAL(18,2) COMMENT 'The gross monetary amount on which the tax is calculated, expressed in the transaction currency. For VAT/GST this is the net invoice value; for PFC it is the per-passenger charge base; for WHT it is the gross vendor payment.',
    `transaction_currency` STRING COMMENT 'ISO 4217 three-letter currency code of the transaction in which the tax amounts are denominated (e.g., USD, EUR, GBP). Supports multi-currency operations across the airlines global network.. Valid values are `^[A-Z]{3}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the tax posting in SAP FI. POSTED=active tax document posted to GL; REVERSED=document reversed/cancelled; CLEARED=tax settled/remitted to authority; PARKED=saved but not yet posted; BLOCKED=held for review.. Valid values are `POSTED|REVERSED|CLEARED|PARKED|BLOCKED`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this tax transaction record was last modified in the data platform, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Tracks the most recent change for audit and reconciliation purposes.',
    CONSTRAINT pk_tax_transaction PRIMARY KEY(`tax_transaction_id`)
) COMMENT 'Tax posting and compliance records for all applicable taxes including VAT/GST on ancillary services, passenger facility charges (PFC), airport taxes, withholding tax on vendor payments, and corporate income tax provisions. Captures tax code, tax jurisdiction, taxable base amount, tax amount, tax period, filing reference, and tax authority. Supports multi-jurisdiction tax compliance and DOT/EASA regulatory financial reporting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'Unique surrogate identifier for each fixed asset record in the SAP FI-AA module. Primary key for the fixed asset master data product.',
    `aircraft_id` BIGINT COMMENT 'Foreign key linking to fleet.aircraft. Business justification: Aircraft are the largest fixed assets on the balance sheet. This FK links the financial asset record to the operational aircraft master for depreciation tracking, asset valuation, and financial report',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Each fixed asset belongs to ONE company code. The fixed_asset table has company_code (STRING) which should be replaced with a FK to the company_code master. Fixed assets are company-code specific in S',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Each fixed asset can be assigned to ONE cost center for depreciation allocation. The fixed_asset table has cost_center (STRING) which should be replaced with a FK to the cost_centre master.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Each fixed asset is linked to ONE GL account for asset accounting. The fixed_asset table has gl_account (STRING) which should be replaced with a FK to the general_ledger master. This links fixed asset',
    `lease_contract_id` BIGINT COMMENT 'Foreign key linking to finance.lease_contract. Business justification: Each IFRS 16 right-of-use asset is created from ONE lease contract. The fixed_asset table has lease_contract_number (STRING) and is_ifrs16_rou_asset flag, which should be replaced with a FK to the lea',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation charged against the asset from acquisition date to the current reporting period. Corresponds to SAP ANLC.KNAFA (cumulative ordinary depreciation). Used to compute net book value and for balance sheet reporting.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original acquisition cost (historical cost) of the asset in the document currency at the time of purchase. For aircraft, includes purchase price, import duties, and directly attributable costs to bring the asset to its intended use. Corresponds to SAP ANLC.KANSW.',
    `acquisition_date` DATE COMMENT 'Date on which the asset was acquired, purchased, or placed in service. Corresponds to SAP ANLA.AKTIV. Used as the start date for depreciation calculation and CAPEX reporting.',
    `asset_class_code` STRING COMMENT 'SAP asset class (ANLKL) categorising the asset for depreciation rules, GL account determination, and reporting. Examples: 1000=Aircraft, 1100=Aircraft Engines, 1200=Simulators, 2000=Ground Support Equipment, 3000=IT Infrastructure, 4000=Leasehold Improvements, 5000=Right-of-Use Assets (IFRS 16). [ENUM-REF-CANDIDATE: 1000|1100|1200|2000|3000|4000|5000|6000 — promote to reference product]',
    `asset_class_name` STRING COMMENT 'Human-readable name of the SAP asset class (e.g., Aircraft, Aircraft Engines, Flight Simulators, Ground Support Equipment). Denormalised for reporting convenience.',
    `asset_description` STRING COMMENT 'Primary human-readable description of the fixed asset (e.g., Boeing 737-800 MSN 45123, Full Flight Simulator B737, Ground Power Unit GPU-400). Corresponds to SAP ANLA.TXT50 field.',
    `asset_location_code` STRING COMMENT 'IATA airport or facility code indicating the primary physical location of the asset (e.g., LHR for Heathrow maintenance base, JFK for ground support equipment). Corresponds to SAP ANLA.STORT. Supports insurance valuation and physical asset verification.',
    `asset_number` STRING COMMENT 'SAP FI-AA main asset number uniquely identifying the asset within the company code. Corresponds to the ANLN1 field in SAP Asset Master (ANLZ/ANLB tables). Used for CAPEX tracking and asset register reconciliation.',
    `asset_status` STRING COMMENT 'Current lifecycle status of the fixed asset. active = in service and depreciating; under_construction = Asset Under Construction (AUC) not yet capitalised; disposed = sold, scrapped, or written off; transferred = transferred to another company code or cost centre; impaired = impairment loss recognised per IAS 36; deactivated = temporarily taken out of service.. Valid values are `active|under_construction|disposed|transferred|impaired|deactivated`',
    `asset_subnumber` STRING COMMENT 'SAP FI-AA sub-number (ANLN2) used to track component-level assets under a main asset number, such as individual aircraft engines under a parent airframe asset. Supports component accounting per IAS 16.',
    `asset_type` STRING COMMENT 'Categorises the asset by ownership or lease arrangement. owned = outright purchase; finance_lease = IFRS 16 right-of-use finance lease; operating_lease_rou = IFRS 16 right-of-use operating lease; dry_lease = aircraft leased without crew; wet_lease = aircraft leased with crew; acmi = Aircraft Crew Maintenance Insurance lease. Drives IFRS 16 vs IAS 16 accounting treatment.. Valid values are `owned|finance_lease|operating_lease_rou|dry_lease|wet_lease|acmi`',
    `capitalisation_date` DATE COMMENT 'Date on which the asset was formally capitalised and transferred from Asset Under Construction (AUC) to a productive asset class. May differ from acquisition_date for self-constructed assets or aircraft deliveries with pre-delivery payments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset master record was first created in SAP FI-AA. Corresponds to SAP ANLA.ERDAT and ANLA.ERZET. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the acquisition cost and valuation amounts (e.g., USD, EUR, GBP). Aligns with the transaction currency used at time of asset acquisition.. Valid values are `^[A-Z]{3}$`',
    `depreciation_area` STRING COMMENT 'SAP FI-AA depreciation area code (AFABE) identifying the valuation basis (e.g., 01=Book Depreciation IFRS, 10=Tax Depreciation, 20=Group Reporting). Multiple depreciation areas allow parallel valuation for IFRS, local GAAP, and tax purposes.',
    `depreciation_method_code` STRING COMMENT 'Code identifying the depreciation method applied to the asset. SL=Straight-Line; DB=Declining Balance; UOP=Units of Production (e.g., flight cycles or block hours for engines); SOYD=Sum of Years Digits; NONE=Non-depreciable (e.g., land). Corresponds to SAP ANLB.AFASL.. Valid values are `SL|DB|UOP|SOYD|NONE`',
    `disposal_date` DATE COMMENT 'Date on which the asset was disposed of, sold, scrapped, or retired from service. Triggers cessation of depreciation and recognition of disposal gain or loss. Corresponds to SAP ANLA.DEAKT.',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Net proceeds received on disposal or sale of the asset. Used to calculate the gain or loss on disposal (disposal proceeds minus net book value at disposal date). Relevant for aircraft sales, part-out transactions, and GSE disposals.',
    `impairment_loss` DECIMAL(18,2) COMMENT 'Cumulative impairment loss recognised on the asset where the carrying amount exceeds the recoverable amount. Applicable for aircraft fleets affected by route network changes, AOG events, or market value declines. Corresponds to SAP ANLC extraordinary depreciation.',
    `insurance_value` DECIMAL(18,2) COMMENT 'Agreed hull insurance value of the asset as declared to the insurer, typically the agreed value or replacement cost for aircraft. Used for insurance premium calculation and claims settlement. May differ from net book value for older aircraft.',
    `is_ifrs16_rou_asset` BOOLEAN COMMENT 'Indicates whether this asset is a right-of-use (ROU) asset recognised under IFRS 16 Leases. True for aircraft, engines, and equipment under finance or operating leases. Drives separate balance sheet presentation and disclosure requirements.',
    `last_changed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent change to the fixed asset master record in SAP FI-AA. Corresponds to SAP ANLA.AEDAT and ANLA.AEZET. Supports change audit trail for SOX compliance and data reconciliation.',
    `lease_commencement_date` DATE COMMENT 'Date on which the lease term commences and the right-of-use (ROU) asset is recognised on the balance sheet under IFRS 16. Determines the start of ROU asset amortisation and lease liability unwinding.',
    `lease_end_date` DATE COMMENT 'Contractual end date of the lease term for right-of-use assets. Used to determine the remaining lease term for IFRS 16 ROU asset amortisation and lease liability discounting. Includes any reasonably certain renewal option periods.',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the company code local currency used for statutory financial reporting. Supports multi-currency consolidation in SAP FI-AA.. Valid values are `^[A-Z]{3}$`',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current net book value of the asset calculated as acquisition cost minus accumulated depreciation and any impairment losses. Corresponds to SAP ANLC carrying amount. Key metric for CAPEX tracking, insurance valuation, and balance sheet reporting.',
    `profit_center` STRING COMMENT 'SAP Controlling profit centre (PRCTR) associated with the asset for segment reporting and profitability analysis. Enables allocation of depreciation to route or fleet profit centres for management accounting.',
    `purchase_order_number` STRING COMMENT 'SAP purchase order number (EBELN) associated with the asset acquisition. Links the fixed asset to the procurement process for CAPEX budget control and three-way matching (PO, goods receipt, invoice).',
    `registration_number` STRING COMMENT 'Official civil aviation authority registration number (tail number) assigned to the aircraft asset (e.g., G-BOAC, N12345). Applicable to aircraft and rotorcraft assets. Used for cross-referencing with flight operations, MRO, and insurance records.',
    `residual_value` DECIMAL(18,2) COMMENT 'Estimated residual (salvage) value of the asset at the end of its useful life. For aircraft, this is typically the estimated scrap or resale value. Depreciation is calculated on the depreciable amount (acquisition cost minus residual value). Corresponds to SAP ANLB.SCHRW.',
    `revaluation_amount` DECIMAL(18,2) COMMENT 'Cumulative revaluation surplus or deficit recognised where the airline applies the revaluation model for aircraft or property assets. Recorded in Other Comprehensive Income (OCI) under IAS 16 revaluation model. Corresponds to SAP ANLC.KZINS.',
    `serial_number` STRING COMMENT 'Manufacturer serial number (MSN) or equipment serial number uniquely identifying the physical asset. For aircraft, this is the Manufacturer Serial Number (MSN); for engines, the Engine Serial Number (ESN). Critical for cross-referencing with AMOS maintenance records and insurance policies.',
    `useful_life_periods` STRING COMMENT 'Remaining useful life expressed in fiscal periods (months) within the current fiscal year. Complements useful_life_years for mid-year acquisitions and partial-period depreciation calculations. Corresponds to SAP ANLB.NDPER.',
    `useful_life_years` STRING COMMENT 'Estimated useful economic life of the asset in years as defined in the depreciation key. For aircraft, typically 20-25 years; for engines, 15-20 years; for simulators, 10-15 years; for IT infrastructure, 3-5 years. Corresponds to SAP ANLB.NDJAR.',
    `vendor_number` STRING COMMENT 'SAP vendor account number (LIFNR) of the supplier or lessor from whom the asset was acquired or leased. Used for accounts payable reconciliation and CAPEX purchase order matching.',
    `wbs_element` STRING COMMENT 'SAP Project System WBS element (POSID) linked to the asset for CAPEX project tracking. Used during the Asset Under Construction (AUC) phase to accumulate project costs before capitalisation. Common for aircraft delivery projects and MRO facility upgrades.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'SAP FI-AA fixed asset master for the airlines capitalised assets including owned aircraft, engines, simulators, ground support equipment, IT infrastructure, and leasehold improvements. Stores asset class, acquisition date, acquisition cost, useful life, depreciation method, accumulated depreciation, net book value, asset location, and disposal date. Supports CAPEX tracking, insurance valuation, and IFRS 16 right-of-use asset management.';

CREATE OR REPLACE TABLE `airlines_ecm`.`finance`.`company_code` (
    `company_code_id` BIGINT COMMENT 'Unique surrogate key for the company code record in the Silver Layer lakehouse. Primary key for this entity.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: A company_code in SAP represents a legal entity for accounting purposes. The legal_entity master is the authoritative source for legal entity data. company_code should FK to legal_entity to establish ',
    `airline_accounting_code` STRING COMMENT 'Three-digit IATA numeric airline accounting code (also known as the airline prefix) used in e-ticket stock numbering, interline billing, and BSP/ARC settlement transactions. Uniquely identifies the airline in financial settlement systems.. Valid values are `^[0-9]{3}$`',
    `arc_participant_flag` BOOLEAN COMMENT 'Indicates whether this legal entity participates in the Airlines Reporting Corporation (ARC) settlement system for US domestic ticket sales. Relevant for North American entities and drives ARC settlement accounts receivable processing.',
    `bsp_participant_flag` BOOLEAN COMMENT 'Indicates whether this legal entity is a registered participant in the IATA Billing and Settlement Plan (BSP) for settlement of ticket sales through travel agents. Drives interline billing and accounts receivable settlement workflows.',
    `chart_of_accounts` STRING COMMENT 'Four-character SAP code identifying the chart of accounts assigned to this company code. Defines the general ledger account structure, account numbering, and account descriptions applicable to all financial postings. Corresponds to SAP KTOPL field.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code_code` STRING COMMENT 'Four-character alphanumeric SAP FI company code uniquely identifying the legal entity within the SAP S/4HANA system. Matches the SAP Bukrs field. Used as the primary business key across all FI/CO postings, journal entries, and financial statements.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code_status` STRING COMMENT 'Current lifecycle status of the company code within SAP FI. Controls whether new financial postings can be made against this entity. inactive blocks new postings; in_liquidation triggers specific closing procedures under IFRS.. Valid values are `active|inactive|in_liquidation|dormant|merged`',
    `consolidation_group` STRING COMMENT 'Identifier of the financial consolidation group to which this company code belongs within the group reporting hierarchy. Used for intercompany elimination, minority interest calculations, and preparation of consolidated financial statements under IFRS 10.',
    `consolidation_unit` STRING COMMENT 'SAP Group Reporting consolidation unit identifier mapped to this company code. Represents the lowest-level reporting unit in the consolidation hierarchy for multi-entity financial roll-up and statutory consolidation.',
    `controlling_area` STRING COMMENT 'Four-character SAP CO controlling area code assigned to this company code. Defines the scope of cost accounting, profit center accounting, and internal order management. Enables CASK (Cost per Available Seat Kilometer) and RASK reporting by aligning cost objects to revenue data.. Valid values are `^[A-Z0-9]{4}$`',
    `corsia_participant_flag` BOOLEAN COMMENT 'Indicates whether this legal entity is subject to CORSIA (Carbon Offsetting and Reduction Scheme for International Aviation) obligations. Drives carbon offset liability accounting and regulatory reporting to ICAO.',
    `country_of_incorporation` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the jurisdiction in which the legal entity is incorporated. Drives statutory reporting requirements, applicable tax law, and national civil aviation authority oversight.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this company code record was first created in the Silver Layer data product. Supports audit trail, data lineage tracking, and compliance with data governance policies.',
    `credit_control_area` STRING COMMENT 'Four-character SAP code identifying the credit control area governing credit limit management and accounts receivable risk assessment for this company code. Relevant for interline billing settlements and BSP/ARC credit exposure.. Valid values are `^[A-Z0-9]{4}$`',
    `effective_from_date` DATE COMMENT 'Date from which this company code became active and eligible for financial postings in SAP FI. Marks the start of the entitys operational financial lifecycle within the group.',
    `effective_to_date` DATE COMMENT 'Date on which this company code was deactivated or ceased financial operations. Null for currently active entities. Used to enforce period-end close and prevent postings after entity dissolution or merger.',
    `entity_type` STRING COMMENT 'Classification of the legal entity by its corporate structure. Determines consolidation treatment, intercompany elimination rules, and applicable accounting standards. [ENUM-REF-CANDIDATE: airline|subsidiary|holding|joint_venture|special_purpose_vehicle|branch — promote to reference product if additional types are required]. Valid values are `airline|subsidiary|holding|joint_venture|special_purpose_vehicle|branch`',
    `fiscal_year_variant` STRING COMMENT 'Two-character SAP code defining the fiscal year structure for this company code, including the number of posting periods, special periods, and whether the fiscal year aligns with the calendar year. Corresponds to SAP PERIV field. Critical for period-end close and CASK reporting cycles.. Valid values are `^[A-Z0-9]{2}$`',
    `group_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code of the parent groups reporting currency used for financial consolidation. Transactions in local currency are translated to group currency for consolidated financial statements.. Valid values are `^[A-Z]{3}$`',
    `iata_airline_code` STRING COMMENT 'Two-character IATA airline designator code assigned to this legal entity. Used in BSP (Billing and Settlement Plan) settlements, interline billing, ticket issuance, and ARC (Airlines Reporting Corporation) reporting. Links financial entity to operational airline identity.. Valid values are `^[A-Z0-9]{2}$`',
    `icao_airline_code` STRING COMMENT 'Three-letter ICAO airline designator code for this legal entity. Used in flight plan filings, ATC communications, NOTAM references, and regulatory correspondence with national civil aviation authorities.. Valid values are `^[A-Z]{3}$`',
    `ifrs16_lessee_flag` BOOLEAN COMMENT 'Indicates whether this company code is subject to IFRS 16 Leases accounting, requiring recognition of right-of-use assets and lease liabilities on the balance sheet. Applicable to entities with aircraft dry leases, wet leases, or ACMI arrangements.',
    `ifrs_reporting_standard` STRING COMMENT 'Accounting standard under which this legal entity prepares its statutory financial statements. Determines recognition, measurement, and disclosure requirements including IFRS 16 lease liability treatment and CORSIA carbon offset accounting.. Valid values are `IFRS|US_GAAP|local_GAAP|mixed`',
    `incorporation_date` DATE COMMENT 'Date on which the legal entity was formally incorporated or registered with the relevant national company registry. Used for entity lifecycle tracking and statutory reporting.',
    `intercompany_elimination_flag` BOOLEAN COMMENT 'Indicates whether intercompany transactions posted against this company code are subject to elimination during group financial consolidation. True for entities within the consolidation perimeter; false for associates or joint ventures accounted for under equity method.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this company code record in the Silver Layer. Used for incremental load detection, change data capture, and audit compliance.',
    `legal_name` STRING COMMENT 'Full registered legal name of the entity as recorded with the relevant national company registry or civil aviation authority. Used for statutory reporting, regulatory filings, and intercompany agreements.',
    `local_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the functional/local currency of the company code as defined in SAP FI. All financial transactions are translated to this currency for statutory reporting. Corresponds to SAP WAERS field.. Valid values are `^[A-Z]{3}$`',
    `operating_certificate_number` STRING COMMENT 'Air Operator Certificate (AOC) number issued by the national civil aviation authority authorising this legal entity to conduct commercial air transport operations. Links the financial entity to its operational regulatory authorisation.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of equity ownership held by the immediate parent entity in this legal entity. Determines consolidation method: full consolidation (>50%), equity method (20-50%), or cost method (<20%) under IFRS 10/IAS 28.',
    `posting_period_variant` STRING COMMENT 'Four-character SAP code controlling which fiscal periods are open or closed for posting in this company code. Governs period-end close procedures and prevents backdated postings outside approved windows. Corresponds to SAP BDATV field.. Valid values are `^[A-Z0-9]{4}$`',
    `registered_address` STRING COMMENT 'Full registered office address of the legal entity as recorded with the national company registry. Used for statutory correspondence, regulatory filings, and legal notices.',
    `registered_address_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the registered office address of the legal entity. May differ from country of incorporation for branch entities. Required for statutory filings and regulatory correspondence.. Valid values are `^[A-Z]{3}$`',
    `short_name` STRING COMMENT 'Abbreviated trading or operating name of the legal entity used in internal reports, SAP correspondence, and financial dashboards. Corresponds to SAP BUTXT field.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this company code record was sourced. Supports data lineage, reconciliation, and Silver Layer provenance tracking.. Valid values are `SAP_S4HANA|manual|migration`',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction code identifying the applicable tax authority and tax calculation procedure for this company code. Used for VAT/GST determination, withholding tax, and Passenger Facility Charge (PFC) reporting to DOT.',
    `vat_registration_number` STRING COMMENT 'Official VAT or GST registration number issued by the national tax authority for this legal entity. Required for VAT invoicing, reclaim submissions, and cross-border tax compliance. Sensitive business identifier.',
    CONSTRAINT pk_company_code PRIMARY KEY(`company_code_id`)
) COMMENT 'Legal entity and company code master representing the airlines individual legal entities, subsidiaries, and joint ventures registered in SAP FI. Stores company code, legal entity name, country of incorporation, local currency, chart of accounts, fiscal year variant, and consolidation group. Supports multi-entity financial consolidation, intercompany eliminations, and statutory reporting per jurisdiction.';

CREATE OR REPLACE TABLE `airlines_ecm`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
    `parent_entity_legal_entity_id` BIGINT COMMENT 'Reference to the immediate parent legal entity in the corporate ownership hierarchy. Null if this is the ultimate parent.',
    `parent_legal_entity_id` BIGINT COMMENT 'Self-referencing FK on legal_entity (parent_legal_entity_id)',
    `primary_ultimate_parent_entity_legal_entity_id` BIGINT COMMENT 'Reference to the top-level parent legal entity in the corporate ownership hierarchy. Null if this is the ultimate parent.',
    `accounting_standard` STRING COMMENT 'Primary accounting framework used by the entity for financial reporting (IFRS, US GAAP, or local GAAP).',
    `air_operator_certificate_number` STRING COMMENT 'Certificate number issued by the civil aviation authority authorizing the entity to conduct commercial air transport operations.',
    `aoc_effective_date` DATE COMMENT 'Date on which the Air Operator Certificate became effective and the entity was authorized to commence operations.',
    `aoc_expiry_date` DATE COMMENT 'Date on which the Air Operator Certificate expires and must be renewed. Null if certificate has no expiry.',
    `aoc_issuing_authority` STRING COMMENT 'Name of the civil aviation authority that issued the Air Operator Certificate (e.g., FAA, EASA, CAAC).',
    `consolidation_method` STRING COMMENT 'Accounting method used to consolidate this entitys financial results into group reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was first created in the system.',
    `entity_type` STRING COMMENT 'Classification of the entitys business purpose within the corporate structure (e.g., operating company, holding company, SPV).',
    `fiscal_year_end_day` STRING COMMENT 'Day of month (1-31) representing the end of the entitys fiscal year.',
    `fiscal_year_end_month` STRING COMMENT 'Month number (1-12) representing the end of the entitys fiscal year for financial reporting purposes.',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code representing the primary currency of the economic environment in which the entity operates.',
    `iata_airline_code` STRING COMMENT 'Two-character IATA airline designator code assigned to the legal entity if it operates as an airline.',
    `icao_airline_code` STRING COMMENT 'Three-character ICAO airline designator code assigned to the legal entity if it operates as an airline.',
    `incorporation_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction where the entity is incorporated.',
    `incorporation_date` DATE COMMENT 'Date on which the legal entity was officially incorporated or registered with the relevant authority.',
    `incorporation_jurisdiction` STRING COMMENT 'State, province, or sub-national jurisdiction within the incorporation country (e.g., Delaware, Ontario).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this legal entity record was most recently updated.',
    `legal_entity_code` STRING COMMENT 'Business-assigned unique code for the legal entity used in financial reporting and consolidation.',
    `legal_entity_name` STRING COMMENT 'Full registered legal name of the entity as it appears in incorporation documents and regulatory filings.',
    `legal_form` STRING COMMENT 'Type of legal structure of the entity (e.g., corporation, LLC, partnership, branch).',
    `lei_code` STRING COMMENT 'ISO 17442 Legal Entity Identifier, a 20-character alphanumeric code for unique identification in financial transactions and regulatory reporting.',
    `operating_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary country where the entity conducts business operations.',
    `operational_status` STRING COMMENT 'Current operational state indicating whether the entity is actively conducting business.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of equity ownership held by the parent entity (0.00 to 100.00). Used for consolidation calculations.',
    `registered_address_line1` STRING COMMENT 'First line of the official registered address of the legal entity as filed with the corporate registry.',
    `registered_address_line2` STRING COMMENT 'Second line of the official registered address (suite, floor, building name).',
    `registered_city` STRING COMMENT 'City or municipality of the registered address.',
    `registered_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the registered address.',
    `registered_postal_code` STRING COMMENT 'Postal or ZIP code of the registered address.',
    `registered_state_province` STRING COMMENT 'State, province, or region of the registered address.',
    `registration_number` STRING COMMENT 'Official registration number assigned by the corporate registry or companies house in the jurisdiction of incorporation.',
    `regulatory_status` STRING COMMENT 'Current regulatory standing of the legal entity with the corporate registry or governing authority.',
    `reporting_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used for financial reporting and consolidation purposes.',
    `short_name` STRING COMMENT 'Abbreviated or trading name of the legal entity used in operational systems and reports.',
    `tax_identification_number` STRING COMMENT 'Primary tax identification number assigned by the tax authority in the entitys jurisdiction of incorporation.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master reference table for legal_entity. Referenced by lessee_entity_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ADD CONSTRAINT `fk_finance_general_ledger_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ADD CONSTRAINT `fk_finance_cost_centre_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `airlines_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ADD CONSTRAINT `fk_finance_accounts_payable_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ADD CONSTRAINT `fk_finance_accounts_receivable_interline_billing_id` FOREIGN KEY (`interline_billing_id`) REFERENCES `airlines_ecm`.`finance`.`interline_billing`(`interline_billing_id`);
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ADD CONSTRAINT `fk_finance_fuel_cost_transaction_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ADD CONSTRAINT `fk_finance_fuel_cost_transaction_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ADD CONSTRAINT `fk_finance_fuel_cost_transaction_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ADD CONSTRAINT `fk_finance_lease_contract_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `airlines_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ADD CONSTRAINT `fk_finance_lease_liability_schedule_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ADD CONSTRAINT `fk_finance_lease_liability_schedule_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ADD CONSTRAINT `fk_finance_lease_liability_schedule_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `airlines_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ADD CONSTRAINT `fk_finance_lease_liability_schedule_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ADD CONSTRAINT `fk_finance_interline_billing_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ADD CONSTRAINT `fk_finance_interline_billing_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ADD CONSTRAINT `fk_finance_interline_billing_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ADD CONSTRAINT `fk_finance_tax_transaction_accounts_payable_id` FOREIGN KEY (`accounts_payable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_payable`(`accounts_payable_id`);
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ADD CONSTRAINT `fk_finance_tax_transaction_accounts_receivable_id` FOREIGN KEY (`accounts_receivable_id`) REFERENCES `airlines_ecm`.`finance`.`accounts_receivable`(`accounts_receivable_id`);
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ADD CONSTRAINT `fk_finance_tax_transaction_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ADD CONSTRAINT `fk_finance_tax_transaction_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ADD CONSTRAINT `fk_finance_tax_transaction_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `airlines_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_centre_id` FOREIGN KEY (`cost_centre_id`) REFERENCES `airlines_ecm`.`finance`.`cost_centre`(`cost_centre_id`);
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_general_ledger_id` FOREIGN KEY (`general_ledger_id`) REFERENCES `airlines_ecm`.`finance`.`general_ledger`(`general_ledger_id`);
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_lease_contract_id` FOREIGN KEY (`lease_contract_id`) REFERENCES `airlines_ecm`.`finance`.`lease_contract`(`lease_contract_id`);
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `airlines_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_entity_legal_entity_id` FOREIGN KEY (`parent_entity_legal_entity_id`) REFERENCES `airlines_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `airlines_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_primary_ultimate_parent_entity_legal_entity_id` FOREIGN KEY (`primary_ultimate_parent_entity_legal_entity_id`) REFERENCES `airlines_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `airlines_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` SET TAGS ('dbx_subdomain' = 'accounting_records');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Entry ID');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_business_glossary_term' = 'Accounting Principle');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `accounting_principle` SET TAGS ('dbx_value_regex' = 'IFRS|GAAP|IFRS16|LOCAL');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `amount_company_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Company Code Currency');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `amount_company_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `amount_company_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `amount_group_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Group Currency');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `amount_group_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `amount_group_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `amount_transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Transaction Currency');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `amount_transaction_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `amount_transaction_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `company_currency` SET TAGS ('dbx_business_glossary_term' = 'Company Code Currency');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `company_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `cost_element` SET TAGS ('dbx_business_glossary_term' = 'Cost Element');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `cost_element` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'S|H');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Type');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `functional_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,16}$');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `gl_account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `header_text` SET TAGS ('dbx_business_glossary_term' = 'Document Header Text');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `internal_order` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `internal_order` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,12}$');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `last_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Changed Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `ledger_code` SET TAGS ('dbx_business_glossary_term' = 'Ledger Code');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `ledger_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Document Line Item Number');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|parked|held|cleared');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `posting_text` SET TAGS ('dbx_business_glossary_term' = 'Posting Text');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `posting_user` SET TAGS ('dbx_business_glossary_term' = 'Posting User ID');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `profit_centre` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `profit_centre` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `trading_partner_company_code` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner Company Code');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `trading_partner_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`general_ledger` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'accounting_records');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'A|D|K|M|S');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_document_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Document Currency');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_document_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_document_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'D|C');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Document Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Document Number');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Financial Document Type');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entry Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,16}$');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `header_text` SET TAGS ('dbx_business_glossary_term' = 'Document Header Text');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `last_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Changed Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `line_item_text` SET TAGS ('dbx_business_glossary_term' = 'Line Item Text');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|parked|held|reversed|cleared|blocked');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`finance`.`journal_entry` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` SET TAGS ('dbx_subdomain' = 'accounting_records');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre ID');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `activity_type_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Type Code');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `annual_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `budget_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,10}$');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `cask_allocation_key` SET TAGS ('dbx_business_glossary_term' = 'Cost per Available Seat Kilometer (CASK) Allocation Key');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Category Code');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `centre_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Type');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `centre_type` SET TAGS ('dbx_value_regex' = 'cost|profit|investment|revenue');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `corsia_emissions_flag` SET TAGS ('dbx_business_glossary_term' = 'CORSIA Emissions Reporting Flag');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Code');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Description');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Name');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Status');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `cost_centre_status` SET TAGS ('dbx_value_regex' = 'active|inactive|locked|pending_activation|closed');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `fuel_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cost Accounting Flag');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `gl_account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Group');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `gl_account_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `hierarchy_area` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Hierarchy Area');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `hub_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Hub Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `hub_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `iata_cost_category` SET TAGS ('dbx_business_glossary_term' = 'IATA (International Air Transport Association) Cost Category');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `ifrs16_lease_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS 16 Lease Liability Flag');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `interline_settlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Interline Settlement Flag');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `internal_activity_rate` SET TAGS ('dbx_business_glossary_term' = 'Internal Activity Rate');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `internal_activity_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `last_changed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Changed By User');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `last_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Changed Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `profit_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Code');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `rask_attribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue per Available Seat Kilometer (RASK) Attribution Flag');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Short Name');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `short_name` SET TAGS ('dbx_value_regex' = '^.{1,20}$');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `airlines_ecm`.`finance`.`cost_centre` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` SET TAGS ('dbx_subdomain' = 'accounting_records');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable ID');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fleet_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fleet Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `ground_handler_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Handler Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Approval Workflow Status');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `bsp_arc_settlement_ref` SET TAGS ('dbx_business_glossary_term' = 'BSP/ARC Settlement Reference');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Amount');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `discount_due_date` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Due Date');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Rate');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Posting Period');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `fuel_uplift_volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift Volume (Liters)');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Date');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `ifrs16_lease_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS 16 Lease Liability Flag');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_currency` SET TAGS ('dbx_business_glossary_term' = 'Invoice Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Processing Status');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'open|parked|blocked|in_approval|cleared|cancelled');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason Code');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_value_regex' = 'dispute|price_variance|missing_gr|manual_hold|audit_review');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Execution Date');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|cheque|bsp_settlement|arc_settlement|direct_debit');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Accounting Document Number');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Tax Amount');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|price_variance|quantity_variance|pending_gr|failed');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `vendor_category` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_payable` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` SET TAGS ('dbx_subdomain' = 'accounting_records');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Record ID');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `interline_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Billing Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `ageing_bucket` SET TAGS ('dbx_business_glossary_term' = 'Ageing Bucket');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `ageing_bucket` SET TAGS ('dbx_value_regex' = 'CURRENT|1_30_DAYS|31_60_DAYS|61_90_DAYS|91_120_DAYS|OVER_120_DAYS');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `ar_status` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Status');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `ar_status` SET TAGS ('dbx_value_regex' = 'OPEN|PARTIALLY_PAID|CLEARED|DISPUTED|WRITTEN_OFF|IN_DUNNING');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `bank_value_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Value Date');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `bsp_arc_billing_period` SET TAGS ('dbx_business_glossary_term' = 'Billing and Settlement Plan (BSP) / Airlines Reporting Corporation (ARC) Billing Period');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'SAP Cost Center');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_business_glossary_term' = 'Credit Control Area');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Customer Credit Limit');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `customer_account_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Number');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `customer_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `customer_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `customer_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Name');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `customer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `customer_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_currency` SET TAGS ('dbx_business_glossary_term' = 'Document Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'AR Document Number');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'SAP AR Document Type');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'DR|DG|DA|RV|AB');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Posting Period');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `interline_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Interline Carrier IATA Code');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `interline_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `last_dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Receivable Amount');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `open_amount` SET TAGS ('dbx_business_glossary_term' = 'Open (Outstanding) Receivable Amount');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `open_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `open_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'BANK_TRANSFER|BSP_SETTLEMENT|ARC_SETTLEMENT|CREDIT_CARD|DIRECT_DEBIT|CHEQUE');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Accounting Posting Date');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'SAP Profit Center');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `receivable_type` SET TAGS ('dbx_business_glossary_term' = 'Receivable Type');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `receivable_type` SET TAGS ('dbx_value_regex' = 'BSP_AGENCY|ARC_AGENCY|CORPORATE|INTERLINE|CARGO_AWB|ANCILLARY');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'MATCHED|UNMATCHED|DISPUTED|PENDING_REVIEW');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `reference_document` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`accounts_receivable` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` SET TAGS ('dbx_subdomain' = 'budget_control');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan ID');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre ID');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `ask_budget` SET TAGS ('dbx_business_glossary_term' = 'Available Seat Kilometer (ASK) Budget');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'OPEX|CAPEX|REVENUE|MIXED');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `capex_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Budget Amount');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `capex_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `cask_budget` SET TAGS ('dbx_business_glossary_term' = 'Cost per Available Seat Kilometer (CASK) Budget');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_business_glossary_term' = 'Budget Consolidation Level');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_value_regex' = 'entity|division|group|segment');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Controlling Area Code');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective From Date');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective Until Date');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `forecast_cycle` SET TAGS ('dbx_business_glossary_term' = 'Forecast Cycle');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `forecast_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `fuel_cost_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cost Budget Amount');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `fuel_cost_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `interline_settlement_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Interline Settlement Budget Amount');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `interline_settlement_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `is_rolling_forecast` SET TAGS ('dbx_business_glossary_term' = 'Is Rolling Forecast Flag');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `lease_liability_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Budget Amount (IFRS 16)');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `lease_liability_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `load_factor_budget_pct` SET TAGS ('dbx_business_glossary_term' = 'Load Factor Budget Percentage');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `locked_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Locked Date');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Notes');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `opex_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Budget Amount');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `opex_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Name');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Number');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Status');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Type');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'annual|rolling_forecast|supplemental|capital|zero_based');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Version');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `planning_horizon_years` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon (Years)');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `rask_budget` SET TAGS ('dbx_business_glossary_term' = 'Revenue per Available Seat Kilometer (RASK) Budget');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `revenue_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Budget Amount');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `revenue_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Submission Date');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `variance_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Threshold Amount');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `variance_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`budget_plan` ALTER COLUMN `variance_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Threshold Percentage');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` SET TAGS ('dbx_subdomain' = 'budget_control');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `fuel_cost_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cost Transaction ID');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre ID');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight ID');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `fuel_uplift_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift Event ID');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `airport_iata_code` SET TAGS ('dbx_business_glossary_term' = 'Airport IATA Code');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `airport_iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `carbon_emission_kg` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission (Kilograms CO2e)');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `dispute_reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Dispute Reference');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `fuel_density` SET TAGS ('dbx_business_glossary_term' = 'Fuel Density (kg/L)');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `fuel_supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Fuel Supplier Name');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'Jet-A1|SAF|Jet-A|TS-1|JP-8');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Amount');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `functional_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `gross_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Fuel Cost Amount');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `gross_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `hedge_gain_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Hedge Gain/Loss Amount');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `hedge_gain_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `hedged_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Hedged Fuel Unit Price');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `hedged_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `ifrs16_lease_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS 16 Lease Liability Flag');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `into_plane_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Into-Plane Agent Name');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `net_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Fuel Cost Amount');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `net_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Financial Posting Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `quantity_kg` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quantity (Kilograms)');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `quantity_litres` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quantity (Litres)');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `saf_blend_percentage` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Aviation Fuel (SAF) Blend Percentage');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `tax_and_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax and Surcharge Amount');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `tax_and_surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cost Transaction Number');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending|disputed|cancelled');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Fuel Unit Price');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `unit_price_currency` SET TAGS ('dbx_business_glossary_term' = 'Unit Price Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `unit_price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `uplift_source_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift Source Type');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `uplift_source_type` SET TAGS ('dbx_value_regex' = 'hydrant|bowser|pipeline|barge');
ALTER TABLE `airlines_ecm`.`finance`.`fuel_cost_transaction` ALTER COLUMN `uplift_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` SET TAGS ('dbx_subdomain' = 'asset_leasing');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract ID');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `base_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Base Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Lessee Entity Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Leased Asset Category');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `asset_category` SET TAGS ('dbx_value_regex' = 'aircraft|engine|spare_part_pool|property');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `asset_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft / Asset Registration');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Commencement Date');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `contract_currency` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `contract_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Number');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Status');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|modified|terminated|expired');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `discount_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate / Incremental Borrowing Rate (IBR) Percentage');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `discount_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiry Date');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `functional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `gl_lease_liability_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Lease Liability Account');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `gl_rou_asset_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Right-of-Use (ROU) Asset Account');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `ifrs16_exemption_type` SET TAGS ('dbx_business_glossary_term' = 'IFRS 16 Exemption Type');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `ifrs16_exemption_type` SET TAGS ('dbx_value_regex' = 'none|short_term|low_value');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `last_modification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Lease Modification Date');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `lease_liability_opening` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Opening Balance');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `lease_liability_opening` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `lease_term_months` SET TAGS ('dbx_business_glossary_term' = 'Lease Term (Months)');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Type');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `lease_type` SET TAGS ('dbx_value_regex' = 'dry_lease|wet_lease_acmi|engine_lease|spare_part_pool|property_lease');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `lessor_country_code` SET TAGS ('dbx_business_glossary_term' = 'Lessor Country Code');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `lessor_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `maintenance_reserve_flag` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Reserve Flag');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `modification_count` SET TAGS ('dbx_business_glossary_term' = 'Lease Modification Count');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Lease Payment Frequency');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `payment_in_advance_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment in Advance Flag');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `periodic_lease_payment` SET TAGS ('dbx_business_glossary_term' = 'Periodic Lease Payment Amount');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `periodic_lease_payment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `purchase_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Purchase Option Flag');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `purchase_option_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Option Price');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `purchase_option_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `renewal_option_reasonably_certain` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Reasonably Certain Flag');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `residual_value_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Residual Value Guarantee Amount');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `residual_value_guarantee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `rou_asset_value` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Use (ROU) Asset Value');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `rou_asset_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `termination_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Termination Option Flag');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `termination_option_reasonably_certain` SET TAGS ('dbx_business_glossary_term' = 'Termination Option Reasonably Certain Flag');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `variable_payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Variable Lease Payment Terms');
ALTER TABLE `airlines_ecm`.`finance`.`lease_contract` ALTER COLUMN `variable_payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` SET TAGS ('dbx_subdomain' = 'asset_leasing');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `lease_liability_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Schedule ID');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract ID');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `asset_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration / Asset Registration');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Lease Liability Balance');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `closing_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Commencement Date');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate (Incremental Borrowing Rate)');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `discount_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `extension_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Option Included Flag');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `fx_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Rate');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `initial_recognition_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Recognition Amount');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `initial_recognition_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `interest_expense` SET TAGS ('dbx_business_glossary_term' = 'Interest Expense on Lease Liability');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `interest_expense` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `journal_entry_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Posted Flag');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease End Date');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `lease_payment` SET TAGS ('dbx_business_glossary_term' = 'Lease Payment');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `lease_payment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `lease_status` SET TAGS ('dbx_business_glossary_term' = 'Lease Status');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `lease_status` SET TAGS ('dbx_value_regex' = 'active|terminated|expired|modified|subleased');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Type');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `lease_type` SET TAGS ('dbx_value_regex' = 'aircraft_operating|aircraft_finance|property_operating|property_finance|equipment_operating|equipment_finance');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `lessor_name` SET TAGS ('dbx_business_glossary_term' = 'Lessor Name');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `lessor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `low_value_asset_flag` SET TAGS ('dbx_business_glossary_term' = 'Low-Value Asset Exemption Flag');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Lease Liability Balance');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `opening_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `period_sequence` SET TAGS ('dbx_business_glossary_term' = 'Period Sequence Number');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `principal_repayment` SET TAGS ('dbx_business_glossary_term' = 'Principal Repayment');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `principal_repayment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `profit_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Code');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `remeasurement_amount` SET TAGS ('dbx_business_glossary_term' = 'Lease Liability Remeasurement Amount');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `remeasurement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `remeasurement_date` SET TAGS ('dbx_business_glossary_term' = 'Remeasurement Date');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `remeasurement_reason` SET TAGS ('dbx_business_glossary_term' = 'Remeasurement Reason');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `remeasurement_reason` SET TAGS ('dbx_value_regex' = 'lease_modification|extension_option_change|termination_option_change|index_rate_change|purchase_option_change');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `short_term_lease_flag` SET TAGS ('dbx_business_glossary_term' = 'Short-Term Lease Exemption Flag');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `termination_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Termination Option Included Flag');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `variable_lease_payment` SET TAGS ('dbx_business_glossary_term' = 'Variable Lease Payment');
ALTER TABLE `airlines_ecm`.`finance`.`lease_liability_schedule` ALTER COLUMN `variable_lease_payment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` SET TAGS ('dbx_subdomain' = 'accounting_records');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `interline_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Billing ID');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `interline_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Agreement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'AWB (Air Waybill) Number');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `billing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Document Number');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `billing_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Status');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `billing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|disputed|settled|cancelled');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `billing_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Type');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `billing_type` SET TAGS ('dbx_value_regex' = 'passenger|cargo|ancillary|adjustment');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `cabin_class` SET TAGS ('dbx_business_glossary_term' = 'Cabin Class');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `cabin_class` SET TAGS ('dbx_value_regex' = 'first|business|premium_economy|economy');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `destination_airport_iata_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport IATA (International Air Transport Association) Code');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `destination_airport_iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `fare_basis_code` SET TAGS ('dbx_business_glossary_term' = 'Fare Basis Code');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `gross_billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Billing Amount');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `origin_airport_iata_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport IATA (International Air Transport Association) Code');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `origin_airport_iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `partner_airline_iata_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Airline IATA (International Air Transport Association) Code');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `partner_airline_iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_business_glossary_term' = 'PNR (Passenger Name Record) Locator');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6}$');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `pnr_locator` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `proration_amount` SET TAGS ('dbx_business_glossary_term' = 'Proration Amount');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Billing Remarks');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `settlement_due_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Due Date');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'bsp|arc|cass|direct_billing|ich');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Ticket Number');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `ticket_number` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `ticket_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `ticket_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `airlines_ecm`.`finance`.`interline_billing` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'debit_memo|credit_memo|proration|settlement');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` SET TAGS ('dbx_subdomain' = 'accounting_records');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Transaction ID');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `booking_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Payment Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `e_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'E Ticket Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `refund_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Transaction Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `airport_code` SET TAGS ('dbx_business_glossary_term' = 'Airport IATA Code');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Document Number');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Tax Filing Reference');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `is_recoverable` SET TAGS ('dbx_business_glossary_term' = 'Is Tax Recoverable');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `local_currency_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Tax Amount');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `local_currency_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `remittance_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Remittance Date');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `source_document_type` SET TAGS ('dbx_business_glossary_term' = 'Source Document Type');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Name');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_direction` SET TAGS ('dbx_business_glossary_term' = 'Tax Direction');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_direction` SET TAGS ('dbx_value_regex' = 'INPUT|OUTPUT');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Name');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_period` SET TAGS ('dbx_business_glossary_term' = 'Tax Period');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_period` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_return_period` SET TAGS ('dbx_business_glossary_term' = 'Tax Return Period');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_return_period` SET TAGS ('dbx_value_regex' = '^d{4}-(Q[1-4]|0[1-9]|1[0-2])$');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `taxable_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Base Amount');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `taxable_base_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Transaction Status');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'POSTED|REVERSED|CLEARED|PARKED|BLOCKED');
ALTER TABLE `airlines_ecm`.`finance`.`tax_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_leasing');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Name');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_location_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Code');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|under_construction|disposed|transferred|impaired|deactivated');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_subnumber` SET TAGS ('dbx_business_glossary_term' = 'Asset Sub-Number');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'owned|finance_lease|operating_lease_rou|dry_lease|wet_lease|acmi');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalisation_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalisation Date');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method_code` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method Code');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method_code` SET TAGS ('dbx_value_regex' = 'SL|DB|UOP|SOYD|NONE');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_loss` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_value` SET TAGS ('dbx_business_glossary_term' = 'Insurance Value');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `is_ifrs16_rou_asset` SET TAGS ('dbx_business_glossary_term' = 'IFRS 16 Right-of-Use (ROU) Asset Flag');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_changed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Changed Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Commencement Date');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease End Date');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `residual_value` SET TAGS ('dbx_business_glossary_term' = 'Residual Value');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `residual_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `revaluation_amount` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Amount');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `revaluation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_periods` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Periods)');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `vendor_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Number');
ALTER TABLE `airlines_ecm`.`finance`.`fixed_asset` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` SET TAGS ('dbx_subdomain' = 'budget_control');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `airline_accounting_code` SET TAGS ('dbx_business_glossary_term' = 'IATA Airline Accounting Code');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `airline_accounting_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `arc_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'ARC Participant Flag');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `bsp_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'BSP Participant Flag');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts Code');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_business_glossary_term' = 'Company Code Status');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|in_liquidation|dormant|merged');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group Code');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `consolidation_unit` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Unit Code');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `controlling_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `corsia_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'CORSIA Participant Flag');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Country of Incorporation (ISO 3166-1 Alpha-3)');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_business_glossary_term' = 'Credit Control Area Code');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `credit_control_area` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'airline|subsidiary|holding|joint_venture|special_purpose_vehicle|branch');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Group Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `group_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `iata_airline_code` SET TAGS ('dbx_business_glossary_term' = 'IATA Airline Designator Code');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `iata_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `icao_airline_code` SET TAGS ('dbx_business_glossary_term' = 'ICAO Airline Designator Code');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `icao_airline_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `ifrs16_lessee_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS 16 Lessee Flag');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `ifrs_reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Standard');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `ifrs_reporting_standard` SET TAGS ('dbx_value_regex' = 'IFRS|US_GAAP|local_GAAP|mixed');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Incorporation');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `intercompany_elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Elimination Flag');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `operating_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Air Operator Certificate (AOC) Number');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `posting_period_variant` SET TAGS ('dbx_business_glossary_term' = 'Posting Period Variant');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `posting_period_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `registered_address` SET TAGS ('dbx_business_glossary_term' = 'Registered Office Address');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `registered_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `registered_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Country (ISO 3166-1 Alpha-3)');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `registered_address_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Company Short Name');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|manual|migration');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `airlines_ecm`.`finance`.`company_code` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'budget_control');
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ALTER COLUMN `parent_legal_entity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
