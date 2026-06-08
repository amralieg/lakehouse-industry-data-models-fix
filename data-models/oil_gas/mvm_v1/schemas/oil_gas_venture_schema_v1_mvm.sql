-- Schema for Domain: venture | Business: Oil Gas | Version: v1_mvm
-- Generated on: 2026-05-04 09:29:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`venture` COMMENT 'Manages joint operating agreements (JOA), production sharing agreements (PSA), farm-in/farm-out arrangements, and partner relationships. Owns partner equity positions, working interest registers, AFE approvals, joint interest billing (JIB), cost recovery tracking, profit oil/gas splits, partner netting, and cash call management. Supports COPAS accounting standards and SEC partner disclosure. Integrates with SAP Joint Venture Accounting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`joa` (
    `joa_id` BIGINT COMMENT 'Unique identifier for the Joint Operating Agreement record.',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the primary asset, field, or facility governed by the Joint Operating Agreement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: JOAs are primary cost accounting structures in joint ventures; each JOA maps to cost centers for GL posting, budget tracking, and monthly JIB allocation. Essential for SAP CO integration and partner c',
    `partner_id` BIGINT COMMENT 'FK to venture.partner',
    `joa_venture_partner_id` BIGINT COMMENT 'Identifier of the party designated as the operator responsible for day-to-day operations under the Joint Operating Agreement.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: JOAs govern joint operations on specific leased acreage. Operators need lease terms, royalty burdens, and expiry dates for AFE planning, cash call allocation, and compliance with lease obligations.',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: JOAs govern operations that must be conducted under valid operating licenses. The license defines authorized activities, production limits, and compliance obligations that the JOA must incorporate. Cr',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: JOAs define joint operations that roll up to profit centers for segment P&L reporting and management accounting. Standard requirement for oil & gas financial reporting by operated vs non-operated asse',
    `abandonment_provision` STRING COMMENT 'Description of the provisions governing asset abandonment, decommissioning, and Plug and Abandonment (P&A) cost allocation among joint venture partners.',
    `afe_approval_threshold_usd` DECIMAL(18,2) COMMENT 'The monetary threshold in US Dollars above which an Authorization for Expenditure (AFE) requires formal approval from joint venture partners under the Joint Operating Agreement.',
    `amendment_count` STRING COMMENT 'The total number of amendments or modifications made to the Joint Operating Agreement since its original execution.',
    `audit_rights` STRING COMMENT 'Description of the audit rights granted to non-operating partners under the Joint Operating Agreement, including frequency, scope, and cost allocation.',
    `cash_call_frequency` STRING COMMENT 'The frequency at which cash calls are issued to joint venture partners to fund operations under the Joint Operating Agreement.. Valid values are `monthly|quarterly|as_needed|milestone_based`',
    `confidentiality_provision` STRING COMMENT 'Description of the confidentiality and data protection obligations imposed on joint venture partners under the Joint Operating Agreement.',
    `contract_area` STRING COMMENT 'The geographic area, block, lease, or asset covered by the Joint Operating Agreement, including legal descriptions and boundary coordinates.',
    `copas_election` STRING COMMENT 'The COPAS accounting standard elected for joint interest billing and cost allocation under the Joint Operating Agreement (e.g., COPAS 2005, COPAS 2019).. Valid values are `copas_2005|copas_2019|custom|none`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the Joint Operating Agreement record was first created in the system.',
    `default_provision` STRING COMMENT 'Description of the default and remediation provisions that apply when a partner fails to meet financial or operational obligations under the Joint Operating Agreement.',
    `dispute_resolution_method` STRING COMMENT 'The method specified in the Joint Operating Agreement for resolving disputes among partners (e.g., arbitration, mediation, litigation, expert determination).. Valid values are `arbitration|mediation|litigation|expert_determination`',
    `effective_date` DATE COMMENT 'The date on which the Joint Operating Agreement becomes legally binding and operational.',
    `expiry_date` DATE COMMENT 'The date on which the Joint Operating Agreement terminates or expires, if applicable. Null for open-ended agreements.',
    `forfeiture_provision` STRING COMMENT 'Description of the forfeiture provisions that govern the loss of working interest or rights when a partner defaults on obligations under the Joint Operating Agreement.',
    `governing_law` STRING COMMENT 'The legal jurisdiction and governing law under which the Joint Operating Agreement is executed and disputes are resolved (e.g., Texas law, UK law, Norwegian law).',
    `hse_standard` STRING COMMENT 'The Health Safety and Environment (HSE) standards and compliance frameworks that the operator and partners must adhere to under the Joint Operating Agreement.',
    `insurance_requirement` STRING COMMENT 'Description of the insurance coverage requirements specified in the Joint Operating Agreement, including types of coverage, minimum limits, and responsible parties.',
    `interest_rate_late_payment_pct` DECIMAL(18,2) COMMENT 'The annual interest rate percentage applied to late payments by joint venture partners under the Joint Operating Agreement.',
    `joa_name` STRING COMMENT 'The descriptive name or title of the Joint Operating Agreement, typically referencing the asset, block, or contract area covered.',
    `joa_number` STRING COMMENT 'The externally-known business identifier or contract number for the Joint Operating Agreement, used for legal and operational reference.',
    `joa_status` STRING COMMENT 'Current lifecycle status of the Joint Operating Agreement indicating its operational state.. Valid values are `draft|active|suspended|terminated|expired|amended`',
    `last_amendment_date` DATE COMMENT 'The date of the most recent amendment or modification to the Joint Operating Agreement.',
    `last_amendment_description` STRING COMMENT 'A brief description of the most recent amendment or modification made to the Joint Operating Agreement.',
    `modified_by` STRING COMMENT 'The user or system identifier of the person or process that last modified the Joint Operating Agreement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the Joint Operating Agreement record was last modified in the system.',
    `non_operator_rights` STRING COMMENT 'Description of the rights and privileges granted to non-operating partners under the Joint Operating Agreement, including audit rights, information access, and approval thresholds.',
    `notes` STRING COMMENT 'Additional notes, comments, or remarks related to the Joint Operating Agreement for internal reference and documentation purposes.',
    `overhead_rate_method` STRING COMMENT 'The method used to calculate and allocate overhead costs to joint venture partners (e.g., fixed rate, percentage of direct costs, actual costs, hybrid).. Valid values are `fixed|percentage|actual|hybrid`',
    `overhead_rate_value` DECIMAL(18,2) COMMENT 'The numeric value of the overhead rate applied under the Joint Operating Agreement, expressed as a percentage or fixed amount depending on the overhead rate method.',
    `payment_terms_days` STRING COMMENT 'The number of days within which joint venture partners must remit payment in response to a cash call or Joint Interest Billing (JIB) invoice.',
    `source_system` STRING COMMENT 'The name of the source system from which the Joint Operating Agreement record originated (e.g., SAP Joint Venture Accounting, Quorum Land System).',
    `source_system_code` STRING COMMENT 'The unique identifier of the Joint Operating Agreement record in the source system.',
    `transfer_restriction` STRING COMMENT 'Description of restrictions on the transfer, assignment, or sale of working interest under the Joint Operating Agreement, including right of first refusal and consent requirements.',
    `voting_threshold_ordinary_pct` DECIMAL(18,2) COMMENT 'The percentage of working interest votes required to approve ordinary resolutions and routine operational decisions under the Joint Operating Agreement.',
    `voting_threshold_special_pct` DECIMAL(18,2) COMMENT 'The percentage of working interest votes required to approve special resolutions, major capital expenditures, or strategic decisions under the Joint Operating Agreement.',
    `created_by` STRING COMMENT 'The user or system identifier of the person or process that created the Joint Operating Agreement record.',
    CONSTRAINT pk_joa PRIMARY KEY(`joa_id`)
) COMMENT 'Master record for Joint Operating Agreements governing co-ownership and operational responsibilities among working interest partners for a specific asset, block, or contract area. Captures JOA type, effective/expiry dates, governing law, operator designation, non-operator rights, voting thresholds for ordinary and special resolutions, default and forfeiture provisions, COPAS accounting election (2005/2019), overhead rate method, and amendment history. Serves as the foundational legal instrument linking all joint venture cost sharing, revenue allocation, AFE approvals, and partner governance in the venture domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`psa` (
    `psa_id` BIGINT COMMENT 'Unique identifier for the Production Sharing Agreement record. Primary key.',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: PSAs reference specific licensed contract areas and must comply with operating license terms, production capacity limits, and regulatory conditions. License number is typically cited in PSA documentat',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: PSAs are fiscal regimes that map to profit centers for segment reporting and regulatory disclosure. Required for international upstream operations to track contractor vs government entitlements by con',
    `partner_id` BIGINT COMMENT 'Reference to the partner entity designated as the operator for this PSA. The operator manages day-to-day operations and is typically the largest working interest holder.',
    `psa_venture_partner_id` BIGINT COMMENT 'Reference to the National Oil Company or host government entity that is the counterparty to this PSA.',
    `arbitration_forum` STRING COMMENT 'Designated arbitration body or forum for dispute resolution (e.g., International Chamber of Commerce, London Court of International Arbitration, UNCITRAL). Specifies the mechanism for resolving contractual disputes.',
    `contract_area` STRING COMMENT 'Geographic description or block designation of the exploration and production area covered by this PSA. May reference offshore blocks, onshore concessions, or field names.',
    `contractor_profit_share_percent` DECIMAL(18,2) COMMENT 'Base percentage of profit oil/gas allocated to contractors after cost recovery. Used when profit_oil_split_method is fixed_percentage. For tiered or R-factor methods, this represents the initial or minimum contractor share.',
    `cost_recovery_carryforward_allowed` BOOLEAN COMMENT 'Indicates whether unrecovered costs from prior periods may be carried forward to future periods for recovery. True means contractors can accumulate cost pools; False means costs not recovered in a period are forfeited.',
    `cost_recovery_ceiling_percent` DECIMAL(18,2) COMMENT 'Maximum percentage of gross production (in value terms) that contractors may recover as cost oil/gas in any given period. Typical range is 40-80%. Prevents excessive cost recovery in high-production periods.',
    `created_by_user` STRING COMMENT 'User ID or name of the person who created this PSA record in the system. Used for audit and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PSA record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which financial terms (bonuses, expenditure commitments, cost recovery) are denominated. Typically USD for international PSAs.. Valid values are `^[A-Z]{3}$`',
    `depreciation_method` STRING COMMENT 'Method used to depreciate capital expenditures for cost recovery purposes. Unit of production ties depreciation to actual production volumes. Immediate expensing allows full cost recovery in the period incurred.. Valid values are `straight_line|declining_balance|unit_of_production|immediate_expensing`',
    `development_period_years` STRING COMMENT 'Duration in years allocated for the development and production phase. May be extended based on field life and economic production thresholds.',
    `domestic_market_obligation_percent` DECIMAL(18,2) COMMENT 'Percentage of contractor entitlement that must be sold to the domestic market at a regulated or discounted price. Common in PSAs to ensure host country energy security. Also known as DMO.',
    `effective_date` DATE COMMENT 'The date from which the PSA terms become binding and cost recovery and entitlement calculations commence. May differ from signature date pending government approvals.',
    `environmental_compliance_standard` STRING COMMENT 'Reference to the environmental, health, and safety (EHS) standards and regulations that contractors must comply with under this PSA. May reference host country regulations, international standards (ISO 14001), or lender requirements (Equator Principles).',
    `expiry_date` DATE COMMENT 'The date on which the PSA contract term ends, unless extended by mutual agreement or automatic extension clauses. Nullable for contracts with indefinite terms subject to production thresholds.',
    `exploration_period_years` STRING COMMENT 'Duration in years allocated for the exploration phase under the PSA. During this period, contractors conduct seismic surveys, drilling, and appraisal activities.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law that applies to the interpretation and enforcement of the PSA. Typically the host country law, but may reference international arbitration frameworks.',
    `government_profit_share_percent` DECIMAL(18,2) COMMENT 'Base percentage of profit oil/gas allocated to the host government after cost recovery. Used when profit_oil_split_method is fixed_percentage. For tiered or R-factor methods, this represents the initial or maximum government share.',
    `host_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the host government or jurisdiction where the PSA is executed.. Valid values are `^[A-Z]{3}$`',
    `local_content_requirement_percent` DECIMAL(18,2) COMMENT 'Minimum percentage of goods, services, and workforce that must be sourced locally from the host country. Used to promote local economic development and employment.',
    `minimum_expenditure_commitment` DECIMAL(18,2) COMMENT 'Minimum capital expenditure (CAPEX) amount that contractors must invest during the exploration period to satisfy work obligations. Expressed in USD. Non-compliance may trigger penalties or contract termination.',
    `minimum_work_obligation` STRING COMMENT 'Description of the minimum exploration and appraisal work commitments (e.g., seismic surveys, number of wells to be drilled) that contractors must complete during the exploration period. Failure to meet obligations may result in penalties or relinquishment.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this PSA record. Used for audit and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this PSA record was last modified. Used for audit trail and change tracking.',
    `production_bonus_amount` DECIMAL(18,2) COMMENT 'Payment amount due to the host government when the production_bonus_threshold_bopd is achieved. May be recoverable as cost oil depending on PSA terms. Expressed in USD.',
    `production_bonus_threshold_bopd` STRING COMMENT 'Daily production threshold in barrels of oil per day (BOPD) or barrel of oil equivalent (BOE) that triggers a production bonus payment to the host government. Multiple tiers may exist; this represents the first or primary threshold.',
    `profit_oil_split_method` STRING COMMENT 'Methodology used to determine the split of profit oil/gas between the host government and contractors. R-factor is cumulative revenue divided by cumulative costs. Production tier is based on daily or cumulative production volumes. Sliding scale adjusts split based on field profitability.. Valid values are `fixed_percentage|r_factor|production_tier|sliding_scale|rate_of_return`',
    `psa_name` STRING COMMENT 'The business name or title of the PSA, typically referencing the contract area or field name.',
    `psa_number` STRING COMMENT 'The externally-known unique contract number or identifier assigned to this PSA by the host government or National Oil Company (NOC). Used for legal reference and regulatory reporting.',
    `psa_status` STRING COMMENT 'Current lifecycle status of the PSA. Active indicates the contract is in force and production/cost recovery is occurring. Suspended or force majeure indicates temporary halt. Terminated or expired indicates contract end. [ENUM-REF-CANDIDATE: draft|negotiation|executed|active|suspended|force_majeure|terminated|expired — 8 candidates stripped; promote to reference product]',
    `relinquishment_schedule` STRING COMMENT 'Description of the phased relinquishment of contract area that contractors must return to the host government over the exploration and development periods. Typically expressed as percentage of area to be relinquished at specific milestones.',
    `ring_fencing_rule` STRING COMMENT 'Defines whether cost recovery and profit calculations are performed at the contract level (all fields aggregated), field level (each field independent), or block level. Ring fencing prevents cross-subsidization of costs between profitable and unprofitable areas.. Valid values are `contract_level|field_level|block_level|none`',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of gross production paid to the host government as royalty before cost recovery and profit split. Typically ranges from 5-20%. Royalty is deducted from gross production before calculating cost oil and profit oil.',
    `signature_bonus_amount` DECIMAL(18,2) COMMENT 'One-time upfront payment made by contractors to the host government upon signing the PSA. Typically non-recoverable as cost oil. Expressed in USD.',
    `signature_date` DATE COMMENT 'The date on which the PSA was formally signed by all parties. Used for legal and audit purposes.',
    `stabilization_clause` STRING COMMENT 'Legal provision that protects contractors from adverse changes in host government fiscal or regulatory terms during the PSA term. Describes the scope and duration of fiscal stability guarantees.',
    `state_participation_percent` DECIMAL(18,2) COMMENT 'Percentage equity participation by the host government or NOC in the contractor group. State participation entitles the government to a share of contractor entitlement and obligates them to fund their proportionate share of costs. Also known as carried interest if the state does not fund costs.',
    `training_and_technology_transfer_obligation` STRING COMMENT 'Description of contractor obligations to provide training, capacity building, and technology transfer to host country nationals and institutions. May include scholarship programs, technical training, and knowledge sharing.',
    CONSTRAINT pk_psa PRIMARY KEY(`psa_id`)
) COMMENT 'Master record for Production Sharing Agreements (or Production Sharing Contracts) between a host government or National Oil Company and one or more international/independent E&P partners. Captures PSA type, contract area, effective/expiry dates, cost recovery ceiling percentage, profit oil/gas split tiers (R-factor or production-based), royalty rates, signature bonus, state participation percentage, relinquishment schedule, minimum work obligations, stabilization clauses, ring-fencing rules, and governing jurisdiction. SSOT for all PSA-level entitlement, cost recovery, and profit split calculations.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`partner` (
    `partner_id` BIGINT COMMENT 'Primary key for partner',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Operating partners and major non-operators are legal entities with company codes for intercompany JIB settlements, netting transactions, and consolidated financial reporting. Required for intercompany',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Partners must register with and report to regulatory authorities in their primary jurisdiction of operation. Used for tracking partner compliance status, KYC requirements, and regulatory standing. Ess',
    `annual_revenue_amount` DECIMAL(18,2) COMMENT 'Most recent annual revenue of the partner organization in the specified currency. Used for partner financial strength assessment and credit risk evaluation.',
    `annual_revenue_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the annual revenue amount.. Valid values are `^[A-Z]{3}$`',
    `api_partner_code` STRING COMMENT 'Standardized partner identifier assigned by the American Petroleum Institute for industry-wide partner identification and data exchange.',
    `classification` STRING COMMENT 'Functional role of the partner in joint venture operations. Operator manages day-to-day operations; non-operator holds interest but does not operate; working interest owner bears proportionate costs; royalty owner receives revenue without cost burden; overriding royalty owner holds carved-out interest; area of mutual interest indicates exploration partnership.. Valid values are `operator|non_operator|working_interest_owner|royalty_owner|overriding_royalty_owner|area_of_mutual_interest`',
    `country_of_incorporation` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the jurisdiction where the partner entity is legally incorporated.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner master record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed for the partner before requiring prepayment or additional security under joint interest billing terms.',
    `credit_limit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit limit amount.. Valid values are `^[A-Z]{3}$`',
    `credit_rating` STRING COMMENT 'External credit rating assigned by a recognized rating agency (e.g., Moodys, S&P, Fitch). Used for partner risk assessment, cash call management, and default provisions in JOA.',
    `default_interest_rate_percent` DECIMAL(18,2) COMMENT 'Annual interest rate applied to overdue balances when partner fails to remit payment within payment terms, as specified in the JOA.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet for business entity identification and credit assessment.. Valid values are `^[0-9]{9}$`',
    `entity_type` STRING COMMENT 'Classification of the partner organization. IOC = International Oil Company, NOC = National Oil Company, independent = independent producer, government = government entity, private_equity = financial investor, service_company = oilfield service provider.. Valid values are `IOC|NOC|independent|government|private_equity|service_company`',
    `is_government_entity` BOOLEAN COMMENT 'Boolean flag indicating whether the partner is a government or state-owned entity. True = government entity; False = private entity. Used for PSA compliance and regulatory reporting.',
    `is_operator` BOOLEAN COMMENT 'Boolean flag indicating whether this partner serves as the operator for any joint venture properties. True = partner is an operator; False = partner is non-operator only.',
    `kyc_completion_date` DATE COMMENT 'Date when the most recent Know Your Customer due diligence process was completed for this partner, including identity verification, beneficial ownership disclosure, and sanctions screening.',
    `kyc_review_due_date` DATE COMMENT 'Date when the next periodic KYC review is required for this partner to maintain compliance with anti-money laundering and sanctions regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner master record was most recently updated.',
    `legal_name` STRING COMMENT 'Full legal name of the partner entity as registered with the governing jurisdiction. Used for contract execution, regulatory filings, and SEC partner disclosure.',
    `partner_status` STRING COMMENT 'Current lifecycle status of the partner relationship. Active = participating in operations; inactive = no current participation; suspended = temporarily restricted; defaulted = failed to meet payment obligations; withdrawn = exited joint venture.. Valid values are `active|inactive|suspended|defaulted|withdrawn`',
    `partnership_end_date` DATE COMMENT 'Date when the partner exited all joint venture relationships with the company, either through sale of interest, withdrawal, or termination. Null for active partners.',
    `partnership_start_date` DATE COMMENT 'Date when the partner first entered into a joint venture, JOA, or PSA relationship with the company. Used for partner tenure analysis and relationship management.',
    `payment_terms_days` STRING COMMENT 'Standard number of days allowed for partner to remit payment after joint interest billing invoice date, as defined in the JOA or PSA.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for operational correspondence, AFE distribution, and joint interest billing communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact for joint venture operations, AFE approvals, and partner communications.',
    `primary_contact_phone` STRING COMMENT 'Telephone number of the primary business contact for urgent operational matters and partner coordination.',
    `registered_address_line1` STRING COMMENT 'First line of the partners registered legal address as filed with the incorporation jurisdiction.',
    `registered_address_line2` STRING COMMENT 'Second line of the partners registered legal address (suite, floor, building name).',
    `registered_city` STRING COMMENT 'City of the partners registered legal address.',
    `registered_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the partners registered legal address.. Valid values are `^[A-Z]{3}$`',
    `registered_postal_code` STRING COMMENT 'Postal or ZIP code of the partners registered legal address.',
    `registered_state_province` STRING COMMENT 'State, province, or administrative region of the partners registered legal address.',
    `sanctioned_entity_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the partner is subject to international trade sanctions or export controls. True = sanctioned; False = not sanctioned. Used for compliance screening and OFAC reporting.',
    `sap_partner_number` STRING COMMENT 'Unique partner master record identifier in SAP Joint Venture Accounting module. Used for joint interest billing, partner netting, and AFE management.',
    `sap_vendor_number` STRING COMMENT 'Unique vendor master record identifier in SAP S/4HANA system. Links partner to accounts payable, procurement, and joint interest billing processes.',
    `short_name` STRING COMMENT 'Abbreviated or common name used for operational reporting, dashboards, and internal communications.',
    `stock_exchange_ticker` STRING COMMENT 'Public stock exchange ticker symbol if the partner is a publicly traded company. Used for market capitalization tracking and financial health monitoring.',
    `tax_identification_number` STRING COMMENT 'Government-issued tax identification number for the partner entity. Format varies by jurisdiction (e.g., EIN in USA, VAT number in EU).',
    `tax_jurisdiction` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary tax jurisdiction for the partner. May differ from country of incorporation for tax domicile purposes.. Valid values are `^[A-Z]{3}$`',
    `website_url` STRING COMMENT 'Official website URL of the partner organization for reference and due diligence purposes.',
    CONSTRAINT pk_partner PRIMARY KEY(`partner_id`)
) COMMENT 'Master record for each legal entity participating in a joint venture, JOA, or PSA. Captures partner legal name, entity type (IOC, NOC, independent, government), country of incorporation, API partner code, SAP vendor/partner number, contact details, credit rating, and partner classification. Prefixed venture_ to avoid collision with the customer domains counterparty records. SSOT for partner identity within the venture domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` (
    `venture_working_interest_id` BIGINT COMMENT 'Unique identifier for the working interest position record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: Partners hold working interest in processing facilities and compression stations, not only wells. venture_working_interest has well_asset_id but no asset_facility_id. Facility-level working interest t',
    `block_id` BIGINT COMMENT 'Foreign key linking to exploration.block. Business justification: Working interest is held in specific exploration blocks. Direct block linkage on venture_working_interest enables block-level WI portfolio reporting, SEC reserve disclosure by block, and regulatory fi',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Working interest positions drive partner-specific cost allocation; each WI position maps to cost centers for SAP JVA partner share tracking, billing allocation, and working interest percentage-based c',
    `farmout_id` BIGINT COMMENT 'Foreign key linking to venture.farmout. Business justification: A working interest position in venture_working_interest may have been created or modified as a result of a farmout transaction. Adding farmout_id to venture_working_interest links the WI register entr',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement governing this working interest position.',
    `partner_id` BIGINT COMMENT 'Reference to the joint venture partner holding this working interest position.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Partners hold working interest in jointly-owned pipeline segments. venture_working_interest has well_asset_id but no pipeline_segment_id. Pipeline working interest percentages drive tariff revenue all',
    `psa_id` BIGINT COMMENT 'Reference to the Production Sharing Agreement governing this working interest position, if applicable.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Working-interest percentages apply to specific reservoirs for net-reserves calculations and SEC disclosure; venture_working_interest already has lease_id and well_asset_id but reservoir-level WI attri',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Working interests are tracked at WBS element level for detailed project cost allocation by partner. Enables project-level partner accounting for AFE cost tracking and billing allocation.',
    `well_asset_id` BIGINT COMMENT 'Reference to the asset (well, field, lease, or facility) covered by this working interest position.',
    `afe_approval_required_flag` BOOLEAN COMMENT 'Indicates whether this partner must provide AFE approval for capital expenditures on the asset.',
    `afe_approval_threshold_usd` DECIMAL(18,2) COMMENT 'The dollar threshold above which this partners AFE approval is required, expressed in US dollars.',
    `assignment_date` DATE COMMENT 'The date on which the assignment or conveyance of this working interest was executed.',
    `assignment_reference` STRING COMMENT 'Reference number or identifier for the assignment or conveyance document that established or modified this working interest position.',
    `billing_allocation_method` STRING COMMENT 'The method used to allocate joint interest billing charges to this partner for this working interest position.. Valid values are `proportional|fixed|custom`',
    `carried_interest_flag` BOOLEAN COMMENT 'Indicates whether this working interest position is carried (costs borne by another party) during a specified phase of operations.',
    `carried_through_phase` STRING COMMENT 'The operational phase through which the working interest is carried, if applicable.. Valid values are `exploration|drilling|completion|production|none`',
    `cash_call_eligible_flag` BOOLEAN COMMENT 'Indicates whether this working interest position is subject to cash call obligations for funding operations.',
    `cost_recovery_limit_usd` DECIMAL(18,2) COMMENT 'The maximum amount of costs that can be recovered by the partner under a PSA or other cost recovery arrangement, expressed in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this working interest position record was first created in the system.',
    `effective_date` DATE COMMENT 'The date from which this working interest position becomes effective and binding.',
    `expiry_date` DATE COMMENT 'The date on which this working interest position expires or terminates, if applicable. Null for open-ended positions.',
    `modified_by` STRING COMMENT 'The user or system identifier that last modified this working interest position record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this working interest position record was last modified.',
    `non_consent_option` STRING COMMENT 'Indicates whether the partner has the option to elect non-consent status for proposed operations under the JOA.. Valid values are `allowed|not_allowed|conditional`',
    `non_consent_penalty_percentage` DECIMAL(18,2) COMMENT 'The penalty percentage applied to a partners working interest if they elect non-consent status, as defined in the JOA.',
    `nri_percentage` DECIMAL(18,2) COMMENT 'The percentage of net revenue interest held by the partner after deducting royalties and overriding royalty interests. Represents the partners share of production revenue.',
    `operator_flag` BOOLEAN COMMENT 'Indicates whether this partner is the designated operator for the asset under this agreement.',
    `orri_percentage` DECIMAL(18,2) COMMENT 'The percentage of overriding royalty interest, if any, carved out from the working interest. Represents a non-cost-bearing interest in production.',
    `partner_netting_flag` BOOLEAN COMMENT 'Indicates whether this partner participates in partner netting arrangements for joint interest billing settlements.',
    `payout_date` DATE COMMENT 'The date on which payout was achieved for this working interest position, if applicable.',
    `payout_status` STRING COMMENT 'Indicates whether the working interest has reached payout (recovery of capital costs), affecting revenue distribution.. Valid values are `pre-payout|post-payout|not_applicable`',
    `profit_gas_split_percentage` DECIMAL(18,2) COMMENT 'The partners share of profit gas under a Production Sharing Agreement, after cost recovery.',
    `profit_oil_split_percentage` DECIMAL(18,2) COMMENT 'The partners share of profit oil under a Production Sharing Agreement, after cost recovery.',
    `reversion_nri_percentage` DECIMAL(18,2) COMMENT 'The net revenue interest percentage that applies after payout or after a specified reversion event, if different from the initial NRI percentage.',
    `reversion_wi_percentage` DECIMAL(18,2) COMMENT 'The working interest percentage that applies after payout or after a specified reversion event, if different from the initial WI percentage.',
    `sap_jva_cost_object` STRING COMMENT 'The SAP JVA cost object or cost center code used for tracking costs and billing allocations for this working interest position.',
    `sec_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this working interest position must be disclosed in SEC partner disclosure filings.',
    `termination_date` DATE COMMENT 'The date on which this working interest position was terminated, if applicable.',
    `termination_reason` STRING COMMENT 'The reason for termination of this working interest position, if terminated.',
    `venture_working_interest_status` STRING COMMENT 'Current lifecycle status of the working interest position.. Valid values are `active|suspended|terminated|pending`',
    `wi_percentage` DECIMAL(18,2) COMMENT 'The percentage of working interest held by the partner in the asset. Represents the partners share of capital and operating costs.',
    CONSTRAINT pk_venture_working_interest PRIMARY KEY(`venture_working_interest_id`)
) COMMENT 'SSOT register of working interest (WI) positions held by each partner in each JOA or PSA-covered asset. Captures WI percentage, net revenue interest (NRI), overriding royalty interest (ORRI), carried interest flag, effective date, expiry date, assignment history reference, and SAP JVA cost object. Supports SEC partner disclosure and COPAS billing allocation. One record per partner per agreement per effective period.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`farmout` (
    `farmout_id` BIGINT COMMENT 'Primary key for farmout',
    `block_id` BIGINT COMMENT 'Foreign key linking to exploration.block. Business justification: Farmout transactions transfer working interest in specific exploration blocks. Direct block linkage on farmout enables block-level farmout portfolio tracking, regulatory approval filing (which require',
    `partner_id` BIGINT COMMENT 'Reference to the partner acquiring the working interest in a farm-in transaction (the incoming party).',
    `farmout_farmor_partner_id` BIGINT COMMENT 'Reference to the partner divesting the working interest in a farm-out transaction (the outgoing party).',
    `field_id` BIGINT COMMENT 'Foreign key linking to production.field. Business justification: Farmout transactions are field or acreage-specific; linking farmout to field enables field-level farmout tracking, earn-in monitoring, and production milestone verification for back-in right triggers.',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this farm-in/farm-out transaction is executed.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Farm-in/out transactions transfer working interests in specific leases. Lease_id defines transaction scope, acreage transferred, and post-transaction interest calculations for division orders and reve',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Farmout earn-in conditions are frequently tied to drilling a specific prospect. Direct prospect linkage on farmout enables earn-in status tracking against prospect drilling milestones, work program ob',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Farmout transactions can occur under PSA contracts as well as JOAs, particularly in international upstream operations where a contractor farms out part of its PSA interest. farmout currently has joa_i',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Farmout transactions require regulatory approval and permit transfers between farmor and farminee. The approval permit documents regulatory authority consent to the transaction. Essential for tracking',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Farmout earn-in obligations are typically tied to drilling or developing a specific reservoir target; the farminees work-program commitment (wells count, capex) is evaluated against the reservoirs r',
    `tract_id` BIGINT COMMENT 'Foreign key linking to land.tract. Business justification: Farmouts often convey specific tracts within a lease for earn-in obligations. Tract-level tracking required for acreage earn-in verification, title transfer documentation, and back-in right calculatio',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Farmout transactions have dedicated WBS elements for tracking farminee earn-in work program costs and carry obligations. Standard project accounting for farm-in/farm-out capital tracking and payout mo',
    `ami_expiration_date` DATE COMMENT 'The date on which the Area of Mutual Interest clause expires.',
    `area_of_mutual_interest_flag` BOOLEAN COMMENT 'Indicates whether an Area of Mutual Interest clause applies, requiring parties to offer participation rights in future acquisitions within a defined geographic area.',
    `back_in_right_flag` BOOLEAN COMMENT 'Indicates whether the farmor retains a back-in right to reacquire a portion of the working interest after the farminee has earned their interest and recovered costs.',
    `back_in_trigger_event` STRING COMMENT 'Description of the event or milestone that triggers the farmors back-in right (e.g., payout, commercial production).',
    `back_in_wi_percent` DECIMAL(18,2) COMMENT 'The percentage of working interest the farmor can reacquire if the back-in right is exercised.',
    `carry_obligation_amount` DECIMAL(18,2) COMMENT 'The total dollar amount of drilling and completion costs that the farminee agrees to carry (pay on behalf of the farmor) as consideration for the working interest transfer.',
    `carry_obligation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the carry obligation amount (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `cash_consideration_amount` DECIMAL(18,2) COMMENT 'The cash payment amount exchanged as part of the farm-in/farm-out transaction, if applicable.',
    `cash_consideration_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the cash consideration amount.. Valid values are `^[A-Z]{3}$`',
    `closing_date` DATE COMMENT 'The date on which the transaction closed and all conditions precedent were satisfied.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this farm-in/farm-out transaction record was first created in the system.',
    `earn_in_condition` STRING COMMENT 'Description of the conditions the farminee must satisfy to earn the working interest (e.g., drill to total depth, complete production testing).',
    `earn_in_status` STRING COMMENT 'Current status of the farminees progress toward satisfying the earn-in conditions.. Valid values are `not-started|in-progress|completed|failed`',
    `effective_date` DATE COMMENT 'The date on which the working interest transfer becomes effective for accounting and revenue allocation purposes.',
    `execution_date` DATE COMMENT 'The date on which the farm-in/farm-out agreement was signed by all parties.',
    `non_consent_penalty_factor` DECIMAL(18,2) COMMENT 'The penalty multiplier applied to the non-consenting partys share of costs (e.g., 300 for a 300% penalty).',
    `non_consent_penalty_flag` BOOLEAN COMMENT 'Indicates whether a non-consent penalty applies if the farmor elects not to participate in future operations after the farm-out.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special conditions related to the farm-in/farm-out transaction.',
    `nri_transferred_percent` DECIMAL(18,2) COMMENT 'The percentage of net revenue interest being transferred, after deducting royalties and overriding royalty interests, expressed as a decimal.',
    `operator_consent_flag` BOOLEAN COMMENT 'Indicates whether the operator of the joint venture has consented to the farm-in/farm-out transaction.',
    `preferential_right_flag` BOOLEAN COMMENT 'Indicates whether the farmor retains a preferential right to purchase or match any third-party offer for the farminees interest.',
    `regulatory_agency` STRING COMMENT 'The name of the regulatory agency or commission that approved or is reviewing the transaction (e.g., BSEE, Texas Railroad Commission).',
    `regulatory_approval_date` DATE COMMENT 'The date on which regulatory approval was granted for the transaction.',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory approval for the farm-in/farm-out transaction from governing bodies such as BSEE, BOEM, or state regulatory commissions.. Valid values are `pending|approved|rejected|not-required|conditional`',
    `sec_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether this transaction requires disclosure in SEC filings due to materiality thresholds.',
    `transaction_number` STRING COMMENT 'Business identifier for the farm-in/farm-out transaction, typically used in external communications and regulatory filings.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the farm-in/farm-out transaction.. Valid values are `draft|pending|executed|closed|cancelled|terminated`',
    `transaction_type` STRING COMMENT 'Indicates whether this is a farm-in (acquiring working interest) or farm-out (divesting working interest) transaction.. Valid values are `farm-in|farm-out`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this farm-in/farm-out transaction record was last modified in the system.',
    `wi_transferred_percent` DECIMAL(18,2) COMMENT 'The percentage of working interest being transferred from farmor to farminee, expressed as a decimal (e.g., 25.000000 for 25%).',
    `work_program_commitment` STRING COMMENT 'Description of the drilling, completion, or development work program that the farminee commits to execute as part of the transaction terms.',
    `work_program_deadline_date` DATE COMMENT 'The date by which the farminee must complete the committed work program to earn the working interest.',
    `work_program_wells_count` STRING COMMENT 'The number of wells the farminee commits to drill or complete under the work program commitment.',
    CONSTRAINT pk_farmout PRIMARY KEY(`farmout_id`)
) COMMENT 'Tracks farm-in and farm-out transactions where a partner acquires or divests a working interest stake in exchange for drilling carries, cash consideration, or work program commitments. Captures transaction type (farm-in/farm-out), farminee, farmor, interest transferred, carry obligation amount, work program milestones, effective date, and regulatory approval status. Links to the working_interest register for post-transaction WI updates.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`venture_afe` (
    `venture_afe_id` BIGINT COMMENT 'Unique identifier for the Authorization for Expenditure record. Primary key for the AFE master data.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Venture AFEs must link to procurement AFE budgets for cost tracking, variance analysis, and JIB billing. Essential for joint venture cost control and partner allocation in oil-and-gas operations.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: AFEs are issued for facility-level capital projects (compression upgrades, processing plant expansions). venture_afe already has well_asset_id; adding asset_facility_id enables facility-level AFE appr',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: AFEs frequently reference master service contracts (drilling, construction, facility O&M) that govern work scope and rates. AFE approval workflows validate contract terms, available capacity, and rate',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Venture AFEs (joint venture operational view) must reconcile to finance AFEs (GL capitalization view) for AFE cost variance analysis, budget-to-actual reporting, and capital vs. expense classification',
    `joa_id` BIGINT COMMENT 'Foreign key reference to the Joint Operating Agreement under which this AFE is issued. The JOA governs partner rights, obligations, and approval thresholds for expenditures.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: AFEs authorize capital and operating expenditures on specific leases. Lease-level cost tracking is essential for JIB allocation, partner billing, and lease-level profitability analysis.',
    `operating_committee_id` BIGINT COMMENT 'Foreign key linking to venture.operating_committee. Business justification: Large AFEs (above the approval threshold) require Operating Committee approval under the JOA. venture_afe has joa_id and approval_threshold_amount but no FK to the operating_committee that governs the',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: AFEs authorize capital work programs that must be conducted under valid operating licenses. Regulatory authorities require AFEs to reference the license number authorizing the activity. Essential for ',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: Venture AFEs are prepared by operator for JOA/PSA approval. Operator reference required for AFE approval routing, non-consent election tracking, and cost allocation verification in joint venture opera',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: AFEs for drilling, completion, and facility operations require permits (APD, air quality, water discharge, ROW). Linking AFE to permit enables tracking of permit compliance for authorized work program',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Venture AFEs represent work authorizations that are organized under capital projects for multi-year program tracking. Finance.project is the master project hierarchy. Standard project accounting integ',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: AFEs can be issued under PSA contracts for development and exploration expenditures, not only under JOAs. venture_afe has joa_id but no psa_id. Adding psa_id (nullable) allows AFEs to be associated wi',
    `partner_id` BIGINT COMMENT 'Foreign key reference to the legal entity acting as operator for this AFE. The operator is responsible for executing the work program and billing partners per their working interest.',
    `actual_cost_to_date` DECIMAL(18,2) COMMENT 'Cumulative actual expenditure incurred against this AFE as of the last accounting period close. Used to monitor spending against the approved budget and trigger variance reporting.',
    `afe_number` STRING COMMENT 'The externally-known business identifier for the AFE, typically formatted per operator standards and shared with Joint Operating Agreement (JOA) partners for approval and billing reference.',
    `afe_status` STRING COMMENT 'Current lifecycle status of the AFE. Draft indicates initial preparation; Submitted indicates sent to partners for approval; Approved indicates partner consent received; In Progress indicates work has commenced; Completed indicates work finished; Closed indicates final accounting reconciliation complete. [ENUM-REF-CANDIDATE: Draft|Submitted|Approved|Rejected|In Progress|Completed|Closed|Cancelled — 8 candidates stripped; promote to reference product]',
    `afe_type` STRING COMMENT 'Classification of the AFE by expenditure category. CAPEX represents capital expenditure for long-term assets; OPEX represents operating expenditure for ongoing operations; Drilling, Workover, Facility, and Seismic represent specific work program types.. Valid values are `CAPEX|OPEX|Drilling|Workover|Facility|Seismic`',
    `approval_deadline_date` DATE COMMENT 'The date by which partners must respond with approval or objection per the JOA approval process. Silence after this date may constitute deemed approval depending on JOA terms.',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'The monetary threshold defined in the JOA above which partner approval is required for this AFE. AFEs below this threshold may be approved by the operator without explicit partner consent.',
    `authorization_level` STRING COMMENT 'The organizational approval level required for this AFE based on its size and risk profile. Higher-value or higher-risk AFEs require escalation to senior management or board approval.. Valid values are `Field|Regional|Corporate|Board`',
    `billing_method` STRING COMMENT 'The method by which partners will be billed for this AFE. Actual indicates billing based on actual costs incurred; Estimate indicates billing based on the approved estimate; Turnkey indicates a fixed-price arrangement.. Valid values are `Actual|Estimate|Turnkey`',
    `comments` STRING COMMENT 'Free-form text field for additional notes, clarifications, or special instructions related to this AFE. Used for communication between operator and partners.',
    `contingency_amount` DECIMAL(18,2) COMMENT 'Additional budget allowance added to the operator estimate to cover unforeseen costs, typically expressed as a percentage of the base estimate and included in the total AFE authorization.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this AFE record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this AFE (e.g., USD, GBP, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `final_approval_date` DATE COMMENT 'The date on which the AFE received final approval from all required partners or was deemed approved per JOA terms, authorizing the operator to commence work.',
    `modified_by` STRING COMMENT 'User ID or name of the individual who last modified this AFE record. Used for audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this AFE record was last modified in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and change tracking.',
    `non_consent_election_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether any partner elected to go non-consent on this AFE per JOA provisions, forfeiting their working interest in the project in exchange for avoiding the expenditure.',
    `operator_estimate_amount` DECIMAL(18,2) COMMENT 'The operators estimated total cost for the work program before contingency, expressed in the AFE currency. This is the base cost estimate submitted to partners for approval.',
    `overhead_rate_percent` DECIMAL(18,2) COMMENT 'The percentage rate applied to direct costs to recover indirect costs and overhead per the JOA and COPAS accounting procedures. Expressed as a percentage (e.g., 5.00 for 5%).',
    `risk_category` STRING COMMENT 'Operators assessment of the technical, operational, or financial risk associated with this AFE work program. Used for partner evaluation and internal risk management.. Valid values are `Low|Medium|High|Critical`',
    `submission_date` DATE COMMENT 'The date on which the AFE was formally submitted to JOA partners for review and approval. Starts the approval clock per JOA terms.',
    `supplemental_afe_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether a supplemental AFE is required due to cost overruns exceeding the approved contingency or scope changes requiring additional partner approval.',
    `total_approved_amount` DECIMAL(18,2) COMMENT 'The final authorized expenditure limit approved by JOA partners, including operator estimate plus contingency. This is the spending authority granted to the operator for the work program.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between actual cost to date and the total approved amount. Positive variance indicates overspend; negative variance indicates underspend. Material variances may require supplemental AFE approval.',
    `variance_explanation` STRING COMMENT 'Narrative explanation provided by the operator for material cost variances, documenting reasons for overspend or underspend and any corrective actions taken.',
    `wbs_element` STRING COMMENT 'Reference to the SAP Project System (PS) Work Breakdown Structure element that tracks costs and budget for this AFE in the ERP system. Enables integration between AFE management and financial accounting.',
    `work_completion_date` DATE COMMENT 'The planned or actual date on which the work program covered by this AFE was completed. Triggers final cost reconciliation and closeout processes.',
    `work_program_description` STRING COMMENT 'Detailed narrative description of the proposed work program covered by this AFE, including scope, objectives, technical approach, and expected deliverables. Used by partners to evaluate and approve the expenditure request.',
    `work_start_date` DATE COMMENT 'The planned or actual date on which the work program covered by this AFE commenced. Used for project tracking and schedule management.',
    `created_by` STRING COMMENT 'User ID or name of the individual who created this AFE record in the system. Used for audit trail and accountability.',
    CONSTRAINT pk_venture_afe PRIMARY KEY(`venture_afe_id`)
) COMMENT 'Authorization for Expenditure (AFE) master record representing a formal budget approval request submitted to JOA partners for a specific capital or operating work program (well drilling, workover, facility construction, seismic). Captures AFE number, AFE type (CAPEX/OPEX), work program description, operator estimate, contingency, partner approval status per WI, total approved amount, and SAP PS WBS element reference. SSOT for AFE lifecycle management.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`afe_approval` (
    `afe_approval_id` BIGINT COMMENT 'Unique identifier for each partners individual approval or rejection response to an AFE. Primary key for the AFE approval record.',
    `partner_id` BIGINT COMMENT 'Reference to the joint venture partner entity submitting this approval or rejection response. Identifies which working interest owner or revenue interest holder is providing consent or objection to the proposed expenditure.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: AFE approvals in the exploration phase are issued for drilling specific prospects. Direct prospect linkage on afe_approval enables prospect-level AFE approval status tracking, non-consent election rep',
    `venture_afe_id` BIGINT COMMENT 'Foreign key linking to venture.venture_afe. Business justification: afe_approval tracks each partners individual approval or rejection response to an AFE. The venture_afe is the AFE master record in the venture domain. Currently afe_approval only references drilling.',
    `venture_working_interest_id` BIGINT COMMENT 'Foreign key linking to venture.venture_working_interest. Business justification: afe_approval stores partner_working_interest as a denormalized DECIMAL field capturing the partners WI percentage at the time of approval. Adding venture_working_interest_id links the approval to the',
    `approval_date` DATE COMMENT 'The calendar date on which the partner submitted their approval, rejection, or conditional approval response. Used to track compliance with JOA-mandated response deadlines and to determine if consent was timely.',
    `approval_document_reference` STRING COMMENT 'Reference identifier or file path to the formal approval document, email, or correspondence submitted by the partner. Enables retrieval of source documentation for audit and dispute resolution purposes.',
    `approval_method` STRING COMMENT 'The communication channel or method through which the partner submitted their approval or rejection response. Used for audit trail and to assess effectiveness of different communication channels.. Valid values are `email|portal|fax|mail|verbal|meeting`',
    `approval_status` STRING COMMENT 'Current status of the partners response to the AFE. Approved indicates full consent; rejected indicates refusal; pending indicates no response received; conditionally approved indicates consent with attached conditions or modifications; non-consent indicates formal election to not participate per JOA non-consent provisions.. Valid values are `approved|rejected|pending|conditionally_approved|non_consent`',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise date and time when the partners approval response was received or recorded in the system. Provides audit trail for time-sensitive consent tracking and dispute resolution.',
    `approved_amount` DECIMAL(18,2) COMMENT 'The monetary amount approved by the partner for this AFE, expressed in the AFEs functional currency. May differ from the requested amount if partner approves a reduced scope or applies a cap. Null if status is rejected or pending.',
    `approved_amount_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the approved amount (e.g., USD, CAD, GBP). Ensures proper currency handling in multi-currency joint venture environments.. Valid values are `^[A-Z]{3}$`',
    `cash_call_issued_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a cash call has been issued to this partner for their share of the approved AFE. True if cash call issued; false otherwise. Links AFE approval to downstream billing processes.',
    `comments` STRING COMMENT 'Additional comments, notes, or clarifications provided by the partner or operator regarding the approval decision. May include context for conditional approvals, clarifications on scope, or internal notes for tracking purposes.',
    `conditions_attached` STRING COMMENT 'Specific conditions, modifications, or stipulations attached by the partner to their conditional approval. May include cost caps, scope changes, milestone requirements, or additional reporting obligations. Null if approval is unconditional or status is rejected/pending.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this AFE approval record was first created in the joint venture accounting system. Provides audit trail for record lifecycle tracking.',
    `deemed_consent_applied` BOOLEAN COMMENT 'Boolean flag indicating whether deemed consent provisions were applied to this partner due to failure to respond within the JOA-mandated timeframe. True if deemed consent was invoked; false otherwise. Deemed consent treats non-response as approval per JOA terms.',
    `escalation_level` STRING COMMENT 'Current escalation status for non-responsive partners. Tracks the progression of follow-up actions taken by the operator to obtain partner response, from initial reminders through deemed consent application or legal review.. Valid values are `none|first_reminder|second_reminder|final_notice|deemed_consent_pending|legal_review`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this AFE approval record was last updated or modified. Tracks changes to approval status, amounts, or conditions over time for audit and compliance purposes.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this AFE approval record. Provides accountability and audit trail for data changes in the joint venture accounting system.',
    `non_consent_election` BOOLEAN COMMENT 'Boolean flag indicating whether the partner formally elected non-consent status for this AFE per JOA non-consent provisions. True if partner elected non-consent; false otherwise. Non-consenting partners forfeit participation rights but avoid cost exposure, subject to JOA penalty provisions.',
    `partner_share_amount` DECIMAL(18,2) COMMENT 'The calculated monetary amount representing this partners proportionate share of the total AFE cost based on their working interest percentage. Used for joint interest billing (JIB) and cash call preparation.',
    `rejection_category` STRING COMMENT 'Standardized classification of the rejection reason for reporting and trend analysis. Enables operator to identify common objection patterns and improve AFE quality.. Valid values are `cost_excessive|technical_risk|strategic_misalignment|procedural_deficiency|budget_constraint|scope_unclear`',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the partner for rejecting the AFE or electing non-consent. May include technical concerns, cost objections, strategic misalignment, or procedural issues. Null if status is approved or pending.',
    `response_due_date` DATE COMMENT 'The deadline date by which the partner must submit their approval or rejection response per JOA provisions. Used to track overdue responses and trigger escalation procedures for non-responsive partners.',
    `response_overdue_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the partners response is overdue based on the response due date. True if current date exceeds due date and status is still pending; false otherwise. Triggers escalation and deemed-consent evaluation per JOA.',
    `voting_threshold_met` BOOLEAN COMMENT 'Boolean flag indicating whether the cumulative working interest of all approving partners (including this approval) meets or exceeds the JOA-mandated voting threshold for this AFE type. True if threshold is met; false otherwise. Calculated field updated as approvals are received.',
    CONSTRAINT pk_afe_approval PRIMARY KEY(`afe_approval_id`)
) COMMENT 'Tracks each partners individual approval or rejection response to an AFE. Captures partner reference, approval status (approved, rejected, pending, conditionally approved), approved amount, rejection reason, approval date, approver name, and any conditions attached. Enables operator to track consent thresholds per JOA voting provisions and escalate non-responses. One record per partner per AFE.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`jib_statement` (
    `jib_statement_id` BIGINT COMMENT 'Primary key for jib_statement',
    `asset_facility_id` BIGINT COMMENT 'Reference to the specific facility to which the costs in this Joint Interest Billing statement are attributed, if applicable.',
    `block_id` BIGINT COMMENT 'Foreign key linking to exploration.block. Business justification: JIB statements bill partners for costs incurred on a specific block/license area. Direct block linkage enables block-level JIB cost reporting, partner billing reconciliation by block, and operating co',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: JIB statements include costs for recurring compliance obligations such as regulatory reporting, environmental monitoring, inspections, and permit renewals. Partners need to trace compliance costs to s',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: JIB statements often allocate costs under specific master contracts (drilling services, facility operations). COPAS audits require contract traceability for rate validation and overhead allocation. Cr',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this billing statement is issued.',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: JIB statements are issued by operator to non-operators under JOA terms. Operator reference critical for billing reconciliation, dispute resolution, and COPAS audit compliance in joint venture accounti',
    `partner_id` BIGINT COMMENT 'Reference to the operating partner issuing this Joint Interest Billing statement.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: JIB statements are issued for jointly-owned pipeline infrastructure operations. jib_statement has asset_facility_id and well_asset_id but no pipeline_segment_id. Pipeline-specific JIB statements for t',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: JIB statements can be issued under PSA arrangements as well as JOAs, particularly for cost recovery billing between contractor parties. jib_statement has joa_id but no psa_id. Adding psa_id (nullable)',
    `well_asset_id` BIGINT COMMENT 'Reference to the specific well asset to which the costs in this Joint Interest Billing statement are attributed, if applicable.',
    `approval_date` DATE COMMENT 'The date on which the Joint Interest Billing statement was approved by the operator or designated authority for issuance to non-operating partners.',
    `billing_period_end_date` DATE COMMENT 'The end date of the billing period covered by this Joint Interest Billing statement.',
    `billing_period_start_date` DATE COMMENT 'The start date of the billing period covered by this Joint Interest Billing statement.',
    `copas_billing_code` STRING COMMENT 'The standardized COPAS billing code that classifies the type of costs included in this Joint Interest Billing statement according to COPAS accounting standards.',
    `cost_category` STRING COMMENT 'The primary category of costs covered by this Joint Interest Billing statement, indicating the nature of the joint account expenditures. [ENUM-REF-CANDIDATE: drilling|completion|production|facility|workover|abandonment|general_administrative — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this Joint Interest Billing statement record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the Joint Interest Billing statement amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `dispute_amount` DECIMAL(18,2) COMMENT 'The total amount under dispute by non-operating partners, if any disputes have been raised against this Joint Interest Billing statement.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether any non-operating partner has raised a dispute regarding the costs or allocations in this Joint Interest Billing statement.',
    `dispute_reason` STRING COMMENT 'A description of the reason for any dispute raised by non-operating partners regarding this Joint Interest Billing statement.',
    `modified_by` STRING COMMENT 'The user or system identifier that last modified this Joint Interest Billing statement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this Joint Interest Billing statement record was last modified in the system.',
    `netting_eligible_flag` BOOLEAN COMMENT 'Indicates whether this Joint Interest Billing statement is eligible for partner netting, where offsetting receivables and payables between partners can be netted to reduce cash movements.',
    `payment_due_date` DATE COMMENT 'The date by which non-operating partners are required to remit payment for their proportionate share of the billed costs.',
    `payment_received_date` DATE COMMENT 'The date on which full payment was received from all non-operating partners for this Joint Interest Billing statement.',
    `payment_terms_days` STRING COMMENT 'The number of days from the statement date within which payment is due, as specified in the Joint Operating Agreement.',
    `remarks` STRING COMMENT 'Additional notes, comments, or explanations provided by the operator regarding this Joint Interest Billing statement, including special circumstances or clarifications.',
    `sap_jva_document_number` STRING COMMENT 'The document number in SAP Joint Venture Accounting system that corresponds to this Joint Interest Billing statement for integration and reconciliation purposes.',
    `statement_date` DATE COMMENT 'The date on which the Joint Interest Billing statement was issued by the operator to the non-operating partners.',
    `statement_number` STRING COMMENT 'Externally-known unique statement number assigned by the operator for tracking and reference purposes.',
    `statement_status` STRING COMMENT 'Current lifecycle status of the Joint Interest Billing statement in the billing and payment workflow.. Valid values are `draft|issued|disputed|approved|paid|cancelled`',
    `statement_type` STRING COMMENT 'Classification of the Joint Interest Billing statement indicating whether it is an original billing, a revision, a supplemental charge, a final statement, or an adjustment.. Valid values are `original|revised|supplemental|final|adjustment`',
    `total_joint_account_costs` DECIMAL(18,2) COMMENT 'The total costs incurred on the joint account during the billing period before allocation to individual partners based on their working interest.',
    `total_overhead_charges` DECIMAL(18,2) COMMENT 'The total overhead charges applied by the operator for administrative and management services as permitted under the Joint Operating Agreement.',
    `total_prior_period_adjustments` DECIMAL(18,2) COMMENT 'The net total of adjustments related to prior billing periods, including corrections, credits, and additional charges identified after the original billing.',
    `total_statement_amount` DECIMAL(18,2) COMMENT 'The total amount billed in this Joint Interest Billing statement, calculated as the sum of joint account costs, overhead charges, and prior period adjustments.',
    `created_by` STRING COMMENT 'The user or system identifier that created this Joint Interest Billing statement record.',
    CONSTRAINT pk_jib_statement PRIMARY KEY(`jib_statement_id`)
) COMMENT 'Joint Interest Billing (JIB) statement issued by the operator to non-operating partners for their proportionate share of joint account costs. Captures billing period, statement date, total joint costs, each partners WI allocation, prior period adjustments, overhead charges, and SAP JVA document reference. Conforms to COPAS billing standards. SSOT for partner cost billing in the venture domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`jib_line` (
    `jib_line_id` BIGINT COMMENT 'Primary key for jib_line',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: JIB line items must reference AFE budgets for cost recovery validation, budget variance tracking, and partner billing accuracy. Critical for COPAS-compliant joint venture accounting and audit trails.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility (production platform, processing plant, pipeline, storage terminal) to which this cost is allocated. Supports facility-level cost tracking and asset management.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Individual JIB line items must reference the governing contract for COPAS audit compliance. Auditors trace every charged item back to contract terms to validate rates, overhead allocation, and cost re',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual JIB line items are allocated to cost centers for internal management reporting and overhead allocation. Improves query performance for cost center variance analysis vs going through journal',
    `jib_statement_id` BIGINT COMMENT 'Reference to the parent JIB statement that contains this line item. Links the line to the header-level billing document issued to joint venture partners.',
    `journal_entry_line_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry_line. Business justification: Individual JIB line items map to journal entry lines for detailed GL account posting, cost center allocation, and audit trail from JV billing to financial statements. Required for COPAS billing reconc',
    `lease_id` BIGINT COMMENT 'Reference to the lease or concession area to which this cost is allocated. Enables lease-level profitability analysis and regulatory reporting.',
    `partner_id` BIGINT COMMENT 'Reference to the specific joint venture partner being billed for this line item. Each JIB statement may have multiple line items for different partners based on their working interest.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: JIB line items for product-related costs (storage, handling, quality testing, blending) require product linkage. Business process: Product-specific cost allocation in JIBs, partner billing for product',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: JIB lines itemize costs for jointly-owned pipeline operations (inspection, pigging, cathodic protection). jib_line has asset_facility_id and well_asset_id but no pipeline_segment_id. Pipeline-specific',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Individual JIB line items trace to specific purchase orders for three-way match (PO-GR-Invoice) validation before costs can be billed to joint account. Required for COPAS compliance and partner audit ',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or service provider who performed the work or supplied the goods. Enables tracking of vendor performance and cost analysis by supplier.',
    `venture_afe_id` BIGINT COMMENT 'Foreign key linking to venture.venture_afe. Business justification: Individual JIB line items represent specific cost categories charged to partners, often authorized by a specific AFE. jib_line has afe_budget_id (cross-domain procurement) but no FK to venture.venture',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: JIB line items are charged to WBS elements for project cost tracking and AFE budget monitoring. Standard project accounting requirement for capital vs operating cost classification.',
    `well_asset_id` BIGINT COMMENT 'Reference to the specific well to which this cost is allocated. Enables well-level cost tracking and economic analysis for drilling and production operations.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of any adjustment made to the original charge due to dispute resolution, correction, or revision. Positive values represent additional charges; negative values represent credits.',
    `adjustment_reason` STRING COMMENT 'Explanation for any adjustment made to the line item. Provides audit trail for billing corrections and dispute resolutions.',
    `approval_date` DATE COMMENT 'Date this charge was approved for billing to partners. Used for audit trail and compliance with internal control procedures.',
    `approval_status` STRING COMMENT 'Internal approval status of this charge before billing to partners. Values include pending approval (PENDING), approved for billing (APPROVED), rejected (REJECTED), or requires additional review (REQUIRES_REVIEW).. Valid values are `PENDING|APPROVED|REJECTED|REQUIRES_REVIEW`',
    `cost_category_code` STRING COMMENT 'Classification of the cost type according to COPAS standards. Categories include drilling (DRILL), completion (COMPL), production (PROD), facilities (FACIL), geological and geophysical (GEOL), land and lease (LAND), overhead (OVHD), general and administrative (GA), plug and abandonment (PLUG), workover (WORKOV), seismic (SEISMIC), and other (OTHER). [ENUM-REF-CANDIDATE: DRILL|COMPL|PROD|FACIL|GEOL|LAND|OVHD|GA|PLUG|WORKOV|SEISMIC|OTHER — 12 candidates stripped; promote to reference product]',
    `cost_description` STRING COMMENT 'Detailed narrative description of the specific cost or service being charged. Provides transparency to joint venture partners regarding the nature of the expenditure.',
    `cost_recovery_limit_percentage` DECIMAL(18,2) COMMENT 'Maximum percentage of production revenue that can be used for cost recovery in a given period under PSA terms. Expressed as a decimal (e.g., 0.5000 for 50% cost recovery limit).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this JIB line record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction. Supports multi-currency joint ventures and enables proper foreign exchange accounting. [ENUM-REF-CANDIDATE: USD|CAD|GBP|EUR|NOK|BRL|MXN|AUD — 8 candidates stripped; promote to reference product]',
    `dispute_date` DATE COMMENT 'Date the partner formally disputed this charge. Used to track dispute aging and ensure timely resolution per JOA terms.',
    `dispute_reason` STRING COMMENT 'Partners stated reason for disputing this charge. Provides context for dispute resolution and helps identify systemic billing issues.',
    `dispute_status` STRING COMMENT 'Current status of any partner dispute regarding this line item. Values include undisputed (UNDISPUTED), disputed by partner (DISPUTED), under operator review (UNDER_REVIEW), dispute resolved (RESOLVED), or amount adjusted (ADJUSTED).. Valid values are `UNDISPUTED|DISPUTED|UNDER_REVIEW|RESOLVED|ADJUSTED`',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this cost is posted in the operators financial system. Enables integration with enterprise accounting and financial reporting.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total cost amount before allocation to partners. Represents 100% of the cost incurred by the operator on behalf of the joint venture.',
    `invoice_date` DATE COMMENT 'Date the vendor invoice was issued. Used for aging analysis and payment term calculations in joint venture accounting.',
    `invoice_number` STRING COMMENT 'The vendors invoice number for this charge. Provides traceability to source documentation for audit and dispute resolution purposes.',
    `is_capital_expenditure` BOOLEAN COMMENT 'Boolean flag indicating whether this cost is classified as capital expenditure (CAPEX) or operating expenditure (OPEX). Critical for financial reporting, tax treatment, and reserve calculations.',
    `is_recoverable` BOOLEAN COMMENT 'Boolean flag indicating whether this cost is recoverable under a Production Sharing Agreement (PSA) or similar fiscal regime. Determines whether the cost can be recovered from production revenue before profit sharing.',
    `is_tangible` BOOLEAN COMMENT 'Boolean flag indicating whether this is a tangible cost (equipment, materials) or intangible cost (drilling, geological services). Affects depreciation treatment and tax deductibility under full cost or successful efforts accounting.',
    `line_number` STRING COMMENT 'Sequential line number within the JIB statement for ordering and reference purposes. Enables partners to reference specific charges in dispute resolution.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this JIB line record was last modified. Enables change tracking and audit compliance.',
    `overhead_amount` DECIMAL(18,2) COMMENT 'Dollar amount of overhead charged on this line item, calculated by applying the overhead rate to the base cost. Represents operator compensation for administrative and indirect costs.',
    `overhead_rate_percentage` DECIMAL(18,2) COMMENT 'COPAS-approved overhead rate applied to this cost category. Expressed as a decimal (e.g., 0.0500 for 5%). Compensates the operator for indirect costs of managing joint venture operations.',
    `partner_net_amount` DECIMAL(18,2) COMMENT 'The partners share of the cost calculated by applying their working interest percentage to the gross amount. This is the amount the partner owes for this line item.',
    `payment_due_date` DATE COMMENT 'Date by which the partner must pay this charge per JOA payment terms. Used for aging analysis and late payment interest calculations.',
    `payment_received_date` DATE COMMENT 'Date the operator received payment from the partner for this line item. Used for cash flow tracking and reconciliation.',
    `payment_status` STRING COMMENT 'Current payment status of this line item from the partner. Values include unpaid (UNPAID), partially paid (PARTIALLY_PAID), fully paid (PAID), overdue (OVERDUE), or written off as uncollectible (WRITTEN_OFF).. Valid values are `UNPAID|PARTIALLY_PAID|PAID|OVERDUE|WRITTEN_OFF`',
    `service_period_end_date` DATE COMMENT 'Ending date of the period during which the service was performed or goods were delivered. Used for matching costs to production periods and reserve calculations.',
    `service_period_start_date` DATE COMMENT 'Beginning date of the period during which the service was performed or goods were delivered. Enables period-based cost allocation and accrual accounting.',
    `wbs_element` STRING COMMENT 'Project work breakdown structure element for capital project tracking. Links JIB costs to specific phases or deliverables within major capital projects.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The partners working interest percentage used to calculate their share of this cost. Expressed as a decimal (e.g., 0.2500 for 25%). Reflects the partners obligation to bear costs under the JOA.',
    CONSTRAINT pk_jib_line PRIMARY KEY(`jib_line_id`)
) COMMENT 'Individual cost line item within a JIB statement, representing a specific cost category charged to the joint account. Captures cost category (drilling, completion, production, overhead, G&A), AFE reference, cost description, gross amount, partner WI percentage, partner net amount, and COPAS overhead rate applied. Enables granular cost transparency and partner dispute resolution at the line-item level.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`cash_call` (
    `cash_call_id` BIGINT COMMENT 'Unique identifier for the cash call notice issued by the operator to non-operating partners.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Cash calls are issued against AFE budgets to fund joint operations. Links enable partners to verify calls against approved budgets, track committed vs. called amounts, and manage working capital.',
    `block_id` BIGINT COMMENT 'Foreign key linking to exploration.block. Business justification: Cash calls are issued for specific work programs on exploration blocks. Direct block linkage enables block-level cash call tracking, partner funding obligation monitoring per block, and operating comm',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Cash calls fund specific compliance obligations including environmental bonds, regulatory fees, abandonment provisions, and monitoring costs. Partners need to see which regulatory obligation drives ea',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Cash calls for major capital programs (drilling campaigns, EPC projects) reference the governing master contract. Partners require contract reference for scope validation and approval. Essential for c',
    `joa_id` BIGINT COMMENT 'Reference to the joint operating agreement under which this cash call is issued.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Cash calls generate journal entries when posted to the general ledger for partner receivables and joint account clearing. Core integration between joint interest billing and financial accounting syste',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Cash calls fund operations on specific leases. Lease context is required for partner billing based on working interest, tracking lease-level capital commitments, and reconciling AFE spend to lease.',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: Cash calls are issued by operator under JOA authority. Operator reference required for payment routing, default interest calculation, and forfeiture provision enforcement in joint venture operations.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Cash calls can be issued under PSA contracts to fund exploration and development work programs. cash_call has joa_id but no psa_id. Adding psa_id (nullable) allows cash calls to be associated with PSA',
    `venture_afe_id` BIGINT COMMENT 'Foreign key linking to venture.venture_afe. Business justification: Cash calls are frequently issued to fund expenditures authorized by a specific AFE. cash_call already has afe_budget_id (cross-domain procurement) and drilling_afe_id (cross-domain drilling) but no FK',
    `partner_id` BIGINT COMMENT 'Reference to the operating partner issuing the cash call.',
    `approved_by` STRING COMMENT 'Username or identifier of the operator manager who approved the cash call for issuance to non-operating partners.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the cash call was approved for issuance by the operator manager.',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period for which the cash call covers anticipated joint account expenditures.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period for which the cash call covers anticipated joint account expenditures.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the cash call was cancelled, such as AFE revision, project delay, or partner dispute.',
    `cancelled_by` STRING COMMENT 'Username or identifier of the operator personnel who cancelled the cash call, if applicable.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the cash call was cancelled by the operator, if applicable.',
    `cash_call_number` STRING COMMENT 'Unique business identifier for the cash call notice, typically assigned by the operators joint venture accounting system.',
    `cash_call_status` STRING COMMENT 'Current lifecycle status of the cash call: draft (prepared but not issued), issued (sent to partners), partially_paid (some partners paid), fully_paid (all partners paid), overdue (past due date with unpaid balances), cancelled (withdrawn by operator).. Valid values are `draft|issued|partially_paid|fully_paid|overdue|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cash call record was first created in the joint venture accounting system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cash call amount (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `default_interest_accrued` DECIMAL(18,2) COMMENT 'Total default interest accrued on late payments from non-operating partners who missed the due date.',
    `default_interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate (expressed as a decimal, e.g., 0.1200 for 12%) applied to late payments per JOA default provisions.',
    `due_date` DATE COMMENT 'Date by which non-operating partners must remit their share of the cash call to avoid default interest charges under JOA provisions.',
    `expenditure_category` STRING COMMENT 'Primary category of joint account expenditures covered by this cash call: drilling (new well drilling), completion (well completion activities), facilities (surface facilities construction), operating (routine lease operating expenses), workover (well intervention), abandonment (plug and abandonment), other (miscellaneous). [ENUM-REF-CANDIDATE: drilling|completion|facilities|operating|workover|abandonment|other — 7 candidates stripped; promote to reference product]',
    `expenditure_description` STRING COMMENT 'Detailed narrative description of the planned expenditures and activities covered by this cash call.',
    `issue_date` DATE COMMENT 'Date on which the operator issued the cash call notice to non-operating partners.',
    `modified_by` STRING COMMENT 'Username or identifier of the operator personnel who last modified the cash call record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the cash call record was last modified in the joint venture accounting system.',
    `notes` STRING COMMENT 'Free-form notes and comments regarding the cash call, including special instructions, partner communications, or reconciliation adjustments.',
    `operator_bank_account_number` STRING COMMENT 'Bank account number to which non-operating partners should remit their cash call payments.',
    `operator_bank_name` STRING COMMENT 'Name of the financial institution where non-operating partners should remit cash call payments.',
    `operator_bank_routing_number` STRING COMMENT 'Bank routing number (ABA or SWIFT/BIC code) for wire transfers or ACH payments.',
    `payment_instructions` STRING COMMENT 'Detailed instructions for non-operating partners on how to remit payment, including reference numbers, wire instructions, and contact information.',
    `reconciliation_date` DATE COMMENT 'Date on which the cash call was fully reconciled and all payment discrepancies resolved.',
    `reconciliation_status` STRING COMMENT 'Status of reconciliation between called amounts and received payments: pending (awaiting payment), reconciled (all payments match called amounts), discrepancy (underpayments or overpayments identified), adjusted (discrepancies resolved through adjustments).. Valid values are `pending|reconciled|discrepancy|adjusted`',
    `total_amount_outstanding` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the cash call, calculated as total_call_amount minus total_amount_received.',
    `total_amount_received` DECIMAL(18,2) COMMENT 'Cumulative total of all payments received from non-operating partners against this cash call.',
    `total_call_amount` DECIMAL(18,2) COMMENT 'Total amount of advance funding requested from all non-operating partners for upcoming joint account expenditures.',
    CONSTRAINT pk_cash_call PRIMARY KEY(`cash_call_id`)
) COMMENT 'Cash call notice issued by the operator to non-operating partners requesting advance funding for upcoming joint account expenditures under a JOA. Captures cash call number, billing period, total call amount, per-partner WI-based allocation, due date, operator bank account details, currency, payment instructions, and individual partner payment status. After merging cash_call_payment: also tracks each partners actual payment response including payment date, amount received, payment method, bank reference, exchange rate, and reconciliation status against the called amount. Enables identification of underpayments, overpayments, and late payments triggering default interest under JOA provisions. Managed within SAP Joint Venture Accounting.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` (
    `cash_call_payment_id` BIGINT COMMENT 'Unique identifier for each partner payment response to a cash call. Primary key for the cash call payment record.',
    `cash_call_id` BIGINT COMMENT 'Reference to the parent cash call that triggered this payment. Links to the original cash call request issued by the operator.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Cash call payments generate GL postings when received from partners for cash receipt accounting and partner account reconciliation. Standard accounts receivable process for joint interest billing.',
    `partner_id` BIGINT COMMENT 'Reference to the joint venture partner making this payment. Identifies which partner in the joint operating agreement is responding to the cash call.',
    `bank_reference` STRING COMMENT 'The bank transaction reference, wire transfer number, or check number associated with this payment. Used for bank reconciliation and audit trail.',
    `called_amount` DECIMAL(18,2) COMMENT 'The original amount requested from this partner in the cash call, in the cash call currency. Used to calculate payment variance and reconciliation status.',
    `called_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the cash call amount was originally denominated. Used for variance calculation when payment currency differs.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cash call payment record was first created in the system. Used for audit trail and data lineage tracking.',
    `days_late` STRING COMMENT 'The number of calendar days between the cash call due date and the payment date. Used to calculate default interest charges. Null or zero if payment was on time.',
    `default_interest_amount` DECIMAL(18,2) COMMENT 'The interest charge assessed on late or underpaid amounts per the Joint Operating Agreement (JOA) default interest rate. Calculated based on days late and variance amount.',
    `default_interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate applied to late or underpaid amounts, as specified in the Joint Operating Agreement (JOA). Expressed as a decimal (e.g., 0.0850 for 8.5 percent).',
    `dispute_reason` STRING COMMENT 'The reason provided by the partner for disputing the cash call or paying a different amount. Used to track and resolve billing disputes per JOA dispute resolution procedures.',
    `dispute_resolution_date` DATE COMMENT 'The date on which a payment dispute was resolved between the operator and partner. Null if no dispute exists or dispute is still open.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert payment amount to called currency for reconciliation. Rate is payment_currency per unit of called_currency. Null if currencies match.',
    `gl_document_number` STRING COMMENT 'The general ledger document or journal entry number associated with this payment posting. Links cash call payment to financial accounting records.',
    `gl_posting_date` DATE COMMENT 'The date on which this payment was posted to the operators general ledger. Used for financial period assignment and accounting close processes.',
    `late_payment_flag` BOOLEAN COMMENT 'Indicates whether the payment was received after the due date specified in the cash call. True triggers default interest calculation per JOA terms.',
    `modified_by` STRING COMMENT 'The user identifier or name of the person who last modified this payment record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cash call payment record was last modified. Used for audit trail and change tracking.',
    `netting_amount` DECIMAL(18,2) COMMENT 'The amount offset through partner netting arrangements. Reduces the cash payment required from the partner. Null if no netting was applied.',
    `netting_applied_flag` BOOLEAN COMMENT 'Indicates whether partner netting was applied to offset this payment against amounts owed by the operator to the partner. True when payment is reduced by bilateral netting.',
    `paying_bank_name` STRING COMMENT 'The name of the financial institution from which the payment originated. Used for reconciliation and partner payment pattern analysis.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The actual monetary amount received from the partner in the payment currency. May differ from the called amount due to underpayment, overpayment, or currency fluctuations.',
    `payment_amount_base_currency` DECIMAL(18,2) COMMENT 'The payment amount converted to the operators base reporting currency using the exchange rate. Used for consolidated financial reporting and variance analysis.',
    `payment_confirmation_sent_date` DATE COMMENT 'The date on which the operator sent payment confirmation or receipt acknowledgment to the partner. Used for partner communication tracking.',
    `payment_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the payment was received. May differ from the cash call currency if partner pays in alternate currency.. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The date on which the partner payment was received by the operator. Used to calculate late payment interest per Joint Operating Agreement (JOA) terms.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used by the partner to remit payment. Offset indicates payment via partner netting or cost recovery allocation.. Valid values are `wire_transfer|ach|check|electronic_funds_transfer|letter_of_credit|offset`',
    `payment_notes` STRING COMMENT 'Free-text notes or comments regarding this payment. May include partner explanations for variances, dispute details, or special payment arrangements.',
    `payment_reference_number` STRING COMMENT 'External payment reference number or transaction identifier provided by the paying partner or their bank. Used for reconciliation and audit trail.',
    `receiving_bank_account` STRING COMMENT 'The operators bank account number into which this payment was deposited. Used to reconcile bank statements with cash call collections.',
    `reconciled_by` STRING COMMENT 'The name or identifier of the joint venture accountant who performed the reconciliation. Used for audit trail and accountability.',
    `reconciliation_date` DATE COMMENT 'The date on which the payment was reconciled against the cash call and variance was resolved or accepted. Null if reconciliation is still pending.',
    `reconciliation_status` STRING COMMENT 'Current status of the payment reconciliation against the called amount. Underpaid and overpaid statuses trigger follow-up actions per JOA terms. Disputed indicates partner has challenged the cash call.. Valid values are `pending|reconciled|variance_under_review|underpaid|overpaid|disputed`',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between called amount and payment amount in base currency. Positive indicates overpayment, negative indicates underpayment. Triggers default interest calculation if negative.',
    `created_by` STRING COMMENT 'The user identifier or name of the person who created this payment record. Used for audit trail and accountability.',
    CONSTRAINT pk_cash_call_payment PRIMARY KEY(`cash_call_payment_id`)
) COMMENT 'Records each partners actual payment response to a cash call, capturing payment date, amount received, payment method, bank reference, currency, exchange rate applied, and reconciliation status against the called amount. Enables operator to identify underpayments, overpayments, and late payments triggering default interest under the JOA. Links to partner netting records.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`cost_recovery` (
    `cost_recovery_id` BIGINT COMMENT 'Unique identifier for the cost recovery record. Primary key for the cost recovery tracking entity.',
    `actual_cost_id` BIGINT COMMENT 'Foreign key linking to finance.actual_cost. Business justification: PSA cost recovery calculations consume actual cost data from finance for cost oil calculation, unrecovered cost balance tracking, and contractor/government entitlement determination. Required for PSA ',
    `block_id` BIGINT COMMENT 'Foreign key linking to exploration.block. Business justification: PSA cost recovery is tracked by ring-fenced cost recovery area, which maps directly to an exploration block. Direct block linkage enables block-level cost recovery balance reporting, government audit ',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Cost recovery under PSAs includes allowable compliance costs per regulatory obligations. Government auditors verify that recovered costs correspond to legitimate regulatory obligations. Essential for ',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Under PSAs, cost recovery claims must reference the contracts under which costs were incurred. Government audits require contract documentation proving costs are recoverable per PSA terms. Mandatory f',
    `jib_statement_id` BIGINT COMMENT 'Foreign key linking to venture.jib_statement. Business justification: cost_recovery currently stores jib_reference_number as a denormalized STRING field. Replacing this with a proper FK to venture.jib_statement normalizes the relationship and allows JOIN-based retrieval',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: PSA cost recovery tracks recoverable costs by lease/concession. Lease_id enables ring-fencing compliance, cost pool allocation, and audit trail linking recovered costs to specific lease expenditures.',
    `monthly_production_id` BIGINT COMMENT 'Foreign key linking to production.monthly_production. Business justification: Cost recovery calculations under PSA are tied to specific production periods; linking cost_recovery to monthly_production enables traceability of which production periods volumes and revenues drove t',
    `partner_id` BIGINT COMMENT 'Foreign key linking to venture.partner. Business justification: cost_recovery tracks cumulative and periodic cost recovery positions under PSA contracts. The contractor entity recovering costs is a partner in the venture domain. cost_recovery has psa_id and lease_',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: PSA cost recovery is tracked by petroleum product category (oil vs gas) with different recovery limits. Business process: Product-level cost recovery ceiling application, government audits by product ',
    `psa_id` BIGINT COMMENT 'Foreign key reference to the production sharing agreement under which cost recovery is tracked.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: PSA cost-recovery tracking is ring-fenced by reservoir or field; costs incurred must be attributed to the specific reservoir to apply the correct cost-recovery ceiling and unrecovered-cost balance. Do',
    `vendor_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_invoice. Business justification: Cost recovery under PSAs requires detailed invoice-level documentation. NOC auditors review vendor invoices to validate cost recovery claims, prevent gold-plating, and ensure compliance with PSA cost ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Cost recovery tracking under PSAs references WBS elements for project-phase cost pools (exploration, development, production). Enables cost recovery calculation by project phase for contractor entitle',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: PSA cost recovery is tracked at the well level for government audit purposes. cost_recovery has psa_id and lease_id but no well_asset_id. Well-level cost recovery balances and unrecovered cost trackin',
    `accounting_period` STRING COMMENT 'The fiscal period (YYYY-MM format) for which this cost recovery position is reported. Aligns with monthly joint interest billing cycles.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `afe_number` STRING COMMENT 'The AFE number authorizing the costs incurred in this period. Links cost recovery to approved capital and operating budgets.',
    `audit_date` DATE COMMENT 'The date when this cost recovery record was last audited or reviewed by the government or joint venture partners.',
    `audit_status` STRING COMMENT 'The current audit or approval status of this cost recovery record. Tracks lifecycle from draft submission through government audit and final approval.. Valid values are `draft|submitted|under_review|approved|disputed|adjusted`',
    `ceiling_limit` DECIMAL(18,2) COMMENT 'The maximum amount of cost oil/gas that can be allocated to cost recovery in the period, expressed as a percentage of total production value per PSA terms.',
    `ceiling_percentage` DECIMAL(18,2) COMMENT 'The percentage of total production value allocated to cost recovery per PSA contract terms (e.g., 50%, 60%, 70%). Varies by contract and field maturity.',
    `ceiling_utilized` DECIMAL(18,2) COMMENT 'The actual amount of cost recovery ceiling utilized in the period. May be less than the limit if unrecovered costs are lower than the ceiling.',
    `contractor_share_percentage` DECIMAL(18,2) COMMENT 'The contractors participating interest percentage in the PSA. Used to calculate contractor entitlement to cost recovery.',
    `cost_category` STRING COMMENT 'Classification of the recoverable cost type under the PSA. Determines recovery priority and ceiling rules per contract terms.. Valid values are `exploration|development|operating|abandonment|general_administrative`',
    `cost_subcategory` STRING COMMENT 'Detailed subcategory within the cost category for granular tracking (e.g., seismic acquisition, drilling, facilities, workover, LOE).',
    `costs_incurred_period` DECIMAL(18,2) COMMENT 'Total costs incurred during the current accounting period for this cost category under the PSA. Represents new recoverable costs added to the pool.',
    `costs_recovered_period` DECIMAL(18,2) COMMENT 'Total costs recovered during the current accounting period from cost oil/gas allocation per PSA terms. Reduces the unrecovered cost balance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this cost recovery record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which cost recovery amounts are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `depreciation_amount_period` DECIMAL(18,2) COMMENT 'The depreciation expense allocated to cost recovery in the current period for capital assets under the PSA.',
    `depreciation_method` STRING COMMENT 'The depreciation method applied to capital costs for cost recovery purposes under the PSA. May differ from book depreciation.. Valid values are `straight_line|unit_of_production|declining_balance|none`',
    `dispute_amount` DECIMAL(18,2) COMMENT 'The monetary amount under dispute if the dispute flag is true. Represents costs challenged by government or partners.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this cost recovery record is under dispute by the government or joint venture partners. True if disputed, false otherwise.',
    `dispute_reason` STRING COMMENT 'The reason or description of the dispute if the dispute flag is true. Documents the basis for cost recovery challenge.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert local currency costs to the PSA reporting currency for the accounting period.',
    `government_share_percentage` DECIMAL(18,2) COMMENT 'The host government or national oil company participating interest percentage in the PSA. Used to calculate government entitlement to profit oil/gas after cost recovery.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this cost recovery record was last updated. Audit trail for record changes.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this cost recovery record. Used to document special circumstances, adjustments, or clarifications.',
    `period_end_date` DATE COMMENT 'The last day of the accounting period covered by this cost recovery record.',
    `period_start_date` DATE COMMENT 'The first day of the accounting period covered by this cost recovery record.',
    `priority` STRING COMMENT 'The priority order for recovering this cost category when multiple categories compete for limited cost oil/gas (1=highest priority). Typically operating costs recover before development costs.',
    `production_tier` STRING COMMENT 'The production volume tier or R-factor tier that determines the profit oil/gas split percentage in the current period per PSA sliding scale terms.',
    `profit_oil_split_contractor` DECIMAL(18,2) COMMENT 'The contractors share of profit oil/gas after cost recovery, expressed as a percentage. May vary by production tier or R-factor per PSA terms.',
    `profit_oil_split_government` DECIMAL(18,2) COMMENT 'The governments share of profit oil/gas after cost recovery, expressed as a percentage. May vary by production tier or R-factor per PSA terms.',
    `r_factor` DECIMAL(18,2) COMMENT 'The cumulative revenue-to-cost ratio used to determine profit oil/gas split tiers in some PSAs. Calculated as cumulative revenue divided by cumulative costs.',
    `ring_fencing_entity` STRING COMMENT 'The specific field, block, or contract identifier to which this cost recovery record is ring-fenced per PSA terms.',
    `ring_fencing_rule` STRING COMMENT 'The ring-fencing methodology applied to cost recovery under the PSA. Determines whether costs can be pooled across fields, blocks, or contracts.. Valid values are `field_level|block_level|contract_level|consolidated`',
    `sec_disclosure_flag` BOOLEAN COMMENT 'Indicates whether this cost recovery record is included in SEC reserves disclosure and financial reporting. True if disclosed, false otherwise.',
    `unrecovered_cost_balance_closing` DECIMAL(18,2) COMMENT 'The cumulative unrecovered cost balance at the end of the accounting period. Calculated as opening balance plus costs incurred minus costs recovered.',
    `unrecovered_cost_balance_opening` DECIMAL(18,2) COMMENT 'The cumulative unrecovered cost balance at the beginning of the accounting period. Carried forward from prior period closing balance.',
    `uplift_amount_period` DECIMAL(18,2) COMMENT 'The uplift or interest amount accrued on unrecovered costs during the current period. Added to costs incurred for recovery calculation.',
    `uplift_rate` DECIMAL(18,2) COMMENT 'The annual uplift or interest rate applied to unrecovered costs per PSA terms, expressed as a percentage. Compensates contractor for delayed cost recovery.',
    CONSTRAINT pk_cost_recovery PRIMARY KEY(`cost_recovery_id`)
) COMMENT 'Tracks cumulative and periodic cost recovery positions under PSA contracts, capturing recoverable cost categories (exploration, development, operating), costs incurred, costs recovered in period, unrecovered cost balance, cost recovery ceiling utilization, and ring-fencing rules. Supports profit oil/gas split calculation and SEC cost recovery disclosure. One record per PSA per cost category per period.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` (
    `profit_oil_split_id` BIGINT COMMENT 'Unique identifier for the profit oil split calculation record. Primary key for the profit oil split entity.',
    `cost_recovery_id` BIGINT COMMENT 'Foreign key linking to venture.cost_recovery. Business justification: Under PSA contracts, profit oil split calculations are directly dependent on cost recovery positions — profit oil is only available after cost oil (cost recovery) is allocated. profit_oil_split alread',
    `monthly_production_id` BIGINT COMMENT 'Foreign key linking to production.monthly_production. Business justification: Profit oil split calculations are driven by monthly production volumes under PSA; linking profit_oil_split to monthly_production provides the source production record for the calculation, enabling gov',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Profit oil calculations are performed separately by petroleum product type (oil vs gas) with different split terms. Business process: PSA profit oil allocation by product, government entitlement by pr',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Profit oil splits under PSA are calculated at the facility/field level where production is measured; linking profit_oil_split to production_facility enables facility-level profit-oil reporting and gov',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit oil entitlements are tracked by profit center for contractor revenue recognition, segment reporting, and profitability analysis. Critical for PSA revenue booking and SEC reserve disclosure.',
    `psa_id` BIGINT COMMENT 'Reference to the production sharing agreement under which this profit oil split is calculated.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Profit-oil split calculations are based on production volumes from a specific reservoir under a PSA; ring-fencing rules in PSAs are typically applied at reservoir or field level. Domain experts expect',
    `partner_id` BIGINT COMMENT 'Reference to the operating company responsible for calculating and reporting this profit oil split under the joint operating agreement (JOA).',
    `well_asset_id` BIGINT COMMENT 'Foreign key linking to asset.well_asset. Business justification: Profit oil splits under PSA regimes are calculated per well or field. profit_oil_split has psa_id and partner_id but no well_asset_id. Well-level profit oil entitlement reporting is a regulatory requi',
    `approval_date` DATE COMMENT 'The date on which this profit oil split calculation was approved by all parties to the PSA.',
    `calculation_date` DATE COMMENT 'The date on which this profit oil split calculation was performed.',
    `calculation_method` STRING COMMENT 'The methodology used to determine profit split percentages for this period, as defined in the PSA terms.. Valid values are `r_factor|production_tier|hybrid|fixed_split`',
    `calculation_period_end_date` DATE COMMENT 'The end date of the production period for which this profit oil split is calculated.',
    `calculation_period_start_date` DATE COMMENT 'The start date of the production period for which this profit oil split is calculated.',
    `calculation_status` STRING COMMENT 'Current status of the profit oil split calculation in the approval and settlement workflow.. Valid values are `draft|preliminary|final|revised|approved|disputed`',
    `contractor_entitlement_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Total gas volume entitled to the contractor group, including cost gas and contractor share of profit gas, expressed in thousand cubic feet.',
    `contractor_entitlement_oil_volume_bbl` DECIMAL(18,2) COMMENT 'Total oil volume entitled to the contractor group, including cost oil and contractor share of profit oil, expressed in barrels.',
    `contractor_profit_gas_share_percent` DECIMAL(18,2) COMMENT 'The percentage of profit gas allocated to the contractor group for this calculation period.',
    `contractor_profit_oil_share_percent` DECIMAL(18,2) COMMENT 'The percentage of profit oil allocated to the contractor group for this calculation period.',
    `cost_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Volume of gas allocated to cost recovery for the contractor group under the PSA terms, expressed in thousand cubic feet.',
    `cost_oil_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of oil allocated to cost recovery for the contractor group under the PSA terms, expressed in barrels.',
    `cost_recovery_limit_percent` DECIMAL(18,2) COMMENT 'The maximum percentage of total production that can be allocated to cost recovery in this period, as defined by the PSA terms.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this profit oil split record was first created in the system.',
    `cumulative_cost_recovery_amount_usd` DECIMAL(18,2) COMMENT 'Cumulative costs recovered by the contractor group through cost oil and cost gas allocations as of this calculation period, expressed in USD.',
    `cumulative_revenue_amount_usd` DECIMAL(18,2) COMMENT 'Cumulative gross revenue from production as of this calculation period, used in R-factor calculation, expressed in USD.',
    `fiscal_regime_type` STRING COMMENT 'The type of fiscal regime governing this profit split calculation, determining the fundamental structure of revenue and cost allocation.. Valid values are `production_sharing|service_contract|concession|risk_service`',
    `government_entitlement_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Total gas volume entitled to the host government or NOC, representing government share of profit gas, expressed in thousand cubic feet.',
    `government_entitlement_oil_volume_bbl` DECIMAL(18,2) COMMENT 'Total oil volume entitled to the host government or NOC, representing government share of profit oil, expressed in barrels.',
    `government_profit_gas_share_percent` DECIMAL(18,2) COMMENT 'The percentage of profit gas allocated to the host government or national oil company (NOC) for this calculation period.',
    `government_profit_oil_share_percent` DECIMAL(18,2) COMMENT 'The percentage of profit oil allocated to the host government or national oil company (NOC) for this calculation period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this profit oil split record was last updated or modified.',
    `production_tier` STRING COMMENT 'The production tier or bracket applied for this calculation period under tiered PSA terms, determining the applicable split percentages.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|tier_6`',
    `profit_gas_volume_mcf` DECIMAL(18,2) COMMENT 'Volume of gas remaining after cost gas deduction, to be split between contractor and government, expressed in thousand cubic feet.',
    `profit_oil_volume_bbl` DECIMAL(18,2) COMMENT 'Volume of oil remaining after cost oil deduction, to be split between contractor and government, expressed in barrels.',
    `r_factor` DECIMAL(18,2) COMMENT 'The ratio of cumulative revenue to cumulative costs used to determine the profit split tier under sliding-scale PSA terms. Higher R-factors typically result in more favorable government share.',
    `remarks` STRING COMMENT 'Additional notes, comments, or explanations regarding this profit oil split calculation, including any adjustments or special circumstances.',
    `settlement_date` DATE COMMENT 'The date on which the entitlements from this profit oil split were settled and distributed to the respective parties.',
    `total_gas_production_volume_mcf` DECIMAL(18,2) COMMENT 'Total natural gas production volume for the period in thousand cubic feet.',
    `total_oil_production_volume_bbl` DECIMAL(18,2) COMMENT 'Total crude oil production volume for the period in barrels.',
    `total_production_volume_boe` DECIMAL(18,2) COMMENT 'Total production volume for the period expressed in barrels of oil equivalent, combining oil and gas production.',
    `unrecovered_cost_balance_usd` DECIMAL(18,2) COMMENT 'Remaining unrecovered costs carried forward to future periods under the PSA cost recovery mechanism, expressed in USD.',
    CONSTRAINT pk_profit_oil_split PRIMARY KEY(`profit_oil_split_id`)
) COMMENT 'Records the periodic calculation and allocation of profit oil and profit gas between the contractor group and the host government/NOC under a PSA. Captures production period, total production volume (BOE), cost oil/gas deducted, profit oil/gas volume, R-factor or production tier applied, contractor share percentage, government share percentage, and entitlement volumes per partner. SSOT for PSA profit entitlement.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` (
    `lifting_entitlement_id` BIGINT COMMENT 'Unique identifier for the lifting entitlement record. Primary key for the lifting entitlement entity.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Lifting operations require valid export permits, transportation permits, and quality certifications. Each cargo lifting must reference the authorizing permit. Essential for regulatory compliance verif',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this lifting entitlement is governed.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Lifting entitlements are calculated from production on specific leases. Lease_id ties entitlement volumes to source property, enabling accurate partner allocation and royalty burden deduction.',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: Operator manages lifting schedules and entitlement calculations under JOA/PSA terms. Operator reference required for cargo allocation, imbalance tracking, and settlement instruction generation in prod',
    `partner_id` BIGINT COMMENT 'Reference to the joint venture partner who holds this lifting entitlement.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Partner lifting entitlements are for specific petroleum products (crude, condensate, LNG). Business process: Partner crude/product lifting schedules, entitlement balancing by product type, imbalance t',
    `production_facility_id` BIGINT COMMENT 'Foreign key linking to production.production_facility. Business justification: Lifting entitlements are tied to specific production facilities where entitled volumes are produced and measured; the production_facility link identifies the source facility for entitlement calculatio',
    `psa_id` BIGINT COMMENT 'Reference to the Production Sharing Agreement under which this lifting entitlement is governed. Nullable if governed by JOA instead.',
    `venture_working_interest_id` BIGINT COMMENT 'Foreign key linking to venture.venture_working_interest. Business justification: Lifting entitlements are derived from a partners working interest position. lifting_entitlement has joa_id, psa_id, and partner_id but no FK to the specific venture_working_interest register entry th',
    `actual_lifted_volume_bbl` DECIMAL(18,2) COMMENT 'The actual volume of crude oil or liquids physically lifted by the partner, expressed in barrels. Null for gas-only liftings.',
    `actual_lifted_volume_boe` DECIMAL(18,2) COMMENT 'The actual volume physically lifted by the partner during this transaction, expressed in Barrels of Oil Equivalent (BOE).',
    `actual_lifted_volume_mcf` DECIMAL(18,2) COMMENT 'The actual volume of natural gas physically lifted by the partner, expressed in Thousand Cubic Feet (MCF). Null for oil-only liftings.',
    `cargo_reference_number` STRING COMMENT 'Reference number for the physical cargo or shipment associated with this lifting, if applicable. Links to logistics and transportation records.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this lifting entitlement record was first created in the system.',
    `cumulative_imbalance_value_usd` DECIMAL(18,2) COMMENT 'The total monetary value of the cumulative overlift or underlift position, expressed in USD.',
    `cumulative_imbalance_volume_boe` DECIMAL(18,2) COMMENT 'The cumulative overlift or underlift position for this partner across all lifting transactions to date, expressed in BOE. Positive indicates net overlift, negative indicates net underlift.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for all monetary values in this record. Typically USD for international oil and gas transactions.. Valid values are `^[A-Z]{3}$`',
    `entitlement_period_end_date` DATE COMMENT 'The end date of the production period for which this entitlement is calculated.',
    `entitlement_period_start_date` DATE COMMENT 'The start date of the production period for which this entitlement is calculated.',
    `entitlement_volume_bbl` DECIMAL(18,2) COMMENT 'The partners calculated entitlement volume for crude oil or liquids, expressed in barrels. Null for gas-only entitlements.',
    `entitlement_volume_boe` DECIMAL(18,2) COMMENT 'The partners calculated entitlement volume for the period, expressed in Barrels of Oil Equivalent (BOE) for standardized comparison across product types.',
    `entitlement_volume_mcf` DECIMAL(18,2) COMMENT 'The partners calculated entitlement volume for natural gas, expressed in Thousand Cubic Feet (MCF). Null for oil-only entitlements.',
    `imbalance_value_usd` DECIMAL(18,2) COMMENT 'The monetary value of the imbalance for this transaction, calculated as imbalance volume multiplied by reference price, expressed in USD.',
    `imbalance_volume_boe` DECIMAL(18,2) COMMENT 'The difference between entitlement and actual lifted volume for this transaction (actual minus entitlement), expressed in BOE. Positive indicates overlift, negative indicates underlift.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this lifting entitlement record was last updated or modified.',
    `lifting_date` DATE COMMENT 'The date on which the partner physically lifted or took delivery of the crude oil or natural gas volumes.',
    `lifting_reference_number` STRING COMMENT 'External business identifier for the lifting entitlement transaction, used for partner communication and reconciliation.',
    `measurement_method` STRING COMMENT 'The method or standard used to measure the lifted volumes, such as custody transfer meters, tank gauging, or flow meters.',
    `measurement_ticket_number` STRING COMMENT 'The reference number of the official measurement ticket or run ticket documenting the lifted volumes.',
    `net_revenue_interest_percentage` DECIMAL(18,2) COMMENT 'The partners Net Revenue Interest (NRI) percentage after deducting royalties and overriding royalty interests, used for revenue allocation.',
    `opening_imbalance_volume_boe` DECIMAL(18,2) COMMENT 'The cumulative imbalance position at the start of this entitlement period, before this lifting transaction is applied.',
    `pricing_basis` STRING COMMENT 'The pricing benchmark or index used to determine the reference price, such as West Texas Intermediate (WTI), Brent, or Henry Hub for natural gas.',
    `quality_adjustment_volume_boe` DECIMAL(18,2) COMMENT 'Volume adjustment applied due to product quality variance from specification, expressed in BOE. Can be positive or negative.',
    `quality_specification_met_flag` BOOLEAN COMMENT 'Indicates whether the lifted product met the contractual quality specifications. True if specifications were met, False if not.',
    `reference_price_per_boe` DECIMAL(18,2) COMMENT 'The reference price per BOE used to value the imbalance position, typically based on the contract pricing mechanism or market index.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to this lifting entitlement transaction.',
    `settlement_date` DATE COMMENT 'The date on which the imbalance was settled or is scheduled to be settled. Null if settlement is pending.',
    `settlement_election` STRING COMMENT 'The partners election for how they wish to settle their entitlement: in-kind (take physical product) or in-value (receive cash equivalent).. Valid values are `in_kind|in_value`',
    `settlement_method` STRING COMMENT 'The method by which the imbalance will be settled: in-kind (physical volume adjustment), in-value (cash settlement), cash-out (immediate cash payment), or carry-forward (deferred to future period).. Valid values are `in_kind|in_value|cash_out|carry_forward`',
    `settlement_status` STRING COMMENT 'The current status of the imbalance settlement process: pending (not yet initiated), in-progress (settlement underway), settled (completed), or disputed (under review).. Valid values are `pending|in_progress|settled|disputed`',
    `transportation_mode` STRING COMMENT 'The mode of transportation used for the lifting: pipeline, tanker, truck, rail, or barge.. Valid values are `pipeline|tanker|truck|rail|barge`',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The partners Working Interest (WI) percentage in the field or well at the time of this lifting, used to calculate entitlement.',
    CONSTRAINT pk_lifting_entitlement PRIMARY KEY(`lifting_entitlement_id`)
) COMMENT 'Tracks each partners crude oil and natural gas lifting entitlement, actual lifting volumes, and cumulative overlift/underlift imbalance positions under a JOA or PSA. Captures entitlement volume (BOE), actual lifted volume, cargo reference, lifting date, product grade, pricing basis, and in-kind vs. in-value settlement election. After merging overlift_underlift: also maintains cumulative imbalance position including opening balance, period variance, cumulative imbalance volume and value at reference price, settlement method, and settlement status. SSOT for partner lifting management and imbalance equalization.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` (
    `overlift_underlift_id` BIGINT COMMENT 'Primary key for overlift_underlift',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: Overlift/underlift imbalances are calculated at the terminal/facility level where liftings occur. overlift_underlift has well_asset_id and joa_id but no asset_facility_id. Facility-level imbalance tra',
    `jib_statement_id` BIGINT COMMENT 'Foreign key linking to venture.jib_statement. Business justification: overlift_underlift currently stores jib_reference_number as a denormalized STRING field. Replacing this with a proper FK to venture.jib_statement normalizes the relationship. Overlift/underlift imbala',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this imbalance is tracked.',
    `lifting_entitlement_id` BIGINT COMMENT 'Foreign key linking to venture.lifting_entitlement. Business justification: Overlift/underlift imbalances are directly derived from the difference between a partners lifting entitlement and actual liftings. overlift_underlift has joa_id, psa_id, and partner_id but no FK to t',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: Operator calculates and settles production imbalances under JOA/PSA terms. Operator reference critical for settlement instructions, tolerance threshold enforcement, and imbalance dispute resolution in',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Overlift/underlift imbalances are tracked by specific petroleum product. Business process: Partner imbalance settlement by product type, product-specific tolerance thresholds, imbalance valuation usin',
    `partner_id` BIGINT COMMENT 'Reference to the joint venture partner who holds this overlift or underlift position.',
    `psa_id` BIGINT COMMENT 'Reference to the Production Sharing Agreement under which this imbalance is tracked, if applicable.',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: Overlift/underlift imbalances arise from production of specific reservoirs; reservoir-level attribution is required for production-allocation accounting and partner-settlement calculations. Domain exp',
    `venture_working_interest_id` BIGINT COMMENT 'Foreign key linking to venture.venture_working_interest. Business justification: Overlift/underlift imbalance positions are tracked per partner per JOA/PSA asset, directly tied to the partners working interest position. overlift_underlift has joa_id, psa_id, and primary_overlift_',
    `well_asset_id` BIGINT COMMENT 'Reference to the producing asset (field, platform, or facility) where the imbalance occurred.',
    `actual_lifted_volume_boe` DECIMAL(18,2) COMMENT 'The actual volume of production in barrels of oil equivalent that the partner physically lifted or took delivery of during the current period.',
    `approval_status` STRING COMMENT 'The approval status of the imbalance calculation: draft (under preparation), pending approval (submitted for partner review), approved (accepted by all parties), or rejected (disputed or requiring revision).. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'The name or identifier of the person or system that approved the imbalance calculation.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the imbalance calculation was approved by the authorized party.',
    `calculation_method` STRING COMMENT 'The methodology used to calculate the imbalance: entitlement-based (PSA cost recovery and profit oil), working interest-based (JOA proportional share), PSA formula (specific contractual formula), or custom (bespoke calculation per agreement).. Valid values are `entitlement|working_interest|psa_formula|custom`',
    `closing_balance_boe` DECIMAL(18,2) COMMENT 'The cumulative overlift or underlift imbalance volume in barrels of oil equivalent at the end of the reporting period, calculated as opening balance plus current period variance.',
    `comments` STRING COMMENT 'Additional notes or comments regarding the imbalance position, settlement arrangements, or special circumstances.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this imbalance record was first created in the system.',
    `current_period_variance_boe` DECIMAL(18,2) COMMENT 'The difference between actual lifted volume and entitled volume for the current period in barrels of oil equivalent. Positive values indicate overlift; negative values indicate underlift.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the imbalance position is currently under dispute by one or more partners.',
    `dispute_reason` STRING COMMENT 'Description of the reason for the dispute, if applicable, such as disagreement on entitled volumes, pricing methodology, or measurement accuracy.',
    `dispute_resolution_date` DATE COMMENT 'The date on which the dispute was resolved and the imbalance position was agreed upon by all parties.',
    `entitled_volume_boe` DECIMAL(18,2) COMMENT 'The volume of production in barrels of oil equivalent that the partner is entitled to lift during the current period based on their working interest or PSA entitlement.',
    `imbalance_period_end_date` DATE COMMENT 'The end date of the reporting period for which this imbalance position is calculated.',
    `imbalance_period_start_date` DATE COMMENT 'The start date of the reporting period for which this imbalance position is calculated.',
    `imbalance_status` STRING COMMENT 'The current status of the imbalance position: overlift (partner lifted more than entitled), underlift (partner lifted less than entitled), balanced (no imbalance), pending settlement (awaiting equalization), settled (equalized), or disputed (under partner dispute resolution).. Valid values are `overlift|underlift|balanced|pending_settlement|settled|disputed`',
    `imbalance_value_usd` DECIMAL(18,2) COMMENT 'The monetary value of the closing imbalance position in United States Dollars, calculated as closing balance multiplied by reference price.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this imbalance record was last modified or updated.',
    `nri_percentage` DECIMAL(18,2) COMMENT 'The partners net revenue interest percentage in the asset at the time of the imbalance calculation, representing the share of production revenue after royalties and burdens.',
    `opening_balance_boe` DECIMAL(18,2) COMMENT 'The cumulative overlift or underlift imbalance volume in barrels of oil equivalent at the beginning of the reporting period. Positive values indicate overlift; negative values indicate underlift.',
    `price_index_reference` STRING COMMENT 'The market price index or benchmark used to determine the reference price for valuing the imbalance, such as WTI, Brent, Henry Hub, or a contractual formula.',
    `reference_price_per_boe` DECIMAL(18,2) COMMENT 'The reference price per barrel of oil equivalent used to value the imbalance position, typically based on market index prices such as WTI or Brent.',
    `settlement_completion_date` DATE COMMENT 'The actual date on which the imbalance position was fully settled or equalized.',
    `settlement_due_date` DATE COMMENT 'The date by which the imbalance position must be settled or equalized according to the JOA or PSA terms.',
    `settlement_method` STRING COMMENT 'The method by which the imbalance will be settled: in-kind (through future production adjustments), cash (monetary settlement), hybrid (combination of in-kind and cash), or not applicable (no settlement required).. Valid values are `in_kind|cash|hybrid|not_applicable`',
    `source_system` STRING COMMENT 'The name of the source system from which this imbalance record was extracted, typically SAP Joint Venture Accounting or Avocet Production Operations.',
    `tolerance_threshold_boe` DECIMAL(18,2) COMMENT 'The maximum allowable imbalance volume in barrels of oil equivalent before settlement is required, as defined in the JOA or PSA.',
    `tolerance_threshold_percentage` DECIMAL(18,2) COMMENT 'The maximum allowable imbalance as a percentage of entitled volume before settlement is required, as defined in the JOA or PSA.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The partners working interest percentage in the asset at the time of the imbalance calculation, used to determine entitled volumes.',
    CONSTRAINT pk_overlift_underlift PRIMARY KEY(`overlift_underlift_id`)
) COMMENT 'Tracks cumulative overlift and underlift imbalance positions per partner per JOA/PSA asset. Captures opening balance, current period lifting variance, cumulative imbalance volume (BOE), imbalance value at reference price, settlement method (cash or in-kind), and settlement status. Enables equalization calculations and supports partner dispute resolution for production imbalances.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`jv_budget` (
    `jv_budget_id` BIGINT COMMENT 'Unique identifier for the joint venture budget record. Primary key.',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: JV annual work program budgets are prepared at the facility level (processing plants, compression stations). jv_budget has joa_id and lease_id but no direct facility link. Facility-level JV budget rep',
    `block_id` BIGINT COMMENT 'Foreign key linking to exploration.block. Business justification: JV work program budgets are prepared for specific exploration blocks. Direct block linkage enables block-level budget vs. actual reporting, minimum work program commitment tracking, and operating comm',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Joint venture budgets feed into corporate budgets for annual planning, capital allocation, and budget-to-actual variance analysis. Essential for consolidated budget preparation and operating committee',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Annual JV budgets allocate funds to specific master contracts (rig contracts, facility O&M, transportation). Budget vs. actual reporting tracks spending against contracted rates and terms. Critical fo',
    `field_id` BIGINT COMMENT 'Foreign key linking to production.field. Business justification: JV budgets are prepared at the field level in joint operations; linking jv_budget to field enables field-level budget vs. actual production reporting and supports operating committee work program appr',
    `joa_id` BIGINT COMMENT 'Reference to the joint operating agreement or production sharing agreement that this budget supports.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: JV budgets allocate capital and operating spend across leases. Lease-level budget tracking is required for variance analysis, AFE reconciliation, and lease-level profitability reporting.',
    `operating_committee_id` BIGINT COMMENT 'Foreign key linking to venture.operating_committee. Business justification: The JV work program and budget (WP&B) is formally approved by the Operating Committee established under the JOA. jv_budget has operating_committee_approval_date as a denormalized date field but no FK ',
    `operating_license_id` BIGINT COMMENT 'Foreign key linking to compliance.operating_license. Business justification: Joint venture budgets must align with licensed production capacity limits, authorized operations scope, and license conditions. Budget submissions to operating committees reference the governing licen',
    `operator_id` BIGINT COMMENT 'Foreign key linking to land.operator. Business justification: JV budgets are prepared and managed by operator under JOA/PSA terms. Operator reference essential for budget approval workflow, variance accountability, and operating committee reporting in joint vent',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: JV budgets are structured under capital projects for multi-year work programs and development campaigns. Links annual JV budget to master project for lifecycle budget tracking and variance reporting.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: JV work program and budgets (WP&B) are prepared under both JOA and PSA frameworks. jv_budget has joa_id but no psa_id. Adding psa_id (nullable) allows JV budgets to be associated with PSA contracts. N',
    `reservoir_id` BIGINT COMMENT 'Foreign key linking to reservoir.reservoir. Business justification: JV budgets are prepared for specific reservoir developments; capex, drilling, and facilities budgets are tied to the reservoirs development plan. Domain experts expect jv_budget to reference the rese',
    `abandonment_budget_usd` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated to plug and abandonment activities, including well plugging, facility decommissioning, site restoration, and environmental remediation.',
    `afe_reference_list` STRING COMMENT 'Comma-separated list of AFE numbers associated with this budget, linking the budget to specific authorizations for expenditure that detail individual projects or work scopes within the overall work program.',
    `approved_by` STRING COMMENT 'Name or identifier of the operating committee chairperson or authorized representative who formally approved the budget on behalf of the joint venture partners.',
    `budget_end_date` DATE COMMENT 'Effective end date of the budget period, marking the close of the fiscal period for which this budget is authorized.',
    `budget_start_date` DATE COMMENT 'Effective start date of the budget period, marking when expenditures under this budget may begin to be incurred and allocated.',
    `budget_status` STRING COMMENT 'Current lifecycle state of the budget: draft (under preparation), submitted (sent to operating committee), approved (authorized by operating committee), rejected (not approved), revised (amended after initial approval), active (in execution), closed (fiscal period ended). [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|revised|active|closed — 7 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the budget by planning horizon and purpose: annual (standard yearly budget), multi-year (long-term capital program), supplemental (mid-year adjustment), emergency (unplanned urgent expenditure), or AFE-specific (tied to a single Authorization for Expenditure).. Valid values are `annual|multi_year|supplemental|emergency|afe_specific`',
    `budget_year` STRING COMMENT 'Fiscal year for which this budget applies, expressed as a four-digit year (e.g., 2024). For multi-year budgets, this represents the starting year.',
    `capex_budget_usd` DECIMAL(18,2) COMMENT 'Portion of the total gross budget allocated to capital expenditures, including drilling, completion, facility construction, and major equipment purchases that will be capitalized per accounting standards.',
    `comments` STRING COMMENT 'Free-text field for additional notes, clarifications, or special conditions related to the budget, including operating committee feedback, partner concerns, or execution constraints.',
    `completion_budget_usd` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated to well completion activities, including perforation, stimulation, fracturing, wellhead installation, and initial production equipment.',
    `contingency_amount_usd` DECIMAL(18,2) COMMENT 'Absolute dollar amount of contingency reserve included in the total budget, providing a buffer for cost overruns or unplanned expenditures.',
    `contingency_pct` DECIMAL(18,2) COMMENT 'Percentage of the total budget allocated as contingency reserve for unforeseen costs, scope changes, or risk mitigation, expressed as a decimal percentage (e.g., 10.00 for 10%).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the system, supporting audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budget amounts. While amounts are stored in USD, this field documents the original currency if the budget was prepared in a different currency and converted. [ENUM-REF-CANDIDATE: USD|CAD|GBP|EUR|AUD|NOK|BRL|MXN — 8 candidates stripped; promote to reference product]',
    `drilling_budget_usd` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated specifically to drilling operations, including rig costs, drilling fluids, casing, cementing, and directional drilling services.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert the original budget currency to USD, if applicable. Rate is expressed as units of original currency per 1 USD.',
    `facilities_budget_usd` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated to production facilities, including construction, expansion, or upgrade of processing plants, pipelines, storage tanks, and surface equipment.',
    `hse_budget_usd` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated to health, safety, and environmental programs, including safety training, environmental monitoring, spill prevention, and regulatory compliance activities.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was last modified, supporting audit trail and change tracking requirements.',
    `non_operator_share_usd` DECIMAL(18,2) COMMENT 'The aggregate allocated share of all non-operating partners in the total budget, representing the combined financial obligation of all non-operators for the work program.',
    `operating_committee_approval_date` DATE COMMENT 'Date when the operating committee formally approved this budget, authorizing the operator to proceed with the work program and incur expenditures.',
    `operator_share_usd` DECIMAL(18,2) COMMENT 'The operators allocated share of the total budget based on their working interest percentage, representing the operators financial obligation for the work program.',
    `operator_wi_pct` DECIMAL(18,2) COMMENT 'The operators working interest percentage in the joint venture, expressed as a decimal percentage (e.g., 45.00 for 45%). Used to calculate the operators share of costs and revenues.',
    `opex_budget_usd` DECIMAL(18,2) COMMENT 'Portion of the total gross budget allocated to operating expenditures, including lease operating expenses, production costs, routine maintenance, and day-to-day operational activities that will be expensed in the current period.',
    `overhead_allocation_method` STRING COMMENT 'Method used to allocate operator overhead costs to the joint venture budget: fixed rate (flat fee), percentage (of direct costs), actual cost (pass-through), or COPAS standard (per COPAS accounting guidelines).. Valid values are `fixed_rate|percentage|actual_cost|copas_standard`',
    `overhead_budget_usd` DECIMAL(18,2) COMMENT 'Total budgeted amount for operator overhead charges included in the work program budget, covering administrative, technical, and support services provided by the operator.',
    `overhead_rate_pct` DECIMAL(18,2) COMMENT 'Overhead rate applied to direct costs to calculate operator overhead charges, expressed as a decimal percentage (e.g., 15.00 for 15%). Applicable when overhead allocation method is percentage-based.',
    `production_operations_budget_usd` DECIMAL(18,2) COMMENT 'Portion of the total budget allocated to ongoing production operations, including well servicing, artificial lift, chemical treatments, and routine production maintenance.',
    `revision_date` DATE COMMENT 'Date when the current revision of the budget was created or amended. For the original budget, this is the initial submission date.',
    `revision_number` STRING COMMENT 'Sequential version number tracking amendments to the original budget. Initial approved budget is revision 0; subsequent amendments increment this counter.',
    `revision_reason` STRING COMMENT 'Explanation for why the budget was revised, documenting the business justification for amendments such as scope changes, cost overruns, new opportunities, or regulatory requirements.',
    `source_system` STRING COMMENT 'Name of the source system from which this budget record originated, typically SAP Joint Venture Accounting or another joint venture management system.',
    `source_system_code` STRING COMMENT 'Unique identifier for this budget record in the source system, enabling traceability and reconciliation between the lakehouse and operational systems.',
    `total_gross_budget_usd` DECIMAL(18,2) COMMENT 'Total authorized budget amount in US dollars for the joint venture work program before allocation to partners. Represents 100% of the budgeted expenditure across all working interest owners.',
    `work_program_description` STRING COMMENT 'Detailed narrative description of the planned work program activities covered by this budget, including drilling operations, production optimization, facility maintenance, and other joint venture activities.',
    CONSTRAINT pk_jv_budget PRIMARY KEY(`jv_budget_id`)
) COMMENT 'Annual and multi-year joint venture work program and budget (WP&B) approved by the operating committee for a JOA or PSA. Captures budget year, work program description, total gross budget, operator share, non-operator shares by WI, CAPEX/OPEX split, AFE references, budget revision number, and operating committee approval date. Distinct from the corporate finance budget — this is the joint account budget owned by the venture domain.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`operating_committee` (
    `operating_committee_id` BIGINT COMMENT 'Unique identifier for the Operating Committee record. Primary key.',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this Operating Committee is established. Links the committee to its governing JOA.',
    `partner_id` BIGINT COMMENT 'FK to venture.partner',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: Operating Committees can be established under PSA contracts as well as JOAs to govern joint decision-making. operating_committee has joa_id but no psa_id. Adding psa_id (nullable) covers PSA-based ope',
    `tertiary_operating_chairperson_party_venture_partner_id` BIGINT COMMENT 'FK to venture.partner',
    `afe_approval_authority_usd` DECIMAL(18,2) COMMENT 'The maximum dollar amount of an AFE that the Operating Committee can approve without requiring additional partner consent or escalation. Expressed in US dollars.',
    `chairperson_rotation_frequency` STRING COMMENT 'The frequency at which the chairperson role rotates among partner representatives. Annual means yearly rotation; biennial means every two years; fixed means the chairperson does not rotate; rotating means rotation occurs but on an irregular schedule.. Valid values are `annual|biennial|fixed|rotating`',
    `committee_code` STRING COMMENT 'Short alphanumeric code used to identify the Operating Committee in internal systems and reporting. Facilitates quick reference and system integration.',
    `committee_name` STRING COMMENT 'The official name of the Operating Committee as designated in the JOA. Typically includes the asset or field name for identification.',
    `confidentiality_requirement` BOOLEAN COMMENT 'Indicates whether Operating Committee proceedings, minutes, and decisions are subject to confidentiality obligations under the JOA. True means confidentiality is required; false means no specific confidentiality obligation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this Operating Committee record was first created in the system. Supports audit trail and data lineage.',
    `decision_authority_scope` STRING COMMENT 'A textual description of the scope of decision-making authority granted to the Operating Committee under the JOA. Defines what types of operational, financial, and strategic decisions the committee can make.',
    `dispute_resolution_method` STRING COMMENT 'The primary method specified in the JOA for resolving disputes that arise within the Operating Committee. Arbitration involves binding third-party arbitration; mediation involves facilitated negotiation; litigation involves court proceedings; expert determination involves a technical experts binding decision.. Valid values are `arbitration|mediation|litigation|expert_determination`',
    `dissolution_date` DATE COMMENT 'The date on which the Operating Committee was formally dissolved or disbanded. Null for active committees. Marks the end of the committees governance authority.',
    `establishment_date` DATE COMMENT 'The date on which the Operating Committee was formally established under the JOA. Marks the beginning of the committees governance authority.',
    `governing_law` STRING COMMENT 'The jurisdiction and legal framework under which the Operating Committee operates and resolves disputes. Typically aligns with the JOAs governing law.',
    `last_meeting_date` DATE COMMENT 'The date of the most recent Operating Committee meeting. Used to track meeting cadence and governance activity.',
    `meeting_frequency` STRING COMMENT 'The scheduled frequency at which the Operating Committee convenes for regular meetings as stipulated in the JOA. As-needed indicates meetings are called on an ad-hoc basis.. Valid values are `monthly|quarterly|semi-annually|annually|as-needed`',
    `meeting_location` STRING COMMENT 'The primary physical or virtual location where Operating Committee meetings are held. May include city, office address, or virtual meeting platform details.',
    `minutes_retention_years` STRING COMMENT 'The number of years that meeting minutes and committee records must be retained for audit, compliance, and legal purposes. Aligns with regulatory and contractual requirements.',
    `modified_by` STRING COMMENT 'The user ID or system identifier of the person or process that last modified this Operating Committee record. Supports audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this Operating Committee record was last modified in the system. Supports audit trail and change tracking.',
    `next_scheduled_meeting_date` DATE COMMENT 'The date of the next scheduled Operating Committee meeting. Facilitates planning and ensures partners are aware of upcoming governance events.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional context, special provisions, or operational notes related to the Operating Committee that do not fit into structured fields.',
    `notice_period_days` STRING COMMENT 'The minimum number of days advance notice required before a scheduled Operating Committee meeting. Ensures all partners have adequate time to prepare and attend.',
    `operating_committee_status` STRING COMMENT 'Current operational status of the Operating Committee. Active committees are currently governing joint operations; inactive committees are temporarily not meeting; suspended committees have paused governance due to disputes or force majeure; dissolved committees have been permanently disbanded.. Valid values are `active|inactive|suspended|dissolved`',
    `proxy_voting_allowed` BOOLEAN COMMENT 'Indicates whether partner representatives are permitted to vote by proxy if they cannot attend a meeting in person. True means proxy voting is allowed; false means representatives must attend to vote.',
    `quorum_requirement_pct` DECIMAL(18,2) COMMENT 'The minimum percentage of working interest or voting rights that must be represented at a meeting for the committee to conduct official business and make binding decisions. Expressed as a percentage of total working interest.',
    `source_system` STRING COMMENT 'The name of the source system from which this Operating Committee record originated. Typically SAP Joint Venture Accounting or a contract management system. Supports data lineage and integration traceability.',
    `source_system_code` STRING COMMENT 'The unique identifier of this Operating Committee record in the source system. Enables cross-system reconciliation and data lineage tracking.',
    `total_member_count` STRING COMMENT 'The total number of partner representatives who are members of the Operating Committee. Each JOA partner typically appoints one or more representatives.',
    `virtual_meeting_allowed` BOOLEAN COMMENT 'Indicates whether Operating Committee meetings may be conducted virtually via teleconference or video conference. True means virtual meetings are permitted; false means in-person attendance is required.',
    `voting_basis` STRING COMMENT 'The method by which votes are weighted in committee decisions. Working interest means votes are proportional to each partys working interest percentage; one vote per party means each partner has equal voting power regardless of interest; hybrid combines both methods for different decision types.. Valid values are `working_interest|one_vote_per_party|hybrid`',
    `voting_threshold_ordinary_pct` DECIMAL(18,2) COMMENT 'The minimum percentage of affirmative votes required to pass ordinary resolutions or routine operational decisions. Typically expressed as a percentage of working interest represented at the meeting.',
    `voting_threshold_special_pct` DECIMAL(18,2) COMMENT 'The minimum percentage of affirmative votes required to pass special resolutions involving major decisions such as large capital expenditures, changes to the JOA, or operator replacement. Typically higher than ordinary resolution threshold.',
    `created_by` STRING COMMENT 'The user ID or system identifier of the person or process that created this Operating Committee record. Supports audit trail and data lineage.',
    CONSTRAINT pk_operating_committee PRIMARY KEY(`operating_committee_id`)
) COMMENT 'Master record for the Operating Committee (OpCom) established under each JOA, representing the governance body of partner representatives with voting rights over joint operations. Captures committee name, associated JOA, meeting frequency, quorum requirements, voting threshold for ordinary vs. special resolutions, and current chairperson. SSOT for JOA governance structure.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`carried_interest` (
    `carried_interest_id` BIGINT COMMENT 'Unique identifier for the carried interest arrangement. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Carried interest arrangements track costs against specific AFE budgets for recovery calculations and payout determination. Essential for farmout economics and partner cost recovery in oil-and-gas join',
    `asset_facility_id` BIGINT COMMENT 'Foreign key linking to asset.asset_facility. Business justification: Carried interest arrangements in JVs are tied to facility development projects (e.g., a partner carried through processing plant construction). carried_interest has well_asset_id but no asset_facility',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Carried interest agreements must specify how compliance obligations are allocated between carrier and carried party. Each partys share of regulatory costs, bonds, and abandonment obligations must be ',
    `farmout_id` BIGINT COMMENT 'Foreign key linking to venture.farmout. Business justification: Carried interest arrangements frequently originate from farmout transactions where the farmor agrees to carry the farminee through a specific phase (e.g., exploration drilling). carried_interest has j',
    `joa_id` BIGINT COMMENT 'Reference to the joint operating agreement under which this carried interest arrangement is established.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Carry agreements are tied to specific lease interests. Lease_id defines the scope of carry, enables tracking of carried costs by lease, and determines reversion working interest upon payout.',
    `pipeline_segment_id` BIGINT COMMENT 'Foreign key linking to asset.pipeline_segment. Business justification: Carried interest applies to pipeline construction projects in JV areas. A partner may be carried through pipeline build-out with reversion rights. carried_interest has well_asset_id but no pipeline_se',
    `partner_id` BIGINT COMMENT 'Reference to the partner who is funding the carried partys share of costs during the carry period.',
    `project_id` BIGINT COMMENT 'Foreign key linking to finance.project. Business justification: Carried interest arrangements are tracked at project level for payout monitoring and recovery calculations. Standard farmout economics tracking for earn-in work program completion and back-in rights.',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to exploration.prospect. Business justification: Carried interest arrangements in exploration are typically tied to drilling a specific prospect. Direct prospect linkage enables tracking carry obligations against prospect drilling status, payout tri',
    `psa_id` BIGINT COMMENT 'Reference to the production sharing agreement if this carried interest is part of a PSA structure. Nullable for JOA-only arrangements.',
    `venture_working_interest_id` BIGINT COMMENT 'Foreign key linking to venture.venture_working_interest. Business justification: A carried interest arrangement is tied to a specific working interest position — the carrier funds the carried partys share of a specific WI. carried_interest has joa_id, psa_id, and well_asset_id bu',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Carried interest tracking requires WBS elements for cost accumulation, recovery monitoring, and payout calculation. Critical for farmout economics tracking and carried party cost recovery reporting.',
    `accrued_interest_amount` DECIMAL(18,2) COMMENT 'Total interest amount in base currency that has accrued on the outstanding carry balance to date.',
    `back_in_right_flag` BOOLEAN COMMENT 'Indicates whether the carried party has the right to back-in to the project after payout by reimbursing the carrier for carried costs.',
    `back_in_wi_percentage` DECIMAL(18,2) COMMENT 'Working interest percentage the carried party can back-in to if they exercise their back-in right. Nullable if no back-in right exists.',
    `carried_interest_status` STRING COMMENT 'Current lifecycle status of the carried interest arrangement.. Valid values are `active|suspended|completed|terminated|defaulted`',
    `carried_wi_percentage` DECIMAL(18,2) COMMENT 'The working interest percentage of the carried party that is being carried by the carrier partner.',
    `carry_agreement_number` STRING COMMENT 'Business identifier for the carried interest arrangement, typically referenced in AFE documents and joint interest billing.',
    `carry_amount_limit` DECIMAL(18,2) COMMENT 'Maximum amount in base currency that the carrier will fund on behalf of the carried party. Nullable for unlimited carry arrangements.',
    `carry_phase` STRING COMMENT 'The operational phase during which the carry applies: exploration, appraisal, development, drilling, or completion.. Valid values are `exploration|appraisal|development|drilling|completion`',
    `carry_type` STRING COMMENT 'Type of carry arrangement: full (100% of costs carried), partial (percentage of costs carried), casing_point (carry until casing point decision), or production (carry until first production).. Valid values are `full|partial|casing_point|production`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carried interest record was first created in the system.',
    `cumulative_carried_amount` DECIMAL(18,2) COMMENT 'Total amount in base currency that has been carried by the carrier partner to date, including all costs funded on behalf of the carried party.',
    `cumulative_recovered_amount` DECIMAL(18,2) COMMENT 'Total amount in base currency that has been recovered by the carrier partner to date through the agreed recovery mechanism.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this carried interest arrangement.. Valid values are `^[A-Z]{3}$`',
    `default_provision` STRING COMMENT 'Contractual provisions that apply if the carried party defaults on obligations or if the carrier fails to fund agreed costs.',
    `effective_date` DATE COMMENT 'Date when the carried interest arrangement becomes effective and cost carrying begins.',
    `expiry_date` DATE COMMENT 'Date when the carried interest arrangement expires or the carry period ends. Nullable for open-ended arrangements.',
    `forfeiture_provision` STRING COMMENT 'Terms under which the carried party may forfeit their interest if they fail to meet obligations or if recovery conditions are not met.',
    `interest_accrual_method` STRING COMMENT 'Method of interest calculation on the outstanding carry balance: simple (interest on principal only), compound (interest on principal plus accrued interest), or none (no interest).. Valid values are `simple|compound|none`',
    `interest_rate_percentage` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the outstanding carry balance if the carry agreement includes interest accrual. Nullable if no interest applies.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified this carried interest record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this carried interest record was last modified in the system.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special terms, or clarifications regarding the carried interest arrangement.',
    `outstanding_carry_balance` DECIMAL(18,2) COMMENT 'Current outstanding balance in base currency that remains to be recovered by the carrier partner. Calculated as cumulative_carried_amount minus cumulative_recovered_amount.',
    `payout_date` DATE COMMENT 'Date when the carried interest was fully recovered and payout was achieved. Nullable until payout is complete.',
    `payout_status` STRING COMMENT 'Current payout status of the carry arrangement: pre_payout (no recovery started), in_payout (recovery in progress), post_payout (fully recovered), or suspended (recovery temporarily halted).. Valid values are `pre_payout|in_payout|post_payout|suspended`',
    `recovery_mechanism` STRING COMMENT 'Method by which the carrier recovers carried costs: gross_revenue (from gross production revenue), net_revenue (from net revenue after royalties), production_volume (from carried partys production volumes), or cost_allocation (through future cost allocations).. Valid values are `gross_revenue|net_revenue|production_volume|cost_allocation`',
    `recovery_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to carried costs for recovery calculation. For example, 2.0 means carrier recovers twice the carried amount. Default is 1.0 for dollar-for-dollar recovery.',
    `recovery_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of the carried partys revenue or production that is applied to recover the carried costs. For example, 50% means half of carried partys revenue goes to carrier until carry is recovered.',
    `reversion_nri_percentage` DECIMAL(18,2) COMMENT 'Net revenue interest percentage that reverts to the carrier partner after payout is achieved. Nullable if no reversion applies.',
    `reversion_wi_percentage` DECIMAL(18,2) COMMENT 'Working interest percentage that reverts to the carrier partner after payout is achieved. Nullable if no reversion applies.',
    `sec_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether this carried interest arrangement must be disclosed in SEC filings due to materiality thresholds or partner reporting requirements.',
    `source_system` STRING COMMENT 'Name of the source system from which this carried interest record originated, typically SAP Joint Venture Accounting or partner accounting system.',
    `source_system_code` STRING COMMENT 'Unique identifier for this carried interest record in the source system, used for data lineage and reconciliation.',
    `created_by` STRING COMMENT 'User identifier of the person who created this carried interest record.',
    CONSTRAINT pk_carried_interest PRIMARY KEY(`carried_interest_id`)
) COMMENT 'Tracks carried interest arrangements where one partner (the carrier) funds another partners (the carried party) share of costs during an exploration or development phase, to be recovered from future production revenues. Captures carry type (full/partial), carry period, carry amount, recovery mechanism (gross/net), recovery rate, cumulative recovered amount, and outstanding carry balance. Supports complex E&P financing structures.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`joint_venture` (
    `joint_venture_id` BIGINT COMMENT 'Primary key for joint_venture',
    `joa_id` BIGINT COMMENT 'Foreign key linking to venture.joa. Business justification: A joint venture is typically governed by a Joint Operating Agreement. joint_venture currently has partner_id and parent_joint_venture_id but no FK to joa. Adding joa_id links the JV master record to i',
    `parent_joint_venture_id` BIGINT COMMENT 'Self-referencing FK on joint_venture (parent_joint_venture_id)',
    `partner_id` BIGINT COMMENT 'Unique identifier of the partner organization involved in the joint venture.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Joint ventures map directly to profit centers for segment P&L reporting and equity accounting. Standard JV financial reporting structure for consolidated and proportionate consolidation methods.',
    `psa_id` BIGINT COMMENT 'Foreign key linking to venture.psa. Business justification: A joint venture may be governed by a Production Sharing Agreement instead of (or in addition to) a JOA, particularly in international upstream operations. joint_venture has no FK to psa. Adding psa_id',
    `accounting_standard` STRING COMMENT 'Accounting framework used for joint venture financial reporting.',
    `afe_approval_number` STRING COMMENT 'Authorization number for the Authorization for Expenditure (AFE) linked to the joint venture.',
    `approval_date` DATE COMMENT 'Date the joint venture was formally approved by corporate governance.',
    `cash_call_amount` DECIMAL(18,2) COMMENT 'Monetary amount requested from the partner for cash calls.',
    `cash_call_due_date` DATE COMMENT 'Date by which the cash call amount must be paid.',
    `cost_recovery_method` STRING COMMENT 'Method used to recover costs from production revenue.',
    `cost_recovery_rate` DECIMAL(18,2) COMMENT 'Rate (percentage) at which costs are recovered from production revenue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the joint venture record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `effective_from` DATE COMMENT 'Date the joint venture agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date the joint venture agreement ends or expires (null if open‑ended).',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the joint venture details are classified as confidential.',
    `joint_interest_billing_flag` BOOLEAN COMMENT 'Indicates whether joint interest billing (JIB) is applied to this venture.',
    `joint_venture_code` STRING COMMENT 'External business code or number assigned to the joint venture.',
    `joint_venture_description` STRING COMMENT 'Free‑form description of the joint venture purpose and scope.',
    `joint_venture_name` STRING COMMENT 'Human‑readable name of the joint venture.',
    `joint_venture_status` STRING COMMENT 'Current lifecycle status of the joint venture.',
    `joint_venture_type` STRING COMMENT 'Classification of the agreement type (e.g., Joint Operating Agreement, Production Sharing Agreement).',
    `jurisdiction` STRING COMMENT 'ISO‑3 country code of the legal jurisdiction governing the joint venture.',
    `netting_method` STRING COMMENT 'Method used for netting partner balances (gross or net).',
    `partner_equity_percent` DECIMAL(18,2) COMMENT 'Equity share percentage owned by the partner in the joint venture.',
    `profit_gas_split_percentage` DECIMAL(18,2) COMMENT 'Percentage of gas profit allocated to the partner after cost recovery.',
    `profit_oil_split_percentage` DECIMAL(18,2) COMMENT 'Percentage of oil profit allocated to the partner after cost recovery.',
    `profit_split_percentage` DECIMAL(18,2) COMMENT 'Overall percentage of profit allocated to the partner after cost recovery.',
    `reporting_entity` STRING COMMENT 'Internal entity responsible for financial reporting of the joint venture.',
    `sec_disclosure_date` DATE COMMENT 'Date the joint venture information was disclosed to the SEC.',
    `sec_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the joint venture must be disclosed in SEC filings.',
    `tax_regime` STRING COMMENT 'Tax regime applicable to the joint venture earnings.',
    `total_commitment_amount` DECIMAL(18,2) COMMENT 'Total monetary commitment pledged by the partner for the joint venture.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the joint venture record.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Working interest percentage allocated to the partner for production operations.',
    CONSTRAINT pk_joint_venture PRIMARY KEY(`joint_venture_id`)
) COMMENT 'Master reference table for joint_venture. Referenced by joint_venture_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` (
    `operating_committee_member_id` BIGINT COMMENT 'Primary key for the operating_committee_member association',
    `operating_committee_id` BIGINT COMMENT 'Foreign key linking to the operating committee on which the partner holds membership',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the partner who holds membership on the operating committee',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this membership record was first created in the system.',
    `member_role` STRING COMMENT 'The governance role held by this partner representative on the operating committee. Chairperson presides over meetings; Alternates can vote in absence of primary representative.',
    `member_wi_percentage` DECIMAL(18,2) COMMENT 'The working interest percentage held by this partner in the joint venture associated with this operating committee. Determines voting weight in committee decisions.',
    `membership_end_date` DATE COMMENT 'The date on which this partners representation on the operating committee ceased, due to working interest divestiture, JOA termination, or committee dissolution. Null for active memberships.',
    `membership_start_date` DATE COMMENT 'The date on which this partners representation on the operating committee became effective, typically aligned with JOA execution or working interest acquisition.',
    `membership_status` STRING COMMENT 'Current status of this committee membership. Active memberships have full voting rights; Suspended may occur during dispute resolution; Terminated indicates historical membership.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this membership record was most recently updated.',
    `proxy_designation` STRING COMMENT 'The name or identifier of the alternate representative authorized to vote on behalf of this partner when the primary representative cannot attend committee meetings. Only applicable if the JOA permits proxy voting.',
    `representative_email` STRING COMMENT 'The email address of the partner representative for committee correspondence and meeting notices.',
    `representative_name` STRING COMMENT 'The full name of the individual representing this partner on the operating committee.',
    `voting_rights_percentage` DECIMAL(18,2) COMMENT 'The percentage of voting rights allocated to this partner representative on the operating committee. Typically aligned with working interest but may differ based on JOA provisions.',
    CONSTRAINT pk_operating_committee_member PRIMARY KEY(`operating_committee_member_id`)
) COMMENT 'This association product represents the membership relationship between partners and operating committees in joint venture governance. It captures each partners representation on an Operating Committee, including their voting rights, role, and tenure. Each record links one partner to one operating committee with attributes that exist only in the context of this membership relationship. This is a foundational governance concept in JOA (Joint Operating Agreement) structures, where working interest owners are entitled to committee representation.. Existence Justification: In JOA governance structures, operating committees are composed of representatives from multiple working interest partners, and each partner typically participates on multiple operating committees across their portfolio of joint ventures. This is a foundational governance relationship in oil and gas joint operations: the business actively manages committee memberships, tracks voting rights proportional to working interest, assigns roles (chairperson, member, alternate), and maintains historical records of representation for audit and compliance purposes.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ADD CONSTRAINT `fk_venture_joa_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ADD CONSTRAINT `fk_venture_joa_joa_venture_partner_id` FOREIGN KEY (`joa_venture_partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ADD CONSTRAINT `fk_venture_psa_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ADD CONSTRAINT `fk_venture_psa_psa_venture_partner_id` FOREIGN KEY (`psa_venture_partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_farmout_id` FOREIGN KEY (`farmout_id`) REFERENCES `oil_gas_ecm`.`venture`.`farmout`(`farmout_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_farmout_farmor_partner_id` FOREIGN KEY (`farmout_farmor_partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_operating_committee_id` FOREIGN KEY (`operating_committee_id`) REFERENCES `oil_gas_ecm`.`venture`.`operating_committee`(`operating_committee_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ADD CONSTRAINT `fk_venture_afe_approval_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ADD CONSTRAINT `fk_venture_afe_approval_venture_afe_id` FOREIGN KEY (`venture_afe_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_afe`(`venture_afe_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ADD CONSTRAINT `fk_venture_afe_approval_venture_working_interest_id` FOREIGN KEY (`venture_working_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_working_interest`(`venture_working_interest_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_jib_statement_id` FOREIGN KEY (`jib_statement_id`) REFERENCES `oil_gas_ecm`.`venture`.`jib_statement`(`jib_statement_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_venture_afe_id` FOREIGN KEY (`venture_afe_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_afe`(`venture_afe_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_venture_afe_id` FOREIGN KEY (`venture_afe_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_afe`(`venture_afe_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ADD CONSTRAINT `fk_venture_cash_call_payment_cash_call_id` FOREIGN KEY (`cash_call_id`) REFERENCES `oil_gas_ecm`.`venture`.`cash_call`(`cash_call_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ADD CONSTRAINT `fk_venture_cash_call_payment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_jib_statement_id` FOREIGN KEY (`jib_statement_id`) REFERENCES `oil_gas_ecm`.`venture`.`jib_statement`(`jib_statement_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ADD CONSTRAINT `fk_venture_profit_oil_split_cost_recovery_id` FOREIGN KEY (`cost_recovery_id`) REFERENCES `oil_gas_ecm`.`venture`.`cost_recovery`(`cost_recovery_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ADD CONSTRAINT `fk_venture_profit_oil_split_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ADD CONSTRAINT `fk_venture_profit_oil_split_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ADD CONSTRAINT `fk_venture_lifting_entitlement_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ADD CONSTRAINT `fk_venture_lifting_entitlement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ADD CONSTRAINT `fk_venture_lifting_entitlement_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ADD CONSTRAINT `fk_venture_lifting_entitlement_venture_working_interest_id` FOREIGN KEY (`venture_working_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_working_interest`(`venture_working_interest_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_jib_statement_id` FOREIGN KEY (`jib_statement_id`) REFERENCES `oil_gas_ecm`.`venture`.`jib_statement`(`jib_statement_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_lifting_entitlement_id` FOREIGN KEY (`lifting_entitlement_id`) REFERENCES `oil_gas_ecm`.`venture`.`lifting_entitlement`(`lifting_entitlement_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_venture_working_interest_id` FOREIGN KEY (`venture_working_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_working_interest`(`venture_working_interest_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_operating_committee_id` FOREIGN KEY (`operating_committee_id`) REFERENCES `oil_gas_ecm`.`venture`.`operating_committee`(`operating_committee_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ADD CONSTRAINT `fk_venture_operating_committee_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ADD CONSTRAINT `fk_venture_operating_committee_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ADD CONSTRAINT `fk_venture_operating_committee_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ADD CONSTRAINT `fk_venture_operating_committee_tertiary_operating_chairperson_party_venture_partner_id` FOREIGN KEY (`tertiary_operating_chairperson_party_venture_partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_farmout_id` FOREIGN KEY (`farmout_id`) REFERENCES `oil_gas_ecm`.`venture`.`farmout`(`farmout_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_venture_working_interest_id` FOREIGN KEY (`venture_working_interest_id`) REFERENCES `oil_gas_ecm`.`venture`.`venture_working_interest`(`venture_working_interest_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` ADD CONSTRAINT `fk_venture_joint_venture_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` ADD CONSTRAINT `fk_venture_joint_venture_parent_joint_venture_id` FOREIGN KEY (`parent_joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` ADD CONSTRAINT `fk_venture_joint_venture_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` ADD CONSTRAINT `fk_venture_joint_venture_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ADD CONSTRAINT `fk_venture_operating_committee_member_operating_committee_id` FOREIGN KEY (`operating_committee_id`) REFERENCES `oil_gas_ecm`.`venture`.`operating_committee`(`operating_committee_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ADD CONSTRAINT `fk_venture_operating_committee_member_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`venture` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `oil_gas_ecm`.`venture` SET TAGS ('dbx_domain' = 'venture');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` SET TAGS ('dbx_subdomain' = 'joint_governance');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `partner_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `joa_venture_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Party ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `abandonment_provision` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Provision');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `afe_approval_threshold_usd` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Approval Threshold (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `audit_rights` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `cash_call_frequency` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Frequency');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `cash_call_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|as_needed|milestone_based');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `confidentiality_provision` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Provision');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `contract_area` SET TAGS ('dbx_business_glossary_term' = 'Contract Area');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `copas_election` SET TAGS ('dbx_business_glossary_term' = 'Council of Petroleum Accountants Societies (COPAS) Election');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `copas_election` SET TAGS ('dbx_value_regex' = 'copas_2005|copas_2019|custom|none');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `default_provision` SET TAGS ('dbx_business_glossary_term' = 'Default Provision');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|litigation|expert_determination');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `forfeiture_provision` SET TAGS ('dbx_business_glossary_term' = 'Forfeiture Provision');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `hse_standard` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Standard');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `insurance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `interest_rate_late_payment_pct` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Late Payment Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `joa_name` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Name');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `joa_number` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `joa_status` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `joa_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|amended');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `last_amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Description');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `non_operator_rights` SET TAGS ('dbx_business_glossary_term' = 'Non-Operator Rights');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `overhead_rate_method` SET TAGS ('dbx_business_glossary_term' = 'Overhead Rate Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `overhead_rate_method` SET TAGS ('dbx_value_regex' = 'fixed|percentage|actual|hybrid');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `overhead_rate_value` SET TAGS ('dbx_business_glossary_term' = 'Overhead Rate Value');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (Days)');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `transfer_restriction` SET TAGS ('dbx_business_glossary_term' = 'Transfer Restriction');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `voting_threshold_ordinary_pct` SET TAGS ('dbx_business_glossary_term' = 'Voting Threshold Ordinary Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `voting_threshold_special_pct` SET TAGS ('dbx_business_glossary_term' = 'Voting Threshold Special Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` SET TAGS ('dbx_subdomain' = 'joint_governance');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Partner ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `psa_venture_partner_id` SET TAGS ('dbx_business_glossary_term' = 'National Oil Company (NOC) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `arbitration_forum` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Forum');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `contract_area` SET TAGS ('dbx_business_glossary_term' = 'Contract Area');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `contractor_profit_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Contractor Profit Share Percent');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `cost_recovery_carryforward_allowed` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Carryforward Allowed');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `cost_recovery_ceiling_percent` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Ceiling Percent');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|unit_of_production|immediate_expensing');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `development_period_years` SET TAGS ('dbx_business_glossary_term' = 'Development Period Years');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `domestic_market_obligation_percent` SET TAGS ('dbx_business_glossary_term' = 'Domestic Market Obligation (DMO) Percent');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `environmental_compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Standard');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `exploration_period_years` SET TAGS ('dbx_business_glossary_term' = 'Exploration Period Years');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `government_profit_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Government Profit Share Percent');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `host_country_code` SET TAGS ('dbx_business_glossary_term' = 'Host Country Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `host_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `local_content_requirement_percent` SET TAGS ('dbx_business_glossary_term' = 'Local Content Requirement Percent');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `minimum_expenditure_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Expenditure Commitment');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `minimum_expenditure_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `minimum_work_obligation` SET TAGS ('dbx_business_glossary_term' = 'Minimum Work Obligation');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `production_bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Production Bonus Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `production_bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `production_bonus_threshold_bopd` SET TAGS ('dbx_business_glossary_term' = 'Production Bonus Threshold Barrels of Oil Per Day (BOPD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `profit_oil_split_method` SET TAGS ('dbx_business_glossary_term' = 'Profit Oil Split Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `profit_oil_split_method` SET TAGS ('dbx_value_regex' = 'fixed_percentage|r_factor|production_tier|sliding_scale|rate_of_return');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `psa_name` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Name');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `psa_number` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Contract Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `psa_status` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `relinquishment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Relinquishment Schedule');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `ring_fencing_rule` SET TAGS ('dbx_business_glossary_term' = 'Ring Fencing Rule');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `ring_fencing_rule` SET TAGS ('dbx_value_regex' = 'contract_level|field_level|block_level|none');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `signature_bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Signature Bonus Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `signature_bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `stabilization_clause` SET TAGS ('dbx_business_glossary_term' = 'Stabilization Clause');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `state_participation_percent` SET TAGS ('dbx_business_glossary_term' = 'State Participation Percent');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `training_and_technology_transfer_obligation` SET TAGS ('dbx_business_glossary_term' = 'Training and Technology Transfer Obligation');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` SET TAGS ('dbx_subdomain' = 'joint_governance');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Authority Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `annual_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `annual_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `annual_revenue_currency` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Currency');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `annual_revenue_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `api_partner_code` SET TAGS ('dbx_business_glossary_term' = 'American Petroleum Institute (API) Partner Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Partner Classification');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'operator|non_operator|working_interest_owner|royalty_owner|overriding_royalty_owner|area_of_mutual_interest');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Country of Incorporation');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `credit_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Currency');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `credit_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `default_interest_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Default Interest Rate Percent');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Entity Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'IOC|NOC|independent|government|private_equity|service_company');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `is_government_entity` SET TAGS ('dbx_business_glossary_term' = 'Is Government Entity Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `is_operator` SET TAGS ('dbx_business_glossary_term' = 'Is Operator Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `kyc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Completion Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `kyc_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Review Due Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Legal Name');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `partner_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `partner_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|defaulted|withdrawn');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `partnership_end_date` SET TAGS ('dbx_business_glossary_term' = 'Partnership End Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `partnership_start_date` SET TAGS ('dbx_business_glossary_term' = 'Partnership Start Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_country` SET TAGS ('dbx_business_glossary_term' = 'Registered Country');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_business_glossary_term' = 'Registered State or Province');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `sanctioned_entity_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctioned Entity Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `sanctioned_entity_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `sap_partner_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Partner Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `sap_vendor_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Vendor Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Short Name');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `stock_exchange_ticker` SET TAGS ('dbx_business_glossary_term' = 'Stock Exchange Ticker Symbol');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Partner Website URL');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Block Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `farmout_id` SET TAGS ('dbx_business_glossary_term' = 'Farmout Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `afe_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Approval Required Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `afe_approval_threshold_usd` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Approval Threshold (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `assignment_reference` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reference');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `billing_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Billing Allocation Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `billing_allocation_method` SET TAGS ('dbx_value_regex' = 'proportional|fixed|custom');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `carried_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `carried_through_phase` SET TAGS ('dbx_business_glossary_term' = 'Carried Through Phase');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `carried_through_phase` SET TAGS ('dbx_value_regex' = 'exploration|drilling|completion|production|none');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `cash_call_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Eligible Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `cost_recovery_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Limit (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `non_consent_option` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Option');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `non_consent_option` SET TAGS ('dbx_value_regex' = 'allowed|not_allowed|conditional');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `non_consent_penalty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Penalty Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `nri_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `operator_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `orri_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overriding Royalty Interest (ORRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `partner_netting_flag` SET TAGS ('dbx_business_glossary_term' = 'Partner Netting Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `payout_date` SET TAGS ('dbx_business_glossary_term' = 'Payout Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `payout_status` SET TAGS ('dbx_business_glossary_term' = 'Payout Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `payout_status` SET TAGS ('dbx_value_regex' = 'pre-payout|post-payout|not_applicable');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `profit_gas_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Profit Gas Split Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `profit_oil_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Profit Oil Split Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `reversion_nri_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reversion Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `reversion_wi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reversion Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `sap_jva_cost_object` SET TAGS ('dbx_business_glossary_term' = 'SAP Joint Venture Accounting (JVA) Cost Object');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `sec_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Disclosure Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `venture_working_interest_status` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `venture_working_interest_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `wi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `farmout_id` SET TAGS ('dbx_business_glossary_term' = 'Farmout Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Block Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Farminee Partner ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `farmout_farmor_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Farmor Partner ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `tract_id` SET TAGS ('dbx_business_glossary_term' = 'Tract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `ami_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Area of Mutual Interest (AMI) Expiration Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `area_of_mutual_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Area of Mutual Interest (AMI) Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `back_in_right_flag` SET TAGS ('dbx_business_glossary_term' = 'Back-In Right Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `back_in_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Back-In Trigger Event');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `back_in_wi_percent` SET TAGS ('dbx_business_glossary_term' = 'Back-In Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `carry_obligation_amount` SET TAGS ('dbx_business_glossary_term' = 'Carry Obligation Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `carry_obligation_currency` SET TAGS ('dbx_business_glossary_term' = 'Carry Obligation Currency');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `carry_obligation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `cash_consideration_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Consideration Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `cash_consideration_currency` SET TAGS ('dbx_business_glossary_term' = 'Cash Consideration Currency');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `cash_consideration_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `earn_in_condition` SET TAGS ('dbx_business_glossary_term' = 'Earn-In Condition');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `earn_in_status` SET TAGS ('dbx_business_glossary_term' = 'Earn-In Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `earn_in_status` SET TAGS ('dbx_value_regex' = 'not-started|in-progress|completed|failed');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `non_consent_penalty_factor` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Penalty Factor');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `non_consent_penalty_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Penalty Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `nri_transferred_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Transferred Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `operator_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Consent Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `preferential_right_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferential Right Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not-required|conditional');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `sec_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Disclosure Required Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'draft|pending|executed|closed|cancelled|terminated');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'farm-in|farm-out');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `wi_transferred_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Transferred Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `work_program_commitment` SET TAGS ('dbx_business_glossary_term' = 'Work Program Commitment');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `work_program_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Work Program Deadline Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `work_program_wells_count` SET TAGS ('dbx_business_glossary_term' = 'Work Program Wells Count');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `venture_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `operating_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Entity ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `actual_cost_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost to Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `afe_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `afe_type` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `afe_type` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX|Drilling|Workover|Facility|Seismic');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `approval_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Deadline Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `authorization_level` SET TAGS ('dbx_value_regex' = 'Field|Regional|Corporate|Board');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `billing_method` SET TAGS ('dbx_business_glossary_term' = 'Billing Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `billing_method` SET TAGS ('dbx_value_regex' = 'Actual|Estimate|Turnkey');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `contingency_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `non_consent_election_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Election Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `operator_estimate_amount` SET TAGS ('dbx_business_glossary_term' = 'Operator Estimate Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `overhead_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Overhead Rate Percent');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `supplemental_afe_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplemental Authorization for Expenditure (AFE) Required Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `total_approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `variance_explanation` SET TAGS ('dbx_business_glossary_term' = 'Variance Explanation');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `work_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Work Completion Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `work_program_description` SET TAGS ('dbx_business_glossary_term' = 'Work Program Description');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `work_start_date` SET TAGS ('dbx_business_glossary_term' = 'Work Start Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `afe_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Approval Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Partner Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `venture_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `approval_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Approval Document Reference');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `approval_method` SET TAGS ('dbx_business_glossary_term' = 'Approval Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `approval_method` SET TAGS ('dbx_value_regex' = 'email|portal|fax|mail|verbal|meeting');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending|conditionally_approved|non_consent');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `approved_amount_currency` SET TAGS ('dbx_business_glossary_term' = 'Approved Amount Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `approved_amount_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `cash_call_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Issued Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `conditions_attached` SET TAGS ('dbx_business_glossary_term' = 'Approval Conditions');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `deemed_consent_applied` SET TAGS ('dbx_business_glossary_term' = 'Deemed Consent Applied Indicator');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|first_reminder|second_reminder|final_notice|deemed_consent_pending|legal_review');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `non_consent_election` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Election Indicator');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `partner_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Partner Share Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `rejection_category` SET TAGS ('dbx_business_glossary_term' = 'Rejection Category');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `rejection_category` SET TAGS ('dbx_value_regex' = 'cost_excessive|technical_risk|strategic_misalignment|procedural_deficiency|budget_constraint|scope_unclear');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `response_overdue_flag` SET TAGS ('dbx_business_glossary_term' = 'Response Overdue Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `voting_threshold_met` SET TAGS ('dbx_business_glossary_term' = 'Voting Threshold Met Indicator');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Jib Statement Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Block Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Partner Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `copas_billing_code` SET TAGS ('dbx_business_glossary_term' = 'Council of Petroleum Accountants Societies (COPAS) Billing Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `dispute_amount` SET TAGS ('dbx_business_glossary_term' = 'Dispute Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `netting_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Netting Eligible Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `sap_jva_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Joint Venture Accounting (JVA) Document Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Issue Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_value_regex' = 'draft|issued|disputed|approved|paid|cancelled');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Statement Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_value_regex' = 'original|revised|supplemental|final|adjustment');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `total_joint_account_costs` SET TAGS ('dbx_business_glossary_term' = 'Total Joint Account Costs');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `total_overhead_charges` SET TAGS ('dbx_business_glossary_term' = 'Total Overhead Charges');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `total_prior_period_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Total Prior Period Adjustments');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `total_statement_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Statement Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `jib_line_id` SET TAGS ('dbx_business_glossary_term' = 'Jib Line Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Partner Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `venture_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'PENDING|APPROVED|REJECTED|REQUIRES_REVIEW');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `cost_description` SET TAGS ('dbx_business_glossary_term' = 'Cost Description');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `cost_recovery_limit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Limit Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'UNDISPUTED|DISPUTED|UNDER_REVIEW|RESOLVED|ADJUSTED');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `is_capital_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Is Capital Expenditure (CAPEX) Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `is_recoverable` SET TAGS ('dbx_business_glossary_term' = 'Is Recoverable Cost Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `is_tangible` SET TAGS ('dbx_business_glossary_term' = 'Is Tangible Cost Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `overhead_amount` SET TAGS ('dbx_business_glossary_term' = 'Overhead Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `overhead_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overhead Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `partner_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Partner Net Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'UNPAID|PARTIALLY_PAID|PAID|OVERDUE|WRITTEN_OFF');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `service_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period End Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `service_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period Start Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `cash_call_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Block Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `venture_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `cash_call_number` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `cash_call_status` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `cash_call_status` SET TAGS ('dbx_value_regex' = 'draft|issued|partially_paid|fully_paid|overdue|cancelled');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `default_interest_accrued` SET TAGS ('dbx_business_glossary_term' = 'Default Interest Accrued');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `default_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Default Interest Rate');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `expenditure_category` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Category');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `expenditure_description` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Description');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Issue Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `operator_bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Operator Bank Account Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `operator_bank_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `operator_bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `operator_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Bank Name');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `operator_bank_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `operator_bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Operator Bank Routing Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `operator_bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `payment_instructions` SET TAGS ('dbx_business_glossary_term' = 'Payment Instructions');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|discrepancy|adjusted');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `total_amount_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Outstanding');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `total_amount_received` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Received');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `total_call_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Cash Call Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `cash_call_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Payment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `cash_call_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Partner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `bank_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Reference Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `called_amount` SET TAGS ('dbx_business_glossary_term' = 'Called Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `called_currency` SET TAGS ('dbx_business_glossary_term' = 'Called Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `called_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `days_late` SET TAGS ('dbx_business_glossary_term' = 'Days Late');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `default_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Default Interest Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `default_interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Default Interest Rate');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `gl_document_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Document Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `late_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `netting_amount` SET TAGS ('dbx_business_glossary_term' = 'Netting Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `netting_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Netting Applied Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `paying_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Paying Bank Name');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `payment_amount_base_currency` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount in Base Currency');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `payment_confirmation_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Confirmation Sent Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `payment_currency` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `payment_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|electronic_funds_transfer|letter_of_credit|offset');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `receiving_bank_account` SET TAGS ('dbx_business_glossary_term' = 'Receiving Bank Account Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `receiving_bank_account` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `reconciled_by` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|variance_under_review|underpaid|overpaid|disputed');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Variance Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `cost_recovery_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `actual_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Block Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Jib Statement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `monthly_production_id` SET TAGS ('dbx_business_glossary_term' = 'Monthly Production Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|disputed|adjusted');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `ceiling_limit` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Ceiling Limit');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `ceiling_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Ceiling Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `ceiling_utilized` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Ceiling Utilized');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `contractor_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Contractor Share Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `cost_category` SET TAGS ('dbx_value_regex' = 'exploration|development|operating|abandonment|general_administrative');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `cost_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Cost Subcategory');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `costs_incurred_period` SET TAGS ('dbx_business_glossary_term' = 'Costs Incurred in Period');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `costs_recovered_period` SET TAGS ('dbx_business_glossary_term' = 'Costs Recovered in Period');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `depreciation_amount_period` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Amount in Period');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|unit_of_production|declining_balance|none');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `dispute_amount` SET TAGS ('dbx_business_glossary_term' = 'Dispute Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `government_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Government Share Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Priority');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `production_tier` SET TAGS ('dbx_business_glossary_term' = 'Production Tier');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `profit_oil_split_contractor` SET TAGS ('dbx_business_glossary_term' = 'Profit Oil Split Contractor Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `profit_oil_split_government` SET TAGS ('dbx_business_glossary_term' = 'Profit Oil Split Government Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `r_factor` SET TAGS ('dbx_business_glossary_term' = 'R-Factor');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `ring_fencing_entity` SET TAGS ('dbx_business_glossary_term' = 'Ring Fencing Entity');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `ring_fencing_rule` SET TAGS ('dbx_business_glossary_term' = 'Ring Fencing Rule');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `ring_fencing_rule` SET TAGS ('dbx_value_regex' = 'field_level|block_level|contract_level|consolidated');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `sec_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Disclosure Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `unrecovered_cost_balance_closing` SET TAGS ('dbx_business_glossary_term' = 'Unrecovered Cost Balance Closing');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `unrecovered_cost_balance_opening` SET TAGS ('dbx_business_glossary_term' = 'Unrecovered Cost Balance Opening');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `uplift_amount_period` SET TAGS ('dbx_business_glossary_term' = 'Uplift Amount in Period');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `uplift_rate` SET TAGS ('dbx_business_glossary_term' = 'Uplift Rate');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `profit_oil_split_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Oil Split Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `cost_recovery_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `monthly_production_id` SET TAGS ('dbx_business_glossary_term' = 'Monthly Production Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'r_factor|production_tier|hybrid|fixed_split');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `calculation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Period End Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `calculation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Period Start Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `calculation_status` SET TAGS ('dbx_business_glossary_term' = 'Calculation Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `calculation_status` SET TAGS ('dbx_value_regex' = 'draft|preliminary|final|revised|approved|disputed');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `contractor_entitlement_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Contractor Entitlement Gas Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `contractor_entitlement_oil_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Contractor Entitlement Oil Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `contractor_profit_gas_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Contractor Profit Gas Share Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `contractor_profit_oil_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Contractor Profit Oil Share Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `cost_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Cost Gas Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `cost_oil_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Cost Oil Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `cost_recovery_limit_percent` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Limit Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `cumulative_cost_recovery_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Cost Recovery Amount in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `cumulative_cost_recovery_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `cumulative_revenue_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Revenue Amount in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `cumulative_revenue_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `fiscal_regime_type` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Regime Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `fiscal_regime_type` SET TAGS ('dbx_value_regex' = 'production_sharing|service_contract|concession|risk_service');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `government_entitlement_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Government Entitlement Gas Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `government_entitlement_oil_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Government Entitlement Oil Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `government_profit_gas_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Government Profit Gas Share Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `government_profit_oil_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Government Profit Oil Share Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `production_tier` SET TAGS ('dbx_business_glossary_term' = 'Production Tier');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `production_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|tier_6');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `profit_gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Profit Gas Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `profit_oil_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Profit Oil Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `r_factor` SET TAGS ('dbx_business_glossary_term' = 'R-Factor');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `total_gas_production_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Total Gas Production Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `total_oil_production_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Total Oil Production Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `total_production_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Total Production Volume in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `unrecovered_cost_balance_usd` SET TAGS ('dbx_business_glossary_term' = 'Unrecovered Cost Balance in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `unrecovered_cost_balance_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `lifting_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Entitlement Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Export Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `production_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Production Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `actual_lifted_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Actual Lifted Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `actual_lifted_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Actual Lifted Volume in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `actual_lifted_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Actual Lifted Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `cargo_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Cargo Reference Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `cumulative_imbalance_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Imbalance Value in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `cumulative_imbalance_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Imbalance Volume in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `entitlement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Period End Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `entitlement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Period Start Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `entitlement_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `entitlement_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Volume in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `entitlement_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `imbalance_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Imbalance Value in United States Dollars (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `imbalance_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Imbalance Volume in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `lifting_date` SET TAGS ('dbx_business_glossary_term' = 'Lifting Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `lifting_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Lifting Reference Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `measurement_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Measurement Ticket Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `net_revenue_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `opening_imbalance_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Opening Imbalance Volume in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `quality_adjustment_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Quality Adjustment Volume in Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `quality_specification_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Met Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `reference_price_per_boe` SET TAGS ('dbx_business_glossary_term' = 'Reference Price per Barrels of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `settlement_election` SET TAGS ('dbx_business_glossary_term' = 'Settlement Election');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `settlement_election` SET TAGS ('dbx_value_regex' = 'in_kind|in_value');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'in_kind|in_value|cash_out|carry_forward');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|settled|disputed');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'pipeline|tanker|truck|rail|barge');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `overlift_underlift_id` SET TAGS ('dbx_business_glossary_term' = 'Overlift Underlift Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Jib Statement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `lifting_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Entitlement Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `actual_lifted_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Actual Lifted Volume Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'entitlement|working_interest|psa_formula|custom');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `closing_balance_boe` SET TAGS ('dbx_business_glossary_term' = 'Closing Balance Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `current_period_variance_boe` SET TAGS ('dbx_business_glossary_term' = 'Current Period Variance Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `entitled_volume_boe` SET TAGS ('dbx_business_glossary_term' = 'Entitled Volume Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `imbalance_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Imbalance Period End Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `imbalance_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Imbalance Period Start Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `imbalance_status` SET TAGS ('dbx_business_glossary_term' = 'Imbalance Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `imbalance_status` SET TAGS ('dbx_value_regex' = 'overlift|underlift|balanced|pending_settlement|settled|disputed');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `imbalance_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Imbalance Value United States Dollar (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `nri_percentage` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `opening_balance_boe` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `price_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Price Index Reference');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `reference_price_per_boe` SET TAGS ('dbx_business_glossary_term' = 'Reference Price Per Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `settlement_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Completion Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `settlement_due_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Due Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'in_kind|cash|hybrid|not_applicable');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `tolerance_threshold_boe` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Threshold Barrel of Oil Equivalent (BOE)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `tolerance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Threshold Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` SET TAGS ('dbx_subdomain' = 'capital_planning');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `jv_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Budget Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `block_id` SET TAGS ('dbx_business_glossary_term' = 'Block Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `operating_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `operating_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operating License Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `reservoir_id` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `abandonment_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Budget (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `afe_reference_list` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Reference List');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `budget_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget End Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `budget_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Start Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'annual|multi_year|supplemental|emergency|afe_specific');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `capex_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Budget (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Budget Comments');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `completion_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Completion Budget (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `contingency_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Contingency Amount (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `contingency_pct` SET TAGS ('dbx_business_glossary_term' = 'Contingency Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `drilling_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Drilling Budget (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `facilities_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Facilities Budget (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `hse_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Budget (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `non_operator_share_usd` SET TAGS ('dbx_business_glossary_term' = 'Non-Operator Share (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `operating_committee_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Approval Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `operator_share_usd` SET TAGS ('dbx_business_glossary_term' = 'Operator Share (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `operator_wi_pct` SET TAGS ('dbx_business_glossary_term' = 'Operator Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `opex_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX) Budget (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `overhead_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Overhead Allocation Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `overhead_allocation_method` SET TAGS ('dbx_value_regex' = 'fixed_rate|percentage|actual_cost|copas_standard');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `overhead_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Overhead Budget (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `overhead_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Overhead Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `production_operations_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Production Operations Budget (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `total_gross_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Budget (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `work_program_description` SET TAGS ('dbx_business_glossary_term' = 'Work Program Description');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` SET TAGS ('dbx_subdomain' = 'joint_governance');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `operating_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee (OpCom) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `partner_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `tertiary_operating_chairperson_party_venture_partner_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `afe_approval_authority_usd` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Authorization for Expenditure (AFE) Approval Authority USD');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `chairperson_rotation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Chairperson Rotation Frequency');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `chairperson_rotation_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|fixed|rotating');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `committee_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `committee_name` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Name');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `confidentiality_requirement` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Confidentiality Requirement');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `decision_authority_scope` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Decision Authority Scope');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Dispute Resolution Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|litigation|expert_determination');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Dissolution Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `establishment_date` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Establishment Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Governing Law');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `last_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Last Meeting Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Meeting Frequency');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annually|annually|as-needed');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Meeting Location');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `minutes_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Minutes Retention Years');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Record Modified By');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `next_scheduled_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Next Scheduled Meeting Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Meeting Notice Period Days');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `operating_committee_status` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `operating_committee_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|dissolved');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `proxy_voting_allowed` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Proxy Voting Allowed');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `quorum_requirement_pct` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Quorum Requirement Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Source System');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Source System ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `total_member_count` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Total Member Count');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `virtual_meeting_allowed` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Virtual Meeting Allowed');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `voting_basis` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Voting Basis');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `voting_basis` SET TAGS ('dbx_value_regex' = 'working_interest|one_vote_per_party|hybrid');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `voting_threshold_ordinary_pct` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Voting Threshold for Ordinary Resolutions Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `voting_threshold_special_pct` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Voting Threshold for Special Resolutions Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Record Created By');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` SET TAGS ('dbx_subdomain' = 'financial_settlement');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `carried_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Facility Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `farmout_id` SET TAGS ('dbx_business_glossary_term' = 'Farmout Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `pipeline_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Partner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `accrued_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `back_in_right_flag` SET TAGS ('dbx_business_glossary_term' = 'Back-In Right Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `back_in_wi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Back-In Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `carried_interest_status` SET TAGS ('dbx_business_glossary_term' = 'Carry Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `carried_interest_status` SET TAGS ('dbx_value_regex' = 'active|suspended|completed|terminated|defaulted');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `carried_wi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Carried Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `carry_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Carry Agreement Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `carry_amount_limit` SET TAGS ('dbx_business_glossary_term' = 'Carry Amount Limit');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `carry_phase` SET TAGS ('dbx_business_glossary_term' = 'Carry Phase');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `carry_phase` SET TAGS ('dbx_value_regex' = 'exploration|appraisal|development|drilling|completion');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `carry_type` SET TAGS ('dbx_business_glossary_term' = 'Carry Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `carry_type` SET TAGS ('dbx_value_regex' = 'full|partial|casing_point|production');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `cumulative_carried_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Carried Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `cumulative_recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Recovered Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `default_provision` SET TAGS ('dbx_business_glossary_term' = 'Default Provision');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `forfeiture_provision` SET TAGS ('dbx_business_glossary_term' = 'Forfeiture Provision');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `interest_accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `interest_accrual_method` SET TAGS ('dbx_value_regex' = 'simple|compound|none');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `interest_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `outstanding_carry_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Carry Balance');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `payout_date` SET TAGS ('dbx_business_glossary_term' = 'Payout Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `payout_status` SET TAGS ('dbx_business_glossary_term' = 'Payout Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `payout_status` SET TAGS ('dbx_value_regex' = 'pre_payout|in_payout|post_payout|suspended');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `recovery_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Recovery Mechanism');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `recovery_mechanism` SET TAGS ('dbx_value_regex' = 'gross_revenue|net_revenue|production_volume|cost_allocation');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `recovery_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Recovery Multiplier');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `recovery_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recovery Rate Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `reversion_nri_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reversion Net Revenue Interest (NRI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `reversion_wi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reversion Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `sec_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Disclosure Required Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` SET TAGS ('dbx_subdomain' = 'joint_governance');
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` ALTER COLUMN `parent_joint_venture_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` SET TAGS ('dbx_subdomain' = 'joint_governance');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` SET TAGS ('dbx_association_edges' = 'venture.partner,venture.operating_committee');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `operating_committee_member_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Member - Operating Committee Member Id');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `operating_committee_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `operating_committee_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `operating_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Member - Operating Committee Id');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Member - Partner Id');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `member_role` SET TAGS ('dbx_business_glossary_term' = 'Member Role');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `member_wi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Member Working Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `membership_end_date` SET TAGS ('dbx_business_glossary_term' = 'Membership End Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `membership_start_date` SET TAGS ('dbx_business_glossary_term' = 'Membership Start Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `proxy_designation` SET TAGS ('dbx_business_glossary_term' = 'Proxy Designation');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `representative_email` SET TAGS ('dbx_business_glossary_term' = 'Representative Email');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `representative_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `representative_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `representative_name` SET TAGS ('dbx_business_glossary_term' = 'Representative Name');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee_member` ALTER COLUMN `voting_rights_percentage` SET TAGS ('dbx_business_glossary_term' = 'Voting Rights Percentage');
