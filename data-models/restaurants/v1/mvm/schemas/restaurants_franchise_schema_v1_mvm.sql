-- Schema for Domain: franchise | Business: Restaurants | Version: v1_mvm
-- Generated on: 2026-05-06 04:01:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `restaurants_ecm`.`franchise` COMMENT 'SSOT for franchise partner identity, FDD agreements, territory management, royalty rate calculations, franchise fees, compliance tracking, NRO (New Restaurant Opening) pipeline, franchisee performance metrics, and development lifecycle via FranConnect. Ensures adherence to brand standards, IFA best practices, and FTC Franchise Rule.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `restaurants_ecm`.`franchise`.`franchisee` (
    `franchisee_id` BIGINT COMMENT 'System-generated unique identifier for the franchise partner.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Royalty payment processing requires linking each franchisee to its bank account for ACH transfers; experts expect a direct bank_account_id FK.',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_center. Business justification: Assigning each franchisee to a primary distribution center supports logistics planning and delivery scheduling reports.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Franchisees operate as legal entities (LLCs, corporations) registered in the finance system. Tax reporting, FDD compliance, and intercompany reconciliation require linking the franchisee record to its',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: Franchisee belongs to a geographic territory; linking franchisee to territory via territory_id enables proper reporting and eliminates reliance on free‑text codes.',
    `address_line1` STRING COMMENT 'First line of the franchisees primary business address.',
    `address_line2` STRING COMMENT 'Second line of the franchisees primary business address, if applicable.',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Reported annual gross revenue of the franchisee.',
    `average_unit_volume` DECIMAL(18,2) COMMENT 'Average sales volume per unit for the franchisee.',
    `city` STRING COMMENT 'City of the franchisees primary business address.',
    `compliance_status` STRING COMMENT 'Overall compliance status with brand standards and regulatory requirements.. Valid values are `compliant|non_compliant|under_review`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the franchisees primary business address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the franchisee record was first created in the system.',
    `credit_rating` STRING COMMENT 'Credit rating assigned to the franchisee by a rating agency. [ENUM-REF-CANDIDATE: aaa|aa|a|bbb|bb|b|ccc|cc|c|d — promote to reference product]',
    `dba_name` STRING COMMENT 'Trade name under which the franchisee operates, if different from the legal name.',
    `established_date` DATE COMMENT 'Date the franchisee entity was legally formed.',
    `fdd_disclosure_status` STRING COMMENT 'Status of the Franchise Disclosure Document compliance for the franchisee.. Valid values are `disclosed|pending|exempt`',
    `food_safety_certified` BOOLEAN COMMENT 'Indicates whether the franchisee holds a current food safety certification (e.g., ServSafe).',
    `franchise_fee_amount` DECIMAL(18,2) COMMENT 'Initial fee paid by the franchisee for the franchise rights.',
    `franchisee_number` STRING COMMENT 'Unique business identifier assigned to the franchisee for internal tracking.',
    `franchisee_status` STRING COMMENT 'Current lifecycle status of the franchisee partnership.. Valid values are `active|inactive|terminated|pending`',
    `franchisee_type` STRING COMMENT 'Legal structure of the franchisee entity.. Valid values are `individual|llc|corporation|partnership`',
    `ifa_membership_status` STRING COMMENT 'International Franchise Association membership status of the franchisee.. Valid values are `member|non_member|pending`',
    `industry_segment` STRING COMMENT 'Segment of the restaurant industry the franchisee operates in.. Valid values are `qsr|casual|fine_dining`',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the current insurance policy.',
    `insurance_policy_number` STRING COMMENT 'Policy number for the franchisees liability and property insurance.',
    `legal_name` STRING COMMENT 'Full legal name of the franchisee entity as registered with government authorities.',
    `next_renewal_date` DATE COMMENT 'Scheduled date for the next franchise agreement renewal.',
    `number_of_units` STRING COMMENT 'Total number of restaurant locations operated by the franchisee.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the franchisees primary business address.',
    `royalty_fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount of royalty fees calculated for a reporting period.',
    `royalty_rate` DECIMAL(18,2) COMMENT 'Percentage of gross sales payable to the brand as royalty.',
    `state_province` STRING COMMENT 'State or province of the franchisees primary business address.',
    `state_tax_number` STRING COMMENT 'State-level tax identification number for the franchisee.',
    `tax_id_ein` STRING COMMENT 'Federal tax identification number for the franchisee.',
    `termination_date` DATE COMMENT 'Date the franchise agreement was terminated, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the franchisee record.',
    CONSTRAINT pk_franchisee PRIMARY KEY(`franchisee_id`)
) COMMENT 'Master record for each franchise partner entity — the legal business entity (individual, LLC, corporation) that holds one or more franchise agreements with the brand. Captures franchisee identity, legal structure, ownership details, contact information, financial standing, FDD disclosure status, IFA membership, and FranConnect system ID. SSOT for franchise partner identity across the enterprise.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`franchise`.`agreement` (
    `agreement_id` BIGINT COMMENT 'System-generated unique identifier for the franchise agreement record.',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier of the franchisor (company) party.',
    `agreement_legal_entity_id` BIGINT COMMENT 'Unique identifier of the franchisor (company) party.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Franchise agreements are brand-specific legal contracts. In multi-brand systems, a franchisee holds separate agreements per brand. Legal, compliance, and royalty reporting all require knowing which br',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Franchise agreements have effective periods that must align to fiscal periods for revenue recognition scheduling under ASC 606/IFRS 15. Finance requires period-tagged agreements for deferred revenue c',
    `franchisee_id` BIGINT COMMENT 'Unique identifier of the franchisee party.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Franchise agreements generate royalty revenue streams tracked in profit centers. Finance maps agreement-level royalty streams to profit centers for franchisee P&L reporting and revenue recognition. St',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: Franchise agreements contractually specify which loyalty program(s) the franchisee must participate in, including marketing fee obligations and compliance requirements. The franchise agreement loyalt',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: A franchise agreement is tied to a specific geographic territory; adding territory_id FK normalizes territory data and removes redundant code/description fields.',
    `agreement_number` STRING COMMENT 'External business identifier assigned to the agreement (e.g., FA-2023-001).',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the agreement.. Valid values are `active|inactive|terminated|pending|draft`',
    `agreement_type` STRING COMMENT 'Classifies the agreement as initial, renewal, transfer, or amendment.. Valid values are `initial|renewal|transfer|amendment`',
    `amendment_effective_date` DATE COMMENT 'Date when the amendment becomes effective.',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment applied to the agreement.',
    `average_unit_volume` DECIMAL(18,2) COMMENT 'Projected average sales per unit location for the franchisee.',
    `compliance_review_date` DATE COMMENT 'Date of the most recent compliance audit of the agreement.',
    `compliance_status` STRING COMMENT 'Result of the latest compliance review.. Valid values are `compliant|non_compliant|pending`',
    `contract_version` STRING COMMENT 'Version identifier for the agreement (e.g., v1, v2).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Scheduled expiration date of the agreement (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date the agreement becomes legally binding.',
    `ftc_compliance_attestation_flag` BOOLEAN COMMENT 'Attestation that the agreement complies with FTC Franchise Rule disclosures.',
    `initial_fee_amount` DECIMAL(18,2) COMMENT 'Up‑front fee paid by the franchisee to obtain the franchise rights.',
    `marketing_fee_percent` DECIMAL(18,2) COMMENT 'Percentage of sales contributed to the brand‑wide marketing fund.',
    `notes` STRING COMMENT 'Free‑form text for additional comments, special conditions, or observations.',
    `renewal_fee_amount` DECIMAL(18,2) COMMENT 'Fee payable by the franchisee to renew the agreement for the next term.',
    `renewal_term_years` STRING COMMENT 'Number of years for each renewal period after the initial term.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Ongoing royalty percentage of gross sales payable to the franchisor.',
    `sales_target_amount` DECIMAL(18,2) COMMENT 'Target gross sales amount the franchisee commits to achieve during the term.',
    `signed_date` DATE COMMENT 'Date the agreement was signed by both parties.',
    `termination_date` DATE COMMENT 'Actual date the agreement was terminated prior to its scheduled end.',
    `transfer_rights_flag` BOOLEAN COMMENT 'Indicates whether the franchisee may transfer the agreement to another party.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Authoritative record of each franchise agreement between the franchisor and a franchisee, encompassing the full agreement lifecycle from execution through renewal, transfer, or termination. Captures agreement type (initial, renewal, transfer, successor), effective and expiration dates, territory grant, initial franchise fee, royalty rate and basis, marketing fund contribution rate, renewal terms, and agreement status. Owns all lifecycle event records including: transfers (transferor/transferee, ROFR exercise, approval, transfer conditions, effective date), renewals (updated terms, FDD re-disclosure, renewal fee, execution date), and terminations (type, default notice, cure period, de-identification, post-termination obligations, non-compete). SSOT for all contractual franchise obligations and their complete lifecycle history. Supports FTC Franchise Rule Items 5, 6, 17 disclosure requirements.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`franchise`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique identifier for the territory.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Franchise territories are brand-specific — a territory granted for Brand A is legally distinct from one for Brand B. Franchise development, territory conflict resolution, and market saturation analysi',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Territories map to profit centers for regional P&L reporting and royalty revenue attribution by geographic segment. Finance tracks territory-level profitability for segment reporting. Foodservice fran',
    `area_sq_miles` DECIMAL(18,2) COMMENT 'Total land area of the territory in square miles.',
    `assignment_status` STRING COMMENT 'Current status of the territory assignment process.. Valid values are `assigned|unassigned|pending`',
    `average_unit_volume` DECIMAL(18,2) COMMENT 'Average sales per unit (AUV) across locations in the territory (USD).',
    `city` STRING COMMENT 'Primary city associated with the territory.',
    `compliance_status` STRING COMMENT 'Current food‑safety and regulatory compliance status of the territory.. Valid values are `compliant|non_compliant|under_review`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code for the territory.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was created.',
    `dma` STRING COMMENT 'DMA region identifier for the territory.',
    `effective_end_date` DATE COMMENT 'Date when the territory expires or is terminated (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the territory became effective for the franchisee.',
    `franchise_fee` DECIMAL(18,2) COMMENT 'One‑time fee charged to the franchisee for the territory grant.',
    `geometry_wkt` STRING COMMENT 'Well‑Known Text representation of the territorys polygon boundary.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent compliance inspection for the territory.',
    `median_income` DECIMAL(18,2) COMMENT 'Median household income for the territory (USD).',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the territory.',
    `number_of_locations` STRING COMMENT 'Count of restaurant units operating within the territory.',
    `population` STRING COMMENT 'Estimated resident population within the territory.',
    `radius_miles` DECIMAL(18,2) COMMENT 'Radius in miles for circular territories (if applicable).',
    `region` STRING COMMENT 'Two‑letter state or province code for the territory.. Valid values are `^[A-Z]{2}$`',
    `royalty_rate` DECIMAL(18,2) COMMENT 'Royalty percentage applied to franchisee sales within the territory.',
    `territory_code` STRING COMMENT 'Business identifier code assigned to the territory.',
    `territory_description` STRING COMMENT 'Free‑form description of the territorys characteristics.',
    `territory_name` STRING COMMENT 'Human‑readable name of the territory.',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory.. Valid values are `active|inactive|pending|closed`',
    `territory_type` STRING COMMENT 'Classification of the territorys exclusivity rights.. Valid values are `exclusive|protected|non_exclusive`',
    `trade_area_classification` STRING COMMENT 'Business classification of the trade area based on demographics and spend.. Valid values are `high|medium|low`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the territory record.',
    `zip_codes` STRING COMMENT 'List of ZIP codes included in the territory, separated by commas.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Defines the protected or exclusive geographic territory granted to a franchisee under a franchise agreement. Captures territory boundaries (polygon, zip codes, DMA, radius), territory type (exclusive, protected, non-exclusive), population count, trade area classification, territory status, and assignment history. Supports territory conflict resolution and development pipeline planning.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`franchise`.`billing` (
    `billing_id` BIGINT COMMENT 'Primary key for billing',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.agreement. Business justification: Each billing record charges fees governed by a specific franchise agreement. The agreement defines royalty rates, marketing fee percentages, and other fee structures that determine billing amounts. Li',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Each franchise billing record generates an AR invoice for royalties and fees. Finance AR reconciliation and cash application require tracing billing records to their corresponding AR invoices. Foodser',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to franchise.fee_schedule. Business justification: Billing records charge fees defined in the fee_schedule (one-time and recurring franchise fees beyond royalties). Linking billing to fee_schedule normalizes the fee definition away from the billing re',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Franchise billing cycles align to fiscal periods for royalty revenue recognition and period-close reporting. Finance teams reconcile franchise billing by financial period. Foodservice franchise accoun',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Franchise billing records are generated per franchisee; linking to franchisee provides ownership and enables reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Franchise billing entries (royalty fees, marketing fees) must post to specific GL accounts for revenue recognition. Finance requires GL account assignment on billing records for automated journal entr',
    `sales_report_id` BIGINT COMMENT 'Foreign key linking to franchise.sales_report. Business justification: Royalty and marketing fund billing is calculated directly from franchisee-submitted gross sales reports. Linking billing to the triggering sales_report creates an auditable chain from reported sales →',
    CONSTRAINT pk_billing PRIMARY KEY(`billing_id`)
) COMMENT 'Transactional record of all periodic franchise fees billed to a franchisee for a specific reporting period, including royalties, marketing fund contributions, technology fees, and other recurring charges. Captures billing period, gross sales reported, rates applied, line-item amounts (royalty, marketing fund, technology, other), total amount billed, payment due date, payment status, and variance from prior period. Source of truth for franchise revenue recognition, AR aging, and marketing fund governance. Supports FDD Item 6 and Item 11 disclosure compliance.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`franchise`.`sales_report` (
    `sales_report_id` BIGINT COMMENT 'System-generated unique identifier for the sales report record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.agreement. Business justification: Each sales report is submitted under a specific franchise agreement, and the royalty_rate and marketing_fee_percent applied to the report are defined in that agreement. Adding agreement_id links the r',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sales reports are submitted per restaurant location; cost centers represent those locations in the finance system. Direct link enables period-close reconciliation of reported sales against cost center',
    `delivery_platform_id` BIGINT COMMENT 'Foreign key linking to order.delivery_platform. Business justification: Franchise sales reports must attribute delivery platform revenue separately because franchise agreements increasingly apply platform-specific royalty rates and commission offsets. Franchisors require ',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Sales reports are submitted for specific fiscal periods; finance uses this link to close periods and recognize royalty revenue. Foodservice franchise finance teams require period-tagged sales reports ',
    `franchisee_id` BIGINT COMMENT 'Unique identifier of the franchise partner submitting the report.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Sales reports drive royalty and marketing fee postings to GL accounts. Finance needs this link for automated journal entry generation from validated sales reports. Standard franchise accounting requir',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant location to which the sales data applies.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Identifies the employee submitting the sales report, providing audit trail, accountability, and performance monitoring for franchisee reporting.',
    `adjustments_amount` DECIMAL(18,2) COMMENT 'Sum of discounts, taxes, and other adjustments applied to gross sales.',
    `audit_trail` STRING COMMENT 'Chronological log of key actions performed on the report (e.g., submissions, approvals).',
    `average_check_value` DECIMAL(18,2) COMMENT 'Average dollar amount per transaction for the reporting period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales report record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary values.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `daypart_sales_breakdown` STRING COMMENT 'JSON string summarizing sales by daypart (e.g., breakfast, lunch, dinner).',
    `franchise_fee` DECIMAL(18,2) COMMENT 'Fixed fee charged to the franchisee for brand usage during the period.',
    `gross_sales_amount` DECIMAL(18,2) COMMENT 'Total gross sales reported for the period before any deductions.',
    `net_sales_amount` DECIMAL(18,2) COMMENT 'Net sales after adjustments; basis for royalty calculations.',
    `notes` STRING COMMENT 'Free‑form comments entered by the franchisee or reviewer.',
    `report_number` STRING COMMENT 'External reference number assigned to the sales report by the franchisee.',
    `reporting_period_end` DATE COMMENT 'Last calendar date of the reporting period covered by the sales report.',
    `reporting_period_start` DATE COMMENT 'First calendar date of the reporting period covered by the sales report.',
    `reporting_period_type` STRING COMMENT 'Granularity of the reporting period (e.g., weekly, monthly).. Valid values are `weekly|monthly|quarterly|yearly`',
    `royalty_amount` DECIMAL(18,2) COMMENT 'Calculated royalty amount based on royalty_rate and net_sales_amount.',
    `sales_report_status` STRING COMMENT 'Current lifecycle status of the sales report.. Valid values are `draft|submitted|validated|rejected`',
    `same_store_sales` DECIMAL(18,2) COMMENT 'Comparable sales metric for existing stores, used for performance benchmarking.',
    `submission_method` STRING COMMENT 'Channel used by the franchisee to submit the report.. Valid values are `portal|email|ftp|api`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the franchisee submitted the sales report.',
    `transaction_count` BIGINT COMMENT 'Total number of individual transactions (average transaction count) recorded in the period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sales report record.',
    `validation_status` STRING COMMENT 'Result of the automated/manual validation process.. Valid values are `pending|passed|failed`',
    `variance_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the variance when variance_flag is true.',
    `variance_flag` BOOLEAN COMMENT 'Indicates whether reported figures deviate beyond predefined thresholds.',
    CONSTRAINT pk_sales_report PRIMARY KEY(`sales_report_id`)
) COMMENT 'Franchisee-submitted periodic gross sales report used as the basis for royalty and marketing fund calculation, SSS (Same-Store Sales) tracking, and operational benchmarking. Captures reporting period (weekly, monthly), reported gross sales by daypart, net sales, transaction count (ATC), average check value (ACV), submission date, submission method (POS auto-pull, manual entry, EDI), validation status, and variance flags. Supports royalty billing, comp sales analysis, franchisee performance benchmarking, and FDD Item 19 financial performance representation validation.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` (
    `nro_pipeline_id` BIGINT COMMENT 'System-generated unique identifier for each NRO pipeline record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.agreement. Business justification: NRO projects are authorized under a specific franchise agreement. The agreement defines the franchisees rights to open new locations, the territory, and the development obligations. Linking nro_pipel',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: NRO projects are funded by approved capital budgets in finance (finance.budget has nro_flag and nro_project_code). Linking pipeline to budget enables capex tracking, budget vs. actual reporting, and i',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NRO projects are assigned to cost centers for capex project accounting and pre-opening expense tracking. Foodservice development controllers require cost center assignment on pipeline records for proj',
    `development_schedule_id` BIGINT COMMENT 'Foreign key linking to franchise.development_schedule. Business justification: Each NRO pipeline project fulfills a commitment under a franchisees contractual development schedule. Linking nro_pipeline to development_schedule enables tracking of which specific schedule commitme',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_center. Business justification: New restaurant opening (NRO) supply chain onboarding requires assigning the new unit to a distribution center before opening day. This DC assignment is a named milestone in the NRO process — supply ch',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchisee responsible for the new restaurant.',
    `haccp_plan_id` BIGINT COMMENT 'Foreign key linking to foodsafety.haccp_plan. Business justification: Regulatory and franchise standards require an approved HACCP plan before a new restaurant opens. The NRO pipeline tracks permits_obtained_flag and health_inspection_score; linking to the specific hacc',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: NRO projects are executed under a specific legal entity for capex capitalization and tax purposes. Multi-entity franchise systems require entity-level capex reporting. Foodservice development finance ',
    `menu_id` BIGINT COMMENT 'Foreign key linking to menu.menu. Business justification: New restaurant opening (NRO) planning requires assigning the approved menu version the unit will launch with — a named NRO readiness milestone. Franchisors track menu readiness as part of the opening ',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: When an NRO project completes, the resulting restaurant unit must be linked back to the pipeline record for development tracking, ROI analysis, and post-opening performance benchmarking. Franchise dev',
    `food_safety_audit_id` BIGINT COMMENT 'Foreign key linking to foodsafety.food_safety_audit. Business justification: New restaurant openings require a pre-opening food safety audit as a regulatory and franchise standard gating requirement. The NRO pipeline tracks health_inspection_score and permits_obtained_flag; li',
    `employee_id` BIGINT COMMENT 'Identifier of the development consultant assigned to the project.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: NRO projects are assigned to profit centers for pre-opening cost tracking and initial revenue attribution. Finance requires profit center assignment for project P&L reporting and ROI calculation again',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.program. Business justification: New restaurant opening activation includes loyalty program enrollment as a named checklist milestone. Foodservice operations teams track which loyalty program a new unit will participate in during the',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: NRO pipeline tracks new restaurant opening milestones; linking to the physical site being developed enables integrated development tracking, site readiness reporting, and capital investment planning. ',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: NRO pipeline projects are located within a specific franchise territory. The nro_pipeline table currently stores territory_code as a STRING, which is a denormalized reference to the territory entity. ',
    `actual_capex_spent` DECIMAL(18,2) COMMENT 'Cumulative capital expenditures incurred to date.',
    `actual_open_date` DATE COMMENT 'Date the restaurant actually opened for business.',
    `actual_opex_spent` DECIMAL(18,2) COMMENT 'Cumulative operating expenses incurred to date.',
    `brand` STRING COMMENT 'Brand classification of the restaurant (e.g., Quick-Service, Casual, Fine Dining).. Valid values are `QSR|Casual|Fine_Dining`',
    `budget_capex` DECIMAL(18,2) COMMENT 'Approved capital expenditure budget for the project.',
    `budget_opex` DECIMAL(18,2) COMMENT 'Approved operating expense budget for the pre‑opening period.',
    `capital_investment_estimate` DECIMAL(18,2) COMMENT 'Projected capital expenditure required to open the restaurant, in USD.',
    `compliance_status` STRING COMMENT 'Current status of regulatory and brand compliance for the project.. Valid values are `compliant|non_compliant|pending`',
    `construction_complete_flag` BOOLEAN COMMENT 'True when construction is finished.',
    `construction_start_flag` BOOLEAN COMMENT 'True when construction work has commenced.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the NRO pipeline record was first created.',
    `development_type` STRING COMMENT 'Category of the restaurant development: new build, conversion of existing location, or remodel.. Valid values are `new_build|conversion|remodel`',
    `effective_from` DATE COMMENT 'Date the NRO agreement becomes effective (typically the target open date).',
    `effective_until` DATE COMMENT 'Date the NRO agreement ends or is superseded; null if open‑ended.',
    `expected_acuv` DECIMAL(18,2) COMMENT 'Forecasted average transaction value (USD) for the new restaurant.',
    `expected_cogs_percent` DECIMAL(18,2) COMMENT 'Projected Cost of Goods Sold as a percentage of sales.',
    `expected_labor_percent` DECIMAL(18,2) COMMENT 'Projected labor cost as a percentage of sales.',
    `expected_roi` DECIMAL(18,2) COMMENT 'Forecasted ROI for the new restaurant over a 12‑month horizon.',
    `expected_traffic_volume` STRING COMMENT 'Projected daily customer count for the first 30 days after opening.',
    `health_inspection_score` STRING COMMENT 'Score from the most recent health inspection (0‑100).',
    `last_milestone_date` DATE COMMENT 'Date when the most recent project milestone was achieved.',
    `last_milestone_name` STRING COMMENT 'Name of the most recent milestone (e.g., "Construction Complete").',
    `notes` STRING COMMENT 'Free‑form notes or comments about the project.',
    `opening_announced_flag` BOOLEAN COMMENT 'True when the grand opening has been publicly announced.',
    `permits_obtained_flag` BOOLEAN COMMENT 'Indicates whether all required permits have been secured.',
    `project_code` STRING COMMENT 'External business identifier for the NRO project, used in reporting and contracts.. Valid values are `^NRO-[A-Z0-9]{6}$`',
    `project_name` STRING COMMENT 'Descriptive name of the NRO development project.',
    `project_status` STRING COMMENT 'Overall status of the NRO project.. Valid values are `active|on_hold|cancelled|completed`',
    `risk_level` STRING COMMENT 'Assessed risk category for the project.. Valid values are `low|medium|high`',
    `stage` STRING COMMENT 'Current lifecycle stage of the NRO project. [ENUM-REF-CANDIDATE: site_identified|loi_signed|lease_executed|permits_obtained|construction_started|construction_complete|training_complete|opened|closed — 9 candidates stripped; promote to reference product]',
    `stage_change_timestamp` TIMESTAMP COMMENT 'Timestamp when the project moved into the current stage.',
    `target_open_date` DATE COMMENT 'Planned date for the restaurant to begin operations.',
    `training_complete_flag` BOOLEAN COMMENT 'True when staff training is completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the NRO pipeline record.',
    CONSTRAINT pk_nro_pipeline PRIMARY KEY(`nro_pipeline_id`)
) COMMENT 'Tracks all franchise capital construction and development projects from initiation through completion, including New Restaurant Openings (NROs), remodels, reimaging, refreshes, and conversions. Captures project type (new build, conversion, full remodel, refresh, reimaging, ADA compliance), project stage (site identified, LOI signed, lease executed, permits obtained, construction started, construction complete, training complete, opened/completed), target and actual completion dates, development type, assigned development consultant, capital investment estimate, approved contractor, permit and inspection status, brand approval status, contractual obligation source, and milestone completion dates. SSOT for the franchise development and facility lifecycle in FranConnect.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`franchise`.`development_schedule` (
    `development_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the franchise development schedule.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.agreement. Business justification: A development schedule is a contractual commitment made as part of or in conjunction with a franchise agreement. The schedule_number, total_units_committed, and development phase are all governed by t',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Development schedules commit franchisees to open a specific number of units of a specific brand. Multi-brand franchisees have separate schedules per brand. Franchise development reporting and complian',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Development schedules drive multi-year capex budgets. Finance.budget has nro_flag for this purpose. Linking development schedules to approved budgets enables committed unit tracking against capital al',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Development schedules span fiscal periods; finance tracks committed unit openings by period for revenue forecasting and royalty pipeline projections. Foodservice franchise finance teams use period-tag',
    `franchisee_id` BIGINT COMMENT 'Identifier of the franchisee to whom the development schedule is assigned.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Development schedules are contractual commitments executed under a specific legal entity. Multi-entity franchise systems require entity-level development commitment reporting for FDD disclosure and le',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Development schedules commit franchisees to opening specific units; linking to the site being developed tracks which physical locations fulfill contractual unit-opening obligations. Franchise developm',
    `territory_id` BIGINT COMMENT 'Geographic territory identifier governing the development schedule.',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the franchisee against the development schedule.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the development schedule record was first created in the system.',
    `cure_period_months` STRING COMMENT 'Number of months granted to the franchisee to cure a schedule breach before penalties apply.',
    `development_phase` STRING COMMENT 'Current phase of the development schedule lifecycle.. Valid values are `planning|execution|monitoring|closed`',
    `development_schedule_status` STRING COMMENT 'Current lifecycle state of the schedule (active, inactive, suspended, completed, default).. Valid values are `active|inactive|suspended|completed|default`',
    `end_date` DATE COMMENT 'Date when the development schedule expires if the required units are not opened.',
    `last_compliance_check` DATE COMMENT 'Date of the most recent compliance review for the development schedule.',
    `notes` STRING COMMENT 'Free-text field for additional comments, exceptions, or special conditions related to the schedule.',
    `schedule_number` STRING COMMENT 'External reference number assigned to the development schedule, used in franchise contracts and reporting.',
    `schedule_type` STRING COMMENT 'Category of the development agreement (e.g., Multi-Unit Development Agreement, single-unit, renewal).. Valid values are `MUDA|single_unit|renewal`',
    `schedule_version` STRING COMMENT 'Version number of the schedule record to track revisions.',
    `start_date` DATE COMMENT 'Date when the development schedule becomes effective and the franchisee may begin opening units.',
    `target_units_year_1` STRING COMMENT 'Number of units the franchisee must open in the first calendar year of the schedule.',
    `target_units_year_2` STRING COMMENT 'Number of units the franchisee must open in the second calendar year of the schedule.',
    `target_units_year_3` STRING COMMENT 'Number of units the franchisee must open in the third calendar year of the schedule.',
    `total_units_committed` STRING COMMENT 'Total number of restaurant units the franchisee has agreed to open under the schedule.',
    `units_opened_to_date` STRING COMMENT 'Cumulative count of units the franchisee has opened to date under this schedule.',
    `units_remaining` STRING COMMENT 'Number of units still required to meet the schedule commitment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the development schedule record.',
    CONSTRAINT pk_development_schedule PRIMARY KEY(`development_schedule_id`)
) COMMENT 'Contractual development schedule committing a franchisee to open a specified number of restaurants within defined time windows under a multi-unit development agreement (MUDA). Captures total units committed, units opened to date, units remaining, development period start and end dates, annual opening targets by year, cure period terms, and schedule compliance status. Supports franchise development pipeline forecasting and default tracking.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`franchise`.`compliance_audit` (
    `compliance_audit_id` BIGINT COMMENT 'System‑generated unique identifier for each compliance audit record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.agreement. Business justification: Compliance audits verify adherence to brand standards as defined in the franchise agreement. The agreement specifies the brand standards, compliance review dates, and corrective action requirements th',
    `employee_id` BIGINT COMMENT 'Unique identifier of the internal or external auditor who performed the audit.',
    `brand_standard_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand_standard. Business justification: Compliance audits measure adherence to specific brand standards (brand_standards_score, food_safety_score). Franchise QA teams run audit-vs-standard gap reports. A foodservice franchisor would expect ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compliance audits are conducted at restaurant locations mapped to cost centers. Finance uses audit scores for cost center performance reporting, insurance cost allocation, and brand standards complian',
    `facility_id` BIGINT COMMENT 'Foreign key linking to realestate.facility. Business justification: Compliance audits score facility-specific attributes (equipment_score, cleanliness_score, food_safety_score). Linking directly to facility enables facility condition lifecycle tracking, maintenance pr',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Compliance audits are conducted within financial periods; results feed period-end compliance reporting and royalty rate adjustments. Finance requires period-tagged audit records for compliance-linked ',
    `food_safety_audit_id` BIGINT COMMENT 'Foreign key linking to foodsafety.food_safety_audit. Business justification: Franchise compliance audits incorporate food safety scores derived from formal food safety audits. Linking compliance_audit to the specific food_safety_audit record enables franchise ops teams to trac',
    `health_inspection_id` BIGINT COMMENT 'Foreign key linking to foodsafety.health_inspection. Business justification: Franchise compliance auditors review the most recent government health inspection when scoring a unit. Linking compliance_audit to the specific health_inspection record allows franchise ops to correla',
    `menu_id` BIGINT COMMENT 'Foreign key linking to menu.menu. Business justification: Franchise brand standards compliance audits explicitly assess whether a unit is operating the approved menu version (correct pricing, approved items, no unauthorized substitutions). Linking compliance',
    `primary_compliance_employee_id` BIGINT COMMENT 'Unique identifier of the internal or external auditor who performed the audit.',
    `franchisee_id` BIGINT COMMENT 'Unique identifier of the franchised restaurant unit subject to the audit.',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to supply.recall_event. Business justification: Recall-triggered compliance audits are a named regulatory process: when a supplier recall occurs, franchisee locations receive mandatory on-site audits to verify product removal and corrective action.',
    `site_id` BIGINT COMMENT 'Foreign key linking to realestate.site. Business justification: Compliance audits are conducted at specific restaurant sites; linking audit to site enables location-based compliance trend analysis, health inspection history by site, and real estate portfolio risk ',
    `unit_id` BIGINT COMMENT 'Foreign key linking to restaurant.unit. Business justification: Compliance audits are conducted at a specific restaurant unit. Franchise QA reporting, corrective action tracking, and health inspection scoring all require knowing which unit was audited. A foodservi',
    `audit_disposition` STRING COMMENT 'Final outcome of the audit after any follow‑up actions.. Valid values are `pass|conditional_pass|fail`',
    `audit_notes` STRING COMMENT 'Free‑form comments and observations recorded by the auditor.',
    `audit_number` STRING COMMENT 'External audit reference number used in franchise compliance reporting.',
    `audit_source_system` STRING COMMENT 'Name of the source system that supplied the audit data (e.g., Zenput, FranConnect).',
    `audit_timestamp` TIMESTAMP COMMENT 'Date and time when the audit was performed on site.',
    `audit_type` STRING COMMENT 'Classification of the audit execution method.. Valid values are `scheduled|unannounced|follow_up`',
    `brand_standards_score` DECIMAL(18,2) COMMENT 'Compliance percentage for the Brand Standards section.',
    `cleanliness_score` DECIMAL(18,2) COMMENT 'Compliance percentage for the Cleanliness section.',
    `compliance_audit_status` STRING COMMENT 'Current processing state of the audit record.. Valid values are `pending|in_progress|completed|cancelled`',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether any corrective actions must be taken as a result of the audit.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the audit record was first created.',
    `critical_violations_count` STRING COMMENT 'Number of critical compliance violations identified during the audit.',
    `equipment_score` DECIMAL(18,2) COMMENT 'Compliance percentage for the Equipment section.',
    `food_safety_score` DECIMAL(18,2) COMMENT 'Compliance percentage for the Food Safety section.',
    `non_critical_violations_count` STRING COMMENT 'Number of non‑critical compliance violations identified during the audit.',
    `overall_score` DECIMAL(18,2) COMMENT 'Aggregated compliance percentage across all audit sections (0‑100).',
    `service_score` DECIMAL(18,2) COMMENT 'Compliance percentage for the Service section.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the audit record.',
    CONSTRAINT pk_compliance_audit PRIMARY KEY(`compliance_audit_id`)
) COMMENT 'Records the results of brand standards compliance audits conducted at franchised restaurant units. Captures audit date, audit type (scheduled, unannounced, follow-up), auditor identity, overall compliance score, section scores (food safety, cleanliness, service, brand standards, equipment), critical and non-critical violation counts, corrective action required flag, and audit disposition (pass, conditional pass, fail). Supports franchise agreement compliance enforcement and performance scorecard inputs.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`franchise`.`fee_schedule` (
    `fee_schedule_id` BIGINT COMMENT 'Primary key for fee_schedule',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.franchise_agreement. Business justification: Fee schedule entries are defined by a specific franchise agreement; linking to agreement captures contractual context.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Fee schedules (royalty rates, marketing fees) are brand-specific in multi-brand franchise systems. Finance teams generate brand-level royalty reports and fee structures differ by brand. A franchise fi',
    `channel_id` BIGINT COMMENT 'Foreign key linking to order.channel. Business justification: Modern foodservice franchise agreements define channel-specific royalty and marketing fee rates (e.g., lower royalty on third-party delivery vs. in-store). Fee schedules must reference the order chann',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Fee schedules have effective periods aligned to financial periods for billing cycle management and rate change tracking. Finance requires period-tagged fee schedules to ensure correct rates are applie',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Fee schedule fees are charged to a particular franchisee; linking provides financial attribution.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Fee schedules define royalty and marketing fee rates that must map to GL accounts for automated revenue recognition posting. Finance requires GL account assignment on fee schedules to ensure correct a',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Fee schedules are issued by the franchisor legal entity and govern royalty obligations. Multi-brand/multi-entity franchise systems require legal entity assignment on fee schedules for entity-level rev',
    `territory_id` BIGINT COMMENT 'Foreign key linking to franchise.territory. Business justification: Fee schedule rates vary by territory; linking to territory enables territorial reporting and compliance.',
    CONSTRAINT pk_fee_schedule PRIMARY KEY(`fee_schedule_id`)
) COMMENT 'Records all one-time and recurring franchise fees charged to franchisees beyond royalties, including initial franchise fees, renewal fees, transfer fees, training fees, technology fees, and marketing fund contributions. Captures fee type, fee amount, billing trigger event, payment status, waiver or discount applied, and associated agreement. Complements royalty_invoice which handles periodic royalty billing specifically.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`franchise`.`training_enrollment` (
    `training_enrollment_id` BIGINT COMMENT 'System-generated unique identifier for the training enrollment record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.agreement. Business justification: Training requirements (hours_required, training_type, certification requirements) are specified in the franchise agreement. Linking training_enrollment to agreement enables direct lookup of the contra',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Training costs are allocated to cost centers (franchisee location or training center). Finance requires cost center assignment on training enrollments for labor and training expense allocation reporti',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Training costs are allocated to financial periods for budget vs. actual reporting. Finance requires period-tagged training enrollments to reconcile training expense against cost center budgets and NRO',
    `food_safety_certification_id` BIGINT COMMENT 'Foreign key linking to foodsafety.food_safety_certification. Business justification: Franchise training enrollments for food safety programs (e.g., ServSafe) result in food_safety_certification records. The training_enrollment carries denormalized certification_issued and certificatio',
    `franchisee_id` BIGINT COMMENT 'Foreign key linking to franchise.franchisee. Business justification: Training enrollment tracks franchisee and designated manager training required under the franchise agreement. While training_enrollment links to employees (workforce domain) and units (restaurant doma',
    `nro_pipeline_id` BIGINT COMMENT 'Foreign key linking to franchise.nro_pipeline. Business justification: Training completion is a tracked milestone in the NRO pipeline (training_complete_flag on nro_pipeline). Linking training_enrollment to nro_pipeline creates the operational connection between specific',
    `employee_id` BIGINT COMMENT 'Identifier of the franchisee or manager who is enrolled in the training.',
    `tertiary_training_trainer_employee_id` BIGINT COMMENT 'Identifier of the trainer or instructor responsible for the training.',
    `unit_id` BIGINT COMMENT 'Identifier of the restaurant or site where the training took place (if in‑restaurant).',
    `actual_completion_date` DATE COMMENT 'Actual date when the trainee completed the training.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the enrollment satisfies regulatory compliance requirements (e.g., ServSafe).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was created in the system.',
    `effective_until` DATE COMMENT 'Date when the enrollment agreement ends (typically the scheduled completion date or certification expiration).',
    `enrollment_date` TIMESTAMP COMMENT 'Date and time when the trainee was enrolled in the training program.',
    `enrollment_number` STRING COMMENT 'Unique enrollment reference number assigned by the system.',
    `hours_completed` DECIMAL(18,2) COMMENT 'Number of training hours the trainee has completed.',
    `hours_required` DECIMAL(18,2) COMMENT 'Total number of training hours required for completion.',
    `notes` STRING COMMENT 'Free‑text notes regarding the enrollment, special accommodations, or observations.',
    `pass_fail_status` STRING COMMENT 'Result of the training assessment.. Valid values are `pass|fail|not_applicable`',
    `scheduled_completion_date` DATE COMMENT 'Planned date by which the trainee should complete the training.',
    `score` DECIMAL(18,2) COMMENT 'Numeric score achieved in the training assessment (0‑100).',
    `training_enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment.. Valid values are `enrolled|completed|failed|cancelled|in-progress`',
    `training_type` STRING COMMENT 'Mode of delivery for the training.. Valid values are `classroom|online|in-restaurant`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    CONSTRAINT pk_training_enrollment PRIMARY KEY(`training_enrollment_id`)
) COMMENT 'Tracks franchisee and designated manager enrollment and completion of required brand training programs (initial training, refresher, new product, food safety certification). Captures trainee identity, training program name, training type (classroom, online, in-restaurant), enrollment date, scheduled completion date, actual completion date, pass/fail status, certification issued, and expiration date. Supports compliance tracking for brand standards and ServSafe/NRA certification requirements.';

CREATE OR REPLACE TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` (
    `performance_scorecard_id` BIGINT COMMENT 'System-generated unique identifier for each franchisee performance scorecard record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to franchise.agreement. Business justification: Performance scorecards evaluate franchisee performance against targets defined in the franchise agreement (sales_target_amount, royalty_rate_percent, compliance_review_date). Linking performance_score',
    `brand_id` BIGINT COMMENT 'Foreign key linking to restaurant.brand. Business justification: Performance scorecards in multi-brand franchise systems are brand-specific — a franchisee operating multiple brands has separate scorecards per brand. Brand-level performance benchmarking, NPS trackin',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Performance scorecards are evaluated per financial period; finance uses them to validate royalty payment timeliness and same-store sales growth by period. Foodservice franchise finance teams require p',
    `franchisee_id` BIGINT COMMENT 'Unique identifier of the franchisee to which this scorecard applies.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Performance scorecards aggregate financial metrics (total_royalty_amount, total_sales_amount) that map to profit centers for P&L reporting. Finance needs this link to reconcile scorecard financials ag',
    `average_unit_volume` DECIMAL(18,2) COMMENT 'Average weekly sales per restaurant unit for the franchisee, expressed in local currency.',
    `compliance_audit_average_score` DECIMAL(18,2) COMMENT 'Average score from all compliance audits performed during the period, on a 0‑100 scale.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the scorecard record was first created.',
    `customer_satisfaction_score` DECIMAL(18,2) COMMENT 'Average customer satisfaction rating collected from surveys, on a 0‑100 scale.',
    `evaluation_month` STRING COMMENT 'Numeric month (1‑12) of the evaluation period.',
    `evaluation_period_end` DATE COMMENT 'Last day of the evaluation period covered by the scorecard.',
    `evaluation_period_start` DATE COMMENT 'First day of the evaluation period covered by the scorecard.',
    `evaluation_status` STRING COMMENT 'Current processing status of the scorecard record.. Valid values are `pending|completed|reviewed`',
    `evaluation_type` STRING COMMENT 'Frequency classification of the scorecard (e.g., annual, quarterly, monthly).. Valid values are `annual|quarterly|monthly`',
    `evaluation_year` STRING COMMENT 'Calendar year in which the evaluation period falls.',
    `food_safety_score` DECIMAL(18,2) COMMENT 'Composite score from food safety inspections and audits, on a 0‑100 scale.',
    `net_promoter_score` STRING COMMENT 'Net promoter score for the franchisee, ranging from -100 to 100.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the scorecard.',
    `number_of_restaurants` STRING COMMENT 'Count of active restaurant units owned or operated by the franchisee.',
    `overall_performance_tier` STRING COMMENT 'Tier classification of franchisee performance for the period.. Valid values are `platinum|gold|silver|at_risk`',
    `region_code` STRING COMMENT 'Three‑letter ISO code representing the primary geographic region of the franchisee.. Valid values are `[A-Z]{3}`',
    `royalty_payment_timeliness_pct` DECIMAL(18,2) COMMENT 'Percentage of royalty invoices paid on or before the due date during the period.',
    `same_store_sales_growth_pct` DECIMAL(18,2) COMMENT 'Year‑over‑year percentage change in same‑store sales for the franchisee portfolio.',
    `total_royalty_amount` DECIMAL(18,2) COMMENT 'Total royalty fees accrued for the franchisee during the period.',
    `total_sales_amount` DECIMAL(18,2) COMMENT 'Aggregate gross sales across all franchisee locations for the evaluation period.',
    `training_completion_rate_pct` DECIMAL(18,2) COMMENT 'Proportion of required franchisee staff training modules completed on schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the scorecard record.',
    CONSTRAINT pk_performance_scorecard PRIMARY KEY(`performance_scorecard_id`)
) COMMENT 'Periodic franchisee performance evaluation record aggregating key operational and financial KPIs for a franchisee across their restaurant portfolio. Captures evaluation period, AUV (Average Unit Volume), SSS (Same-Store Sales) growth, CSAT score, NPS, compliance audit average score, royalty payment timeliness, training completion rate, food safety score, and overall performance tier (platinum, gold, silver, at-risk). Supports franchisee recognition programs and remediation prioritization.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ADD CONSTRAINT `fk_franchise_franchisee_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `restaurants_ecm`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ADD CONSTRAINT `fk_franchise_agreement_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ADD CONSTRAINT `fk_franchise_agreement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `restaurants_ecm`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` ADD CONSTRAINT `fk_franchise_billing_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` ADD CONSTRAINT `fk_franchise_billing_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `restaurants_ecm`.`franchise`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` ADD CONSTRAINT `fk_franchise_billing_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` ADD CONSTRAINT `fk_franchise_billing_sales_report_id` FOREIGN KEY (`sales_report_id`) REFERENCES `restaurants_ecm`.`franchise`.`sales_report`(`sales_report_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ADD CONSTRAINT `fk_franchise_sales_report_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ADD CONSTRAINT `fk_franchise_sales_report_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_development_schedule_id` FOREIGN KEY (`development_schedule_id`) REFERENCES `restaurants_ecm`.`franchise`.`development_schedule`(`development_schedule_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ADD CONSTRAINT `fk_franchise_nro_pipeline_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `restaurants_ecm`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ADD CONSTRAINT `fk_franchise_development_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ADD CONSTRAINT `fk_franchise_development_schedule_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ADD CONSTRAINT `fk_franchise_development_schedule_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `restaurants_ecm`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ADD CONSTRAINT `fk_franchise_compliance_audit_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ADD CONSTRAINT `fk_franchise_fee_schedule_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ADD CONSTRAINT `fk_franchise_fee_schedule_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ADD CONSTRAINT `fk_franchise_fee_schedule_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `restaurants_ecm`.`franchise`.`territory`(`territory_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ADD CONSTRAINT `fk_franchise_training_enrollment_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ADD CONSTRAINT `fk_franchise_training_enrollment_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ADD CONSTRAINT `fk_franchise_training_enrollment_nro_pipeline_id` FOREIGN KEY (`nro_pipeline_id`) REFERENCES `restaurants_ecm`.`franchise`.`nro_pipeline`(`nro_pipeline_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ADD CONSTRAINT `fk_franchise_performance_scorecard_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `restaurants_ecm`.`franchise`.`agreement`(`agreement_id`);
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ADD CONSTRAINT `fk_franchise_performance_scorecard_franchisee_id` FOREIGN KEY (`franchisee_id`) REFERENCES `restaurants_ecm`.`franchise`.`franchisee`(`franchisee_id`);

-- ========= TAGS =========
ALTER SCHEMA `restaurants_ecm`.`franchise` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `restaurants_ecm`.`franchise` SET TAGS ('dbx_domain' = 'franchise');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (Address Line 1)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (Address Line 2)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue (Annual Revenue)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `average_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (City)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (Compliance Status)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (Country Code)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (Record Created Timestamp)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating (Credit Rating)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As Name (DBA Name)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `dba_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `dba_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Established Date (Established Date)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `fdd_disclosure_status` SET TAGS ('dbx_business_glossary_term' = 'FDD Disclosure Status (FDD Disclosure Status)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `fdd_disclosure_status` SET TAGS ('dbx_value_regex' = 'disclosed|pending|exempt');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `food_safety_certified` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certified (Food Safety Certified)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `franchise_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee Amount (Franchise Fee Amount)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `franchisee_number` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Number (Franchisee Number)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `franchisee_status` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Status (Franchisee Status)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `franchisee_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `franchisee_type` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Type (Franchisee Type)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `franchisee_type` SET TAGS ('dbx_value_regex' = 'individual|llc|corporation|partnership');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `ifa_membership_status` SET TAGS ('dbx_business_glossary_term' = 'IFA Membership Status (IFA Membership Status)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `ifa_membership_status` SET TAGS ('dbx_value_regex' = 'member|non_member|pending');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `industry_segment` SET TAGS ('dbx_business_glossary_term' = 'Industry Segment (Industry Segment)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `industry_segment` SET TAGS ('dbx_value_regex' = 'qsr|casual|fine_dining');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date (Insurance Expiry Date)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number (Insurance Policy Number)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name (Legal Name)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date (Next Renewal Date)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `number_of_units` SET TAGS ('dbx_business_glossary_term' = 'Number of Units (Number of Units)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (Postal Code)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `royalty_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Fee Amount (Royalty Fee Amount)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate (Royalty Rate)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province (State/Province)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `state_tax_number` SET TAGS ('dbx_business_glossary_term' = 'State Tax ID (State Tax ID)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `state_tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `state_tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_business_glossary_term' = 'Employer Identification Number (EIN)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (Termination Date)');
ALTER TABLE `restaurants_ecm`.`franchise`.`franchisee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (Record Updated Timestamp)');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisor ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `agreement_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisor ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Number');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Status');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending|draft');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Franchise Agreement Type');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'initial|renewal|transfer|amendment');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `amendment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `average_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV)');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `ftc_compliance_attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'FTC Compliance Attestation Flag');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `initial_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Franchise Fee Amount');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `marketing_fee_percent` SET TAGS ('dbx_business_glossary_term' = 'Marketing Fund Contribution Percent');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `renewal_term_years` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Years');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `sales_target_amount` SET TAGS ('dbx_business_glossary_term' = 'Sales Target Amount');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `transfer_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Transfer Rights Flag');
ALTER TABLE `restaurants_ecm`.`franchise`.`agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `area_sq_miles` SET TAGS ('dbx_business_glossary_term' = 'Territory Area (Square Miles)');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Assignment Status');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'assigned|unassigned|pending');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `average_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV) for Territory');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Territory City Name');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Compliance Status');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `dma` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Identifier');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective End Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Territory Effective Start Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `franchise_fee` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee Amount for Territory');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Territory Geographic Boundary (WKT)');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Inspection Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `median_income` SET TAGS ('dbx_business_glossary_term' = 'Territory Median Household Income');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes on Territory');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `number_of_locations` SET TAGS ('dbx_business_glossary_term' = 'Number of Restaurant Locations in Territory');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `population` SET TAGS ('dbx_business_glossary_term' = 'Territory Population Count');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `radius_miles` SET TAGS ('dbx_business_glossary_term' = 'Territory Radius (Miles)');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Territory State/Province Code');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage for Territory');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Lifecycle Status');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type (Exclusive/Protected/Non‑Exclusive)');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'exclusive|protected|non_exclusive');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `trade_area_classification` SET TAGS ('dbx_business_glossary_term' = 'Trade Area Classification');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `trade_area_classification` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `restaurants_ecm`.`franchise`.`territory` ALTER COLUMN `zip_codes` SET TAGS ('dbx_business_glossary_term' = 'Territory ZIP Codes (Comma‑Separated)');
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` ALTER COLUMN `billing_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Identifier');
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`billing` ALTER COLUMN `sales_report_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Report Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `sales_report_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Report ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `delivery_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Platform Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Restaurant Location ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustments Amount');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `average_check_value` SET TAGS ('dbx_business_glossary_term' = 'Average Check Value (ACV)');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `daypart_sales_breakdown` SET TAGS ('dbx_business_glossary_term' = 'Daypart Sales Breakdown');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `franchise_fee` SET TAGS ('dbx_business_glossary_term' = 'Franchise Fee');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `gross_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Sales Amount');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `net_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Sales Amount');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Report Notes');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Type');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `reporting_period_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|yearly');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Amount');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `sales_report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `sales_report_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|validated|rejected');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `same_store_sales` SET TAGS ('dbx_business_glossary_term' = 'Same‑Store Sales (SSS)');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'portal|email|ftp|api');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count (ATC)');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `restaurants_ecm`.`franchise`.`sales_report` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` SET TAGS ('dbx_subdomain' = 'brand_compliance');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `nro_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'New Restaurant Opening (NRO) Pipeline ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `development_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Development Schedule Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `haccp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Haccp Plan Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Opened Unit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Preopening Food Safety Audit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Development Consultant ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `actual_capex_spent` SET TAGS ('dbx_business_glossary_term' = 'Actual CAPEX Spent');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `actual_open_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Open Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `actual_opex_spent` SET TAGS ('dbx_business_glossary_term' = 'Actual OPEX Spent');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `brand` SET TAGS ('dbx_business_glossary_term' = 'Brand');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `brand` SET TAGS ('dbx_value_regex' = 'QSR|Casual|Fine_Dining');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `budget_capex` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Budget');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `budget_opex` SET TAGS ('dbx_business_glossary_term' = 'OPEX Budget');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `capital_investment_estimate` SET TAGS ('dbx_business_glossary_term' = 'Capital Investment Estimate');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `construction_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Construction Complete Flag');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `construction_start_flag` SET TAGS ('dbx_business_glossary_term' = 'Construction Started Flag');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `development_type` SET TAGS ('dbx_business_glossary_term' = 'Development Type');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `development_type` SET TAGS ('dbx_value_regex' = 'new_build|conversion|remodel');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `expected_acuv` SET TAGS ('dbx_business_glossary_term' = 'Expected Average Check Value (ACV)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `expected_cogs_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected COGS Percentage');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `expected_labor_percent` SET TAGS ('dbx_business_glossary_term' = 'Expected Labor Cost Percentage');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `expected_roi` SET TAGS ('dbx_business_glossary_term' = 'Expected Return on Investment (ROI)');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `expected_traffic_volume` SET TAGS ('dbx_business_glossary_term' = 'Expected Traffic Volume');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Score');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `health_inspection_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `last_milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Last Milestone Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `last_milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Last Milestone Name');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Project Notes');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `opening_announced_flag` SET TAGS ('dbx_business_glossary_term' = 'Opening Announced Flag');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `permits_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Permits Obtained Flag');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `project_code` SET TAGS ('dbx_value_regex' = '^NRO-[A-Z0-9]{6}$');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|cancelled|completed');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Project Stage');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `stage_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Stage Change Timestamp');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `target_open_date` SET TAGS ('dbx_business_glossary_term' = 'Target Open Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `training_complete_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Complete Flag');
ALTER TABLE `restaurants_ecm`.`franchise`.`nro_pipeline` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `development_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Development Schedule ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Compliance Status');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `cure_period_months` SET TAGS ('dbx_business_glossary_term' = 'Cure Period (Months)');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `development_phase` SET TAGS ('dbx_business_glossary_term' = 'Development Phase');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `development_phase` SET TAGS ('dbx_value_regex' = 'planning|execution|monitoring|closed');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `development_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Development Schedule Status');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `development_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|completed|default');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule End Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `last_compliance_check` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Check Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Development Schedule Number');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Development Schedule Type');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'MUDA|single_unit|renewal');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Start Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `target_units_year_1` SET TAGS ('dbx_business_glossary_term' = 'Target Units Year 1');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `target_units_year_2` SET TAGS ('dbx_business_glossary_term' = 'Target Units Year 2');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `target_units_year_3` SET TAGS ('dbx_business_glossary_term' = 'Target Units Year 3');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `total_units_committed` SET TAGS ('dbx_business_glossary_term' = 'Total Units Committed');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `units_opened_to_date` SET TAGS ('dbx_business_glossary_term' = 'Units Opened To Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `units_remaining` SET TAGS ('dbx_business_glossary_term' = 'Units Remaining');
ALTER TABLE `restaurants_ecm`.`franchise`.`development_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` SET TAGS ('dbx_subdomain' = 'brand_compliance');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Identifier');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Identifier (AUDITOR_ID)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `brand_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Standard Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `food_safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Audit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Health Inspection Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `health_inspection_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `menu_id` SET TAGS ('dbx_business_glossary_term' = 'Menu Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `primary_compliance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Identifier (AUDITOR_ID)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `primary_compliance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `primary_compliance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Identifier (FRANCHISE_ID)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `audit_disposition` SET TAGS ('dbx_business_glossary_term' = 'Audit Disposition (DISPOSITION)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `audit_disposition` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes (NOTES)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number (AUDIT_NO)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `audit_source_system` SET TAGS ('dbx_business_glossary_term' = 'Audit Source System (SOURCE_SYS)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Timestamp (AUDIT_TS)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (AUDIT_TYPE)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'scheduled|unannounced|follow_up');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `brand_standards_score` SET TAGS ('dbx_business_glossary_term' = 'Brand Standards Section Score (BRAND_SCORE)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `cleanliness_score` SET TAGS ('dbx_business_glossary_term' = 'Cleanliness Section Score (CLN_SCORE)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Lifecycle Status (STATUS)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `compliance_audit_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag (CORR_ACT_REQ)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `critical_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Violations Count (CRIT_VIOL_CNT)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `equipment_score` SET TAGS ('dbx_business_glossary_term' = 'Equipment Section Score (EQP_SCORE)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `food_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Section Score (FS_SCORE)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `non_critical_violations_count` SET TAGS ('dbx_business_glossary_term' = 'Non‑Critical Violations Count (NONCRIT_VIOL_CNT)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Score (OVERALL_SCORE)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `service_score` SET TAGS ('dbx_business_glossary_term' = 'Service Section Score (SRV_SCORE)');
ALTER TABLE `restaurants_ecm`.`franchise`.`compliance_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Identifier');
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`fee_schedule` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` SET TAGS ('dbx_subdomain' = 'brand_compliance');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `training_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `food_safety_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `nro_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Nro Pipeline Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trainee ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `tertiary_training_trainer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trainer ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `tertiary_training_trainer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `tertiary_training_trainer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date (ACD)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag (CF)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CT)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until (EU)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date (ED)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number (ENR)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Hours Completed (HC)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `hours_required` SET TAGS ('dbx_business_glossary_term' = 'Hours Required (HR)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes (EN)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status (PFS)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `scheduled_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Date (SCD)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Training Score (TS)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `training_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status (ES)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `training_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|completed|failed|cancelled|in-progress');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type (TT)');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'classroom|online|in-restaurant');
ALTER TABLE `restaurants_ecm`.`franchise`.`training_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UT)');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` SET TAGS ('dbx_subdomain' = 'brand_compliance');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `performance_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Scorecard ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `franchisee_id` SET TAGS ('dbx_business_glossary_term' = 'Franchisee ID');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `average_unit_volume` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Volume (AUV)');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `compliance_audit_average_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Average Score');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction (CSAT) Score');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_month` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Month');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'pending|completed|reviewed');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `evaluation_year` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Year');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `food_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Score');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `net_promoter_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `number_of_restaurants` SET TAGS ('dbx_business_glossary_term' = 'Number of Restaurants');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `overall_performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Tier');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `overall_performance_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|at_risk');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `royalty_payment_timeliness_pct` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment Timeliness Percentage');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `same_store_sales_growth_pct` SET TAGS ('dbx_business_glossary_term' = 'Same‑Store Sales Growth Percentage (SSS Growth)');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `total_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Royalty Amount');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `total_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Sales Amount');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `training_completion_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Rate Percentage');
ALTER TABLE `restaurants_ecm`.`franchise`.`performance_scorecard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
