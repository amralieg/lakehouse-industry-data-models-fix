-- Schema for Domain: customer | Business: Mining | Version: v1_mvm
-- Generated on: 2026-05-05 14:20:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`customer` COMMENT 'Single source of truth for all commodity buyers, offtake counterparties, and trading partners including steel mills, smelters, energy companies, and commodity traders. Manages customer profiles, credit limits, delivery destinations, contract terms, and commercial relationship hierarchies.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`customer`.`counterparty` (
    `counterparty_id` BIGINT COMMENT 'Unique identifier for the commodity buyer, offtake counterparty, or trading partner. Primary key for the counterparty master record.',
    `business_unit_id` BIGINT COMMENT 'Foreign key linking to finance.business_unit. Business justification: Mining companies assign counterparties to business units (e.g., Iron Ore BU, Copper BU) for commercial P&L reporting, relationship ownership, and sales volume tracking by commodity division. A mining ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Revenue recognition, tax reporting, and intercompany accounting in mining require knowing which legal entity (e.g., Australian subsidiary vs. Singapore trading entity) owns the counterparty relationsh',
    `parent_counterparty_id` BIGINT COMMENT 'Identifier of the parent or ultimate holding company if this counterparty is part of a corporate group. Enables consolidated credit management and group-level reporting.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to customer.payment_term. Business justification: counterparty has a payment_terms_days INT field representing the default payment terms for the counterparty. The payment_term table is the authoritative reference for payment term definitions. Normali',
    `profit_centre_id` BIGINT COMMENT 'Foreign key linking to finance.profit_centre. Business justification: Revenue attribution and segment profitability reporting require linking customers to profit centres. Mining companies must track which customers drive profit centre performance for strategic account m',
    `abn` STRING COMMENT '11-digit Australian Business Number issued by the Australian Taxation Office for entities registered in Australia.. Valid values are `^[0-9]{11}$`',
    `acn` STRING COMMENT '9-digit Australian Company Number issued by ASIC to companies registered under the Corporations Act 2001.. Valid values are `^[0-9]{9}$`',
    `classification` STRING COMMENT 'Business classification of the counterparty based on their primary industry and role in the commodity supply chain. Determines applicable commercial terms and risk profiles.. Valid values are `steel_mill|smelter|refinery|energy_company|commodity_trader|end_user`',
    `communication_language` STRING COMMENT 'Two-letter ISO language code representing the counterpartys preferred language for contracts, invoices, and commercial correspondence.. Valid values are `^[a-z]{2}$`',
    `counterparty_status` STRING COMMENT 'Current operational status of the counterparty relationship. Active counterparties are eligible for new transactions; suspended or blacklisted counterparties are restricted.. Valid values are `active|inactive|suspended|under_review|blacklisted`',
    `country_of_incorporation` STRING COMMENT 'Three-letter ISO country code representing the jurisdiction where the counterparty is legally incorporated or registered.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the counterparty master record was first created in the system. Supports audit trail and data lineage tracking.',
    `credit_limit_usd` DECIMAL(18,2) COMMENT 'Maximum credit exposure limit approved for the counterparty, expressed in United States Dollars. Governs the total value of outstanding receivables and open orders.',
    `credit_rating` STRING COMMENT 'Current credit rating assigned to the counterparty by the specified rating agency. Influences credit limits, payment terms, and security requirements.',
    `credit_rating_agency` STRING COMMENT 'Name of the credit rating agency that issued the counterpartys credit rating. Used for credit risk assessment and exposure management.. Valid values are `SP|Moodys|Fitch|DBRS|Internal`',
    `duns_number` STRING COMMENT '9-digit unique identifier assigned by Dun & Bradstreet for global business entity identification and credit assessment.. Valid values are `^[0-9]{9}$`',
    `effective_from_date` DATE COMMENT 'Date from which the counterparty relationship became active and eligible for commodity transactions. Marks the start of the commercial relationship lifecycle.',
    `effective_to_date` DATE COMMENT 'Date when the counterparty relationship was terminated or suspended. Null for active relationships. Used for historical analysis and compliance reporting.',
    `incoterm_preference` STRING COMMENT 'Preferred Incoterm for commodity sales contracts. FOB (Free on Board) and CIF (Cost Insurance and Freight) are most common in mining. Defines responsibility for freight, insurance, and risk transfer.. Valid values are `FOB|CFR|CIF|DAP|DDP`',
    `invoice_delivery_method` STRING COMMENT 'Preferred method for delivering invoices to the counterparty. EDI and portal integrations enable automated accounts payable processing.. Valid values are `email|edi|portal|mail`',
    `is_sanctioned_entity` BOOLEAN COMMENT 'Boolean flag indicating whether the counterparty appears on any international sanctions lists (OFAC, UN, EU). True indicates the entity is sanctioned and transactions are prohibited.',
    `kyc_completion_date` DATE COMMENT 'Date when the most recent KYC due diligence process was successfully completed. Used to track KYC refresh requirements.',
    `kyc_expiry_date` DATE COMMENT 'Date when the current KYC certification expires and requires renewal. Typically 12-24 months from completion date depending on risk classification.',
    `kyc_status` STRING COMMENT 'Current status of the Know Your Customer due diligence process. Completed KYC is mandatory before executing commodity sales contracts.. Valid values are `not_started|in_progress|completed|expired|failed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the counterparty master record was most recently updated. Tracks data currency and supports change data capture processes.',
    `legal_name` STRING COMMENT 'Full registered legal name of the counterparty as it appears on incorporation documents and contracts. Used for legal agreements and regulatory reporting.',
    `lei_code` STRING COMMENT '20-character alphanumeric Legal Entity Identifier code used for financial transaction reporting and regulatory compliance.. Valid values are `^[A-Z0-9]{20}$`',
    `preferred_commodity_grades` STRING COMMENT 'Comma-separated list of preferred mineral grades or product specifications that the counterparty typically purchases. Examples: 62% Fe iron ore fines, 99.99% copper cathode, premium coking coal.',
    `preferred_discharge_ports` STRING COMMENT 'Comma-separated list of preferred destination ports where the counterparty receives commodity deliveries. Aligns with their processing facilities and distribution networks.',
    `preferred_loading_ports` STRING COMMENT 'Comma-separated list of preferred mine or port loading locations for commodity shipments. Reflects counterpartys logistics network and freight optimization preferences.',
    `preferred_vessel_size_dwt` STRING COMMENT 'Preferred shipping vessel size category for bulk commodity deliveries, based on port infrastructure and logistics capabilities. Influences freight terms and delivery scheduling.. Valid values are `handysize|handymax|panamax|capesize|vloc`',
    `primary_contact_email` STRING COMMENT 'Primary email address for commercial communications with the counterparty. Used for contract correspondence, invoices, and operational notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the counterparty, including country code. Used for urgent commercial and operational communications.',
    `registered_address_line1` STRING COMMENT 'First line of the official registered address of the counterparty as recorded with the incorporation authority.',
    `registered_address_line2` STRING COMMENT 'Second line of the official registered address, typically containing building, suite, or floor information.',
    `registered_city` STRING COMMENT 'City or locality component of the counterpartys registered address.',
    `registered_country` STRING COMMENT 'Three-letter ISO country code for the country component of the counterpartys registered address.. Valid values are `^[A-Z]{3}$`',
    `registered_postal_code` STRING COMMENT 'Postal or ZIP code component of the counterpartys registered address.',
    `registered_state_province` STRING COMMENT 'State, province, or administrative region component of the counterpartys registered address.',
    `reporting_format_preference` STRING COMMENT 'Preferred format for delivery of commercial reports, certificates of analysis, and shipping documentation. Supports integration with counterpartys procurement systems.. Valid values are `pdf|excel|xml|edi|api`',
    `tax_identification_number` STRING COMMENT 'Tax identification number or VAT registration number issued by the counterpartys tax authority. Required for tax reporting and withholding compliance.',
    `trading_name` STRING COMMENT 'Commercial trading name or brand name used by the counterparty in day-to-day business operations. May differ from legal name.',
    CONSTRAINT pk_counterparty PRIMARY KEY(`counterparty_id`)
) COMMENT 'Master record for all commodity buyers, offtake counterparties, and trading partners including steel mills, smelters, energy companies, and commodity traders. Single source of truth for counterparty identity, legal entity details (ABN/ACN, DUNS number), country of incorporation, registered address, credit rating, KYC status, commercial classification, and operational preferences (preferred commodity grades, vessel sizes, loading ports, communication language, reporting format, invoice delivery method, relationship manager assignment). Includes counterparty-specific commercial and logistics preferences that drive tailored account management. Primary anchor entity for the customer domain in mining commodity sales.';

CREATE OR REPLACE TABLE `mining_ecm`.`customer`.`counterparty_contact` (
    `counterparty_contact_id` BIGINT COMMENT 'Unique identifier for the counterparty contact person. Primary key for the counterparty contact entity.',
    `counterparty_id` BIGINT COMMENT 'Reference to the parent counterparty organisation (customer, offtake partner, trading entity) to which this contact belongs.',
    `contact_type` STRING COMMENT 'Classification of the contact person by their primary functional role within the counterparty organisation.. Valid values are `commercial|technical|logistics|finance|legal|executive`',
    `counterparty_contact_status` STRING COMMENT 'Current lifecycle status of the contact person within the counterparty relationship. Active contacts are available for business communications; inactive contacts have left the organisation or role.. Valid values are `active|inactive|suspended|on_leave`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this contact record was first created in the system.',
    `credit_approval_authority` BOOLEAN COMMENT 'Indicates whether this contact person has authority to approve credit terms, payment schedules, or financial arrangements.',
    `department` STRING COMMENT 'Organisational department or division to which the contact person belongs (e.g., Procurement, Trading, Operations, Finance).',
    `effective_from_date` DATE COMMENT 'Date from which this contact person became active in their role with the counterparty organisation.',
    `effective_to_date` DATE COMMENT 'Date on which this contact person ceased to be active in their role, if applicable. Null for currently active contacts.',
    `email_address` STRING COMMENT 'Primary business email address for the contact person. Used for commercial correspondence, contract negotiations, and operational communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Facsimile number for the contact person, if applicable for formal document transmission.',
    `first_name` STRING COMMENT 'Given name of the contact person.',
    `full_name` STRING COMMENT 'Complete name of the contact person as it should appear in formal correspondence and documentation.',
    `is_decision_maker` BOOLEAN COMMENT 'Indicates whether this contact person has authority to make binding commercial decisions on behalf of the counterparty organisation.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact person is the primary or main point of contact for the counterparty organisation.',
    `job_title` STRING COMMENT 'Official position or role title of the contact person within their organisation.',
    `last_contact_date` DATE COMMENT 'Date of the most recent business communication or interaction with this contact person.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who most recently modified this contact record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this contact record was most recently updated.',
    `last_name` STRING COMMENT 'Family name or surname of the contact person.',
    `logistics_coordinator` BOOLEAN COMMENT 'Indicates whether this contact person coordinates shipping, delivery schedules, and logistics arrangements.',
    `middle_name` STRING COMMENT 'Middle name or initial of the contact person, if applicable.',
    `mobile_number` STRING COMMENT 'Mobile or cellular telephone number for the contact person, used for urgent communications and field coordination.',
    `notes` STRING COMMENT 'Free-text field for recording additional information about the contact person, including communication preferences, relationship history, or special considerations.',
    `phone_number` STRING COMMENT 'Primary business telephone number for the contact person, including country and area codes.',
    `preferred_communication_method` STRING COMMENT 'The contact persons preferred channel for business communications and correspondence.. Valid values are `email|phone|mobile|fax|portal`',
    `preferred_language` STRING COMMENT 'ISO 639-1 two-letter language code representing the contact persons preferred language for business communications (e.g., EN, ZH, ES, PT, JA).',
    `salutation` STRING COMMENT 'Formal title or honorific used when addressing the contact person.. Valid values are `Mr|Ms|Mrs|Dr|Prof|Mx`',
    `signing_authority` BOOLEAN COMMENT 'Indicates whether this contact person has legal authority to sign contracts, purchase orders, or other binding commercial documents.',
    `technical_liaison` BOOLEAN COMMENT 'Indicates whether this contact person serves as the technical liaison for product specifications, quality requirements, and technical compliance matters.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the contact persons primary business location, used for scheduling meetings and coordinating communications across global operations.',
    `created_by` STRING COMMENT 'User identifier of the person who created this contact record.',
    CONSTRAINT pk_counterparty_contact PRIMARY KEY(`counterparty_contact_id`)
) COMMENT 'Individual contact persons associated with a counterparty organisation, including commercial representatives, technical liaisons, logistics coordinators, and finance contacts. Tracks name, role, department, communication preferences, and active status for each contact at a buyer or trading partner entity.';

CREATE OR REPLACE TABLE `mining_ecm`.`customer`.`delivery_destination` (
    `delivery_destination_id` BIGINT COMMENT 'Unique identifier for the delivery destination record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Delivery destinations (ports, customer facilities) incur specific logistics costs (stevedoring, demurrage, handling) that must be allocated to cost centres for accurate delivered cost calculation, AIS',
    `counterparty_id` BIGINT COMMENT 'Foreign key reference to the customer entity that owns or operates this delivery destination.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Mining operations track which vendors operate/own discharge ports and loading facilities for inbound materials (explosives, fuel, consumables). Required for vendor performance tracking by location, fr',
    `address_line_1` STRING COMMENT 'Primary street address or location descriptor for the delivery destination facility.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building, terminal, or berth number.',
    `berth_name` STRING COMMENT 'Specific berth or wharf name within the port terminal where vessels dock for loading or unloading. Null for non-maritime destinations.',
    `berth_number` STRING COMMENT 'Alphanumeric identifier for the specific berth position. Null for non-maritime destinations.',
    `city` STRING COMMENT 'City or municipality where the delivery destination is located.',
    `commodity_types_accepted` STRING COMMENT 'Pipe-separated list of commodity types that this destination is approved to receive (e.g., iron_ore, coal, copper_concentrate, lithium_spodumene, nickel_ore). [ENUM-REF-CANDIDATE: iron_ore|coal|copper_concentrate|lithium_spodumene|lithium_hydroxide|nickel_ore|bauxite|manganese — promote to reference product]',
    `conveyor_system_available` BOOLEAN COMMENT 'Indicates whether the destination has conveyor belt infrastructure for direct commodity transfer.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the delivery destination is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery destination record was first created in the system.',
    `customs_clearance_available` BOOLEAN COMMENT 'Indicates whether customs clearance services are available at this destination for international shipments.',
    `delivery_destination_status` STRING COMMENT 'Current operational status of the delivery destination indicating whether it is available for commodity shipments.. Valid values are `active|inactive|suspended|under_construction|decommissioned`',
    `destination_code` STRING COMMENT 'Unique business identifier for the delivery destination, typically a port code, terminal code, or facility identifier used in shipping documentation and logistics systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `destination_name` STRING COMMENT 'Full business name of the delivery destination (e.g., Port of Qingdao Terminal 3, Rio Tinto Smelter Intake Point, Baosteel Stockyard).',
    `destination_type` STRING COMMENT 'Classification of the delivery destination based on facility type and operational purpose.. Valid values are `port_terminal|smelter_intake|power_station_stockyard|warehouse|rail_siding|ship_berth`',
    `effective_from_date` DATE COMMENT 'Date from which this delivery destination became active and approved for commodity shipments.',
    `effective_to_date` DATE COMMENT 'Date until which this delivery destination remains active. Null for indefinite destinations.',
    `environmental_restrictions` STRING COMMENT 'Description of any environmental restrictions, dust control requirements, or operational constraints applicable to this destination.',
    `incoterms_applicable` STRING COMMENT 'Pipe-separated list of International Commercial Terms (Incoterms) applicable to this destination (e.g., FOB, CIF, CFR, DAP, DDP). [ENUM-REF-CANDIDATE: FOB|CIF|CFR|DAP|DDP|EXW|FCA|CPT|CIP|DAT|DPU — promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery destination record was last updated.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the delivery destination in decimal degrees for logistics planning and vessel routing.',
    `loading_rate_tph` DECIMAL(18,2) COMMENT 'Typical or maximum loading rate in tonnes per hour for commodity discharge or loading operations at this destination.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the delivery destination in decimal degrees for logistics planning and vessel routing.',
    `maximum_vessel_beam_m` DECIMAL(18,2) COMMENT 'Maximum vessel beam (width) in meters that the berth can accommodate.',
    `maximum_vessel_draft_m` DECIMAL(18,2) COMMENT 'Maximum allowable vessel draft in meters that the berth or port can accommodate, critical for vessel selection and cargo planning.',
    `maximum_vessel_loa_m` DECIMAL(18,2) COMMENT 'Maximum vessel length overall (LOA) in meters that the berth can accommodate.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, or logistics constraints specific to this destination.',
    `operating_hours` STRING COMMENT 'Standard operating hours or schedule for the destination (e.g., 24/7, business_hours_only, daylight_only).',
    `port_code` STRING COMMENT 'Five-letter UN/LOCODE port identifier for maritime destinations (e.g., CNQIN for Qingdao, AUHED for Port Hedland). Null for non-port destinations.. Valid values are `^[A-Z]{5}$`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the delivery destination address.',
    `rail_access_available` BOOLEAN COMMENT 'Indicates whether the destination has direct rail access for commodity delivery.',
    `region` STRING COMMENT 'Geographic region or state/province where the destination is located (e.g., Western Australia, Shandong Province, Queensland).',
    `road_access_available` BOOLEAN COMMENT 'Indicates whether the destination has road access for truck-based commodity delivery.',
    `storage_capacity_tonnes` DECIMAL(18,2) COMMENT 'Total storage or stockpile capacity in tonnes available at the destination for commodity inventory.',
    CONSTRAINT pk_delivery_destination PRIMARY KEY(`delivery_destination_id`)
) COMMENT 'Master register of all approved delivery destinations for commodity shipments, including port terminals, smelter intake points, power station stockyards, and warehouse locations. Captures destination name, port code, country, Incoterms applicability (FOB, CIF, CFR), berth specifications, draft restrictions, and logistics constraints relevant to iron ore, coal, copper concentrate, and lithium product deliveries.';

CREATE OR REPLACE TABLE `mining_ecm`.`customer`.`credit_limit` (
    `credit_limit_id` BIGINT COMMENT 'Unique identifier for the credit limit record. Primary key for the credit limit entity.',
    `counterparty_id` BIGINT COMMENT 'Reference to the commodity buyer, offtake counterparty, or trading partner to whom this credit limit is assigned. Links to the customer master data.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Credit limits in mining are granted by a specific legal entity — the entity whose balance sheet carries the credit exposure. Consolidated credit risk reporting, IFRS 9 expected credit loss calculation',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to customer.payment_term. Business justification: credit_limit contains payment_terms_days, discount_days, discount_percentage, late_payment_penalty_rate, and payment_method — all of which are fully defined in the payment_term reference table (paymen',
    `approval_authority` STRING COMMENT 'Name or title of the individual, committee, or governance body that approved this credit limit. Examples include Chief Financial Officer (CFO), Credit Committee, Board of Directors, or Regional Credit Manager. Provides audit trail for credit limit authorization.',
    `approval_date` DATE COMMENT 'Date on which the credit limit was formally approved by the designated approval authority. Establishes the authorization date for audit and compliance purposes.',
    `available_credit` DECIMAL(18,2) COMMENT 'Remaining credit capacity available for new transactions. Calculated as limit_amount minus utilisation_amount. Negative values indicate over-limit exposure requiring management intervention.',
    `collateral_amount` DECIMAL(18,2) COMMENT 'Value of the collateral or credit enhancement securing this credit limit. Typically expressed in the same currency as the credit limit. For parent guarantees this may be the guaranteed amount, for standby LCs this is the LC face value.',
    `collateral_reference` STRING COMMENT 'Reference number or identifier for the collateral instrument securing this credit limit. For standby LCs this is the LC number, for guarantees this is the guarantee reference, for cash deposits this is the deposit account reference.',
    `collateral_type` STRING COMMENT 'Type of credit enhancement or collateral arrangement securing the credit limit. Parent guarantees are common for subsidiary buyers, standby letters of credit (LC) provide bank-backed security, cash deposits are held as security, bank guarantees are issued by financial institutions, insurance bonds are provided by credit insurers, and asset pledges involve physical or financial assets as security. [ENUM-REF-CANDIDATE: none|parent_guarantee|standby_lc|cash_deposit|bank_guarantee|insurance_bond|asset_pledge — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this credit limit record was first created in the system. Provides audit trail for record creation.',
    `credit_limit_number` STRING COMMENT 'Business identifier for the credit limit agreement. Externally visible reference number used in credit management communications and approvals.. Valid values are `^CL-[0-9]{8}$`',
    `credit_limit_status` STRING COMMENT 'Current lifecycle status of the credit limit. Draft limits are being prepared, pending approval limits await credit committee authorization, active limits are in force, suspended limits are temporarily blocked due to payment issues or risk concerns, expired limits have passed their validity date, cancelled limits have been terminated, and under review limits are being reassessed due to changed circumstances. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|cancelled|under_review — 7 candidates stripped; promote to reference product]',
    `credit_limit_type` STRING COMMENT 'Classification of the credit limit based on its purpose and duration. Master limits are ongoing, temporary limits are short-term extensions, project-specific limits are tied to individual mining projects or shipments, seasonal limits accommodate cyclical demand, spot trade limits cover one-off transactions, and offtake agreement limits are tied to long-term supply contracts.. Valid values are `master_limit|temporary_limit|project_specific|seasonal_limit|spot_trade_limit|offtake_agreement_limit`',
    `credit_rating` STRING COMMENT 'External or internal credit rating assigned to the counterparty that forms the basis for the credit limit determination. Ratings follow standard agency notation (AAA highest, D default, NR not rated). May be sourced from agencies like Moodys, S&P, Fitch, or internal credit risk models. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D|NR — 11 candidates stripped; promote to reference product]',
    `credit_rating_agency` STRING COMMENT 'Name of the credit rating agency or internal risk assessment team that provided the credit rating. Examples include Moodys, Standard & Poors, Fitch Ratings, or Internal Credit Risk Committee.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the credit limit is denominated. Common currencies for mining commodity trading include USD, EUR, CNY, JPY, and AUD.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date from which the credit limit becomes active and enforceable. Shipments and invoices on or after this date are subject to this credit limit.',
    `expiry_date` DATE COMMENT 'Date on which the credit limit ceases to be valid. Nullable for open-ended master limits that remain in force until explicitly revised or cancelled.',
    `insurance_coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of the credit limit covered by credit insurance. Typically ranges from 80% to 95%, with the mining company retaining a deductible or co-insurance portion to align incentives for credit risk management.',
    `insurance_policy_number` STRING COMMENT 'Reference number for the credit insurance policy covering this counterparty exposure, if applicable. Credit insurance protects against non-payment risk and is common for high-value or high-risk commodity trading relationships.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review of this credit limit. Updated each time the credit limit undergoes scheduled or ad-hoc reassessment by the credit risk team.',
    `limit_amount` DECIMAL(18,2) COMMENT 'Maximum approved credit exposure amount that the counterparty is authorized to utilize. Represents the total outstanding receivables (invoiced but unpaid) that the customer may accumulate before further shipments are blocked.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this credit limit record was last modified. Updated whenever any attribute of the credit limit is changed, supporting change tracking and audit requirements.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this credit limit. Calculated based on the last review date plus the review frequency. Triggers workflow notifications to credit risk analysts.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or commentary related to this credit limit. May include details on negotiation history, special approval conditions, temporary adjustments, or risk mitigation measures.',
    `review_frequency_months` STRING COMMENT 'Number of months between scheduled reviews of this credit limit. High-risk counterparties may be reviewed quarterly (3 months), standard counterparties semi-annually (6 months), and low-risk counterparties annually (12 months). Ensures credit limits remain aligned with counterparty creditworthiness.',
    `risk_classification` STRING COMMENT 'Internal risk category assigned to the counterparty based on credit assessment, payment history, financial health, and market conditions. Low risk counterparties have strong financials and payment track record, medium risk have acceptable credit profiles, high risk require enhanced monitoring, watch list indicates deteriorating conditions, and default indicates payment failure or insolvency.. Valid values are `low_risk|medium_risk|high_risk|watch_list|default`',
    `utilisation_amount` DECIMAL(18,2) COMMENT 'Current outstanding receivables balance against this credit limit. Calculated in real-time as the sum of all unpaid invoices and open deliveries. When utilisation approaches or exceeds the limit amount, shipment blocks are triggered.',
    CONSTRAINT pk_credit_limit PRIMARY KEY(`credit_limit_id`)
) COMMENT 'Manages approved credit exposure limits and payment terms assigned to each counterparty, including total credit limit amount, currency, effective/expiry dates, credit rating basis, collateral arrangements (parent company guarantees, standby LCs), approval authority, payment days from B/L date, payment method (TT, LC, documentary collection), discount terms, and late payment penalties. Tracks real-time utilisation against limit and supports credit risk management for commodity trading and offtake agreements. Aligned with SAP S/4HANA credit management module.';

CREATE OR REPLACE TABLE `mining_ecm`.`customer`.`credit_review` (
    `credit_review_id` BIGINT COMMENT 'Unique identifier for the credit review record. Primary key.',
    `counterparty_id` BIGINT COMMENT 'Identifier of the counterparty (steel mill, smelter, energy company, commodity trader) being reviewed.',
    `credit_limit_id` BIGINT COMMENT 'Foreign key linking to customer.credit_limit. Business justification: A credit review is conducted against a specific credit limit record. The credit_review table captures approved_credit_limit_usd, recommended_credit_limit_usd, and current_credit_limit_usd — all of whi',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to customer.payment_term. Business justification: credit_review has a payment_terms STRING field capturing the payment terms recommended or approved during the review. Normalizing this to a FK against the payment_term reference table ensures consiste',
    `approval_date` DATE COMMENT 'The date on which the credit review was formally approved by the credit committee or authorized approver.',
    `approval_notes` STRING COMMENT 'Additional notes or conditions recorded by the credit committee or approver at the time of approval, including any modifications to the recommendation or special conditions.',
    `approval_outcome` STRING COMMENT 'The final decision by the credit committee: approved as recommended (no changes), approved with modifications (limit or terms adjusted), rejected (recommendation not accepted), or deferred (requires additional information).. Valid values are `approved_as_recommended|approved_with_modifications|rejected|deferred`',
    `approved_credit_limit_usd` DECIMAL(18,2) COMMENT 'The final approved credit limit for this counterparty in United States Dollars (USD) following credit committee approval. This becomes the new active limit upon approval.',
    `approver_name` STRING COMMENT 'Full name of the credit committee member or senior risk officer who approved the review outcome.',
    `collateral_required_flag` BOOLEAN COMMENT 'Indicates whether collateral or security is required for transactions with this counterparty (True) or not (False), based on the credit review outcome.',
    `collateral_type` STRING COMMENT 'The type of collateral or security required if collateral_required_flag is True: letter of credit, bank guarantee, parent company guarantee, cash deposit, none, or other.. Valid values are `letter_of_credit|bank_guarantee|parent_guarantee|cash_deposit|none|other`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this credit review record was first created in the system, for audit trail purposes.',
    `current_credit_limit_usd` DECIMAL(18,2) COMMENT 'The existing approved credit limit for this counterparty in United States Dollars (USD), representing the maximum exposure the company is willing to accept prior to this review.',
    `current_ratio` DECIMAL(18,2) COMMENT 'The counterpartys current assets divided by current liabilities, a liquidity metric indicating short-term financial health.',
    `external_credit_rating` STRING COMMENT 'The credit rating assigned by the external rating agency (e.g., Aaa, Baa2 for Moodys; AAA, BBB+ for S&P/Fitch). Free text to accommodate different agency scales.',
    `external_rating_agency` STRING COMMENT 'The primary external credit rating agency whose rating is referenced in this review (Moodys, Standard & Poors, Fitch, DBRS, Japan Credit Rating, or Other).. Valid values are `Moodys|S&P|Fitch|DBRS|JCR|Other`',
    `external_rating_date` DATE COMMENT 'The date on which the external credit rating was issued or last updated by the rating agency.',
    `financial_statement_date` DATE COMMENT 'The as-of date of the counterpartys financial statements used as the basis for the financial analysis in this credit review.',
    `interest_coverage_ratio` DECIMAL(18,2) COMMENT 'The counterpartys EBIT (Earnings Before Interest and Tax) divided by interest expense, indicating ability to service debt obligations.',
    `internal_credit_rating` STRING COMMENT 'The internal credit rating assigned to the counterparty by the mining companys credit risk team, using a scale aligned with external agency methodologies (AAA highest quality, D default). [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D — 10 candidates stripped; promote to reference product]',
    `internal_rating_outlook` STRING COMMENT 'The outlook for the internal credit rating: positive (potential upgrade), stable (no change expected), negative (potential downgrade), developing (uncertain direction).. Valid values are `positive|stable|negative|developing`',
    `leverage_ratio` DECIMAL(18,2) COMMENT 'The counterpartys total debt to equity ratio or net debt to EBITDA ratio, a key financial metric analyzed during the credit review to assess financial risk.',
    `limit_change_reason` STRING COMMENT 'Business justification for any recommended change to the credit limit, including references to financial performance, market conditions, or strategic relationship considerations.',
    `loss_given_default_pct` DECIMAL(18,2) COMMENT 'The estimated loss severity in the event of default, expressed as a percentage of exposure at default (0.00 to 100.00), used for IFRS 9 ECL calculation.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this credit review record was last modified in the system, for audit trail purposes.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic credit review of this counterparty, typically 12 months from current review for investment grade, 6 months for sub-investment grade.',
    `probability_of_default_pct` DECIMAL(18,2) COMMENT 'The estimated probability of default over a 12-month horizon, expressed as a percentage (0.00 to 100.00), used for IFRS 9 Expected Credit Loss (ECL) calculation.',
    `recommended_credit_limit_usd` DECIMAL(18,2) COMMENT 'The credit limit recommended by the credit analyst based on this review, in United States Dollars (USD). May be higher, lower, or equal to the current limit.',
    `review_date` DATE COMMENT 'The date on which the credit review was conducted or completed. Principal business event timestamp for this review.',
    `review_number` STRING COMMENT 'Business identifier for the credit review, typically formatted as CR-YYYYNNNNNN for external reference and audit trail.. Valid values are `^CR-[0-9]{6,10}$`',
    `review_status` STRING COMMENT 'Current lifecycle state of the credit review: draft (initial preparation), in_progress (under analysis), pending_approval (submitted to credit committee), approved (finalized and active), rejected (not accepted), superseded (replaced by newer review).. Valid values are `draft|in_progress|pending_approval|approved|rejected|superseded`',
    `review_type` STRING COMMENT 'Classification of the review trigger: periodic (scheduled), event-driven (material change in counterparty financials), ad-hoc (management request), annual (mandatory yearly), pre-contract (new customer onboarding), limit increase (customer requests higher exposure), or downgrade trigger (external rating agency downgrade). [ENUM-REF-CANDIDATE: periodic|event_driven|ad_hoc|annual|pre_contract|limit_increase|downgrade_trigger — 7 candidates stripped; promote to reference product]',
    `reviewer_name` STRING COMMENT 'Full name of the credit analyst or risk officer who conducted the review.',
    `risk_commentary` STRING COMMENT 'Detailed qualitative assessment of the counterpartys credit risk, including analysis of financial position, industry outlook, management quality, and any material risk factors identified during the review.',
    CONSTRAINT pk_credit_review PRIMARY KEY(`credit_review_id`)
) COMMENT 'Records periodic and event-driven credit reviews conducted for counterparties, capturing review date, reviewer, credit rating assigned, financial analysis inputs (leverage ratios, liquidity), external agency ratings (Moodys, S&P), recommended limit changes, and approval outcome. Provides an audit trail of credit decisions supporting IFRS and internal risk governance.';

CREATE OR REPLACE TABLE `mining_ecm`.`customer`.`segment` (
    `segment_id` BIGINT COMMENT 'Unique identifier for the customer segment classification record. Primary key.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Customer segments in mining are defined by commodity (e.g., Iron Ore Tier 1, Copper Mid-Market). Segment reporting, pricing strategy, and relationship management decisions are all commodity-driven',
    `counterparty_id` BIGINT COMMENT 'Reference to the customer entity being classified into this segment. Links to the customer master data.',
    `annual_volume_maximum_tonnes` DECIMAL(18,2) COMMENT 'Maximum annual offtake volume in metric tonnes that defines the upper bound of this segments volume band. Null indicates no upper limit.',
    `annual_volume_minimum_tonnes` DECIMAL(18,2) COMMENT 'Minimum annual offtake volume in metric tonnes that defines the lower bound of this segments volume band.',
    `contract_type_preference` STRING COMMENT 'Typical contract structure preference for customers in this segment. Long-Term Offtake for multi-year commitments, Annual Framework for yearly agreements, Quarterly for short-term contracts, Spot for transactional purchases, Mixed for diversified approach.. Valid values are `Long-Term Offtake|Annual Framework|Quarterly|Spot|Mixed`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the customers primary country of operation or delivery destination.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this customer segment classification record was first created in the system.',
    `credit_risk_rating` STRING COMMENT 'Internal credit risk assessment rating for this customer segment. AAA represents lowest risk, D represents default or highest risk. Used for credit limit determination and commercial terms. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D — 10 candidates stripped; promote to reference product]',
    `diversification_target_flag` BOOLEAN COMMENT 'Boolean indicator whether this customer segment is targeted for portfolio diversification efforts to reduce concentration risk. True indicates diversification target.',
    `effective_from_date` DATE COMMENT 'Date from which this customer segment classification becomes effective and applicable for commercial treatment and reporting.',
    `effective_to_date` DATE COMMENT 'Date until which this customer segment classification remains effective. Null indicates the segment is currently active with no defined end date.',
    `end_use_industry` STRING COMMENT 'Primary industry sector in which the customer operates and consumes the mineral commodities. Critical for understanding demand drivers and market positioning. [ENUM-REF-CANDIDATE: Steel|Energy|Battery Materials|Smelting|Manufacturing|Construction|Other — 7 candidates stripped; promote to reference product]',
    `geographic_region` STRING COMMENT 'Primary geographic region where the customer operates or takes delivery. Used for regional portfolio analysis and logistics planning.. Valid values are `Asia Pacific|Europe|North America|South America|Middle East|Africa`',
    `incoterm_preference` STRING COMMENT 'Preferred Incoterms delivery basis for this customer segment. FOB (Free on Board) for port delivery, CIF (Cost Insurance and Freight) for delivered pricing, CFR (Cost and Freight), DAP (Delivered at Place), DDP (Delivered Duty Paid), EXW (Ex Works) for mine gate pickup.. Valid values are `FOB|CFR|CIF|DAP|DDP|EXW`',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this customer segment classification record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this customer segment classification record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when this customer segment classification was last reviewed and validated by the commercial team.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this customer segment classification.',
    `payment_terms_category` STRING COMMENT 'Standard payment terms category applicable to this customer segment. Defines credit period and payment security requirements.. Valid values are `Advance Payment|Letter of Credit|Net 30|Net 60|Net 90|Extended Terms`',
    `pricing_strategy` STRING COMMENT 'Commercial pricing approach applied to this customer segment. Premium for strategic long-term partners, Standard for preferred customers, Competitive for market-rate buyers, Spot Market for transactional pricing, and Negotiated for bespoke arrangements.. Valid values are `Premium|Standard|Competitive|Spot Market|Negotiated`',
    `quality_specification_tier` STRING COMMENT 'Product quality specification tier typically required by customers in this segment. Premium Grade for highest purity/lowest impurities, Standard Grade for typical commercial specifications, Commercial Grade for broader tolerance ranges, Spot Grade for variable quality spot market material.. Valid values are `Premium Grade|Standard Grade|Commercial Grade|Spot Grade`',
    `relationship_manager` STRING COMMENT 'Name of the commercial relationship manager or account executive responsible for managing customers in this segment.',
    `review_frequency_months` STRING COMMENT 'Number of months between scheduled reviews of this customer segment classification. Typically 6 or 12 months for strategic segments, longer for stable spot segments.',
    `segment_code` STRING COMMENT 'Short alphanumeric code representing the segment classification for system processing and reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `segment_description` STRING COMMENT 'Detailed textual description of the customer segment, including defining characteristics, strategic rationale, and commercial treatment guidelines.',
    `segment_name` STRING COMMENT 'Human-readable name of the customer segment classification.',
    `segment_status` STRING COMMENT 'Current lifecycle status of this customer segment classification. Active indicates current use, Under Review for segments being reassessed, Suspended for temporarily inactive segments, Archived for historical segments no longer in use.. Valid values are `Active|Under Review|Suspended|Archived`',
    `service_level_tier` STRING COMMENT 'Service level commitment tier for this customer segment. Platinum receives highest priority for supply allocation, logistics coordination, and technical support. Standard receives baseline service.. Valid values are `Platinum|Gold|Silver|Bronze|Standard`',
    `strategic_priority_flag` BOOLEAN COMMENT 'Boolean indicator whether this customer segment is designated as a strategic priority for business development and relationship investment. True indicates strategic priority status.',
    `tier_classification` STRING COMMENT 'Strategic tier classification indicating the commercial importance and relationship depth. Tier 1 Strategic represents highest-value long-term partnerships, Tier 2 Preferred for regular preferred customers, Tier 3 Spot for transactional buyers, and Tier 4 Inactive for dormant relationships.. Valid values are `Tier 1 Strategic|Tier 2 Preferred|Tier 3 Spot|Tier 4 Inactive`',
    `volume_band` STRING COMMENT 'Classification of customer based on annual offtake volume ranges. Very High represents multi-million tonne buyers, High for significant volume, Medium for regular buyers, Low for small-scale, and Minimal for occasional spot purchases.. Valid values are `Very High|High|Medium|Low|Minimal`',
    `created_by` STRING COMMENT 'User identifier or system account that created this customer segment classification record.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Classification of counterparties into commercial segments for strategic account management, pricing strategy, and relationship prioritisation. Segments include tier classifications (Tier 1 strategic, Tier 2 preferred, Tier 3 spot), end-use industry (steel, energy, battery materials, smelting), geographic region, and volume band. Enables differentiated commercial treatment and portfolio analysis.';

CREATE OR REPLACE TABLE `mining_ecm`.`customer`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Unique identifier for the bank account record. Primary key.',
    `counterparty_id` BIGINT COMMENT 'Reference to the customer or counterparty who owns this bank account. Links to steel mills, smelters, energy companies, commodity traders, and other offtake partners.',
    `account_holder_name` STRING COMMENT 'Legal name of the account holder as registered with the bank. Must match customer legal name for payment reconciliation and anti-money laundering compliance.',
    `account_number` STRING COMMENT 'The bank account number used for payment processing and financial settlement. May be domestic account number or IBAN depending on jurisdiction.',
    `account_status` STRING COMMENT 'Current operational status of the bank account record. Only active accounts can be used for payment processing.. Valid values are `active|inactive|suspended|closed|pending_verification`',
    `account_type` STRING COMMENT 'Classification of the bank account type. Corporate and current accounts are most common for commodity trading settlements.. Valid values are `checking|savings|current|corporate|escrow|trust`',
    `bank_address_line1` STRING COMMENT 'First line of the bank branch physical address. Required for letter of credit documentation and compliance verification.',
    `bank_address_line2` STRING COMMENT 'Second line of the bank branch physical address for additional location details.',
    `bank_branch_name` STRING COMMENT 'Name of the specific bank branch where the account is held.',
    `bank_city` STRING COMMENT 'City where the bank branch is located.',
    `bank_country_code` STRING COMMENT 'Three-letter ISO country code of the bank location. Critical for compliance with international trade finance regulations and sanctions screening.. Valid values are `^[A-Z]{3}$`',
    `bank_name` STRING COMMENT 'Full legal name of the financial institution holding the account.',
    `bank_postal_code` STRING COMMENT 'Postal or ZIP code of the bank branch address.',
    `bank_state_province` STRING COMMENT 'State or province of the bank branch location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the account. Common currencies include USD, EUR, CNY, JPY for commodity sales settlements.. Valid values are `^[A-Z]{3}$`',
    `effective_from_date` DATE COMMENT 'Date from which this bank account becomes valid for payment processing. Supports time-bound account changes.',
    `effective_to_date` DATE COMMENT 'Date until which this bank account remains valid. Null indicates no expiration. Used for account closure or replacement scenarios.',
    `iban` STRING COMMENT 'International Bank Account Number for cross-border payments. Used primarily for European and international commodity transactions under CIF and FOB terms.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$`',
    `intermediary_bank_name` STRING COMMENT 'Name of intermediary or correspondent bank used for routing international payments when direct settlement is not available.',
    `intermediary_swift_bic_code` STRING COMMENT 'SWIFT BIC code of the intermediary bank for multi-hop international wire transfers.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this is the primary bank account for the customer. Used as default for payment routing in ERP systems.',
    `is_sanctions_screened` BOOLEAN COMMENT 'Indicates whether the bank and account holder have been screened against international sanctions lists (OFAC, UN, EU). Mandatory for international commodity trading compliance.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this bank account record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this bank account record. Critical for audit trail and change tracking.',
    `payment_method_supported` STRING COMMENT 'Pipe-separated list of payment methods supported by this account. Critical for FOB and CIF transaction settlement routing.',
    `routing_number` STRING COMMENT 'Domestic routing number for bank transfers. Format varies by country (ABA routing number in USA, sort code in UK, BSB in Australia).',
    `sanctions_screening_date` DATE COMMENT 'Date of most recent sanctions screening. Must be refreshed periodically per compliance policy.',
    `special_instructions` STRING COMMENT 'Free-text field for special payment routing instructions, reference codes, or beneficiary notifications required by the customer or bank.',
    `swift_bic_code` STRING COMMENT 'SWIFT BIC code identifying the bank and branch for international wire transfers and letter of credit processing in commodity sales.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `verification_date` DATE COMMENT 'Date when the bank account was successfully verified. Required for audit trail and compliance reporting.',
    `verification_method` STRING COMMENT 'Method used to verify the bank account authenticity and ownership.. Valid values are `micro_deposit|document_upload|third_party_service|manual_review|bank_statement`',
    `verification_status` STRING COMMENT 'Status of bank account verification process. Verified accounts have passed validation checks including test deposits or third-party verification services.. Valid values are `verified|pending|failed|not_verified`',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this bank account record.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Master record of counterparty bank account details used for payment processing, letter of credit (LC) issuance, and financial settlement of commodity sales. Captures bank name, SWIFT/BIC code, IBAN or account number, currency, country, account holder name, and verification status. Supports secure payment routing for FOB and CIF commodity transactions.';

CREATE OR REPLACE TABLE `mining_ecm`.`customer`.`payment_term` (
    `payment_term_id` BIGINT COMMENT 'Unique identifier for the payment term record. Primary key.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Payment terms in mining are defined per legal entity because different entities operate under different jurisdictions with distinct payment norms, statutory payment period requirements, and AR managem',
    `applicable_commodity_types` STRING COMMENT 'Comma-separated list of commodity types to which this payment term applies (e.g., iron_ore, copper_concentrate, coal, lithium, nickel). Null if applicable to all commodities.',
    `approval_authority_level` STRING COMMENT 'Organizational authority level required to approve the use of this payment term in a new offtake agreement. Higher-risk terms (e.g., extended payment days, open account) require senior approval.. Valid values are `standard|manager|director|cfo|board`',
    `bank_guarantee_required_flag` BOOLEAN COMMENT 'Indicates whether a bank guarantee or performance bond is required from the counterparty when this payment term is used. True if guarantee is mandatory.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment term record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credit_insurance_required_flag` BOOLEAN COMMENT 'Indicates whether credit insurance or trade finance insurance must be in place for transactions using this payment term. True if insurance is mandatory.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which payment must be made (e.g., USD, EUR, CNY, AUD). Most mining commodity contracts are denominated in USD.. Valid values are `^[A-Z]{3}$`',
    `discount_days` STRING COMMENT 'Number of days from the payment basis date within which early payment qualifies for a discount (e.g., 10 days in a 2/10 Net 30 term). Null if no early payment discount applies.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the invoice amount if payment is made within the discount days period (e.g., 2.00 for a 2% discount). Null if no discount applies.',
    `documentary_requirements` STRING COMMENT 'List of documents required to be presented for payment under this term (e.g., Bill of Lading, Commercial Invoice, Certificate of Origin, Quality Certificate, Weight Certificate). Particularly relevant for LC and documentary collection terms.',
    `effective_from_date` DATE COMMENT 'Date from which this payment term becomes valid and available for use in offtake agreements and invoicing. Format: yyyy-MM-dd.',
    `effective_to_date` DATE COMMENT 'Date until which this payment term remains valid. Null for open-ended terms. Format: yyyy-MM-dd.',
    `grace_period_days` STRING COMMENT 'Number of days after the payment due date before late payment penalties are applied. Provides a buffer period for payment processing delays. Null if no grace period applies.',
    `installment_allowed_flag` BOOLEAN COMMENT 'Indicates whether payment may be made in multiple installments rather than a single lump sum. True if installment payments are permitted under this term.',
    `installment_count` STRING COMMENT 'Number of installments into which payment may be divided if installment_allowed_flag is true. Null if installments are not allowed.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified this payment term record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payment term record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `late_payment_penalty_rate` DECIMAL(18,2) COMMENT 'Annual interest rate (percentage) applied to overdue amounts for late payment. Typically expressed as a percentage per annum (e.g., 8.00 for 8% p.a.). Null if no penalty applies.',
    `letter_of_credit_type` STRING COMMENT 'Specific type of Letter of Credit if payment_method is letter_of_credit. Irrevocable and confirmed LCs are preferred for high-value commodity transactions. Null if payment method is not LC. [ENUM-REF-CANDIDATE: irrevocable|revocable|confirmed|unconfirmed|sight|deferred|transferable|standby — 8 candidates stripped; promote to reference product]',
    `maximum_transaction_value` DECIMAL(18,2) COMMENT 'Maximum invoice or shipment value (in the currency specified by currency_code) for which this payment term may be applied without additional credit approval. Null if no maximum applies.',
    `minimum_transaction_value` DECIMAL(18,2) COMMENT 'Minimum invoice or shipment value (in the currency specified by currency_code) for which this payment term may be applied. Used to enforce stricter terms for smaller transactions. Null if no minimum applies.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or exceptions applicable to this payment term. May include references to specific customer segments or regional requirements.',
    `payment_basis` STRING COMMENT 'The reference event from which payment days are calculated. Common bases in mining commodity sales include Bill of Lading (B/L) date for FOB (Free on Board) terms and delivery date for CIF (Cost Insurance and Freight) terms.. Valid values are `invoice_date|bill_of_lading_date|shipment_date|delivery_date|month_end|custom`',
    `payment_days` STRING COMMENT 'Number of days from the reference event (e.g., Bill of Lading date, invoice date, shipment date) until payment is due. Standard terms in mining include 30, 60, 90, or 120 days.',
    `payment_method` STRING COMMENT 'The instrument or mechanism by which payment is executed. Telegraphic Transfer (TT) and Letter of Credit (LC) are most common in international commodity trading. Documentary Collection (D/C) used for established relationships.. Valid values are `telegraphic_transfer|letter_of_credit|documentary_collection|cash_in_advance|open_account|escrow`',
    `payment_priority` STRING COMMENT 'Priority level assigned to this payment term for cash flow planning and treasury operations. High priority terms (e.g., cash in advance, short-dated LCs) receive expedited processing.. Valid values are `high|medium|low|standard`',
    `payment_term_code` STRING COMMENT 'Standardized short code identifying the payment term (e.g., NET30, NET60, LC90, COD). Used as the business key across offtake agreements and invoicing systems.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `payment_term_description` STRING COMMENT 'Detailed explanation of the payment term including conditions, calculation basis, and any special clauses applicable to commodity trading.',
    `payment_term_name` STRING COMMENT 'Full descriptive name of the payment term (e.g., Net 30 Days from Bill of Lading Date, 90 Days Letter of Credit).',
    `payment_term_status` STRING COMMENT 'Current lifecycle status of the payment term. Active terms are available for use in new agreements. Deprecated terms are retained for historical reference but not available for new contracts.. Valid values are `active|inactive|suspended|deprecated`',
    `risk_rating` STRING COMMENT 'Credit and counterparty risk rating associated with this payment term. Cash in advance and confirmed LCs are low risk; extended open account terms are high risk.. Valid values are `low|medium|high|critical`',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this payment term record in the system.',
    CONSTRAINT pk_payment_term PRIMARY KEY(`payment_term_id`)
) COMMENT 'Reference data defining the payment terms applicable to counterparties and offtake agreements, including payment days (e.g., 30 days from B/L date), payment method (telegraphic transfer, letter of credit, documentary collection), currency, discount terms, and late payment penalty rates. Provides standardised payment term codes referenced across offtake agreements and invoicing.';

CREATE OR REPLACE TABLE `mining_ecm`.`customer`.`letter_of_credit` (
    `letter_of_credit_id` BIGINT COMMENT 'Unique identifier for the letter of credit record. Primary key.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Mining LCs are issued for specific commodity shipments (iron ore, copper, coal). Trade finance reporting, LC issuance workflows, and regulatory compliance all require structured commodity identificati',
    `counterparty_id` BIGINT COMMENT 'Reference to the commodity buyer or offtake counterparty who arranged this letter of credit as payment security.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to customer.bank_account. Business justification: Letters of credit are issued by the buyers bank against a specific bank account. The counterparty (buyer) has one or more bank accounts registered in the bank_account table. Linking the LC to the spe',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Letters of credit in mining trade finance are issued in favour of a specific legal entity (the beneficiary/seller). The legal entity determines which entitys banking facilities are used, which books ',
    `delivery_destination_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_destination. Business justification: Letters of credit specify loading and discharge ports for commodity shipments. Currently stored as text fields, these should reference delivery_destination master data. Loading port is the origin port',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to customer.payment_term. Business justification: letter_of_credit has a payment_terms STRING field. An LC is issued under specific payment terms (e.g., at sight, 90 days after bill of lading). Linking to the payment_term reference table normalizes t',
    `tenement_id` BIGINT COMMENT 'Foreign key linking to tenement.tenement. Business justification: Mining regulators require letters of credit as security bonds (rehabilitation bonds, expenditure security) tied to specific tenements. Treasury and compliance teams must link each LC to the tenement i',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Mining operations issue LCs to vendors for high-value procurement: capital equipment purchases, bulk explosives, long-lead mining equipment, imported consumables. Required for procurement payment secu',
    `advising_bank_name` STRING COMMENT 'Name of the financial institution that advises or confirms the letter of credit to the beneficiary (seller).',
    `advising_bank_swift_code` STRING COMMENT 'SWIFT/BIC code of the advising bank for international payment routing.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `amendment_count` STRING COMMENT 'Total number of amendments that have been made to this letter of credit since its original issuance.',
    `applicant_name` STRING COMMENT 'Legal name of the applicant (the buyer or importer) who requested the issuing bank to open this letter of credit.',
    `available_amount` DECIMAL(18,2) COMMENT 'Remaining monetary amount available for drawing under this letter of credit (LC amount minus utilised amount).',
    `beneficiary_name` STRING COMMENT 'Legal name of the beneficiary (the mining company or seller) entitled to draw payment under this letter of credit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this letter of credit record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the letter of credit amount is denominated (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `discharge_port` STRING COMMENT 'Name of the destination port or location where the commodity shipment must be discharged as specified in the letter of credit.',
    `document_requirements` STRING COMMENT 'Comprehensive list of documents required for presentation to the bank to draw payment under this letter of credit (e.g., bill of lading, commercial invoice, certificate of origin, assay certificate, packing list, insurance certificate).',
    `expiry_date` DATE COMMENT 'Date on which the letter of credit expires and can no longer be drawn upon by the beneficiary.',
    `governing_rules` STRING COMMENT 'International rules and practices governing this letter of credit (e.g., UCP 600, ISP98 for standby letters of credit, eUCP for electronic presentation).. Valid values are `UCP_600|UCP_500|ISP98|eUCP`',
    `incoterm` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the delivery terms and risk transfer point for the commodity shipment (e.g., FOB, CIF, CFR). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `issue_date` DATE COMMENT 'Date on which the letter of credit was issued by the issuing bank.',
    `issuing_bank_name` STRING COMMENT 'Name of the financial institution that issued the letter of credit on behalf of the buyer.',
    `issuing_bank_swift_code` STRING COMMENT 'SWIFT/BIC code of the issuing bank for international payment routing.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment made to this letter of credit.',
    `latest_shipment_date` DATE COMMENT 'The last permissible date by which the commodity shipment must be dispatched as stipulated in the letter of credit terms.',
    `lc_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the letter of credit available for drawing by the beneficiary.',
    `lc_number` STRING COMMENT 'The externally-known unique alphanumeric identifier assigned by the issuing bank to this letter of credit instrument.. Valid values are `^[A-Z0-9]{8,20}$`',
    `lc_type` STRING COMMENT 'Classification of the letter of credit instrument based on its terms and conditions (irrevocable, revocable, confirmed, unconfirmed, transferable, standby).. Valid values are `irrevocable|revocable|confirmed|unconfirmed|transferable|standby`',
    `letter_of_credit_status` STRING COMMENT 'Current lifecycle status of the letter of credit (draft, active, partially utilised, fully utilised, expired, cancelled).. Valid values are `draft|active|partially_utilised|fully_utilised|expired|cancelled`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this letter of credit record was last modified in the system.',
    `partial_shipment_allowed` BOOLEAN COMMENT 'Indicates whether partial shipments of the commodity are permitted under the terms of this letter of credit.',
    `payment_terms` STRING COMMENT 'Payment terms specified in the letter of credit defining when payment is due (sight payment, deferred payment, usance, acceptance).. Valid values are `sight|deferred|usance|acceptance`',
    `presentation_period_days` STRING COMMENT 'Maximum number of days after the shipment date within which documents must be presented to the bank for payment.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the commodity to be shipped under this letter of credit.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the commodity quantity (e.g., MT for metric tonnes, DMT for dry metric tonnes, WMT for wet metric tonnes).. Valid values are `MT|DMT|WMT|tonnes|kg|lbs`',
    `shipment_period_from` DATE COMMENT 'Start date of the permissible shipment period window specified in the letter of credit.',
    `shipment_period_to` DATE COMMENT 'End date of the permissible shipment period window specified in the letter of credit.',
    `tenor_days` STRING COMMENT 'Number of days after presentation of compliant documents before payment is due, applicable for deferred payment or usance letters of credit.',
    `tolerance_percentage` DECIMAL(18,2) COMMENT 'Permissible variance percentage (plus or minus) allowed for quantity and/or amount under the letter of credit terms.',
    `transhipment_allowed` BOOLEAN COMMENT 'Indicates whether transhipment (transfer of goods from one vessel to another during transit) is permitted under this letter of credit.',
    `utilised_amount` DECIMAL(18,2) COMMENT 'Cumulative monetary amount that has been drawn or utilised against this letter of credit to date.',
    CONSTRAINT pk_letter_of_credit PRIMARY KEY(`letter_of_credit_id`)
) COMMENT 'Manages letters of credit (LC) issued by buyers as payment security for commodity shipments, capturing LC number, issuing bank, advising bank, LC amount, currency, expiry date, shipment period, document requirements (bill of lading, certificate of origin, assay certificate), amendment history, and utilisation status. Critical for managing payment risk in international commodity trade.';

CREATE OR REPLACE TABLE `mining_ecm`.`customer`.`kyc_record` (
    `kyc_record_id` BIGINT COMMENT 'Unique identifier for the KYC compliance record.',
    `counterparty_id` BIGINT COMMENT 'Reference to the customer or trading partner entity this KYC record applies to.',
    `adverse_media_screening_date` DATE COMMENT 'Date when the most recent adverse media screening was performed.',
    `adverse_media_screening_result` STRING COMMENT 'Result of screening for negative news or adverse media coverage related to the counterparty, including allegations of financial crime, corruption, or sanctions violations.. Valid values are `clear|adverse_found|under_investigation|not_screened`',
    `aml_risk_rating` STRING COMMENT 'Overall AML risk rating assigned to the counterparty based on risk assessment factors including jurisdiction, business nature, transaction patterns, and PEP status.. Valid values are `low|medium|high|very_high`',
    `approval_date` DATE COMMENT 'Date when the KYC record was formally approved by the compliance officer.',
    `beneficial_ownership_documented` BOOLEAN COMMENT 'Indicates whether beneficial ownership documentation has been collected and verified, identifying individuals who ultimately own or control the counterparty entity.',
    `beneficial_ownership_verification_date` DATE COMMENT 'Date when beneficial ownership documentation was last verified.',
    `business_relationship_purpose` STRING COMMENT 'Documented purpose and intended nature of the business relationship with the counterparty, including expected transaction types and volumes.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding the KYC verification process, risk factors, or special considerations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this KYC record was first created in the system.',
    `document_repository_reference` STRING COMMENT 'Reference identifier or path to the secure document repository where KYC supporting documents are stored.',
    `documentation_complete` BOOLEAN COMMENT 'Indicates whether all required KYC documentation has been collected and is complete.',
    `due_diligence_level` STRING COMMENT 'Level of customer due diligence applied based on risk assessment: standard for normal risk, enhanced for high-risk counterparties, simplified for low-risk entities.. Valid values are `standard|enhanced|simplified`',
    `expiry_date` DATE COMMENT 'Date when the current KYC verification expires and requires renewal.',
    `identity_verification_method` STRING COMMENT 'Method used to verify the identity of the counterparty: document review, in-person verification, electronic verification, or third-party verification service.. Valid values are `document_review|in_person|electronic|third_party_verification|not_verified`',
    `jurisdiction_risk_level` STRING COMMENT 'Risk level associated with the counterpartys country of incorporation or primary operating jurisdiction, based on FATF assessments and international AML standards.. Valid values are `low|medium|high|very_high`',
    `kyc_status` STRING COMMENT 'Current status of the KYC verification process for this counterparty.. Valid values are `pending|verified|rejected|expired|under_review|suspended`',
    `last_transaction_review_date` DATE COMMENT 'Date when the counterpartys transaction activity was last reviewed as part of ongoing monitoring.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic KYC review, determined by the due diligence level and risk rating.',
    `ongoing_monitoring_flag` BOOLEAN COMMENT 'Indicates whether the counterparty is subject to ongoing transaction monitoring and periodic review as part of continuous KYC compliance.',
    `pep_classification` STRING COMMENT 'Classification of the PEP status: domestic PEP, foreign PEP, international organization official, family member of PEP, close associate of PEP, or not applicable.. Valid values are `domestic|foreign|international_organization|family_member|close_associate|not_applicable`',
    `pep_flag` BOOLEAN COMMENT 'Indicates whether the counterparty or its beneficial owners are identified as Politically Exposed Persons, requiring enhanced due diligence.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether this KYC record requires reporting to regulatory authorities due to suspicious activity or high-risk classification.',
    `review_frequency_months` STRING COMMENT 'Frequency in months for periodic KYC reviews based on risk rating: typically 12 months for standard, 6 months for enhanced due diligence.',
    `risk_assessment_date` DATE COMMENT 'Date when the AML risk assessment was last performed or updated.',
    `sanctions_screening_date` DATE COMMENT 'Date when the most recent sanctions screening was performed.',
    `sanctions_screening_result` STRING COMMENT 'Result of screening against international sanctions lists including OFAC, UN, EU, and other jurisdictional sanctions databases.. Valid values are `clear|match|potential_match|not_screened`',
    `source_of_funds_verified` BOOLEAN COMMENT 'Indicates whether the source of funds for the counterparty has been verified as part of enhanced due diligence.',
    `source_of_wealth_verified` BOOLEAN COMMENT 'Indicates whether the source of wealth for the counterparty has been verified, typically required for high-risk or PEP counterparties.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this KYC record was last updated or modified.',
    `verification_date` DATE COMMENT 'Date when the KYC verification was completed and approved.',
    CONSTRAINT pk_kyc_record PRIMARY KEY(`kyc_record_id`)
) COMMENT 'Know Your Customer (KYC) compliance record for each counterparty, capturing KYC status, verification date, due diligence level (standard, enhanced), sanctions screening result, beneficial ownership documentation, politically exposed person (PEP) flag, anti-money laundering (AML) risk rating, and next review date. Supports regulatory compliance obligations under FATF, OFAC, and applicable national AML legislation for international commodity trading.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ADD CONSTRAINT `fk_customer_counterparty_parent_counterparty_id` FOREIGN KEY (`parent_counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ADD CONSTRAINT `fk_customer_counterparty_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `mining_ecm`.`customer`.`payment_term`(`payment_term_id`);
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ADD CONSTRAINT `fk_customer_counterparty_contact_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ADD CONSTRAINT `fk_customer_delivery_destination_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ADD CONSTRAINT `fk_customer_credit_limit_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ADD CONSTRAINT `fk_customer_credit_limit_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `mining_ecm`.`customer`.`payment_term`(`payment_term_id`);
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ADD CONSTRAINT `fk_customer_credit_review_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ADD CONSTRAINT `fk_customer_credit_review_credit_limit_id` FOREIGN KEY (`credit_limit_id`) REFERENCES `mining_ecm`.`customer`.`credit_limit`(`credit_limit_id`);
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ADD CONSTRAINT `fk_customer_credit_review_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `mining_ecm`.`customer`.`payment_term`(`payment_term_id`);
ALTER TABLE `mining_ecm`.`customer`.`segment` ADD CONSTRAINT `fk_customer_segment_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ADD CONSTRAINT `fk_customer_bank_account_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ADD CONSTRAINT `fk_customer_letter_of_credit_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ADD CONSTRAINT `fk_customer_letter_of_credit_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `mining_ecm`.`customer`.`bank_account`(`bank_account_id`);
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ADD CONSTRAINT `fk_customer_letter_of_credit_delivery_destination_id` FOREIGN KEY (`delivery_destination_id`) REFERENCES `mining_ecm`.`customer`.`delivery_destination`(`delivery_destination_id`);
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ADD CONSTRAINT `fk_customer_letter_of_credit_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `mining_ecm`.`customer`.`payment_term`(`payment_term_id`);
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ADD CONSTRAINT `fk_customer_kyc_record_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `mining_ecm`.`customer`.`counterparty`(`counterparty_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `mining_ecm`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` SET TAGS ('dbx_subdomain' = 'counterparty_management');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `business_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `parent_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Counterparty Identifier');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `profit_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `abn` SET TAGS ('dbx_business_glossary_term' = 'Australian Business Number (ABN)');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `abn` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `abn` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `acn` SET TAGS ('dbx_business_glossary_term' = 'Australian Company Number (ACN)');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `acn` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `acn` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Classification');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'steel_mill|smelter|refinery|energy_company|commodity_trader|end_user');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `communication_language` SET TAGS ('dbx_business_glossary_term' = 'Communication Language');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `communication_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `counterparty_status` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Status');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `counterparty_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|blacklisted');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Country of Incorporation');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (USD)');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `credit_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Agency');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_value_regex' = 'SP|Moodys|Fitch|DBRS|Internal');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `duns_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `incoterm_preference` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterm) Preference');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `incoterm_preference` SET TAGS ('dbx_value_regex' = 'FOB|CFR|CIF|DAP|DDP');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|edi|portal|mail');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `is_sanctioned_entity` SET TAGS ('dbx_business_glossary_term' = 'Is Sanctioned Entity Flag');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `kyc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Completion Date');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `kyc_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Expiry Date');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|expired|failed');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `lei_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (LEI) Code');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `lei_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{20}$');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `lei_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `preferred_commodity_grades` SET TAGS ('dbx_business_glossary_term' = 'Preferred Commodity Grades');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `preferred_discharge_ports` SET TAGS ('dbx_business_glossary_term' = 'Preferred Discharge Ports');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `preferred_loading_ports` SET TAGS ('dbx_business_glossary_term' = 'Preferred Loading Ports');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `preferred_vessel_size_dwt` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vessel Size (Deadweight Tonnage)');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `preferred_vessel_size_dwt` SET TAGS ('dbx_value_regex' = 'handysize|handymax|panamax|capesize|vloc');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_country` SET TAGS ('dbx_business_glossary_term' = 'Registered Country');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_business_glossary_term' = 'Registered State or Province');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `reporting_format_preference` SET TAGS ('dbx_business_glossary_term' = 'Reporting Format Preference');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `reporting_format_preference` SET TAGS ('dbx_value_regex' = 'pdf|excel|xml|edi|api');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Trading Name');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` SET TAGS ('dbx_subdomain' = 'counterparty_management');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `counterparty_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Contact Identifier (ID)');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'commercial|technical|logistics|finance|legal|executive');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `counterparty_contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `counterparty_contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|on_leave');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `credit_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Authority Flag');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Name');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `is_decision_maker` SET TAGS ('dbx_business_glossary_term' = 'Is Decision Maker Flag');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `logistics_coordinator` SET TAGS ('dbx_business_glossary_term' = 'Logistics Coordinator Flag');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `preferred_communication_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Method');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `preferred_communication_method` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|fax|portal');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `salutation` SET TAGS ('dbx_business_glossary_term' = 'Salutation');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `salutation` SET TAGS ('dbx_value_regex' = 'Mr|Ms|Mrs|Dr|Prof|Mx');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `signing_authority` SET TAGS ('dbx_business_glossary_term' = 'Signing Authority Flag');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `technical_liaison` SET TAGS ('dbx_business_glossary_term' = 'Technical Liaison Flag');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `mining_ecm`.`customer`.`counterparty_contact` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` SET TAGS ('dbx_subdomain' = 'counterparty_management');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `delivery_destination_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Destination Identifier (ID)');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `berth_name` SET TAGS ('dbx_business_glossary_term' = 'Berth Name');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `berth_number` SET TAGS ('dbx_business_glossary_term' = 'Berth Number');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `commodity_types_accepted` SET TAGS ('dbx_business_glossary_term' = 'Commodity Types Accepted');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `conveyor_system_available` SET TAGS ('dbx_business_glossary_term' = 'Conveyor System Available');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `customs_clearance_available` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Available');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `delivery_destination_status` SET TAGS ('dbx_business_glossary_term' = 'Destination Status');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `delivery_destination_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_construction|decommissioned');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `destination_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Code');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `destination_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `destination_name` SET TAGS ('dbx_business_glossary_term' = 'Destination Name');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `destination_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Type');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `destination_type` SET TAGS ('dbx_value_regex' = 'port_terminal|smelter_intake|power_station_stockyard|warehouse|rail_siding|ship_berth');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `environmental_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Restrictions');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `incoterms_applicable` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Applicable');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `loading_rate_tph` SET TAGS ('dbx_business_glossary_term' = 'Loading Rate (Tonnes Per Hour - TPH)');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `maximum_vessel_beam_m` SET TAGS ('dbx_business_glossary_term' = 'Maximum Vessel Beam (Meters)');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `maximum_vessel_draft_m` SET TAGS ('dbx_business_glossary_term' = 'Maximum Vessel Draft (Meters)');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `maximum_vessel_loa_m` SET TAGS ('dbx_business_glossary_term' = 'Maximum Vessel Length Overall (LOA) in Meters');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Destination Notes');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `port_code` SET TAGS ('dbx_business_glossary_term' = 'Port Code');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `port_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `rail_access_available` SET TAGS ('dbx_business_glossary_term' = 'Rail Access Available');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `road_access_available` SET TAGS ('dbx_business_glossary_term' = 'Road Access Available');
ALTER TABLE `mining_ecm`.`customer`.`delivery_destination` ALTER COLUMN `storage_capacity_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Tonnes)');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` SET TAGS ('dbx_subdomain' = 'credit_risk');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Identifier (ID)');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `available_credit` SET TAGS ('dbx_business_glossary_term' = 'Available Credit');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `collateral_amount` SET TAGS ('dbx_business_glossary_term' = 'Collateral Amount');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `collateral_reference` SET TAGS ('dbx_business_glossary_term' = 'Collateral Reference Number');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `credit_limit_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Number');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `credit_limit_number` SET TAGS ('dbx_value_regex' = '^CL-[0-9]{8}$');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `credit_limit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Status');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `credit_limit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Type');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `credit_limit_type` SET TAGS ('dbx_value_regex' = 'master_limit|temporary_limit|project_specific|seasonal_limit|spot_trade_limit|offtake_agreement_limit');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Agency');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `insurance_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Percentage');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Policy Number');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Notes');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'low_risk|medium_risk|high_risk|watch_list|default');
ALTER TABLE `mining_ecm`.`customer`.`credit_limit` ALTER COLUMN `utilisation_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Utilisation Amount');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` SET TAGS ('dbx_subdomain' = 'credit_risk');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `credit_review_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Review ID');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Approval Date');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Approval Notes');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `approval_outcome` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Approval Outcome');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `approval_outcome` SET TAGS ('dbx_value_regex' = 'approved_as_recommended|approved_with_modifications|rejected|deferred');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `approved_credit_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Approved Credit Limit (USD)');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `approved_credit_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Credit Approver Name');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `collateral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Required Flag');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `collateral_type` SET TAGS ('dbx_value_regex' = 'letter_of_credit|bank_guarantee|parent_guarantee|cash_deposit|none|other');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `current_credit_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Current Credit Limit (USD)');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `current_credit_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `current_ratio` SET TAGS ('dbx_business_glossary_term' = 'Current Ratio');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `external_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'External Credit Rating');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `external_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'External Credit Rating Agency');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `external_rating_agency` SET TAGS ('dbx_value_regex' = 'Moodys|S&P|Fitch|DBRS|JCR|Other');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `external_rating_date` SET TAGS ('dbx_business_glossary_term' = 'External Credit Rating Date');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `financial_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Statement Date');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `interest_coverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Interest Coverage Ratio');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `internal_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Internal Credit Rating');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `internal_rating_outlook` SET TAGS ('dbx_business_glossary_term' = 'Internal Credit Rating Outlook');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `internal_rating_outlook` SET TAGS ('dbx_value_regex' = 'positive|stable|negative|developing');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `leverage_ratio` SET TAGS ('dbx_business_glossary_term' = 'Leverage Ratio');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `limit_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Change Reason');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `loss_given_default_pct` SET TAGS ('dbx_business_glossary_term' = 'Loss Given Default (LGD) Percentage');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `probability_of_default_pct` SET TAGS ('dbx_business_glossary_term' = 'Probability of Default (PD) Percentage');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `recommended_credit_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Recommended Credit Limit (USD)');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `recommended_credit_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Date');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Number');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `review_number` SET TAGS ('dbx_value_regex' = '^CR-[0-9]{6,10}$');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Status');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|pending_approval|approved|rejected|superseded');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Type');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Credit Reviewer Name');
ALTER TABLE `mining_ecm`.`customer`.`credit_review` ALTER COLUMN `risk_commentary` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk Commentary');
ALTER TABLE `mining_ecm`.`customer`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `mining_ecm`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'counterparty_management');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Identifier (ID)');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `annual_volume_maximum_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume Maximum Tonnes');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `annual_volume_minimum_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume Minimum Tonnes');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `contract_type_preference` SET TAGS ('dbx_business_glossary_term' = 'Contract Type Preference');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `contract_type_preference` SET TAGS ('dbx_value_regex' = 'Long-Term Offtake|Annual Framework|Quarterly|Spot|Mixed');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `credit_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk Rating');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `credit_risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `diversification_target_flag` SET TAGS ('dbx_business_glossary_term' = 'Diversification Target Flag');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `end_use_industry` SET TAGS ('dbx_business_glossary_term' = 'End-Use Industry');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'Asia Pacific|Europe|North America|South America|Middle East|Africa');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `incoterm_preference` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Preference (International Commercial Terms)');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `incoterm_preference` SET TAGS ('dbx_value_regex' = 'FOB|CFR|CIF|DAP|DDP|EXW');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `payment_terms_category` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Category');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `payment_terms_category` SET TAGS ('dbx_value_regex' = 'Advance Payment|Letter of Credit|Net 30|Net 60|Net 90|Extended Terms');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_value_regex' = 'Premium|Standard|Competitive|Spot Market|Negotiated');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `pricing_strategy` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `quality_specification_tier` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Tier');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `quality_specification_tier` SET TAGS ('dbx_value_regex' = 'Premium Grade|Standard Grade|Commercial Grade|Spot Grade');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `relationship_manager` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'Active|Under Review|Suspended|Archived');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `service_level_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Tier');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `service_level_tier` SET TAGS ('dbx_value_regex' = 'Platinum|Gold|Silver|Bronze|Standard');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `strategic_priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority Flag');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `tier_classification` SET TAGS ('dbx_business_glossary_term' = 'Tier Classification');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `tier_classification` SET TAGS ('dbx_value_regex' = 'Tier 1 Strategic|Tier 2 Preferred|Tier 3 Spot|Tier 4 Inactive');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `volume_band` SET TAGS ('dbx_business_glossary_term' = 'Volume Band');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `volume_band` SET TAGS ('dbx_value_regex' = 'Very High|High|Medium|Low|Minimal');
ALTER TABLE `mining_ecm`.`customer`.`segment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` SET TAGS ('dbx_subdomain' = 'credit_risk');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Name');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending_verification');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'checking|savings|current|corporate|escrow|trust');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Bank Address Line 1');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Bank Address Line 2');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_city` SET TAGS ('dbx_business_glossary_term' = 'Bank City');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Country Code');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Postal Code');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_state_province` SET TAGS ('dbx_business_glossary_term' = 'Bank State or Province');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `bank_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]{1,30}$');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `intermediary_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Bank Name');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `intermediary_swift_bic_code` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Society for Worldwide Interbank Financial Telecommunication (SWIFT) Business Identifier Code (BIC)');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `intermediary_swift_bic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `intermediary_swift_bic_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `intermediary_swift_bic_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Account Flag');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `is_sanctions_screened` SET TAGS ('dbx_business_glossary_term' = 'Is Sanctions Screened Flag');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `payment_method_supported` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Supported [ENUM-REF-CANDIDATE: wire_transfer|ach|sepa|rtgs|swift|letter_of_credit|documentary_collection|telegraphic_transfer — promote to reference product]');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Payment Instructions');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Business Identifier Code (BIC)');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'micro_deposit|document_upload|third_party_service|manual_review|bank_statement');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_verified');
ALTER TABLE `mining_ecm`.`customer`.`bank_account` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` SET TAGS ('dbx_subdomain' = 'credit_risk');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term ID');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `applicable_commodity_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Commodity Types');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'standard|manager|director|cfo|board');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `bank_guarantee_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Bank Guarantee Required Flag');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `credit_insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Insurance Required Flag');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `discount_days` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Days');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percentage');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `documentary_requirements` SET TAGS ('dbx_business_glossary_term' = 'Documentary Requirements');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `installment_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Installment Allowed Flag');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `installment_count` SET TAGS ('dbx_business_glossary_term' = 'Installment Count');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `late_payment_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Rate');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `letter_of_credit_type` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Type');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `maximum_transaction_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Value');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `minimum_transaction_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Value');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Notes');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `payment_basis` SET TAGS ('dbx_business_glossary_term' = 'Payment Basis');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `payment_basis` SET TAGS ('dbx_value_regex' = 'invoice_date|bill_of_lading_date|shipment_date|delivery_date|month_end|custom');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `payment_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Days');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'telegraphic_transfer|letter_of_credit|documentary_collection|cash_in_advance|open_account|escrow');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `payment_priority` SET TAGS ('dbx_business_glossary_term' = 'Payment Priority');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `payment_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low|standard');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `payment_term_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Description');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `payment_term_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Name');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `payment_term_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Status');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `payment_term_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|deprecated');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`customer`.`payment_term` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` SET TAGS ('dbx_subdomain' = 'credit_risk');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `letter_of_credit_id` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Identifier');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `delivery_destination_id` SET TAGS ('dbx_business_glossary_term' = 'Loading Port Delivery Destination Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `tenement_id` SET TAGS ('dbx_business_glossary_term' = 'Tenement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `advising_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Advising Bank Name');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `advising_bank_swift_code` SET TAGS ('dbx_business_glossary_term' = 'Advising Bank SWIFT Code');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `advising_bank_swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `advising_bank_swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `advising_bank_swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `applicant_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Name');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `applicant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `applicant_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `available_amount` SET TAGS ('dbx_business_glossary_term' = 'Available Amount');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `discharge_port` SET TAGS ('dbx_business_glossary_term' = 'Discharge Port');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `document_requirements` SET TAGS ('dbx_business_glossary_term' = 'Document Requirements');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `governing_rules` SET TAGS ('dbx_business_glossary_term' = 'Governing Rules');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `governing_rules` SET TAGS ('dbx_value_regex' = 'UCP_600|UCP_500|ISP98|eUCP');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `issuing_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Name');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `issuing_bank_swift_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank SWIFT Code');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `issuing_bank_swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `issuing_bank_swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `issuing_bank_swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `latest_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Latest Shipment Date');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `lc_amount` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Amount');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `lc_number` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Number');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `lc_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `lc_type` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Type');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `lc_type` SET TAGS ('dbx_value_regex' = 'irrevocable|revocable|confirmed|unconfirmed|transferable|standby');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `letter_of_credit_status` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Status');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `letter_of_credit_status` SET TAGS ('dbx_value_regex' = 'draft|active|partially_utilised|fully_utilised|expired|cancelled');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `partial_shipment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Partial Shipment Allowed Flag');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'sight|deferred|usance|acceptance');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `presentation_period_days` SET TAGS ('dbx_business_glossary_term' = 'Presentation Period Days');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'MT|DMT|WMT|tonnes|kg|lbs');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `shipment_period_from` SET TAGS ('dbx_business_glossary_term' = 'Shipment Period From Date');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `shipment_period_to` SET TAGS ('dbx_business_glossary_term' = 'Shipment Period To Date');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `tenor_days` SET TAGS ('dbx_business_glossary_term' = 'Tenor Days');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Percentage');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `transhipment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Transhipment Allowed Flag');
ALTER TABLE `mining_ecm`.`customer`.`letter_of_credit` ALTER COLUMN `utilised_amount` SET TAGS ('dbx_business_glossary_term' = 'Utilised Amount');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` SET TAGS ('dbx_subdomain' = 'counterparty_management');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `kyc_record_id` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Record ID');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `adverse_media_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Screening Date');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `adverse_media_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Adverse Media Screening Result');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `adverse_media_screening_result` SET TAGS ('dbx_value_regex' = 'clear|adverse_found|under_investigation|not_screened');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Risk Rating');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `aml_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'KYC Approval Date');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `beneficial_ownership_documented` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Ownership Documented Flag');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `beneficial_ownership_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Ownership Verification Date');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `business_relationship_purpose` SET TAGS ('dbx_business_glossary_term' = 'Business Relationship Purpose');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'KYC Comments');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `document_repository_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Reference');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `document_repository_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `documentation_complete` SET TAGS ('dbx_business_glossary_term' = 'Documentation Complete Flag');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `due_diligence_level` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Level');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `due_diligence_level` SET TAGS ('dbx_value_regex' = 'standard|enhanced|simplified');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'KYC Expiry Date');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Method');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `identity_verification_method` SET TAGS ('dbx_value_regex' = 'document_review|in_person|electronic|third_party_verification|not_verified');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `jurisdiction_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Risk Level');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `jurisdiction_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Status');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected|expired|under_review|suspended');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `last_transaction_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Review Date');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next KYC Review Date');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `ongoing_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Ongoing Monitoring Flag');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `pep_classification` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Classification');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `pep_classification` SET TAGS ('dbx_value_regex' = 'domestic|foreign|international_organization|family_member|close_associate|not_applicable');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `pep_flag` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Flag');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency in Months');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `sanctions_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Result');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `sanctions_screening_result` SET TAGS ('dbx_value_regex' = 'clear|match|potential_match|not_screened');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `source_of_funds_verified` SET TAGS ('dbx_business_glossary_term' = 'Source of Funds Verified Flag');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `source_of_wealth_verified` SET TAGS ('dbx_business_glossary_term' = 'Source of Wealth Verified Flag');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `mining_ecm`.`customer`.`kyc_record` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification Date');
