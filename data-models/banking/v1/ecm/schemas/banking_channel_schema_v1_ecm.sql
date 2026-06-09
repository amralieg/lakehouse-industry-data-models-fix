-- Schema for Domain: channel | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:26

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`channel` COMMENT 'Customer interaction channels including digital banking (mobile/web), branch network, ATM, contact center, relationship managers, and API/open banking. Manages channel configuration, omnichannel orchestration, customer journey tracking, session management, SLA tracking, and channel-specific product offerings.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`channel` (
    `channel_id` BIGINT COMMENT 'Primary key for channel',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Channels are licensed and regulated under specific jurisdictions (e.g., FCA, OCC, ECB). Critical for regulatory reporting, compliance validation, and determining applicable capital adequacy and stress',
    `aml_monitoring_enabled` BOOLEAN COMMENT 'Indicates whether transactions through this channel are subject to real-time or near-real-time AML transaction monitoring.',
    `api_endpoint_url` STRING COMMENT 'Base URL for API-based channels (open banking API, BaaS API). Null for non-API channels.',
    `authentication_method` STRING COMMENT 'Primary authentication method(s) used by the channel (e.g., username/password, biometric, two-factor authentication, certificate-based, in-person verification). [ENUM-REF-CANDIDATE: username_password|biometric|mfa|certificate|oauth|saml|in_person|pin|token — promote to reference product]',
    `channel_code` STRING COMMENT 'Unique business identifier code for the channel, used for external references and system integration. Follows bank-specific channel coding standards.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `channel_description` STRING COMMENT 'Detailed description of the channels purpose, capabilities, and target customer segments.',
    `channel_name` STRING COMMENT 'Human-readable name of the channel (e.g., Mobile Banking App, Downtown Branch, Corporate API Gateway).',
    `channel_status` STRING COMMENT 'Current operational status of the channel in its lifecycle.. Valid values are `active|inactive|suspended|planned|decommissioned|maintenance`',
    `channel_type` STRING COMMENT 'Primary classification of the channel. Aligned with ISO 20022 channel type taxonomy where applicable.. Valid values are `digital_banking|branch|atm|contact_center|relationship_manager|api_banking`',
    `cost_center_code` STRING COMMENT 'General ledger cost center code to which channel operating expenses are allocated.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the primary country where the channel operates. For multi-country channels, this represents the home country.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the channel record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the primary currency supported by the channel. Multi-currency channels may reference additional currencies in configuration tables.. Valid values are `^[A-Z]{3}$`',
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
    `swift_bic_code` STRING COMMENT 'SWIFT BIC code associated with the channel if it represents a branch or location with its own BIC. Null for non-branch channels or branches without unique BIC.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `termination_date` DATE COMMENT 'Date when the channel was or will be decommissioned and no longer available. Null for active channels.',
    `third_party_provider` STRING COMMENT 'Name of third-party vendor or technology provider if the channel is operated or enabled by an external partner (e.g., fintech platform, BaaS provider, core banking vendor). Null if operated in-house.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the channels primary operating location (e.g., America/New_York, Europe/London).',
    `transaction_limit_daily` DECIMAL(18,2) COMMENT 'Maximum aggregate transaction amount allowed per customer per day through this channel. Null if no limit applies.',
    `transaction_limit_per_transaction` DECIMAL(18,2) COMMENT 'Maximum single transaction amount allowed through this channel. Null if no limit applies.',
    CONSTRAINT pk_channel PRIMARY KEY(`channel_id`)
) COMMENT 'Master registry of all customer interaction channels operated by the bank, serving as the SSOT for channel identity, classification, and configuration. Covers digital channels (mobile app, web banking), branch network, ATM network, contact center, relationship manager, and API/open banking channels, with support for emerging channel types including embedded finance and Banking-as-a-Service (BaaS). Captures channel type (aligned with ISO 20022 channel type codes where applicable), channel status, capabilities, supported products and services, operating hours, geographic coverage, regulatory classification, and channel-specific configuration parameters. Each channel sub-type (branch, ATM, digital_channel, contact_center) maintains its own detailed master record that FKs back to this registry for unified channel governance, omnichannel orchestration, and enterprise channel performance reporting.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`branch` (
    `branch_id` BIGINT COMMENT 'Unique identifier for the branch location. Primary key for the branch entity.',
    `regulatory_exam_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_exam. Business justification: Branches are regulatory exam targets (BSA/AML branch exams, CRA performance evaluations, consumer compliance exams). Link enables exam scoping, document request coordination, and findings attribution.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Branches follow local holiday calendars for operating hours and business day calculations. Critical for SLA compliance, customer service planning, transaction settlement timing, and workforce scheduli',
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
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the branch is located.. Valid values are `^[A-Z]{3}$`',
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
    `regulatory_jurisdiction` STRING COMMENT 'Primary regulatory authority or jurisdiction governing the branch operations. May include federal, state, or international regulatory bodies depending on location.',
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
    `country_code` STRING COMMENT 'Three-letter ISO country code where the ATM is located (e.g., USA, CAN, GBR).. Valid values are `^[A-Z]{3}$`',
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
    `surcharge_currency_code` STRING COMMENT 'Three-letter ISO currency code for the surcharge amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this ATM record was last modified in the system.',
    `video_banking_enabled` BOOLEAN COMMENT 'Indicates whether the ATM supports live video teller assistance (True) or not (False).',
    CONSTRAINT pk_atm PRIMARY KEY(`atm_id`)
) COMMENT 'Master record for each ATM unit in the banks owned and managed network. Captures ATM ID, serial number, model, manufacturer, location (branch-attached or off-premise), address, geographic coordinates, network affiliations (Visa/Mastercard/STAR/Allpoint), supported transaction types, cash cassette configuration, surcharge policy, accessibility compliance (ADA), operational status, last maintenance date, and cash replenishment schedule.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`digital_channel` (
    `digital_channel_id` BIGINT COMMENT 'Unique identifier for the digital channel instance, registered API consumer, or third-party provider application.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Digital channel instances should reference their parent channel definition in the master channel registry. This resolves the silo issue for digital_channel. The FK links each digital banking platform ',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Digital channels operate under specific regulatory jurisdictions (PSD2, eIDAS, CFPB 1033). Critical for TPP registration validation, API governance, consent management, and regulatory compliance in op',
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

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`contact_center` (
    `contact_center_id` BIGINT COMMENT 'Unique identifier for the contact center operational unit.',
    `holiday_calendar_id` BIGINT COMMENT 'Foreign key linking to reference.holiday_calendar. Business justification: Contact centers follow holiday calendars for staffing models, operating hours, and SLA compliance. Critical for workforce management, call routing, and ensuring adequate coverage during business days.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Contact centers require supervisor assignment for operational hierarchy, escalation handling, quality monitoring, workforce management, and SLA accountability. Essential for performance reporting and ',
    `call_recording_policy` STRING COMMENT 'Recording policy for customer interactions: all calls (100% recording), sample (random subset), none (no recording), or regulatory-only (only calls subject to compliance requirements).. Valid values are `all_calls|sample|none|regulatory_only`',
    `center_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the contact center for operational reporting and routing (e.g., NYC-IB-01, MUM-CS-02).. Valid values are `^[A-Z0-9]{3,10}$`',
    `center_name` STRING COMMENT 'Business name of the contact center operational unit (e.g., New York Inbound Voice Center, Mumbai Customer Service Hub).',
    `center_type` STRING COMMENT 'Primary operational mode of the contact center: inbound voice (customer-initiated calls), outbound campaigns (proactive outreach), IVR self-service (Interactive Voice Response), live chat, secure email, SMS, or video banking. [ENUM-REF-CANDIDATE: inbound_voice|outbound_campaigns|ivr_self_service|live_chat|secure_email|sms|video_banking — 7 candidates stripped; promote to reference product]',
    `city` STRING COMMENT 'City where the contact center is located.',
    `core_banking_integration_endpoint` STRING COMMENT 'API endpoint or system identifier for core banking system integration to access account and transaction data during customer interactions.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the contact center is domiciled (e.g., USA, GBR, IND).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact center record was first created in the system.',
    `crm_integration_endpoint` STRING COMMENT 'API endpoint or system identifier for CRM integration to retrieve customer context and log interactions.',
    `effective_from_date` DATE COMMENT 'Date when this contact center configuration became effective and operational.',
    `effective_to_date` DATE COMMENT 'Date when this contact center configuration ceased to be effective. Null for currently active centers.',
    `ivr_menu_structure` STRING COMMENT 'High-level description or reference to the IVR menu flow and options available to callers (e.g., Press 1 for Accounts, 2 for Loans, 3 for Cards).',
    `ivr_tree_version` STRING COMMENT 'Version identifier of the IVR menu tree configuration currently deployed at this contact center (e.g., v3.2.1).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contact center record was last updated.',
    `location_type` STRING COMMENT 'Physical deployment model: physical (on-premises facility), virtual (cloud-based or remote workforce), or hybrid (combination of both).. Valid values are `physical|virtual|hybrid`',
    `operating_hours_friday` STRING COMMENT 'Operating hours on Friday in HH:MM-HH:MM format. Null if closed.',
    `operating_hours_monday` STRING COMMENT 'Operating hours on Monday in HH:MM-HH:MM format (e.g., 08:00-20:00). Null if closed.',
    `operating_hours_saturday` STRING COMMENT 'Operating hours on Saturday in HH:MM-HH:MM format. Null if closed.',
    `operating_hours_sunday` STRING COMMENT 'Operating hours on Sunday in HH:MM-HH:MM format. Null if closed.',
    `operating_hours_thursday` STRING COMMENT 'Operating hours on Thursday in HH:MM-HH:MM format. Null if closed.',
    `operating_hours_tuesday` STRING COMMENT 'Operating hours on Tuesday in HH:MM-HH:MM format. Null if closed.',
    `operating_hours_wednesday` STRING COMMENT 'Operating hours on Wednesday in HH:MM-HH:MM format. Null if closed.',
    `operational_status` STRING COMMENT 'Current operational state of the contact center: active (fully operational), inactive (temporarily offline), maintenance (scheduled downtime), or decommissioned (permanently closed).. Valid values are `active|inactive|maintenance|decommissioned`',
    `pci_dss_compliant` BOOLEAN COMMENT 'Indicates whether this contact center is certified compliant with PCI-DSS standards for handling payment card information.',
    `pci_dss_scope` STRING COMMENT 'Description of PCI-DSS scope for this contact center (e.g., Full card data capture, Tokenized payments only, No card handling).',
    `physical_address` STRING COMMENT 'Full street address of the contact center facility if physical or hybrid. Null for fully virtual centers.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the contact center location.',
    `priority_rules` STRING COMMENT 'Business rules defining customer prioritization in queue (e.g., Private Banking clients priority 1, Retail clients priority 2).',
    `quality_monitoring_enabled` BOOLEAN COMMENT 'Indicates whether quality assurance monitoring and scoring is active for this contact center.',
    `queue_routing_model` STRING COMMENT 'Call distribution strategy: skill-based (route to agents with specific skills), priority-based (VIP customers first), round-robin (sequential distribution), or least-occupied (agent with fewest active calls).. Valid values are `skill_based|priority_based|round_robin|least_occupied`',
    `sla_abandonment_rate_percent` DECIMAL(18,2) COMMENT 'Target maximum percentage of calls abandoned by customers before reaching an agent, per SLA commitment.',
    `sla_average_handle_time_seconds` STRING COMMENT 'Target average duration in seconds for an agent to complete a customer interaction (talk time plus after-call work), per SLA commitment.',
    `sla_average_speed_of_answer_seconds` STRING COMMENT 'Target average time in seconds for an agent to answer an incoming call, per SLA commitment.',
    `sla_first_call_resolution_percent` DECIMAL(18,2) COMMENT 'Target percentage of customer issues resolved on the first contact without requiring follow-up, per SLA commitment.',
    `staffing_model` STRING COMMENT 'Workforce composition: in-house (bank employees only), outsourced (third-party vendor), or blended (mix of both).. Valid values are `in_house|outsourced|blended`',
    `state_province` STRING COMMENT 'State or province where the contact center is located.',
    `supported_languages` STRING COMMENT 'Comma-separated list of ISO 639-1 language codes supported by this contact center (e.g., en,es,fr,hi).',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the contact centers operating hours (e.g., America/New_York, Asia/Kolkata).',
    `vendor_name` STRING COMMENT 'Name of the third-party vendor operating this contact center if staffing model is outsourced or blended. Null for in-house centers.',
    `workforce_management_system` STRING COMMENT 'Name or identifier of the workforce management platform used for agent scheduling, forecasting, and capacity planning (e.g., Verint WFM, NICE IEX).',
    CONSTRAINT pk_contact_center PRIMARY KEY(`contact_center_id`)
) COMMENT 'Master record for each contact center operational unit including inbound voice, outbound campaigns, IVR self-service, live chat, secure email, SMS, and video banking. Captures center name, physical/virtual location, operating hours by day of week, supported languages, IVR tree version and menu structure, queue management configuration (skill-based routing, priority rules), staffing model (in-house, outsourced, blended), SLA targets (average speed of answer, average handle time, first call resolution, abandonment rate), call recording and quality monitoring policy, PCI-DSS compliance scope for payment card handling, and integration endpoints with CRM and core banking. Supports omnichannel orchestration, workforce management, and contact center performance benchmarking.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`session` (
    `session_id` BIGINT COMMENT 'Primary key for session',
    `channel_id` BIGINT COMMENT 'Reference to the channel through which the session was initiated (mobile app, web banking, branch, ATM, contact center, relationship manager, API).',
    `continuous_monitoring_id` BIGINT COMMENT 'Foreign key linking to audit.continuous_monitoring. Business justification: Sessions are monitored continuously for fraud patterns, authentication failures, suspicious login activity, and session hijacking. Continuous monitoring programs track session anomalies in real-time a',
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
    `geolocation_country_code` STRING COMMENT 'Three-letter ISO country code representing the geographic origin of the session.. Valid values are `^[A-Z]{3}$`',
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
    `api_application_id` BIGINT COMMENT 'The identifier of the third-party application or client that invoked the API. Populated only for API channel interactions.',
    `atm_id` BIGINT COMMENT 'Foreign key linking to channel.atm. Business justification: ATM interactions require direct ATM FK for transaction reconciliation, ATM performance analytics, cash management, and incident correlation. Removes denormalized atm_network_code in favor of proper FK',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Audit engagements routinely examine customer interactions for compliance testing (AML, fair lending, sales practices). Auditors trace interactions to findings and sample them as evidence in workpapers',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: interaction currently has channel_type (STRING) but no FK to the channel master table. Each interaction event occurs through a specific channel instance and must be linked to channel for proper channe',
    `channel_relationship_manager_id` BIGINT COMMENT 'The identifier of the relationship manager who facilitated the interaction. Populated only for relationship manager channel interactions.',
    `contact_center_id` BIGINT COMMENT 'Foreign key linking to channel.contact_center. Business justification: Contact center interactions require center attribution for workforce management, SLA tracking, quality monitoring, and center performance analytics. Critical for contact center operations and regulato',
    `deposit_account_id` BIGINT COMMENT 'Reference to the account involved in this interaction, if applicable.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Channel interactions capture securities trading, investment advisory sessions, and product inquiries. Banking operations require tracking which instruments were discussed, traded, or serviced in each ',
    `employee_id` BIGINT COMMENT 'The identifier of the contact center agent who handled the interaction. Populated only for contact center channel interactions.',
    `interaction_employee_id` BIGINT COMMENT 'The identifier of the teller who processed the branch transaction. Populated only for branch channel interactions.',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Customer interactions affected by operational risk events (system failures, fraud attempts, process errors) require linkage for incident impact analysis, customer remediation tracking, and regulatory ',
    `override_approval_id` BIGINT COMMENT 'The identifier of the supervisory override or approval granted for exceptions or limit overrides during the transaction. Populated for branch and contact center interactions requiring approval.',
    `party_id` BIGINT COMMENT 'Reference to the customer or party who initiated or is associated with this interaction.',
    `session_id` BIGINT COMMENT 'Identifier for the customer session within which this interaction occurred, enabling journey reconstruction across multiple interactions.',
    `api_endpoint` STRING COMMENT 'The API endpoint URL or path invoked during the interaction. Populated only for API channel interactions.',
    `api_payload_size_bytes` STRING COMMENT 'The size of the API request or response payload in bytes. Populated only for API channel interactions.',
    `api_response_code` STRING COMMENT 'The HTTP response code returned by the API endpoint (e.g., 200, 400, 500). Populated only for API channel interactions.',
    `atm_authorization_code` STRING COMMENT 'The authorization or approval code returned by the ATM network for the transaction. Populated only for ATM channel interactions.',
    `atm_cash_dispensed_flag` BOOLEAN COMMENT 'Indicates whether cash was successfully dispensed during the ATM transaction. Populated only for ATM channel interactions.',
    `atm_response_code` STRING COMMENT 'The response code returned by the ATM network indicating success, decline, or error condition. Populated only for ATM channel interactions.',
    `atm_surcharge_amount` DECIMAL(18,2) COMMENT 'The surcharge fee applied to the ATM transaction, if applicable. Populated only for ATM channel interactions.',
    `branch_location_code` STRING COMMENT 'The code identifying the branch location where the interaction occurred. Populated only for branch channel interactions.',
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
    `transaction_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the transaction amount.. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this interaction record was last updated in the system.',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Transactional record of each discrete customer interaction event across any channel, serving as the single source of truth for all channel-originated transaction and engagement activity. Uses a channel_type discriminator to capture channel-specific attributes: ATM transactions (withdrawal, deposit, balance inquiry, cardless cash, PIN change — with network, authorization/response codes, surcharge, cash dispensed flag), branch teller transactions (cash deposit, withdrawal, check cashing, wire initiation, cashiers checks, foreign currency exchange, safe deposit box access — with teller ID, CTR threshold flag for BSA/FinCEN $10K reporting, override approvals), digital banking actions (login, transfer, bill pay, account inquiry), contact center interactions (IVR path, agent interaction, chat, email), and API calls (endpoint, response code, payload size). Captures interaction type, channel reference, timestamp, duration, amount (where applicable), currency, outcome, associated product/service, staff member (for branch/RM), resolution status, and session reference. Enables omnichannel journey reconstruction, SLA measurement, regulatory transaction reporting (CTR/SAR), and channel performance analytics.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`sla` (
    `sla_id` BIGINT COMMENT 'Primary key for sla',
    `channel_id` BIGINT COMMENT 'Reference to the customer interaction channel (digital banking, branch, ATM, contact center, relationship manager, API/open banking) to which this SLA applies.',
    `interaction_id` BIGINT COMMENT 'Reference identifier of the specific customer interaction or transaction that experienced the SLA breach.',
    `sla_breach_id` BIGINT COMMENT 'Unique identifier for a specific SLA breach instance; null if this record is an SLA definition rather than a breach event.',
    `actual_resolution_time_minutes` STRING COMMENT 'Actual time in minutes taken to fully resolve customer interaction; used to compare against target for breach detection.',
    `actual_response_time_minutes` STRING COMMENT 'Actual time in minutes taken to provide initial response to customer interaction; used to compare against target for breach detection.',
    `breach_penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty or credit applied to customer or internal cost center as a result of the SLA breach.',
    `breach_penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the breach penalty amount.. Valid values are `^[A-Z]{3}$`',
    `breach_severity` STRING COMMENT 'Severity classification of the SLA breach based on magnitude of delay and customer impact.. Valid values are `low|medium|high|critical`',
    `breach_timestamp` TIMESTAMP COMMENT 'Date and time when the SLA breach occurred.',
    `breach_type` STRING COMMENT 'Type of SLA breach that occurred (response time exceeded, resolution time exceeded, escalation threshold breached).. Valid values are `response_time|resolution_time|escalation`',
    `channel_type` STRING COMMENT 'Type of customer interaction channel covered by this SLA.. Valid values are `digital_banking_mobile|digital_banking_web|branch|atm|contact_center|relationship_manager`',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this SLA record.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA record (definition or breach event) was first created in the system.',
    `customer_impact_assessment` STRING COMMENT 'Assessment of the impact of the SLA breach on customer experience, satisfaction, and business relationship.',
    `effective_from_date` DATE COMMENT 'Date from which this SLA definition becomes active and enforceable.',
    `effective_to_date` DATE COMMENT 'Date until which this SLA definition remains active; null indicates open-ended SLA.',
    `escalation_threshold_minutes` STRING COMMENT 'Time threshold in minutes after which unresolved interaction must be escalated to higher support tier or management.',
    `interaction_category` STRING COMMENT 'Category of customer interaction or transaction type covered by this SLA (e.g., account inquiry, loan application, wire transfer, complaint).. Valid values are `account_inquiry|loan_application|wire_transfer|complaint|payment_processing|service_request`',
    `measurement_methodology` STRING COMMENT 'Description of how SLA performance is measured and calculated (e.g., business hours vs. calendar hours, start/end event definitions).',
    `regulator_case_number` STRING COMMENT 'Case or reference number assigned by the regulatory authority if the breach was escalated or reported.',
    `regulatory_basis` STRING COMMENT 'Regulatory requirement or standard that mandates or informs this SLA (e.g., CFPB complaint resolution timelines, OCC service standards).',
    `remediation_action_taken` STRING COMMENT 'Description of corrective or remediation actions taken in response to the SLA breach.',
    `reported_to_regulator_flag` BOOLEAN COMMENT 'Indicates whether this SLA breach was reported to a regulatory authority (CFPB, OCC) as part of compliance reporting.',
    `responsible_channel` STRING COMMENT 'Name or identifier of the channel or operational unit responsible for the breach.',
    `responsible_team` STRING COMMENT 'Name or identifier of the team or department responsible for the breach.',
    `root_cause_category` STRING COMMENT 'Categorized root cause of the SLA breach (system outage, staffing shortage, process failure, high volume, training gap, third-party delay).. Valid values are `system_outage|staffing_shortage|process_failure|high_volume|training_gap|third_party_delay`',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause analysis findings for the SLA breach.',
    `sla_name` STRING COMMENT 'Business-friendly name of the SLA definition (e.g., Mobile Banking Account Inquiry Response Time, Branch Complaint Resolution SLA).',
    `sla_status` STRING COMMENT 'Current lifecycle status of the SLA definition.. Valid values are `active|inactive|suspended|under_review`',
    `target_resolution_time_minutes` STRING COMMENT 'Target time in minutes for complete resolution of customer interaction or request.',
    `target_response_time_minutes` STRING COMMENT 'Target time in minutes for initial response to customer interaction or request.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the user who last updated this SLA record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this SLA record was last modified.',
    CONSTRAINT pk_sla PRIMARY KEY(`sla_id`)
) COMMENT 'Master record defining SLA targets and thresholds for each channel and interaction type combination, including breach event tracking. Captures SLA name, channel type, interaction category (account inquiry, loan application, wire transfer, complaint), target response time, target resolution time, escalation thresholds, measurement methodology, effective date range, and regulatory basis (CFPB complaint resolution timelines, OCC service standards). Also records each SLA breach instance: breach type (response time, resolution time, escalation), actual vs. target metric, breach severity, root cause category, responsible channel/team, remediation action taken, customer impact assessment, and breach penalty applied. Feeds SLA monitoring dashboards, regulatory reporting (CFPB complaint SLA compliance), and operational improvement programs.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`sla_breach` (
    `sla_breach_id` BIGINT COMMENT 'Unique identifier for the SLA breach record.',
    `finding_id` BIGINT COMMENT 'Foreign key linking to audit.finding. Business justification: SLA breaches are frequently cited as evidence in audit findings related to operational risk, customer service failures, and control deficiencies. Auditors link breaches to findings for root cause anal',
    `channel_id` BIGINT COMMENT 'Reference to the channel where the SLA breach occurred (mobile, web, branch, ATM, contact center).',
    `interaction_id` BIGINT COMMENT 'Reference to the customer interaction or case that triggered the SLA breach.',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Material SLA breaches trigger operational risk event logging for regulatory reporting (operational loss data collection) and root cause analysis. Banks must track SLA failures as operational risk even',
    `party_id` BIGINT COMMENT 'Reference to the customer or party affected by the SLA breach.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or relationship manager responsible for handling the interaction that breached the SLA.',
    `breach_id` BIGINT COMMENT 'Foreign key linking to compliance.breach. Business justification: Channel SLA breaches that violate regulatory commitments (Reg E error resolution timing, complaint response deadlines, accessibility requirements) escalate to compliance breaches. Link enables regulat',
    `actual_metric_value` DECIMAL(18,2) COMMENT 'The actual metric value achieved, which exceeded the SLA target (e.g., 45 seconds, 3 hours, 2 business days).',
    `breach_reference_number` STRING COMMENT 'Externally-known unique reference number for the SLA breach incident.',
    `breach_severity` STRING COMMENT 'Severity classification of the SLA breach based on impact and deviation magnitude.. Valid values are `critical|high|medium|low`',
    `breach_status` STRING COMMENT 'Current status of the SLA breach in the remediation workflow.. Valid values are `open|under_review|remediated|closed|escalated|pending_approval`',
    `breach_timestamp` TIMESTAMP COMMENT 'The exact date and time when the SLA target was breached.',
    `breach_type` STRING COMMENT 'Type of SLA metric that was breached (response time, resolution time, escalation time, acknowledgment time, callback time, processing time).. Valid values are `response_time|resolution_time|escalation_time|acknowledgment_time|callback_time|processing_time`',
    `business_line` STRING COMMENT 'The line of business or business unit where the SLA breach occurred (retail banking, investment banking, wealth management, etc.).',
    `channel_sla_id` BIGINT COMMENT 'Reference to the SLA definition that was breached.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when the SLA breach case was formally closed.',
    `comments` STRING COMMENT 'Additional notes or comments regarding the SLA breach incident and its handling.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Monetary value of compensation or credit offered to the customer for the SLA breach.',
    `compensation_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the compensation amount.. Valid values are `^[A-Z]{3}$`',
    `compensation_offered_flag` BOOLEAN COMMENT 'Indicates whether compensation or goodwill gesture was offered to the customer due to the SLA breach.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the SLA breach occurred.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA breach record was first created in the system.',
    `customer_impact_assessment` STRING COMMENT 'Assessment of the impact of the SLA breach on the customer experience and satisfaction.. Valid values are `no_impact|low_impact|moderate_impact|high_impact|critical_impact`',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'The date and time when the customer was notified about the SLA breach.',
    `customer_notified_flag` BOOLEAN COMMENT 'Indicates whether the customer was notified about the SLA breach.',
    `detected_timestamp` TIMESTAMP COMMENT 'The date and time when the SLA breach was detected by the monitoring system.',
    `deviation_percentage` DECIMAL(18,2) COMMENT 'The percentage deviation from the SLA target ((actual - target) / target * 100).',
    `deviation_value` DECIMAL(18,2) COMMENT 'The magnitude of deviation from the SLA target (actual minus target).',
    `escalation_level` STRING COMMENT 'The escalation tier or level reached during the breach handling process (0 = no escalation, 1 = first level, 2 = second level, etc.).',
    `geographic_region` STRING COMMENT 'The geographic region or market where the SLA breach occurred.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this SLA breach record was last updated.',
    `metric_unit` STRING COMMENT 'Unit of measure for the SLA metric (seconds, minutes, hours, business days, calendar days).. Valid values are `seconds|minutes|hours|business_days|calendar_days`',
    `product_category` STRING COMMENT 'The product or service category associated with the interaction that breached the SLA (deposits, loans, payments, investments, etc.).',
    `regulatory_report_submission_date` DATE COMMENT 'The date when the regulatory report was submitted.',
    `regulatory_report_submitted_flag` BOOLEAN COMMENT 'Indicates whether a regulatory report has been submitted for this SLA breach.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this SLA breach is reportable to regulatory bodies such as Consumer Financial Protection Bureau (CFPB) for complaint SLA compliance.',
    `remediation_action_taken` STRING COMMENT 'Description of the corrective or remediation action taken to address the SLA breach.',
    `remediation_timestamp` TIMESTAMP COMMENT 'The date and time when remediation action was completed.',
    `responsible_team` STRING COMMENT 'The team or department responsible for the channel or process where the breach occurred.',
    `root_cause_category` STRING COMMENT 'Primary category of the root cause that led to the SLA breach.. Valid values are `system_outage|high_volume|staff_shortage|process_failure|technical_issue|third_party_delay`',
    `root_cause_description` STRING COMMENT 'Detailed description of the root cause analysis findings for the SLA breach.',
    `target_metric_value` DECIMAL(18,2) COMMENT 'The SLA target metric value that was expected to be met (e.g., 30 seconds, 2 hours, 1 business day).',
    CONSTRAINT pk_sla_breach PRIMARY KEY(`sla_breach_id`)
) COMMENT 'Transactional record capturing each instance where a channel SLA target was breached. Captures the associated SLA definition, interaction or case reference, breach type (response time, resolution time, escalation), actual vs. target metric, breach severity, root cause category, responsible channel/team, remediation action taken, and customer impact assessment. Feeds regulatory reporting (CFPB complaint SLA compliance) and operational improvement programs.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`channel_relationship_manager` (
    `channel_relationship_manager_id` BIGINT COMMENT 'Unique identifier for the relationship manager record within the channel domain. Primary key.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Relationship managers track AUM in specific currencies for performance measurement and compensation calculations. Critical for portfolio management, revenue attribution, and RM performance reporting i',
    `employee_id` BIGINT COMMENT 'Human Capital Management system employee identifier for the relationship manager. Links to HR system of record.',
    `assigned_branch_code` STRING COMMENT 'Branch or office location code where the relationship manager is primarily based. May be null for virtual or regional coverage models.. Valid values are `^[A-Z0-9]{4,10}$`',
    `assignment_end_date` DATE COMMENT 'Date the relationship manager ended or is scheduled to end their current role or LOB assignment. Null for active assignments.',
    `assignment_start_date` DATE COMMENT 'Date the relationship manager began their current role or LOB assignment. May differ from hire date if the RM transferred from another role.',
    `aum_under_management` DECIMAL(18,2) COMMENT 'Total assets under management attributed to this relationship manager, measured in the banks reporting currency. Updated periodically from portfolio valuation systems.',
    `certification_list` STRING COMMENT 'Comma-separated list of professional certifications held by the relationship manager (e.g., CFA, CFP, CPA, MBA). Used for client matching and regulatory compliance.',
    `channel_relationship_manager_status` STRING COMMENT 'Current employment and assignment status of the relationship manager. Determines whether the RM is actively managing clients.. Valid values are `active|on_leave|terminated|retired|suspended|transferred`',
    `client_count` STRING COMMENT 'Total number of active clients assigned to this relationship manager as primary or secondary coverage.',
    `compensation_grade` STRING COMMENT 'Compensation grade or band assigned to the relationship manager. Used for salary benchmarking and equity analysis.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of the relationship manager. Indicates whether all required training, licenses, and certifications are current.. Valid values are `compliant|pending_review|non_compliant|exempted`',
    `cost_center_code` STRING COMMENT 'General ledger cost center code to which the relationship managers compensation and expenses are allocated.. Valid values are `^[A-Z0-9]{4,10}$`',
    `coverage_region` STRING COMMENT 'Geographic region or territory assigned to the relationship manager for client coverage (e.g., Northeast, EMEA, Asia-Pacific, North America).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this relationship manager record was first created in the channel domain. Used for audit trail and data lineage.',
    `email_address` STRING COMMENT 'Corporate email address of the relationship manager for client communication and internal correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `full_name` STRING COMMENT 'Full legal name of the relationship manager as recorded in the HR system.',
    `hire_date` DATE COMMENT 'Date the relationship manager was hired by the bank. Used for tenure calculation and benefits eligibility.',
    `incentive_eligible_flag` BOOLEAN COMMENT 'Indicates whether the relationship manager is eligible for performance-based incentive compensation. True if eligible, False otherwise.',
    `language_proficiency` STRING COMMENT 'Comma-separated list of languages spoken by the relationship manager with proficiency levels (e.g., English-Native, Spanish-Fluent, Mandarin-Conversational). Used for client matching.',
    `last_compliance_review_date` DATE COMMENT 'Date of the most recent compliance review or audit for this relationship manager. Used to track regulatory adherence and training currency.',
    `licensed_products` STRING COMMENT 'Comma-separated list of financial licenses and product authorizations held by the RM (e.g., Series 7, Series 65, insurance, derivatives, structured products).',
    `lob_assignment` STRING COMMENT 'Primary line of business to which the relationship manager is assigned. Determines product authority and client segmentation.. Valid values are `commercial_banking|wealth_management|investment_banking|private_banking|corporate_banking|retail_banking`',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next compliance review or performance evaluation. Used for proactive compliance management.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context about the relationship manager, including handoff notes, portfolio transfer history, or special considerations.',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating for the relationship manager. Updated annually or per performance review cycle.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated`',
    `phone_number` STRING COMMENT 'Primary business phone number for the relationship manager. Used for client contact and internal communication.',
    `portfolio_tier` STRING COMMENT 'Client portfolio tier classification indicating the seniority and complexity of clients managed by this RM.. Valid values are `tier_1|tier_2|tier_3|emerging|institutional`',
    `revenue_target` DECIMAL(18,2) COMMENT 'Annual revenue target assigned to the relationship manager, measured in the banks reporting currency. Used for performance evaluation and compensation planning.',
    `source_system` STRING COMMENT 'Name of the source system from which this relationship manager record originated (e.g., Workday, SAP SuccessFactors, Core Banking System).',
    `specialization` STRING COMMENT 'Industry sectors or client types in which the relationship manager has specialized expertise (e.g., healthcare, technology, real estate, family offices).',
    `termination_date` DATE COMMENT 'Date the relationship manager left the bank or was terminated. Null for active employees. Triggers client reassignment workflow.',
    `termination_reason` STRING COMMENT 'Reason for the relationship managers departure from the bank. Used for HR analytics and exit pattern analysis.. Valid values are `voluntary_resignation|retirement|involuntary_termination|transfer|end_of_contract|other`',
    `title` STRING COMMENT 'Official job title of the relationship manager (e.g., Vice President - Commercial Banking, Senior Wealth Advisor, Managing Director - Investment Banking).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this relationship manager record was last modified. Used for change tracking and data freshness monitoring.',
    `years_of_experience` STRING COMMENT 'Total years of professional experience in banking and financial services. Used for client matching and portfolio tier assignment.',
    CONSTRAINT pk_channel_relationship_manager PRIMARY KEY(`channel_relationship_manager_id`)
) COMMENT 'Master record for each relationship manager (RM) serving corporate, commercial, or private banking clients, including complete client portfolio assignment history. Captures RM employee ID, name, title, LOB assignment (commercial banking, wealth management, investment banking), portfolio tier, licensed products (Series 7, Series 65, insurance), assigned branch or coverage region, AUM under management, client count, revenue target, and performance rating. Embeds the full client assignment association: customer ID, assignment type (primary, secondary, coverage), assignment start/end dates, LOB context, assignment reason, AUM at assignment, revenue attributed, handoff notes, and reassignment/portfolio transfer history. Serves as the SSOT for RM identity, client coverage, coverage continuity, and RM performance attribution within the channel domain.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`rm_client_assignment` (
    `rm_client_assignment_id` BIGINT COMMENT 'Unique identifier for the relationship manager client assignment record.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the RM team or group responsible for this client assignment. Used for team-based service models.',
    `party_id` BIGINT COMMENT 'Identifier of the customer assigned to the relationship manager. Links to the customer master record.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Identifier of the next relationship manager who will serve this client after the current assignment ends. Used for planned transitions and coverage continuity.',
    `tertiary_rm_channel_relationship_manager_id` BIGINT COMMENT 'Identifier of the previous relationship manager who served this client before the current assignment. Used to track RM succession and handoff history.',
    `assignment_approval_date` DATE COMMENT 'Date when this RM-client assignment was formally approved by management or compliance. Used for governance and audit trail.',
    `assignment_approved_by` STRING COMMENT 'User ID or name of the manager or compliance officer who approved this RM-client assignment. Used for accountability and audit trail.',
    `assignment_channel` STRING COMMENT 'Primary channel through which the RM-client relationship is managed and serviced. Indicates the dominant interaction mode.. Valid values are `branch|contact_center|digital|mobile|relationship_manager|api`',
    `assignment_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RM-client assignment record was first created in the system. Used for audit trail and data lineage.',
    `assignment_end_date` DATE COMMENT 'Date when the relationship manager assignment to the client ended or is scheduled to end. Null for ongoing assignments.',
    `assignment_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this assignment record. Used for audit trail and accountability.',
    `assignment_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this RM-client assignment record was last modified or updated. Used for change tracking and audit trail.',
    `assignment_priority` STRING COMMENT 'Priority level of this client assignment for the RM. Indicates relative importance and attention required.. Valid values are `high|medium|low|strategic|standard`',
    `assignment_reason` STRING COMMENT 'Business reason or trigger for this RM-client assignment. Captures why the assignment was created or changed.. Valid values are `new_client|portfolio_rebalance|rm_departure|client_request|geographic_realignment|specialization_match`',
    `assignment_source_system` STRING COMMENT 'Name or code of the source system that originated this RM-client assignment record. Used for data lineage and reconciliation.',
    `assignment_start_date` DATE COMMENT 'Date when the relationship manager assignment to the client became effective. Marks the beginning of the RM-client relationship.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the RM-client assignment. Active indicates current assignment, inactive indicates ended assignment, pending indicates assignment awaiting activation, suspended indicates temporarily paused assignment, terminated indicates formally ended assignment.. Valid values are `active|inactive|pending|suspended|terminated`',
    `assignment_type` STRING COMMENT 'Type of relationship manager assignment indicating the role and responsibility level. Primary indicates main point of contact, secondary indicates support role, coverage indicates temporary or shared responsibility, backup indicates contingency assignment, specialist indicates subject matter expert role, advisory indicates consultative role.. Valid values are `primary|secondary|coverage|backup|specialist|advisory`',
    `aum_at_assignment` DECIMAL(18,2) COMMENT 'Total assets under management for the client at the time of RM assignment. Snapshot value used for performance tracking and portfolio sizing.',
    `aum_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the AUM at assignment value.. Valid values are `^[A-Z]{3}$`',
    `branch_code` STRING COMMENT 'Code of the branch or office location associated with this RM-client assignment. Links to the branch master record.',
    `client_satisfaction_score` DECIMAL(18,2) COMMENT 'Most recent client satisfaction or Net Promoter Score (NPS) for this RM-client relationship. Used for relationship quality monitoring and RM performance evaluation.',
    `client_tenure_months` STRING COMMENT 'Number of months the client has been with the institution at the time of this assignment. Used for client lifecycle analysis and relationship maturity assessment.',
    `compliance_review_status` STRING COMMENT 'Status of compliance or regulatory review for this RM-client assignment. Ensures assignments meet conflict of interest, suitability, and regulatory requirements.. Valid values are `approved|pending|rejected|not_required|under_review`',
    `conflict_of_interest_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a potential conflict of interest has been identified for this RM-client assignment. Used for compliance monitoring and risk management.',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of client relationship coverage allocated to this RM when multiple RMs serve the same client. Sum of all coverage percentages for a client should equal 100.',
    `cross_sell_opportunities` STRING COMMENT 'Number of identified cross-sell or product expansion opportunities for this client under the current RM assignment. Used for revenue growth planning and RM performance tracking.',
    `geographic_region` STRING COMMENT 'Geographic region or territory for this RM-client assignment. Used for regional portfolio management and coverage planning.',
    `handoff_notes` STRING COMMENT 'Free-text notes documenting client context, preferences, history, and important information for RM transitions or coverage continuity. Critical for maintaining service quality during reassignments.',
    `is_primary_rm` BOOLEAN COMMENT 'Boolean flag indicating whether this RM is the primary relationship manager for the client. True if primary, false if secondary or coverage role.',
    `last_contact_date` DATE COMMENT 'Date of the most recent interaction or contact between the RM and the client. Used for relationship activity tracking and engagement monitoring.',
    `line_of_business` STRING COMMENT 'Business division or segment context for this RM-client assignment. Indicates which business unit the relationship is managed under.. Valid values are `retail_banking|private_banking|wealth_management|investment_banking|commercial_banking|corporate_banking`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next portfolio review or relationship check-in between the RM and client. Used for proactive relationship management.',
    `portfolio_segment` STRING COMMENT 'Client wealth or business segment classification for this assignment. Used for portfolio management and service level differentiation.. Valid values are `mass_affluent|high_net_worth|ultra_high_net_worth|institutional|corporate|small_business`',
    `record_effective_date` DATE COMMENT 'Date when this version of the assignment record became effective. Used for slowly changing dimension (SCD) Type 2 history tracking.',
    `record_expiration_date` DATE COMMENT 'Date when this version of the assignment record expired or was superseded by a new version. Null for current active records. Used for slowly changing dimension (SCD) Type 2 history tracking.',
    `relationship_health_score` DECIMAL(18,2) COMMENT 'Composite score measuring the overall health and strength of the RM-client relationship. Calculated from engagement metrics, satisfaction scores, revenue trends, and other relationship indicators.',
    `revenue_attributed` DECIMAL(18,2) COMMENT 'Total revenue attributed to this RM-client relationship during the assignment period. Used for RM performance measurement and compensation calculations.',
    `revenue_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the revenue attributed value.. Valid values are `^[A-Z]{3}$`',
    `service_model` STRING COMMENT 'Service delivery model applied to this RM-client relationship. Defines how the RM interacts with and serves the client.. Valid values are `dedicated|shared|team_based|digital_first|hybrid`',
    `sla_target_response_hours` STRING COMMENT 'Target number of hours for RM response to client inquiries or requests as defined by the service level agreement for this client segment.',
    `termination_reason` STRING COMMENT 'Detailed reason or explanation for why this RM-client assignment was terminated or ended. Used for root cause analysis and process improvement.',
    CONSTRAINT pk_rm_client_assignment PRIMARY KEY(`rm_client_assignment_id`)
) COMMENT 'Association record linking relationship managers to their assigned client portfolios. Captures RM ID, customer ID, assignment type (primary, secondary, coverage), assignment start/end dates, LOB context, assignment reason, AUM at assignment, revenue attributed, and handoff notes. Tracks RM-client relationship history including reassignments, coverage changes, and portfolio transfers. Essential for client coverage continuity and RM performance attribution.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`journey` (
    `journey_id` BIGINT COMMENT 'Primary key for journey',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Customer journeys are audited for fair lending compliance, customer treatment standards, digital accessibility, and omnichannel experience quality. Journey analytics are subjects of dedicated audit en',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the relationship manager assigned to assist with this journey, if applicable. Null for self-service journeys.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Customer journeys track progression across channels. The current_channel string should be replaced with a FK to the channel master to enable proper omnichannel analytics. This FK uses the label prefix',
    `party_id` BIGINT COMMENT 'Reference to the customer or party undertaking this journey. Links to the party master record in the customer domain.',
    `journey_template_id` BIGINT COMMENT 'Reference to the standardized journey template that defines the stages, expected durations, and channel scope for this journey type (e.g., account opening, loan application, KYC refresh).',
    `abandonment_flag` BOOLEAN COMMENT 'Indicates whether the customer abandoned the journey before completion. True if the customer dropped off; false otherwise.',
    `abandonment_stage` STRING COMMENT 'The stage at which the customer abandoned the journey. Null if journey was not abandoned. Used to identify friction points.',
    `abandonment_timestamp` TIMESTAMP COMMENT 'Date and time when the journey was marked as abandoned. Null if journey was not abandoned.',
    `active_duration_minutes` STRING COMMENT 'Total time the customer was actively engaged in the journey (excluding idle time), measured in minutes. Provides insight into actual effort required.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the journey was successfully completed. Null for in-progress or abandoned journeys.',
    `application_reference_number` STRING COMMENT 'External reference number for the application or case associated with this journey. Used for cross-system tracking and customer communication.',
    `channel_scope` STRING COMMENT 'Defines which channels are available for this journey. Omnichannel allows seamless switching; restricted scopes limit customer to specific channels.. Valid values are `omnichannel|digital_only|branch_only|contact_center_only|relationship_manager_only|hybrid`',
    `channel_switch_count` STRING COMMENT 'Number of times the customer switched channels during this journey. Measures omnichannel behavior and channel orchestration effectiveness.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether all regulatory requirements were met during the journey. True if compliant; false if any compliance issues were identified.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this journey record was first created in the system. Used for audit trail and data lineage.',
    `current_stage` STRING COMMENT 'The current stage or step the customer is in within the journey (e.g., Identity Verification, Document Upload, Credit Review, Final Approval). Stage names are journey-specific.',
    `current_stage_entry_timestamp` TIMESTAMP COMMENT 'Date and time when the customer entered the current stage. Used to calculate stage duration and identify bottlenecks.',
    `current_stage_sequence` STRING COMMENT 'Ordinal position of the current stage within the journey template. Enables progress tracking and completion percentage calculation.',
    `customer_feedback` STRING COMMENT 'Free-text feedback provided by the customer at journey completion or abandonment. Used for qualitative analysis and process improvement.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this journey has been escalated due to delays, customer complaints, or compliance issues. True if escalated; false otherwise.',
    `escalation_reason` STRING COMMENT 'Reason for journey escalation, if applicable. Null if journey has not been escalated.',
    `expected_completion_date` DATE COMMENT 'Projected date by which the journey should be completed based on template durations and current progress. Used for SLA tracking and customer communication.',
    `initiated_channel` STRING COMMENT 'The channel through which the customer originally started this journey. Enables channel attribution and conversion analysis. [ENUM-REF-CANDIDATE: mobile_app|web_portal|branch|atm|contact_center|relationship_manager|api|chatbot — 8 candidates stripped; promote to reference product]',
    `journey_name` STRING COMMENT 'Business-friendly name of the journey instance, typically derived from the template (e.g., Personal Checking Account Opening, Mortgage Loan Application, Annual KYC Refresh).',
    `journey_status` STRING COMMENT 'Current lifecycle status of the journey instance. Tracks whether the customer is actively progressing, has completed, or has dropped off. [ENUM-REF-CANDIDATE: initiated|in_progress|completed|abandoned|suspended|cancelled|failed — 7 candidates stripped; promote to reference product]',
    `journey_type` STRING COMMENT 'Classification of the journey by business process type. Determines applicable regulatory requirements, SLA targets, and channel orchestration rules. [ENUM-REF-CANDIDATE: account_opening|loan_application|kyc_refresh|onboarding|product_upgrade|complaint_resolution|service_request|wealth_advisory|investment_onboarding — 9 candidates stripped; promote to reference product]',
    `last_activity_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent customer activity in this journey. Used to identify stalled journeys and trigger follow-up actions.',
    `nps_collection_timestamp` TIMESTAMP COMMENT 'Date and time when the NPS score was collected from the customer. Null if NPS was not collected.',
    `nps_score` STRING COMMENT 'Customer satisfaction score collected at journey completion, typically on a 0-10 scale. Used to measure customer experience and journey quality.',
    `outcome` STRING COMMENT 'Final outcome of the journey. Successful indicates the customer completed all stages and achieved the goal; unsuccessful indicates completion without goal achievement; abandoned indicates customer drop-off.. Valid values are `successful|unsuccessful|abandoned|cancelled|expired|pending_review`',
    `priority_level` STRING COMMENT 'Business priority assigned to this journey based on customer segment, product type, or regulatory requirements. Influences resource allocation and escalation.. Valid values are `low|medium|high|urgent`',
    `product_applied_for` STRING COMMENT 'The specific banking product or service the customer is applying for or upgrading to through this journey (e.g., Premium Checking, Mortgage Loan, Wealth Management Advisory).',
    `regulatory_requirement` STRING COMMENT 'Applicable regulatory requirements for this journey type (e.g., CFPB disclosure requirements, OCC customer identification program, AML screening). Comma-separated list if multiple apply.',
    `session_count` STRING COMMENT 'Number of distinct customer sessions (login/interaction events) that occurred during this journey. Measures engagement frequency.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the journey was completed within the SLA target time. True if SLA was met; false if exceeded.',
    `sla_target_minutes` STRING COMMENT 'Target completion time for this journey type as defined in the service level agreement, measured in minutes.',
    `source_system` STRING COMMENT 'Name of the source system or channel platform that originated this journey record (e.g., Digital Banking Platform, Branch Management System, Contact Center CRM).',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the customer initiated this journey instance. Used for duration tracking and SLA monitoring.',
    `total_duration_minutes` STRING COMMENT 'Total elapsed time from journey start to completion or abandonment, measured in minutes. Used for performance analysis and SLA compliance.',
    `total_stages` STRING COMMENT 'Total number of stages defined in the journey template. Used to calculate journey completion percentage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this journey record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_journey PRIMARY KEY(`journey_id`)
) COMMENT 'Master record defining standardized customer journey templates and tracking individual customer journey instances for key banking processes — account opening, loan application, onboarding, KYC refresh, product upgrade, and complaint resolution. Template layer captures journey name, channel scope (omnichannel, digital-only, branch-only), journey stages, expected duration per stage, handoff rules between channels, drop-off thresholds, and associated regulatory requirements (CFPB, OCC). Instance layer tracks each customers progression: customer ID, journey template reference, current stage, channel at each stage, timestamps for stage entry/exit, stage outcomes, channel switches (e.g., started online, completed in branch), abandonment flags, NPS score collected, and final journey outcome. Enables omnichannel journey orchestration, completion rate tracking, NPS measurement, CLTV-linked engagement analysis, and process improvement.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`journey_instance` (
    `journey_instance_id` BIGINT COMMENT 'Unique identifier for each individual customer journey instance. Primary key for tracking a specific customers progression through a defined journey template.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the relationship manager assigned to assist the customer during this journey. Null for self-service journeys. Used for relationship manager performance tracking and assisted journey analytics.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Journey instances track individual customer progressions and need to reference the initial channel where the journey started. The initial_channel_code string is replaced with a proper FK. Label prefix',
    `journey_id` BIGINT COMMENT 'Reference to the predefined journey template that this instance follows. Defines the expected stages, channels, and outcomes for this journey type (e.g., account opening, loan application, wealth onboarding).',
    `party_id` BIGINT COMMENT 'Reference to the customer or party executing this journey. Links to the party master data to identify who is progressing through the journey.',
    `session_id` BIGINT COMMENT 'Unique session identifier for the digital session in which the journey was initiated. Links journey instances to detailed session-level interaction data for digital channels.',
    `abandonment_flag` BOOLEAN COMMENT 'Indicates whether the customer abandoned the journey before completion. True if the journey was started but not completed within the expected timeframe or explicitly abandoned.',
    `abandonment_reason_code` STRING COMMENT 'Coded reason for journey abandonment (e.g., TIMEOUT, CUSTOMER_DECLINED, TECHNICAL_ERROR, INCOMPLETE_DOCS). Supports root cause analysis of abandonment patterns.',
    `abandonment_stage_code` STRING COMMENT 'Code of the stage where the customer abandoned the journey. Null if the journey was not abandoned. Used to identify high-friction stages and optimize journey design.',
    `active_duration_seconds` BIGINT COMMENT 'Total time in seconds the customer was actively engaged in the journey (excluding idle time, wait time for approvals, or system processing time). Measures actual customer effort.',
    `branch_code` STRING COMMENT 'Code of the branch where the journey was initiated or primarily executed. Null for fully digital journeys. Supports branch-level journey performance analysis.',
    `campaign_code` STRING COMMENT 'Marketing campaign code associated with this journey instance. Links journey performance to specific marketing initiatives and enables campaign Return on Investment (ROI) analysis.',
    `channel_switch_count` STRING COMMENT 'Number of times the customer switched channels during this journey. Indicates omnichannel engagement complexity and potential friction points.',
    `cltv_segment` STRING COMMENT 'Customer Lifetime Value (CLTV) segment of the customer at the time of journey initiation. Used to link journey experience and completion rates to customer value and prioritize high-value customer journeys.. Valid values are `high|medium|low|unknown`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this journey instance record was first created in the system. Used for data lineage and audit trail purposes.',
    `current_channel_code` STRING COMMENT 'Channel where the customer is currently interacting in the journey. Tracks channel switches and omnichannel behavior (e.g., started online, continued in branch). [ENUM-REF-CANDIDATE: mobile|web|branch|atm|contact_center|relationship_manager|api|partner — 8 candidates stripped; promote to reference product]',
    `current_stage_code` STRING COMMENT 'Code representing the current stage in the journey where the customer is positioned (e.g., INIT, KYC, APPROVAL, FULFILLMENT, COMPLETE). Used for operational tracking and stage-level analytics.',
    `current_stage_entry_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer entered the current stage. Used to track stage-level duration and identify bottlenecks in the journey progression.',
    `current_stage_name` STRING COMMENT 'Human-readable name of the current stage (e.g., Initial Application, Know Your Customer (KYC) Verification, Credit Approval, Account Fulfillment). Provides business context for the current position in the journey.',
    `customer_feedback_text` STRING COMMENT 'Free-text feedback provided by the customer about their journey experience. Supports qualitative analysis of customer sentiment and journey pain points.',
    `customer_segment_code` STRING COMMENT 'Code representing the customer segment (e.g., RETAIL, WEALTH, CORPORATE, SME) at the time of journey initiation. Enables segment-specific journey performance analysis.',
    `device_type` STRING COMMENT 'Type of device used by the customer to initiate the journey. Supports device-specific journey optimization and responsive design analytics.. Valid values are `desktop|mobile|tablet|kiosk|atm|unknown`',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the journey was completed, abandoned, or terminated. Null for in-progress journeys. Used to calculate journey duration and completion metrics.',
    `error_count` STRING COMMENT 'Number of errors or exceptions encountered during the journey. Indicates technical friction and system reliability issues impacting customer experience.',
    `final_outcome_code` STRING COMMENT 'Final outcome of the journey instance. Indicates whether the customer successfully completed the intended business objective, failed, partially completed, or abandoned.. Valid values are `success|failure|partial|abandoned|expired`',
    `final_outcome_description` STRING COMMENT 'Detailed description of the final journey outcome. Provides business context for the outcome code (e.g., Account opened successfully, Application declined due to credit score, Customer abandoned at document upload).',
    `journey_name` STRING COMMENT 'Business-friendly name of the journey being tracked (e.g., Personal Loan Application, Wealth Management Onboarding, Credit Card Activation). Provides human-readable context for reporting and analytics.',
    `journey_status` STRING COMMENT 'Overall lifecycle status of the journey instance. Indicates whether the customer is actively progressing, has completed, abandoned, or encountered issues in the journey.. Valid values are `in_progress|completed|abandoned|suspended|failed`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this journey instance record was last updated. Tracks the most recent change to the journey state for audit and data quality purposes.',
    `nps_collection_timestamp` TIMESTAMP COMMENT 'Timestamp when the NPS score was collected from the customer. Null if NPS was not collected for this journey instance.',
    `nps_score` STRING COMMENT 'Net Promoter Score (NPS) collected from the customer at journey completion. Scale of 0-10 measuring customer satisfaction and likelihood to recommend. Used to link journey experience to customer loyalty metrics.',
    `product_code` STRING COMMENT 'Code of the banking product or service associated with this journey (e.g., CHECKING_ACCT, PERSONAL_LOAN, WEALTH_ADVISORY). Links journey instances to product performance and cross-sell analytics.',
    `product_name` STRING COMMENT 'Human-readable name of the banking product or service associated with this journey. Provides business context for product-specific journey analytics.',
    `referral_source_code` STRING COMMENT 'Code indicating how the customer was referred to this journey (e.g., ORGANIC, CAMPAIGN, PARTNER, BRANCH_REFERRAL). Supports marketing attribution and channel effectiveness analysis.',
    `retry_count` STRING COMMENT 'Number of times the customer retried a stage or action during the journey. Indicates usability issues or customer confusion at specific journey stages.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the journey was completed within the SLA target duration. True if total_duration_seconds is less than or equal to sla_target_duration_seconds.',
    `sla_target_duration_seconds` BIGINT COMMENT 'Target duration in seconds for completing this journey as defined by the Service Level Agreement (SLA). Used to measure journey performance against business commitments.',
    `stage_count` STRING COMMENT 'Total number of stages the customer progressed through in this journey instance. Used to measure journey complexity and compare actual vs. expected stage progression.',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer initiated this journey instance. Marks the beginning of the customers progression through the defined journey template.',
    `total_duration_seconds` BIGINT COMMENT 'Total elapsed time in seconds from journey start to end. Calculated as the difference between end_timestamp and start_timestamp. Used for journey efficiency analysis and Service Level Agreement (SLA) tracking.',
    CONSTRAINT pk_journey_instance PRIMARY KEY(`journey_instance_id`)
) COMMENT 'Transactional record tracking each individual customers progression through a defined journey template. Captures customer ID, journey template reference, current stage, channel at each stage, timestamps for stage entry/exit, stage outcomes, channel switches (e.g., started online, completed in branch), abandonment flags, NPS score collected, and final journey outcome. Enables omnichannel journey completion tracking and CLTV-linked engagement measurement.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`channel_incident` (
    `channel_incident_id` BIGINT COMMENT 'Unique identifier for the channel incident record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Channel incidents require individual engineer assignment for accountability, workload tracking, resolution metrics, and escalation management. Critical for IT operations, SLA compliance, and post-inci',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Channel incidents (system outages, security breaches, fraud events) trigger audit engagements to investigate control failures, business continuity, and regulatory reporting. Post-incident reviews are ',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Incidents affecting channel availability or performance should reference the specific channel entity, not just store a channel code string. This enables proper impact analysis and reporting. The affec',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Channel incidents (outages, security breaches, system failures) are recorded as operational risk events for regulatory reporting, loss data collection, and capital calculation under operational risk f',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was acknowledged by the support team and assigned for investigation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `affected_channel_count` STRING COMMENT 'Number of distinct channels impacted by this incident. Used for multi-channel outage scenarios.',
    `affected_location_count` STRING COMMENT 'Number of physical locations (branches, ATMs) or logical endpoints affected by the incident.',
    `assigned_team` STRING COMMENT 'Name of the technical support team or group assigned to investigate and resolve the incident.',
    `channel_incident_status` STRING COMMENT 'Current lifecycle status of the incident. Tracks progression from initial detection through investigation, resolution, and closure. [ENUM-REF-CANDIDATE: new|acknowledged|investigating|identified|resolving|resolved|closed|reopened — 8 candidates stripped; promote to reference product]',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the incident record was formally closed after verification and documentation. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `communication_sent_flag` BOOLEAN COMMENT 'Indicates whether customer communication was sent regarding the incident. True if customers were notified; False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this incident record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customer_impact_count` STRING COMMENT 'Estimated or actual number of customers affected by the incident. Used for impact assessment and regulatory reporting.',
    `detected_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was first detected by monitoring systems or reported by users. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `duration_minutes` STRING COMMENT 'Total duration of the incident from start to resolution, measured in minutes. Used for Service Level Agreement (SLA) tracking and operational risk reporting.',
    `escalated_flag` BOOLEAN COMMENT 'Indicates whether the incident was escalated beyond initial support tier. True if escalated; False if resolved at first level.',
    `escalation_level` STRING COMMENT 'Current escalation tier of the incident. Level 1 is first-line support; higher levels indicate escalation to specialized teams or management.',
    `incident_number` STRING COMMENT 'Business-facing unique incident reference number used for tracking and communication. Format: INC-YYYYMMDD.. Valid values are `^INC-[0-9]{8}$`',
    `incident_type` STRING COMMENT 'Classification of the incident by operational category: ATM outage, mobile app downtime, web banking downtime, branch closure, contact center system failure, or API gateway disruption.. Valid values are `atm_outage|mobile_app_downtime|web_banking_downtime|branch_closure|contact_center_failure|api_gateway_disruption`',
    `post_incident_review_date` DATE COMMENT 'Date when the post-incident review was conducted or is scheduled. Format: yyyy-MM-dd.',
    `post_incident_review_required_flag` BOOLEAN COMMENT 'Indicates whether a formal post-incident review is required based on severity, impact, or regulatory requirements. True if review required; False otherwise.',
    `post_incident_review_status` STRING COMMENT 'Current status of the post-incident review process. Tracks progression from scheduling through completion of lessons-learned analysis.. Valid values are `not_required|scheduled|in_progress|completed|cancelled`',
    `priority` STRING COMMENT 'Incident resolution priority level. P1 is highest priority requiring immediate response; P4 is lowest priority for scheduled resolution.. Valid values are `p1|p2|p3|p4`',
    `regulatory_report_submitted_flag` BOOLEAN COMMENT 'Indicates whether the required regulatory report has been submitted to governing authorities. True if submitted; False if pending or not required.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether the incident meets thresholds for mandatory regulatory reporting to authorities such as Federal Reserve, OCC, or CFPB. True if reportable; False otherwise.',
    `resolution_description` STRING COMMENT 'Detailed narrative of the actions taken to resolve the incident and restore service. Documents the resolution steps for knowledge management.',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was resolved and service was restored. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `root_cause_category` STRING COMMENT 'High-level classification of the underlying root cause of the incident. Used for trend analysis and preventive action planning. [ENUM-REF-CANDIDATE: hardware_failure|software_defect|network_issue|capacity_overload|human_error|third_party_failure|security_incident — 7 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative description of the root cause identified through investigation. Documents the underlying technical or operational failure that triggered the incident.',
    `rpo_met_flag` BOOLEAN COMMENT 'Indicates whether data recovery met the defined RPO target. True if RPO was met; False if data loss exceeded acceptable threshold.',
    `rpo_target_minutes` STRING COMMENT 'Target Recovery Point Objective for this incident type, measured in minutes. Defines the maximum acceptable data loss window per business continuity plan.',
    `rto_met_flag` BOOLEAN COMMENT 'Indicates whether the incident was resolved within the defined RTO target. True if RTO was met; False if exceeded.',
    `rto_target_minutes` STRING COMMENT 'Target Recovery Time Objective for this incident type, measured in minutes. Defines the maximum acceptable downtime per business continuity plan.',
    `severity_level` STRING COMMENT 'Business impact severity classification of the incident. Critical indicates complete service unavailability affecting large customer base; high indicates significant degradation; medium indicates partial impact; low indicates minimal impact.. Valid values are `critical|high|medium|low`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the incident resulted in a breach of service level agreement commitments. True if SLA was breached; False otherwise.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the incident actually began affecting service availability or performance. May differ from detected_timestamp if incident started before detection. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `time_to_acknowledge_minutes` STRING COMMENT 'Time elapsed between detection and acknowledgment by support team, measured in minutes. Used for response time SLA tracking.',
    `time_to_detect_minutes` STRING COMMENT 'Time elapsed between incident start and detection, measured in minutes. Key metric for monitoring effectiveness.',
    `time_to_resolve_minutes` STRING COMMENT 'Time elapsed between acknowledgment and resolution, measured in minutes. Core metric for incident management performance.',
    `transaction_impact_count` STRING COMMENT 'Number of customer transactions that failed, were delayed, or were otherwise impacted during the incident window.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this incident record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `workaround_applied_flag` BOOLEAN COMMENT 'Indicates whether a temporary workaround was applied to restore service before permanent resolution. True if workaround was used; False if direct resolution.',
    `workaround_description` STRING COMMENT 'Description of the temporary workaround applied to restore service while permanent fix is implemented.',
    CONSTRAINT pk_channel_incident PRIMARY KEY(`channel_incident_id`)
) COMMENT 'Transactional record capturing operational incidents affecting channel availability or performance — ATM outages, mobile app downtime, branch closures, contact center system failures, and API gateway disruptions. Captures incident type, affected channel(s), severity level, start/end timestamps, customer impact count, root cause, resolution steps, RTO/RPO metrics, and post-incident review status. Feeds operational risk reporting and business continuity management.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`atm_transaction` (
    `atm_transaction_id` BIGINT COMMENT 'Unique identifier for the ATM transaction event. Primary key for the atm_transaction product.',
    `atm_id` BIGINT COMMENT 'Identifier of the ATM terminal where the transaction was executed. Links to the ATM device master record.',
    `card_id` BIGINT COMMENT 'Tokenized reference to the card used for the transaction. Links to the card master record without exposing PAN (Primary Account Number).',
    `session_id` BIGINT COMMENT 'Unique identifier for the ATM session during which this transaction occurred, used to group multiple transactions within a single customer session.',
    `deposit_account_id` BIGINT COMMENT 'Identifier of the customer account debited or credited by this ATM transaction.',
    `issuer_institution_legal_entity_id` BIGINT COMMENT 'Bank Identification Number (BIN) or institution code of the issuing bank that issued the card used in the transaction.. Valid values are `^[0-9]{6,11}$`',
    `legal_entity_id` BIGINT COMMENT 'Bank Identification Number (BIN) or institution code of the acquiring bank that owns the ATM terminal.. Valid values are `^[0-9]{6,11}$`',
    `original_transaction_atm_transaction_id` BIGINT COMMENT 'Reference to the original ATM transaction ID if this record represents a reversal or adjustment. Null for original transactions.',
    `party_id` BIGINT COMMENT 'Identifier of the customer (party) who initiated the ATM transaction. Links to the customer master record.',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: ATM withdrawals and deposits are payment transactions requiring direct link for reconciliation, settlement, dispute resolution, and financial reporting. Core operational relationship between ATM chann',
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
    `transaction_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `transaction_reference_number` STRING COMMENT 'Externally visible unique reference number for the ATM transaction, used for customer inquiries and dispute resolution.. Valid values are `^[A-Z0-9]{12,20}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the ATM transaction: approved (successful), declined (rejected by issuer or network), reversed (voided after initial approval), pending (awaiting settlement), timeout (no response received), or cancelled (customer aborted).. Valid values are `approved|declined|reversed|pending|timeout|cancelled`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the ATM transaction was initiated by the customer at the terminal, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `transaction_type` STRING COMMENT 'Type of ATM transaction performed: cash withdrawal, deposit, balance inquiry, PIN change, mini statement, cardless cash, inter-bank transfer, or bill payment. [ENUM-REF-CANDIDATE: withdrawal|deposit|balance_inquiry|pin_change|mini_statement|cardless_cash|inter_bank_transfer|bill_payment — 8 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this transaction record was last modified in the data platform, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    CONSTRAINT pk_atm_transaction PRIMARY KEY(`atm_transaction_id`)
) COMMENT 'Transactional record of each ATM transaction event — cash withdrawal, deposit, balance inquiry, PIN change, cardless cash, and inter-bank transfers. Captures ATM ID, card number (tokenized), customer reference, transaction type, amount, currency, network used (Visa/Mastercard/STAR), authorization code, response code, surcharge applied, cash dispensed flag, timestamp, and transaction status. Distinct from payment domain wire/ACH — this is ATM-channel-specific card-present transaction capture.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`branch_teller_transaction` (
    `branch_teller_transaction_id` BIGINT COMMENT 'Unique identifier for the branch teller transaction record.',
    `workpaper_id` BIGINT COMMENT 'Foreign key linking to audit.workpaper. Business justification: Auditors sample teller transactions as evidence when testing cash handling controls, CTR/SAR compliance, dual control procedures, and operational accuracy. Transactions are directly referenced in audi',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Teller transactions convert to base currency for GL posting. Base_currency_amount exists but needs FK for accurate accounting, exchange rate application, and consolidated financial reporting.',
    `branch_id` BIGINT COMMENT 'Identifier of the branch where the transaction was processed.',
    `deposit_account_id` BIGINT COMMENT 'Identifier of the account associated with the transaction, if applicable.',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_instruction. Business justification: Teller transactions that initiate payments (wire transfers, ACH origination, bill payments) create payment instructions. Direct operational link required for end-to-end payment tracking, branch perfor',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Branch tellers execute over-the-counter securities transactions including bond purchases, equity trades for retail clients, and structured product sales. Transaction records must reference the specifi',
    `original_transaction_branch_teller_transaction_id` BIGINT COMMENT 'Identifier of the original transaction being reversed, if this is a reversal transaction.',
    `party_id` BIGINT COMMENT 'Identifier of the customer involved in the transaction.',
    `employee_id` BIGINT COMMENT 'Identifier of the teller who processed the transaction.',
    `session_id` BIGINT COMMENT 'Identifier of the teller session during which the transaction was processed, used for session reconciliation and audit.',
    `base_currency_amount` DECIMAL(18,2) COMMENT 'Transaction amount converted to the banks base reporting currency, if foreign exchange was involved.',
    `beneficiary_account_number` STRING COMMENT 'Account number of the beneficiary for wire transfer transactions.',
    `beneficiary_name` STRING COMMENT 'Name of the beneficiary for wire transfer or cashiers check transactions.',
    `check_number` STRING COMMENT 'Check number for check deposit or check cashing transactions.',
    `check_routing_number` STRING COMMENT 'Nine-digit ABA routing number for check transactions.. Valid values are `^[0-9]{9}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transaction record was first created in the system.',
    `ctr_threshold_flag` BOOLEAN COMMENT 'Indicates whether the transaction meets or exceeds the $10,000 threshold requiring a Currency Transaction Report (CTR) filing under the Bank Secrecy Act (BSA) and FinCEN regulations.',
    `customer_identification_number` STRING COMMENT 'Identification document number presented by the customer, required for high-value transactions and CTR reporting.',
    `customer_identification_type` STRING COMMENT 'Type of identification document presented by the customer for the transaction, required for compliance and KYC purposes.. Valid values are `drivers_license|passport|national_id|military_id|other`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied for foreign currency transactions, if applicable.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Service fee charged for the teller transaction, if applicable.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the transaction was posted.',
    `gl_posting_date` DATE COMMENT 'Date when the transaction was posted to the general ledger for accounting purposes.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the teller regarding the transaction.',
    `override_reason` STRING COMMENT 'Business justification or reason code for the supervisory override, if applicable.',
    `override_required_flag` BOOLEAN COMMENT 'Indicates whether the transaction required supervisory or managerial override approval due to policy exceptions or limit breaches.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this transaction is a reversal of a previous transaction.',
    `safe_deposit_box_number` STRING COMMENT 'Safe deposit box number for safe deposit box access transactions.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the teller transaction in the specified currency.',
    `transaction_channel` STRING COMMENT 'Specific channel within the branch network through which the transaction was initiated.. Valid values are `branch_teller|drive_through|video_teller|mobile_branch`',
    `transaction_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount.. Valid values are `^[A-Z]{3}$`',
    `transaction_reference_number` STRING COMMENT 'Externally visible unique reference number for the teller transaction, used for customer inquiries and audit trails.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the teller transaction.. Valid values are `completed|pending|reversed|cancelled|failed`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the teller transaction was executed at the branch.',
    `transaction_type` STRING COMMENT 'Type of teller transaction performed at the branch. [ENUM-REF-CANDIDATE: cash_deposit|cash_withdrawal|check_deposit|check_cashing|wire_initiation|cashiers_check|foreign_exchange|safe_deposit_access|account_inquiry|balance_inquiry|statement_request|other — 12 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the transaction record was last updated in the system.',
    `wire_reference_number` STRING COMMENT 'Unique reference number for wire transfer initiation transactions.',
    `workstation_code` STRING COMMENT 'Identifier of the teller workstation or terminal used to process the transaction.',
    CONSTRAINT pk_branch_teller_transaction PRIMARY KEY(`branch_teller_transaction_id`)
) COMMENT 'Transactional record of each teller-processed transaction at a branch — cash deposits, withdrawals, check cashing, wire initiation, cashiers checks, foreign currency exchange, and safe deposit box access. Captures branch ID, teller ID, customer reference, transaction type, amount, currency, account reference, CTR threshold flag (BSA/FinCEN $10K reporting), override approvals, and timestamp. Distinct from payment domain settlement records — this captures the branch channel origination event.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`open_banking_consent` (
    `open_banking_consent_id` BIGINT COMMENT 'Unique identifier for the open banking consent record. Primary key for the consent entity.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: Open banking consent management is a high-risk regulatory area (PSD2, CFPB 1033) requiring dedicated audit engagements. Auditors review consent frameworks, data access controls, and third-party provid',
    `digital_channel_id` BIGINT COMMENT 'Foreign key linking to channel.digital_channel. Business justification: Open banking consents granted via specific digital channels/APIs require channel attribution for PSD2/CFPB 1033 regulatory reporting, consent lifecycle management, and API usage analytics.',
    `employee_id` BIGINT COMMENT 'Identifier of the compliance officer who reviewed and approved high-risk consents, supporting audit and accountability requirements.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user or process that last modified this consent record, supporting accountability and audit requirements.',
    `party_id` BIGINT COMMENT 'Identifier of the customer or party who granted the consent for open banking data sharing.',
    `previous_consent_open_banking_consent_id` BIGINT COMMENT 'Reference to the previous consent record if this is a renewal, enabling consent history tracking and lineage.',
    `third_party_provider_id` BIGINT COMMENT 'Unique identifier of the third-party provider (TPP) or fintech application authorized to access customer data under open banking frameworks.',
    `access_count` STRING COMMENT 'Total number of times the TPP has accessed customer data under this consent since grant, supporting usage analytics and compliance monitoring.',
    `access_frequency_limit` STRING COMMENT 'Maximum number of data access requests permitted per day under this consent, enforcing PSD2 access frequency rules (typically 4 times per day).',
    `account_scope` STRING COMMENT 'Specific accounts or account types included in the consent scope, defining which customer accounts the TPP is authorized to access.',
    `authentication_method` STRING COMMENT 'Strong customer authentication method used when granting consent: biometric, SMS OTP, hardware token, mobile app authentication, or other SCA-compliant method.',
    `compliance_review_status` STRING COMMENT 'Status of regulatory compliance review for high-risk consents: not required for standard consents, pending review, approved after review, or rejected.. Valid values are `not_required|pending|approved|rejected`',
    `compliance_review_timestamp` TIMESTAMP COMMENT 'Date and time when compliance review was completed for this consent. Null if no review was required or review is pending.',
    `consent_channel` STRING COMMENT 'Channel through which the customer granted the open banking consent: mobile app, web portal, branch, contact center, or direct API integration.. Valid values are `mobile_app|web_portal|branch|contact_center|api`',
    `consent_language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which consent terms were presented to and accepted by the customer.',
    `consent_reference_number` STRING COMMENT 'External business identifier for the consent, used for customer communication and audit trails.',
    `consent_scope` STRING COMMENT 'Detailed scope of data access granted, including specific account types, transaction history depth, and data elements authorized for sharing.',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent: pending customer approval, active and in use, expired by time limit, revoked by customer, suspended by bank, or rejected.. Valid values are `pending|active|expired|revoked|suspended|rejected`',
    `consent_type` STRING COMMENT 'Type of open banking consent granted: account information access, payment initiation, funds confirmation, identity verification, or combined services.. Valid values are `account_information|payment_initiation|funds_confirmation|identity_verification|combined`',
    `consent_version` STRING COMMENT 'Version identifier of the consent terms and conditions accepted by the customer, enabling tracking of consent template changes over time.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this consent record was first created in the open banking consent management system.',
    `customer_consent_confirmation_code` STRING COMMENT 'Unique confirmation code provided to the customer upon consent grant, used for customer service inquiries and consent verification.',
    `customer_device_fingerprint` STRING COMMENT 'Unique identifier of the device used by the customer to grant consent, supporting fraud detection and security monitoring.',
    `customer_ip_address` STRING COMMENT 'IP address from which the customer granted the consent, captured for fraud prevention and audit purposes.',
    `data_access_log_reference` STRING COMMENT 'Reference identifier linking to detailed audit logs of all data access events performed under this consent, enabling full traceability.',
    `data_retention_period_days` STRING COMMENT 'Number of days the consent record and associated audit logs must be retained for regulatory compliance after consent expiry or revocation.',
    `effective_from_date` DATE COMMENT 'Date from which the consent becomes active and the TPP is authorized to access customer data.',
    `expiry_date` DATE COMMENT 'Date on which the consent automatically expires and data access authorization terminates, typically 90 days from grant under PSD2.',
    `grant_timestamp` TIMESTAMP COMMENT 'Date and time when the customer granted the open banking consent, recorded in ISO 8601 format with timezone.',
    `last_access_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent data access by the TPP under this consent, used for monitoring and compliance reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this consent record was last updated, supporting audit trail and data lineage requirements.',
    `notification_preference` STRING COMMENT 'Customer preference for receiving notifications about consent status changes, access events, and expiry warnings: email, SMS, mobile push notification, or none.. Valid values are `email|sms|push|none`',
    `recurring_access_indicator` BOOLEAN COMMENT 'Indicates whether the consent authorizes recurring data access (true) or one-time access only (false).',
    `regulatory_framework` STRING COMMENT 'Regulatory framework under which the consent was granted: PSD2 (EU), CFPB Section 1033 (US), CDR (Australia), Open Banking UK, or other jurisdiction-specific framework.. Valid values are `psd2|cfpb_1033|cdr|open_banking_uk|other`',
    `renewal_indicator` BOOLEAN COMMENT 'Indicates whether this consent is a renewal of a previous expired consent (true) or a new initial consent (false).',
    `revocation_reason` STRING COMMENT 'Reason provided by the customer or bank for revoking the consent, supporting audit and customer service requirements.',
    `revocation_timestamp` TIMESTAMP COMMENT 'Date and time when the customer revoked the consent, terminating TPP data access authorization. Null if consent has not been revoked.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Risk score assigned to this consent at grant time based on customer profile, TPP reputation, and fraud indicators, ranging from 0.00 (low risk) to 100.00 (high risk).',
    `source_system_code` STRING COMMENT 'Identifier of the source system or API gateway that originated this consent record, enabling data lineage tracking across the enterprise.',
    `tpp_certificate_reference` STRING COMMENT 'Qualified certificate identifier issued to the TPP by a qualified trust service provider, validating TPP authorization under PSD2.',
    `transaction_history_period_days` STRING COMMENT 'Number of days of historical transaction data the TPP is authorized to access, typically 90 days under PSD2.',
    CONSTRAINT pk_open_banking_consent PRIMARY KEY(`open_banking_consent_id`)
) COMMENT 'Master record managing customer consent grants for open banking and API-based third-party data sharing under PSD2, CFPB Section 1033, and open banking frameworks. Captures customer ID, third-party provider (TPP) identity, consent scope (account data, payment initiation, identity), consent grant timestamp, expiry date, revocation status, data access log reference, regulatory framework (PSD2/CFPB 1033/CDR), and consent version. SSOT for open banking authorization and data sharing governance.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`channel_alert` (
    `channel_alert_id` BIGINT COMMENT 'Unique identifier for the channel alert record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing or communication campaign associated with this alert, if applicable, enabling campaign performance tracking.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to channel.channel. Business justification: Alerts sent to customers through a specific channel should reference that channel entity. This enables channel-specific alert analytics and SLA tracking. The channel_code string is replaced by a prope',
    `deposit_account_id` BIGINT COMMENT 'Reference to the specific account associated with this alert, if applicable.',
    `instruction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_instruction. Business justification: Alerts may reference payment instructions for scheduled payment reminders, mandate expiration notices, or instruction-level status updates. Supports proactive customer communication and payment instru',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Banks send instrument-specific alerts including price movement notifications, corporate action announcements (dividends, calls, maturities), and margin call warnings. Alert system must reference speci',
    `monitoring_exception_id` BIGINT COMMENT 'Foreign key linking to audit.monitoring_exception. Business justification: Alerts (fraud alerts, compliance alerts, security alerts) that fire generate monitoring exceptions requiring investigation, disposition, and escalation. Auditors track alert-to-exception linkage to va',
    `party_id` BIGINT COMMENT 'Reference to the customer or party who received this alert.',
    `alert_template_id` BIGINT COMMENT 'Reference to the message template used to generate this alert, enabling template performance tracking and version control.',
    `account_transaction_id` BIGINT COMMENT 'Reference to the specific transaction that triggered this alert, if applicable (e.g., for transaction confirmation or fraud alerts).',
    `actual_send_timestamp` TIMESTAMP COMMENT 'The actual date and time when the alert was sent to the delivery provider, following format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `alert_category` STRING COMMENT 'High-level categorization of the alert for reporting and analytics: operational (transactional updates), regulatory (compliance-driven notices), marketing (promotional), risk (fraud/security), or service (customer service notifications).. Valid values are `operational|regulatory|marketing|risk|service`',
    `alert_type` STRING COMMENT 'Classification of the alert based on its business purpose: transaction confirmation, fraud detection, balance threshold breach, payment due reminder, regulatory notice, security notification, promotional message, service update, branch appointment reminder, or statement availability. [ENUM-REF-CANDIDATE: transaction_alert|fraud_alert|balance_threshold|payment_due|regulatory_notice|security_alert|promotional|service_notification|appointment_reminder|statement_ready — 10 candidates stripped; promote to reference product]',
    `body` STRING COMMENT 'Full text content of the alert message delivered to the customer.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this alert record was first created in the system, following format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `customer_response` STRING COMMENT 'The customers response or action taken after receiving the alert: acknowledged, dismissed, clicked embedded link, contacted the bank, or no response recorded.. Valid values are `acknowledged|dismissed|clicked_link|called_bank|no_response`',
    `delivered_timestamp` TIMESTAMP COMMENT 'The date and time when the alert was successfully delivered to the customers device or inbox, following format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `delivery_cost_amount` DECIMAL(18,2) COMMENT 'The cost incurred for delivering this alert through the chosen channel, typically charged by the delivery provider.',
    `delivery_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the delivery cost amount.. Valid values are `^[A-Z]{3}$`',
    `delivery_provider` STRING COMMENT 'Name of the third-party service provider or platform used to deliver the alert (e.g., Twilio for SMS, SendGrid for email, Firebase for push notifications).',
    `delivery_status` STRING COMMENT 'Current status of the alert delivery lifecycle: queued for sending, sent to provider, delivered to device, read by customer, failed to deliver, bounced back, or customer unsubscribed. [ENUM-REF-CANDIDATE: queued|sent|delivered|read|failed|bounced|unsubscribed — 7 candidates stripped; promote to reference product]',
    `failure_reason` STRING COMMENT 'Detailed explanation of why the alert delivery failed, if applicable (e.g., invalid phone number, email bounced, device token expired, customer blocked sender).',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the alert was delivered, based on customer preference.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this alert record was last updated, following format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_retry_timestamp` TIMESTAMP COMMENT 'The date and time of the most recent delivery retry attempt, following format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `opt_in_date` DATE COMMENT 'The date when the customer provided consent to receive this type of alert, following format yyyy-MM-dd.',
    `opt_in_status` STRING COMMENT 'The customers consent status for receiving this type of alert at the time of sending: explicitly opted in, opted out, or default (no explicit preference recorded).. Valid values are `opted_in|opted_out|default`',
    `opt_out_date` DATE COMMENT 'The date when the customer withdrew consent or unsubscribed from this type of alert, following format yyyy-MM-dd.',
    `personalization_applied` BOOLEAN COMMENT 'Indicates whether customer-specific personalization (name, account details, transaction amounts) was applied to the alert content (True) or a generic template was used (False).',
    `priority` STRING COMMENT 'Priority level assigned to the alert indicating urgency and importance for customer action or awareness.. Valid values are `critical|high|medium|low`',
    `provider_message_reference` STRING COMMENT 'Unique message identifier assigned by the delivery provider, used for tracking and troubleshooting delivery issues.',
    `read_timestamp` TIMESTAMP COMMENT 'The date and time when the customer opened or read the alert, if tracking is available, following format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `recipient_address` STRING COMMENT 'The specific delivery address used for this alert: email address, phone number, device token, or other channel-specific identifier.',
    `reference_number` STRING COMMENT 'Business-facing unique reference number for the alert, used for customer service inquiries and tracking.',
    `regulatory_flag` BOOLEAN COMMENT 'Indicates whether this alert is mandated by regulatory requirements (True) or is discretionary/operational (False).',
    `regulatory_requirement` STRING COMMENT 'Specific regulatory rule or requirement that mandates this alert, if applicable (e.g., Regulation E overdraft notice, CARD Act payment due reminder).',
    `response_timestamp` TIMESTAMP COMMENT 'The date and time when the customer responded to or interacted with the alert, following format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `retry_count` STRING COMMENT 'Number of delivery retry attempts made for this alert after initial failure.',
    `scheduled_send_timestamp` TIMESTAMP COMMENT 'The date and time when the alert was scheduled to be sent, following format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `sla_met_flag` BOOLEAN COMMENT 'Indicates whether the alert was delivered within the defined Service Level Agreement (SLA) target time (True) or exceeded the target (False).',
    `sla_target_delivery_minutes` STRING COMMENT 'The target number of minutes within which this alert type should be delivered, as defined by internal Service Level Agreement (SLA) standards.',
    `subject` STRING COMMENT 'Subject line or headline of the alert message, providing a brief summary of the notification content.',
    `triggered_by_event` STRING COMMENT 'Description of the business event or condition that triggered the alert generation (e.g., balance below threshold, large withdrawal, suspicious activity detected).',
    CONSTRAINT pk_channel_alert PRIMARY KEY(`channel_alert_id`)
) COMMENT 'Transactional record of each notification or alert sent to a customer through a channel — push notifications, SMS alerts, email notifications, in-app messages, and branch appointment reminders. Captures alert type (transaction alert, fraud alert, balance threshold, payment due, regulatory notice), channel delivered, customer ID, delivery timestamp, delivery status (sent, delivered, read, failed), customer response, and opt-in/opt-out status. Supports omnichannel communication management and regulatory notice delivery tracking.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`branch_appointment` (
    `branch_appointment_id` BIGINT COMMENT 'Unique identifier for the branch appointment record. Primary key.',
    `branch_id` BIGINT COMMENT 'Reference to the branch where the appointment is scheduled.',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the relationship manager assigned to the appointment, if applicable.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Branch appointments for account services, disputes, or product discussions reference the primary account being serviced for CRM tracking, sales attribution, and service quality monitoring. Essential f',
    `party_id` BIGINT COMMENT 'Reference to the customer or party who scheduled the appointment.',
    `rescheduled_from_appointment_id` BIGINT COMMENT 'Reference to the original appointment identifier if this appointment is a rescheduled version of a prior appointment.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Appointments are staffed by specific employees (advisors, specialists, product experts). Essential for capacity planning, performance tracking, compensation attribution, and customer relationship cont',
    `actual_arrival_time` TIMESTAMP COMMENT 'The actual date and time when the customer arrived for the appointment.',
    `actual_duration_minutes` STRING COMMENT 'Actual duration of the appointment in minutes, calculated from start to end time.',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the appointment service concluded.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the appointment service began.',
    `appointment_channel` STRING COMMENT 'The channel through which the appointment was originally booked.. Valid values are `walk_in|phone|web|mobile_app|email|relationship_manager`',
    `appointment_notes` STRING COMMENT 'Free-text notes or comments recorded by staff during or after the appointment, capturing key discussion points or customer requests.',
    `appointment_number` STRING COMMENT 'Business-facing unique identifier or confirmation number for the appointment, used for customer reference and tracking.',
    `appointment_outcome` STRING COMMENT 'The result or outcome of the appointment after completion or cancellation.. Valid values are `successful|partially_completed|unsuccessful|customer_no_show|cancelled_by_customer|cancelled_by_bank`',
    `appointment_status` STRING COMMENT 'Current lifecycle status of the appointment. [ENUM-REF-CANDIDATE: scheduled|confirmed|in_progress|completed|cancelled|no_show|rescheduled — 7 candidates stripped; promote to reference product]',
    `appointment_type` STRING COMMENT 'Category of service or consultation requested for the appointment. [ENUM-REF-CANDIDATE: account_opening|loan_consultation|investment_review|kyc_refresh|notary_service|wealth_advisory|mortgage_application|safe_deposit_box — 8 candidates stripped; promote to reference product]',
    `cancellation_reason` STRING COMMENT 'Free-text or coded explanation for why the appointment was cancelled.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the appointment was cancelled.',
    `confirmation_sent_flag` BOOLEAN COMMENT 'Indicator of whether an appointment confirmation notification was sent to the customer.',
    `confirmation_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the appointment confirmation notification was sent to the customer.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the appointment record was first created in the system.',
    `customer_feedback` STRING COMMENT 'Free-text feedback or comments provided by the customer regarding their appointment experience.',
    `customer_satisfaction_score` STRING COMMENT 'Numeric rating provided by the customer reflecting their satisfaction with the appointment experience, typically on a scale of 1 to 5 or 1 to 10.',
    `follow_up_action` STRING COMMENT 'Description of the follow-up action or next steps required after the appointment.',
    `follow_up_due_date` DATE COMMENT 'Target date by which the follow-up action should be completed.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicator of whether a follow-up action or appointment is required after this appointment.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system process that last modified the appointment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the appointment record was last updated in the system.',
    `no_show_flag` BOOLEAN COMMENT 'Indicator of whether the customer failed to attend the scheduled appointment without prior cancellation.',
    `products_discussed` STRING COMMENT 'Comma-separated list or description of banking products or services discussed during the appointment.',
    `products_sold` STRING COMMENT 'Comma-separated list or description of banking products or services successfully sold or opened as a result of the appointment.',
    `reminder_sent_flag` BOOLEAN COMMENT 'Indicator of whether an appointment reminder notification was sent to the customer.',
    `reminder_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the appointment reminder notification was sent to the customer.',
    `revenue_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the revenue generated amount.. Valid values are `^[A-Z]{3}$`',
    `revenue_generated_amount` DECIMAL(18,2) COMMENT 'Estimated or actual revenue generated from products sold or services rendered during the appointment.',
    `scheduled_date` DATE COMMENT 'The date on which the appointment is scheduled to occur.',
    `scheduled_duration_minutes` STRING COMMENT 'Planned duration of the appointment in minutes.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The anticipated date and time when the appointment is scheduled to conclude.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise date and time when the appointment is scheduled to begin.',
    `sla_actual_wait_time_minutes` STRING COMMENT 'The actual wait time in minutes from scheduled start time to actual start time, used for SLA compliance tracking.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicator of whether the appointment met the defined service level agreement for wait time and service delivery.',
    `sla_target_wait_time_minutes` STRING COMMENT 'The target maximum wait time in minutes from scheduled start time to actual start time, as defined by branch service level agreements.',
    CONSTRAINT pk_branch_appointment PRIMARY KEY(`branch_appointment_id`)
) COMMENT 'Transactional record for customer appointments scheduled at a branch or with a relationship manager. Captures appointment ID, customer ID, branch or RM reference, appointment type (account opening, loan consultation, investment review, KYC refresh, notary), scheduled datetime, actual arrival time, duration, staff assigned, outcome, no-show flag, and follow-up actions. Supports branch capacity planning, RM calendar management, and customer journey orchestration.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`preference` (
    `preference_id` BIGINT COMMENT 'Primary key for preference',
    `channel_relationship_manager_id` BIGINT COMMENT 'Reference to the customers preferred relationship manager (RM) for wealth management and advisory services. Applicable primarily to high-net-worth and institutional clients.',
    `party_id` BIGINT COMMENT 'Reference to the customer party who owns this preference profile. Links to the customer master record.',
    `branch_id` BIGINT COMMENT 'Reference to the customers preferred branch location for in-person banking services. Nullable if customer has no branch preference.',
    `accessibility_requirement_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has declared accessibility requirements (visual, auditory, mobility, cognitive). True triggers accessibility-enhanced service delivery.',
    `accessibility_requirement_type` STRING COMMENT 'Type of accessibility requirement declared by the customer. Used to configure appropriate assistive technologies and service accommodations. Confidential to protect customer privacy.. Valid values are `visual|auditory|mobility|cognitive|speech|multiple`',
    `audio_format_required` BOOLEAN COMMENT 'Boolean flag indicating whether the customer requires audio formats for digital communications and statements.',
    `braille_required` BOOLEAN COMMENT 'Boolean flag indicating whether the customer requires Braille formats for paper communications.',
    `branch_channel_preference_score` DECIMAL(18,2) COMMENT 'System-calculated score (0.00 to 100.00) representing the customers propensity to use branch services. Complements digital preference score for omnichannel segmentation.',
    `consent_basis` STRING COMMENT 'Legal basis for processing the preference data under GDPR Article 6: explicit consent, legitimate interest, contractual necessity, legal obligation, or vital interest.. Valid values are `explicit_consent|legitimate_interest|contractual_necessity|legal_obligation|vital_interest`',
    `consent_channel` STRING COMMENT 'Channel through which the customer provided consent for this preference. Required for consent audit trail. [ENUM-REF-CANDIDATE: mobile_app|web_portal|branch|phone|email|paper_form|relationship_manager — 7 candidates stripped; promote to reference product]',
    `consent_ip_address` STRING COMMENT 'IP address from which digital consent was provided. Used for fraud detection and consent verification. Confidential for privacy protection.',
    `consent_timestamp` TIMESTAMP COMMENT 'Date and time when the customer provided consent for this preference. Critical for GDPR and TCPA compliance auditing.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this preference record was first created in the system. Part of standard audit trail.',
    `digital_channel_preference_score` DECIMAL(18,2) COMMENT 'System-calculated score (0.00 to 100.00) representing the customers propensity to use digital channels (mobile, web, API) versus traditional channels (branch, phone). Higher scores indicate stronger digital preference. Used for channel migration strategies and personalization.',
    `effective_date` DATE COMMENT 'Date from which this preference becomes active and enforceable in omnichannel orchestration systems.',
    `expiration_date` DATE COMMENT 'Date on which this preference expires and is no longer enforced. Nullable for preferences with no expiration. Some jurisdictions require periodic consent renewal.',
    `inference_confidence_score` DECIMAL(18,2) COMMENT 'Confidence score (0.00 to 100.00) associated with system-inferred preferences. Higher scores indicate greater confidence in the inference. Nullable for customer-stated preferences.',
    `inference_model_version` STRING COMMENT 'Version identifier of the machine learning or analytics model used to infer preferences when preference_source is system_inferred. Enables model governance and auditability.',
    `large_print_required` BOOLEAN COMMENT 'Boolean flag indicating whether the customer requires large-print formats for paper communications and statements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this preference record was last updated. Part of standard audit trail for tracking preference changes over time.',
    `last_verified_date` DATE COMMENT 'Date when the preference was last verified or reconfirmed by the customer. Used to track consent freshness and trigger re-verification workflows.',
    `marketing_email_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has consented to receive marketing and promotional emails. True = opted in, False = opted out. Must comply with CAN-SPAM Act and GDPR.',
    `marketing_mail_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has consented to receive marketing and promotional materials via postal mail.',
    `marketing_phone_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has consented to receive marketing and promotional phone calls. Must comply with TCPA and Do Not Call Registry requirements.',
    `marketing_sms_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has consented to receive marketing and promotional SMS messages. Must comply with TCPA regulations.',
    `next_verification_due_date` DATE COMMENT 'Date by which the preference should be re-verified with the customer to maintain compliance with consent renewal policies.',
    `notification_category_alerts` BOOLEAN COMMENT 'Boolean flag indicating opt-in status for account alert notifications (low balance, large transaction, unusual activity).',
    `notification_category_payments` BOOLEAN COMMENT 'Boolean flag indicating opt-in status for payment-related notifications (payment due, payment received, payment failed).',
    `notification_category_products` BOOLEAN COMMENT 'Boolean flag indicating opt-in status for product and service update notifications (new features, rate changes, terms updates).',
    `notification_category_security` BOOLEAN COMMENT 'Boolean flag indicating opt-in status for security-related notifications (login from new device, password change, suspicious activity). Typically defaults to True for customer protection.',
    `override_authorized_by` STRING COMMENT 'Name or identifier of the person or system that authorized the preference override. Required for audit trail when override_flag is True.',
    `override_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this preference has been overridden by regulatory requirement, legal hold, or operational necessity. True = preference is overridden.',
    `override_reason` STRING COMMENT 'Free-text explanation of why the preference was overridden. Required when override_flag is True. Examples: regulatory requirement, fraud investigation, legal hold, customer safety.',
    `preference_source` STRING COMMENT 'Origin of the preference data: customer-stated (self-service), system-inferred (behavioral analytics), relationship manager input, onboarding process, data migration, or third-party source.. Valid values are `customer_stated|system_inferred|relationship_manager|onboarding|migration|third_party`',
    `preference_status` STRING COMMENT 'Current lifecycle status of the preference record. Active preferences are enforced in omnichannel orchestration.. Valid values are `active|inactive|suspended|pending_verification|expired`',
    `preference_type` STRING COMMENT 'Category of preference being captured: contact channel, communication, notification, service delivery, accessibility, or privacy.. Valid values are `contact_channel|communication|notification|service_delivery|accessibility|privacy`',
    `preferred_contact_channel` STRING COMMENT 'The customers stated or inferred primary channel for bank-initiated contact and service delivery. [ENUM-REF-CANDIDATE: mobile_app|web_portal|email|sms|phone|branch|atm|relationship_manager|mail — 9 candidates stripped; promote to reference product]',
    `preferred_language_code` STRING COMMENT 'ISO 639-2 three-letter language code representing the customers preferred language for communication and service delivery (e.g., ENG, SPA, FRA, CHI).. Valid values are `^[A-Z]{3}$`',
    `statement_delivery_channel` STRING COMMENT 'Customers preferred channel for receiving account statements: electronic (email/portal), paper (postal mail), both, or suppressed (no statements).. Valid values are `electronic|paper|both|suppressed`',
    `statement_frequency` STRING COMMENT 'Frequency at which the customer prefers to receive account statements.. Valid values are `monthly|quarterly|annually|on_demand`',
    `transactional_email_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has opted in to receive transactional and service-related emails (statements, alerts, confirmations). Typically defaults to True as these are essential communications.',
    `transactional_sms_opt_in` BOOLEAN COMMENT 'Boolean flag indicating whether the customer has opted in to receive transactional and service-related SMS notifications (fraud alerts, payment confirmations, balance alerts).',
    CONSTRAINT pk_preference PRIMARY KEY(`preference_id`)
) COMMENT 'Master record capturing each customers stated and inferred channel preferences — preferred contact channel (mobile, email, branch, phone), preferred language, notification opt-ins/opt-outs by category, preferred branch, preferred RM, digital vs. branch preference score, and accessibility requirements. Captures preference source (customer-stated, system-inferred), effective date, and consent basis. Drives omnichannel personalization and regulatory communication compliance (TCPA, CAN-SPAM).';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`api_application` (
    `api_application_id` BIGINT COMMENT 'Unique identifier for the API application registration record. Primary key for the API application entity.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: API applications are registered under specific regulatory jurisdictions (PSD2, CFPB 1033, CDR). Critical for TPP validation, regulatory compliance, API governance, and determining applicable data acce',
    `account_information_service_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether the application is authorized to access account information services under PSD2 or equivalent open banking regulations.',
    `activation_date` DATE COMMENT 'Date on which the API application was activated and granted access to production APIs following successful onboarding and approval.',
    `api_product_subscriptions` STRING COMMENT 'Comma-separated list of API product subscriptions granted to the application, such as account information service (AIS), payment initiation service (PIS), funds confirmation service (FCS), and other open banking services.',
    `application_code` STRING COMMENT 'Unique business identifier or code assigned to the API application for external reference and integration purposes.',
    `application_name` STRING COMMENT 'Human-readable name of the third-party provider (TPP) or internal application registered to consume the banks open banking APIs.',
    `application_status` STRING COMMENT 'Current lifecycle status of the API application registration indicating whether the application is authorized to consume APIs.. Valid values are `pending_approval|active|suspended|revoked|expired|deactivated`',
    `application_type` STRING COMMENT 'Classification of the API application based on the nature of the consumer organization (third-party provider, internal application, partner, fintech, aggregator, or merchant service).. Valid values are `third_party_provider|internal_application|partner_application|fintech_integration|aggregator|merchant_service`',
    `callback_url` STRING COMMENT 'Registered callback URL to which the banks API gateway will redirect users after authentication or send asynchronous notifications.',
    `consent_duration_days` STRING COMMENT 'Maximum number of days for which customer consent remains valid for this application to access their data, as defined by regulatory requirements or bank policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the API application record was first created in the system.',
    `data_access_scope` STRING COMMENT 'Detailed description of the data access permissions and scope granted to the application, including specific account types, transaction history depth, and customer data elements.',
    `deactivation_date` DATE COMMENT 'Date on which the API application was deactivated or revoked, terminating its access to the banks APIs.',
    `developer_contact_email` STRING COMMENT 'Primary email address for technical and operational communication with the application developer or organization.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `developer_contact_phone` STRING COMMENT 'Primary phone number for contacting the application developer or organization for support and incident management.',
    `developer_organization_name` STRING COMMENT 'Legal name of the organization or entity that developed and owns the API application.',
    `eidas_certificate_expiry_date` DATE COMMENT 'Expiration date of the eIDAS qualified certificate. The application must renew the certificate before this date to maintain API access.',
    `eidas_certificate_issuer` STRING COMMENT 'Name of the qualified trust service provider (QTSP) that issued the eIDAS certificate for the application.',
    `eidas_certificate_reference` STRING COMMENT 'Reference identifier for the eIDAS qualified certificate used for secure authentication and digital signatures in PSD2 API transactions.',
    `encryption_standard` STRING COMMENT 'Encryption protocol and version required for secure communication between the application and the banks API endpoints (e.g., TLS 1.2, TLS 1.3, mutual TLS).. Valid values are `TLS_1_2|TLS_1_3|MTLS`',
    `environment` STRING COMMENT 'Deployment environment in which the API application is registered and operates (sandbox for testing, UAT for user acceptance testing, production for live operations).. Valid values are `sandbox|uat|production`',
    `funds_confirmation_service_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether the application is authorized to confirm availability of funds for card-based payment transactions under PSD2 or equivalent open banking regulations.',
    `ip_whitelist` STRING COMMENT 'Comma-separated list of IP addresses or CIDR ranges from which the application is permitted to make API requests for enhanced security.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the API application record was last updated or modified.',
    `oauth2_client_identifier` STRING COMMENT 'OAuth 2.0 client identifier assigned to the application for authentication and authorization flows in the open banking API ecosystem.',
    `oauth2_client_secret_hash` STRING COMMENT 'Hashed representation of the OAuth 2.0 client secret used for secure authentication. The plaintext secret is never stored.',
    `onboarding_approval_date` DATE COMMENT 'Date on which the applications onboarding request was approved and the application was authorized to access production APIs.',
    `onboarding_approval_status` STRING COMMENT 'Status of the applications onboarding approval process indicating whether the bank has authorized the application to access production APIs.. Valid values are `pending_review|approved|rejected|conditional_approval`',
    `onboarding_approved_by` STRING COMMENT 'Name or identifier of the bank employee or system that approved the applications onboarding request.',
    `payment_initiation_service_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether the application is authorized to initiate payments on behalf of customers under PSD2 or equivalent open banking regulations.',
    `rate_limit_requests_per_day` STRING COMMENT 'Maximum number of API requests the application is permitted to make per day based on its assigned rate limit tier.',
    `rate_limit_requests_per_minute` STRING COMMENT 'Maximum number of API requests the application is permitted to make per minute based on its assigned rate limit tier.',
    `rate_limit_tier` STRING COMMENT 'Tier classification that determines the maximum number of API requests the application is allowed to make within a specified time period.. Valid values are `sandbox|basic|standard|premium|enterprise|unlimited`',
    `registration_date` DATE COMMENT 'Date on which the API application was initially registered in the banks open banking platform.',
    `regulatory_registration_status` STRING COMMENT 'Status of the applications regulatory registration with competent authorities such as PSD2 TPP license or CFPB 1033 registration.. Valid values are `registered|pending|not_required|expired|revoked`',
    `sla_response_time_ms` STRING COMMENT 'Maximum API response time in milliseconds guaranteed under the service level agreement for the applications rate limit tier.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Guaranteed uptime percentage for the API services as defined in the service level agreement with the application developer.',
    `terms_of_service_accepted_date` DATE COMMENT 'Date on which the application developer accepted the current version of the API terms of service.',
    `terms_of_service_version` STRING COMMENT 'Version identifier of the API terms of service that the application developer has accepted and agreed to comply with.',
    `tpp_competent_authority` STRING COMMENT 'Name of the regulatory authority that issued the TPP license or registration (e.g., Financial Conduct Authority, BaFin, ACPR).',
    `tpp_license_number` STRING COMMENT 'License or registration number issued by the competent authority under PSD2 or equivalent regulation authorizing the third-party provider to offer payment services.',
    `webhook_url` STRING COMMENT 'Endpoint URL where the bank will send real-time event notifications and webhooks for subscribed events such as payment status updates or account changes.',
    CONSTRAINT pk_api_application PRIMARY KEY(`api_application_id`)
) COMMENT 'Master record for each third-party provider (TPP) or internal application registered to consume the banks open banking APIs. Captures application name, developer/organization identity, API product subscriptions (account information, payment initiation, funds confirmation), OAuth2 client credentials (hashed), rate limit tier, environment (sandbox, UAT, production), regulatory registration (TPP license under PSD2, CFPB 1033 registration status), eIDAS certificate reference, data access scope, terms of service version accepted, and onboarding approval status. SSOT for API consumer identity, access governance, and TPP lifecycle management within the channel domain.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`channel_product` (
    `channel_product_id` BIGINT COMMENT 'Unique identifier for the channel-product association. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the person who approved this product-channel association.',
    `channel_id` BIGINT COMMENT 'Reference to the banking channel through which the product is offered (e.g., mobile banking, branch, ATM, contact center).',
    `disclosure_template_id` BIGINT COMMENT 'Reference to the regulatory disclosure template that must be presented for this product-channel combination.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Banks configure channel-specific securities product catalogs (e.g., certain bonds only available via relationship managers, complex derivatives restricted from digital channels). Channel product avail',
    `previous_channel_product_id` BIGINT COMMENT 'Self-referencing FK on channel_product (previous_channel_product_id)',
    `api_endpoint_url` STRING COMMENT 'API endpoint URL for programmatic access to this product through this channel (for API/open banking channels).',
    `approval_date` DATE COMMENT 'Date on which this product-channel association was approved.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether managerial or compliance approval is required before offering this product through this channel.',
    `authentication_method_required` STRING COMMENT 'Authentication method(s) required for accessing this product through this channel (e.g., password, biometric, two-factor, token, PIN).',
    `availability_status` STRING COMMENT 'Current availability status of the product through this specific channel.. Valid values are `available|unavailable|restricted|pilot|sunset`',
    `channel_fee_amount` DECIMAL(18,2) COMMENT 'Channel-specific fee charged for accessing or transacting with this product through this channel (e.g., ATM surcharge, branch service fee).',
    `channel_fee_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the channel fee.. Valid values are `^[A-Z]{3}$`',
    `channel_specific_product_code` STRING COMMENT 'Channel-specific identifier or SKU for the product variant offered through this channel, if different from the standard product code.',
    `configuration_parameters` STRING COMMENT 'Channel-specific configuration parameters or feature flags for this product (stored as JSON or key-value pairs).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel-product association record was first created in the system.',
    `cross_sell_priority` STRING COMMENT 'Priority ranking for cross-selling this product through this channel (lower number = higher priority).',
    `customer_segment_restriction` STRING COMMENT 'Customer segment eligibility restrictions for accessing this product through this channel (e.g., retail, private banking, institutional, small business).',
    `data_source_system` STRING COMMENT 'Source system from which this channel-product association data originated (e.g., Core Banking System, Channel Management Platform).',
    `digital_experience_url` STRING COMMENT 'URL or deep link to the digital experience for this product within this channel (for digital channels).',
    `effective_date` DATE COMMENT 'Date from which this product became available through this channel.',
    `fee_schedule_code` STRING COMMENT 'Reference to the fee schedule applicable to this product when accessed through this channel.',
    `geographic_restriction` STRING COMMENT 'Geographic availability restrictions for this product-channel combination (e.g., country codes, state codes, regional restrictions).',
    `kyc_requirement_level` STRING COMMENT 'Level of KYC verification required when opening or accessing this product through this channel.. Valid values are `none|basic|standard|enhanced|full`',
    `last_modified_by` STRING COMMENT 'User or system identifier that last modified this record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel-product association record was last updated.',
    `marketing_campaign_code` STRING COMMENT 'Marketing campaign identifier associated with promoting this product through this channel.',
    `pricing_tier` STRING COMMENT 'Pricing tier or segment applicable to this product-channel combination (e.g., premium, standard, basic).',
    `product_category` STRING COMMENT 'High-level classification of the product type (deposit accounts, lending products, investment services, payment services, etc.). [ENUM-REF-CANDIDATE: deposit|loan|credit_card|investment|insurance|payment|advisory|trade_finance — 8 candidates stripped; promote to reference product]',
    `product_code` STRING COMMENT 'Unique code identifying the banking product or service (e.g., checking account, mortgage loan, credit card, investment advisory).',
    `product_name` STRING COMMENT 'Human-readable name of the banking product or service offered through this channel.',
    `regulatory_disclosure_required` BOOLEAN COMMENT 'Indicates whether regulatory disclosures must be presented when offering this product through this channel.',
    `sla_response_time_seconds` STRING COMMENT 'Target response time in seconds for product-related requests through this channel.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Target uptime percentage for product availability through this channel.',
    `supports_account_opening` BOOLEAN COMMENT 'Indicates whether new account origination for this product is supported through this channel.',
    `supports_closure` BOOLEAN COMMENT 'Indicates whether account or product closure can be initiated through this channel.',
    `supports_servicing` BOOLEAN COMMENT 'Indicates whether account servicing activities (balance inquiries, statement requests, profile updates) for this product are supported through this channel.',
    `supports_transactions` BOOLEAN COMMENT 'Indicates whether transactional activity (deposits, withdrawals, transfers, payments) for this product is supported through this channel.',
    `termination_date` DATE COMMENT 'Date on which this product will no longer be available through this channel (null if ongoing).',
    `transaction_limit_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the transaction limits (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `transaction_limit_daily` DECIMAL(18,2) COMMENT 'Maximum daily transaction amount allowed for this product through this channel.',
    `transaction_limit_per_transaction` DECIMAL(18,2) COMMENT 'Maximum amount allowed for a single transaction for this product through this channel.',
    CONSTRAINT pk_channel_product PRIMARY KEY(`channel_product_id`)
) COMMENT 'Association entity mapping which banking products and services are available through which channels. Captures channel, product type, availability status, and channel-specific configuration.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`queue` (
    `queue_id` BIGINT COMMENT 'Unique identifier for the customer service queue. Primary key for the queue entity.',
    `branch_id` BIGINT COMMENT 'Reference to the branch location where this queue is configured, if applicable for branch-based queues.',
    `contact_center_id` BIGINT COMMENT 'Reference to the contact center where this queue is configured.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Queue ownership is critical for SLA accountability, staffing decisions, routing rule changes, and performance management. Banking operations require clear responsibility for queue performance metrics ',
    `overflow_queue_id` BIGINT COMMENT 'Reference to the alternate queue where interactions are routed when this queue reaches maximum capacity.',
    `parent_queue_id` BIGINT COMMENT 'Self-referencing FK on queue (parent_queue_id)',
    `abandonment_threshold_seconds` STRING COMMENT 'Time threshold in seconds after which a customer disconnect is counted as an abandonment for reporting purposes.',
    `agents_available` STRING COMMENT 'Real-time count of agents or service representatives currently available to service this queue.',
    `agents_busy` STRING COMMENT 'Real-time count of agents currently handling interactions from this queue.',
    `agents_staffed` STRING COMMENT 'Total count of agents or service representatives currently staffed and logged into this queue.',
    `average_handle_time_seconds` STRING COMMENT 'Historical average time in seconds to complete an interaction from this queue, including talk time and after-call work.',
    `callback_enabled_flag` BOOLEAN COMMENT 'Indicates whether customers can request a callback instead of waiting in queue.',
    `cost_center_code` STRING COMMENT 'General Ledger (GL) cost center code to which queue operational costs are allocated.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this queue record was first created in the system.',
    `current_queue_depth` STRING COMMENT 'Real-time count of interactions currently waiting in the queue.',
    `current_sla_compliance_percentage` DECIMAL(18,2) COMMENT 'Real-time percentage of interactions answered within SLA target time for the current measurement period.',
    `current_wait_time_seconds` STRING COMMENT 'Real-time average wait time in seconds for interactions currently in the queue.',
    `customer_segment_restriction` STRING COMMENT 'Customer segment or tier restriction for queue access, if applicable (e.g., premium, private banking).',
    `effective_from_date` DATE COMMENT 'Date when this queue configuration became effective and operational.',
    `effective_to_date` DATE COMMENT 'Date when this queue configuration ceased to be effective, null if currently active.',
    `estimated_wait_time_announcement_flag` BOOLEAN COMMENT 'Indicates whether estimated wait time is announced to customers in queue.',
    `language_support` STRING COMMENT 'Comma-separated list of language codes supported by agents servicing this queue.',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified this queue configuration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this queue record was last updated or modified.',
    `max_queue_capacity` STRING COMMENT 'Maximum number of interactions that can be held in the queue before overflow or rejection occurs.',
    `music_on_hold_enabled_flag` BOOLEAN COMMENT 'Indicates whether music or audio content is played while customers wait in queue.',
    `operating_hours_end_time` TIMESTAMP COMMENT 'Daily end time when the queue stops accepting new interactions, in HH:MM format.',
    `operating_hours_start_time` TIMESTAMP COMMENT 'Daily start time when the queue begins accepting interactions, in HH:MM format.',
    `priority_level` STRING COMMENT 'Numeric priority level for queue processing, with lower numbers indicating higher priority.',
    `product_scope` STRING COMMENT 'Comma-separated list of product categories or codes that this queue supports.',
    `quality_monitoring_sample_rate` DECIMAL(18,2) COMMENT 'Percentage of interactions from this queue that are sampled for quality monitoring and coaching.',
    `queue_code` STRING COMMENT 'Unique business identifier code for the queue used in operational systems and reporting.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `queue_name` STRING COMMENT 'Human-readable name of the queue describing its purpose or service area.',
    `queue_status` STRING COMMENT 'Current operational status of the queue indicating whether it is accepting new interactions.. Valid values are `active|inactive|suspended|maintenance`',
    `queue_type` STRING COMMENT 'Classification of the queue by interaction channel and service delivery method. [ENUM-REF-CANDIDATE: inbound_call|outbound_call|chat|email|video|branch_teller|branch_advisor|callback — 8 candidates stripped; promote to reference product]',
    `regulatory_recording_required_flag` BOOLEAN COMMENT 'Indicates whether interactions in this queue must be recorded for regulatory compliance purposes.',
    `routing_algorithm` STRING COMMENT 'Algorithm used to route interactions from this queue to available agents or service representatives.. Valid values are `fifo|priority|skill_based|longest_idle|round_robin`',
    `service_category` STRING COMMENT 'Business service category or line of business that this queue supports. [ENUM-REF-CANDIDATE: account_inquiry|loan_servicing|card_services|fraud_reporting|technical_support|sales|complaints — 7 candidates stripped; promote to reference product]',
    `skill_group` STRING COMMENT 'Skill group or competency category required to service interactions in this queue, used for agent routing.',
    `sla_target_answer_time_seconds` STRING COMMENT 'Target time in seconds within which interactions should be answered to meet SLA commitments.',
    `sla_target_percentage` DECIMAL(18,2) COMMENT 'Target percentage of interactions that should be answered within the SLA target time (e.g., 80% answered in 20 seconds).',
    `time_zone` STRING COMMENT 'Time zone in which the queue operates, using IANA time zone database format.',
    CONSTRAINT pk_queue PRIMARY KEY(`queue_id`)
) COMMENT 'Customer service queue configuration and real-time status for contact center and branch operations. Captures queue type, skill group, current wait time, SLA target, and staffing level.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`branch_audit_scope` (
    `branch_audit_scope_id` BIGINT COMMENT 'Unique identifier for this branch-engagement scope record. Primary key.',
    `branch_id` BIGINT COMMENT 'Foreign key linking to the branch location included in the audit engagement scope',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to the internal audit engagement that covers this branch',
    `auditor_assigned` STRING COMMENT 'Name or identifier of the auditor assigned to conduct fieldwork at this specific branch. In large engagements, different auditors may cover different branches.',
    `branch_audit_status` STRING COMMENT 'Current status of the audit work for this specific branch within the engagement. Allows tracking of multi-branch engagements where different branches may be at different stages.',
    `branch_risk_rating` STRING COMMENT 'Risk rating assigned to this specific branch within the context of this audit engagement. Reflects branch-specific risk factors such as transaction volume, prior findings, regulatory issues, or control weaknesses.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this branch was added to the engagement scope.',
    `findings_count` STRING COMMENT 'Total number of audit findings (observations, exceptions, control deficiencies) identified at this branch during this engagement. Used for branch performance tracking and risk assessment.',
    `last_audit_date` DATE COMMENT 'Date when audit fieldwork was last conducted at this branch for this engagement. Used for tracking audit coverage and scheduling follow-up visits.',
    `sample_size` STRING COMMENT 'Number of transactions, accounts, or records sampled from this branch during the audit engagement. Used for statistical sampling and audit coverage documentation.',
    `scope_end_date` DATE COMMENT 'End date of the audit period for this specific branch within the engagement. Defines the business period under review for this branch.',
    `scope_start_date` DATE COMMENT 'Start date of the audit period for this specific branch within the engagement. May differ from the overall engagement audit period if branches are audited in phases.',
    `updated_date` TIMESTAMP COMMENT 'Timestamp when this scope record was last modified.',
    CONSTRAINT pk_branch_audit_scope PRIMARY KEY(`branch_audit_scope_id`)
) COMMENT 'This association product represents the audit scope relationship between branch and engagement. It captures the inclusion of a specific branch location within an internal audit engagement, including branch-specific risk assessments, sample parameters, and audit findings. Each record links one branch to one engagement with attributes that exist only in the context of this specific audit coverage.. Existence Justification: In banking internal audit operations, audit engagements routinely cover multiple branch locations (regional audits, thematic compliance reviews, network-wide cash audits), and each branch is subject to multiple audit engagements over time (annual operational audits, surprise cash counts, BSA/AML reviews, SOX testing). The audit function actively manages the scope definition by assigning branches to engagements, tracking branch-specific risk ratings, sample sizes, findings counts, and audit status per branch.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`audit_scope` (
    `audit_scope_id` BIGINT COMMENT 'Unique identifier for this channel-engagement scope record. Primary key.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the banking channel included in the audit scope',
    `employee_id` BIGINT COMMENT 'Identifier of the audit staff member who added this channel to the engagement scope.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to the internal audit engagement',
    `audit_hours_allocated` DECIMAL(18,2) COMMENT 'Number of audit hours allocated and expended on reviewing this specific channel within the engagement. Used for audit resource planning, variance analysis, and cost allocation.',
    `channel_audit_opinion` STRING COMMENT 'Audit opinion specific to this channel within the engagement. May differ from the overall engagement opinion if the engagement covers multiple channels with varying control effectiveness.',
    `channel_risk_rating` STRING COMMENT 'Risk rating assigned to this specific channel within the context of this audit engagement, based on transaction volume, control environment, prior findings, and inherent channel risk. May differ from the overall engagement risk rating.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this channel was added to the engagement scope.',
    `findings_count` STRING COMMENT 'Number of audit findings (control deficiencies, exceptions, observations) identified for this channel during this engagement. Used for channel-level risk trending and audit reporting.',
    `scope_end_date` DATE COMMENT 'End date of the audit period for this specific channel within the engagement. May differ from the overall engagement audit period if channels are reviewed in phases.',
    `scope_inclusion_rationale` STRING COMMENT 'Business justification for including this channel in the engagement scope (e.g., high transaction volume, prior control deficiencies, regulatory focus area, new channel launch).',
    `scope_start_date` DATE COMMENT 'Start date of the audit period for this specific channel within the engagement. May differ from the overall engagement audit period if channels are reviewed in phases.',
    `scope_status` STRING COMMENT 'Current status of the audit work for this channel within the engagement. Allows tracking of phased audit execution where channels are reviewed sequentially.',
    `testing_approach` STRING COMMENT 'Audit testing methodology applied to this channel within the engagement (full population review, statistical sampling, judgmental sampling, process walkthrough, inquiry only).',
    `transaction_volume_reviewed` BIGINT COMMENT 'Number of transactions sampled and reviewed for this channel during this audit engagement. Used for audit sampling documentation and effort tracking.',
    CONSTRAINT pk_audit_scope PRIMARY KEY(`audit_scope_id`)
) COMMENT 'This association product represents the inclusion of a specific banking channel within the scope of an internal audit engagement. It captures the audit scope boundaries, risk assessment, transaction sampling parameters, and audit effort allocation for each channel-engagement combination. Each record links one channel to one engagement with attributes that exist only in the context of this audit scope relationship.. Existence Justification: In banking internal audit operations, a single audit engagement routinely covers multiple channels (branch network, ATM network, digital banking, contact center) to assess omnichannel risk, customer experience, and control effectiveness across the channel ecosystem. Conversely, each banking channel is audited by multiple engagements over time—annual operational audits, regulatory examinations, SOX compliance reviews, incident-driven investigations, and thematic audits. The audit function actively manages the scope definition for each engagement, explicitly selecting which channels to include, allocating audit hours per channel, assessing channel-specific risk ratings, sampling transactions, and tracking findings at the channel level.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`rule_configuration` (
    `rule_configuration_id` BIGINT COMMENT 'Unique identifier for this channel-rule configuration record. Primary key.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the banking channel where this rule configuration applies',
    `detection_rule_id` BIGINT COMMENT 'Foreign key linking to the fraud detection rule being configured for this channel',
    `alert_volume` BIGINT COMMENT 'Total number of fraud alerts generated by this rule on this channel during the measurement period, used for capacity planning and rule tuning decisions',
    `channel_specific_threshold` DECIMAL(18,2) COMMENT 'Threshold value tuned specifically for this channel-rule combination, overriding the default rule threshold when channel risk profiles differ (e.g., ATM may have lower velocity thresholds than mobile banking)',
    `configuration_status` STRING COMMENT 'Operational status of this rule on this channel: active (in production), inactive (disabled for this channel), testing (pilot mode), suspended (temporarily disabled due to performance issues)',
    `effective_date` DATE COMMENT 'Date when this channel-specific rule configuration became active in production monitoring',
    `expiration_date` DATE COMMENT 'Date when this channel-specific configuration is scheduled for review or retirement. Null for ongoing configurations.',
    `false_positive_rate` DECIMAL(18,2) COMMENT 'Proportion of legitimate transactions on this channel incorrectly flagged by this rule, calculated as false positives divided by total alerts for this channel-rule pair',
    `last_tuning_date` DATE COMMENT 'Date when the channel-specific threshold or configuration was last adjusted based on performance analysis for this channel-rule combination',
    `measurement_period_end_date` DATE COMMENT 'End date of the performance measurement period for the channel-specific metrics',
    `measurement_period_start_date` DATE COMMENT 'Start date of the performance measurement period for the channel-specific metrics (alert_volume, false_positive_rate, effectiveness_score)',
    `rule_effectiveness_score` DECIMAL(18,2) COMMENT 'Composite effectiveness metric (0-100) for this rule on this specific channel, calculated from channel-specific true positive rate, false positive rate, and detection coverage',
    CONSTRAINT pk_rule_configuration PRIMARY KEY(`rule_configuration_id`)
) COMMENT 'This association product represents the configuration relationship between banking channels and fraud detection rules. It captures channel-specific rule tuning, performance metrics, and threshold adjustments that exist only in the context of a specific channel-rule pairing. Each record links one channel to one detection rule with performance data and configuration parameters that vary by channel.. Existence Justification: In banking fraud operations, detection rules are configured and tuned differently for each channel based on channel-specific fraud patterns and risk profiles. A single fraud detection rule (e.g., velocity check) applies to multiple channels (ATM, mobile, branch, wire), and each channel has multiple active rules. The bank actively manages channel-rule configurations as operational entities, tracking performance metrics (alert volume, false positive rate, effectiveness score) and tuning thresholds per channel-rule combination.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Unique identifier for this cost center to channel allocation relationship. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the finance manager or controller who approved this cost allocation relationship. Used for audit trail and governance of allocation methodology changes.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to the banking channel receiving cost allocations',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to the cost center that is allocating costs to the channel',
    `created_by_user_employee_id` BIGINT COMMENT 'User ID of the person who created this cost allocation record. Used for audit trail and accountability.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person who last modified this cost allocation record. Used for audit trail and accountability.',
    `allocation_amount_annual` DECIMAL(18,2) COMMENT 'Budgeted or actual annual cost amount allocated from this cost center to this channel in the reporting currency. Calculated as cost_center.budget_amount * allocation_percentage. Used for channel P&L reporting and profitability analysis.',
    `allocation_method` STRING COMMENT 'Method used to calculate the allocation of costs from this cost center to this channel. Direct allocation assigns costs based on direct usage or causation. Activity-based uses cost drivers. Headcount allocates based on FTE count. Transaction volume uses transaction counts. Revenue-based allocates proportional to channel revenue. Square footage uses physical space. Custom indicates a specialized allocation formula.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the cost centers total costs allocated to this specific channel. Used for proportional cost distribution in activity-based costing. Sum of allocation_percentage across all channels for a given cost_center should equal 100%.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this cost allocation relationship. Active allocations are used in current financial reporting. Pending allocations are approved but not yet effective. Suspended allocations are temporarily inactive. Closed allocations are historical and no longer used.',
    `approval_date` DATE COMMENT 'Date when this cost allocation relationship was formally approved by finance management. Used for audit trail and compliance with internal financial controls.',
    `cost_driver_metric` STRING COMMENT 'The specific business metric or cost driver used to determine the allocation percentage for activity-based costing methods (e.g., transaction_count, customer_count, FTE_count, square_feet, server_hours). Null for direct allocation methods.',
    `cost_driver_value` DECIMAL(18,2) COMMENT 'The quantitative value of the cost driver metric for this cost center-channel allocation (e.g., 15000 transactions, 250 FTEs, 5000 square feet). Used to calculate allocation_percentage when using activity-based methods.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost allocation record was first created in the system. Used for audit trail.',
    `effective_from_date` DATE COMMENT 'Date when this cost allocation relationship became active and began being used for financial reporting and profitability analysis. Supports temporal tracking of allocation changes over time.',
    `effective_to_date` DATE COMMENT 'Date when this cost allocation relationship ended or was superseded by a new allocation structure. Null for currently active allocations. Supports historical analysis of cost allocation changes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cost allocation record was last updated. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes explaining the business rationale for this specific allocation, any special considerations, or documentation of allocation methodology decisions. Used for knowledge transfer and audit support.',
    `primary_channel_flag` BOOLEAN COMMENT 'Indicates whether this channel is the primary recipient of costs from this cost center. Used when a cost center predominantly supports one channel but has minor allocations to others. Supports simplified reporting and primary cost center assignment for channels.',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'This association product represents the cost allocation relationship between cost centers and banking channels. It captures how organizational costs are distributed across customer interaction channels for activity-based costing, channel profitability analysis, and management accounting. Each record links one cost center to one channel with allocation percentages, methods, and effective date ranges that exist only in the context of this cost distribution relationship.. Existence Justification: In banking operations, cost centers (organizational units like IT Operations, Compliance, Facilities) distribute their costs across multiple channels (branch network, ATM network, digital channels, contact centers), and each channel receives cost allocations from multiple cost centers. Banks actively manage these allocation relationships through formal allocation methodologies (activity-based costing, headcount-based, transaction volume-based) with specific percentages, effective dates, and approval workflows. This is a core management accounting process for channel profitability analysis, RAROC reporting, and FTP allocation.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`alert_template` (
    `alert_template_id` BIGINT COMMENT 'Primary key for alert_template',
    `previous_alert_template_id` BIGINT COMMENT 'Self-referencing FK on alert_template (previous_alert_template_id)',
    `approval_date` DATE COMMENT 'Date when the template was approved for production use.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this template for production use.',
    `call_to_action_text` STRING COMMENT 'Text for the call-to-action button or link within the alert message.',
    `call_to_action_url` STRING COMMENT 'Target URL for the call-to-action link, which may contain variable placeholders.',
    `alert_template_category` STRING COMMENT 'Business category classifying the alert template by functional domain.',
    `channel` STRING COMMENT 'The customer interaction channel through which this alert template is delivered.',
    `character_limit` STRING COMMENT 'Maximum number of characters allowed for this template based on channel constraints (e.g., 160 for SMS).',
    `consent_type` STRING COMMENT 'Type of customer consent required for alerts using this template.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the alert template record was first created in the system.',
    `delivery_time_end` STRING COMMENT 'End time of the allowed delivery window in HH:MM format (24-hour) for sending alerts using this template.',
    `delivery_time_start` STRING COMMENT 'Start time of the allowed delivery window in HH:MM format (24-hour) for sending alerts using this template.',
    `alert_template_description` STRING COMMENT 'Detailed description of the alert template purpose, usage guidelines, and business context.',
    `effective_date` DATE COMMENT 'Date from which the alert template becomes active and available for use.',
    `expiration_date` DATE COMMENT 'Date after which the alert template is no longer valid and should not be used. Null indicates no expiration.',
    `expiry_hours` STRING COMMENT 'Number of hours after which an undelivered alert expires and is no longer attempted.',
    `frequency_limit` STRING COMMENT 'Maximum number of times this alert can be sent to a customer within the frequency window to prevent alert fatigue.',
    `frequency_window_hours` STRING COMMENT 'Time window in hours within which the frequency limit applies.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 country code) indicating the language of the template content.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the alert template record was last updated.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp when this template was last used to generate an alert.',
    `message_body` STRING COMMENT 'Template content body containing the alert message text with variable placeholders for dynamic content substitution.',
    `personalization_enabled` BOOLEAN COMMENT 'Indicates whether the template supports dynamic personalization with customer-specific data.',
    `priority` STRING COMMENT 'Business priority level of the alert determining delivery urgency and customer notification importance.',
    `regulatory_classification` STRING COMMENT 'Classification indicating whether the alert is mandated by banking regulations or is discretionary.',
    `reply_to_email` STRING COMMENT 'Email address to which customer replies should be directed.',
    `requires_customer_consent` BOOLEAN COMMENT 'Indicates whether customer opt-in consent is required before sending alerts using this template.',
    `retry_count` STRING COMMENT 'Number of retry attempts allowed if alert delivery fails.',
    `retry_interval_minutes` STRING COMMENT 'Time interval in minutes between retry attempts for failed alert delivery.',
    `sender_email` STRING COMMENT 'Email address used as the sender for email-based alerts using this template.',
    `sender_name` STRING COMMENT 'Display name of the sender shown to the customer receiving the alert.',
    `alert_template_status` STRING COMMENT 'Current lifecycle status of the alert template indicating its availability for use.',
    `subject_line` STRING COMMENT 'Template subject line or title used for email and notification headers. May contain variable placeholders.',
    `tags` STRING COMMENT 'Comma-separated list of business tags or keywords for template categorization and search.',
    `template_code` STRING COMMENT 'Unique business identifier code for the alert template used for external reference and integration.',
    `template_name` STRING COMMENT 'Human-readable name of the alert template describing its purpose.',
    `template_type` STRING COMMENT 'Classification of the alert template by its primary business purpose.',
    `timezone` STRING COMMENT 'IANA timezone identifier for interpreting delivery time windows (e.g., America/New_York).',
    `trigger_event` STRING COMMENT 'Business event or condition that triggers the generation of an alert from this template.',
    `usage_count` BIGINT COMMENT 'Total number of times this template has been used to generate alerts.',
    `variable_placeholders` STRING COMMENT 'Comma-separated list of variable placeholder names used in the template for dynamic content substitution (e.g., customer_name, account_number, transaction_amount).',
    `version_number` STRING COMMENT 'Semantic version number of the template following major.minor.patch format for change tracking.',
    CONSTRAINT pk_alert_template PRIMARY KEY(`alert_template_id`)
) COMMENT 'Master reference table for alert_template. Referenced by template_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Primary key for campaign',
    `parent_campaign_id` BIGINT COMMENT 'Self-referencing FK on campaign (parent_campaign_id)',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Actual amount spent on campaign execution to date in the base currency.',
    `approval_status` STRING COMMENT 'Status of campaign approval workflow indicating whether the campaign has been authorized for execution.',
    `approved_by` STRING COMMENT 'Name of the approver who authorized the campaign for execution.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign was approved for execution.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total allocated budget for the campaign execution in the base currency.',
    `budget_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the campaign budget.',
    `business_unit` STRING COMMENT 'Business unit or division sponsoring the campaign (e.g., Retail Banking, Wealth Management, Corporate Banking).',
    `campaign_code` STRING COMMENT 'Externally-known unique business identifier for the campaign, used in reporting and cross-system references.',
    `campaign_name` STRING COMMENT 'Human-readable name of the marketing campaign for identification and reporting purposes.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the campaign indicating its operational state.',
    `campaign_type` STRING COMMENT 'Classification of the campaign based on its primary business objective.',
    `channel_type` STRING COMMENT 'Primary customer interaction channel through which the campaign is executed.',
    `compliance_notes` STRING COMMENT 'Notes or comments from compliance review regarding regulatory considerations or restrictions.',
    `compliance_reviewed` BOOLEAN COMMENT 'Indicates whether the campaign has undergone compliance and regulatory review.',
    `control_group_percentage` DECIMAL(18,2) COMMENT 'Percentage of target audience assigned to the control group for campaign effectiveness testing.',
    `conversion_count` BIGINT COMMENT 'Number of customers or prospects who completed the desired campaign action (e.g., product purchase, account opening).',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the primary campaign market.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was first created in the system.',
    `campaign_description` STRING COMMENT 'Detailed description of the campaign objectives, messaging strategy, and execution approach.',
    `end_date` DATE COMMENT 'Date when the campaign concludes and stops customer outreach. Nullable for ongoing campaigns.',
    `frequency_cap` STRING COMMENT 'Maximum number of times a customer can be contacted as part of this campaign to prevent over-communication.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the campaign record is currently active and available for operational use.',
    `message_template` STRING COMMENT 'Reference to the communication message template or creative content used in the campaign.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was last modified.',
    `offer_details` STRING COMMENT 'Specific promotional offer or incentive provided to customers as part of the campaign (e.g., interest rate discount, cashback, waived fees).',
    `opt_in_required` BOOLEAN COMMENT 'Indicates whether explicit customer opt-in consent is required for campaign participation per privacy regulations.',
    `owner_email` STRING COMMENT 'Email address of the campaign owner for communication and escalation purposes.',
    `owner_name` STRING COMMENT 'Name of the business owner or marketing manager responsible for the campaign.',
    `priority_level` STRING COMMENT 'Business priority assigned to the campaign for resource allocation and execution sequencing.',
    `product_offering` STRING COMMENT 'Banking product or service being promoted through the campaign (e.g., credit card, mortgage, savings account).',
    `reached_count` BIGINT COMMENT 'Number of customers or prospects successfully reached by campaign communications.',
    `region` STRING COMMENT 'Geographic region or market where the campaign is executed.',
    `response_count` BIGINT COMMENT 'Number of customers or prospects who responded to the campaign.',
    `start_date` DATE COMMENT 'Date when the campaign becomes active and begins customer outreach.',
    `tags` STRING COMMENT 'Comma-separated list of business tags or labels for campaign categorization and filtering.',
    `target_audience_size` BIGINT COMMENT 'Total number of customers or prospects targeted by the campaign.',
    `target_segment` STRING COMMENT 'Description of the customer segment or audience targeted by this campaign.',
    `test_control_flag` BOOLEAN COMMENT 'Indicates whether the campaign includes a test/control group design for effectiveness measurement.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Master reference table for campaign. Referenced by campaign_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`override_approval` (
    `override_approval_id` BIGINT COMMENT 'Primary key for override_approval',
    `deposit_account_id` BIGINT COMMENT 'Identifier of the specific account involved in the override request, if applicable.',
    `approver_user_employee_id` BIGINT COMMENT 'Identifier of the user who is assigned to or has approved/rejected this override request.',
    `channel_id` BIGINT COMMENT 'Identifier of the customer interaction channel through which the override request was initiated.',
    `delegated_from_user_employee_id` BIGINT COMMENT 'Identifier of the original approver who delegated their authority, if delegation occurred.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who initiated the override request requiring approval.',
    `override_request_id` BIGINT COMMENT 'Reference to the original override request that triggered this approval workflow.',
    `party_id` BIGINT COMMENT 'Identifier of the customer associated with the transaction or account requiring the override approval.',
    `account_transaction_id` BIGINT COMMENT 'Identifier of the specific transaction that triggered the override requirement, if applicable.',
    `previous_override_approval_id` BIGINT COMMENT 'Self-referencing FK on override_approval (previous_override_approval_id)',
    `actual_turnaround_hours` DECIMAL(18,2) COMMENT 'Actual elapsed time in hours from request submission to approval decision.',
    `approval_comments` STRING COMMENT 'Free-text comments provided by the approver explaining their decision rationale or conditions.',
    `approval_decision` STRING COMMENT 'The final decision rendered by the approver on the override request.',
    `approval_decision_timestamp` TIMESTAMP COMMENT 'Date and time when the approver made their decision on the override request.',
    `approval_level` STRING COMMENT 'Numeric indicator of the approval hierarchy level (1=first level, 2=second level, etc.) required for this override.',
    `approval_reference_number` STRING COMMENT 'Externally visible unique reference number for this override approval, used for audit trails and customer communication.',
    `approval_source_system` STRING COMMENT 'Name of the system or application from which the override approval was processed.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the override approval request.',
    `approved_limit_value` DECIMAL(18,2) COMMENT 'The new limit or threshold value approved through this override, if applicable.',
    `approver_role` STRING COMMENT 'The organizational role or authority level of the approver (e.g., Branch Manager, Regional Director, Chief Credit Officer).',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether enhanced audit trail documentation is required for this override approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this override approval record was first created in the system.',
    `delegation_flag` BOOLEAN COMMENT 'Indicates whether the approval authority was delegated from another user or role.',
    `effective_from_timestamp` TIMESTAMP COMMENT 'Date and time when the override approval becomes effective and can be applied.',
    `effective_until_timestamp` TIMESTAMP COMMENT 'Date and time when the override approval ceases to be valid.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the override request was escalated to a higher approval authority, if applicable.',
    `expiry_date` DATE COMMENT 'Date on which this override approval expires and is no longer valid, if time-limited.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this override approval record was last updated.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether notification of the approval decision has been sent to relevant parties.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the approval decision notification was sent.',
    `original_limit_value` DECIMAL(18,2) COMMENT 'The original policy limit or threshold that was breached, requiring the override approval.',
    `override_amount` DECIMAL(18,2) COMMENT 'Monetary value associated with the override (e.g., amount exceeding limit, fee being waived, pricing adjustment).',
    `override_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the override amount.',
    `override_reason_code` STRING COMMENT 'Standardized code representing the business reason for the override request.',
    `override_reason_description` STRING COMMENT 'Detailed textual explanation of why the override was requested and the business justification.',
    `override_type` STRING COMMENT 'Classification of the type of override being approved (e.g., limit breach, policy exception, pricing override).',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicates whether this override has potential regulatory reporting or compliance implications.',
    `request_submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the override request was originally submitted for approval.',
    `risk_rating` STRING COMMENT 'Assessment of the risk level associated with approving this override.',
    `service_level_agreement_hours` STRING COMMENT 'Target number of hours within which the override approval decision should be made per service level agreement.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the approval decision exceeded the defined service level agreement timeframe.',
    CONSTRAINT pk_override_approval PRIMARY KEY(`override_approval_id`)
) COMMENT 'Master reference table for override_approval. Referenced by override_approval_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`journey_template` (
    `journey_template_id` BIGINT COMMENT 'Primary key for journey_template',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this journey template for production deployment.',
    `previous_journey_template_id` BIGINT COMMENT 'Self-referencing FK on journey_template (previous_journey_template_id)',
    `abandonment_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of journey instances based on this template that were abandoned by customers before completion.',
    `accessibility_compliant` BOOLEAN COMMENT 'Indicates whether this journey template meets accessibility standards for customers with disabilities (e.g., WCAG 2.1).',
    `api_integration_enabled` BOOLEAN COMMENT 'Indicates whether this journey template supports API or open banking integration for third-party access.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this journey template was approved for production use by authorized personnel.',
    `authentication_method` STRING COMMENT 'Required authentication method for this journey (e.g., biometric, OTP, password, multi-factor).',
    `authentication_required` BOOLEAN COMMENT 'Indicates whether customer authentication is required to initiate this journey.',
    `average_completion_minutes` DECIMAL(18,2) COMMENT 'Average actual time in minutes taken by customers to complete journeys based on this template.',
    `channel_type` STRING COMMENT 'Primary channel through which this journey template is delivered to customers.',
    `compliance_framework` STRING COMMENT 'Applicable regulatory compliance frameworks that govern this journey template (e.g., KYC, AML, GDPR, PCI-DSS).',
    `consent_required` BOOLEAN COMMENT 'Indicates whether explicit customer consent is required during this journey for data processing or marketing purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this journey template record was first created in the system.',
    `customer_segment` STRING COMMENT 'Target customer segment for which this journey template is designed.',
    `journey_template_description` STRING COMMENT 'Detailed description of the journey template including its intended use, target customer segments, and business objectives.',
    `digital_signature_required` BOOLEAN COMMENT 'Indicates whether digital signature or electronic signature is required for legal binding in this journey.',
    `effective_from_date` DATE COMMENT 'Date from which this journey template version becomes active and available for use.',
    `effective_to_date` DATE COMMENT 'Date until which this journey template version remains active. Null indicates no expiration.',
    `estimated_duration_minutes` STRING COMMENT 'Expected time in minutes for a customer to complete the journey based on this template.',
    `journey_stage_count` STRING COMMENT 'Total number of stages or steps defined in this journey template.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this journey template record was last updated or modified.',
    `multi_language_supported` BOOLEAN COMMENT 'Indicates whether this journey template supports multiple languages for international or diverse customer bases.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this journey template for operational reference.',
    `omnichannel_enabled` BOOLEAN COMMENT 'Indicates whether this journey template supports omnichannel orchestration allowing customers to switch channels mid-journey.',
    `owner_business_unit` STRING COMMENT 'Business unit or department responsible for maintaining and governing this journey template.',
    `personalization_enabled` BOOLEAN COMMENT 'Indicates whether this journey template supports dynamic personalization based on customer data and behavior.',
    `priority_level` STRING COMMENT 'Business priority level assigned to this journey template for resource allocation and service delivery.',
    `product_category` STRING COMMENT 'Banking product category associated with this journey template (e.g., deposits, loans, cards, investments, payments).',
    `regulatory_compliance_required` BOOLEAN COMMENT 'Indicates whether this journey template includes mandatory regulatory compliance steps (e.g., KYC, AML, disclosure requirements).',
    `sla_target_minutes` STRING COMMENT 'Target service level agreement time in minutes for journey completion as defined by business policy.',
    `journey_template_status` STRING COMMENT 'Current lifecycle status of the journey template indicating its availability for use.',
    `success_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of journey instances based on this template that were successfully completed by customers.',
    `supported_languages` STRING COMMENT 'Comma-separated list of ISO 639-1 language codes supported by this journey template (e.g., en, es, fr, de).',
    `tags` STRING COMMENT 'Comma-separated list of business tags or keywords for categorization, search, and filtering of journey templates.',
    `template_code` STRING COMMENT 'Business-readable unique code for the journey template used for external reference and integration.',
    `template_name` STRING COMMENT 'Human-readable name of the journey template describing its purpose and use case.',
    `template_type` STRING COMMENT 'Classification of the journey template by its primary business purpose.',
    `usage_count` BIGINT COMMENT 'Total number of times this journey template has been instantiated or used by customers.',
    `version_number` STRING COMMENT 'Semantic version number of the journey template following major.minor.patch format for change tracking.',
    CONSTRAINT pk_journey_template PRIMARY KEY(`journey_template_id`)
) COMMENT 'Master reference table for journey_template. Referenced by template_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`third_party_provider` (
    `third_party_provider_id` BIGINT COMMENT 'Primary key for third_party_provider',
    `parent_third_party_provider_id` BIGINT COMMENT 'Self-referencing FK on third_party_provider (parent_third_party_provider_id)',
    `api_integration_method` STRING COMMENT 'Technical integration method used to connect with the third party providers services.',
    `business_continuity_plan_flag` BOOLEAN COMMENT 'Indicates whether the third party provider has a documented and tested business continuity plan.',
    `certification_expiry_date` DATE COMMENT 'Expiration date of the third party providers current certification.',
    `certification_type` STRING COMMENT 'Type of industry certifications held by the third party provider (e.g., ISO 27001, SOC 2, PCI DSS).',
    `compliance_status` STRING COMMENT 'Current compliance status of the third party provider with respect to regulatory and contractual requirements.',
    `contract_end_date` DATE COMMENT 'Scheduled end date of the contractual relationship with the third party provider. Null for open-ended contracts.',
    `contract_renewal_date` DATE COMMENT 'Next scheduled date for contract renewal review with the third party provider.',
    `contract_start_date` DATE COMMENT 'Effective start date of the contractual relationship with the third party provider.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this third party provider record was first created in the system.',
    `data_processing_agreement_flag` BOOLEAN COMMENT 'Indicates whether a formal data processing agreement is in place with the third party provider.',
    `data_residency_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating where the third party provider stores and processes data.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Total insurance coverage amount held by the third party provider for liability and operational risks.',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit or assessment conducted on the third party provider.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this third party provider record was last updated in the system.',
    `legal_entity_identifier` STRING COMMENT 'ISO 17442 compliant Legal Entity Identifier for the third party provider, enabling global identification in financial transactions.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next audit or assessment of the third party provider.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the third party provider.',
    `onboarding_date` DATE COMMENT 'Date when the third party provider was onboarded and approved to provide services to the bank.',
    `payment_terms_days` STRING COMMENT 'Number of days within which payment is due to the third party provider from invoice date.',
    `preferred_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial transactions with the third party provider.',
    `primary_contact_email` STRING COMMENT 'Primary email address for operational communication with the third party provider.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the third party provider organization.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for contacting the third party provider.',
    `provider_code` STRING COMMENT 'Unique business identifier code assigned to the third party provider for operational reference.',
    `provider_name` STRING COMMENT 'The full legal name of the third party provider organization.',
    `provider_type` STRING COMMENT 'Classification of the third party provider based on the service category they provide to the bank.',
    `registered_address_line1` STRING COMMENT 'First line of the registered business address of the third party provider.',
    `registered_address_line2` STRING COMMENT 'Second line of the registered business address of the third party provider.',
    `registered_city` STRING COMMENT 'City of the registered business address of the third party provider.',
    `registered_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the registered business address of the third party provider.',
    `registered_postal_code` STRING COMMENT 'Postal or ZIP code of the registered business address of the third party provider.',
    `registered_state_province` STRING COMMENT 'State or province of the registered business address of the third party provider.',
    `registration_number` STRING COMMENT 'Official business registration or incorporation number of the third party provider as issued by the relevant government authority.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the third party provider based on vendor risk assessment.',
    `service_category` STRING COMMENT 'Primary service category offered by the third party provider.',
    `service_level_agreement_tier` STRING COMMENT 'Service level agreement tier defining the performance and support commitments from the third party provider.',
    `third_party_provider_status` STRING COMMENT 'Current lifecycle status of the third party provider relationship with the bank.',
    `tax_identification_number` STRING COMMENT 'Tax identification number of the third party provider as registered with the tax authority in their jurisdiction.',
    `termination_notice_period_days` STRING COMMENT 'Number of days notice required to terminate the contract with the third party provider.',
    `uptime_commitment_percentage` DECIMAL(18,2) COMMENT 'Contractually committed uptime percentage for services provided by the third party provider.',
    `website_url` STRING COMMENT 'Official website URL of the third party provider.',
    CONSTRAINT pk_third_party_provider PRIMARY KEY(`third_party_provider_id`)
) COMMENT 'Master reference table for third_party_provider. Referenced by third_party_provider_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`channel`.`override_request` (
    `override_request_id` BIGINT COMMENT 'Primary key for override_request',
    `previous_override_request_id` BIGINT COMMENT 'Self-referencing FK on override_request (previous_override_request_id)',
    `account_id` BIGINT COMMENT 'Identifier of the account associated with the override request, if applicable.',
    `actual_resolution_minutes` STRING COMMENT 'Actual time in minutes taken to resolve the override request from submission to final decision.',
    `approval_comments` STRING COMMENT 'Comments or notes provided by the approver explaining the approval or rejection decision.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the override request was approved or rejected.',
    `approved_by_role` STRING COMMENT 'Job role or position of the user who approved the override (e.g., branch manager, operations manager, compliance officer, senior manager).',
    `approved_by_user_id` BIGINT COMMENT 'Identifier of the authorized user who approved the override request, if applicable.',
    `approved_limit_value` DECIMAL(18,2) COMMENT 'The final approved limit or threshold value after override approval, which may differ from the requested value.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit trail records for this override request, capturing all state changes and actions.',
    `channel_id` BIGINT COMMENT 'Identifier of the channel through which the override request was initiated (e.g., mobile banking, branch, ATM, contact center).',
    `compliance_review_required` BOOLEAN COMMENT 'Indicates whether the override request requires review by the compliance department before approval.',
    `compliance_review_status` STRING COMMENT 'Status of the compliance review process for this override request (e.g., not required, pending, approved, rejected).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the override request record was first created in the database.',
    `customer_id` BIGINT COMMENT 'Identifier of the customer on whose behalf the override request is being made.',
    `effective_end_timestamp` TIMESTAMP COMMENT 'Date and time when the approved override expires and is no longer valid. Null indicates indefinite validity.',
    `effective_start_timestamp` TIMESTAMP COMMENT 'Date and time when the approved override becomes effective and can be applied.',
    `escalation_level` STRING COMMENT 'Number indicating how many levels the override request has been escalated in the approval hierarchy (0 = no escalation).',
    `expiration_duration_days` STRING COMMENT 'Number of days the override remains valid from the effective start date, if time-limited.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the override request record was last updated in the database.',
    `original_limit_value` DECIMAL(18,2) COMMENT 'The original limit or threshold value before the override (e.g., transaction limit, withdrawal limit, credit limit).',
    `override_amount` DECIMAL(18,2) COMMENT 'Monetary value associated with the override request (e.g., fee amount to be waived, limit increase amount, transaction amount requiring override).',
    `override_currency_code` STRING COMMENT 'Three-letter ISO currency code for the override amount (e.g., USD, EUR, GBP).',
    `override_reason_code` STRING COMMENT 'Standardized code representing the reason for the override request (e.g., customer relationship, system error, regulatory requirement).',
    `override_reason_description` STRING COMMENT 'Detailed textual explanation of why the override is being requested, provided by the requestor.',
    `override_type` STRING COMMENT 'Category of override being requested (e.g., transaction limit override, fee waiver, policy exception, authorization override, compliance override, credit decision override).',
    `priority_level` STRING COMMENT 'Priority classification of the override request indicating urgency of processing (e.g., low, medium, high, urgent, critical).',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this override must be included in regulatory reporting submissions.',
    `request_number` STRING COMMENT 'Business-facing unique reference number for the override request, used for tracking and communication.',
    `request_status` STRING COMMENT 'Current lifecycle status of the override request (e.g., pending, under review, approved, rejected, expired, withdrawn, escalated).',
    `requested_by_role` STRING COMMENT 'Job role or position of the user who requested the override (e.g., teller, relationship manager, branch manager, customer service representative).',
    `requested_by_user_id` BIGINT COMMENT 'Identifier of the bank employee or system user who initiated the override request.',
    `requested_limit_value` DECIMAL(18,2) COMMENT 'The new limit or threshold value being requested through the override.',
    `requested_timestamp` TIMESTAMP COMMENT 'Date and time when the override request was submitted into the system.',
    `requires_dual_authorization` BOOLEAN COMMENT 'Indicates whether the override request requires approval from two authorized users for enhanced control.',
    `risk_rating` STRING COMMENT 'Categorical risk rating assigned to the override request (e.g., low, medium, high, very high).',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score associated with granting this override, used for risk assessment and monitoring.',
    `secondary_approval_timestamp` TIMESTAMP COMMENT 'Date and time when the second approval was granted for dual-authorization overrides.',
    `secondary_approver_user_id` BIGINT COMMENT 'Identifier of the second authorized user who approved the override, if dual authorization is required.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the override request resolution exceeded the target SLA timeframe.',
    `sla_target_resolution_minutes` STRING COMMENT 'Target time in minutes within which the override request should be resolved according to service level agreements.',
    `transaction_id` BIGINT COMMENT 'Identifier of the transaction that triggered or is associated with the override request, if applicable.',
    CONSTRAINT pk_override_request PRIMARY KEY(`override_request_id`)
) COMMENT 'Master reference table for override_request. Referenced by override_request_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`channel`.`atm` ADD CONSTRAINT `fk_channel_atm_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ADD CONSTRAINT `fk_channel_digital_channel_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`session` ADD CONSTRAINT `fk_channel_session_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_api_application_id` FOREIGN KEY (`api_application_id`) REFERENCES `banking_ecm`.`channel`.`api_application`(`api_application_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_atm_id` FOREIGN KEY (`atm_id`) REFERENCES `banking_ecm`.`channel`.`atm`(`atm_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_contact_center_id` FOREIGN KEY (`contact_center_id`) REFERENCES `banking_ecm`.`channel`.`contact_center`(`contact_center_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_override_approval_id` FOREIGN KEY (`override_approval_id`) REFERENCES `banking_ecm`.`channel`.`override_approval`(`override_approval_id`);
ALTER TABLE `banking_ecm`.`channel`.`interaction` ADD CONSTRAINT `fk_channel_interaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`channel`.`sla` ADD CONSTRAINT `fk_channel_sla_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`sla` ADD CONSTRAINT `fk_channel_sla_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`channel`.`sla` ADD CONSTRAINT `fk_channel_sla_sla_breach_id` FOREIGN KEY (`sla_breach_id`) REFERENCES `banking_ecm`.`channel`.`sla_breach`(`sla_breach_id`);
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ADD CONSTRAINT `fk_channel_sla_breach_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ADD CONSTRAINT `fk_channel_sla_breach_interaction_id` FOREIGN KEY (`interaction_id`) REFERENCES `banking_ecm`.`channel`.`interaction`(`interaction_id`);
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ADD CONSTRAINT `fk_channel_rm_client_assignment_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ADD CONSTRAINT `fk_channel_rm_client_assignment_tertiary_rm_channel_relationship_manager_id` FOREIGN KEY (`tertiary_rm_channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`channel`.`journey` ADD CONSTRAINT `fk_channel_journey_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`channel`.`journey` ADD CONSTRAINT `fk_channel_journey_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`journey` ADD CONSTRAINT `fk_channel_journey_journey_template_id` FOREIGN KEY (`journey_template_id`) REFERENCES `banking_ecm`.`channel`.`journey_template`(`journey_template_id`);
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ADD CONSTRAINT `fk_channel_journey_instance_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ADD CONSTRAINT `fk_channel_journey_instance_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ADD CONSTRAINT `fk_channel_journey_instance_journey_id` FOREIGN KEY (`journey_id`) REFERENCES `banking_ecm`.`channel`.`journey`(`journey_id`);
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ADD CONSTRAINT `fk_channel_journey_instance_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ADD CONSTRAINT `fk_channel_channel_incident_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_atm_id` FOREIGN KEY (`atm_id`) REFERENCES `banking_ecm`.`channel`.`atm`(`atm_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ADD CONSTRAINT `fk_channel_atm_transaction_original_transaction_atm_transaction_id` FOREIGN KEY (`original_transaction_atm_transaction_id`) REFERENCES `banking_ecm`.`channel`.`atm_transaction`(`atm_transaction_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ADD CONSTRAINT `fk_channel_branch_teller_transaction_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ADD CONSTRAINT `fk_channel_branch_teller_transaction_original_transaction_branch_teller_transaction_id` FOREIGN KEY (`original_transaction_branch_teller_transaction_id`) REFERENCES `banking_ecm`.`channel`.`branch_teller_transaction`(`branch_teller_transaction_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ADD CONSTRAINT `fk_channel_branch_teller_transaction_session_id` FOREIGN KEY (`session_id`) REFERENCES `banking_ecm`.`channel`.`session`(`session_id`);
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ADD CONSTRAINT `fk_channel_open_banking_consent_digital_channel_id` FOREIGN KEY (`digital_channel_id`) REFERENCES `banking_ecm`.`channel`.`digital_channel`(`digital_channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ADD CONSTRAINT `fk_channel_open_banking_consent_previous_consent_open_banking_consent_id` FOREIGN KEY (`previous_consent_open_banking_consent_id`) REFERENCES `banking_ecm`.`channel`.`open_banking_consent`(`open_banking_consent_id`);
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ADD CONSTRAINT `fk_channel_open_banking_consent_third_party_provider_id` FOREIGN KEY (`third_party_provider_id`) REFERENCES `banking_ecm`.`channel`.`third_party_provider`(`third_party_provider_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ADD CONSTRAINT `fk_channel_channel_alert_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `banking_ecm`.`channel`.`campaign`(`campaign_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ADD CONSTRAINT `fk_channel_channel_alert_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ADD CONSTRAINT `fk_channel_channel_alert_alert_template_id` FOREIGN KEY (`alert_template_id`) REFERENCES `banking_ecm`.`channel`.`alert_template`(`alert_template_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ADD CONSTRAINT `fk_channel_branch_appointment_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ADD CONSTRAINT `fk_channel_branch_appointment_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ADD CONSTRAINT `fk_channel_branch_appointment_rescheduled_from_appointment_id` FOREIGN KEY (`rescheduled_from_appointment_id`) REFERENCES `banking_ecm`.`channel`.`branch_appointment`(`branch_appointment_id`);
ALTER TABLE `banking_ecm`.`channel`.`preference` ADD CONSTRAINT `fk_channel_preference_channel_relationship_manager_id` FOREIGN KEY (`channel_relationship_manager_id`) REFERENCES `banking_ecm`.`channel`.`channel_relationship_manager`(`channel_relationship_manager_id`);
ALTER TABLE `banking_ecm`.`channel`.`preference` ADD CONSTRAINT `fk_channel_preference_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ADD CONSTRAINT `fk_channel_channel_product_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ADD CONSTRAINT `fk_channel_channel_product_previous_channel_product_id` FOREIGN KEY (`previous_channel_product_id`) REFERENCES `banking_ecm`.`channel`.`channel_product`(`channel_product_id`);
ALTER TABLE `banking_ecm`.`channel`.`queue` ADD CONSTRAINT `fk_channel_queue_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`channel`.`queue` ADD CONSTRAINT `fk_channel_queue_contact_center_id` FOREIGN KEY (`contact_center_id`) REFERENCES `banking_ecm`.`channel`.`contact_center`(`contact_center_id`);
ALTER TABLE `banking_ecm`.`channel`.`queue` ADD CONSTRAINT `fk_channel_queue_overflow_queue_id` FOREIGN KEY (`overflow_queue_id`) REFERENCES `banking_ecm`.`channel`.`queue`(`queue_id`);
ALTER TABLE `banking_ecm`.`channel`.`queue` ADD CONSTRAINT `fk_channel_queue_parent_queue_id` FOREIGN KEY (`parent_queue_id`) REFERENCES `banking_ecm`.`channel`.`queue`(`queue_id`);
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` ADD CONSTRAINT `fk_channel_branch_audit_scope_branch_id` FOREIGN KEY (`branch_id`) REFERENCES `banking_ecm`.`channel`.`branch`(`branch_id`);
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ADD CONSTRAINT `fk_channel_audit_scope_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` ADD CONSTRAINT `fk_channel_rule_configuration_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ADD CONSTRAINT `fk_channel_cost_allocation_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`alert_template` ADD CONSTRAINT `fk_channel_alert_template_previous_alert_template_id` FOREIGN KEY (`previous_alert_template_id`) REFERENCES `banking_ecm`.`channel`.`alert_template`(`alert_template_id`);
ALTER TABLE `banking_ecm`.`channel`.`campaign` ADD CONSTRAINT `fk_channel_campaign_parent_campaign_id` FOREIGN KEY (`parent_campaign_id`) REFERENCES `banking_ecm`.`channel`.`campaign`(`campaign_id`);
ALTER TABLE `banking_ecm`.`channel`.`override_approval` ADD CONSTRAINT `fk_channel_override_approval_channel_id` FOREIGN KEY (`channel_id`) REFERENCES `banking_ecm`.`channel`.`channel`(`channel_id`);
ALTER TABLE `banking_ecm`.`channel`.`override_approval` ADD CONSTRAINT `fk_channel_override_approval_override_request_id` FOREIGN KEY (`override_request_id`) REFERENCES `banking_ecm`.`channel`.`override_request`(`override_request_id`);
ALTER TABLE `banking_ecm`.`channel`.`override_approval` ADD CONSTRAINT `fk_channel_override_approval_previous_override_approval_id` FOREIGN KEY (`previous_override_approval_id`) REFERENCES `banking_ecm`.`channel`.`override_approval`(`override_approval_id`);
ALTER TABLE `banking_ecm`.`channel`.`journey_template` ADD CONSTRAINT `fk_channel_journey_template_previous_journey_template_id` FOREIGN KEY (`previous_journey_template_id`) REFERENCES `banking_ecm`.`channel`.`journey_template`(`journey_template_id`);
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ADD CONSTRAINT `fk_channel_third_party_provider_parent_third_party_provider_id` FOREIGN KEY (`parent_third_party_provider_id`) REFERENCES `banking_ecm`.`channel`.`third_party_provider`(`third_party_provider_id`);
ALTER TABLE `banking_ecm`.`channel`.`override_request` ADD CONSTRAINT `fk_channel_override_request_previous_override_request_id` FOREIGN KEY (`previous_override_request_id`) REFERENCES `banking_ecm`.`channel`.`override_request`(`override_request_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`channel` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `banking_ecm`.`channel` SET TAGS ('dbx_domain' = 'channel');
ALTER TABLE `banking_ecm`.`channel`.`channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`channel` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Identifier');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Bank Identifier Code (BIC)');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `swift_bic_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `third_party_provider` SET TAGS ('dbx_business_glossary_term' = 'Third Party Provider');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `third_party_provider` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `transaction_limit_daily` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Daily');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `transaction_limit_daily` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `transaction_limit_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Per Transaction');
ALTER TABLE `banking_ecm`.`channel`.`channel` ALTER COLUMN `transaction_limit_per_transaction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`branch` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Identifier');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Current Regulatory Exam Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `safe_deposit_box_count` SET TAGS ('dbx_business_glossary_term' = 'Safe Deposit Box Count');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `staff_capacity` SET TAGS ('dbx_business_glossary_term' = 'Staff Capacity');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `banking_ecm`.`channel`.`branch` ALTER COLUMN `wheelchair_accessible` SET TAGS ('dbx_business_glossary_term' = 'Wheelchair Accessible');
ALTER TABLE `banking_ecm`.`channel`.`atm` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`atm` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `atm_id` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) Identifier');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Identifier');
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
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'ATM Country Code');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `surcharge_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Currency Code');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `surcharge_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`atm` ALTER COLUMN `video_banking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Video Banking Enabled');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `digital_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Channel ID');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`digital_channel` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`channel`.`contact_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `contact_center_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Center ID');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `holiday_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Holiday Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `call_recording_policy` SET TAGS ('dbx_business_glossary_term' = 'Call Recording Policy');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `call_recording_policy` SET TAGS ('dbx_value_regex' = 'all_calls|sample|none|regulatory_only');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `center_code` SET TAGS ('dbx_business_glossary_term' = 'Contact Center Code');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `center_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Center Name');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `center_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Center Type');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `core_banking_integration_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Core Banking Integration Endpoint');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `crm_integration_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Integration Endpoint');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `ivr_menu_structure` SET TAGS ('dbx_business_glossary_term' = 'Interactive Voice Response (IVR) Menu Structure');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `ivr_tree_version` SET TAGS ('dbx_business_glossary_term' = 'Interactive Voice Response (IVR) Tree Version');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'physical|virtual|hybrid');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `operating_hours_friday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Friday');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `operating_hours_monday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Monday');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `operating_hours_saturday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Saturday');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `operating_hours_sunday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Sunday');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `operating_hours_thursday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Thursday');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `operating_hours_tuesday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Tuesday');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `operating_hours_wednesday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Wednesday');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `pci_dss_compliant` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Industry Data Security Standard (PCI-DSS) Compliant');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `pci_dss_scope` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Industry Data Security Standard (PCI-DSS) Scope');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `physical_address` SET TAGS ('dbx_business_glossary_term' = 'Physical Address');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `physical_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `physical_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `priority_rules` SET TAGS ('dbx_business_glossary_term' = 'Priority Rules');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `quality_monitoring_enabled` SET TAGS ('dbx_business_glossary_term' = 'Quality Monitoring Enabled');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `queue_routing_model` SET TAGS ('dbx_business_glossary_term' = 'Queue Routing Model');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `queue_routing_model` SET TAGS ('dbx_value_regex' = 'skill_based|priority_based|round_robin|least_occupied');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `sla_abandonment_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Abandonment Rate (Percent)');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `sla_average_handle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Average Handle Time (Seconds)');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `sla_average_speed_of_answer_seconds` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Average Speed of Answer (Seconds)');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `sla_first_call_resolution_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) First Call Resolution (Percent)');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `staffing_model` SET TAGS ('dbx_business_glossary_term' = 'Staffing Model');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `staffing_model` SET TAGS ('dbx_value_regex' = 'in_house|outsourced|blended');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `supported_languages` SET TAGS ('dbx_business_glossary_term' = 'Supported Languages');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `banking_ecm`.`channel`.`contact_center` ALTER COLUMN `workforce_management_system` SET TAGS ('dbx_business_glossary_term' = 'Workforce Management System');
ALTER TABLE `banking_ecm`.`channel`.`session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`channel`.`session` SET TAGS ('dbx_subdomain' = 'customer_interaction');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `continuous_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Continuous Monitoring Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Country Code');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`session` ALTER COLUMN `geolocation_country_code` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `banking_ecm`.`channel`.`interaction` SET TAGS ('dbx_subdomain' = 'customer_interaction');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Identifier');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `api_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Client Application ID');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `atm_id` SET TAGS ('dbx_business_glossary_term' = 'Atm Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager (RM) ID');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `contact_center_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Center Agent ID');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `interaction_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Teller ID');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `interaction_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `interaction_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `override_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Override Approval ID');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `api_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `api_payload_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Payload Size in Bytes');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `api_response_code` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Response Code');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `atm_authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) Authorization Code');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `atm_cash_dispensed_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) Cash Dispensed Flag');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `atm_response_code` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) Response Code');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `atm_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) Surcharge Amount');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `branch_location_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Location Code');
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
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`interaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`sla` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`sla` SET TAGS ('dbx_subdomain' = 'risk_compliance');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Identifier');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction Reference ID');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `sla_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Breach Event ID');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `actual_resolution_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Time (Minutes)');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `actual_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Response Time (Minutes)');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `breach_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Breach Penalty Amount');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `breach_penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `breach_penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Breach Penalty Currency Code');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `breach_penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `breach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `breach_type` SET TAGS ('dbx_business_glossary_term' = 'Breach Type');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `breach_type` SET TAGS ('dbx_value_regex' = 'response_time|resolution_time|escalation');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'digital_banking_mobile|digital_banking_web|branch|atm|contact_center|relationship_manager');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `customer_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Assessment');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `escalation_threshold_minutes` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold (Minutes)');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `interaction_category` SET TAGS ('dbx_business_glossary_term' = 'Interaction Category');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `interaction_category` SET TAGS ('dbx_value_regex' = 'account_inquiry|loan_application|wire_transfer|complaint|payment_processing|service_request');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `regulator_case_number` SET TAGS ('dbx_business_glossary_term' = 'Regulator Case Number');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `remediation_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Taken');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `reported_to_regulator_flag` SET TAGS ('dbx_business_glossary_term' = 'Reported to Regulator Flag');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `responsible_channel` SET TAGS ('dbx_business_glossary_term' = 'Responsible Channel');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'system_outage|staffing_shortage|process_failure|high_volume|training_gap|third_party_delay');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Status');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `target_resolution_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Time (Minutes)');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `target_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Target Response Time (Minutes)');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `banking_ecm`.`channel`.`sla` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` SET TAGS ('dbx_subdomain' = 'risk_compliance');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `sla_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach ID');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Interaction ID');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee ID');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `breach_id` SET TAGS ('dbx_business_glossary_term' = 'Related Compliance Breach Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `actual_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Metric Value');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `breach_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Breach Reference Number');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'open|under_review|remediated|closed|escalated|pending_approval');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `breach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `breach_type` SET TAGS ('dbx_business_glossary_term' = 'Breach Type');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `breach_type` SET TAGS ('dbx_value_regex' = 'response_time|resolution_time|escalation_time|acknowledgment_time|callback_time|processing_time');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `business_line` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `channel_sla_id` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Definition ID');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `compensation_offered_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Offered Flag');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `compensation_offered_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `compensation_offered_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `customer_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Assessment');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `customer_impact_assessment` SET TAGS ('dbx_value_regex' = 'no_impact|low_impact|moderate_impact|high_impact|critical_impact');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `customer_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notified Flag');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detected Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `deviation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Deviation Percentage');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `deviation_value` SET TAGS ('dbx_business_glossary_term' = 'Deviation Value');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Metric Unit of Measure');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `metric_unit` SET TAGS ('dbx_value_regex' = 'seconds|minutes|hours|business_days|calendar_days');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `regulatory_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submission Date');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `regulatory_report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Flag');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `remediation_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Taken');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `remediation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remediation Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'system_outage|high_volume|staff_shortage|process_failure|technical_issue|third_party_delay');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `banking_ecm`.`channel`.`sla_breach` ALTER COLUMN `target_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Value');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` SET TAGS ('dbx_subdomain' = 'customer_interaction');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Relationship Manager ID');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Aum Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `assigned_branch_code` SET TAGS ('dbx_business_glossary_term' = 'Assigned Branch Code');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `assigned_branch_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `aum_under_management` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM)');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `aum_under_management` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `certification_list` SET TAGS ('dbx_business_glossary_term' = 'Professional Certifications');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `channel_relationship_manager_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Status');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `channel_relationship_manager_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|terminated|retired|suspended|transferred');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `client_count` SET TAGS ('dbx_business_glossary_term' = 'Client Count');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_business_glossary_term' = 'Compensation Grade');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `compensation_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|pending_review|non_compliant|exempted');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `coverage_region` SET TAGS ('dbx_business_glossary_term' = 'Coverage Region');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Full Name');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `incentive_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Incentive Eligible Flag');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `language_proficiency` SET TAGS ('dbx_business_glossary_term' = 'Language Proficiency');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `licensed_products` SET TAGS ('dbx_business_glossary_term' = 'Licensed Products');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `lob_assignment` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Assignment');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `lob_assignment` SET TAGS ('dbx_value_regex' = 'commercial_banking|wealth_management|investment_banking|private_banking|corporate_banking|retail_banking');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `performance_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `portfolio_tier` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Tier');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `portfolio_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|emerging|institutional');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `revenue_target` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `revenue_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `specialization` SET TAGS ('dbx_business_glossary_term' = 'Industry Specialization');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary_resignation|retirement|involuntary_termination|transfer|end_of_contract|other');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `termination_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_relationship_manager` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` SET TAGS ('dbx_subdomain' = 'customer_interaction');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `rm_client_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager (RM) Client Assignment ID');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Team ID');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Successor Relationship Manager (RM) ID');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `tertiary_rm_channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Relationship Manager (RM) ID');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approval Date');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approved By');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_channel` SET TAGS ('dbx_business_glossary_term' = 'Assignment Channel');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_channel` SET TAGS ('dbx_value_regex' = 'branch|contact_center|digital|mobile|relationship_manager|api');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Assignment Modified By');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low|strategic|standard');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('dbx_value_regex' = 'new_client|portfolio_rebalance|rm_departure|client_request|geographic_realignment|specialization_match');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source System');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|coverage|backup|specialist|advisory');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `aum_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) at Assignment');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `aum_at_assignment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `aum_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Assets Under Management (AUM) Currency Code');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `aum_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `client_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Client Satisfaction Score');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `client_satisfaction_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `client_tenure_months` SET TAGS ('dbx_business_glossary_term' = 'Client Tenure Months');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|not_required|under_review');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `conflict_of_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Flag');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coverage Percentage');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `cross_sell_opportunities` SET TAGS ('dbx_business_glossary_term' = 'Cross-Sell Opportunities');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `cross_sell_opportunities` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `handoff_notes` SET TAGS ('dbx_business_glossary_term' = 'Handoff Notes');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `handoff_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `is_primary_rm` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Relationship Manager (RM)');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'retail_banking|private_banking|wealth_management|investment_banking|commercial_banking|corporate_banking');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `portfolio_segment` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Segment');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `portfolio_segment` SET TAGS ('dbx_value_regex' = 'mass_affluent|high_net_worth|ultra_high_net_worth|institutional|corporate|small_business');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `record_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Record Effective Date');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `record_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Record Expiration Date');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_business_glossary_term' = 'Relationship Health Score');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `relationship_health_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `revenue_attributed` SET TAGS ('dbx_business_glossary_term' = 'Revenue Attributed');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `revenue_attributed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Currency Code');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `service_model` SET TAGS ('dbx_business_glossary_term' = 'Service Model');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `service_model` SET TAGS ('dbx_value_regex' = 'dedicated|shared|team_based|digital_first|hybrid');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `sla_target_response_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Response Hours');
ALTER TABLE `banking_ecm`.`channel`.`rm_client_assignment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `banking_ecm`.`channel`.`journey` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`journey` SET TAGS ('dbx_subdomain' = 'customer_interaction');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `journey_id` SET TAGS ('dbx_business_glossary_term' = 'Journey Identifier');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager ID');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Current Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `journey_template_id` SET TAGS ('dbx_business_glossary_term' = 'Journey Template ID');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `abandonment_flag` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Flag');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `abandonment_stage` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Stage');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `abandonment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `active_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Active Duration (Minutes)');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `application_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Application Reference Number');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `channel_scope` SET TAGS ('dbx_business_glossary_term' = 'Channel Scope');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `channel_scope` SET TAGS ('dbx_value_regex' = 'omnichannel|digital_only|branch_only|contact_center_only|relationship_manager_only|hybrid');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `channel_switch_count` SET TAGS ('dbx_business_glossary_term' = 'Channel Switch Count');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `current_stage` SET TAGS ('dbx_business_glossary_term' = 'Current Journey Stage');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `current_stage_entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Current Stage Entry Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `current_stage_sequence` SET TAGS ('dbx_business_glossary_term' = 'Current Stage Sequence Number');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `customer_feedback` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `expected_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Completion Date');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `initiated_channel` SET TAGS ('dbx_business_glossary_term' = 'Initiated Channel');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `journey_name` SET TAGS ('dbx_business_glossary_term' = 'Journey Name');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `journey_status` SET TAGS ('dbx_business_glossary_term' = 'Journey Status');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `journey_type` SET TAGS ('dbx_business_glossary_term' = 'Journey Type');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `last_activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `nps_collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'NPS Collection Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Journey Outcome');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'successful|unsuccessful|abandoned|cancelled|expired|pending_review');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `product_applied_for` SET TAGS ('dbx_business_glossary_term' = 'Product Applied For');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `session_count` SET TAGS ('dbx_business_glossary_term' = 'Session Count');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Met Flag');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target (Minutes)');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Journey Start Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `total_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Total Journey Duration (Minutes)');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `total_stages` SET TAGS ('dbx_business_glossary_term' = 'Total Journey Stages');
ALTER TABLE `banking_ecm`.`channel`.`journey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` SET TAGS ('dbx_subdomain' = 'customer_interaction');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `journey_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Journey Instance Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Initial Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `journey_id` SET TAGS ('dbx_business_glossary_term' = 'Journey Template Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `abandonment_flag` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Flag');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `abandonment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Reason Code');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `abandonment_stage_code` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Stage Code');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `active_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Active Duration (Seconds)');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `channel_switch_count` SET TAGS ('dbx_business_glossary_term' = 'Channel Switch Count');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `cltv_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Lifetime Value (CLTV) Segment');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `cltv_segment` SET TAGS ('dbx_value_regex' = 'high|medium|low|unknown');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `current_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Current Channel Code');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `current_stage_code` SET TAGS ('dbx_business_glossary_term' = 'Current Stage Code');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `current_stage_entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Current Stage Entry Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `current_stage_name` SET TAGS ('dbx_business_glossary_term' = 'Current Stage Name');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `customer_feedback_text` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback Text');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `customer_feedback_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `customer_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Code');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'desktop|mobile|tablet|kiosk|atm|unknown');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Journey End Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `error_count` SET TAGS ('dbx_business_glossary_term' = 'Error Count');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `final_outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Final Outcome Code');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `final_outcome_code` SET TAGS ('dbx_value_regex' = 'success|failure|partial|abandoned|expired');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `final_outcome_description` SET TAGS ('dbx_business_glossary_term' = 'Final Outcome Description');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `journey_name` SET TAGS ('dbx_business_glossary_term' = 'Journey Name');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `journey_status` SET TAGS ('dbx_business_glossary_term' = 'Journey Status');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `journey_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|abandoned|suspended|failed');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `nps_collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) Collection Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `referral_source_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Source Code');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `sla_target_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Duration (Seconds)');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `stage_count` SET TAGS ('dbx_business_glossary_term' = 'Stage Count');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Journey Start Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`journey_instance` ALTER COLUMN `total_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Total Journey Duration (Seconds)');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` SET TAGS ('dbx_subdomain' = 'risk_compliance');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `channel_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Incident ID');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Engineer Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `affected_channel_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Channel Count');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `affected_location_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Location Count');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `assigned_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `channel_incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `communication_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Communication Sent Flag');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `customer_impact_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Count');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detected Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `escalated_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalated Flag');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{8}$');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'atm_outage|mobile_app_downtime|web_banking_downtime|branch_closure|contact_center_failure|api_gateway_disruption');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `post_incident_review_date` SET TAGS ('dbx_business_glossary_term' = 'Post-Incident Review Date');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `post_incident_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Incident Review Required Flag');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `post_incident_review_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Incident Review Status');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `post_incident_review_status` SET TAGS ('dbx_value_regex' = 'not_required|scheduled|in_progress|completed|cancelled');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'p1|p2|p3|p4');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `regulatory_report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Flag');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolved Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `rpo_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Recovery Point Objective (RPO) Met Flag');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `rpo_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Recovery Point Objective (RPO) Target Minutes');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `rto_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Recovery Time Objective (RTO) Met Flag');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `rto_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Recovery Time Objective (RTO) Target Minutes');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `time_to_acknowledge_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time to Acknowledge Minutes');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `time_to_detect_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time to Detect Minutes');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `time_to_resolve_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time to Resolve Minutes');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `transaction_impact_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Impact Count');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `workaround_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Workaround Applied Flag');
ALTER TABLE `banking_ecm`.`channel`.`channel_incident` ALTER COLUMN `workaround_description` SET TAGS ('dbx_business_glossary_term' = 'Workaround Description');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `atm_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) Transaction ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `atm_id` SET TAGS ('dbx_business_glossary_term' = 'Automated Teller Machine (ATM) ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `card_id` SET TAGS ('dbx_business_glossary_term' = 'Card ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Session ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `issuer_institution_legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Institution ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `issuer_institution_legal_entity_id` SET TAGS ('dbx_value_regex' = '^[0-9]{6,11}$');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Institution ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_value_regex' = '^[0-9]{6,11}$');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `original_transaction_atm_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
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
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12,20}$');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'approved|declined|reversed|pending|timeout|cancelled');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`channel`.`atm_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `branch_teller_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Teller Transaction ID');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `workpaper_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Workpaper Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch ID');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `original_transaction_branch_teller_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Teller ID');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Amount');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Account Number');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `beneficiary_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `check_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Check Routing Number');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `check_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `check_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `check_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `ctr_threshold_flag` SET TAGS ('dbx_business_glossary_term' = 'Currency Transaction Report (CTR) Threshold Flag');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `customer_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Identification Number');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `customer_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `customer_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `customer_identification_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Identification Type');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `customer_identification_type` SET TAGS ('dbx_value_regex' = 'drivers_license|passport|national_id|military_id|other');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange (FX) Rate');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `override_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Required Flag');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `safe_deposit_box_number` SET TAGS ('dbx_business_glossary_term' = 'Safe Deposit Box Number');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `transaction_channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `transaction_channel` SET TAGS ('dbx_value_regex' = 'branch_teller|drive_through|video_teller|mobile_branch');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'completed|pending|reversed|cancelled|failed');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `wire_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Wire Reference Number');
ALTER TABLE `banking_ecm`.`channel`.`branch_teller_transaction` ALTER COLUMN `workstation_code` SET TAGS ('dbx_business_glossary_term' = 'Workstation ID');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` SET TAGS ('dbx_subdomain' = 'risk_compliance');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `open_banking_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Open Banking Consent ID');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `digital_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reviewer ID');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `previous_consent_open_banking_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Consent ID');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `third_party_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Provider (TPP) ID');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `access_count` SET TAGS ('dbx_business_glossary_term' = 'Access Count');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `access_frequency_limit` SET TAGS ('dbx_business_glossary_term' = 'Access Frequency Limit');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `account_scope` SET TAGS ('dbx_business_glossary_term' = 'Account Scope');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication (SCA) Method');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `compliance_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `consent_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Channel');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `consent_channel` SET TAGS ('dbx_value_regex' = 'mobile_app|web_portal|branch|contact_center|api');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `consent_language_code` SET TAGS ('dbx_business_glossary_term' = 'Consent Language Code');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `consent_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Number');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `consent_scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'pending|active|expired|revoked|suspended|rejected');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'account_information|payment_initiation|funds_confirmation|identity_verification|combined');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `customer_consent_confirmation_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Consent Confirmation Code');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `customer_device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Customer Device ID');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `customer_device_fingerprint` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `customer_device_fingerprint` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `customer_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Customer IP Address');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `customer_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `customer_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `data_access_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Access Log Reference');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `grant_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Grant Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `last_access_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Access Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `notification_preference` SET TAGS ('dbx_value_regex' = 'email|sms|push|none');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `recurring_access_indicator` SET TAGS ('dbx_business_glossary_term' = 'Recurring Access Indicator');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'psd2|cfpb_1033|cdr|open_banking_uk|other');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `renewal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Renewal Indicator');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Revocation Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `tpp_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Provider (TPP) Certificate ID');
ALTER TABLE `banking_ecm`.`channel`.`open_banking_consent` ALTER COLUMN `transaction_history_period_days` SET TAGS ('dbx_business_glossary_term' = 'Transaction History Period (Days)');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` SET TAGS ('dbx_subdomain' = 'customer_interaction');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `channel_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Alert Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `monitoring_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Exception Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `alert_template_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Template Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `actual_send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Send Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `alert_category` SET TAGS ('dbx_business_glossary_term' = 'Alert Category');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `alert_category` SET TAGS ('dbx_value_regex' = 'operational|regulatory|marketing|risk|service');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Type');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `body` SET TAGS ('dbx_business_glossary_term' = 'Alert Body');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `customer_response` SET TAGS ('dbx_business_glossary_term' = 'Customer Response');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `customer_response` SET TAGS ('dbx_value_regex' = 'acknowledged|dismissed|clicked_link|called_bank|no_response');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivered Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `delivery_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Delivery Cost Amount');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `delivery_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Cost Currency Code');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `delivery_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `delivery_provider` SET TAGS ('dbx_business_glossary_term' = 'Delivery Provider');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `last_retry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Retry Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `opt_in_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Date');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `opt_in_status` SET TAGS ('dbx_business_glossary_term' = 'Opt-In Status');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `opt_in_status` SET TAGS ('dbx_value_regex' = 'opted_in|opted_out|default');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Date');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `personalization_applied` SET TAGS ('dbx_business_glossary_term' = 'Personalization Applied');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Alert Priority');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `provider_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Provider Message Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Read Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `recipient_address` SET TAGS ('dbx_business_glossary_term' = 'Recipient Address');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `recipient_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `recipient_address` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Alert Reference Number');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Flag');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `scheduled_send_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Send Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `sla_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Met Flag');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `sla_target_delivery_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Minutes');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Alert Subject');
ALTER TABLE `banking_ecm`.`channel`.`channel_alert` ALTER COLUMN `triggered_by_event` SET TAGS ('dbx_business_glossary_term' = 'Triggered By Event');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` SET TAGS ('dbx_subdomain' = 'customer_interaction');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `branch_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Appointment Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `rescheduled_from_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled From Appointment Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Assigned Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `actual_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Time');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration in Minutes');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `appointment_channel` SET TAGS ('dbx_business_glossary_term' = 'Appointment Channel');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `appointment_channel` SET TAGS ('dbx_value_regex' = 'walk_in|phone|web|mobile_app|email|relationship_manager');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `appointment_notes` SET TAGS ('dbx_business_glossary_term' = 'Appointment Notes');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `appointment_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `appointment_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appointment Outcome');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `appointment_outcome` SET TAGS ('dbx_value_regex' = 'successful|partially_completed|unsuccessful|customer_no_show|cancelled_by_customer|cancelled_by_bank');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `confirmation_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Sent Flag');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `confirmation_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Sent Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `customer_feedback` SET TAGS ('dbx_business_glossary_term' = 'Customer Feedback');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `customer_feedback` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `customer_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Score');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `follow_up_action` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `products_discussed` SET TAGS ('dbx_business_glossary_term' = 'Products Discussed');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `products_sold` SET TAGS ('dbx_business_glossary_term' = 'Products Sold');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `reminder_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Reminder Sent Flag');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `reminder_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reminder Sent Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Currency Code');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `revenue_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `revenue_generated_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Generated Amount');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `scheduled_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Duration in Minutes');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `sla_actual_wait_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Wait Time in Minutes');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `banking_ecm`.`channel`.`branch_appointment` ALTER COLUMN `sla_target_wait_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Wait Time in Minutes');
ALTER TABLE `banking_ecm`.`channel`.`preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`preference` SET TAGS ('dbx_subdomain' = 'customer_interaction');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Preference Identifier');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `channel_relationship_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Relationship Manager Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Branch Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `accessibility_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Requirement Flag');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `accessibility_requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Requirement Type');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `accessibility_requirement_type` SET TAGS ('dbx_value_regex' = 'visual|auditory|mobility|cognitive|speech|multiple');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `accessibility_requirement_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `audio_format_required` SET TAGS ('dbx_business_glossary_term' = 'Audio Format Required Flag');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `braille_required` SET TAGS ('dbx_business_glossary_term' = 'Braille Required Flag');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `branch_channel_preference_score` SET TAGS ('dbx_business_glossary_term' = 'Branch Channel Preference Score');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `consent_basis` SET TAGS ('dbx_business_glossary_term' = 'Consent Basis');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `consent_basis` SET TAGS ('dbx_value_regex' = 'explicit_consent|legitimate_interest|contractual_necessity|legal_obligation|vital_interest');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `consent_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Channel');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `consent_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Consent Internet Protocol (IP) Address');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `consent_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `digital_channel_preference_score` SET TAGS ('dbx_business_glossary_term' = 'Digital Channel Preference Score');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `inference_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Inference Confidence Score');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `inference_model_version` SET TAGS ('dbx_business_glossary_term' = 'Inference Model Version');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `large_print_required` SET TAGS ('dbx_business_glossary_term' = 'Large Print Required Flag');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `marketing_email_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Email Opt-In Flag');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `marketing_email_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `marketing_email_opt_in` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `marketing_mail_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Postal Mail Opt-In Flag');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `marketing_phone_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Phone Call Opt-In Flag');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `marketing_phone_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `marketing_phone_opt_in` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `marketing_sms_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Short Message Service (SMS) Opt-In Flag');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `next_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `notification_category_alerts` SET TAGS ('dbx_business_glossary_term' = 'Notification Category - Alerts Opt-In Flag');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `notification_category_payments` SET TAGS ('dbx_business_glossary_term' = 'Notification Category - Payments Opt-In Flag');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `notification_category_products` SET TAGS ('dbx_business_glossary_term' = 'Notification Category - Product Updates Opt-In Flag');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `notification_category_security` SET TAGS ('dbx_business_glossary_term' = 'Notification Category - Security Opt-In Flag');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `override_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Override Authorized By');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `preference_source` SET TAGS ('dbx_business_glossary_term' = 'Preference Source');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `preference_source` SET TAGS ('dbx_value_regex' = 'customer_stated|system_inferred|relationship_manager|onboarding|migration|third_party');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_business_glossary_term' = 'Preference Status');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `preference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_verification|expired');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `preference_type` SET TAGS ('dbx_business_glossary_term' = 'Preference Type');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `preference_type` SET TAGS ('dbx_value_regex' = 'contact_channel|communication|notification|service_delivery|accessibility|privacy');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Channel');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language Code');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `preferred_language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `statement_delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Statement Delivery Channel');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `statement_delivery_channel` SET TAGS ('dbx_value_regex' = 'electronic|paper|both|suppressed');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Statement Frequency');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `statement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|on_demand');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `transactional_email_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Transactional Email Opt-In Flag');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `transactional_email_opt_in` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `transactional_email_opt_in` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`preference` ALTER COLUMN `transactional_sms_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Transactional Short Message Service (SMS) Opt-In Flag');
ALTER TABLE `banking_ecm`.`channel`.`api_application` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`api_application` SET TAGS ('dbx_subdomain' = 'digital_experience');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `api_application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Application Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `account_information_service_enabled` SET TAGS ('dbx_business_glossary_term' = 'Account Information Service (AIS) Enabled Flag');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `api_product_subscriptions` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Product Subscriptions');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `application_code` SET TAGS ('dbx_business_glossary_term' = 'Application Code');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `application_name` SET TAGS ('dbx_business_glossary_term' = 'Application Name');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'pending_approval|active|suspended|revoked|expired|deactivated');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Application Type');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'third_party_provider|internal_application|partner_application|fintech_integration|aggregator|merchant_service');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `callback_url` SET TAGS ('dbx_business_glossary_term' = 'Callback Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `consent_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Consent Duration Days');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `data_access_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Access Scope');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `developer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Developer Contact Email Address');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `developer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `developer_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `developer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `developer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Developer Contact Phone Number');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `developer_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `developer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `developer_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Developer Organization Name');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `eidas_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Electronic Identification, Authentication and Trust Services (eIDAS) Certificate Expiry Date');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `eidas_certificate_issuer` SET TAGS ('dbx_business_glossary_term' = 'Electronic Identification, Authentication and Trust Services (eIDAS) Certificate Issuer');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `eidas_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Identification, Authentication and Trust Services (eIDAS) Certificate Reference');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `encryption_standard` SET TAGS ('dbx_business_glossary_term' = 'Encryption Standard');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `encryption_standard` SET TAGS ('dbx_value_regex' = 'TLS_1_2|TLS_1_3|MTLS');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `environment` SET TAGS ('dbx_business_glossary_term' = 'Environment');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `environment` SET TAGS ('dbx_value_regex' = 'sandbox|uat|production');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `funds_confirmation_service_enabled` SET TAGS ('dbx_business_glossary_term' = 'Funds Confirmation Service (FCS) Enabled Flag');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `ip_whitelist` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address Whitelist');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `ip_whitelist` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `oauth2_client_identifier` SET TAGS ('dbx_business_glossary_term' = 'OAuth 2.0 Client Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `oauth2_client_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `oauth2_client_secret_hash` SET TAGS ('dbx_business_glossary_term' = 'OAuth 2.0 Client Secret Hash');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `oauth2_client_secret_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `onboarding_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Approval Date');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `onboarding_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Approval Status');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `onboarding_approval_status` SET TAGS ('dbx_value_regex' = 'pending_review|approved|rejected|conditional_approval');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `onboarding_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Approved By');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `payment_initiation_service_enabled` SET TAGS ('dbx_business_glossary_term' = 'Payment Initiation Service (PIS) Enabled Flag');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `rate_limit_requests_per_day` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Requests Per Day');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `rate_limit_requests_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Requests Per Minute');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `rate_limit_tier` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Tier');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `rate_limit_tier` SET TAGS ('dbx_value_regex' = 'sandbox|basic|standard|premium|enterprise|unlimited');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `regulatory_registration_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Status');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `regulatory_registration_status` SET TAGS ('dbx_value_regex' = 'registered|pending|not_required|expired|revoked');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `sla_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Milliseconds');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `terms_of_service_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Terms of Service Accepted Date');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `terms_of_service_version` SET TAGS ('dbx_business_glossary_term' = 'Terms of Service Version');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `tpp_competent_authority` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Provider (TPP) Competent Authority');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `tpp_license_number` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Provider (TPP) License Number');
ALTER TABLE `banking_ecm`.`channel`.`api_application` ALTER COLUMN `webhook_url` SET TAGS ('dbx_business_glossary_term' = 'Webhook Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `channel_product_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Product ID');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `disclosure_template_id` SET TAGS ('dbx_business_glossary_term' = 'Disclosure Template ID');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `previous_channel_product_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `authentication_method_required` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method Required');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|unavailable|restricted|pilot|sunset');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `channel_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Channel Fee Amount');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `channel_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Fee Currency Code');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `channel_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `channel_specific_product_code` SET TAGS ('dbx_business_glossary_term' = 'Channel-Specific Product Code');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `configuration_parameters` SET TAGS ('dbx_business_glossary_term' = 'Configuration Parameters');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `cross_sell_priority` SET TAGS ('dbx_business_glossary_term' = 'Cross-Sell Priority');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `customer_segment_restriction` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Restriction');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `digital_experience_url` SET TAGS ('dbx_business_glossary_term' = 'Digital Experience Uniform Resource Locator (URL)');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `kyc_requirement_level` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Requirement Level');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `kyc_requirement_level` SET TAGS ('dbx_value_regex' = 'none|basic|standard|enhanced|full');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `marketing_campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign Code');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `regulatory_disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Disclosure Required');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `sla_response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Seconds');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `supports_account_opening` SET TAGS ('dbx_business_glossary_term' = 'Supports Account Opening');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `supports_closure` SET TAGS ('dbx_business_glossary_term' = 'Supports Closure');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `supports_servicing` SET TAGS ('dbx_business_glossary_term' = 'Supports Servicing');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `supports_transactions` SET TAGS ('dbx_business_glossary_term' = 'Supports Transactions');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `transaction_limit_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Currency Code');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `transaction_limit_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `transaction_limit_daily` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Daily');
ALTER TABLE `banking_ecm`.`channel`.`channel_product` ALTER COLUMN `transaction_limit_per_transaction` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Per Transaction');
ALTER TABLE `banking_ecm`.`channel`.`queue` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`queue` SET TAGS ('dbx_subdomain' = 'channel_operations');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `queue_id` SET TAGS ('dbx_business_glossary_term' = 'Queue Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `contact_center_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Center Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `overflow_queue_id` SET TAGS ('dbx_business_glossary_term' = 'Overflow Queue Identifier (ID)');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `parent_queue_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `abandonment_threshold_seconds` SET TAGS ('dbx_business_glossary_term' = 'Abandonment Threshold (Seconds)');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `agents_available` SET TAGS ('dbx_business_glossary_term' = 'Agents Available');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `agents_busy` SET TAGS ('dbx_business_glossary_term' = 'Agents Busy');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `agents_staffed` SET TAGS ('dbx_business_glossary_term' = 'Agents Staffed');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `average_handle_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Average Handle Time (Seconds)');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `callback_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Callback Enabled Flag');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `current_queue_depth` SET TAGS ('dbx_business_glossary_term' = 'Current Queue Depth');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `current_sla_compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Current Service Level Agreement (SLA) Compliance Percentage');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `current_wait_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Current Wait Time (Seconds)');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `customer_segment_restriction` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Restriction');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `estimated_wait_time_announcement_flag` SET TAGS ('dbx_business_glossary_term' = 'Estimated Wait Time Announcement Flag');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `language_support` SET TAGS ('dbx_business_glossary_term' = 'Language Support');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `max_queue_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Queue Capacity');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `music_on_hold_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Music on Hold Enabled Flag');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `operating_hours_end_time` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours End Time');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `operating_hours_start_time` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Start Time');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `quality_monitoring_sample_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Monitoring Sample Rate');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `queue_code` SET TAGS ('dbx_business_glossary_term' = 'Queue Code');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `queue_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `queue_name` SET TAGS ('dbx_business_glossary_term' = 'Queue Name');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `queue_status` SET TAGS ('dbx_business_glossary_term' = 'Queue Status');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `queue_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|maintenance');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `queue_type` SET TAGS ('dbx_business_glossary_term' = 'Queue Type');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `regulatory_recording_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Recording Required Flag');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `routing_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Routing Algorithm');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `routing_algorithm` SET TAGS ('dbx_value_regex' = 'fifo|priority|skill_based|longest_idle|round_robin');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `skill_group` SET TAGS ('dbx_business_glossary_term' = 'Skill Group');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `sla_target_answer_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Answer Time (Seconds)');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `sla_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Percentage');
ALTER TABLE `banking_ecm`.`channel`.`queue` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` SET TAGS ('dbx_subdomain' = 'risk_compliance');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` SET TAGS ('dbx_association_edges' = 'channel.branch,audit.engagement');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` ALTER COLUMN `branch_audit_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Audit Scope Identifier');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` ALTER COLUMN `branch_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Audit Scope - Branch Id');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Branch Audit Scope - Engagement Id');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` ALTER COLUMN `auditor_assigned` SET TAGS ('dbx_business_glossary_term' = 'Assigned Auditor');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` ALTER COLUMN `branch_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Branch Audit Status');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` ALTER COLUMN `branch_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Branch Risk Rating');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Count');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Audit Sample Size');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` ALTER COLUMN `scope_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope End Date');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` ALTER COLUMN `scope_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope Start Date');
ALTER TABLE `banking_ecm`.`channel`.`branch_audit_scope` ALTER COLUMN `updated_date` SET TAGS ('dbx_business_glossary_term' = 'Updated Date');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` SET TAGS ('dbx_subdomain' = 'risk_compliance');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` SET TAGS ('dbx_association_edges' = 'channel.channel,audit.engagement');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `audit_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Audit Scope Identifier');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Audit Scope - Banking Channel Id');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Audit Scope - Engagement Id');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `audit_hours_allocated` SET TAGS ('dbx_business_glossary_term' = 'Audit Hours Allocated');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `channel_audit_opinion` SET TAGS ('dbx_business_glossary_term' = 'Channel Audit Opinion');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `channel_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Channel Risk Rating');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Count');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `scope_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scope End Date');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `scope_inclusion_rationale` SET TAGS ('dbx_business_glossary_term' = 'Scope Inclusion Rationale');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `scope_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Start Date');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_business_glossary_term' = 'Scope Status');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `testing_approach` SET TAGS ('dbx_business_glossary_term' = 'Testing Approach');
ALTER TABLE `banking_ecm`.`channel`.`audit_scope` ALTER COLUMN `transaction_volume_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Transaction Volume Reviewed');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` SET TAGS ('dbx_subdomain' = 'risk_compliance');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` SET TAGS ('dbx_association_edges' = 'channel.channel,fraud.detection_rule');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` ALTER COLUMN `rule_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Rule Configuration ID');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Rule Configuration - Banking Channel Id');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` ALTER COLUMN `detection_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Rule Configuration - Detection Rule Id');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` ALTER COLUMN `alert_volume` SET TAGS ('dbx_business_glossary_term' = 'Alert Volume');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` ALTER COLUMN `channel_specific_threshold` SET TAGS ('dbx_business_glossary_term' = 'Channel Specific Threshold');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` ALTER COLUMN `configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` ALTER COLUMN `false_positive_rate` SET TAGS ('dbx_business_glossary_term' = 'False Positive Rate');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` ALTER COLUMN `last_tuning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Tuning Date');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `banking_ecm`.`channel`.`rule_configuration` ALTER COLUMN `rule_effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Rule Effectiveness Score');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'risk_compliance');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` SET TAGS ('dbx_association_edges' = 'ledger.cost_center,channel.channel');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Cost Allocation ID');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Cost Allocation - Banking Channel Id');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Cost Allocation - Cost Center Id');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Employee ID');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Employee ID');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `allocation_amount_annual` SET TAGS ('dbx_business_glossary_term' = 'Allocation Amount Annual');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Allocation Method');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `cost_driver_metric` SET TAGS ('dbx_business_glossary_term' = 'Cost Driver Metric');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `cost_driver_value` SET TAGS ('dbx_business_glossary_term' = 'Cost Driver Value');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `banking_ecm`.`channel`.`cost_allocation` ALTER COLUMN `primary_channel_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Channel Flag');
ALTER TABLE `banking_ecm`.`channel`.`alert_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`alert_template` SET TAGS ('dbx_subdomain' = 'digital_experience');
ALTER TABLE `banking_ecm`.`channel`.`alert_template` ALTER COLUMN `alert_template_id` SET TAGS ('dbx_business_glossary_term' = 'Alert Template Identifier');
ALTER TABLE `banking_ecm`.`channel`.`alert_template` ALTER COLUMN `previous_alert_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`alert_template` ALTER COLUMN `reply_to_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`alert_template` ALTER COLUMN `sender_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`campaign` SET TAGS ('dbx_subdomain' = 'digital_experience');
ALTER TABLE `banking_ecm`.`channel`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `banking_ecm`.`channel`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`campaign` ALTER COLUMN `owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`campaign` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`override_approval` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`override_approval` SET TAGS ('dbx_subdomain' = 'risk_compliance');
ALTER TABLE `banking_ecm`.`channel`.`override_approval` ALTER COLUMN `override_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Override Approval Identifier');
ALTER TABLE `banking_ecm`.`channel`.`override_approval` ALTER COLUMN `previous_override_approval_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`override_approval` ALTER COLUMN `approved_limit_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`override_approval` ALTER COLUMN `original_limit_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`override_approval` ALTER COLUMN `override_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`journey_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`journey_template` SET TAGS ('dbx_subdomain' = 'customer_interaction');
ALTER TABLE `banking_ecm`.`channel`.`journey_template` ALTER COLUMN `journey_template_id` SET TAGS ('dbx_business_glossary_term' = 'Journey Template Identifier');
ALTER TABLE `banking_ecm`.`channel`.`journey_template` ALTER COLUMN `previous_journey_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` SET TAGS ('dbx_subdomain' = 'digital_experience');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `third_party_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Provider Identifier');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `parent_third_party_provider_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`third_party_provider` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`channel`.`override_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`channel`.`override_request` SET TAGS ('dbx_subdomain' = 'risk_compliance');
ALTER TABLE `banking_ecm`.`channel`.`override_request` ALTER COLUMN `override_request_id` SET TAGS ('dbx_business_glossary_term' = 'Override Request Identifier');
ALTER TABLE `banking_ecm`.`channel`.`override_request` ALTER COLUMN `previous_override_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
