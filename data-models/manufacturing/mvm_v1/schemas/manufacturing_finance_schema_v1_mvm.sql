-- Schema for Domain: finance | Business: Manufacturing | Version: v1_mvm
-- Generated on: 2026-05-06 09:42:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `manufacturing_ecm`.`finance` COMMENT 'Corporate finance and cost management domain governing general ledger, cost centers, profit centers, accounts payable, CapEx/OpEx tracking, EBITDA reporting, budgeting, financial planning and analysis, and financial consolidation via SAP FI/CO. Serves as SSOT for all internal financial structures and management accounting aligned with IFRS/GAAP.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `manufacturing_ecm`.`finance`.`procurement_contract` (
    `procurement_contract_id` BIGINT COMMENT 'Unique identifier for the procurement contract record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to supplier.agreement. Business justification: Procurement contracts (release orders/scheduling agreements in finance) are executed under overarching supplier framework agreements. This hierarchy is fundamental to contract management in industrial',
    `commodity_category_id` BIGINT COMMENT 'Foreign key linking to finance.commodity_category. Business justification: Procurement contracts contain a `material_category` STRING field that maps to the commodity category taxonomy. Replacing this with commodity_category_id FK normalizes contract classification to the au',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Procurement contracts are established under a specific company code (legal entity) in SAP MM. This FK links contracts to the legal entity master, enabling entity-level contract spend reporting, compli',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Supports Family‑Level Supply Contract Management allowing contracts to be associated with product families for volume‑discount negotiations.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor party with whom this procurement contract is established.',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.site. Business justification: Procurement contracts in industrial manufacturing are often site-specific — delivery terms, lead times, and MOQs are negotiated per supplier site. delivery_location is a plain-text denormalization of ',
    `amendment_count` STRING COMMENT 'Total number of amendments or change orders issued against this contract since its original approval.',
    `approval_date` DATE COMMENT 'Date when the contract was formally approved by authorized signatories and became legally binding.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews upon expiration if not explicitly terminated. True for auto-renewing contracts, False otherwise.',
    `compliance_status` STRING COMMENT 'Current compliance state of the contract with internal procurement policies, regulatory requirements, and governance standards. Compliant indicates full adherence, non-compliant flags violations, under review indicates active audit, waived indicates approved exception.. Valid values are `compliant|non_compliant|under_review|waived`',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether the contract includes confidentiality or non-disclosure provisions protecting proprietary information. True if confidentiality terms are present, False otherwise.',
    `contract_description` STRING COMMENT 'Detailed narrative description of the scope, purpose, and key terms of the procurement contract.',
    `contract_name` STRING COMMENT 'Descriptive name or title of the procurement contract for easy identification and reference.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the procurement contract, typically assigned by SAP Ariba or ERP system.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the procurement contract. Draft indicates initial creation, pending approval awaits authorization, active is in force, suspended is temporarily halted, expired has passed end date, terminated is cancelled before expiration, closed is completed and archived. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|closed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the procurement contract structure. Blanket PO for recurring purchases with predefined terms, scheduling agreement for delivery schedules, value contract for spend-based limits, quantity contract for volume-based commitments, framework agreement for multi-supplier arrangements, or master agreement for overarching terms.. Valid values are `blanket_po|scheduling_agreement|value_contract|quantity_contract|framework_agreement|master_agreement`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this contract (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when the procurement contract becomes legally binding and operational.',
    `expiration_date` DATE COMMENT 'Date when the procurement contract term ends and is no longer in force. Nullable for open-ended contracts.',
    `incoterms` STRING COMMENT 'Standardized trade terms defining responsibilities for shipping, insurance, and risk transfer between buyer and supplier per ICC Incoterms 2020. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the contract terms. Nullable if no amendments have been made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement contract record was last updated or modified.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from purchase order release to delivery, as committed by the supplier in the contract.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity per release or purchase order required by the supplier under this contract. Nullable if no MOQ is specified.',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated in the contract (e.g., Net 30, Net 60, 2/10 Net 30 for early payment discounts).',
    `penalty_clause` STRING COMMENT 'Description of financial penalties or liquidated damages applicable for supplier non-compliance with contract terms, SLA breaches, or quality failures.',
    `price_deescalation_mechanism` STRING COMMENT 'Formula or methodology for reducing contract prices based on volume commitments, market conditions, or continuous improvement targets.',
    `price_escalation_mechanism` STRING COMMENT 'Formula or methodology for adjusting contract prices over time based on indices (e.g., CPI, commodity indices), exchange rates, or negotiated percentage increases.',
    `purchasing_group` STRING COMMENT 'Buyer group or category team within the purchasing organization responsible for this contract, typically aligned to commodity or material category.',
    `purchasing_organization` STRING COMMENT 'Organizational unit or division responsible for negotiating and executing this procurement contract within the ERP system.',
    `quality_requirements` STRING COMMENT 'Specific quality standards, certifications, inspection criteria, and acceptance testing requirements mandated in the contract (e.g., ISO 9001, PPAP, APQP, specific Cpk targets).',
    `quantity_unit` STRING COMMENT 'Unit of measure for target quantity (e.g., EA for each, KG for kilograms, M for meters, HR for hours).',
    `release_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity already released or called off against this contract through purchase orders or delivery schedules.',
    `release_value` DECIMAL(18,2) COMMENT 'Cumulative monetary value already released or spent against this contract through purchase orders.',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Quantity still available for release under this contract, calculated as target quantity minus release quantity.',
    `remaining_value` DECIMAL(18,2) COMMENT 'Monetary value still available for release under this contract, calculated as total contract value minus release value.',
    `renewal_term_months` STRING COMMENT 'Duration in months for each automatic renewal period if auto renewal is enabled. Nullable if auto renewal is not applicable.',
    `sla_terms` STRING COMMENT 'Service level commitments and performance targets defined in the contract, such as lead time, on-time delivery rate, quality standards, and response times.',
    `target_quantity` DECIMAL(18,2) COMMENT 'Planned or committed quantity of materials or services to be procured under this contract for quantity-based agreements. Nullable for value-based contracts.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the contract before expiration.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Maximum monetary value committed under this procurement contract for value-based contracts, or estimated total spend for quantity-based contracts.',
    `warranty_terms` STRING COMMENT 'Warranty coverage and duration provided by the supplier for materials or services under this contract, including defect remediation and replacement terms.',
    CONSTRAINT pk_procurement_contract PRIMARY KEY(`procurement_contract_id`)
) COMMENT 'Master procurement contract or framework agreement established with a supplier for recurring supply of materials or services over a defined term. Captures contract number, contract type (blanket PO, scheduling agreement, value contract, quantity contract), effective/expiration dates, total contract value, target/release quantities, auto-renewal flag, SLA terms, penalty clauses, price escalation/de-escalation mechanisms, compliance status, and contract owner. Distinct from sales contracts owned by the sales domain. Supports contract coverage KPI tracking and maverick spend identification.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` (
    `supplier_invoice_id` BIGINT COMMENT 'Unique identifier for the supplier invoice record. Primary key.',
    `commodity_category_id` BIGINT COMMENT 'Foreign key linking to finance.commodity_category. Business justification: Supplier invoices contain a `material_category` STRING field that maps to the commodity category taxonomy. Replacing this with commodity_category_id FK normalizes spend classification to the authorita',
    `company_code_id` BIGINT COMMENT 'FK to finance.company_code',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Invoice posting requires cost center to allocate vendor expenses to the correct internal unit.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Vendor invoices are posted to GL accounts for expense recognition per accounting policy.',
    `plant_id` BIGINT COMMENT 'FK to production.plant',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to finance.procurement_contract. Business justification: Supplier invoices are frequently issued against procurement contracts (blanket/framework agreements) in industrial manufacturing. Linking supplier_invoice to procurement_contract enables contract util',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document used in three-way match verification.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice is matched in the three-way match process (PO–GR–Invoice).',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: supplier_invoice has material_number as a plain denormalized text field. Replacing with FK to sku_master enables material spend analytics, three-way match validation by SKU, and purchased component co',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier (vendor) who issued this invoice.',
    `approval_date` DATE COMMENT 'The date the invoice was approved for payment.',
    `baseline_date` DATE COMMENT 'The reference date from which payment terms are calculated, typically the invoice date or goods receipt date.',
    `blocking_reason` STRING COMMENT 'The reason why the invoice is blocked for payment, such as price variance, quantity variance, or quality issues.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the invoice is denominated.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount amount applied to the invoice, such as early payment discounts or volume discounts.',
    `document_date` DATE COMMENT 'The date recorded on the invoice document, which may differ from the invoice date or posting date.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied for currency conversion if the invoice currency differs from the company currency.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the invoice is posted.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the invoice is posted for accounting purposes.',
    `freight_amount` DECIMAL(18,2) COMMENT 'The freight or shipping charges included in the invoice.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before taxes and adjustments.',
    `invoice_date` DATE COMMENT 'The date the invoice was issued by the supplier. This is the principal business event timestamp for the invoice.',
    `invoice_number` STRING COMMENT 'The unique invoice number assigned by the supplier. This is the externally-known business identifier for the invoice.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the procure-to-pay workflow. [ENUM-REF-CANDIDATE: parked|posted|blocked|cleared|cancelled|rejected|pending_approval — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'The type or category of the invoice document.. Valid values are `standard|credit_memo|debit_memo|prepayment|down_payment|final`',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the invoice record was last modified.',
    `net_amount` DECIMAL(18,2) COMMENT 'The total invoice amount after all taxes, discounts, and adjustments. This is the amount payable to the supplier.',
    `payment_block_indicator` BOOLEAN COMMENT 'Flag indicating whether the invoice is blocked for payment.',
    `payment_date` DATE COMMENT 'The actual date the payment was made to the supplier.',
    `payment_due_date` DATE COMMENT 'The date by which payment must be made to the supplier according to the payment terms.',
    `payment_method` STRING COMMENT 'The method by which payment will be made to the supplier.. Valid values are `wire_transfer|ach|check|credit_card|electronic_payment|letter_of_credit`',
    `payment_reference_number` STRING COMMENT 'The reference number assigned to the payment transaction when the invoice is paid.',
    `payment_status` STRING COMMENT 'Current payment status indicating whether the invoice has been paid.. Valid values are `unpaid|partially_paid|fully_paid|overdue|on_hold`',
    `payment_terms` STRING COMMENT 'The agreed payment terms between the buyer and supplier, such as Net 30, Net 60, or 2/10 Net 30.',
    `posting_date` DATE COMMENT 'The date the invoice was posted to the financial accounting system.',
    `purchasing_group` STRING COMMENT 'The purchasing group or buyer responsible for the procurement transaction.',
    `purchasing_organization` STRING COMMENT 'The organizational unit responsible for procurement activities related to this invoice.',
    `reference` STRING COMMENT 'Additional reference number or code provided by the supplier on the invoice document for their internal tracking.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applied to the invoice, including VAT, sales tax, or other applicable taxes.',
    `tax_code` STRING COMMENT 'The tax code applied to the invoice for tax calculation purposes.',
    `tax_jurisdiction` STRING COMMENT 'The tax jurisdiction or authority under which the invoice tax is calculated.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match verification process comparing purchase order, goods receipt, and invoice.. Valid values are `matched|not_matched|partially_matched|override`',
    `tolerance_check_status` STRING COMMENT 'Result of the tolerance check comparing invoice amounts against purchase order and goods receipt amounts.. Valid values are `passed|failed|warning|not_checked`',
    `tolerance_variance_amount` DECIMAL(18,2) COMMENT 'The amount by which the invoice differs from the expected amount based on the purchase order and goods receipt.',
    `tolerance_variance_percentage` DECIMAL(18,2) COMMENT 'The percentage variance between the invoice amount and the expected amount.',
    `wbs_element` STRING COMMENT 'The WBS element for project-related invoices, linking the invoice to a specific project phase or deliverable.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax deducted from the invoice payment.',
    CONSTRAINT pk_supplier_invoice PRIMARY KEY(`supplier_invoice_id`)
) COMMENT 'Supplier invoice document received from a vendor and processed for three-way match verification (PO–GR–Invoice). Captures invoice number, supplier invoice reference, invoice date, posting date, gross amount, tax amount, currency, payment due date, payment terms, invoice status (parked, posted, blocked, cleared), and tolerance check results. Serves as the SSOT for procurement-side payables within the procure-to-pay cycle.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`finance`.`commodity_category` (
    `commodity_category_id` BIGINT COMMENT 'Primary key for commodity_category',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Commodity categories are mapped to GL accounts in SAP MM for automatic account determination. This FK links the spend taxonomy to the chart of accounts, enabling automatic GL account assignment during',
    `parent_category_commodity_category_id` BIGINT COMMENT 'Reference to the parent category in the hierarchy. Null for top-level (L1) categories.',
    `category_code` STRING COMMENT 'Unique alphanumeric code identifying the commodity category. May align with UNSPSC (United Nations Standard Products and Services Code) or internal taxonomy.. Valid values are `^[A-Z0-9]{2,20}$`',
    `category_description` STRING COMMENT 'Detailed description of the commodity category scope, including typical materials, services, or products classified under this category.',
    `category_level` STRING COMMENT 'Hierarchical level of the category within the taxonomy structure. L1 represents top-level, L2 sub-category, L3 detailed category, etc.. Valid values are `L1|L2|L3|L4|L5`',
    `category_manager_name` STRING COMMENT 'Full name of the category manager responsible for strategic sourcing and supplier relationships within this category.',
    `category_name` STRING COMMENT 'Full descriptive name of the commodity category (e.g., Electrical Components, Raw Steel, MRO Supplies).',
    `category_status` STRING COMMENT 'Current lifecycle status of the commodity category within the procurement taxonomy.. Valid values are `active|inactive|under_review|deprecated`',
    `compliance_requirement_flag` BOOLEAN COMMENT 'Indicates whether this category has specific regulatory compliance requirements (e.g., RoHS, REACH, conflict minerals, ISO certifications).',
    `contract_coverage_flag` BOOLEAN COMMENT 'Indicates whether this category is covered by active procurement contracts or framework agreements.',
    `cost_reduction_target_pct` DECIMAL(18,2) COMMENT 'Annual cost reduction target percentage for this category as part of strategic sourcing initiatives.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this commodity category record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this commodity category classification became effective in the procurement taxonomy.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether this category requires environmental compliance certifications such as ISO 14001, RoHS, REACH, or conflict minerals reporting.',
    `expiration_date` DATE COMMENT 'Date when this commodity category classification expires or is scheduled for review. Null for active categories without planned expiration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this commodity category record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when this category was last reviewed for accuracy, relevance, and alignment with business needs.',
    `lead_time_days_avg` STRING COMMENT 'Average procurement lead time in days for materials and services within this category, from requisition to delivery.',
    `moq_applicable_flag` BOOLEAN COMMENT 'Indicates whether suppliers in this category typically enforce minimum order quantity requirements.',
    `negotiation_frequency` STRING COMMENT 'Typical frequency of contract negotiations and RFx events for this commodity category.. Valid values are `annual|semi_annual|quarterly|ad_hoc`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this commodity category classification and sourcing strategy.',
    `preferred_supplier_count` STRING COMMENT 'Number of preferred suppliers currently approved and active for this commodity category.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether this category has designated preferred suppliers with negotiated contracts or framework agreements.',
    `price_volatility_index` STRING COMMENT 'Classification of price volatility for commodities in this category based on historical price fluctuations and market dynamics.. Valid values are `high|medium|low|stable`',
    `purchasing_group` STRING COMMENT 'Code identifying the purchasing group (buyer team) responsible for operational procurement within this category.. Valid values are `^[A-Z0-9]{3,10}$`',
    `purchasing_organization` STRING COMMENT 'Code identifying the purchasing organization responsible for procurement activities within this category. Aligns with SAP organizational structure.. Valid values are `^[A-Z0-9]{4,10}$`',
    `quality_certification_required` STRING COMMENT 'Comma-separated list of required quality certifications for suppliers in this category (e.g., ISO 9001, IATF 16949, AS9100).',
    `remarks` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to this commodity category.',
    `risk_classification` STRING COMMENT 'Risk classification based on supply chain vulnerability, supplier concentration, geopolitical factors, and material criticality.. Valid values are `high_risk|medium_risk|low_risk`',
    `sourcing_strategy` STRING COMMENT 'Defined sourcing strategy for this category: single-source, dual-source, multi-source, global sourcing, or local sourcing approach.. Valid values are `single_source|dual_source|multi_source|global_sourcing|local_sourcing`',
    `spend_type` STRING COMMENT 'Classification of spend type: direct materials (production inputs), indirect materials (non-production), MRO (Maintenance, Repair, Operations), CapEx (Capital Expenditure), or services.. Valid values are `direct|indirect|MRO|CapEx|services`',
    `strategic_sourcing_priority` STRING COMMENT 'Priority level assigned to this category for strategic sourcing initiatives based on spend volume, supply risk, and business impact.. Valid values are `critical|high|medium|low`',
    `unspsc_class` STRING COMMENT 'Third-level UNSPSC class name within the family (e.g., Cutting and Forming Machines).',
    `unspsc_code` STRING COMMENT 'Eight-digit UNSPSC classification code for global commodity standardization and cross-industry spend analysis.. Valid values are `^[0-9]{8}$`',
    `unspsc_commodity` STRING COMMENT 'Fourth-level UNSPSC commodity name, the most granular classification level (e.g., CNC Milling Machines).',
    `unspsc_family` STRING COMMENT 'Second-level UNSPSC family name within the segment (e.g., Metalworking Machinery and Equipment).',
    `unspsc_segment` STRING COMMENT 'Top-level UNSPSC segment name (e.g., Industrial Manufacturing and Processing Machinery and Accessories).',
    CONSTRAINT pk_commodity_category PRIMARY KEY(`commodity_category_id`)
) COMMENT 'Commodity and spend category taxonomy used to classify all purchased materials and services into a hierarchical structure aligned with UNSPSC or internal category codes. Captures category code, category name, category level (L1/L2/L3), parent category, spend type (direct/indirect/MRO/CapEx), category owner, preferred supplier flag, and strategic sourcing priority. Enables category management, spend cube construction, and sourcing strategy alignment.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`finance`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'System-generated unique identifier for the cost center.',
    `parent_cost_center_id` BIGINT COMMENT 'Identifier of the immediate parent cost center in the hierarchy.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual costs incurred by the cost center.',
    `allocation_basis` STRING COMMENT 'Method used to allocate costs from this center to other entities.. Valid values are `direct|percentage|activity_based`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned budget allocated to the cost center for the fiscal period.',
    `controlling_area_code` STRING COMMENT 'Code of the controlling area to which the cost center belongs.',
    `cost_center_code` STRING COMMENT 'Business key used to identify the cost center in financial transactions.',
    `cost_center_description` STRING COMMENT 'Detailed description of the cost centers purpose and scope.',
    `cost_center_group` STRING COMMENT 'Logical grouping of cost centers for reporting or allocation purposes.',
    `cost_center_name` STRING COMMENT 'Human‑readable name of the cost center.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center.. Valid values are `active|inactive|planned|closed`',
    `cost_center_type` STRING COMMENT 'Classification of the cost center by functional area.. Valid values are `production|administration|research_and_development|sales|support`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cost center record was first created.',
    `currency_code` STRING COMMENT 'Currency in which the cost centers financials are recorded.. Valid values are `^[A-Z]{3}$`',
    `external_reference` STRING COMMENT 'Identifier used to map the cost center to external systems or legacy codes.',
    `hierarchy_level` STRING COMMENT 'Depth of the cost center within the organizational hierarchy.',
    `hierarchy_path` STRING COMMENT 'Slash‑delimited path representing the cost centers position in the hierarchy (e.g., "/100/200/300").',
    `is_overhead` BOOLEAN COMMENT 'Indicates whether the cost center is used for overhead cost allocation.',
    `location_code` STRING COMMENT 'Code of the physical location or plant associated with the cost center.',
    `owner_department` STRING COMMENT 'Organizational department that owns the cost center.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cost center record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between budgeted and actual costs.',
    `valid_from` DATE COMMENT 'Date when the cost center becomes effective.',
    `valid_to` DATE COMMENT 'Date when the cost center is retired or becomes inactive.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Master record for all SAP CO cost centers representing organizational units responsible for incurring costs. Captures cost center hierarchy, responsible manager, controlling area assignment, profit center assignment, currency, validity period, cost center category (production, administration, R&D, sales), and standard hierarchy position. Serves as the SSOT for internal cost allocation, overhead absorption, and management accounting structures. The primary controlling object for budget assignment, actual cost collection, and variance analysis in manufacturing operations.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`finance`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'System-generated unique identifier for the profit center.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Profit centers belong to a company code (legal entity) in SAP CO. The existing `legal_entity_code` STRING field is a denormalized reference to the company code; replacing it with company_code_id FK no',
    `cost_center_id` BIGINT COMMENT 'Link to the primary cost center that supplies cost data for this profit center.',
    `parent_profit_center_id` BIGINT COMMENT 'Identifier of the immediate parent profit center in the hierarchy, if any.',
    `actual_profit` DECIMAL(18,2) COMMENT 'Realized profit for the profit center in the reporting period.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Approved budget amount for the profit center for the fiscal period.',
    `controlling_area` STRING COMMENT 'Code of the controlling area to which the profit center belongs for internal cost accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the profit center record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code in which the profit center records its functional amounts.. Valid values are `^[A-Z]{3}$`',
    `financial_reporting_line` STRING COMMENT 'Line of financial reporting hierarchy (e.g., segment, division, business unit) used for IFRS segment reporting.. Valid values are `segment|division|business_unit`',
    `hierarchy_level` STRING COMMENT 'Numeric level indicating the profit centers depth in the organizational hierarchy.',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether the profit center is included in statutory and management reporting.',
    `last_review_date` DATE COMMENT 'Date of the most recent strategic review of the profit center.',
    `oee_target_percent` DECIMAL(18,2) COMMENT 'Target Overall Equipment Effectiveness percentage assigned to the profit center for performance benchmarking.',
    `owner` STRING COMMENT 'Business unit or individual accountable for the profit centers performance.',
    `planned_profit` DECIMAL(18,2) COMMENT 'Profit amount planned for the profit center at the start of the reporting period.',
    `profit_center_code` STRING COMMENT 'Business identifier code assigned to the profit center, often used in financial postings.. Valid values are `^[A-Z0-9]{3,10}$`',
    `profit_center_description` STRING COMMENT 'Free‑text description providing context about the profit centers purpose and scope.',
    `profit_center_group` STRING COMMENT 'Logical grouping name used for consolidated reporting across multiple profit centers.',
    `profit_center_name` STRING COMMENT 'Human‑readable name of the profit center used in reports and dashboards.',
    `profit_center_status` STRING COMMENT 'Current lifecycle status of the profit center.. Valid values are `active|inactive|planned|closed`',
    `profit_center_type` STRING COMMENT 'Classification indicating whether the profit center is internal, external, or a joint‑venture entity.. Valid values are `internal|external|joint_venture`',
    `region` STRING COMMENT 'Geographic region where the profit center primarily operates.. Valid values are `NA|EMEA|APAC`',
    `reporting_currency_code` STRING COMMENT 'Currency code used for external financial reporting of the profit center.. Valid values are `^[A-Z]{3}$`',
    `segment` STRING COMMENT 'High‑level business segment classification for the profit center.. Valid values are `Manufacturing|Services|R&D|Support`',
    `tax_jurisdiction_code` STRING COMMENT 'Code representing the tax jurisdiction applicable to the profit center.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the profit center record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the profit center record.',
    `valid_from` DATE COMMENT 'Date on which the profit center becomes effective for reporting.',
    `valid_to` DATE COMMENT 'Date on which the profit center ceases to be effective; null if still active.',
    `created_by` STRING COMMENT 'User identifier of the person who created the profit center record.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Master record for profit centers representing autonomous business segments within the manufacturing enterprise used for internal profitability reporting. Captures profit center hierarchy, controlling area, responsible manager, segment classification, currency, and validity dates. Enables P&L reporting at sub-entity level per SAP EC-PCA (Profit Center Accounting) aligned with IFRS segment reporting.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`finance`.`gl_account` (
    `gl_account_id` BIGINT COMMENT 'System-generated unique identifier for the GL account record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: GL account may be assigned to a cost center for reporting.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: GL account may be assigned to a profit center for reporting.',
    `account_category` STRING COMMENT 'Business‑level categorisation used for reporting and analysis.. Valid values are `operating|non_operating|tax|intercompany|regulatory`',
    `account_group` STRING COMMENT 'Higher‑level grouping code that aggregates multiple GL accounts for reporting.',
    `account_long_description` STRING COMMENT 'Extended description providing additional context for reporting and audit.',
    `account_name` STRING COMMENT 'Human‑readable name describing the purpose of the GL account.',
    `account_number` STRING COMMENT 'External business identifier for the GL account, used in postings and reporting.',
    `account_type` STRING COMMENT 'Classification of the account by financial statement section.. Valid values are `balance_sheet|profit_and_loss|equity|asset|liability`',
    `balance_type` STRING COMMENT 'Indicates whether the account is a natural debit or credit account.. Valid values are `debit|credit`',
    `consolidation_group` STRING COMMENT 'Identifier of the consolidation group for legal entity roll‑up.',
    `cost_element_category` STRING COMMENT 'Indicates whether the account is linked to a primary or secondary cost element for CO integration.. Valid values are `primary|secondary|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the GL account record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter code of the currency in which the account is denominated.',
    `current_balance` DECIMAL(18,2) COMMENT 'Running balance reflecting all posted transactions to date.',
    `external_system_code` STRING COMMENT 'Identifier of the source ERP or external system that created the account.',
    `functional_area` STRING COMMENT 'Organisational functional area to which the account belongs (e.g., Manufacturing, R&D, Sales).',
    `gl_account_description` STRING COMMENT 'Long textual description of the account purpose and usage.',
    `gl_account_status` STRING COMMENT 'Current lifecycle status of the account.. Valid values are `active|inactive|blocked|pending|closed`',
    `is_bank_account` BOOLEAN COMMENT 'True if the account is linked to a bank account for cash management.',
    `is_budget_enabled` BOOLEAN COMMENT 'True if the account participates in budgeting processes.',
    `is_cash_account` BOOLEAN COMMENT 'True if the account represents cash or cash equivalents.',
    `is_deprecated` BOOLEAN COMMENT 'True if the account is scheduled for retirement and should no longer be used for new postings.',
    `is_expense_account` BOOLEAN COMMENT 'True if the account is used for operating expense postings.',
    `is_fixed_asset_account` BOOLEAN COMMENT 'True if the account is used for fixed‑asset accounting.',
    `is_forecast_enabled` BOOLEAN COMMENT 'True if the account is included in financial forecasting.',
    `is_income_account` BOOLEAN COMMENT 'True if the account records income other than sales.',
    `is_intercompany` BOOLEAN COMMENT 'True if the account is used for intercompany transactions.',
    `is_inventory_account` BOOLEAN COMMENT 'True if the account tracks inventory valuation.',
    `is_purchase_account` BOOLEAN COMMENT 'True if the account records purchase expenses.',
    `is_reconciliation_account` BOOLEAN COMMENT 'True if the account is used for automatic reconciliation of sub‑ledger postings.',
    `is_sales_account` BOOLEAN COMMENT 'True if the account records sales revenue.',
    `is_tax_relevant` BOOLEAN COMMENT 'True if the account is subject to tax reporting requirements.',
    `opening_balance` DECIMAL(18,2) COMMENT 'Balance of the account at the start of the fiscal year.',
    `reporting_currency` STRING COMMENT 'Currency used for consolidated financial reporting.',
    `segment` STRING COMMENT 'Business segment code (e.g., Industrial, Energy, Services) for segment reporting.',
    `tax_code` STRING COMMENT 'Tax classification applied to postings against this account.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the GL account record.',
    `valid_from` DATE COMMENT 'Date from which the account becomes effective for posting.',
    `valid_to` DATE COMMENT 'Date after which the account is no longer valid for posting (nullable).',
    CONSTRAINT pk_gl_account PRIMARY KEY(`gl_account_id`)
) COMMENT 'General ledger account master record serving as the SSOT for the chart of accounts used across all financial postings. Captures account number, account type (balance sheet, P&L), account group, reconciliation account flag, currency, tax category, field status group, cost element category (primary/secondary for CO integration), functional area, and IFRS/GAAP classification. Bridges financial accounting and management accounting by carrying cost element attributes that enable controlling postings. Governs all financial postings and is the backbone of the enterprise chart of accounts.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`finance`.`company_code` (
    `company_code_id` BIGINT COMMENT 'Surrogate key for company code record.',
    `business_partner_id` BIGINT COMMENT 'Reference to the Business Partner master record representing the legal entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Company code is associated with a cost center for controlling.',
    `annual_revenue_local_currency` DECIMAL(18,2) COMMENT 'Annual revenue reported in the entitys local currency.',
    `audit_trail_reference` BIGINT COMMENT 'Identifier linking to audit trail records for changes to this company code.',
    `chart_of_accounts` STRING COMMENT 'Chart of accounts key linked to the company code.',
    `company_code` STRING COMMENT 'Alphanumeric identifier for the legal entity as defined in SAP.',
    `company_code_name` STRING COMMENT 'Full legal name of the company entity.',
    `company_code_status` STRING COMMENT 'Current lifecycle status of the company code.. Valid values are `active|inactive|pending|closed`',
    `consolidation_group` STRING COMMENT 'Group identifier for financial consolidation.',
    `consolidation_method` STRING COMMENT 'Method used for consolidation (e.g., full, proportional).',
    `controlling_area` STRING COMMENT 'Controlling area assigned for cost accounting.',
    `country` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the legal entity is registered.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the company code record was created in the source system.',
    `currency` STRING COMMENT 'ISO 4217 currency code used for the legal entitys financial reporting.',
    `effective_end_date` DATE COMMENT 'Date when the company code ceases to be effective, if applicable.',
    `effective_start_date` DATE COMMENT 'Date from which the company code becomes effective.',
    `elimination_scope` STRING COMMENT 'Scope of intercompany eliminations for the company code.',
    `fiscal_year_variant` STRING COMMENT 'Fiscal year variant assigned to the company code for period accounting.',
    `headquarter_address_line1` STRING COMMENT 'First line of the legal entitys headquarters address.',
    `headquarter_city` STRING COMMENT 'City of the legal entitys headquarters.',
    `headquarter_postal_code` STRING COMMENT 'Postal code of the headquarters address.',
    `headquarter_state` STRING COMMENT 'State or province of the headquarters.',
    `industry_classification_code` STRING COMMENT 'Industry classification code (e.g., NAICS) for the entity.',
    `is_consolidated` BOOLEAN COMMENT 'Indicates whether the company code is included in group consolidation.',
    `legal_form` STRING COMMENT 'Legal form of the entity (e.g., corporation, LLC).',
    `number_of_employees` STRING COMMENT 'Total number of employees for the legal entity.',
    `primary_contact_email` STRING COMMENT 'Primary email address for official communications with the legal entity.',
    `public_company_flag` BOOLEAN COMMENT 'Indicates if the entity is publicly listed.',
    `registration_number` STRING COMMENT 'Official registration number of the entity with the corporate registry.',
    `segment` STRING COMMENT 'Business segment classification for reporting.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates if the entity is tax-exempt.',
    `tax_id_number` STRING COMMENT 'Tax identification number (e.g., VAT, EIN) for the legal entity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the company code record.',
    CONSTRAINT pk_company_code PRIMARY KEY(`company_code_id`)
) COMMENT 'Master record for SAP FI company codes representing legally independent entities within the manufacturing group. Captures company code identifier, company name, country, currency, fiscal year variant, chart of accounts assignment, controlling area assignment, consolidation group, consolidation method, and elimination scope. Serves as the organizational anchor for all financial postings, statutory reporting under IFRS/GAAP, and the consolidation unit for group financial statement preparation.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`finance`.`journal_entry` (
    `journal_entry_id` BIGINT COMMENT 'System-generated unique identifier for the journal entry record.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: In SAP FI, AP invoice postings generate journal entries. Linking journal_entry back to the source ap_invoice enables full audit trail from GL posting to originating AP document. The existing `referenc',
    `ar_item_id` BIGINT COMMENT 'Foreign key linking to finance.ar_item. Business justification: AR postings (customer payments, invoices, credit memos) generate journal entries in SAP FI-AR. Linking journal_entry to the source ar_item provides traceability from GL postings back to the originatin',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Every SAP FI journal entry is posted under a specific company code (legal entity). The existing STRING field `company_code` is a denormalized code; replacing it with company_code_id FK normalizes this',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Journal entry references a cost center; replace code with FK.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Asset acquisitions, depreciation runs, and disposals all generate journal entries in SAP FI-AA. Linking journal_entry to fixed_asset enables direct traceability from GL postings to the asset register,',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Journal entries post to GL accounts — this is the fundamental SAP FI relationship. Every journal entry line item references a GL account. Adding gl_account_id as the primary posting account FK enables',
    `production_work_order_id` BIGINT COMMENT 'Foreign key linking to production.production_work_order. Business justification: Journal entries for production order settlements, WIP postings, and variance postings reference the originating work order. In industrial manufacturing CO-PC, period-end settlement creates journal ent',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Journal entry references a profit center; replace code with FK.',
    `audit_trail_reference` BIGINT COMMENT 'Reference to the audit log entry for compliance tracking.',
    `batch_reference` STRING COMMENT 'Identifier of the processing batch for mass postings.',
    `business_area` STRING COMMENT 'Higher‑level business area used in financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the journal entry record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the transaction currency.',
    `document_date` DATE COMMENT 'Date on the original source document (e.g., invoice date).',
    `document_header_text` STRING COMMENT 'Header description of the journal document.',
    `document_number` STRING COMMENT 'External business identifier for the journal entry, typically the SAP document number.',
    `document_type` STRING COMMENT 'Category of the journal entry indicating its purpose (e.g., invoice, credit note).. Valid values are `invoice|credit_note|payment|adjustment|reversal|accrual`',
    `entry_date` DATE COMMENT 'Date when the journal entry was entered into the system.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert transaction currency to local company currency.',
    `exchange_rate_type` STRING COMMENT 'Indicator of the exchange rate calculation method (e.g., average, spot).',
    `fiscal_period` STRING COMMENT 'Numeric period (e.g., month) within the fiscal year for the posting.',
    `fiscal_year` STRING COMMENT 'Four‑digit fiscal year to which the posting belongs.',
    `fiscal_year_variant` STRING COMMENT 'Variant of the fiscal year used for special reporting calendars.',
    `gaap_compliance_flag` BOOLEAN COMMENT 'True if the posting complies with local GAAP reporting standards.',
    `ifrs_compliance_flag` BOOLEAN COMMENT 'True if the posting complies with IFRS reporting standards.',
    `is_adjusted` BOOLEAN COMMENT 'True if the entry represents an adjustment rather than a primary posting.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Total amount of the posting converted to the company’s local currency.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount (debits minus credits) of the journal entry.',
    `posting_date` DATE COMMENT 'Date on which the journal entry was posted to the general ledger.',
    `posting_key` STRING COMMENT 'SAP posting key indicating debit or credit nature of the line.',
    `posting_period` STRING COMMENT 'Period identifier used for period‑end closing.',
    `posting_status` STRING COMMENT 'Current lifecycle status of the journal entry.. Valid values are `posted|pending|reversed|error`',
    `posting_text` STRING COMMENT 'Free‑form text entered by the user describing the posting.',
    `posting_time` TIMESTAMP COMMENT 'Exact timestamp when the entry was posted to the ledger.',
    `reference_document` STRING COMMENT 'External document number referenced by this journal entry (e.g., purchase order).',
    `reversal_document_number` STRING COMMENT 'Document number of the original entry that this entry reverses.',
    `reversal_indicator` BOOLEAN COMMENT 'True if this entry reverses a previous posting.',
    `segment` STRING COMMENT 'Segment classification for reporting (e.g., Industrial, Services).',
    `source_system` STRING COMMENT 'Name of the source ERP/system that generated the journal entry (e.g., SAP FI).',
    `tax_amount_total` DECIMAL(18,2) COMMENT 'Aggregate tax amount calculated for the posting.',
    `tax_code` STRING COMMENT 'Tax code applicable to the posting.',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'Sum of credit line amounts for the journal entry in local currency.',
    `total_debit_amount` DECIMAL(18,2) COMMENT 'Sum of debit line amounts for the journal entry in local currency.',
    `transaction_currency_amount` DECIMAL(18,2) COMMENT 'Total amount of the posting in the transaction currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the journal entry.',
    `wbs_element` STRING COMMENT 'WBS element reference for project accounting.',
    CONSTRAINT pk_journal_entry PRIMARY KEY(`journal_entry_id`)
) COMMENT 'Core transactional record capturing all general ledger postings at both document header and line item level, serving as the single source of truth for the complete financial audit trail. Header attributes include document number, document type, posting date, fiscal year, period, company code, currency, exchange rate, reference document, reversal indicator, and IFRS/GAAP compliance flags. Line item attributes include line number, GL account, debit/credit indicator, amount in transaction and local currencies, cost center, profit center, WBS element reference, internal order, tax code, assignment field, and posting text. Covers manual journal entries, automated system postings, accruals, reversals, reclassifications, and period-end closing entries. Foundation for trial balance, financial statements, reconciliation, and audit evidence.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`finance`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the budget record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Finance budgets in SAP CO are always scoped to a company code (legal entity). This FK links budget records to the legal entity master, enabling entity-level budget vs. actual reporting, financial plan',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget is planned for a specific cost center; replace code with FK.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Budget can be linked to a GL account for accounting entries.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: Budgets are organized by plant in industrial manufacturing for plant-level cost planning, capital expenditure approval, and budget variance reporting. Finance controllers prepare plant budgets for ann',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Budget is planned for a specific profit center; replace code with FK.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Territory-level sales budget planning: industrial manufacturers set annual revenue budgets by sales territory for quota allocation, budget vs. actual variance reporting, and sales performance manageme',
    `approval_date` DATE COMMENT 'Date when the budget was approved.',
    `approval_status` STRING COMMENT 'Current approval status of the budget.. Valid values are `pending|approved|rejected`',
    `budget_category` STRING COMMENT 'High-level category of the budget.. Valid values are `CapEx|OpEx|Headcount|Materials|Other`',
    `budget_code` STRING COMMENT 'Business identifier code for the budget, used for reference and reporting.',
    `budget_name` STRING COMMENT 'Descriptive name of the budget.',
    `budget_type` STRING COMMENT 'Classification of the budget version: original, revised, or supplemental.. Valid values are `original|revised|supplemental`',
    `cost_element` STRING COMMENT 'Cost element classification for budgeting purposes.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for budget amounts.',
    `department_code` STRING COMMENT 'Code of the department owning the budget.',
    `effective_end_date` DATE COMMENT 'Date when the budget expires or is superseded.',
    `effective_start_date` DATE COMMENT 'Date when the budget becomes effective.',
    `finance_budget_status` STRING COMMENT 'Current lifecycle status of the budget.. Valid values are `draft|submitted|approved|rejected|closed`',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year to which the budget applies.',
    `forecast_method` STRING COMMENT 'Method used to generate forecasted amounts within the budget.. Valid values are `historical|statistical|managerial|none`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the budget is currently active.',
    `is_capex` BOOLEAN COMMENT 'Indicates if the budget pertains to capital expenditures.',
    `is_opex` BOOLEAN COMMENT 'Indicates if the budget pertains to operational expenditures.',
    `last_review_date` DATE COMMENT 'Date of the most recent budget review.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the budget.',
    `period` STRING COMMENT 'Reporting period covered by the budget (quarterly or annual).. Valid values are `Q1|Q2|Q3|Q4|Annual`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the budget record was first captured in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the budget record.',
    `region_code` STRING COMMENT 'Geographic region code for the budget.',
    `review_cycle` STRING COMMENT 'Frequency of budget review cycles.. Valid values are `monthly|quarterly|annual`',
    `source_system` STRING COMMENT 'Originating system of the budget data (e.g., SAP S/4HANA).',
    `total_committed_amount` DECIMAL(18,2) COMMENT 'Aggregate amount that has been committed (e.g., purchase orders).',
    `total_planned_amount` DECIMAL(18,2) COMMENT 'Aggregate planned amount for the budget across all periods and categories.',
    `total_revised_amount` DECIMAL(18,2) COMMENT 'Aggregate revised amount after adjustments.',
    `updated_by` STRING COMMENT 'User identifier who last updated the budget record.',
    `variance_threshold_percent` DECIMAL(18,2) COMMENT 'Acceptable variance percentage between planned and actual amounts.',
    `version_number` STRING COMMENT 'Sequential version number of the budget.',
    `version_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget version was created or released.',
    `created_by` STRING COMMENT 'User identifier who created the budget record.',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Budget planning and tracking records capturing both header-level governance and period-level line item detail for all controlling objects (cost centers, profit centers, internal orders). Header captures budget version, fiscal year, budget type (original, revised, supplemental), approval workflow status, responsible manager, and total planned amounts. Line items capture controlling object assignment, GL account, cost element, fiscal period, planned amount, revised amount, committed amount, currency, and budget category (CapEx, OpEx, headcount, materials). Supports FP&A variance analysis (plan vs actual vs forecast), budget-to-actual reporting, rolling forecast integration, budget transfer workflows, and CapEx/OpEx governance across the manufacturing enterprise.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`finance`.`ap_invoice` (
    `ap_invoice_id` BIGINT COMMENT 'System-generated unique identifier for the accounts payable invoice record.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: AP invoices are paid from specific house bank accounts in SAP FI. The existing `house_bank_account` STRING field is a denormalized reference; replacing it with bank_account_id FK normalizes payment ro',
    `company_code_id` BIGINT COMMENT 'FK to finance.company_code',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AP invoice belongs to a cost center; replace string code with FK for referential integrity.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AP invoices are posted to GL accounts in SAP FI-AP. The GL account determines the expense or liability account for the invoice posting. This FK enables direct navigation from AP invoice to the chart o',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to finance.procurement_contract. Business justification: AP invoices are frequently issued against procurement contracts (framework agreements) in manufacturing. Linking ap_invoice to procurement_contract enables contract compliance monitoring, spend-agains',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supplier.procurement_goods_receipt. Business justification: Three-way match in industrial manufacturing AP processing requires direct linkage between AP invoice and the goods receipt. goods_receipt_number is a plain-text denormalization. FK enables GR/IR clear',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: AP invoice belongs to a profit center; replace string code with FK.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplier.purchase_order. Business justification: AP invoices are matched to POs for three-way match (PO/GR/Invoice) in industrial manufacturing — a core AP processing and audit compliance requirement. purchase_order_number is a plain-text denormaliz',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the vendor that issued the invoice.',
    `approval_status` STRING COMMENT 'Current state of the invoice approval workflow.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice was approved.',
    `approval_user` STRING COMMENT 'User identifier of the person who approved the invoice.',
    `bank_statement_reconciliation_status` STRING COMMENT 'Status of matching the payment against bank statement entries.. Valid values are `reconciled|unreconciled|partial`',
    `baseline_date` DATE COMMENT 'Date used as the starting point for payment terms calculation.',
    `cash_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied when payment is made within discount period.',
    `clearing_document_number` STRING COMMENT 'Reference to the accounting document that clears the invoice.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the invoice amounts.',
    `discount_taken` DECIMAL(18,2) COMMENT 'Monetary value of any cash discount applied.',
    `document_number` STRING COMMENT 'External invoice number assigned by the vendor or the organization.',
    `due_date` DATE COMMENT 'Date by which the invoice must be paid according to payment terms.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, and withholdings.',
    `invoice_date` DATE COMMENT 'Date the vendor issued the invoice.',
    `invoice_type` STRING COMMENT 'Classification of the invoice (e.g., standard invoice, credit memo).. Valid values are `standard|credit_memo|debit_memo`',
    `net_amount` DECIMAL(18,2) COMMENT 'Amount payable after taxes, discounts, and withholdings.',
    `payment_amount` DECIMAL(18,2) COMMENT 'Amount actually paid for the invoice.',
    `payment_block_reason` STRING COMMENT 'Reason why payment processing is blocked for this invoice.',
    `payment_date` DATE COMMENT 'Date on which the payment was actually made.',
    `payment_method` STRING COMMENT 'Instrument used to settle the invoice.. Valid values are `ACH|wire|check|direct_debit`',
    `payment_reference` STRING COMMENT 'Reference number provided by the bank for the payment transaction.',
    `payment_status` STRING COMMENT 'Current status of the payment execution.. Valid values are `scheduled|paid|failed|cancelled`',
    `payment_terms` STRING COMMENT 'Standard terms defining when payment is due (e.g., Net 30, 2% 10 Net 30).',
    `payment_value_date` DATE COMMENT 'Date on which the payment amount is considered effective.',
    `posting_date` DATE COMMENT 'Date the invoice was posted to the general ledger.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the invoice record.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax calculated for the invoice.',
    `tax_code` STRING COMMENT 'Code that determines the tax rate and calculation rules applied.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the invoice is exempt from tax.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax percentage for the invoice.',
    `three_way_match_status` STRING COMMENT 'Result of PO/GR/IR verification: matched, unmatched, or partially matched.. Valid values are `matched|unmatched|partial`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted at source.',
    `withholding_tax_code` STRING COMMENT 'Code defining the withholding tax rate and rules.',
    CONSTRAINT pk_ap_invoice PRIMARY KEY(`ap_invoice_id`)
) COMMENT 'Accounts payable full lifecycle records capturing vendor invoices and their associated payment execution processed as a unified payables document. Invoice attributes include document number, vendor, company code, invoice date, posting date, baseline date, payment terms, gross amount, tax amount, net amount, three-way match status (PO/GR/IR verification), payment block reason, and approval workflow status. Payment attributes include payment method (ACH, wire, check, direct debit), house bank account, value date, payment amount, discount taken, cash discount percentage, clearing document reference, payment run identifier, and bank statement reconciliation status. Covers the complete payables cycle from invoice receipt through three-way matching, approval, payment proposal, payment execution, and bank clearing. Serves as the SSOT for all vendor obligations, payment commitments, and outgoing cash flows.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`finance`.`ar_item` (
    `ar_item_id` BIGINT COMMENT 'System-generated unique identifier for the AR line item record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer party to whom the invoice is issued.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Every AR item in SAP FI-AR belongs to a specific company code (legal entity). The existing STRING field `company_code` is a denormalized code; replacing it with company_code_id FK normalizes this to t',
    `contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Contract revenue recognition (IFRS 15/ASC 606): AR items in industrial manufacturing must reference the governing sales contract for contract-level revenue tracking, billing milestone validation, and ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: AR item is posted to a cost center; replace string code with FK.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: AR items post to GL reconciliation accounts in SAP FI-AR. The GL account determines the receivables account for the AR posting. This FK enables direct navigation from AR items to the chart of accounts',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: AR item is posted to a profit center; replace string code with FK.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: ar_item has material_number as a plain denormalized text field. Replacing with FK to sku_master enables revenue recognition by product SKU, customer profitability analysis by product, and sales analyt',
    `sla_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_agreement. Business justification: AR items for SLA annual fees, penalty credits, and service billings must reference the governing SLA agreement for dispute resolution, IFRS 15 revenue recognition, and contract compliance reporting. F',
    `aging_bucket` STRING COMMENT 'Categorization of the outstanding amount based on days past due.. Valid values are `0-30|31-60|61-90|90+`',
    `aging_days` STRING COMMENT 'Number of days the invoice is overdue.',
    `business_area` STRING COMMENT 'Higher‑level grouping of profit centers for consolidated reporting.',
    `cleared_flag` BOOLEAN COMMENT 'Indicates whether the AR item has been fully settled.',
    `clearing_document_number` STRING COMMENT 'Document number of the payment or credit memo that cleared this AR item.',
    `collection_status` STRING COMMENT 'Current status of the collection effort for the AR item.. Valid values are `pending|in_progress|resolved`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the AR line item record was first created in the system.',
    `credit_memo_amount` DECIMAL(18,2) COMMENT 'Total amount of credit memos applied to reduce the invoice balance.',
    `credit_memo_flag` BOOLEAN COMMENT 'Indicates whether a credit memo has been issued against this AR item.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the transaction currency.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total cash discount taken on the invoice.',
    `dispute_status` STRING COMMENT 'Current status of any dispute raised against the invoice.. Valid values are `none|open|resolved`',
    `document_number` STRING COMMENT 'External document number assigned by SAP FI for the AR transaction.',
    `due_date` DATE COMMENT 'Date by which payment is expected according to payment terms.',
    `dunning_level` STRING COMMENT 'Current dunning step indicating the severity of overdue collection.. Valid values are `1|2|3|4|5`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert the invoice amount to the company codes local currency.',
    `invoice_amount` DECIMAL(18,2) COMMENT 'Gross amount of the invoice in the document currency before discounts, taxes, or adjustments.',
    `invoice_description` STRING COMMENT 'Free‑text description of goods or services billed.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment applied to this AR item.',
    `last_payment_method` STRING COMMENT 'Payment method used for the most recent payment.. Valid values are `bank_transfer|credit_card|check|cash`',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Invoice amount expressed in the company codes functional currency.',
    `net_amount` DECIMAL(18,2) COMMENT 'Invoice amount after discounts and taxes, representing the amount due.',
    `open_amount` DECIMAL(18,2) COMMENT 'Remaining amount still outstanding after payments and adjustments.',
    `original_amount` DECIMAL(18,2) COMMENT 'Original gross amount at invoice creation before any adjustments.',
    `payment_date` DATE COMMENT 'Date on which the invoice was fully or partially paid.',
    `payment_method` STRING COMMENT 'Means by which the customer remitted payment.. Valid values are `bank_transfer|credit_card|check|cash`',
    `payment_reference` STRING COMMENT 'Reference identifier supplied by the customer for the payment transaction.',
    `payment_terms` STRING COMMENT 'Standard payment condition (e.g., NET30, 2% 10 NET30).',
    `posting_date` DATE COMMENT 'Date the AR document was posted to the general ledger.',
    `record_status` STRING COMMENT 'Lifecycle status of the AR item indicating its processing stage.. Valid values are `open|cleared|written_off|cancelled`',
    `segment` STRING COMMENT 'Business segment classification for reporting (e.g., Industrial, Services).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the invoice calculated using the applicable tax code.',
    `tax_code` STRING COMMENT 'Code that determines tax rate and calculation rules for the invoice.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax percentage derived from the tax code.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the AR line item.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount that has been written off for this AR item.',
    `write_off_flag` BOOLEAN COMMENT 'Indicates whether the remaining balance has been written off as uncollectible.',
    CONSTRAINT pk_ar_item PRIMARY KEY(`ar_item_id`)
) COMMENT 'Accounts receivable open item and cleared item records from SAP FI-AR tracking customer receivables arising from product sales and service billings. Captures AR document number, customer account, company code, posting date, due date, invoice amount, currency, payment terms, dunning level, clearing document, aging bucket, and dispute status. Serves as the SSOT for customer receivables aging and cash collection tracking.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`finance`.`fixed_asset` (
    `fixed_asset_id` BIGINT COMMENT 'System-generated unique identifier for each fixed asset record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Fixed assets in SAP FI-AA are always assigned to a company code (legal entity). This FK is essential for legal entity-level asset reporting, CapEx tracking per entity, and IFRS/GAAP depreciation conso',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fixed asset is assigned to a cost center for depreciation tracking.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: In industrial manufacturing, automation systems and electrification assets are installed at customer sites. Fixed asset records must reference the customer site for asset lifecycle management, depreci',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Fixed assets are linked to asset GL accounts in SAP FI-AA (asset balance sheet accounts). This FK enables direct navigation from the asset register to the chart of accounts, supporting balance sheet r',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Fixed assets are assigned to profit centers in SAP CO for management accounting. This FK enables profit center-level asset reporting, EBITDA calculation (depreciation by profit center), and segment-le',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplier.purchase_order. Business justification: Capital assets in industrial manufacturing are procured via POs — asset capitalization requires traceability to the originating purchase order for audit, warranty tracking, and CAPEX reporting. No exi',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: In industrial manufacturing, capital equipment and tooling are manufactured products that get capitalized as fixed assets. Linking fixed_asset to sku_master enables asset lifecycle management tied to ',
    `work_center_id` BIGINT COMMENT 'Foreign key linking to production.work_center. Business justification: Fixed assets (machinery, equipment) are assigned to work centers in industrial manufacturing for depreciation cost allocation to production operations and asset utilization tracking. Asset accounting ',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recorded to date.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original cost incurred to acquire the asset, recorded in functional currency.',
    `acquisition_date` DATE COMMENT 'Date the asset was acquired or placed into service.',
    `asset_class` STRING COMMENT 'High‑level classification of the asset for reporting and depreciation policy.. Valid values are `Machinery|Vehicle|Building|IT_Equipment|Tooling`',
    `asset_description` STRING COMMENT 'Detailed textual description of the asset, including purpose and key characteristics.',
    `asset_name` STRING COMMENT 'Human‑readable name or title of the asset.',
    `asset_number` STRING COMMENT 'External asset identifier used in accounting and operations, often the tag or barcode.',
    `asset_origin` STRING COMMENT 'Source of the asset acquisition.. Valid values are `purchased|leased|internally_built`',
    `capitalized_flag` BOOLEAN COMMENT 'Indicates whether the cost has been capitalized as a fixed asset.',
    `condition_rating` STRING COMMENT 'Current physical condition of the asset as assessed by maintenance.. Valid values are `excellent|good|fair|poor`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the asset record was first created in the system.',
    `department_responsible` STRING COMMENT 'Department that owns or manages the asset.',
    `depreciation_method` STRING COMMENT 'Method used to calculate periodic depreciation expense.. Valid values are `straight_line|declining_balance|units_of_production`',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation calculations begin for the asset.',
    `fixed_asset_status` STRING COMMENT 'Current lifecycle status of the asset.. Valid values are `active|inactive|retired|maintenance|disposed`',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount the policy will pay for the asset.',
    `insurance_expiry_date` DATE COMMENT 'Date when the insurance coverage ends.',
    `insurance_policy_number` STRING COMMENT 'Reference number of the insurance policy covering the asset.',
    `insurance_provider` STRING COMMENT 'Company that provides the insurance coverage.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity.',
    `lease_contract_number` STRING COMMENT 'Reference number of the lease agreement.',
    `lease_end_date` DATE COMMENT 'Date when a leased assets contract expires.',
    `lease_provider` STRING COMMENT 'Company that provides the leased asset.',
    `maintenance_contract_number` STRING COMMENT 'Reference number of the maintenance service agreement.',
    `maintenance_provider` STRING COMMENT 'Company or internal unit responsible for scheduled maintenance.',
    `manufacturer` STRING COMMENT 'Company that produced the asset.',
    `model_number` STRING COMMENT 'Manufacturers model identifier for the asset.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Assets carrying amount after subtracting accumulated depreciation.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next scheduled maintenance.',
    `plant` STRING COMMENT 'Identifier of the manufacturing plant or site where the asset is located.',
    `replacement_cost` DECIMAL(18,2) COMMENT 'Estimated cost to replace the asset with a similar new one.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer.',
    `tax_accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recorded for tax purposes.',
    `tax_depreciation_rate` DECIMAL(18,2) COMMENT 'Depreciation rate applied for tax reporting purposes, expressed as a percentage.',
    `tax_net_book_value` DECIMAL(18,2) COMMENT 'Assets tax book value after tax depreciation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the asset record.',
    `useful_life_years` STRING COMMENT 'Estimated number of years the asset will generate economic benefits.',
    `warranty_end_date` DATE COMMENT 'Date when the asset warranty expires.',
    `warranty_provider` STRING COMMENT 'Entity that provides the warranty coverage.',
    `warranty_start_date` DATE COMMENT 'Date when the asset warranty becomes effective.',
    CONSTRAINT pk_fixed_asset PRIMARY KEY(`fixed_asset_id`)
) COMMENT 'Fixed asset register and complete transaction history serving as the lifecycle record for all capitalized assets of the manufacturing enterprise including production machinery, CNC equipment, robotics, automation systems, buildings, vehicles, tooling, and IT infrastructure. Master data captures asset number, asset class, description, serial number, acquisition date and value, useful life, depreciation method/key, salvage value, location/plant assignment, and cost center assignment. Transaction history captures all asset movements: acquisitions, retirements, transfers, revaluations, impairments, and periodic depreciation postings with transaction type, posting date, amount, document reference, and depreciation area (book/tax/IFRS). Provides accumulated depreciation, net book value, replacement value, and insurance value. The SSOT for asset valuation, depreciation scheduling, capital base reporting, and insurance declarations.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`finance`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'System-generated unique identifier for the bank account record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: House bank accounts in SAP FI are always assigned to a specific company code (legal entity). This FK links bank accounts to the legal entity master, enabling entity-level cash position reporting, paym',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Bank account is linked to a GL account for cash management.',
    `pool_header_bank_account_id` BIGINT COMMENT 'Self-referencing FK on bank_account (pool_header_bank_account_id)',
    `account_label` STRING COMMENT 'Human‑readable name or label for the bank account used in reports and UI.',
    `account_number` STRING COMMENT 'Primary bank account number used for payments and cash management.',
    `account_type` STRING COMMENT 'Classification of the bank account (checking, savings, operating, cash‑pool, loan).. Valid values are `checking|savings|operating|cash_pool|loan`',
    `balance` DECIMAL(18,2) COMMENT 'Current monetary balance of the account as of the latest reconciliation.',
    `bank_account_status` STRING COMMENT 'Current lifecycle status of the bank account.. Valid values are `active|inactive|closed|suspended|pending`',
    `bank_address` STRING COMMENT 'Physical address of the bank branch.',
    `bank_branch` STRING COMMENT 'Specific branch of the bank where the account is held.',
    `bank_city` STRING COMMENT 'City where the bank branch is located.',
    `bank_contact_number` STRING COMMENT 'Telephone number for the bank branch.',
    `bank_country_code` STRING COMMENT 'Three‑letter country code where the bank is located.',
    `bank_name` STRING COMMENT 'Legal name of the banking institution holding the account.',
    `cash_pool_membership` STRING COMMENT 'Indicates if the account participates in a cash‑pool (primary, secondary, or none).. Valid values are `primary|secondary|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the account (e.g., USD, EUR).',
    `daily_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate amount that can be processed in a single day.',
    `effective_from` DATE COMMENT 'Date when the bank account becomes active for posting.',
    `effective_to` DATE COMMENT 'Date when the bank account is no longer active (nullable for open‑ended).',
    `iban` STRING COMMENT 'Standardized international account identifier for cross‑border transactions.',
    `internal_reference` STRING COMMENT 'Free‑form field for internal notes or reference codes.',
    `last_reconciliation_date` DATE COMMENT 'Date of the most recent bank statement reconciliation.',
    `payment_method_eligibility` STRING COMMENT 'Supported payment methods for this account (e.g., wire, ACH).. Valid values are `wire|ach|rtgs|swift`',
    `swift_bic` STRING COMMENT 'Bank Identifier Code used for international wire transfers.',
    `treasury_region` STRING COMMENT 'Geographic region of the treasury unit responsible for the account.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the bank account record.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Master record for all house bank accounts used by the manufacturing enterprise for payment processing, cash pooling, and liquidity management. Captures bank key, account number, IBAN, SWIFT/BIC, bank name, country, currency, GL account assignment, payment method eligibility, daily transaction limits, and cash pool membership. Serves as the SSOT for treasury operations and bank statement reconciliation in SAP FI.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`finance`.`business_partner` (
    `business_partner_id` BIGINT COMMENT 'Primary key for business_partner',
    `parent_business_partner_id` BIGINT COMMENT 'Self-referencing FK on business_partner (parent_business_partner_id)',
    `parent_partner_business_partner_id` BIGINT COMMENT 'Identifier of the parent organization if the partner is part of a corporate hierarchy.',
    `address_line1` STRING COMMENT 'First line of the business partners primary address.',
    `address_line2` STRING COMMENT 'Second line of the business partners primary address.',
    `business_partner_name` STRING COMMENT 'Full legal name of the business partner (individual or organization).',
    `business_partner_status` STRING COMMENT 'Current lifecycle status of the partner record.',
    `city` STRING COMMENT 'City of the business partners primary address.',
    `classification_code` STRING COMMENT 'Internal code used to segment partners for reporting and risk analysis.',
    `compliance_status` STRING COMMENT 'Current compliance status with internal and regulatory requirements.',
    `contact_person_email` STRING COMMENT 'Email address of the primary contact person.',
    `contact_person_name` STRING COMMENT 'Name of the primary contact person for the partner.',
    `contact_person_phone` STRING COMMENT 'Phone number of the primary contact person.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the business partners primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the partner record was first created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount extended to the partner.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code used for transactions with the partner.',
    `data_classification` STRING COMMENT 'Classification level of the partner data as per corporate policy.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the partner.',
    `effective_from` DATE COMMENT 'Date when the partner relationship becomes effective.',
    `effective_until` DATE COMMENT 'Date when the partner relationship ends or is scheduled to end; null if open-ended.',
    `external_reference_code` STRING COMMENT 'External system reference code for the partner.',
    `industry_code` STRING COMMENT 'Standard industry classification code (e.g., NAICS) for the partner.',
    `is_exporter` BOOLEAN COMMENT 'True if the partner is designated as an exporter.',
    `is_importer` BOOLEAN COMMENT 'True if the partner is designated as an importer for customs purposes.',
    `last_review_date` DATE COMMENT 'Date when the partner record was last reviewed for accuracy.',
    `notes` STRING COMMENT 'Free-text field for additional remarks or comments about the partner.',
    `partner_type` STRING COMMENT 'Classification of the partner (e.g., vendor, customer, internal entity).',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the partner.',
    `postal_code` STRING COMMENT 'Postal code of the business partners primary address.',
    `primary_contact_email` STRING COMMENT 'Primary email address for business partner communications.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the business partner.',
    `registration_number` STRING COMMENT 'Official registration number of the organization (e.g., company registration).',
    `risk_rating` STRING COMMENT 'Risk assessment rating for the partner.',
    `short_name` STRING COMMENT 'Abbreviated or commonly used name for the business partner.',
    `source_system` STRING COMMENT 'Originating source system for the partner record (e.g., SAP, external CRM).',
    `state_province` STRING COMMENT 'State or province of the business partners primary address.',
    `swift_code` STRING COMMENT 'SWIFT/BIC code for international transfers to the partners bank.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the partner is tax-exempt (true) or not (false).',
    `tax_id_number` STRING COMMENT 'Government-issued tax identifier for the partner (e.g., EIN, VAT).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the partner record.',
    `vat_number` STRING COMMENT 'Value Added Tax registration number, if applicable.',
    `website_url` STRING COMMENT 'Public website URL of the business partner.',
    CONSTRAINT pk_business_partner PRIMARY KEY(`business_partner_id`)
) COMMENT 'Master reference table for business_partner. Referenced by business_partner_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ADD CONSTRAINT `fk_finance_procurement_contract_commodity_category_id` FOREIGN KEY (`commodity_category_id`) REFERENCES `manufacturing_ecm`.`finance`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ADD CONSTRAINT `fk_finance_procurement_contract_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ADD CONSTRAINT `fk_finance_supplier_invoice_commodity_category_id` FOREIGN KEY (`commodity_category_id`) REFERENCES `manufacturing_ecm`.`finance`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ADD CONSTRAINT `fk_finance_supplier_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ADD CONSTRAINT `fk_finance_supplier_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ADD CONSTRAINT `fk_finance_supplier_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ADD CONSTRAINT `fk_finance_supplier_invoice_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `manufacturing_ecm`.`finance`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ADD CONSTRAINT `fk_finance_commodity_category_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ADD CONSTRAINT `fk_finance_commodity_category_parent_category_commodity_category_id` FOREIGN KEY (`parent_category_commodity_category_id`) REFERENCES `manufacturing_ecm`.`finance`.`commodity_category`(`commodity_category_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ADD CONSTRAINT `fk_finance_cost_center_parent_cost_center_id` FOREIGN KEY (`parent_cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ADD CONSTRAINT `fk_finance_profit_center_parent_profit_center_id` FOREIGN KEY (`parent_profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ADD CONSTRAINT `fk_finance_gl_account_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_business_partner_id` FOREIGN KEY (`business_partner_id`) REFERENCES `manufacturing_ecm`.`finance`.`business_partner`(`business_partner_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ADD CONSTRAINT `fk_finance_company_code_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_ap_invoice_id` FOREIGN KEY (`ap_invoice_id`) REFERENCES `manufacturing_ecm`.`finance`.`ap_invoice`(`ap_invoice_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_ar_item_id` FOREIGN KEY (`ar_item_id`) REFERENCES `manufacturing_ecm`.`finance`.`ar_item`(`ar_item_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_fixed_asset_id` FOREIGN KEY (`fixed_asset_id`) REFERENCES `manufacturing_ecm`.`finance`.`fixed_asset`(`fixed_asset_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ADD CONSTRAINT `fk_finance_journal_entry_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ADD CONSTRAINT `fk_finance_budget_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `manufacturing_ecm`.`finance`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ADD CONSTRAINT `fk_finance_ap_invoice_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ADD CONSTRAINT `fk_finance_ar_item_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`cost_center`(`cost_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ADD CONSTRAINT `fk_finance_fixed_asset_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `manufacturing_ecm`.`finance`.`profit_center`(`profit_center_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_company_code_id` FOREIGN KEY (`company_code_id`) REFERENCES `manufacturing_ecm`.`finance`.`company_code`(`company_code_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_gl_account_id` FOREIGN KEY (`gl_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`gl_account`(`gl_account_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ADD CONSTRAINT `fk_finance_bank_account_pool_header_bank_account_id` FOREIGN KEY (`pool_header_bank_account_id`) REFERENCES `manufacturing_ecm`.`finance`.`bank_account`(`bank_account_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ADD CONSTRAINT `fk_finance_business_partner_parent_business_partner_id` FOREIGN KEY (`parent_business_partner_id`) REFERENCES `manufacturing_ecm`.`finance`.`business_partner`(`business_partner_id`);
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ADD CONSTRAINT `fk_finance_business_partner_parent_partner_business_partner_id` FOREIGN KEY (`parent_partner_business_partner_id`) REFERENCES `manufacturing_ecm`.`finance`.`business_partner`(`business_partner_id`);

-- ========= TAGS =========
ALTER SCHEMA `manufacturing_ecm`.`finance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `manufacturing_ecm`.`finance` SET TAGS ('dbx_domain' = 'finance');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` SET TAGS ('dbx_subdomain' = 'procurement_payables');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `commodity_category_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product Family Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|waived');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'blanket_po|scheduling_agreement|value_contract|quantity_contract|framework_agreement|master_agreement');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `price_deescalation_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Price De-escalation Mechanism');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `price_deescalation_mechanism` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `price_escalation_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Mechanism');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `price_escalation_mechanism` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `quality_requirements` SET TAGS ('dbx_business_glossary_term' = 'Quality Requirements');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Release Quantity');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `release_value` SET TAGS ('dbx_business_glossary_term' = 'Release Value');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `release_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `remaining_value` SET TAGS ('dbx_business_glossary_term' = 'Remaining Value');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `remaining_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `sla_terms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Terms');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`procurement_contract` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` SET TAGS ('dbx_subdomain' = 'procurement_payables');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `commodity_category_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `plant_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|down_payment|final');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `payment_block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Indicator');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|electronic_payment|letter_of_credit');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partially_paid|fully_paid|overdue|on_hold');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Reference');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|not_matched|partially_matched|override');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `tolerance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Check Status');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `tolerance_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_checked');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `tolerance_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Variance Amount');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `tolerance_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Variance Percentage');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `manufacturing_ecm`.`finance`.`supplier_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` SET TAGS ('dbx_subdomain' = 'procurement_payables');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `commodity_category_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Identifier');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `parent_category_commodity_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Category ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Hierarchy Level');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `category_level` SET TAGS ('dbx_value_regex' = 'L1|L2|L3|L4|L5');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `category_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Category Manager Name');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `category_status` SET TAGS ('dbx_business_glossary_term' = 'Category Status');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `category_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|deprecated');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `compliance_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Flag');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `contract_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Coverage Flag');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `cost_reduction_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Cost Reduction Target Percentage');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `lead_time_days_avg` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time (Days)');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `moq_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Applicable Flag');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `negotiation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Frequency');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `negotiation_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|ad_hoc');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `preferred_supplier_count` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Count');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `price_volatility_index` SET TAGS ('dbx_business_glossary_term' = 'Price Volatility Index');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `price_volatility_index` SET TAGS ('dbx_value_regex' = 'high|medium|low|stable');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `quality_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Requirements');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Classification');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'high_risk|medium_risk|low_risk');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Strategy');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_value_regex' = 'single_source|dual_source|multi_source|global_sourcing|local_sourcing');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `spend_type` SET TAGS ('dbx_business_glossary_term' = 'Spend Type Classification');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `spend_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|MRO|CapEx|services');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `strategic_sourcing_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Sourcing Priority');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `strategic_sourcing_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `unspsc_class` SET TAGS ('dbx_business_glossary_term' = 'UNSPSC Class Name');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_business_glossary_term' = 'United Nations Standard Products and Services Code (UNSPSC)');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `unspsc_commodity` SET TAGS ('dbx_business_glossary_term' = 'UNSPSC Commodity Name');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `unspsc_family` SET TAGS ('dbx_business_glossary_term' = 'UNSPSC Family Name');
ALTER TABLE `manufacturing_ecm`.`finance`.`commodity_category` ALTER COLUMN `unspsc_segment` SET TAGS ('dbx_business_glossary_term' = 'UNSPSC Segment Name');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` SET TAGS ('dbx_subdomain' = 'ledger_controlling');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `parent_cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Cost Center ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (AC)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Allocation Basis (AB)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `allocation_basis` SET TAGS ('dbx_value_regex' = 'direct|percentage|activity_based');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (BA)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code (CA)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (CC)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description (CCD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group (CCG)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name (CCN)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status (CCS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type (CCT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_value_regex' = 'production|administration|research_and_development|sales|support');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (EXT_REF)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level (HL)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path (HP)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `is_overhead` SET TAGS ('dbx_business_glossary_term' = 'Is Overhead Cost Center Flag');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Location Code (LOC)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department (OD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount (VA)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date (Valid From)');
ALTER TABLE `manufacturing_ecm`.`finance`.`cost_center` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date (Valid To)');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` SET TAGS ('dbx_subdomain' = 'ledger_controlling');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Cost Center ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `parent_profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Profit Center ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `actual_profit` SET TAGS ('dbx_business_glossary_term' = 'Actual Profit');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `financial_reporting_line` SET TAGS ('dbx_business_glossary_term' = 'Financial Reporting Line');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `financial_reporting_line` SET TAGS ('dbx_value_regex' = 'segment|division|business_unit');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Level');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `is_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Reportable Flag');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `oee_target_percent` SET TAGS ('dbx_business_glossary_term' = 'OEE Target Percent');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Owner');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `planned_profit` SET TAGS ('dbx_business_glossary_term' = 'Planned Profit');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_description` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Description');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_group` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Group');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'internal|external|joint_venture');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'NA|EMEA|APAC');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `reporting_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Segment');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `segment` SET TAGS ('dbx_value_regex' = 'Manufacturing|Services|R&D|Support');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Updated Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Valid From Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Valid To Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`profit_center` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` SET TAGS ('dbx_subdomain' = 'ledger_controlling');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account ID (GL_ACCOUNT_ID)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `account_category` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Category (GL_ACCOUNT_CATEGORY)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `account_category` SET TAGS ('dbx_value_regex' = 'operating|non_operating|tax|intercompany|regulatory');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Group (GL_ACCOUNT_GROUP)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `account_long_description` SET TAGS ('dbx_business_glossary_term' = 'Account Long Description (ACCOUNT_LONG_DESCRIPTION)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Name (GL_ACCOUNT_NAME)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Number (GL_ACCOUNT_NUMBER)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Type (GL_ACCOUNT_TYPE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'balance_sheet|profit_and_loss|equity|asset|liability');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `balance_type` SET TAGS ('dbx_business_glossary_term' = 'Balance Type (BALANCE_TYPE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `balance_type` SET TAGS ('dbx_value_regex' = 'debit|credit');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group (CONSOLIDATION_GROUP)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category (COST_ELEMENT_CATEGORY)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|none');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURRENCY_CODE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance (CURRENT_BALANCE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Code (EXTERNAL_SYSTEM_CODE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area (FUNCTIONAL_AREA)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_description` SET TAGS ('dbx_business_glossary_term' = 'GL Account Description (GL_ACCOUNT_DESCRIPTION)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_business_glossary_term' = 'GL Account Status (STATUS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `gl_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending|closed');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_bank_account` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Indicator (IS_BANK_ACCOUNT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_bank_account` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_bank_account` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_budget_enabled` SET TAGS ('dbx_business_glossary_term' = 'Budget Enabled Indicator (IS_BUDGET_ENABLED)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_cash_account` SET TAGS ('dbx_business_glossary_term' = 'Cash Account Indicator (IS_CASH_ACCOUNT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_deprecated` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Indicator (IS_DEPRECATED)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_expense_account` SET TAGS ('dbx_business_glossary_term' = 'Expense Account Indicator (IS_EXPENSE_ACCOUNT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_fixed_asset_account` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Account Indicator (IS_FIXED_ASSET_ACCOUNT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_forecast_enabled` SET TAGS ('dbx_business_glossary_term' = 'Forecast Enabled Indicator (IS_FORECAST_ENABLED)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_income_account` SET TAGS ('dbx_business_glossary_term' = 'Income Account Indicator (IS_INCOME_ACCOUNT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_intercompany` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Indicator (IS_INTERCOMPANY)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_inventory_account` SET TAGS ('dbx_business_glossary_term' = 'Inventory Account Indicator (IS_INVENTORY_ACCOUNT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_purchase_account` SET TAGS ('dbx_business_glossary_term' = 'Purchase Account Indicator (IS_PURCHASE_ACCOUNT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_reconciliation_account` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Indicator (IS_RECONCILIATION_ACCOUNT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_sales_account` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Indicator (IS_SALES_ACCOUNT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `is_tax_relevant` SET TAGS ('dbx_business_glossary_term' = 'Tax Relevance Indicator (IS_TAX_RELEVANT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance (OPENING_BALANCE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency (REPORTING_CURRENCY)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment (SEGMENT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date (VALID_FROM)');
ALTER TABLE `manufacturing_ecm`.`finance`.`gl_account` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date (VALID_TO)');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` SET TAGS ('dbx_subdomain' = 'ledger_controlling');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Surrogate ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `annual_revenue_local_currency` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue (Local Currency)');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `chart_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts Key');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code (Legal Entity Code)');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_name` SET TAGS ('dbx_business_glossary_term' = 'Company Legal Name');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_business_glossary_term' = 'Company Code Status');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `company_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Group');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `controlling_area` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `elimination_scope` SET TAGS ('dbx_business_glossary_term' = 'Elimination Scope');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `headquarter_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarter Address Line 1');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `headquarter_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `headquarter_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `headquarter_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarter City');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `headquarter_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `headquarter_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `headquarter_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarter Postal Code');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `headquarter_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `headquarter_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `headquarter_state` SET TAGS ('dbx_business_glossary_term' = 'Headquarter State/Province');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `headquarter_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `headquarter_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `industry_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Code');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `is_consolidated` SET TAGS ('dbx_business_glossary_term' = 'Is Consolidated Flag');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `legal_form` SET TAGS ('dbx_business_glossary_term' = 'Legal Form');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `number_of_employees` SET TAGS ('dbx_business_glossary_term' = 'Number of Employees');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `public_company_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Company Flag');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`company_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` SET TAGS ('dbx_subdomain' = 'ledger_controlling');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `ar_item_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Item Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Work Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_header_text` SET TAGS ('dbx_business_glossary_term' = 'Document Header Text');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'invoice|credit_note|payment|adjustment|reversal|accrual');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `fiscal_year_variant` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Variant');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `gaap_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'GAAP Compliance Flag');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `ifrs_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS Compliance Flag');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `is_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Flag');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_key` SET TAGS ('dbx_business_glossary_term' = 'Posting Key');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_period` SET TAGS ('dbx_business_glossary_term' = 'Posting Period');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|error');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_text` SET TAGS ('dbx_business_glossary_term' = 'Posting Text');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `posting_time` SET TAGS ('dbx_business_glossary_term' = 'Posting Time');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `reference_document` SET TAGS ('dbx_business_glossary_term' = 'Reference Document');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Business Segment');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_amount_total` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `total_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Debit Amount');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `transaction_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Amount');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`journal_entry` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` SET TAGS ('dbx_subdomain' = 'ledger_controlling');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_business_glossary_term' = 'Budget Category (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `budget_category` SET TAGS ('dbx_value_regex' = 'CapEx|OpEx|Headcount|Materials|Other');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'original|revised|supplemental');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `cost_element` SET TAGS ('dbx_business_glossary_term' = 'Cost Element (CE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `finance_budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `finance_budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|closed');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `forecast_method` SET TAGS ('dbx_business_glossary_term' = 'Forecast Method (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `forecast_method` SET TAGS ('dbx_value_regex' = 'historical|statistical|managerial|none');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `is_capex` SET TAGS ('dbx_business_glossary_term' = 'Is CapEx Flag (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `is_opex` SET TAGS ('dbx_business_glossary_term' = 'Is OpEx Flag (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `period` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4|Annual');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (AUD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (AUD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `total_committed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Amount (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `total_committed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `total_committed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `total_planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Amount (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `total_planned_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `total_planned_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `total_revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Revised Amount (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `total_revised_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `total_revised_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `variance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percent (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `version_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Timestamp (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`budget` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (BGT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` SET TAGS ('dbx_subdomain' = 'procurement_payables');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Invoice ID (AP_INVOICE_ID)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID (VENDOR_ID)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `approval_user` SET TAGS ('dbx_business_glossary_term' = 'Approval User (APPROVER)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `bank_statement_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Reconciliation Status (BANK_RECON_STATUS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `bank_statement_reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|unreconciled|partial');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date (BASELINE_DATE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `cash_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Percentage (DISC_PCT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number (CL_DOC_NO)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `discount_taken` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken (DISC_TAKEN)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Document Number (DOC_NO)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date (DUE_DATE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount (GROSS_AMT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date (INV_DATE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type (INV_TYPE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount (NET_AMT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount (PAY_AMT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason (PAY_BLOCK_RSN)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date (PAY_DATE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire|check|direct_debit');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference (PAY_REF)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PAY_STATUS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'scheduled|paid|failed|cancelled');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_TERMS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `payment_value_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Value Date (PAY_VAL_DATE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date (POST_DATE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (CREATED_TS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (UPDATED_TS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag (TAX_EXEMPT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (TAX_RATE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three‑Way Match Status (3WM_STATUS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partial');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount (WH_TAX_AMT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ap_invoice` ALTER COLUMN `withholding_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Code (WH_TAX_CODE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` SET TAGS ('dbx_subdomain' = 'asset_receivables');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `ar_item_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Item ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CUST_ID)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `sla_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Agreement Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket (AGE_BUCKET)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = '0-30|31-60|61-90|90+');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `aging_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Days (AGE_DAYS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area (BUS_AREA)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `cleared_flag` SET TAGS ('dbx_business_glossary_term' = 'Cleared Flag (CLRD_FLG)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number (CL_DOC_NO)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status (COLL_STATUS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|resolved');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `credit_memo_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Amount (CR_MEMO_AMT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `credit_memo_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Flag (CR_MEMO_FLG)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISC_AMT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status (DISP_STATUS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'none|open|resolved');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Document Number (AR_DOC_NO)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date (DUE_DATE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level (DUN_LEVEL)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `dunning_level` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate (EXCH_RATE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Amount (INV_AMT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description (INV_DESC)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount (LAST_PAY_AMT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `last_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Method (LAST_PAY_METHOD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `last_payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|credit_card|check|cash');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount (LC_AMT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (NET_AMT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `open_amount` SET TAGS ('dbx_business_glossary_term' = 'Open Amount (OPEN_AMT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `original_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Amount (ORIG_AMT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date (PAY_DATE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|credit_card|check|cash');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference (PAY_REF)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_TERM)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date (POST_DATE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (REC_STATUS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'open|cleared|written_off|cancelled');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `segment` SET TAGS ('dbx_business_glossary_term' = 'Segment (SEGMENT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate (TAX_RATE)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Amount (WO_AMT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`ar_item` ALTER COLUMN `write_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Flag (WO_FLG)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` SET TAGS ('dbx_subdomain' = 'asset_receivables');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Identifier (FA_ID)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation (AD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost (AC)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date (AD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class (AC)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'Machinery|Vehicle|Building|IT_Equipment|Tooling');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Description (AD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name (AN)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number (AN)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_origin` SET TAGS ('dbx_business_glossary_term' = 'Asset Origin (AO)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `asset_origin` SET TAGS ('dbx_value_regex' = 'purchased|leased|internally_built');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `capitalized_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalized Flag (CF)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating (CR)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `department_responsible` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department (RD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method (DM)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date (DSD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status (AS)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `fixed_asset_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|maintenance|disposed');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount (ICA)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date (IED)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number (IPN)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `insurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Insurance Provider (IP)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date (LMD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Contract Number (LCN)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_end_date` SET TAGS ('dbx_business_glossary_term' = 'Lease End Date (LED)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `lease_provider` SET TAGS ('dbx_business_glossary_term' = 'Lease Provider (LP)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `maintenance_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Number (MCN)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `maintenance_provider` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Provider (MP)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer (MFR)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number (MN)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Date (NMD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PC)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `replacement_cost` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cost (RC)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value (SV)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (SN)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Tax Accumulated Depreciation (TAD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_depreciation_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Depreciation Rate (TDR)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `tax_net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Tax Net Book Value (TNBV)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years) (UL)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_end_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty End Date (WED)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_provider` SET TAGS ('dbx_business_glossary_term' = 'Warranty Provider (WP)');
ALTER TABLE `manufacturing_ecm`.`finance`.`fixed_asset` ALTER COLUMN `warranty_start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date (WSD)');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` SET TAGS ('dbx_subdomain' = 'asset_receivables');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `pool_header_bank_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `pool_header_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `pool_header_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `account_label` SET TAGS ('dbx_business_glossary_term' = 'Account Label');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number (ACCOUNT_NUMBER)');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'checking|savings|operating|cash_pool|loan');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `balance` SET TAGS ('dbx_business_glossary_term' = 'Current Account Balance');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|suspended|pending');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_account_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address` SET TAGS ('dbx_business_glossary_term' = 'Bank Address');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_branch` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_city` SET TAGS ('dbx_business_glossary_term' = 'Bank City');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Contact Phone Number');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_contact_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `cash_pool_membership` SET TAGS ('dbx_business_glossary_term' = 'Cash Pool Membership');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `cash_pool_membership` SET TAGS ('dbx_value_regex' = 'primary|secondary|none');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `effective_to` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `internal_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Reference');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `payment_method_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Eligibility');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `payment_method_eligibility` SET TAGS ('dbx_value_regex' = 'wire|ach|rtgs|swift');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic` SET TAGS ('dbx_business_glossary_term' = 'SWIFT BIC Code');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `swift_bic` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `treasury_region` SET TAGS ('dbx_business_glossary_term' = 'Treasury Region');
ALTER TABLE `manufacturing_ecm`.`finance`.`bank_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` SET TAGS ('dbx_subdomain' = 'procurement_payables');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Identifier');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `parent_business_partner_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `business_partner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `business_partner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `vat_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`finance`.`business_partner` ALTER COLUMN `vat_number` SET TAGS ('dbx_pii_identifier' = 'true');
