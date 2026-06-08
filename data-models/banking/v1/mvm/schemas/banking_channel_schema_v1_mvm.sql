-- Schema for Domain: channel | Business: Banking | Version: v1_mvm
-- Generated on: 2026-05-03 02:24:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`channel` COMMENT 'Customer interaction channels including digital banking (mobile/web), branch network, ATM, contact center, relationship managers, and API/open banking. Manages channel configuration, omnichannel orchestration, customer journey tracking, session management, SLA tracking, and channel-specific product offerings.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`channel` (
    `channel_id` BIGINT COMMENT 'Primary key for channel',
    `bic_directory_id` BIGINT COMMENT 'Foreign key linking to reference.bic_directory. Business justification: Channels with SWIFT connectivity (swift_bic_code present) must reference the BIC directory for correspondent banking, payment routing, and SWIFT message validation. Banking domain experts expect chann',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Channel operating costs (infrastructure, staffing, technology) must be allocated to a cost center for management accounting and budgeting. The existing cost_center_code is a denormalized plain attribu',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Channels are licensed and regulated per country — FATCA/CRS reporting, OFAC sanctions screening, and AML risk rating all depend on the channels operating country. Banking domain experts expect channe',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Channels enforce transaction limits and regulatory reporting in a specific operating currency. AML monitoring, daily transaction limit enforcement, and regulatory capital reporting all require a valid',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Channels enforce transaction processing cutoffs and SLA calculations based on business day calendars. Holiday calendars determine when channels process payments and settle transactions. Banking domain',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Channels are licensed and regulated under specific jurisdictions (e.g., FCA, OCC, ECB). Critical for regulatory reporting, compliance validation, and determining applicable capital adequacy and stress',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Banking channels are licensed and operated by specific legal entities. Regulatory reporting (OCC, FRB licensing, conduct reporting) and legal entity P&L attribution require knowing which legal entity ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: Channels generate revenue (fees, net interest income) attributed to profit centers for segment P&L reporting and IFRS 8 segment disclosure. Banking management reporting requires channel-to-profit-cent',
    `aml_monitoring_enabled` BOOLEAN COMMENT 'Indicates whether transactions through this channel are subject to real-time or near-real-time AML transaction monitoring.',
    `api_endpoint_url` STRING COMMENT 'Base URL for API-based channels (open banking API, BaaS API). Null for non-API channels.',
    `authentication_method` STRING COMMENT 'Primary authentication method(s) used by the channel (e.g., username/password, biometric, two-factor authentication, certificate-based, in-person verification). [ENUM-REF-CANDIDATE: username_password|biometric|mfa|certificate|oauth|saml|in_person|pin|token — promote to reference product]',
    `channel_code` STRING COMMENT 'Unique business identifier code for the channel, used for external references and system integration. Follows bank-specific channel coding standards.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `channel_description` STRING COMMENT 'Detailed description of the channels purpose, capabilities, and target customer segments.',
    `channel_name` STRING COMMENT 'Human-readable name of the channel (e.g., Mobile Banking App, Downtown Branch, Corporate API Gateway).',
    `channel_status` STRING COMMENT 'Current operational status of the channel in its lifecycle.. Valid values are `active|inactive|suspended|planned|decommissioned|maintenance`',
    `channel_type` STRING COMMENT 'Primary classification of the channel. Aligned with ISO 20022 channel type taxonomy where applicable.. Valid values are `digital_banking|branch|atm|contact_center|relationship_manager|api_banking`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the channel record was first created in the system.',
    `customer_segment_restriction` STRING COMMENT 'Comma-separated list of customer segment codes that are permitted to use this channel. Null if no restriction applies (channel available to all segments).',
    `data_source_system` STRING COMMENT 'Name of the source system from which this channel record originates (e.g., Core Banking System, Channel Management Platform, CRM).',
    `effective_date` DATE COMMENT 'Date when the channel became or will become operational and available to customers.',
    `encryption_standard` STRING COMMENT 'Encryption standard applied to data transmitted through the channel (e.g., TLS 1.3, AES-256).',
    `geographic_scope` STRING COMMENT 'Geographic coverage scope of the channel (e.g., single location, regional network, national footprint, global access).. Valid values are `local|regional|national|international|global`',
    `kyc_capability` STRING COMMENT 'Level of KYC and customer due diligence capability available through the channel (full identity verification, partial verification, or none).. Valid values are `full|partial|none`',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified the channel record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the channel record was last updated.',
    `omnichannel_orchestration_enabled` BOOLEAN COMMENT 'Indicates whether the channel participates in omnichannel customer journey orchestration and cross-channel session continuity.',
    `operating_hours_description` STRING COMMENT 'Human-readable description of channel operating hours (e.g., 24/7, Mon-Fri 9AM-5PM EST, Business days excluding bank holidays).',
    `product_offering_scope` STRING COMMENT 'Scope of banking products and services available through this channel (all products, restricted subset, or custom configuration).. Valid values are `all_products|restricted|custom`',
    `region_code` STRING COMMENT 'Internal region or market code for channel assignment to organizational regions (e.g., Northeast, EMEA, APAC).',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether transactions through this channel require specific regulatory reporting (e.g., CTR, SAR, CCAR stress testing).',
    `sla_response_time_seconds` STRING COMMENT 'Target response time in seconds for channel interactions as defined in the channel SLA (e.g., page load time for digital, call answer time for contact center).',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Target uptime percentage for the channel as defined in the SLA (e.g., 99.9% for digital channels).',
    `subtype` STRING COMMENT 'Detailed sub-classification of the channel providing granular segmentation (e.g., mobile app vs web banking under digital; full-service branch vs express branch). [ENUM-REF-CANDIDATE: mobile_app|web_banking|branch_full_service|branch_express|atm_full_service|atm_deposit_only|ivr|live_agent|chatbot|email|rm_dedicated|rm_shared|open_banking_api|baas_api|embedded_finance — 15 candidates stripped; promote to reference product]',
    `supports_account_opening` BOOLEAN COMMENT 'Indicates whether the channel supports new account origination and onboarding workflows.',
    `supports_investment_services` BOOLEAN COMMENT 'Indicates whether the channel provides investment banking, wealth management, or securities trading capabilities.',
    `supports_loan_origination` BOOLEAN COMMENT 'Indicates whether the channel supports loan application and origination processes.',
    `supports_transactions` BOOLEAN COMMENT 'Indicates whether the channel supports financial transaction execution (payments, transfers, withdrawals) or is information/inquiry-only.',
    `termination_date` DATE COMMENT 'Date when the channel was or will be decommissioned and no longer available. Null for active channels.',
    `third_party_provider` STRING COMMENT 'Name of third-party vendor or technology provider if the channel is operated or enabled by an external partner (e.g., fintech platform, BaaS provider, core banking vendor). Null if operated in-house.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the channels primary operating location (e.g., America/New_York, Europe/London).',
    `transaction_limit_daily` DECIMAL(18,2) COMMENT 'Maximum aggregate transaction amount allowed per customer per day through this channel. Null if no limit applies.',
    `transaction_limit_per_transaction` DECIMAL(18,2) COMMENT 'Maximum single transaction amount allowed through this channel. Null if no limit applies.',
    CONSTRAINT pk_channel PRIMARY KEY(`channel_id`)
) COMMENT 'Master registry of all customer interaction channels operated by the bank, serving as the SSOT for channel identity, classification, and configuration. Covers digital channels (mobile app, web banking), branch network, ATM network, contact center, relationship manager, and API/open banking channels, with support for emerging channel types including embedded finance and Banking-as-a-Service (BaaS). Captures channel type (aligned with ISO 20022 channel type codes where applicable), channel status, capabilities, supported products and services, operating hours, geographic coverage, regulatory classification, and channel-specific configuration parameters. Each channel sub-type (branch, ATM, digital_channel, contact_center) maintains its own detailed master record that FKs back to this registry for unified channel governance, omnichannel orchestration, and enterprise channel performance reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`branch` (
    `branch_id` BIGINT COMMENT 'Unique identifier for the branch location. Primary key for the branch entity.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: The channel table is the master registry of ALL customer interaction channels operated by the bank. A branch is a physical instantiation of a channel and must be registered in the channel master. Addi',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Branch physical location country drives AML jurisdiction assignment, FDIC/regulatory exam scheduling, FATCA/CRS reporting obligations, and OFAC sanctions screening. Banking domain experts universally ',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Branches operate with a primary currency for vault management, teller cash balancing, and regulatory reporting (e.g., CTR filings). Banking domain experts expect branches to reference a canonical curr',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Branches follow local holiday calendars for operating hours and business day calculations. Critical for SLA compliance, customer service planning, transaction settlement timing, and workforce scheduli',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Branches operate under specific regulatory jurisdictions governing capital adequacy, AML/BSA compliance, and licensing. The regulatory_jurisdiction plain-text column is a denormalized representation. ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Branches operate under a specific legal entitys banking license. Regulatory examinations (OCC, FDIC, FRB), branch-level stress testing, and legal entity resolution planning require direct branch-to-l',
    `address_line_1` STRING COMMENT 'Primary street address of the branch location including street number and name.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite number, floor, building name, or other location details.',
    `atm_count` STRING COMMENT 'Number of ATM machines located at or immediately adjacent to the branch. Used for self-service capacity planning and customer convenience analysis.',
    `branch_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the branch within the banks network. Used for routing, reporting, and regulatory identification.. Valid values are `^[A-Z0-9]{4,12}$`',
    `branch_name` STRING COMMENT 'Official business name of the branch location as registered with regulatory authorities and displayed to customers.',
    `branch_status` STRING COMMENT 'Current operational status of the branch in its lifecycle. Active branches are fully operational; inactive branches are permanently closed; temporarily closed branches are expected to reopen; pending opening branches are approved but not yet operational; pending closure branches are scheduled for closure; under renovation branches are temporarily closed for facility upgrades.. Valid values are `active|inactive|temporarily_closed|pending_opening|pending_closure|under_renovation`',
    `branch_type` STRING COMMENT 'Classification of the branch based on service capabilities and operational model. Full-service branches offer complete banking services; limited-service branches offer restricted services; drive-through branches focus on vehicle-accessible transactions; in-store branches are located within retail establishments; mobile branches are temporary or movable units; automated branches are primarily self-service; private banking branches serve high-net-worth clients. [ENUM-REF-CANDIDATE: full_service|limited_service|drive_through|in_store|mobile|automated|private_banking — 7 candidates stripped; promote to reference product]',
    `bsa_aml_designation` STRING COMMENT 'Risk classification of the branch for BSA/AML compliance purposes. Standard designation applies default monitoring; high-risk designation requires enhanced due diligence; enhanced monitoring applies additional transaction surveillance; exempt designation applies to branches with limited transaction capabilities.. Valid values are `standard|high_risk|enhanced_monitoring|exempt`',
    `city` STRING COMMENT 'City or municipality where the branch is located.',
    `closure_date` DATE COMMENT 'Date when the branch permanently ceased operations. Null for active branches. Used for network rationalization analysis and regulatory reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the branch record was first created in the system. Used for data lineage and audit trail purposes.',
    `drive_through_lanes` STRING COMMENT 'Number of drive-through service lanes available at the branch for vehicle-accessible banking transactions.',
    `email_address` STRING COMMENT 'Official email address for the branch used for customer inquiries, service requests, and business correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Facsimile number for the branch used for document transmission and formal communications.',
    `fdic_certificate_number` STRING COMMENT 'FDIC certificate number associated with the institution operating this branch. Used for regulatory reporting and deposit insurance identification.. Valid values are `^[0-9]{5,6}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the branch record was most recently updated in the system. Used for change tracking and data quality monitoring.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the branch location in decimal degrees format. Used for mapping, proximity analysis, and location-based services.',
    `lease_expiration_date` DATE COMMENT 'Date when the current lease agreement for the branch facility expires. Null for owned properties. Used for lease renewal planning and real estate strategy.',
    `lease_or_owned` STRING COMMENT 'Indicates whether the branch facility is owned by the bank, leased from a third party, or operates under a ground lease arrangement. Used for real estate portfolio management and cost allocation.. Valid values are `owned|leased|ground_lease`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the branch location in decimal degrees format. Used for mapping, proximity analysis, and location-based services.',
    `market_code` STRING COMMENT 'Code identifying the market or metropolitan statistical area (MSA) in which the branch operates. Used for market share analysis and competitive positioning.',
    `opening_date` DATE COMMENT 'Date when the branch first opened for business and began serving customers. Used for branch age analysis and network expansion tracking.',
    `operating_hours_saturday` STRING COMMENT 'Operating hours for the branch on Saturdays. May differ from weekday hours or be closed. Format includes opening and closing times.',
    `operating_hours_sunday` STRING COMMENT 'Operating hours for the branch on Sundays. Many branches are closed on Sundays. Format includes opening and closing times or indication of closure.',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for the branch on weekdays (Monday through Friday). Format typically includes opening and closing times (e.g., 09:00-17:00).',
    `parking_available` BOOLEAN COMMENT 'Indicates whether dedicated customer parking is available at or near the branch location.',
    `performance_tier` STRING COMMENT 'Internal classification of branch performance based on deposit volume, loan origination, customer acquisition, and profitability metrics. Flagship branches are premier locations; Tier 1 represents highest performance; Tier 4 represents lowest performance. Used for resource allocation and strategic planning.. Valid values are `tier_1|tier_2|tier_3|tier_4|flagship`',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the branch. Used by customers and internal staff for inquiries and service requests.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the branch address used for mail delivery and geographic segmentation.',
    `region_code` STRING COMMENT 'Internal code identifying the geographic region or district to which the branch is assigned for management and reporting purposes.',
    `safe_deposit_box_count` STRING COMMENT 'Total number of safe deposit boxes available for customer rental at the branch. Used for vault capacity management and revenue forecasting.',
    `square_footage` STRING COMMENT 'Total interior floor space of the branch facility measured in square feet. Used for facilities management, lease cost analysis, and space utilization planning.',
    `staff_capacity` STRING COMMENT 'Maximum number of full-time equivalent staff members the branch is designed to accommodate. Used for workforce planning and capacity management.',
    `state_province` STRING COMMENT 'State, province, or primary administrative subdivision where the branch is located.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the branch location (e.g., America/New_York). Used for scheduling, transaction timestamping, and cross-timezone coordination.',
    `wheelchair_accessible` BOOLEAN COMMENT 'Indicates whether the branch facility is fully accessible to customers using wheelchairs, including ramps, elevators, and accessible service counters.',
    CONSTRAINT pk_branch PRIMARY KEY(`branch_id`)
) COMMENT 'Master record for each physical branch location in the banks network. Captures branch code, name, address, geographic coordinates, branch type (full-service, limited-service, drive-through, in-store), operating hours, staffing capacity, ATM count, safe deposit box availability, accessibility features, regulatory jurisdiction, BSA/AML designation, and branch performance tier. Serves as the SSOT for branch identity and physical network management.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`atm` (
    `atm_id` BIGINT COMMENT 'Unique identifier for the ATM unit in the banks owned and managed network.',
    `branch_id` BIGINT COMMENT 'Identifier of the branch to which this ATM is assigned for operational and reporting purposes. Null if the ATM is not associated with a specific branch.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: The channel table is the master registry of ALL customer interaction channels. An ATM is a self-service channel and must be registered in the channel master alongside digital, branch, and contact-cent',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: ATM operating costs (cash replenishment, maintenance, depreciation, network fees) must be allocated to a cost center for management accounting. Banks track ATM profitability and cost efficiency by cos',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: ATM physical location country determines network affiliation rules, AML monitoring thresholds, surcharge regulations, and regulatory reporting requirements. Banking domain experts expect ATM-to-countr',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: ATMs dispense cash and charge surcharges in a specific currency; cash replenishment planning, interchange settlement, and regulatory reporting require a validated currency reference. Banking domain ex',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: ATMs follow holiday calendars for maintenance scheduling, cash replenishment planning, and service availability. Critical for operational efficiency, cash management, and ensuring adequate liquidity d',
    `ada_compliant` BOOLEAN COMMENT 'Indicates whether the ATM meets ADA accessibility requirements (True) or not (False).',
    `address_line_1` STRING COMMENT 'Primary street address line where the ATM is physically located.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or unit number where the ATM is located.',
    `average_daily_cash_dispensed` DECIMAL(18,2) COMMENT 'Average amount of cash dispensed by this ATM per day in the local currency, calculated over a rolling period.',
    `average_daily_transactions` STRING COMMENT 'Average number of transactions processed by this ATM per day, calculated over a rolling period (e.g., 30 days).',
    `biometric_authentication_enabled` BOOLEAN COMMENT 'Indicates whether the ATM supports biometric authentication methods such as fingerprint or iris scanning (True) or not (False).',
    `cash_cassette_configuration` STRING COMMENT 'Denomination configuration of cash cassettes (e.g., Cassette 1: $20, Cassette 2: $50, Cassette 3: $100, Cassette 4: $20).',
    `cash_cassette_count` STRING COMMENT 'Number of cash cassettes installed in the ATM for dispensing currency.',
    `cash_replenishment_schedule` STRING COMMENT 'Frequency at which the ATM is scheduled for cash replenishment: daily, weekly, bi-weekly, monthly, or on-demand based on usage.. Valid values are `daily|weekly|bi-weekly|monthly|on-demand`',
    `check_imaging_enabled` BOOLEAN COMMENT 'Indicates whether the ATM has check imaging capability for remote deposit capture (True) or not (False).',
    `city` STRING COMMENT 'City or municipality where the ATM is located.',
    `contactless_enabled` BOOLEAN COMMENT 'Indicates whether the ATM supports contactless card or mobile wallet transactions (True) or not (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ATM record was first created in the system.',
    `daily_withdrawal_limit` DECIMAL(18,2) COMMENT 'Maximum cumulative withdrawal amount per cardholder per day at this ATM in the local currency.',
    `deposit_enabled` BOOLEAN COMMENT 'Indicates whether the ATM supports cash and/or check deposit functionality (True) or is withdrawal-only (False).',
    `encryption_standard` STRING COMMENT 'Encryption standard used by the ATM for securing transaction data (e.g., 3DES, AES-128, AES-256).. Valid values are `3DES|AES-128|AES-256`',
    `firmware_version` STRING COMMENT 'Version number of the firmware currently installed on the ATM.',
    `installation_date` DATE COMMENT 'Date when the ATM was first installed and commissioned at its current location.',
    `ip_address` STRING COMMENT 'Network IP address assigned to the ATM for communication with the banks transaction processing systems.',
    `last_cash_replenishment_date` DATE COMMENT 'Date when the ATM was last replenished with cash.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled or unscheduled maintenance service performed on the ATM.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the ATM location in decimal degrees.',
    `location_type` STRING COMMENT 'Classification of the ATM placement: branch-attached (within or adjacent to a branch), off-premise (remote location), in-lobby, drive-through, or standalone kiosk.. Valid values are `branch|off-premise|in-lobby|drive-through|standalone`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the ATM location in decimal degrees.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the ATM unit.. Valid values are `NCR|Diebold Nixdorf|Hyosung|GRG Banking|Fujitsu|Triton`',
    `max_withdrawal_amount` DECIMAL(18,2) COMMENT 'Maximum single transaction withdrawal amount allowed at this ATM in the local currency.',
    `model` STRING COMMENT 'Model designation of the ATM unit as specified by the manufacturer (e.g., NCR SelfServ 80, Diebold Nixdorf DN Series).',
    `network_affiliations` STRING COMMENT 'Comma-separated list of interbank networks the ATM participates in (e.g., Visa, Mastercard, STAR, Allpoint, NYCE, Cirrus).',
    `next_maintenance_date` DATE COMMENT 'Date when the next scheduled preventive maintenance is planned for the ATM.',
    `operational_status` STRING COMMENT 'Current operational state of the ATM: active (in service), inactive (temporarily offline), maintenance (scheduled service), out-of-service (unplanned downtime), or decommissioned (permanently removed).. Valid values are `active|inactive|maintenance|out-of-service|decommissioned`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the ATM location.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number uniquely identifying the physical ATM hardware unit.',
    `service_provider` STRING COMMENT 'Name of the third-party service provider responsible for ATM maintenance and cash management, if outsourced. Null if managed in-house.',
    `state_province` STRING COMMENT 'State, province, or administrative region where the ATM is located.',
    `supported_transaction_types` STRING COMMENT 'Comma-separated list of transaction types the ATM supports (e.g., withdrawal, deposit, balance inquiry, transfer, bill payment, check cashing).',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Fee charged to non-customer cardholders for using this ATM, in the local currency. Zero if no surcharge applies.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this ATM record was last modified in the system.',
    `video_banking_enabled` BOOLEAN COMMENT 'Indicates whether the ATM supports live video teller assistance (True) or not (False).',
    CONSTRAINT pk_atm PRIMARY KEY(`atm_id`)
) COMMENT 'Master record for each ATM unit in the banks owned and managed network. Captures ATM ID, serial number, model, manufacturer, location (branch-attached or off-premise), address, geographic coordinates, network affiliations (Visa/Mastercard/STAR/Allpoint), supported transaction types, cash cassette configuration, surcharge policy, accessibility compliance (ADA), operational status, last maintenance date, and cash replenishment schedule.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`digital_channel` (
    `digital_channel_id` BIGINT COMMENT 'Unique identifier for the digital channel instance, registered API consumer, or third-party provider application.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Digital channel instances should reference their parent channel definition in the master channel registry. This resolves the silo issue for digital_channel. The FK links each digital banking platform ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Digital channel infrastructure costs (cloud hosting, API gateway, cybersecurity, development) are allocated to cost centers for technology cost management and IT chargeback processes. Banks track digi',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Digital channels operate under specific regulatory jurisdictions (PSD2, eIDAS, CFPB 1033). Critical for TPP registration validation, API governance, consent management, and regulatory compliance in op',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Digital channels (mobile banking, internet banking, open banking APIs) are licensed per legal entity under PSD2, OCC, and national banking regulations. Regulatory reporting and conduct supervision req',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to ledger.profit_center. Business justification: Digital channels generate fee income and drive product sales attributed to profit centers for segment P&L reporting. IFRS 8 segment disclosure and management reporting require digital channel revenue ',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Digital channels enforce transaction limits in specific currencies. Critical for PSD2 compliance, API rate limiting, cross-border payment processing, and multi-currency digital banking operations.',
    `api_gateway_endpoint` STRING COMMENT 'Base URL or endpoint address for the API gateway serving this channel.',
    `api_product_subscriptions` STRING COMMENT 'Comma-separated list of subscribed API products (e.g., account_information, payment_initiation, funds_confirmation, card_management).',
    `authentication_method` STRING COMMENT 'Comma-separated list of supported authentication methods (e.g., biometric, MFA, OTP, OAuth2, OIDC, certificate).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this digital channel record was first created in the system.',
    `data_access_scope` STRING COMMENT 'OAuth2 scope or permission set defining the data and operations this channel or TPP is authorized to access.',
    `developer_contact_email` STRING COMMENT 'Primary email address for technical contact or developer responsible for this channel or API consumer.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `developer_organization_name` STRING COMMENT 'Legal name of the organization or developer entity that owns or operates this API consumer or channel.',
    `digital_channel_status` STRING COMMENT 'Current lifecycle status of the digital channel instance or API consumer registration.. Valid values are `active|inactive|suspended|pending_approval|decommissioned|under_review`',
    `effective_from_date` DATE COMMENT 'Date from which this digital channel configuration or API consumer registration becomes active and operational.',
    `effective_to_date` DATE COMMENT 'Date until which this digital channel configuration or API consumer registration remains valid; null for open-ended registrations.',
    `eidas_certificate_reference` STRING COMMENT 'Reference identifier for the eIDAS (electronic IDentification, Authentication and trust Services) qualified certificate used for TPP authentication.',
    `encryption_standard` STRING COMMENT 'Encryption protocol or standard required for secure communication with this channel.. Valid values are `tls_1_2|tls_1_3|aes_256|rsa_2048`',
    `environment` STRING COMMENT 'Deployment environment classification for the channel instance.. Valid values are `sandbox|uat|production`',
    `feature_flags` STRING COMMENT 'Comma-separated list of enabled feature flags or capabilities for this channel instance (e.g., payment_initiation, account_aggregation, funds_confirmation).',
    `ip_whitelist` STRING COMMENT 'Comma-separated list of whitelisted IP addresses or CIDR ranges authorized to access this channel or API endpoint.',
    `is_baas_enabled` BOOLEAN COMMENT 'Indicates whether this channel is configured for Banking-as-a-Service or embedded finance capabilities.',
    `last_activity_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent API call, login, or transaction activity through this channel.',
    `max_requests_per_minute` STRING COMMENT 'Maximum number of API requests allowed per minute for this channel instance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this digital channel record was last modified or updated.',
    `oauth_client_identifier` STRING COMMENT 'OAuth2 or OIDC client identifier for API consumer authentication.',
    `oauth_client_secret_hash` STRING COMMENT 'Hashed OAuth2 client secret for secure credential storage.',
    `onboarding_approval_status` STRING COMMENT 'Current approval status of the channel or API consumer onboarding workflow.. Valid values are `pending|approved|rejected|under_review`',
    `onboarding_approved_by` STRING COMMENT 'Name or identifier of the approver who authorized this channel or API consumer registration.',
    `onboarding_approved_date` DATE COMMENT 'Date when the channel or API consumer registration was approved.',
    `platform_variant` STRING COMMENT 'Specific platform or protocol variant for the channel (e.g., iOS, Android, REST API).. Valid values are `ios|android|web|rest_api|graphql|soap`',
    `rate_limit_tier` STRING COMMENT 'API rate limiting tier assigned to this channel or consumer, governing request throughput.. Valid values are `basic|standard|premium|enterprise|unlimited`',
    `risk_rating` STRING COMMENT 'Risk classification assigned to this channel or TPP based on security assessment, transaction patterns, and regulatory compliance.. Valid values are `low|medium|high|critical`',
    `session_timeout_minutes` STRING COMMENT 'Idle session timeout duration in minutes before automatic logout or token expiration.',
    `sla_response_time_ms` STRING COMMENT 'Target API response time in milliseconds as defined in the SLA for this channel.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Target uptime percentage (e.g., 99.95) as defined in the SLA for this channel.',
    `terms_accepted_date` DATE COMMENT 'Date when the current terms of service version was accepted by the developer or TPP.',
    `terms_of_service_version` STRING COMMENT 'Version identifier of the terms of service or API usage agreement accepted by the channel or TPP.',
    `tpp_registration_number` STRING COMMENT 'Regulatory registration or license number for third-party provider applications under PSD2 or open banking frameworks.',
    `transaction_limit_daily` DECIMAL(18,2) COMMENT 'Maximum monetary value of transactions allowed per day through this channel.',
    `transaction_limit_per_transaction` DECIMAL(18,2) COMMENT 'Maximum monetary value allowed for a single transaction through this channel.',
    `version` STRING COMMENT 'Current version number or release identifier of the digital channel application or API endpoint.',
    `webhook_url` STRING COMMENT 'Callback URL endpoint for asynchronous event notifications or webhooks sent to the API consumer.',
    CONSTRAINT pk_digital_channel PRIMARY KEY(`digital_channel_id`)
) COMMENT 'Master configuration record for each digital banking channel instance, registered API consumer, and third-party provider (TPP) application — mobile banking app (iOS/Android), web banking portal, open banking API endpoints, aggregator integrations, and embedded finance/BaaS API consumers. Captures platform type, version, authentication methods (biometric, MFA, OTP), supported transaction limits, session timeout policies, feature flags, API gateway endpoint, OAuth2/OIDC client credentials (hashed), rate limit tier, environment (sandbox/UAT/production), PSD2/open banking compliance status, TPP regulatory registration (license number, jurisdiction), eIDAS certificate reference, developer/organization identity, API product subscriptions (account information, payment initiation, funds confirmation), data access scope, terms of service version accepted, onboarding approval status, and channel-specific SLA parameters. SSOT for digital channel configuration, API consumer identity, access governance, and TPP lifecycle management.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`session` (
    `session_id` BIGINT COMMENT 'Primary key for session',
    `channel_id` BIGINT COMMENT 'Reference to the channel through which the session was initiated (mobile app, web banking, branch, ATM, contact center, relationship manager, API).',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Session geolocation country is used for AML country-risk scoring and fraud detection — referencing country.aml_risk_rating and ofac_sanctions_flag directly. Banking domain experts expect geolocation c',
    `party_id` BIGINT COMMENT 'Reference to the customer or party associated with this session. Null for anonymous sessions.',
    `application_version` STRING COMMENT 'Version number of the mobile or desktop application used for the session. Null for web browser sessions.',
    `authentication_level` STRING COMMENT 'Strength level of authentication applied, aligned with regulatory requirements for customer due diligence and transaction authorization.. Valid values are `none|basic|enhanced|strong`',
    `authentication_method` STRING COMMENT 'Method used to authenticate the customer at session initiation (password, biometric, one-time password, security token, digital certificate, single sign-on).. Valid values are `password|biometric|otp|token|certificate|sso`',
    `browser_name` STRING COMMENT 'Name of the web browser used for the session (e.g., Chrome, Safari, Firefox, Edge). Null for non-browser channels.',
    `browser_version` STRING COMMENT 'Version number of the web browser used for the session. Null for non-browser channels.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this session record was first created in the system.',
    `device_fingerprint` STRING COMMENT 'Unique identifier or hash representing the device characteristics used to access the session. Used for fraud detection and device recognition.',
    `device_type` STRING COMMENT 'Classification of the device used to initiate the session (mobile phone, tablet, desktop computer, ATM, kiosk, point-of-sale terminal).. Valid values are `mobile|tablet|desktop|atm|kiosk|pos`',
    `duration_seconds` STRING COMMENT 'Total duration of the session in seconds, calculated as the difference between session end and start timestamps.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the session was terminated, either by user action, timeout, or system event.',
    `exit_page_url` STRING COMMENT 'URL of the last page or screen accessed before the session was terminated.',
    `fraud_risk_score` DECIMAL(18,2) COMMENT 'Real-time fraud risk score assigned to the session based on behavioral analytics, device fingerprinting, and transaction patterns. Scale 0-100, higher indicates greater risk.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the session origin, derived from IP address or device GPS. Used for location-based fraud detection and customer journey analysis.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the session origin, derived from IP address or device GPS. Used for location-based fraud detection and customer journey analysis.',
    `ip_address` STRING COMMENT 'IP address from which the session was initiated. Used for geolocation, fraud detection, and security monitoring.',
    `landing_page_url` STRING COMMENT 'URL of the first page or screen accessed in the session.',
    `language_preference` STRING COMMENT 'Two-letter ISO language code representing the customers preferred language for the session interface.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this session record was last updated in the system.',
    `notes` STRING COMMENT 'Free-text notes or comments captured during the session, typically used for assisted channels such as contact center or relationship manager interactions.',
    `operating_system` STRING COMMENT 'Operating system of the device used during the session (e.g., iOS, Android, Windows, macOS).',
    `outcome` STRING COMMENT 'Final outcome classification of the session indicating whether the customer completed their intended action, abandoned the session, experienced a timeout, or encountered an error.. Valid values are `completed|abandoned|timed_out|error`',
    `page_view_count` STRING COMMENT 'Total number of pages or screens viewed during the session. Used for engagement analysis and customer journey mapping.',
    `referrer_url` STRING COMMENT 'URL of the page or source that referred the customer to initiate the session. Used for marketing attribution and customer journey analysis.',
    `session_status` STRING COMMENT 'Current lifecycle status of the session.. Valid values are `active|completed|abandoned|timed_out|terminated`',
    `session_type` STRING COMMENT 'Classification of the session based on authentication and interaction mode.. Valid values are `authenticated|anonymous|assisted|api`',
    `sla_actual_response_time_ms` STRING COMMENT 'Actual average response time in milliseconds measured during the session.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the session met the defined SLA targets for response time and availability.',
    `sla_target_response_time_ms` STRING COMMENT 'Target response time in milliseconds defined by the SLA for this session type and channel.',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the session was initiated by the customer or system.',
    `termination_reason` STRING COMMENT 'Detailed reason for session termination, including user logout, inactivity timeout, security event, system error, or forced logout.',
    `token` STRING COMMENT 'Unique cryptographic token assigned to the session for authentication and authorization purposes. Used to maintain session state and security.',
    `transaction_count` STRING COMMENT 'Total number of financial or non-financial transactions executed within the session.',
    `user_agent` STRING COMMENT 'Browser or application user agent string identifying the client software, operating system, and device type used to access the session.',
    CONSTRAINT pk_session PRIMARY KEY(`session_id`)
) COMMENT 'Transactional record capturing each authenticated or anonymous customer session across all channels — mobile app, web banking, branch visit, ATM interaction, and contact center call. Captures session ID, channel reference, customer identifier, device fingerprint, IP address, geolocation, authentication method and level, session start/end timestamps, session duration, pages/screens visited, transaction count within session, session outcome (completed, abandoned, timed-out), and termination reason. Serves as the primary grain for fraud detection behavioral models, omnichannel journey tracking, and session-level SLA measurement. Links to channel_interaction for detailed event-level analysis.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`interaction` (
    `interaction_id` BIGINT COMMENT 'Primary key for interaction',
    `atm_id` BIGINT COMMENT 'Foreign key linking to channel.atm. Business justification: ATM interactions require direct ATM FK for transaction reconciliation, ATM performance analytics, cash management, and incident correlation. Removes denormalized atm_network_code in favor of proper FK',
    `branch_id` BIGINT COMMENT 'Foreign key linking to channel.branch. Business justification: The interaction table currently stores branch_location_code as a denormalized STRING, which is a normalization violation. Replacing it with a proper FK branch_id -> branch.branch_id allows joining to ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: interaction currently has channel_type (STRING) but no FK to the channel master table. Each interaction event occurs through a specific channel instance and must be linked to channel for proper channe',
    `corporate_action_id` BIGINT COMMENT 'Foreign key linking to security.corporate_action. Business justification: Corporate action servicing is a named banking process: customers contact the bank via branch, digital, or phone to inquire about or elect on dividend payments, rights issues, mergers, or tender offers',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Interactions record transaction amounts for CTR threshold monitoring and AML reporting — both require a validated currency reference to apply correct thresholds and convert to reporting currency. Bank',
    `deposit_account_id` BIGINT COMMENT 'Reference to the account involved in this interaction, if applicable.',
    `party_id` BIGINT COMMENT 'Reference to the customer or party who initiated or is associated with this interaction.',
    `session_id` BIGINT COMMENT 'Identifier for the customer session within which this interaction occurred, enabling journey reconstruction across multiple interactions.',
    `api_endpoint` STRING COMMENT 'The API endpoint URL or path invoked during the interaction. Populated only for API channel interactions.',
    `api_payload_size_bytes` STRING COMMENT 'The size of the API request or response payload in bytes. Populated only for API channel interactions.',
    `api_response_code` STRING COMMENT 'The HTTP response code returned by the API endpoint (e.g., 200, 400, 500). Populated only for API channel interactions.',
    `atm_authorization_code` STRING COMMENT 'The authorization or approval code returned by the ATM network for the transaction. Populated only for ATM channel interactions.',
    `atm_cash_dispensed_flag` BOOLEAN COMMENT 'Indicates whether cash was successfully dispensed during the ATM transaction. Populated only for ATM channel interactions.',
    `atm_response_code` STRING COMMENT 'The response code returned by the ATM network indicating success, decline, or error condition. Populated only for ATM channel interactions.',
    `atm_surcharge_amount` DECIMAL(18,2) COMMENT 'The surcharge fee applied to the ATM transaction, if applicable. Populated only for ATM channel interactions.',
    `contact_center_call_duration_seconds` STRING COMMENT 'The total duration of the contact center call in seconds. Populated only for contact center voice interactions.',
    `contact_center_interaction_mode` STRING COMMENT 'The mode of contact center interaction (e.g., Interactive Voice Response (IVR), live voice call, chat, email, Short Message Service (SMS)). Populated only for contact center channel interactions.. Valid values are `IVR|voice|chat|email|SMS`',
    `contact_center_ivr_path` STRING COMMENT 'The sequence of IVR menu selections made by the customer during the interaction. Populated only for contact center IVR interactions.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this interaction record was first created in the system.',
    `ctr_threshold_flag` BOOLEAN COMMENT 'Indicates whether the transaction amount meets or exceeds the $10,000 threshold requiring a Currency Transaction Report (CTR) filing under Bank Secrecy Act (BSA) and Financial Crimes Enforcement Network (FinCEN) regulations. Populated for branch and other cash transactions.',
    `digital_device_type` STRING COMMENT 'The type of device used for digital banking interactions. Populated only for digital banking channel interactions.. Valid values are `mobile_app|web_browser|tablet|wearable`',
    `digital_session_ip_address` STRING COMMENT 'The IP address from which the digital banking session originated. Populated only for digital banking channel interactions.',
    `digital_user_agent` STRING COMMENT 'The user agent string identifying the browser or application used for the digital banking interaction. Populated only for digital banking channel interactions.',
    `duration_seconds` STRING COMMENT 'The duration of the interaction in seconds, from initiation to completion or termination.',
    `error_code` STRING COMMENT 'The system error code if the interaction failed or encountered an error condition.',
    `error_message` STRING COMMENT 'The human-readable error message describing the failure or error condition.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'The latitude coordinate of the interaction location, if captured (e.g., for mobile banking or ATM transactions).',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'The longitude coordinate of the interaction location, if captured (e.g., for mobile banking or ATM transactions).',
    `interaction_status` STRING COMMENT 'The outcome or current status of the interaction event.. Valid values are `completed|failed|pending|cancelled|timeout|error`',
    `interaction_timestamp` TIMESTAMP COMMENT 'The precise date and time when the interaction event occurred in the channel system.',
    `interaction_type` STRING COMMENT 'The specific type of interaction or transaction performed (e.g., withdrawal, deposit, balance inquiry, login, transfer, bill payment, wire initiation, account inquiry, IVR navigation, agent call, API call).',
    `product_service_code` STRING COMMENT 'The code identifying the product or service associated with this interaction (e.g., checking account, savings account, loan product, investment product).',
    `resolution_status` STRING COMMENT 'Indicates whether the customer inquiry or issue was resolved during this interaction.. Valid values are `resolved|unresolved|escalated|pending_followup`',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the interaction met the defined SLA target time.',
    `sla_target_seconds` STRING COMMENT 'The target service level agreement time for this interaction type, measured in seconds.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'The monetary amount involved in the interaction, if applicable (e.g., withdrawal amount, deposit amount, transfer amount).',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this interaction record was last updated in the system.',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Transactional record of each discrete customer interaction event across any channel, serving as the single source of truth for all channel-originated transaction and engagement activity. Uses a channel_type discriminator to capture channel-specific attributes: ATM transactions (withdrawal, deposit, balance inquiry, cardless cash, PIN change — with network, authorization/response codes, surcharge, cash dispensed flag), branch teller transactions (cash deposit, withdrawal, check cashing, wire initiation, cashiers checks, foreign currency exchange, safe deposit box access — with teller ID, CTR threshold flag for BSA/FinCEN $10K reporting, override approvals), digital banking actions (login, transfer, bill pay, account inquiry), contact center interactions (IVR path, agent interaction, chat, email), and API calls (endpoint, response code, payload size). Captures interaction type, channel reference, timestamp, duration, amount (where applicable), currency, outcome, associated product/service, staff member (for branch/RM), resolution status, and session reference. Enables omnichannel journey reconstruction, SLA measurement, regulatory transaction reporting (CTR/SAR), and channel performance analytics.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`atm_transaction` (
    `atm_transaction_id` BIGINT COMMENT 'Unique identifier for the ATM transaction event. Primary key for the atm_transaction product.',
    `atm_id` BIGINT COMMENT 'Identifier of the ATM terminal where the transaction was executed. Links to the ATM device master record.',
    `card_id` BIGINT COMMENT 'Tokenized reference to the card used for the transaction. Links to the card master record without exposing PAN (Primary Account Number).',
    `session_id` BIGINT COMMENT 'Unique identifier for the ATM session during which this transaction occurred, used to group multiple transactions within a single customer session.',
    `chargeback_id` BIGINT COMMENT 'Foreign key linking to fraud.chargeback. Business justification: Visa/Mastercard dispute rules require the original ATM transaction reference when filing ATM chargebacks. ATM dispute processing workflows must directly link the disputed ATM transaction to its charge',
    `deposit_account_id` BIGINT COMMENT 'Identifier of the customer account debited or credited by this ATM transaction.',
    `interaction_id` BIGINT COMMENT 'Foreign key linking to channel.interaction. Business justification: The interaction table is the master transactional record of each discrete customer interaction event across any channel. An ATM transaction IS a customer interaction event — it generates an interactio',
    `original_transaction_atm_transaction_id` BIGINT COMMENT 'Reference to the original ATM transaction ID if this record represents a reversal or adjustment. Null for original transactions.',
    `party_id` BIGINT COMMENT 'Identifier of the customer (party) who initiated the ATM transaction. Links to the customer master record.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: ATM withdrawals and deposits are payment transactions requiring direct link for reconciliation, settlement, dispute resolution, and financial reporting. Core operational relationship between ATM chann',
    `legal_entity_id` BIGINT COMMENT 'Bank Identification Number (BIN) or institution code of the issuing bank that issued the card used in the transaction.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: ATM transaction currency is required for interchange fee calculation, CTR threshold monitoring, and regulatory reporting. Banking domain experts expect ATM transaction currency to reference the canoni',
    `authorization_code` STRING COMMENT 'Alphanumeric code returned by the issuing bank or card network upon successful authorization of the transaction.. Valid values are `^[A-Z0-9]{6,8}$`',
    `card_entry_mode` STRING COMMENT 'Method by which the card data was captured at the ATM: chip (EMV chip read), magnetic stripe, contactless (NFC/RFID), or manual entry.. Valid values are `chip|magnetic_stripe|contactless|manual_entry`',
    `cash_dispensed_amount` DECIMAL(18,2) COMMENT 'Actual amount of cash dispensed by the ATM, which should match the transaction amount for withdrawal transactions. Null for non-cash transactions.',
    `cash_dispensed_flag` BOOLEAN COMMENT 'Boolean indicator of whether physical cash was successfully dispensed by the ATM for this transaction (True=cash dispensed, False=no cash dispensed).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction record was first created in the data platform, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether the customer has filed a dispute or chargeback claim for this transaction. True=dispute filed, False=no dispute.',
    `fraud_flag` BOOLEAN COMMENT 'Boolean indicator of whether this transaction was flagged as potentially fraudulent by the fraud detection system. True=flagged for review, False=not flagged.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Risk score assigned by the fraud detection system indicating the likelihood of fraudulent activity, typically ranging from 0 (low risk) to 100 (high risk).',
    `interchange_fee_amount` DECIMAL(18,2) COMMENT 'Fee paid by the acquiring bank to the issuing bank for processing the ATM transaction, typically a percentage of the transaction amount plus a fixed fee.',
    `network_code` STRING COMMENT 'Card network or ATM network used to route and authorize the transaction (e.g., Visa, Mastercard, STAR, Cirrus, Plus). [ENUM-REF-CANDIDATE: visa|mastercard|star|pulse|cirrus|plus|interac|maestro — 8 candidates stripped; promote to reference product]',
    `on_us_transaction_flag` BOOLEAN COMMENT 'Boolean indicator of whether this is an on-us transaction (customer using their own banks ATM) or an off-us transaction (customer using another banks ATM). True=on-us, False=off-us.',
    `pin_verified_flag` BOOLEAN COMMENT 'Boolean indicator of whether the customers PIN was successfully verified during the transaction. True=PIN verified, False=PIN not verified or failed.',
    `posting_date` DATE COMMENT 'Date on which the transaction was posted to the customers account in the core banking system, may differ from transaction date due to batch processing.',
    `receipt_printed_flag` BOOLEAN COMMENT 'Boolean indicator of whether a paper receipt was printed for the customer (True=receipt printed, False=receipt declined or unavailable).',
    `response_code` STRING COMMENT 'Numeric code returned by the issuer or network indicating the outcome of the authorization request (e.g., 00=approved, 51=insufficient funds, 54=expired card).. Valid values are `^[0-9]{2,3}$`',
    `response_description` STRING COMMENT 'Human-readable description of the response code, explaining the reason for approval or decline (e.g., Approved, Insufficient Funds, Invalid PIN).',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator of whether this transaction was reversed due to timeout, cash dispenser failure, or other technical issue. True=transaction reversed, False=not reversed.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Total amount settled for this transaction, including transaction amount, surcharge, and any applicable fees, in the settlement currency.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the settlement amount, which may differ from transaction currency for cross-border transactions.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'Date on which the transaction will be or was settled between the acquiring and issuing banks, typically T+0 or T+1 from transaction date.',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Additional fee charged by the ATM owner for out-of-network transactions, displayed to the customer before transaction approval.',
    `terminal_location_code` STRING COMMENT 'Geographic or branch location code where the ATM terminal is physically installed, used for location-based analytics and fraud detection.',
    `terminal_type` STRING COMMENT 'Classification of the ATM terminal type: branch (inside bank branch), offsite (standalone location), mobile (portable ATM), kiosk (self-service banking kiosk), or drive-through.. Valid values are `branch|offsite|mobile|kiosk|drive_through`',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Principal monetary amount of the ATM transaction in the transaction currency, excluding any surcharges or fees.',
    `transaction_reference_number` STRING COMMENT 'Externally visible unique reference number for the ATM transaction, used for customer inquiries and dispute resolution.. Valid values are `^[A-Z0-9]{12,20}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the ATM transaction: approved (successful), declined (rejected by issuer or network), reversed (voided after initial approval), pending (awaiting settlement), timeout (no response received), or cancelled (customer aborted).. Valid values are `approved|declined|reversed|pending|timeout|cancelled`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the ATM transaction was initiated by the customer at the terminal, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `transaction_type` STRING COMMENT 'Type of ATM transaction performed: cash withdrawal, deposit, balance inquiry, PIN change, mini statement, cardless cash, inter-bank transfer, or bill payment. [ENUM-REF-CANDIDATE: withdrawal|deposit|balance_inquiry|pin_change|mini_statement|cardless_cash|inter_bank_transfer|bill_payment — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction record was last modified in the data platform, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    CONSTRAINT pk_atm_transaction PRIMARY KEY(`atm_transaction_id`)
) COMMENT 'Transactional record of each ATM transaction event — cash withdrawal, deposit, balance inquiry, PIN change, cardless cash, and inter-bank transfers. Captures ATM ID, card number (tokenized), customer reference, transaction type, amount, currency, network used (Visa/Mastercard/STAR), authorization code, response code, surcharge applied, cash dispensed flag, timestamp, and transaction status. Distinct from payment domain wire/ACH — this is ATM-channel-specific card-present transaction capture.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`channel`.`branch` ADD CONSTRAINT `fk_channel_branch_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm` ADD CONSTRAINT `fk_channel_atm_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm` ADD CONSTRAINT `fk_channel_atm_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ADD CONSTRAINT `fk_channel_digital_channel_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`session` ADD CONSTRAINT `fk_channel_session_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_atm_id` FOREIGN KEY (`atm_id`) REFERENCES `banking_ecm`.`channel`.`atm`(`atm_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_atm_id` FOREIGN KEY (`atm_id`) REFERENCES `banking_ecm`.`channel`.`atm`(`atm_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_original_transaction_atm_transaction_id` FOREIGN KEY (`original_transaction_atm_transaction_id`) REFERENCES `banking_ecm`.`channel`.`atm_transaction`(`atm_transaction_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`channel` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `banking_ecm`.`channel` SET TAGS ('dbx_domain' = 'channel');
ALTER TABLE `banking_ecm`.`channel`.`channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`channel` SET TAGS ('dbx_subdomain' = 'channel_management');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Identifier');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `bic_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Bic Directory Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `aml_monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) Monitoring Enabled');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint URL');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `channel_description` SET TAGS ('dbx_business_glossary_term' = 'Channel Description');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Status');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `channel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|decommissioned|maintenance');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'digital_banking|branch|atm|contact_center|relationship_manager|api_banking');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `customer_segment_restriction` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Restriction');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `encryption_standard` SET TAGS ('dbx_business_glossary_term' = 'Encryption Standard');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'local|regional|national|international|global');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `kyc_capability` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Capability');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `kyc_capability` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `omnichannel_orchestration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Omnichannel Orchestration Enabled');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `operating_hours_description` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Description');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `product_offering_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Offering Scope');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `product_offering_scope` SET TAGS ('dbx_value_regex' = 'all_products|restricted|custom');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `sla_response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Seconds');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Channel Subtype');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `supports_account_opening` SET TAGS ('dbx_business_glossary_term' = 'Supports Account Opening');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `supports_investment_services` SET TAGS ('dbx_business_glossary_term' = 'Supports Investment Services');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `supports_loan_origination` SET TAGS ('dbx_business_glossary_term' = 'Supports Loan Origination');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `supports_transactions` SET TAGS ('dbx_business_glossary_term' = 'Supports Transactions');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `third_party_provider` SET TAGS ('dbx_business_glossary_term' = 'Third Party Provider');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `third_party_provider` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `transaction_limit_daily` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Daily');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `transaction_limit_daily` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `transaction_limit_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Per Transaction');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `transaction_limit_per_transaction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`branch` SET TAGS ('dbx_subdomain' = 'channel_management');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Identifier');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `atm_count` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) Count');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `branch_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `branch_name` SET TAGS ('dbx_business_glossary_term' = 'Branch Name');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `branch_status` SET TAGS ('dbx_business_glossary_term' = 'Branch Status');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `branch_status` SET TAGS ('dbx_value_regex' = 'active|inactive|temporarily_closed|pending_opening|pending_closure|under_renovation');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `branch_type` SET TAGS ('dbx_business_glossary_term' = 'Branch Type');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `bsa_aml_designation` SET TAGS ('dbx_business_glossary_term' = 'Bank Secrecy Act (BSA) / Anti-Money Laundering (AML) Designation');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `bsa_aml_designation` SET TAGS ('dbx_value_regex' = 'standard|high_risk|enhanced_monitoring|exempt');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `drive_through_lanes` SET TAGS ('dbx_business_glossary_term' = 'Drive-Through Lanes');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `fdic_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Deposit Insurance Corporation (FDIC) Certificate Number');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `fdic_certificate_number` SET TAGS ('dbx_value_regex' = '^[0-9]{5,6}$');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `lease_or_owned` SET TAGS ('dbx_business_glossary_term' = 'Lease or Owned Status');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `lease_or_owned` SET TAGS ('dbx_value_regex' = 'owned|leased|ground_lease');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `market_code` SET TAGS ('dbx_business_glossary_term' = 'Market Code');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `operating_hours_saturday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Saturday');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `operating_hours_sunday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Sunday');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekday');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `parking_available` SET TAGS ('dbx_business_glossary_term' = 'Parking Available');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|flagship');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `safe_deposit_box_count` SET TAGS ('dbx_business_glossary_term' = 'Safe Deposit Box Count');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `staff_capacity` SET TAGS ('dbx_business_glossary_term' = 'Staff Capacity');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `wheelchair_accessible` SET TAGS ('dbx_business_glossary_term' = 'Wheelchair Accessible');
ALTER TABLE `banking_ecm`.`channel`.`atm` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`atm` SET TAGS ('dbx_subdomain' = 'channel_management');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `atm_id` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) Identifier');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Identifier');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `ada_compliant` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'ATM Address Line 1');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'ATM Address Line 2');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `average_daily_cash_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Cash Dispensed');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `average_daily_transactions` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Transactions');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `biometric_authentication_enabled` SET TAGS ('dbx_business_glossary_term' = 'Biometric Authentication Enabled');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `biometric_authentication_enabled` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `biometric_authentication_enabled` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `cash_cassette_configuration` SET TAGS ('dbx_business_glossary_term' = 'Cash Cassette Configuration');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `cash_cassette_count` SET TAGS ('dbx_business_glossary_term' = 'Cash Cassette Count');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `cash_replenishment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Cash Replenishment Schedule');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `cash_replenishment_schedule` SET TAGS ('dbx_value_regex' = 'daily|weekly|bi-weekly|monthly|on-demand');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `check_imaging_enabled` SET TAGS ('dbx_business_glossary_term' = 'Check Imaging Enabled');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'ATM City');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `contactless_enabled` SET TAGS ('dbx_business_glossary_term' = 'Contactless Enabled');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `daily_withdrawal_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Withdrawal Limit');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `deposit_enabled` SET TAGS ('dbx_business_glossary_term' = 'Deposit Enabled');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `encryption_standard` SET TAGS ('dbx_business_glossary_term' = 'Encryption Standard');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `encryption_standard` SET TAGS ('dbx_value_regex' = '3DES|AES-128|AES-256');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'ATM Firmware Version');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'ATM Installation Date');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'ATM Internet Protocol (IP) Address');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `last_cash_replenishment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cash Replenishment Date');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'ATM Latitude');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'ATM Location Type');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'branch|off-premise|in-lobby|drive-through|standalone');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'ATM Longitude');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'ATM Manufacturer');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `manufacturer` SET TAGS ('dbx_value_regex' = 'NCR|Diebold Nixdorf|Hyosung|GRG Banking|Fujitsu|Triton');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `max_withdrawal_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Withdrawal Amount');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `model` SET TAGS ('dbx_business_glossary_term' = 'ATM Model');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `network_affiliations` SET TAGS ('dbx_business_glossary_term' = 'ATM Network Affiliations');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'ATM Operational Status');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|out-of-service|decommissioned');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'ATM Postal Code');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'ATM Serial Number');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `service_provider` SET TAGS ('dbx_business_glossary_term' = 'ATM Service Provider');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'ATM State or Province');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `supported_transaction_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Transaction Types');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `video_banking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Video Banking Enabled');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` SET TAGS ('dbx_subdomain' = 'channel_management');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `digital_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Channel ID');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `api_gateway_endpoint` SET TAGS ('dbx_business_glossary_term' = 'API Gateway Endpoint');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `api_product_subscriptions` SET TAGS ('dbx_business_glossary_term' = 'API Product Subscriptions');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `data_access_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Access Scope');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `developer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Developer Contact Email');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `developer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `developer_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `developer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `developer_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Developer Organization Name');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `digital_channel_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Status');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `digital_channel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|decommissioned|under_review');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `eidas_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'eIDAS Certificate Reference');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `encryption_standard` SET TAGS ('dbx_business_glossary_term' = 'Encryption Standard');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `encryption_standard` SET TAGS ('dbx_value_regex' = 'tls_1_2|tls_1_3|aes_256|rsa_2048');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `environment` SET TAGS ('dbx_business_glossary_term' = 'Environment Type');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `environment` SET TAGS ('dbx_value_regex' = 'sandbox|uat|production');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `feature_flags` SET TAGS ('dbx_business_glossary_term' = 'Feature Flags');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `ip_whitelist` SET TAGS ('dbx_business_glossary_term' = 'IP Address Whitelist');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `ip_whitelist` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `is_baas_enabled` SET TAGS ('dbx_business_glossary_term' = 'Banking-as-a-Service (BaaS) Enabled Flag');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `last_activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `max_requests_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Maximum Requests Per Minute');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `oauth_client_identifier` SET TAGS ('dbx_business_glossary_term' = 'OAuth2 Client ID');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `oauth_client_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `oauth_client_secret_hash` SET TAGS ('dbx_business_glossary_term' = 'OAuth2 Client Secret Hash');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `oauth_client_secret_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `onboarding_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Approval Status');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `onboarding_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `onboarding_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Approved By');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `onboarding_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Approved Date');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `platform_variant` SET TAGS ('dbx_business_glossary_term' = 'Platform Variant');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `platform_variant` SET TAGS ('dbx_value_regex' = 'ios|android|web|rest_api|graphql|soap');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `rate_limit_tier` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Tier');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `rate_limit_tier` SET TAGS ('dbx_value_regex' = 'basic|standard|premium|enterprise|unlimited');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `session_timeout_minutes` SET TAGS ('dbx_business_glossary_term' = 'Session Timeout Minutes');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `sla_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Milliseconds');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `terms_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Terms Accepted Date');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `terms_of_service_version` SET TAGS ('dbx_business_glossary_term' = 'Terms of Service Version');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `tpp_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Provider (TPP) Registration Number');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `transaction_limit_daily` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `transaction_limit_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Per-Transaction Limit');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Channel Version');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `webhook_url` SET TAGS ('dbx_business_glossary_term' = 'Webhook URL');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `webhook_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`channel`.`session` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `country_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `country_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `application_version` SET TAGS ('dbx_business_glossary_term' = 'Application Version');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `authentication_level` SET TAGS ('dbx_business_glossary_term' = 'Authentication Level');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `authentication_level` SET TAGS ('dbx_value_regex' = 'none|basic|enhanced|strong');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'password|biometric|otp|token|certificate|sso');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `browser_name` SET TAGS ('dbx_business_glossary_term' = 'Browser Name');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `browser_version` SET TAGS ('dbx_business_glossary_term' = 'Browser Version');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|tablet|desktop|atm|kiosk|pos');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Session Duration in Seconds');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `exit_page_url` SET TAGS ('dbx_business_glossary_term' = 'Exit Page Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `landing_page_url` SET TAGS ('dbx_business_glossary_term' = 'Landing Page Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Session Notes');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `operating_system` SET TAGS ('dbx_business_glossary_term' = 'Operating System');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Session Outcome');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'completed|abandoned|timed_out|error');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `page_view_count` SET TAGS ('dbx_business_glossary_term' = 'Page View Count');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `referrer_url` SET TAGS ('dbx_business_glossary_term' = 'Referrer Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `session_status` SET TAGS ('dbx_value_regex' = 'active|completed|abandoned|timed_out|terminated');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `session_type` SET TAGS ('dbx_business_glossary_term' = 'Session Type');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `session_type` SET TAGS ('dbx_value_regex' = 'authenticated|anonymous|assisted|api');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `sla_actual_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Response Time in Milliseconds');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `sla_target_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Response Time in Milliseconds');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `token` SET TAGS ('dbx_business_glossary_term' = 'Session Token');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `token` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`channel`.`interaction` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Identifier');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `atm_id` SET TAGS ('dbx_business_glossary_term' = 'Atm Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `corporate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `api_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `api_payload_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Payload Size in Bytes');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `api_response_code` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Response Code');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `atm_authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) Authorization Code');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `atm_cash_dispensed_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) Cash Dispensed Flag');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `atm_response_code` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) Response Code');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `atm_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) Surcharge Amount');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `contact_center_call_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Contact Center Call Duration in Seconds');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `contact_center_interaction_mode` SET TAGS ('dbx_business_glossary_term' = 'Contact Center Interaction Mode');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `contact_center_interaction_mode` SET TAGS ('dbx_value_regex' = 'IVR|voice|chat|email|SMS');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `contact_center_ivr_path` SET TAGS ('dbx_business_glossary_term' = 'Contact Center Interactive Voice Response (IVR) Path');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `ctr_threshold_flag` SET TAGS ('dbx_business_glossary_term' = 'Currency Transaction Report (CTR) Threshold Flag');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `digital_device_type` SET TAGS ('dbx_business_glossary_term' = 'Digital Device Type');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `digital_device_type` SET TAGS ('dbx_value_regex' = 'mobile_app|web_browser|tablet|wearable');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `digital_session_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Digital Session Internet Protocol (IP) Address');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `digital_session_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `digital_session_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `digital_user_agent` SET TAGS ('dbx_business_glossary_term' = 'Digital User Agent');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `digital_user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `digital_user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Duration in Seconds');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_business_glossary_term' = 'Interaction Status');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_value_regex' = 'completed|failed|pending|cancelled|timeout|error');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `interaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `product_service_code` SET TAGS ('dbx_business_glossary_term' = 'Product or Service Code');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|escalated|pending_followup');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `sla_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target in Seconds');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `atm_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) Transaction ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `atm_id` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `card_id` SET TAGS ('dbx_business_glossary_term' = 'Card ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Session ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `original_transaction_atm_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Institution ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,8}$');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `card_entry_mode` SET TAGS ('dbx_business_glossary_term' = 'Card Entry Mode');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `card_entry_mode` SET TAGS ('dbx_value_regex' = 'chip|magnetic_stripe|contactless|manual_entry');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `cash_dispensed_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Dispensed Amount');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `cash_dispensed_flag` SET TAGS ('dbx_business_glossary_term' = 'Cash Dispensed Flag');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `interchange_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Amount');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `network_code` SET TAGS ('dbx_business_glossary_term' = 'Network Code');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `on_us_transaction_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Us Transaction Flag');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `pin_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Identification Number (PIN) Verified Flag');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `receipt_printed_flag` SET TAGS ('dbx_business_glossary_term' = 'Receipt Printed Flag');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Response Code');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `response_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2,3}$');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `response_description` SET TAGS ('dbx_business_glossary_term' = 'Response Description');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `terminal_location_code` SET TAGS ('dbx_business_glossary_term' = 'Terminal Location Code');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `terminal_type` SET TAGS ('dbx_business_glossary_term' = 'Terminal Type');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `terminal_type` SET TAGS ('dbx_value_regex' = 'branch|offsite|mobile|kiosk|drive_through');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12,20}$');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'approved|declined|reversed|pending|timeout|cancelled');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
