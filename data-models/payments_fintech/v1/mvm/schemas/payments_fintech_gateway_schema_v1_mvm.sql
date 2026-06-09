-- Schema for Domain: gateway | Business: Payments Fintech | Version: v1_mvm
-- Generated on: 2026-05-03 21:29:49

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`gateway` COMMENT 'Owns the payment gateway and API routing infrastructure — merchant API/SDK integration configurations, transaction routing rules, protocol translation (ISO 8583, REST, SOAP), acquirer endpoint registrations, webhook delivery, rate limiting, API authentication, failover logic, and gateway SLA performance records.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` (
    `gateway_api_credential_id` BIGINT COMMENT 'System-generated unique identifier for the API credential record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partner onboarding requires each gateway API credential to be linked to the owning partner for billing, compliance audit, and credential lifecycle management.',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: API credentials in PayFac/gateway models are scoped to specific processing accounts (e.g., separate credentials for card-present vs card-not-present accounts). Credential provisioning, rotation audits',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant. Business justification: API credentials are issued per merchant; linking enables authentication audit, usage reporting, and revocation per merchant.',
    `rate_limit_policy_id` BIGINT COMMENT 'Foreign key linking to gateway.rate_limit_policy. Business justification: gateway_api_credential has rate_limit_per_minute (raw integer) — a denormalized rate limiting value that should reference the authoritative rate_limit_policy master record. API credentials are subject',
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
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Merchant integrations must be associated with a legal entity for regulatory compliance, tax reporting, and financial statement consolidation. Essential for multi-entity payment processors to track whi',
    `mdr_config_id` BIGINT COMMENT 'Foreign key linking to interchange.mdr_config. Business justification: Merchant integrations must reference the MDR pricing configuration that governs transaction fees for that integration. Critical for real-time pricing enforcement at gateway routing time and merchant b',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant. Business justification: Required for onboarding: each merchant integration config must be linked to its merchant for routing, reporting, and compliance.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Merchant integration configuration is product‑specific, linking integration to the payment product it supports for onboarding and monitoring.',
    `rate_limit_policy_id` BIGINT COMMENT 'Foreign key linking to gateway.rate_limit_policy. Business justification: merchant_integration has is_rate_limited (boolean) and rate_limit_per_minute (raw integer) — these are denormalized rate limiting values that should reference the authoritative rate_limit_policy maste',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Merchant integrations are subject to scheme-specific certification and compliance requirements (e.g., Visa Direct vs. Mastercard Send have different integration mandates). Scheme certification trackin',
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
    `onboarding_status` STRING COMMENT 'Current status of the merchants onboarding workflow for this integration.. Valid values are `pending|completed|rejected|inactive`',
    `pci_dss_compliance_tier` STRING COMMENT 'PCI DSS compliance tier assigned to the integration based on data handling scope.. Valid values are `tier1|tier2|tier3|tier4`',
    `protocol_version` STRING COMMENT 'Version of the integration protocol or API specification used.',
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
    `bin_sponsorship_id` BIGINT COMMENT 'Foreign key linking to partner.bin_sponsorship. Business justification: Routing rules must validate BIN ownership and sponsorship arrangements before routing transactions. Gateway needs to verify the transaction BIN falls within sponsored ranges and route accordingly per ',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partners often have custom routing rules; linking enables rule‑ownership reporting, SLA monitoring, and regulatory routing audits.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Routing rules often have associated fee structures and revenue/expense implications (routing optimization fees, premium routing charges). Direct GL account linkage enables automated accounting for rou',
    `mdr_config_id` BIGINT COMMENT 'Foreign key linking to interchange.mdr_config. Business justification: Routing rules optimize acquirer selection based on MDR pricing to minimize merchant costs. Real business process: cost-aware intelligent routing that considers both interchange and MDR when selecting ',
    `network_participation_id` BIGINT COMMENT 'Foreign key linking to partner.network_participation. Business justification: Routing decisions depend on which payment networks the partner participates in and their participation roles. Gateway must route transactions only through networks where the partner has active partici',
    `network_routing_rule_id` BIGINT COMMENT 'Foreign key linking to network.network_routing_rule. Business justification: Gateway routing rules are the gateway-layer implementation of network-mandated routing rules. Compliance audits and routing governance require tracing each gateway_routing_rule to the network_routing_',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Routing engine uses product_id to select routing rule for each payment product, required for rule‑based acquirer selection.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Primary acquirer endpoint to which matching transactions are routed.',
    `rate_limit_policy_id` BIGINT COMMENT 'Foreign key linking to gateway.rate_limit_policy. Business justification: gateway_routing_rule has is_rate_limited (boolean) and rate_limit_per_second (raw integer) — denormalized rate limiting values that should reference the authoritative rate_limit_policy master record. ',
    `routing_table_id` BIGINT COMMENT 'Foreign key linking to network.routing_table. Business justification: Gateway routing rules implement network-layer routing table configurations. Routing reconciliation and audit processes require tracing gateway rules to the specific network routing table (processing r',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Required for scheme‑based routing decisions; the routing engine must know which card scheme a rule applies to for compliance reporting.',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to gateway.sla_profile. Business justification: gateway_routing_rule has sla_response_time_ms (raw integer) — a denormalized SLA target that should reference the authoritative sla_profile master record. sla_profile defines comprehensive SLA commitm',
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
    `region_code` STRING COMMENT 'Three‑letter country/region code for geographic routing.',
    `risk_level` STRING COMMENT 'Risk classification associated with the rule.. Valid values are `low|medium|high`',
    `routing_algorithm` STRING COMMENT 'Algorithm used to select among multiple target acquirers.. Valid values are `round_robin|least_connections|weighted`',
    `rule_code` STRING COMMENT 'Business code used to reference the rule in external systems.',
    `rule_name` STRING COMMENT 'Human‑readable name of the routing rule.',
    `rule_type` STRING COMMENT 'Classification of the rule logic (e.g., least‑cost, scheme‑preference, geographic, custom).. Valid values are `least_cost|scheme_preference|geographic|custom`',
    `tokenization_required` BOOLEAN COMMENT 'Indicates if the transaction must be tokenized before routing.',
    `transaction_type` STRING COMMENT 'Type of transaction the rule applies to.. Valid values are `auth|capture|sale|refund|void`',
    `updated_by` STRING COMMENT 'User or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rule.',
    CONSTRAINT pk_gateway_routing_rule PRIMARY KEY(`gateway_routing_rule_id`)
) COMMENT 'Business-managed transaction routing rule defining how inbound payment requests are directed to acquirer endpoints. Captures rule priority, matching criteria (BIN range, MCC, currency, amount threshold, card scheme, region), target acquirer endpoint, failover sequence, load-balancing weight, effective date range, and rule status. Supports least-cost routing, scheme-preference routing, and geographic routing strategies.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` (
    `acquirer_endpoint_id` BIGINT COMMENT 'Unique system-generated identifier for the acquirer endpoint configuration.',
    `acquirer_id` BIGINT COMMENT 'Foreign key linking to settlement.acquirer. Business justification: Acquirer endpoints belong to a specific settlement acquirer. This link is essential for acquirer performance reporting, settlement reconciliation, and fee validation — a payments domain expert expects',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Acquirer endpoints operate under specific partner agreements that define commercial terms (MDR, IRF rates), compliance obligations, settlement cycles, and SLA commitments. Gateway must enforce agreeme',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Acquirer endpoints represent operational infrastructure with associated costs (connectivity fees, maintenance, transaction processing). Cost center allocation is essential for P&L reporting, operation',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partner‑specific acquirer endpoints are configured for settlement and risk management; the FK ties endpoint health and compliance to the responsible partner.',
    `endpoint_id` BIGINT COMMENT 'Identifier of the secondary endpoint used for failover.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Fee accounting process maps each acquirer endpoint to a GL account for posting acquisition fees and settlement adjustments.',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to fx.nostro_account. Business justification: Acquirer endpoints settle funds through specific nostro accounts held at correspondent banks. Treasury operations require tracking which nostro account each endpoint uses for liquidity management, bal',
    `partner_settlement_account_id` BIGINT COMMENT 'Foreign key linking to partner.partner_settlement_account. Business justification: Each acquirer endpoint must designate a specific partner settlement account for funds movement post-authorization. Settlement operations require knowing exactly which bank account receives funds from ',
    `scheme_fee_table_id` BIGINT COMMENT 'Foreign key linking to interchange.scheme_fee_table. Business justification: Acquirer endpoints have associated scheme fee structures that affect total cost of acceptance. Real business process: total cost calculation per endpoint for routing optimization and merchant cost tra',
    `acquirer_bic` STRING COMMENT 'SWIFT BIC of the acquirer, 8‑ or 11‑character code.. Valid values are `^[A-Z]{8,11}$`',
    `acquirer_endpoint_description` STRING COMMENT 'Free‑form description of the endpoint purpose, notes, or special handling instructions.',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`request` (
    `request_id` BIGINT COMMENT 'Unique identifier for the inbound API request record.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Payment gateway requests generate revenue recognition obligations under IFRS 15. Linking requests to accounting periods enables period-based revenue analysis, supports cutoff testing for financial aud',
    `cardholder_account_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_account. Business justification: Payment authorization requests target a specific cardholder account (credit/debit/prepaid). The gateway applies account-level velocity controls, credit limit checks, and account-status validation per ',
    `cardholder_profile_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_profile. Business justification: Required for transaction monitoring report linking each gateway request to the originating cardholder profile for fraud detection and compliance.',
    `device_fingerprint_id` BIGINT COMMENT 'Foreign key linking to fraud.device_fingerprint. Business justification: Request logs reference captured device fingerprint to feed fraud risk models and support device‑based investigations.',
    `location_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_location. Business justification: Gateway requests originate from specific merchant locations (POS terminals, e-commerce endpoints). Location-level fraud monitoring, PCI scope enforcement, and operational reporting require knowing whi',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant (MID) that originated the request.',
    `merchant_integration_id` BIGINT COMMENT 'Foreign key linking to gateway.merchant_integration. Business justification: Every inbound API request arrives via a specific merchant integration (API or SDK configuration). Linking request → merchant_integration enables analysis of request patterns per integration type, prot',
    `pan_record_id` BIGINT COMMENT 'Foreign key linking to cardholder.pan_record. Business justification: Every gateway payment request is tied to a specific PAN used for the transaction. The gateway uses the PAN record for BIN-based routing, scheme selection, tokenization validation, and fraud scoring. c',
    `payment_credential_id` BIGINT COMMENT 'Foreign key linking to cardholder.payment_credential. Business justification: The gateway must validate which credential (PIN, CVV, biometric, OTP) was presented in the authorization request to enforce SCA compliance and 3DS authentication flows. PSD2/SCA regulatory requirement',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Transaction request includes payment product identifier to apply correct fee schedule and routing logic.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: FX rate lookup needed during processing of multi‑currency transactions; request stores the applied rate for compliance and reporting.',
    `rate_limit_policy_id` BIGINT COMMENT 'Identifier of the rate‑limit rule that applied (if any).',
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
    `cardholder_account_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_account. Business justification: Authorization responses drive account-level state changes: available credit updates, balance adjustments, and delinquency status. Regulatory reporting (e.g., Reg E, PSD2) requires tracing authorizatio',
    `location_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_location. Business justification: Gateway responses must be traceable to the originating merchant location for location-level fraud monitoring, chargeback analysis, and PCI scope reporting. response has merchant_id but not merchant_lo',
    `pan_record_id` BIGINT COMMENT 'Foreign key linking to cardholder.pan_record. Business justification: Authorization responses must reference the specific PAN authorized or declined for card-level decline rate analysis, fraud pattern detection, and usage tracking (pan_record.usage_count, last_used_time',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Response records the FX rate used for the transaction to support post‑settlement audit and dispute handling.',
    `request_id` BIGINT COMMENT 'Identifier of the originating gateway request that generated this response.',
    `routing_decision_id` BIGINT COMMENT 'Foreign key linking to gateway.routing_decision. Business justification: A gateway response is the outcome of processing a request that was routed via a specific routing decision. Linking response → routing_decision completes the end-to-end transaction chain (request → rou',
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
    `cardholder_account_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_account. Business justification: Routing decisions are influenced by account type (debit vs credit), account currency, and account status. Debit accounts route differently than credit accounts; multi-currency accounts trigger FX rout',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Routing decisions drive operational costs (acquirer fees, network costs, processing overhead). Cost center allocation enables profitability analysis by routing strategy, supports operational expense b',
    `gateway_routing_rule_id` BIGINT COMMENT 'Identifier of the routing rule that was evaluated to produce this decision.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: Routing decisions can optimize based on expected interchange rate category to minimize total cost of acceptance. Real business process: predictive cost-optimized routing that considers anticipated int',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant that initiated the payment request.',
    `multi_network_routing_id` BIGINT COMMENT 'Foreign key linking to network.multi_network_routing. Business justification: When a routing_decision uses least-cost or Durbin-compliant multi-network routing, it must reference the multi_network_routing profile that governed network selection. Required for Durbin Amendment co',
    `pan_record_id` BIGINT COMMENT 'Foreign key linking to cardholder.pan_record. Business justification: BIN/IIN-based routing is a core gateway function — the routing decision selects acquirer endpoints based on the PANs BIN range, card scheme, and issuing bank. Linking routing_decision to pan_record e',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Routing decisions consider real‑time FX rates for currency‑based routing rules; storing the rate links decision to the rate source.',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.request. Business justification: Every routing decision is made in direct response to a specific inbound API request. The routing_decision table captures which acquirer was selected for a given payment request — without a request_id ',
    `scheme_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to network.scheme_fee_schedule. Business justification: Least-cost routing decisions are driven by scheme fee schedules. Routing decisions must reference the scheme_fee_schedule consulted to select the optimal acquirer, enabling interchange optimization re',
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
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_account. Business justification: Failover events affect transaction processing for specific merchant accounts. Impact assessment, SLA breach reporting, and merchant notification workflows require knowing which merchant_account was af',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant whose transactions were impacted.',
    `sla_id` BIGINT COMMENT 'Foreign key linking to network.sla. Business justification: Failover events are triggered by SLA threshold breaches. The failover_event.sla_breach_flag is a denormalization signal — the specific network SLA record being breached must be traceable for penalty c',
    `acquirer_endpoint_id` BIGINT COMMENT 'Identifier of the primary (failed) acquirer endpoint.',
    `scheme_id` BIGINT COMMENT 'Identifier of the payment network (e.g., Visa, Mastercard) involved.',
    `sla_profile_id` BIGINT COMMENT 'Foreign key linking to gateway.sla_profile. Business justification: failover_event has sla_breach_flag (boolean) indicating whether the failover caused an SLA breach. Linking failover_event → sla_profile identifies which specific SLA profile was breached during the fa',
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
    `ecosystem_partner_id` BIGINT COMMENT 'Identifier of the partner (e.g., payment service provider) associated with the subscription, if applicable.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant that owns this webhook subscription.',
    `merchant_integration_id` BIGINT COMMENT 'Foreign key linking to gateway.merchant_integration. Business justification: A webhook subscription is registered by a merchant for a specific integration — it defines which events from which integration should trigger webhook notifications. webhook_subscription already has me',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Webhook subscriptions are configured per payment product to notify merchants of product-specific events (authorization, settlement, refund, chargeback). Real-world webhook platforms allow merchants to',
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
    `request_id` BIGINT COMMENT 'Unique identifier for the HTTP request sent to the merchant.',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` (
    `sla_profile_id` BIGINT COMMENT 'Unique identifier for the SLA profile.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Identifier of the acquiring bank or network endpoint covered by the SLA.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partners have SLA agreements with the gateway; the FK enables SLA compliance tracking and breach penalty calculations per partner.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant to which the SLA applies.',
    `merchant_integration_id` BIGINT COMMENT 'Foreign key linking to gateway.merchant_integration. Business justification: The sla_profile description explicitly states it defines SLA commitments for a merchant integration or acquirer endpoint. sla_profile already has acquirer_endpoint_id (existing FK) and merchant_id (',
    `sla_id` BIGINT COMMENT 'Foreign key linking to network.sla. Business justification: Gateway SLA profiles must reference the governing network-level SLA (scheme uptime/latency obligations) to ensure compliance with scheme requirements. Operations and compliance teams trace gateway SLA',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: SLA breaches trigger penalty obligations (payables to merchants) or penalty income (receivables from acquirers). Direct GL account linkage enables automated accrual of SLA-related financial obligation',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` (
    `threeds_config_id` BIGINT COMMENT 'Unique surrogate key for each 3-D Secure configuration record.',
    `merchant_integration_id` BIGINT COMMENT 'Foreign key linking to gateway.merchant_integration. Business justification: threeds_config is described as 3-D Secure authentication settings applied per merchant integration. Without this FK, threeds_config is completely siloed within the gateway domain — it has no in-doma',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: 3DS configurations are scheme-specific (Visa 3DS2 vs Mastercard Identity Check have distinct protocol rules). Compliance certification and scheme-specific 3DS reporting require knowing which schemes ',
    `scheme_parameter_id` BIGINT COMMENT 'Foreign key linking to network.scheme_parameter. Business justification: 3DS gateway configurations must comply with scheme-mandated parameters (protocol version, exemption thresholds, challenge rules). Compliance audits trace threeds_config settings to the specific scheme',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ADD CONSTRAINT `fk_gateway_gateway_api_credential_rate_limit_policy_id` FOREIGN KEY (`rate_limit_policy_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`rate_limit_policy`(`rate_limit_policy_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ADD CONSTRAINT `fk_gateway_merchant_integration_rate_limit_policy_id` FOREIGN KEY (`rate_limit_policy_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`rate_limit_policy`(`rate_limit_policy_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_rate_limit_policy_id` FOREIGN KEY (`rate_limit_policy_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`rate_limit_policy`(`rate_limit_policy_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ADD CONSTRAINT `fk_gateway_gateway_routing_rule_target_acquirer_acquirer_endpoint_id` FOREIGN KEY (`target_acquirer_acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_merchant_integration_id` FOREIGN KEY (`merchant_integration_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`merchant_integration`(`merchant_integration_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ADD CONSTRAINT `fk_gateway_request_rate_limit_policy_id` FOREIGN KEY (`rate_limit_policy_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`rate_limit_policy`(`rate_limit_policy_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ADD CONSTRAINT `fk_gateway_response_routing_decision_id` FOREIGN KEY (`routing_decision_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`routing_decision`(`routing_decision_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ADD CONSTRAINT `fk_gateway_routing_decision_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ADD CONSTRAINT `fk_gateway_routing_decision_gateway_routing_rule_id` FOREIGN KEY (`gateway_routing_rule_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`gateway_routing_rule`(`gateway_routing_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ADD CONSTRAINT `fk_gateway_routing_decision_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ADD CONSTRAINT `fk_gateway_failover_event_gateway_routing_rule_id` FOREIGN KEY (`gateway_routing_rule_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`gateway_routing_rule`(`gateway_routing_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ADD CONSTRAINT `fk_gateway_failover_event_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ADD CONSTRAINT `fk_gateway_failover_event_sla_profile_id` FOREIGN KEY (`sla_profile_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`sla_profile`(`sla_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ADD CONSTRAINT `fk_gateway_failover_event_target_endpoint_acquirer_endpoint_id` FOREIGN KEY (`target_endpoint_acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ADD CONSTRAINT `fk_gateway_webhook_subscription_merchant_integration_id` FOREIGN KEY (`merchant_integration_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`merchant_integration`(`merchant_integration_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ADD CONSTRAINT `fk_gateway_webhook_delivery_request_id` FOREIGN KEY (`request_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`request`(`request_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ADD CONSTRAINT `fk_gateway_webhook_delivery_webhook_subscription_id` FOREIGN KEY (`webhook_subscription_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`webhook_subscription`(`webhook_subscription_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ADD CONSTRAINT `fk_gateway_sla_profile_acquirer_endpoint_id` FOREIGN KEY (`acquirer_endpoint_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`acquirer_endpoint`(`acquirer_endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ADD CONSTRAINT `fk_gateway_sla_profile_merchant_integration_id` FOREIGN KEY (`merchant_integration_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`merchant_integration`(`merchant_integration_id`);
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ADD CONSTRAINT `fk_gateway_threeds_config_merchant_integration_id` FOREIGN KEY (`merchant_integration_id`) REFERENCES `payments_fintech_ecm`.`gateway`.`merchant_integration`(`merchant_integration_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`gateway` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `payments_fintech_ecm`.`gateway` SET TAGS ('dbx_domain' = 'gateway');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` SET TAGS ('dbx_subdomain' = 'integration_management');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `gateway_api_credential_id` SET TAGS ('dbx_business_glossary_term' = 'API Credential Identifier (API_CRED_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_api_credential` ALTER COLUMN `rate_limit_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Policy Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `mdr_config_id` SET TAGS ('dbx_business_glossary_term' = 'Mdr Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `rate_limit_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'pending|completed|rejected|inactive');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `pci_dss_compliance_tier` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance Tier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `pci_dss_compliance_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`merchant_integration` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version');
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
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` SET TAGS ('dbx_subdomain' = 'transaction_routing');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `gateway_routing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Routing Rule ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `bin_sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Bin Sponsorship Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `mdr_config_id` SET TAGS ('dbx_business_glossary_term' = 'Mdr Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `network_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `network_routing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Network Routing Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Target Acquirer ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `rate_limit_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `routing_table_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `routing_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Routing Algorithm');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `routing_algorithm` SET TAGS ('dbx_value_regex' = 'round_robin|least_connections|weighted');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Code');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Name');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'least_cost|scheme_preference|geographic|custom');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `tokenization_required` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Required');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'auth|capture|sale|refund|void');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`gateway_routing_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` SET TAGS ('dbx_subdomain' = 'transaction_routing');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Endpoint ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `acquirer_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Failover Endpoint ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `partner_settlement_account_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Settlement Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `scheme_fee_table_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `acquirer_bic` SET TAGS ('dbx_business_glossary_term' = 'Bank Identifier Code (BIC)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `acquirer_bic` SET TAGS ('dbx_value_regex' = '^[A-Z]{8,11}$');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`acquirer_endpoint` ALTER COLUMN `acquirer_endpoint_description` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Description');
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
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` SET TAGS ('dbx_subdomain' = 'transaction_routing');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Location Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID (MID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `merchant_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Integration Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `pan_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pan Record Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `payment_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Credential Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`request` ALTER COLUMN `rate_limit_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Rate‑Limit Rule ID');
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
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` SET TAGS ('dbx_subdomain' = 'transaction_routing');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `response_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Response ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Location Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `pan_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pan Record Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`response` ALTER COLUMN `routing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` SET TAGS ('dbx_subdomain' = 'transaction_routing');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `routing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `cardholder_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `gateway_routing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `multi_network_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Multi Network Routing Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `pan_record_id` SET TAGS ('dbx_business_glossary_term' = 'Pan Record Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`routing_decision` ALTER COLUMN `scheme_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Schedule Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` SET TAGS ('dbx_subdomain' = 'transaction_routing');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `failover_event_id` SET TAGS ('dbx_business_glossary_term' = 'Failover Event Identifier (FAILOVER_EVENT_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `gateway_routing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Policy Identifier (ROUTE_POLICY_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MERCHANT_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Network Sla Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Acquirer Endpoint Identifier (SOURCE_ENDPOINT_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Network Identifier (NETWORK_ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`failover_event` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Profile Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` SET TAGS ('dbx_subdomain' = 'transaction_routing');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `webhook_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Webhook Subscription Identifier (WSID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (PID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `merchant_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Integration Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_subscription` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` SET TAGS ('dbx_subdomain' = 'transaction_routing');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `webhook_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Webhook Delivery Identifier');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`webhook_delivery` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Request Identifier');
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
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` SET TAGS ('dbx_subdomain' = 'integration_management');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `rate_limit_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Limit Policy ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`rate_limit_policy` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` SET TAGS ('dbx_subdomain' = 'transaction_routing');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `sla_profile_id` SET TAGS ('dbx_business_glossary_term' = 'SLA Profile ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `merchant_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Integration Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Network Sla Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`sla_profile` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Penalty Gl Account Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` SET TAGS ('dbx_subdomain' = 'integration_management');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `threeds_config_id` SET TAGS ('dbx_business_glossary_term' = '3-D Secure Configuration Identifier (3DS Config ID)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `merchant_integration_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Integration Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`gateway`.`threeds_config` ALTER COLUMN `scheme_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Parameter Id (Foreign Key)');
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
