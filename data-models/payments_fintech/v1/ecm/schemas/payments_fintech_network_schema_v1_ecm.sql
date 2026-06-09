-- Schema for Domain: network | Business: Payments Fintech | Version: v1_ecm
-- Generated on: 2026-05-03 18:25:34

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`network` COMMENT 'Defines payment network connectivity, routing rules, and messaging metadata for each payment scheme (Visa, Mastercard, Amex, Discover). Owns network endpoints, routing tables, scheme parameter configurations, network certification records, and multi-network transaction routing logic.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`scheme` (
    `scheme_id` BIGINT COMMENT 'Unique surrogate key for each payment scheme record.',
    `card_scheme_id` BIGINT COMMENT 'Foreign key linking to reference.reference_card_scheme. Business justification: Regulatory reporting requires mapping each network scheme to its global card‑scheme definition to aggregate compliance metrics across Visa, Mastercard, etc.',
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
    `acquirer_endpoint_id` BIGINT COMMENT 'Identifier of the alternate endpoint used for failover.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Endpoints are deployed per country; FK to country supports regional SLA monitoring and regulatory jurisdiction tracking.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Required for routing and settlement reports to map each network endpoint to the owning partner (acquirer/issuer) responsible for traffic and fee allocation.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Network Operations Management: assigns a network engineer to each endpoint for incident response and performance reporting.',
    `region_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_region. Business justification: Network operations assign each endpoint to a gateway region to monitor SLA, latency, and regulatory data‑residency per region.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Endpoint compliance audit requires mapping each network endpoint to the regulatory obligation it satisfies (PCI‑DSS, ISO‑20022).',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Endpoints belong to a payment scheme; adding scheme_id FK normalizes the relationship and removes the redundant network_scheme string column.',
    `timezone_id` BIGINT COMMENT 'Foreign key linking to reference.timezone. Business justification: Endpoint operations depend on local time zones for maintenance windows; linking to timezone master enables automated scheduling and compliance with local regulations.',
    `tls_certificate_id` BIGINT COMMENT 'Reference to the TLS certificate used for securing the connection.',
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
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.endpoint. Business justification: Routing table should link to the endpoint entity rather than storing a URL string; this creates a true relational link and removes redundant data.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Routing tables are defined per scheme; adding scheme_id FK creates parent relationship and removes need for any scheme string column (none present).',
    `bin_range_end` STRING COMMENT 'Ending BIN of the inclusive range for which this rule applies.. Valid values are `^d{6,8}$`',
    `bin_range_start` STRING COMMENT 'Starting BIN (Bank Identification Number) of the inclusive range for which this rule applies.. Valid values are `^d{6,8}$`',
    `change_reason` STRING COMMENT 'Business reason or justification for the most recent modification.',
    `compliance_check_required` BOOLEAN COMMENT 'Specifies if regulatory compliance checks must be performed before routing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the routing rule record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for which the rule is valid.. Valid values are `^[A-Z]{3}$`',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Tracks which employee created a routing rule for PCI‑DSS change‑log and internal audit compliance.',
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
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Parameters may vary by country; linking to country master supports jurisdiction‑specific compliance and reporting.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Fee and parameter rules are currency‑specific; linking to the master currency table enables accurate cross‑border fee calculations and regulatory reporting.',
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
    `regulatory_reference` STRING COMMENT 'Citation to the specific rule, bulletin, or standard governing the parameter (e.g., Visa Core Rules Section 5.2).',
    `scheme_parameter_description` STRING COMMENT 'Detailed free‑text description of the parameter purpose and usage.',
    `scheme_parameter_status` STRING COMMENT 'Current lifecycle state of the parameter record.. Valid values are `active|inactive|deprecated|pending`',
    `source_bulletin_date` DATE COMMENT 'Date of the network bulletin that introduced or updated the parameter.',
    `unit_of_measure` STRING COMMENT 'Unit associated with the parameter value (e.g., USD, count, minutes).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the parameter record.',
    `value_data_type` STRING COMMENT 'Data type of the parameter value indicating how it should be interpreted.. Valid values are `integer|decimal|boolean|string|date`',
    `version_number` STRING COMMENT 'Incremental version of the parameter record for change tracking.',
    CONSTRAINT pk_scheme_parameter PRIMARY KEY(`scheme_parameter_id`)
) COMMENT 'Stores scheme-specific configuration parameters published by card networks — authorization floor limits, velocity thresholds, CVV/AVS requirement flags, 3DS mandate settings, SCA exemption rules, chargeback time limits, and EMV fallback policies. Updated per scheme bulletin cycles.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` (
    `scheme_bulletin_id` BIGINT COMMENT 'Unique system-generated identifier for the scheme bulletin record.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Bulletins are issued by a scheme; replace string scheme column with scheme_id FK.',
    `applicable_regions` STRING COMMENT 'Comma‑separated list of ISO‑3166‑1 alpha‑3 country codes where the bulletin applies.',
    `bulletin_number` STRING COMMENT 'Official bulletin number or code assigned by the card scheme.',
    `bulletin_type` STRING COMMENT 'Category of the bulletin (e.g., mandate, update, advisory).. Valid values are `Mandate|Update|Advisory|TechnicalSpecification`',
    `compliance_deadline` DATE COMMENT 'Date by which merchants/issuers must comply with the bulletin.',
    `compliance_requirements` STRING COMMENT 'Specific technical or operational requirements that must be met to comply.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bulletin record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the bulletins changes become effective.',
    `impacted_parameter_category` STRING COMMENT 'Primary functional area(s) affected by the bulletin.. Valid values are `authorization|settlement|risk|tokenization|pricing|routing`',
    `implementation_status` STRING COMMENT 'Progress of internal implementation of the bulletin requirements.. Valid values are `not_started|in_progress|completed|deferred`',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance review of the bulletin.',
    `mandatory` BOOLEAN COMMENT 'Indicates whether the bulletin is mandatory (true) or advisory (false).',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or internal comments.',
    `scheme_bulletin_description` STRING COMMENT 'Full textual description of the bulletin content and purpose.',
    `scheme_bulletin_status` STRING COMMENT 'Current lifecycle status of the bulletin.. Valid values are `draft|published|effective|expired|retracted`',
    `source_document_url` STRING COMMENT 'Link to the original bulletin document hosted by the scheme.',
    `title` STRING COMMENT 'Human‑readable title of the scheme bulletin.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the bulletin record.',
    `version_number` STRING COMMENT 'Sequential version of the bulletin; increments when the bulletin is revised.',
    CONSTRAINT pk_scheme_bulletin PRIMARY KEY(`scheme_bulletin_id`)
) COMMENT 'Tracks official scheme bulletins and mandate publications issued by card networks (Visa, Mastercard, Amex). Records bulletin ID, effective date, impacted parameter categories, compliance deadline, and implementation status. Drives the scheme parameter update lifecycle and compliance tracking.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`network_certification_record` (
    `network_certification_record_id` BIGINT COMMENT 'System-generated unique identifier for the certification record.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Certification records are tied to a scheme; replace associated_scheme string with scheme_id FK.',
    `certification_body` STRING COMMENT 'Organization or scheme that issued the certification.. Valid values are `Visa|Mastercard|Amex|Discover|PCI_SSC|ISO`',
    `certification_code` STRING COMMENT 'Internal code or identifier used to reference the certification within the platform.',
    `certification_name` STRING COMMENT 'Human‑readable name of the certification (e.g., EMV Chip Certification).',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification.. Valid values are `active|expired|pending|revoked`',
    `certification_type` STRING COMMENT 'Category of certification indicating the technology or standard being certified.. Valid values are `EMV|NFC|3DS|PCI_DSS|ISO_20022|SWIFT`',
    `compliance_scope` STRING COMMENT 'Geographic or functional scope covered by the certification.. Valid values are `global|regional|local`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the certification becomes effective.',
    `effective_until` DATE COMMENT 'Date when the certification expires or is no longer valid.',
    `is_renewal` BOOLEAN COMMENT 'Indicates whether the certification record represents a renewal of a prior certification.',
    `notes` STRING COMMENT 'Any supplemental information or comments about the certification.',
    `renewal_due_date` DATE COMMENT 'Date by which the certification must be renewed to remain valid.',
    `result_details` STRING COMMENT 'Free‑text details describing the test outcome, observations, or notes.',
    `test_date` DATE COMMENT 'Date on which the certification testing was performed.',
    `test_result` STRING COMMENT 'Outcome of the certification test.. Valid values are `pass|fail|partial`',
    `updated_by` STRING COMMENT 'Identifier of the user or process that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    `version` STRING COMMENT 'Version identifier of the certification (e.g., v1.2, 2023‑Q1).',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the record.',
    CONSTRAINT pk_network_certification_record PRIMARY KEY(`network_certification_record_id`)
) COMMENT 'Tracks network certification and compliance testing records for the platform — EMV chip certification, contactless NFC certification, 3DS server certification, PCI DSS attestations, and scheme-specific technical certifications. Records certification body, test results, expiry dates, and renewal status.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`message_log` (
    `message_log_id` BIGINT COMMENT 'Unique surrogate identifier for each network message log record.',
    `compliance_aml_screening_result_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_aml_screening_result. Business justification: Message‑level monitoring links logs to AML screening results for SAR filing and audit trails.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Message logs need to attribute each transaction message to the originating partner for dispute handling and audit trails.',
    `endpoint_id` BIGINT COMMENT 'Identifier of the network endpoint (e.g., acquiring bank, scheme gateway) that originated or received the message.',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_case. Business justification: Fraud Investigation Report requires linking each network log entry to the fraud case it supports, enabling auditors to trace messages used in case analysis.',
    `network_certification_network_certification_record_id` BIGINT COMMENT 'Identifier of the certification record that validates the network endpoints compliance.',
    `network_certification_record_id` BIGINT COMMENT 'Identifier of the certification record that validates the network endpoints compliance.',
    `network_routing_rule_id` BIGINT COMMENT 'Reference to the routing rule applied to route this message.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the point‑of‑sale terminal that originated the transaction.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Settlement‑related message logs must reference the exact FX rate used for audit and reconciliation.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the batch file or processing batch that contains the message.',
    `transaction_id` BIGINT COMMENT 'Reference to the business transaction that generated this network message.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount of the transaction in the smallest currency unit.',
    `authorization_status` STRING COMMENT 'Result of the authorization attempt as reported by the network.. Valid values are `approved|declined|error|timeout`',
    `compliance_status` STRING COMMENT 'Indicates whether the message meets applicable regulatory and scheme compliance requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the log record was first inserted into the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the transaction amount.. Valid values are `^[A-Z]{3}$`',
    `decline_reason_code` STRING COMMENT 'Code indicating the specific reason for a decline, if applicable.. Valid values are `^[A-Z0-9]{1,4}$`',
    `destination_ip` STRING COMMENT 'IP address of the receiving system (e.g., network gateway).',
    `destination_port` STRING COMMENT 'Network port on the destination system that received the message.',
    `error_code` STRING COMMENT 'Error code returned by the network when a failure occurs.. Valid values are `^[A-Z0-9]{1,6}$`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact time the network message was observed or captured by the system.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Risk score assigned by the fraud detection platform for this message.',
    `is_test_message` BOOLEAN COMMENT 'Flag indicating whether the message was generated in a test or sandbox environment.',
    `iso_message_version` STRING COMMENT 'Specifies whether the message follows ISO 8583 or ISO 20022 formatting.. Valid values are `8583|20022`',
    `message_direction` STRING COMMENT 'Indicates whether the record is a request, response, advice, or reversal message.. Valid values are `request|response|advice|reversal`',
    `message_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA‑256) of the raw message for integrity verification.',
    `message_sequence_number` BIGINT COMMENT 'Sequential number of the message within its batch or session.',
    `message_type_indicator` STRING COMMENT 'Four‑digit code that identifies the message class, function, and origin according to ISO 8583 or ISO 20022. [ENUM-REF-CANDIDATE: 0100|0110|0200|0210|0400|0410|0420|0430|0500|0510|0800|0810 — promote to reference product]',
    `network_scheme` STRING COMMENT 'Payment scheme or network that processed the message (e.g., Visa, Mastercard).. Valid values are `Visa|Mastercard|Amex|Discover|UnionPay`',
    `network_status` STRING COMMENT 'Overall status of the network interaction for this message.. Valid values are `success|failed|pending|reversed`',
    `processing_code` STRING COMMENT 'Six‑digit code that defines the transaction type and processing rules (e.g., purchase, refund, cash advance).. Valid values are `^d{6}$`',
    `processing_time_ms` STRING COMMENT 'Time in milliseconds taken by the system to process the message internally.',
    `raw_message` STRING COMMENT 'Full raw message content as received from the network (e.g., ISO 8583 bitmap).',
    `regulatory_report_flag` BOOLEAN COMMENT 'True if the message must be included in regulatory reporting (e.g., AML, SAR).',
    `response_code` STRING COMMENT 'Three‑digit code returned by the network indicating approval, decline, or error conditions.. Valid values are `^d{3}$`',
    `retry_count` STRING COMMENT 'Number of times the message has been retried after a failure.',
    `risk_category` STRING COMMENT 'Categorized risk level derived from the fraud score.. Valid values are `low|medium|high|critical`',
    `round_trip_latency_ms` STRING COMMENT 'Measured latency in milliseconds between transmission and receipt of the corresponding response.',
    `settlement_date` DATE COMMENT 'Date on which the transaction was settled in the acquiring bank.',
    `source_ip` STRING COMMENT 'IP address of the originating system that sent the message.',
    `source_port` STRING COMMENT 'Network port on the source system used for the transmission.',
    `transmission_timestamp` TIMESTAMP COMMENT 'Timestamp when the message was sent from the originating system to the network.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the log record.',
    CONSTRAINT pk_message_log PRIMARY KEY(`message_log_id`)
) COMMENT 'Operational log of ISO 8583 and ISO 20022 financial messages exchanged with payment networks — authorization requests/responses, reversal messages, advice messages, and network management messages. Captures message type indicator (MTI), processing code, response code, transmission timestamp, and round-trip latency. Critical for reconciliation and dispute evidence.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`connectivity_event` (
    `connectivity_event_id` BIGINT COMMENT 'Unique surrogate key for each connectivity event record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Network downtime events are costed to specific cost centers for internal charge‑back and service‑level reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Captures which employee logged the connectivity event, supporting root‑cause analysis and audit.',
    `endpoint_id` BIGINT COMMENT 'Identifier of the network endpoint (e.g., switch, router, gateway) involved in the event.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Connectivity events are associated with a scheme; replace scheme string with scheme_id FK.',
    `affected_transaction_volume` BIGINT COMMENT 'Number of payment transactions impacted by the connectivity event.',
    `certificate_status` STRING COMMENT 'Current status of the TLS/SSL certificate used in the connection.. Valid values are `valid|expired|revoked`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the connectivity event record was first created in the system.',
    `destination_ip` STRING COMMENT 'IP address of the target system for the connection.',
    `duration_seconds` STRING COMMENT 'Length of time the event lasted, measured in seconds.',
    `error_code` STRING COMMENT 'Standardized error code returned by the network component, if any.',
    `event_description` STRING COMMENT 'Free‑text description providing details about the event.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date and time when the connectivity event occurred.',
    `event_type` STRING COMMENT 'Category of the connectivity event.. Valid values are `session_established|session_terminated|link_failure|failover|reconnection|heartbeat`',
    `failure_reason` STRING COMMENT 'Root cause or reason for a failure‑type event, if applicable.',
    `is_successful` BOOLEAN COMMENT 'True if the event resulted in a successful connection or recovery; otherwise false.',
    `network_node` STRING COMMENT 'Logical name or identifier of the network node where the event originated.',
    `port` STRING COMMENT 'Network port number associated with the event.',
    `protocol` STRING COMMENT 'Transport protocol used for the connection.. Valid values are `TCP|UDP|TLS|HTTPS`',
    `resolution_action` STRING COMMENT 'Action taken to resolve or mitigate the event.. Valid values are `auto_retry|manual_intervention|none`',
    `retry_count` STRING COMMENT 'Number of automatic retry attempts performed after a failure.',
    `sla_actual_seconds` STRING COMMENT 'Actual time taken to resolve the event, measured in seconds.',
    `sla_target_seconds` STRING COMMENT 'Target duration defined in the SLA for the event to be resolved.',
    `source_ip` STRING COMMENT 'IP address of the source system that initiated the connection.',
    `tls_version` STRING COMMENT 'Version of TLS negotiated for the session, if applicable.',
    `updated_by` STRING COMMENT 'Identifier of the system or user that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the connectivity event record.',
    `created_by` STRING COMMENT 'Identifier of the system or user that created the record.',
    CONSTRAINT pk_connectivity_event PRIMARY KEY(`connectivity_event_id`)
) COMMENT 'Records network connectivity events — session establishment, session teardown, link failures, failover activations, and reconnection events for each scheme endpoint. Captures event type, duration, affected endpoint, impacted transaction volume, and resolution action. Supports SLA monitoring and incident root-cause analysis.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`failover_config` (
    `failover_config_id` BIGINT COMMENT 'Unique surrogate key for the failover configuration.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Identifies the engineer configuring failover settings, needed for change management and regulatory audit.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Failover configurations are defined per scheme; replace string fields with scheme_id FK.',
    `compliance_status` STRING COMMENT 'Indicates whether the configuration meets applicable regulatory and security standards (e.g., PCI DSS).. Valid values are `compliant|non_compliant|pending`',
    `config_code` STRING COMMENT 'Unique business code used to reference the failover configuration.',
    `config_name` STRING COMMENT 'Human readable name for the failover configuration.',
    `consecutive_failure_count` STRING COMMENT 'Number of consecutive failures required to trigger failover.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the failover configuration record was first created.',
    `effective_from` DATE COMMENT 'Date when the failover configuration becomes effective.',
    `effective_until` DATE COMMENT 'Date when the failover configuration expires or is retired (nullable for open‑ended).',
    `error_rate_threshold` DECIMAL(18,2) COMMENT 'Maximum acceptable error rate (percentage) before failover is triggered.',
    `failover_config_description` STRING COMMENT 'Free‑form description providing context and rationale for the failover configuration.',
    `failover_config_status` STRING COMMENT 'Current operational status of the failover configuration.. Valid values are `active|inactive|maintenance|decommissioned`',
    `failover_mode` STRING COMMENT 'Indicates whether failover is triggered automatically or requires manual intervention.. Valid values are `automatic|manual`',
    `failover_type` STRING COMMENT 'Type of failover strategy applied to network endpoints.. Valid values are `primary_secondary|multi_network|geographic`',
    `last_failover_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent failover event.',
    `latency_threshold_ms` STRING COMMENT 'Maximum acceptable latency in milliseconds before failover is triggered.',
    `next_scheduled_test_timestamp` TIMESTAMP COMMENT 'Scheduled timestamp for the next automated failover test.',
    `notification_email` STRING COMMENT 'Email address to receive failover alerts and notifications.',
    `notification_phone` STRING COMMENT 'Phone number to receive failover alerts via SMS or voice call.',
    `primary_endpoint` STRING COMMENT 'Identifier of the primary network endpoint used under normal operation.',
    `recovery_time_target_seconds` STRING COMMENT 'Target time in seconds to recover to the primary endpoint after a failover event.',
    `region_code` STRING COMMENT 'Three‑letter ISO country code representing the geographic region for which the configuration applies.. Valid values are `^[A-Z]{3}$`',
    `secondary_endpoint` STRING COMMENT 'Identifier of the secondary network endpoint used when failover occurs.',
    `test_mode_enabled` BOOLEAN COMMENT 'Indicates if periodic failover testing mode is enabled.',
    `timeout_threshold_seconds` STRING COMMENT 'Maximum request timeout in seconds before failover is triggered.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that last updated the configuration.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the failover configuration record.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the configuration.',
    CONSTRAINT pk_failover_config PRIMARY KEY(`failover_config_id`)
) COMMENT 'Defines failover and redundancy configurations for each network endpoint — primary/secondary endpoint pairs, failover trigger thresholds (error rate, latency, timeout), automatic vs. manual failover mode, and recovery criteria. Ensures business continuity for payment processing during network outages.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`sla` (
    `sla_id` BIGINT COMMENT 'System‑generated unique identifier for the SLA record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: SLA penalty and performance cost allocations are charged to internal cost centers for charge‑back reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Associates SLA escalation contact with an employee, enabling automated alert routing and compliance reporting.',
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
    `endpoint_identifier` STRING COMMENT 'Unique identifier of the network connection endpoint used for routing.. Valid values are `^[A-Z0-9_-]{3,20}$`',
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
    `fee_payment_account` STRING COMMENT 'Bank account identifier used for fee payments (e.g., IBAN).',
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
    `risk_profile` STRING COMMENT 'Risk rating assigned to the membership based on scheme requirements and historical performance.. Valid values are `low|medium|high|critical`',
    `termination_reason` STRING COMMENT 'Reason provided for terminating the membership agreement.',
    `updated_by` STRING COMMENT 'User or system that performed the latest update.',
    `created_by` STRING COMMENT 'User or system that initially created the record.',
    CONSTRAINT pk_scheme_membership PRIMARY KEY(`scheme_membership_id`)
) COMMENT 'Records the formal membership and participation agreements between the platform (as acquirer, issuer, or processor) and each card scheme. Stores membership type (principal, associate, affiliate), membership ID, effective date, annual fees, and compliance obligations. SSOT for scheme participation status.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` (
    `scheme_fee_schedule_id` BIGINT COMMENT 'System-generated unique identifier for each scheme fee schedule record.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Fee schedules differ by country; FK to country enables localized fee enforcement and regulatory compliance.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Fee schedules are defined per currency; referencing the currency master ensures correct fee application and auditability.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Fee schedule entries are posted to specific GL accounts for revenue recognition in daily accounting.',
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
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Multi‑network routing profiles are scoped to a scheme; add scheme_id FK.',
    `compliance_check_required` BOOLEAN COMMENT 'Indicates whether additional regulatory compliance checks must be performed before routing.',
    `durbin_compliance_mode` STRING COMMENT 'Specifies how the profile complies with the Durbin Amendment for debit transactions.. Valid values are `required|optional|exempt`',
    `fallback_network_code` STRING COMMENT 'Network code to use when primary networks are unavailable or fail compliance checks.',
    `least_cost_flag` BOOLEAN COMMENT 'Indicates whether the routing engine should prioritize the lowest interchange cost.',
    `network_preference_order` STRING COMMENT 'Comma‑separated list of network codes (e.g., VISA,MC,DISC) in order of preference for routing.',
    `notes` STRING COMMENT 'Free‑form text for operational comments, exceptions, or audit remarks.',
    `priority_score` DECIMAL(18,2) COMMENT 'Numeric score used by the routing engine to rank this profile against others.',
    `profile_code` STRING COMMENT 'Business‑visible code that uniquely identifies the routing profile across systems.',
    `profile_created_by` STRING COMMENT 'Identifier of the user or system that created the routing profile.',
    `profile_created_timestamp` TIMESTAMP COMMENT 'Date‑time when the routing profile was initially created in the system.',
    `profile_name` STRING COMMENT 'Human‑readable name of the routing configuration used by operations and reporting.',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` (
    `network_protocol_config_id` BIGINT COMMENT 'System-generated unique identifier for each network protocol configuration record.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Protocol configurations are scheme‑specific; replace scheme_code with scheme_id FK.',
    `bitmap_format` STRING COMMENT 'Representation format of the ISO 8583 bitmap (binary or hexadecimal).. Valid values are `binary|hex`',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to compute message integrity checksums.. Valid values are `CRC32|LRC|none`',
    `compliance_status` STRING COMMENT 'Indicates whether the configuration meets applicable standards (PCI DSS, EMVCo, etc.).. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the configuration record was first created.',
    `delimiter` STRING COMMENT 'Character or byte sequence used to separate messages when framing rule is delimiter.',
    `effective_from` DATE COMMENT 'Date when the configuration becomes effective for routing.',
    `effective_until` DATE COMMENT 'Date when the configuration ceases to be effective (null for open‑ended).',
    `encoding` STRING COMMENT 'Character encoding used for the message payload.. Valid values are `ASCII|EBCDIC`',
    `field_mapping_definition` STRING COMMENT 'JSON string that maps internal field names to network message fields.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this configuration is the default for its scheme.',
    `iso_20022_message_set` STRING COMMENT 'Identifier of the ISO 20022 message set (e.g., pain.001, pacs.008) employed by the configuration.',
    `iso_8583_version` STRING COMMENT 'Version of the ISO 8583 standard used (e.g., 1987, 1993, 2003).. Valid values are `1987|1993|2003`',
    `last_tested_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent functional test of the configuration.',
    `max_message_length` STRING COMMENT 'Maximum allowed size of a single protocol message in bytes.',
    `message_framing_rule` STRING COMMENT 'Rule that defines how messages are delimited or length‑prefixed on the wire.. Valid values are `length_prefix|delimiter|none`',
    `min_message_length` STRING COMMENT 'Minimum expected size of a protocol message in bytes.',
    `network_protocol_config_code` STRING COMMENT 'Business identifier or code used to reference the configuration in downstream systems.',
    `network_protocol_config_description` STRING COMMENT 'Free‑form description of the protocol configuration and its purpose.',
    `network_protocol_config_name` STRING COMMENT 'Human‑readable name identifying the protocol configuration.',
    `network_protocol_config_status` STRING COMMENT 'Current lifecycle state of the protocol configuration.. Valid values are `active|inactive|deprecated|pending`',
    `protocol_type` STRING COMMENT 'Type of messaging protocol implemented by this configuration.. Valid values are `ISO8583|ISO20022|Proprietary`',
    `routing_priority` STRING COMMENT 'Numeric priority used when multiple configurations match; lower numbers indicate higher priority.',
    `supported_currencies` STRING COMMENT 'Comma‑separated list of ISO 4217 currency codes the configuration can handle.',
    `supported_message_types` STRING COMMENT 'Comma‑separated list of message type identifiers (e.g., 0100, 0200) supported.',
    `test_result` STRING COMMENT 'Outcome of the last test execution.. Valid values are `pass|fail|warning`',
    `updated_by` STRING COMMENT 'Identifier of the user or process that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the configuration record.',
    `version_number` STRING COMMENT 'Version identifier for change‑management and audit purposes.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the record.',
    CONSTRAINT pk_network_protocol_config PRIMARY KEY(`network_protocol_config_id`)
) COMMENT 'Stores messaging protocol configurations for each network connection — ISO 8583 version (1987/1993/2003), ISO 20022 message set, field mapping definitions, bitmap configurations, encoding (EBCDIC/ASCII), and message framing rules. Enables protocol translation between internal systems and external network endpoints.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`cutover` (
    `cutover_id` BIGINT COMMENT 'Unique system-generated identifier for each network cutover event.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Links cutover project ownership to a specific employee, required for governance, reporting, and post‑cutover review.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Cutover events are owned by a specific partner; linking enables responsibility tracking and post‑cutover validation reporting.',
    `endpoint_id` BIGINT COMMENT 'Identifier of the network endpoint being upgraded or migrated.',
    `regulatory_reporting_req_id` BIGINT COMMENT 'Identifier of the regulatory report generated for this cutover.',
    `scheme_id` BIGINT COMMENT 'FK to network.scheme',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Real end date‑time when the cutover completed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Real start date‑time when the cutover began.',
    `affected_region_codes` STRING COMMENT 'Comma‑separated list of ISO‑3166‑1 alpha‑3 region codes impacted.',
    `audit_trail` STRING COMMENT 'Chronological log of significant actions on the cutover record.',
    `business_owner` STRING COMMENT 'Name of the business owner responsible for the cutover.',
    `business_owner_email` STRING COMMENT 'Email address of the business owner.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `business_owner_phone` STRING COMMENT 'Phone number of the business owner.. Valid values are `^+?[0-9]{7,15}$`',
    `certification_renewal_date` DATE COMMENT 'Date on which the network certification is renewed, if applicable.',
    `change_control_status` STRING COMMENT 'Current status of the change control ticket.. Valid values are `open|closed|rejected`',
    `change_control_ticket_number` STRING COMMENT 'Ticket number from the change management system linked to the cutover.',
    `change_window_description` STRING COMMENT 'Description of the maintenance window allocated for the cutover.',
    `communication_plan` STRING COMMENT 'Plan for notifying stakeholders before, during, and after cutover.',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the cutover.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cutover record was first created in the system.',
    `cutover_name` STRING COMMENT 'Human‑readable name describing the cutover event.',
    `cutover_status` STRING COMMENT 'Current lifecycle status of the cutover.. Valid values are `planned|in_progress|completed|rolled_back|cancelled`',
    `cutover_type` STRING COMMENT 'Category of the cutover activity.. Valid values are `migration|endpoint_upgrade|protocol_version_change|certification_renewal`',
    `duration_minutes` STRING COMMENT 'Total elapsed minutes from actual start to actual end.',
    `go_no_go_criteria` STRING COMMENT 'Business rules that determine whether the cutover may proceed.',
    `impact_assessment` STRING COMMENT 'Qualitative assessment of business impact caused by the cutover.',
    `network_endpoint_name` STRING COMMENT 'Human‑readable name of the affected network endpoint.',
    `notes` STRING COMMENT 'Free‑form comments or observations.',
    `planned_end_timestamp` TIMESTAMP COMMENT 'Scheduled end date‑time for the cutover.',
    `planned_start_timestamp` TIMESTAMP COMMENT 'Scheduled start date‑time for the cutover.',
    `post_cutover_validation_timestamp` TIMESTAMP COMMENT 'Timestamp when final validation was performed.',
    `protocol_version_after` STRING COMMENT 'Version of the network protocol after the cutover.',
    `protocol_version_before` STRING COMMENT 'Version of the network protocol prior to the cutover.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether the cutover must be reported to a regulator.',
    `risk_level` STRING COMMENT 'Risk rating assigned to the cutover.. Valid values are `low|medium|high`',
    `rollback_plan` STRING COMMENT 'Detailed steps to revert the cutover if needed.',
    `stakeholder_contact_email` STRING COMMENT 'Primary email address of the stakeholder responsible for the cutover.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `stakeholder_contact_phone` STRING COMMENT 'Primary phone number of the stakeholder responsible for the cutover.. Valid values are `^+?[0-9]{7,15}$`',
    `success_indicator` BOOLEAN COMMENT 'True if the cutover met all success criteria.',
    `updated_by` STRING COMMENT 'User identifier that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the cutover record.',
    `validation_results` STRING COMMENT 'Outcome of validation checks performed after cutover.',
    `version_number` STRING COMMENT 'Incremental version of the cutover record for concurrency control.',
    `created_by` STRING COMMENT 'User identifier that created the cutover record.',
    CONSTRAINT pk_cutover PRIMARY KEY(`cutover_id`)
) COMMENT 'Tracks planned and executed network cutover events — scheme-mandated technology migrations, endpoint upgrades, protocol version changes, and certification renewals. Records cutover window, affected endpoints, rollback plan, go/no-go criteria, and post-cutover validation results.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`emv_parameter` (
    `emv_parameter_id` BIGINT COMMENT 'Unique identifier for the EMV parameter set.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: EMV parameter sets are country‑specific for card acceptance; linking to country master aligns with global EMV certification.',
    `scheme_id` BIGINT COMMENT 'Identifier of the payment scheme (e.g., Visa, Mastercard) to which this EMV parameter set applies.',
    `additional_terminal_capabilities` STRING COMMENT 'Extended capability bitmap for the terminal.. Valid values are `^[A-F0-9]+$`',
    `aid` STRING COMMENT 'Hexadecimal identifier of the EMV application as defined by the card scheme.. Valid values are `^[A-F0-9]{10,32}$`',
    `aid_description` STRING COMMENT 'Human‑readable description of the AID purpose.',
    `application_interchange_profile` STRING COMMENT 'Hex value defining interchange profile rules for the application.. Valid values are `^[A-F0-9]{2,4}$`',
    `application_version_number` STRING COMMENT 'Version number of the EMV application on the card.. Valid values are `^[A-F0-9]{2,4}$`',
    `card_action_code_default` STRING COMMENT 'Hex code defined by the card issuer for default handling.. Valid values are `^[A-F0-9]{8}$`',
    `card_action_code_denial` STRING COMMENT 'Hex code defined by the card issuer for denial handling.. Valid values are `^[A-F0-9]{8}$`',
    `card_action_code_online` STRING COMMENT 'Hex code defined by the card issuer for online processing.. Valid values are `^[A-F0-9]{8}$`',
    `compliance_status` STRING COMMENT 'Indicates whether the parameter set meets the latest scheme and regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `contactless_transaction_limit_amount` DECIMAL(18,2) COMMENT 'Maximum amount allowed for contactless transactions without additional verification.',
    `contactless_transaction_limit_currency` STRING COMMENT 'Currency code for the contactless transaction limit.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the EMV parameter record was first created in the system.',
    `cvm_required_limit_amount` DECIMAL(18,2) COMMENT 'Transaction amount above which Cardholder Verification Method (CVM) is required.',
    `cvm_required_limit_currency` STRING COMMENT 'Currency code for the CVM required limit.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'Date when the EMV parameter set becomes effective.',
    `effective_until` DATE COMMENT 'Date when the EMV parameter set expires or is superseded.',
    `emv_parameter_description` STRING COMMENT 'Free‑form description of the purpose and scope of the parameter set.',
    `emv_parameter_status` STRING COMMENT 'Current lifecycle status of the EMV parameter set.. Valid values are `active|inactive|deprecated`',
    `floor_limit_amount` DECIMAL(18,2) COMMENT 'Maximum transaction amount that can be approved offline without online authorization.',
    `floor_limit_currency` STRING COMMENT 'Currency code for the floor limit amount.. Valid values are `^[A-Z]{3}$`',
    `issuer_country_code` STRING COMMENT 'Country code of the card issuer.. Valid values are `^[A-Z]{3}$`',
    `offline_data_authentication` STRING COMMENT 'Method used for offline data authentication (static, dynamic, or online).. Valid values are `offline_static|offline_dynamic|online`',
    `offline_pin_required` BOOLEAN COMMENT 'Indicates whether an offline PIN entry is mandatory for the transaction.',
    `online_pin_required` BOOLEAN COMMENT 'Indicates whether an online PIN entry is mandatory for the transaction.',
    `parameter_set_code` STRING COMMENT 'Unique code used to reference the EMV parameter set within the organization.',
    `parameter_set_name` STRING COMMENT 'Human‑readable name of the EMV parameter configuration.',
    `terminal_action_code_default` STRING COMMENT 'Hex code indicating the terminals default response for unspecified conditions.. Valid values are `^[A-F0-9]{8}$`',
    `terminal_action_code_denial` STRING COMMENT 'Hex code indicating the terminals response when a transaction is denied.. Valid values are `^[A-F0-9]{8}$`',
    `terminal_action_code_online` STRING COMMENT 'Hex code indicating the terminals response when a transaction is processed online.. Valid values are `^[A-F0-9]{8}$`',
    `terminal_capabilities` STRING COMMENT 'Hexadecimal bitmap describing the terminals functional capabilities.. Valid values are `^[A-F0-9]+$`',
    `terminal_type` STRING COMMENT 'Classification of the terminal based on connectivity and capabilities.. Valid values are `offline|online|mixed`',
    `transaction_currency_code` STRING COMMENT 'Currency code used for the transaction amount.. Valid values are `^[A-Z]{3}$`',
    `transaction_currency_exponent` STRING COMMENT 'Number of decimal places for the transaction currency (e.g., 2 for cents).',
    `transaction_limit_amount` DECIMAL(18,2) COMMENT 'Maximum amount allowed for a single transaction under this parameter set.',
    `transaction_limit_currency` STRING COMMENT 'Currency code for the transaction limit.. Valid values are `^[A-Z]{3}$`',
    `transaction_type` STRING COMMENT 'Category of transaction this parameter set applies to.. Valid values are `purchase|cash_withdrawal|refund|preauth|void`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the EMV parameter record.',
    `version_number` STRING COMMENT 'Version identifier for the EMV parameter set, incremented on each change.',
    CONSTRAINT pk_emv_parameter PRIMARY KEY(`emv_parameter_id`)
) COMMENT 'Stores EMV chip and contactless parameter sets distributed by card schemes — application identifiers (AIDs), terminal action codes, card action codes, floor limits, TAC-denial/online/default values, and contactless transaction limits. Updated per EMVCo and scheme bulletin cycles.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`network_response_code` (
    `network_response_code_id` BIGINT COMMENT 'Unique surrogate identifier for each network response code. _canonical_skip_reason: Entity is a reference lookup, no minimum attribute categories required.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Response codes are defined per scheme; replace string fields with scheme_id FK.',
    `compliance_requirements` STRING COMMENT 'Regulatory or scheme‑specific compliance obligations associated with the response code (e.g., PCI DSS, ISO 8583).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the response code record was first created in the system.',
    `effective_from` DATE COMMENT 'Date from which the response code is valid for processing.',
    `effective_until` DATE COMMENT 'Date after which the response code is no longer valid (null if indefinite).',
    `is_retryable` BOOLEAN COMMENT 'Indicates whether the transaction may be safely retried after this response.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp when the response code details were last reviewed for compliance or accuracy.',
    `network_response_code_description` STRING COMMENT 'Human‑readable explanation of what the response code means.',
    `network_response_code_status` STRING COMMENT 'Lifecycle status of the response code within the scheme.. Valid values are `active|inactive|deprecated`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or remarks about the response code.',
    `recommended_merchant_action` STRING COMMENT 'Suggested action for the merchant when this response code is returned (e.g., retry, contact cardholder, decline).',
    `response_category` STRING COMMENT 'High‑level classification of the response code.. Valid values are `approval|decline|referral|error`',
    `response_code` STRING COMMENT 'Alphanumeric code assigned by the card scheme to indicate the outcome of an authorization request.',
    `response_source` STRING COMMENT 'Origin of the response code (network‑generated, issuer‑generated, or processor‑generated).. Valid values are `network|issuer|processor`',
    `severity_level` STRING COMMENT 'Indicates the operational impact or urgency associated with the response.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the response code record.',
    CONSTRAINT pk_network_response_code PRIMARY KEY(`network_response_code_id`)
) COMMENT 'Reference table of authorization and network response codes defined by each card scheme — approval codes, decline codes, referral codes, and error codes. Stores code value, scheme owner, description, recommended merchant action, and retry eligibility flag. Used for authorization decisioning and decline analytics.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` (
    `scheme_compliance_record_id` BIGINT COMMENT 'System-generated unique identifier for the scheme compliance record.',
    `document_id` BIGINT COMMENT 'Reference identifier for the uploaded attestation or certification document.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Compliance‑related fees or penalties are posted to designated GL accounts for financial reporting.',
    `scheme_bulletin_id` BIGINT COMMENT 'Identifier of the specific scheme bulletin or mandate that drives this compliance requirement.',
    `scheme_id` BIGINT COMMENT 'Identifier of the payment scheme (e.g., Visa, Mastercard) to which this compliance record relates.',
    `attestation_received_date` DATE COMMENT 'Date the scheme acknowledged receipt of the compliance attestation.',
    `compliance_deadline` DATE COMMENT 'Final date by which the required compliance actions must be completed.',
    `compliance_record_number` STRING COMMENT 'Business identifier assigned to the compliance record, often used in reporting and audits.',
    `compliance_requirements` STRING COMMENT 'Textual description of the specific scheme requirements that this record addresses.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Numeric score (e.g., 0‑100) representing overall compliance health for the record.',
    `compliance_type` STRING COMMENT 'Category of compliance requirement (e.g., PCI DSS, tokenization, 3‑DS, ISO 20022, AML, risk management).. Valid values are `pci_dss|tokenization|three_ds|iso_20022|aml|risk`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance record was initially created in the system.',
    `effective_from` DATE COMMENT 'Date when the compliance obligations become effective for this record.',
    `effective_until` DATE COMMENT 'Date when the compliance obligations cease (nullable for open‑ended obligations).',
    `implementation_status` STRING COMMENT 'Progress status of implementing the scheme mandate.. Valid values are `not_started|in_progress|completed|deferred`',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code indicating the regulatory jurisdiction applicable to the compliance requirement.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of this compliance record.',
    `non_compliance_notice_date` DATE COMMENT 'Date a formal notice of non‑compliance was received from the scheme.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations related to the compliance record.',
    `notice_details` STRING COMMENT 'Free‑text description of the non‑compliance notice content.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulation, law, or standard that mandates the compliance (e.g., GDPR, PSD2, SOX).',
    `remediation_due_date` DATE COMMENT 'Date by which remediation actions must be finished.',
    `remediation_plan` STRING COMMENT 'Detailed plan describing actions to remediate identified non‑compliance.',
    `remediation_status` STRING COMMENT 'Current status of the remediation effort.. Valid values are `not_started|in_progress|completed|failed`',
    `risk_profile` STRING COMMENT 'Risk classification associated with the compliance record based on potential impact of non‑compliance.. Valid values are `low|medium|high|critical`',
    `scheme_compliance_record_status` STRING COMMENT 'Current overall status of the compliance record against the scheme requirements.. Valid values are `compliant|non_compliant|pending|under_review|remediated|closed`',
    `submission_date` DATE COMMENT 'Date the compliance evidence or attestation was submitted to the scheme.',
    `updated_by` STRING COMMENT 'User identifier who performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the compliance record.',
    `version_number` STRING COMMENT 'Incremental version of the compliance record, incremented on each substantive change.',
    `created_by` STRING COMMENT 'User identifier (e.g., employee ID or email) who created the record.',
    CONSTRAINT pk_scheme_compliance_record PRIMARY KEY(`scheme_compliance_record_id`)
) COMMENT 'Tracks the platforms compliance status against scheme rules and mandates — PCI DSS compliance attestations submitted to schemes, mandate implementation confirmations, non-compliance notices received, remediation plans, and compliance deadline tracking per scheme bulletin.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`volume_limit` (
    `volume_limit_id` BIGINT COMMENT 'Surrogate primary key for the network volume limit record.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Volume limits are set per scheme; replace scheme_code with scheme_id FK.',
    `alert_threshold_percentage` DECIMAL(18,2) COMMENT 'Percentage of limit at which an alert is generated.',
    `bin_range_end` STRING COMMENT 'Ending Bank Identification Number (BIN) of the range the limit covers.',
    `bin_range_start` STRING COMMENT 'Starting Bank Identification Number (BIN) of the range the limit covers.',
    `breach_flag` BOOLEAN COMMENT 'Indicates whether the limit has been breached.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `daily_limit_count` STRING COMMENT 'Maximum number of transactions allowed per day.',
    `daily_limit_value` DECIMAL(18,2) COMMENT 'Maximum total transaction amount allowed per day.',
    `effective_from` DATE COMMENT 'Date when the limit becomes effective.',
    `effective_until` DATE COMMENT 'Date when the limit expires (null if indefinite).',
    `limit_code` STRING COMMENT 'Unique code used to reference the limit configuration.',
    `limit_scope` STRING COMMENT 'Scope level at which the limit applies.. Valid values are `scheme|bin_range|merchant_category|transaction_type|global`',
    `limit_type` STRING COMMENT 'Metric type of the limit (number of transactions, monetary amount, or velocity).. Valid values are `count|amount|velocity`',
    `limit_unit` STRING COMMENT 'Unit of measurement for limit_value.. Valid values are `transactions|USD|EUR|GBP|JPY|local_currency`',
    `limit_value` DECIMAL(18,2) COMMENT 'Numeric threshold for the limit (e.g., max amount or max count).',
    `merchant_category_code` STRING COMMENT 'Merchant Category Code to which the limit applies.',
    `monthly_limit_count` STRING COMMENT 'Maximum number of transactions allowed per month.',
    `monthly_limit_value` DECIMAL(18,2) COMMENT 'Maximum total transaction amount allowed per month.',
    `transaction_type` STRING COMMENT 'Type of transaction the limit governs.. Valid values are `purchase|refund|cash_advance|preauth|settlement`',
    `updated_by` STRING COMMENT 'Identifier of the user or system that last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `usage_amount` DECIMAL(18,2) COMMENT 'Current accumulated transaction amount within the active window.',
    `usage_counter` STRING COMMENT 'Current count of transactions counted towards the limit within the active window.',
    `usage_reset_timestamp` TIMESTAMP COMMENT 'Timestamp when the usage counters reset.',
    `velocity_window_seconds` STRING COMMENT 'Time window in seconds for velocity control evaluation.',
    `volume_limit_description` STRING COMMENT 'Free-text description of the limit purpose and any special notes.',
    `volume_limit_name` STRING COMMENT 'Human readable name for the volume limit configuration.',
    `volume_limit_status` STRING COMMENT 'Current lifecycle status of the limit configuration.. Valid values are `active|inactive|pending|retired`',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the record.',
    CONSTRAINT pk_volume_limit PRIMARY KEY(`volume_limit_id`)
) COMMENT 'Defines network-imposed and internally configured volume limits — daily transaction count caps, TPV thresholds, single-transaction amount limits, and velocity controls per scheme, BIN range, or merchant category. Supports real-time limit enforcement and breach alerting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`scheme_event` (
    `scheme_event_id` BIGINT COMMENT 'System-generated unique identifier for each scheme-level operational event.',
    `scheme_id` BIGINT COMMENT 'Identifier of the payment scheme (e.g., Visa, Mastercard) affected by the event.',
    `affected_mcc_codes` STRING COMMENT 'Comma‑separated list of MCC values whose merchants are impacted.',
    `affected_regions` STRING COMMENT 'Comma‑separated list of ISO‑3166‑1 alpha‑3 country codes impacted by the event.',
    `change_reason` STRING COMMENT 'Business or technical justification for the event, especially for emergency routing changes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the event record was first created in the data lake.',
    `duration_minutes` STRING COMMENT 'Total duration of the event in minutes, calculated from start and end timestamps.',
    `end_timestamp` TIMESTAMP COMMENT 'Planned end time for maintenance windows or the resolution time of an outage.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date and time when the event was observed or recorded.',
    `event_type` STRING COMMENT 'Category of the scheme event: scheduled maintenance, unplanned outage, emergency routing change, or scheme‑initiated parameter push.. Valid values are `maintenance|outage|routing_change|parameter_push`',
    `impact_scope` STRING COMMENT 'Geographic or functional scope of the event (e.g., global, regional, specific merchant category).',
    `is_emergency` BOOLEAN COMMENT 'True if the event required emergency handling or unscheduled routing changes.',
    `parameter_name` STRING COMMENT 'Name of the scheme configuration parameter that was changed (relevant for parameter_push events).',
    `parameter_value` DECIMAL(18,2) COMMENT 'New value assigned to the scheme parameter during a parameter_push event.',
    `resolution_notes` STRING COMMENT 'Notes on how the event was resolved, including actions taken and responsible teams.',
    `scheme_event_description` STRING COMMENT 'Free‑text narrative describing the cause, context, and details of the event.',
    `scheme_event_status` STRING COMMENT 'Lifecycle status of the event from creation to closure.. Valid values are `pending|in_progress|resolved|closed`',
    `severity` STRING COMMENT 'Business impact severity of the event, used for prioritization and escalation.. Valid values are `low|medium|high|critical`',
    `start_timestamp` TIMESTAMP COMMENT 'Planned start time for maintenance windows or the beginning of an outage period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the event record.',
    CONSTRAINT pk_scheme_event PRIMARY KEY(`scheme_event_id`)
) COMMENT 'Records scheme-level operational events — scheduled maintenance windows, unplanned outages, emergency routing changes, and scheme-initiated parameter pushes. Captures event type, affected schemes, start/end timestamps, impact severity, and resolution notes. Distinct from connectivity_event which tracks endpoint-level link events.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`scheme_obligation_mapping` (
    `scheme_obligation_mapping_id` BIGINT COMMENT 'Primary key for the scheme_obligation_mapping association',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the regulatory obligation',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to the payment scheme',
    `effective_from` DATE COMMENT 'Date when the obligation starts to apply to the scheme',
    `effective_until` DATE COMMENT 'Date when the obligation ceases to apply to the scheme',
    CONSTRAINT pk_scheme_obligation_mapping PRIMARY KEY(`scheme_obligation_mapping_id`)
) COMMENT 'This association product represents the mapping between a payment scheme and a regulatory obligation. It captures the period during which a scheme must satisfy a specific obligation.. Existence Justification: Each payment scheme must comply with multiple regulatory obligations, and each regulatory obligation can apply to multiple schemes. The compliance team actively maintains a mapping that records the effective start and end dates of each scheme‑obligation relationship.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`network_routing_rule2` (
    `network_routing_rule2_id` BIGINT COMMENT 'Primary key for network_routing_rule2',
    `scheme_id` BIGINT COMMENT 'Auto-generated FK linking siloed routing_rule to scheme',
    CONSTRAINT pk_network_routing_rule2 PRIMARY KEY(`network_routing_rule2_id`)
) COMMENT 'This association product represents the routing rule that links a payment card scheme to an acquirer endpoint. It captures the operational parameters used by the payment network to decide where to send transactions for a given scheme.. Existence Justification: Payment processors actively manage routing rules that map card schemes to acquirer endpoints. Each rule records which scheme(s) can be sent to which endpoint(s), with priority, match criteria, and default flags. Both a scheme can be routed to multiple endpoints and an endpoint can serve multiple schemes, and the rules themselves are a managed business artifact.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`scheme_certification` (
    `scheme_certification_id` BIGINT COMMENT 'Primary key for the scheme_certification association',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to the POS terminal',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to the payment scheme',
    `activation_date` DATE COMMENT 'Date the terminal was certified for the scheme',
    `certification_status` STRING COMMENT 'Current status of the certification',
    `compliance_deadline` DATE COMMENT 'Date by which the terminal must meet scheme compliance requirements',
    CONSTRAINT pk_scheme_certification PRIMARY KEY(`scheme_certification_id`)
) COMMENT 'This association product represents the certification relationship between a payment scheme and a POS terminal. It captures activation date, certification status, and compliance deadline for each scheme‑terminal pairing.. Existence Justification: Each POS terminal can be certified for multiple payment card schemes, and each scheme is supported by many terminals across the network. Certification is an operational record that is created, updated, and retired by the business, capturing activation dates, status, and compliance deadlines for every terminal‑scheme pairing.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`dcc_pricing` (
    `dcc_pricing_id` BIGINT COMMENT 'Primary key for the dcc_pricing association',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to the currency pair',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to the payment scheme',
    `dcc_margin_percentage` DECIMAL(18,2) COMMENT 'Percentage margin applied to DCC transactions for this scheme‑pair',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount required for DCC offer',
    `offer_presentation_method` STRING COMMENT 'Method used to present the DCC offer to the cardholder (e.g., popup, inline)',
    `scheme_compliance` STRING COMMENT 'Compliance flag or notes for the scheme regarding this DCC offering',
    CONSTRAINT pk_dcc_pricing PRIMARY KEY(`dcc_pricing_id`)
) COMMENT 'Represents the configured DCC pricing relationship between a payment scheme and a currency pair. Each record stores the margin, minimum transaction amount, offer presentation method, and compliance details that are specific to the scheme‑currency pair combination.. Existence Justification: In the payments fintech platform, each card scheme (e.g., Visa, Mastercard) can be offered with DCC pricing for many currency pairs, and each currency pair can have DCC pricing defined for multiple schemes. The business actively configures these scheme‑currency pair settings (margin, minimum amount, offer method) as a managed entity.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` (
    `regulatory_coverage_id` BIGINT COMMENT 'Primary key for the regulatory_coverage association',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to the regulatory jurisdiction',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to the payment scheme',
    `compliance_score` DECIMAL(18,2) COMMENT 'Numeric score representing compliance level for this scheme‑jurisdiction pair',
    `compliance_type` STRING COMMENT 'Type of compliance requirement for the scheme in this jurisdiction',
    `effective_from` DATE COMMENT 'Date when the compliance requirement became effective',
    `effective_until` DATE COMMENT 'Date when the compliance requirement expires or is superseded',
    `regulatory_coverage_status` STRING COMMENT 'Current compliance status (e.g., compliant, non‑compliant, pending)',
    `remediation_due_date` DATE COMMENT 'Deadline for completing remediation',
    `remediation_plan` STRING COMMENT 'Description of remediation actions required',
    `remediation_status` STRING COMMENT 'Current status of remediation (e.g., pending, in‑progress, completed)',
    `submission_date` DATE COMMENT 'Date the compliance evidence was submitted',
    CONSTRAINT pk_regulatory_coverage PRIMARY KEY(`regulatory_coverage_id`)
) COMMENT 'This association product represents the compliance relationship between a payment scheme and a regulatory jurisdiction. It captures jurisdiction‑specific compliance attributes for each scheme, enabling tracking of compliance status, remediation actions, and effective periods.. Existence Justification: A payment scheme can be subject to multiple regulatory jurisdictions, and a regulatory jurisdiction can govern multiple payment schemes. The compliance team actively tracks each scheme‑jurisdiction pairing with attributes such as compliance type, status, effective dates, and remediation details. This relationship is managed as a distinct business entity.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ADD CONSTRAINT `fk_network_endpoint_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ADD CONSTRAINT `fk_network_routing_table_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ADD CONSTRAINT `fk_network_routing_table_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ADD CONSTRAINT `fk_network_network_routing_rule_routing_table_id` FOREIGN KEY (`routing_table_id`) REFERENCES `payments_fintech_ecm`.`network`.`routing_table`(`routing_table_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ADD CONSTRAINT `fk_network_network_routing_rule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ADD CONSTRAINT `fk_network_network_routing_rule_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ADD CONSTRAINT `fk_network_scheme_parameter_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ADD CONSTRAINT `fk_network_scheme_bulletin_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ADD CONSTRAINT `fk_network_network_certification_record_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ADD CONSTRAINT `fk_network_message_log_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ADD CONSTRAINT `fk_network_message_log_network_certification_network_certification_record_id` FOREIGN KEY (`network_certification_network_certification_record_id`) REFERENCES `payments_fintech_ecm`.`network`.`network_certification_record`(`network_certification_record_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ADD CONSTRAINT `fk_network_message_log_network_certification_record_id` FOREIGN KEY (`network_certification_record_id`) REFERENCES `payments_fintech_ecm`.`network`.`network_certification_record`(`network_certification_record_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ADD CONSTRAINT `fk_network_message_log_network_routing_rule_id` FOREIGN KEY (`network_routing_rule_id`) REFERENCES `payments_fintech_ecm`.`network`.`network_routing_rule`(`network_routing_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ADD CONSTRAINT `fk_network_connectivity_event_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ADD CONSTRAINT `fk_network_connectivity_event_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ADD CONSTRAINT `fk_network_failover_config_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ADD CONSTRAINT `fk_network_sla_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ADD CONSTRAINT `fk_network_scheme_membership_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ADD CONSTRAINT `fk_network_scheme_fee_schedule_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ADD CONSTRAINT `fk_network_multi_network_routing_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ADD CONSTRAINT `fk_network_network_protocol_config_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ADD CONSTRAINT `fk_network_cutover_endpoint_id` FOREIGN KEY (`endpoint_id`) REFERENCES `payments_fintech_ecm`.`network`.`endpoint`(`endpoint_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ADD CONSTRAINT `fk_network_cutover_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ADD CONSTRAINT `fk_network_emv_parameter_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ADD CONSTRAINT `fk_network_network_response_code_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ADD CONSTRAINT `fk_network_scheme_compliance_record_scheme_bulletin_id` FOREIGN KEY (`scheme_bulletin_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme_bulletin`(`scheme_bulletin_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ADD CONSTRAINT `fk_network_scheme_compliance_record_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ADD CONSTRAINT `fk_network_volume_limit_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ADD CONSTRAINT `fk_network_scheme_event_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_obligation_mapping` ADD CONSTRAINT `fk_network_scheme_obligation_mapping_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule2` ADD CONSTRAINT `fk_network_network_routing_rule2_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_certification` ADD CONSTRAINT `fk_network_scheme_certification_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`dcc_pricing` ADD CONSTRAINT `fk_network_dcc_pricing_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` ADD CONSTRAINT `fk_network_regulatory_coverage_scheme_id` FOREIGN KEY (`scheme_id`) REFERENCES `payments_fintech_ecm`.`network`.`scheme`(`scheme_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`network` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `payments_fintech_ecm`.`network` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` SET TAGS ('dbx_subdomain' = 'scheme_governance');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Identifier (SCHEME_ID)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme` ALTER COLUMN `card_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Card Scheme Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` SET TAGS ('dbx_subdomain' = 'network_connectivity');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Identifier (NE_ID)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Failover Endpoint Identifier (FAILOVER_ENDPOINT_ID)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Region Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `timezone_id` SET TAGS ('dbx_business_glossary_term' = 'Timezone Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`endpoint` ALTER COLUMN `tls_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'TLS Certificate Identifier (TLS_CERT_ID)');
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
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` SET TAGS ('dbx_subdomain' = 'routing_configuration');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `routing_table_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Table ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_business_glossary_term' = 'BIN Range End (Inclusive)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_value_regex' = '^d{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_business_glossary_term' = 'BIN Range Start (Inclusive)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_value_regex' = '^d{6,8}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Reason for Last Change to Rule');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `compliance_check_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Required Flag');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`network`.`routing_table` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` SET TAGS ('dbx_subdomain' = 'routing_configuration');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `network_routing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Network Routing Rule ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule - Acquirer Endpoint Id');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` SET TAGS ('dbx_subdomain' = 'scheme_governance');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `scheme_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Parameter ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `scheme_parameter_description` SET TAGS ('dbx_business_glossary_term' = 'Parameter Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `scheme_parameter_status` SET TAGS ('dbx_business_glossary_term' = 'Parameter Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `scheme_parameter_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `source_bulletin_date` SET TAGS ('dbx_business_glossary_term' = 'Source Bulletin Publication Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Parameter Unit of Measure');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `value_data_type` SET TAGS ('dbx_business_glossary_term' = 'Parameter Value Data Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `value_data_type` SET TAGS ('dbx_value_regex' = 'integer|decimal|boolean|string|date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_parameter` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Parameter Version Number');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` SET TAGS ('dbx_subdomain' = 'scheme_governance');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `scheme_bulletin_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Bulletin ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `applicable_regions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regions');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `bulletin_number` SET TAGS ('dbx_business_glossary_term' = 'Bulletin Number');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `bulletin_type` SET TAGS ('dbx_business_glossary_term' = 'Bulletin Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `bulletin_type` SET TAGS ('dbx_value_regex' = 'Mandate|Update|Advisory|TechnicalSpecification');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `impacted_parameter_category` SET TAGS ('dbx_business_glossary_term' = 'Impacted Parameter Category');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `impacted_parameter_category` SET TAGS ('dbx_value_regex' = 'authorization|settlement|risk|tokenization|pricing|routing');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Indicator');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `scheme_bulletin_description` SET TAGS ('dbx_business_glossary_term' = 'Bulletin Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `scheme_bulletin_status` SET TAGS ('dbx_business_glossary_term' = 'Bulletin Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `scheme_bulletin_status` SET TAGS ('dbx_value_regex' = 'draft|published|effective|expired|retracted');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `source_document_url` SET TAGS ('dbx_business_glossary_term' = 'Source Document URL');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Bulletin Title');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_bulletin` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Bulletin Version Number');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` SET TAGS ('dbx_subdomain' = 'compliance_certification');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `network_certification_record_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Record ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Issuing Body');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `certification_body` SET TAGS ('dbx_value_regex' = 'Visa|Mastercard|Amex|Discover|PCI_SSC|ISO');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `certification_code` SET TAGS ('dbx_business_glossary_term' = 'Certification Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending|revoked');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type (e.g., EMV, NFC, 3DS, PCI DSS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'EMV|NFC|3DS|PCI_DSS|ISO_20022|SWIFT');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `compliance_scope` SET TAGS ('dbx_business_glossary_term' = 'Compliance Scope');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `compliance_scope` SET TAGS ('dbx_value_regex' = 'global|regional|local');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `is_renewal` SET TAGS ('dbx_business_glossary_term' = 'Is Renewal Flag');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `result_details` SET TAGS ('dbx_business_glossary_term' = 'Certification Test Result Details');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Test Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Certification Test Result');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|partial');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Certification Version');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_certification_record` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` SET TAGS ('dbx_subdomain' = 'network_connectivity');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Network Message Log ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `compliance_aml_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Aml Screening Result Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `network_certification_network_certification_record_id` SET TAGS ('dbx_business_glossary_term' = 'Network Certification ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `network_certification_record_id` SET TAGS ('dbx_business_glossary_term' = 'Network Certification ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `network_routing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Rule ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identification Number (TID)');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'approved|declined|error|timeout');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `decline_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `decline_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `destination_ip` SET TAGS ('dbx_business_glossary_term' = 'Destination IP Address');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `destination_ip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `destination_ip` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `destination_port` SET TAGS ('dbx_business_glossary_term' = 'Destination Port');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Network Error Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `error_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `is_test_message` SET TAGS ('dbx_business_glossary_term' = 'Test Message Indicator');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `iso_message_version` SET TAGS ('dbx_business_glossary_term' = 'ISO Message Version');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `iso_message_version` SET TAGS ('dbx_value_regex' = '8583|20022');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `message_direction` SET TAGS ('dbx_business_glossary_term' = 'Message Direction');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `message_direction` SET TAGS ('dbx_value_regex' = 'request|response|advice|reversal');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `message_hash` SET TAGS ('dbx_business_glossary_term' = 'Message Hash');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `message_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Message Sequence Number');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `message_type_indicator` SET TAGS ('dbx_business_glossary_term' = 'Message Type Indicator (MTI)');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `network_scheme` SET TAGS ('dbx_business_glossary_term' = 'Network Scheme');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `network_scheme` SET TAGS ('dbx_value_regex' = 'Visa|Mastercard|Amex|Discover|UnionPay');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'success|failed|pending|reversed');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `processing_code` SET TAGS ('dbx_business_glossary_term' = 'Processing Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `processing_code` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `processing_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Processing Time (ms)');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `raw_message` SET TAGS ('dbx_business_glossary_term' = 'Raw Message Payload');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `regulatory_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Flag');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Response Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `response_code` SET TAGS ('dbx_value_regex' = '^d{3}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `round_trip_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Round‑Trip Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `source_ip` SET TAGS ('dbx_business_glossary_term' = 'Source IP Address');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `source_ip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `source_ip` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `source_port` SET TAGS ('dbx_business_glossary_term' = 'Source Port');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transmission Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`message_log` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` SET TAGS ('dbx_subdomain' = 'network_connectivity');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `connectivity_event_id` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Event Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `affected_transaction_volume` SET TAGS ('dbx_business_glossary_term' = 'Affected Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'valid|expired|revoked');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `destination_ip` SET TAGS ('dbx_business_glossary_term' = 'Destination IP Address');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `destination_ip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `destination_ip` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Event Duration (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'session_established|session_terminated|link_failure|failover|reconnection|heartbeat');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `is_successful` SET TAGS ('dbx_business_glossary_term' = 'Event Success Indicator');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `network_node` SET TAGS ('dbx_business_glossary_term' = 'Network Node Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `port` SET TAGS ('dbx_business_glossary_term' = 'Network Port');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `protocol` SET TAGS ('dbx_business_glossary_term' = 'Network Protocol');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `protocol` SET TAGS ('dbx_value_regex' = 'TCP|UDP|TLS|HTTPS');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 'auto_retry|manual_intervention|none');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `sla_actual_seconds` SET TAGS ('dbx_business_glossary_term' = 'SLA Actual (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `sla_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'SLA Target (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `source_ip` SET TAGS ('dbx_business_glossary_term' = 'Source IP Address');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `source_ip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `source_ip` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `tls_version` SET TAGS ('dbx_business_glossary_term' = 'TLS Version');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`connectivity_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` SET TAGS ('dbx_subdomain' = 'network_connectivity');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `failover_config_id` SET TAGS ('dbx_business_glossary_term' = 'Failover Configuration ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `config_code` SET TAGS ('dbx_business_glossary_term' = 'Failover Configuration Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `config_name` SET TAGS ('dbx_business_glossary_term' = 'Failover Configuration Name');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `consecutive_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Consecutive Failure Count');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `error_rate_threshold` SET TAGS ('dbx_business_glossary_term' = 'Error Rate Threshold (Percent)');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `failover_config_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `failover_config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `failover_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|decommissioned');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `failover_mode` SET TAGS ('dbx_business_glossary_term' = 'Failover Mode');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `failover_mode` SET TAGS ('dbx_value_regex' = 'automatic|manual');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `failover_type` SET TAGS ('dbx_business_glossary_term' = 'Failover Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `failover_type` SET TAGS ('dbx_value_regex' = 'primary_secondary|multi_network|geographic');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `last_failover_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Failover Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `latency_threshold_ms` SET TAGS ('dbx_business_glossary_term' = 'Latency Threshold (Milliseconds)');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `next_scheduled_test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Test Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `notification_email` SET TAGS ('dbx_business_glossary_term' = 'Notification Email Address');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `notification_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `notification_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `notification_phone` SET TAGS ('dbx_business_glossary_term' = 'Notification Phone Number');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `notification_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `notification_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `primary_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Primary Network Endpoint Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `recovery_time_target_seconds` SET TAGS ('dbx_business_glossary_term' = 'Recovery Time Target (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `secondary_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Secondary Network Endpoint Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `test_mode_enabled` SET TAGS ('dbx_business_glossary_term' = 'Test Mode Enabled');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `timeout_threshold_seconds` SET TAGS ('dbx_business_glossary_term' = 'Timeout Threshold (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`failover_config` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` SET TAGS ('dbx_subdomain' = 'network_connectivity');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Network SLA Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `endpoint_identifier` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`sla` ALTER COLUMN `endpoint_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
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
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` SET TAGS ('dbx_subdomain' = 'scheme_governance');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `scheme_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Membership Identifier');
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
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `fee_payment_account` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Account (FEE_PAY_ACC)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `fee_payment_account` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `fee_payment_account` SET TAGS ('dbx_pii_financial' = 'true');
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
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `risk_profile` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile (RISK_PROFILE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `risk_profile` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TERM_REASON)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (UPDATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_membership` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` SET TAGS ('dbx_subdomain' = 'scheme_governance');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `scheme_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Schedule Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_fee_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` SET TAGS ('dbx_subdomain' = 'routing_configuration');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `multi_network_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Multi-Network Routing ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `compliance_check_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Required Flag (CCR_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `durbin_compliance_mode` SET TAGS ('dbx_business_glossary_term' = 'Durbin Amendment Compliance Mode (DACM)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `durbin_compliance_mode` SET TAGS ('dbx_value_regex' = 'required|optional|exempt');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `fallback_network_code` SET TAGS ('dbx_business_glossary_term' = 'Fallback Network Code (FNC)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `least_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Least Cost Routing Flag (LCR_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `network_preference_order` SET TAGS ('dbx_business_glossary_term' = 'Network Preference Order (NPO)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Routing Profile Notes (RP_NOTES)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `priority_score` SET TAGS ('dbx_business_glossary_term' = 'Routing Priority Score (RPSCORE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `profile_code` SET TAGS ('dbx_business_glossary_term' = 'Routing Profile Code (RPC)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `profile_created_by` SET TAGS ('dbx_business_glossary_term' = 'Routing Profile Created By (RP_CREATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `profile_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Routing Profile Creation Timestamp (RP_CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`multi_network_routing` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Routing Profile Name (RPN)');
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
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` SET TAGS ('dbx_subdomain' = 'routing_configuration');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `network_protocol_config_id` SET TAGS ('dbx_business_glossary_term' = 'Network Protocol Configuration ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `bitmap_format` SET TAGS ('dbx_business_glossary_term' = 'Bitmap Format');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `bitmap_format` SET TAGS ('dbx_value_regex' = 'binary|hex');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'CRC32|LRC|none');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `delimiter` SET TAGS ('dbx_business_glossary_term' = 'Message Delimiter');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `encoding` SET TAGS ('dbx_business_glossary_term' = 'Message Encoding');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `encoding` SET TAGS ('dbx_value_regex' = 'ASCII|EBCDIC');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `field_mapping_definition` SET TAGS ('dbx_business_glossary_term' = 'Field Mapping Definition');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Configuration Flag');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `iso_20022_message_set` SET TAGS ('dbx_business_glossary_term' = 'ISO 20022 Message Set');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `iso_8583_version` SET TAGS ('dbx_business_glossary_term' = 'ISO 8583 Version');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `iso_8583_version` SET TAGS ('dbx_value_regex' = '1987|1993|2003');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `last_tested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Tested Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `max_message_length` SET TAGS ('dbx_business_glossary_term' = 'Maximum Message Length');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `message_framing_rule` SET TAGS ('dbx_business_glossary_term' = 'Message Framing Rule');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `message_framing_rule` SET TAGS ('dbx_value_regex' = 'length_prefix|delimiter|none');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `min_message_length` SET TAGS ('dbx_business_glossary_term' = 'Minimum Message Length');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `network_protocol_config_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `network_protocol_config_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `network_protocol_config_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `network_protocol_config_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `network_protocol_config_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `protocol_type` SET TAGS ('dbx_business_glossary_term' = 'Protocol Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `protocol_type` SET TAGS ('dbx_value_regex' = 'ISO8583|ISO20022|Proprietary');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `routing_priority` SET TAGS ('dbx_business_glossary_term' = 'Routing Priority');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `supported_currencies` SET TAGS ('dbx_business_glossary_term' = 'Supported Currencies');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `supported_message_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Message Types');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|warning');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version Number');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_protocol_config` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` SET TAGS ('dbx_subdomain' = 'network_connectivity');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `cutover_id` SET TAGS ('dbx_business_glossary_term' = 'Network Cutover Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Employee Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `regulatory_reporting_req_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `scheme_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `affected_region_codes` SET TAGS ('dbx_business_glossary_term' = 'Affected Region Codes');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `business_owner` SET TAGS ('dbx_business_glossary_term' = 'Business Owner');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `business_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Email (EMAIL)');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `business_owner_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `business_owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `business_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `business_owner_phone` SET TAGS ('dbx_business_glossary_term' = 'Business Owner Phone (PHONE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `business_owner_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `business_owner_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `business_owner_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `certification_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Renewal Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `change_control_status` SET TAGS ('dbx_business_glossary_term' = 'Change Control Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `change_control_status` SET TAGS ('dbx_value_regex' = 'open|closed|rejected');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `change_control_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Ticket Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `change_window_description` SET TAGS ('dbx_business_glossary_term' = 'Change Window Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `communication_plan` SET TAGS ('dbx_business_glossary_term' = 'Communication Plan');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `cutover_name` SET TAGS ('dbx_business_glossary_term' = 'Cutover Name');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `cutover_status` SET TAGS ('dbx_business_glossary_term' = 'Cutover Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `cutover_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|rolled_back|cancelled');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `cutover_type` SET TAGS ('dbx_business_glossary_term' = 'Cutover Type (TYPE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `cutover_type` SET TAGS ('dbx_value_regex' = 'migration|endpoint_upgrade|protocol_version_change|certification_renewal');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Cutover Duration (MINUTES)');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `go_no_go_criteria` SET TAGS ('dbx_business_glossary_term' = 'Go/No‑Go Criteria');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `network_endpoint_name` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Name');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `planned_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned End Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `planned_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `post_cutover_validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Post‑Cutover Validation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `protocol_version_after` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version After');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `protocol_version_before` SET TAGS ('dbx_business_glossary_term' = 'Protocol Version Before');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (RISK)');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `rollback_plan` SET TAGS ('dbx_business_glossary_term' = 'Rollback Plan');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `stakeholder_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Contact Email (EMAIL)');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `stakeholder_contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `stakeholder_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `stakeholder_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `stakeholder_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Contact Phone (PHONE)');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `stakeholder_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `stakeholder_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `stakeholder_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `success_indicator` SET TAGS ('dbx_business_glossary_term' = 'Success Indicator');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `validation_results` SET TAGS ('dbx_business_glossary_term' = 'Post‑Cutover Validation Results');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`network`.`cutover` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` SET TAGS ('dbx_subdomain' = 'scheme_governance');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `emv_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'EMV Parameter ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Scheme ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `additional_terminal_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Additional Terminal Capabilities (Hex)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `additional_terminal_capabilities` SET TAGS ('dbx_value_regex' = '^[A-F0-9]+$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `aid` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (AID)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `aid` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{10,32}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `aid_description` SET TAGS ('dbx_business_glossary_term' = 'AID Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `application_interchange_profile` SET TAGS ('dbx_business_glossary_term' = 'Application Interchange Profile (Hex)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `application_interchange_profile` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{2,4}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `application_version_number` SET TAGS ('dbx_business_glossary_term' = 'Application Version Number (Hex)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `application_version_number` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{2,4}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `card_action_code_default` SET TAGS ('dbx_business_glossary_term' = 'Card Action Code – Default (CAC‑Default)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `card_action_code_default` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{8}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `card_action_code_denial` SET TAGS ('dbx_business_glossary_term' = 'Card Action Code – Denial (CAC‑Denial)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `card_action_code_denial` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{8}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `card_action_code_online` SET TAGS ('dbx_business_glossary_term' = 'Card Action Code – Online (CAC‑Online)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `card_action_code_online` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{8}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `contactless_transaction_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Contactless Transaction Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `contactless_transaction_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Contactless Transaction Limit Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `contactless_transaction_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `cvm_required_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'CVM Required Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `cvm_required_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'CVM Required Limit Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `cvm_required_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `emv_parameter_description` SET TAGS ('dbx_business_glossary_term' = 'EMV Parameter Set Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `emv_parameter_status` SET TAGS ('dbx_business_glossary_term' = 'EMV Parameter Set Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `emv_parameter_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `floor_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Floor Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `floor_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Floor Limit Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `floor_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `issuer_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuer Country Code (ISO 3166‑Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `issuer_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `offline_data_authentication` SET TAGS ('dbx_business_glossary_term' = 'Offline Data Authentication Method');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `offline_data_authentication` SET TAGS ('dbx_value_regex' = 'offline_static|offline_dynamic|online');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `offline_pin_required` SET TAGS ('dbx_business_glossary_term' = 'Offline PIN Required');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `online_pin_required` SET TAGS ('dbx_business_glossary_term' = 'Online PIN Required');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `parameter_set_code` SET TAGS ('dbx_business_glossary_term' = 'EMV Parameter Set Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `parameter_set_name` SET TAGS ('dbx_business_glossary_term' = 'EMV Parameter Set Name');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `terminal_action_code_default` SET TAGS ('dbx_business_glossary_term' = 'Terminal Action Code – Default (TAC‑Default)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `terminal_action_code_default` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{8}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `terminal_action_code_denial` SET TAGS ('dbx_business_glossary_term' = 'Terminal Action Code – Denial (TAC‑Denial)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `terminal_action_code_denial` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{8}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `terminal_action_code_online` SET TAGS ('dbx_business_glossary_term' = 'Terminal Action Code – Online (TAC‑Online)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `terminal_action_code_online` SET TAGS ('dbx_value_regex' = '^[A-F0-9]{8}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `terminal_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Terminal Capabilities (Hex)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `terminal_capabilities` SET TAGS ('dbx_value_regex' = '^[A-F0-9]+$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `terminal_type` SET TAGS ('dbx_business_glossary_term' = 'Terminal Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `terminal_type` SET TAGS ('dbx_value_regex' = 'offline|online|mixed');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `transaction_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `transaction_currency_exponent` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Exponent');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `transaction_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `transaction_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Limit Currency (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `transaction_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|cash_withdrawal|refund|preauth|void');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`emv_parameter` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` SET TAGS ('dbx_subdomain' = 'routing_configuration');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `network_response_code_id` SET TAGS ('dbx_business_glossary_term' = 'Network Response Code Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `is_retryable` SET TAGS ('dbx_business_glossary_term' = 'Retry Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `network_response_code_description` SET TAGS ('dbx_business_glossary_term' = 'Response Code Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `network_response_code_status` SET TAGS ('dbx_business_glossary_term' = 'Response Code Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `network_response_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `recommended_merchant_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Merchant Action');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `response_category` SET TAGS ('dbx_business_glossary_term' = 'Response Category');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `response_category` SET TAGS ('dbx_value_regex' = 'approval|decline|referral|error');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Response Code (RC)');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `response_source` SET TAGS ('dbx_business_glossary_term' = 'Response Source');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `response_source` SET TAGS ('dbx_value_regex' = 'network|issuer|processor');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_response_code` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` SET TAGS ('dbx_subdomain' = 'compliance_certification');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `scheme_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Compliance Record ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Attestation Document ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `scheme_bulletin_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Bulletin ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `attestation_received_date` SET TAGS ('dbx_business_glossary_term' = 'Attestation Received Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `compliance_record_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Record Number');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `compliance_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `compliance_type` SET TAGS ('dbx_value_regex' = 'pci_dss|tokenization|three_ds|iso_20022|aml|risk');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `non_compliance_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Non‑Compliance Notice Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `notice_details` SET TAGS ('dbx_business_glossary_term' = 'Notice Details');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `risk_profile` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `risk_profile` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `scheme_compliance_record_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `scheme_compliance_record_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|under_review|remediated|closed');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_compliance_record` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` SET TAGS ('dbx_subdomain' = 'routing_configuration');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `volume_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Network Volume Limit ID');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `alert_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Percentage');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_business_glossary_term' = 'BIN Range End');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_business_glossary_term' = 'BIN Range Start');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Flag');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `daily_limit_count` SET TAGS ('dbx_business_glossary_term' = 'Daily Limit Count');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `daily_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Daily Limit Value');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `limit_code` SET TAGS ('dbx_business_glossary_term' = 'Network Volume Limit Code');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `limit_scope` SET TAGS ('dbx_business_glossary_term' = 'Limit Scope');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `limit_scope` SET TAGS ('dbx_value_regex' = 'scheme|bin_range|merchant_category|transaction_type|global');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Limit Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'count|amount|velocity');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Limit Unit');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `limit_unit` SET TAGS ('dbx_value_regex' = 'transactions|USD|EUR|GBP|JPY|local_currency');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `limit_value` SET TAGS ('dbx_business_glossary_term' = 'Limit Value');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `monthly_limit_count` SET TAGS ('dbx_business_glossary_term' = 'Monthly Limit Count');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `monthly_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Monthly Limit Value');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|refund|cash_advance|preauth|settlement');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `usage_amount` SET TAGS ('dbx_business_glossary_term' = 'Usage Amount');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `usage_counter` SET TAGS ('dbx_business_glossary_term' = 'Usage Counter');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `usage_reset_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Usage Reset Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `velocity_window_seconds` SET TAGS ('dbx_business_glossary_term' = 'Velocity Window (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `volume_limit_description` SET TAGS ('dbx_business_glossary_term' = 'Limit Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `volume_limit_name` SET TAGS ('dbx_business_glossary_term' = 'Network Volume Limit Name');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `volume_limit_status` SET TAGS ('dbx_business_glossary_term' = 'Limit Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `volume_limit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`network`.`volume_limit` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` SET TAGS ('dbx_subdomain' = 'scheme_governance');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `scheme_event_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Event Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `affected_mcc_codes` SET TAGS ('dbx_business_glossary_term' = 'Affected Merchant Category Codes');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `affected_regions` SET TAGS ('dbx_business_glossary_term' = 'Affected Regions');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Event Duration (Minutes)');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Scheme Event Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'maintenance|outage|routing_change|parameter_push');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `impact_scope` SET TAGS ('dbx_business_glossary_term' = 'Impact Scope');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `is_emergency` SET TAGS ('dbx_business_glossary_term' = 'Emergency Indicator');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `parameter_name` SET TAGS ('dbx_business_glossary_term' = 'Scheme Parameter Name');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `parameter_value` SET TAGS ('dbx_business_glossary_term' = 'Scheme Parameter Value');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `scheme_event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `scheme_event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `scheme_event_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|resolved|closed');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Event Severity Level');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_obligation_mapping` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_obligation_mapping` SET TAGS ('dbx_subdomain' = 'compliance_certification');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_obligation_mapping` SET TAGS ('dbx_association_edges' = 'network.scheme,compliance.regulatory_obligation');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_obligation_mapping` ALTER COLUMN `scheme_obligation_mapping_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Obligation Mapping - Scheme Obligation Id');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_obligation_mapping` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Obligation Mapping - Regulatory Obligation Id');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_obligation_mapping` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Obligation Mapping - Scheme Id');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_obligation_mapping` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_obligation_mapping` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule2` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule2` SET TAGS ('dbx_subdomain' = 'routing_configuration');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule2` SET TAGS ('dbx_association_edges' = 'network.scheme,gateway.acquirer_endpoint');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule2` ALTER COLUMN `network_routing_rule2_id` SET TAGS ('dbx_business_glossary_term' = 'network_routing_rule2 Identifier');
ALTER TABLE `payments_fintech_ecm`.`network`.`network_routing_rule2` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Reference to scheme');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_certification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_certification` SET TAGS ('dbx_subdomain' = 'compliance_certification');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_certification` SET TAGS ('dbx_association_edges' = 'network.scheme,terminal.pos_terminal');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_certification` ALTER COLUMN `scheme_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Certification - Scheme Certification Id');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_certification` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Certification - Pos Terminal Id');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_certification` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Certification - Scheme Id');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_certification` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`scheme_certification` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `payments_fintech_ecm`.`network`.`dcc_pricing` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`dcc_pricing` SET TAGS ('dbx_subdomain' = 'scheme_governance');
ALTER TABLE `payments_fintech_ecm`.`network`.`dcc_pricing` SET TAGS ('dbx_association_edges' = 'network.scheme,fx.currency_pair');
ALTER TABLE `payments_fintech_ecm`.`network`.`dcc_pricing` ALTER COLUMN `dcc_pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Dcc Pricing - Dcc Pricing Id');
ALTER TABLE `payments_fintech_ecm`.`network`.`dcc_pricing` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Dcc Pricing - Currency Pair Id');
ALTER TABLE `payments_fintech_ecm`.`network`.`dcc_pricing` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Dcc Pricing - Scheme Id');
ALTER TABLE `payments_fintech_ecm`.`network`.`dcc_pricing` ALTER COLUMN `dcc_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'DCC Margin');
ALTER TABLE `payments_fintech_ecm`.`network`.`dcc_pricing` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum DCC Transaction');
ALTER TABLE `payments_fintech_ecm`.`network`.`dcc_pricing` ALTER COLUMN `offer_presentation_method` SET TAGS ('dbx_business_glossary_term' = 'Offer Presentation');
ALTER TABLE `payments_fintech_ecm`.`network`.`dcc_pricing` ALTER COLUMN `scheme_compliance` SET TAGS ('dbx_business_glossary_term' = 'Scheme Compliance');
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` SET TAGS ('dbx_subdomain' = 'compliance_certification');
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` SET TAGS ('dbx_association_edges' = 'network.scheme,reference.regulatory_jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` ALTER COLUMN `regulatory_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Coverage - Regulatory Coverage Id');
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Coverage - Regulatory Jurisdiction Id');
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Coverage - Scheme Id');
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` ALTER COLUMN `compliance_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Type');
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` ALTER COLUMN `regulatory_coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `payments_fintech_ecm`.`network`.`regulatory_coverage` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
