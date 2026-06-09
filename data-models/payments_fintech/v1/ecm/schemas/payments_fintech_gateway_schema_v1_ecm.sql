-- Schema for Domain: gateway | Business: Payments Fintech | Version: v1_ecm
-- Generated on: 2026-05-03 18:25:33

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`gateway` COMMENT 'Owns the payment gateway and API routing infrastructure — merchant API/SDK integration configurations, transaction routing rules, protocol translation (ISO 8583, REST, SOAP), acquirer endpoint registrations, webhook delivery, rate limiting, API authentication, failover logic, and gateway SLA performance records.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` (
    `gateway_api_credential_id` BIGINT COMMENT 'System-generated unique identifier for the API credential record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partner onboarding requires each gateway API credential to be linked to the owning partner for billing, compliance audit, and credential lifecycle management.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user or service account that created the credential.',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant. Business justification: API credentials are issued per merchant; linking enables authentication audit, usage reporting, and revocation per merchant.',
    `allowed_ip_ranges` STRING COMMENT 'Network CIDR blocks from which the credential may be used; empty means unrestricted.',
    `audience` STRING COMMENT 'Recipient(s) that the token is intended for, often a service identifier.',
    `audit_log_reference` STRING COMMENT 'External identifier linking to a detailed audit trail stored in the compliance system.',
    `authentication_method` STRING COMMENT 'Specifies the protocol or mechanism by which the credential authenticates API calls.. Valid values are `api_key|oauth|hmac|certificate`',
    `certificate_thumbprint` STRING COMMENT 'SHA‑1/256 hash of the public certificate associated with the credential.',
    `client_identifier` STRING COMMENT 'Public identifier for an OAuth client used during token acquisition.',
    `client_secret` STRING COMMENT 'Confidential secret associated with an OAuth client credential.',
    `compliance_status` STRING COMMENT 'Indicates whether the credential meets current PCI DSS, GDPR, and internal security policies.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the credential record was first created in the system.',
    `credential_key` STRING COMMENT 'Public API key or client identifier presented by the merchant/partner when invoking gateway APIs.',
    `credential_name` STRING COMMENT 'Descriptive name assigned to the credential for easy identification by operations and security teams.',
    `credential_type` STRING COMMENT 'Specifies the technical mechanism of the credential (e.g., static API key, OAuth client, HMAC secret, X.509 certificate).. Valid values are `api_key|oauth_client|hmac|certificate`',
    `data_classification` STRING COMMENT 'Organizational classification indicating handling and access controls for the credential data.. Valid values are `restricted|confidential|internal|public`',
    `effective_from` DATE COMMENT 'Calendar date on which the credential is permitted to be used.',
    `effective_until` DATE COMMENT 'Calendar date after which the credential must no longer be accepted; null indicates no fixed expiry.',
    `encryption_algorithm` STRING COMMENT 'Cryptographic algorithm employed to protect the credential material.. Valid values are `RSA|ECDSA|AES`',
    `environment` STRING COMMENT 'Indicates whether the credential is intended for live production traffic or testing/sandbox environments.. Valid values are `production|sandbox|test`',
    `gateway_api_credential_status` STRING COMMENT 'Indicates whether the credential is usable, disabled, revoked, or awaiting activation.. Valid values are `active|inactive|revoked|suspended|pending`',
    `hash_algorithm` STRING COMMENT 'Digest algorithm used for HMAC or signature verification.. Valid values are `SHA256|SHA384|SHA512`',
    `hmac_secret` STRING COMMENT 'Shared secret used to compute HMAC signatures for request authentication.',
    `issuer` STRING COMMENT 'Name of the authority or system that issued the credential.',
    `key_identifier` STRING COMMENT 'Unique identifier for the cryptographic key, used in token headers.',
    `last_rotated_timestamp` TIMESTAMP COMMENT 'Date and time when the credential was most recently rotated.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date and time of the last successful API call authenticated with this credential.',
    `max_concurrent_sessions` STRING COMMENT 'Upper limit on simultaneous active sessions or tokens for this credential.',
    `next_rotation_timestamp` TIMESTAMP COMMENT 'Scheduled date and time for the next required rotation of the credential.',
    `rate_limit_per_minute` STRING COMMENT 'Maximum number of API calls permitted in any rolling 60‑second window.',
    `regulatory_review_date` DATE COMMENT 'Date when the credential was last examined for regulatory compliance.',
    `revocation_reason` STRING COMMENT 'Human‑readable explanation for why the credential was revoked.',
    `revoked_flag` BOOLEAN COMMENT 'True if the credential has been revoked and must no longer be accepted.',
    `revoked_timestamp` TIMESTAMP COMMENT 'Date and time the revocation became effective.',
    `rotation_interval_days` STRING COMMENT 'Policy‑driven interval after which the credential must be regenerated.',
    `scopes` STRING COMMENT 'Comma‑separated list of permission scopes granted to the credential (e.g., transactions:read, settlements:write).',
    `token_endpoint` STRING COMMENT 'OAuth token endpoint used by the client to obtain access tokens.',
    `token_expiry_seconds` STRING COMMENT 'Lifetime of issued access tokens, expressed in seconds.',
    `token_type` STRING COMMENT 'Specifies whether the token follows Bearer or MAC token semantics.. Valid values are `bearer|mac`',
    `updated_by` STRING COMMENT 'Identifier of the internal user or service account that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the credential record.',
    `usage_count` STRING COMMENT 'Running total of successful API calls made with this credential.',
    `usage_quota` DECIMAL(18,2) COMMENT 'Total number of allowed invocations or monetary value before the credential is throttled or blocked.',
    CONSTRAINT pk_gateway_api_credential PRIMARY KEY(`gateway_api_credential_id`)
) COMMENT 'Master record for merchant and partner API authentication credentials used to access the payment gateway. Stores API keys, OAuth client IDs/secrets, HMAC signing keys, certificate thumbprints, credential rotation schedules, permission scopes, and revocation status. SSOT for gateway authentication identity — every inbound API call is authenticated against this record.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` (
    `merchant_integration_id` BIGINT COMMENT 'System-generated unique identifier for the merchant integration configuration record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Integration records must capture the partner that facilitated merchant onboarding, used in partner performance dashboards and revenue‑share calculations.',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant. Business justification: Required for onboarding: each merchant integration config must be linked to its merchant for routing, reporting, and compliance.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Merchant integration configuration is product‑specific, linking integration to the payment product it supports for onboarding and monitoring.',
    `api_key` STRING COMMENT 'Secret API key credential used for authentication when authentication_method = api_key.',
    `authentication_method` STRING COMMENT 'Mechanism used to authenticate calls from the merchant (API key, OAuth, or mutual TLS).. Valid values are `api_key|oauth|mutual_tls`',
    `compliance_last_review_date` DATE COMMENT 'Date of the most recent compliance audit or review for this integration.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the integration with PCI DSS and other regulations.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this integration record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the integration configuration becomes effective.',
    `effective_until` DATE COMMENT 'Date when the integration configuration expires or is superseded; null if open‑ended.',
    `endpoint_url` STRING COMMENT 'Fully qualified URL of the merchants API endpoint or callback address.',
    `environment` STRING COMMENT 'Operational environment for the integration – sandbox for testing or production for live traffic.. Valid values are `sandbox|production`',
    `gateway_region` STRING COMMENT 'Geographic region or data‑center where the integration is hosted (e.g., us-east-1).',
    `integration_category` STRING COMMENT 'High‑level business category of the integration (e.g., payment, refund).. Valid values are `payment|refund|settlement|dispute|wallet`',
    `integration_name` STRING COMMENT 'Human‑readable name given to this integration profile by the merchant or operations team.',
    `integration_type` STRING COMMENT 'Technical style of the integration (e.g., REST API, SOAP web service, ISO 8583 message, native SDK).. Valid values are `REST|SOAP|ISO8583|SDK`',
    `is_rate_limited` BOOLEAN COMMENT 'Flag indicating whether rate limiting is enforced for this integration.',
    `is_tokenized` BOOLEAN COMMENT 'Indicates if the integration uses tokenization for cardholder data.',
    `last_tested_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent connectivity or compliance test performed on the integration.',
    `merchant_integration_description` STRING COMMENT 'Free‑form description of the integration purpose, scope, or special notes.',
    `merchant_integration_status` STRING COMMENT 'Operational status of the integration profile.. Valid values are `active|inactive|suspended|decommissioned`',
    `oauth_client_identifier` STRING COMMENT 'Client identifier issued to the merchant for OAuth‑based authentication.',
    `oauth_scopes` STRING COMMENT 'Comma‑separated list of OAuth scopes granted to the merchant integration.',
    `onboarding_status` STRING COMMENT 'Current status of the merchants onboarding workflow for this integration.. Valid values are `pending|completed|rejected|inactive`',
    `pci_dss_compliance_tier` STRING COMMENT 'PCI DSS compliance tier assigned to the integration based on data handling scope.. Valid values are `tier1|tier2|tier3|tier4`',
    `protocol_version` STRING COMMENT 'Version of the integration protocol or API specification used.',
    `rate_limit_per_minute` STRING COMMENT 'Maximum number of API calls allowed per minute for this integration.',
    `support_contact_email` STRING COMMENT 'Email address of the merchants technical support contact for this integration.',
    `support_contact_phone` STRING COMMENT 'Phone number of the merchants technical support contact for this integration.',
    `test_status` STRING COMMENT 'Result of the latest integration test (passed, failed, or not yet tested).. Valid values are `passed|failed|not_tested`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this integration record.',
    `version` STRING COMMENT 'Version identifier for the integration configuration (e.g., release tag).',
    `webhook_secret` STRING COMMENT 'Shared secret used to sign webhook payloads for integrity verification.',
    `webhook_url` STRING COMMENT 'URL to which the gateway will POST event notifications for this integration.',
    CONSTRAINT pk_merchant_integration PRIMARY KEY(`merchant_integration_id`)
) COMMENT 'Master configuration record for each merchants API or SDK integration with the payment gateway. Captures integration type (REST, SOAP, ISO 8583, SDK), protocol version, endpoint URLs, MID linkage, integration environment (sandbox/production), onboarding status, PCI DSS compliance tier, and assigned gateway region. One merchant may have multiple integration profiles across channels.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` (
    `gateway_routing_rule_id` BIGINT COMMENT 'Unique identifier for the routing rule.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Primary acquirer endpoint to which matching transactions are routed.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: Rules may target a specific card scheme; linking to reference_card_scheme provides scheme details and compliance data.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Routing rules are applied per currency; linking to reference.currency enables validation, reporting, and compliance per ISO currency.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partners often have custom routing rules; linking enables rule‑ownership reporting, SLA monitoring, and regulatory routing audits.',
    `employee_id` BIGINT COMMENT 'User or system that created the rule.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: Routing: rules need to reference IRF rate categories to apply correct interchange rates per regulatory and scheme requirements.',
    `mcc_id` BIGINT COMMENT 'Foreign key linking to reference.mcc. Business justification: MCC‑based routing decisions require the authoritative MCC reference for accurate categorisation and risk scoring.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Routing engine uses product_id to select routing rule for each payment product, required for rule‑based acquirer selection.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Required for scheme‑based routing decisions; the routing engine must know which card scheme a rule applies to for compliance reporting.',
    `target_acquirer_acquirer_endpoint_id` BIGINT COMMENT 'Primary acquirer endpoint to which matching transactions are routed.',
    `amount_max` DECIMAL(18,2) COMMENT 'Upper bound of transaction amount for rule matching.',
    `amount_min` DECIMAL(18,2) COMMENT 'Lower bound of transaction amount for rule matching.',
    `bin_range_end` STRING COMMENT 'Ending BIN of the rules matching range.',
    `bin_range_start` STRING COMMENT 'Starting BIN (Bank Identification Number) of the rules matching range.',
    `channel` STRING COMMENT 'Channel through which the transaction originates.. Valid values are `web|mobile|pos|api`',
    `compliance_check_required` BOOLEAN COMMENT 'Flag indicating if the transaction must pass additional compliance checks before routing.',
    `compliance_rule_set` STRING COMMENT 'Identifier of the compliance rule set applied to transactions routed by this rule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was created.',
    `effective_end_date` DATE COMMENT 'Date when the rule expires (null for indefinite).',
    `effective_start_date` DATE COMMENT 'Date when the rule becomes active.',
    `external_rule_reference` STRING COMMENT 'Identifier of the rule in an external system, if any.',
    `failover_acquirer_sequence` STRING COMMENT 'Comma‑separated list of acquirer IDs used for failover routing.',
    `fraud_score_threshold` DECIMAL(18,2) COMMENT 'Minimum fraud risk score required for the rule to be applied.',
    `gateway_routing_rule_description` STRING COMMENT 'Free‑form description of the rule purpose and logic.',
    `gateway_routing_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|deprecated|pending`',
    `is_default_rule` BOOLEAN COMMENT 'Indicates whether this rule serves as the fallback/default routing rule.',
    `is_rate_limited` BOOLEAN COMMENT 'Indicates whether the rule enforces a transaction rate limit.',
    `load_balancing_weight` STRING COMMENT 'Relative weight for load‑balancing among multiple target acquirers.',
    `match_criteria` STRING COMMENT 'JSON representation of complex matching conditions not covered by individual columns.',
    `notes` STRING COMMENT 'Additional free‑form notes for operational teams.',
    `priority` STRING COMMENT 'Evaluation order; lower numbers are evaluated first.',
    `rate_limit_per_second` STRING COMMENT 'Maximum number of transactions per second allowed under this rule.',
    `region_code` STRING COMMENT 'Three‑letter country/region code for geographic routing.',
    `risk_level` STRING COMMENT 'Risk classification associated with the rule.. Valid values are `low|medium|high`',
    `routing_algorithm` STRING COMMENT 'Algorithm used to select among multiple target acquirers.. Valid values are `round_robin|least_connections|weighted`',
    `rule_code` STRING COMMENT 'Business code used to reference the rule in external systems.',
    `rule_name` STRING COMMENT 'Human‑readable name of the routing rule.',
    `rule_type` STRING COMMENT 'Classification of the rule logic (e.g., least‑cost, scheme‑preference, geographic, custom).. Valid values are `least_cost|scheme_preference|geographic|custom`',
    `sla_response_time_ms` STRING COMMENT 'Target maximum response time for routing decisions, in milliseconds.',
    `tokenization_required` BOOLEAN COMMENT 'Indicates if the transaction must be tokenized before routing.',
    `transaction_type` STRING COMMENT 'Type of transaction the rule applies to.. Valid values are `auth|capture|sale|refund|void`',
    `updated_by` STRING COMMENT 'User or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rule.',
    CONSTRAINT pk_gateway_routing_rule PRIMARY KEY(`gateway_routing_rule_id`)
) COMMENT 'Business-managed transaction routing rule defining how inbound payment requests are directed to acquirer endpoints. Captures rule priority, matching criteria (BIN range, MCC, currency, amount threshold, card scheme, region), target acquirer endpoint, failover sequence, load-balancing weight, effective date range, and rule status. Supports least-cost routing, scheme-preference routing, and geographic routing strategies.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` (
    `acquirer_endpoint_id` BIGINT COMMENT 'Unique system-generated identifier for the acquirer endpoint configuration.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partner‑specific acquirer endpoints are configured for settlement and risk management; the FK ties endpoint health and compliance to the responsible partner.',
    `failover_endpoint_id` BIGINT COMMENT 'Identifier of the secondary endpoint used for failover.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Fee accounting process maps each acquirer endpoint to a GL account for posting acquisition fees and settlement adjustments.',
    `acquirer_bic` STRING COMMENT 'SWIFT BIC of the acquirer, 8‑ or 11‑character code.. Valid values are `^[A-Z]{8,11}$`',
    `acquirer_bin` STRING COMMENT 'First six digits of the acquirers card number range.. Valid values are `^d{6}$`',
    `acquirer_endpoint_description` STRING COMMENT 'Free‑form description of the endpoint purpose, notes, or special handling instructions.',
    `acquirer_name` STRING COMMENT 'Legal name of the acquiring financial institution.',
    `compliance_regulation` STRING COMMENT 'Regulatory frameworks applicable to this endpoint (e.g., PCI_DSS, PSD2, EMVCo).',
    `connection_pool_size` STRING COMMENT 'Maximum number of simultaneous connections maintained to the acquirer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the endpoint record was first created.',
    `cross_border_fee` DECIMAL(18,2) COMMENT 'Additional fee charged for cross‑border transactions, expressed in the settlement currency.',
    `currency_conversion_supported` BOOLEAN COMMENT 'Indicates whether the acquirer can process cross‑currency transactions for this endpoint.',
    `effective_from` DATE COMMENT 'Date when the endpoint configuration becomes effective.',
    `effective_until` DATE COMMENT 'Date when the endpoint configuration expires or is retired (null if open‑ended).',
    `endpoint_code` STRING COMMENT 'Business code used to reference the endpoint in operational processes.',
    `endpoint_name` STRING COMMENT 'Human‑readable name for the acquirer connection endpoint.',
    `failover_enabled` BOOLEAN COMMENT 'Indicates whether automatic failover to a secondary endpoint is active.',
    `geographic_coverage` STRING COMMENT 'Comma‑separated list of ISO 3166‑1 alpha‑3 country codes where this endpoint is active. [ENUM-REF-CANDIDATE: USA|CAN|GBR|FRA|DEU|JPN|AUS|CHN|IND|BRA — promote to reference product]',
    `health_check_status` STRING COMMENT 'Result of the most recent automated health check.. Valid values are `pass|fail|unknown`',
    `host_url` STRING COMMENT 'Fully qualified domain name or IP address of the acquirer endpoint.',
    `is_tokenization_supported` BOOLEAN COMMENT 'Indicates whether the acquirer supports tokenized card data for this endpoint.',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent health‑check execution.',
    `max_concurrent_connections` STRING COMMENT 'Hard limit on concurrent active sessions allowed for this endpoint.',
    `operational_status` STRING COMMENT 'Current operational state of the endpoint.. Valid values are `active|inactive|maintenance|decommissioned`',
    `port` STRING COMMENT 'TCP port used for the connection.',
    `protocol` STRING COMMENT 'Technical protocol used for communication with the acquirer.. Valid values are `ISO8583|REST|SOAP|SWIFT`',
    `rate_limit_per_sec` STRING COMMENT 'Allowed number of requests per second to the acquirer.',
    `settlement_currency` STRING COMMENT 'ISO 4217 three‑letter code of the currency used for settlement with the acquirer.. Valid values are `^[A-Z]{3}$`',
    `settlement_type` STRING COMMENT 'Indicates whether settlement is net‑based or gross‑based.. Valid values are `net|gross`',
    `supported_card_schemes` STRING COMMENT 'Comma‑separated list of card scheme identifiers (e.g., Visa, Mastercard, Amex) that this endpoint can process. [ENUM-REF-CANDIDATE: Visa|Mastercard|Amex|Discover|JCB|UnionPay — promote to reference product]',
    `timeout_ms` STRING COMMENT 'Maximum time in milliseconds to wait for a response before timing out.',
    `tls_certificate_expiration` DATE COMMENT 'Date on which the TLS certificate expires.',
    `tls_certificate_thumbprint` STRING COMMENT 'SHA‑1 thumbprint of the TLS certificate presented by the acquirer.. Valid values are `^[A-Fa-f0-9]{40}$`',
    `token_service_provider` STRING COMMENT 'Name of the token service provider (TSP) associated with this endpoint, if any.',
    `transaction_fee_fixed_amount` DECIMAL(18,2) COMMENT 'Fixed monetary fee applied per transaction, expressed in the settlement currency.',
    `transaction_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage fee applied to each transaction processed through this endpoint.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the endpoint record.',
    CONSTRAINT pk_acquirer_endpoint PRIMARY KEY(`acquirer_endpoint_id`)
) COMMENT 'Master record for each registered acquirer connection endpoint available to the gateway. Stores acquirer BIC/BIN, connection protocol (ISO 8583, REST, SWIFT), host URL, port, TLS certificate details, connection pool size, timeout thresholds, supported card schemes, settlement currency, geographic coverage, and operational status. SSOT for acquirer connectivity configuration within the gateway domain.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` (
    `gateway_protocol_config_id` BIGINT COMMENT 'System-generated unique identifier for each protocol configuration record.',
    `region_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_region. Business justification: Gateway protocol configurations are region-specific; linking to gateway_region enables regional management and compliance.',
    `authentication_method` STRING COMMENT 'Method used to authenticate inbound API calls for this configuration.. Valid values are `APIKey|OAuth2|MutualTLS|None`',
    `bitmap_configuration` STRING COMMENT 'Definition of bitmap layout for ISO‑8583 messages.',
    `change_control_number` STRING COMMENT 'Identifier of the change request that introduced or modified this configuration.',
    `character_set` STRING COMMENT 'Specific character set applied to the message (e.g., ISO‑8859‑1).',
    `compliance_standard` STRING COMMENT 'Regulatory or industry standard that this configuration adheres to.. Valid values are `PCI_DSS|EMVCo|ISO20022|ISO8583|None`',
    `config_name` STRING COMMENT 'Human‑readable name identifying the protocol configuration.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the configuration record was first created in the system.',
    `deprecation_reason` STRING COMMENT 'Explanation why the configuration was deprecated, if applicable.',
    `deprecation_timestamp` TIMESTAMP COMMENT 'Timestamp when the configuration was officially deprecated.',
    `documentation_url` STRING COMMENT 'Link to the technical documentation for this configuration.',
    `effective_from` TIMESTAMP COMMENT 'Timestamp when the configuration becomes active for routing.',
    `effective_until` TIMESTAMP COMMENT 'Timestamp when the configuration is retired; null if indefinite.',
    `encoding_scheme` STRING COMMENT 'Character encoding used for message payloads (e.g., UTF-8, ASCII).',
    `error_handling_mode` STRING COMMENT 'Defines how parsing or transformation errors are treated.. Valid values are `strict|lenient|custom`',
    `field_mapping_definitions` STRING COMMENT 'JSON‑encoded rules that map source fields to target fields for the protocol.',
    `gateway_protocol_config_description` STRING COMMENT 'Free‑form text describing the purpose and scope of the configuration.',
    `gateway_protocol_config_status` STRING COMMENT 'Current lifecycle state of the configuration.. Valid values are `active|inactive|deprecated|pending`',
    `is_default` BOOLEAN COMMENT 'Indicates whether this configuration is the default for its protocol.',
    `last_tested_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful end‑to‑end test of the configuration.',
    `max_payload_size_bytes` STRING COMMENT 'Upper limit on the size of a single message payload.',
    `mti_mappings` STRING COMMENT 'Mapping definition between source and target MTI values for the protocol.',
    `owner_team` STRING COMMENT 'Business team responsible for maintaining the configuration.',
    `priority` STRING COMMENT 'Numeric priority used when multiple configurations match; lower numbers have higher precedence.',
    `protocol` STRING COMMENT 'Messaging standard that this configuration translates to and from.. Valid values are `ISO8583|ISO20022|REST|SOAP|GraphQL`',
    `rate_limit_per_second` STRING COMMENT 'Maximum number of messages that can be processed per second under this configuration.',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates if deployment of this configuration requires formal regulatory sign‑off.',
    `retry_policy` STRING COMMENT 'Policy governing how failed message deliveries are retried.. Valid values are `none|fixed|exponential|custom`',
    `supported_message_versions` STRING COMMENT 'Comma‑separated list of protocol version identifiers that this configuration supports.',
    `test_environment` STRING COMMENT 'Indicates whether the configuration is intended for sandbox or production use.. Valid values are `sandbox|production`',
    `timeout_ms` STRING COMMENT 'Maximum time to wait for a response before considering the transaction timed out.',
    `transformation_pipeline` STRING COMMENT 'Identifier of the processing pipeline that applies additional transformations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the configuration record.',
    `version` STRING COMMENT 'Version identifier of the protocol specification (e.g., 1.0, 2.1).',
    CONSTRAINT pk_gateway_protocol_config PRIMARY KEY(`gateway_protocol_config_id`)
) COMMENT 'Configuration record defining protocol translation parameters for each supported messaging standard (ISO 8583, ISO 20022, REST, SOAP, GraphQL). Captures message format version, field mapping definitions, encoding scheme, character set, MTI (Message Type Indicator) mappings, bitmap configuration, and transformation pipeline reference. Enables the gateway to translate between merchant-facing and acquirer-facing protocols.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`request` (
    `request_id` BIGINT COMMENT 'Unique identifier for the inbound API request record.',
    `cardholder_profile_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_profile. Business justification: Required for transaction monitoring report linking each gateway request to the originating cardholder profile for fraud detection and compliance.',
    `application_id` BIGINT COMMENT 'Identifier of the client application (e.g., mobile SDK, web app) making the request.',
    `contactless_profile_id` BIGINT COMMENT 'Identifier of the point‑of‑sale terminal that generated the request.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Geo‑country code in request drives jurisdictional risk checks; linking to reference.country enables AML/OFAC screening.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Incoming requests include a currency code; FK to reference.currency validates the code and supports settlement reporting.',
    `device_fingerprint_id` BIGINT COMMENT 'Foreign key linking to fraud.device_fingerprint. Business justification: Request logs reference captured device fingerprint to feed fraud risk models and support device‑based investigations.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: Required for linking each payment request originating from a digital wallet to the wallet, enabling fraud monitoring, transaction traceability, and settlement reporting.',
    `gateway_api_credential_id` BIGINT COMMENT 'Identifier of the API credential (key/secret) used to authenticate the request.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant (MID) that originated the request.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Transaction request includes payment product identifier to apply correct fee schedule and routing logic.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the point‑of‑sale terminal that generated the request.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: FX rate lookup needed during processing of multi‑currency transactions; request stores the applied rate for compliance and reporting.',
    `rate_limit_policy_id` BIGINT COMMENT 'Identifier of the rate‑limit rule that applied (if any).',
    `wallet_transaction_id` BIGINT COMMENT 'Foreign key linking to wallet.wallet_transaction. Business justification: Directly ties the gateway request to the wallet transaction it represents, supporting real‑time monitoring and end‑to‑end transaction audit.',
    `client_version` STRING COMMENT 'Version string of the client application.',
    `correlation_identifier` STRING COMMENT 'Client‑provided identifier for tracing the request across systems.',
    `endpoint_path` STRING COMMENT 'API endpoint path invoked by the request (e.g., /v1/authorize).',
    `headers` STRING COMMENT 'Serialized HTTP headers of the inbound request.',
    `http_method` STRING COMMENT 'HTTP verb used for the request.. Valid values are `GET|POST|PUT|DELETE|PATCH`',
    `idempotency_key` STRING COMMENT 'Client‑provided key to ensure idempotent processing of the request.',
    `is_rate_limited` BOOLEAN COMMENT 'Indicates whether the request was blocked or throttled by rate‑limit rules.',
    `latency_ms` BIGINT COMMENT 'Time elapsed from request receipt to completion of initial validation, measured in milliseconds.',
    `payload_truncated` STRING COMMENT 'First 256 characters of the request payload for quick inspection (full payload stored elsewhere).',
    `processing_node_identifier` BIGINT COMMENT 'Identifier of the gateway server node that processed the request.',
    `protocol` STRING COMMENT 'Protocol used for the inbound request (e.g., ISO8583, REST, SOAP).. Valid values are `ISO8583|REST|SOAP|JSON|XML`',
    `raw_message_hash` STRING COMMENT 'Hash (e.g., SHA‑256) of the raw request message for integrity verification.',
    `request_timestamp` TIMESTAMP COMMENT 'Exact time the gateway received the API request (event time).',
    `request_type` STRING COMMENT 'Business operation the request is attempting (authorization, capture, void, refund, inquiry).. Valid values are `authorization|capture|void|refund|inquiry`',
    `schema_version` STRING COMMENT 'Version of the API request schema used by the client.',
    `size_bytes` BIGINT COMMENT 'Size of the raw request payload in bytes.',
    `source_ip` STRING COMMENT 'IP address of the client that initiated the request.',
    `source_port` STRING COMMENT 'Network port on the client side used for the request.',
    `tls_version` STRING COMMENT 'TLS protocol version negotiated for the request.. Valid values are `TLS1.0|TLS1.1|TLS1.2|TLS1.3`',
    `user_agent` STRING COMMENT 'User‑agent string supplied by the client application.',
    `validation_error_code` STRING COMMENT 'Error code returned when validation_outcome is rejected or error.',
    `validation_outcome` STRING COMMENT 'Result of the gateways initial syntactic/semantic validation.. Valid values are `accepted|rejected|error`',
    CONSTRAINT pk_request PRIMARY KEY(`request_id`)
) COMMENT 'Transactional record capturing every inbound API request received by the payment gateway before authorization processing. Stores request timestamp, originating MID, TID, API credential reference, request type (authorization, capture, void, refund, inquiry), raw message hash, protocol used, source IP, request size, TLS version, and initial validation outcome. Serves as the immutable entry-point audit record for every gateway interaction.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`response` (
    `response_id` BIGINT COMMENT 'Unique identifier for the gateway response record.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: Card scheme in response is needed for scheme‑specific settlement rules; reference link provides authoritative data.',
    `cardholder_profile_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_profile. Business justification: Enables reconciliation of response data with the cardholder profile for dispute resolution and regulatory audit of transaction outcomes.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Response includes currency; FK to reference.currency ensures accurate reporting and reconciliation.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: Needed to associate the gateways response with the originating digital wallet for reconciliation, dispute handling, and compliance reporting.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Required for daily settlement posting: each gateway response must be linked to the corresponding journal entry to record revenue and reconcile transaction outcomes.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant associated with the transaction.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Response records the payment product to enable product‑level reconciliation and reporting.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the point‑of‑sale terminal that originated the request; sensitive PCI data.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Response records the FX rate used for the transaction to support post‑settlement audit and dispute handling.',
    `request_id` BIGINT COMMENT 'Identifier of the originating gateway request that generated this response.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the batch that includes this transaction for settlement.',
    `wallet_transaction_id` BIGINT COMMENT 'Foreign key linking to wallet.wallet_transaction. Business justification: Associates the response with the specific wallet transaction for settlement reconciliation and dispute resolution.',
    `acquirer_response_code` STRING COMMENT 'Response code returned by the acquiring bank or processor.',
    `amount_cents` BIGINT COMMENT 'Transaction amount expressed in the smallest currency unit (e.g., cents).',
    `authorization_code` STRING COMMENT 'Issuer-provided code confirming successful authorization; sensitive PCI data.',
    `card_type` STRING COMMENT 'Classification of the card (credit, debit, prepaid, commercial).. Valid values are `credit|debit|prepaid|commercial`',
    `compliance_check_details` STRING COMMENT 'Free‑text details of any compliance issues detected.',
    `compliance_check_passed` BOOLEAN COMMENT 'Result of regulatory compliance checks (e.g., AML, sanctions).',
    `correlation_identifier` STRING COMMENT 'Identifier used to correlate this response with upstream request logs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the response record was first persisted.',
    `decline_reason` STRING COMMENT 'Human‑readable reason why the transaction was declined, if applicable.',
    `destination_ip` STRING COMMENT 'IP address of the merchant endpoint that received the response.',
    `destination_port` STRING COMMENT 'Network port on the merchant side used for the response.',
    `entry_mode` STRING COMMENT 'Method by which card data was captured.. Valid values are `chip|magstripe|contactless|manual`',
    `error_code` STRING COMMENT 'Code representing any internal processing error that occurred.',
    `error_description` STRING COMMENT 'Detailed description of the internal error.',
    `final_disposition` STRING COMMENT 'Overall outcome of the response after retries (e.g., success, failed, partial).. Valid values are `success|failed|partial`',
    `fraud_score` STRING COMMENT 'Numeric risk score assigned by the fraud engine.',
    `is_fraud_flag` BOOLEAN COMMENT 'Indicates whether the transaction was flagged as potentially fraudulent.',
    `is_test_transaction` BOOLEAN COMMENT 'Indicates whether the transaction was processed in test mode.',
    `message` STRING COMMENT 'Optional free‑text message included in the response.',
    `network_latency_ms` STRING COMMENT 'Measured network round‑trip time in milliseconds.',
    `processing_latency_ms` STRING COMMENT 'Time in milliseconds from request receipt to response generation.',
    `protocol` STRING COMMENT 'Protocol used to deliver the response to the merchant.. Valid values are `ISO8583|REST|SOAP|JSON|XML|gRPC`',
    `response_code` STRING COMMENT 'Standard response code indicating approval, decline, or error (e.g., ISO 8583 response codes).',
    `response_timestamp` TIMESTAMP COMMENT 'Exact time when the gateway sent the response to the merchant.',
    `retry_count` STRING COMMENT 'Number of retry attempts performed before delivering the final response.',
    `settlement_date` DATE COMMENT 'Date on which the transaction was settled with the acquiring bank.',
    `sla_met` BOOLEAN COMMENT 'Indicates whether the response met the defined SLA latency threshold.',
    `source_ip` STRING COMMENT 'IP address of the gateway node that sent the response.',
    `source_port` STRING COMMENT 'Network port on the gateway used for the response.',
    `transaction_type` STRING COMMENT 'Business purpose of the transaction.. Valid values are `purchase|refund|auth|capture|void`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the response record.',
    CONSTRAINT pk_response PRIMARY KEY(`response_id`)
) COMMENT 'Transactional record capturing the gateways outbound response for each processed request. Stores response timestamp, linked gateway_request_id, response code, authorization code, decline reason, acquirer response code, processing latency (ms), response protocol, retry count, and final disposition. Enables SLA measurement, decline analysis, and end-to-end latency tracking.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` (
    `routing_decision_id` BIGINT COMMENT 'Unique identifier for the routing decision record.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Identifier of the acquiring bank or payment network selected (or considered) for the transaction.',
    `gateway_routing_rule_id` BIGINT COMMENT 'Identifier of the routing rule that was evaluated to produce this decision.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant that initiated the payment request.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Routing decisions consider real‑time FX rates for currency‑based routing rules; storing the rate links decision to the rate source.',
    `alternative_acquirer_endpoints` STRING COMMENT 'Comma‑separated list of other eligible acquirer endpoints evaluated during routing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the routing decision record was first persisted.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the request amount.',
    `decision_error_code` STRING COMMENT 'Standardized error code if the routing decision failed.',
    `decision_error_message` STRING COMMENT 'Human‑readable error message associated with a failed routing decision.',
    `decision_outcome` STRING COMMENT 'Result of the routing decision as applied to the transaction.. Valid values are `approved|declined|rerouted|error`',
    `decision_reason` STRING COMMENT 'Human‑readable explanation or code describing why the particular endpoint was selected.',
    `decision_timestamp` TIMESTAMP COMMENT 'Exact time when the routing decision was evaluated and made.',
    `failover_triggered` BOOLEAN COMMENT 'Indicates whether a failover path was taken due to primary endpoint failure.',
    `load_balancing_outcome` STRING COMMENT 'Algorithmic outcome used to select the acquirer endpoint.. Valid values are `selected|round_robin|least_connections|weighted`',
    `request_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the transaction that triggered the routing decision.',
    `request_protocol` STRING COMMENT 'Protocol used by the originating request (e.g., ISO8583, REST, SOAP, JSON).. Valid values are `ISO8583|REST|SOAP|JSON`',
    `request_source` STRING COMMENT 'Channel through which the payment request arrived (e.g., web, mobile app, POS terminal).. Valid values are `web|mobile|POS|mPOS|API`',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk score generated by the fraud detection platform for this request.',
    `routing_decision_status` STRING COMMENT 'Current lifecycle status of the routing decision.. Valid values are `applied|failed|pending|reverted`',
    `routing_latency_ms` STRING COMMENT 'Measured time in milliseconds from request receipt to routing decision output.',
    `selected_acquirer_endpoint` STRING COMMENT 'Endpoint (e.g., URL, host:port) of the acquirer that was chosen to receive the transaction.',
    `sla_achieved` BOOLEAN COMMENT 'Indicates whether the actual routing latency met the SLA target.',
    `sla_target_ms` STRING COMMENT 'Configured service‑level‑agreement target latency for routing decisions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the routing decision record.',
    CONSTRAINT pk_routing_decision PRIMARY KEY(`routing_decision_id`)
) COMMENT 'Transactional record capturing the real-time routing decision made for each payment request. Records which routing rule was applied, the selected acquirer endpoint, evaluated alternative endpoints, routing latency, load-balancing outcome, failover triggered flag, and the reason for endpoint selection. Provides full auditability of routing logic for dispute resolution, performance tuning, and regulatory review.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`failover_event` (
    `failover_event_id` BIGINT COMMENT 'Unique identifier for each failover event record.',
    `gateway_routing_rule_id` BIGINT COMMENT 'Identifier of the routing rule applied during the failover.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant whose transactions were impacted.',
    `network_scheme_id` BIGINT COMMENT 'Identifier of the payment network (e.g., Visa, Mastercard) involved.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Identifier of the primary (failed) acquirer endpoint.',
    `scheme_id` BIGINT COMMENT 'Identifier of the payment network (e.g., Visa, Mastercard) involved.',
    `target_endpoint_acquirer_endpoint_id` BIGINT COMMENT 'Identifier of the secondary (fallback) acquirer endpoint.',
    `affected_transaction_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary value of the affected transactions (currency assumed USD).',
    `affected_transaction_volume` BIGINT COMMENT 'Count of individual transactions impacted by the failover.',
    `error_code` STRING COMMENT 'Error code returned by the gateway when the primary endpoint failed.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the failover was triggered by the gateway.',
    `failover_duration_seconds` STRING COMMENT 'Elapsed time from failover start to successful recovery, measured in seconds.',
    `failover_event_status` STRING COMMENT 'Current lifecycle status of the failover event.. Valid values are `in_progress|completed|failed|recovered`',
    `network_name` STRING COMMENT 'Human‑readable name of the payment network.',
    `notes` STRING COMMENT 'Free‑form text for additional context or investigator comments.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the failover event record was first inserted.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the failover event record.',
    `recovery_timestamp` TIMESTAMP COMMENT 'Timestamp when traffic was successfully restored to the target endpoint.',
    `region_code` STRING COMMENT 'Three‑letter country code representing the geographic region of the impacted transactions.',
    `retry_attempts` STRING COMMENT 'Count of automatic retry attempts made on the primary endpoint prior to failover.',
    `sla_breach_flag` BOOLEAN COMMENT 'True if the failover duration exceeded the SLA threshold.',
    `source_endpoint_name` STRING COMMENT 'Human‑readable name of the failed primary endpoint.',
    `target_endpoint_name` STRING COMMENT 'Human‑readable name of the fallback endpoint.',
    `transaction_type` STRING COMMENT 'Category of transactions impacted by the failover.. Valid values are `purchase|refund|reversal|auth|capture`',
    `trigger_reason` STRING COMMENT 'Reason why the primary endpoint was considered unavailable.. Valid values are `timeout|connection_refused|error_threshold|network_failure|other`',
    CONSTRAINT pk_failover_event PRIMARY KEY(`failover_event_id`)
) COMMENT 'Transactional record of each gateway failover occurrence — when a primary acquirer endpoint becomes unavailable and traffic is rerouted to a secondary. Captures failover trigger timestamp, failed endpoint, failover target endpoint, trigger reason (timeout, connection refused, error threshold breach), affected transaction volume, failover duration, and recovery timestamp. Critical for SLA breach analysis and infrastructure resilience reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` (
    `webhook_subscription_id` BIGINT COMMENT 'System-generated unique identifier for the webhook subscription record.',
    `created_by_user_employee_id` BIGINT COMMENT 'Identifier of the internal user who created the subscription.',
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the partner (e.g., payment service provider) associated with the subscription, if applicable.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who created the subscription.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant that owns this webhook subscription.',
    `authentication_method` STRING COMMENT 'Method used to authenticate webhook calls to the target URL.. Valid values are `hmac_sha256|oauth_bearer|basic_auth`',
    `authentication_secret` STRING COMMENT 'Secret key or token used with the selected authentication method (e.g., HMAC secret, OAuth bearer token).',
    `backoff_strategy` STRING COMMENT 'Algorithm used to calculate delay between successive retries.. Valid values are `fixed|exponential|jitter`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subscription record was first created in the system.',
    `effective_from` TIMESTAMP COMMENT 'Timestamp when the subscription becomes active.',
    `effective_until` TIMESTAMP COMMENT 'Timestamp when the subscription expires or is scheduled to terminate (null for indefinite).',
    `encryption_enabled` BOOLEAN COMMENT 'Indicates whether the payload is encrypted at rest or in transit.',
    `encryption_key_reference` STRING COMMENT 'Identifier of the encryption key used to protect the payload.',
    `event_types` STRING COMMENT 'Comma‑separated list of event identifiers (e.g., authorization.approved,capture.completed) the subscriber wishes to receive.',
    `failure_count` STRING COMMENT 'Number of consecutive delivery failures.',
    `ip_allowlist` STRING COMMENT 'Comma‑separated list of IP address ranges permitted to receive webhook calls.',
    `is_test` BOOLEAN COMMENT 'Indicates whether the subscription is for testing purposes only.',
    `last_failure_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent delivery failure.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the subscription.. Valid values are `active|paused|cancelled|expired`',
    `max_payload_size_bytes` BIGINT COMMENT 'Maximum allowed size of the webhook payload in bytes.',
    `max_retry_attempts` STRING COMMENT 'Maximum number of retry attempts before the subscription is marked failed.',
    `notification_endpoint_type` STRING COMMENT 'Transport mechanism for the webhook (e.g., HTTP, HTTPS, message queue).. Valid values are `http|https|queue`',
    `oauth_client_identifier` STRING COMMENT 'Client identifier when OAuth Bearer authentication is used.',
    `oauth_scopes` STRING COMMENT 'Space‑separated list of OAuth scopes granted to the webhook client.',
    `payload_format` STRING COMMENT 'Format of the webhook payload delivered to the target URL.. Valid values are `json|xml|form`',
    `rate_limit_per_minute` STRING COMMENT 'Maximum number of webhook calls allowed per minute for this subscription.',
    `retry_backoff_seconds` STRING COMMENT 'Base number of seconds used in backoff calculations between retries.',
    `retry_policy` STRING COMMENT 'Policy governing how failed webhook deliveries are retried.. Valid values are `none|fixed|exponential`',
    `sla_response_time_seconds` STRING COMMENT 'Target maximum time (in seconds) for the webhook endpoint to acknowledge a delivery.',
    `subscription_code` STRING COMMENT 'Business-facing code used to reference the subscription in external systems and documentation.',
    `subscription_name` STRING COMMENT 'Human‑readable name for the webhook subscription.',
    `subscription_type` STRING COMMENT 'Broad classification of the subscription purpose.. Valid values are `event|transaction|balance|custom`',
    `target_url` STRING COMMENT 'Fully qualified HTTPS endpoint where event notifications are delivered.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the subscription record.',
    `version` STRING COMMENT 'Version number incremented on each configuration change.',
    `webhook_secret_hash` STRING COMMENT 'Hash of the secret used for HMAC verification of incoming webhook calls.',
    `webhook_subscription_description` STRING COMMENT 'Optional free‑form description providing context about the subscription purpose.',
    CONSTRAINT pk_webhook_subscription PRIMARY KEY(`webhook_subscription_id`)
) COMMENT 'Master record for each merchant or partner webhook subscription registered with the gateway. Stores target URL, subscribed event types (authorization.approved, capture.completed, dispute.opened, etc.), authentication method (HMAC-SHA256, OAuth bearer), retry policy, maximum retry attempts, backoff strategy, active status, and subscription creation/expiry dates. SSOT for outbound event notification configuration.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` (
    `webhook_delivery_id` BIGINT COMMENT 'System-generated unique identifier for each webhook delivery attempt.',
    `request_id` BIGINT COMMENT 'Unique identifier for the HTTP request sent to the merchant.. Valid values are `^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$`',
    `webhook_subscription_id` BIGINT COMMENT 'Identifier of the merchant subscription that defines the webhook endpoint and event filters.',
    `attempt_number` STRING COMMENT 'Sequential number of the delivery attempt for this webhook event.',
    `correlation_identifier` STRING COMMENT 'UUID used to correlate this delivery with upstream processing logs.. Valid values are `^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery record was first created in the data lake.',
    `delivery_status` STRING COMMENT 'Current status of the webhook delivery attempt.. Valid values are `delivered|failed|pending|retry_scheduled`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Exact time the webhook delivery attempt was initiated.',
    `endpoint_url` STRING COMMENT 'Full URL of the merchants webhook endpoint.. Valid values are `^https?://.+$`',
    `error_message` STRING COMMENT 'Error details returned by the merchant endpoint when delivery fails.',
    `event_type` STRING COMMENT 'Category of the business event that triggered the webhook notification.. Valid values are `transaction_created|transaction_settled|dispute_opened|chargeback|fraud_alert|settlement_report`',
    `http_status_code` STRING COMMENT 'HTTP response status code returned by the merchant endpoint.',
    `is_final_attempt` BOOLEAN COMMENT 'True if this attempt is the last allowed retry.',
    `max_attempts` STRING COMMENT 'Configured maximum number of retry attempts allowed for the webhook.',
    `next_retry_timestamp` TIMESTAMP COMMENT 'Scheduled timestamp for the next retry attempt when the previous delivery failed.',
    `payload_hash` STRING COMMENT 'SHA-256 hash of the webhook payload to verify integrity.. Valid values are `^[a-fA-F0-9]{64}$`',
    `protocol` STRING COMMENT 'Communication protocol used for the webhook delivery.. Valid values are `REST|SOAP|ISO8583`',
    `response_body_snippet` STRING COMMENT 'Truncated portion of the HTTP response body for diagnostic purposes.',
    `response_latency_ms` STRING COMMENT 'Round‑trip time in milliseconds between sending the webhook and receiving the HTTP response.',
    `retry_policy` STRING COMMENT 'Configured retry strategy for failed webhook deliveries.. Valid values are `exponential|fixed|none`',
    `source_system` STRING COMMENT 'Originating system that generated the webhook event.. Valid values are `gateway|digital_wallet|fraud_platform`',
    `success_flag` BOOLEAN COMMENT 'Indicates whether the webhook delivery was successful (true) or not (false).',
    `throttling_flag` BOOLEAN COMMENT 'Indicates whether delivery was delayed due to rate‑limiting.',
    CONSTRAINT pk_webhook_delivery PRIMARY KEY(`webhook_delivery_id`)
) COMMENT 'Transactional record for each webhook notification delivery attempt made by the gateway. Captures delivery timestamp, linked webhook_subscription_id, event type, payload hash, HTTP response code, response latency, delivery attempt number, retry sequence, success/failure status, and next retry scheduled time. Enables merchant support teams to diagnose missed notifications and replay failed deliveries.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` (
    `rate_limit_policy_id` BIGINT COMMENT 'Unique surrogate key for the rate limit policy.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Rate‑limit policies are negotiated per partner contract; linking supports enforcement reporting and partner‑level usage billing.',
    `employee_id` BIGINT COMMENT 'System user or service that created the policy.',
    `burst_limit` STRING COMMENT 'Number of requests allowed in a short burst exceeding the steady‑state quota.',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance rules that the policy must satisfy (e.g., PCI DSS, GDPR).',
    `consumer_identifier` STRING COMMENT 'Identifier of the consumer subject to the policy (e.g., API key, MID, or IP range).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the policy record was first created.',
    `daily_cap` BIGINT COMMENT 'Maximum total requests allowed in a calendar day.',
    `effective_from` TIMESTAMP COMMENT 'Date‑time when the policy becomes effective.',
    `effective_until` TIMESTAMP COMMENT 'Date‑time when the policy expires; null for indefinite.',
    `enforcement_action` STRING COMMENT 'Action taken when limits are breached: throttle (delay) or block (reject).. Valid values are `throttle|block`',
    `policy_name` STRING COMMENT 'Human‑readable name of the rate limit policy.',
    `policy_type` STRING COMMENT 'Category of consumer scope the policy applies to.. Valid values are `api|mid|ip_range`',
    `rate_limit_policy_description` STRING COMMENT 'Free‑form text describing the purpose and scope of the policy.',
    `rate_limit_policy_status` STRING COMMENT 'Current lifecycle status of the policy.. Valid values are `active|inactive|suspended|pending`',
    `request_quota_rpm` STRING COMMENT 'Maximum allowed requests per minute for the consumer.',
    `request_quota_tps` STRING COMMENT 'Maximum allowed requests per second for the consumer.',
    `throttle_response_code` STRING COMMENT 'HTTP status code returned when the consumer exceeds the quota.. Valid values are `429|503`',
    `tier_name` STRING COMMENT 'Name of the service tier (e.g., Bronze, Silver, Gold) associated with the policy.',
    `updated_by` STRING COMMENT 'System user or service that last updated the policy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the policy.',
    CONSTRAINT pk_rate_limit_policy PRIMARY KEY(`rate_limit_policy_id`)
) COMMENT 'Business-managed rate limiting policy applied to API consumers accessing the gateway. Defines the consumer scope (per API credential, per MID, per IP range), request quota (TPS, RPM, daily cap), burst allowance, throttle response code, policy effective period, and enforcement action (throttle vs. block). Supports tiered service levels and abuse prevention without impacting legitimate high-volume merchants.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` (
    `rate_limit_breach_id` BIGINT COMMENT 'System-generated unique identifier for each rate limit breach event.',
    `rate_limit_policy_id` BIGINT COMMENT 'Unique identifier of the rate‑limit policy that was violated.',
    `alert_sent` BOOLEAN COMMENT 'Indicates whether an operational alert was generated for the breach.',
    `alert_timestamp` TIMESTAMP COMMENT 'Timestamp when the alert for the breach was sent.',
    `breach_description` STRING COMMENT 'Free‑form text describing the context or notes of the breach.',
    `breach_duration_seconds` STRING COMMENT 'Length of time the breach condition persisted before remediation.',
    `breach_timestamp` TIMESTAMP COMMENT 'Exact time the rate limit breach was detected by the gateway.',
    `client_user_agent` STRING COMMENT 'User‑agent string of the client making the request.',
    `compliance_flag` STRING COMMENT 'Indicates whether the breach event complies with internal and regulatory policies.. Valid values are `compliant|non_compliant|under_review`',
    `correlation_identifier` STRING COMMENT 'Unique identifier used to trace the request across distributed systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the breach record was first persisted in the data lake.',
    `data_classification` STRING COMMENT 'Classification level assigned to the breach record for governance purposes.. Valid values are `restricted|confidential|internal|public`',
    `endpoint_path` STRING COMMENT 'REST endpoint path that was accessed when the breach occurred.',
    `enforcement_action` STRING COMMENT 'Action taken by the gateway when the breach occurred.. Valid values are `throttled|blocked|alerted`',
    `exceeded_metric` STRING COMMENT 'Metric (TPS or RPM) that exceeded the configured threshold.. Valid values are `tps|rpm`',
    `is_test_environment` BOOLEAN COMMENT 'Indicates whether the request originated from a test/sandbox environment.',
    `observed_rpm` STRING COMMENT 'Number of transactions per minute observed at the moment of breach.',
    `observed_tps` STRING COMMENT 'Number of transactions per second observed at the moment of breach.',
    `originating_ip` STRING COMMENT 'IP address from which the request that triggered the breach originated.. Valid values are `^((25[0-5]|2[0-4]d|[01]?d?d)(.|$)){4}$`',
    `policy_name` STRING COMMENT 'Human‑readable name of the rate‑limit policy applied to the source.',
    `rate_limit_breach_status` STRING COMMENT 'Current lifecycle status of the breach record.. Valid values are `open|resolved|escalated`',
    `rate_limit_window` STRING COMMENT 'Time window granularity for the applied rate‑limit policy.. Valid values are `per_second|per_minute`',
    `region_code` STRING COMMENT 'Three‑letter ISO country code representing the geographic region of the request.. Valid values are `USA|CAN|GBR|AUS|DEU|FRA`',
    `remediation_action` STRING COMMENT 'Post‑breach action taken to address the underlying cause.. Valid values are `increase_quota|notify_merchant|none`',
    `request_method` STRING COMMENT 'HTTP verb used for the API call that exceeded the rate limit.. Valid values are `GET|POST|PUT|DELETE|PATCH`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the breach was resolved or automatically cleared.',
    `source_identifier` STRING COMMENT 'The actual identifier of the source that caused the breach (e.g., API key value, merchant ID, or IP address).',
    `source_type` STRING COMMENT 'Category of the entity that triggered the breach (API credential, merchant identifier, or IP address).. Valid values are `api_key|merchant_id|ip_address`',
    `threshold_rpm` STRING COMMENT 'Configured RPM limit for the applicable policy.',
    `threshold_tps` STRING COMMENT 'Configured TPS limit for the applicable policy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the breach record.',
    CONSTRAINT pk_rate_limit_breach PRIMARY KEY(`rate_limit_breach_id`)
) COMMENT 'Transactional record of each rate limit breach event detected by the gateway. Captures breach timestamp, offending API credential or MID, applied policy reference, observed TPS/RPM at breach, enforcement action taken (throttled, blocked, alerted), breach duration, and resolution timestamp. Used for capacity planning, merchant communication, and abuse pattern detection.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` (
    `sla_profile_id` BIGINT COMMENT 'Unique identifier for the SLA profile.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Identifier of the acquiring bank or network endpoint covered by the SLA.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: SLAs can be defined per currency; linking to reference.currency supports currency‑specific availability targets.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partners have SLA agreements with the gateway; the FK enables SLA compliance tracking and breach penalty calculations per partner.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant to which the SLA applies.',
    `breach_notification_time_hours` STRING COMMENT 'Maximum time to notify the merchant after an SLA breach.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SLA profile record was created.',
    `effective_from` DATE COMMENT 'Date when the SLA becomes binding.',
    `effective_until` DATE COMMENT 'Date when the SLA expires or is terminated (null for open‑ended).',
    `error_rate_threshold_pct` DECIMAL(18,2) COMMENT 'Maximum allowed error/decline rate expressed as a percentage.',
    `escalation_contact_email` STRING COMMENT 'Email address of the contact to notify on SLA breach.',
    `escalation_contact_phone` STRING COMMENT 'Phone number of the escalation contact.',
    `last_measured_availability_pct` DECIMAL(18,2) COMMENT 'Observed availability percentage during the last measurement window.',
    `last_measured_error_rate_pct` DECIMAL(18,2) COMMENT 'Observed error/decline rate in the last measurement window.',
    `last_measured_latency_p95_ms` STRING COMMENT 'Observed 95th percentile latency in the last measurement window.',
    `last_measured_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent SLA performance measurement.',
    `latency_p50_ms` STRING COMMENT '50th percentile (median) authorization response time in milliseconds.',
    `latency_p95_ms` STRING COMMENT '95th percentile authorization response time in milliseconds.',
    `latency_p99_ms` STRING COMMENT '99th percentile authorization response time in milliseconds.',
    `measurement_metric` STRING COMMENT 'Primary metric used for SLA measurement.. Valid values are `availability|latency|error_rate`',
    `measurement_window_minutes` STRING COMMENT 'Time window over which SLA metrics are aggregated.',
    `monitoring_endpoint` STRING COMMENT 'URL of the endpoint used to monitor SLA metrics.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the SLA.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty applied for SLA breach.',
    `remediation_obligation` STRING COMMENT 'Description of remediation steps or penalties applied when SLA is breached.',
    `sla_code` STRING COMMENT 'Business identifier for the SLA agreement, used in contracts and reporting.',
    `sla_profile_status` STRING COMMENT 'Current lifecycle status of the SLA.. Valid values are `active|inactive|suspended|pending|terminated`',
    `sla_revision_number` STRING COMMENT 'Sequential revision number for tracking changes to the SLA.',
    `sla_type` STRING COMMENT 'Classification of the SLA (e.g., merchant integration, acquirer endpoint, API service, partner).. Valid values are `merchant|acquirer|api|partner`',
    `sla_version` STRING COMMENT 'Version label of the SLA contract (e.g., v1.0, v2.1).',
    `target_availability_pct` DECIMAL(18,2) COMMENT 'Committed service availability expressed as a percentage (e.g., 99.95).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SLA profile.',
    CONSTRAINT pk_sla_profile PRIMARY KEY(`sla_profile_id`)
) COMMENT 'Master record defining the gateway SLA commitments for a merchant integration or acquirer endpoint. Specifies target availability percentage, maximum authorization latency (p50/p95/p99 in ms), maximum error rate threshold, measurement window, breach notification SLA, and remediation obligations. Linked to merchant agreements and used as the baseline for SLA performance measurement.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` (
    `sla_measurement_id` BIGINT COMMENT 'Unique identifier for each SLA measurement entry.',
    `sla_profile_id` BIGINT COMMENT 'Identifier of the SLA profile against which this measurement is evaluated.',
    `availability_percentage` DECIMAL(18,2) COMMENT 'Calculated availability of the gateway service expressed as a percentage of the measurement window.',
    `breach_severity` STRING COMMENT 'Categorical severity of the SLA breach, where higher levels indicate greater impact.. Valid values are `low|medium|high|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA measurement record was first inserted into the data lake.',
    `error_rate_percent` DECIMAL(18,2) COMMENT 'Proportion of total requests that failed, expressed as a percentage of the measurement window.',
    `latency_p50_ms` DECIMAL(18,2) COMMENT 'Median (p50) request latency observed during the measurement window, expressed in milliseconds.',
    `latency_p95_ms` DECIMAL(18,2) COMMENT '95th percentile request latency observed during the measurement window, expressed in milliseconds.',
    `latency_p99_ms` DECIMAL(18,2) COMMENT '99th percentile request latency observed during the measurement window, expressed in milliseconds.',
    `measurement_source` STRING COMMENT 'Origin of the measurement data, e.g., real‑time gateway, batch processing, external monitoring service.. Valid values are `gateway|batch|monitoring|third_party`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Exact time the SLA measurement observation occurred.',
    `measurement_window_end` TIMESTAMP COMMENT 'Timestamp marking the end of the period over which the SLA metrics were aggregated.',
    `measurement_window_start` TIMESTAMP COMMENT 'Timestamp marking the beginning of the period over which the SLA metrics were aggregated.',
    `notes` STRING COMMENT 'Optional textual comments providing context, anomalies, or manual observations related to the measurement.',
    `sla_breach_flag` BOOLEAN COMMENT 'True if any measured metric fell below the SLA target thresholds for the window.',
    `tps` DECIMAL(18,2) COMMENT 'Average number of successful transactions processed per second during the measurement window.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this SLA measurement record.',
    CONSTRAINT pk_sla_measurement PRIMARY KEY(`sla_measurement_id`)
) COMMENT 'Transactional record capturing periodic SLA performance measurements against defined SLA profiles. Stores measurement window start/end, measured availability percentage, p50/p95/p99 latency values, error rate, TPS throughput, SLA breach flag, breach severity, and measurement source. Provides the time-series operational data needed for SLA reporting, breach detection, and contractual compliance.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` (
    `sla_breach_id` BIGINT COMMENT 'Unique surrogate key for each SLA breach event.',
    `sla_profile_id` BIGINT COMMENT 'Reference to the SLA contract/profile that defines the metrics and thresholds.',
    `audit_trail_reference` STRING COMMENT 'Identifier linking to the full audit log that captured the breach lifecycle events.',
    `breach_duration_seconds` BIGINT COMMENT 'Total elapsed time of the breach calculated as end minus start, expressed in seconds.',
    `breach_end_timestamp` TIMESTAMP COMMENT 'Exact time the SLA metric returned to within the contracted threshold.',
    `breach_reference` STRING COMMENT 'Human‑readable reference code assigned to the breach for tracking and communication.',
    `breach_start_timestamp` TIMESTAMP COMMENT 'Exact time the SLA metric first fell outside the contracted threshold.',
    `compliance_status` STRING COMMENT 'Indicates whether the breach remediation complies with internal policies and external regulations.. Valid values are `compliant|non_compliant|pending`',
    `contracted_unit` STRING COMMENT 'Unit associated with the contracted SLA value.. Valid values are `percent|ms|transactions_per_second|seconds|bytes|other`',
    `contracted_value` DECIMAL(18,2) COMMENT 'The SLA‑defined threshold that should not be exceeded (or must be met).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the breach record was first inserted into the data store.',
    `credit_applied_timestamp` TIMESTAMP COMMENT 'Date and time the credit obligation was settled.',
    `credit_currency` STRING COMMENT 'Three‑letter currency code (e.g., USD, EUR) for the credit obligation.. Valid values are `^[A-Z]{3}$`',
    `credit_obligation_amount` DECIMAL(18,2) COMMENT 'Financial credit amount the provider must remit to the impacted party as per SLA contract.',
    `impacted_party_reference` BIGINT COMMENT 'Surrogate key referencing the party that experienced the SLA breach.',
    `impacted_party_type` STRING COMMENT 'Classifies whether the breach affected a merchant, acquiring bank, partner, or other entity.. Valid values are `merchant|acquirer|partner|other`',
    `is_credit_applied` BOOLEAN COMMENT 'True if the contractual credit has been posted to the impacted party.',
    `measured_unit` STRING COMMENT 'Unit associated with the measured value (e.g., percent, ms).. Valid values are `percent|ms|transactions_per_second|seconds|bytes|other`',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric value recorded for the metric while the breach was active.',
    `metric` STRING COMMENT 'The specific SLA metric (e.g., availability, latency) that triggered the breach.. Valid values are `availability|latency|error_rate|throughput|transaction_rate|other`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True when the breach triggers mandatory regulatory reporting (e.g., AML, PCI).',
    `remediation_action` STRING COMMENT 'Description of the corrective steps performed to resolve the breach.',
    `root_cause_category` STRING COMMENT 'High‑level classification of why the SLA breach occurred.. Valid values are `network|hardware|software|configuration|external|unknown`',
    `severity` STRING COMMENT 'Business‑defined severity level used for escalation and penalty calculation.. Valid values are `low|medium|high|critical`',
    `sla_breach_description` STRING COMMENT 'Additional narrative details about the breach, context, or observations.',
    `sla_breach_status` STRING COMMENT 'Indicates whether the breach is still open, under investigation, resolved, or closed.. Valid values are `open|investigating|resolved|closed`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the breach record.',
    CONSTRAINT pk_sla_breach PRIMARY KEY(`sla_breach_id`)
) COMMENT 'Transactional record of each confirmed SLA breach event against a gateway SLA profile. Captures breach start/end timestamps, breached metric (availability, latency, error rate), measured vs. contracted value, impacted merchant or acquirer, breach severity classification, root cause category, remediation action taken, and credit obligation triggered. Feeds contractual penalty calculations and merchant communication workflows.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` (
    `sdk_version_id` BIGINT COMMENT 'Unique surrogate key for each SDK version record.',
    `api_compatibility_version` STRING COMMENT 'Version of the gateway API that this SDK is compatible with.',
    `certification_body` STRING COMMENT 'Organization that performed the PCI DSS certification (e.g., PCI Security Standards Council).',
    `certification_date` DATE COMMENT 'Date when the SDK achieved PCI DSS certification.',
    `changelog_summary` STRING COMMENT 'Brief description of functional and bug‑fix changes introduced in this SDK version.',
    `checksum_sha256` STRING COMMENT 'SHA‑256 hash of the SDK package for integrity verification.',
    `checksum_type` STRING COMMENT 'Algorithm used to generate the checksum.. Valid values are `sha256|md5|sha1`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SDK version record was first created in the data lake.',
    `deprecation_date` DATE COMMENT 'Date after which the SDK version is considered deprecated and should no longer be used for new integrations.',
    `documentation_url` STRING COMMENT 'Link to the SDK developer documentation.',
    `download_url` STRING COMMENT 'Secure URL from which the SDK package can be downloaded.',
    `end_of_life_date` DATE COMMENT 'Final date after which the SDK version will be retired and unsupported.',
    `file_size_bytes` BIGINT COMMENT 'Size of the SDK binary/package in bytes.',
    `is_mandatory_update` BOOLEAN COMMENT 'Indicates whether merchants must upgrade to this SDK version to remain compliant.',
    `language_support` STRING COMMENT 'Comma‑separated list of programming languages or locales supported by the SDK.',
    `minimum_os_version` STRING COMMENT 'Lowest operating system version required for the SDK to function.',
    `minimum_runtime_version` STRING COMMENT 'Minimum version of the runtime environment (e.g., Java, .NET) required.',
    `pci_dss_compliance_status` STRING COMMENT 'Current PCI DSS compliance certification status of the SDK.. Valid values are `compliant|non_compliant|pending`',
    `platform` STRING COMMENT 'Technology platform the SDK targets (e.g., iOS, Android, JavaScript, Java, .NET, PHP, Python).',
    `release_date` DATE COMMENT 'Calendar date when the SDK version was first made publicly available.',
    `release_notes` STRING COMMENT 'Full release notes detailing changes, bug fixes, and migration guidance.',
    `sdk_type` STRING COMMENT 'Classification of the SDK based on deployment model.. Valid values are `mobile|web|server|desktop`',
    `sdk_version_status` STRING COMMENT 'Current lifecycle state of the SDK version.. Valid values are `active|deprecated|retired|planned`',
    `support_contact_email` STRING COMMENT 'Email address for technical support related to this SDK version.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `support_contact_phone` STRING COMMENT 'Phone number for technical support related to this SDK version.',
    `supported_features` STRING COMMENT 'Comma‑separated list of major features (e.g., tokenization, 3‑DS, fraud scoring) available in this SDK version.',
    `supported_payment_methods` STRING COMMENT 'Comma‑separated list of payment methods (e.g., card, ACH, digital wallet) the SDK can process. [ENUM-REF-CANDIDATE: card|ach|digital_wallet|bank_transfer|crypto|other — promote to reference product]',
    `updated_by` STRING COMMENT 'Identifier of the internal user or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SDK version record.',
    `version` STRING COMMENT 'Human‑readable version label (e.g., "v2.3.1"). Serves as the identity label for the SDK resource.',
    `version_code` STRING COMMENT 'Canonical version code used internally and in external contracts; uniquely identifies the SDK release.',
    `created_by` STRING COMMENT 'Identifier of the internal user or system that created the record.',
    CONSTRAINT pk_sdk_version PRIMARY KEY(`sdk_version_id`)
) COMMENT 'Master record for each published version of the payment gateway SDK (iOS, Android, JavaScript, Java, .NET, PHP, Python). Stores SDK platform, version number, release date, deprecation date, end-of-life date, minimum OS/runtime requirements, supported payment methods, changelog summary, download URL, and PCI DSS compliance certification status. SSOT for SDK lifecycle management and merchant upgrade tracking.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` (
    `merchant_sdk_adoption_id` BIGINT COMMENT 'Unique identifier for each SDK adoption record linking a merchant integration to a specific SDK version.',
    `merchant_integration_id` BIGINT COMMENT 'Identifier of the merchant integration (API/SDK configuration) that is adopting the SDK version.',
    `sdk_version_id` BIGINT COMMENT 'Identifier of the SDK version being used by the merchant integration.',
    `adoption_date` DATE COMMENT 'Date when the merchant integration first started using the SDK version.',
    `compliance_required` BOOLEAN COMMENT 'True if the SDK version must meet specific regulatory or PCI DSS compliance criteria for the merchant.',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the SDK version for the merchant integration.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the adoption record was initially created in the data lake.',
    `current_sdk_status` STRING COMMENT 'Operational status of the SDK version as observed for the merchant integration.. Valid values are `active|deprecated|retired|unsupported`',
    `forced_upgrade_deadline` DATE COMMENT 'Date by which the merchant must upgrade to a supported SDK version to remain compliant with PCI DSS or internal policies.',
    `last_seen_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful transaction or heartbeat observed for this SDK version on the merchant integration.',
    `notes` STRING COMMENT 'Free‑form notes captured by the gateway team regarding the adoption, exceptions, or special handling.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk score (0‑100) assigned to the SDK version based on vulnerability scanning and fraud exposure.',
    `sdk_release_date` DATE COMMENT 'Calendar date on which the SDK version was released to merchants.',
    `sdk_release_notes_url` STRING COMMENT 'Web address linking to the release notes or changelog for the SDK version.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the adoption record.',
    `upgrade_notification_sent` BOOLEAN COMMENT 'Indicates whether a notification to upgrade to a newer SDK version has been sent to the merchant.',
    CONSTRAINT pk_merchant_sdk_adoption PRIMARY KEY(`merchant_sdk_adoption_id`)
) COMMENT 'Association record tracking which SDK version each merchant integration is actively using. Captures merchant_integration_id, sdk_version_id, adoption date, last seen timestamp, upgrade notification sent flag, and forced upgrade deadline. Enables the gateway team to identify merchants on deprecated SDK versions, drive upgrade campaigns, and enforce PCI DSS compliance cutoffs.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` (
    `endpoint_health_id` BIGINT COMMENT 'Unique identifier for each health check observation of an acquirer endpoint.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Identifier of the registered acquirer endpoint that was health‑checked.',
    `check_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the health check was performed.',
    `circuit_breaker_state` STRING COMMENT 'Current state of the circuit‑breaker controlling traffic to the endpoint.. Valid values are `closed|open|half_open`',
    `consecutive_failure_count` STRING COMMENT 'Number of back‑to‑back failed health checks for this endpoint.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this health‑check record was first inserted.',
    `endpoint_health_status` STRING COMMENT 'Result of the health check – success indicates the endpoint responded as expected.. Valid values are `success|failure`',
    `error_message` STRING COMMENT 'Human‑readable error description when a health check fails.',
    `failure_reason_code` STRING COMMENT 'Code categorising why a health check failed.. Valid values are `timeout|connection_refused|invalid_response|authentication_failed|unknown_error`',
    `health_check_type` STRING COMMENT 'Mechanism used for the health check (e.g., TCP ping, ISO 8583 echo, REST heartbeat).. Valid values are `tcp_ping|iso8583_echo|rest_heartbeat`',
    `health_score` STRING COMMENT 'Composite score (0‑100) reflecting overall endpoint health based on recent checks.',
    `last_success_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful health check for this endpoint.',
    `protocol` STRING COMMENT 'Communication protocol exposed by the acquirer endpoint.. Valid values are `iso8583|rest|soap`',
    `region_code` STRING COMMENT 'Three‑letter ISO country code indicating the region where the endpoint resides.. Valid values are `^[A-Z]{3}$`',
    `response_time_ms` STRING COMMENT 'Measured round‑trip time of the health check in milliseconds.',
    `sla_response_time_ms` STRING COMMENT 'Maximum response time promised in the SLA for this endpoint.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this health‑check record.',
    CONSTRAINT pk_endpoint_health PRIMARY KEY(`endpoint_health_id`)
) COMMENT 'Transactional record capturing periodic health check results for each registered acquirer endpoint. Stores check timestamp, endpoint reference, health check type (TCP ping, ISO 8583 echo, REST heartbeat), response time (ms), success/failure status, consecutive failure count, circuit breaker state (closed/open/half-open), and health score. Drives automated failover decisions and capacity management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` (
    `tls_certificate_id` BIGINT COMMENT 'Unique system-generated identifier for the TLS/SSL certificate record.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Foreign key linking to gateway.acquirer_endpoint. Business justification: TLS certificates are bound to specific acquirer endpoints; FK replaces free-text endpoint reference.',
    `auto_renewal` BOOLEAN COMMENT 'Indicates whether the certificate is set to renew automatically before expiry.',
    `certificate_profile` STRING COMMENT 'Level of validation performed by the CA (Extended Validation, Organization Validation, Domain Validation, Self‑Signed).. Valid values are `EV|OV|DV|Self_Signed`',
    `certificate_type` STRING COMMENT 'Classification of the certificate purpose.. Valid values are `server|client|code_signing|root|intermediate`',
    `compliance_pci_dss` STRING COMMENT 'Indicates whether the certificate meets PCI DSS requirements for encryption.. Valid values are `compliant|non_compliant|not_applicable`',
    `country_code` STRING COMMENT 'Two‑letter ISO 3166‑1 country code from the certificate subject.. Valid values are `^[A-Z]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certificate record was first created in the data lake.',
    `email_address` STRING COMMENT 'Email address listed in the certificate for administrative contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `expiration_alert_sent` BOOLEAN COMMENT 'Indicates whether an expiry alert has been sent to the operations team.',
    `fingerprint_sha256` STRING COMMENT 'Hexadecimal SHA-256 hash of the certificate, used for integrity verification.. Valid values are `^[A-Fa-f0-9]{64}$`',
    `is_wildcard` BOOLEAN COMMENT 'True if the certificate covers a wildcard domain (e.g., *.paymentsfintech.com).',
    `issuer` STRING COMMENT 'Distinguished Name of the Certificate Authority (CA) that issued the certificate.',
    `key_algorithm` STRING COMMENT 'Cryptographic algorithm used for the public key, e.g., RSA or ECDSA.. Valid values are `RSA|ECDSA|ED25519|DSA`',
    `key_length_bits` STRING COMMENT 'Size of the public key in bits, e.g., 2048, 3072, 4096.',
    `last_checked_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful health‑check of the certificates endpoint.',
    `locality` STRING COMMENT 'City component of the certificate subject.',
    `notes` STRING COMMENT 'Additional free‑text information or operational comments about the certificate.',
    `organization_name` STRING COMMENT 'Legal organization name extracted from the certificate subject.',
    `organizational_unit` STRING COMMENT 'Organizational unit (OU) component of the certificate subject.',
    `renewal_due_date` DATE COMMENT 'Date by which the certificate should be renewed to avoid service interruption.',
    `revocation_reason` STRING COMMENT 'Human‑readable reason why the certificate was revoked, if applicable.',
    `revocation_status` STRING COMMENT 'Current revocation state of the certificate.. Valid values are `valid|revoked|suspended`',
    `revocation_timestamp` TIMESTAMP COMMENT 'Date‑time when the certificate was revoked.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the issuing CA, used to identify the certificate.. Valid values are `^[A-F0-9]+$`',
    `state_or_province` STRING COMMENT 'State or province component of the certificate subject.',
    `subject` STRING COMMENT 'Distinguished Name (DN) representing the entity the certificate is issued to, e.g., CN=api.paymentsfintech.com.',
    `thumbprint` STRING COMMENT 'Legacy SHA-1 hash of the certificate, often used by older systems.. Valid values are `^[A-Fa-f0-9]{40}$`',
    `tls_certificate_status` STRING COMMENT 'Current lifecycle status of the certificate within the gateway.. Valid values are `active|inactive|expired|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certificate record.',
    `usage` STRING COMMENT 'Indicates whether the certificate is used for inbound, outbound, or both traffic.. Valid values are `inbound|outbound|both`',
    `valid_from` DATE COMMENT 'Date on which the certificate becomes valid.',
    `valid_to` DATE COMMENT 'Date on which the certificate expires and must be renewed.',
    CONSTRAINT pk_tls_certificate PRIMARY KEY(`tls_certificate_id`)
) COMMENT 'Master record for TLS/SSL certificates used to secure gateway connections — both inbound (merchant-facing) and outbound (acquirer-facing). Stores certificate subject, issuer CA, serial number, fingerprint (SHA-256), valid-from/valid-to dates, key algorithm, key length, associated endpoint or integration, auto-renewal flag, and revocation status. Enables proactive certificate expiry management and PCI DSS compliance tracking.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` (
    `ip_allowlist_id` BIGINT COMMENT 'Unique surrogate key for each allowlist or blocklist record.',
    `gateway_api_credential_id` BIGINT COMMENT 'Foreign key hint to the API credential (client) that this IP rule protects.',
    `compliance_status` STRING COMMENT 'Indicates whether the rule meets current PCI DSS network access control requirements.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the allowlist entry was initially persisted.',
    `effective_from` DATE COMMENT 'The calendar date from which the IP rule is enforced.',
    `effective_until` DATE COMMENT 'The calendar date after which the IP rule is no longer applied.',
    `enforcement_action` STRING COMMENT 'Specifies the system response: reject the request, monitor for review, or raise an alert.. Valid values are `reject|monitor|alert`',
    `geographic_region` STRING COMMENT 'Region used for regulatory or risk‑based routing decisions.. Valid values are `^[A-Z]{3}$`',
    `ip_allowlist_status` STRING COMMENT 'Indicates whether the rule is currently enforced, awaiting activation, or revoked.. Valid values are `active|inactive|pending|revoked`',
    `ip_range` STRING COMMENT 'The IPv4 address or CIDR block that the rule applies to.. Valid values are `^([0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}$`',
    `is_rate_limited` BOOLEAN COMMENT 'True if this IP rule includes a custom rate‑limit configuration.',
    `justification` STRING COMMENT 'Narrative explaining why the IP address or range is allowed or blocked.',
    `list_type` STRING COMMENT 'Specifies if the IP range is permitted (allow) or denied (block) for gateway access.. Valid values are `allow|block`',
    `merchant_mid` STRING COMMENT 'The merchants unique identifier to which the IP rule applies.',
    `notes` STRING COMMENT 'Additional context or remarks entered by administrators.',
    `rate_limit_per_second` STRING COMMENT 'Maximum number of API calls allowed per second for this IP range when rate‑limit override is active.',
    `source_system` STRING COMMENT 'Name of the upstream system (e.g., Gateway Config Service) that supplied the data.',
    `updated_by` STRING COMMENT 'Identifier of the person or process that last modified the rule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the allowlist entry.',
    `created_by` STRING COMMENT 'Identifier of the person or process that created the rule.',
    CONSTRAINT pk_ip_allowlist PRIMARY KEY(`ip_allowlist_id`)
) COMMENT 'Master record defining IP address allowlists and blocklists applied to gateway API access. Stores the associated API credential or MID, IP address or CIDR range, list type (allow/block), geographic region, effective date range, enforcement action, and the business justification for the entry. Supports PCI DSS network access control requirements and fraud prevention at the network perimeter.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`event_log` (
    `event_log_id` BIGINT COMMENT 'Unique immutable identifier for each gateway event log record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Event logs must attribute actions to the responsible partner for audit trails, dispute resolution, and regulatory reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the actor (system user, service account, or automated process) that performed the action.',
    `sla_profile_id` BIGINT COMMENT 'Reference to the SLA profile applicable at the time of the event.',
    `actor_type` STRING COMMENT 'Classification of the actor (e.g., user, service, system).',
    `after_state` STRING COMMENT 'JSON‑encoded snapshot of the entitys state after the event.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first persisted in the data lake.',
    `before_state` STRING COMMENT 'JSON‑encoded snapshot of the entitys state prior to the event.',
    `compliance_status` STRING COMMENT 'Indicates whether the event complies with applicable regulations and internal policies.. Valid values are `compliant|non_compliant|pending`',
    `correlation_identifier` STRING COMMENT 'Identifier used to correlate this event with related events across systems.',
    `entity_reference` BIGINT COMMENT 'Unique identifier of the specific entity instance that the event relates to.',
    `entity_type` STRING COMMENT 'Business entity type impacted by the event (e.g., api_credential, routing_rule, endpoint).',
    `event_log_description` STRING COMMENT 'Human‑readable description summarizing the event.',
    `event_payload` STRING COMMENT 'Additional free‑form data or context associated with the event.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date and time when the event occurred in the gateway domain.',
    `event_type` STRING COMMENT 'Categorical discriminator indicating the kind of lifecycle event captured.. Valid values are `credential_rotation|routing_rule_activation|endpoint_registration|sla_profile_change|webhook_subscription_modification|failover_activation`',
    `ip_address` STRING COMMENT 'IP address from which the event originated, used for security and audit purposes.',
    `outcome` STRING COMMENT 'Result of the event execution.. Valid values are `success|failure|partial`',
    `severity` STRING COMMENT 'Severity level indicating the impact or urgency of the event.. Valid values are `info|warning|error|critical`',
    `source_system` STRING COMMENT 'Name of the originating system or component that generated the event (e.g., gateway, fraud_platform).',
    `user_agent` STRING COMMENT 'User‑agent header value identifying client software or device.',
    CONSTRAINT pk_event_log PRIMARY KEY(`event_log_id`)
) COMMENT 'Immutable business-level event log capturing significant lifecycle events within the gateway domain — credential rotations, routing rule activations, endpoint registrations, SLA profile changes, webhook subscription modifications, and failover activations. Stores event type, actor (system or user), affected entity type and ID, before/after state summary, event timestamp, and source system. Distinct from technical system logs — this is the business audit trail required for PCI DSS and regulatory compliance.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` (
    `threeds_config_id` BIGINT COMMENT 'Unique surrogate key for each 3-D Secure configuration record.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: 3‑DS settings are scheme‑specific; linking to reference_card_scheme provides scheme metadata for compliance.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: 3‑DS configuration may vary by currency; FK to reference.currency enables correct rule selection.',
    `mcc_id` BIGINT COMMENT 'Foreign key linking to reference.mcc. Business justification: MCC overrides in 3‑DS flow require authoritative MCC data to apply correct exemption rules.',
    `region_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_region. Business justification: 3DS configuration varies by processing region; linking to gateway_region provides regional control.',
    `acquirer_bin` STRING COMMENT 'Six‑digit BIN of the acquiring bank used for routing the 3‑DS flow.. Valid values are `^d{6}$`',
    `audit_log_reference` STRING COMMENT 'Reference to the audit log entry that records changes to this configuration.',
    `authentication_flow` STRING COMMENT 'Method used to present the 3‑DS challenge to the cardholder.. Valid values are `redirect|embedded|native`',
    `challenge_preference` STRING COMMENT 'Merchant‑specified preference for challenge flow during authentication.. Valid values are `no_preference|no_challenge|challenge_requested`',
    `challenge_timeout_seconds` STRING COMMENT 'Time limit in seconds for the challenge response.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework(s) governing this configuration.. Valid values are `PSD2|PCI_DSS|EMVCo`',
    `compliance_status` STRING COMMENT 'Result of the latest compliance validation.. Valid values are `pass|fail|pending`',
    `config_code` STRING COMMENT 'Business code used to reference the configuration in external systems.',
    `config_name` STRING COMMENT 'Human‑readable name identifying the 3‑DS configuration.',
    `config_type` STRING COMMENT 'Indicates whether the configuration follows a standard template or is custom‑built for a merchant.. Valid values are `standard|custom`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the configuration record was first created.',
    `effective_from` DATE COMMENT 'Date from which the configuration becomes active.',
    `effective_until` DATE COMMENT 'Date after which the configuration is no longer active (null for open‑ended).',
    `exemption_rules` STRING COMMENT 'Comma‑separated list of exemption criteria applied to the configuration.. Valid values are `tra|low_value|trusted_beneficiary|none`',
    `frictionless_flow_eligible` BOOLEAN COMMENT 'Indicates whether transactions can be processed without a challenge under this configuration.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this configuration is the default for the merchant.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance review of the configuration.',
    `max_challenge_attempts` STRING COMMENT 'Maximum number of challenge attempts allowed before transaction decline.',
    `protocol_version` STRING COMMENT 'Version of the 3‑DS protocol applied (e.g., 1.0 or 2.0).. Valid values are `1.0|2.0`',
    `requestor_identifier` STRING COMMENT 'Identifier of the entity (typically the merchant) that initiates the 3‑DS authentication request.',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Maximum risk score allowed for frictionless flow; higher scores trigger challenge.',
    `sca_compliance_status` STRING COMMENT 'Result of PSD2 SCA compliance evaluation for the configuration.. Valid values are `compliant|non_compliant|exempt`',
    `threeds_config_description` STRING COMMENT 'Free‑form text describing the purpose and scope of the configuration.',
    `threeds_config_status` STRING COMMENT 'Current lifecycle state of the 3‑DS configuration.. Valid values are `active|inactive|deprecated|pending`',
    `transaction_type` STRING COMMENT 'Category of transaction to which the configuration applies.. Valid values are `ecommerce|mcommerce|pos|recurring|auth_only`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the configuration.',
    `version` STRING COMMENT 'Semantic version string (e.g., 1.2.3) for the configuration.',
    CONSTRAINT pk_threeds_config PRIMARY KEY(`threeds_config_id`)
) COMMENT 'Master configuration record for 3-D Secure (3DS v1 and v2) authentication settings applied per merchant integration. Stores 3DS protocol version, requestor ID, acquirer BIN, merchant category code override, challenge preference (no-preference, no-challenge, challenge-requested), exemption rules (TRA, low-value, trusted-beneficiary), frictionless flow eligibility, and SCA compliance status under PSD2. Governs how the gateway invokes 3DS for each merchant.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` (
    `gateway3ds_authentication_id` BIGINT COMMENT 'System‑generated unique identifier for each 3‑DS authentication attempt.',
    `cardholder_cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder whose payment instrument was used.',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder whose payment instrument was used.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant involved in the transaction.',
    `transaction_id` BIGINT COMMENT 'Identifier assigned by the Directory Server for this authentication flow.',
    `request_id` BIGINT COMMENT 'Identifier of the original payment request that triggered the 3‑DS authentication.',
    `acs_response_code` STRING COMMENT 'Response code returned by the Access Control Server.',
    `authentication_latency_ms` STRING COMMENT 'Time in milliseconds between authentication request and final response.',
    `authentication_message` STRING COMMENT 'Human‑readable message describing the authentication outcome.',
    `authentication_method` STRING COMMENT 'Method used for authentication (static, dynamic, frictionless, or challenge).. Valid values are `static|dynamic|frictionless|challenge`',
    `authentication_result` STRING COMMENT 'Outcome of the 3‑DS authentication: Y=success, N=failed, A=attempted, U=unavailable, R=retry, C=challenge.. Valid values are `Y|N|A|U|R|C`',
    `authentication_status` STRING COMMENT 'Current processing state of the authentication record.. Valid values are `processed|failed|pending`',
    `authentication_timestamp` TIMESTAMP COMMENT 'Exact time the 3‑DS authentication was performed.',
    `card_brand` STRING COMMENT 'Brand of the payment card used in the transaction.. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `cavv` STRING COMMENT 'Cryptographic value generated by the cardholders device for authentication.',
    `challenge_indicator` STRING COMMENT 'Indicates whether a challenge is required (01‑05 per 3‑DS spec).. Valid values are `01|02|03|04|05`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the authentication record was first inserted.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the transaction amount.. Valid values are `^[A-Z]{3}$`',
    `device_fingerprint` STRING COMMENT 'Hashed identifier of the device used for authentication.',
    `eci_value` DECIMAL(18,2) COMMENT 'ECI code indicating the level of authentication and liability shift.',
    `exemption_applied` STRING COMMENT 'Exemption code applied to bypass full authentication (e.g., low‑value, trusted‑merchant).',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the authentication was flagged as fraudulent.',
    `liability_shift` STRING COMMENT 'Entity (merchant, issuer, or none) that bears liability after authentication.. Valid values are `merchant|issuer|none`',
    `liability_shift_reason` STRING COMMENT 'Explanation for the liability shift outcome, if applicable.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk assessment generated by fraud engine for this authentication.',
    `source_ip_address` STRING COMMENT 'IP address of the client device that initiated the authentication.. Valid values are `^[0-9]{1,3}(.[0-9]{1,3}){3}$`',
    `three_ds_version` STRING COMMENT 'Version of the 3‑DS protocol used for this authentication (e.g., 2.1.0).',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the underlying transaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the authentication record.',
    CONSTRAINT pk_gateway3ds_authentication PRIMARY KEY(`gateway3ds_authentication_id`)
) COMMENT 'Transactional record for each 3-D Secure authentication attempt processed through the gateway. Captures authentication timestamp, linked gateway_request_id, 3DS version, authentication result (Y/N/A/U/R/C), ECI value, CAVV/AAV, DS transaction ID, ACS transaction ID, challenge indicator, exemption applied, authentication latency, and liability shift outcome. SSOT for 3DS authentication events within the gateway.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` (
    `tokenization_request_id` BIGINT COMMENT 'Unique system-generated identifier for the tokenization request record.',
    `cardholder_profile_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_profile. Business justification: Supports tokenization audit linking each token request to the cardholder profile, satisfying PCI‑DSS tokenization reporting and risk analysis.',
    `device_id` BIGINT COMMENT 'Identifier of the device to which the token is bound (e.g., mobile device ID).',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: Tokenization requests are issued by a specific wallet; linking enables audit of token issuance per wallet and regulatory token‑lifecycle tracking.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant (MID) that originated the tokenization request.',
    `region_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_region. Business justification: Tokenization requests are processed per gateway region; linking enables region-level reporting.',
    `assurance_level` STRING COMMENT 'Level of confidence in the tokenization process, reflecting authentication strength.. Valid values are `low|medium|high`',
    `compliance_check_passed` BOOLEAN COMMENT 'Indicates whether the request satisfied all applicable PCI/DSS and regulatory compliance checks.',
    `compliance_rule_set` STRING COMMENT 'Identifier of the compliance rule set applied during tokenization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tokenization request record was first created in the data lake.',
    `failure_reason` STRING COMMENT 'Human‑readable description of why a tokenization request failed, if applicable.',
    `fraud_flag` BOOLEAN COMMENT 'True if the request was flagged as potentially fraudulent.',
    `fraud_reason` STRING COMMENT 'Reason or rule that triggered the fraud flag.',
    `geo_city` STRING COMMENT 'City name associated with the request IP address.',
    `geo_country_code` STRING COMMENT 'Three‑letter ISO 3166‑1 country code of the request origin.',
    `ip_address` STRING COMMENT 'Source IP address of the tokenization request.',
    `outcome_status` STRING COMMENT 'Result of the tokenization request: success, failure, or partial (e.g., token created but with warnings).. Valid values are `success|failure|partial`',
    `pan_hash` STRING COMMENT 'Cryptographic hash of the PAN; stored to avoid retaining raw PAN data.',
    `processing_latency_ms` STRING COMMENT 'Time in milliseconds taken to process the tokenization request.',
    `request_channel` STRING COMMENT 'Channel through which the request was made (web, mobile app, POS, mPOS).. Valid values are `web|mobile|pos|mpos`',
    `request_reference` STRING COMMENT 'External reference supplied by the merchant to correlate the tokenization request with their own systems.',
    `request_source` STRING COMMENT 'Origin of the request call: API, SDK, or webhook.. Valid values are `api|sdk|webhook`',
    `request_timestamp` TIMESTAMP COMMENT 'Exact date and time when the tokenization request was received by the gateway.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score assigned by the fraud detection engine for this request.',
    `sla_achieved_flag` BOOLEAN COMMENT 'True if processing latency met or beat the SLA target.',
    `sla_target_ms` STRING COMMENT 'Service‑level‑agreement target latency for tokenization processing.',
    `token_expiry_date` DATE COMMENT 'Date on which the issued token becomes invalid.',
    `token_service_provider` STRING COMMENT 'Name or code of the token service provider that issued the token.',
    `token_type` STRING COMMENT 'Indicates the category of token generated: network token, gateway token, or device PAN (DPAN).. Valid values are `network|gateway|dpan`',
    `token_value` DECIMAL(18,2) COMMENT 'The actual token string issued to replace the PAN; treated as PCI-sensitive data.',
    `tokenization_method` STRING COMMENT 'Method used to generate the token: client‑side, server‑side, or hybrid.. Valid values are `client_side|server_side|hybrid`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tokenization request record.',
    CONSTRAINT pk_tokenization_request PRIMARY KEY(`tokenization_request_id`)
) COMMENT 'Transactional record for each network tokenization or gateway tokenization request processed through the gateway. Captures request timestamp, originating MID, PAN hash (never raw PAN), token type (DPAN, gateway token, network token), TSP reference, tokenization outcome, token expiry, device binding reference, and assurance level. Supports PCI DSS scope reduction by tracking the tokenization event without storing sensitive cardholder data.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`region` (
    `region_id` BIGINT COMMENT 'Unique identifier for the gateway processing region.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Each gateway region is subject to a specific regulatory jurisdiction; linking enables jurisdiction‑based compliance reporting.',
    `active_status` STRING COMMENT 'Current operational status of the region.. Valid values are `active|inactive|decommissioned`',
    `audit_status` STRING COMMENT 'Result of the latest audit (passed, failed, or pending).. Valid values are `passed|failed|pending`',
    `compliance_status` STRING COMMENT 'Current compliance posture of the region against applicable regulations.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the region record was first created.',
    `cross_border_fee_applicable` BOOLEAN COMMENT 'True if cross‑border transaction fees are applied for this region.',
    `data_center_type` STRING COMMENT 'Classification of the data center role for the region.. Valid values are `primary|secondary|disaster_recovery`',
    `data_residency_requirements` STRING COMMENT 'Statement of data residency constraints (e.g., local‑only, allowed cross‑border).',
    `effective_from` DATE COMMENT 'Date when the region definition becomes effective.',
    `effective_until` DATE COMMENT 'Date when the region definition expires or is superseded (null if open‑ended).',
    `encryption_standard` STRING COMMENT 'Encryption protocol used for data in transit within the region.. Valid values are `TLS1.0|TLS1.1|TLS1.2|TLS1.3`',
    `jurisdiction_data_protection_law` STRING COMMENT 'Primary data‑protection legislation governing the region.. Valid values are `GDPR|CCPA|PDPA|LGPD|None`',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance audit for the region.',
    `lifecycle_status` STRING COMMENT 'Lifecycle stage of the region within the gateway ecosystem.. Valid values are `operational|maintenance|retired|pending`',
    `max_transactions_per_second` STRING COMMENT 'Peak transaction throughput the region is provisioned to handle.',
    `network_latency_ms` STRING COMMENT 'Average network latency observed from the region to major acquirers.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the region.',
    `primary_data_center_location` STRING COMMENT 'Geographic location (city, country) of the primary data center serving the region.',
    `region_code` STRING COMMENT 'Short alphanumeric code identifying the processing region (e.g., NA1, EU2).',
    `region_description` STRING COMMENT 'Free‑form description of the regions purpose and characteristics.',
    `region_name` STRING COMMENT 'Human‑readable name of the processing region.',
    `regulatory_jurisdiction` STRING COMMENT 'Regulatory authority or framework governing payments in the region (e.g., FCA, OCC, PSD2).',
    `risk_level` STRING COMMENT 'Risk rating for the region based on operational, regulatory, and security factors.. Valid values are `low|medium|high|critical`',
    `secondary_data_center_location` STRING COMMENT 'Location of the disaster‑recovery / secondary data center for the region.',
    `settlement_currency` STRING COMMENT 'Default currency used for settlement of transactions processed in the region.',
    `sla_target_response_time_ms` STRING COMMENT 'Maximum allowed response time for gateway operations in this region, per SLA.',
    `supported_card_schemes` STRING COMMENT 'Comma‑separated list of card schemes (e.g., Visa, Mastercard, Amex) supported in this region. [ENUM-REF-CANDIDATE: Visa|Mastercard|Amex|Discover|JCB|UnionPay|Other — promote to reference product]',
    `supported_currencies` STRING COMMENT 'Comma‑separated list of ISO 4217 currency codes accepted in the region. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|AUD|CAD|CHF|CNY|INR|Other — promote to reference product]',
    `timezone` STRING COMMENT 'IANA timezone identifier for the region (e.g., America/New_York).',
    `tokenization_supported` BOOLEAN COMMENT 'Indicates whether tokenization services are available in the region.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the region record.',
    CONSTRAINT pk_region PRIMARY KEY(`region_id`)
) COMMENT 'Reference record defining the geographic processing regions in which the gateway operates. Stores region code, region name, primary data center location, secondary (DR) data center location, supported card schemes, supported currencies, regulatory jurisdiction, data residency requirements, and active status. Used to assign merchant integrations and acquirer endpoints to the correct processing region for latency optimization and data sovereignty compliance.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`api_version` (
    `api_version_id` BIGINT COMMENT 'Unique system-generated identifier for the API version record.',
    `sla_profile_id` BIGINT COMMENT 'Identifier of the Service‑Level‑Agreement profile governing performance expectations for this API version.',
    `api_documentation_url` STRING COMMENT 'Link to the formal OpenAPI/Swagger documentation for this version.',
    `api_version_description` STRING COMMENT 'Free‑form description of the purpose and scope of the API version.',
    `api_version_status` STRING COMMENT 'Current lifecycle status of the API version.. Valid values are `active|deprecated|sunset|retired|draft`',
    `authentication_methods` STRING COMMENT 'Pipe‑separated list of authentication mechanisms supported by this API version.. Valid values are `api_key|oauth2|jwt|hmac|basic`',
    `backward_compatibility_matrix` STRING COMMENT 'Structured description (e.g., JSON) of which prior API features remain compatible.',
    `breaking_change_flag` BOOLEAN COMMENT 'True if the version introduces breaking changes compared with the prior version.',
    `changelog_summary` STRING COMMENT 'Brief summary of changes introduced in this version.',
    `compliance_review_date` DATE COMMENT 'Date of the most recent compliance assessment for this API version.',
    `compliance_status` STRING COMMENT 'Current PCI‑DSS compliance status of the API version.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the API version record was first created in the data lake.',
    `deprecation_date` DATE COMMENT 'Date after which the API version is considered deprecated and should no longer be used for new integrations (nullable if not scheduled).',
    `deprecation_reason` STRING COMMENT 'Business or technical rationale for deprecating this API version.',
    `documentation_version` STRING COMMENT 'Version string of the accompanying API documentation set.',
    `feature_flags` STRING COMMENT 'JSON‑encoded map of feature toggles enabled for this API version.',
    `is_beta` BOOLEAN COMMENT 'True if the version is a beta release intended for early adopters.',
    `is_mandatory_update` BOOLEAN COMMENT 'True if merchants must upgrade to this version to remain compliant.',
    `last_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance audit performed on this API version.',
    `migration_guide_url` STRING COMMENT 'Web address of the migration guide that explains how to move from prior versions to this version.',
    `minimum_os_version` STRING COMMENT 'Minimum operating system version required for SDKs or clients using this API version.',
    `minimum_runtime_version` STRING COMMENT 'Minimum runtime (e.g., Java, .NET) version required for this API version.',
    `platform` STRING COMMENT 'Pipe‑separated list of platforms (e.g., web, mobile, POS) that can invoke this API version.. Valid values are `web|mobile|pos|mpos`',
    `rate_limit_per_minute` STRING COMMENT 'Maximum number of API calls allowed per minute for this version.',
    `rate_limit_per_second` STRING COMMENT 'Maximum number of API calls allowed per second for this version.',
    `release_date` DATE COMMENT 'Calendar date on which the API version was first made publicly available.',
    `release_notes_url` STRING COMMENT 'Link to the detailed release notes for this API version.',
    `release_type` STRING COMMENT 'Semantic classification of the release (e.g., major, minor, patch, beta, release candidate).. Valid values are `major|minor|patch|beta|rc`',
    `sunset_date` DATE COMMENT 'Final date on which the API version will be retired and cease to operate.',
    `supported_languages` STRING COMMENT 'Comma‑separated list of programming languages for which SDKs are provided. [ENUM-REF-CANDIDATE: java|python|ruby|go|csharp|nodejs|php|swift|kotlin — promote to reference product]',
    `supported_payment_methods` STRING COMMENT 'Pipe‑separated list of payment instrument types accepted by this API version.. Valid values are `card|bank_transfer|digital_wallet|crypto|direct_debit`',
    `supported_protocols` STRING COMMENT 'Pipe‑separated list of transport protocols the API version can use.. Valid values are `REST|SOAP|ISO8583|gRPC`',
    `supported_request_types` STRING COMMENT 'Pipe‑separated list of request operation types that this API version supports.. Valid values are `authorization|capture|refund|void|inquiry|settlement`',
    `target_audience` STRING COMMENT 'Intended primary consumer of the API version.. Valid values are `merchant|partner|internal`',
    `test_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of automated test coverage for this API version.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the API version record.',
    `version` STRING COMMENT 'Human‑readable version string (e.g., "v2.1.0") that uniquely identifies the published API version.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the record.',
    CONSTRAINT pk_api_version PRIMARY KEY(`api_version_id`)
) COMMENT 'Reference record for each published version of the gateway API. Stores API version identifier, release date, deprecation date, sunset date, supported request types, breaking change flag, migration guide URL, and backward-compatibility matrix. Enables the gateway team to manage multi-version API coexistence, enforce deprecation timelines, and communicate breaking changes to merchant integrations.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` (
    `sdk_adoption_id` BIGINT COMMENT 'Primary key for the sdk_adoption association',
    `merchant_integration_id` BIGINT COMMENT 'Links to the merchant integration that adopts the SDK',
    `sdk_version_id` BIGINT COMMENT 'Links to the SDK version being adopted',
    `adoption_date` DATE COMMENT 'Date the SDK version was first adopted for the integration',
    `compliance_required` STRING COMMENT 'Indicates whether compliance checks are required for this SDK adoption',
    `compliance_status` STRING COMMENT 'Current compliance status of the SDK within this integration',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `current_sdk_status` STRING COMMENT 'Operational status of the SDK for this integration (e.g., ACTIVE, DEPRECATED)',
    `forced_upgrade_deadline` DATE COMMENT 'Deadline by which the integration must upgrade to a newer SDK version',
    `last_seen_timestamp` TIMESTAMP COMMENT 'Most recent timestamp the SDK version was observed in use',
    `notes` STRING COMMENT 'Free‑form notes about the adoption decision or issues',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk score assigned to this SDK adoption based on security and compliance factors',
    `sdk_release_date` DATE COMMENT 'Release date of the SDK version being adopted',
    `sdk_release_notes_url` STRING COMMENT 'URL to the release notes for the adopted SDK version',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    CONSTRAINT pk_sdk_adoption PRIMARY KEY(`sdk_adoption_id`)
) COMMENT 'Represents the adoption relationship between a merchant integration and a specific SDK version. Each record captures when the SDK was adopted, compliance details, risk score, and other lifecycle attributes that belong to the adoption event.. Existence Justification: Merchants manage which SDK version their integration uses and may upgrade or downgrade over time. Each adoption is recorded with dates, compliance status, and risk information, and the same SDK version can be used by many merchant integrations. The relationship itself is a managed entity that carries lifecycle attributes.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_target_acquirer_acquirer_endpoint_id` FOREIGN KEY (`target_acquirer_acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ADD CONSTRAINT `fk_gateway_acquirer_endpoint_failover_endpoint_id` FOREIGN KEY (`failover_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ADD CONSTRAINT `fk_gateway_gateway_protocol_config_region_id` FOREIGN KEY (`region_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`region`(`region_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_gateway_api_credential_id` FOREIGN KEY (`gateway_api_credential_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`gateway_api_credential`(`gateway_api_credential_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_rate_limit_policy_id` FOREIGN KEY (`rate_limit_policy_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`rate_limit_policy`(`rate_limit_policy_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ADD CONSTRAINT `fk_gateway_routing_decision_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ADD CONSTRAINT `fk_gateway_routing_decision_gateway_routing_rule_id` FOREIGN KEY (`gateway_routing_rule_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`gateway_routing_rule`(`gateway_routing_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ADD CONSTRAINT `fk_gateway_failover_event_gateway_routing_rule_id` FOREIGN KEY (`gateway_routing_rule_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`gateway_routing_rule`(`gateway_routing_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ADD CONSTRAINT `fk_gateway_failover_event_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ADD CONSTRAINT `fk_gateway_failover_event_target_endpoint_acquirer_endpoint_id` FOREIGN KEY (`target_endpoint_acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ADD CONSTRAINT `fk_gateway_webhook_delivery_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ADD CONSTRAINT `fk_gateway_webhook_delivery_webhook_subscription_id` FOREIGN KEY (`webhook_subscription_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`webhook_subscription`(`webhook_subscription_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ADD CONSTRAINT `fk_gateway_rate_limit_breach_rate_limit_policy_id` FOREIGN KEY (`rate_limit_policy_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`rate_limit_policy`(`rate_limit_policy_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ADD CONSTRAINT `fk_gateway_sla_profile_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ADD CONSTRAINT `fk_gateway_sla_measurement_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ADD CONSTRAINT `fk_gateway_sla_breach_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ADD CONSTRAINT `fk_gateway_merchant_sdk_adoption_merchant_integration_id` FOREIGN KEY (`merchant_integration_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`merchant_integration`(`merchant_integration_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ADD CONSTRAINT `fk_gateway_merchant_sdk_adoption_sdk_version_id` FOREIGN KEY (`sdk_version_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`sdk_version`(`sdk_version_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ADD CONSTRAINT `fk_gateway_endpoint_health_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ADD CONSTRAINT `fk_gateway_tls_certificate_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ADD CONSTRAINT `fk_gateway_ip_allowlist_gateway_api_credential_id` FOREIGN KEY (`gateway_api_credential_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`gateway_api_credential`(`gateway_api_credential_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ADD CONSTRAINT `fk_gateway_event_log_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ADD CONSTRAINT `fk_gateway_threeds_config_region_id` FOREIGN KEY (`region_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`region`(`region_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ADD CONSTRAINT `fk_gateway_gateway3ds_authentication_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ADD CONSTRAINT `fk_gateway_tokenization_request_region_id` FOREIGN KEY (`region_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`region`(`region_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ADD CONSTRAINT `fk_gateway_api_version_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ADD CONSTRAINT `fk_gateway_sdk_adoption_merchant_integration_id` FOREIGN KEY (`merchant_integration_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`merchant_integration`(`merchant_integration_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ADD CONSTRAINT `fk_gateway_sdk_adoption_sdk_version_id` FOREIGN KEY (`sdk_version_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`sdk_version`(`sdk_version_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`gateway` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `payments_fintech_ecm`.`gateway` SET TAGS ('dbx_domain' = 'gateway');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` SET TAGS ('dbx_subdomain' = 'integration_management');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `gateway_api_credential_id` SET TAGS ('dbx_business_glossary_term' = 'API Credential Identifier (API_CRED_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By (CB)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `allowed_ip_ranges` SET TAGS ('dbx_business_glossary_term' = 'Allowed IP Ranges (AIR)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `audience` SET TAGS ('dbx_business_glossary_term' = 'Audience (AUD)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Reference (ALR)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method (AM)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'api_key|oauth|hmac|certificate');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `certificate_thumbprint` SET TAGS ('dbx_business_glossary_term' = 'Certificate Thumbprint (CTP)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `certificate_thumbprint` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `certificate_thumbprint` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `client_identifier` SET TAGS ('dbx_business_glossary_term' = 'Client ID (CID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `client_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `client_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `client_secret` SET TAGS ('dbx_business_glossary_term' = 'Client Secret (CS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `client_secret` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `client_secret` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CT)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `credential_key` SET TAGS ('dbx_business_glossary_term' = 'Credential Key (CK)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `credential_key` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `credential_key` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `credential_name` SET TAGS ('dbx_business_glossary_term' = 'Credential Name (CN)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type (CT)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_value_regex' = 'api_key|oauth_client|hmac|certificate');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification (DC)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Encryption Algorithm (EA)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_value_regex' = 'RSA|ECDSA|AES');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `environment` SET TAGS ('dbx_business_glossary_term' = 'Environment (ENV)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `environment` SET TAGS ('dbx_value_regex' = 'production|sandbox|test');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `gateway_api_credential_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Status (CS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `gateway_api_credential_status` SET TAGS ('dbx_value_regex' = 'active|inactive|revoked|suspended|pending');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Hash Algorithm (HA)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_value_regex' = 'SHA256|SHA384|SHA512');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `hmac_secret` SET TAGS ('dbx_business_glossary_term' = 'HMAC Secret (HS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `hmac_secret` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `hmac_secret` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `issuer` SET TAGS ('dbx_business_glossary_term' = 'Issuer (ISS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `key_identifier` SET TAGS ('dbx_business_glossary_term' = 'Key Identifier (KID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `last_rotated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Rotated Timestamp (LRT)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp (LUT)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `max_concurrent_sessions` SET TAGS ('dbx_business_glossary_term' = 'Max Concurrent Sessions (MCS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `next_rotation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Rotation Timestamp (NRT)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `rate_limit_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Per Minute (RLPM)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `regulatory_review_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Date (RRD)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason (RR)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `revoked_flag` SET TAGS ('dbx_business_glossary_term' = 'Revoked Flag (RF)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `revoked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revoked Timestamp (RVT)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `rotation_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Rotation Interval (RI)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `scopes` SET TAGS ('dbx_business_glossary_term' = 'OAuth Scopes (OS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `token_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Token Endpoint URL (TEU)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `token_expiry_seconds` SET TAGS ('dbx_business_glossary_term' = 'Token Expiry (TE)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `token_type` SET TAGS ('dbx_business_glossary_term' = 'Token Type (TT)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `token_type` SET TAGS ('dbx_value_regex' = 'bearer|mac');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (UB)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UT)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count (UC)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `usage_quota` SET TAGS ('dbx_business_glossary_term' = 'Usage Quota (UQ)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` SET TAGS ('dbx_subdomain' = 'integration_management');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `merchant_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Integration ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `api_key` SET TAGS ('dbx_business_glossary_term' = 'API Key');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `api_key` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `api_key` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'api_key|oauth|mutual_tls');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `compliance_last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Endpoint URL');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `environment` SET TAGS ('dbx_business_glossary_term' = 'Deployment Environment');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `environment` SET TAGS ('dbx_value_regex' = 'sandbox|production');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `gateway_region` SET TAGS ('dbx_business_glossary_term' = 'Gateway Region');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `integration_category` SET TAGS ('dbx_business_glossary_term' = 'Integration Category');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `integration_category` SET TAGS ('dbx_value_regex' = 'payment|refund|settlement|dispute|wallet');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `integration_name` SET TAGS ('dbx_business_glossary_term' = 'Integration Name');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `integration_type` SET TAGS ('dbx_business_glossary_term' = 'Integration Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `integration_type` SET TAGS ('dbx_value_regex' = 'REST|SOAP|ISO8583|SDK');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `is_rate_limited` SET TAGS ('dbx_business_glossary_term' = 'Is Rate Limited');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `is_tokenized` SET TAGS ('dbx_business_glossary_term' = 'Is Tokenized');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `last_tested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Tested Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `merchant_integration_description` SET TAGS ('dbx_business_glossary_term' = 'Integration Description');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `merchant_integration_status` SET TAGS ('dbx_business_glossary_term' = 'Integration Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `merchant_integration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|decommissioned');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `oauth_client_identifier` SET TAGS ('dbx_business_glossary_term' = 'OAuth Client ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `oauth_client_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `oauth_client_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `oauth_scopes` SET TAGS ('dbx_business_glossary_term' = 'OAuth Scopes');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'pending|completed|rejected|inactive');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `pci_dss_compliance_tier` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance Tier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `pci_dss_compliance_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `rate_limit_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Per Minute');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Email');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_tested');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Integration Version');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `webhook_secret` SET TAGS ('dbx_business_glossary_term' = 'Webhook Secret');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `webhook_secret` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `webhook_secret` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `webhook_url` SET TAGS ('dbx_business_glossary_term' = 'Webhook URL');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` SET TAGS ('dbx_subdomain' = 'routing_operations');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `gateway_routing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Routing Rule ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Target Acquirer ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Mcc Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `target_acquirer_acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Target Acquirer ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `amount_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `amount_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_business_glossary_term' = 'BIN Range End');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_business_glossary_term' = 'BIN Range Start');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile|pos|api');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `compliance_check_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Required');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `compliance_rule_set` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rule Set');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `external_rule_reference` SET TAGS ('dbx_business_glossary_term' = 'External Rule Reference');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `failover_acquirer_sequence` SET TAGS ('dbx_business_glossary_term' = 'Failover Acquirer Sequence');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `fraud_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score Threshold');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `gateway_routing_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `gateway_routing_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `gateway_routing_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `is_default_rule` SET TAGS ('dbx_business_glossary_term' = 'Default Rule Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `is_rate_limited` SET TAGS ('dbx_business_glossary_term' = 'Rate Limiting Enabled');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `load_balancing_weight` SET TAGS ('dbx_business_glossary_term' = 'Load‑Balancing Weight');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `match_criteria` SET TAGS ('dbx_business_glossary_term' = 'Match Criteria JSON');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rule Notes');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Priority');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `rate_limit_per_second` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Per Second');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `routing_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Routing Algorithm');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `routing_algorithm` SET TAGS ('dbx_value_regex' = 'round_robin|least_connections|weighted');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Name');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'least_cost|scheme_preference|geographic|custom');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `sla_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'SLA Response Time (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `tokenization_required` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Required');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'auth|capture|sale|refund|void');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` SET TAGS ('dbx_subdomain' = 'routing_operations');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Endpoint ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `failover_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Failover Endpoint ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `acquirer_bic` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `acquirer_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{8,11}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `acquirer_bin` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Bank Identification Number (BIN)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `acquirer_bin` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `acquirer_endpoint_description` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Description');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `acquirer_name` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Name');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `connection_pool_size` SET TAGS ('dbx_business_glossary_term' = 'Connection Pool Size');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `cross_border_fee` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Fee');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `currency_conversion_supported` SET TAGS ('dbx_business_glossary_term' = 'Currency Conversion Supported');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `endpoint_code` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Name');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `failover_enabled` SET TAGS ('dbx_business_glossary_term' = 'Failover Enabled');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `health_check_status` SET TAGS ('dbx_business_glossary_term' = 'Health Check Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `health_check_status` SET TAGS ('dbx_value_regex' = 'pass|fail|unknown');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `health_check_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `health_check_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `host_url` SET TAGS ('dbx_business_glossary_term' = 'Host URL');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `is_tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Supported');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `max_concurrent_connections` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Connections');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `port` SET TAGS ('dbx_business_glossary_term' = 'Port Number');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `protocol` SET TAGS ('dbx_business_glossary_term' = 'Connection Protocol');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `protocol` SET TAGS ('dbx_value_regex' = 'ISO8583|REST|SOAP|SWIFT');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `rate_limit_per_sec` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit per Second');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'net|gross');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `supported_card_schemes` SET TAGS ('dbx_business_glossary_term' = 'Supported Card Schemes');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `timeout_ms` SET TAGS ('dbx_business_glossary_term' = 'Connection Timeout (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `tls_certificate_expiration` SET TAGS ('dbx_business_glossary_term' = 'TLS Certificate Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `tls_certificate_thumbprint` SET TAGS ('dbx_business_glossary_term' = 'TLS Certificate Thumbprint');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `tls_certificate_thumbprint` SET TAGS ('dbx_value_regex' = '^[A-Fa-f0-9]{40}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `transaction_fee_fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fixed Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `transaction_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Percentage');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` SET TAGS ('dbx_subdomain' = 'routing_operations');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `gateway_protocol_config_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Protocol Configuration ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Region Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'APIKey|OAuth2|MutualTLS|None');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `bitmap_configuration` SET TAGS ('dbx_business_glossary_term' = 'Bitmap Configuration');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `character_set` SET TAGS ('dbx_business_glossary_term' = 'Character Set');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_value_regex' = 'PCI_DSS|EMVCo|ISO20022|ISO8583|None');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `config_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `deprecation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Reason');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `deprecation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `encoding_scheme` SET TAGS ('dbx_business_glossary_term' = 'Encoding Scheme');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `error_handling_mode` SET TAGS ('dbx_business_glossary_term' = 'Error Handling Mode');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `error_handling_mode` SET TAGS ('dbx_value_regex' = 'strict|lenient|custom');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `field_mapping_definitions` SET TAGS ('dbx_business_glossary_term' = 'Field Mapping Definitions');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `gateway_protocol_config_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Description');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `gateway_protocol_config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `gateway_protocol_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Configuration Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `last_tested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Tested Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `max_payload_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Payload Size (Bytes)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `mti_mappings` SET TAGS ('dbx_business_glossary_term' = 'Message Type Indicator Mappings');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `owner_team` SET TAGS ('dbx_business_glossary_term' = 'Owner Team');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Configuration Priority');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `protocol` SET TAGS ('dbx_business_glossary_term' = 'Protocol Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `protocol` SET TAGS ('dbx_value_regex' = 'ISO8583|ISO20022|REST|SOAP|GraphQL');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `rate_limit_per_second` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Per Second');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `retry_policy` SET TAGS ('dbx_business_glossary_term' = 'Retry Policy');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `retry_policy` SET TAGS ('dbx_value_regex' = 'none|fixed|exponential|custom');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `supported_message_versions` SET TAGS ('dbx_business_glossary_term' = 'Supported Message Versions');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `test_environment` SET TAGS ('dbx_value_regex' = 'sandbox|production');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `timeout_ms` SET TAGS ('dbx_business_glossary_term' = 'Message Timeout (Milliseconds)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `transformation_pipeline` SET TAGS ('dbx_business_glossary_term' = 'Transformation Pipeline Reference');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_protocol_config` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Client Application ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `contactless_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID (TID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `gateway_api_credential_id` SET TAGS ('dbx_business_glossary_term' = 'API Credential ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `gateway_api_credential_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `gateway_api_credential_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID (MID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID (TID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `rate_limit_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Rate‑Limit Rule ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `wallet_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Transaction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `client_version` SET TAGS ('dbx_business_glossary_term' = 'Client Application Version');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `correlation_identifier` SET TAGS ('dbx_business_glossary_term' = 'Correlation ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `endpoint_path` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Path');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `headers` SET TAGS ('dbx_business_glossary_term' = 'Request Headers');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `http_method` SET TAGS ('dbx_business_glossary_term' = 'HTTP Method');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `http_method` SET TAGS ('dbx_value_regex' = 'GET|POST|PUT|DELETE|PATCH');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `idempotency_key` SET TAGS ('dbx_business_glossary_term' = 'Idempotency Key');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `is_rate_limited` SET TAGS ('dbx_business_glossary_term' = 'Rate‑Limit Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Processing Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `payload_truncated` SET TAGS ('dbx_business_glossary_term' = 'Request Payload (Truncated)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `processing_node_identifier` SET TAGS ('dbx_business_glossary_term' = 'Processing Node ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `protocol` SET TAGS ('dbx_business_glossary_term' = 'Transport Protocol');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `protocol` SET TAGS ('dbx_value_regex' = 'ISO8583|REST|SOAP|JSON|XML');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `raw_message_hash` SET TAGS ('dbx_business_glossary_term' = 'Raw Message Hash');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'authorization|capture|void|refund|inquiry');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `schema_version` SET TAGS ('dbx_business_glossary_term' = 'Request Schema Version');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Request Size (Bytes)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `source_ip` SET TAGS ('dbx_business_glossary_term' = 'Source IP Address');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `source_ip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `source_ip` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `source_port` SET TAGS ('dbx_business_glossary_term' = 'Source Port');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `tls_version` SET TAGS ('dbx_business_glossary_term' = 'TLS Version');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `tls_version` SET TAGS ('dbx_value_regex' = 'TLS1.0|TLS1.1|TLS1.2|TLS1.3');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `validation_error_code` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `validation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Initial Validation Outcome');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `validation_outcome` SET TAGS ('dbx_value_regex' = 'accepted|rejected|error');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `response_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Response ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identification Number (TID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `wallet_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Transaction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `acquirer_response_code` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Response Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `amount_cents` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount (cents)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `amount_cents` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `amount_cents` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code (AUTH)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `authorization_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `authorization_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `compliance_check_details` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Details');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `correlation_identifier` SET TAGS ('dbx_business_glossary_term' = 'Correlation ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `destination_ip` SET TAGS ('dbx_business_glossary_term' = 'Destination IP Address');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `destination_ip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `destination_ip` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `destination_port` SET TAGS ('dbx_business_glossary_term' = 'Destination Port');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `entry_mode` SET TAGS ('dbx_business_glossary_term' = 'Entry Mode');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `entry_mode` SET TAGS ('dbx_value_regex' = 'chip|magstripe|contactless|manual');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Internal Error Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `error_description` SET TAGS ('dbx_business_glossary_term' = 'Error Description');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `final_disposition` SET TAGS ('dbx_business_glossary_term' = 'Final Disposition');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `final_disposition` SET TAGS ('dbx_value_regex' = 'success|failed|partial');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `is_fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `is_test_transaction` SET TAGS ('dbx_business_glossary_term' = 'Test Transaction Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `message` SET TAGS ('dbx_business_glossary_term' = 'Response Message');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `network_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Network Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `processing_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Processing Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `protocol` SET TAGS ('dbx_business_glossary_term' = 'Response Protocol');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `protocol` SET TAGS ('dbx_value_regex' = 'ISO8583|REST|SOAP|JSON|XML|gRPC');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Response Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `sla_met` SET TAGS ('dbx_business_glossary_term' = 'SLA Met Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `source_ip` SET TAGS ('dbx_business_glossary_term' = 'Source IP Address');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `source_ip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `source_ip` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `source_port` SET TAGS ('dbx_business_glossary_term' = 'Source Port');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|refund|auth|capture|void');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` SET TAGS ('dbx_subdomain' = 'routing_operations');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `routing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `gateway_routing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `alternative_acquirer_endpoints` SET TAGS ('dbx_business_glossary_term' = 'Alternative Acquirer Endpoints List');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `decision_error_code` SET TAGS ('dbx_business_glossary_term' = 'Decision Error Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `decision_error_message` SET TAGS ('dbx_business_glossary_term' = 'Decision Error Message');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Outcome');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_value_regex' = 'approved|declined|rerouted|error');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `decision_reason` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Reason');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `failover_triggered` SET TAGS ('dbx_business_glossary_term' = 'Failover Triggered Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `load_balancing_outcome` SET TAGS ('dbx_business_glossary_term' = 'Load Balancing Outcome');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `load_balancing_outcome` SET TAGS ('dbx_value_regex' = 'selected|round_robin|least_connections|weighted');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `request_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Request Amount (USD)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `request_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `request_protocol` SET TAGS ('dbx_business_glossary_term' = 'Request Protocol Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `request_protocol` SET TAGS ('dbx_value_regex' = 'ISO8583|REST|SOAP|JSON');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `request_source` SET TAGS ('dbx_business_glossary_term' = 'Request Source Channel');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `request_source` SET TAGS ('dbx_value_regex' = 'web|mobile|POS|mPOS|API');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `routing_decision_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `routing_decision_status` SET TAGS ('dbx_value_regex' = 'applied|failed|pending|reverted');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `routing_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Routing Latency (Milliseconds)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `selected_acquirer_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Selected Acquirer Endpoint Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `sla_achieved` SET TAGS ('dbx_business_glossary_term' = 'SLA Achieved Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `sla_target_ms` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Latency (Milliseconds)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` SET TAGS ('dbx_subdomain' = 'routing_operations');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `failover_event_id` SET TAGS ('dbx_business_glossary_term' = 'Failover Event Identifier (FAILOVER_EVENT_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `gateway_routing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Policy Identifier (ROUTE_POLICY_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MERCHANT_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `network_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Network Identifier (NETWORK_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Acquirer Endpoint Identifier (SOURCE_ENDPOINT_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Network Identifier (NETWORK_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `target_endpoint_acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Secondary Acquirer Endpoint Identifier (TARGET_ENDPOINT_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `affected_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Monetary Amount Affected (AFFECTED_TRANSACTION_AMOUNT)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `affected_transaction_volume` SET TAGS ('dbx_business_glossary_term' = 'Number of Transactions Affected (AFFECTED_TRANSACTION_VOLUME)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Gateway Error Code (ERROR_CODE)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Failover Trigger Timestamp (EVENT_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `failover_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Failover Duration in Seconds (FAILOVER_DURATION_SECONDS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `failover_event_status` SET TAGS ('dbx_business_glossary_term' = 'Failover Event Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `failover_event_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|failed|recovered');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `network_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Network Name (NETWORK_NAME)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes or Comments (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RECORD_AUDIT_CREATED)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RECORD_AUDIT_UPDATED)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `recovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Failover Recovery Timestamp (RECOVERY_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'ISO 3166‑1 Alpha‑3 Country Code of Affected Transactions (REGION_CODE)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `retry_attempts` SET TAGS ('dbx_business_glossary_term' = 'Number of Retry Attempts Before Failover (RETRY_ATTEMPTS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Indicator (SLA_BREACH_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `source_endpoint_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Acquirer Endpoint Name (SOURCE_ENDPOINT_NAME)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `target_endpoint_name` SET TAGS ('dbx_business_glossary_term' = 'Secondary Acquirer Endpoint Name (TARGET_ENDPOINT_NAME)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Affected (TRANSACTION_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|refund|reversal|auth|capture');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Failover Trigger Reason (TRIGGER_REASON)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `trigger_reason` SET TAGS ('dbx_value_regex' = 'timeout|connection_refused|error_threshold|network_failure|other');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` SET TAGS ('dbx_subdomain' = 'integration_management');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `webhook_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Webhook Subscription Identifier (WSID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (CreatedByUID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (PID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (CreatedByUID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method (AuthMethod)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'hmac_sha256|oauth_bearer|basic_auth');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `authentication_secret` SET TAGS ('dbx_business_glossary_term' = 'Authentication Secret (AuthSecret)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `authentication_secret` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `authentication_secret` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `backoff_strategy` SET TAGS ('dbx_business_glossary_term' = 'Backoff Strategy (Backoff)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `backoff_strategy` SET TAGS ('dbx_value_regex' = 'fixed|exponential|jitter');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CreatedTS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp (EffFrom)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Timestamp (EffUntil)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `encryption_enabled` SET TAGS ('dbx_business_glossary_term' = 'Encryption Enabled Flag (EncEnabled)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `encryption_key_reference` SET TAGS ('dbx_business_glossary_term' = 'Encryption Key Identifier (EncKeyID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `encryption_key_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `encryption_key_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `event_types` SET TAGS ('dbx_business_glossary_term' = 'Subscribed Event Types (ET)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `failure_count` SET TAGS ('dbx_business_glossary_term' = 'Consecutive Failure Count (FailCount)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `ip_allowlist` SET TAGS ('dbx_business_glossary_term' = 'IP Allowlist (IPAllowlist)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `is_test` SET TAGS ('dbx_business_glossary_term' = 'Test Mode Flag (IsTest)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `last_failure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Failure Timestamp (LastFailTS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (Status)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|paused|cancelled|expired');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `max_payload_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Payload Size (MaxPayloadBytes)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `max_retry_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Attempts (MaxRetry)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `notification_endpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Endpoint Type (EndpointType)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `notification_endpoint_type` SET TAGS ('dbx_value_regex' = 'http|https|queue');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `oauth_client_identifier` SET TAGS ('dbx_business_glossary_term' = 'OAuth Client Identifier (OAuthCID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `oauth_scopes` SET TAGS ('dbx_business_glossary_term' = 'OAuth Scopes (OAuthScopes)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `payload_format` SET TAGS ('dbx_business_glossary_term' = 'Payload Format (PayloadFmt)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `payload_format` SET TAGS ('dbx_value_regex' = 'json|xml|form');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `rate_limit_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Per Minute (RateLimit)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `retry_backoff_seconds` SET TAGS ('dbx_business_glossary_term' = 'Retry Backoff Seconds (BackoffSec)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `retry_policy` SET TAGS ('dbx_business_glossary_term' = 'Retry Policy (RetryPolicy)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `retry_policy` SET TAGS ('dbx_value_regex' = 'none|fixed|exponential');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `sla_response_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'SLA Response Time (SLARespSec)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `subscription_code` SET TAGS ('dbx_business_glossary_term' = 'Webhook Subscription Code (WSC)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `subscription_name` SET TAGS ('dbx_business_glossary_term' = 'Webhook Subscription Name (WSN)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `subscription_type` SET TAGS ('dbx_business_glossary_term' = 'Subscription Type (SubType)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `subscription_type` SET TAGS ('dbx_value_regex' = 'event|transaction|balance|custom');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `target_url` SET TAGS ('dbx_business_glossary_term' = 'Target URL (URL)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UpdatedTS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Subscription Version (Version)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `webhook_secret_hash` SET TAGS ('dbx_business_glossary_term' = 'Webhook Secret Hash (SecretHash)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `webhook_secret_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `webhook_secret_hash` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `webhook_subscription_description` SET TAGS ('dbx_business_glossary_term' = 'Webhook Subscription Description (WSD)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` SET TAGS ('dbx_subdomain' = 'integration_management');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `webhook_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Webhook Delivery Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `request_id` SET TAGS ('dbx_value_regex' = '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `webhook_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Webhook Subscription Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Number');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `correlation_identifier` SET TAGS ('dbx_business_glossary_term' = 'Correlation Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `correlation_identifier` SET TAGS ('dbx_value_regex' = '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[1-5][0-9a-fA-F]{3}-[89abAB][0-9a-fA-F]{3}-[0-9a-fA-F]{12}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'delivered|failed|pending|retry_scheduled');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Endpoint URL');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_value_regex' = '^https?://.+$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'transaction_created|transaction_settled|dispute_opened|chargeback|fraud_alert|settlement_report');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `http_status_code` SET TAGS ('dbx_business_glossary_term' = 'HTTP Status Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `is_final_attempt` SET TAGS ('dbx_business_glossary_term' = 'Final Attempt Indicator');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `max_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Delivery Attempts');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `next_retry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Retry Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `payload_hash` SET TAGS ('dbx_business_glossary_term' = 'Payload SHA-256 Hash');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `payload_hash` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `protocol` SET TAGS ('dbx_business_glossary_term' = 'Transport Protocol');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `protocol` SET TAGS ('dbx_value_regex' = 'REST|SOAP|ISO8583');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `response_body_snippet` SET TAGS ('dbx_business_glossary_term' = 'Response Body Snippet');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `response_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Response Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `retry_policy` SET TAGS ('dbx_business_glossary_term' = 'Retry Policy');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `retry_policy` SET TAGS ('dbx_value_regex' = 'exponential|fixed|none');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'gateway|digital_wallet|fraud_platform');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `success_flag` SET TAGS ('dbx_business_glossary_term' = 'Delivery Success Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `throttling_flag` SET TAGS ('dbx_business_glossary_term' = 'Throttling Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `rate_limit_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Policy ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `burst_limit` SET TAGS ('dbx_business_glossary_term' = 'Burst Limit');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `consumer_identifier` SET TAGS ('dbx_business_glossary_term' = 'Consumer Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `daily_cap` SET TAGS ('dbx_business_glossary_term' = 'Daily Request Cap');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `enforcement_action` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `enforcement_action` SET TAGS ('dbx_value_regex' = 'throttle|block');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type (API Credential, Merchant ID, IP Range)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'api|mid|ip_range');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `rate_limit_policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `rate_limit_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `rate_limit_policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `request_quota_rpm` SET TAGS ('dbx_business_glossary_term' = 'Request Quota RPM (Requests Per Minute)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `request_quota_tps` SET TAGS ('dbx_business_glossary_term' = 'Request Quota TPS (Transactions Per Second)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `throttle_response_code` SET TAGS ('dbx_business_glossary_term' = 'Throttle Response HTTP Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `throttle_response_code` SET TAGS ('dbx_value_regex' = '429|503');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Tier Name');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `rate_limit_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Breach Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `rate_limit_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Policy Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `alert_sent` SET TAGS ('dbx_business_glossary_term' = 'Alert Sent Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `alert_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `breach_description` SET TAGS ('dbx_business_glossary_term' = 'Breach Description');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `breach_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Breach Duration (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `breach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `client_user_agent` SET TAGS ('dbx_business_glossary_term' = 'Client User Agent');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `client_user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `client_user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `correlation_identifier` SET TAGS ('dbx_business_glossary_term' = 'Correlation Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `endpoint_path` SET TAGS ('dbx_business_glossary_term' = 'API Endpoint Path');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `enforcement_action` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `enforcement_action` SET TAGS ('dbx_value_regex' = 'throttled|blocked|alerted');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `exceeded_metric` SET TAGS ('dbx_business_glossary_term' = 'Exceeded Metric');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `exceeded_metric` SET TAGS ('dbx_value_regex' = 'tps|rpm');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `is_test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `observed_rpm` SET TAGS ('dbx_business_glossary_term' = 'Observed Transactions Per Minute');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `observed_tps` SET TAGS ('dbx_business_glossary_term' = 'Observed Transactions Per Second');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `originating_ip` SET TAGS ('dbx_business_glossary_term' = 'Originating IP Address');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `originating_ip` SET TAGS ('dbx_value_regex' = '^((25[0-5]|2[0-4]d|[01]?d?d)(.|$)){4}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `originating_ip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `originating_ip` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Policy Name');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `rate_limit_breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `rate_limit_breach_status` SET TAGS ('dbx_value_regex' = 'open|resolved|escalated');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `rate_limit_window` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Window');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `rate_limit_window` SET TAGS ('dbx_value_regex' = 'per_second|per_minute');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|GBR|AUS|DEU|FRA');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `remediation_action` SET TAGS ('dbx_value_regex' = 'increase_quota|notify_merchant|none');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `request_method` SET TAGS ('dbx_business_glossary_term' = 'HTTP Request Method');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `request_method` SET TAGS ('dbx_value_regex' = 'GET|POST|PUT|DELETE|PATCH');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `source_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Source Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `source_type` SET TAGS ('dbx_value_regex' = 'api_key|merchant_id|ip_address');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `threshold_rpm` SET TAGS ('dbx_business_glossary_term' = 'Threshold Transactions Per Minute');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `threshold_tps` SET TAGS ('dbx_business_glossary_term' = 'Threshold Transactions Per Second');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_breach` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'SLA Profile ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `breach_notification_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Breach Notification Time (hours)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `error_rate_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Error Rate Threshold Percentage');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Email');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `last_measured_availability_pct` SET TAGS ('dbx_business_glossary_term' = 'Last Measured Availability Percentage');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `last_measured_error_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Last Measured Error Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `last_measured_latency_p95_ms` SET TAGS ('dbx_business_glossary_term' = 'Last Measured P95 Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `last_measured_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Measured Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `latency_p50_ms` SET TAGS ('dbx_business_glossary_term' = 'P50 Authorization Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `latency_p95_ms` SET TAGS ('dbx_business_glossary_term' = 'P95 Authorization Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `latency_p99_ms` SET TAGS ('dbx_business_glossary_term' = 'P99 Authorization Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `measurement_metric` SET TAGS ('dbx_business_glossary_term' = 'Measurement Metric');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `measurement_metric` SET TAGS ('dbx_value_regex' = 'availability|latency|error_rate');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `measurement_window_minutes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window (minutes)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `monitoring_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Endpoint URL');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'SLA Notes');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `remediation_obligation` SET TAGS ('dbx_business_glossary_term' = 'Remediation Obligation');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'SLA Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `sla_profile_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `sla_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `sla_revision_number` SET TAGS ('dbx_business_glossary_term' = 'SLA Revision Number');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'SLA Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `sla_type` SET TAGS ('dbx_value_regex' = 'merchant|acquirer|api|partner');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `sla_version` SET TAGS ('dbx_business_glossary_term' = 'SLA Version');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `target_availability_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Availability Percentage');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `sla_measurement_id` SET TAGS ('dbx_business_glossary_term' = 'SLA Measurement ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'SLA Profile ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `availability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Availability Percentage');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `error_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Error Rate Percentage');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `latency_p50_ms` SET TAGS ('dbx_business_glossary_term' = 'Latency P50 (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `latency_p95_ms` SET TAGS ('dbx_business_glossary_term' = 'Latency P95 (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `latency_p99_ms` SET TAGS ('dbx_business_glossary_term' = 'Latency P99 (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'gateway|batch|monitoring|third_party');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `measurement_window_end` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window End');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `measurement_window_start` SET TAGS ('dbx_business_glossary_term' = 'Measurement Window Start');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `tps` SET TAGS ('dbx_business_glossary_term' = 'Transactions Per Second (TPS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_measurement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `sla_breach_id` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'SLA Profile Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `breach_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Breach Duration (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `breach_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach End Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `breach_reference` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Reference Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `breach_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach Start Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `contracted_unit` SET TAGS ('dbx_business_glossary_term' = 'Contracted SLA Unit');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `contracted_unit` SET TAGS ('dbx_value_regex' = 'percent|ms|transactions_per_second|seconds|bytes|other');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `contracted_value` SET TAGS ('dbx_business_glossary_term' = 'Contracted SLA Value');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `credit_applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit Applied Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `credit_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Currency Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `credit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `credit_obligation_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Obligation Amount');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `impacted_party_reference` SET TAGS ('dbx_business_glossary_term' = 'Impacted Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `impacted_party_type` SET TAGS ('dbx_business_glossary_term' = 'Impacted Party Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `impacted_party_type` SET TAGS ('dbx_value_regex' = 'merchant|acquirer|partner|other');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `is_credit_applied` SET TAGS ('dbx_business_glossary_term' = 'Credit Applied Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `measured_unit` SET TAGS ('dbx_business_glossary_term' = 'Measured Metric Unit');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `measured_unit` SET TAGS ('dbx_value_regex' = 'percent|ms|transactions_per_second|seconds|bytes|other');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Metric Value');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `metric` SET TAGS ('dbx_business_glossary_term' = 'Breached SLA Metric');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `metric` SET TAGS ('dbx_value_regex' = 'availability|latency|error_rate|throughput|transaction_rate|other');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'network|hardware|software|configuration|external|unknown');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Severity');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `sla_breach_description` SET TAGS ('dbx_business_glossary_term' = 'Breach Description');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `sla_breach_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Breach Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `sla_breach_status` SET TAGS ('dbx_value_regex' = 'open|investigating|resolved|closed');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_breach` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` SET TAGS ('dbx_subdomain' = 'integration_management');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `sdk_version_id` SET TAGS ('dbx_business_glossary_term' = 'SDK Version ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `api_compatibility_version` SET TAGS ('dbx_business_glossary_term' = 'API Compatibility Version');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `changelog_summary` SET TAGS ('dbx_business_glossary_term' = 'Changelog Summary');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'SHA‑256 Checksum');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `checksum_type` SET TAGS ('dbx_business_glossary_term' = 'Checksum Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `checksum_type` SET TAGS ('dbx_value_regex' = 'sha256|md5|sha1');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `download_url` SET TAGS ('dbx_business_glossary_term' = 'Download URL');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `end_of_life_date` SET TAGS ('dbx_business_glossary_term' = 'End‑of‑Life Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `is_mandatory_update` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Update Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `language_support` SET TAGS ('dbx_business_glossary_term' = 'Language Support');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `minimum_os_version` SET TAGS ('dbx_business_glossary_term' = 'Minimum OS Version');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `minimum_runtime_version` SET TAGS ('dbx_business_glossary_term' = 'Minimum Runtime Version');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `pci_dss_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `pci_dss_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Target Platform');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `release_notes` SET TAGS ('dbx_business_glossary_term' = 'Release Notes');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `sdk_type` SET TAGS ('dbx_business_glossary_term' = 'SDK Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `sdk_type` SET TAGS ('dbx_value_regex' = 'mobile|web|server|desktop');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `sdk_version_status` SET TAGS ('dbx_business_glossary_term' = 'SDK Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `sdk_version_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|retired|planned');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Email');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `supported_features` SET TAGS ('dbx_business_glossary_term' = 'Supported Features');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `supported_payment_methods` SET TAGS ('dbx_business_glossary_term' = 'Supported Payment Methods');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'SDK Version (Human Readable)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `version_code` SET TAGS ('dbx_business_glossary_term' = 'SDK Version Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_version` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` SET TAGS ('dbx_subdomain' = 'integration_management');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `merchant_sdk_adoption_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant SDK Adoption Record Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `merchant_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Integration Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `sdk_version_id` SET TAGS ('dbx_business_glossary_term' = 'SDK Version Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `adoption_date` SET TAGS ('dbx_business_glossary_term' = 'SDK Adoption Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Required Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `current_sdk_status` SET TAGS ('dbx_business_glossary_term' = 'Current SDK Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `current_sdk_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|retired|unsupported');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `forced_upgrade_deadline` SET TAGS ('dbx_business_glossary_term' = 'Forced Upgrade Deadline');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `last_seen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Seen Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adoption Notes');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'SDK Risk Score');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `sdk_release_date` SET TAGS ('dbx_business_glossary_term' = 'SDK Release Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `sdk_release_notes_url` SET TAGS ('dbx_business_glossary_term' = 'SDK Release Notes URL');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_sdk_adoption` ALTER COLUMN `upgrade_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Notification Sent Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` SET TAGS ('dbx_subdomain' = 'routing_operations');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `endpoint_health_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Health Record ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `endpoint_health_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `endpoint_health_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Endpoint ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Health Check Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `circuit_breaker_state` SET TAGS ('dbx_business_glossary_term' = 'Circuit Breaker State');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `circuit_breaker_state` SET TAGS ('dbx_value_regex' = 'closed|open|half_open');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `consecutive_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Consecutive Failure Count');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `endpoint_health_status` SET TAGS ('dbx_business_glossary_term' = 'Health Check Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `endpoint_health_status` SET TAGS ('dbx_value_regex' = 'success|failure');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `endpoint_health_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `endpoint_health_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `failure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `failure_reason_code` SET TAGS ('dbx_value_regex' = 'timeout|connection_refused|invalid_response|authentication_failed|unknown_error');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `health_check_type` SET TAGS ('dbx_business_glossary_term' = 'Health Check Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `health_check_type` SET TAGS ('dbx_value_regex' = 'tcp_ping|iso8583_echo|rest_heartbeat');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `health_check_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `health_check_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `health_score` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Health Score');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `health_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `health_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `last_success_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Success Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `protocol` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Protocol');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `protocol` SET TAGS ('dbx_value_regex' = 'iso8583|rest|soap');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Response Time (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `sla_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Response Time (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`endpoint_health` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `tls_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'TLS Certificate Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `auto_renewal` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Indicator (AutoRenewal)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `certificate_profile` SET TAGS ('dbx_business_glossary_term' = 'Certificate Validation Profile (Profile)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `certificate_profile` SET TAGS ('dbx_value_regex' = 'EV|OV|DV|Self_Signed');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type (CertType)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_value_regex' = 'server|client|code_signing|root|intermediate');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `compliance_pci_dss` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance Status (PCICompliance)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `compliance_pci_dss` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (Country)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CreatedTimestamp)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Certificate Contact Email (Email)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `expiration_alert_sent` SET TAGS ('dbx_business_glossary_term' = 'Expiration Alert Sent Flag (AlertSent)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `fingerprint_sha256` SET TAGS ('dbx_business_glossary_term' = 'SHA-256 Fingerprint (FingerprintSHA256)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `fingerprint_sha256` SET TAGS ('dbx_value_regex' = '^[A-Fa-f0-9]{64}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `fingerprint_sha256` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `fingerprint_sha256` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `is_wildcard` SET TAGS ('dbx_business_glossary_term' = 'Wildcard Certificate Indicator (Wildcard)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `issuer` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issuer (Issuer)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `key_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Public Key Algorithm (KeyAlgorithm)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `key_algorithm` SET TAGS ('dbx_value_regex' = 'RSA|ECDSA|ED25519|DSA');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `key_length_bits` SET TAGS ('dbx_business_glossary_term' = 'Key Length in Bits (KeyLength)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `last_checked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp (LastChecked)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `locality` SET TAGS ('dbx_business_glossary_term' = 'Locality / City (Locality)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certificate Notes (Notes)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `organization_name` SET TAGS ('dbx_business_glossary_term' = 'Organization Name (Organization)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `organizational_unit` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit (OrgUnit)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Renewal Due Date (RenewalDue)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason (RevocationReason)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `revocation_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Revocation Status (RevocationStatus)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `revocation_status` SET TAGS ('dbx_value_regex' = 'valid|revoked|suspended');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revocation Timestamp (RevocationTimestamp)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Serial Number (SerialNumber)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-F0-9]+$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `state_or_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province (StateProvince)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Certificate Subject (Subject)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `thumbprint` SET TAGS ('dbx_business_glossary_term' = 'SHA-1 Thumbprint (Thumbprint)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `thumbprint` SET TAGS ('dbx_value_regex' = '^[A-Fa-f0-9]{40}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `tls_certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Operational Status (Status)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `tls_certificate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|pending');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UpdatedTimestamp)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `usage` SET TAGS ('dbx_business_glossary_term' = 'Certificate Usage Direction (Usage)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `usage` SET TAGS ('dbx_value_regex' = 'inbound|outbound|both');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Certificate Valid From Date (ValidFrom)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tls_certificate` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiration Date (ValidTo)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `ip_allowlist_id` SET TAGS ('dbx_business_glossary_term' = 'IP Allowlist Entry Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `gateway_api_credential_id` SET TAGS ('dbx_business_glossary_term' = 'API Credential Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `enforcement_action` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `enforcement_action` SET TAGS ('dbx_value_regex' = 'reject|monitor|alert');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `ip_allowlist_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `ip_allowlist_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|revoked');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `ip_range` SET TAGS ('dbx_business_glossary_term' = 'IP Address or CIDR Range');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `ip_range` SET TAGS ('dbx_value_regex' = '^([0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{0,4}:){1,7}[0-9a-fA-F]{0,4}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `ip_range` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `ip_range` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `is_rate_limited` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Override Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `list_type` SET TAGS ('dbx_business_glossary_term' = 'Allowlist Type (Allow or Block)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `list_type` SET TAGS ('dbx_value_regex' = 'allow|block');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `merchant_mid` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identification Number (MID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operator Notes');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `rate_limit_per_second` SET TAGS ('dbx_business_glossary_term' = 'Custom Rate Limit (Requests per Second)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`ip_allowlist` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` SET TAGS ('dbx_subdomain' = 'performance_monitoring');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `event_log_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Event Log Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Actor Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'SLA Profile Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `actor_type` SET TAGS ('dbx_business_glossary_term' = 'Actor Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `after_state` SET TAGS ('dbx_business_glossary_term' = 'After State Snapshot');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `before_state` SET TAGS ('dbx_business_glossary_term' = 'Before State Snapshot');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `correlation_identifier` SET TAGS ('dbx_business_glossary_term' = 'Correlation Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `event_log_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `event_payload` SET TAGS ('dbx_business_glossary_term' = 'Event Payload');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'credential_rotation|routing_rule_activation|endpoint_registration|sla_profile_change|webhook_subscription_modification|failover_activation');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Source IP Address');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Event Outcome');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'success|failure|partial');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Event Severity');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'info|warning|error|critical');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`event_log` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `threeds_config_id` SET TAGS ('dbx_business_glossary_term' = '3-D Secure Configuration Identifier (3DS Config ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Mcc Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Region Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `acquirer_bin` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Bank Identification Number (Acquirer BIN)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `acquirer_bin` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Reference Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `authentication_flow` SET TAGS ('dbx_business_glossary_term' = 'Authentication Flow Type (Authentication Flow)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `authentication_flow` SET TAGS ('dbx_value_regex' = 'redirect|embedded|native');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `challenge_preference` SET TAGS ('dbx_business_glossary_term' = 'Challenge Preference Setting (Challenge Preference)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `challenge_preference` SET TAGS ('dbx_value_regex' = 'no_preference|no_challenge|challenge_requested');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `challenge_timeout_seconds` SET TAGS ('dbx_business_glossary_term' = 'Challenge Timeout (seconds)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Compliance Regulation (Compliance Regulation)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'PSD2|PCI_DSS|EMVCo');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status of Configuration (Compliance Status)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'pass|fail|pending');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `config_code` SET TAGS ('dbx_business_glossary_term' = '3-D Secure Configuration Code (3DS Config Code)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `config_name` SET TAGS ('dbx_business_glossary_term' = '3-D Secure Configuration Name (3DS Config Name)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `config_type` SET TAGS ('dbx_business_glossary_term' = '3-D Secure Configuration Type (3DS Config Type)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `config_type` SET TAGS ('dbx_value_regex' = 'standard|custom');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `exemption_rules` SET TAGS ('dbx_business_glossary_term' = 'Exemption Rules for 3-D Secure (Exemption Rules)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `exemption_rules` SET TAGS ('dbx_value_regex' = 'tra|low_value|trusted_beneficiary|none');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `frictionless_flow_eligible` SET TAGS ('dbx_business_glossary_term' = 'Frictionless Flow Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Configuration Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `max_challenge_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Challenge Attempts');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = '3-D Secure Protocol Version (3DS Protocol Version)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `protocol_version` SET TAGS ('dbx_value_regex' = '1.0|2.0');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `requestor_identifier` SET TAGS ('dbx_business_glossary_term' = 'Requestor Identifier (Requestor ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `risk_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Threshold for 3-D Secure (Risk Score Threshold)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `sca_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication Compliance Status (SCA Compliance Status)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `sca_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `threeds_config_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Description');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `threeds_config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `threeds_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type for 3-D Secure (Transaction Type)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'ecommerce|mcommerce|pos|recurring|auth_only');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `gateway3ds_authentication_id` SET TAGS ('dbx_business_glossary_term' = '3-D Secure Authentication Event ID (3DS_AUTH_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier (CARDHOLDER_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier (CARDHOLDER_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Directory Server Transaction ID (DS_TXN_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `transaction_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `transaction_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request ID (GW_REQ_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `acs_response_code` SET TAGS ('dbx_business_glossary_term' = 'ACS Response Code (ACS_RESP_CODE)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `authentication_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Authentication Latency (ms) (AUTH_LATENCY_MS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `authentication_message` SET TAGS ('dbx_business_glossary_term' = 'Authentication Message (AUTH_MESSAGE)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method (AUTH_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'static|dynamic|frictionless|challenge');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `authentication_result` SET TAGS ('dbx_business_glossary_term' = 'Authentication Result (AUTH_RESULT)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `authentication_result` SET TAGS ('dbx_value_regex' = 'Y|N|A|U|R|C');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `authentication_status` SET TAGS ('dbx_business_glossary_term' = 'Authentication Processing Status (AUTH_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `authentication_status` SET TAGS ('dbx_value_regex' = 'processed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `authentication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authentication Timestamp (AUTH_TS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand (CARD_BRAND)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `card_brand` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `cavv` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Authentication Verification Value (CAVV)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `cavv` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `cavv` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `challenge_indicator` SET TAGS ('dbx_business_glossary_term' = 'Challenge Indicator (CHALLENGE_IND)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `challenge_indicator` SET TAGS ('dbx_value_regex' = '01|02|03|04|05');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURRENCY_CODE)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint (DEVICE_FP)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `eci_value` SET TAGS ('dbx_business_glossary_term' = 'Electronic Commerce Indicator (ECI)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `exemption_applied` SET TAGS ('dbx_business_glossary_term' = 'Exemption Applied (EXEMPTION)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag (FRAUD_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `liability_shift` SET TAGS ('dbx_business_glossary_term' = 'Liability Shift Outcome (LIABILITY_SHIFT)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `liability_shift` SET TAGS ('dbx_value_regex' = 'merchant|issuer|none');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `liability_shift_reason` SET TAGS ('dbx_business_glossary_term' = 'Liability Shift Reason (LIABILITY_SHIFT_REASON)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `source_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Source IP Address (SRC_IP)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `source_ip_address` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}(.[0-9]{1,3}){3}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `source_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `source_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `three_ds_version` SET TAGS ('dbx_business_glossary_term' = '3-D Secure Protocol Version (3DS_VERSION)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount (TRANSACTION_AMT)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway3ds_authentication` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` SET TAGS ('dbx_subdomain' = 'security_controls');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `tokenization_request_id` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Request ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `device_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `device_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Region Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `assurance_level` SET TAGS ('dbx_business_glossary_term' = 'Assurance Level');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `assurance_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `compliance_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Passed');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `compliance_rule_set` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rule Set');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `fraud_reason` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `geo_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Outcome Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `outcome_status` SET TAGS ('dbx_value_regex' = 'success|failure|partial');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `pan_hash` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Number (PAN) Hash');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `pan_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `pan_hash` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `processing_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Processing Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `request_channel` SET TAGS ('dbx_business_glossary_term' = 'Request Channel');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `request_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|pos|mpos');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `request_reference` SET TAGS ('dbx_business_glossary_term' = 'Request Reference Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `request_source` SET TAGS ('dbx_business_glossary_term' = 'Request Source');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `request_source` SET TAGS ('dbx_value_regex' = 'api|sdk|webhook');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `sla_achieved_flag` SET TAGS ('dbx_business_glossary_term' = 'SLA Achieved Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `sla_target_ms` SET TAGS ('dbx_business_glossary_term' = 'SLA Target (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `token_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Token Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider (TSP)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `token_type` SET TAGS ('dbx_business_glossary_term' = 'Token Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `token_type` SET TAGS ('dbx_value_regex' = 'network|gateway|dpan');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `token_value` SET TAGS ('dbx_business_glossary_term' = 'Token Value');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `token_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `token_value` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Method');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_value_regex' = 'client_side|server_side|hybrid');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`tokenization_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` SET TAGS ('dbx_subdomain' = 'integration_management');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Region ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Region Active Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `cross_border_fee_applicable` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Fee Applicable Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `data_center_type` SET TAGS ('dbx_business_glossary_term' = 'Data Center Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `data_center_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|disaster_recovery');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `data_residency_requirements` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Requirements');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `encryption_standard` SET TAGS ('dbx_business_glossary_term' = 'Encryption Standard');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `encryption_standard` SET TAGS ('dbx_value_regex' = 'TLS1.0|TLS1.1|TLS1.2|TLS1.3');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `jurisdiction_data_protection_law` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Law Jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `jurisdiction_data_protection_law` SET TAGS ('dbx_value_regex' = 'GDPR|CCPA|PDPA|LGPD|None');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Region Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'operational|maintenance|retired|pending');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `max_transactions_per_second` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transactions Per Second (TPS)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `network_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Network Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `primary_data_center_location` SET TAGS ('dbx_business_glossary_term' = 'Primary Data Center Location');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (RC)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `region_description` SET TAGS ('dbx_business_glossary_term' = 'Region Description');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Region Name (RN)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `secondary_data_center_location` SET TAGS ('dbx_business_glossary_term' = 'Secondary Data Center Location');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `sla_target_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Response Time (ms)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `supported_card_schemes` SET TAGS ('dbx_business_glossary_term' = 'Supported Card Schemes');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `supported_currencies` SET TAGS ('dbx_business_glossary_term' = 'Supported Currencies');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Region Timezone');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Supported Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`region` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` SET TAGS ('dbx_subdomain' = 'integration_management');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `api_version_id` SET TAGS ('dbx_business_glossary_term' = 'API Version ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'SLA Profile ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `api_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'API Documentation URL');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `api_version_description` SET TAGS ('dbx_business_glossary_term' = 'API Version Description');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `api_version_status` SET TAGS ('dbx_business_glossary_term' = 'API Version Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `api_version_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|sunset|retired|draft');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `authentication_methods` SET TAGS ('dbx_business_glossary_term' = 'Supported Authentication Methods');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `authentication_methods` SET TAGS ('dbx_value_regex' = 'api_key|oauth2|jwt|hmac|basic');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `backward_compatibility_matrix` SET TAGS ('dbx_business_glossary_term' = 'Backward Compatibility Matrix');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `breaking_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Breaking Change Indicator');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `changelog_summary` SET TAGS ('dbx_business_glossary_term' = 'Changelog Summary');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'API Deprecation Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `deprecation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deprecation Reason');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `documentation_version` SET TAGS ('dbx_business_glossary_term' = 'Documentation Version');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `feature_flags` SET TAGS ('dbx_business_glossary_term' = 'Feature Flags');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `is_beta` SET TAGS ('dbx_business_glossary_term' = 'Beta Release Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `is_mandatory_update` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Update Flag');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `last_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `migration_guide_url` SET TAGS ('dbx_business_glossary_term' = 'Migration Guide URL');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `minimum_os_version` SET TAGS ('dbx_business_glossary_term' = 'Minimum OS Version');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `minimum_runtime_version` SET TAGS ('dbx_business_glossary_term' = 'Minimum Runtime Version');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Supported Platforms');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `platform` SET TAGS ('dbx_value_regex' = 'web|mobile|pos|mpos');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `rate_limit_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Per Minute');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `rate_limit_per_second` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Per Second');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'API Release Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `release_notes_url` SET TAGS ('dbx_business_glossary_term' = 'Release Notes URL');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `release_type` SET TAGS ('dbx_business_glossary_term' = 'Release Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `release_type` SET TAGS ('dbx_value_regex' = 'major|minor|patch|beta|rc');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'API Sunset Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `supported_languages` SET TAGS ('dbx_business_glossary_term' = 'Supported Languages');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `supported_payment_methods` SET TAGS ('dbx_business_glossary_term' = 'Supported Payment Methods');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `supported_payment_methods` SET TAGS ('dbx_value_regex' = 'card|bank_transfer|digital_wallet|crypto|direct_debit');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `supported_protocols` SET TAGS ('dbx_business_glossary_term' = 'Supported Protocols');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `supported_protocols` SET TAGS ('dbx_value_regex' = 'REST|SOAP|ISO8583|gRPC');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `supported_request_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Request Types');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `supported_request_types` SET TAGS ('dbx_value_regex' = 'authorization|capture|refund|void|inquiry|settlement');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `target_audience` SET TAGS ('dbx_value_regex' = 'merchant|partner|internal');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `test_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Test Coverage Percent');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'API Version Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`api_version` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` SET TAGS ('dbx_subdomain' = 'integration_management');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` SET TAGS ('dbx_association_edges' = 'gateway.merchant_integration,gateway.sdk_version');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ALTER COLUMN `sdk_adoption_id` SET TAGS ('dbx_business_glossary_term' = 'Sdk Adoption - Sdk Adoption Id');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ALTER COLUMN `merchant_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Sdk Adoption - Merchant Integration Id');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ALTER COLUMN `sdk_version_id` SET TAGS ('dbx_business_glossary_term' = 'Sdk Adoption - Sdk Version Id');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ALTER COLUMN `adoption_date` SET TAGS ('dbx_business_glossary_term' = 'Adoption Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ALTER COLUMN `compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ALTER COLUMN `current_sdk_status` SET TAGS ('dbx_business_glossary_term' = 'SDK Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ALTER COLUMN `forced_upgrade_deadline` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Deadline');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ALTER COLUMN `last_seen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Seen');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adoption Notes');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ALTER COLUMN `sdk_release_date` SET TAGS ('dbx_business_glossary_term' = 'SDK Release Date');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ALTER COLUMN `sdk_release_notes_url` SET TAGS ('dbx_business_glossary_term' = 'Release Notes URL');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sdk_adoption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated');
