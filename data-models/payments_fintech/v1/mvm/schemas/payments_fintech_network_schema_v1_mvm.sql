-- Schema for Domain: network | Business: Payments Fintech | Version: v1_mvm
-- Generated on: 2026-05-03 21:29:50

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`network` COMMENT 'Defines payment network connectivity, routing rules, and messaging metadata for each payment scheme (Visa, Mastercard, Amex, Discover). Owns network endpoints, routing tables, scheme parameter configurations, network certification records, and multi-network transaction routing logic.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`scheme` (
    `scheme_id` BIGINT COMMENT 'Unique surrogate key for each payment scheme record.',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Payment schemes operate under jurisdiction-specific rules (geographic_coverage, settlement_currency). Linking scheme to jurisdiction_profile enables jurisdiction-specific compliance reporting, cross-b',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Payment schemes operate under specific legal entities for regulatory licensing, financial reporting, and liability. Essential for compliance reporting (PCI DSS, PSD2) and consolidation of scheme-relat',
    `policy_document_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_document. Business justification: Payment schemes publish operating regulations and rulebooks that are formal policy documents. Compliance teams track which policy document (scheme rulebook version) governs each scheme. Scheme ruleboo',
    `rate_feed_id` BIGINT COMMENT 'Foreign key linking to fx.rate_feed. Business justification: Payment schemes designate specific FX rate feeds for DCC and cross-border rate sourcing — Visa uses specific rate providers, Mastercard uses others. Scheme-specific rate feed configuration for DCC com',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Payment schemes (Visa, Mastercard) operate under specific regulatory obligations (PSD2, local mandates). Compliance teams must map each scheme to its governing regulatory obligation for scheme complia',
    `compliance_requirements` STRING COMMENT 'Regulatory and industry standards the scheme must adhere to.. Valid values are `PCI_DSS|PSD2|EMVCo|ISO20022`',
    `contact_email` STRING COMMENT 'Primary email address for scheme support inquiries.',
    `contact_phone` STRING COMMENT 'Primary telephone number for scheme support inquiries.',
    `currency_supported` STRING COMMENT 'Currencies in which the scheme can settle transactions.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `effective_date` DATE COMMENT 'Date on which the scheme became effective for routing and processing.',
    `geographic_coverage` STRING COMMENT 'List of ISO‑3166‑1 alpha‑3 country codes where the scheme is accepted.',
    `governing_body` STRING COMMENT 'Legal entity that owns or governs the scheme (e.g., Visa Inc., Mastercard).',
    `interchange_fee_rate` DECIMAL(18,2) COMMENT 'Numeric fee rate applied to transactions (e.g., 0.0150 for 1.5%).',
    `interchange_fee_type` STRING COMMENT 'Indicates whether the interchange fee is calculated as a percentage or a fixed amount.. Valid values are `percentage|fixed`',
    `network_certification_date` DATE COMMENT 'Date when the scheme achieved its most recent network certification.',
    `network_certification_status` STRING COMMENT 'Current certification status of the scheme within the network.. Valid values are `certified|pending|revoked`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the scheme record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the scheme record.',
    `risk_profile` STRING COMMENT 'Risk classification of the scheme based on fraud and chargeback history.. Valid values are `low|medium|high`',
    `scheme_code` STRING COMMENT 'Canonical short code used to identify the scheme in messages and reports (e.g., VISA, MC).',
    `scheme_description` STRING COMMENT 'Free‑form description of the scheme, its purpose and key characteristics.',
    `scheme_name` STRING COMMENT 'Human‑readable name of the payment scheme (e.g., Visa, Mastercard).',
    `scheme_status` STRING COMMENT 'Current operational status of the scheme within the platform.. Valid values are `active|inactive|suspended|pending|retired`',
    `scheme_type` STRING COMMENT 'Category of the scheme based on the primary instrument or service it supports.. Valid values are `card|digital_wallet|bank_transfer|crypto`',
    `settlement_currency` STRING COMMENT 'Default currency used for settlement of scheme transactions.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `settlement_method` STRING COMMENT 'Method used to settle transactions for the scheme.. Valid values are `real_time|batch|net`',
    `supported_transaction_types` STRING COMMENT 'Comma‑separated list of transaction types the scheme supports (e.g., purchase, refund, cash‑advance).',
    `termination_date` DATE COMMENT 'Date on which the scheme was retired or ceased to be supported (nullable).',
    `three_ds_supported` BOOLEAN COMMENT 'Indicates whether the scheme supports 3‑Domain Secure authentication.',
    `tokenization_supported` BOOLEAN COMMENT 'Indicates whether the scheme supports tokenization of PANs.',
    `version` STRING COMMENT 'Version identifier for the scheme definition (e.g., v2.1).',
    `website_url` STRING COMMENT 'Public website URL providing scheme specifications and resources.',
    CONSTRAINT pk_scheme PRIMARY KEY(`scheme_id`)
) COMMENT 'Master record for each payment card scheme (Visa, Mastercard, Amex, Discover, UnionPay, etc.). Defines the scheme brand identity, governing body, supported transaction types, geographic reach, and scheme-level operational parameters. SSOT for payment scheme identity across the platform.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`endpoint` (
    `endpoint_id` BIGINT COMMENT 'Unique surrogate key for the network endpoint record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Network endpoints (gateways, data centers) incur operational costs (hosting, bandwidth, maintenance). Linking to cost_center enables accurate allocation of infrastructure expenses for budgeting, varia',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Required for routing and settlement reports to map each network endpoint to the owning partner (acquirer/issuer) responsible for traffic and fee allocation.',
    `pci_dss_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.pci_dss_audit. Business justification: Network endpoints are in-scope CDE (Cardholder Data Environment) components for PCI-DSS audits. Linking endpoint to pci_dss_audit enables tracking which endpoints were assessed in each audit cycle — a',
    `policy_document_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_document. Business justification: Endpoints operate under specific security and connectivity policies (TLS policies, encryption standards, access control policies). Linking endpoint to policy_document enables compliance teams to verif',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Endpoint compliance audit requires mapping each network endpoint to the regulatory obligation it satisfies (PCI‑DSS, ISO‑20022).',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Endpoints belong to a payment scheme; adding scheme_id FK normalizes the relationship and removes the redundant network_scheme string column.',
    `audit_trail` STRING COMMENT 'Free‑form notes capturing audit events related to the endpoint.',
    `authentication_method` STRING COMMENT 'Method used to authenticate connections to the endpoint.. Valid values are `MutualTLS|APIKey|OAuth|Other`',
    `average_latency_ms` DECIMAL(18,2) COMMENT 'Mean round‑trip latency observed for the endpoint, measured in milliseconds.',
    `certificate_expiration_date` DATE COMMENT 'Date when the associated TLS certificate expires.',
    `compliance_iso_20022` BOOLEAN COMMENT 'Indicates compliance with ISO 20022 messaging standards.',
    `compliance_pci_dss` BOOLEAN COMMENT 'Indicates whether the endpoint meets PCI DSS requirements.',
    `compliance_regulatory` STRING COMMENT 'Comma‑separated list of regulatory codes (e.g., PSD2, SOX) applicable to the endpoint.',
    `connection_type` STRING COMMENT 'Indicates whether connections are persistent or stateless.. Valid values are `persistent|stateless`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the endpoint record was first created.',
    `data_center_location` STRING COMMENT 'Physical data‑center location (city, facility) hosting the endpoint.',
    `effective_from` DATE COMMENT 'Date when the endpoint became operationally effective.',
    `effective_until` DATE COMMENT 'Date when the endpoint is scheduled to be retired; null if indefinite.',
    `encryption_protocol` STRING COMMENT 'Encryption protocol negotiated for the endpoint.. Valid values are `TLS1.2|TLS1.3|Other`',
    `endpoint_code` STRING COMMENT 'Business‑level unique code used in operational processes.',
    `endpoint_description` STRING COMMENT 'Free‑form description of the endpoint purpose and characteristics.',
    `endpoint_name` STRING COMMENT 'Human‑readable name identifying the endpoint.',
    `endpoint_status` STRING COMMENT 'Current operational status of the endpoint.. Valid values are `active|inactive|maintenance|decommissioned`',
    `health_check_interval_seconds` STRING COMMENT 'Interval between successive health checks, in seconds.',
    `health_check_timeout_seconds` STRING COMMENT 'Maximum time to wait for a health‑check response before marking it failed.',
    `health_status` STRING COMMENT 'Current health assessment of the endpoint.. Valid values are `healthy|degraded|unhealthy`',
    `host_url` STRING COMMENT 'Fully qualified URL or hostname used to reach the endpoint.',
    `ip_address_range` STRING COMMENT 'CIDR notation representing the IP range allocated to the endpoint.',
    `is_primary` BOOLEAN COMMENT 'Flag indicating whether this endpoint is the primary for its scheme.',
    `is_tls_mutual` BOOLEAN COMMENT 'True if mutual TLS authentication is required.',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful health‑check.',
    `maintenance_window` STRING COMMENT 'Planned maintenance period (e.g., "Sat 02:00‑04:00 UTC").',
    `max_connections` STRING COMMENT 'Maximum number of simultaneous connections the endpoint can sustain.',
    `max_message_size_bytes` STRING COMMENT 'Maximum size of a single message the endpoint will accept, in bytes.',
    `monitoring_endpoint` STRING COMMENT 'URL used by monitoring tools to probe endpoint health.',
    `network_interface` STRING COMMENT 'Type of network interface (e.g., Ethernet, Fiber).',
    `port` STRING COMMENT 'TCP/UDP port number on which the endpoint listens.',
    `protocol_version` STRING COMMENT 'Version of the messaging protocol used (e.g., ISO8583, ISO20022).. Valid values are `ISO8583|ISO20022|Other`',
    `routing_priority` STRING COMMENT 'Numeric priority used when selecting among multiple eligible endpoints.',
    `supported_currencies` STRING COMMENT 'Comma‑separated list of ISO 4217 currency codes the endpoint can process.',
    `supported_message_format` STRING COMMENT 'Message format(s) the endpoint can process.. Valid values are `iso8583|iso20022|other`',
    `throughput_tps` DECIMAL(18,2) COMMENT 'Average number of transactions the endpoint processes per second.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the endpoint record.',
    CONSTRAINT pk_endpoint PRIMARY KEY(`endpoint_id`)
) COMMENT 'Defines physical and logical connectivity endpoints for each payment network — host URLs, IP ranges, port configurations, protocol versions (ISO 8583, ISO 20022), TLS certificate references, and connection health thresholds. Represents the network infrastructure layer for scheme connectivity.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`routing_table` (
    `routing_table_id` BIGINT COMMENT 'Unique identifier for the routing rule record.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Routing table entries are currency-specific for cross-border transactions. The plain currency_code attribute is a denormalized representation of the currency pair. Currency-aware routing configuration',
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.endpoint. Business justification: Routing table should link to the endpoint entity rather than storing a URL string; this creates a true relational link and removes redundant data.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: Least-cost routing (LCR) is a core payments business process where routing decisions are made based on interchange rate categories. Routing tables must reference the target irf_rate_category to implem',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Routing tables are jurisdiction-specific (Durbin Amendment in US, PSD2 in EU require specific routing rules). Linking routing_table to jurisdiction_profile enables compliance audits of jurisdiction-sp',
    `policy_id` BIGINT COMMENT 'Foreign key linking to risk.risk_policy. Business justification: Routing tables enforce risk policies — the risk_score_threshold attribute on routing_table confirms risk-policy-governed routing. Routing decisions for high-risk transactions (by MCC, BIN, amount) are',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Routing tables have a compliance_check_required flag — the specific regulatory obligation driving that check must be traceable. Compliance teams need to identify which regulatory obligation mandates',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Routing tables are defined per scheme; adding scheme_id FK creates parent relationship and removes need for any scheme string column (none present).',
    `bin_range_end` STRING COMMENT 'Ending BIN of the inclusive range for which this rule applies.. Valid values are `^d{6,8}$`',
    `bin_range_start` STRING COMMENT 'Starting BIN (Bank Identification Number) of the inclusive range for which this rule applies.. Valid values are `^d{6,8}$`',
    `change_reason` STRING COMMENT 'Business reason or justification for the most recent modification.',
    `compliance_check_required` BOOLEAN COMMENT 'Specifies if regulatory compliance checks must be performed before routing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the routing rule record was first created.',
    `effective_from` DATE COMMENT 'Date when the routing rule becomes active.',
    `effective_until` DATE COMMENT 'Date when the routing rule expires; null if indefinite.',
    `fallback_sequence` STRING COMMENT 'Order number for fallback routing attempts.',
    `fee_rate` DECIMAL(18,2) COMMENT 'Fee rate (as a decimal fraction) applied when routing through the target network.',
    `is_fallback_enabled` BOOLEAN COMMENT 'Indicates whether fallback routing is permitted if primary routing fails.',
    `last_tested_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent automated test of the routing rule.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Upper monetary limit for transactions that can be routed by this rule.',
    `mcc_code` STRING COMMENT 'Merchant category code that the rule matches.. Valid values are `^d{4}$`',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'Lower monetary threshold for transactions applicable to this rule.',
    `priority` STRING COMMENT 'Numeric priority determining rule precedence (lower = higher priority).',
    `processing_rail` STRING COMMENT 'Processing mode used for the routed transaction.. Valid values are `real_time|batch|offline`',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Maximum allowed fraud risk score for a transaction to be routed via this rule.',
    `routing_table_description` STRING COMMENT 'Free‑form description of the routing rule purpose and logic.',
    `routing_table_status` STRING COMMENT 'Current lifecycle status of the routing rule.. Valid values are `active|inactive|deprecated|pending`',
    `routing_type` STRING COMMENT 'Classification of the routing logic applied.. Valid values are `least_cost|failover|primary|secondary`',
    `rule_code` STRING COMMENT 'Business identifier code for the routing rule.',
    `rule_name` STRING COMMENT 'Human‑readable name of the routing rule.',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Fixed surcharge amount added to the transaction fee for this routing path.',
    `target_network` STRING COMMENT 'Payment network to which the transaction should be routed.. Valid values are `visa|mastercard|amex|discover|unionpay|local`',
    `test_result` STRING COMMENT 'Outcome of the most recent routing rule test.. Valid values are `pass|fail|warning`',
    `transaction_type` STRING COMMENT 'Type of transaction the routing rule applies to.. Valid values are `purchase|refund|cash_advance|preauth|void`',
    `updated_by` STRING COMMENT 'Identifier of the user or system that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the routing rule.',
    `version_number` STRING COMMENT 'Sequential version number for change tracking.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the rule.',
    CONSTRAINT pk_routing_table PRIMARY KEY(`routing_table_id`)
) COMMENT 'Defines transaction routing rules mapping BIN ranges, MCC codes, transaction types, and currency combinations to target network endpoints and processing rails. Supports multi-network routing logic, least-cost routing, and failover sequencing. Core operational artifact for the Payment Gateway and Authorization Engine.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` (
    `network_routing_rule_id` BIGINT COMMENT 'System-generated unique identifier for the routing rule.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Foreign key linking to the acquirer endpoint',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: Network routing rules implement least-cost routing by directing transactions to the network yielding the preferred interchange rate category. Routing rule configuration, LCR compliance reporting, and ',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Network routing rules have a region_code attribute and jurisdiction-specific compliance_status. Linking to jurisdiction_profile enables compliance teams to audit routing rules against jurisdiction-s',
    `policy_document_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_document. Business justification: Individual routing rules are governed by routing policy documents (scheme operating regulations, internal routing policies). Linking routing rules to their governing policy document enables policy-dri',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Routing rules carry a compliance_status field — the regulatory obligation driving that status must be traceable. Compliance teams need to map routing rules to specific regulatory obligations (e.g., Du',
    `routing_table_id` BIGINT COMMENT 'Foreign key linking to network.routing_table. Business justification: Routing rules belong to a routing table; adding routing_table_id FK establishes hierarchy.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to the card scheme',
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.endpoint. Business justification: Routing rule must reference the actual endpoint entity; replace the free‑text column with a proper foreign key to enforce data integrity and enable joins.',
    `amount_max` DECIMAL(18,2) COMMENT 'Upper bound of transaction amount (in rule currency) for which the rule is applicable.',
    `amount_min` DECIMAL(18,2) COMMENT 'Lower bound of transaction amount (in rule currency) for which the rule is applicable.',
    `bin_end` STRING COMMENT 'Last BIN in the inclusive range that the rule applies to.. Valid values are `^d{6,8}$`',
    `bin_start` STRING COMMENT 'First BIN (Bank Identification Number) in the inclusive range that the rule applies to.. Valid values are `^d{6,8}$`',
    `card_type` STRING COMMENT 'Category of payment instrument the rule targets.. Valid values are `credit|debit|prepaid|commercial|unknown`',
    `compliance_status` STRING COMMENT 'Indicates whether the rule has been reviewed and approved against PCI DSS, PSD2, and other applicable regulations.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the routing rule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for amount thresholds.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'Date on which the rule becomes active.',
    `effective_until` DATE COMMENT 'Date after which the rule is no longer applied; null indicates indefinite validity.',
    `is_default_rule` BOOLEAN COMMENT 'Flag indicating whether this rule is the default fallback',
    `is_override` BOOLEAN COMMENT 'Indicates whether this rule can supersede lower‑priority rules for the same criteria.',
    `last_executed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent transaction that matched this rule.',
    `match_criteria` STRING COMMENT 'Criteria expression used to match transactions to this rule',
    `network_routing_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|deprecated`',
    `priority` STRING COMMENT 'Integer indicating rule precedence; lower numbers are evaluated first.',
    `region_code` STRING COMMENT 'ISO 3166‑1 alpha‑3 country or region code to which the rule applies.. Valid values are `^[A-Z]{3}$`',
    `rule_code` STRING COMMENT 'Business‑unique code used to reference the rule in configuration and logs.',
    `rule_description` STRING COMMENT 'Detailed free‑text description of the rule logic and intent.',
    `rule_name` STRING COMMENT 'Human‑readable name describing the purpose of the routing rule.',
    `rule_type` STRING COMMENT 'Classification of the rule logic (e.g., BIN range, amount threshold, geographic, or composite).',
    `rule_version` STRING COMMENT 'Version identifier for change‑management and audit purposes.',
    `transaction_type` STRING COMMENT 'Type of transaction the rule evaluates.. Valid values are `purchase|refund|cash_advance|auth|capture|reversal`',
    `updated_by` STRING COMMENT 'Identifier of the internal user or service that last modified the rule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the routing rule.',
    `created_by` STRING COMMENT 'Identifier of the internal user or service that created the rule.',
    CONSTRAINT pk_network_routing_rule PRIMARY KEY(`network_routing_rule_id`)
) COMMENT 'Individual routing rule entry within a routing table. Specifies the condition set (BIN range, card type, transaction type, amount threshold, currency, region) and the target network endpoint or rail. Supports priority ordering, effective date ranges, and override flags for dynamic routing decisions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` (
    `scheme_parameter_id` BIGINT COMMENT 'Unique surrogate identifier for each scheme parameter record.',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: Scheme parameters (CVV required, EMV required, 3DS required) directly govern interchange qualification criteria for specific rate categories. Interchange qualification engine configuration and scheme ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Scheme parameters (floor limits, velocity caps, 3DS mandates) are frequently driven by regulatory obligations. The existing regulatory_reference plain attribute is a denormalized text reference to r',
    `scheme_id` BIGINT COMMENT 'FK to network.scheme',
    `applies_to_card_type` STRING COMMENT 'Card product types to which the parameter is applicable.. Valid values are `credit|debit|prepaid|commercial|all`',
    `applies_to_mcc` STRING COMMENT 'Four‑digit MCC to which the parameter is limited; null if not MCC‑specific.. Valid values are `^d{4}$`',
    `applies_to_transaction_type` STRING COMMENT 'Transaction operation types governed by the parameter.. Valid values are `purchase|refund|cash_advance|reversal|auth|capture`',
    `change_reason` STRING COMMENT 'Free‑text description of why the parameter value was changed.',
    `compliance_flag` STRING COMMENT 'Indicates regulatory framework(s) the parameter satisfies.. Valid values are `pci_dss|psd2|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the parameter record was first inserted into the lakehouse.',
    `effective_from` DATE COMMENT 'Date on which the parameter becomes effective for transaction processing.',
    `effective_until` DATE COMMENT 'Date on which the parameter expires; null if the parameter is open‑ended.',
    `is_global` BOOLEAN COMMENT 'True if the parameter applies to all merchants and terminals; false if scoped to specific groups.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the parameter must be enforced for all transactions.',
    `last_review_date` DATE COMMENT 'Date when the parameter was last reviewed for relevance or compliance.',
    `parameter_category` STRING COMMENT 'Broad classification of the parameter (e.g., floor_limit, velocity_threshold, cvv_requirement, avs_requirement, 3ds_mandate, sca_exemption, chargeback_time_limit, emv_fallback). [ENUM-REF-CANDIDATE: floor_limit|velocity_threshold|cvv_requirement|avs_requirement|3ds_mandate|sca_exemption|chargeback_time_limit|emv_fallback|other — promote to reference product]',
    `parameter_code` STRING COMMENT 'Unique code assigned by the card network to identify the parameter.',
    `parameter_name` STRING COMMENT 'Human‑readable name describing the configuration parameter.',
    `parameter_value` DECIMAL(18,2) COMMENT 'Raw value of the parameter as provided by the scheme; stored as string to accommodate numeric, boolean, or textual formats.',
    `scheme_parameter_description` STRING COMMENT 'Detailed free‑text description of the parameter purpose and usage.',
    `scheme_parameter_status` STRING COMMENT 'Current lifecycle state of the parameter record.. Valid values are `active|inactive|deprecated|pending`',
    `source_bulletin_date` DATE COMMENT 'Date of the network bulletin that introduced or updated the parameter.',
    `unit_of_measure` STRING COMMENT 'Unit associated with the parameter value (e.g., USD, count, minutes).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the parameter record.',
    `value_data_type` STRING COMMENT 'Data type of the parameter value indicating how it should be interpreted.. Valid values are `integer|decimal|boolean|string|date`',
    `version_number` STRING COMMENT 'Incremental version of the parameter record for change tracking.',
    CONSTRAINT pk_scheme_parameter PRIMARY KEY(`scheme_parameter_id`)
) COMMENT 'Stores scheme-specific configuration parameters published by card networks — authorization floor limits, velocity thresholds, CVV/AVS requirement flags, 3DS mandate settings, SCA exemption rules, chargeback time limits, and EMV fallback policies. Updated per scheme bulletin cycles.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`sla` (
    `sla_id` BIGINT COMMENT 'System‑generated unique identifier for the SLA record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: SLA penalty and performance cost allocations are charged to internal cost centers for charge‑back reporting.',
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.endpoint. Business justification: The sla table contains endpoint_identifier as a STRING field, which is a denormalized reference to the endpoint it governs. SLA commitments in payment networks are defined per physical/logical connect',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: SLAs are jurisdiction-specific — PSD2 mandates specific payment processing time SLAs in the EU, while other jurisdictions have different requirements. Linking SLA to jurisdiction_profile enables juris',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: SLAs are service contracts between legal entities (e.g., fintech platform and scheme network). Required for tracking penalty liabilities, revenue commitments, and ensuring contract obligations and fin',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: SLA contracts must reference the specific regulatory obligation they support for compliance reporting.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: SLAs are negotiated per scheme; replace scheme_code with scheme_id FK.',
    `actual_authorization_response_time_ms` STRING COMMENT 'Measured average authorization response time during the reporting period.',
    `actual_batch_settlement_window_hours` STRING COMMENT 'Observed average time taken to settle batches.',
    `actual_latency_ms` STRING COMMENT 'Observed average latency during the reporting period.',
    `actual_uptime_percentage` DECIMAL(18,2) COMMENT 'Measured network availability percentage for the reporting period.',
    `batch_settlement_window_hours` STRING COMMENT 'Maximum time allowed to complete batch settlement after transaction capture.',
    `compliance_status` STRING COMMENT 'Current compliance state of the SLA with applicable regulations.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SLA record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for penalty and any monetary SLA components.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'Date when the SLA becomes binding.',
    `effective_until` DATE COMMENT 'Date when the SLA expires or is terminated (null for open‑ended).',
    `escalation_contact_email` STRING COMMENT 'Email address of the person or team to notify on SLA breach.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_contact_phone` STRING COMMENT 'Phone number for SLA breach escalation.. Valid values are `^+?[0-9]{7,15}$`',
    `last_review_date` DATE COMMENT 'Date of the most recent SLA performance review.',
    `max_latency_ms` STRING COMMENT 'Maximum allowed network latency for transaction messages, in milliseconds.',
    `monitoring_frequency` STRING COMMENT 'How often SLA performance metrics are measured and reported.. Valid values are `real_time|hourly|daily|weekly`',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or special conditions.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary value of the penalty for a breach, expressed in the contract currency.',
    `penalty_clause` STRING COMMENT 'Text describing the financial penalty applied for SLA breaches.',
    `sla_category` STRING COMMENT 'Classification of the SLA metric type (authorization response time, uptime, latency, settlement window).. Valid values are `authorization_response|uptime|latency|settlement`',
    `sla_name` STRING COMMENT 'Human‑readable name of the service‑level agreement.',
    `sla_status` STRING COMMENT 'Current lifecycle status of the SLA record.. Valid values are `active|inactive|suspended|pending|terminated`',
    `target_authorization_response_time_ms` STRING COMMENT 'Promised maximum time for a real‑time authorization response, expressed in milliseconds.',
    `target_uptime_percentage` DECIMAL(18,2) COMMENT 'Contracted network availability expressed as a percentage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the SLA record.',
    `version` STRING COMMENT 'Version identifier for the SLA contract (e.g., v1.0, v2.1).',
    CONSTRAINT pk_sla PRIMARY KEY(`sla_id`)
) COMMENT 'Defines SLA commitments for each payment network connection — target authorization response time (TPS), uptime percentage, maximum latency thresholds, batch settlement window, and penalty clauses. Tracks contracted vs. actual performance metrics per scheme and endpoint.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`scheme_membership` (
    `scheme_membership_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each scheme membership record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Scheme membership (Visa/Mastercard principal or affiliate status) is held by a specific partner entity. Regulatory compliance reporting, certification tracking, and fee billing all require knowing whi',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Scheme membership terms, fees, and compliance obligations are jurisdiction-specific. Linking membership to jurisdiction_profile enables compliance teams to report on membership status by regulatory zo',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Scheme memberships are contractual agreements held by specific legal entities. Required for tracking membership fees payable/receivable, contract liability recognition, and ensuring the correct legal ',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to fx.nostro_account. Business justification: Scheme membership fees (annual fees, renewal fees) are paid from designated nostro accounts. The plain fee_payment_account attribute is a denormalized reference to the nostro account. Membership fee p',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Membership records belong to a scheme; replace scheme_code with scheme_id FK.',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Recurring fee charged to the platform for membership per year.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the membership record was first created in the lakehouse.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the membership record.',
    `compliance_deadline` DATE COMMENT 'Date by which any outstanding compliance obligations must be satisfied.',
    `compliance_obligation_summary` STRING COMMENT 'High‑level description of the key compliance obligations tied to the membership.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the membership with scheme rules.. Valid values are `compliant|non_compliant|pending_review`',
    `contract_document_url` STRING COMMENT 'Link to the stored membership contract document.',
    `contract_version` STRING COMMENT 'Version identifier of the contract document.',
    `dispute_resolution_process` STRING COMMENT 'Description of the process for handling disputes with the scheme.',
    `effective_from` DATE COMMENT 'Date on which the membership agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date on which the membership agreement expires or is terminated (null for open‑ended).',
    `fee_currency` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the annual fee.',
    `fee_payment_frequency` STRING COMMENT 'How often the annual fee is invoiced.. Valid values are `annual|monthly|quarterly|once`',
    `fee_payment_method` STRING COMMENT 'Method used to remit the annual or renewal fee to the scheme.. Valid values are `ach|wire|credit_card|paypal`',
    `last_review_date` DATE COMMENT 'Most recent date the membership agreement was reviewed for compliance.',
    `membership_number` STRING COMMENT 'External business identifier assigned to the membership agreement by the platform.',
    `membership_status` STRING COMMENT 'Current lifecycle state of the membership agreement.. Valid values are `active|suspended|terminated|pending|draft`',
    `membership_type` STRING COMMENT 'Classification of the membership relationship with the scheme.. Valid values are `principal|associate|affiliate`',
    `network_certification_date` DATE COMMENT 'Date on which the most recent certification was granted.',
    `network_certification_status` STRING COMMENT 'Current certification status of the platform with the scheme.. Valid values are `certified|pending|revoked`',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or comments.',
    `onboarding_date` DATE COMMENT 'Date the membership was initially onboarded into the platform.',
    `renewal_date` DATE COMMENT 'Scheduled date for membership renewal consideration.',
    `renewal_fee_amount` DECIMAL(18,2) COMMENT 'Fee amount applicable for the upcoming renewal period.',
    `renewal_fee_currency` STRING COMMENT 'Currency of the renewal fee.',
    `renewal_option` STRING COMMENT 'Whether renewal is automatic or requires manual approval.. Valid values are `auto|manual`',
    `termination_reason` STRING COMMENT 'Reason provided for terminating the membership agreement.',
    `updated_by` STRING COMMENT 'User or system that performed the latest update.',
    `created_by` STRING COMMENT 'User or system that initially created the record.',
    CONSTRAINT pk_scheme_membership PRIMARY KEY(`scheme_membership_id`)
) COMMENT 'Records the formal membership and participation agreements between the platform (as acquirer, issuer, or processor) and each card scheme. Stores membership type (principal, associate, affiliate), membership ID, effective date, annual fees, and compliance obligations. SSOT for scheme participation status.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` (
    `scheme_fee_schedule_id` BIGINT COMMENT 'System-generated unique identifier for each scheme fee schedule record.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Scheme fee schedules for cross-border transactions apply to specific currency pairs (e.g., USD/EUR interchange rates differ from USD/GBP). Cross-border interchange fee calculation and scheme fee repor',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Fee schedule entries are posted to specific GL accounts for revenue recognition in daily accounting.',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Fee schedules have domestic/international/cross-border applicability flags that are jurisdiction-driven. Linking to jurisdiction_profile enables jurisdiction-specific fee compliance reporting (e.g., E',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Fee schedules are constrained by regulatory obligations (EU Interchange Fee Regulation caps, Durbin Amendment debit fee limits). Compliance teams must link fee schedules to the regulatory obligation t',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Fee schedules are defined per scheme; replace scheme_code with scheme_id FK.',
    `applicable_to_domestic` BOOLEAN COMMENT 'True if the fee applies to domestic (same‑country) transactions.',
    `applicable_to_international` BOOLEAN COMMENT 'True if the fee applies to international (cross‑border) transactions.',
    `card_type` STRING COMMENT 'Type of payment card for which the fee schedule is applicable.. Valid values are `credit|debit|prepaid|commercial|private_label`',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the fee schedule.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fee schedule record was first created in the system.',
    `effective_from` DATE COMMENT 'Date on which the fee schedule becomes active.',
    `effective_until` DATE COMMENT 'Date on which the fee schedule expires or is superseded; null for open‑ended.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount charged per transaction when the fee is flat‑rate.',
    `fee_cap_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount that can be charged for this fee per transaction.',
    `fee_cap_indicator` BOOLEAN COMMENT 'True if a fee cap is enforced for this schedule.',
    `fee_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied to the transaction amount for percentage‑based fees.',
    `fee_schedule_code` STRING COMMENT 'Business-facing code that uniquely identifies the fee schedule within the organization.',
    `fee_type` STRING COMMENT 'Category of the fee charged by the scheme (e.g., network access, processing, cross‑border assessment, value‑added service).. Valid values are `network_access|processing|cross_border|value_added`',
    `is_cross_border` BOOLEAN COMMENT 'True if the fee applies to cross‑border transactions; otherwise false.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance or policy review of the fee schedule.',
    `maximum_transaction_amount` DECIMAL(18,2) COMMENT 'Upper bound of transaction amount for which the fee applies.',
    `mcc_code` STRING COMMENT 'Four‑digit code representing the merchants business category.',
    `minimum_transaction_amount` DECIMAL(18,2) COMMENT 'Lower bound of transaction amount for which the fee applies.',
    `scheme_fee_schedule_description` STRING COMMENT 'Free‑form text describing the purpose, scope, or special conditions of the fee schedule.',
    `scheme_fee_schedule_status` STRING COMMENT 'Current lifecycle status of the fee schedule.. Valid values are `active|inactive|pending|retired`',
    `surcharge_indicator` BOOLEAN COMMENT 'True if the fee is a surcharge passed to the merchant or cardholder.',
    `transaction_category` STRING COMMENT 'Business classification of the transaction (e.g., purchase, refund, cash‑advance) to which the fee applies.',
    `updated_by` STRING COMMENT 'Identifier of the user or process that last updated the fee schedule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the fee schedule record.',
    `version_number` STRING COMMENT 'Incremental version of the fee schedule record for change tracking.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the fee schedule record.',
    CONSTRAINT pk_scheme_fee_schedule PRIMARY KEY(`scheme_fee_schedule_id`)
) COMMENT 'Defines the fee structures charged by card schemes for network access, authorization, clearing, and value-added services. Stores fee type (network access fee, scheme processing fee, cross-border assessment), rate, effective date range, and applicable transaction categories. Distinct from interchange (owned by interchange domain).';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` (
    `multi_network_routing_id` BIGINT COMMENT 'System-generated unique identifier for the routing profile.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Multi-network routing profiles select optimal rails based on currency — EUR transactions may prefer SEPA, USD may prefer Fedwire. Least-cost routing decisions and currency-aware network preference ord',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: Multi-network routing profiles implement least-cost routing by selecting the network with the lowest interchange rate category. The least_cost_flag and durbin_compliance_mode fields confirm LCR intent',
    `jurisdiction_profile_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction_profile. Business justification: Multi-network routing profiles have a durbin_compliance_mode attribute indicating jurisdiction-specific compliance requirements. Linking to jurisdiction_profile enables compliance validation of rout',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Multi-network routing profiles have compliance_check_required and durbin_compliance_mode — these are driven by specific regulatory obligations (Durbin Amendment, PSD2). Linking to regulatory_oblig',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Multi-network routing profiles use risk scores to select optimal networks — the risk_score_threshold attribute on multi_network_routing confirms risk-based routing decisions. Linking to the entitys r',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Multi‑network routing profiles are scoped to a scheme; add scheme_id FK.',
    `compliance_check_required` BOOLEAN COMMENT 'Indicates whether additional regulatory compliance checks must be performed before routing.',
    `durbin_compliance_mode` STRING COMMENT 'Specifies how the profile complies with the Durbin Amendment for debit transactions.. Valid values are `required|optional|exempt`',
    `fallback_network_code` STRING COMMENT 'Network code to use when primary networks are unavailable or fail compliance checks.',
    `least_cost_flag` BOOLEAN COMMENT 'Indicates whether the routing engine should prioritize the lowest interchange cost.',
    `network_preference_order` STRING COMMENT 'Comma‑separated list of network codes (e.g., VISA,MC,DISC) in order of preference for routing.',
    `notes` STRING COMMENT 'Free‑form text for operational comments, exceptions, or audit remarks.',
    `priority_score` DECIMAL(18,2) COMMENT 'Numeric score used by the routing engine to rank this profile against others.',
    `profile_created_by` STRING COMMENT 'Identifier of the user or system that created the routing profile.',
    `profile_created_timestamp` TIMESTAMP COMMENT 'Date‑time when the routing profile was initially created in the system.',
    `profile_status` STRING COMMENT 'Current lifecycle state of the routing profile.. Valid values are `active|inactive|deprecated|pending`',
    `profile_updated_by` STRING COMMENT 'Identifier of the user or system that performed the latest update.',
    `profile_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the routing profile.',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Maximum allowed fraud risk score for a transaction to be routed using this profile.',
    `routing_category` STRING COMMENT 'Classification of the routing profile based on transaction type or market segment.. Valid values are `debit|credit|prepaid|commercial|consumer`',
    `routing_type` STRING COMMENT 'Indicates whether the profile is a default rule, an override, or specific to a merchant or cardholder.. Valid values are `default|override|merchant_specific|cardholder_specific|dynamic`',
    `transaction_volume_threshold` DECIMAL(18,2) COMMENT 'Minimum cumulative transaction amount (in USD) required to trigger this routing profile.',
    `version_number` STRING COMMENT 'Incremental version of the routing profile for change management.',
    CONSTRAINT pk_multi_network_routing PRIMARY KEY(`multi_network_routing_id`)
) COMMENT 'Manages multi-network routing configurations for transactions eligible to be processed across multiple networks (e.g., Visa vs. Interlink for debit, Mastercard vs. Maestro). Stores network preference order, merchant override rules, cardholder preference flags, Durbin Amendment compliance settings, and least-cost routing logic.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ADD CONSTRAINT `fk_network_endpoint_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ADD CONSTRAINT `fk_network_routing_table_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ADD CONSTRAINT `fk_network_routing_table_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ADD CONSTRAINT `fk_network_network_routing_rule_routing_table_id` FOREIGN KEY (`routing_table_id`) REFERENCES `payments_fintech_ecm`.`network`.`routing_table`(`routing_table_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ADD CONSTRAINT `fk_network_network_routing_rule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ADD CONSTRAINT `fk_network_network_routing_rule_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ADD CONSTRAINT `fk_network_scheme_parameter_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ADD CONSTRAINT `fk_network_sla_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ADD CONSTRAINT `fk_network_sla_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ADD CONSTRAINT `fk_network_scheme_membership_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ADD CONSTRAINT `fk_network_scheme_fee_schedule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ADD CONSTRAINT `fk_network_multi_network_routing_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`network` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `payments_fintech_ecm`.`network` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` SET TAGS ('dbx_subdomain' = 'scheme_management');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Identifier (SCHEME_ID)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `rate_feed_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Feed Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements (SCHEME_COMPLIANCE_REQ)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_value_regex' = 'PCI_DSS|PSD2|EMVCo|ISO20022');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Scheme Contact Email (SCHEME_CONTACT_EMAIL)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Scheme Contact Phone (SCHEME_CONTACT_PHONE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `currency_supported` SET TAGS ('dbx_business_glossary_term' = 'Supported Currencies (SCHEME_CURRENCY_SUPPORTED)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `currency_supported` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Scheme Effective Date (SCHEME_EFFECTIVE_DATE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage (SCHEME_GEOGRAPHIC_COVERAGE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body (SCHEME_GOVERNING_BODY)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `interchange_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Rate (SCHEME_INTERCHANGE_FEE_RATE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `interchange_fee_type` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Type (SCHEME_INTERCHANGE_FEE_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `interchange_fee_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `network_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Network Certification Date (SCHEME_CERT_DATE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `network_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Network Certification Status (SCHEME_CERT_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `network_certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|revoked');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (SCHEME_AUDIT_CREATED)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (SCHEME_AUDIT_UPDATED)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `risk_profile` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile (SCHEME_RISK_PROFILE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `risk_profile` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `scheme_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Scheme Code (SCHEME_CODE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `scheme_description` SET TAGS ('dbx_business_glossary_term' = 'Scheme Description (SCHEME_DESCRIPTION)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `scheme_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Scheme Name (SCHEME_NAME)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `scheme_status` SET TAGS ('dbx_business_glossary_term' = 'Scheme Status (SCHEME_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `scheme_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `scheme_type` SET TAGS ('dbx_business_glossary_term' = 'Scheme Type (SCHEME_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `scheme_type` SET TAGS ('dbx_value_regex' = 'card|digital_wallet|bank_transfer|crypto');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency (SCHEME_SETTLEMENT_CURRENCY)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method (SCHEME_SETTLEMENT_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'real_time|batch|net');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `supported_transaction_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Transaction Types (SCHEME_SUPPORTED_TX_TYPES)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Scheme Termination Date (SCHEME_TERMINATION_DATE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `three_ds_supported` SET TAGS ('dbx_business_glossary_term' = '3‑DS Supported (SCHEME_3DS_SUPPORTED)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Supported (SCHEME_TOKENIZATION_SUPPORTED)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Scheme Version (SCHEME_VERSION)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Scheme Website URL (SCHEME_WEBSITE_URL)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` SET TAGS ('dbx_subdomain' = 'network_operations');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Identifier (NE_ID)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `pci_dss_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Pci Dss Audit Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes (AUDIT_TRAIL)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method (AUTH_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'MutualTLS|APIKey|OAuth|Other');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `average_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Average Latency (milliseconds) (AVG_LAT_MS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `certificate_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'TLS Certificate Expiration Date (CERT_EXPIRY_DATE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `compliance_iso_20022` SET TAGS ('dbx_business_glossary_term' = 'ISO 20022 Compliance Flag (ISO20022_COMPLIANT)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `compliance_pci_dss` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance Flag (PCI_DSS_COMPLIANT)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `compliance_regulatory` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Codes (REG_COMPLIANCE_CODES)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Connection Type (CONN_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `connection_type` SET TAGS ('dbx_value_regex' = 'persistent|stateless');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `data_center_location` SET TAGS ('dbx_business_glossary_term' = 'Data Center Location (DC_LOCATION)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_UNTIL)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `encryption_protocol` SET TAGS ('dbx_business_glossary_term' = 'Encryption Protocol (EP)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `encryption_protocol` SET TAGS ('dbx_value_regex' = 'TLS1.2|TLS1.3|Other');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `endpoint_code` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Code (NEC)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `endpoint_description` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Description (DESC)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `endpoint_name` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Name (NEN)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `endpoint_status` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Status (NES)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `endpoint_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_business_glossary_term' = 'Health Check Interval (seconds) (HCI_SEC)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `health_check_interval_seconds` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `health_check_timeout_seconds` SET TAGS ('dbx_business_glossary_term' = 'Health Check Timeout (seconds) (HCT_SEC)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `health_check_timeout_seconds` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `health_check_timeout_seconds` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `health_status` SET TAGS ('dbx_business_glossary_term' = 'Health Status (HS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `health_status` SET TAGS ('dbx_value_regex' = 'healthy|degraded|unhealthy');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `health_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `health_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `host_url` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Host URL (EHU)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `ip_address_range` SET TAGS ('dbx_business_glossary_term' = 'IP Address Range (CIDR) (IPR)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `ip_address_range` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `ip_address_range` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Endpoint Indicator (IS_PRIMARY)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `is_tls_mutual` SET TAGS ('dbx_business_glossary_term' = 'Mutual TLS Indicator (IS_TLS_MUTUAL)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp (LHC_TS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `maintenance_window` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Maintenance Window (MAINT_WINDOW)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `max_connections` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Connections (MAX_CONN)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `max_message_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Message Size (bytes) (MAX_MSG_SIZE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `monitoring_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Endpoint URL (MONITORING_URL)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `network_interface` SET TAGS ('dbx_business_glossary_term' = 'Network Interface Type (INTERFACE_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `port` SET TAGS ('dbx_business_glossary_term' = 'Network Port (NP)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `protocol_version` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version (PV)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `protocol_version` SET TAGS ('dbx_value_regex' = 'ISO8583|ISO20022|Other');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `routing_priority` SET TAGS ('dbx_business_glossary_term' = 'Routing Priority (ROUTING_PRIORITY)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `supported_currencies` SET TAGS ('dbx_business_glossary_term' = 'Supported Currency Codes (CURRENCY_CODES)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `supported_message_format` SET TAGS ('dbx_business_glossary_term' = 'Supported Message Format (MSG_FORMAT)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `supported_message_format` SET TAGS ('dbx_value_regex' = 'iso8583|iso20022|other');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `throughput_tps` SET TAGS ('dbx_business_glossary_term' = 'Throughput Transactions Per Second (THROUGHPUT_TPS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` SET TAGS ('dbx_subdomain' = 'network_operations');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `routing_table_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Table ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_business_glossary_term' = 'BIN Range End (Inclusive)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_value_regex' = '^d{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_business_glossary_term' = 'BIN Range Start (Inclusive)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_value_regex' = '^d{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Last Change to Rule');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `compliance_check_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Required Flag');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `fallback_sequence` SET TAGS ('dbx_business_glossary_term' = 'Fallback Sequence Order');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate Applied (Decimal)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `is_fallback_enabled` SET TAGS ('dbx_business_glossary_term' = 'Fallback Enabled Flag');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `last_tested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Rule Test Execution Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount Allowed');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `mcc_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount Allowed');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Routing Priority Order');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `processing_rail` SET TAGS ('dbx_business_glossary_term' = 'Processing Rail');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `processing_rail` SET TAGS ('dbx_value_regex' = 'real_time|batch|offline');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `risk_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Threshold for Routing Decision');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `routing_table_description` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `routing_table_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `routing_table_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `routing_type` SET TAGS ('dbx_business_glossary_term' = 'Routing Type (Least Cost, Failover, Primary, Secondary)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `routing_type` SET TAGS ('dbx_value_regex' = 'least_cost|failover|primary|secondary');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Name');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount Applied');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `target_network` SET TAGS ('dbx_business_glossary_term' = 'Target Payment Network');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `target_network` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|unionpay|local');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Result of Last Rule Test');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|warning');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|refund|cash_advance|preauth|void');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'User Who Last Updated Record');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number of Routing Rule');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'User Who Created Record');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` SET TAGS ('dbx_subdomain' = 'network_operations');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `network_routing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Network Routing Rule ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule - Acquirer Endpoint Id');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `routing_table_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule - Scheme Id');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Target Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `amount_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `amount_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `bin_end` SET TAGS ('dbx_business_glossary_term' = 'BIN End Range');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `bin_end` SET TAGS ('dbx_value_regex' = '^d{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `bin_start` SET TAGS ('dbx_business_glossary_term' = 'BIN Start Range');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `bin_start` SET TAGS ('dbx_value_regex' = '^d{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial|unknown');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `is_default_rule` SET TAGS ('dbx_business_glossary_term' = 'Default Rule Indicator');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `is_override` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `last_executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Executed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `match_criteria` SET TAGS ('dbx_business_glossary_term' = 'Match Criteria');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `network_routing_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `network_routing_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Priority');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Name');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `rule_version` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule Version');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|refund|cash_advance|auth|capture|reversal');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` SET TAGS ('dbx_subdomain' = 'scheme_management');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `scheme_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Parameter ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `scheme_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `applies_to_card_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Card Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `applies_to_card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial|all');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `applies_to_mcc` SET TAGS ('dbx_business_glossary_term' = 'Applicable Merchant Category Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `applies_to_mcc` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `applies_to_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `applies_to_transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|refund|cash_advance|reversal|auth|capture');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Parameter Change Reason');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Parameter Compliance Indicator');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'pci_dss|psd2|none');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Parameter Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Parameter Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `is_global` SET TAGS ('dbx_business_glossary_term' = 'Parameter Global Applicability');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Parameter Mandatory Indicator');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Parameter Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `parameter_category` SET TAGS ('dbx_business_glossary_term' = 'Scheme Parameter Category');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `parameter_code` SET TAGS ('dbx_business_glossary_term' = 'Scheme Parameter Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Scheme Parameter Name');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `parameter_value` SET TAGS ('dbx_business_glossary_term' = 'Scheme Parameter Value');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `scheme_parameter_description` SET TAGS ('dbx_business_glossary_term' = 'Parameter Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `scheme_parameter_status` SET TAGS ('dbx_business_glossary_term' = 'Parameter Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `scheme_parameter_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `source_bulletin_date` SET TAGS ('dbx_business_glossary_term' = 'Source Bulletin Publication Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Parameter Unit of Measure');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `value_data_type` SET TAGS ('dbx_business_glossary_term' = 'Parameter Value Data Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `value_data_type` SET TAGS ('dbx_value_regex' = 'integer|decimal|boolean|string|date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Parameter Version Number');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` SET TAGS ('dbx_subdomain' = 'network_operations');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Network SLA Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `actual_authorization_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Actual Authorization Response Time (ms)');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `actual_batch_settlement_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Batch Settlement Window (hours)');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `actual_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Actual Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `actual_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Actual Uptime Percentage');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `batch_settlement_window_hours` SET TAGS ('dbx_business_glossary_term' = 'Batch Settlement Window (hours)');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Email');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Phone');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `max_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Maximum Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'SLA Notes');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `sla_category` SET TAGS ('dbx_business_glossary_term' = 'SLA Category');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `sla_category` SET TAGS ('dbx_value_regex' = 'authorization_response|uptime|latency|settlement');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'SLA Name');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_business_glossary_term' = 'SLA Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `sla_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `target_authorization_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Target Authorization Response Time (ms)');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `target_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Uptime Percentage');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'SLA Version');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` SET TAGS ('dbx_subdomain' = 'scheme_management');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `scheme_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Membership Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee Amount (ANNUAL_FEE_AMT)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline (COMPLIANCE_DL)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `compliance_obligation_summary` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Summary (COMPLIANCE_SUM)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL (CONTRACT_URL)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version (CONTRACT_VER)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `dispute_resolution_process` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Process (DISPUTE_PROC)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency (FEE_CURR)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `fee_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Frequency (FEE_FREQ)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `fee_payment_frequency` SET TAGS ('dbx_value_regex' = 'annual|monthly|quarterly|once');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `fee_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Method (FEE_PAY_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `fee_payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire|credit_card|paypal');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LAST_REVIEW)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `membership_number` SET TAGS ('dbx_business_glossary_term' = 'Membership Number (MEMBER_NO)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Membership Status (MEMBER_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending|draft');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_business_glossary_term' = 'Membership Type (MEMBER_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `membership_type` SET TAGS ('dbx_value_regex' = 'principal|associate|affiliate');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `network_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Network Certification Date (CERT_DATE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `network_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Network Certification Status (CERT_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `network_certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|revoked');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date (ONBOARD_DATE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date (RENEWAL_DATE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount (RENEW_FEE_AMT)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `renewal_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Currency (RENEW_FEE_CURR)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option (RENEW_OPTION)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TERM_REASON)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (UPDATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` SET TAGS ('dbx_subdomain' = 'scheme_management');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `scheme_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Schedule Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `applicable_to_domestic` SET TAGS ('dbx_business_glossary_term' = 'Domestic Applicability Flag');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `applicable_to_international` SET TAGS ('dbx_business_glossary_term' = 'International Applicability Flag');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial|private_label');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `fee_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Amount');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `fee_cap_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Indicator');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate (Percentage)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `fee_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'network_access|processing|cross_border|value_added');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `is_cross_border` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Indicator');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `maximum_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `minimum_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `scheme_fee_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `scheme_fee_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `scheme_fee_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `surcharge_indicator` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Indicator');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `transaction_category` SET TAGS ('dbx_business_glossary_term' = 'Transaction Category');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` SET TAGS ('dbx_subdomain' = 'network_operations');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `multi_network_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Network Routing ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `jurisdiction_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `compliance_check_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Required Flag (CCR_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `durbin_compliance_mode` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Compliance Mode (DACM)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `durbin_compliance_mode` SET TAGS ('dbx_value_regex' = 'required|optional|exempt');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `fallback_network_code` SET TAGS ('dbx_business_glossary_term' = 'Fallback Network Code (FNC)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `least_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Least Cost Routing Flag (LCR_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `network_preference_order` SET TAGS ('dbx_business_glossary_term' = 'Network Preference Order (NPO)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Routing Profile Notes (RP_NOTES)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `priority_score` SET TAGS ('dbx_business_glossary_term' = 'Routing Priority Score (RPSCORE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `profile_created_by` SET TAGS ('dbx_business_glossary_term' = 'Routing Profile Created By (RP_CREATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `profile_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Routing Profile Creation Timestamp (RP_CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Routing Profile Status (RPS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `profile_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Routing Profile Updated By (RP_UPDATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `profile_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Routing Profile Update Timestamp (RP_UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `risk_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Threshold (RST)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `routing_category` SET TAGS ('dbx_business_glossary_term' = 'Routing Category (RCAT)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `routing_category` SET TAGS ('dbx_value_regex' = 'debit|credit|prepaid|commercial|consumer');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_business_glossary_term' = 'Routing Type (RTYPE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `routing_type` SET TAGS ('dbx_value_regex' = 'default|override|merchant_specific|cardholder_specific|dynamic');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `transaction_volume_threshold` SET TAGS ('dbx_business_glossary_term' = 'Transaction Volume Threshold (TVT)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Profile Version Number (RPV)');
