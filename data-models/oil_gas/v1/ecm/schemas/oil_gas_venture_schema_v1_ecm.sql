-- Schema for Domain: venture | Business: Oil Gas | Version: v1_ecm
-- Generated on: 2026-05-04 05:08:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `oil_gas_ecm`.`venture` COMMENT 'Manages joint operating agreements (JOA), production sharing agreements (PSA), farm-in/farm-out arrangements, and partner relationships. Owns partner equity positions, working interest registers, AFE approvals, joint interest billing (JIB), cost recovery tracking, profit oil/gas splits, partner netting, and cash call management. Supports COPAS accounting standards and SEC partner disclosure. Integrates with SAP Joint Venture Accounting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`joa` (
    `joa_id` BIGINT COMMENT 'Unique identifier for the Joint Operating Agreement record.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to venture.agreement_type. Business justification: joa currently has joa_type as STRING attribute. This should be normalized to FK relationship with agreement_type reference table. The agreement_type table contains type_code, type_name, and detailed m',
    `asset_facility_id` BIGINT COMMENT 'Identifier of the primary asset, field, or facility governed by the Joint Operating Agreement.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: JOAs require regulatory approval filings with state/federal agencies at execution and amendment. Operators must submit JOA terms for regulatory review in most jurisdictions, particularly for offshore ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: JOAs are primary cost accounting structures in joint ventures; each JOA maps to cost centers for GL posting, budget tracking, and monthly JIB allocation. Essential for SAP CO integration and partner c',
    `partner_id` BIGINT COMMENT 'FK to venture.partner',
    `joa_venture_partner_id` BIGINT COMMENT 'Identifier of the party designated as the operator responsible for day-to-day operations under the Joint Operating Agreement.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: JOAs govern joint operations on specific leased acreage. Operators need lease terms, royalty burdens, and expiry dates for AFE planning, cash call allocation, and compliance with lease obligations.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: JOAs require designated operator representative employee for day-to-day operational coordination, AFE approvals, and operating committee liaison. Critical for approval authority tracking and operation',
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
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to venture.agreement_type. Business justification: psa currently has psa_type as STRING attribute. This should be normalized to FK relationship with agreement_type reference table. The agreement_type table is designed to classify ALL venture agreement',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: PSAs are government contracts requiring extensive regulatory submissions for approval, amendments, work program approvals, and periodic compliance reporting to host country petroleum ministries and re',
    `compliance_sec_reserves_disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.sec_reserves_disclosure. Business justification: PSA contract terms (cost recovery ceiling, profit oil split, contractor entitlement) directly determine SEC reserve disclosures and standardized measure calculations. SEC filings must reference PSA te',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PSAs require dedicated cost centers for cost recovery tracking, contractor/government split accounting, and cost recovery ceiling monitoring. Critical for PSA fiscal regime compliance and government a',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PSAs require designated operator representative employee for government liaison, regulatory compliance reporting, and cost recovery submissions. Essential for tracking accountability in host country r',
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
    `commercial_counterparty_id` BIGINT COMMENT 'FK to customer.counterparty.counterparty_id — MUST-HAVE: Enables linking JV partners to the enterprise counterparty master for credit risk, KYC, and sanctions screening. Without this FK, compliance cannot verify that JV partners pass sanctions sc',
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
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Working interest allocations must be disclosed in SEC 10-K reserve filings, state regulatory filings, and PSA reporting. Changes in working interest trigger regulatory disclosure requirements under se',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Working interest positions drive partner-specific cost allocation; each WI position maps to cost centers for SAP JVA partner share tracking, billing allocation, and working interest percentage-based c',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement governing this working interest position.',
    `partner_id` BIGINT COMMENT 'Reference to the joint venture partner holding this working interest position.',
    `psa_id` BIGINT COMMENT 'Reference to the Production Sharing Agreement governing this working interest position, if applicable.',
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
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Farm-in/farm-out transactions require regulatory approval from state oil and gas commissions, federal agencies (BOEM/BSEE for offshore), and host governments under PSAs. Regulatory filing tracks appro',
    `partner_id` BIGINT COMMENT 'Reference to the partner acquiring the working interest in a farm-in transaction (the incoming party).',
    `farmout_farmor_partner_id` BIGINT COMMENT 'Reference to the partner divesting the working interest in a farm-out transaction (the outgoing party).',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this farm-in/farm-out transaction is executed.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Farm-in/out transactions transfer working interests in specific leases. Lease_id defines transaction scope, acreage transferred, and post-transaction interest calculations for division orders and reve',
    `property_id` BIGINT COMMENT 'Reference to the oil and gas property or lease subject to the farm-in/farm-out transaction.',
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
    `dc_program_id` BIGINT COMMENT 'Foreign key linking to drilling.dc_program. Business justification: JV partners approve funding for multi-well drilling programs (not just individual wells). venture_afe tracks partner approvals and cost allocation for entire campaigns. Links JV authorization (venture',
    `finance_afe_id` BIGINT COMMENT 'Foreign key linking to finance.finance_afe. Business justification: Venture AFEs (joint venture operational view) must reconcile to finance AFEs (GL capitalization view) for AFE cost variance analysis, budget-to-actual reporting, and capital vs. expense classification',
    `joa_id` BIGINT COMMENT 'Foreign key reference to the Joint Operating Agreement under which this AFE is issued. The JOA governs partner rights, obligations, and approval thresholds for expenditures.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: AFEs authorize capital and operating expenditures on specific leases. Lease-level cost tracking is essential for JIB allocation, partner billing, and lease-level profitability analysis.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: AFEs for drilling, completion, and facility operations require permits (APD, air quality, water discharge, ROW). Linking AFE to permit enables tracking of permit compliance for authorized work program',
    `property_id` BIGINT COMMENT 'Foreign key reference to the oil and gas property or lease where the work program will be executed. Links the AFE to the specific asset or field.',
    `partner_id` BIGINT COMMENT 'Foreign key reference to the legal entity acting as operator for this AFE. The operator is responsible for executing the work program and billing partners per their working interest.',
    `well_asset_id` BIGINT COMMENT 'Foreign key reference to the specific well if the AFE is for well-related activities (drilling, completion, workover, plug and abandonment). Null for non-well AFEs such as facility construction or seismic surveys.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: AFE approvals require tracking which specific employee approved on behalf of partner for audit trail, authorization verification, and compliance. Existing approver_name/title/email are denormalized em',
    `drilling_afe_id` BIGINT COMMENT 'Reference to the parent AFE document for which this approval response was submitted. Links this approval record to the specific capital or operating expenditure authorization being voted on by joint venture partners.',
    `partner_id` BIGINT COMMENT 'Reference to the joint venture partner entity submitting this approval or rejection response. Identifies which working interest owner or revenue interest holder is providing consent or objection to the proposed expenditure.',
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
    `partner_working_interest` DECIMAL(18,2) COMMENT 'The partners working interest percentage in the joint venture at the time of AFE approval. Expressed as a decimal (e.g., 0.250000 for 25%). Used to calculate the partners proportionate share of AFE costs and to determine voting thresholds per JOA provisions.',
    `rejection_category` STRING COMMENT 'Standardized classification of the rejection reason for reporting and trend analysis. Enables operator to identify common objection patterns and improve AFE quality.. Valid values are `cost_excessive|technical_risk|strategic_misalignment|procedural_deficiency|budget_constraint|scope_unclear`',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the partner for rejecting the AFE or electing non-consent. May include technical concerns, cost objections, strategic misalignment, or procedural issues. Null if status is approved or pending.',
    `response_due_date` DATE COMMENT 'The deadline date by which the partner must submit their approval or rejection response per JOA provisions. Used to track overdue responses and trigger escalation procedures for non-responsive partners.',
    `response_overdue_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the partners response is overdue based on the response due date. True if current date exceeds due date and status is still pending; false otherwise. Triggers escalation and deemed-consent evaluation per JOA.',
    `voting_threshold_met` BOOLEAN COMMENT 'Boolean flag indicating whether the cumulative working interest of all approving partners (including this approval) meets or exceeds the JOA-mandated voting threshold for this AFE type. True if threshold is met; false otherwise. Calculated field updated as approvals are received.',
    CONSTRAINT pk_afe_approval PRIMARY KEY(`afe_approval_id`)
) COMMENT 'Tracks each partners individual approval or rejection response to an AFE. Captures partner reference, approval status (approved, rejected, pending, conditionally approved), approved amount, rejection reason, approval date, approver name, and any conditions attached. Enables operator to track consent thresholds per JOA voting provisions and escalate non-responses. One record per partner per AFE.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`jib_statement` (
    `jib_statement_id` BIGINT COMMENT 'Primary key for jib_statement',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: JIB statement approvals require employee-level tracking for audit trail, authorization verification, and COPAS compliance. The existing approved_by text field is denormalized and should be replaced wi',
    `asset_facility_id` BIGINT COMMENT 'Reference to the specific facility to which the costs in this Joint Interest Billing statement are attributed, if applicable.',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this billing statement is issued.',
    `partner_id` BIGINT COMMENT 'Reference to the operating partner issuing this Joint Interest Billing statement.',
    `regulatory_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_audit. Business justification: JIB statements under PSAs are subject to government cost audits to verify cost recovery compliance. Host governments audit JIB charges to ensure only allowable costs are recovered, making this link es',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: JIB statements are subject to SOX controls for joint venture billing accuracy, cost allocation, and revenue recognition. SOX controls verify JIB statement completeness, accuracy, and timely submission',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Individual JIB line item approvals require employee tracking for cost control, dispute resolution, and audit trail. Critical for tracking who authorized specific charges in joint venture billing.',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility (production platform, processing plant, pipeline, storage terminal) to which this cost is allocated. Supports facility-level cost tracking and asset management.',
    `compliance_audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Individual JIB line items are flagged in regulatory audits as non-compliant, non-recoverable, or improperly allocated costs. Linking line items to audit findings enables corrective action tracking and',
    `jib_statement_id` BIGINT COMMENT 'Reference to the parent JIB statement that contains this line item. Links the line to the header-level billing document issued to joint venture partners.',
    `journal_entry_line_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry_line. Business justification: Individual JIB line items map to journal entry lines for detailed GL account posting, cost center allocation, and audit trail from JV billing to financial statements. Required for COPAS billing reconc',
    `lease_id` BIGINT COMMENT 'Reference to the lease or concession area to which this cost is allocated. Enables lease-level profitability analysis and regulatory reporting.',
    `partner_id` BIGINT COMMENT 'Reference to the specific joint venture partner being billed for this line item. Each JIB statement may have multiple line items for different partners based on their working interest.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: JIB line items for product-related costs (storage, handling, quality testing, blending) require product linkage. Business process: Product-specific cost allocation in JIBs, partner billing for product',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or service provider who performed the work or supplied the goods. Enables tracking of vendor performance and cost analysis by supplier.',
    `well_asset_id` BIGINT COMMENT 'Reference to the specific well to which this cost is allocated. Enables well-level cost tracking and economic analysis for drilling and production operations.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of any adjustment made to the original charge due to dispute resolution, correction, or revision. Positive values represent additional charges; negative values represent credits.',
    `adjustment_reason` STRING COMMENT 'Explanation for any adjustment made to the line item. Provides audit trail for billing corrections and dispute resolutions.',
    `approval_date` DATE COMMENT 'Date this charge was approved for billing to partners. Used for audit trail and compliance with internal control procedures.',
    `approval_status` STRING COMMENT 'Internal approval status of this charge before billing to partners. Values include pending approval (PENDING), approved for billing (APPROVED), rejected (REJECTED), or requires additional review (REQUIRES_REVIEW).. Valid values are `PENDING|APPROVED|REJECTED|REQUIRES_REVIEW`',
    `cost_category_code` STRING COMMENT 'Classification of the cost type according to COPAS standards. Categories include drilling (DRILL), completion (COMPL), production (PROD), facilities (FACIL), geological and geophysical (GEOL), land and lease (LAND), overhead (OVHD), general and administrative (GA), plug and abandonment (PLUG), workover (WORKOV), seismic (SEISMIC), and other (OTHER). [ENUM-REF-CANDIDATE: DRILL|COMPL|PROD|FACIL|GEOL|LAND|OVHD|GA|PLUG|WORKOV|SEISMIC|OTHER — 12 candidates stripped; promote to reference product]',
    `cost_center_code` STRING COMMENT 'Cost center code for internal cost allocation and management reporting. Supports organizational profitability analysis and budget tracking.',
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
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Cash calls from operator to non-operators create AP obligations for payment processing, aging tracking, and cash flow forecasting. Essential for working capital management and partner payment reconcil',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Cash calls are issued against AFE budgets to fund joint operations. Links enable partners to verify calls against approved budgets, track committed vs. called amounts, and manage working capital.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cash call issuance requires tracking which employee created it for accountability, authorization verification, and partner communication. Essential for dispute resolution and audit trail in joint vent',
    `drilling_afe_id` BIGINT COMMENT 'Reference to the AFE that authorizes the expenditures covered by this cash call.',
    `joa_id` BIGINT COMMENT 'Reference to the joint operating agreement under which this cash call is issued.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Cash calls fund operations on specific leases. Lease context is required for partner billing based on working interest, tracking lease-level capital commitments, and reconciling AFE spend to lease.',
    `sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Cash calls are financial transactions subject to SOX controls for revenue recognition, partner receivables, and joint venture accounting. SOX controls verify cash call calculation accuracy, approval, ',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PSA cost recovery audits require tracking auditor employee for regulatory compliance, audit trail, and government reporting. Essential for host country audit requirements and dispute resolution.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: PSA cost recovery tracks recoverable costs by lease/concession. Lease_id enables ring-fencing compliance, cost pool allocation, and audit trail linking recovered costs to specific lease expenditures.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: PSA cost recovery is tracked by petroleum product category (oil vs gas) with different recovery limits. Business process: Product-level cost recovery ceiling application, government audits by product ',
    `psa_id` BIGINT COMMENT 'Foreign key reference to the production sharing agreement under which cost recovery is tracked.',
    `regulatory_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_audit. Business justification: Cost recovery under PSAs is subject to mandatory government audits to verify compliance with contract terms, cost recovery ceilings, and allowable cost definitions. Audit results directly impact cost ',
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
    `jib_reference_number` STRING COMMENT 'The JIB invoice or statement number that reported the costs incurred in this period. Provides audit trail to partner billing.',
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
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Profit oil calculations must be reported to host governments for royalty and tax purposes, and disclosed in SEC filings for material PSA contracts. Regulatory filing tracks submission of profit oil st',
    `field_id` BIGINT COMMENT 'Reference to the oil and gas field or development area to which this profit oil split calculation applies.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Profit oil calculations are performed separately by petroleum product type (oil vs gas) with different split terms. Business process: PSA profit oil allocation by product, government entitlement by pr',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit oil entitlements are tracked by profit center for contractor revenue recognition, segment reporting, and profitability analysis. Critical for PSA revenue booking and SEC reserve disclosure.',
    `psa_id` BIGINT COMMENT 'Reference to the production sharing agreement under which this profit oil split is calculated.',
    `partner_id` BIGINT COMMENT 'Reference to the operating company responsible for calculating and reporting this profit oil split under the joint operating agreement (JOA).',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`partner_netting` (
    `partner_netting_id` BIGINT COMMENT 'Unique identifier for the partner netting transaction record.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who approved the netting transaction.',
    `intercompany_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.intercompany_transaction. Business justification: Partner netting creates intercompany transactions between legal entities for consolidated financial statement elimination, transfer pricing documentation, and intercompany reconciliation. Required for',
    `joa_id` BIGINT COMMENT 'Identifier of the Joint Operating Agreement under which this netting transaction is executed.',
    `partner_id` BIGINT COMMENT 'Identifier of the non-operating partner involved in this netting transaction.',
    `actual_settlement_date` DATE COMMENT 'The actual date on which the net settlement payment was received or made, if different from the scheduled settlement date.',
    `approval_date` DATE COMMENT 'The date on which the netting transaction was approved by the authorized approver.',
    `bank_account_reference` STRING COMMENT 'Reference to the bank account used for settlement payment (masked or tokenized for security).',
    `cash_call_count` STRING COMMENT 'Number of cash calls included in this netting transaction.',
    `counterparty_settlement_risk_score` DECIMAL(18,2) COMMENT 'Risk score (0-100) assessing the counterparty settlement risk for this partner at the time of netting, used for credit and liquidity management.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the netting transaction record was first created in the system.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the netting transaction is under dispute by the partner (True) or not (False).',
    `dispute_reason` STRING COMMENT 'Description of the reason for dispute if the dispute flag is set to True.',
    `dispute_resolution_date` DATE COMMENT 'The date on which the dispute was resolved, if applicable.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied if currency conversion was required for the netting transaction.',
    `exchange_rate_date` DATE COMMENT 'The date on which the exchange rate was determined for currency conversion.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year in which the netting transaction was recorded.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the netting transaction was recorded.',
    `gross_payable_amount` DECIMAL(18,2) COMMENT 'Total amount payable to the partner before netting, aggregated across all Joint Interest Billing (JIB) statements, cash calls, royalty obligations, and lifting settlements for the period.',
    `gross_receivable_amount` DECIMAL(18,2) COMMENT 'Total amount receivable from the partner before netting, aggregated across all Joint Interest Billing (JIB) statements, cash calls, and lifting settlements for the period.',
    `jib_statement_count` STRING COMMENT 'Number of Joint Interest Billing (JIB) statements included in this netting transaction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the netting transaction record was last updated.',
    `lifting_settlement_count` STRING COMMENT 'Number of lifting settlements (crude oil or natural gas offtake settlements) included in this netting transaction.',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'The net amount to be settled after offsetting gross receivables and gross payables. Positive values indicate net receivable from partner; negative values indicate net payable to partner.',
    `netting_agreement_reference` STRING COMMENT 'Reference to the contractual netting agreement or clause within the Joint Operating Agreement (JOA) or Production Sharing Agreement (PSA) that authorizes this netting arrangement.',
    `netting_document_number` STRING COMMENT 'The unique document number assigned to this netting transaction in SAP Joint Venture Accounting (JVA) or the source system.',
    `netting_method` STRING COMMENT 'The method used to perform the netting: bilateral (two-party), multilateral (multiple parties), automatic (system-generated), or manual (operator-initiated).. Valid values are `bilateral|multilateral|automatic|manual`',
    `netting_period_end_date` DATE COMMENT 'The end date of the period covered by this netting transaction.',
    `netting_period_start_date` DATE COMMENT 'The start date of the period covered by this netting transaction.',
    `netting_status` STRING COMMENT 'Current lifecycle status of the netting transaction indicating its approval and settlement state.. Valid values are `draft|pending_approval|approved|settled|cancelled|disputed`',
    `payment_method` STRING COMMENT 'The method by which the net settlement amount will be or was paid.. Valid values are `wire_transfer|ach|check|offset|intercompany_transfer`',
    `remarks` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the netting transaction.',
    `royalty_obligation_count` STRING COMMENT 'Number of royalty obligations included in this netting transaction.',
    `sap_jva_posting_document_number` STRING COMMENT 'The SAP JVA document number generated when the netting transaction was posted to the financial ledger.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the netting settlement is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'The date on which the net settlement amount is due or was paid.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which the netting transaction was originated (e.g., SAP_JVA for SAP Joint Venture Accounting, QUORUM for Quorum Land System).. Valid values are `SAP_JVA|QUORUM|LEGACY_JV|MANUAL`',
    CONSTRAINT pk_partner_netting PRIMARY KEY(`partner_netting_id`)
) COMMENT 'Records partner netting transactions where offsetting receivables and payables between the operator and a non-operating partner across JIB statements, cash calls, royalty obligations, and lifting settlements are netted to a single settlement amount per period. Captures netting period, gross receivable, gross payable, net settlement amount, netting agreement reference, settlement currency, settlement date, and SAP JVA netting document number. Reduces cash movement volume and counterparty settlement risk across the joint venture.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` (
    `lifting_entitlement_id` BIGINT COMMENT 'Unique identifier for the lifting entitlement record. Primary key for the lifting entitlement entity.',
    `field_id` BIGINT COMMENT 'Reference to the oil or gas field from which the lifting entitlement originates.',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this lifting entitlement is governed.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Lifting entitlements are calculated from production on specific leases. Lease_id ties entitlement volumes to source property, enabling accurate partner allocation and royalty burden deduction.',
    `partner_id` BIGINT COMMENT 'Reference to the joint venture partner who holds this lifting entitlement.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Partner lifting entitlements are for specific petroleum products (crude, condensate, LNG). Business process: Partner crude/product lifting schedules, entitlement balancing by product type, imbalance t',
    `psa_id` BIGINT COMMENT 'Reference to the Production Sharing Agreement under which this lifting entitlement is governed. Nullable if governed by JOA instead.',
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
    `lifting_point_location` STRING COMMENT 'The physical location or facility where the product was lifted, such as a terminal, platform, or pipeline delivery point.',
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
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this imbalance is tracked.',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Overlift/underlift imbalances are tracked by specific petroleum product. Business process: Partner imbalance settlement by product type, product-specific tolerance thresholds, imbalance valuation usin',
    `partner_id` BIGINT COMMENT 'Reference to the joint venture partner who holds this overlift or underlift position.',
    `psa_id` BIGINT COMMENT 'Reference to the Production Sharing Agreement under which this imbalance is tracked, if applicable.',
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
    `jib_reference_number` STRING COMMENT 'The reference number of the Joint Interest Billing statement that includes this imbalance position for partner invoicing and netting.',
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
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Joint venture budgets feed into corporate budgets for annual planning, capital allocation, and budget-to-actual variance analysis. Essential for consolidated budget preparation and operating committee',
    `joa_id` BIGINT COMMENT 'Reference to the joint operating agreement or production sharing agreement that this budget supports.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: JV budgets allocate capital and operating spend across leases. Lease-level budget tracking is required for variance analysis, AFE reconciliation, and lease-level profitability reporting.',
    `opcom_meeting_id` BIGINT COMMENT 'Reference identifier for the operating committee meeting at which this budget was reviewed and approved, enabling traceability to meeting minutes and resolutions.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: JV budget submissions require tracking submitting employee for approval workflow, accountability, and operating committee review. Critical for tracking budget preparation responsibility and approval c',
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
    `partner_id` BIGINT COMMENT 'Reference to the partner party currently serving as chairperson of the Operating Committee. The chairperson typically facilitates meetings, sets agendas, and ensures procedural compliance.',
    `quaternary_operating_partner_id` BIGINT COMMENT 'FK to venture.partner',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` (
    `opcom_meeting_id` BIGINT COMMENT 'Unique identifier for the Operating Committee meeting record. Primary key for the opcom_meeting product.',
    `partner_id` BIGINT COMMENT 'Reference to the partner entity that served as chairperson for this Operating Committee meeting.',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this Operating Committee meeting is convened. Links the meeting to the governing JOA framework.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Operating committee meetings require designated secretary employee for minutes preparation, records management, and resolution tracking. Critical for JOA governance and legal compliance with meeting d',
    `action_items_count` STRING COMMENT 'The total number of action items assigned during the Operating Committee meeting that require follow-up by partners or the operator.',
    `afe_approvals_count` STRING COMMENT 'The number of Authorization for Expenditure (AFE) proposals that were approved during this Operating Committee meeting.',
    `agenda_document_reference` STRING COMMENT 'Reference identifier or file path to the formal agenda document distributed prior to or at the meeting.',
    `agenda_summary` STRING COMMENT 'High-level summary of the key agenda items and topics discussed during the Operating Committee meeting.',
    `attendees_summary` STRING COMMENT 'High-level summary of partners and representatives who attended the Operating Committee meeting, including attendance mode (in-person, virtual).',
    `budget_approved_flag` BOOLEAN COMMENT 'Boolean indicator of whether an annual or project budget was approved during this Operating Committee meeting.',
    `chairperson_name` STRING COMMENT 'Full name of the individual who chaired the Operating Committee meeting. Classified as restricted personal identifiable information.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the Operating Committee meeting record was first created in the system.',
    `meeting_date` DATE COMMENT 'The calendar date on which the Operating Committee meeting was held or is scheduled to be held.',
    `meeting_end_time` TIMESTAMP COMMENT 'The precise timestamp when the Operating Committee meeting concluded, including time zone information.',
    `meeting_location` STRING COMMENT 'Physical location or virtual platform where the Operating Committee meeting was held (e.g., Houston Office, Microsoft Teams, Zoom).',
    `meeting_location_address` STRING COMMENT 'Full street address of the physical meeting location, if applicable. Classified as confidential organizational contact data.',
    `meeting_location_city` STRING COMMENT 'City where the Operating Committee meeting was held.',
    `meeting_location_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the meeting location (e.g., USA, GBR, NOR).. Valid values are `^[A-Z]{3}$`',
    `meeting_number` STRING COMMENT 'Business identifier for the Operating Committee meeting, typically sequential or formatted per JOA convention (e.g., OPCOM-2024-001).',
    `meeting_start_time` TIMESTAMP COMMENT 'The precise timestamp when the Operating Committee meeting commenced, including time zone information.',
    `meeting_status` STRING COMMENT 'Current lifecycle status of the Operating Committee meeting: scheduled for future date, in progress during the meeting, completed with minutes finalized, cancelled before occurrence, postponed to a later date, or adjourned without completion.. Valid values are `scheduled|in_progress|completed|cancelled|postponed|adjourned`',
    `meeting_type` STRING COMMENT 'Classification of the meeting type: regular scheduled meetings, special meetings called for specific purposes, emergency meetings for urgent matters, annual meetings, or extraordinary meetings per JOA provisions.. Valid values are `regular|special|emergency|annual|extraordinary`',
    `minutes_approved_date` DATE COMMENT 'The date on which the meeting minutes were formally approved by the Operating Committee.',
    `minutes_approved_flag` BOOLEAN COMMENT 'Boolean indicator of whether the meeting minutes have been formally reviewed and approved by the Operating Committee members.',
    `minutes_document_reference` STRING COMMENT 'Reference identifier or file path to the official meeting minutes document that records discussions, decisions, and action items.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the Operating Committee meeting record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the Operating Committee meeting record was last modified in the system.',
    `next_meeting_scheduled_date` DATE COMMENT 'The scheduled date for the next Operating Committee meeting, if determined during this meeting.',
    `notes` STRING COMMENT 'Additional notes, observations, or context related to the Operating Committee meeting that do not fit into structured fields.',
    `operator_change_flag` BOOLEAN COMMENT 'Boolean indicator of whether a change of operator was discussed or approved during this Operating Committee meeting.',
    `quorum_achieved_flag` BOOLEAN COMMENT 'Boolean indicator of whether the required quorum of partners (as defined in the JOA) was present to conduct official business and pass binding resolutions.',
    `quorum_threshold_pct` DECIMAL(18,2) COMMENT 'The minimum percentage of working interest or voting rights required to achieve quorum for this meeting, as specified in the JOA.',
    `resolutions_passed_count` STRING COMMENT 'The total number of formal resolutions that were passed during the Operating Committee meeting.',
    `source_system` STRING COMMENT 'Name of the source system from which the Operating Committee meeting record originated (e.g., SAP Joint Venture Accounting, SharePoint).',
    `source_system_code` STRING COMMENT 'Unique identifier of the Operating Committee meeting record in the source system, used for traceability and reconciliation.',
    `total_voting_interest_represented_pct` DECIMAL(18,2) COMMENT 'The aggregate percentage of working interest or voting rights represented by partners present or voting at the meeting.',
    `work_program_modified_flag` BOOLEAN COMMENT 'Boolean indicator of whether modifications to the joint venture work program were approved during this Operating Committee meeting.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the Operating Committee meeting record in the system.',
    CONSTRAINT pk_opcom_meeting PRIMARY KEY(`opcom_meeting_id`)
) COMMENT 'Records each Operating Committee meeting including meeting date, location, agenda items, quorum achieved flag, resolutions passed, voting results per partner, minutes reference, and action items. Provides the audit trail for partner governance decisions including AFE approvals, budget adoptions, operator changes, and work program modifications.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`carried_interest` (
    `carried_interest_id` BIGINT COMMENT 'Unique identifier for the carried interest arrangement. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Carried interest arrangements track costs against specific AFE budgets for recovery calculations and payout determination. Essential for farmout economics and partner cost recovery in oil-and-gas join',
    `drilling_afe_id` BIGINT COMMENT 'Reference to the AFE document that authorizes the expenditures covered by this carried interest arrangement.',
    `joa_id` BIGINT COMMENT 'Reference to the joint operating agreement under which this carried interest arrangement is established.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Carry agreements are tied to specific lease interests. Lease_id defines the scope of carry, enables tracking of carried costs by lease, and determines reversion working interest upon payout.',
    `partner_id` BIGINT COMMENT 'Reference to the partner who is funding the carried partys share of costs during the carry period.',
    `psa_id` BIGINT COMMENT 'Reference to the production sharing agreement if this carried interest is part of a PSA structure. Nullable for JOA-only arrangements.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Carried interest tracking requires WBS elements for cost accumulation, recovery monitoring, and payout calculation. Critical for farmout economics tracking and carried party cost recovery reporting.',
    `well_asset_id` BIGINT COMMENT 'Reference to the specific asset (well, field, lease, or facility) to which this carried interest arrangement applies.',
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

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`state_participation` (
    `state_participation_id` BIGINT COMMENT 'Unique identifier for the state participation record. Primary key.',
    `concession_id` BIGINT COMMENT 'Reference to the concession agreement under which this state participation is granted, if applicable.',
    `psa_id` BIGINT COMMENT 'Reference to the production sharing agreement under which this state participation is granted.',
    `afe_approval_required_flag` BOOLEAN COMMENT 'Indicates whether the state participation interest holder has AFE approval rights and must approve expenditures above a threshold. True if approval rights exist, False otherwise.',
    `afe_approval_threshold_usd` DECIMAL(18,2) COMMENT 'The minimum AFE amount (in USD) that requires approval from the state participation interest holder. Null if no approval rights or no threshold applies.',
    `back_in_right_flag` BOOLEAN COMMENT 'Indicates whether this participation is a back-in right (True) or an immediate participation (False). Back-in rights allow the government to acquire interest after a discovery or milestone.',
    `carried_through_phase` STRING COMMENT 'The project phase through which the state participation interest is carried (i.e., costs borne by other partners): exploration, appraisal, development, production, full field life, or none if not a carried interest.. Valid values are `exploration|appraisal|development|production|full field life|none`',
    `cash_call_obligation_flag` BOOLEAN COMMENT 'Indicates whether the state participation interest is subject to cash call obligations for ongoing capital and operating expenditures. True if the state must fund its proportionate share, False if carried or exempt.',
    `consideration_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the consideration amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `consideration_paid_amount` DECIMAL(18,2) COMMENT 'The monetary consideration paid by the host government to acquire the participation interest, if any. Zero for free carry or back-in rights with no payment obligation.',
    `cost_recovery_eligible_flag` BOOLEAN COMMENT 'Indicates whether the state participation interest is eligible to recover historical exploration and development costs from cost oil/gas under the PSA. True if eligible, False if the state enters with no cost recovery rights (typical for free carry).',
    `cost_recovery_limit_usd` DECIMAL(18,2) COMMENT 'The maximum cumulative amount of historical costs that the state may recover from its share of cost oil/gas, expressed in USD. Null if no limit applies or if cost recovery is not permitted.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this state participation record was first created in the system.',
    `effective_date` DATE COMMENT 'The date from which the state participation becomes effective for cost recovery, entitlement, and revenue sharing purposes.',
    `entitlement_calculation_method` STRING COMMENT 'The method used to calculate the states production entitlement under this participation: working interest (proportionate share of gross production), profit oil split (share of profit oil/gas after cost recovery), net revenue interest (share of net revenue), hybrid (combination of methods), or other.. Valid values are `working interest|profit oil split|net revenue interest|hybrid|other`',
    `exercise_date` DATE COMMENT 'The date on which the host government formally exercised its participation right by notifying the operator or consortium.',
    `exercise_deadline_date` DATE COMMENT 'The contractual deadline by which the host government must notify the operator of its intent to exercise the participation right. Null if no deadline applies.',
    `exercise_trigger_event` STRING COMMENT 'The contractual event or milestone that enables or requires the host government to exercise its participation right: commercial discovery, final investment decision (FID), first production, development plan approval, reserves booking, field declaration, production threshold, or cumulative production milestone. [ENUM-REF-CANDIDATE: commercial discovery|final investment decision|first production|development plan approval|reserves booking|field declaration|production threshold|cumulative production milestone — 8 candidates stripped; promote to reference product]',
    `expiry_date` DATE COMMENT 'The date on which the state participation arrangement expires or terminates, if applicable. Null for indefinite participation.',
    `host_government_entity_code` BIGINT COMMENT 'Reference to the host government or National Oil Company (NOC) exercising the participation right.',
    `modified_by` STRING COMMENT 'The user ID or name of the person who last modified this state participation record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this state participation record was last modified in the system.',
    `non_consent_option_available_flag` BOOLEAN COMMENT 'Indicates whether the state participation interest holder has the right to elect non-consent on discretionary operations under the JOA. True if non-consent is available, False if the state must participate in all approved operations.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or clarifications regarding the state participation arrangement.',
    `operator_consent_date` DATE COMMENT 'The date on which the operator or JOA partners formally consented to the state participation, if consent was required.',
    `operator_consent_required_flag` BOOLEAN COMMENT 'Indicates whether the operator or other JOA partners must consent to the state exercising its participation right. True if consent is required, False if the right is automatic upon exercise.',
    `participation_number` STRING COMMENT 'Business identifier for the state participation arrangement, typically assigned by the operator or regulatory authority.',
    `participation_percentage` DECIMAL(18,2) COMMENT 'The percentage of working interest that the host government or NOC holds or may acquire under this participation arrangement. Expressed as a decimal (e.g., 15.000000 for 15%).',
    `participation_status` STRING COMMENT 'Current lifecycle status of the state participation: pending (right exists but not yet exercised), exercised (government has elected to participate), active (participation is in effect), expired (option period lapsed), waived (government declined to exercise), or terminated (participation ended).. Valid values are `pending|exercised|active|expired|waived|terminated`',
    `participation_type` STRING COMMENT 'Classification of the state participation mechanism: back-in right (government option to acquire interest post-discovery), free carry (government interest with no cost obligation), paid participation (government pays proportionate share), carried interest (costs recovered from production), state equity (direct ownership), or royalty participation (in-kind royalty converted to equity).. Valid values are `back-in right|free carry|paid participation|carried interest|state equity|royalty participation`',
    `profit_gas_split_percentage` DECIMAL(18,2) COMMENT 'The percentage of profit gas allocated to the state under this participation arrangement, if different from the standard PSA profit gas split. Null if standard PSA terms apply.',
    `profit_oil_split_percentage` DECIMAL(18,2) COMMENT 'The percentage of profit oil allocated to the state under this participation arrangement, if different from the standard PSA profit oil split. Null if standard PSA terms apply.',
    `regulatory_approval_date` DATE COMMENT 'The date on which the relevant regulatory authority approved the state participation, if approval was required.',
    `regulatory_approval_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory or ministerial approval is required to formalize the state participation. True if approval is required, False if the participation is self-executing under the PSA.',
    `reversion_trigger_event` STRING COMMENT 'The event that triggers reversion of additional working interest to the state: payout, cumulative production milestone, contract expiry, field abandonment, reserves depletion, or none if no reversion applies.. Valid values are `payout|cumulative production|contract expiry|field abandonment|reserves depletion|none`',
    `reversion_wi_percentage` DECIMAL(18,2) COMMENT 'The working interest percentage that reverts to the state after payout or at a specified milestone, if applicable. Null if no reversion clause exists.',
    `sec_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether this state participation arrangement must be disclosed in SEC filings due to materiality or impact on reserves and entitlements. True if disclosure is required, False otherwise.',
    `termination_date` DATE COMMENT 'The date on which the state participation was terminated, if applicable. Null if the participation is still active or pending.',
    `termination_reason` STRING COMMENT 'Free-text explanation of why the state participation was terminated (e.g., contract expiry, government waiver, field abandonment, regulatory change).',
    `trigger_date` DATE COMMENT 'The date on which the trigger event occurred, initiating the governments right or obligation to participate.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this state participation record.',
    CONSTRAINT pk_state_participation PRIMARY KEY(`state_participation_id`)
) COMMENT 'Tracks the host government or NOCs back-in or carried participation rights under a PSA or concession agreement. Captures participation type (back-in right, free carry, paid participation), participation percentage, exercise trigger (discovery, FID, production), exercise date, consideration paid, and current participation status. Supports PSA entitlement calculations and SEC disclosure of government participation terms.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` (
    `royalty_obligation_id` BIGINT COMMENT 'Primary key for royalty_obligation',
    `asset_facility_id` BIGINT COMMENT 'Reference to the producing asset (well, field, or facility) from which this royalty obligation is derived.',
    `joa_id` BIGINT COMMENT 'Reference to the joint operating agreement under which this royalty obligation is established.',
    `lease_id` BIGINT COMMENT 'Reference to the mineral lease or land lease under which this royalty obligation is owed.',
    `partner_id` BIGINT COMMENT 'Reference to the venture partner or external party to whom the royalty is owed.',
    `psa_id` BIGINT COMMENT 'Reference to the production sharing agreement governing this royalty obligation, if applicable.',
    `royalty_owner_id` BIGINT COMMENT 'Foreign key linking to land.royalty_owner. Business justification: Venture-level royalty obligations (overriding royalties, net profits interests) are paid to specific royalty owners. Royalty_owner_id enables payment processing, 1099 reporting, and suspense account m',
    `commodity_type` STRING COMMENT 'The hydrocarbon commodity to which this royalty obligation applies: crude oil, natural gas, natural gas liquids (NGL), condensate, or all hydrocarbons.. Valid values are `crude_oil|natural_gas|ngl|condensate|all_hydrocarbons`',
    `cost_recovery_limit_amount` DECIMAL(18,2) COMMENT 'Maximum cumulative cost recovery amount before royalty rate changes or payout is achieved, if stipulated in PSA or JOA.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty obligation record was first created in the system.',
    `cumulative_royalty_paid_amount` DECIMAL(18,2) COMMENT 'Total cumulative royalty amount paid to the payee since the effective date of this obligation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which royalty payments are denominated (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `deduction_allowed_flag` BOOLEAN COMMENT 'Indicates whether post-production costs (transportation, processing, compression) may be deducted before calculating royalty (True/False).',
    `deduction_type` STRING COMMENT 'Description of allowable deductions: transportation costs, processing fees, compression charges, marketing expenses, or none if gross royalty.',
    `effective_date` DATE COMMENT 'Date on which this royalty obligation becomes effective and royalty accrual begins.',
    `expiry_date` DATE COMMENT 'Date on which this royalty obligation terminates or expires. Null for perpetual obligations.',
    `interest_rate_late_payment_pct` DECIMAL(18,2) COMMENT 'Annual interest rate applied to late or overdue royalty payments, expressed as a percentage.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent royalty payment made to the payee.',
    `last_payment_date` DATE COMMENT 'Date of the most recent royalty payment made to the payee.',
    `minimum_royalty_amount` DECIMAL(18,2) COMMENT 'Minimum royalty payment amount per period, regardless of production volume, if stipulated in the agreement.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty obligation record was last modified.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or clarifications regarding this royalty obligation.',
    `payee_tax_code` STRING COMMENT 'Tax identification number of the payee for IRS 1099 reporting and withholding compliance.',
    `payment_frequency` STRING COMMENT 'Frequency at which royalty payments are made to the payee: monthly, quarterly, semi-annual, annual, or upon sale of production.. Valid values are `monthly|quarterly|semi_annual|annual|upon_sale`',
    `payment_terms_days` STRING COMMENT 'Number of days after the end of the production period within which royalty payment is due.',
    `payout_date` DATE COMMENT 'Date on which payout was achieved and the royalty rate changed, if applicable.',
    `payout_status` STRING COMMENT 'Indicates whether the obligation is subject to payout provisions and current payout state: not applicable (no payout clause), pre-payout (costs not yet recovered), or post-payout (costs recovered, full royalty rate applies).. Valid values are `not_applicable|pre_payout|post_payout`',
    `production_basis` STRING COMMENT 'Defines whether royalty is calculated on gross production (before any deductions), net production (after operating costs), working interest share, or net revenue interest share.. Valid values are `gross_production|net_production|working_interest_share|net_revenue_interest_share`',
    `royalty_obligation_number` STRING COMMENT 'Business identifier for the royalty obligation, used for external communication and reporting.',
    `royalty_obligation_status` STRING COMMENT 'Current lifecycle status of the royalty obligation: active (accruing and payable), suspended (temporarily halted), terminated (ended), pending approval (awaiting contract execution), disputed (under legal review), or paid out (obligation fully satisfied).. Valid values are `active|suspended|terminated|pending_approval|disputed|paid_out`',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Fixed royalty rate expressed as a percentage of production value or volume. Null if sliding scale or tiered structure applies.',
    `royalty_subtype` STRING COMMENT 'Further classification or variant of the royalty type, capturing jurisdiction-specific or contract-specific nuances.',
    `royalty_type` STRING COMMENT 'Classification of the royalty obligation. Gross overriding royalty interest (ORRI) is paid from gross production before costs; net profits interest (NPI) is paid after cost recovery; government royalty is owed to state or federal authorities; landowner royalty is owed to mineral rights owners; production payment is a fixed-volume or fixed-value obligation; carried interest royalty is owed when a carried party begins paying.. Valid values are `gross_overriding|net_profits_interest|government_royalty|landowner_royalty|production_payment|carried_interest_royalty`',
    `sap_jva_document_number` STRING COMMENT 'SAP Joint Venture Accounting system document number for this royalty obligation, used for integration and reconciliation.',
    `sec_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether this royalty obligation must be disclosed in SEC filings due to materiality or partner relationship (True/False).',
    `sliding_scale_basis` STRING COMMENT 'The metric on which the sliding scale royalty rate is calculated: production volume thresholds, commodity price tiers, cumulative recovery milestones, or time-based phases.. Valid values are `production_volume|commodity_price|cumulative_recovery|time_based`',
    `sliding_scale_flag` BOOLEAN COMMENT 'Indicates whether the royalty rate varies based on production volume, price, or cumulative recovery (True/False).',
    `suspension_reason` STRING COMMENT 'Explanation for suspension of royalty payments: production shut-in, force majeure, payee dispute, regulatory hold, or other cause.',
    `termination_date` DATE COMMENT 'Actual date on which the royalty obligation was terminated, if applicable.',
    `termination_reason` STRING COMMENT 'Reason for termination of the royalty obligation: lease expiration, asset abandonment, buyout, mutual agreement, or contract breach.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this record.',
    CONSTRAINT pk_royalty_obligation PRIMARY KEY(`royalty_obligation_id`)
) COMMENT 'Master record for royalty obligations owed to mineral rights owners, governments, or overriding royalty interest holders under lease, JOA, or PSA terms. Captures royalty type (gross overriding, net profits interest, government royalty), royalty rate or sliding scale tiers, production basis (gross/net), payment frequency, payee details, and applicable deductions. Distinct from the land domains lease royalty — this entity tracks the venture-level royalty obligation and payment status.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`royalty_payment` (
    `royalty_payment_id` BIGINT COMMENT 'Primary key for royalty_payment',
    `joa_id` BIGINT COMMENT 'Reference to the joint operating agreement under which this royalty payment is made.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Royalty payments generate journal entries for expense recognition, accrual posting, and financial statement preparation. Required for monthly royalty accrual, payment reconciliation, and SEC disclosur',
    `petroleum_product_id` BIGINT COMMENT 'Foreign key linking to product.petroleum_product. Business justification: Royalty payments are calculated on specific petroleum products with product-specific rates. Business process: Product-based royalty rate application, government revenue reporting by product type, leas',
    `property_id` BIGINT COMMENT 'Reference to the oil and gas property or lease from which production generated this royalty payment.',
    `psa_id` BIGINT COMMENT 'Reference to the production sharing agreement governing this royalty payment, if applicable.',
    `royalty_owner_id` BIGINT COMMENT 'Reference to the royalty interest holder receiving this payment. May be a mineral rights owner, landowner, or overriding royalty interest (ORRI) holder.',
    `partner_id` BIGINT COMMENT 'Reference to the operating company responsible for making this royalty payment on behalf of the working interest owners.',
    `well_asset_id` BIGINT COMMENT 'Reference to the specific well asset that produced the hydrocarbons generating this royalty payment.',
    `ad_valorem_tax` DECIMAL(18,2) COMMENT 'The amount of ad valorem (property) tax withheld from the royalty payment, if the royalty owner is responsible for their proportionate share of property taxes.',
    `check_number` STRING COMMENT 'The check number if the payment method was check. Null for electronic payment methods.',
    `compression_deduction` DECIMAL(18,2) COMMENT 'The amount deducted from gross production value to cover the cost of compressing natural gas for transportation, if allowed under the lease terms.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this royalty payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this royalty payment record (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `division_order_number` STRING COMMENT 'Reference to the division order that establishes the royalty owners decimal interest and payment instructions for this property.',
    `gas_price_per_mcf` DECIMAL(18,2) COMMENT 'The realized price per thousand cubic feet of natural gas used to calculate the gross value of gas production for royalty purposes.',
    `gas_volume_mcf` DECIMAL(18,2) COMMENT 'The volume of natural gas produced during the production month that is subject to this royalty payment, measured in thousand cubic feet.',
    `gathering_deduction` DECIMAL(18,2) COMMENT 'The amount deducted from gross production value to cover the cost of gathering hydrocarbons from multiple wells to a central facility, if allowed under the lease terms.',
    `gross_production_value` DECIMAL(18,2) COMMENT 'The total value of oil, gas, and NGL production before any deductions. Calculated as the sum of (volume × price) for each product type.',
    `interest_amount` DECIMAL(18,2) COMMENT 'The amount of interest paid to the royalty owner for late payment, if the payment was made after the contractual due date and interest is required by statute or lease terms.',
    `interest_rate_percent` DECIMAL(18,2) COMMENT 'The annual interest rate applied to calculate late payment interest, expressed as a percentage.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this royalty payment record was last modified in the system.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The final net amount disbursed to the royalty owner after all deductions and tax withholdings have been applied to the royalty amount.',
    `net_royalty_value` DECIMAL(18,2) COMMENT 'The net value subject to royalty calculation after all allowable deductions have been applied to the gross production value.',
    `ngl_price_per_bbl` DECIMAL(18,2) COMMENT 'The realized price per barrel of natural gas liquids used to calculate the gross value of NGL production for royalty purposes.',
    `ngl_volume_bbl` DECIMAL(18,2) COMMENT 'The volume of natural gas liquids produced during the production month that is subject to this royalty payment, measured in barrels.',
    `oil_price_per_bbl` DECIMAL(18,2) COMMENT 'The realized price per barrel of oil used to calculate the gross value of oil production for royalty purposes. May be based on posted price, index price, or actual sales price.',
    `oil_volume_bbl` DECIMAL(18,2) COMMENT 'The volume of crude oil produced during the production month that is subject to this royalty payment, measured in barrels.',
    `other_tax_withholding` DECIMAL(18,2) COMMENT 'Any other tax amounts withheld from the royalty payment, such as federal or state income tax withholding for non-resident royalty owners.',
    `payment_date` DATE COMMENT 'The date on which the royalty payment was disbursed to the royalty owner.',
    `payment_due_date` DATE COMMENT 'The contractual date by which the royalty payment must be disbursed to avoid late payment penalties or interest charges.',
    `payment_method` STRING COMMENT 'The method by which the royalty payment was disbursed to the royalty owner.. Valid values are `check|wire_transfer|ach|direct_deposit|suspense`',
    `payment_number` STRING COMMENT 'Unique business identifier for this royalty payment transaction, typically assigned by the operator or joint venture accounting system.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the royalty payment transaction.. Valid values are `pending|approved|disbursed|cancelled|suspended|reconciled`',
    `processing_deduction` DECIMAL(18,2) COMMENT 'The amount deducted from gross production value to cover the cost of processing raw natural gas or treating crude oil, if allowed under the lease terms.',
    `production_month` DATE COMMENT 'The calendar month for which production volumes are being paid. Royalty payments are typically made one or two months in arrears of production.',
    `royalty_amount` DECIMAL(18,2) COMMENT 'The calculated royalty payment amount due to the royalty owner, computed as net royalty value multiplied by the royalty interest decimal.',
    `royalty_interest_decimal` DECIMAL(18,2) COMMENT 'The decimal fraction representing the royalty owners share of production, expressed as a decimal (e.g., 0.125 for 12.5% or 1/8th royalty).',
    `severance_tax` DECIMAL(18,2) COMMENT 'The amount of state or local severance tax withheld from the royalty payment, if the royalty owner is responsible for their proportionate share of production taxes.',
    `suspense_flag` BOOLEAN COMMENT 'Indicates whether this royalty payment is being held in suspense due to title issues, missing owner information, or other administrative holds.',
    `suspense_reason` STRING COMMENT 'Explanation of why the royalty payment is being held in suspense, if the suspense flag is true.',
    `total_deductions` DECIMAL(18,2) COMMENT 'The sum of all allowable deductions (transportation, processing, compression, gathering, and other) applied to the gross production value before calculating the net royalty amount.',
    `transportation_deduction` DECIMAL(18,2) COMMENT 'The amount deducted from gross production value to cover the cost of transporting hydrocarbons from the wellhead to the point of sale, if allowed under the lease terms.',
    `wire_reference_number` STRING COMMENT 'The wire transfer or ACH reference number if the payment method was electronic. Null for check payments.',
    CONSTRAINT pk_royalty_payment PRIMARY KEY(`royalty_payment_id`)
) COMMENT 'Transactional record of each royalty payment disbursed to a royalty interest holder. Captures payment period, production volume basis, gross value, royalty rate applied, deductions (transportation, processing), net royalty amount, payment date, check/wire reference, and payee confirmation. Supports COPAS accounting standards and SEC royalty disclosure requirements.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`jv_audit` (
    `jv_audit_id` BIGINT COMMENT 'Unique identifier for the joint venture audit event. Primary key for the audit record.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: JV audit exceptions result in correcting journal entries for GL adjustment, partner credit/debit issuance, and financial statement restatement. Essential for audit resolution tracking and COPAS compli',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: JV audits examine AFE budget compliance, cost allocation accuracy, and overhead rate application. Links enable auditors to validate charges against approved budgets and identify exceptions for partner',
    `joa_id` BIGINT COMMENT 'Reference to the joint operating agreement under which this audit is conducted. Links to the governing JOA that defines audit rights and procedures.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: JV audits require tracking lead auditor employee for accountability, competency verification, and audit quality control. Essential for tracking auditor qualifications and audit trail in joint venture ',
    `partner_id` BIGINT COMMENT 'Reference to the non-operating partner entity initiating the audit per JOA audit rights provisions. The party exercising audit rights to verify operator charges.',
    `regulatory_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_audit. Business justification: Joint venture audits under PSAs often trigger or are triggered by government regulatory audits of cost recovery and compliance. Host governments use JV audit findings to verify operator compliance wit',
    `afe_count_examined` STRING COMMENT 'Number of individual AFEs whose charges were examined during the audit. Relevant for audits focused on capital project cost verification.',
    `agreed_adjustment_amount` DECIMAL(18,2) COMMENT 'Dollar value of audit exceptions accepted by the operator and agreed for adjustment. Represents the settled portion of audit findings that will result in billing corrections or credits.',
    `arbitration_case_number` STRING COMMENT 'Case or docket number assigned by the arbitration forum if disputed audit findings are escalated to formal arbitration per JOA dispute resolution provisions.',
    `audit_commencement_date` DATE COMMENT 'Date on which the audit fieldwork or examination of operator records officially began. Marks the start of the active audit phase.',
    `audit_completion_date` DATE COMMENT 'Date on which the audit fieldwork was completed and final findings were compiled. Marks the end of the examination phase before report issuance.',
    `audit_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred by the auditing partner to conduct the audit, including auditor fees, travel expenses, and internal resources. May be subject to cost sharing per JOA provisions.',
    `audit_notice_date` DATE COMMENT 'Date on which the auditing partner formally notified the operator of intent to conduct the audit, per JOA audit rights notification requirements.',
    `audit_number` STRING COMMENT 'Business identifier for the audit event, typically assigned by the auditing partner or operator for tracking and correspondence purposes.',
    `audit_period_end_date` DATE COMMENT 'Ending date of the accounting period under audit. Defines the end of the timeframe for which joint account charges are being reviewed.',
    `audit_period_start_date` DATE COMMENT 'Beginning date of the accounting period under audit. Defines the start of the timeframe for which joint account charges are being reviewed.',
    `audit_scope` STRING COMMENT 'Classification of the audit scope defining which cost categories are being examined. Determines whether the audit covers capital expenditures, operating expenses, overhead allocations, specific AFE charges, or the full joint account. [ENUM-REF-CANDIDATE: CAPEX|OPEX|overhead|AFE_specific|full_account|lease_operating_expense|drilling_costs|facilities_costs|G&A_allocation — 9 candidates stripped; promote to reference product]',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit event. Tracks progression from planning through notice, fieldwork, reporting, settlement negotiation, and final closure or dispute escalation. [ENUM-REF-CANDIDATE: planned|notice_issued|fieldwork_in_progress|draft_report|final_report|settlement_pending|settled|disputed|closed — 9 candidates stripped; promote to reference product]',
    `audit_type` STRING COMMENT 'Classification of the audit nature. Routine audits are periodic reviews per JOA provisions; special audits address specific concerns; dispute-driven audits follow partner disagreements; compliance audits verify regulatory adherence.. Valid values are `routine|special|dispute_driven|compliance|pre_payout|post_payout`',
    `auditor_firm_name` STRING COMMENT 'Name of the independent auditing firm or internal audit team conducting the examination on behalf of the auditing partner.',
    `copas_compliance_flag` BOOLEAN COMMENT 'Indicator of whether the operator accounting practices were found to be in compliance with COPAS accounting guidelines and the JOA COPAS election.',
    `cost_recovery_method` STRING COMMENT 'Method by which audit costs are allocated between parties. Some JOAs require operator reimbursement if findings exceed a threshold; others place costs on the auditing partner.. Valid values are `auditing_partner_bears|operator_reimburses|proportional_to_findings|per_JOA_terms`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the system. Supports data lineage and audit trail requirements.',
    `credit_issue_date` DATE COMMENT 'Date on which the operator issued billing credits or refunds to the auditing partner for settled audit exceptions.',
    `credit_issued_amount` DECIMAL(18,2) COMMENT 'Total dollar value of credits issued by the operator to the auditing partner as a result of settled audit findings. Represents the actual financial adjustment resulting from the audit.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this audit record. Typically matches the JOA billing currency. [ENUM-REF-CANDIDATE: USD|CAD|GBP|EUR|AUD|NOK|BRL|MXN — 8 candidates stripped; promote to reference product]',
    `dispute_resolution_method` STRING COMMENT 'Method employed to resolve disputed audit findings when parties cannot reach agreement through direct negotiation. Typically defined in the JOA dispute resolution provisions.. Valid values are `negotiation|mediation|arbitration|litigation|operating_committee`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Dollar value of audit exceptions that remain in dispute after operator response and initial settlement discussions. Represents unresolved findings requiring further negotiation or arbitration.',
    `draft_report_date` DATE COMMENT 'Date on which the draft audit report was issued to the operator for review and response before finalization.',
    `exception_count` STRING COMMENT 'Total number of individual exceptions or questioned items identified during the audit. Provides a count of discrete findings regardless of dollar magnitude.',
    `final_report_date` DATE COMMENT 'Date on which the final audit report was issued, incorporating operator responses and auditor conclusions. Establishes the basis for settlement negotiations.',
    `findings_summary` STRING COMMENT 'High-level narrative summary of the audit findings, including key exception categories, material issues identified, and overall assessment of operator accounting practices.',
    `jib_statement_period_count` STRING COMMENT 'Number of JIB statement periods covered by the audit scope. Indicates the breadth of the audit examination across billing cycles.',
    `material_weakness_flag` BOOLEAN COMMENT 'Indicator of whether the audit identified material weaknesses in operator internal controls or accounting practices that could affect the reliability of joint account charges.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this audit record. Supports accountability and change tracking requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was last modified. Tracks updates to audit status, findings, or settlement information throughout the audit lifecycle.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the audit event, findings, settlement process, or special circumstances.',
    `operator_response_date` DATE COMMENT 'Date on which the operator formally responded to the draft audit report, providing explanations, supporting documentation, or acceptance of findings.',
    `operator_response_summary` STRING COMMENT 'Summary of the operators response to audit findings, including accepted exceptions, disputed items, and explanations for questioned charges.',
    `settlement_agreement_reference` STRING COMMENT 'Reference number or identifier for the formal settlement agreement documenting the resolution of audit findings and agreed adjustments.',
    `settlement_date` DATE COMMENT 'Date on which the audit findings were fully settled between the auditing partner and operator, either through agreement or formal dispute resolution.',
    `settlement_status` STRING COMMENT 'Current status of the settlement process for audit findings. Tracks whether exceptions are under negotiation, partially resolved, fully settled, or escalated to formal dispute resolution.. Valid values are `pending|negotiating|partially_settled|fully_settled|arbitration|litigation`',
    `total_charges_examined_amount` DECIMAL(18,2) COMMENT 'Total dollar value of operator charges examined during the audit period. Represents the gross amount of joint account billings under review.',
    `total_exceptions_amount` DECIMAL(18,2) COMMENT 'Total dollar value of charges identified as exceptions or questioned costs during the audit. Represents the aggregate amount of findings before operator response and negotiation.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this audit record in the system. Supports accountability and audit trail requirements.',
    CONSTRAINT pk_jv_audit PRIMARY KEY(`jv_audit_id`)
) COMMENT 'Records joint venture audit events initiated by non-operating partners to verify operators joint account charges per JOA audit rights provisions. Captures audit period, auditing partner, audit scope (CAPEX, OPEX, overhead), audit commencement date, findings summary, disputed amounts, agreed adjustments, and final settlement. Supports COPAS audit procedures and partner dispute resolution.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`default_notice` (
    `default_notice_id` BIGINT COMMENT 'Unique identifier for the default notice record. Primary key.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Default notices often relate to unpaid AFE obligations. Linking to AFE budget provides context for default amount, cure calculations, and forfeiture risk assessment in joint venture default scenarios.',
    `cash_call_id` BIGINT COMMENT 'Reference to the specific cash call that triggered the default, if applicable. Null for non-cash-call defaults.',
    `partner_id` BIGINT COMMENT 'Reference to the joint venture partner who is in default or non-performance under the JOA provisions.',
    `drilling_afe_id` BIGINT COMMENT 'Reference to the AFE related to the default, if the default involves AFE non-consent or work program failure.',
    `joa_id` BIGINT COMMENT 'Reference to the joint operating agreement under which this default notice is issued.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Partner defaults risk forfeiture of lease-level interests. Lease_id defines forfeiture scope, enables calculation of interests at risk, and supports division order amendments upon forfeiture.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Default notices require designated operator contact employee for partner communication, cure negotiation, and legal proceedings. Critical for tracking accountability in default resolution and forfeitu',
    `violation_id` BIGINT COMMENT 'Foreign key linking to compliance.violation. Business justification: Partner defaults on environmental or operational obligations can constitute regulatory violations. When a defaulting partner fails to fund remediation or compliance work, the operator may report viola',
    `accrued_interest_amount` DECIMAL(18,2) COMMENT 'Total interest accrued on the default amount from the original due date through the current date or cure date.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this default notice record was first created in the system.',
    `cure_amount_paid` DECIMAL(18,2) COMMENT 'Total amount paid by the defaulting partner to cure the default, including principal, interest, and any penalties.',
    `cure_date` DATE COMMENT 'Actual date on which the defaulting partner remedied the default by making payment, performing work, or otherwise satisfying the default obligation.',
    `cure_deadline_date` DATE COMMENT 'Final date by which the defaulting partner must cure the default to avoid forfeiture or other remedies as specified in the JOA.',
    `cure_period_days` STRING COMMENT 'Number of calendar days allowed under the JOA for the defaulting partner to remedy the default before forfeiture or other remedies may be pursued.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the default amount (e.g., USD, GBP, EUR).',
    `default_amount` DECIMAL(18,2) COMMENT 'Monetary value of the default obligation in the specified currency. For cash call defaults, this is the unpaid amount. For work program failures, this may represent the estimated cost of unperformed work.',
    `default_interest_rate_pct` DECIMAL(18,2) COMMENT 'Annual interest rate percentage applied to unpaid default amounts as specified in the JOA default provisions.',
    `default_notice_number` STRING COMMENT 'Externally-known unique business identifier for the default notice document, typically assigned by the operator.',
    `default_status` STRING COMMENT 'Current lifecycle status of the default notice. Notice issued indicates formal notice has been sent. Cure period active indicates partner has time remaining to remedy default. Cured indicates partner has remedied the default. Forfeited indicates partner interest has been forfeited per JOA provisions. Negotiated settlement indicates parties reached alternative resolution. Litigation indicates dispute escalated to legal proceedings. Withdrawn indicates notice was retracted by operator. [ENUM-REF-CANDIDATE: notice_issued|cure_period_active|cured|forfeited|negotiated_settlement|litigation|withdrawn — 7 candidates stripped; promote to reference product]',
    `default_type` STRING COMMENT 'Classification of the default event. Cash call non-payment indicates failure to remit funds by due date. AFE non-consent indicates partner elected not to participate in approved expenditure. Work program failure indicates failure to perform committed work obligations. Insurance non-compliance indicates failure to maintain required insurance coverage. Abandonment obligation failure indicates failure to fund plugging and abandonment obligations.. Valid values are `cash_call_non_payment|afe_non_consent|work_program_failure|insurance_non_compliance|abandonment_obligation_failure|other`',
    `forfeited_nri_pct` DECIMAL(18,2) COMMENT 'Actual percentage of net revenue interest forfeited from the defaulting partner as a result of uncured default.',
    `forfeited_wi_pct` DECIMAL(18,2) COMMENT 'Actual percentage of working interest forfeited from the defaulting partner as a result of uncured default.',
    `forfeiture_date` DATE COMMENT 'Date on which the defaulting partners working interest was formally forfeited to non-defaulting partners per JOA provisions.',
    `forfeiture_risk_flag` BOOLEAN COMMENT 'Indicates whether the defaulting partners working interest is at risk of forfeiture under JOA default provisions. True if forfeiture is possible, false otherwise.',
    `joa_default_clause_reference` STRING COMMENT 'Specific article, section, or clause number in the JOA that governs this default and the remedies being pursued.',
    `legal_action_flag` BOOLEAN COMMENT 'Indicates whether the default has escalated to formal legal proceedings, arbitration, or litigation. True if legal action initiated, false otherwise.',
    `legal_case_reference` STRING COMMENT 'Court case number, arbitration reference, or other legal proceeding identifier if the default has escalated to formal dispute resolution.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this default notice record in the system.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this default notice record was last modified or updated in the system.',
    `non_defaulting_partners_notified_flag` BOOLEAN COMMENT 'Indicates whether all non-defaulting partners have been formally notified of the default per JOA requirements. True if notified, false otherwise.',
    `notes` STRING COMMENT 'Free-text field for additional context, communications history, or special circumstances related to the default notice and resolution process.',
    `notice_delivery_method` STRING COMMENT 'Method by which the default notice was formally delivered to the defaulting partner as required by JOA notice provisions.. Valid values are `certified_mail|courier|email|hand_delivery|registered_post`',
    `notice_document_reference` STRING COMMENT 'Document management system reference or file path to the formal default notice letter or document sent to the defaulting partner.',
    `notice_issue_date` DATE COMMENT 'Date on which the formal default notice was issued to the defaulting partner by the operator.',
    `nri_at_risk_pct` DECIMAL(18,2) COMMENT 'Percentage of net revenue interest held by the defaulting partner that is subject to potential forfeiture if the default is not cured.',
    `opcom_review_date` DATE COMMENT 'Date on which the default was reviewed or is scheduled to be reviewed by the joint venture operating committee.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Total monetary amount agreed in the negotiated settlement, which may differ from the original default amount plus interest.',
    `settlement_date` DATE COMMENT 'Date on which a negotiated settlement agreement was reached between the operator and defaulting partner as an alternative to forfeiture.',
    `settlement_terms` STRING COMMENT 'Summary of the negotiated settlement terms agreed between parties, including payment schedules, interest concessions, or work program modifications.',
    `wi_at_risk_pct` DECIMAL(18,2) COMMENT 'Percentage of working interest held by the defaulting partner that is subject to potential forfeiture if the default is not cured.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this default notice record in the system.',
    CONSTRAINT pk_default_notice PRIMARY KEY(`default_notice_id`)
) COMMENT 'Records formal default notices issued to non-paying or non-performing partners under JOA default provisions. Captures defaulting partner, default type (cash call non-payment, AFE non-consent, work program failure), notice date, cure period, default amount, forfeiture risk, and resolution status. Tracks the full default lifecycle from notice through cure, forfeiture, or negotiated settlement.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`non_consent_election` (
    `non_consent_election_id` BIGINT COMMENT 'Unique identifier for the non-consent election record. Primary key for tracking a partners decision to go non-consent on a proposed Joint Operating Agreement (JOA) operation.',
    `afe_budget_id` BIGINT COMMENT 'Foreign key linking to procurement.afe_budget. Business justification: Non-consent elections reference the AFE budget being declined, essential for penalty calculations, recoupment tracking, and working interest adjustments. Core to JOA non-consent provisions and partner',
    `asset_facility_id` BIGINT COMMENT 'Reference to the facility asset associated with the non-consent operation, if applicable. Null for well-specific operations.',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Non-consent elections affecting working interests must be disclosed in SEC reserve filings when material. Changes in proved reserves due to non-consent forfeitures require regulatory disclosure under ',
    `drilling_afe_id` BIGINT COMMENT 'Reference to the AFE that triggered the non-consent election. The AFE describes the proposed operation (well, workover, facility) that the partner declined to participate in.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system account that approved the non-consent election record. Supports audit trail and governance requirements.',
    `joa_id` BIGINT COMMENT 'Reference to the Joint Operating Agreement under which this non-consent election is made. Links to the governing JOA that defines non-consent provisions and penalty terms.',
    `lease_id` BIGINT COMMENT 'Foreign key linking to land.lease. Business justification: Non-consent elections forfeit working interest in specific lease operations. Lease_id is core to penalty calculation, interest reversion tracking, and division order updates post-payout.',
    `partner_id` BIGINT COMMENT 'Reference to the joint venture partner who elected to go non-consent. This partner forfeits participation rights in exchange for avoiding upfront capital exposure.',
    `well_asset_id` BIGINT COMMENT 'Reference to the well asset associated with the non-consent operation, if applicable. Null for facility-level or non-well operations.',
    `approval_date` DATE COMMENT 'Date on which the operator or operating committee formally approved and recorded the non-consent election. Establishes the official start of non-consent provisions.',
    `back_in_right_flag` BOOLEAN COMMENT 'Indicates whether the non-consenting partner retains a back-in right to resume participation after payout or other trigger event. True if back-in provisions exist in the JOA.',
    `back_in_trigger_event` STRING COMMENT 'Description of the event or condition that triggers the non-consenting partners back-in right, if applicable. Examples include payout achievement, production threshold, or time-based milestone.',
    `cancellation_date` DATE COMMENT 'Date on which the non-consent election was cancelled or voided, if applicable. Occurs when the operation is abandoned or the partner reverses their election within allowed timeframes.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the non-consent election was cancelled. Examples include operation abandonment, partner withdrawal reversal, or JOA amendment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this non-consent election record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this non-consent election record. Ensures consistent financial reporting across international joint ventures. [ENUM-REF-CANDIDATE: USD|CAD|GBP|EUR|AUD|NOK|BRL|MXN — 8 candidates stripped; promote to reference product]',
    `election_date` DATE COMMENT 'Date on which the partner formally elected to go non-consent. This date establishes the partners forfeiture of participation rights and triggers penalty provisions.',
    `election_status` STRING COMMENT 'Current lifecycle status of the non-consent election. Tracks progression from initial election through recoupment and potential reinstatement.. Valid values are `pending|confirmed|active|recouped|reinstated|cancelled`',
    `jib_allocation_method` STRING COMMENT 'Method used to allocate production revenue for recoupment purposes in joint interest billing statements. Defines how revenue is distributed between consenting and non-consenting partners during the penalty period.. Valid values are `proportional|waterfall|hybrid`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this non-consent election record was last modified. Tracks the most recent update for audit and reconciliation purposes.',
    `non_consent_penalty_multiplier` DECIMAL(18,2) COMMENT 'Penalty multiplier applied to the non-consenting partners share of operation costs. Typical values range from 200% to 500%, with 300% being common. Defines the total recoupment amount consenting partners must recover before reinstating the non-consenting partner.',
    `non_consent_share_cost` DECIMAL(18,2) COMMENT 'The non-consenting partners proportionate share of the operation cost based on their working interest. This is the base amount before penalty multiplier is applied.',
    `notes` STRING COMMENT 'Free-text field for additional comments, clarifications, or special conditions related to the non-consent election. Captures context not covered by structured fields.',
    `nri_forfeited_percent` DECIMAL(18,2) COMMENT 'Percentage of net revenue interest forfeited by the non-consenting partner during the recoupment period. Reflects the revenue share temporarily transferred to consenting partners.',
    `operation_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost of the operation subject to non-consent, as stated in the AFE. Used to calculate the non-consenting partners share and penalty obligation.',
    `operation_type` STRING COMMENT 'Type of JOA operation subject to the non-consent election. Defines the nature of the capital project the partner declined to fund.. Valid values are `drilling|workover|completion|facility|recompletion|sidetrack`',
    `penalty_recoupment_amount` DECIMAL(18,2) COMMENT 'Total amount that must be recouped by consenting partners before the non-consenting partner is reinstated. Calculated as non_consent_share_cost multiplied by non_consent_penalty_multiplier.',
    `recouped_amount_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount recouped by consenting partners from production revenue as of the current date. Tracks progress toward full penalty recovery and partner reinstatement.',
    `recoupment_completion_date` DATE COMMENT 'Date on which consenting partners fully recovered the penalty recoupment amount. Triggers reinstatement of the non-consenting partners working interest.',
    `recoupment_start_date` DATE COMMENT 'Date on which recoupment of the non-consent penalty began. Typically coincides with first production or revenue allocation from the operation.',
    `reinstatement_date` DATE COMMENT 'Date on which the non-consenting partners working interest and net revenue interest were reinstated following full penalty recoupment. Partner resumes normal participation rights.',
    `reinstatement_status` STRING COMMENT 'Status of the non-consenting partners reinstatement to full working interest participation. Indicates whether penalty has been fully recouped and rights restored.. Valid values are `not_applicable|pending|reinstated|partial`',
    `remaining_recoupment_amount` DECIMAL(18,2) COMMENT 'Outstanding balance of penalty recoupment amount that consenting partners have yet to recover. Calculated as penalty_recoupment_amount minus recouped_amount_to_date.',
    `sec_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether this non-consent election must be disclosed in SEC filings due to materiality thresholds or partner reporting obligations. True if SEC disclosure is required.',
    `source_system` STRING COMMENT 'Name of the source system from which this non-consent election record originated. Typically SAP Joint Venture Accounting or similar JV management system.',
    `source_system_code` STRING COMMENT 'Unique identifier of this non-consent election record in the source system. Enables traceability and reconciliation back to the system of record.',
    `wi_forfeited_percent` DECIMAL(18,2) COMMENT 'Percentage of working interest forfeited by the non-consenting partner during the recoupment period. This interest reverts to consenting partners until the non-consent penalty is recovered.',
    CONSTRAINT pk_non_consent_election PRIMARY KEY(`non_consent_election_id`)
) COMMENT 'Records a partners election to go non-consent on a proposed JOA operation (well, workover, facility), forfeiting their right to participate in exchange for a non-consent penalty premium on future production. Captures electing partner, operation reference, non-consent date, non-consent penalty multiplier (e.g., 300% recoupment), recouped amount to date, and reinstatement status. Supports JOA non-consent accounting under COPAS.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`agreement_type` (
    `agreement_type_id` BIGINT COMMENT 'Primary key for agreement_type',
    `abandonment_liability_allocation` STRING COMMENT 'Describes how plugging and abandonment (P&A) costs and liabilities are allocated among parties under this agreement type. Proportional to WI is most common for JOA; some PSAs place responsibility on the operator or government; others require equal sharing or case-by-case negotiation.. Valid values are `proportional_to_wi|operator_responsible|government_responsible|shared_equally|negotiated`',
    `afe_approval_required_flag` BOOLEAN COMMENT 'Indicates whether this agreement type requires formal AFE approval processes for capital and operating expenditures. True for JOA and most operating agreements; may be false for some PSAs where the NOC controls budgets directly.',
    `agreement_type_description` STRING COMMENT 'Detailed business description of this agreement type, including its purpose, typical use cases, key characteristics, and how it differs from other agreement types. Provides context for users selecting agreement types during data entry and reporting.',
    `agreement_type_status` STRING COMMENT 'Current lifecycle status of this agreement type in the reference data system. Active types are available for new agreements; inactive types are retained for historical agreements but not used for new contracts; deprecated types are being phased out; under review types are being evaluated for addition or modification.. Valid values are `active|inactive|deprecated|under_review`',
    `applicable_jurisdictions` STRING COMMENT 'Comma-separated list of countries or jurisdictions where this agreement type is commonly used or legally recognized (e.g., USA, CAN, NOR, BRA, MYS, IDN). Supports geographic filtering and regulatory compliance analysis.',
    `cash_call_mechanism_flag` BOOLEAN COMMENT 'Indicates whether this agreement type uses a cash call mechanism for funding joint operations, where the operator issues periodic billing statements to non-operators for their share of costs. True for JOA; false for most PSAs where cost recovery is handled through production allocation.',
    `copas_billing_code_applicable_flag` BOOLEAN COMMENT 'Indicates whether COPAS standardized billing codes are used for joint interest billing under this agreement type. True for JOA and most US-based operating agreements; may be false for international PSAs that use different accounting standards.',
    `cost_recovery_applicable_flag` BOOLEAN COMMENT 'Indicates whether this agreement type includes cost recovery provisions allowing contractors to recover exploration and development costs from production revenues before profit splits. Typically true for PSA and PSC types; false for JOA and concession agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agreement type record was first created in the system. Part of standard audit trail for reference data management.',
    `default_overhead_rate_method` STRING COMMENT 'Standard method for calculating overhead charges under this agreement type. Fixed percentage applies a standard rate to direct costs; actual cost passes through real overhead; COPAS rate uses published industry rates; negotiated means parties agree case-by-case; not applicable for agreements without overhead provisions.. Valid values are `fixed_percentage|actual_cost|copas_rate|negotiated|not_applicable`',
    `dispute_resolution_method` STRING COMMENT 'Standard dispute resolution mechanism specified for this agreement type. Arbitration is common for international PSAs; litigation for domestic JOAs; expert determination for technical disputes; mediation for commercial issues; OPCOM vote for operational decisions; not specified if left to individual agreement terms.. Valid values are `arbitration|litigation|expert_determination|mediation|opcom_vote|not_specified`',
    `effective_date` DATE COMMENT 'Date when this agreement type classification became effective in the reference data system. Used for temporal reporting and historical analysis of agreement type usage.',
    `environmental_compliance_standard` STRING COMMENT 'The environmental, health, and safety (HSE) standard or framework typically required under this agreement type (e.g., ISO 14001, API RP 75, Host Country Environmental Law, International Finance Corporation Performance Standards). May reference multiple standards separated by semicolons.',
    `expiry_date` DATE COMMENT 'Date when this agreement type classification expires or was deprecated in the reference data system. Null for active types. Used to maintain historical accuracy when agreement type definitions change.',
    `governing_body_standard` STRING COMMENT 'The industry body or regulatory framework that provides the standard template or guidance for this agreement type (e.g., AAPL Form 610 Model Form Operating Agreement, AIPN Model Production Sharing Agreement, Host Country Petroleum Law). May reference multiple standards separated by semicolons.',
    `local_content_requirement_flag` BOOLEAN COMMENT 'Indicates whether this agreement type typically includes local content requirements mandating minimum percentages of local goods, services, or employment. Common in PSAs and concession agreements in developing countries; less common in JOAs in mature basins.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this agreement type record was last modified in the system. Part of standard audit trail for reference data management.',
    `non_consent_provision_flag` BOOLEAN COMMENT 'Indicates whether this agreement type includes non-consent provisions allowing parties to opt out of proposed operations with specified penalties or interest dilution. Common in JOA; less common in PSA structures.',
    `operator_designation_required_flag` BOOLEAN COMMENT 'Indicates whether this agreement type requires the formal designation of an operator party responsible for day-to-day operations and joint interest billing. True for JOA and most operating agreements; false for some PSAs where the NOC retains operational control.',
    `profit_split_applicable_flag` BOOLEAN COMMENT 'Indicates whether this agreement type involves profit oil or profit gas sharing between government/NOC and contractor parties. True for PSA and PSC; false for JOA and most other agreement types where revenue is allocated by working interest.',
    `ring_fencing_applicable_flag` BOOLEAN COMMENT 'Indicates whether this agreement type includes ring-fencing provisions that prevent cost recovery or tax consolidation across multiple contract areas or projects. Common in PSAs to protect government revenue; not applicable to most JOAs.',
    `sec_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether agreements of this type typically require disclosure in SEC filings for publicly traded companies. True for material JOAs, PSAs, and farm-in/out transactions that affect reserves or financial position; false for minor or routine agreements.',
    `transfer_restriction_type` STRING COMMENT 'Describes the level of restriction on transferring interests under this agreement type. Unrestricted allows free assignment; preferential right gives existing parties first refusal; operator consent requires operator approval; government approval requires host country consent; prohibited means transfers are not allowed.. Valid values are `unrestricted|preferential_right|operator_consent|government_approval|prohibited`',
    `type_category` STRING COMMENT 'High-level classification grouping similar agreement types for analytical and reporting purposes. Operating agreements govern joint operations (JOA), fiscal agreements define government/contractor splits (PSA/PSC), transfer agreements convey interests (farm-in/out), unitization agreements pool resources across boundaries, and financing agreements structure carried interests.. Valid values are `operating_agreement|fiscal_agreement|transfer_agreement|unitization_agreement|financing_agreement|other`',
    `type_code` STRING COMMENT 'Short alphanumeric code representing the agreement type (e.g., JOA, PSA, PSC, FARM-IN, FARM-OUT, UNIT, CARRY). Used for system integration and reporting classification.. Valid values are `^[A-Z0-9]{2,10}$`',
    `type_name` STRING COMMENT 'Full descriptive name of the venture agreement type (e.g., Joint Operating Agreement, Production Sharing Agreement, Production Sharing Contract, Farm-In Agreement, Farm-Out Agreement, Unitization Agreement, Carried Interest Arrangement).',
    `typical_term_length_years` STRING COMMENT 'Standard or typical duration in years for agreements of this type, from effective date to expiry. Used for planning and forecasting purposes. Null if term length varies widely or is indefinite.',
    `usage_notes` STRING COMMENT 'Additional guidance or notes for users on when and how to apply this agreement type classification. May include examples, edge cases, or references to specific business processes or system integrations.',
    `working_interest_allocation_method` STRING COMMENT 'Describes how working interest is allocated among parties under this agreement type. Fixed percentage for JOA; sliding scale or production-based for some PSAs; cost-based for carried interest arrangements; not applicable for pure service contracts.. Valid values are `fixed_percentage|sliding_scale|production_based|cost_based|not_applicable`',
    CONSTRAINT pk_agreement_type PRIMARY KEY(`agreement_type_id`)
) COMMENT 'Reference data classifying the types of venture agreements managed in the domain, including JOA, PSA, PSC, concession agreement, farm-in/farm-out, unitization agreement, and carried interest arrangement. Captures type code, type name, governing body standard, typical term length, and applicable jurisdictions. Provides standardized classification for agreement-level reporting and regulatory disclosure.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` (
    `joa_contract_allocation_id` BIGINT COMMENT 'Unique identifier for this JOA contract allocation record. Primary key.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to the procurement contract being allocated to the JOA.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to the Joint Operating Agreement that this contract allocation serves.',
    `afe_reference_number` STRING COMMENT 'Reference to the Authorization for Expenditure (AFE) that approved this contract allocation to the JOA. Required when contract costs exceed the JOAs AFE approval threshold. Links contract spending to partner-approved capital and operating budgets.',
    `allocation_notes` STRING COMMENT 'Free-text notes documenting the business rationale for this contract allocation, any special terms negotiated with non-operating partners, or operational context relevant to cost allocation and billing.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the procurement contract costs that are allocated to this specific JOA. Used when a single contract serves multiple JOAs to proportionally distribute costs. Sum of allocation percentages across all JOAs for a given contract should equal 100%.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this contract allocation. Active indicates the allocation is currently in effect. Suspended indicates temporary halt. Expired indicates the allocation period has ended. Terminated indicates early termination. Pending Approval indicates the allocation is awaiting partner approval per JOA voting thresholds.',
    `billing_method` STRING COMMENT 'The method used to bill contract costs to this JOA. Direct means costs are billed entirely to this JOA. Proportional uses the allocation percentage. AFE-Based ties billing to specific Authorization for Expenditure approvals. Actual Usage bills based on measured consumption. Fixed Allocation uses predetermined amounts regardless of actual usage.',
    `cost_center_code` STRING COMMENT 'The accounting cost center code used for joint interest billing of costs from this contract allocation. Enables proper cost tracking and reporting in the operators accounting system and partner billing statements.',
    `cost_recovery_eligible` BOOLEAN COMMENT 'Indicates whether costs from this contract allocation are eligible for cost recovery under the JOA terms and applicable Production Sharing Contract or other upstream agreements. False indicates non-recoverable costs that must be borne by working interest partners without reimbursement from production revenue.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this contract allocation record was created in the system.',
    `effective_date` DATE COMMENT 'The date when this contract allocation to the JOA becomes effective. May differ from the contracts overall effective date if the contract is added to the JOA mid-term or if allocation percentages change over time.',
    `expiry_date` DATE COMMENT 'The date when this contract allocation to the JOA expires or terminates. Nullable if the allocation continues for the full contract term. Used to track changes in contract allocation over time as JOAs are amended or assets are transferred.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this contract allocation record was last modified, including changes to allocation percentage, billing method, or status.',
    `overhead_rate` DECIMAL(18,2) COMMENT 'The overhead rate applied to this contract allocation for this specific JOA, which may differ from the JOAs standard overhead rate based on contract type or negotiated terms. Used to calculate overhead charges in joint interest billing.',
    CONSTRAINT pk_joa_contract_allocation PRIMARY KEY(`joa_contract_allocation_id`)
) COMMENT 'This association product represents the allocation of procurement contracts (including rig contracts and master service agreements) to Joint Operating Agreements. In joint venture operations, a single procurement contract often serves multiple JOAs simultaneously, and each JOA may utilize multiple contracts. Each record captures the allocation percentage, billing method, cost recovery eligibility, and overhead rate specific to each JOA-contract pairing, enabling accurate cost allocation and joint interest billing across working interest partners.. Existence Justification: In oil and gas joint venture operations, procurement contracts (especially rig contracts and master service agreements) routinely serve multiple Joint Operating Agreements simultaneously, and each JOA utilizes multiple contracts. The business actively manages contract allocations as a distinct operational entity, tracking allocation percentages, billing methods, cost recovery eligibility, and JOA-specific overhead rates for each JOA-contract pairing to enable accurate joint interest billing and cost sharing among working interest partners.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` (
    `joa_wbs_allocation_id` BIGINT COMMENT 'Unique identifier for this JOA-to-WBS allocation record. Primary key.',
    `joa_id` BIGINT COMMENT 'Foreign key linking to the Joint Operating Agreement that governs cost sharing and working interest for this allocation.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to the WBS element (project cost object) to which JOA working interest and budget allocation rules apply.',
    `afe_reference_number` STRING COMMENT 'The Authorization for Expenditure (AFE) document number that authorizes this specific allocation of JOA budget to the WBS element. Links project authorization to joint venture cost sharing.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this JOA-to-WBS allocation indicating whether it is actively used for cost tracking and partner billing.',
    `budget_allocation_amount` DECIMAL(18,2) COMMENT 'The portion of the WBS element budget that is allocated to this specific JOA, reflecting the working interest share or contractual cost allocation. Identified in detection phase as relationship-specific data.',
    `capitalization_flag` BOOLEAN COMMENT 'Indicates whether costs posted to this WBS element under this JOA should be capitalized to fixed assets (true) or expensed (false). Governs settlement rules for Asset Under Construction (AUC). Identified in detection phase as relationship-specific data.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this JOA-to-WBS allocation record was created in the system.',
    `effective_date` DATE COMMENT 'The date from which this JOA-to-WBS allocation becomes effective for cost tracking and AFE approval purposes. Identified in detection phase as relationship-specific data.',
    `expiry_date` DATE COMMENT 'The date on which this JOA-to-WBS allocation expires or is superseded, if applicable. Null if allocation remains active.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this JOA-to-WBS allocation record was last modified.',
    `settlement_rule_override` STRING COMMENT 'Optional override of the default WBS settlement rule for costs incurred under this specific JOA allocation. Used when JOA-specific capitalization or cost center settlement differs from standard WBS configuration.',
    `work_program_phase` STRING COMMENT 'The phase of the work program or project lifecycle that this WBS element represents within the JOA scope (e.g., exploration, development, production). Identified in detection phase as relationship-specific data.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The working interest percentage applicable to this specific WBS element under this JOA. May differ from the overall JOA working interest if phase-specific or project-specific allocations apply. Identified in detection phase as relationship-specific data.',
    CONSTRAINT pk_joa_wbs_allocation PRIMARY KEY(`joa_wbs_allocation_id`)
) COMMENT 'This association product represents the allocation of Joint Operating Agreement (JOA) working interest and budget responsibility to specific Work Breakdown Structure (WBS) elements for capital project tracking. It captures the phase-specific budget allocations, working interest percentages, and capitalization rules that govern how joint venture partners share costs and track capital expenditures across exploration, development, and production project phases. Each record links one JOA to one WBS element with attributes that exist only in the context of this cost allocation relationship.. Existence Justification: In oil and gas joint venture operations, a single Joint Operating Agreement commonly governs multiple capital projects across different lifecycle phases (exploration wells, development facilities, production infrastructure), each tracked as separate WBS elements in the project accounting system. Conversely, large multi-venture fields or shared infrastructure projects (e.g., a processing facility serving multiple JOAs) require a single WBS element to track costs that must be allocated across multiple JOAs based on working interest percentages. The business actively manages these allocations to ensure proper AFE-to-WBS mapping, partner cost sharing, and capitalization treatment.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` (
    `partner_vendor_qualification_id` BIGINT COMMENT 'Primary key for the partner_vendor_qualification association',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the qualified vendor in the procurement system',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the joint venture partner who maintains this vendor qualification',
    `approved_by_name` STRING COMMENT 'Full name of the partner representative who approved this vendor qualification',
    `approved_by_title` STRING COMMENT 'Job title or role of the partner representative who approved this vendor qualification (e.g., Procurement Manager, Operations Director)',
    `approved_scope` STRING COMMENT 'Detailed description of the scope of work, services, or materials that this vendor is approved to provide for this specific partner. May differ from partner to partner based on their standards and requirements.',
    `contract_value_limit` DECIMAL(18,2) COMMENT 'Maximum contract value that this vendor is approved to execute for this specific partner without additional approval. Partner-specific limit based on vendor capability assessment and risk tolerance.',
    `contract_value_limit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value limit amount',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this partner-vendor qualification record was created in the system',
    `hse_compliance_verified` BOOLEAN COMMENT 'Boolean flag indicating whether the vendor has been verified to meet this partners specific Health, Safety, and Environmental standards',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this partner-vendor qualification record was last updated',
    `last_review_date` DATE COMMENT 'Date when the partner last reviewed or re-evaluated this vendor qualification',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this vendor qualification by the partner',
    `notes` STRING COMMENT 'Free-text notes capturing partner-specific conditions, restrictions, or observations about this vendor qualification',
    `performance_rating` STRING COMMENT 'Partner-specific performance rating of the vendor based on past delivery, quality, HSE compliance, and responsiveness. Each partner maintains independent performance assessments.',
    `qualification_date` DATE COMMENT 'Date when the vendor was qualified or approved by this partner for procurement activities',
    `qualification_expiry_date` DATE COMMENT 'Date when the partner-specific vendor qualification expires and requires renewal or re-evaluation',
    `qualification_status` STRING COMMENT 'Current qualification status of the vendor for this specific partner. Values: Qualified, Conditional, Suspended, Expired, Under Review. Each partner maintains independent qualification status.',
    CONSTRAINT pk_partner_vendor_qualification PRIMARY KEY(`partner_vendor_qualification_id`)
) COMMENT 'This association product represents the qualification and approval relationship between joint venture partners and their approved vendors. It captures partner-specific vendor qualification status, approved scope of work, performance ratings, and contract value limits. Each record links one partner to one vendor with attributes that exist only in the context of this partner-vendor relationship, enabling partners to maintain independent approved vendor lists within joint ventures.. Existence Justification: In oil and gas joint ventures, each partner maintains independent approved vendor lists with partner-specific qualification criteria, performance ratings, and contract value limits. A single vendor can be qualified by multiple partners (each with different scopes and limits), and each partner qualifies multiple vendors. This is an operational business process where partners actively manage, review, and update vendor qualifications as part of JOA/PSA governance.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` (
    `partner_cost_allocation_id` BIGINT COMMENT 'Unique identifier for this partner-cost center allocation record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key to finance.cost_center identifying the cost center in this allocation relationship',
    `joint_venture_id` BIGINT COMMENT 'Foreign key reference to the specific joint venture or JOA under which this allocation is governed. Provides context for the contractual basis of the allocation arrangement.',
    `partner_id` BIGINT COMMENT 'Foreign key to venture.partner identifying the partner in this allocation relationship',
    `afe_number` STRING COMMENT 'The AFE number associated with this allocation, linking the partner-cost center relationship to a specific capital or operating authorization approved by the joint venture partners.',
    `allocation_method` STRING COMMENT 'The methodology used to allocate costs from this cost center to this partner. PROPORTIONAL = based on working interest %, FIXED = predetermined amount, STEP_DOWN = hierarchical allocation, ACTIVITY_BASED = driver-based allocation, DIRECT = directly assigned costs.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this allocation relationship. ACTIVE = costs are being allocated, SUSPENDED = temporarily paused, PENDING = approved but not yet effective, TERMINATED = allocation has ended.',
    `billing_allocation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether costs allocated through this relationship should be included in joint interest billing (JIB) to the partner. True = costs are billable to partner, False = costs are tracked for reporting but not billed (e.g., operator-absorbed costs).',
    `billing_frequency` STRING COMMENT 'The frequency at which costs allocated through this relationship are billed to the partner. Determines the joint interest billing cycle for this partner-cost center combination.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this allocation record was created in the system.',
    `effective_date` DATE COMMENT 'The date from which this partner-cost center allocation arrangement becomes effective. Supports time-variant allocation relationships as working interests change due to farm-ins, farm-outs, or JOA amendments.',
    `expiry_date` DATE COMMENT 'The date on which this partner-cost center allocation arrangement expires or is superseded by a new arrangement. Null indicates the allocation is currently active with no planned end date.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this allocation record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this allocation record.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The percentage of costs from this cost center that are allocated to this partner, based on their working interest in the joint venture. Sum of all partner percentages for a given cost center should equal 100%.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this allocation record.',
    CONSTRAINT pk_partner_cost_allocation PRIMARY KEY(`partner_cost_allocation_id`)
) COMMENT 'This association product represents the cost allocation relationship between joint venture partners and cost centers in joint operating agreements. It captures the working interest percentage, allocation methodology, and billing arrangements that govern how costs accumulated in each cost center are distributed to participating partners. Each record links one partner to one cost center with attributes that exist only in the context of this specific partner-cost center allocation arrangement.. Existence Justification: In oil and gas joint ventures, multiple partners share ownership and costs across multiple cost centers based on their working interest percentages defined in Joint Operating Agreements (JOAs). A partner participates in multiple JOAs, each with numerous cost centers (drilling, production, G&A), and each cost center accumulates costs that must be allocated to multiple partners according to their respective working interests. The business actively manages these allocation relationships, tracking partner-specific percentages, billing methods, effective dates, and AFE authorizations for each partner-cost center combination.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` (
    `partner_account_assignment_id` BIGINT COMMENT 'Unique identifier for this partner-account assignment record. Primary key.',
    `gl_account_id` BIGINT COMMENT 'Foreign key to finance.gl_account. Identifies which GL account is assigned to this partner.',
    `partner_id` BIGINT COMMENT 'Foreign key to venture.partner. Identifies which partner this account assignment applies to.',
    `account_assignment_rule` STRING COMMENT 'Business rule or condition defining when this GL account should be automatically selected for this partner. May reference transaction type, AFE category, cost center, or other posting logic criteria used by the JV accounting automation engine.',
    `assignment_priority` STRING COMMENT 'Numeric priority ranking used when multiple account assignments could apply to the same partner and transaction type. Lower numbers indicate higher priority. Used by posting automation to resolve assignment conflicts.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this account assignment. ACTIVE = in use for posting, INACTIVE = disabled, PENDING = configured but not yet effective, SUPERSEDED = replaced by newer assignment.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this account assignment record was created. Audit trail.',
    `default_credit_account` BOOLEAN COMMENT 'Boolean flag indicating whether this is the default GL account for credit postings to this partner for the specified partner_account_type. Used by automated posting routines to determine account selection.',
    `default_debit_account` BOOLEAN COMMENT 'Boolean flag indicating whether this is the default GL account for debit postings to this partner for the specified partner_account_type. Used by automated posting routines to determine account selection.',
    `effective_date` DATE COMMENT 'Date from which this partner-account assignment becomes active and should be used for transaction posting. Supports time-based account assignment changes (e.g., new fiscal year, contract amendment, partner restructuring).',
    `expiration_date` DATE COMMENT 'Date after which this partner-account assignment is no longer active. Null indicates indefinite assignment. Supports historical tracking of account assignment changes over time.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this account assignment record. Audit trail for configuration changes.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this account assignment record was last modified. Audit trail.',
    `partner_account_type` STRING COMMENT 'Classification of the account assignment indicating the transaction type this GL account handles for this partner. Values: RECEIVABLE (amounts owed by partner), PAYABLE (amounts owed to partner), REVENUE_SHARE (partner revenue distribution), COST_RECOVERY (cost reimbursement), CASH_CALL (partner funding requests), INTEREST_INCOME, INTEREST_EXPENSE, SUSPENSE (temporary holding), OTHER.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this account assignment record. Audit trail for configuration changes.',
    CONSTRAINT pk_partner_account_assignment PRIMARY KEY(`partner_account_assignment_id`)
) COMMENT 'This association product represents the account determination rule between venture partners and general ledger accounts. It captures partner-specific GL account assignments for automated posting of joint venture transactions including receivables, payables, revenue share, and cost recovery. Each record links one partner to one GL account with assignment rules, effective dates, and account usage type that exist only in the context of this relationship. Core to JV accounting automation per COPAS standards.. Existence Justification: In joint venture accounting operations, each partner requires multiple GL account assignments for different transaction types (receivables, payables, revenue share, cost recovery, cash calls), and each GL account serves multiple partners across the venture portfolio. The relationship represents partner-specific account determination rules that drive automated posting in JV accounting systems—a core operational configuration managed by venture accountants and referenced by every JV transaction posting routine.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`filing_participation` (
    `filing_participation_id` BIGINT COMMENT 'Unique surrogate identifier for each partner participation record in a regulatory filing',
    `compliance_regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to the regulatory filing in which this partner is participating',
    `partner_id` BIGINT COMMENT 'Foreign key linking to the joint venture partner participating in this regulatory filing',
    `approval_contact_email` STRING COMMENT 'Email address of the approving contact for correspondence and audit verification purposes.',
    `approval_contact_name` STRING COMMENT 'Full name of the individual from the partner organization who provided approval or signature for this filing. Required for regulatory audit trail.',
    `approval_date` DATE COMMENT 'Date on which this partner formally approved or signed off on this regulatory filing. Required for audit trail and SOX compliance for material disclosures.',
    `approval_status` STRING COMMENT 'Current approval status of this partner for this regulatory filing. Tracks workflow progression through multi-party approval process required for joint submissions.',
    `comments` STRING COMMENT 'Free-text comments or notes from the partner regarding their participation in this filing, including conditions, reservations, or clarifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this filing participation record was first created in the compliance system.',
    `partner_role` STRING COMMENT 'The functional role of the partner in the context of this specific regulatory filing. Operator submits on behalf of JV, Non-Operator reviews and approves, Government Partner may have special reporting rights.',
    `signatory_flag` BOOLEAN COMMENT 'Indicates whether this partner is required to sign or formally approve this regulatory filing. True for PSA amendments, joint SEC filings, and FERC tariff submissions requiring multi-party signatures.',
    `submission_date` DATE COMMENT 'Date on which this partner submitted their portion of data or documentation for inclusion in the regulatory filing. May differ from the overall filing submission_timestamp.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this filing participation record was last modified, tracking approval workflow progression.',
    `working_interest_percentage` DECIMAL(18,2) COMMENT 'The partners working interest percentage applicable to this regulatory filing. Critical for SEC reserves disclosures and revenue reporting where each partners share must be disclosed.',
    CONSTRAINT pk_filing_participation PRIMARY KEY(`filing_participation_id`)
) COMMENT 'This association product represents the participation of joint venture partners in regulatory filings submitted to governing bodies. It captures each partners role, working interest, signatory status, and approval for multi-party regulatory submissions including joint SEC disclosures, PSA amendments, BSEE offshore reports, and FERC filings. Each record links one partner to one regulatory filing with attributes that exist only in the context of this participation relationship.. Existence Justification: In oil and gas joint venture operations, multiple partners participate in single regulatory filings (e.g., joint SEC 10-K proved reserves disclosures, PSA amendment filings to BOEM, FERC pipeline tariff submissions). Each partner has a specific role, working interest percentage, and approval status for each filing. Conversely, each partner participates in multiple regulatory filings across different JOAs, PSAs, and operating agreements over time. This is an operational relationship actively managed through compliance workflows.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`joint_venture` (
    `joint_venture_id` BIGINT COMMENT 'Primary key for joint_venture',
    `partner_id` BIGINT COMMENT 'Unique identifier of the partner organization involved in the joint venture.',
    `parent_joint_venture_id` BIGINT COMMENT 'Self-referencing FK on joint_venture (parent_joint_venture_id)',
    `accounting_standard` STRING COMMENT 'Accounting framework used for joint venture financial reporting.',
    `afe_approval_number` STRING COMMENT 'Authorization number for the Authorization for Expenditure (AFE) linked to the joint venture.',
    `approval_date` DATE COMMENT 'Date the joint venture was formally approved by corporate governance.',
    `cash_call_amount` DECIMAL(18,2) COMMENT 'Monetary amount requested from the partner for cash calls.',
    `cash_call_due_date` DATE COMMENT 'Date by which the cash call amount must be paid.',
    `cost_recovery_method` STRING COMMENT 'Method used to recover costs from production revenue.',
    `cost_recovery_rate` DECIMAL(18,2) COMMENT 'Rate (percentage) at which costs are recovered from production revenue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the joint venture record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `joint_venture_description` STRING COMMENT 'Free‑form description of the joint venture purpose and scope.',
    `effective_from` DATE COMMENT 'Date the joint venture agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date the joint venture agreement ends or expires (null if open‑ended).',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the joint venture details are classified as confidential.',
    `joint_interest_billing_flag` BOOLEAN COMMENT 'Indicates whether joint interest billing (JIB) is applied to this venture.',
    `joint_venture_code` STRING COMMENT 'External business code or number assigned to the joint venture.',
    `joint_venture_name` STRING COMMENT 'Human‑readable name of the joint venture.',
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
    `joint_venture_status` STRING COMMENT 'Current lifecycle status of the joint venture.',
    `tax_regime` STRING COMMENT 'Tax regime applicable to the joint venture earnings.',
    `total_commitment_amount` DECIMAL(18,2) COMMENT 'Total monetary commitment pledged by the partner for the joint venture.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the joint venture record.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Working interest percentage allocated to the partner for production operations.',
    CONSTRAINT pk_joint_venture PRIMARY KEY(`joint_venture_id`)
) COMMENT 'Master reference table for joint_venture. Referenced by joint_venture_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`jib_batch` (
    `jib_batch_id` BIGINT COMMENT 'Primary key for jib_batch',
    `partner_id` BIGINT COMMENT 'Identifier of the joint venture partner associated with this billing batch.',
    `parent_jib_batch_id` BIGINT COMMENT 'Self-referencing FK on jib_batch (parent_jib_batch_id)',
    `approval_status` STRING COMMENT 'Approval workflow state of the batch.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the batch was approved.',
    `batch_number` STRING COMMENT 'Human‑readable business identifier assigned to the billing batch.',
    `billing_cycle_code` STRING COMMENT 'Code indicating the billing frequency (Monthly, Quarterly, Annual).',
    `billing_event_timestamp` TIMESTAMP COMMENT 'Timestamp of the business event that triggered the JIB batch (e.g., period close).',
    `comments` STRING COMMENT 'Additional free‑form remarks or notes about the batch.',
    `cost_recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered for joint‑venture cost recovery under the applicable agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the JIB batch record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the batch amounts.',
    `jib_batch_description` STRING COMMENT 'Free‑form text describing the purpose or notes for the batch.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Conversion rate to the reporting currency if the batch currency differs.',
    `is_manual` BOOLEAN COMMENT 'Indicates whether the batch was entered manually (True) or generated automatically (False).',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last updated the batch.',
    `net_partner_amount` DECIMAL(18,2) COMMENT 'Final amount payable to the partner after cost recovery and profit splits.',
    `period_end_date` DATE COMMENT 'Last calendar date of the billing period covered by the batch.',
    `period_start_date` DATE COMMENT 'First calendar date of the billing period covered by the batch.',
    `profit_gas_share_percent` DECIMAL(18,2) COMMENT 'Percentage of profit gas allocated to the partner for this batch.',
    `profit_oil_share_percent` DECIMAL(18,2) COMMENT 'Percentage of profit oil allocated to the partner for this batch.',
    `settlement_date` DATE COMMENT 'Date on which the net amounts are settled with the partner.',
    `source_system` STRING COMMENT 'Name of the source system that originated the batch record (e.g., SAP).',
    `jib_batch_status` STRING COMMENT 'Current processing state of the JIB batch.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the batch gross amount.',
    `tax_code` STRING COMMENT 'Code representing the tax regime applicable to the batch.',
    `total_adjustments_amount` DECIMAL(18,2) COMMENT 'Aggregate of all adjustments (taxes, fees, discounts) applied to the gross amount.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Sum of all gross charges before adjustments for the batch, expressed in the batch currency.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Net amount payable after gross charges and adjustments, in the batch currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the JIB batch record.',
    `version_number` STRING COMMENT 'Incremental version of the batch record for audit purposes.',
    CONSTRAINT pk_jib_batch PRIMARY KEY(`jib_batch_id`)
) COMMENT 'Master reference table for jib_batch. Referenced by jib_batch_id.';

CREATE OR REPLACE TABLE `oil_gas_ecm`.`venture`.`concession` (
    `concession_id` BIGINT COMMENT 'Primary key for concession',
    `parent_concession_id` BIGINT COMMENT 'Self-referencing FK on concession (parent_concession_id)',
    `approval_date` DATE COMMENT 'Date on which the concession was formally approved.',
    `approved_by` STRING COMMENT 'Name of the executive or authority that approved the concession.',
    `basin` STRING COMMENT 'Geological basin where the concession assets are located.',
    `block` STRING COMMENT 'Block or parcel identifier within the basin.',
    `compliance_status` STRING COMMENT 'Overall compliance standing of the concession with internal and external regulations.',
    `concession_code` STRING COMMENT 'External reference code or number assigned to the concession by the joint venture accounting system.',
    `concession_type` STRING COMMENT 'Category of the agreement governing the rights to explore or produce (e.g., Joint Operating Agreement, Production Sharing Agreement).',
    `cost_recovery_percent` DECIMAL(18,2) COMMENT 'Maximum percentage of production revenue that can be recovered as cost under the concession.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the concession record was first created in the data lake.',
    `concession_description` STRING COMMENT 'Free‑form description providing context, purpose, and any special conditions of the concession.',
    `document_id` BIGINT COMMENT 'Identifier of the primary contract document stored in the document repository.',
    `effective_from` DATE COMMENT 'Date on which the concession becomes legally binding.',
    `effective_until` DATE COMMENT 'Date on which the concession expires or is scheduled to terminate (null for open‑ended).',
    `eia_date` DATE COMMENT 'Date on which the EIA was finalized.',
    `environmental_impact_assessment_flag` BOOLEAN COMMENT 'Indicates whether an Environmental Impact Assessment has been completed.',
    `extension_date` DATE COMMENT 'Date on which the extension became effective.',
    `extension_flag` BOOLEAN COMMENT 'Indicates whether the concession term has been extended.',
    `financial_currency` STRING COMMENT 'ISO 4217 currency code used for monetary values in the concession.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the concession financials are reported.',
    `jurisdiction` STRING COMMENT 'ISO‑3 country code of the legal jurisdiction governing the concession.',
    `last_review_date` DATE COMMENT 'Date of the most recent compliance or financial review of the concession.',
    `lease_number` STRING COMMENT 'Official lease number associated with the concession.',
    `concession_name` STRING COMMENT 'Human‑readable name of the concession, typically the field block or lease name.',
    `net_revenue_share_percent` DECIMAL(18,2) COMMENT 'Share of net revenue allocated to the reporting entity after royalty and cost recovery.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks, exceptions, or special conditions.',
    `operator_id` BIGINT COMMENT 'Identifier of the operating company responsible for the concession.',
    `partner_count` STRING COMMENT 'Total count of joint‑venture partners participating in the concession.',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory approvals for the concession.',
    `renewal_date` DATE COMMENT 'Effective date of the renewal option, if exercised.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the concession includes a renewal option.',
    `royalty_percent` DECIMAL(18,2) COMMENT 'Royalty rate applied to production revenue as defined in the concession.',
    `concession_status` STRING COMMENT 'Current lifecycle state of the concession.',
    `tax_regime` STRING COMMENT 'Tax treatment applicable to the concession revenue.',
    `termination_date` DATE COMMENT 'Date on which the concession was terminated, if applicable.',
    `total_cost_recovery_amount` DECIMAL(18,2) COMMENT 'Cumulative amount recovered as cost under the concession.',
    `total_royalty_amount` DECIMAL(18,2) COMMENT 'Cumulative royalty amount accrued under the concession.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the concession record.',
    `working_interest_percent` DECIMAL(18,2) COMMENT 'Percentage of the working interest owned by the reporting entity.',
    CONSTRAINT pk_concession PRIMARY KEY(`concession_id`)
) COMMENT 'Master reference table for concession. Referenced by concession_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ADD CONSTRAINT `fk_venture_joa_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `oil_gas_ecm`.`venture`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ADD CONSTRAINT `fk_venture_joa_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ADD CONSTRAINT `fk_venture_joa_joa_venture_partner_id` FOREIGN KEY (`joa_venture_partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ADD CONSTRAINT `fk_venture_psa_agreement_type_id` FOREIGN KEY (`agreement_type_id`) REFERENCES `oil_gas_ecm`.`venture`.`agreement_type`(`agreement_type_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ADD CONSTRAINT `fk_venture_psa_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ADD CONSTRAINT `fk_venture_psa_psa_venture_partner_id` FOREIGN KEY (`psa_venture_partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ADD CONSTRAINT `fk_venture_venture_working_interest_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_farmout_farmor_partner_id` FOREIGN KEY (`farmout_farmor_partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ADD CONSTRAINT `fk_venture_farmout_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ADD CONSTRAINT `fk_venture_venture_afe_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ADD CONSTRAINT `fk_venture_afe_approval_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ADD CONSTRAINT `fk_venture_jib_statement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_jib_statement_id` FOREIGN KEY (`jib_statement_id`) REFERENCES `oil_gas_ecm`.`venture`.`jib_statement`(`jib_statement_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ADD CONSTRAINT `fk_venture_jib_line_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ADD CONSTRAINT `fk_venture_cash_call_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ADD CONSTRAINT `fk_venture_cash_call_payment_cash_call_id` FOREIGN KEY (`cash_call_id`) REFERENCES `oil_gas_ecm`.`venture`.`cash_call`(`cash_call_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ADD CONSTRAINT `fk_venture_cash_call_payment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ADD CONSTRAINT `fk_venture_cost_recovery_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ADD CONSTRAINT `fk_venture_profit_oil_split_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ADD CONSTRAINT `fk_venture_profit_oil_split_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ADD CONSTRAINT `fk_venture_partner_netting_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ADD CONSTRAINT `fk_venture_partner_netting_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ADD CONSTRAINT `fk_venture_lifting_entitlement_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ADD CONSTRAINT `fk_venture_lifting_entitlement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ADD CONSTRAINT `fk_venture_lifting_entitlement_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ADD CONSTRAINT `fk_venture_overlift_underlift_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ADD CONSTRAINT `fk_venture_jv_budget_opcom_meeting_id` FOREIGN KEY (`opcom_meeting_id`) REFERENCES `oil_gas_ecm`.`venture`.`opcom_meeting`(`opcom_meeting_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ADD CONSTRAINT `fk_venture_operating_committee_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ADD CONSTRAINT `fk_venture_operating_committee_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ADD CONSTRAINT `fk_venture_operating_committee_quaternary_operating_partner_id` FOREIGN KEY (`quaternary_operating_partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ADD CONSTRAINT `fk_venture_operating_committee_tertiary_operating_chairperson_party_venture_partner_id` FOREIGN KEY (`tertiary_operating_chairperson_party_venture_partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ADD CONSTRAINT `fk_venture_opcom_meeting_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ADD CONSTRAINT `fk_venture_opcom_meeting_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ADD CONSTRAINT `fk_venture_carried_interest_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ADD CONSTRAINT `fk_venture_state_participation_concession_id` FOREIGN KEY (`concession_id`) REFERENCES `oil_gas_ecm`.`venture`.`concession`(`concession_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ADD CONSTRAINT `fk_venture_state_participation_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ADD CONSTRAINT `fk_venture_royalty_obligation_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ADD CONSTRAINT `fk_venture_royalty_obligation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ADD CONSTRAINT `fk_venture_royalty_obligation_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ADD CONSTRAINT `fk_venture_royalty_payment_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ADD CONSTRAINT `fk_venture_royalty_payment_psa_id` FOREIGN KEY (`psa_id`) REFERENCES `oil_gas_ecm`.`venture`.`psa`(`psa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ADD CONSTRAINT `fk_venture_royalty_payment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ADD CONSTRAINT `fk_venture_jv_audit_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ADD CONSTRAINT `fk_venture_jv_audit_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ADD CONSTRAINT `fk_venture_default_notice_cash_call_id` FOREIGN KEY (`cash_call_id`) REFERENCES `oil_gas_ecm`.`venture`.`cash_call`(`cash_call_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ADD CONSTRAINT `fk_venture_default_notice_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ADD CONSTRAINT `fk_venture_default_notice_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ADD CONSTRAINT `fk_venture_non_consent_election_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ADD CONSTRAINT `fk_venture_non_consent_election_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ADD CONSTRAINT `fk_venture_joa_contract_allocation_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ADD CONSTRAINT `fk_venture_joa_wbs_allocation_joa_id` FOREIGN KEY (`joa_id`) REFERENCES `oil_gas_ecm`.`venture`.`joa`(`joa_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ADD CONSTRAINT `fk_venture_partner_vendor_qualification_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ADD CONSTRAINT `fk_venture_partner_cost_allocation_joint_venture_id` FOREIGN KEY (`joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ADD CONSTRAINT `fk_venture_partner_cost_allocation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ADD CONSTRAINT `fk_venture_partner_account_assignment_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ADD CONSTRAINT `fk_venture_filing_participation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` ADD CONSTRAINT `fk_venture_joint_venture_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` ADD CONSTRAINT `fk_venture_joint_venture_parent_joint_venture_id` FOREIGN KEY (`parent_joint_venture_id`) REFERENCES `oil_gas_ecm`.`venture`.`joint_venture`(`joint_venture_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_batch` ADD CONSTRAINT `fk_venture_jib_batch_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `oil_gas_ecm`.`venture`.`partner`(`partner_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_batch` ADD CONSTRAINT `fk_venture_jib_batch_parent_jib_batch_id` FOREIGN KEY (`parent_jib_batch_id`) REFERENCES `oil_gas_ecm`.`venture`.`jib_batch`(`jib_batch_id`);
ALTER TABLE `oil_gas_ecm`.`venture`.`concession` ADD CONSTRAINT `fk_venture_concession_parent_concession_id` FOREIGN KEY (`parent_concession_id`) REFERENCES `oil_gas_ecm`.`venture`.`concession`(`concession_id`);

-- ========= TAGS =========
ALTER SCHEMA `oil_gas_ecm`.`venture` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `oil_gas_ecm`.`venture` SET TAGS ('dbx_domain' = 'venture');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` SET TAGS ('dbx_subdomain' = 'venture_agreements');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Agreement Type Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `partner_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `joa_venture_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Party ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` SET TAGS ('dbx_subdomain' = 'venture_agreements');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Psa Agreement Type Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `compliance_sec_reserves_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Sec Reserves Disclosure Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`psa` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` SET TAGS ('dbx_subdomain' = 'partner_finance');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` SET TAGS ('dbx_subdomain' = 'venture_agreements');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `venture_working_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Working Interest ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_working_interest` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) ID');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` SET TAGS ('dbx_subdomain' = 'venture_agreements');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `farmout_id` SET TAGS ('dbx_business_glossary_term' = 'Farmout Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Farminee Partner ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `farmout_farmor_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Farmor Partner ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`farmout` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` SET TAGS ('dbx_subdomain' = 'partner_finance');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `venture_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `dc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Drilling Program Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `finance_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Afe Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Entity ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`venture_afe` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset ID');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` SET TAGS ('dbx_subdomain' = 'partner_finance');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `afe_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Approval Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Partner Identifier');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `partner_working_interest` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `rejection_category` SET TAGS ('dbx_business_glossary_term' = 'Rejection Category');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `rejection_category` SET TAGS ('dbx_value_regex' = 'cost_excessive|technical_risk|strategic_misalignment|procedural_deficiency|budget_constraint|scope_unclear');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `response_overdue_flag` SET TAGS ('dbx_business_glossary_term' = 'Response Overdue Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`afe_approval` ALTER COLUMN `voting_threshold_met` SET TAGS ('dbx_business_glossary_term' = 'Voting Threshold Met Indicator');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` SET TAGS ('dbx_subdomain' = 'partner_finance');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Jib Statement Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Partner Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `regulatory_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Audit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_statement` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` SET TAGS ('dbx_subdomain' = 'partner_finance');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `jib_line_id` SET TAGS ('dbx_business_glossary_term' = 'Jib Line Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `compliance_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `jib_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `journal_entry_line_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Line Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Partner Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'PENDING|APPROVED|REJECTED|REQUIRES_REVIEW');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `cost_category_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Category Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` SET TAGS ('dbx_subdomain' = 'partner_finance');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `cash_call_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call` ALTER COLUMN `sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Sox Control Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` SET TAGS ('dbx_subdomain' = 'partner_finance');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `cash_call_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Payment Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cash_call_payment` ALTER COLUMN `cash_call_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Identifier (ID)');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` SET TAGS ('dbx_subdomain' = 'revenue_allocation');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `cost_recovery_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `actual_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `regulatory_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Audit Id (Foreign Key)');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`cost_recovery` ALTER COLUMN `jib_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Reference Number');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` SET TAGS ('dbx_subdomain' = 'revenue_allocation');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `profit_oil_split_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Oil Split Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`profit_oil_split` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier (ID)');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` SET TAGS ('dbx_subdomain' = 'partner_finance');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `partner_netting_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Netting ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `intercompany_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Partner ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `actual_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Settlement Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Reference');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `cash_call_count` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Count');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `counterparty_settlement_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Settlement Risk Score');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `gross_payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Payable Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `gross_receivable_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Receivable Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `jib_statement_count` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement Count');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `lifting_settlement_count` SET TAGS ('dbx_business_glossary_term' = 'Lifting Settlement Count');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `netting_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Netting Agreement Reference');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `netting_document_number` SET TAGS ('dbx_business_glossary_term' = 'Netting Document Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `netting_method` SET TAGS ('dbx_business_glossary_term' = 'Netting Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `netting_method` SET TAGS ('dbx_value_regex' = 'bilateral|multilateral|automatic|manual');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `netting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Netting Period End Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `netting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Netting Period Start Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `netting_status` SET TAGS ('dbx_business_glossary_term' = 'Netting Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `netting_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|settled|cancelled|disputed');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|offset|intercompany_transfer');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `royalty_obligation_count` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation Count');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `sap_jva_posting_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Joint Venture Accounting (JVA) Posting Document Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_netting` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_JVA|QUORUM|LEGACY_JV|MANUAL');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` SET TAGS ('dbx_subdomain' = 'revenue_allocation');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `lifting_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Lifting Entitlement Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `field_id` SET TAGS ('dbx_business_glossary_term' = 'Field Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Identifier (ID)');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`lifting_entitlement` ALTER COLUMN `lifting_point_location` SET TAGS ('dbx_business_glossary_term' = 'Lifting Point Location');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` SET TAGS ('dbx_subdomain' = 'revenue_allocation');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `overlift_underlift_id` SET TAGS ('dbx_business_glossary_term' = 'Overlift Underlift Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Identifier (ID)');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`overlift_underlift` ALTER COLUMN `jib_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Reference Number');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` SET TAGS ('dbx_subdomain' = 'operational_governance');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `jv_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Budget Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `opcom_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Meeting Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` SET TAGS ('dbx_subdomain' = 'operational_governance');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `operating_committee_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee (OpCom) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee Chairperson Party ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`operating_committee` ALTER COLUMN `quaternary_operating_partner_id` SET TAGS ('dbx_internal' = 'true');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` SET TAGS ('dbx_subdomain' = 'operational_governance');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `opcom_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee (OpCom) Meeting Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Chairperson Partner Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Secretary Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `action_items_count` SET TAGS ('dbx_business_glossary_term' = 'Action Items Count');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `afe_approvals_count` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Approvals Count');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `agenda_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Agenda Document Reference');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `agenda_summary` SET TAGS ('dbx_business_glossary_term' = 'Agenda Summary');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `attendees_summary` SET TAGS ('dbx_business_glossary_term' = 'Attendees Summary');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `budget_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Approved Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_business_glossary_term' = 'Chairperson Name');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `chairperson_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee (OpCom) Meeting Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `meeting_end_time` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee (OpCom) Meeting End Time');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `meeting_location` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee (OpCom) Meeting Location');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `meeting_location_address` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee (OpCom) Meeting Location Address');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `meeting_location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `meeting_location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `meeting_location_city` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee (OpCom) Meeting Location City');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `meeting_location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee (OpCom) Meeting Location Country Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `meeting_location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `meeting_number` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee (OpCom) Meeting Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `meeting_start_time` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee (OpCom) Meeting Start Time');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `meeting_status` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee (OpCom) Meeting Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `meeting_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|postponed|adjourned');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `meeting_type` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee (OpCom) Meeting Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `meeting_type` SET TAGS ('dbx_value_regex' = 'regular|special|emergency|annual|extraordinary');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `minutes_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Minutes Approved Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `minutes_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Minutes Approved Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `minutes_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Minutes Document Reference');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `next_meeting_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Meeting Scheduled Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Meeting Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `operator_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Change Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `quorum_achieved_flag` SET TAGS ('dbx_business_glossary_term' = 'Quorum Achieved Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `quorum_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Quorum Threshold Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `resolutions_passed_count` SET TAGS ('dbx_business_glossary_term' = 'Resolutions Passed Count');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `total_voting_interest_represented_pct` SET TAGS ('dbx_business_glossary_term' = 'Total Voting Interest Represented Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `work_program_modified_flag` SET TAGS ('dbx_business_glossary_term' = 'Work Program Modified Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`opcom_meeting` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` SET TAGS ('dbx_subdomain' = 'venture_agreements');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `carried_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Carried Interest Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Partner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`carried_interest` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
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
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` SET TAGS ('dbx_subdomain' = 'venture_agreements');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `state_participation_id` SET TAGS ('dbx_business_glossary_term' = 'State Participation Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `concession_id` SET TAGS ('dbx_business_glossary_term' = 'Concession Agreement Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `afe_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Approval Required Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `afe_approval_threshold_usd` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Approval Threshold (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `back_in_right_flag` SET TAGS ('dbx_business_glossary_term' = 'Back-In Right Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `carried_through_phase` SET TAGS ('dbx_business_glossary_term' = 'Carried Through Phase');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `carried_through_phase` SET TAGS ('dbx_value_regex' = 'exploration|appraisal|development|production|full field life|none');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `cash_call_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Obligation Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `consideration_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Consideration Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `consideration_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `consideration_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Consideration Paid Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `cost_recovery_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Eligible Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `cost_recovery_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Limit (USD)');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Effective Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `entitlement_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Calculation Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `entitlement_calculation_method` SET TAGS ('dbx_value_regex' = 'working interest|profit oil split|net revenue interest|hybrid|other');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `exercise_date` SET TAGS ('dbx_business_glossary_term' = 'Exercise Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `exercise_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Exercise Deadline Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `exercise_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Exercise Trigger Event');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Expiry Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `host_government_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Host Government Entity Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `non_consent_option_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Option Available Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'State Participation Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `operator_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Operator Consent Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `operator_consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Consent Required Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `participation_number` SET TAGS ('dbx_business_glossary_term' = 'State Participation Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `participation_percentage` SET TAGS ('dbx_business_glossary_term' = 'State Participation Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'State Participation Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'pending|exercised|active|expired|waived|terminated');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `participation_type` SET TAGS ('dbx_business_glossary_term' = 'State Participation Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `participation_type` SET TAGS ('dbx_value_regex' = 'back-in right|free carry|paid participation|carried interest|state equity|royalty participation');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `profit_gas_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Profit Gas Split Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `profit_oil_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Profit Oil Split Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `regulatory_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `reversion_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Reversion Trigger Event');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `reversion_trigger_event` SET TAGS ('dbx_value_regex' = 'payout|cumulative production|contract expiry|field abandonment|reserves depletion|none');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `reversion_wi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Reversion Working Interest (WI) Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `sec_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Disclosure Required Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Termination Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Participation Termination Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `trigger_date` SET TAGS ('dbx_business_glossary_term' = 'Trigger Event Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`state_participation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` SET TAGS ('dbx_subdomain' = 'revenue_allocation');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `royalty_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Payee Partner ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'crude_oil|natural_gas|ngl|condensate|all_hydrocarbons');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `cost_recovery_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Limit Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `cumulative_royalty_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Royalty Paid Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `deduction_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Deduction Allowed Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `deduction_type` SET TAGS ('dbx_business_glossary_term' = 'Deduction Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `interest_rate_late_payment_pct` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Late Payment Percent');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `minimum_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Royalty Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `payee_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Payee Tax Identification Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `payee_tax_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|upon_sale');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `payout_date` SET TAGS ('dbx_business_glossary_term' = 'Payout Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `payout_status` SET TAGS ('dbx_business_glossary_term' = 'Payout Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `payout_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pre_payout|post_payout');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `production_basis` SET TAGS ('dbx_business_glossary_term' = 'Production Basis');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `production_basis` SET TAGS ('dbx_value_regex' = 'gross_production|net_production|working_interest_share|net_revenue_interest_share');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `royalty_obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `royalty_obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Royalty Obligation Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `royalty_obligation_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending_approval|disputed|paid_out');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `royalty_subtype` SET TAGS ('dbx_business_glossary_term' = 'Royalty Subtype');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `royalty_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `royalty_type` SET TAGS ('dbx_value_regex' = 'gross_overriding|net_profits_interest|government_royalty|landowner_royalty|production_payment|carried_interest_royalty');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `sap_jva_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Joint Venture Accounting (JVA) Document Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `sec_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Disclosure Required Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `sliding_scale_basis` SET TAGS ('dbx_business_glossary_term' = 'Sliding Scale Basis');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `sliding_scale_basis` SET TAGS ('dbx_value_regex' = 'production_volume|commodity_price|cumulative_recovery|time_based');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `sliding_scale_flag` SET TAGS ('dbx_business_glossary_term' = 'Sliding Scale Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_obligation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` SET TAGS ('dbx_subdomain' = 'revenue_allocation');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `royalty_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `petroleum_product_id` SET TAGS ('dbx_business_glossary_term' = 'Petroleum Product Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `psa_id` SET TAGS ('dbx_business_glossary_term' = 'Production Sharing Agreement (PSA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `royalty_owner_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Owner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Entity Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `ad_valorem_tax` SET TAGS ('dbx_business_glossary_term' = 'Ad Valorem Tax');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `compression_deduction` SET TAGS ('dbx_business_glossary_term' = 'Compression Deduction');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `division_order_number` SET TAGS ('dbx_business_glossary_term' = 'Division Order Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `gas_price_per_mcf` SET TAGS ('dbx_business_glossary_term' = 'Gas Price Per Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `gas_volume_mcf` SET TAGS ('dbx_business_glossary_term' = 'Gas Volume in Thousand Cubic Feet (MCF)');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `gathering_deduction` SET TAGS ('dbx_business_glossary_term' = 'Gathering Deduction');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `gross_production_value` SET TAGS ('dbx_business_glossary_term' = 'Gross Production Value');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `interest_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percent');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `net_royalty_value` SET TAGS ('dbx_business_glossary_term' = 'Net Royalty Value');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `ngl_price_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Price Per Barrel (BBL)');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `ngl_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Natural Gas Liquids (NGL) Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `oil_price_per_bbl` SET TAGS ('dbx_business_glossary_term' = 'Oil Price Per Barrel (BBL)');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `oil_volume_bbl` SET TAGS ('dbx_business_glossary_term' = 'Oil Volume in Barrels (BBL)');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `other_tax_withholding` SET TAGS ('dbx_business_glossary_term' = 'Other Tax Withholding');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|wire_transfer|ach|direct_deposit|suspense');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|disbursed|cancelled|suspended|reconciled');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `processing_deduction` SET TAGS ('dbx_business_glossary_term' = 'Processing Deduction');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `production_month` SET TAGS ('dbx_business_glossary_term' = 'Production Month');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `royalty_interest_decimal` SET TAGS ('dbx_business_glossary_term' = 'Royalty Interest Decimal');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `severance_tax` SET TAGS ('dbx_business_glossary_term' = 'Severance Tax');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `suspense_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspense Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `suspense_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspense Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `total_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `transportation_deduction` SET TAGS ('dbx_business_glossary_term' = 'Transportation Deduction');
ALTER TABLE `oil_gas_ecm`.`venture`.`royalty_payment` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Wire Reference Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` SET TAGS ('dbx_subdomain' = 'operational_governance');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `jv_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture (JV) Audit Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Journal Entry Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Auditing Partner Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `regulatory_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Audit Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `afe_count_examined` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Count Examined');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `agreed_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Agreed Adjustment Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `arbitration_case_number` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Case Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `audit_commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Commencement Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `audit_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Completion Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `audit_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `audit_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Notice Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope Category');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type Classification');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'routine|special|dispute_driven|compliance|pre_payout|post_payout');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `auditor_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Firm Name');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `copas_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Council of Petroleum Accountants Societies (COPAS) Compliance Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `cost_recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Recovery Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `cost_recovery_method` SET TAGS ('dbx_value_regex' = 'auditing_partner_bears|operator_reimburses|proportional_to_findings|per_JOA_terms');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `credit_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Issue Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `credit_issued_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Issued Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'negotiation|mediation|arbitration|litigation|operating_committee');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `draft_report_date` SET TAGS ('dbx_business_glossary_term' = 'Draft Report Issuance Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `final_report_date` SET TAGS ('dbx_business_glossary_term' = 'Final Report Issuance Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Summary');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `jib_statement_period_count` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Statement Period Count');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `material_weakness_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Weakness Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `operator_response_date` SET TAGS ('dbx_business_glossary_term' = 'Operator Response Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `operator_response_summary` SET TAGS ('dbx_business_glossary_term' = 'Operator Response Summary');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `settlement_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Agreement Reference');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|negotiating|partially_settled|fully_settled|arbitration|litigation');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `total_charges_examined_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charges Examined Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `total_exceptions_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Exceptions Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`jv_audit` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` SET TAGS ('dbx_subdomain' = 'venture_agreements');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `default_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Default Notice Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `cash_call_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Defaulting Partner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Contact Employee Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `accrued_interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Interest Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `cure_amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Cure Amount Paid');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `cure_date` SET TAGS ('dbx_business_glossary_term' = 'Cure Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `cure_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Cure Deadline Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `cure_period_days` SET TAGS ('dbx_business_glossary_term' = 'Cure Period Days');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `default_amount` SET TAGS ('dbx_business_glossary_term' = 'Default Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `default_interest_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Default Interest Rate Percentage (Pct)');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `default_notice_number` SET TAGS ('dbx_business_glossary_term' = 'Default Notice Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `default_status` SET TAGS ('dbx_business_glossary_term' = 'Default Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `default_type` SET TAGS ('dbx_business_glossary_term' = 'Default Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `default_type` SET TAGS ('dbx_value_regex' = 'cash_call_non_payment|afe_non_consent|work_program_failure|insurance_non_compliance|abandonment_obligation_failure|other');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `forfeited_nri_pct` SET TAGS ('dbx_business_glossary_term' = 'Forfeited Net Revenue Interest (NRI) Percentage (Pct)');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `forfeited_wi_pct` SET TAGS ('dbx_business_glossary_term' = 'Forfeited Working Interest (WI) Percentage (Pct)');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `forfeiture_date` SET TAGS ('dbx_business_glossary_term' = 'Forfeiture Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `forfeiture_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Forfeiture Risk Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `joa_default_clause_reference` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Default Clause Reference');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `legal_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `legal_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Case Reference');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `non_defaulting_partners_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Defaulting Partners Notified Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `notice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Notice Delivery Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `notice_delivery_method` SET TAGS ('dbx_value_regex' = 'certified_mail|courier|email|hand_delivery|registered_post');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `notice_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Notice Document Reference');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `notice_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Issue Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `nri_at_risk_pct` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) at Risk Percentage (Pct)');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `opcom_review_date` SET TAGS ('dbx_business_glossary_term' = 'Operating Committee (OPCOM) Review Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Settlement Terms');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `wi_at_risk_pct` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) at Risk Percentage (Pct)');
ALTER TABLE `oil_gas_ecm`.`venture`.`default_notice` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` SET TAGS ('dbx_subdomain' = 'venture_agreements');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `non_consent_election_id` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Election Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `afe_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Afe Budget Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `asset_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `drilling_afe_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Operating Agreement (JOA) Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `lease_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Id (Foreign Key)');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Electing Partner Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `well_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Well Asset Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `back_in_right_flag` SET TAGS ('dbx_business_glossary_term' = 'Back-In Right Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `back_in_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Back-In Trigger Event');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `election_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Election Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `election_status` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Election Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `election_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|active|recouped|reinstated|cancelled');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `jib_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Joint Interest Billing (JIB) Allocation Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `jib_allocation_method` SET TAGS ('dbx_value_regex' = 'proportional|waterfall|hybrid');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `non_consent_penalty_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Penalty Multiplier');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `non_consent_share_cost` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Share Cost');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `nri_forfeited_percent` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Interest (NRI) Forfeited Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `operation_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Operation Cost Estimate');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `operation_type` SET TAGS ('dbx_value_regex' = 'drilling|workover|completion|facility|recompletion|sidetrack');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `penalty_recoupment_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Recoupment Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `recouped_amount_to_date` SET TAGS ('dbx_business_glossary_term' = 'Recouped Amount to Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `recoupment_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Completion Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `recoupment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Start Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `reinstatement_date` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `reinstatement_status` SET TAGS ('dbx_business_glossary_term' = 'Reinstatement Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `reinstatement_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|reinstated|partial');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `remaining_recoupment_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Recoupment Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `sec_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Disclosure Required Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `oil_gas_ecm`.`venture`.`non_consent_election` ALTER COLUMN `wi_forfeited_percent` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Forfeited Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` SET TAGS ('dbx_subdomain' = 'venture_agreements');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `abandonment_liability_allocation` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Liability Allocation');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `abandonment_liability_allocation` SET TAGS ('dbx_value_regex' = 'proportional_to_wi|operator_responsible|government_responsible|shared_equally|negotiated');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `afe_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure (AFE) Approval Required Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `agreement_type_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Description');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `agreement_type_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `agreement_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|under_review');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `applicable_jurisdictions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Jurisdictions');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `cash_call_mechanism_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash Call Mechanism Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `copas_billing_code_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Council of Petroleum Accountants Societies (COPAS) Billing Code Applicable Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `cost_recovery_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Applicable Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `default_overhead_rate_method` SET TAGS ('dbx_business_glossary_term' = 'Default Overhead Rate Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `default_overhead_rate_method` SET TAGS ('dbx_value_regex' = 'fixed_percentage|actual_cost|copas_rate|negotiated|not_applicable');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'arbitration|litigation|expert_determination|mediation|opcom_vote|not_specified');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `environmental_compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Standard');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `governing_body_standard` SET TAGS ('dbx_business_glossary_term' = 'Governing Body Standard');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `local_content_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Local Content Requirement Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `non_consent_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Consent Provision Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `operator_designation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator Designation Required Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `profit_split_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Profit Split Applicable Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `ring_fencing_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Ring Fencing Applicable Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `sec_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Securities and Exchange Commission (SEC) Disclosure Required Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `transfer_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Restriction Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `transfer_restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|preferential_right|operator_consent|government_approval|prohibited');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `type_category` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Category');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `type_category` SET TAGS ('dbx_value_regex' = 'operating_agreement|fiscal_agreement|transfer_agreement|unitization_agreement|financing_agreement|other');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `type_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Name');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `typical_term_length_years` SET TAGS ('dbx_business_glossary_term' = 'Typical Term Length (Years)');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `working_interest_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Working Interest (WI) Allocation Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`agreement_type` ALTER COLUMN `working_interest_allocation_method` SET TAGS ('dbx_value_regex' = 'fixed_percentage|sliding_scale|production_based|cost_based|not_applicable');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` SET TAGS ('dbx_subdomain' = 'venture_agreements');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` SET TAGS ('dbx_association_edges' = 'venture.joa,procurement.procurement_contract');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ALTER COLUMN `joa_contract_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'JOA Contract Allocation ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Contract Allocation - Procurement Contract Id');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Contract Allocation - Joa Id');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ALTER COLUMN `afe_reference_number` SET TAGS ('dbx_business_glossary_term' = 'AFE Reference Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ALTER COLUMN `billing_method` SET TAGS ('dbx_business_glossary_term' = 'Billing Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ALTER COLUMN `cost_recovery_eligible` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Eligible');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Created Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Expiry Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_contract_allocation` ALTER COLUMN `overhead_rate` SET TAGS ('dbx_business_glossary_term' = 'Overhead Rate');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` SET TAGS ('dbx_subdomain' = 'venture_agreements');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` SET TAGS ('dbx_association_edges' = 'venture.joa,finance.wbs_element');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ALTER COLUMN `joa_wbs_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'JOA WBS Allocation ID');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ALTER COLUMN `joa_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Wbs Allocation - Joa Id');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Joa Wbs Allocation - Wbs Element Id');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ALTER COLUMN `afe_reference_number` SET TAGS ('dbx_business_glossary_term' = 'AFE Reference Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ALTER COLUMN `budget_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Amount');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ALTER COLUMN `capitalization_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Created Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Expiry Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ALTER COLUMN `settlement_rule_override` SET TAGS ('dbx_business_glossary_term' = 'Settlement Rule Override');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ALTER COLUMN `work_program_phase` SET TAGS ('dbx_business_glossary_term' = 'Work Program Phase');
ALTER TABLE `oil_gas_ecm`.`venture`.`joa_wbs_allocation` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` SET TAGS ('dbx_subdomain' = 'partner_finance');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` SET TAGS ('dbx_association_edges' = 'venture.partner,procurement.vendor');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `partner_vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Vendor Qualification - Partner Vendor Qualification Id');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Vendor Qualification - Vendor Id');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Vendor Qualification - Venture Partner Id');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `approved_by_title` SET TAGS ('dbx_business_glossary_term' = 'Approved By Title');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `approved_scope` SET TAGS ('dbx_business_glossary_term' = 'Approved Scope');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `contract_value_limit` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Limit');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `contract_value_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Limit Currency');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `hse_compliance_verified` SET TAGS ('dbx_business_glossary_term' = 'HSE Compliance Verified');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_vendor_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` SET TAGS ('dbx_subdomain' = 'partner_finance');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` SET TAGS ('dbx_association_edges' = 'venture.partner,finance.cost_center');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `partner_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Cost Allocation Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Partner Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure Number');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `billing_allocation_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Allocation Indicator');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Expiry Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_cost_allocation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Creator');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` SET TAGS ('dbx_subdomain' = 'partner_finance');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` SET TAGS ('dbx_association_edges' = 'venture.partner,finance.gl_account');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ALTER COLUMN `partner_account_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Account Assignment Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Venture Partner Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ALTER COLUMN `account_assignment_rule` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Rule');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ALTER COLUMN `default_credit_account` SET TAGS ('dbx_business_glossary_term' = 'Default Credit Account Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ALTER COLUMN `default_debit_account` SET TAGS ('dbx_business_glossary_term' = 'Default Debit Account Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ALTER COLUMN `partner_account_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Account Type');
ALTER TABLE `oil_gas_ecm`.`venture`.`partner_account_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` SET TAGS ('dbx_subdomain' = 'operational_governance');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` SET TAGS ('dbx_association_edges' = 'venture.partner,compliance.regulatory_filing');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `filing_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Participation Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `compliance_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Participation - Regulatory Filing Id');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Participation - Venture Partner Id');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `approval_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Approving Contact Email');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `approval_contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `approval_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Approving Contact Name');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `approval_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `approval_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Partner Approval Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Approval Status');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Partner Comments');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `partner_role` SET TAGS ('dbx_business_glossary_term' = 'Partner Role in Filing');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `signatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Signatory Requirement Flag');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Partner Submission Date');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `oil_gas_ecm`.`venture`.`filing_participation` ALTER COLUMN `working_interest_percentage` SET TAGS ('dbx_business_glossary_term' = 'Working Interest Percentage');
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` SET TAGS ('dbx_subdomain' = 'venture_agreements');
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` ALTER COLUMN `joint_venture_id` SET TAGS ('dbx_business_glossary_term' = 'Joint Venture Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`joint_venture` ALTER COLUMN `parent_joint_venture_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_batch` SET TAGS ('dbx_subdomain' = 'partner_finance');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_batch` ALTER COLUMN `jib_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Jib Batch Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`jib_batch` ALTER COLUMN `parent_jib_batch_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `oil_gas_ecm`.`venture`.`concession` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `oil_gas_ecm`.`venture`.`concession` SET TAGS ('dbx_subdomain' = 'venture_agreements');
ALTER TABLE `oil_gas_ecm`.`venture`.`concession` ALTER COLUMN `concession_id` SET TAGS ('dbx_business_glossary_term' = 'Concession Identifier');
ALTER TABLE `oil_gas_ecm`.`venture`.`concession` ALTER COLUMN `parent_concession_id` SET TAGS ('dbx_self_ref_fk' = 'true');
