-- Schema for Domain: masterdata | Business: Pharmaceuticals | Version: v1_mvm
-- Generated on: 2026-05-05 21:10:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`masterdata` COMMENT 'Governs enterprise master data including organization hierarchy, chart of accounts, vendor master, material master, geographic reference data, units of measure, and code sets (ATC, NDC). Serves as the cross-domain reference layer ensuring consistent identifiers across SAP S/4HANA, Veeva, LIMS, and other operational systems. Supports MDM governance, data stewardship, and data quality management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the legal entity record. Primary key for the legal entity master data product.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: legal_entity.jurisdiction_of_incorporation is a free-text STRING representing the country/jurisdiction where the entity is incorporated. The masterdata.country table is the authoritative reference for',
    `parent_entity_legal_entity_id` BIGINT COMMENT 'Reference to the parent legal entity in the organizational hierarchy. Null for top-level holding companies. Used to construct the legal entity hierarchy for consolidation and reporting.',
    `primary_ultimate_parent_entity_legal_entity_id` BIGINT COMMENT 'Reference to the ultimate parent legal entity at the top of the organizational hierarchy. Used for global consolidation and group-level reporting.',
    `address_id` BIGINT COMMENT 'Foreign key linking to masterdata.address. Business justification: legal_entity carries six inline registered address columns (registered_address_line1, registered_address_line2, registered_city, registered_state_province, registered_postal_code, registered_country) ',
    `consolidation_group` STRING COMMENT 'The consolidation group or reporting unit to which this legal entity belongs for financial consolidation purposes. Used to aggregate financial results across multiple legal entities.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A calculated score representing the completeness and accuracy of this legal entity master data record, typically ranging from 0.00 to 100.00. Used for data quality monitoring and improvement initiatives.',
    `data_steward_name` STRING COMMENT 'The name of the individual or role responsible for maintaining the accuracy and completeness of this legal entity master data record. Part of the MDM governance framework.',
    `dissolution_date` DATE COMMENT 'The date on which the legal entity was officially dissolved or terminated. Null for active entities.',
    `duns_number` STRING COMMENT 'The 9-digit DUNS number assigned by Dun & Bradstreet for global business identification and credit reporting.. Valid values are `^[0-9]{9}$`',
    `ema_organization_code` STRING COMMENT 'The organization identifier assigned by the European Medicines Agency for entities involved in pharmaceutical activities in the European Union. Used in regulatory submissions and correspondence.',
    `entity_status` STRING COMMENT 'The current operational and legal status of the entity. Active entities are currently operating, inactive entities are dormant but legally registered, dissolved entities have been legally terminated, merged entities have been combined with another entity, acquired entities have been purchased by another organization, and pending formation entities are in the process of incorporation.. Valid values are `active|inactive|dissolved|merged|acquired|pending_formation`',
    `entity_type` STRING COMMENT 'Classification of the legal entity based on its operational and ownership structure. Operating companies conduct business operations, holding companies own other entities, joint ventures are shared ownership arrangements, subsidiaries are majority-owned entities, branches are extensions of parent entities, and partnerships are shared ownership structures.. Valid values are `operating_company|holding_company|joint_venture|subsidiary|branch|partnership`',
    `fda_establishment_identifier` STRING COMMENT 'The FDA Establishment Identifier assigned to facilities that manufacture, repack, relabel, or salvage drugs, biologics, or devices for commercial distribution in the United States. Required for regulatory submissions and inspections.',
    `fiscal_year_end_month` STRING COMMENT 'The month in which the legal entitys fiscal year ends, represented as an integer from 1 (January) to 12 (December). Used for financial reporting and tax purposes.',
    `functional_currency` STRING COMMENT 'The primary currency in which the legal entity conducts its business and maintains its books of account, represented as a 3-letter ISO currency code.. Valid values are `^[A-Z]{3}$`',
    `gmp_certification_status` STRING COMMENT 'The current status of GMP certification for this legal entity. GMP certification is required for pharmaceutical manufacturing facilities and demonstrates compliance with quality standards.. Valid values are `certified|pending|expired|not_applicable|suspended`',
    `incorporation_date` DATE COMMENT 'The date on which the legal entity was officially incorporated or registered in its jurisdiction.',
    `industry_classification_code` STRING COMMENT 'The standard industry classification code for the legal entitys primary business activity. May use NAICS, SIC, or ISIC classification systems.',
    `iso_certification_status` STRING COMMENT 'The current ISO quality management system certifications held by this legal entity (e.g., ISO 9001, ISO 13485). Multiple certifications may be listed.',
    `legal_form` STRING COMMENT 'The legal form or structure of the entity as defined by the jurisdiction of incorporation (e.g., Corporation, Limited Liability Company, Public Limited Company, Private Limited Company, Partnership). Uses ISO 20275 Entity Legal Forms codes where applicable.',
    `legal_name` STRING COMMENT 'The official registered legal name of the entity as recorded in the jurisdiction of incorporation. This is the name that appears on all regulatory filings, contracts, and official documents.',
    `lei_code` STRING COMMENT 'The 20-character ISO 17442 Legal Entity Identifier code used for global entity identification in financial transactions and regulatory reporting.. Valid values are `^[A-Z0-9]{20}$`',
    `primary_business_activity` STRING COMMENT 'Description of the primary business activity or operations conducted by this legal entity (e.g., pharmaceutical manufacturing, research and development, distribution, holding company).',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this legal entity master data record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this legal entity master data record was last modified.',
    `registration_number` STRING COMMENT 'The official registration or incorporation number assigned by the jurisdiction of incorporation. This may be a company registration number, certificate of incorporation number, or equivalent identifier.',
    `reporting_currency` STRING COMMENT 'The currency used for external financial reporting and consolidation, represented as a 3-letter ISO currency code. May differ from functional currency for subsidiaries.. Valid values are `^[A-Z]{3}$`',
    `sap_company_code` STRING COMMENT 'The 4-character SAP S/4HANA company code assigned to this legal entity. Company codes are the smallest organizational unit for which a complete self-contained set of accounts can be drawn up for external reporting purposes.. Valid values are `^[A-Z0-9]{4}$`',
    `short_name` STRING COMMENT 'Abbreviated or commonly used name for the legal entity used in internal systems and reporting.',
    `stock_exchange_listing` STRING COMMENT 'The stock exchange(s) on which the legal entitys securities are listed, if publicly traded. Uses ISO 10383 Market Identifier Codes (MIC) where applicable.',
    `stock_ticker_symbol` STRING COMMENT 'The ticker symbol or trading symbol for the legal entitys publicly traded securities, if applicable.',
    `tax_identification_number` STRING COMMENT 'The primary tax identification number assigned by the tax authority in the jurisdiction of incorporation. In the US this is the Employer Identification Number (EIN), in other jurisdictions it may be a VAT number, corporate tax number, or equivalent.',
    `vat_registration_number` STRING COMMENT 'The VAT registration number assigned by the tax authority for entities registered for VAT purposes. Applicable primarily in jurisdictions with VAT systems.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master record for all legal entities within the pharmaceutical enterprise including subsidiaries, affiliates, joint ventures, and holding companies. Captures legal name, registration number, jurisdiction of incorporation, entity type (operating company, holding, JV), tax identification numbers, registered address, functional currency, consolidation group, and SAP company code mapping. Serves as the organizational backbone for financial consolidation, regulatory submissions, and cross-system entity resolution.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Primary key for org_unit',
    `address_id` BIGINT COMMENT 'Foreign key linking to masterdata.address. Business justification: org_unit carries five inline address columns (address_line_1, address_line_2, city, state_province, postal_code) that duplicate the masterdata.address master record. Adding org_unit_address_id FK to a',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Org units located in countries. New FK country_id → country.country_id. Existing country_code (STRING) remains for code-level reference.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Organizational units belong to legal entities. New FK legal_entity_id → legal_entity.legal_entity_id. Remove company_code as legal_entity.sap_company_code is authoritative.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the enterprise hierarchy. Enables hierarchical traversal and roll-up reporting across business units, divisions, departments, and teams. Null for top-level units.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.profit_center. Business justification: Org units roll up to profit centers for P&L reporting. New FK profit_center_id → profit_center.masterdata_profit_center_id. Remove profit_center_code as redundant.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual operating budget allocated to this organizational unit in the reporting currency. Used for financial planning, variance analysis, and resource allocation decisions.',
    `budget_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget amount. Used for multi-currency reporting and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `business_area_code` STRING COMMENT 'SAP S/4HANA Financial Accounting (FI) business area code for cross-company code reporting. Used for segment reporting and consolidated financial statements.. Valid values are `^[A-Z0-9]{4,10}$`',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA Controlling (CO) cost center code associated with this organizational unit. Used for financial planning, budgeting, and expense allocation. Aligns with SAP CO module cost center master data.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the master data system. Used for audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'Date when the organizational unit ceased or will cease operations. Null for currently active units. Used for historical reporting and organizational change tracking.',
    `effective_start_date` DATE COMMENT 'Date when the organizational unit became or will become operational. Used for time-based hierarchy queries and historical organizational structure analysis.',
    `email_address` STRING COMMENT 'Primary contact email address for the organizational unit. Used for official correspondence and system notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `functional_area` STRING COMMENT 'Broad functional classification of the organizational unit such as Research and Development, Manufacturing, Quality, Regulatory Affairs, Commercial, Medical Affairs, Supply Chain, Finance, Human Resources, or Information Technology. Supports cross-functional analysis and resource allocation.',
    `gcp_regulated_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit operates under GCP (Good Clinical Practice) regulations. True for clinical development, medical affairs, and pharmacovigilance units conducting or supporting clinical trials.',
    `geographic_region` STRING COMMENT 'Geographic region or market where this organizational unit operates (e.g., North America, Europe, Asia Pacific, Latin America). Used for regional performance analysis and market segmentation.',
    `glp_regulated_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit operates under GLP (Good Laboratory Practice) regulations. True for preclinical research and toxicology laboratories conducting non-clinical safety studies.',
    `gmp_regulated_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit operates under GMP (Good Manufacturing Practice) or cGMP (Current Good Manufacturing Practice) regulations. True for manufacturing, quality control, and quality assurance units handling drug substances or drug products.',
    `headcount_fte` DECIMAL(18,2) COMMENT 'Total full-time equivalent employee count allocated to this organizational unit. Used for workforce planning, budget allocation, and productivity analysis. Includes full-time, part-time, and contractor resources normalized to FTE.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last updated. Used for change tracking and data quality monitoring.',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit. Active units are operational and staffed. Inactive units are temporarily suspended. Pending units are approved but not yet operational. Dissolved units have been permanently closed.. Valid values are `active|inactive|pending|dissolved`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the organizational unit. Used for business communication and emergency contact.',
    `qms_scope_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit is within the scope of the enterprise Quality Management System (QMS). True for units subject to ISO 9001 certification and quality audits.',
    `sap_org_unit_code` STRING COMMENT 'Native SAP S/4HANA organizational unit identifier from the Organizational Management (OM) module. Used for bidirectional synchronization and cross-system reconciliation.',
    `site_location` STRING COMMENT 'Physical site or facility name where the organizational unit is primarily located. Used for facility management, space planning, and operational logistics.',
    `therapeutic_area` STRING COMMENT 'Primary therapeutic area focus for research, clinical, or commercial organizational units (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular, Neuroscience). Null for non-product-focused units.',
    `unit_code` STRING COMMENT 'Business-assigned unique code for the organizational unit. Used for cross-system integration and reporting. Typically aligned with SAP S/4HANA organizational element codes (cost center, profit center, business area).. Valid values are `^[A-Z0-9]{2,20}$`',
    `unit_level` STRING COMMENT 'Numeric level of the unit in the organizational hierarchy. Level 1 represents top-level enterprise units, with increasing numbers for deeper nesting. Supports hierarchy depth analysis and roll-up aggregation.',
    `unit_name` STRING COMMENT 'Full official name of the organizational unit as recognized in corporate documentation and reporting systems. Used for display in reports, dashboards, and organizational charts.',
    `unit_short_name` STRING COMMENT 'Abbreviated name or acronym for the organizational unit. Used in space-constrained displays and informal communication.',
    `unit_type` STRING COMMENT 'Classification of the organizational unit by its role in the enterprise structure. Determines reporting hierarchy level and management accountability scope. [ENUM-REF-CANDIDATE: business_unit|division|department|function|team|cost_center|profit_center — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Master record for organizational units within the enterprise hierarchy including business units, divisions, departments, and functional groups. Captures unit name, unit type (business unit, division, department, function, team), parent unit reference for hierarchy traversal, effective dates, responsible manager, geographic location, headcount, and SAP organizational element mapping. Supports HR organizational structure, operational reporting hierarchies, and management accountability across SAP S/4HANA, Veeva, and LIMS.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` (
    `cost_center_id` BIGINT COMMENT 'Primary key for cost_center',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Cost centers belong to legal entities (SAP company codes). New FK legal_entity_id → legal_entity.legal_entity_id. Remove company_code as legal_entity.sap_company_code is authoritative.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Cost centers belong to organizational units. New FK org_unit_id → org_unit.masterdata_org_unit_id. Remove department_code as org_unit.unit_code provides authoritative reference.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Cost centers in pharmaceutical manufacturing are typically plant-specific (e.g., Plant 123 - QC Lab, Plant 456 - Packaging Line 2). The existing location_code STRING attribute should be normaliz',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.profit_center. Business justification: Cost centers roll up to profit centers for internal P&L reporting. New FK profit_center_id → profit_center.masterdata_profit_center_id. Remove profit_center_code as redundant.',
    `activity_type_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this cost center performs activity-based costing and maintains activity types for internal cost allocation.',
    `budget_profile` STRING COMMENT 'Budget control profile defining budget availability checking rules, tolerance limits, and budget management parameters for this cost center.',
    `business_area_code` STRING COMMENT 'Business area assignment for cross-company code reporting and segment analysis, enabling consolidated financial statements by business segment.',
    `controlling_area_code` STRING COMMENT 'The controlling area to which this cost center is assigned. Controlling area is the highest organizational unit in management accounting, representing a closed system for cost accounting purposes.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_allocation_method` STRING COMMENT 'The method used for allocating costs from this cost center to other cost objects (e.g., direct allocation, activity-based costing, assessment, distribution). Supports COGS calculation and transfer pricing.',
    `cost_center_category` STRING COMMENT 'Classification of the cost center by functional area. Production includes manufacturing and API production; R&D includes drug discovery, preclinical, and clinical development; Quality Control includes QC labs and QA functions; Regulatory Affairs includes submission and compliance activities.. Valid values are `production|administration|research_and_development|sales_and_marketing|quality_control|regulatory_affairs`',
    `cost_center_code` STRING COMMENT 'The unique alphanumeric business identifier for the cost center used across SAP S/4HANA and financial reporting systems. This is the externally-known code used in general ledger postings, budget allocations, and management accounting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `cost_center_description` STRING COMMENT 'Extended textual description of the cost centers purpose, scope, and responsibilities within the organization.',
    `cost_center_name` STRING COMMENT 'The full descriptive name of the cost center, providing human-readable identification for reporting and analysis.',
    `cost_center_status` STRING COMMENT 'Current lifecycle status of the cost center. Active cost centers accept postings; Inactive cost centers are closed; Blocked cost centers exist but cannot receive new postings; Planned cost centers are defined for future use.. Valid values are `active|inactive|blocked|planned`',
    `cost_center_type` STRING COMMENT 'Granular classification of the cost center type within its category, enabling detailed cost analysis and allocation logic.',
    `created_by_user` STRING COMMENT 'User ID of the person who created this cost center master record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this cost center master record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which cost center transactions are recorded and reported.. Valid values are `^[A-Z]{3}$`',
    `functional_area_code` STRING COMMENT 'Functional area classification for cost-of-sales accounting and external financial reporting per IFRS/GAAP requirements. Typical values include manufacturing, R&D, sales, administration.',
    `gmp_classification` STRING COMMENT 'Classification indicating whether the cost center operates under GMP regulations. GMP-critical cost centers (e.g., API production, sterile manufacturing) require enhanced documentation and validation; GMP-non-critical support GMP operations; Non-GMP cost centers operate outside GMP scope.. Valid values are `gmp_critical|gmp_non_critical|non_gmp`',
    `hierarchy_area` STRING COMMENT 'Standard hierarchy assignment for cost center grouping and roll-up reporting in management accounting.',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified this cost center master record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this cost center master record was last modified.',
    `lock_indicator` STRING COMMENT 'Indicates which types of postings are locked for this cost center. Unlocked allows all postings; Locked_actual prevents actual cost postings; Locked_plan prevents planning postings; Locked_all prevents all postings.. Valid values are `unlocked|locked_actual|locked_plan|locked_all`',
    `mdm_golden_record_flag` BOOLEAN COMMENT 'Indicates whether this record is the authoritative golden record in the MDM system, used for master data governance and data quality management.',
    `planning_group` STRING COMMENT 'Planning group assignment for cost center planning and budgeting cycles, enabling coordinated planning across related cost centers.',
    `source_system_code` STRING COMMENT 'Identifier of the source operational system from which this cost center master record originated, supporting multi-system MDM governance.',
    `sox_relevant_flag` BOOLEAN COMMENT 'Indicates whether this cost center is subject to SOX financial controls and audit requirements, typically for cost centers involved in financial reporting processes.',
    `statistical_cost_center_flag` BOOLEAN COMMENT 'Indicates whether this is a statistical cost center used for informational purposes only, without actual cost postings.',
    `valid_from_date` DATE COMMENT 'The date from which this cost center master record is valid and can accept cost postings. Part of the time-dependent master data structure.',
    `valid_to_date` DATE COMMENT 'The date until which this cost center master record is valid. After this date, no new postings are allowed. Nullable for open-ended validity.',
    CONSTRAINT pk_cost_center PRIMARY KEY(`cost_center_id`)
) COMMENT 'Master record for SAP cost centers used in management accounting and financial controlling. Captures cost center code, description, cost center category (production, administration, R&D, sales), responsible person, valid-from and valid-to dates, controlling area, profit center assignment, and functional area classification. Serves as the primary financial dimension for cost allocation across manufacturing, clinical, and R&D operations.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` (
    `profit_center_id` BIGINT COMMENT 'Primary key for profit_center',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: profit_center.geographic_region is a STRING field but does not map directly to a country. In pharmaceutical enterprises, profit centers are often structured by country for market access, reimbursement',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Profit centers belong to legal entities for consolidation. New FK legal_entity_id → legal_entity.legal_entity_id. Remove company_code as legal_entity.sap_company_code is authoritative.',
    `analysis_period` STRING COMMENT 'The fiscal period for which this profit center configuration is effective, in YYYYMM format. Supports period-specific profit center assignments and reorganizations.. Valid values are `^[0-9]{6}$`',
    `business_area_code` STRING COMMENT 'The business area for cross-company code reporting. Represents a business segment that spans multiple legal entities, used for consolidated management reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `controlling_area_code` STRING COMMENT 'The controlling area to which this profit center is assigned. Controlling area is the organizational unit in SAP CO that represents a closed system for cost accounting purposes.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_group` STRING COMMENT 'The cost center group or range associated with this profit center. Links profit center to underlying cost centers for cost allocation and variance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this profit center master record was created in the system. Supports audit trail and compliance requirements.',
    `currency_code` STRING COMMENT 'The functional currency in which this profit centers P&L is reported. Three-letter ISO 4217 currency code (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'The department or organizational unit code associated with this profit center. Links profit center to the organizational hierarchy for reporting and governance.',
    `dummy_profit_center_flag` BOOLEAN COMMENT 'Indicates whether this is a dummy or placeholder profit center used for technical postings, system balancing, or temporary allocations. True if dummy, False if operational.',
    `functional_area_code` STRING COMMENT 'The functional area classification for cost-of-sales accounting. Represents business functions such as R&D, manufacturing, sales, marketing, or administration.. Valid values are `^[A-Z0-9]{1,16}$`',
    `geographic_region` STRING COMMENT 'The primary geographic region or market that this profit center serves. Used for regional P&L reporting and market access strategy.. Valid values are `north_america|europe|asia_pacific|latin_america|middle_east_africa|global`',
    `hierarchy_node` STRING COMMENT 'The node identifier in the profit center standard hierarchy. Enables roll-up reporting and aggregation of P&L across organizational structures (e.g., by therapeutic area, geography, or product line).',
    `language_code` STRING COMMENT 'The primary language code for profit center descriptions and reporting. Two-letter ISO 639-1 language code (e.g., EN, DE, FR).. Valid values are `^[A-Z]{2}$`',
    `lock_indicator` BOOLEAN COMMENT 'Indicates whether the profit center is locked for posting. When True, no new transactions can be posted to this profit center. Used during period-end close or when deactivating a profit center.',
    `modified_by` STRING COMMENT 'The user ID of the person who last modified this profit center master record. Used for change tracking and data stewardship accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this profit center master record was last modified. Supports change tracking, audit trail, and compliance requirements.',
    `product_line` STRING COMMENT 'The product line or portfolio grouping associated with this profit center. May represent a brand family, drug class, or commercial franchise.',
    `profit_center_code` STRING COMMENT 'The business identifier code for the profit center as defined in SAP Controlling. Typically alphanumeric, 4-10 characters. Used across financial reporting, P&L statements, and management accounting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `profit_center_name` STRING COMMENT 'The full business name or description of the profit center. Human-readable label used in financial reports and management dashboards.',
    `profit_center_status` STRING COMMENT 'The current lifecycle status of the profit center. Active profit centers are operational and accept postings. Planned profit centers are set up but not yet operational. Closed profit centers are historical and no longer accept postings.. Valid values are `active|inactive|planned|closed`',
    `profit_center_type` STRING COMMENT 'The classification type of the profit center indicating its primary business function. Operating profit centers generate revenue; support and corporate profit centers provide shared services.. Valid values are `operating|support|corporate|research|manufacturing|commercial`',
    `segment_code` STRING COMMENT 'The segment classification for external segment reporting per IFRS 8 and US GAAP. Typically represents therapeutic area (oncology, immunology, rare diseases), product line, or geographic market.. Valid values are `^[A-Z0-9]{1,10}$`',
    `short_name` STRING COMMENT 'Abbreviated name or short text for the profit center, used in condensed reports and user interfaces where space is limited.',
    `therapeutic_area` STRING COMMENT 'The primary therapeutic area or disease category that this profit center focuses on. Used for portfolio analysis, R&D allocation, and commercial strategy. [ENUM-REF-CANDIDATE: oncology|immunology|rare_diseases|cardiovascular|neuroscience|infectious_diseases|vaccines|consumer_health|other — 9 candidates stripped; promote to reference product]',
    `valid_from_date` DATE COMMENT 'The date from which this profit center master record is valid and can accept financial postings. Supports time-dependent master data changes.',
    `valid_to_date` DATE COMMENT 'The date until which this profit center master record is valid. After this date, no new postings are allowed. Nullable for open-ended validity.',
    `created_by` STRING COMMENT 'The user ID of the person who created this profit center master record in the system. Used for audit trail and data governance.',
    CONSTRAINT pk_profit_center PRIMARY KEY(`profit_center_id`)
) COMMENT 'Master record for SAP profit centers representing autonomous business segments for internal profitability reporting. Captures profit center code, name, hierarchy node, responsible manager, segment classification (therapeutic area, product line, geography), controlling area, and dummy profit center flag. Enables P&L reporting by therapeutic area (oncology, immunology, rare diseases) and product portfolio.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` (
    `chart_of_accounts_id` BIGINT COMMENT 'Unique identifier for the general ledger account record. Primary key for the chart of accounts master data.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key reference to the company code (legal entity) for which this GL account is defined. Chart of accounts can be shared across multiple company codes, but account properties may vary by company code.',
    `account_group` STRING COMMENT 'The hierarchical grouping code that organizes GL accounts into logical categories for reporting and analysis (e.g., RDEXP for R&D expenses, COGS for cost of goods sold).',
    `account_name` STRING COMMENT 'The full descriptive name of the GL account, providing clear business context for the accounts purpose (e.g., Research and Development Expenses - Preclinical Studies).',
    `account_short_name` STRING COMMENT 'Abbreviated name or label for the GL account used in reports and user interfaces where space is limited.',
    `account_status` STRING COMMENT 'Current lifecycle status of the GL account. Active accounts are available for posting; inactive accounts are retained for historical reporting only; blocked accounts prevent new postings; pending closure accounts are scheduled for deactivation.. Valid values are `active|inactive|blocked|pending_closure`',
    `account_type` STRING COMMENT 'The fundamental accounting classification of the GL account, determining its placement in financial statements and its normal balance (debit or credit).. Valid values are `asset|liability|equity|revenue|expense`',
    `balance_sheet_classification` STRING COMMENT 'For balance sheet accounts, specifies whether the account is classified as current or non-current asset/liability, or equity. Not applicable for P&L accounts.. Valid values are `current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable`',
    `controlling_area_integration` BOOLEAN COMMENT 'Boolean flag indicating whether this account is integrated with the Controlling module for cost center, internal order, and profitability analysis postings.',
    `cost_element_category` STRING COMMENT 'For accounts that are cost elements, specifies whether it is a primary cost element (posted from FI) or secondary cost element (used for internal allocations). Not applicable if cost_element_indicator is false.. Valid values are `primary|secondary|not_applicable`',
    `cost_element_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this GL account is also defined as a cost element in Controlling (CO) module, enabling cost center and internal order postings.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account master record was originally created in the system. Required for regulatory audit trails and data lineage.',
    `currency_type` STRING COMMENT 'Specifies which currency perspective this account primarily operates in: local currency, group currency, hard currency, index-based currency, or global company currency. Supports multi-currency pharmaceutical operations.. Valid values are `local|group|hard|index|global`',
    `financial_statement_category` STRING COMMENT 'Indicates which primary financial statement this account appears on: balance sheet (statement of financial position), profit and loss (income statement), cash flow statement, or statement of retained earnings.. Valid values are `balance_sheet|profit_and_loss|cash_flow|retained_earnings`',
    `functional_area` STRING COMMENT 'The business function or department this account is primarily associated with (e.g., R&D, Manufacturing, Commercial, Regulatory Affairs). Used for functional cost analysis in pharmaceutical operations.',
    `gl_account_number` STRING COMMENT 'The unique account code used to identify this GL account across all financial transactions. Typically a 6-10 digit numeric code structured by account type and category.. Valid values are `^[0-9]{6,10}$`',
    `ifrs_mapping_code` STRING COMMENT 'The IFRS financial statement line item code that this account maps to for IFRS-compliant financial reporting. Enables parallel accounting and consolidated reporting under IFRS standards.',
    `line_item_display` BOOLEAN COMMENT 'Boolean flag indicating whether individual line item details are stored and can be displayed for this account. Essential for accounts requiring detailed transaction audit trails.',
    `milestone_revenue_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this revenue account is used for milestone-based revenue recognition common in pharmaceutical licensing and collaboration agreements (e.g., regulatory approval milestones, sales milestones).',
    `modified_by` STRING COMMENT 'The user ID or system identifier of the person or process that last modified this GL account master record. Essential for change tracking and compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this GL account master record was last modified. Tracks the most recent change for audit and governance purposes.',
    `open_item_management` BOOLEAN COMMENT 'Boolean flag indicating whether this account uses open item management, requiring line items to be explicitly cleared (e.g., for receivables, payables, clearing accounts).',
    `pl_classification` STRING COMMENT 'For income statement accounts, specifies the detailed classification within the P&L structure (operating vs non-operating, revenue vs expense categories). Not applicable for balance sheet accounts.. Valid values are `operating_revenue|non_operating_revenue|cost_of_sales|operating_expense|non_operating_expense|not_applicable`',
    `posting_block_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether direct postings to this account are currently blocked. When true, the account can only receive postings through specific controlled processes.',
    `profit_center_update_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether postings to this account automatically update profit center accounting, enabling segment reporting and profitability analysis by therapeutic area or product line.',
    `rd_capitalization_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether costs posted to this account are eligible for capitalization as intangible assets under development (e.g., post-IND development costs). Critical for pharmaceutical R&D accounting under IAS 38 and ASC 730.',
    `reconciliation_account_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this is a reconciliation account (subledger control account) that summarizes detailed transactions from subsidiary ledgers such as Accounts Receivable, Accounts Payable, or Asset Accounting.',
    `royalty_accrual_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this account is used for royalty expense accruals or royalty revenue recognition, common in pharmaceutical licensing arrangements and patent agreements.',
    `sort_key` STRING COMMENT 'The default sort key used for organizing and displaying line items within this account (e.g., by posting date, document number, reference). Improves usability for high-volume accounts.',
    `subledger_type` STRING COMMENT 'For reconciliation accounts, specifies which subledger this account reconciles (AR, AP, Fixed Assets, MM). Not applicable for non-reconciliation accounts.. Valid values are `accounts_receivable|accounts_payable|fixed_assets|materials_management|not_applicable`',
    `tax_category` STRING COMMENT 'The tax treatment category for this account, determining how transactions posted to this account are handled for tax reporting purposes (e.g., VAT_INPUT, VAT_OUTPUT, NON_TAXABLE, EXEMPT).',
    `us_gaap_mapping_code` STRING COMMENT 'The US GAAP financial statement line item code that this account maps to for US GAAP-compliant financial reporting. Supports dual reporting requirements for pharmaceutical companies with US operations.',
    `valid_from_date` DATE COMMENT 'The date from which this GL account becomes active and available for transaction postings. Supports time-dependent account structures.',
    `valid_to_date` DATE COMMENT 'The date until which this GL account remains active. Null indicates no planned end date. Used for account lifecycle management and historical cutover scenarios.',
    `created_by` STRING COMMENT 'The user ID or system identifier of the person or process that created this GL account master record. Supports audit trail and data governance requirements.',
    CONSTRAINT pk_chart_of_accounts PRIMARY KEY(`chart_of_accounts_id`)
) COMMENT 'Master record defining all general ledger account codes used across the pharmaceutical enterprise. Captures GL account number, description, account type (asset, liability, equity, revenue, expense), account group, P&L vs balance sheet classification, tax category, reconciliation account indicator, IFRS/US-GAAP mapping, R&D capitalization eligibility flag, and controlling integration settings. Governs financial reporting consistency across all company codes, enabling compliant reporting under multiple accounting standards and supporting pharma-specific accounting requirements (R&D expense vs capitalization, milestone revenue recognition, royalty accruals).';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`masterdata`.`material` (
    `material_id` BIGINT COMMENT 'Primary key for material',
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: Pharmaceutical materials classified by WHO ATC system. New FK atc_classification_id → atc_classification.masterdata_atc_classification_id. Remove atc_code as redundant.',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: Materials reference INN registry for active pharmaceutical ingredients. New FK inn_registry_id → inn_registry.masterdata_inn_registry_id. Remove inn_name as redundant.',
    `masterdata_ndc_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.ndc_code. Business justification: Marketed pharmaceutical products have NDC codes. New FK ndc_code_id → ndc_code.masterdata_ndc_code_id. Remove ndc_code (STRING) as redundant.',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Materials measured in standard units of measure. New FK base_uom_id → unit_of_measure.uom_id for base UOM. Remove base_unit_of_measure (STRING) as redundant. Note: weight_unit and volume_unit remain a',
    `batch_managed_indicator` BOOLEAN COMMENT 'Flag indicating whether the material requires batch-level tracking and management for traceability and quality control purposes.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by CAS to every chemical substance, used for regulatory submissions and scientific documentation.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `controlled_substance_schedule` STRING COMMENT 'DEA schedule classification for controlled substances. Schedule I-V indicate varying levels of control requirements; non-controlled materials are not regulated under DEA.. Valid values are `SCHEDULE_I|SCHEDULE_II|SCHEDULE_III|SCHEDULE_IV|SCHEDULE_V|NON_CONTROLLED`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the material master record was first created in the system.',
    `discontinuation_date` DATE COMMENT 'Date on which the material is discontinued and no longer available for new orders or production, supporting product lifecycle management.',
    `effective_date` DATE COMMENT 'Date from which the material master record becomes active and available for use in business transactions.',
    `gmp_classification` STRING COMMENT 'Classification indicating the level of GMP control required for this material. GMP-critical materials require the highest level of quality control and documentation.. Valid values are `GMP_CRITICAL|GMP_MAJOR|GMP_MINOR|NON_GMP`',
    `gross_weight` DECIMAL(18,2) COMMENT 'Total weight of the material including packaging, expressed in the weight unit of measure.',
    `hazard_class` STRING COMMENT 'Classification of hazardous materials per GHS (Globally Harmonized System) or DOT hazard classes for transportation and safety management.',
    `hazardous_material_indicator` BOOLEAN COMMENT 'Flag indicating whether the material is classified as hazardous per regulatory definitions, requiring special handling and documentation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the material master record was last updated, supporting audit trail and change management requirements.',
    `lims_material_code` STRING COMMENT 'Material identifier used in the LIMS system for laboratory testing, quality control, and certificate of analysis tracking.',
    `manufacturer_part_number` STRING COMMENT 'Manufacturers unique part number or catalog number for the material, used for procurement and supplier management.',
    `material_description` STRING COMMENT 'Short textual description of the material for identification and display purposes.',
    `material_group` STRING COMMENT 'Hierarchical grouping code for materials used for procurement, planning, and reporting purposes.',
    `material_number` STRING COMMENT 'Unique business identifier for the material across the enterprise. Typically the SAP material number used as the primary external reference code.. Valid values are `^[A-Z0-9]{8,18}$`',
    `material_status` STRING COMMENT 'Current lifecycle status of the material indicating its availability for use in operations.. Valid values are `ACTIVE|BLOCKED|OBSOLETE|PENDING_APPROVAL|DISCONTINUED|QUARANTINE`',
    `material_type` STRING COMMENT 'Classification of the material by its role in pharmaceutical operations. API = Active Pharmaceutical Ingredient, DS = Drug Substance, DP = Drug Product, FDF = Finished Dosage Form. [ENUM-REF-CANDIDATE: API|EXCIPIENT|DRUG_SUBSTANCE|DRUG_PRODUCT|FINISHED_DOSAGE_FORM|PACKAGING_PRIMARY|PACKAGING_SECONDARY|RAW_MATERIAL|REAGENT|REFERENCE_STANDARD — 10 candidates stripped; promote to reference product]',
    `mes_material_code` STRING COMMENT 'Material identifier used in the MES system for production tracking, batch records, and manufacturing operations.',
    `minimum_remaining_shelf_life_days` STRING COMMENT 'Minimum number of days of remaining shelf life required at goods receipt or before use in production, ensuring adequate time for processing and distribution.',
    `net_weight` DECIMAL(18,2) COMMENT 'Weight of the material excluding packaging, expressed in the weight unit of measure.',
    `procurement_type` STRING COMMENT 'Indicates how the material is obtained: externally purchased, internally manufactured, or both. Consignment indicates vendor-owned inventory.. Valid values are `PURCHASED|MANUFACTURED|BOTH|CONSIGNMENT`',
    `quality_inspection_required` BOOLEAN COMMENT 'Flag indicating whether incoming goods or production batches of this material require quality inspection before release for use.',
    `retest_interval_days` STRING COMMENT 'Number of days after which stored material must be retested to confirm continued compliance with specifications, applicable to APIs and intermediates.',
    `serial_number_profile` STRING COMMENT 'Configuration profile defining serial number management requirements for the material, used for unit-level traceability.',
    `shelf_life_days` STRING COMMENT 'Total shelf life of the material from manufacturing date to expiration, expressed in days. Critical for GMP compliance and inventory management.',
    `storage_conditions` STRING COMMENT 'Required environmental conditions for material storage including temperature range, humidity, and light protection requirements per stability data.',
    `temperature_sensitive_indicator` BOOLEAN COMMENT 'Flag indicating whether the material requires temperature-controlled storage and transportation (cold chain management).',
    `usan_name` STRING COMMENT 'United States Adopted Name for pharmaceutical substances as designated by the USAN Council.',
    `volume` DECIMAL(18,2) COMMENT 'Physical volume of the material, used for storage and transportation planning.',
    `volume_unit` STRING COMMENT 'Unit of measure for the volume field.. Valid values are `L|ML|M3|FT3|GAL`',
    `weight_unit` STRING COMMENT 'Unit of measure for gross and net weight fields.. Valid values are `KG|G|MG|LB|OZ`',
    CONSTRAINT pk_material PRIMARY KEY(`material_id`)
) COMMENT 'Central master record for all materials managed within the pharmaceutical enterprise including APIs (Active Pharmaceutical Ingredients), excipients, drug substances (DS), drug products (DP), finished dosage forms (FDF), packaging materials, laboratory reagents, and raw materials. Captures material number, INN (International Nonproprietary Name), USAN, material type, base unit of measure, material group, gross/net weight, shelf life, storage conditions, hazardous material classification, GMP classification, and cross-system identifiers (SAP material number, LIMS material code). SSOT for material identity across SAP MM, LIMS, and MES.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` (
    `plant_id` BIGINT COMMENT 'Unique identifier for the plant facility. Primary key.',
    `address_id` BIGINT COMMENT 'Foreign key linking to masterdata.address. Business justification: plant carries five inline address columns (address_line_1, address_line_2, city, state_province, postal_code) that duplicate the masterdata.address master record. Adding plant_address_id FK to address',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: plant.capacity_unit_of_measure is a free-text STRING representing the unit of measure for annual plant capacity (e.g., kg, liters, units). The masterdata.unit_of_measure table is the authoritative ref',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Plants located in countries for regulatory compliance (GMP, FDA, EMA). New FK country_id → country.country_id. Existing country_code (STRING) remains for code reference.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Plants owned/operated by legal entities. New FK legal_entity_id → legal_entity.legal_entity_id. Remove company_code as legal_entity.sap_company_code is authoritative.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Plants are operational facilities that should be part of the organizational hierarchy. Each plant belongs to an organizational unit (e.g., Manufacturing Operations, R&D Facilities). This enables o',
    `annual_capacity_units` DECIMAL(18,2) COMMENT 'Maximum annual production capacity of the plant expressed in standard units (e.g., kilograms of API, millions of dosage units), used for capacity planning and network design.',
    `capacity_class` STRING COMMENT 'Classification of the plants production or operational capacity relative to other facilities in the network, used for supply chain planning and network optimization.. Valid values are `small|medium|large|extra_large`',
    `commissioning_date` DATE COMMENT 'Date when the plant facility was officially commissioned and began operational activities.',
    `cost_center` STRING COMMENT 'Primary cost center code assigned to the plant facility for cost accounting and financial controlling purposes.. Valid values are `^[A-Z0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plant master record was first created in the system.',
    `dea_registration_number` STRING COMMENT 'DEA registration number for facilities handling controlled substances, required for manufacturing, distribution, or research involving scheduled drugs.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `ema_site_number` STRING COMMENT 'Unique site identifier assigned by the European Medicines Agency for manufacturing and testing facilities within the European Economic Area.. Valid values are `^[A-Z]{2}[0-9]{6,10}$`',
    `email_address` STRING COMMENT 'Primary email contact address for the plant facility for official communications and regulatory correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `environmental_permit_status` STRING COMMENT 'Current status of environmental operating permits required for pharmaceutical manufacturing operations at the plant facility.. Valid values are `valid|expired|pending|suspended|not_required`',
    `fda_establishment_identifier` STRING COMMENT 'Unique registration number assigned by the U.S. Food and Drug Administration for facilities engaged in the manufacture, preparation, propagation, compounding, or processing of drug products.. Valid values are `^[0-9]{7,10}$`',
    `gmp_certification_date` DATE COMMENT 'Date when the plant received its current Good Manufacturing Practice certification from the relevant regulatory authority.',
    `gmp_certification_status` STRING COMMENT 'Current status of the plants Good Manufacturing Practice certification, indicating compliance with pharmaceutical manufacturing quality standards.. Valid values are `certified|expired|pending|suspended|not_applicable`',
    `gmp_expiry_date` DATE COMMENT 'Date when the plants current Good Manufacturing Practice certification expires and requires renewal or re-inspection.',
    `iso_certification_status` STRING COMMENT 'Current status of the plants ISO 9001 Quality Management System certification or other relevant ISO certifications (e.g., ISO 13485 for medical devices).. Valid values are `certified|expired|pending|not_applicable`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection by FDA, EMA, or other competent authority at the plant facility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the plant master record was most recently updated or modified.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the plant facility in decimal degrees, used for logistics planning and geographic analysis.',
    `lims_system` STRING COMMENT 'Name and version of the Laboratory Information Management System used at the plant for sample tracking, testing, and Certificate of Analysis generation.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the plant facility in decimal degrees, used for logistics planning and geographic analysis.',
    `manufacturing_execution_system` STRING COMMENT 'Name and version of the Manufacturing Execution System used at the plant for batch execution, electronic batch records, and production tracking.',
    `next_inspection_due_date` DATE COMMENT 'Anticipated or scheduled date for the next regulatory inspection based on inspection frequency requirements and risk classification.',
    `operational_status` STRING COMMENT 'Current operational lifecycle status of the plant facility indicating whether it is actively producing, temporarily offline, or permanently closed.. Valid values are `active|inactive|under_construction|decommissioned|temporarily_closed|pending_approval`',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the plant facility including country and area codes.',
    `plant_code` STRING COMMENT 'Business identifier code for the plant facility, typically used in SAP S/4HANA and other operational systems for cross-system reference.. Valid values are `^[A-Z0-9]{4,10}$`',
    `plant_name` STRING COMMENT 'Full business name of the plant facility as registered with regulatory authorities and used in official documentation.',
    `plant_type` STRING COMMENT 'Classification of the plant facility based on its primary operational function within the pharmaceutical enterprise.. Valid values are `manufacturing|packaging|distribution|research_and_development|quality_control_laboratory|clinical_supply`',
    `quality_management_system` STRING COMMENT 'Name and version of the Quality Management System software platform used at the plant (e.g., MasterControl, TrackWise, Veeva Vault QualityDocs).',
    `sap_plant_code` STRING COMMENT 'Four-character plant code used in SAP S/4HANA ERP system for materials management, production planning, and financial controlling.. Valid values are `^[A-Z0-9]{4}$`',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the plant facility location, used for scheduling, shift planning, and cross-site coordination.',
    CONSTRAINT pk_plant PRIMARY KEY(`plant_id`)
) COMMENT 'Master record for manufacturing plants, packaging sites, distribution centers, and R&D facilities within the pharmaceutical enterprise. Captures plant code, plant name, plant type (manufacturing, packaging, distribution, R&D, QC laboratory), address, country, GMP certification status, regulatory authority registrations (FDA establishment registration, EMA site number), capacity class, and SAP plant code. Supports manufacturing network planning, regulatory site management, and supply chain operations.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the storage location within the pharmaceutical manufacturing and distribution network. Primary key for the storage location master record.',
    `address_id` BIGINT COMMENT 'Foreign key linking to masterdata.address. Business justification: storage_location carries five inline address columns (address_line_1, address_line_2, city, state_province, postal_code) that duplicate the masterdata.address master record. Adding storage_location_ad',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: storage_location.capacity_unit_of_measure is a free-text STRING representing the unit of measure for storage capacity (e.g., pallets, cubic meters, liters). The masterdata.unit_of_measure table is the',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Storage locations incur operational costs (utilities, climate control, labor, maintenance) that must be allocated to cost centers for management accounting. This is a standard cost allocation relation',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: storage_location.country_code is a free-text STRING representing the country of the storage location. The masterdata.country table is the authoritative reference. Adding country_id FK to country.count',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing or distribution plant to which this storage location belongs. Links storage location to the organizational hierarchy for GMP compliance and regulatory reporting.',
    `capacity_storage_units` DECIMAL(18,2) COMMENT 'Maximum storage capacity of this location measured in storage units (pallets, bins, cubic meters, or location-specific unit). Used for warehouse space planning and inventory optimization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location master record was first created in the system. Audit trail field for data governance and compliance.',
    `dea_license_number` STRING COMMENT 'DEA registration number for storage locations authorized to hold controlled substances (Schedule II-V). Format: 2 letters + 7 digits. Required for controlled substance accountability and regulatory inspections. Null for non-controlled substance storage.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `dea_schedule_authorized` STRING COMMENT 'Highest DEA controlled substance schedule this storage location is authorized to hold. Schedule II requires vault-level security. Not applicable for non-controlled substance storage.. Valid values are `schedule_ii|schedule_iii|schedule_iv|schedule_v|not_applicable`',
    `effective_end_date` DATE COMMENT 'Date when this storage location was decommissioned or permanently closed. Null for active storage locations. Used for historical reporting and audit trail.',
    `effective_start_date` DATE COMMENT 'Date when this storage location became operational and available for goods movements. Marks the beginning of the storage locations lifecycle in the master data system.',
    `gdp_compliant_flag` BOOLEAN COMMENT 'Indicates whether this storage location meets GDP requirements for pharmaceutical distribution. True for qualified distribution centers with temperature mapping, security, and traceability controls. False for non-GDP locations.',
    `gmp_zone_classification` STRING COMMENT 'Cleanroom classification per EU GMP Annex 1 or ISO 14644. Grade A for aseptic processing, Grade D for general manufacturing. Unclassified for non-GMP warehouses. Drives gowning, environmental monitoring, and personnel flow requirements.. Valid values are `grade_a|grade_b|grade_c|grade_d|unclassified`',
    `hazmat_storage_class` STRING COMMENT 'Classification of hazardous materials authorized for storage per OSHA and DOT regulations. Determines segregation requirements, fire suppression systems, and emergency response protocols. Non-hazardous for general storage.. Valid values are `flammable|corrosive|oxidizer|toxic|explosive|non_hazardous`',
    `humidity_max_percent` DECIMAL(18,2) COMMENT 'Maximum allowable relative humidity percentage for this storage location. Excursions may impact product stability and require OOT investigation. Null if humidity control is not required.',
    `humidity_min_percent` DECIMAL(18,2) COMMENT 'Minimum allowable relative humidity percentage for this storage location. Required for hygroscopic API and moisture-sensitive drug products. Null if humidity control is not required.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location master record was last updated. Tracks change history for audit trail and data stewardship.',
    `last_qualification_date` DATE COMMENT 'Date of the most recent qualification or requalification of this storage location per CSV and GMP requirements. Includes temperature mapping, humidity validation, and security system testing. Drives requalification scheduling.',
    `next_qualification_due_date` DATE COMMENT 'Scheduled date for the next periodic requalification of this storage location. Typically annual or biennial based on risk assessment. Overdue qualifications may trigger storage location blocking.',
    `quarantine_zone_flag` BOOLEAN COMMENT 'Indicates whether this storage location is designated as a quarantine zone for materials pending QC release, under investigation, or rejected. True for quarantine areas, false for released goods storage.',
    `returns_processing_flag` BOOLEAN COMMENT 'Indicates whether this storage location is designated for processing returned goods, including customer returns, expired products, and recalls. True for returns processing areas requiring segregation and disposition workflows.',
    `sampling_location_flag` BOOLEAN COMMENT 'Indicates whether this storage location is designated for QC sampling activities. True for sampling areas where materials are temporarily held for sample collection per sampling plans.',
    `security_level` STRING COMMENT 'Physical security classification for this storage location. High for DEA vaults and high-value products requiring 24/7 surveillance, access control, and intrusion detection. Medium for controlled access areas. Standard for general warehouses.. Valid values are `high|medium|standard`',
    `segregation_required_flag` BOOLEAN COMMENT 'Indicates whether materials in this storage location must be physically segregated from other materials due to cross-contamination risk, regulatory requirements, or product incompatibility. True for quarantine zones, controlled substances, and hazmat.',
    `storage_location_code` STRING COMMENT 'Business identifier for the storage location. Alphanumeric code used across SAP WM, LIMS, and MES systems for warehouse management and batch traceability. Typically 4-10 characters.. Valid values are `^[A-Z0-9]{4,10}$`',
    `storage_location_name` STRING COMMENT 'Human-readable name of the storage location. Examples: Cold Room 2-8C Building A, DEA Vault Schedule II, Quarantine Zone QC Lab 3, Hazmat Storage Flammables.',
    `storage_location_status` STRING COMMENT 'Current operational status of the storage location. Blocked status prevents goods movements pending CAPA resolution or requalification. Under qualification indicates validation in progress per CSV requirements.. Valid values are `active|inactive|blocked|under_qualification|decommissioned`',
    `storage_type` STRING COMMENT 'Classification of the storage location by functional purpose. Determines applicable GMP, GDP, and DEA controls. Critical for regulatory inspection readiness and batch traceability. [ENUM-REF-CANDIDATE: warehouse|cold_room|freezer|controlled_substance_vault|quarantine_zone|qc_sampling_area|returns_processing|hazmat_storage|bulk_storage|finished_goods|raw_material|packaging_material|work_in_process — 13 candidates stripped; promote to reference product]',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum allowable temperature for this storage location in degrees Celsius. Excursions beyond this threshold trigger deviation investigations and potential batch impact assessments.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum allowable temperature for this storage location in degrees Celsius. Critical for cold-chain integrity and stability compliance. Examples: 2.0 for refrigerated, -25.0 for freezer, -85.0 for ultra-low freezer.',
    `temperature_monitoring_system` STRING COMMENT 'Type of temperature monitoring system deployed at this storage location. Continuous automated systems provide real-time alerts for excursions. Periodic manual monitoring uses data loggers with batch review. Not monitored for ambient storage.. Valid values are `continuous_automated|periodic_manual|not_monitored`',
    `wms_integration_flag` BOOLEAN COMMENT 'Indicates whether this storage location is integrated with a WMS for automated goods movements, bin management, and real-time inventory tracking. True for WMS-managed locations, false for manual locations.',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Master record for storage locations within pharmaceutical manufacturing and distribution plants. Covers warehouses, cold rooms (2-8°C, -20°C, -80°C), controlled substance vaults (DEA Schedule II-V), quarantine zones, QC sampling areas, returns processing areas, and hazardous material storage. Captures storage location code, plant assignment, temperature range, humidity control requirements, DEA license number (for controlled substances), GMP zone classification (Grade A-D), GDP compliance status, capacity in storage units, and WMS integration flag. Critical for batch traceability, cold-chain integrity, controlled substance accountability, and regulatory inspection readiness.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` (
    `unit_of_measure_id` BIGINT COMMENT 'Primary key for unit_of_measure',
    `base_unit_of_measure_id` BIGINT COMMENT 'Self-referencing FK on unit_of_measure (base_unit_of_measure_id)',
    `applicable_material_types` STRING COMMENT 'Comma-separated list of SAP material types or substance categories for which this UOM is applicable. Examples: API (Active Pharmaceutical Ingredient), DS (Drug Substance), DP (Drug Product), FDF (Finished Dosage Form), excipient, raw material, packaging material. Guides UOM selection during material master creation and transaction processing.',
    `conversion_group` STRING COMMENT 'Logical grouping of UOMs that can be converted among each other. UOMs within the same conversion group share a common dimension and can be mathematically converted (e.g., mass group: mg, g, kg; volume group: mL, L). Used to enforce conversion rules and prevent invalid cross-dimensional conversions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this unit of measure master record was first created in the system. Immutable audit field supporting regulatory compliance and data lineage tracking.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Computed data quality score (0.00 to 100.00) reflecting completeness, accuracy, consistency, and conformance of this UOM master record to MDM data quality rules. Supports proactive data quality management and continuous improvement initiatives.',
    `data_source_system` STRING COMMENT 'Name of the operational system of record from which this UOM master record originates. Examples: SAP S/4HANA MM, LIMS LabWare, MES, Veeva Vault QualityDocs. Supports data lineage and cross-system reconciliation in the lakehouse architecture.',
    `decimal_precision` STRING COMMENT 'Number of decimal places typically used when recording measurements in this unit. Guides data entry validation and reporting formats. Example: 3 for milligrams (0.001), 6 for micrograms (0.000001), 0 for tablets (whole units).',
    `dimension_type` STRING COMMENT 'The fundamental physical dimension represented by this unit of measure per dimensional analysis. Aligns with SI base quantities and derived quantities. Used for dimensional consistency validation in formulation calculations and process parameter specifications. [ENUM-REF-CANDIDATE: length|mass|time|temperature|amount_of_substance|electric_current|luminous_intensity|area|volume|velocity|acceleration|force|pressure|energy|power|frequency|dimensionless — 17 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date after which this unit of measure is no longer valid for new transactions. Null for currently active UOMs. Supports phase-out of deprecated units while preserving historical data integrity.',
    `effective_start_date` DATE COMMENT 'Date from which this unit of measure becomes valid and available for use in operational systems. Supports temporal master data management and regulatory change management (e.g., adoption of new pharmacopeial standards).',
    `is_base_uom` BOOLEAN COMMENT 'Indicates whether this UOM is the base unit for its material or substance in SAP Material Master. Base UOMs serve as the reference for all alternative UOM conversions within a material. True if base UOM, False otherwise.',
    `is_commercial_uom` BOOLEAN COMMENT 'Indicates whether this UOM is used for commercial transactions, sales orders, and distribution (SAP SD module). Commercial UOMs may differ from manufacturing or laboratory UOMs. True if used in commercial contexts, False otherwise.',
    `is_laboratory_uom` BOOLEAN COMMENT 'Indicates whether this UOM is used in laboratory testing, quality control, and LIMS (Laboratory Information Management System). Laboratory UOMs support analytical testing, stability studies, and Certificate of Analysis (CoA) reporting. True if used in laboratory contexts, False otherwise.',
    `is_manufacturing_uom` BOOLEAN COMMENT 'Indicates whether this UOM is used in manufacturing operations, batch production, and MES (Manufacturing Execution System). Manufacturing UOMs align with production planning (PP) and shop floor data collection. True if used in manufacturing, False otherwise.',
    `iso_unit_code` STRING COMMENT 'Standardized unit code per ISO 80000 and UN/CEFACT Recommendation 20. Enables interoperability across international regulatory submissions (eCTD) and supply chain systems. Examples: GRM (gram), KGM (kilogram), MLT (milliliter), LTR (liter).. Valid values are `^[A-Z0-9]{2,4}$`',
    `last_modified_by` STRING COMMENT 'User ID or system account that last modified this unit of measure master record. Supports change control and data stewardship accountability per GxP requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this unit of measure master record was last modified. Updated with each change to support audit trail and change control documentation.',
    `mdm_approval_status` STRING COMMENT 'Approval workflow status for this unit of measure within the MDM governance process. Draft records are under construction; pending_review records await data steward approval; approved records are released for operational use; rejected records require rework. Enforces data quality gates before UOM activation.. Valid values are `draft|pending_review|approved|rejected`',
    `regulatory_standard` STRING COMMENT 'Citation of the regulatory or pharmacopeial standard that defines or governs the use of this unit of measure. Examples: USP <1> Injections, Ph. Eur. 2.9.40 Uniformity of Dosage Units, FDA 21 CFR Part 210 Current Good Manufacturing Practice, ICH Q6A Specifications. Supports compliance traceability for regulatory submissions (IND, NDA, BLA, MAA).',
    `sap_internal_uom` STRING COMMENT 'SAP S/4HANA internal unit of measure code used in Material Master (MM), Production Planning (PP), Quality Management (QM), and Warehouse Management (WM) modules. Maps external UOM codes to SAP-specific representations for ERP transaction processing.. Valid values are `^[A-Z0-9]{2,3}$`',
    `si_conversion_factor` DECIMAL(18,2) COMMENT 'Numeric multiplier to convert this UOM to its SI base unit. Enables automated unit conversion across systems. Example: for milligram to kilogram, factor is 0.000001; for milliliter to liter, factor is 0.001. Null for dimensionless units.',
    `unit_of_measure_status` STRING COMMENT 'Current lifecycle status of the unit of measure in the master data repository. Active UOMs are available for use in transactions; inactive UOMs are retained for historical data but not selectable for new entries; deprecated UOMs are phased out per regulatory or business changes; pending_approval UOMs await MDM governance review before activation.. Valid values are `active|inactive|deprecated|pending_approval`',
    `uom_category` STRING COMMENT 'Classification of the unit of measure by measurement type. Segments UOMs into functional categories for pharmaceutical operations: mass (mg, g, kg), volume (mL, L), concentration (mg/mL, %w/v), potency (IU, mcg), packaging (vial, ampoule, blister, tablet, capsule), analytical (ppm, ppb, CFU/mL), time (hour, day), temperature (Celsius, Fahrenheit), pressure (bar, psi), count (each, piece). [ENUM-REF-CANDIDATE: mass|volume|concentration|potency|packaging|analytical|time|temperature|pressure|count — 10 candidates stripped; promote to reference product]',
    `uom_code` STRING COMMENT 'Short alphanumeric code representing the unit of measure. Used as the business identifier across SAP S/4HANA, LIMS, and MES systems. Examples: MG, G, KG, ML, L, IU, MCG, PPM, PPB, CFU.. Valid values are `^[A-Z0-9]{1,6}$`',
    `uom_description` STRING COMMENT 'Full descriptive name of the unit of measure. Provides human-readable explanation of the UOM code. Examples: Milligram, Gram, Kilogram, Milliliter, Liter, International Unit, Microgram, Parts Per Million, Parts Per Billion, Colony Forming Unit per Milliliter.',
    `created_by` STRING COMMENT 'User ID or system account that created this unit of measure master record. Supports audit trail and data stewardship accountability per 21 CFR Part 11 electronic records requirements.',
    CONSTRAINT pk_unit_of_measure PRIMARY KEY(`unit_of_measure_id`)
) COMMENT 'Reference master for units of measure used across pharmaceutical operations including mass (mg, g, kg), volume (mL, L), concentration (mg/mL, %w/v), potency (IU, mcg), packaging (vial, ampoule, blister, tablet, capsule), and analytical units (ppm, ppb, CFU/mL). Captures UOM code, UOM description, UOM category, ISO unit code, SAP internal UOM, conversion factors to SI base units, and applicable regulatory standards. Ensures consistent measurement across SAP, LIMS, and MES.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`masterdata`.`country` (
    `country_id` BIGINT COMMENT 'Unique identifier for the country or territory record. Primary key for the country master data product.',
    `clinical_trial_registration_required_flag` BOOLEAN COMMENT 'Indicates whether the country mandates registration of clinical trials in a public registry (e.g., ClinicalTrials.gov, EU Clinical Trials Register, CTRI India) before trial initiation. True if registration required, False otherwise. Impacts CTMS workflows and regulatory compliance.',
    `controlled_substance_schedule_system` STRING COMMENT 'Name of the controlled substance classification system used in the country (e.g., DEA Schedules I-V for USA, UK Misuse of Drugs Act Classes A/B/C, Japan Narcotics and Psychotropics Control Law). Determines manufacturing, storage, distribution, and prescribing requirements for controlled APIs and drug products. Impacts supply chain security and regulatory submissions.',
    `country_name` STRING COMMENT 'Official English name of the country or territory as recognized by the United Nations and used in regulatory submissions, commercial documentation, and reporting (e.g., United States of America, United Kingdom, Japan, China, Germany).',
    `country_status` STRING COMMENT 'Current operational status of the country for pharmaceutical business activities. Active: normal operations permitted. Inactive: no current operations or market presence. Restricted: limited operations due to regulatory or business constraints. Sanctioned: operations prohibited due to international sanctions or trade restrictions. Impacts supply chain routing, clinical trial site selection, and commercial activities.. Valid values are `Active|Inactive|Restricted|Sanctioned`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this country master data record was first created in the system. Supports audit trail, data lineage, and regulatory compliance (21 CFR Part 11 electronic records).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the countrys official currency (e.g., USD, EUR, GBP, JPY, CNY). Used in SAP S/4HANA FI/CO modules for financial transactions, pricing, revenue recognition, and P&L reporting.. Valid values are `^[A-Z]{3}$`',
    `data_privacy_regulation` STRING COMMENT 'Name of the primary data privacy and protection regulation applicable in the country (e.g., GDPR for EU, HIPAA for USA, LGPD for Brazil, PDPA for Singapore). Governs handling of patient data in clinical trials, pharmacovigilance, and commercial activities. Critical for EDC system configuration, eTMF management, and data transfer agreements.',
    `distribution_license_required_flag` BOOLEAN COMMENT 'Indicates whether a separate wholesale distribution license or GDP certification is required to distribute pharmaceutical products within the country. True if distribution license required, False otherwise. Impacts supply chain partner qualification and logistics planning.',
    `effective_date` DATE COMMENT 'Date from which this country master data record is effective and valid for use in operational systems, regulatory submissions, and commercial transactions. Supports temporal master data management and historical reporting.',
    `expiration_date` DATE COMMENT 'Date after which this country master data record is no longer valid for use. Null if the record is currently active with no planned expiration. Used for managing country code changes, territory splits, or operational discontinuation.',
    `gmp_inspection_authority` STRING COMMENT 'Name of the authority responsible for conducting GMP inspections of pharmaceutical manufacturing facilities within the country (may differ from the primary regulatory authority in some jurisdictions). Critical for manufacturing site qualification, PAI scheduling, and quality compliance.',
    `hta_body_name` STRING COMMENT 'Name of the national or regional health technology assessment body that evaluates clinical and economic value of new medicines for reimbursement decisions (e.g., NICE for UK, G-BA for Germany, PBAC for Australia, CADTH for Canada, HAS for France). Null if no formal HTA process exists.',
    `ich_region_flag` BOOLEAN COMMENT 'Indicates whether the country is a member of an ICH region (USA, EU, Japan, Canada, Switzerland). ICH membership determines applicability of harmonized technical requirements for pharmaceutical registration (CTD/eCTD format, stability testing, quality guidelines). True if ICH member, False otherwise.',
    `ich_region_name` STRING COMMENT 'Name of the ICH region to which the country belongs, if applicable. Used to determine which ICH guidelines and harmonized standards apply to regulatory submissions and CMC documentation.. Valid values are `ICH Americas|ICH Europe|ICH Asia-Pacific|Non-ICH`',
    `iso_alpha_2_code` STRING COMMENT 'Two-letter country code as defined by ISO 3166-1 alpha-2 standard. Used for regulatory submissions, labeling, and system integrations (e.g., US, GB, JP, CN, DE).. Valid values are `^[A-Z]{2}$`',
    `iso_alpha_3_code` STRING COMMENT 'Three-letter country code as defined by ISO 3166-1 alpha-3 standard. Used in eCTD submissions, regulatory documents, and SAP S/4HANA master data (e.g., USA, GBR, JPN, CHN, DEU).. Valid values are `^[A-Z]{3}$`',
    `iso_numeric_code` STRING COMMENT 'Three-digit numeric country code as defined by ISO 3166-1 numeric standard. Used in systems requiring numeric-only identifiers (e.g., 840 for USA, 826 for GBR, 392 for JPN).. Valid values are `^[0-9]{3}$`',
    `market_access_tier` STRING COMMENT 'Commercial prioritization tier for market access and launch planning. Tier 1: high-value markets with established reimbursement frameworks and large patient populations (e.g., USA, Germany, Japan). Tier 2: significant markets with moderate access complexity. Tier 3: smaller markets or those with challenging reimbursement. Emerging: developing markets with growth potential. Drives commercial strategy, HEOR investment, and launch sequencing.. Valid values are `Tier 1|Tier 2|Tier 3|Emerging`',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this country master data record. Supports audit trail and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this country master data record was last modified. Supports audit trail, change tracking, and data quality monitoring.',
    `patent_filing_authority` STRING COMMENT 'Name of the national intellectual property office responsible for patent applications and grants (e.g., USPTO, EPO, JPO, CNIPA, UKIPO). Used for tracking patent filings, patent term extensions, and exclusivity periods for NCEs and NBEs.',
    `pharmaceutical_market_classification` STRING COMMENT 'Classification of the countrys pharmaceutical regulatory maturity and market structure. Regulated markets have stringent GMP, GCP, and pharmacovigilance requirements (e.g., USA, EU, Japan). Semi-Regulated markets have evolving frameworks. Emerging markets have developing regulatory infrastructure. Unregulated markets have minimal oversight. Drives market access strategy, clinical trial site selection, and supply chain compliance requirements.. Valid values are `Regulated|Semi-Regulated|Emerging|Unregulated`',
    `pharmacovigilance_requirement_level` STRING COMMENT 'Classification of the countrys pharmacovigilance and adverse event reporting requirements. Stringent: mandatory ICSR reporting, SUSAR expedited reporting, periodic safety update reports (e.g., USA, EU, Japan). Moderate: ICSR reporting required with longer timelines. Basic: minimal AE reporting. None: no formal PV requirements. Drives Argus Safety configuration and safety reporting workflows.. Valid values are `Stringent|Moderate|Basic|None`',
    `pics_member_flag` BOOLEAN COMMENT 'Indicates whether the countrys regulatory authority is a member of PIC/S, enabling mutual recognition of GMP inspections and reducing duplicate inspections for manufacturing sites. True if PIC/S member, False otherwise.',
    `primary_language_code` STRING COMMENT 'Two-letter ISO 639-1 language code for the countrys primary official language (e.g., en, ja, zh, de, fr). Used for labeling requirements, patient information leaflets, regulatory submission language, and Veeva PromoMats localization.. Valid values are `^[a-z]{2}$`',
    `region` STRING COMMENT 'High-level geographic region classification based on UN M49 standard. Used for regional sales reporting, supply chain planning, and market access strategy segmentation.. Valid values are `Africa|Americas|Asia|Europe|Oceania`',
    `regulatory_authority_code` STRING COMMENT 'Standardized code or abbreviation for the primary regulatory authority (e.g., FDA, EMA, MHRA, PMDA, NMPA). Used in Veeva Vault RIM, RIMS systems, and regulatory submission workflows.',
    `regulatory_authority_name` STRING COMMENT 'Name of the primary national regulatory authority responsible for pharmaceutical product approvals, post-market surveillance, and GMP inspections (e.g., FDA, EMA, MHRA, PMDA, NMPA, Health Canada, TGA, Anvisa). Critical for routing regulatory submissions and managing compliance obligations.',
    `reimbursement_framework_type` STRING COMMENT 'Description of the countrys pharmaceutical reimbursement and pricing framework (e.g., government-negotiated pricing, health technology assessment (HTA) required, free pricing, reference pricing, value-based agreements). Impacts pricing strategy, market access timelines, and HEOR evidence requirements.',
    `serialization_requirement_flag` BOOLEAN COMMENT 'Indicates whether the country mandates unique serialization and track-and-trace for pharmaceutical products to prevent counterfeiting (e.g., EU FMD, US DSCSA, China NMPA serialization, South Korea PMDA serialization). True if serialization required, False otherwise. Drives packaging line configuration and supply chain system requirements.',
    `short_name` STRING COMMENT 'Commonly used short name for the country or territory, used in user interfaces, reports, and operational systems (e.g., United States, UK, Japan, China, Germany).',
    `sub_region` STRING COMMENT 'Sub-region classification within the broader region (e.g., Northern America, Western Europe, Eastern Asia, South-Eastern Asia, Southern Asia). Used for granular market segmentation and supply chain optimization.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this country master data record. Supports audit trail and data governance requirements.',
    CONSTRAINT pk_country PRIMARY KEY(`country_id`)
) COMMENT 'Reference master for countries and territories relevant to pharmaceutical operations, regulatory submissions, and commercial activities. Captures ISO 3166-1 alpha-2 and alpha-3 codes, country name, region, sub-region, regulatory authority (FDA, EMA, MHRA, PMDA, NMPA), ICH region membership, currency code, language, and pharmaceutical market classification (regulated, semi-regulated, unregulated). Supports regulatory submission routing, market access planning, and supply chain geography.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` (
    `atc_classification_id` BIGINT COMMENT 'Primary key for atc_classification',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: ATC level 5 codes reference INN substances. New FK inn_registry_id → inn_registry.masterdata_inn_registry_id. Remove inn_name as redundant.',
    `parent_atc_classification_id` BIGINT COMMENT 'Self-referencing FK on atc_classification (parent_atc_classification_id)',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Defined Daily Dose (DDD) measured in standard units of measure. New FK ddd_uom_id → unit_of_measure.uom_id. Remove ddd_unit (STRING) as redundant.',
    `administration_route` STRING COMMENT 'The route by which the drug is administered: O=Oral, P=Parenteral, R=Rectal, V=Vaginal, N=Nasal, Implant=Implant, Inhal=Inhalation, Instill=Instillation, SL=Sublingual/Buccal, TD=Transdermal. Critical for DDD assignment and clinical use. [ENUM-REF-CANDIDATE: O|P|R|V|N|Implant|Inhal|Instill|SL|TD — 10 candidates stripped; promote to reference product]',
    `atc_code` STRING COMMENT 'The complete 7-character WHO ATC code representing the full classification hierarchy from anatomical main group to chemical substance level (e.g., A10BA02 for metformin).. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `atc_level` STRING COMMENT 'The hierarchical level of the ATC code: 1=Anatomical main group (1 character), 2=Therapeutic subgroup (3 characters), 3=Pharmacological subgroup (4 characters), 4=Chemical subgroup (5 characters), 5=Chemical substance (7 characters).',
    `atc_level_1_code` STRING COMMENT 'First level anatomical main group code (single letter A-V) representing the organ or system on which the drug acts.. Valid values are `^[A-Z]$`',
    `atc_level_1_description` STRING COMMENT 'Full description of the anatomical main group (e.g., Alimentary tract and metabolism, Blood and blood forming organs, Cardiovascular system).',
    `atc_level_2_code` STRING COMMENT 'Second level therapeutic subgroup code (3 characters) representing the therapeutic main group.. Valid values are `^[A-Z][0-9]{2}$`',
    `atc_level_2_description` STRING COMMENT 'Full description of the therapeutic subgroup (e.g., Drugs used in diabetes, Antithrombotic agents).',
    `atc_level_3_code` STRING COMMENT 'Third level pharmacological subgroup code (4 characters) representing the pharmacological or therapeutic subgroup.. Valid values are `^[A-Z][0-9]{2}[A-Z]$`',
    `atc_level_3_description` STRING COMMENT 'Full description of the pharmacological subgroup (e.g., Blood glucose lowering drugs, excl. insulins, Platelet aggregation inhibitors excl. heparin).',
    `atc_level_4_code` STRING COMMENT 'Fourth level chemical subgroup code (5 characters) representing the chemical or therapeutic subgroup.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}$`',
    `atc_level_4_description` STRING COMMENT 'Full description of the chemical subgroup (e.g., Biguanides, Adenosine diphosphate (ADP) receptor inhibitors).',
    `atc_level_5_code` STRING COMMENT 'Fifth level chemical substance code (7 characters) representing the specific chemical substance or combination.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `atc_level_5_description` STRING COMMENT 'Full description of the chemical substance, typically the INN (International Nonproprietary Name) or combination name (e.g., metformin, clopidogrel).',
    `atc_note` STRING COMMENT 'Additional notes, clarifications, or special instructions related to the ATC classification, including usage restrictions, combination product details, or cross-references to related codes.',
    `atc_status` STRING COMMENT 'Current lifecycle status of the ATC code: active=currently in use, inactive=temporarily suspended, withdrawn=permanently removed from WHO ATC index, pending=under review for inclusion, deprecated=superseded by another code.. Valid values are `active|inactive|withdrawn|pending|deprecated`',
    `biosimilar_reference_flag` BOOLEAN COMMENT 'Indicates whether this biological substance serves as a reference product for biosimilar development and approval (True) or not (False). Relevant for biologics license applications.',
    `combination_product_flag` BOOLEAN COMMENT 'Indicates whether this ATC code represents a fixed-dose combination product containing two or more active pharmaceutical ingredients (True) or a single active substance (False).',
    `controlled_substance_schedule` STRING COMMENT 'The DEA schedule classification for controlled substances: I=High abuse potential no accepted medical use, II=High abuse potential with severe dependence, III=Moderate to low abuse potential, IV=Low abuse potential, V=Lowest abuse potential, Not Controlled=Not a controlled substance.. Valid values are `I|II|III|IV|V|Not Controlled`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ATC classification record was first created in the master data system.',
    `ddd_value` DECIMAL(18,2) COMMENT 'The assumed average maintenance dose per day for a drug used for its main indication in adults, expressed as a numeric value. Used for drug utilization studies and pharmacoeconomic analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this ATC classification record was last updated or modified in the master data system.',
    `mdm_golden_record_flag` BOOLEAN COMMENT 'Indicates whether this record is the master golden record (True) or a duplicate/historical version (False) in the enterprise master data management system.',
    `orphan_drug_designation_flag` BOOLEAN COMMENT 'Indicates whether this substance has received orphan drug designation from FDA or EMA for treatment of rare diseases affecting small patient populations (True) or not (False).',
    `source_system_code` STRING COMMENT 'Identifier of the source system from which this ATC classification record was loaded (e.g., SAP MM, Veeva Vault RIM, external WHO ATC reference feed).',
    `therapeutic_equivalence_group` STRING COMMENT 'Grouping code for substances considered therapeutically equivalent or interchangeable for the same indication, used in formulary management and substitution policies.',
    `valid_from_date` DATE COMMENT 'The date from which this ATC classification record becomes effective and valid for use in regulatory submissions, pharmacovigilance reporting, and commercial analytics.',
    `valid_to_date` DATE COMMENT 'The date until which this ATC classification record remains valid. Null indicates the record is currently active with no planned end date.',
    `who_publication_year` STRING COMMENT 'The year this ATC code was officially published or last updated by the WHO Collaborating Centre for Drug Statistics Methodology.',
    CONSTRAINT pk_atc_classification PRIMARY KEY(`atc_classification_id`)
) COMMENT 'Reference master for the WHO Anatomical Therapeutic Chemical (ATC) classification system used to classify pharmaceutical substances by organ/system and therapeutic, pharmacological, and chemical properties. Captures ATC code at all five levels (anatomical main group, therapeutic subgroup, pharmacological subgroup, chemical subgroup, chemical substance), ATC level description, DDD (Defined Daily Dose), DDD unit, and administration route. Serves as the global standard for drug classification across regulatory submissions, pharmacovigilance, and commercial analytics.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` (
    `masterdata_ndc_code_id` BIGINT COMMENT 'Unique identifier for the NDC code record in the master data system.',
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: NDC products classified by ATC system. New FK atc_classification_id → atc_classification.masterdata_atc_classification_id. Remove atc_code as redundant.',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: NDC codes represent marketed pharmaceutical products in the US, which are based on active pharmaceutical ingredients (APIs) identified by International Nonproprietary Names (INN). The existing nonpro',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: NDC codes have a strength STRING attribute (e.g., 500mg, 10mg/mL) that combines a numeric value and a unit of measure. Best practice is to split this into strength_value (DECIMAL) and strength_u',
    `active_ingredient_count` STRING COMMENT 'The number of distinct active pharmaceutical ingredients (APIs) in the drug product. Most products have 1; combination products have 2 or more.',
    `application_number` STRING COMMENT 'The FDA application number under which the drug product was approved. Format includes application type prefix (NDA for New Drug Application, ANDA for Abbreviated New Drug Application, BLA for Biologics License Application) followed by 6-digit number.. Valid values are `^(NDA|ANDA|BLA)d{6}$`',
    `biosimilar_flag` BOOLEAN COMMENT 'Indicates whether the biological product is a biosimilar (highly similar to an FDA-approved reference biological product). True if biosimilar, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this NDC master data record was first created in the MDM system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A calculated score (0.00 to 100.00) representing the completeness, accuracy, and consistency of the NDC master data record, used for data stewardship prioritization and reporting.',
    `dea_schedule` STRING COMMENT 'The controlled substance schedule classification assigned by the DEA if the drug has abuse potential. CI (Schedule I) through CV (Schedule V), or None for non-controlled substances.. Valid values are `CI|CII|CIII|CIV|CV|None`',
    `dosage_form` STRING COMMENT 'The physical form of the drug product (e.g., tablet, capsule, injection, solution, cream, patch). Standardized per FDA dosage form terminology.',
    `effective_end_date` DATE COMMENT 'The date on which this NDC master data record ceases to be effective. Null if the record is currently effective with no planned end date.',
    `effective_start_date` DATE COMMENT 'The date from which this NDC master data record is effective and valid for use in operational systems and reporting.',
    `end_marketing_date` DATE COMMENT 'The date on which the drug product was discontinued from commercial marketing in the United States. Null if the product is still actively marketed.',
    `interchangeable_biosimilar_flag` BOOLEAN COMMENT 'Indicates whether the biosimilar product has been designated by the FDA as interchangeable with the reference biological product, allowing pharmacy-level substitution. True if interchangeable, False otherwise.',
    `labeler_code` STRING COMMENT 'The first segment of the NDC identifying the labeler (manufacturer, repackager, or distributor) assigned by the FDA. Typically 4 or 5 digits.. Valid values are `^d{4,5}$`',
    `labeler_name` STRING COMMENT 'The legal name of the company responsible for labeling and marketing the drug product (manufacturer, repackager, or distributor).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this NDC master data record was last updated in the MDM system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `listing_expiration_date` DATE COMMENT 'The date on which the NDC listing expires or was discontinued in the FDA National Drug Code Directory. Products with expired listings are no longer actively marketed.',
    `marketing_status` STRING COMMENT 'The current marketing and distribution status of the drug product in the United States. Indicates whether the product is actively marketed as prescription, over-the-counter, or has been discontinued.. Valid values are `Prescription|Over-the-Counter|Discontinued|None`',
    `mdm_golden_record_flag` BOOLEAN COMMENT 'Indicates whether this NDC record is the authoritative golden record in the Master Data Management system, having passed data quality and stewardship validation. True if golden record, False if duplicate or unvalidated.',
    `ndc_number` STRING COMMENT 'The 10-digit or 11-digit National Drug Code assigned by the FDA to uniquely identify a drug product marketed in the United States. Format may be 5-4-1, 5-4-2, 5-3-2, or 4-4-2 depending on labeler, product, and package code segments.. Valid values are `^d{10}$|^d{11}$|^d{5}-d{4}-d{1}$|^d{5}-d{4}-d{2}$|^d{5}-d{3}-d{2}$|^d{4}-d{4}-d{2}$`',
    `package_code` STRING COMMENT 'The third segment of the NDC identifying the package size and type. Typically 1 or 2 digits.. Valid values are `^d{1,2}$`',
    `package_description` STRING COMMENT 'A textual description of the package configuration, including quantity, container type, and packaging hierarchy (e.g., 100 TABLET in 1 BOTTLE, 10 BLISTER PACK in 1 CARTON).',
    `pharm_class` STRING COMMENT 'The pharmacologic class or mechanism of action (MOA) of the active ingredient, describing how the drug works at the molecular or physiological level.',
    `product_code` STRING COMMENT 'The second segment of the NDC identifying the specific strength, dosage form, and formulation of the drug product. Typically 3 or 4 digits.. Valid values are `^d{3,4}$`',
    `product_type` STRING COMMENT 'The regulatory classification of the drug product type as defined by the FDA (e.g., Human Prescription Drug, Human OTC Drug, Biological Product, Vaccine).. Valid values are `Human Prescription Drug|Human OTC Drug|Biological Product|Vaccine|Plasma Derivative`',
    `proprietary_name` STRING COMMENT 'The brand or trade name under which the drug product is marketed (e.g., Lipitor, Advil). May be null for generic products marketed under nonproprietary name only.',
    `record_status` STRING COMMENT 'The current lifecycle status of the NDC master data record in the MDM system. Active records are available for operational use; Inactive records are deprecated; Pending Review records await steward validation; Archived records are retained for historical reference only.. Valid values are `Active|Inactive|Pending Review|Archived`',
    `rems_flag` BOOLEAN COMMENT 'Indicates whether the drug product is subject to a Risk Evaluation and Mitigation Strategy (REMS) program required by the FDA to ensure that benefits outweigh risks. True if REMS required, False otherwise.',
    `repackager_flag` BOOLEAN COMMENT 'Indicates whether the labeler is a repackager (repackages bulk drug product into smaller units) rather than the original manufacturer. True if repackager, False if original manufacturer or distributor.',
    `route_of_administration` STRING COMMENT 'The path by which the drug is administered to the patient (e.g., oral, intravenous, topical, subcutaneous, inhalation). Standardized per FDA route terminology.',
    `rx_otc_indicator` STRING COMMENT 'Indicates whether the drug product requires a prescription (Rx) or is available over-the-counter (OTC) without a prescription.. Valid values are `Rx|OTC`',
    `source_system_code` STRING COMMENT 'The code identifying the operational system of record from which this NDC master data was sourced (e.g., FDA_NDC for FDA National Drug Code Directory, SAP_MM for SAP Materials Management, VEEVA_RIM for Veeva Regulatory Information Management).. Valid values are `FDA_NDC|SAP_MM|VEEVA_RIM|MANUAL`',
    `start_marketing_date` DATE COMMENT 'The date on which the drug product was first commercially marketed in the United States under this NDC.',
    `strength` STRING COMMENT 'The concentration or potency of the active pharmaceutical ingredient (API) in the dosage form, including unit of measure (e.g., 10 mg, 500 mg/5 mL, 0.5%).',
    `therapeutic_equivalence_code` STRING COMMENT 'The FDA Orange Book therapeutic equivalence code indicating whether the drug product is therapeutically equivalent to a reference listed drug. Codes starting with A are considered therapeutically equivalent; codes starting with B are not.. Valid values are `^[A-B][A-Z]{1,2}$`',
    CONSTRAINT pk_masterdata_ndc_code PRIMARY KEY(`masterdata_ndc_code_id`)
) COMMENT 'Reference master for National Drug Codes (NDC) assigned to pharmaceutical products marketed in the United States. Captures NDC number (10-digit or 11-digit format), labeler code, product code, package code, proprietary name, nonproprietary name (INN/USAN), dosage form, route of administration, strength, labeler name, marketing status, application number (NDA/ANDA/BLA), and DEA schedule. Serves as the US product identifier for commercial, supply chain, and pharmacovigilance operations.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` (
    `inn_registry_id` BIGINT COMMENT 'Primary key for inn_registry',
    `active_moiety_inn` STRING COMMENT 'The INN of the active moiety (the molecule or ion responsible for physiological or pharmacological action) when the registered substance is a salt, ester, or other derivative. For example, imatinib mesylate (salt) has imatinib as the active moiety.',
    `atc_code` STRING COMMENT 'The WHO Anatomical Therapeutic Chemical classification code assigned to the substance. ATC codes classify drugs by organ system, therapeutic use, and chemical structure. Format is one letter followed by two digits, two letters, and two digits (e.g., L01XE01 for imatinib).. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `biosimilar_reference_inn` STRING COMMENT 'For biosimilar substances, the INN of the reference biologic product to which this biosimilar is compared. Null for non-biosimilar substances or originator biologics.',
    `breakthrough_therapy_designation_flag` BOOLEAN COMMENT 'Boolean indicator of whether the substance has received breakthrough therapy designation from the FDA, indicating preliminary clinical evidence of substantial improvement over existing therapies for serious conditions.',
    `cas_registry_number` STRING COMMENT 'The unique numerical identifier assigned by the Chemical Abstracts Service to the chemical substance. CAS numbers are globally recognized identifiers for chemical compounds used in regulatory filings, scientific literature, and supply chain documentation.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `controlled_substance_schedule` STRING COMMENT 'The DEA controlled substance schedule classification if the substance is subject to controlled substance regulations in the United States. Schedule I through V indicate varying levels of abuse potential and regulatory control; Not Controlled indicates no DEA scheduling.. Valid values are `schedule_I|schedule_II|schedule_III|schedule_IV|schedule_V|not_controlled`',
    `created_by_user` STRING COMMENT 'The user ID or system account that created this INN registry record in the master data system. Supports audit trail and data lineage requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this INN registry record was first created in the master data system. Supports audit trail, data lineage, and compliance with 21 CFR Part 11 electronic records requirements.',
    `effective_end_date` DATE COMMENT 'The date on which this INN registry record ceases to be effective. Null indicates the record is currently active. Supports temporal validity, version control, and historical tracking of withdrawn or superseded INNs.',
    `effective_start_date` DATE COMMENT 'The date from which this INN registry record is effective and valid for use in regulatory submissions, labeling, and scientific communications. Supports temporal validity and version control.',
    `inn_definition` STRING COMMENT 'The official WHO definition or description of the substance associated with the INN, including its chemical nature, biological origin, or therapeutic purpose. Provides context for the INN assignment.',
    `inn_language_variants` STRING COMMENT 'Alternative language-specific spellings or transliterations of the INN (e.g., Latin, French, Spanish, Russian, Arabic, Chinese). Stored as a delimited list or JSON structure to support multilingual regulatory submissions and labeling.',
    `inn_name` STRING COMMENT 'The official International Nonproprietary Name assigned by the World Health Organization (WHO) for the pharmaceutical substance. This is the globally recognized nonproprietary name used across regulatory submissions, scientific literature, and labeling.',
    `inn_status` STRING COMMENT 'Current status of the INN designation in the WHO publication lifecycle. Proposed indicates initial submission; Recommended indicates WHO expert committee approval; Published indicates final inclusion in WHO INN list; Withdrawn indicates retraction.. Valid values are `proposed|recommended|published|withdrawn`',
    `inn_stem` STRING COMMENT 'The suffix or stem used in the INN name that indicates the pharmacological or chemical class (e.g., -mab for monoclonal antibodies, -tinib for tyrosine kinase inhibitors, -pril for ACE inhibitors). INN stems provide systematic nomenclature consistency.',
    `iupac_name` STRING COMMENT 'The systematic chemical name of the substance according to IUPAC nomenclature rules. Provides unambiguous chemical structure identification, primarily applicable to small molecules.',
    `last_modified_by_user` STRING COMMENT 'The user ID or system account that last modified this INN registry record. Supports audit trail and change tracking requirements for master data governance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this INN registry record was last modified in the master data system. Supports audit trail, change tracking, and compliance with 21 CFR Part 11 electronic records requirements.',
    `mdm_golden_record_flag` BOOLEAN COMMENT 'Boolean indicator of whether this record is the authoritative golden record in the MDM system for this INN. True indicates this is the master record; False indicates a duplicate or non-authoritative record.',
    `mechanism_of_action` STRING COMMENT 'A description of the biochemical or physiological mechanism by which the substance exerts its therapeutic effect (e.g., inhibits BCR-ABL tyrosine kinase, blocks TNF-alpha receptor). Critical for regulatory submissions and scientific communications.',
    `molecular_formula` STRING COMMENT 'The chemical molecular formula representing the elemental composition of the substance (e.g., C20H27N7O for imatinib). Applicable primarily to small molecules; may be null for biologics and complex substances.',
    `molecular_weight` DECIMAL(18,2) COMMENT 'The molecular weight of the substance expressed in Daltons (Da) or grams per mole (g/mol). Critical for dosing calculations, formulation development, and analytical method specifications.',
    `orphan_drug_designation_flag` BOOLEAN COMMENT 'Boolean indicator of whether the substance has received orphan drug designation from FDA, EMA, or other regulatory authorities for treatment of rare diseases. True indicates orphan designation has been granted; False indicates no orphan designation.',
    `pharmacological_class` STRING COMMENT 'The therapeutic or pharmacological classification of the substance based on its mechanism of action or therapeutic use (e.g., kinase inhibitor, monoclonal antibody, beta-lactam antibiotic, ACE inhibitor). Provides insight into the drugs mode of action and therapeutic category.',
    `record_status` STRING COMMENT 'The current lifecycle status of this master data record. Active indicates the record is current and in use; Inactive indicates the record is no longer in use but retained for historical reference; Deprecated indicates the record has been superseded; Under Review indicates the record is being validated or updated.. Valid values are `active|inactive|deprecated|under_review`',
    `route_of_administration` STRING COMMENT 'The typical or approved route(s) by which the substance is administered to patients (e.g., oral, intravenous, subcutaneous, inhalation, topical). May contain multiple routes separated by semicolons if the substance has multiple approved formulations.',
    `source_system_code` STRING COMMENT 'The code or identifier of the source system from which this INN registry record was ingested or synchronized (e.g., WHO_INN_DB, USAN_REGISTRY, SAP_MDM). Supports data lineage and master data governance.',
    `substance_class` STRING COMMENT 'High-level classification of the pharmaceutical substance type. Small molecule refers to chemically synthesized drugs; Biologic refers to protein-based therapeutics; Vaccine refers to immunization products; Gene therapy and Cell therapy refer to advanced therapeutic modalities; Oligonucleotide refers to nucleic acid-based drugs.. Valid values are `small_molecule|biologic|vaccine|gene_therapy|cell_therapy|oligonucleotide`',
    `therapeutic_area` STRING COMMENT 'The primary therapeutic area or disease category for which the substance is intended (e.g., oncology, immunology, cardiovascular, infectious disease, rare disease). Aligns with pharmaceutical business segmentation.',
    `usan_name` STRING COMMENT 'The United States Adopted Name for the pharmaceutical substance as designated by the USAN Council. May differ from INN in some cases but typically aligns with WHO INN nomenclature.',
    `who_inn_list_number` STRING COMMENT 'The sequential WHO INN list number in which the substance was published. WHO publishes INN lists periodically; this number references the specific publication edition.',
    `who_publication_date` DATE COMMENT 'The date on which the INN was officially published by the WHO in the INN list. Represents the formal recognition date of the nonproprietary name.',
    `who_publication_reference` STRING COMMENT 'The full citation or reference to the WHO document or publication in which the INN was announced. Typically includes WHO Drug Information volume and issue number.',
    CONSTRAINT pk_inn_registry PRIMARY KEY(`inn_registry_id`)
) COMMENT 'Reference master for International Nonproprietary Names (INN) as assigned by the WHO for pharmaceutical substances. Captures INN name, USAN (United States Adopted Name), recommended INN status, substance class (small molecule, biologic, vaccine, gene therapy), pharmacological class, CAS registry number, molecular formula, and WHO INN publication reference. Serves as the global nonproprietary naming standard for drug substances across regulatory submissions, labeling, and scientific communications.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`masterdata`.`address` (
    `address_id` BIGINT COMMENT 'Primary key for address',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Address references country for geographic/regulatory context. New FK column country_id will link to country.country_id. Existing country_code (STRING) remains for code-level reference; new FK provides',
    `active_status` STRING COMMENT 'Current lifecycle status of the address record. Active addresses are currently in use, inactive addresses are no longer valid but retained for historical reference, pending addresses are awaiting approval or validation, and archived addresses are historical records retained for compliance.. Valid values are `active|inactive|pending|archived`',
    `address_type` STRING COMMENT 'Classification of the address purpose within pharmaceutical operations. Registered addresses are used for regulatory filings and legal documentation, operational addresses represent active business locations, shipping addresses are used for logistics and distribution, billing addresses are used for invoicing, clinical site addresses represent trial locations, and manufacturing addresses represent production facilities.. Valid values are `registered|operational|shipping|billing|clinical_site|manufacturing`',
    `city` STRING COMMENT 'City or municipality name where the address is located. Used for geographic segmentation, logistics planning, and regulatory reporting by jurisdiction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was first created in the master data system. Used for audit trail, data lineage tracking, and compliance with 21 CFR Part 11 electronic records requirements.',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet DUNS number uniquely identifying the business entity at this address. Used for vendor qualification, supply chain due diligence, and compliance with pharmaceutical procurement standards.. Valid values are `^[0-9]{9}$`',
    `effective_end_date` DATE COMMENT 'Date when this address ceased to be valid or was replaced by a new address. Null for currently active addresses. Used for historical reporting and compliance with Good Documentation Practice (GDP) requirements.',
    `effective_start_date` DATE COMMENT 'Date when this address became valid and active for business use. Used for temporal tracking of address changes, critical for audit trails and regulatory inspection history.',
    `email_address` STRING COMMENT 'Primary email contact for the address location. Used for electronic communication, document transmission, and coordination with Contract Manufacturing Organizations (CMO), Contract Research Organizations (CRO), and regulatory authorities.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the address location. Still used in pharmaceutical industry for transmitting regulatory documents, Certificates of Analysis (CoA), and Good Manufacturing Practice (GMP) documentation where electronic signatures are not yet implemented.',
    `gmp_certified_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether the address location holds current Good Manufacturing Practice (cGMP) certification. True indicates the site is certified for pharmaceutical manufacturing under FDA, EMA, or other regulatory authority standards.',
    `language_code` STRING COMMENT 'Two-letter ISO language code indicating the primary language used at this address location. Used for generating localized documentation, labeling, and communication in compliance with regional regulatory requirements.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this address record. Used for change tracking, data quality monitoring, and ensuring compliance with Good Documentation Practice (GDP) requirements for maintaining current and accurate master data.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees format. Used for geospatial analytics, supply chain route optimization, clinical trial site mapping, and emergency response planning for manufacturing facilities.',
    `line_1` STRING COMMENT 'Primary street address line containing street number, street name, and building identifier. This is the main address component used for physical location identification and postal delivery.',
    `line_2` STRING COMMENT 'Secondary address line for additional location details such as suite number, floor, building name, department, or unit identifier. Optional field used when address_line_1 is insufficient for precise location identification.',
    `line_3` STRING COMMENT 'Tertiary address line for complex addresses requiring additional location context such as industrial park name, campus identifier, or district information. Rarely used but necessary for large pharmaceutical manufacturing complexes or research campuses.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees format. Used in conjunction with latitude for precise geolocation, distribution center proximity analysis, and cold chain logistics planning.',
    `mdm_golden_record_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether this address is the authoritative golden record in the Master Data Management (MDM) system. True indicates this is the single source of truth (SSOT) for this address across all enterprise systems.',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the address location. Used for logistics coordination, emergency contact, and operational communication with manufacturing sites, distribution centers, and clinical trial sites.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for mail delivery and geographic precision. Format varies by country (e.g., 5-digit ZIP in USA, alphanumeric in Canada and UK). Used for logistics optimization, territory assignment, and distribution planning.',
    `primary_address_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether this is the primary or default address for the associated entity (vendor, customer, plant, site). True indicates this is the main address used for official correspondence and regulatory filings.',
    `regulatory_site_identifier` STRING COMMENT 'Official site registration number or establishment identifier assigned by regulatory authorities such as FDA Establishment Identifier (FEI), EMA site number, or PMDA registration number. Required for regulatory submissions and inspection tracking.',
    `sap_address_number` STRING COMMENT 'SAP S/4HANA system address number linking this master data address to the corresponding address record in SAP modules (MM, SD, FI). Enables cross-system reconciliation and ensures consistency between lakehouse and operational ERP system.',
    `standardization_date` DATE COMMENT 'Date when the address was last validated or standardized against postal authority databases. Used to determine when re-validation is required, as addresses may become outdated due to postal code changes or street renaming.',
    `standardization_source` STRING COMMENT 'The authoritative postal service or third-party vendor used to validate and standardize the address format. Identifies which national postal authority or address verification service confirmed the address accuracy. [ENUM-REF-CANDIDATE: USPS|Royal_Mail|Deutsche_Post|Canada_Post|Australia_Post|manual|third_party — 7 candidates stripped; promote to reference product]',
    `state_province` STRING COMMENT 'State, province, region, or administrative division within the country. Critical for regulatory compliance as pharmaceutical licensing and Good Manufacturing Practice (GMP) certifications are often issued at state or provincial level.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the address location (e.g., America/New_York, Europe/London). Critical for coordinating global clinical trials, manufacturing schedules, and supply chain operations across multiple time zones.',
    `validation_status` STRING COMMENT 'Status indicating whether the address has been verified against authoritative postal databases. Validated addresses have been confirmed by postal authority services (USPS, Royal Mail, Deutsche Post), unvalidated addresses have not been checked, failed addresses could not be verified, pending addresses are queued for validation, and manual override indicates business approval despite validation failure.. Valid values are `validated|unvalidated|failed|pending|manual_override`',
    CONSTRAINT pk_address PRIMARY KEY(`address_id`)
) COMMENT 'Master record for standardized physical and postal addresses used across pharmaceutical operations including manufacturing sites, distribution centers, clinical trial sites, vendor locations, and customer ship-to/bill-to addresses. Captures address line 1-3, city, state/province, postal code, country, address type (registered, operational, shipping, billing), geocoordinates, address validation status, and standardization source (USPS, Royal Mail, Deutsche Post). Serves as the cross-domain address SSOT referenced by vendor, customer, plant, and site entities.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` (
    `business_partner_id` BIGINT COMMENT 'Unique identifier for the business partner record. Primary key for the business partner master data entity.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Business partners domiciled in countries. New FK country_id → country.country_id provides relational link. Existing country_code (STRING) remains for code reference.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Business partners (especially subsidiaries, affiliates) may be linked to legal entities for consolidation and intercompany transactions. New FK legal_entity_id → legal_entity.legal_entity_id.',
    `address_id` BIGINT COMMENT 'FK to masterdata.address',
    `avl_flag` BOOLEAN COMMENT 'Boolean indicator whether this business partner is on the Approved Vendor List. True indicates the partner is approved for procurement and manufacturing activities.',
    `bank_account_number` STRING COMMENT 'Bank account number for payment processing. Encrypted at rest and in transit per PCI DSS and SOX requirements.',
    `blocking_indicator` STRING COMMENT 'Indicates whether the business partner is blocked for specific business functions (sales, purchasing, payment) due to compliance, quality, or financial issues.. Valid values are `not_blocked|sales_blocked|purchasing_blocked|payment_blocked|fully_blocked`',
    `bp_category` STRING COMMENT 'Classification of the business partner entity type: person (individual), organization (company/institution), or group (corporate group).. Valid values are `person|organization|group`',
    `bp_number` STRING COMMENT 'The externally-known unique business partner number assigned by SAP S/4HANA. This is the authoritative business identifier used across all systems for external party identity.. Valid values are `^[A-Z0-9]{10}$`',
    `bp_role` STRING COMMENT 'Comma-separated list of roles assigned to this business partner. Roles include: supplier, customer, carrier, CMO (Contract Manufacturing Organization), CRO (Contract Research Organization), CDMO (Contract Development and Manufacturing Organization), distributor, wholesaler, hospital, pharmacy, GPO (Group Purchasing Organization), government agency. A single BP may hold multiple roles.',
    `business_partner_status` STRING COMMENT 'Current lifecycle status of the business partner record. Active indicates the partner is approved for transactions; inactive/suspended/terminated indicate various states of non-availability.. Valid values are `active|inactive|pending|suspended|terminated`',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity that transacts with this business partner. Used for financial accounting and legal reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this business partner record was first created in the system. Immutable audit field.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit limit extended to this business partner for customer roles. Used for credit management and order release workflows.',
    `credit_limit_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit limit amount.. Valid values are `^[A-Z]{3}$`',
    `dea_registration_number` STRING COMMENT 'DEA registration number for business partners authorized to handle controlled substances. Required for API suppliers, CMOs, distributors, and pharmacies dealing with Schedule II-V drugs.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet. Used for credit assessment, supplier qualification, and global business identification.. Valid values are `^[0-9]{9}$`',
    `effective_end_date` DATE COMMENT 'Date until which this business partner record is valid. Null indicates an open-ended relationship.',
    `effective_start_date` DATE COMMENT 'Date from which this business partner record is effective and valid for transactions.',
    `email_address` STRING COMMENT 'Primary email address for business communications with the business partner.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fda_establishment_identifier` STRING COMMENT 'FDA-assigned unique facility identifier for establishments engaged in the manufacture, preparation, propagation, compounding, or processing of drugs. Required for FDA registration and DSCSA compliance.',
    `gln` STRING COMMENT '13-digit GS1 Global Location Number uniquely identifying the business partners physical, functional, or legal entity location. Used in supply chain and EDI transactions.. Valid values are `^[0-9]{13}$`',
    `gmp_certification_status` STRING COMMENT 'Current GMP certification status for manufacturing and laboratory partners. Critical for supplier qualification and AVL (Approved Vendor List) maintenance.. Valid values are `certified|provisional|suspended|expired|not_certified`',
    `gmp_expiry_date` DATE COMMENT 'Expiration date of the current GMP certification. Triggers re-qualification workflows and AVL review.',
    `iban` STRING COMMENT 'International Bank Account Number for SEPA and international wire transfers. Used for business partners in IBAN-participating countries.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]+$`',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality or compliance audit conducted at the business partners facility. Used to track audit frequency and schedule re-audits.',
    `legal_name` STRING COMMENT 'The full legal name of the business partner as registered with government authorities. Used for contracts, regulatory submissions, and legal documentation.',
    `lims_supplier_code` STRING COMMENT 'Cross-system identifier linking this business partner to the supplier master in LIMS for reagent, reference standard, and consumable procurement tracking.',
    `mdm_golden_record_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this record is the authoritative golden record in the MDM system. True indicates this is the single source of truth for this business partner.',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code defining the payment schedule and conditions for transactions with this business partner (e.g., NET30, NET60, 2/10 NET30).',
    `phone_number` STRING COMMENT 'Primary contact phone number for the business partner, including country code.',
    `qualification_status` STRING COMMENT 'Current qualification status of the business partner as a supplier. Reflects the outcome of supplier audits, quality assessments, and compliance reviews.. Valid values are `qualified|pending|disqualified|under_review|not_qualified`',
    `risk_classification` STRING COMMENT 'Risk classification assigned to the business partner based on criticality of supplied materials, quality history, regulatory compliance, and business continuity factors.. Valid values are `low|medium|high|critical`',
    `swift_code` STRING COMMENT 'SWIFT/BIC code identifying the business partners bank for international payments and wire transfers.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `tax_identification_number` STRING COMMENT 'The primary tax identification number assigned by the tax authority in the business partners country of registration. For US entities, this is the EIN (Employer Identification Number) or SSN for sole proprietors.',
    `veeva_account_code` STRING COMMENT 'Cross-system identifier linking this business partner to the corresponding account record in Veeva CRM for commercial and medical affairs integration.',
    CONSTRAINT pk_business_partner PRIMARY KEY(`business_partner_id`)
) COMMENT 'Unified master record and Single Source of Truth (SSOT) for ALL external business partners in the pharmaceutical enterprise, following the SAP S/4HANA Business Partner model. Encompasses all vendor/supplier roles (API suppliers, CMOs, CDMOs, CROs, excipient suppliers, packaging suppliers, laboratory reagent vendors) and all customer roles (wholesalers, distributors, hospital networks, pharmacy chains, GPOs, government health agencies) under a single authoritative identity. Captures BP number, BP category (person, organization, group), BP role(s) (supplier, customer, carrier, CMO, CRO, distributor), legal name, tax identification numbers, GMP certification status, qualification status, approved vendor list (AVL) flag, DEA registration number, HIN (Health Industry Number), GLN (Global Location Number), payment terms, credit limits, bank details, sales organization assignment, distribution channel, currency, and cross-system identifiers (SAP BP number, Veeva account ID, LIMS supplier code). Role-specific attributes maintained per role assignment. This is the sole authoritative product for external party identity — no other product in this domain masters vendor or customer identity.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ADD CONSTRAINT `fk_masterdata_legal_entity_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ADD CONSTRAINT `fk_masterdata_legal_entity_parent_entity_legal_entity_id` FOREIGN KEY (`parent_entity_legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ADD CONSTRAINT `fk_masterdata_legal_entity_primary_ultimate_parent_entity_legal_entity_id` FOREIGN KEY (`primary_ultimate_parent_entity_legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ADD CONSTRAINT `fk_masterdata_legal_entity_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ADD CONSTRAINT `fk_masterdata_org_unit_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ADD CONSTRAINT `fk_masterdata_org_unit_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ADD CONSTRAINT `fk_masterdata_org_unit_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ADD CONSTRAINT `fk_masterdata_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ADD CONSTRAINT `fk_masterdata_org_unit_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ADD CONSTRAINT `fk_masterdata_cost_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ADD CONSTRAINT `fk_masterdata_cost_center_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ADD CONSTRAINT `fk_masterdata_cost_center_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ADD CONSTRAINT `fk_masterdata_cost_center_profit_center_id` FOREIGN KEY (`profit_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`profit_center`(`profit_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ADD CONSTRAINT `fk_masterdata_profit_center_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ADD CONSTRAINT `fk_masterdata_profit_center_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ADD CONSTRAINT `fk_masterdata_chart_of_accounts_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ADD CONSTRAINT `fk_masterdata_material_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ADD CONSTRAINT `fk_masterdata_material_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ADD CONSTRAINT `fk_masterdata_material_masterdata_ndc_code_id` FOREIGN KEY (`masterdata_ndc_code_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code`(`masterdata_ndc_code_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ADD CONSTRAINT `fk_masterdata_material_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ADD CONSTRAINT `fk_masterdata_plant_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ADD CONSTRAINT `fk_masterdata_plant_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ADD CONSTRAINT `fk_masterdata_plant_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ADD CONSTRAINT `fk_masterdata_plant_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ADD CONSTRAINT `fk_masterdata_plant_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`org_unit`(`org_unit_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ADD CONSTRAINT `fk_masterdata_storage_location_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ADD CONSTRAINT `fk_masterdata_storage_location_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ADD CONSTRAINT `fk_masterdata_storage_location_cost_center_id` FOREIGN KEY (`cost_center_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`cost_center`(`cost_center_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ADD CONSTRAINT `fk_masterdata_storage_location_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ADD CONSTRAINT `fk_masterdata_storage_location_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`plant`(`plant_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ADD CONSTRAINT `fk_masterdata_unit_of_measure_base_unit_of_measure_id` FOREIGN KEY (`base_unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ADD CONSTRAINT `fk_masterdata_atc_classification_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ADD CONSTRAINT `fk_masterdata_atc_classification_parent_atc_classification_id` FOREIGN KEY (`parent_atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ADD CONSTRAINT `fk_masterdata_atc_classification_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ADD CONSTRAINT `fk_masterdata_masterdata_ndc_code_atc_classification_id` FOREIGN KEY (`atc_classification_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`atc_classification`(`atc_classification_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ADD CONSTRAINT `fk_masterdata_masterdata_ndc_code_inn_registry_id` FOREIGN KEY (`inn_registry_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`inn_registry`(`inn_registry_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ADD CONSTRAINT `fk_masterdata_masterdata_ndc_code_unit_of_measure_id` FOREIGN KEY (`unit_of_measure_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure`(`unit_of_measure_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ADD CONSTRAINT `fk_masterdata_address_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ADD CONSTRAINT `fk_masterdata_business_partner_country_id` FOREIGN KEY (`country_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`country`(`country_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ADD CONSTRAINT `fk_masterdata_business_partner_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ADD CONSTRAINT `fk_masterdata_business_partner_address_id` FOREIGN KEY (`address_id`) REFERENCES `pharmaceuticals_ecm`.`masterdata`.`address`(`address_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`masterdata` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `pharmaceuticals_ecm`.`masterdata` SET TAGS ('dbx_domain' = 'masterdata');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` SET TAGS ('dbx_subdomain' = 'enterprise_structure');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Legal Entity Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `primary_ultimate_parent_entity_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Parent Legal Entity Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `consolidation_group` SET TAGS ('dbx_business_glossary_term' = 'Financial Consolidation Group');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Master Data Quality Score');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `data_steward_name` SET TAGS ('dbx_business_glossary_term' = 'Master Data Steward Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Dissolution');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `ema_organization_code` SET TAGS ('dbx_business_glossary_term' = 'European Medicines Agency (EMA) Organization Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `entity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|dissolved|merged|acquired|pending_formation');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Type');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'operating_company|holding_company|joint_venture|subsidiary|branch|partnership');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `fda_establishment_identifier` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Establishment Identifier (FEI)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `fiscal_year_end_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year End Month');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `functional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `gmp_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certification Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `gmp_certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|expired|not_applicable|suspended');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `incorporation_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Incorporation');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `industry_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `iso_certification_status` SET TAGS ('dbx_business_glossary_term' = 'ISO Certification Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `legal_form` SET TAGS ('dbx_business_glossary_term' = 'Legal Form Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `lei_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `primary_business_activity` SET TAGS ('dbx_business_glossary_term' = 'Primary Business Activity Description');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `reporting_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `sap_company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `sap_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Short Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `stock_exchange_listing` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Listing Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `stock_ticker_symbol` SET TAGS ('dbx_business_glossary_term' = 'Stock Ticker Symbol');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`legal_entity` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` SET TAGS ('dbx_subdomain' = 'enterprise_structure');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Address Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organization Unit ID');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `gcp_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Clinical Practice (GCP) Regulated Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `glp_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Laboratory Practice (GLP) Regulated Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `gmp_regulated_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Regulated Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `headcount_fte` SET TAGS ('dbx_business_glossary_term' = 'Headcount Full-Time Equivalent (FTE)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|dissolved');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `qms_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Management System (QMS) Scope Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `sap_org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'SAP S/4HANA Organization Unit ID');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `site_location` SET TAGS ('dbx_business_glossary_term' = 'Site Location');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `unit_level` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit Hierarchy Level');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `unit_short_name` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit Short Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit Type');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` SET TAGS ('dbx_subdomain' = 'financial_organization');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `activity_type_indicator` SET TAGS ('dbx_business_glossary_term' = 'Activity Type Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `budget_profile` SET TAGS ('dbx_business_glossary_term' = 'Budget Profile');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area (CO) Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Category');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `cost_center_category` SET TAGS ('dbx_value_regex' = 'production|administration|research_and_development|sales_and_marketing|quality_control|regulatory_affairs');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `cost_center_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Description');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `cost_center_name` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `cost_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|planned');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `cost_center_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Type');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Classification');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_value_regex' = 'gmp_critical|gmp_non_critical|non_gmp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `hierarchy_area` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Area');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_value_regex' = 'unlocked|locked_actual|locked_plan|locked_all');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `mdm_golden_record_flag` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Golden Record Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `planning_group` SET TAGS ('dbx_business_glossary_term' = 'Planning Group');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `sox_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Relevant Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `statistical_cost_center_flag` SET TAGS ('dbx_business_glossary_term' = 'Statistical Cost Center Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`cost_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` SET TAGS ('dbx_subdomain' = 'financial_organization');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `analysis_period` SET TAGS ('dbx_business_glossary_term' = 'Analysis Period');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `analysis_period` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_business_glossary_term' = 'Controlling Area Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `controlling_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `cost_center_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Group');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `dummy_profit_center_flag` SET TAGS ('dbx_business_glossary_term' = 'Dummy Profit Center Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `functional_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,16}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'north_america|europe|asia_pacific|latin_america|middle_east_africa|global');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `hierarchy_node` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Hierarchy Node');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `lock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Lock Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `profit_center_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `profit_center_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|closed');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Type');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `profit_center_type` SET TAGS ('dbx_value_regex' = 'operating|support|corporate|research|manufacturing|commercial');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Short Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`profit_center` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` SET TAGS ('dbx_subdomain' = 'financial_organization');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (COA) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `account_group` SET TAGS ('dbx_business_glossary_term' = 'Account Group Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `account_short_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Short Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending_closure');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type Classification');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'asset|liability|equity|revenue|expense');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_business_glossary_term' = 'Balance Sheet Classification');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `balance_sheet_classification` SET TAGS ('dbx_value_regex' = 'current_asset|non_current_asset|current_liability|non_current_liability|equity|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `controlling_area_integration` SET TAGS ('dbx_business_glossary_term' = 'Controlling (CO) Area Integration Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Category');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `cost_element_category` SET TAGS ('dbx_value_regex' = 'primary|secondary|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `cost_element_indicator` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Indicator Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `currency_type` SET TAGS ('dbx_business_glossary_term' = 'Currency Type');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `currency_type` SET TAGS ('dbx_value_regex' = 'local|group|hard|index|global');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `financial_statement_category` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Category');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `financial_statement_category` SET TAGS ('dbx_value_regex' = 'balance_sheet|profit_and_loss|cash_flow|retained_earnings');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `ifrs_mapping_code` SET TAGS ('dbx_business_glossary_term' = 'International Financial Reporting Standards (IFRS) Mapping Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `line_item_display` SET TAGS ('dbx_business_glossary_term' = 'Line Item Display Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `milestone_revenue_indicator` SET TAGS ('dbx_business_glossary_term' = 'Milestone Revenue Recognition Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `open_item_management` SET TAGS ('dbx_business_glossary_term' = 'Open Item Management Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `pl_classification` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Classification');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `pl_classification` SET TAGS ('dbx_value_regex' = 'operating_revenue|non_operating_revenue|cost_of_sales|operating_expense|non_operating_expense|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `posting_block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Posting Block Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `profit_center_update_indicator` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Update Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `rd_capitalization_eligible` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Capitalization Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `reconciliation_account_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Account Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `royalty_accrual_indicator` SET TAGS ('dbx_business_glossary_term' = 'Royalty Accrual Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `sort_key` SET TAGS ('dbx_business_glossary_term' = 'Account Sort Key');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `subledger_type` SET TAGS ('dbx_business_glossary_term' = 'Subledger Type');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `subledger_type` SET TAGS ('dbx_value_regex' = 'accounts_receivable|accounts_payable|fixed_assets|materials_management|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `us_gaap_mapping_code` SET TAGS ('dbx_business_glossary_term' = 'United States Generally Accepted Accounting Principles (US GAAP) Mapping Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`chart_of_accounts` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` SET TAGS ('dbx_subdomain' = 'product_reference');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `masterdata_ndc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Code Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Base Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `batch_managed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'SCHEDULE_I|SCHEDULE_II|SCHEDULE_III|SCHEDULE_IV|SCHEDULE_V|NON_CONTROLLED');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Classification');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `gmp_classification` SET TAGS ('dbx_value_regex' = 'GMP_CRITICAL|GMP_MAJOR|GMP_MINOR|NON_GMP');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `lims_material_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Material Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|BLOCKED|OBSOLETE|PENDING_APPROVAL|DISCONTINUED|QUARANTINE');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `mes_material_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES) Material Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `minimum_remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Remaining Shelf Life (Days)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'PURCHASED|MANUFACTURED|BOTH|CONSIGNMENT');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `retest_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Retest Interval (Days)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `serial_number_profile` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Profile');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `temperature_sensitive_indicator` SET TAGS ('dbx_business_glossary_term' = 'Temperature Sensitive Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `usan_name` SET TAGS ('dbx_business_glossary_term' = 'United States Adopted Name (USAN)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Volume');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'L|ML|M3|FT3|GAL');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`material` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'KG|G|MG|LB|OZ');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` SET TAGS ('dbx_subdomain' = 'enterprise_structure');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Address Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit Of Measure Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `annual_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Annual Capacity Units');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `capacity_class` SET TAGS ('dbx_business_glossary_term' = 'Capacity Class');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `capacity_class` SET TAGS ('dbx_value_regex' = 'small|medium|large|extra_large');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Registration Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `ema_site_number` SET TAGS ('dbx_business_glossary_term' = 'European Medicines Agency (EMA) Site Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `ema_site_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `environmental_permit_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `environmental_permit_status` SET TAGS ('dbx_value_regex' = 'valid|expired|pending|suspended|not_required');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `fda_establishment_identifier` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Establishment Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `fda_establishment_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{7,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `gmp_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certification Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `gmp_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certification Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `gmp_certification_status` SET TAGS ('dbx_value_regex' = 'certified|expired|pending|suspended|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `gmp_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `iso_certification_status` SET TAGS ('dbx_business_glossary_term' = 'ISO Certification Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `iso_certification_status` SET TAGS ('dbx_value_regex' = 'certified|expired|pending|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `lims_system` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `manufacturing_execution_system` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Execution System (MES)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|temporarily_closed|pending_approval');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `plant_name` SET TAGS ('dbx_business_glossary_term' = 'Plant Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `plant_type` SET TAGS ('dbx_business_glossary_term' = 'Plant Type');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `plant_type` SET TAGS ('dbx_value_regex' = 'manufacturing|packaging|distribution|research_and_development|quality_control_laboratory|clinical_supply');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `quality_management_system` SET TAGS ('dbx_business_glossary_term' = 'Quality Management System (QMS)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Plant Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `sap_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`plant` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` SET TAGS ('dbx_subdomain' = 'enterprise_structure');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Address Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit Of Measure Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `capacity_storage_units` SET TAGS ('dbx_business_glossary_term' = 'Capacity in Storage Units');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `dea_license_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) License Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `dea_license_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `dea_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `dea_schedule_authorized` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule Authorized');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `dea_schedule_authorized` SET TAGS ('dbx_value_regex' = 'schedule_ii|schedule_iii|schedule_iv|schedule_v|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `gdp_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Distribution Practice (GDP) Compliant Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `gmp_zone_classification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Zone Classification');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `gmp_zone_classification` SET TAGS ('dbx_value_regex' = 'grade_a|grade_b|grade_c|grade_d|unclassified');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `hazmat_storage_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (Hazmat) Storage Class');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `hazmat_storage_class` SET TAGS ('dbx_value_regex' = 'flammable|corrosive|oxidizer|toxic|explosive|non_hazardous');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `humidity_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Relative Humidity (Percent)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `humidity_min_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Relative Humidity (Percent)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `last_qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Qualification Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `next_qualification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Qualification Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `quarantine_zone_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Zone Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `returns_processing_flag` SET TAGS ('dbx_business_glossary_term' = 'Returns Processing Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `sampling_location_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Sampling Location Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'high|medium|standard');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `segregation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Segregation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `storage_location_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `storage_location_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `storage_location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|under_qualification|decommissioned');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `storage_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Type');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Celsius)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Celsius)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `temperature_monitoring_system` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring System');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `temperature_monitoring_system` SET TAGS ('dbx_value_regex' = 'continuous_automated|periodic_manual|not_monitored');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`storage_location` ALTER COLUMN `wms_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Integration Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` SET TAGS ('dbx_subdomain' = 'product_reference');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `base_unit_of_measure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `applicable_material_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Material Types');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `conversion_group` SET TAGS ('dbx_business_glossary_term' = 'Conversion Group');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `decimal_precision` SET TAGS ('dbx_business_glossary_term' = 'Decimal Precision');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `dimension_type` SET TAGS ('dbx_business_glossary_term' = 'Physical Dimension Type');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `is_base_uom` SET TAGS ('dbx_business_glossary_term' = 'Is Base Unit of Measure (UOM) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `is_commercial_uom` SET TAGS ('dbx_business_glossary_term' = 'Is Commercial Unit of Measure (UOM) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `is_laboratory_uom` SET TAGS ('dbx_business_glossary_term' = 'Is Laboratory Unit of Measure (UOM) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `is_manufacturing_uom` SET TAGS ('dbx_business_glossary_term' = 'Is Manufacturing Unit of Measure (UOM) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `iso_unit_code` SET TAGS ('dbx_business_glossary_term' = 'International Organization for Standardization (ISO) Unit Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `iso_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `mdm_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `mdm_approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `regulatory_standard` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Standard Reference');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `sap_internal_uom` SET TAGS ('dbx_business_glossary_term' = 'SAP Internal Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `sap_internal_uom` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,3}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `si_conversion_factor` SET TAGS ('dbx_business_glossary_term' = 'International System of Units (SI) Conversion Factor');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `unit_of_measure_status` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `unit_of_measure_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_approval');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `uom_category` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Category');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `uom_code` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `uom_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `uom_description` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Description');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`unit_of_measure` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` SET TAGS ('dbx_subdomain' = 'product_reference');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `clinical_trial_registration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Registration Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `controlled_substance_schedule_system` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule System');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `country_name` SET TAGS ('dbx_business_glossary_term' = 'Country Official Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `country_status` SET TAGS ('dbx_business_glossary_term' = 'Country Operational Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `country_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Restricted|Sanctioned');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `data_privacy_regulation` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Regulation Framework');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `distribution_license_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Distribution License Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Country Record Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Country Record Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `gmp_inspection_authority` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Inspection Authority');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `hta_body_name` SET TAGS ('dbx_business_glossary_term' = 'Health Technology Assessment (HTA) Body Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `ich_region_flag` SET TAGS ('dbx_business_glossary_term' = 'International Council for Harmonisation (ICH) Region Membership Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `ich_region_name` SET TAGS ('dbx_business_glossary_term' = 'International Council for Harmonisation (ICH) Region Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `ich_region_name` SET TAGS ('dbx_value_regex' = 'ICH Americas|ICH Europe|ICH Asia-Pacific|Non-ICH');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `iso_alpha_2_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Alpha-2 Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `iso_alpha_2_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `iso_alpha_3_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Alpha-3 Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `iso_alpha_3_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `iso_numeric_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Numeric Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `iso_numeric_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `market_access_tier` SET TAGS ('dbx_business_glossary_term' = 'Market Access Tier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `market_access_tier` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Emerging');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `patent_filing_authority` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Authority');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `pharmaceutical_market_classification` SET TAGS ('dbx_business_glossary_term' = 'Pharmaceutical Market Classification');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `pharmaceutical_market_classification` SET TAGS ('dbx_value_regex' = 'Regulated|Semi-Regulated|Emerging|Unregulated');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `pharmacovigilance_requirement_level` SET TAGS ('dbx_business_glossary_term' = 'Pharmacovigilance (PV) Requirement Level');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `pharmacovigilance_requirement_level` SET TAGS ('dbx_value_regex' = 'Stringent|Moderate|Basic|None');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `pics_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Pharmaceutical Inspection Co-operation Scheme (PIC/S) Member Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_business_glossary_term' = 'ISO Primary Language Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `primary_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'Africa|Americas|Asia|Europe|Oceania');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `regulatory_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Authority Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `reimbursement_framework_type` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Framework Type');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `serialization_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Product Serialization Requirement Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Country Short Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `sub_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Sub-Region');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`country` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` SET TAGS ('dbx_subdomain' = 'product_reference');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `parent_atc_classification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Ddd Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `administration_route` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'ATC (Anatomical Therapeutic Chemical) Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level` SET TAGS ('dbx_business_glossary_term' = 'ATC (Anatomical Therapeutic Chemical) Level');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level_1_code` SET TAGS ('dbx_business_glossary_term' = 'ATC (Anatomical Therapeutic Chemical) Level 1 Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level_1_code` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level_1_description` SET TAGS ('dbx_business_glossary_term' = 'ATC (Anatomical Therapeutic Chemical) Level 1 Description');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level_2_code` SET TAGS ('dbx_business_glossary_term' = 'ATC (Anatomical Therapeutic Chemical) Level 2 Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level_2_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level_2_description` SET TAGS ('dbx_business_glossary_term' = 'ATC (Anatomical Therapeutic Chemical) Level 2 Description');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level_3_code` SET TAGS ('dbx_business_glossary_term' = 'ATC (Anatomical Therapeutic Chemical) Level 3 Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level_3_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level_3_description` SET TAGS ('dbx_business_glossary_term' = 'ATC (Anatomical Therapeutic Chemical) Level 3 Description');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level_4_code` SET TAGS ('dbx_business_glossary_term' = 'ATC (Anatomical Therapeutic Chemical) Level 4 Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level_4_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level_4_description` SET TAGS ('dbx_business_glossary_term' = 'ATC (Anatomical Therapeutic Chemical) Level 4 Description');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level_5_code` SET TAGS ('dbx_business_glossary_term' = 'ATC (Anatomical Therapeutic Chemical) Level 5 Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level_5_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_level_5_description` SET TAGS ('dbx_business_glossary_term' = 'ATC (Anatomical Therapeutic Chemical) Level 5 Description');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_note` SET TAGS ('dbx_business_glossary_term' = 'ATC (Anatomical Therapeutic Chemical) Classification Note');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_status` SET TAGS ('dbx_business_glossary_term' = 'ATC (Anatomical Therapeutic Chemical) Classification Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `atc_status` SET TAGS ('dbx_value_regex' = 'active|inactive|withdrawn|pending|deprecated');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `biosimilar_reference_flag` SET TAGS ('dbx_business_glossary_term' = 'Biosimilar Reference Product Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `combination_product_flag` SET TAGS ('dbx_business_glossary_term' = 'Combination Product Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'DEA (Drug Enforcement Administration) Controlled Substance Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|Not Controlled');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `ddd_value` SET TAGS ('dbx_business_glossary_term' = 'DDD (Defined Daily Dose) Value');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `mdm_golden_record_flag` SET TAGS ('dbx_business_glossary_term' = 'MDM (Master Data Management) Golden Record Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `orphan_drug_designation_flag` SET TAGS ('dbx_business_glossary_term' = 'Orphan Drug Designation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `therapeutic_equivalence_group` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Equivalence Group');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`atc_classification` ALTER COLUMN `who_publication_year` SET TAGS ('dbx_business_glossary_term' = 'WHO (World Health Organization) Publication Year');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` SET TAGS ('dbx_subdomain' = 'product_reference');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `masterdata_ndc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Master Data National Drug Code (NDC) ID');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Strength Unit Of Measure Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `active_ingredient_count` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredient Count');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^(NDA|ANDA|BLA)d{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `biosimilar_flag` SET TAGS ('dbx_business_glossary_term' = 'Biosimilar Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'CI|CII|CIII|CIV|CV|None');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `end_marketing_date` SET TAGS ('dbx_business_glossary_term' = 'End Marketing Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `interchangeable_biosimilar_flag` SET TAGS ('dbx_business_glossary_term' = 'Interchangeable Biosimilar Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `labeler_code` SET TAGS ('dbx_business_glossary_term' = 'Labeler Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `labeler_code` SET TAGS ('dbx_value_regex' = '^d{4,5}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `labeler_name` SET TAGS ('dbx_business_glossary_term' = 'Labeler Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `listing_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Listing Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `marketing_status` SET TAGS ('dbx_business_glossary_term' = 'Marketing Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `marketing_status` SET TAGS ('dbx_value_regex' = 'Prescription|Over-the-Counter|Discontinued|None');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `mdm_golden_record_flag` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Golden Record Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `ndc_number` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC) Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `ndc_number` SET TAGS ('dbx_value_regex' = '^d{10}$|^d{11}$|^d{5}-d{4}-d{1}$|^d{5}-d{4}-d{2}$|^d{5}-d{3}-d{2}$|^d{4}-d{4}-d{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'Package Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `package_code` SET TAGS ('dbx_value_regex' = '^d{1,2}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Package Description');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `pharm_class` SET TAGS ('dbx_business_glossary_term' = 'Pharmacologic Class');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^d{3,4}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'Human Prescription Drug|Human OTC Drug|Biological Product|Vaccine|Plasma Derivative');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `proprietary_name` SET TAGS ('dbx_business_glossary_term' = 'Proprietary Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Pending Review|Archived');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `rems_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `repackager_flag` SET TAGS ('dbx_business_glossary_term' = 'Repackager Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `rx_otc_indicator` SET TAGS ('dbx_business_glossary_term' = 'Prescription (Rx) or Over-the-Counter (OTC) Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `rx_otc_indicator` SET TAGS ('dbx_value_regex' = 'Rx|OTC');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'FDA_NDC|SAP_MM|VEEVA_RIM|MANUAL');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `start_marketing_date` SET TAGS ('dbx_business_glossary_term' = 'Start Marketing Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Strength');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `therapeutic_equivalence_code` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Equivalence Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`masterdata_ndc_code` ALTER COLUMN `therapeutic_equivalence_code` SET TAGS ('dbx_value_regex' = '^[A-B][A-Z]{1,2}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` SET TAGS ('dbx_subdomain' = 'product_reference');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `active_moiety_inn` SET TAGS ('dbx_business_glossary_term' = 'Active Moiety International Nonproprietary Name (INN)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `biosimilar_reference_inn` SET TAGS ('dbx_business_glossary_term' = 'Biosimilar Reference International Nonproprietary Name (INN)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `breakthrough_therapy_designation_flag` SET TAGS ('dbx_business_glossary_term' = 'Breakthrough Therapy Designation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `cas_registry_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `cas_registry_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'schedule_I|schedule_II|schedule_III|schedule_IV|schedule_V|not_controlled');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `inn_definition` SET TAGS ('dbx_business_glossary_term' = 'International Nonproprietary Name (INN) Definition');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `inn_language_variants` SET TAGS ('dbx_business_glossary_term' = 'International Nonproprietary Name (INN) Language Variants');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `inn_name` SET TAGS ('dbx_business_glossary_term' = 'International Nonproprietary Name (INN)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `inn_status` SET TAGS ('dbx_business_glossary_term' = 'International Nonproprietary Name (INN) Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `inn_status` SET TAGS ('dbx_value_regex' = 'proposed|recommended|published|withdrawn');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `inn_stem` SET TAGS ('dbx_business_glossary_term' = 'International Nonproprietary Name (INN) Stem');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `iupac_name` SET TAGS ('dbx_business_glossary_term' = 'International Union of Pure and Applied Chemistry (IUPAC) Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `mdm_golden_record_flag` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Golden Record Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `mechanism_of_action` SET TAGS ('dbx_business_glossary_term' = 'Mechanism of Action (MOA)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `molecular_formula` SET TAGS ('dbx_business_glossary_term' = 'Molecular Formula');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `molecular_weight` SET TAGS ('dbx_business_glossary_term' = 'Molecular Weight');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `orphan_drug_designation_flag` SET TAGS ('dbx_business_glossary_term' = 'Orphan Drug Designation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `pharmacological_class` SET TAGS ('dbx_business_glossary_term' = 'Pharmacological Class');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `substance_class` SET TAGS ('dbx_business_glossary_term' = 'Pharmaceutical Substance Class');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `substance_class` SET TAGS ('dbx_value_regex' = 'small_molecule|biologic|vaccine|gene_therapy|cell_therapy|oligonucleotide');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `usan_name` SET TAGS ('dbx_business_glossary_term' = 'United States Adopted Name (USAN)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `who_inn_list_number` SET TAGS ('dbx_business_glossary_term' = 'World Health Organization (WHO) International Nonproprietary Name (INN) List Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `who_publication_date` SET TAGS ('dbx_business_glossary_term' = 'World Health Organization (WHO) Publication Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`inn_registry` ALTER COLUMN `who_publication_reference` SET TAGS ('dbx_business_glossary_term' = 'World Health Organization (WHO) Publication Reference');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` SET TAGS ('dbx_subdomain' = 'enterprise_structure');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'registered|operational|shipping|billing|clinical_site|manufacturing');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `gmp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `line_3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `mdm_golden_record_flag` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Golden Record Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `primary_address_flag` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `regulatory_site_identifier` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Site Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `sap_address_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Address Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `sap_address_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `sap_address_number` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `standardization_date` SET TAGS ('dbx_business_glossary_term' = 'Address Standardization Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `standardization_source` SET TAGS ('dbx_business_glossary_term' = 'Address Standardization Source');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Address Validation Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|failed|pending|manual_override');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` SET TAGS ('dbx_subdomain' = 'enterprise_structure');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner (BP) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `address_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `avl_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `blocking_indicator` SET TAGS ('dbx_business_glossary_term' = 'Blocking Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `blocking_indicator` SET TAGS ('dbx_value_regex' = 'not_blocked|sales_blocked|purchasing_blocked|payment_blocked|fully_blocked');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `bp_category` SET TAGS ('dbx_business_glossary_term' = 'Business Partner (BP) Category');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `bp_category` SET TAGS ('dbx_value_regex' = 'person|organization|group');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `bp_number` SET TAGS ('dbx_business_glossary_term' = 'Business Partner (BP) Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `bp_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `bp_role` SET TAGS ('dbx_business_glossary_term' = 'Business Partner (BP) Role(s)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `business_partner_status` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `business_partner_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `credit_limit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `credit_limit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Registration Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `dea_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `fda_establishment_identifier` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Establishment Identifier (FEI)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `gmp_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certification Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `gmp_certification_status` SET TAGS ('dbx_value_regex' = 'certified|provisional|suspended|expired|not_certified');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `gmp_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certification Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]+$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `lims_supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Information Management System (LIMS) Supplier Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `mdm_golden_record_flag` SET TAGS ('dbx_business_glossary_term' = 'Master Data Management (MDM) Golden Record Flag');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Status');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|pending|disqualified|under_review|not_qualified');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk Classification');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Code / Bank Identifier Code (BIC)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `swift_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`masterdata`.`business_partner` ALTER COLUMN `veeva_account_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva Account Identifier');
