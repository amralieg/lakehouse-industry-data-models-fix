-- Schema for Domain: finance | Business: Semiconductors | Version: v1_mvm
-- Generated on: 2026-05-06 20:34:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `semiconductors_ecm`.`finance` COMMENT 'Corporate financial management including general ledger, cost center accounting, capital expenditure tracking for fab equipment, R&D capitalization, budget planning, financial consolidation, NRE cost recovery, wafer cost modeling, and fab utilization-based cost allocation. Supports SOX-compliant financial reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'System-generated unique identifier for the cost center.',
    `legal_entity_id` BIGINT COMMENT 'FK to finance.legal_entity',
    `parent_cost_center_id` BIGINT COMMENT 'Identifier of the immediate parent cost center in the hierarchy.',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `allocation_method` STRING COMMENT 'Method used to allocate costs (e.g., headcount, fab utilization, revenue, custom).. Valid values are `headcount|fab_utilization|revenue|custom`',
    `audit_trail` STRING COMMENT 'Free‑form notes capturing audit trail information for the cost center.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned budget amount allocated to the cost center for the fiscal year.',
    `budget_year` STRING COMMENT 'Fiscal year for which the budget amount applies.',
    `controlling_area` STRING COMMENT 'Controlling area to which the cost center belongs for internal reporting.',
    `cost_center_category` STRING COMMENT 'Category classification such as expense, investment, or overhead.',
    `cost_center_code` STRING COMMENT 'Business code used to reference the cost center in financial postings.',
    `cost_center_description` STRING COMMENT 'Free‑form description providing additional context about the cost center.',
    `cost_center_group` STRING COMMENT 'Logical grouping of cost centers for reporting (e.g., fab group, R&D group).',
    `cost_center_name` STRING COMMENT 'Human‑readable name of the cost center.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center.. Valid values are `active|inactive|planned|closed`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center (e.g., fab, R&D, corporate, support).. Valid values are `fab|r&d|corporate|support`',
    `cost_element` STRING COMMENT 'Cost element code associated with the cost center for expense categorization.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the cost center operates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost center record was created in the source system.',
    `currency` STRING COMMENT 'ISO 4217 currency code used for budgeting and reporting.',
    `department_code` STRING COMMENT 'Code of the department to which the cost center belongs.',
    `external_reference` STRING COMMENT 'Identifier of the cost center in external systems (e.g., legacy ERP).',
    `hierarchy_level` STRING COMMENT 'Depth level of the cost center within the organizational hierarchy.',
    `is_active` BOOLEAN COMMENT 'True if the cost center is currently active; false otherwise.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the cost center contains confidential financial information.',
    `last_review_date` DATE COMMENT 'Date when the cost center was last reviewed for relevance and accuracy.',
    `natural_account` STRING COMMENT 'General ledger natural account linked to the cost center.',
    `plant_code` STRING COMMENT 'Identifier of the manufacturing plant associated with the cost center.',
    `region_code` STRING COMMENT 'Three‑letter region identifier (e.g., APJ, EMEA, AMER).',
    `reporting_line` STRING COMMENT 'Organizational reporting line identifier for the cost center.',
    `responsibility_center_code` STRING COMMENT 'Code of the responsibility center linked to the cost center.',
    `review_cycle` STRING COMMENT 'Frequency of cost center reviews.. Valid values are `annual|quarterly|monthly`',
    `subdepartment_code` STRING COMMENT 'Code of the sub‑department within the department.',
    `tax_code` STRING COMMENT 'Tax code applicable to the cost center for tax reporting.',
    `to_company_code` BIGINT COMMENT 'FK to finance.company_code.company_code_id — Cost centers belong to a specific company code/controlling area. Required for organizational hierarchy and reporting boundaries.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cost center record.',
    `validity_flag` BOOLEAN COMMENT 'True if the cost center is within its validity period; false otherwise.',
    `valid_from` DATE COMMENT 'Date when the cost center becomes effective.',
    `valid_to` DATE COMMENT 'Date when the cost center ceases to be effective (null if open‑ended).',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Authoritative master record for all SAP CO cost centers used in semiconductor operations. Captures fab cost centers (FEOL, BEOL, CMP, lithography), R&D cost centers, engineering support centers, and corporate overhead pools. Includes cost center hierarchy, responsible manager, controlling area, currency, validity periods, and budget allocation type. SSOT for cost center identity used across all financial postings.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'Unique surrogate key for the GL account record.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: The chart of accounts in SAP FI is defined at the company code level, which maps to a legal entity. In semiconductor enterprises with multiple legal entities (fab subsidiary, design entity, holding co',
    `account_category` STRING COMMENT 'Secondary classification such as operating, non‑operating, or statutory.',
    `account_code` STRING COMMENT 'Business identifier used in the chart of accounts; often alphanumeric (e.g., 4000, 5-200).',
    `account_group` STRING COMMENT 'Group identifier used for reporting aggregation (e.g., 4‑Revenue, 5‑COGS).',
    `account_level` STRING COMMENT 'Hierarchical level of the account within the chart of accounts (e.g., 1‑5).',
    `account_name` STRING COMMENT 'Human‑readable name describing the purpose of the account.',
    `account_subgroup` STRING COMMENT 'Sub‑group within an account group for finer granularity.',
    `account_type` STRING COMMENT 'Classification of the account for financial statement mapping.. Valid values are `asset|liability|equity|revenue|expense`',
    `amortization_flag` BOOLEAN COMMENT 'Indicates whether the account is subject to amortization (e.g., intangible assets).',
    `closing_balance` DECIMAL(18,2) COMMENT 'Balance of the account at the end of the fiscal year.',
    `cost_center_code` STRING COMMENT 'Cost center to which the account is charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the GL account record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter code of the functional currency for the account.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Method used to calculate depreciation for asset‑type accounts.. Valid values are `straight_line|double_declining|units_of_production`',
    `depreciation_rate` DECIMAL(18,2) COMMENT 'Annual depreciation rate expressed as a percentage.',
    `external_reference` STRING COMMENT 'Reference to the account in external systems (e.g., legacy ERP code).',
    `financial_statement` STRING COMMENT 'Financial statement where the account is reported.. Valid values are `balance_sheet|income_statement|cash_flow`',
    `gl_account_description` STRING COMMENT 'Extended textual description of the account purpose and usage.',
    `gl_account_status` STRING COMMENT 'Current lifecycle state of the account record.. Valid values are `active|inactive|pending|closed`',
    `is_budget_controlled` BOOLEAN COMMENT 'Indicates whether the account is subject to budgetary controls.',
    `is_consolidation_account` BOOLEAN COMMENT 'Indicates whether the account participates in legal entity consolidation.',
    `is_reconciliation_account` BOOLEAN COMMENT 'True if the account is used for automatic reconciliation of sub‑ledger postings.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Balance of the account at the start of the fiscal year.',
    `posting_restriction_flag` BOOLEAN COMMENT 'True if posting to the account is restricted by policy.',
    `profit_center_code` STRING COMMENT 'Profit center associated with the account for profitability analysis.',
    `reporting_currency` STRING COMMENT 'Currency used for consolidated financial reporting.. Valid values are `^[A-Z]{3}$`',
    `segment_code` STRING COMMENT 'Business segment identifier (e.g., product line, geography) used for reporting.',
    `tax_category` STRING COMMENT 'Tax treatment applicable to the account.. Valid values are `taxable|exempt|zero_rate`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate percentage for the account, expressed as a decimal (e.g., 7.25).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the GL account record.',
    `valid_from` DATE COMMENT 'Date when the account becomes effective.',
    `valid_to` DATE COMMENT 'Date when the account is retired or becomes inactive; null if open‑ended.',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'General ledger chart of accounts master for the semiconductor enterprise. Covers P&L accounts (wafer cost, NRE revenue, R&D expense, depreciation), balance sheet accounts (fab equipment assets, WIP inventory, receivables), and statistical accounts. Includes account type, financial statement version assignment, tax category, reconciliation account flag, and SOX control classification. Sourced from SAP FI chart of accounts.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Unique system-generated identifier for the profit center.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Each profit center in SAP EC-PCA belongs to a specific legal entity for financial consolidation and SOX-compliant reporting. Semiconductor enterprises operate multiple legal entities (e.g., design hou',
    `parent_profit_center_id` BIGINT COMMENT 'Identifier of the immediate parent profit center in the hierarchy.',
    `actual_spend` DECIMAL(18,2) COMMENT 'Actual expenditures recorded against the profit center.',
    `allocation_percent` DECIMAL(18,2) COMMENT 'Percentage of corporate overhead allocated to this profit center.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned budget allocated to the profit center for the fiscal period.',
    `budget_currency` STRING COMMENT 'ISO 4217 currency code of the budget amount, e.g., USD.',
    `change_reason` STRING COMMENT 'Free‑form text describing why the profit center record was changed.',
    `controlling_area` STRING COMMENT 'Controlling area code to which the profit center belongs in SAP CO.',
    `cost_allocation_method` STRING COMMENT 'Method used to allocate costs to the profit center.. Valid values are `direct|activity_based|standard`',
    `created_by_user` STRING COMMENT 'User ID of the person who created the profit center record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the profit center record was first created in the system.',
    `end_date` DATE COMMENT 'Date when the profit center was retired or closed (nullable).',
    `fab_location` STRING COMMENT 'Fabrication facility location associated with the profit center.',
    `geographic_region` STRING COMMENT 'Regional market or sales region covered by the profit center.',
    `hierarchy_level` STRING COMMENT 'Depth level of the profit center within the organizational hierarchy.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the profit center is included in corporate consolidation.',
    `last_review_date` DATE COMMENT 'Date of the most recent financial or operational review.',
    `product_line` STRING COMMENT 'Product family or line that the profit center supports.',
    `profit_center_category` STRING COMMENT 'High‑level category used for reporting and analysis.. Valid values are `product_line|technology_node|geography|service|support`',
    `profit_center_code` STRING COMMENT 'Business code used in SAP and reporting to identify the profit center.',
    `profit_center_description` STRING COMMENT 'Free‑form description providing context and business purpose.',
    `profit_center_group` STRING COMMENT 'Higher‑level grouping of profit centers for consolidated reporting.',
    `profit_center_name` STRING COMMENT 'Human‑readable name of the profit center, e.g., "Advanced Logic ASICs".',
    `profit_center_status` STRING COMMENT 'Current operational status of the profit center.. Valid values are `active|inactive|planned|closed|suspended`',
    `profit_center_type` STRING COMMENT 'Category that defines the nature of the profit center.. Valid values are `product_line|technology_node|geography|service|support`',
    `reporting_currency` STRING COMMENT 'Currency in which the profit center reports financial results.',
    `responsibility_center` STRING COMMENT 'Internal responsibility center code for cost allocation.',
    `review_cycle` STRING COMMENT 'Frequency of scheduled reviews for the profit center.. Valid values are `monthly|quarterly|annual`',
    `sox_compliant` BOOLEAN COMMENT 'Flag indicating SOX compliance for financial reporting.',
    `start_date` DATE COMMENT 'Date when the profit center became effective.',
    `subgroup` STRING COMMENT 'Secondary grouping within a profit center group.',
    `technology_node` STRING COMMENT 'Process technology node (e.g., 5nm, 7nm) linked to the profit center.',
    `to_company_code` BIGINT COMMENT 'FK to finance.company_code.company_code_id — Profit centers are assigned to company codes for legal entity-level profitability reporting.',
    `transfer_pricing_indicator` BOOLEAN COMMENT 'Flag indicating whether the profit center participates in internal transfer pricing.',
    `updated_by_user` STRING COMMENT 'User ID of the person who last updated the profit center record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the profit center record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between budgeted and actual spend (budget - actual).',
    `version_number` STRING COMMENT 'Incremental version number for change tracking.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'SAP EC-PCA profit center master representing autonomous business segments for internal profitability reporting. Covers product lines (SoC, ASIC, FPGA, discrete), technology nodes (5nm, 7nm, 28nm), and geographic segments. Includes profit center hierarchy, responsible manager, controlling area assignment, and transfer pricing indicator. Enables margin analysis by product family and technology generation.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'System-generated unique identifier for the journal entry.',
    `account_id` BIGINT COMMENT 'Identifier of the customer involved in the transaction.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entries are posted against cost center, profit center, internal order and WBS element; FK replaces ambiguous code fields.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Export‑controlled sales require each journal entry to reference the export license authorizing the shipment for compliance reporting.',
    `fabrication_wafer_lot_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_wafer_lot. Business justification: WIP inventory valuation journal entries in semiconductor fabs reference specific wafer lots for lot-level cost traceability. Required for WIP accounting, lot cost variance analysis, scrap write-off jo',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Link journal entry to internal order for cost allocation and tracking.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Every SAP FI journal entry is posted within a company code that maps directly to a legal entity. For SOX-compliant financial reporting and intercompany reconciliation in semiconductor enterprises, jou',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Journal entries need a reliable link to profit center for reporting.',
    `order_id` BIGINT COMMENT 'Foreign key linking to order.order. Business justification: Revenue journal entries must reference the originating sales order for audit trails and financial reporting.',
    `supplier_id` BIGINT COMMENT 'Identifier of the vendor involved in the transaction.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Journal entries should reference the WBS element they belong to.',
    `amount_base` DECIMAL(18,2) COMMENT 'Total amount of the entry converted to the corporate group currency.',
    `amount_local` DECIMAL(18,2) COMMENT 'Total amount of the entry in the documents currency.',
    `asset_number` STRING COMMENT 'Fixed‑asset identifier for depreciation or acquisition postings.',
    `business_area` STRING COMMENT 'Higher‑level grouping of profit centers for reporting.',
    `company_code` STRING COMMENT 'Organizational unit identifier for legal entity reporting.',
    `consolidation_group` STRING COMMENT 'Group identifier for consolidation adjustments.',
    `consolidation_method` STRING COMMENT 'Method used for the consolidation entry.. Valid values are `elimination|translation|goodwill|minority|adjustment`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the journal entry record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the document.. Valid values are `[A-Z]{3}`',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether the line is a debit or credit.. Valid values are `debit|credit`',
    `document_number` STRING COMMENT 'External business identifier for the journal entry document.',
    `document_type` STRING COMMENT 'Category of the financial document (e.g., vendor invoice, intercompany).. Valid values are `vendor_invoice|customer_payment|asset_depreciation|accrual|intercompany|consolidation`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert document currency to group currency.',
    `fiscal_period` STRING COMMENT 'Two‑digit period within the fiscal year (01‑12).. Valid values are `0[1-9]|1[0-2]`',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the entry belongs.',
    `functional_area` STRING COMMENT 'Functional area code for internal reporting.',
    `intercompany_indicator` BOOLEAN COMMENT 'True if the entry is part of an intercompany transaction.',
    `journal_entry_description` STRING COMMENT 'Free‑text description of the journal entry purpose.',
    `ledger_account` STRING COMMENT 'General Ledger account number associated with the entry.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after tax and adjustments.',
    `period_end_date` DATE COMMENT 'End date of the accounting period for the entry.',
    `posting_key` STRING COMMENT 'SAP posting key that determines debit/credit logic.. Valid values are `d{2}`',
    `posting_status` STRING COMMENT 'Current processing status of the journal entry.. Valid values are `posted|pending|reversed|error`',
    `posting_timestamp` TIMESTAMP COMMENT 'Exact date and time when the entry was posted to the ledger.',
    `reference_document_number` STRING COMMENT 'Document number of the original entry being referenced.',
    `reversal_date` DATE COMMENT 'Date on which the reversal was posted.',
    `reversal_indicator` BOOLEAN COMMENT 'True if the entry reverses a previous posting.',
    `segment` STRING COMMENT 'Market or product segment for analytical reporting.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the entry.',
    `tax_code` STRING COMMENT 'Tax code determining tax calculation rules.',
    `to_company_code` BIGINT COMMENT 'FK to finance.company_code.company_code_id — Every journal entry is posted within a specific legal entity (company code). Required for legal entity reporting and consolidation.',
    `updated_by` STRING COMMENT 'User identifier who last modified the journal entry record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the journal entry record.',
    `created_by` STRING COMMENT 'User identifier who created the journal entry record.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Core SAP FI general ledger journal entry capturing all financial postings across the semiconductor enterprise including consolidation adjustments. Document types include vendor invoice, customer payment, asset depreciation, accrual, intercompany, and consolidation entries (intercompany elimination, minority interest adjustment, currency translation adjustment, goodwill amortization). Captures posting date, fiscal period, company code, currency, exchange rate, consolidation unit/group (for group entries), consolidation method, and SOX-relevant reversal indicator. Covers fab cost postings, NRE revenue recognition, R&D capitalization entries, period-end accruals, and group-level consolidation adjustments for SOX-compliant financial reporting under US GAAP or IFRS. Primary transactional record and audit trail for all financial activity.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` (
    `journal_entry_line_id` BIGINT COMMENT 'Unique identifier for the journal entry line record.',
    `booking_id` BIGINT COMMENT 'Foreign key linking to sales.booking. Business justification: Revenue recognition report requires each journal entry line to map to its originating sales booking for reconciliation.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center.cost_center_id — Cost center assignment on journal entry lines is required for management accounting, cost allocation, and P&L reporting by organizational unit.',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account.gl_account_id — Every journal entry line posts to a GL account. This is the core of double-entry bookkeeping and is required for trial balance, financial statements, and all reporting.',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Line‑level journal entries need the order line ID to allocate revenue and cost precisely per SKU.',
    `maintenance_event_id` BIGINT COMMENT 'Foreign key linking to equipment.maintenance_event. Business justification: Financial postings for maintenance costs must reference the originating maintenance event to provide audit trail, enable cost reconciliation between finance and operations systems, and support varianc',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the parent journal entry header to which this line belongs.',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center.profit_center_id — Profit center assignment enables profitability analysis by business segment, technology node, and product line - core semiconductor finance requirement.',
    `to_journal_entry_id` BIGINT COMMENT 'FK to finance.journal_entry.journal_entry_id — Fundamental header-line relationship. Every journal entry line must reference its parent journal entry document. This is the most critical FK in the entire domain - without it, line items are orphaned',
    `wafer_start_authorization_id` BIGINT COMMENT 'Foreign key linking to order.wafer_start_authorization. Business justification: WSA-related costs (wafer starts, NRE charges) are posted to GL via journal entries; linking enables cost reconciliation and audit trail for capitalized vs. expensed wafer starts. Controllers reconcile',
    `wbs_element_id` BIGINT COMMENT 'FK to finance.wbs_element',
    `amount_document_currency` DECIMAL(18,2) COMMENT 'Monetary amount of the line expressed in the documents currency.',
    `amount_local_currency` DECIMAL(18,2) COMMENT 'Monetary amount of the line converted to the companys local currency.',
    `assignment_field` STRING COMMENT 'User‑defined field for additional cost allocation or tagging.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the document currency.',
    `debit_credit_indicator` STRING COMMENT 'Indicates whether the line is a debit or credit.. Valid values are `debit|credit`',
    `effective_date` DATE COMMENT 'Date from which the line amount becomes effective for reporting.',
    `functional_area` STRING COMMENT 'Functional area classification for reporting (e.g., R&D, Manufacturing).',
    `line_description` STRING COMMENT 'Free‑text description of the line item.',
    `line_status` STRING COMMENT 'Current processing status of the line.. Valid values are `open|cleared|reversed|pending`',
    `posting_date` DATE COMMENT 'Date on which the line is posted to the ledger.',
    `quantity` STRING COMMENT 'Quantity associated with the line (e.g., number of units, hours).',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this line reverses a previous entry.',
    `source_system` STRING COMMENT 'Identifier of the source system that generated the journal entry line.. Valid values are `SAP|Oracle|Salesforce|MES|Custom|Other`',
    `tax_code` STRING COMMENT 'Tax code determining tax treatment for the line.',
    `to_journal_entry` BIGINT COMMENT 'FK to finance.journal_entry.journal_entry_id — Header-line relationship is the most fundamental FK in any GL system. Every line item must reference its parent journal entry document. Without this, you cannot reconstruct a balanced journal entry.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the line record.',
    CONSTRAINT pk_journal_entry_line PRIMARY KEY(`journal_entry_line_id`)
) COMMENT 'Individual debit/credit line items within a SAP FI journal entry document. Each line captures GL account, cost center, profit center, WBS element, functional area, amount in document and local currency, tax code, and assignment field. Supports granular cost allocation to fab process steps, equipment depreciation lines, and NRE milestone revenue lines. Essential for drill-down financial analysis and SOX audit trails.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`capex_request` (
    `capex_request_id` BIGINT COMMENT 'System-generated unique identifier for the capital expenditure request.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Capex requests are tied to a cost center; using an FK removes the ambiguous code column.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: Capital equipment purchases subject to export controls must be tied to the relevant export license for financial tracking and audit.',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Capex requests are for equipment to be installed in specific fab facilities. Required for facility-level capital planning, capacity expansion tracking, and CHIPS Act investment reporting by fab locati',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Capex requests in semiconductor fabs are made for equipment supporting specific technology nodes. The existing technology_node plain attribute is a denormalization. Required for node-level capital inv',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: In SAP CO, capital expenditure requests are frequently linked to internal orders used to collect and track costs prior to capitalization as fixed assets. For semiconductor fab equipment purchases, an ',
    `fixed_asset_id` BIGINT COMMENT 'FK to finance.fixed_asset.fixed_asset_id — Approved capex requests result in fixed asset creation. Links investment approval to the resulting asset for lifecycle tracking.',
    `supplier_id` BIGINT COMMENT 'Identifier of the external supplier providing the equipment.',
    `to_fixed_asset_id` BIGINT COMMENT 'FK to finance.fixed_asset.fixed_asset_id — Approved capex requests result in fixed asset creation. This FK links the investment decision to the resulting asset record, enabling capex tracking from request through asset lifecycle.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Capital expenditure requests for semiconductor fab equipment are tracked against WBS elements in SAP PS for project-level cost control and R&D capitalization. A capex request for a lithography tool or',
    `approval_stage` STRING COMMENT 'Current approval workflow stage of the request.. Valid values are `initial|financial|executive`',
    `approval_status` STRING COMMENT 'Result of the most recent approval action.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the request was last approved or rejected.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Final amount approved after any adjustments.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget amount allocated for the request.',
    `business_case_summary` STRING COMMENT 'Brief narrative describing the strategic rationale and expected ROI.',
    `capex_request_status` STRING COMMENT 'Current lifecycle status of the capex request.. Valid values are `draft|submitted|approved|rejected|cancelled`',
    `chips_act_funding_eligible` BOOLEAN COMMENT 'Indicates whether the request qualifies for CHIPS Act financial incentives.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the request record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the requested amount (e.g., USD, EUR).',
    `depreciation_end_date` DATE COMMENT 'Date when the asset is fully depreciated.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the capital asset.. Valid values are `straight_line|double_declining|units_of_production`',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation of the asset begins.',
    `equipment_category` STRING COMMENT 'High‑level classification of the fab equipment being requested.. Valid values are `lithography|cmp|cvd|pvd|ald|ate`',
    `equipment_model` STRING COMMENT 'Manufacturer model number or SKU of the equipment (e.g., NXE:3400).',
    `funding_source` STRING COMMENT 'Source of capital funds for the investment.. Valid values are `internal|external|chips_act|government_grant`',
    `justification` STRING COMMENT 'Detailed technical justification, including technology node applicability and capacity impact.',
    `request_amount` DECIMAL(18,2) COMMENT 'Total monetary amount requested for the investment before any adjustments.',
    `request_date` TIMESTAMP COMMENT 'Date and time when the capex request was initially submitted.',
    `request_number` STRING COMMENT 'Human‑readable request number assigned by the finance system (e.g., CR‑2023‑00123).',
    `requester_name` STRING COMMENT 'Full name of the employee requesting the investment.',
    `risk_rating` STRING COMMENT 'Risk assessment rating for the investment request.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the request record.',
    `useful_life_years` STRING COMMENT 'Estimated economic useful life of the asset in years for depreciation.',
    `vendor_name` STRING COMMENT 'Legal name of the equipment supplier.',
    CONSTRAINT pk_capex_request PRIMARY KEY(`capex_request_id`)
) COMMENT 'Capital expenditure request and approval record for semiconductor fab equipment investments. Captures investment type (lithography scanner, CMP tool, CVD/PVD/ALD system, ATE platform, metrology tool), requested amount, business justification, technology node applicability, expected useful life, depreciation method, and multi-level approval workflow status. Tracks NRE vs. recurring capex classification and CHIPS Act funding eligibility. Links to SAP IM investment program.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'System-generated unique identifier for each fixed asset record.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center.cost_center_id — Every fixed asset is assigned to a cost center for depreciation posting and cost allocation. Critical for fab equipment cost tracking.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Semiconductor fab equipment (lithography tools, deposition systems, etchers) frequently has export control classifications due to advanced technology. Compliance teams must track ECCN for capital asse',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Fixed assets (fab equipment, buildings) are physically located in fab facilities. Required for facility-level asset register reporting, insurance valuation, depreciation allocation by facility, and CH',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Capital equipment is qualified for and dedicated to specific technology nodes. The existing technology_node_nm plain attribute is a denormalization. Required for technology-node-level asset depreciati',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Semiconductor fab equipment (fixed assets) is capitalized from WBS elements representing capital projects. The WBS element tracks the project costs that are subsequently settled to the fixed asset upo',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to fabrication.work_center. Business justification: Fixed assets are physically assigned to work centers in semiconductor fabs. Required for work-center-level asset tracking, maintenance scheduling integration, and depreciation allocation to the correc',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation recorded to date for the asset.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total cost incurred to acquire the asset, including purchase price, freight, installation, and commissioning.',
    `acquisition_date` DATE COMMENT 'Date the asset was purchased or otherwise acquired.',
    `asset_category` STRING COMMENT 'Higher‑level classification (e.g., Equipment, Facility, IT Infrastructure).',
    `asset_name` STRING COMMENT 'Human‑readable name of the asset (e.g., EUV Lithography Scanner 1).',
    `asset_tag` STRING COMMENT 'Unique alphanumeric tag or barcode assigned to the asset for physical identification.',
    `asset_type` STRING COMMENT 'Category of the asset such as Lithography Scanner, CVD Tool, CMP Equipment, Cleanroom Infrastructure, or IT Asset.',
    `capitalized` BOOLEAN COMMENT 'Indicates whether the asset has been capitalized on the balance sheet (True) or remains expense (False).',
    `created_by_user` STRING COMMENT 'User identifier of the person who created the asset record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fixed asset record was first created in the system.',
    `depreciation_adjustment_amount` DECIMAL(18,2) COMMENT 'Additional depreciation amount applied due to changes in utilization or technology node retirement.',
    `depreciation_amount` DECIMAL(18,2) COMMENT 'Depreciation expense posted for the most recent fiscal period.',
    `depreciation_end_date` DATE COMMENT 'Projected date when the asset will be fully depreciated or disposed.',
    `depreciation_key` STRING COMMENT 'Code that determines the depreciation area (e.g., book, tax, IFRS) and rules applied.',
    `depreciation_method` STRING COMMENT 'Algorithm used to calculate periodic depreciation.. Valid values are `straight_line|double_declining|units_of_production`',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation calculations begin for the asset.',
    `disposal_date` DATE COMMENT 'Date the asset was removed from service and disposed of, sold, or transferred.',
    `disposal_method` STRING COMMENT 'Method by which the asset was disposed.. Valid values are `sale|scrap|transfer`',
    `disposal_proceeds` DECIMAL(18,2) COMMENT 'Monetary proceeds received from the disposal of the asset.',
    `fixed_asset_status` STRING COMMENT 'Current operational state of the asset.. Valid values are `in_service|retired|maintenance|disposed|pending`',
    `grant_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the grant allocated to the asset.',
    `grant_recognition_date` DATE COMMENT 'Date on which the grant amount is recognized in financial statements.',
    `grant_tracking_number` STRING COMMENT 'Reference number for CHIPS Act or other government grant associated with the asset.',
    `impairment_amount` DECIMAL(18,2) COMMENT 'Monetary amount by which the assets carrying value is reduced due to impairment.',
    `impairment_indicator` BOOLEAN COMMENT 'Flag indicating whether an impairment test has been performed and resulted in a loss.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity performed on the asset.',
    `location_bay` STRING COMMENT 'Specific bay or cleanroom area within the building housing the asset.',
    `location_building` STRING COMMENT 'Name or code of the building where the asset is installed.',
    `maintenance_contract_number` STRING COMMENT 'Contract identifier for the service agreement covering preventive maintenance.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Assets carrying amount after subtracting accumulated depreciation.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next scheduled maintenance.',
    `remaining_useful_life_years` STRING COMMENT 'Estimated remaining economic life of the asset, expressed in years.',
    `responsible_department` STRING COMMENT 'Organizational department that owns or manages the asset.',
    `updated_by_user` STRING COMMENT 'User identifier of the person who last modified the asset record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fixed asset record.',
    `useful_life_years` STRING COMMENT 'Planned economic life of the asset expressed in years for depreciation purposes.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Average operational utilization of the asset expressed as a percentage of its capacity.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'SAP FI-AA fixed asset master and full depreciation lifecycle for semiconductor manufacturing equipment and infrastructure. Covers EUV/DUV lithography scanners, deposition systems (CVD/PVD/ALD), etch tools, CMP equipment, ATE platforms, cleanroom infrastructure, and IT assets. Master attributes include asset class, acquisition cost, capitalization date, useful life, depreciation key, location (fab building/bay), technology node assignment, and CHIPS Act grant tracking. Depreciation records capture each periodic posting: run date, fiscal period, depreciation area (book/tax/IFRS), depreciation amount, accumulated depreciation, net book value, and remaining useful life. Supports fab utilization-based depreciation adjustments, technology node retirement accounting, asset impairment testing, and disposal/transfer processing. SSOT for the complete asset register from acquisition through disposal including all depreciation schedules. Generated by SAP FI-AA depreciation run (AFAB).';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` (
    `asset_depreciation_id` BIGINT COMMENT 'System-generated unique identifier for each depreciation posting record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Asset depreciation records should reference the cost center responsible for the asset.',
    `fab_tool_id` BIGINT COMMENT 'Foreign key linking to equipment.fab_tool. Business justification: Depreciation journal entries must reference the specific fab_tool being depreciated to enable asset lifecycle tracking, impairment testing, and monthly depreciation runs with asset-level detail for fi',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Each periodic depreciation posting for semiconductor fab equipment generates a corresponding SAP FI journal entry. Linking asset_depreciation to its journal_entry provides the audit trail from the dep',
    `fixed_asset_id` BIGINT COMMENT 'Unique identifier of the fab equipment or infrastructure asset being depreciated.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation accumulated on the asset up to the posting date.',
    `approval_status` STRING COMMENT 'Workflow status of the depreciation posting approval.. Valid values are `approved|rejected|under_review`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the posting was approved or rejected.',
    `asset_depreciation_status` STRING COMMENT 'Current processing status of the depreciation line.. Valid values are `posted|reversed|pending|error`',
    `batch_number` STRING COMMENT 'Identifier of the batch job that performed the depreciation calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the depreciation record was initially created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts (e.g., USD).',
    `depreciation_adjustment_amount` DECIMAL(18,2) COMMENT 'Additional amount added/subtracted to the base depreciation due to utilization or revaluation.',
    `depreciation_amount` DECIMAL(18,2) COMMENT 'Depreciation expense posted for the period in the selected currency.',
    `depreciation_area` STRING COMMENT 'Accounting area for the depreciation amount – book (GAAP), tax, or IFRS.. Valid values are `book|tax|ifrs`',
    `depreciation_method` STRING COMMENT 'Method used to calculate depreciation for the asset.. Valid values are `straight_line|double_declining|units_of_production|sum_of_years_digits`',
    `depreciation_rate` DECIMAL(18,2) COMMENT 'Annual depreciation rate expressed as a percentage.',
    `external_reference_number` STRING COMMENT 'Reference to external documentation or audit trail (e.g., audit report ID).',
    `fiscal_period` STRING COMMENT 'Period number within the fiscal year (typically month 1‑12).',
    `fiscal_year` STRING COMMENT 'Four‑digit calendar year of the depreciation posting (e.g., 2024).',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the depreciation run.',
    `notes` STRING COMMENT 'Free‑form comments or explanations for the posting.',
    `posted_date` DATE COMMENT 'Date on which the depreciation entry was posted to the ledger.',
    `remaining_useful_life_months` STRING COMMENT 'Estimated remaining service life of the asset in months after this posting.',
    `source_system` STRING COMMENT 'Originating ERP or system that generated the depreciation run (e.g., SAP FI‑AA).',
    `technology_node` STRING COMMENT 'Process technology node associated with the asset (e.g., 7nm, 14nm).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the depreciation record.',
    `utilization_factor` DECIMAL(18,2) COMMENT 'Factor reflecting actual equipment utilization used to adjust depreciation.',
    CONSTRAINT pk_asset_depreciation PRIMARY KEY(`asset_depreciation_id`)
) COMMENT 'Periodic depreciation posting records for semiconductor fab equipment and infrastructure assets. Captures depreciation run date, fiscal period, asset, depreciation area (book, tax, IFRS), depreciation amount, accumulated depreciation to date, and remaining useful life. Supports fab utilization-based depreciation adjustments and technology node retirement accounting. Generated by SAP FI-AA depreciation run (AFAB).';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`internal_order` (
    `internal_order_id` BIGINT COMMENT 'System-generated unique identifier for the internal order.',
    `export_license_id` BIGINT COMMENT 'Foreign key linking to compliance.export_license. Business justification: R&D internal orders and capital projects involving controlled technology (advanced process nodes, EUV lithography, AI chip designs) require export licenses for equipment procurement or technology deve',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center responsible for the orders expenses.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: SAP CO internal orders are assigned to profit centers for internal profitability analysis. In semiconductor operations, R&D internal orders, NRE cost collection orders, and fab project orders must be ',
    `to_cost_center_id` BIGINT COMMENT 'FK to finance.cost_center.cost_center_id — Internal orders are assigned to responsible cost centers for settlement and organizational reporting.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred against the internal order to date.',
    `auditor_approval_date` DATE COMMENT 'Date on which the auditor provided approval for capitalization.',
    `auditor_approval_flag` BOOLEAN COMMENT 'Indicates whether the internal order has been approved by the external auditor for capitalization.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget for the internal order expressed in the order currency.',
    `capitalization_date` DATE COMMENT 'Date on which eligible costs were capitalized to an intangible asset.',
    `capitalization_eligibility` BOOLEAN COMMENT 'Indicates whether the order meets criteria for R&D cost capitalization.',
    `closure_date` DATE COMMENT 'Date when the internal order was closed and settled.',
    `commitment_amount` DECIMAL(18,2) COMMENT 'Committed cost amount that cannot be exceeded without re‑approval.',
    `completion_date` DATE COMMENT 'Date when the order reached technically complete status.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary values.. Valid values are `[A-Z]{3}`',
    `internal_order_description` STRING COMMENT 'Free‑text description of the purpose and scope of the internal order.',
    `internal_order_status` STRING COMMENT 'Current lifecycle state of the internal order.. Valid values are `created|released|technically_complete|closed|cancelled|pending`',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent status transition for the order.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after any adjustments, taxes, or discounts applied to the order.',
    `order_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the internal order was initially created in the source system.',
    `order_number` STRING COMMENT 'Business-visible identifier assigned to the internal order.',
    `order_type` STRING COMMENT 'Classification of the order purpose (e.g., research & development, equipment maintenance, non‑recurring engineering).. Valid values are `R&D|Maintenance|NRE|Corporate|Capital|Other`',
    `real_indicator` BOOLEAN COMMENT 'True if the order records real, incurred costs.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first captured in the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the internal order record.',
    `release_date` DATE COMMENT 'Date when the internal order was released for execution.',
    `settlement_rule` STRING COMMENT 'Rule that determines how costs are settled (to an asset, cost center, or WBS element).. Valid values are `asset|cost_center|wbs`',
    `statistical_indicator` BOOLEAN COMMENT 'True if the order is used for statistical cost allocation rather than actual cost tracking.',
    `trl` STRING COMMENT 'Readiness level of the technology (1‑9) at the time of order creation.',
    CONSTRAINT pk_internal_order PRIMARY KEY(`internal_order_id`)
) COMMENT 'SAP CO internal order master for collecting, tracking, settling, and capitalizing costs of specific semiconductor initiatives. Covers R&D capitalization orders (process node development, IP core development, EDA tool evaluation), fab equipment maintenance campaign orders, customer-specific NRE execution orders, and corporate initiative orders. Includes order type, status lifecycle (created/released/technically complete/closed), responsible cost center, settlement rule (to asset, cost center, or WBS), overall budget, commitment value, actual cost, and statistical/real indicator. Full R&D capitalization lifecycle: tracks technology readiness level, capitalization eligibility assessment per ASC 730/IAS 38, original expense amounts, capitalized amounts, capitalization date, asset under construction reference, and auditor approval. Enables end-to-end cost collection from initial R&D expense through capitalization event to intangible asset creation. Sourced from SAP CO-OM/CO-PC.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`wbs_element` (
    `wbs_element_id` BIGINT COMMENT 'Unique surrogate key for the WBS element record.',
    `chips_act_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.chips_act_obligation. Business justification: CHIPS Act grants tie funding to specific project WBS elements with compliance obligations (domestic production commitments, workforce training, childcare provisions). Finance must track actual spend a',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: WBS elements belong to a cost center; an FK provides a reliable link.',
    `internal_order_id` BIGINT COMMENT 'FK to finance.internal_order.internal_order_id — WBS elements in R&D projects link to internal orders for cost collection and capitalization. Required for project cost tracking and R&D capitalization workflow.',
    `parent_wbs_wbs_element_id` BIGINT COMMENT 'Identifier of the immediate parent element in the WBS hierarchy.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: WBS elements in SAP PS are assigned to profit centers to enable project-level profitability analysis. For semiconductor R&D and capital projects, each WBS element must be linked to a profit center rep',
    `actual_cost` DECIMAL(18,2) COMMENT 'Real monetary cost incurred to date for the WBS element.',
    `actual_end_date` DATE COMMENT 'Real calendar date when work on the element actually completed.',
    `actual_start_date` DATE COMMENT 'Real calendar date when work on the element actually started.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the WBS element was approved for execution.',
    `billing_element_flag` BOOLEAN COMMENT 'Indicates whether the WBS element is billable for NRE or customer invoicing.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned monetary budget allocated to the WBS element.',
    `cost_allocation_method` STRING COMMENT 'Method used to allocate costs from this element to downstream entities.. Valid values are `fixed|percentage|usage_based`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the WBS element record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|EUR|JPY|CNY|GBP`',
    `external_reference` STRING COMMENT 'Identifier used by external systems (e.g., PLM, ERP) to reference this WBS element.',
    `financial_year` STRING COMMENT 'Fiscal year to which the elements financial data belongs.',
    `fiscal_period` STRING COMMENT 'Quarter within the financial year for reporting.. Valid values are `Q1|Q2|Q3|Q4`',
    `is_capital_expenditure` BOOLEAN COMMENT 'True if costs incurred under this element are treated as capital expenditures.',
    `is_template` BOOLEAN COMMENT 'True if the element is defined as a reusable template for future projects.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the WBS element record.',
    `planned_end_date` DATE COMMENT 'Planned calendar date when work on the element is expected to finish.',
    `project_phase` STRING COMMENT 'Current phase of the overall project to which the element belongs.. Valid values are `development|qualification|ramp_up|production|closure`',
    `r_and_d_capitalization_flag` BOOLEAN COMMENT 'True if the elements costs are eligible for R&D capitalization under accounting standards.',
    `start_date` DATE COMMENT 'Planned calendar date when work on the element is scheduled to begin.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the WBS element record.',
    `wbs_code` STRING COMMENT 'Hierarchical alphanumeric code that uniquely identifies the WBS element within the project hierarchy.',
    `wbs_element_description` STRING COMMENT 'Detailed description of the work scope represented by the WBS element.',
    `wbs_element_level` STRING COMMENT 'Depth level of the element within the WBS tree (root = 1).',
    `wbs_element_name` STRING COMMENT 'Human‑readable name of the WBS element.',
    `wbs_element_status` STRING COMMENT 'Current lifecycle status of the WBS element.. Valid values are `planned|active|completed|on_hold|cancelled`',
    `wbs_element_type` STRING COMMENT 'Category of the WBS element indicating its granularity within the project hierarchy.. Valid values are `project|phase|task|subtask|milestone`',
    `wbs_hierarchy_path` STRING COMMENT 'Delimited string representing the full path from root to this element (e.g., 1.2.3).',
    `wbs_status_reason` STRING COMMENT 'Free‑text explanation for the current status of the WBS element.',
    `created_by` STRING COMMENT 'User identifier of the person who created the WBS element record.',
    CONSTRAINT pk_wbs_element PRIMARY KEY(`wbs_element_id`)
) COMMENT 'Work Breakdown Structure element master from SAP PS for semiconductor R&D and capital projects. Structures complex multi-phase projects such as new process node development (PDK creation, process qualification, yield ramp), fab expansion programs, and EUV lithography integration. Captures WBS code, project definition, responsible manager, planned/actual dates, budget, and billing element flag for NRE milestone invoicing. Enables hierarchical project cost tracking and R&D capitalization.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'System-generated unique identifier for each cost allocation record.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Periodic cost allocation and assessment cycles in SAP CO generate journal entries in the general ledger. Linking cost_allocation records to their resulting journal_entry provides the audit trail from ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation records identify the sending cost center; the FK replaces the code and enforces referential integrity.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Cost allocation cycles in semiconductor fabs distribute overhead costs between profit centers as well as cost centers. The existing FKs cover sender and receiver cost centers, but profit center assign',
    `tertiary_cost_center_id` BIGINT COMMENT 'FK to finance.cost_center.cost_center_id — Cost allocation cycles have sender cost centers (overhead pools) that distribute costs. Without this FK, allocation cycles cannot identify their source.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Monetary amount allocated to the receiver cost center.',
    `allocation_base_quantity` DECIMAL(18,2) COMMENT 'Quantity of the allocation basis (e.g., total machine hours).',
    `allocation_basis` STRING COMMENT 'Primary driver used as the allocation base (e.g., machine hours, wafer passes).. Valid values are `machine_hours|wafer_passes|labor_hours|energy_consumption|area_sqft|custom`',
    `allocation_description` STRING COMMENT 'Free‑form text describing the purpose or notes for the allocation.',
    `allocation_method` STRING COMMENT 'Method used to calculate the allocation (e.g., activity‑based, statistical, fixed percentage).. Valid values are `activity_based|statistical|fixed_percentage|direct|proportional|custom`',
    `allocation_rate` DECIMAL(18,2) COMMENT 'Rate applied per unit of the allocation base (e.g., cost per machine hour).',
    `cost_allocation_status` STRING COMMENT 'Current processing status of the allocation record.. Valid values are `pending|allocated|reversed|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the allocated amount.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date on which the allocation becomes effective.',
    `expiration_date` DATE COMMENT 'Date after which the allocation is no longer valid (nullable).',
    `fiscal_period` STRING COMMENT 'Fiscal period for which the allocation is recorded, expressed as YYYYQ#.. Valid values are `^d{4}Q[1-4]$`',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter (1‑4) of the allocation.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year of the allocation.',
    `line_sequence` STRING COMMENT 'Sequential number of the allocation line within its allocation cycle.',
    `reversal_indicator` BOOLEAN COMMENT 'True if this allocation record reverses a prior allocation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the allocation record.',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'Periodic cost allocation, assessment, and distribution cycle records for semiconductor fab overhead and shared service costs. Captures allocation cycle ID, sender cost center (fab overhead pool, shared services), receiver cost centers or orders, allocation method (activity-based using machine hours or wafer passes, statistical key figure, fixed percentage), allocation base quantity, allocated amount, fiscal period, and reversal indicator. Supports wafer cost modeling by distributing equipment depreciation, utilities, cleanroom maintenance, and indirect labor to process steps based on fab utilization rates and activity drivers. Enables accurate product costing and profitability analysis.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` (
    `wafer_cost_model_id` BIGINT COMMENT 'Unique surrogate key for each wafer cost model record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Wafer cost models are allocated to cost centers; replace code with FK.',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Wafer cost models are specific to fab locations due to labor rates, overhead, and equipment differences. The existing fab_location plain attribute is a denormalization of fab_facility. Required for lo',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Wafer cost models are defined per technology node. The existing technology_node plain attribute is a denormalization. Required for node-specific cost modeling, technology node economics analysis, and ',
    `process_flow_id` BIGINT COMMENT 'Identifier of the manufacturing process flow associated with this cost model.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Wafer cost models are scoped to a profit center; the FK provides proper ownership and reporting.',
    `chemicals_gases_cost_usd_per_wafer` DECIMAL(18,2) COMMENT 'Direct material cost for chemicals and gases consumed per wafer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost model record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values in the model.. Valid values are `USD|EUR|JPY|CNY|GBP|KRW`',
    `die_size_um2` DECIMAL(18,2) COMMENT 'Area of a single die on the wafer in square micrometres.',
    `effective_end_date` DATE COMMENT 'Date when the cost model is retired or superseded; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the cost model becomes valid for planning and reporting.',
    `equipment_depreciation_usd_per_wafer` DECIMAL(18,2) COMMENT 'Allocated equipment depreciation cost for each wafer pass.',
    `fab_overhead_rate_percent` DECIMAL(18,2) COMMENT 'Factory overhead rate applied to the wafer cost, expressed as a percent.',
    `labor_hours_per_wafer` DECIMAL(18,2) COMMENT 'Total labor hours required to process a single wafer.',
    `labor_rate_usd_per_hour` DECIMAL(18,2) COMMENT 'Hourly labor rate applied to wafer processing activities.',
    `mask_set_amortization_wafers` DECIMAL(18,2) COMMENT 'Number of wafers over which the mask set cost is amortized.',
    `mask_set_cost_usd` DECIMAL(18,2) COMMENT 'Total cost of the photomask set required for the process flow, expressed in US dollars.',
    `model_code` STRING COMMENT 'Business identifier code used to reference the cost model in finance and planning systems.. Valid values are `^[A-Z0-9_]+$`',
    `model_name` STRING COMMENT 'Human‑readable name describing the cost model (e.g., "7nm High‑Yield Model").',
    `silicon_wafer_cost_usd` DECIMAL(18,2) COMMENT 'Cost of the raw silicon wafer per unit, in US dollars.',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Planned percentage of good dies per wafer used for cost allocation.',
    `total_cost_per_wafer_usd` DECIMAL(18,2) COMMENT 'Fully‑loaded cost of a wafer after aggregating all direct and indirect cost components.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cost model record.',
    `version_number` STRING COMMENT 'Sequential version identifier for the cost model, incremented on each change.',
    `wafer_cost_model_status` STRING COMMENT 'Current lifecycle status of the cost model.. Valid values are `active|inactive|deprecated`',
    `wafer_diameter_mm` DECIMAL(18,2) COMMENT 'Diameter of the silicon wafer in millimetres.',
    CONSTRAINT pk_wafer_cost_model PRIMARY KEY(`wafer_cost_model_id`)
) COMMENT 'Semiconductor-specific wafer cost model master defining the standard cost build-up for a wafer lot at a given technology node and process flow. Captures process node, wafer diameter, die size, target yield, mask set cost amortization, direct material cost (silicon wafer, chemicals, gases), direct labor rate, equipment depreciation per wafer pass, fab overhead rate, and fully-loaded cost per wafer out. Used for product pricing, NRE recovery planning, and fab utilization-based cost allocation. Unique to semiconductor manufacturing finance.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` (
    `finance_nre_agreement_id` BIGINT COMMENT 'Surrogate primary key for the NRE agreement record.',
    `account_id` BIGINT COMMENT 'Identifier of the customer party to whom the NRE agreement applies.',
    `chips_act_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.chips_act_obligation. Business justification: NRE agreements can trigger CHIPS Act obligations; linking enables mandatory regulatory‑financial reporting of those obligations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NRE agreements are associated with a cost center; FK enforces this relationship.',
    `ic_design_project_id` BIGINT COMMENT 'Reference to the IC design project associated with the NRE agreement.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: NRE agreements in semiconductor operations use SAP CO internal orders to collect and track the actual engineering costs incurred against the NRE contract. The internal order serves as the cost collect',
    `legal_entity_id` BIGINT COMMENT 'FK to finance.legal_entity',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: NRE agreements generate revenue and costs that must be attributed to a profit center for internal profitability reporting. In semiconductor enterprises, NRE revenue from fabless customers is assigned ',
    `sales_nre_agreement_id` BIGINT COMMENT 'Foreign key linking to sales.sales_nre_agreement. Business justification: Financial NRE agreement must reference the matching sales NRE agreement to align revenue recognition with the sales contract.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: NRE (Non-Recurring Engineering) cost recovery agreements in semiconductor are tracked against WBS elements for R&D capitalization and project cost management. The WBS element represents the specific d',
    `agreement_number` STRING COMMENT 'External contract number assigned to the NRE agreement.',
    `agreement_type` STRING COMMENT 'Category of NRE work covered by the agreement.. Valid values are `mask|design|qualification|combined`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the agreement was approved.',
    `comments` STRING COMMENT 'Additional notes or remarks about the NRE agreement.',
    `contract_version` STRING COMMENT 'Version identifier for the NRE contract document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the NRE amount.. Valid values are `USD|EUR|JPY|CNY|GBP|KRW`',
    `effective_from` DATE COMMENT 'Date when the NRE agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date when the NRE agreement ends, if applicable.',
    `finance_nre_agreement_status` STRING COMMENT 'Current lifecycle status of the NRE agreement.. Valid values are `draft|active|suspended|terminated|closed`',
    `payment_milestone_schedule` STRING COMMENT 'Serialized representation of payment milestones and amounts.',
    `recovery_method` STRING COMMENT 'Method used to recover NRE costs from the customer.. Valid values are `upfront|royalty|hybrid`',
    `region_code` STRING COMMENT 'Three‑letter code representing the geographic region of the agreement.. Valid values are `NAM|EMEA|APAC|LATAM`',
    `revenue_recognition_method` STRING COMMENT 'Accounting method for recognizing revenue from the NRE agreement.. Valid values are `percentage_of_completion|completed_contract|milestone_based`',
    `tax_regime` STRING COMMENT 'Tax treatment applicable to the NRE agreement.. Valid values are `standard|reduced|exempt`',
    `termination_reason` STRING COMMENT 'Reason for termination if the agreement status is terminated.',
    `total_nre_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the NRE agreement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    CONSTRAINT pk_finance_nre_agreement PRIMARY KEY(`finance_nre_agreement_id`)
) COMMENT 'Non-Recurring Engineering cost recovery agreement master tracking NRE contracts with fabless customers for ASIC/SoC design services, mask set costs, and process qualification. Captures NRE type (mask NRE, design NRE, qualification NRE), total NRE amount, payment milestone schedule, recovery method (upfront, volume-based royalty, hybrid), customer, product design reference, and revenue recognition method per ASC 606/IFRS 15. SSOT for NRE financial obligations distinct from recurring product sales.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`budget_plan` (
    `budget_plan_id` BIGINT COMMENT 'System-generated unique identifier for the budget plan record.',
    `chips_act_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.chips_act_obligation. Business justification: Budget plans for CHIPS Act funded projects must allocate resources to meet specific compliance obligations (workforce targets, domestic content requirements, guardrail restrictions). Finance planning ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget plans are defined per cost center, profit center, and WBS element. Adding explicit FK columns replaces the string codes and enables proper joins for reporting and allocation.',
    `fab_facility_id` BIGINT COMMENT 'Foreign key linking to fabrication.fab_facility. Business justification: Budget plans in semiconductor fabs are structured by facility for capacity and operational cost planning. Required for facility-level budget vs. actual reporting, fab capacity investment planning, and',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Budget plans are structured by technology node for R&D and production investment planning in semiconductor companies. Required for node-level budget tracking, technology roadmap financial planning, an',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Budget plans in SAP CO/FM are created at the GL account level to enable budget vs. actual variance analysis by account. In semiconductor financial planning, budget line items are mapped to specific GL',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Budget plans in SAP CO can be created at the internal order level for specific projects and cost collection objects. In semiconductor operations, budget plans for R&D projects, NRE activities, and fab',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Budget plans in semiconductor enterprises are prepared at the legal entity level for statutory reporting and intercompany planning. Each budget plan must be anchored to a specific legal entity to supp',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budget plans belong to a profit center; the FK enables drill‑down of profit‑center level budgeting.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Budget plans are linked to a WBS element for project‑level budgeting; the FK replaces the free‑text WBS code.',
    `approval_status` STRING COMMENT 'Current approval state of the budget plan within the governance workflow.. Valid values are `draft|submitted|approved|rejected`',
    `budget_type` STRING COMMENT 'Classification of the budget (e.g., operating expense, capital expenditure, R&D investment, headcount).. Valid values are `operating|capital|r&d|headcount`',
    `chips_act_funding_indicator` BOOLEAN COMMENT 'True if the budget includes funding that is aligned with the US CHIPS Act grant requirements.',
    `compliance_regulation_flag` BOOLEAN COMMENT 'Indicates whether the budget plan complies with applicable regulatory requirements (e.g., SOX, CHIPS Act).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the budget plan record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the local amount.. Valid values are `USD|EUR|JPY|CNY|GBP|CAD`',
    `financial_reporting_standard` STRING COMMENT 'Accounting framework used for the budget plan (e.g., IFRS, US‑GAAP).. Valid values are `IFRS|GAAP|US-GAAP|IFRS-16`',
    `fiscal_year` STRING COMMENT 'Four‑digit calendar year to which the budget plan applies.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the budget plan record.. Valid values are `active|inactive|closed|archived`',
    `notes` STRING COMMENT 'Free‑form text for additional comments or explanations about the budget plan.',
    `organization_unit_code` STRING COMMENT 'Code identifying the cost or profit center, division, or legal entity responsible for the budget.',
    `plan_approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget plan received final approval.',
    `plan_end_date` DATE COMMENT 'Date on which the budget period ends.',
    `plan_number` STRING COMMENT 'External business identifier assigned to the budget plan, used for tracking and reporting.. Valid values are `^BP-[0-9]{4}-[0-9]{4}$`',
    `plan_start_date` DATE COMMENT 'Date on which the budget period begins.',
    `planned_amount_group` DECIMAL(18,2) COMMENT 'Budgeted monetary amount expressed in the corporate group reporting currency.',
    `planned_amount_local` DECIMAL(18,2) COMMENT 'Budgeted monetary amount expressed in the local operating currency.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'Planned count or volume associated with the budget line (e.g., wafer starts, FTEs, machine hours).',
    `planning_method` STRING COMMENT 'Methodology used to develop the budget (e.g., top‑down, bottom‑up, rolling forecast, zero‑based).. Valid values are `top-down|bottom-up|rolling|zero-based`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the planned quantity.. Valid values are `wafer_start|fte|machine_hour|unit`',
    `updated_by` STRING COMMENT 'Identifier of the user who last updated the budget plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the budget plan record.',
    `variance_to_prior_year_amount` DECIMAL(18,2) COMMENT 'Difference between the planned amount and the actual amount of the prior fiscal year, expressed in currency.',
    `variance_to_prior_year_percent` DECIMAL(18,2) COMMENT 'Percentage difference between the planned amount and the prior year actual amount.',
    `version_number` STRING COMMENT 'Incremental version of the plan to support revisions and audit trails.',
    `created_by` STRING COMMENT 'Identifier of the user who initially created the budget plan.',
    CONSTRAINT pk_budget_plan PRIMARY KEY(`budget_plan_id`)
) COMMENT 'Annual and multi-year financial budget plan with granular line-item detail for the semiconductor enterprise. Header captures planning version, fiscal year, budget type (operating expense, capital expenditure, R&D investment, headcount), organizational unit (cost center, profit center, company code), planning method, and approval status. Line items (owned within this product) specify GL account/cost element, cost center or WBS element, fiscal period distribution, planned quantity (wafer starts, headcount FTEs, machine hours), planned amount in local and group currency, and variance to prior year. Supports fab capacity-based opex planning, technology node R&D investment roadmaps, CHIPS Act grant-aligned capex budgets, rolling forecasts, and period-level budget vs. actual variance analysis. Enables drill-down from plan header to individual cost element allocations. Sourced from SAP BPC/CO planning cycles.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`standard_cost` (
    `standard_cost_id` BIGINT COMMENT 'Unique surrogate key for each standard cost record.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center.cost_center_id — Standard costs reference production cost centers for labor and overhead rate determination. Links cost model to organizational cost structure.',
    `eccn_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.eccn_classification. Business justification: Cost models must incorporate export classification (ECCN) to allocate compliance‑related costs accurately.',
    `fabrication_technology_node_id` BIGINT COMMENT 'Foreign key linking to fabrication.fabrication_technology_node. Business justification: Standard costs are defined per technology node in semiconductor fabs. The existing technology_node plain attribute is a denormalization of fabrication_technology_node. Required for node-level standard',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Standard cost models are applied to order lines for margin calculation, variance analysis, and pricing decisions. Order management systems pull standard costs to compute gross margin at quote and orde',
    `process_flow_id` BIGINT COMMENT 'Identifier of the fab process flow associated with this cost.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Standard cost records are defined per profit center; the FK enables cost‑to‑profit‑center mapping.',
    `wafer_cost_model_id` BIGINT COMMENT 'Foreign key linking to finance.wafer_cost_model. Business justification: Standard cost for semiconductor products is derived from wafer cost models that define the cost build-up for a specific technology node and process flow. The standard_cost record represents the pre-de',
    `allocation_method` STRING COMMENT 'Rule used to allocate shared costs to the product.. Valid values are `per_wafer|per_die|percentage`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost record received formal approval.',
    `approved_by` STRING COMMENT 'Identifier of the individual who approved the cost record.',
    `cost_basis` STRING COMMENT 'Methodology used to value inventory for cost calculation.. Valid values are `FIFO|LIFO|WeightedAverage`',
    `cost_calculation_method` STRING COMMENT 'Approach used to compute the standard cost (bottom‑up or top‑down).. Valid values are `bottom_up|top_down`',
    `cost_category` STRING COMMENT 'High‑level classification of the cost component.. Valid values are `material|labor|equipment|overhead|packaging`',
    `cost_model_description` STRING COMMENT 'Narrative description of the cost model methodology.',
    `cost_per_good_die` DECIMAL(18,2) COMMENT 'Yield‑adjusted cost allocated to each functional die.',
    `cost_status` STRING COMMENT 'Current lifecycle status of the cost record.. Valid values are `active|inactive|archived`',
    `cost_type` STRING COMMENT 'Indicates whether the cost is a standard, actual, or forecast figure.. Valid values are `standard|actual|forecast`',
    `cost_version` STRING COMMENT 'Version label of the cost record, typically reflecting fiscal period or revision cycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost record was initially created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency identifier for all monetary amounts.',
    `die_size_um2` DECIMAL(18,2) COMMENT 'Area of a single die on the wafer in square micrometers.',
    `dies_per_wafer` STRING COMMENT 'Number of dies that can be placed on a wafer before yield adjustment.',
    `effective_date` DATE COMMENT 'Date on which the standard cost becomes effective for accounting.',
    `equipment_depreciation_per_wafer` DECIMAL(18,2) COMMENT 'Depreciation expense of fab equipment allocated to each wafer pass.',
    `expiration_date` DATE COMMENT 'Date on which the standard cost is superseded or retired.',
    `fab_overhead_rate` DECIMAL(18,2) COMMENT 'Rate for indirect fab costs (utilities, cleanroom, indirect labor) applied per wafer.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the cost record is currently active for costing.',
    `labor_rate_per_hour` DECIMAL(18,2) COMMENT 'Hourly labor cost applied to wafer processing activities.',
    `last_review_date` DATE COMMENT 'Date of the most recent cost review cycle.',
    `mask_set_cost` DECIMAL(18,2) COMMENT 'Amortized cost of photomasks for the product run.',
    `material_cost_per_wafer` DECIMAL(18,2) COMMENT 'Direct material expense (silicon, chemicals, gases) allocated per wafer.',
    `notes` STRING COMMENT 'Additional remarks or comments about the cost record.',
    `packaging_cost_per_die` DECIMAL(18,2) COMMENT 'Cost of packaging (die‑attach, encapsulation, testing) allocated per finished die.',
    `product_code` STRING COMMENT 'External part number or SKU used to identify the semiconductor product.',
    `product_family` STRING COMMENT 'High‑level family grouping of the semiconductor product.',
    `product_line` STRING COMMENT 'Specific product line within the family.',
    `revision_number` STRING COMMENT 'Sequential revision number for change tracking.',
    `source_system` STRING COMMENT 'Originating ERP or PLM system that supplied the cost data (e.g., SAP CO‑PC).',
    `target_yield_percent` DECIMAL(18,2) COMMENT 'Planned percentage of good dies per wafer after processing.',
    `total_wafer_cost` DECIMAL(18,2) COMMENT 'Sum of all cost components for a single wafer before yield adjustment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the cost record.',
    `variance_reason` STRING COMMENT 'Explanation for any deviation from prior cost version.',
    `wafer_diameter_mm` DECIMAL(18,2) COMMENT 'Diameter of the silicon wafer in millimeters.',
    CONSTRAINT pk_standard_cost PRIMARY KEY(`standard_cost_id`)
) COMMENT 'Standard cost master for semiconductor products defining the pre-determined cost build-up for wafers, dies, and packaged chips at each technology node and process flow. Encompasses full wafer cost modeling: process node, wafer diameter, die size, target yield, mask set cost amortization, direct materials (silicon wafers, chemicals, gases, photomasks), direct labor rate, machine cost (equipment depreciation per wafer pass, maintenance allocation), fab overhead rate (utilities, cleanroom, indirect labor), and fully-loaded cost per wafer out. Calculates yield-adjusted cost per good die and packaging cost for finished product costing. Used as the basis for inventory valuation (ASC 330), COGS determination, manufacturing variance analysis (price/usage/efficiency/yield), product pricing decisions, NRE recovery planning, and fab utilization-based cost allocation. Updated each fiscal year during standard cost roll with quarterly variance reviews. Sourced from SAP CO-PC product costing.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`transfer_price` (
    `transfer_price_id` BIGINT COMMENT 'System-generated unique identifier for the transfer price master record.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Transfer price agreements are typically managed at the profit‑center level; linking to profit_center provides proper ownership and reporting.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Transfer pricing records govern intercompany pricing between legal entities in semiconductor enterprises (e.g., wafer pricing between fab subsidiary and design entity, IP royalty pricing between IP ho',
    `agreement_number` STRING COMMENT 'External reference number or code assigned to the intercompany pricing agreement.',
    `agreement_type` STRING COMMENT 'Classification of the pricing agreement method (e.g., cost-plus, comparable uncontrolled price, resale, transactional net margin method).. Valid values are `cost_plus|comparable|resale|tnmm`',
    `allocation_basis` STRING COMMENT 'Basis on which the transfer price is allocated (e.g., volume, value).. Valid values are `volume|value|weight|capacity`',
    `approval_by` STRING COMMENT 'Identifier of the user or approver who authorized the agreement.',
    `approval_status` STRING COMMENT 'Current approval state of the transfer pricing agreement.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the agreement received its latest approval decision.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the agreement complies with BEPS Action 13 and local tax regulations.',
    `cost_component` STRING COMMENT 'Cost element used in the price calculation (e.g., material, labor, overhead).. Valid values are `material|labor|overhead|equipment|facility`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the transfer price record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the price amount.. Valid values are `[A-Z]{3}`',
    `effective_from` DATE COMMENT 'Date on which the transfer pricing agreement becomes binding.',
    `effective_price_per_unit` DECIMAL(18,2) COMMENT 'Calculated price per unit of product or service after applying the method and margin.',
    `effective_until` DATE COMMENT 'Date on which the transfer pricing agreement expires or is superseded (null if open‑ended).',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether the transfer price is subject to tax in the jurisdiction.',
    `last_review_date` DATE COMMENT 'Date when the agreement was last reviewed for compliance or market changes.',
    `margin_rate` DECIMAL(18,2) COMMENT 'Target profit margin percentage applied to the cost base, expressed as a percent.',
    `next_review_date` DATE COMMENT 'Planned date for the next compliance or market review of the agreement.',
    `notes` STRING COMMENT 'Supplementary remarks or comments related to the agreement.',
    `oecd_document_reference` STRING COMMENT 'Reference identifier to the OECD documentation supporting the transfer pricing methodology.',
    `price_amount` DECIMAL(18,2) COMMENT 'Monetary amount agreed for the transfer of the product or service.',
    `price_method` STRING COMMENT 'Method used to calculate the transfer price for the agreement.. Valid values are `cost_plus|comparable|resale|tnmm`',
    `product_category` STRING COMMENT 'Category of the transferred product (e.g., wafer, die, IP core, shared service).. Valid values are `wafer|die|ip|service`',
    `service_category` STRING COMMENT 'Category of the transferred service when applicable.. Valid values are `design|testing|assembly|logistics`',
    `source_entity_code` STRING COMMENT 'Internal code of the legal entity that provides the product or service for the transfer price.',
    `source_system` STRING COMMENT 'Originating source system where the transfer price record is maintained.. Valid values are `sap|oracle|custom`',
    `target_entity_code` STRING COMMENT 'Internal code of the legal entity that receives the product or service under the transfer price.',
    `tax_jurisdiction_code` STRING COMMENT 'Three‑letter country code indicating the tax jurisdiction governing the transaction.. Valid values are `[A-Z]{3}`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Statutory tax rate applied to the transfer price, expressed as a percent.',
    `transfer_price_description` STRING COMMENT 'Free‑form text describing the purpose, scope, and key terms of the transfer pricing agreement.',
    `transfer_price_status` STRING COMMENT 'Current lifecycle state of the transfer pricing agreement.. Valid values are `active|inactive|draft|terminated|pending`',
    `transfer_price_type` STRING COMMENT 'Specifies whether the price applies to a product, service, or royalty arrangement.. Valid values are `product|service|royalty`',
    `unit_of_measure` STRING COMMENT 'Unit in which the effective price is expressed.. Valid values are `per_watt|per_die|per_mm2|per_unit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the transfer price record.',
    `version_number` BIGINT COMMENT 'Sequential version identifier for change‑tracking of the agreement.',
    CONSTRAINT pk_transfer_price PRIMARY KEY(`transfer_price_id`)
) COMMENT 'Transfer pricing master records governing intercompany pricing of wafers, dies, IP royalties, and shared services between semiconductor group entities. Captures transfer pricing method (cost-plus, comparable uncontrolled price, resale price, TNMM), applicable entity pair, product or service category, price or margin rate, validity period, and OECD documentation reference. Supports tax-compliant intercompany transactions and country-by-country reporting under BEPS Action 13.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`tax_provision` (
    `tax_provision_id` BIGINT COMMENT 'System-generated unique identifier for the tax provision record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Tax provisions are posted to specific GL accounts (current tax expense, deferred tax asset, deferred tax liability accounts). The existing tax_account_code (STRING) is a denormalized code that should ',
    `journal_entry_id` BIGINT COMMENT 'FK to finance.journal_entry.journal_entry_id — Tax provisions are booked as journal entries (current tax expense, deferred tax adjustments). Links tax calculation to GL posting for audit trail.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity (company) to which the tax provision applies.',
    `obligation_register_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation_register. Business justification: Tax provisions reference specific regulatory obligations (transfer pricing documentation, country-by-country reporting, R&D tax credit substantiation) tracked in obligation register. Audit trail links',
    `primary_reversal_of_tax_provision_id` BIGINT COMMENT 'Reference to the original tax provision that is being reversed.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Tax provisions are recorded against a profit center for tax reporting; the FK replaces any ad‑hoc profit‑center reference.',
    `approval_status` STRING COMMENT 'Approval workflow status of the tax provision.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the tax provision was approved.',
    `approved_by` BIGINT COMMENT 'Identifier of the employee who approved the tax provision.',
    `closure_date` DATE COMMENT 'Date when the tax provision was closed or finalized.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tax provision record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `deferred_tax_asset_amount` DECIMAL(18,2) COMMENT 'Amount of deferred tax assets arising from temporary differences.',
    `deferred_tax_liability_amount` DECIMAL(18,2) COMMENT 'Amount of deferred tax liabilities arising from temporary differences.',
    `effective_from` DATE COMMENT 'Start date when the tax provision becomes effective.',
    `effective_tax_rate` DECIMAL(18,2) COMMENT 'Effective tax rate after reconciling statutory rates and tax provisions.',
    `effective_until` DATE COMMENT 'End date when the tax provision expires or is superseded.',
    `fiscal_period` STRING COMMENT 'Fiscal period (quarter) within the fiscal year.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the tax provision relates.',
    `jurisdiction_code` STRING COMMENT 'Three‑letter ISO 3166‑1 code representing the tax jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the tax provision.',
    `provision_date` TIMESTAMP COMMENT 'Date and time when the tax provision was generated or became effective.',
    `provision_number` STRING COMMENT 'Business identifier or reference number assigned to the tax provision.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this record represents a reversal of a prior provision.',
    `revision_number` STRING COMMENT 'Sequential revision identifier for audit purposes.',
    `source_system` STRING COMMENT 'Originating source system (e.g., SAP S/4HANA FI) that supplied the tax provision data.',
    `tax_base_amount` DECIMAL(18,2) COMMENT 'Monetary amount on which the tax rate is applied.',
    `tax_credit_carryforward_amount` DECIMAL(18,2) COMMENT 'Unutilized tax credits carried forward to future periods.',
    `tax_credit_used_amount` DECIMAL(18,2) COMMENT 'Portion of tax credits applied in the current period.',
    `tax_expense_amount` DECIMAL(18,2) COMMENT 'Current period tax expense recognized in the income statement.',
    `tax_explanation` STRING COMMENT 'Narrative explanation of the tax provision calculation or adjustments.',
    `tax_law_reference` STRING COMMENT 'Reference to the governing tax law or regulation (e.g., ASC 740, IAS 12).',
    `tax_provision_status` STRING COMMENT 'Current lifecycle status of the tax provision.. Valid values are `draft|pending|approved|rejected|closed`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Statutory tax rate applied to the tax base, expressed as a percentage.',
    `tax_rate_change_indicator` BOOLEAN COMMENT 'Flag indicating whether the tax rate changed during the period.',
    `tax_regulation_code` STRING COMMENT 'Internal code representing the specific tax regulation applicable.',
    `tax_type` STRING COMMENT 'Classification of the tax provision (current tax, deferred tax, or both).. Valid values are `current|deferred|both`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tax provision record.',
    `version` STRING COMMENT 'Version number of the tax provision record for change tracking.',
    CONSTRAINT pk_tax_provision PRIMARY KEY(`tax_provision_id`)
) COMMENT 'Tax provision and deferred tax asset/liability tracking for the semiconductor enterprise. Captures current tax expense, deferred tax positions arising from temporary differences (accelerated depreciation on fab equipment, R&D credit carryforwards, CHIPS Act incentive tax treatment, unrealized intercompany profits), effective tax rate reconciliation, uncertain tax positions (ASC 740/IAS 12), and country-by-country tax allocation. Essential for semiconductor companies with global operations, significant R&D tax credits, and complex transfer pricing structures.';

CREATE OR REPLACE TABLE `semiconductors_ecm`.`finance`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
    `parent_legal_entity_id` BIGINT COMMENT 'Identifier of the immediate parent entity in a corporate hierarchy, if applicable.',
    `primary_ultimate_parent_legal_entity_id` BIGINT COMMENT 'Identifier of the top‑most parent entity in the corporate structure.',
    `address_line1` STRING COMMENT 'First line of the entitys primary mailing address.',
    `address_line2` STRING COMMENT 'Second line of the entitys primary mailing address, if needed.',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Fiscal year total revenue reported in the entitys reporting currency.',
    `city` STRING COMMENT 'City of the entitys primary registered address.',
    `compliance_status` STRING COMMENT 'Overall compliance standing with regulatory requirements.',
    `country_of_incorporation` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the jurisdiction where the entity was incorporated.',
    `credit_rating` STRING COMMENT 'External credit rating assigned by rating agencies.',
    `data_classification_level` STRING COMMENT 'Classification of the entitys data for security handling.',
    `dba_name` STRING COMMENT 'Alternate trade name under which the entity conducts business.',
    `dissolution_date` DATE COMMENT 'Date the entity ceased to exist, if applicable.',
    `email_address` STRING COMMENT 'Primary email address used for official communications.',
    `entity_type` STRING COMMENT 'Classification of the entitys legal structure.',
    `exchange_code` STRING COMMENT 'Code of the exchange where the entitys securities are listed.',
    `fiscal_year_end_month` STRING COMMENT 'Month (1‑12) in which the entitys fiscal year ends.',
    `governance_structure` STRING COMMENT 'High‑level governance model of the entity.',
    `incorporation_date` DATE COMMENT 'Date the entity was legally formed.',
    `industry_code` STRING COMMENT 'Standard industry classification (e.g., NAICS) for the entity.',
    `is_public_company` BOOLEAN COMMENT 'Indicates whether the entity is publicly listed.',
    `legal_entity_status` STRING COMMENT 'Current operational status of the entity.',
    `legal_name` STRING COMMENT 'The official registered name of the legal entity as it appears on incorporation documents.',
    `number_of_employees` STRING COMMENT 'Total headcount employed by the entity.',
    `phone_number` STRING COMMENT 'Primary telephone number for the entity.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the primary address.',
    `primary_contact_detail` STRING COMMENT 'Contact information (e.g., email address or phone number) used for the primary contact method.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for official communications with the entity.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the legal entity record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the legal entity record.',
    `registration_number` STRING COMMENT 'Number assigned by the jurisdiction of incorporation.',
    `reporting_currency` STRING COMMENT 'ISO 4217 currency code used for financial reporting.',
    `sic_code` STRING COMMENT 'Legacy industry code used for regulatory reporting.',
    `state_province` STRING COMMENT 'First‑order administrative subdivision of the incorporation country.',
    `stock_ticker` STRING COMMENT 'Ticker symbol if the entity is publicly traded.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax identifier for the entity.',
    `tax_status` STRING COMMENT 'Current tax compliance status of the entity.',
    `website_url` STRING COMMENT 'Public website of the legal entity.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master reference table for legal_entity. Referenced by legal_entity_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `semiconductors_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `semiconductors_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_to_journal_entry_id` FOREIGN KEY (`to_journal_entry_id`) REFERENCES `semiconductors_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ADD CONSTRAINT `fk_finance_journal_entry_line_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `semiconductors_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_to_fixed_asset_id` FOREIGN KEY (`to_fixed_asset_id`) REFERENCES `semiconductors_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ADD CONSTRAINT `fk_finance_capex_request_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `semiconductors_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ADD CONSTRAINT `fk_finance_asset_depreciation_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `semiconductors_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ADD CONSTRAINT `fk_finance_internal_order_to_cost_center_id` FOREIGN KEY (`to_cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_parent_wbs_wbs_element_id` FOREIGN KEY (`parent_wbs_wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ADD CONSTRAINT `fk_finance_wbs_element_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `semiconductors_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ADD CONSTRAINT `fk_finance_cost_allocation_tertiary_cost_center_id` FOREIGN KEY (`tertiary_cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ADD CONSTRAINT `fk_finance_wafer_cost_model_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ADD CONSTRAINT `fk_finance_wafer_cost_model_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ADD CONSTRAINT `fk_finance_finance_nre_agreement_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `semiconductors_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_internal_order_id` FOREIGN KEY (`internal_order_id`) REFERENCES `semiconductors_ecm`.`finance`.`internal_order`(`internal_order_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ADD CONSTRAINT `fk_finance_budget_plan_wbs_element_id` FOREIGN KEY (`wbs_element_id`) REFERENCES `semiconductors_ecm`.`finance`.`wbs_element`(`wbs_element_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ADD CONSTRAINT `fk_finance_standard_cost_wafer_cost_model_id` FOREIGN KEY (`wafer_cost_model_id`) REFERENCES `semiconductors_ecm`.`finance`.`wafer_cost_model`(`wafer_cost_model_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ADD CONSTRAINT `fk_finance_transfer_price_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `semiconductors_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_journal_entry_id` FOREIGN KEY (`journal_entry_id`) REFERENCES `semiconductors_ecm`.`finance`.`journal_entry`(`journal_entry_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_primary_reversal_of_tax_provision_id` FOREIGN KEY (`primary_reversal_of_tax_provision_id`) REFERENCES `semiconductors_ecm`.`finance`.`tax_provision`(`tax_provision_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ADD CONSTRAINT `fk_finance_tax_provision_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `semiconductors_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_parent_legal_entity_id` FOREIGN KEY (`parent_legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ADD CONSTRAINT `fk_finance_legal_entity_primary_ultimate_parent_legal_entity_id` FOREIGN KEY (`primary_ultimate_parent_legal_entity_id`) REFERENCES `semiconductors_ecm`.`finance`.`legal_entity`(`legal_entity_id`);

-- ========= TAGS =========
ALTER SCHEMA `semiconductors_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `semiconductors_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'headcount|fab_utilization|revenue|custom');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Fiscal Year');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'fab|r&d|corporate|support');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_element` SET TAGS ('dbx_business_glossary_term' = 'Cost Element');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Hierarchy Level');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `natural_account` SET TAGS ('dbx_business_glossary_term' = 'Natural Account');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `reporting_line` SET TAGS ('dbx_business_glossary_term' = 'Reporting Line');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `responsibility_center_code` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Center Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `subdepartment_code` SET TAGS ('dbx_business_glossary_term' = 'Sub‑Department Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `validity_flag` SET TAGS ('dbx_business_glossary_term' = 'Validity Flag');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Valid From Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Valid To Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID (GL Account ID)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `account_category` SET TAGS ('dbx_business_glossary_term' = 'Account Category (GL Account Category)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Code (GL Account Code)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'Account Group (GL Account Group)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `account_level` SET TAGS ('dbx_business_glossary_term' = 'Account Level (GL Account Level)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Name (GL Account Name)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `account_subgroup` SET TAGS ('dbx_business_glossary_term' = 'Account Subgroup (GL Account Subgroup)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type (GL Account Type)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `amortization_flag` SET TAGS ('dbx_business_glossary_term' = 'Amortization Flag (GL Amortization Flag)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `closing_balance` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance (GL Closing Balance)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (GL Cost Center Code)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (GL Created Timestamp)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (GL Currency Code)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method (GL Depreciation Method)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|units_of_production');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `depreciation_rate` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate (GL Depreciation Rate)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference (GL External Reference)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `financial_statement` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Assignment (GL Financial Statement)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `financial_statement` SET TAGS ('dbx_value_regex' = 'balance_sheet|income_statement|cash_flow');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_description` SET TAGS ('dbx_business_glossary_term' = 'Account Description (GL Account Description)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status (GL Account Status)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `is_budget_controlled` SET TAGS ('dbx_business_glossary_term' = 'Budget Control Flag (GL Budget Control)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `is_consolidation_account` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Account Flag (GL Consolidation Flag)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `is_reconciliation_account` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Flag (GL Reconciliation Flag)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance (GL Opening Balance)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `posting_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Posting Restriction Flag (GL Posting Restriction)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code (GL Profit Center Code)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency (GL Reporting Currency)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code (GL Segment Code)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category (GL Tax Category)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_category` SET TAGS ('dbx_value_regex' = 'taxable|exempt|zero_rate');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (GL Tax Rate)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (GL Updated Timestamp)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date (GL Valid From)');
ALTER TABLE `semiconductors_ecm`.`finance`.`gl_account` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date (GL Valid To)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier (PC_ID)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center Identifier (PC_PARENT_ID)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `actual_spend` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Actual Spend (PC_ACTUAL_SPEND)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Allocation Percent (PC_ALLOC_PCT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Budget Amount (PC_BUDGET_AMT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Budget Currency (PC_BUDGET_CURR)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason (PC_CHANGE_REASON)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO_AREA)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method (PC_COST_ALLOC_METHOD)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|activity_based|standard');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User (PC_CREATED_BY)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Creation Timestamp (PC_CREATED_TSTMP)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Profit Center End Date (PC_END_DT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `fab_location` SET TAGS ('dbx_business_glossary_term' = 'FAB Location (PC_FAB_LOC)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (PC_REGION)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Level (PC_HIER_LVL)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Flag (PC_CONSOLIDATED)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (PC_LAST_REV_DT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line (PC_PROD_LINE)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_category` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Category (PC_CAT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_category` SET TAGS ('dbx_value_regex' = 'product_line|technology_node|geography|service|support');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code (PC_CODE)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description (PC_DESC)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_group` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Group (PC_GROUP)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name (PC_NAME)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status (PC_STATUS)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed|suspended');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type (PC_TYPE)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'product_line|technology_node|geography|service|support');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency (PC_REP_CURR)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `responsibility_center` SET TAGS ('dbx_business_glossary_term' = 'Responsibility Center (PC_RESP_CENTER)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (PC_REV_CYCLE)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `sox_compliant` SET TAGS ('dbx_business_glossary_term' = 'SOX Compliance Indicator (PC_SOX_COMP)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Start Date (PC_START_DT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `subgroup` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Sub‑Group (PC_SUBGROUP)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node (PC_TECH_NODE)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `transfer_pricing_indicator` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Indicator (PC_TP_IND)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User (PC_UPDATED_BY)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Last Update Timestamp (PC_UPDATED_TSTMP)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Variance Amount (PC_VARIANCE_AMT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`profit_center` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (PC_VER_NUM)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID (JEID)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CUSTOMER_ID)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `fabrication_wafer_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Wafer Lot Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID (VENDOR_ID)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_base` SET TAGS ('dbx_business_glossary_term' = 'Document Amount (Group Currency) (DOC_AMT_GC)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `amount_local` SET TAGS ('dbx_business_glossary_term' = 'Document Amount (Local Currency) (DOC_AMT_LC)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number (ASSET_NO)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area (BUS_AREA)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code (CO_CODE)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group (CONS_GROUP)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method (CONS_METHOD)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_value_regex' = 'elimination|translation|goodwill|minority|adjustment');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator (DC_IND)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number (DOC_NO)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type (DOC_TYPE)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'vendor_invoice|customer_payment|asset_depreciation|accrual|intercompany|consolidation');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate (EXCH_RATE)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period (FP)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '0[1-9]|1[0-2]');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area (FUNC_AREA)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `intercompany_indicator` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator (INTERCO_IND)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_description` SET TAGS ('dbx_business_glossary_term' = 'Entry Description (DESCRIPTION)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `ledger_account` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account (GL_ACCOUNT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (NET_AMT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date (PERIOD_END)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key (POST_KEY)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_value_regex' = 'd{2}');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status (POST_STATUS)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|error');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp (POST_TS)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number (REF_DOC_NO)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date (REV_DATE)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator (REV_IND)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment (SEGMENT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User (UPDATED_BY)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CREATED_BY)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line ID (JELID)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `booking_id` SET TAGS ('dbx_business_glossary_term' = 'Booking Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `maintenance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Event Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID (JEID)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `wafer_start_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Start Authorization Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_document_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Document Currency (AMT_DOC_CURR)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `amount_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency (AMT_LOC_CURR)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `assignment_field` SET TAGS ('dbx_business_glossary_term' = 'Assignment Field (ASSIGNMENT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR_CODE)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_business_glossary_term' = 'Debit/Credit Indicator (DC_IND)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `debit_credit_indicator` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code (FUNC_AREA)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description (LINE_DESC)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status (LINE_STATUS)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|cleared|reversed|pending');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date (POST_DATE)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Line Quantity (LINE_QTY)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator (IS_REVERSAL)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (SRC_SYS)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Salesforce|MES|Custom|Other');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `semiconductors_ecm`.`finance`.`journal_entry_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `capex_request_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Request ID');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `approval_stage` SET TAGS ('dbx_business_glossary_term' = 'Approval Stage');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `approval_stage` SET TAGS ('dbx_value_regex' = 'initial|financial|executive');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Approved Capital Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Capital Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `business_case_summary` SET TAGS ('dbx_business_glossary_term' = 'Business Case Summary');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `capex_request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `capex_request_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `chips_act_funding_eligible` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Funding Eligibility');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|units_of_production');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `equipment_category` SET TAGS ('dbx_business_glossary_term' = 'Equipment Category');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `equipment_category` SET TAGS ('dbx_value_regex' = 'lithography|cmp|cvd|pvd|ald|ate');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `equipment_model` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'internal|external|chips_act|government_grant');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Technical Justification');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `request_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Capital Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Request Number');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `semiconductors_ecm`.`finance`.`capex_request` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalized` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Flag');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Adjustment Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Period Depreciation Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_key` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Key');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|units_of_production');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'sale|scrap|transfer');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Disposal Proceeds');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `disposal_proceeds` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|maintenance|disposed|pending');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `grant_amount` SET TAGS ('dbx_business_glossary_term' = 'Grant Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `grant_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `grant_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Grant Recognition Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `grant_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Grant Tracking Number');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `impairment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `location_bay` SET TAGS ('dbx_business_glossary_term' = 'Location Bay');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `location_building` SET TAGS ('dbx_business_glossary_term' = 'Location Building');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `maintenance_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Number');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `semiconductors_ecm`.`finance`.`fixed_asset` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `asset_depreciation_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Depreciation Record Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `fab_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Tool Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation to Date (Currency)');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Approval Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|under_review');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Approval Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `asset_depreciation_status` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Posting Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `asset_depreciation_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending|error');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Batch Number');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Adjustment Amount (Currency)');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Amount (Currency)');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Area');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_area` SET TAGS ('dbx_value_regex' = 'book|tax|ifrs');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|double_declining|units_of_production|sum_of_years_digits');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `depreciation_rate` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate (Percent)');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Line Sequence Number');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Notes');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `posted_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Posted Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `remaining_useful_life_months` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Months)');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `technology_node` SET TAGS ('dbx_business_glossary_term' = 'Technology Node (nm)');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`asset_depreciation` ALTER COLUMN `utilization_factor` SET TAGS ('dbx_business_glossary_term' = 'Utilization Factor');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order ID');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `export_license_id` SET TAGS ('dbx_business_glossary_term' = 'Export License Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `auditor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Auditor Approval Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `auditor_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Auditor Approval Flag');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `capitalization_date` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `capitalization_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Eligibility');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Commitment Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `internal_order_description` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Description');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `internal_order_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `internal_order_status` SET TAGS ('dbx_value_regex' = 'created|released|technically_complete|closed|cancelled|pending');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `order_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Type');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'R&D|Maintenance|NRE|Corporate|Capital|Other');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `real_indicator` SET TAGS ('dbx_business_glossary_term' = 'Real Indicator');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `settlement_rule` SET TAGS ('dbx_value_regex' = 'asset|cost_center|wbs');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `statistical_indicator` SET TAGS ('dbx_business_glossary_term' = 'Statistical Indicator');
ALTER TABLE `semiconductors_ecm`.`finance`.`internal_order` ALTER COLUMN `trl` SET TAGS ('dbx_business_glossary_term' = 'Technology Readiness Level (TRL)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Chips Act Obligation Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `parent_wbs_wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Parent WBS Element Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (Currency)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Approval Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `billing_element_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Element Flag');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (Currency)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'fixed|percentage|usage_based');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `financial_year` SET TAGS ('dbx_business_glossary_term' = 'Financial Year');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `is_capital_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Indicator');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `is_template` SET TAGS ('dbx_business_glossary_term' = 'Template Indicator');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'development|qualification|ramp_up|production|closure');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `r_and_d_capitalization_flag` SET TAGS ('dbx_business_glossary_term' = 'R&D Capitalization Flag');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_code` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_description` SET TAGS ('dbx_business_glossary_term' = 'WBS Element Description');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_name` SET TAGS ('dbx_business_glossary_term' = 'WBS Element Name');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_status` SET TAGS ('dbx_business_glossary_term' = 'WBS Element Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|on_hold|cancelled');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_type` SET TAGS ('dbx_business_glossary_term' = 'WBS Element Type');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_element_type` SET TAGS ('dbx_value_regex' = 'project|phase|task|subtask|milestone');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'WBS Hierarchy Path');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `wbs_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason Description');
ALTER TABLE `semiconductors_ecm`.`finance`.`wbs_element` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Record Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_base_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocation Base Quantity');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'machine_hours|wafer_passes|labor_hours|energy_consumption|area_sqft|custom');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_description` SET TAGS ('dbx_business_glossary_term' = 'Allocation Description');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'activity_based|statistical|fixed_percentage|direct|proportional|custom');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `allocation_rate` SET TAGS ('dbx_business_glossary_term' = 'Allocation Rate');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `cost_allocation_status` SET TAGS ('dbx_value_regex' = 'pending|allocated|reversed|cancelled');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^d{4}Q[1-4]$');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `semiconductors_ecm`.`finance`.`cost_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `wafer_cost_model_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Cost Model Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `chemicals_gases_cost_usd_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Chemicals & Gases Cost per Wafer (USD)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|KRW');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `die_size_um2` SET TAGS ('dbx_business_glossary_term' = 'Die Size (UM2)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `equipment_depreciation_usd_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Equipment Depreciation per Wafer (USD)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `fab_overhead_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Fab Overhead Rate Percentage');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `labor_hours_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Labor Hours per Wafer');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `labor_rate_usd_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate (USD per Hour)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `mask_set_amortization_wafers` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Amortization Wafer Count');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `mask_set_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Cost (USD)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `model_code` SET TAGS ('dbx_business_glossary_term' = 'Wafer Cost Model Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `model_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]+$');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Wafer Cost Model Name');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `silicon_wafer_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Silicon Wafer Cost (USD)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield Percentage');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `total_cost_per_wafer_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Cost per Wafer (USD)');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `wafer_cost_model_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Model Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `wafer_cost_model_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `semiconductors_ecm`.`finance`.`wafer_cost_model` ALTER COLUMN `wafer_diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Diameter (MM)');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `finance_nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Finance NRE Agreement ID');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Chips Act Obligation Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `ic_design_project_id` SET TAGS ('dbx_business_glossary_term' = 'Product Design ID');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `sales_nre_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Nre Agreement Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'NRE Agreement Number');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'NRE Agreement Type (MASK, DESIGN, QUALIFICATION, COMBINED)');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'mask|design|qualification|combined');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|KRW');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `finance_nre_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `finance_nre_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|closed');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `payment_milestone_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Milestone Schedule');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Recovery Method (UPFRONT, ROYALTY, HYBRID)');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `recovery_method` SET TAGS ('dbx_value_regex' = 'upfront|royalty|hybrid');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = 'NAM|EMEA|APAC|LATAM');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method (ASC 606)');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'percentage_of_completion|completed_contract|milestone_based');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `tax_regime` SET TAGS ('dbx_business_glossary_term' = 'Tax Regime');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `tax_regime` SET TAGS ('dbx_value_regex' = 'standard|reduced|exempt');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `total_nre_amount` SET TAGS ('dbx_business_glossary_term' = 'Total NRE Amount (USD)');
ALTER TABLE `semiconductors_ecm`.`finance`.`finance_nre_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Identifier (BPI)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `chips_act_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Chips Act Obligation Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `fab_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Fab Facility Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (AS)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type (BT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'operating|capital|r&d|headcount');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `chips_act_funding_indicator` SET TAGS ('dbx_business_glossary_term' = 'CHIPS Act Funding Indicator (CAFI)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `compliance_regulation_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation Flag (CRF)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CAD');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `financial_reporting_standard` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Standard (FRS)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `financial_reporting_standard` SET TAGS ('dbx_value_regex' = 'IFRS|GAAP|US-GAAP|IFRS-16');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LS)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|archived');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NTS)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `organization_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit Code (OUC)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Timestamp (PAT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan End Date (PED)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Number (BPN)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^BP-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Start Date (PSD)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `planned_amount_group` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount (Group Currency) (PAGC)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `planned_amount_local` SET TAGS ('dbx_business_glossary_term' = 'Planned Amount (Local Currency) (PALC)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `planned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Quantity (PQ)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `planning_method` SET TAGS ('dbx_business_glossary_term' = 'Planning Method (PM)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `planning_method` SET TAGS ('dbx_value_regex' = 'top-down|bottom-up|rolling|zero-based');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'wafer_start|fte|machine_hour|unit');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (UBU)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `variance_to_prior_year_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance to Prior Year Amount (VPA)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `variance_to_prior_year_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance to Prior Year Percent (VPP)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number (PVN)');
ALTER TABLE `semiconductors_ecm`.`finance`.`budget_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (CBU)');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `eccn_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Eccn Classification Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `fabrication_technology_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fabrication Technology Node Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `process_flow_id` SET TAGS ('dbx_business_glossary_term' = 'Process Flow Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `wafer_cost_model_id` SET TAGS ('dbx_business_glossary_term' = 'Wafer Cost Model Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'per_wafer|per_die|percentage');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_basis` SET TAGS ('dbx_value_regex' = 'FIFO|LIFO|WeightedAverage');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Calculation Method');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_calculation_method` SET TAGS ('dbx_value_regex' = 'bottom_up|top_down');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'material|labor|equipment|overhead|packaging');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_model_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Model Description');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_per_good_die` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Good Die');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_type` SET TAGS ('dbx_value_regex' = 'standard|actual|forecast');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `cost_version` SET TAGS ('dbx_business_glossary_term' = 'Cost Version');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `die_size_um2` SET TAGS ('dbx_business_glossary_term' = 'Die Size (µm²)');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `dies_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Dies Per Wafer');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `equipment_depreciation_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Equipment Depreciation Per Wafer');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `fab_overhead_rate` SET TAGS ('dbx_business_glossary_term' = 'Fab Overhead Rate');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `labor_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Per Hour');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `mask_set_cost` SET TAGS ('dbx_business_glossary_term' = 'Mask Set Cost');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `material_cost_per_wafer` SET TAGS ('dbx_business_glossary_term' = 'Material Cost Per Wafer');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `packaging_cost_per_die` SET TAGS ('dbx_business_glossary_term' = 'Packaging Cost Per Die');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `product_family` SET TAGS ('dbx_business_glossary_term' = 'Product Family');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `target_yield_percent` SET TAGS ('dbx_business_glossary_term' = 'Target Yield (%)');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `total_wafer_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Wafer Cost');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `semiconductors_ecm`.`finance`.`standard_cost` ALTER COLUMN `wafer_diameter_mm` SET TAGS ('dbx_business_glossary_term' = 'Wafer Diameter (mm)');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` SET TAGS ('dbx_subdomain' = 'planning_control');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `transfer_price_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Record Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Source Legal Entity Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'cost_plus|comparable|resale|tnmm');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'volume|value|weight|capacity');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `approval_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `cost_component` SET TAGS ('dbx_business_glossary_term' = 'Cost Component');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `cost_component` SET TAGS ('dbx_value_regex' = 'material|labor|overhead|equipment|facility');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `effective_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Effective Price Per Unit');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Taxable Indicator');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `margin_rate` SET TAGS ('dbx_business_glossary_term' = 'Margin Rate');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `oecd_document_reference` SET TAGS ('dbx_business_glossary_term' = 'OECD Documentation Reference');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `price_method` SET TAGS ('dbx_business_glossary_term' = 'Price Determination Method');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `price_method` SET TAGS ('dbx_value_regex' = 'cost_plus|comparable|resale|tnmm');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'wafer|die|ip|service');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'design|testing|assembly|logistics');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `source_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Source Entity Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'sap|oracle|custom');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `target_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Target Entity Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Applicable Tax Rate');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `transfer_price_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Description');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `transfer_price_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Lifecycle Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `transfer_price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|terminated|pending');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `transfer_price_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Type');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `transfer_price_type` SET TAGS ('dbx_value_regex' = 'product|service|royalty');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'per_watt|per_die|per_mm2|per_unit');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`transfer_price` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `obligation_register_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Register Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `primary_reversal_of_tax_provision_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Tax Provision Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Approval Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Approval Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Approved By');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Closure Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `deferred_tax_asset_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Asset Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `deferred_tax_liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Tax Liability Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `effective_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Effective Tax Rate');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Notes');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `provision_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Date');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `provision_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Number');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Reversal Indicator');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Revision Number');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Base Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_credit_carryforward_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Carryforward Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_credit_used_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Credit Used Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Tax Expense Amount');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_explanation` SET TAGS ('dbx_business_glossary_term' = 'Tax Explanation');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_law_reference` SET TAGS ('dbx_business_glossary_term' = 'Tax Law Reference');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_provision_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Status');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_provision_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|closed');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (Percent)');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_rate_change_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Change Indicator');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_regulation_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Regulation Code');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'current|deferred|both');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `semiconductors_ecm`.`finance`.`tax_provision` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Tax Provision Version');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` SET TAGS ('dbx_subdomain' = 'accounting_operations');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `number_of_employees` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `semiconductors_ecm`.`finance`.`legal_entity` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
