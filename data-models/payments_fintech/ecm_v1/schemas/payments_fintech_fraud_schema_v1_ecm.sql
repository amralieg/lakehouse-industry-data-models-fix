-- Schema for Domain: fraud | Business: Payments Fintech | Version: v1_ecm
-- Generated on: 2026-05-03 18:25:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`fraud` COMMENT 'Operational domain for real-time fraud detection, case management, and prevention. Owns fraud scoring rule configurations, velocity controls, device fingerprint records, 3DS authentication outcomes, SCA challenge results, blocklists, and fraud case lifecycle tracking from detection through remediation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` (
    `fraud_case_id` BIGINT COMMENT 'Unique system-generated identifier for the fraud case record.',
    `assigned_investigator_employee_id` BIGINT COMMENT 'Identifier of the analyst or investigator assigned to the case.',
    `billing_id` BIGINT COMMENT 'Foreign key linking to interchange.interchange_billing. Business justification: Billing adjustments for chargebacks require linking each fraud case to the billing period record that captured the transaction.',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder linked to the suspicious activity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Internal cost allocation of fraud investigation resources is tracked via cost centers for budgeting and performance reporting.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Case loss amounts are reported in a specific currency; linking to reference.currency ensures consistent currency metadata.',
    `device_fingerprint_id` BIGINT COMMENT 'Identifier of the device fingerprint record linked to the event.',
    `dispute_case_id` BIGINT COMMENT 'Foreign key linking to dispute.case. Business justification: Link needed for chargeback reconciliation reports that map each confirmed fraud case to its dispute case.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partner Fraud Risk Dashboard aggregates fraud cases per acquiring partner; linking case to ecosystem_partner enables required reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the analyst or investigator assigned to the case.',
    `fraud_rule_id` BIGINT COMMENT 'Identifier of the rule or model that generated the alert.',
    `fraud_type_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_type. Business justification: fraud_case needs a classification of the case type; linking to fraud_type provides hierarchy and risk weighting.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Regulatory filing and jurisdictional reporting of fraud cases require linking each case to the responsible legal entity.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant associated with the case.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Required for regulatory fraud reporting and risk scoring that depend on the specific payment product (card, BNPL, A2A) used in the transaction.',
    `payment_txn_id` BIGINT COMMENT 'FK to transaction.payment_txn.payment_txn_id — MUST-HAVE: Enables linking a fraud case to its triggering transaction — essential for fraud investigation, loss calculation, and network reporting.',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to terminal.pos_terminal. Business justification: Required for fraud case investigation reports that must identify the POS terminal where the suspicious transaction originated.',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to interchange.interchange_qualification. Business justification: Fraud loss reporting needs the original IRF rate applied to the fraudulent transaction to calculate lost interchange revenue.',
    `regulatory_filing_id` BIGINT COMMENT 'Identifier of the regulatory report associated with the case.',
    `regulatory_report_regulatory_filing_id` BIGINT COMMENT 'Identifier of the regulatory report associated with the case.',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_request. Business justification: Investigation reports require linking each fraud case to the original gateway request that initiated the disputed transaction.',
    `response_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_response. Business justification: Fraud case analysis needs the gateway response details (auth code, decline reason) to verify outcome and support regulatory reporting.',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Risk assessment reports require linking each fraud case to the partys risk profile to correlate fraud outcomes with risk scores.',
    `routing_decision_id` BIGINT COMMENT 'Foreign key linking to gateway.routing_decision. Business justification: Case reviews often examine the routing decision that selected the acquirer to understand risk exposure.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Regulatory loss and risk reporting are often aggregated by card scheme; associating each fraud case with its scheme enables accurate reporting.',
    `transaction_id` BIGINT COMMENT 'Identifier of the transaction that triggered the fraud alert.',
    `wallet_transaction_id` BIGINT COMMENT 'Foreign key linking to wallet.wallet_transaction. Business justification: Required for fraud case investigations to drill down to the exact wallet transaction that triggered the case, enabling detailed audit and remediation.',
    `watchlist_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_watchlist. Business justification: fraud_case may reference a watchlist entry that triggered the case; linking to fraud_watchlist enables traceability.',
    `aml_alert` BOOLEAN COMMENT 'Indicates whether the case triggered an AML screening alert.',
    `blocklist_hit` BOOLEAN COMMENT 'True if the entity matched an internal or external blocklist.',
    `blocklist_name` STRING COMMENT 'Name of the blocklist that produced the hit.',
    `case_number` STRING COMMENT 'Human‑readable case number used in investigations and reporting.',
    `case_status` STRING COMMENT 'Current lifecycle state of the fraud case.. Valid values are `open|investigating|escalated|closed|rejected|resolved`',
    `case_type` STRING COMMENT 'Category of fraud scenario prompting the case.. Valid values are `card_not_present|account_takeover|synthetic_identity|first_party|friendly_fraud|other`',
    `channel` STRING COMMENT 'Channel through which the suspicious transaction originated.. Valid values are `web|mobile|pos|api|atm|other`',
    `chargeback_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the chargeback associated with the case.',
    `chargeback_currency` STRING COMMENT 'Currency of the chargeback amount.. Valid values are `^[A-Z]{3}$`',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the case reached a terminal state (e.g., resolved, rejected).',
    `compliance_review_status` STRING COMMENT 'Status of the regulatory compliance review for the case.. Valid values are `pending|completed|exempt|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'When the fraud case record was first created in the system.',
    `detection_source` STRING COMMENT 'System or channel that initially flagged the suspicious activity.. Valid values are `real_time_scoring|rule_engine|ml_model|manual_review|external_alert|partner_feed`',
    `detection_timestamp` TIMESTAMP COMMENT 'Exact time the suspicious event was detected.',
    `escalation_reason` STRING COMMENT 'Free‑text description of why the case was escalated.',
    `exposure_amount` DECIMAL(18,2) COMMENT 'Estimated monetary loss if fraud is successful.',
    `fraud_category` STRING COMMENT 'High‑level fraud taxonomy for the case.. Valid values are `cnp|account_takeover|synthetic|first_party|friendly_fraud|other`',
    `investigation_end_timestamp` TIMESTAMP COMMENT 'When the investigation was concluded.',
    `investigation_start_timestamp` TIMESTAMP COMMENT 'When the formal investigation of the case began.',
    `is_blocked` BOOLEAN COMMENT 'Indicates whether the associated account or card was blocked pending investigation.',
    `is_chargeback_flagged` BOOLEAN COMMENT 'Indicates whether a chargeback was filed related to the case.',
    `is_escalated` BOOLEAN COMMENT 'True when the case has been escalated to senior investigators or external teams.',
    `is_fraudulent` BOOLEAN COMMENT 'True if the case was concluded as confirmed fraud.',
    `is_high_risk` BOOLEAN COMMENT 'Indicates whether the case is flagged as high risk for immediate action.',
    `notes` STRING COMMENT 'Analyst free‑form notes documenting investigation details.',
    `payment_instrument_token` STRING COMMENT 'Token representing the payment credential used in the transaction.',
    `priority` STRING COMMENT 'Operational priority assigned to the case for handling.. Valid values are `low|medium|high|critical`',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Monetary amount successfully recovered from fraudster or merchant.',
    `resolution_outcome` STRING COMMENT 'Final outcome after case investigation.. Valid values are `fraud_confirmed|fraud_dismissed|chargeback_won|chargeback_lost|pending_review|false_positive`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score generated by scoring models (0‑100).',
    `sar_filed` BOOLEAN COMMENT 'True if a Suspicious Activity Report was filed for this case.',
    `severity_level` STRING COMMENT 'Business‑defined severity rating indicating potential impact.. Valid values are `low|medium|high|critical|unknown`',
    `updated_timestamp` TIMESTAMP COMMENT 'Most recent time the case record was modified.',
    CONSTRAINT pk_fraud_case PRIMARY KEY(`fraud_case_id`)
) COMMENT 'Core operational record representing a fraud investigation lifecycle from initial detection through remediation. Tracks case type (card-not-present, account takeover, synthetic identity, first-party fraud, etc.), case status, assigned investigator, detection source, financial exposure, recovery amount, and resolution outcome. SSOT for fraud case management in the Fraud Detection and Prevention Platform.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` (
    `fraud_alert_id` BIGINT COMMENT 'System-generated unique identifier for the fraud alert record.',
    `assigned_user_employee_id` BIGINT COMMENT 'Identifier of the analyst or user currently handling the alert.',
    `cardholder_cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder (primary account holder).',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder (primary account holder).',
    `compliance_aml_screening_result_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_aml_screening_result. Business justification: Regulatory reporting requires attaching AML screening results to each fraud alert for audit trails and SAR/STR filing.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Geo country code drives jurisdictional AML checks; FK to reference.country provides authoritative country data.',
    `cross_border_payment_id` BIGINT COMMENT 'Foreign key linking to fx.cross_border_payment. Business justification: Real‑time fraud alerts for cross‑border payments need the payment ID to fetch transaction details for immediate response.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Transaction currency must map to reference.currency for regulatory reporting and FX conversion thresholds.',
    `device_fingerprint_id` BIGINT COMMENT 'Identifier of the device fingerprint record associated with the transaction.',
    `dispute_case_id` BIGINT COMMENT 'Identifier of the downstream fraud case linked to this alert.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Regulatory and SLA alerts are sent to the partner owning the merchant; linking alerts to partner supports AML/Fraud notification workflow.',
    `employee_id` BIGINT COMMENT 'Identifier of the analyst or user currently handling the alert.',
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.network_endpoint. Business justification: Forensic analysis of alerts needs the exact network endpoint that processed the transaction, supporting root‑cause investigations.',
    `fraud_rule_id` BIGINT COMMENT 'Identifier of the rule that triggered the alert, if rule‑based.',
    `mcc_id` BIGINT COMMENT 'Foreign key linking to reference.mcc. Business justification: MCC code is used for fraud risk scoring and reporting; linking to reference.mcc enables standardized risk categories.',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant involved in the transaction.',
    `risk_model_id` BIGINT COMMENT 'Identifier of the ML model that produced the fraud score, if applicable.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Alerts must reference the payment product to apply product‑specific risk thresholds and generate compliance reports.',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to terminal.pos_terminal. Business justification: Real‑time fraud alerts need terminal context to apply device‑specific risk rules and for audit trails in compliance reporting.',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_request. Business justification: Alert triage uses the exact gateway request payload to reproduce the event and assess fraud indicators.',
    `response_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_response. Business justification: Linking alerts to the gateway response enables auditors to see the response code and fraud flag that triggered the alert.',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: Sanctions screening is executed as part of fraud alert processing; linking records the check result for regulatory filing.',
    `transaction_id` BIGINT COMMENT 'Unique identifier of the transaction that triggered the alert.',
    `wallet_transaction_id` BIGINT COMMENT 'Foreign key linking to wallet.wallet_transaction. Business justification: Alerts generated from wallet monitoring need a direct link to the wallet transaction for analysts to view transaction context and take action.',
    `alert_type` STRING COMMENT 'Category of the alert indicating the source logic (rule, machine‑learning score, velocity control, etc.).. Valid values are `rule_violation|ml_score|velocity|custom`',
    `auth_response_code` STRING COMMENT 'ISO‑8583 response code returned by the issuer. [ENUM-REF-CANDIDATE: 00|05|12|13|14|15|30|41|43|51|54|55|57|58|62|63|65|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|92|93|94|95|96|97|98|99 — 42 candidates stripped; promote to reference product]',
    `channel` STRING COMMENT 'Digital or physical channel through which the transaction was initiated.. Valid values are `web|mobile|pos|atm`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the alert record was first created in the data lake.',
    `decline_reason` STRING COMMENT 'Reason provided by the issuer for a declined transaction, if applicable.. Valid values are `insufficient_funds|card_stolen|invalid_cvv|exceeds_limit|suspected_fraud|other`',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp when the fraud alert was generated by the detection engine.',
    `fraud_alert_status` STRING COMMENT 'Current lifecycle state of the alert within the case management workflow.. Valid values are `open|reviewed|escalated|closed`',
    `geo_city` STRING COMMENT 'City name of the transaction source location, if available.',
    `geo_country` STRING COMMENT 'Three‑letter ISO country code of the transaction source.. Valid values are `^[A-Z]{3}$`',
    `ip_address` STRING COMMENT 'IP address from which the transaction originated.',
    `is_fraudulent` BOOLEAN COMMENT 'Flag indicating whether the transaction is confirmed as fraudulent after review.',
    `model_name` STRING COMMENT 'Descriptive name of the ML model used for scoring.',
    `notes` STRING COMMENT 'Free‑form text notes added by analysts during investigation.',
    `payment_method` STRING COMMENT 'Instrument used for the transaction (e.g., card, bank transfer).. Valid values are `card|bank_transfer|wallet|crypto`',
    `payment_network` STRING COMMENT 'Card scheme or network that processed the transaction.. Valid values are `visa|mastercard|amex|discover|other`',
    `remediation_action` STRING COMMENT 'Recommended action taken by the system or analyst in response to the alert.. Valid values are `block|monitor|investigate|none`',
    `rule_name` STRING COMMENT 'Human‑readable name of the rule that caused the alert.',
    `score_threshold` DECIMAL(18,2) COMMENT 'Configured threshold that the triggered_score must exceed to raise an alert.',
    `severity_level` STRING COMMENT 'Business‑defined severity indicating potential impact of the alert.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Name of the upstream system that emitted the alert (e.g., gateway, fraud_engine).',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the transaction in the transaction currency.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Exact time the underlying transaction occurred.',
    `triggered_score` DECIMAL(18,2) COMMENT 'Numeric risk score generated by the detection engine.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the alert record.',
    CONSTRAINT pk_fraud_alert PRIMARY KEY(`fraud_alert_id`)
) COMMENT 'Real-time fraud alert generated by the fraud detection engine when a transaction or account activity breaches a scoring threshold or rule condition. Captures alert type, severity level, triggering rule or model identifier, alert status (open, reviewed, escalated, closed), and the associated transaction or account reference. Feeds the case management workflow.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` (
    `fraud_rule_id` BIGINT COMMENT 'System-generated unique identifier for the fraud rule.',
    `created_by_user_employee_id` BIGINT COMMENT 'Internal user who originally created the rule.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: FX‑specific fraud rules are defined per currency pair; the rule must reference the pair for correct applicability.',
    `employee_id` BIGINT COMMENT 'Internal user responsible for the rules lifecycle and maintenance.',
    `fraud_channel_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_channel. Business justification: fraud_rule applies to specific channels; a FK to fraud_channel replaces the free‑text channel_applicability and enforces valid channel references.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Rules are defined per payment product to enforce product‑specific controls and satisfy product‑level compliance policies.',
    `primary_fraud_employee_id` BIGINT COMMENT 'Internal user responsible for the rules lifecycle and maintenance.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Each fraud rule is derived from a specific regulatory obligation; linking enables compliance impact analysis and rule audits.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Payment schemes have distinct fraud rule sets; linking rules to scheme_id allows scheme‑specific rule activation and compliance reporting.',
    `tertiary_fraud_updated_by_user_employee_id` BIGINT COMMENT 'Internal user who performed the latest update.',
    `updated_by_user_employee_id` BIGINT COMMENT 'Internal user who performed the latest update.',
    `wallet_scheme_id` BIGINT COMMENT 'Foreign key linking to wallet.wallet_scheme. Business justification: Fraud rules are often scoped to specific card schemes; associating a rule with a wallet scheme supports rule management and regulatory reporting.',
    `action` STRING COMMENT 'Action taken when the rule condition evaluates to true.. Valid values are `decline|flag|challenge|review`',
    `condition_expression` STRING COMMENT 'Executable logical expression evaluated by the rule engine (e.g., DSL or SQL‑like syntax).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created.',
    `effective_from` DATE COMMENT 'Date from which the rule becomes active in production.',
    `effective_until` DATE COMMENT 'Date after which the rule is no longer applied (null for open‑ended).',
    `fraud_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|deprecated|pending`',
    `is_test_rule` BOOLEAN COMMENT 'Indicates whether the rule is deployed in a test environment only.',
    `max_decline_amount` DECIMAL(18,2) COMMENT 'Upper monetary limit for automatic decline actions.',
    `max_decline_currency` STRING COMMENT 'ISO 4217 currency code for the max decline amount.',
    `notes` STRING COMMENT 'Free‑form field for additional comments or operational guidance.',
    `priority` STRING COMMENT 'Numeric priority used to resolve conflicts when multiple rules match (lower = higher priority).',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Minimum fraud risk score required for the rule to fire.',
    `rule_code` STRING COMMENT 'Business-friendly short code used to reference the rule in operational dashboards and logs.',
    `rule_description` STRING COMMENT 'Detailed description of the rules purpose, scope and business rationale.',
    `rule_name` STRING COMMENT 'Human‑readable name of the fraud detection rule.',
    `rule_type` STRING COMMENT 'Category of the rule defining its evaluation logic.. Valid values are `velocity|threshold|pattern|blocklist`',
    `severity` STRING COMMENT 'Business impact rating of the rule when triggered.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the rule.',
    `velocity_limit` STRING COMMENT 'Maximum number of transactions allowed within the velocity window.',
    `velocity_window_seconds` STRING COMMENT 'Time window over which transaction count is evaluated for velocity rules.',
    `version_number` STRING COMMENT 'Monotonically increasing version of the rule definition.',
    CONSTRAINT pk_fraud_rule PRIMARY KEY(`fraud_rule_id`)
) COMMENT 'Configuration record for a fraud detection rule deployed in the rule engine. Defines rule name, rule type (velocity, threshold, pattern, blocklist), condition logic expression, action (decline, flag, challenge, review), effective date range, channel applicability (POS, CNP, ATM, digital wallet), and rule owner. Supports versioned rule lifecycle management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`rule_version` (
    `rule_version_id` BIGINT COMMENT 'System-generated unique identifier for each version of a fraud rule configuration.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that initially created the rule version record.',
    `fraud_rule_id` BIGINT COMMENT 'Identifier of the parent fraud rule to which this version belongs.',
    `fx_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to fx.fx_fee_schedule. Business justification: Certain fraud rule versions need to reference the applicable FX fee schedule for cost‑based risk calculations.',
    `rate_margin_config_id` BIGINT COMMENT 'Foreign key linking to fx.rate_margin_config. Business justification: Rule versions may depend on margin configuration parameters that affect FX pricing and fraud thresholds.',
    `action_parameters` STRING COMMENT 'Serialized parameters that define actions taken when the rule fires (e.g., block, challenge, alert).',
    `activation_timestamp` TIMESTAMP COMMENT 'Date‑time when the rule version became effective for evaluation.',
    `applies_to_payment_method` STRING COMMENT 'Payment instrument categories that the rule evaluates.. Valid values are `card|bank_transfer|wallet|crypto|other`',
    `applies_to_region` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code indicating the geographic region where the rule is active.. Valid values are `^[A-Z]{3}$`',
    `applies_to_transaction_type` STRING COMMENT 'Transaction event types to which the rule is applied.. Valid values are `auth|capture|settlement|refund|chargeback`',
    `approved_by` STRING COMMENT 'Name or identifier of the analyst who approved this rule version.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the rule version received formal approval.',
    `compliance_requirements` STRING COMMENT 'Textual list of regulatory or internal compliance controls that this rule satisfies (e.g., PCI DSS, AML, PSD2).',
    `condition_logic` STRING COMMENT 'Serialized representation (e.g., JSON or DSL) of the rules conditional expressions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when this rule version record was first created in the system.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'Date‑time when the rule version was retired or superseded (nullable if still active).',
    `is_fallback_rule` BOOLEAN COMMENT 'Flag indicating whether this rule serves as a fallback when no other rule matches.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system that performed the most recent update.',
    `max_amount_per_day` DECIMAL(18,2) COMMENT 'Monetary ceiling for cumulative transaction amount in a day that, if exceeded, triggers the rule.',
    `max_transactions_per_minute` STRING COMMENT 'Velocity control limit for the number of transactions allowed per minute before the rule triggers.',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Numeric threshold that the computed risk score must exceed to trigger the rule.',
    `rule_name` STRING COMMENT 'Human‑readable name of the fraud rule.',
    `rule_source` STRING COMMENT 'Origin of the rule definition (built in‑house, supplied by a partner, or mandated by regulation).. Valid values are `internal|partner|regulatory`',
    `rule_type` STRING COMMENT 'Category of the rule logic (e.g., velocity control, device fingerprint, 3‑DS outcome, behavioral analytics, machine‑learning model, or custom).. Valid values are `velocity|device_fingerprint|3ds_outcome|behavioral|ml_model|custom`',
    `rule_version_description` STRING COMMENT 'Detailed free‑text description of the rule purpose and scope.',
    `rule_version_status` STRING COMMENT 'Current lifecycle state of the rule version.. Valid values are `draft|active|inactive|retired|pending_approval`',
    `threshold_unit` STRING COMMENT 'Unit of measurement for the risk score threshold (points or percent).. Valid values are `points|percent`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to this rule version record.',
    `version_number` STRING COMMENT 'Sequential version number of the rule configuration.',
    CONSTRAINT pk_rule_version PRIMARY KEY(`rule_version_id`)
) COMMENT 'Versioned history of fraud rule configurations, capturing each published version of a fraud rule with its full condition logic, action parameters, activation timestamp, deactivation timestamp, and the analyst who approved the version. Enables audit trail and rollback capability for rule changes.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` (
    `fraud_velocity_control_id` BIGINT COMMENT 'System-generated unique identifier for the velocity control configuration.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Velocity controls often vary by currency pair, requiring a FK to identify the pair for each control.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who created the control.',
    `notification_template_id` BIGINT COMMENT 'Reference to the template used for alerts generated by this control.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Velocity controls vary by product type; linking enables enforcement of product‑specific transaction limits.',
    `primary_fraud_employee_id` BIGINT COMMENT 'Identifier of the internal user who created the control.',
    `updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the internal user who last modified the control.',
    `applicable_channels` STRING COMMENT 'Payment channels to which the control applies.. Valid values are `cnp|pos|mpos|online|mobile`',
    `applicable_payment_methods` STRING COMMENT 'Payment instrument types covered by the control.. Valid values are `card|token|digital_wallet|bank_transfer|crypto`',
    `breach_action` STRING COMMENT 'Action taken when the threshold is exceeded: block transaction, flag for review, invoke step‑up authentication, or generate an alert.. Valid values are `block|flag|step_up_auth|alert`',
    `breach_count` BIGINT COMMENT 'Cumulative number of times the control has been breached since activation.',
    `compliance_flag` STRING COMMENT 'Indicates regulatory compliance relevance of the control.. Valid values are `pci|psd2|none`',
    `control_code` STRING COMMENT 'Human‑readable unique code used to reference the control in operational interfaces.',
    `control_name` STRING COMMENT 'Descriptive name of the velocity control rule.',
    `control_type` STRING COMMENT 'Specifies the measurement type the control evaluates: transaction count, monetary amount, distinct merchant count, or distinct device count.. Valid values are `count|amount|unique_merchant|unique_device`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the control record was first created.',
    `effective_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the control expires; null for indefinite.',
    `effective_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the control becomes effective.',
    `fraud_velocity_control_description` STRING COMMENT 'Free‑form description of the controls purpose and business rationale.',
    `fraud_velocity_control_status` STRING COMMENT 'Current lifecycle status of the velocity control.. Valid values are `active|inactive|pending|retired`',
    `is_global` BOOLEAN COMMENT 'Indicates whether the control applies globally across all jurisdictions (true) or is jurisdiction‑specific (false).',
    `jurisdiction_country_code` STRING COMMENT 'Three‑letter ISO country code indicating the regulatory jurisdiction for the control.. Valid values are `^[A-Z]{3}$`',
    `last_breach_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent occurrence where the control was breached.',
    `priority` STRING COMMENT 'Relative priority (1‑10) used when multiple controls conflict; lower numbers indicate higher priority.',
    `risk_score_weight` DECIMAL(18,2) COMMENT 'Weight applied to the controls outcome when calculating an overall fraud risk score.',
    `rule_version` STRING COMMENT 'Version identifier for the control definition (e.g., v1.0, v2.1).',
    `scope_entity` STRING COMMENT 'Entity to which the velocity limit applies (e.g., individual cardholder, merchant, BIN, device, IP address, or channel).. Valid values are `cardholder|merchant|bin|device|ip_address|channel`',
    `threshold_unit` STRING COMMENT 'Unit of the threshold value: number of transactions or monetary currency.. Valid values are `transactions|currency`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric limit that triggers the breach action; interpreted according to threshold_unit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the control record.',
    `window_duration_seconds` STRING COMMENT 'Length of the rolling time window over which the control is evaluated, expressed in seconds.',
    CONSTRAINT pk_fraud_velocity_control PRIMARY KEY(`fraud_velocity_control_id`)
) COMMENT 'Velocity control configuration defining transaction frequency and volume limits applied per cardholder, merchant, BIN, or device within a rolling time window. Captures control type (count, amount, unique merchant), window duration, threshold value, breach action (block, flag, step-up auth), and applicability scope. Core fraud prevention mechanism for CNP and POS channels.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` (
    `velocity_breach_id` BIGINT COMMENT 'System-generated unique identifier for the velocity control breach event.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Breach amount currency must be tied to reference.currency for loss reporting and risk aggregation.',
    `device_fingerprint_id` BIGINT COMMENT 'Unique identifier of the device fingerprint used in risk assessment.',
    `fraud_velocity_control_id` BIGINT COMMENT 'Identifier of the velocity control rule that was breached.',
    `mcc_id` BIGINT COMMENT 'Foreign key linking to reference.mcc. Business justification: MCC drives velocity thresholds; FK to reference.mcc provides standardized category data.',
    `transaction_id` BIGINT COMMENT 'Identifier of the individual transaction that caused the breach.',
    `action_taken` STRING COMMENT 'Automated or manual response applied after the breach (e.g., block, flag, challenge).. Valid values are `block|flag|challenge|none`',
    `action_timestamp` TIMESTAMP COMMENT 'Date and time when the response action was executed.',
    `bin_number` STRING COMMENT 'First six digits of the card number identifying the issuing bank.',
    `breach_status` STRING COMMENT 'Current lifecycle status of the breach event.. Valid values are `open|resolved|escalated`',
    `breach_timestamp` TIMESTAMP COMMENT 'Date and time when the velocity breach was detected.',
    `channel` STRING COMMENT 'Origin channel of the transaction that triggered the breach.. Valid values are `web|mobile|pos|mpos|nfc`',
    `compliance_flag` STRING COMMENT 'Indicates if the breach has regulatory or internal compliance implications.. Valid values are `regulatory|internal|none`',
    `control_name` STRING COMMENT 'Human‑readable name of the breached velocity control.',
    `control_type` STRING COMMENT 'Category of the control – e.g., transaction count, monetary amount, frequency, or custom value.. Valid values are `count|amount|frequency|value`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the breach record was first persisted.',
    `detection_engine` STRING COMMENT 'Engine that evaluated the transaction – real‑time rule engine, batch processor, or ML model.. Valid values are `real_time|batch|ml_model`',
    `entity_identifier` STRING COMMENT 'Business identifier of the entity such as masked PAN (last 4), MID, or device token.',
    `entity_reference` BIGINT COMMENT 'System identifier of the entity (e.g., cardholder_id, merchant_id) that caused the breach.',
    `entity_type` STRING COMMENT 'Type of entity that triggered the breach (cardholder, merchant, device, BIN, or account).. Valid values are `cardholder|merchant|device|bin|account`',
    `ip_address` STRING COMMENT 'IP address observed for the transaction that triggered the breach.',
    `is_fraudulent` BOOLEAN COMMENT 'Indicates whether the transaction was classified as fraudulent.',
    `jurisdiction` STRING COMMENT 'Three‑letter country code where the breach originated or is subject to regulation.',
    `observed_value` DECIMAL(18,2) COMMENT 'The actual count or monetary amount observed that exceeded the threshold.',
    `risk_score` DECIMAL(18,2) COMMENT 'Fraud risk score associated with the transaction at detection time.',
    `rule_version` STRING COMMENT 'Version identifier of the velocity control rule at the time of breach.',
    `source_system` STRING COMMENT 'Operational system that generated the breach record.. Valid values are `gateway|processing|fraud_platform|digital_wallet`',
    `threshold_unit` STRING COMMENT 'Unit of the threshold – either a simple count or a currency amount.. Valid values are `count|currency`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Configured limit for the control (count or amount) that should not be exceeded.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the transaction that caused the breach.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the breach record.',
    `user_agent` STRING COMMENT 'Browser or client user‑agent string associated with the transaction.',
    `velocity_breach_description` STRING COMMENT 'Free‑form notes describing the context or rationale of the breach.',
    CONSTRAINT pk_velocity_breach PRIMARY KEY(`velocity_breach_id`)
) COMMENT 'Transactional record of a velocity control breach event, capturing which velocity control was breached, the entity (cardholder, merchant, device, BIN) that triggered the breach, the observed count or amount versus the configured threshold, the breach timestamp, and the resulting action taken (block, flag, challenge). Feeds fraud alert generation.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` (
    `device_fingerprint_id` BIGINT COMMENT 'Unique surrogate key for the device fingerprint record.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Device geo country is used in fraud detection models; linking to reference.country standardizes country risk scores.',
    `app_version` STRING COMMENT 'Version of the mobile or desktop application used.',
    `blocklist_flag` BOOLEAN COMMENT 'Indicates whether the device is present on an internal or external blocklist.',
    `blocklist_source` STRING COMMENT 'Identifier of the source list that flagged the device (e.g., internal, external vendor).',
    `browser_name` STRING COMMENT 'Name of the web browser or embedded web view.',
    `browser_version` STRING COMMENT 'Version of the browser.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the device fingerprint record was created in the data store.',
    `device_fingerprint_status` STRING COMMENT 'Current lifecycle status of the device fingerprint record.. Valid values are `active|inactive|blocked|retired`',
    `device_label` STRING COMMENT 'Human‑readable label or nickname assigned to the device for operational reference.',
    `device_type` STRING COMMENT 'Category of the device used in the transaction.. Valid values are `mobile|desktop|pos|mpos|tablet|other`',
    `fingerprint_hash` STRING COMMENT 'Cryptographic hash representing the unique digital fingerprint of the device.',
    `first_seen_timestamp` TIMESTAMP COMMENT 'Timestamp when the device fingerprint was first observed in the system.',
    `geo_city` STRING COMMENT 'City name derived from geolocation.',
    `hce_flag` BOOLEAN COMMENT 'Indicates whether the device supports Host Card Emulation.',
    `ip_address` STRING COMMENT 'IP address observed at the time of device interaction.',
    `last_seen_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent observation of the device fingerprint.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the device location.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the device location.',
    `nfc_capable` BOOLEAN COMMENT 'Indicates whether the device has Near Field Communication capability.',
    `os_name` STRING COMMENT 'Name of the operating system running on the device.',
    `os_version` STRING COMMENT 'Version string of the operating system.',
    `risk_category` STRING COMMENT 'Categorical risk classification derived from the risk score.. Valid values are `low|medium|high|critical`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score assigned to the device based on fraud models.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the device fingerprint record.',
    `user_agent` STRING COMMENT 'Full user‑agent string captured from the device request.',
    CONSTRAINT pk_device_fingerprint PRIMARY KEY(`device_fingerprint_id`)
) COMMENT 'Device fingerprint record capturing the unique digital identity of a device used in a payment or authentication event. Stores device fingerprint hash, device type (mobile, desktop, POS terminal, mPOS), OS, browser or app version, IP address, geolocation, HCE flag, NFC capability, first-seen and last-seen timestamps, and risk classification. Used for device-based fraud detection and account takeover prevention.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` (
    `auth_3ds_result_id` BIGINT COMMENT 'Unique surrogate key for each 3-D Secure authentication outcome record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: 3‑DS authentication records need currency context for compliance and settlement reporting.',
    `device_fingerprint_id` BIGINT COMMENT 'Foreign key linking to fraud.device_fingerprint. Business justification: auth_3ds_result stores device fingerprint as a string; linking to device_fingerprint table normalizes device data and removes redundant column.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant involved in the transaction.',
    `transaction_id` BIGINT COMMENT 'Identifier of the payment transaction to which this 3DS result belongs.',
    `tertiary_auth_acs_transaction_id` BIGINT COMMENT 'Identifier assigned by the Access Control Server (ACS) for this authentication flow.',
    `acquirer_bin` STRING COMMENT 'BIN of the acquiring bank that processed the transaction.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount of the transaction associated with this 3DS authentication.',
    `authentication_attempts` STRING COMMENT 'Count of how many authentication attempts were made for this transaction.',
    `authentication_error_code` STRING COMMENT 'Standardized error code returned when authentication fails.',
    `authentication_error_message` STRING COMMENT 'Human‑readable error message describing the authentication failure.',
    `authentication_method` STRING COMMENT 'Method used for authentication: frictionless, challenge, or fallback.. Valid values are `frictionless|challenge|fallback`',
    `authentication_status` STRING COMMENT 'Outcome of the 3-D Secure authentication attempt.. Valid values are `authenticated|attempted|failed|not_enrolled|error`',
    `authentication_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the 3-D Secure authentication event occurred.',
    `authentication_value` DECIMAL(18,2) COMMENT 'Cryptographic authentication value returned by the ACS (CAVV for 3DS 1.x, AAV for 3DS 2.x).',
    `card_scheme` STRING COMMENT 'Payment network brand of the card used (e.g., Visa, Mastercard).. Valid values are `VISA|MASTERCARD|AMEX|DISCOVER|JCB|UNIONPAY`',
    `cardholder_ip_address` STRING COMMENT 'IP address of the cardholder at the time of authentication.',
    `challenge_indicator` STRING COMMENT 'Indicates whether a challenge was required, requested, or not needed.. Valid values are `no_challenge|challenge_requested|challenge_mandated`',
    `compliance_status` STRING COMMENT 'Indicates whether the authentication outcome meets internal and external compliance standards.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this 3DS result record was first inserted into the data lake.',
    `eci_indicator` STRING COMMENT 'ECI code indicating the level of liability shift and authentication strength.. Valid values are `00|01|02|05|06|07`',
    `fraud_score` DECIMAL(18,2) COMMENT 'Risk score assigned by the fraud engine for this authentication event.',
    `is_successful` BOOLEAN COMMENT 'True if the authentication resulted in a successful liability shift.',
    `issuer_bin` STRING COMMENT 'BIN of the issuing bank that issued the card.',
    `liability_shift` BOOLEAN COMMENT 'True if liability for the transaction shifted to the issuer per 3DS outcome.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or analyst comments.',
    `processing_latency_ms` STRING COMMENT 'Time elapsed between authentication request and final response, measured in milliseconds.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if this authentication must be included in regulatory reporting (e.g., AML, PCI).',
    `risk_decision` STRING COMMENT 'Final decision based on fraud score and business rules.. Valid values are `approve|review|reject`',
    `sca_exemption_type` STRING COMMENT 'Type of SCA exemption applied to the transaction, if any.. Valid values are `low_value|trusted_beneficiary|transaction_risk_analysis|secure_corporate_payment|delegated_authentication|trusted_third_party`',
    `source_system` STRING COMMENT 'Originating system that generated the 3DS result (e.g., gateway, digital_wallet).',
    `three_ds_version` STRING COMMENT 'Version of the 3-D Secure protocol used for the authentication.. Valid values are `1.0|2.0|2.1|2.2`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record.',
    CONSTRAINT pk_auth_3ds_result PRIMARY KEY(`auth_3ds_result_id`)
) COMMENT '3-D Secure authentication outcome record for a payment transaction. Captures 3DS version (1.0, 2.1, 2.2), authentication status (authenticated, attempted, failed, not enrolled), ECI indicator, authentication value (CAVV/AAV), DS transaction ID, ACS transaction ID, challenge indicator, SCA exemption type applied, and authentication timestamp. SSOT for 3DS outcomes in the fraud domain.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` (
    `fraud_sca_challenge_id` BIGINT COMMENT 'Unique identifier for the SCA challenge record.',
    `cardholder_cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder (customer) subject to the SCA challenge.',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder (customer) subject to the SCA challenge.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: SCA challenge amount currency is required for risk scoring and cross‑border regulation.',
    `device_fingerprint_id` BIGINT COMMENT 'Foreign key linking to fraud.device_fingerprint. Business justification: fraud_sca_challenge stores device fingerprint as a string; linking to device_fingerprint table normalizes device data and removes redundant column.',
    `fraud_rule_id` BIGINT COMMENT 'Identifier of the fraud rule that triggered the SCA challenge.',
    `gateway3ds_authentication_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway3ds_authentication. Business justification: SCA challenge records must be tied to the corresponding 3‑DS authentication session for full compliance audit.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant involved in the transaction.',
    `pos_terminal_id` BIGINT COMMENT 'Identifier of the POS terminal that initiated the transaction.',
    `transaction_id` BIGINT COMMENT 'Identifier of the payment transaction that triggered the SCA challenge.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the underlying transaction.',
    `auth_code` STRING COMMENT 'Authorization code returned by the issuer after successful challenge.',
    `challenge_attempt_number` STRING COMMENT 'Sequential number of the attempt for the same transaction.',
    `challenge_outcome` STRING COMMENT 'Result of the SCA challenge: passed, failed, or abandoned by the cardholder.. Valid values are `passed|failed|abandoned`',
    `challenge_response_time_ms` STRING COMMENT 'Elapsed time in milliseconds between initiation and completion of the challenge.',
    `challenge_status` STRING COMMENT 'Current lifecycle status of the challenge.. Valid values are `pending|completed|timeout`',
    `completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the SCA challenge was completed (success, failure, or abandonment).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SCA challenge record was first created in the data lake.',
    `exemption_type` STRING COMMENT 'PSD2 exemption applied to the transaction, if any.. Valid values are `low_value|transaction_risk_analysis|trusted_beneficiary|recurring|none`',
    `failure_reason` STRING COMMENT 'Textual description of why the challenge failed, if applicable.',
    `idempotency_key` STRING COMMENT 'Unique key to ensure the challenge request is processed exactly once.',
    `initiation_timestamp` TIMESTAMP COMMENT 'Timestamp when the SCA challenge was presented to the cardholder.',
    `ip_address` STRING COMMENT 'Source IP address of the device that performed the SCA challenge.. Valid values are `^((25[0-5]|2[0-4]d|[01]?dd?).){3}(25[0-5]|2[0-4]d|[01]?dd?)$`',
    `is_challenge_abandoned` BOOLEAN COMMENT 'True when the cardholder abandoned the challenge.',
    `is_challenge_blocked` BOOLEAN COMMENT 'True when the challenge was blocked by policy or system error.',
    `is_challenge_exempted` BOOLEAN COMMENT 'True when an SCA exemption was applied and no challenge was required.',
    `is_challenge_successful` BOOLEAN COMMENT 'True when the challenge outcome is passed.',
    `mcc_code` STRING COMMENT 'Four‑digit code classifying the merchants business type.',
    `payment_instrument_type` STRING COMMENT 'Type of payment instrument used for the transaction.. Valid values are `card|bank_account|digital_wallet`',
    `regulatory_context` STRING COMMENT 'Regulatory framework governing the challenge, e.g., PSD2.. Valid values are `psd2|other`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score assigned by the fraud detection engine prior to the challenge.',
    `sca_method` STRING COMMENT 'Method used to perform the SCA challenge (One‑Time Password, biometric, push notification, knowledge‑based).. Valid values are `otp|biometric|push|knowledge`',
    `source_channel` STRING COMMENT 'Channel through which the SCA challenge was presented (web, mobile app, POS terminal, API).. Valid values are `web|mobile|pos|api`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SCA challenge record.',
    CONSTRAINT pk_fraud_sca_challenge PRIMARY KEY(`fraud_sca_challenge_id`)
) COMMENT 'Strong Customer Authentication challenge record capturing the SCA method used (OTP, biometric, push notification, knowledge-based), challenge outcome (passed, failed, abandoned), SCA exemption applied (low-value, TRA, trusted beneficiary, recurring), PSD2 regulatory context, challenge initiation timestamp, and completion timestamp. Supports PSD2 SCA compliance reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` (
    `blocklist_entry_id` BIGINT COMMENT 'System-generated unique identifier for each blocklist record.',
    `fraud_case_id` BIGINT COMMENT 'Identifier of the fraud case that triggered this blocklist entry, if applicable.',
    `block_reason_code` STRING COMMENT 'Standardized code indicating why the entity was placed on the blocklist.. Valid values are `fraud|risk|regulatory|compliance|partner_advisory|custom`',
    `blocking_scope` STRING COMMENT 'Scope of the block action (e.g., decline transaction, flag for review, step‑up authentication, monitor only).. Valid values are `decline|flag|step_up|monitor`',
    `blocklist_entry_status` STRING COMMENT 'Current lifecycle status of the blocklist record.. Valid values are `active|inactive|pending_removal|expired`',
    `blocklist_version` STRING COMMENT 'Version number for the blocklist record to support change tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the blocklist entry was initially created.',
    `effective_date` DATE COMMENT 'Date when the block becomes active.',
    `entity_identifier` STRING COMMENT 'Tokenized or hashed value that uniquely identifies the blocked entity within the system.',
    `entity_type` STRING COMMENT 'Category of the entity being blocked (e.g., PAN, BIN, IP address, email, phone, merchant MID).. Valid values are `pan|bin|ip_address|email|phone|merchant_mid`',
    `expiry_date` DATE COMMENT 'Date when the block expires or is scheduled to be removed (nullable for indefinite blocks).',
    `is_global` BOOLEAN COMMENT 'True if the block applies across all jurisdictions; false if limited to a specific jurisdiction.',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code indicating the jurisdiction where the block applies.. Valid values are `^[A-Z]{3}$`',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent periodic review of the blocklist entry.',
    `notes` STRING COMMENT 'Free‑form text for additional context or comments about the block.',
    `review_status` STRING COMMENT 'Result of the latest review (e.g., reviewed, not reviewed, escalated).. Valid values are `reviewed|not_reviewed|escalated`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk rating assigned to the entity at the time of blocklist entry (higher indicates greater risk).',
    `source_of_addition` STRING COMMENT 'Origin of the blocklist entry (e.g., manual entry, automated fraud rule, network advisory).. Valid values are `manual|automated_rule|network_advisory|regulatory|partner`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the blocklist entry.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the blocklist entry.',
    CONSTRAINT pk_blocklist_entry PRIMARY KEY(`blocklist_entry_id`)
) COMMENT 'Blocklist record for an entity (PAN, BIN, device fingerprint, IP address, email, phone, merchant MID, IBAN) that has been flagged for blocking or enhanced scrutiny. Captures entity type, entity identifier (tokenized/hashed), blocklist reason code, source of addition (manual, automated rule, network advisory), effective date, expiry date, and blocking scope (decline, flag, step-up). SSOT for fraud blocklist management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` (
    `blocklist_audit_id` BIGINT COMMENT 'Unique surrogate key for each audit log entry of a blocklist record.',
    `blocklist_entry_id` BIGINT COMMENT 'Identifier of the blocklist entry whose lifecycle event is being recorded.',
    `fraud_case_id` BIGINT COMMENT 'Identifier of the fraud case linked to this blocklist event, if any.',
    `related_fraud_case_id` BIGINT COMMENT 'Identifier of the fraud case linked to this blocklist event, if any.',
    `blocklist_type` STRING COMMENT 'Category of the value being blocked (e.g., IP address, PAN, device identifier, token, email, phone).. Valid values are `ip|pan|device|token|email|phone`',
    `blocklist_value` DECIMAL(18,2) COMMENT 'The actual value placed on the blocklist (e.g., PAN, IP address, token).',
    `comment` STRING COMMENT 'Free‑form notes or comments added by the performer.',
    `compliance_requirement` STRING COMMENT 'Regulatory or standards driver for the blocklist action.. Valid values are `PCI_DSS|AML|KYC|GDPR`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the data store.',
    `error_code` STRING COMMENT 'System error code returned if the blocklist action failed.',
    `error_message` STRING COMMENT 'Human‑readable error description for a failed blocklist operation.',
    `event_timestamp` TIMESTAMP COMMENT 'Date‑time when the blocklist lifecycle action occurred.',
    `event_type` STRING COMMENT 'Type of audit event: addition, modification, removal, or expiry of a blocklist entry.. Valid values are `add|modify|remove|expire`',
    `expiry_date` DATE COMMENT 'Scheduled date when the blocklist entry is set to expire, if applicable.',
    `is_successful` BOOLEAN COMMENT 'Indicates whether the blocklist operation completed successfully.',
    `justification` STRING COMMENT 'Narrative explanation for why the blocklist action was taken, required for regulatory audit.',
    `new_status` STRING COMMENT 'Status of the blocklist entry after the event.. Valid values are `active|inactive|expired|pending`',
    `performed_by` STRING COMMENT 'Name or identifier of the analyst, system, or automated process that executed the action.',
    `performed_by_role` STRING COMMENT 'Role of the actor that performed the blocklist action.. Valid values are `analyst|system|automated`',
    `previous_status` STRING COMMENT 'Status of the blocklist entry before the event.. Valid values are `active|inactive|expired|pending`',
    `region_code` STRING COMMENT 'Three‑letter country code representing the geographic region associated with the blocklist value.',
    `risk_category` STRING COMMENT 'Risk tier derived from the risk score (low, medium, high).. Valid values are `low|medium|high`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score assigned to the blocklist entry at the time of the event.',
    `source_system` STRING COMMENT 'Originating system that generated the blocklist event.. Valid values are `gateway|fraud_platform|compliance_system|digital_wallet`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this audit record.',
    CONSTRAINT pk_blocklist_audit PRIMARY KEY(`blocklist_audit_id`)
) COMMENT 'Audit trail for blocklist entry lifecycle events — additions, modifications, removals, and expiry actions. Captures the previous and new state of the blocklist entry, the action type, the analyst or automated process that performed the action, and the business justification. Supports regulatory audit and PCI DSS compliance requirements.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`score_event` (
    `score_event_id` BIGINT COMMENT 'Globally unique identifier for the fraud scoring event record.',
    `cardholder_cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder (or account holder) involved in the transaction.',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder (or account holder) involved in the transaction.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Score events reference transaction currency; FK to reference.currency enables unified currency analytics.',
    `device_fingerprint_id` BIGINT COMMENT 'Identifier of the device fingerprint record associated with the transaction.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the transaction.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Score events need product context for analytics and to trigger product‑specific actions.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Fraud scoring models incorporate the FX rate at transaction time to assess risk of currency conversion anomalies.',
    `risk_model_id` BIGINT COMMENT 'Foreign key linking to risk.risk_model. Business justification: Fraud scoring uses a specific risk model; linking enables audit of model version per score event for compliance.',
    `rule_set_id` BIGINT COMMENT 'Identifier of the rule set configuration applied during scoring.',
    `transaction_id` BIGINT COMMENT 'Identifier of the transaction that triggered the fraud scoring.',
    `wallet_transaction_id` BIGINT COMMENT 'Foreign key linking to wallet.wallet_transaction. Business justification: Fraud scoring engine processes wallet transactions; linking score events to the wallet transaction provides traceability for compliance audits.',
    `channel` STRING COMMENT 'Digital or physical channel through which the transaction originated.. Valid values are `web|mobile|pos|atm|api`',
    `compliance_status` STRING COMMENT 'Indicates whether the event complies with applicable regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `decision` STRING COMMENT 'Actual decision taken by downstream systems after applying the recommended action.. Valid values are `approved|declined|reviewed|challenged`',
    `event_source` STRING COMMENT 'Subsystem that generated the fraud scoring event.. Valid values are `scoring_engine|rule_engine|ml_model`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date and time when the fraud scoring evaluation was performed.',
    `feature_set_hash` STRING COMMENT 'Hash of the input feature set used for the scoring run, enabling reproducibility.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Numeric fraud risk score produced by the model (higher indicates greater risk).',
    `geo_country_code` STRING COMMENT 'Three‑letter ISO country code derived from the IP address.. Valid values are `^[A-Z]{3}$`',
    `ip_address` STRING COMMENT 'Source IP address of the transaction request.',
    `is_blocked` BOOLEAN COMMENT 'Indicates whether the transaction was automatically blocked by the system.',
    `is_high_risk` BOOLEAN COMMENT 'Indicates whether the transaction is classified as high risk.',
    `latency_ms` STRING COMMENT 'Time in milliseconds taken to compute the fraud score.',
    `model_version` STRING COMMENT 'Version string of the fraud scoring model.',
    `payment_method` STRING COMMENT 'Instrument used to fund the transaction.. Valid values are `card|bank_transfer|wallet|crypto|cash`',
    `reason_code` STRING COMMENT 'Code representing the primary reason for the fraud decision.',
    `recommended_action` STRING COMMENT 'Suggested operational action based on the fraud evaluation.. Valid values are `approve|decline|review|challenge`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fraud score event record was first persisted.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fraud score event record.',
    `regulatory_report_flag` BOOLEAN COMMENT 'True if the event must be included in regulatory reporting feeds.',
    `rule_set_version` STRING COMMENT 'Version of the rule set used for the evaluation.',
    `score_band` STRING COMMENT 'Categorical band derived from the fraud score for operational handling.. Valid values are `low|medium|high|critical`',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the transaction being evaluated.',
    CONSTRAINT pk_score_event PRIMARY KEY(`score_event_id`)
) COMMENT 'Operational record of a fraud scoring evaluation performed on a transaction or account event. Captures the scoring model identifier, model version, input feature set hash, composite fraud score, score band (low, medium, high, critical), scoring latency in milliseconds, and the recommended action output. This is an OPERATIONAL event record — not an analytics aggregate — representing each real-time scoring invocation.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`investigation` (
    `investigation_id` BIGINT COMMENT 'Unique identifier for the fraud investigation record.',
    `audit_trail_id` BIGINT COMMENT 'Reference to audit trail record for this investigation.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: Investigations may focus on a compromised digital wallet; linking the investigation to the wallet enables case‑level reporting and remediation tracking.',
    `dispute_case_id` BIGINT COMMENT 'Foreign key linking to dispute.case. Business justification: Investigation outcomes are reported in dispute case files; linking enables the Investigation‑to‑Dispute summary report.',
    `employee_id` BIGINT COMMENT 'Identifier of the investigator assigned to the case.',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_case. Business justification: An investigation belongs to a single fraud case; adding investigation.fraud_case_id enables direct navigation and satisfies the requirement that every product participates in a relationship.',
    `investigation_assigned_investigator_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `investigation_employee_id` BIGINT COMMENT 'Identifier of the investigator assigned to the case.',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the investigator was assigned.',
    `case_number` STRING COMMENT 'External case number assigned by the fraud case management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the investigation record was created.',
    `data_retention_period_days` STRING COMMENT 'Number of days the investigation data must be retained per policy.',
    `end_timestamp` TIMESTAMP COMMENT 'When the investigation was concluded.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the investigation was escalated, if applicable.',
    `evidence_details` STRING COMMENT 'Detailed evidence data (e.g., transaction logs, device data) stored as JSON string.',
    `evidence_summary` STRING COMMENT 'Summary of evidence collected during investigation.',
    `investigation_status` STRING COMMENT 'Current lifecycle status of the investigation.. Valid values are `open|in_progress|escalated|closed|rejected|suspended`',
    `investigation_type` STRING COMMENT 'Category of investigation.. Valid values are `fraud|risk|compliance|dispute`',
    `investigator_name` STRING COMMENT 'Full name of the assigned investigator.',
    `is_privileged` BOOLEAN COMMENT 'Indicates if the investigation involves privileged accounts.',
    `notes` STRING COMMENT 'Additional notes or comments by investigator.',
    `outcome_decision` STRING COMMENT 'Result of the investigation.. Valid values are `fraud_confirmed|fraud_not_confirmed|false_positive|escalated`',
    `outcome_recommendation` STRING COMMENT 'Recommended action based on investigation outcome.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Flag indicating if the case must be reported to regulators.',
    `reporting_jurisdiction` STRING COMMENT 'Jurisdiction for regulatory reporting (ISO 3166-1 alpha-3).',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score associated with the case, as calculated by fraud scoring engine.',
    `severity` STRING COMMENT 'Severity level assigned to the investigation.. Valid values are `low|medium|high|critical`',
    `sla_compliance` BOOLEAN COMMENT 'Indicates whether the investigation met SLA requirements.',
    `sla_due_timestamp` TIMESTAMP COMMENT 'Target date/time for SLA compliance.',
    `start_timestamp` TIMESTAMP COMMENT 'When the investigation work began.',
    `steps` STRING COMMENT 'Chronological description of steps taken during investigation.',
    `title` STRING COMMENT 'Brief title or description of the investigation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_investigation PRIMARY KEY(`investigation_id`)
) COMMENT 'Detailed investigation record linked to a fraud case, tracking the investigator assigned, investigation steps taken, evidence collected (transaction logs, device data, cardholder statements), escalation history, SLA compliance status, and investigation outcome recommendation. Supports the full case investigation workflow within the FDPP case management module.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`evidence` (
    `evidence_id` BIGINT COMMENT 'Unique surrogate key for each fraud evidence record.',
    `device_id` BIGINT COMMENT 'Identifier of the device (e.g., terminal, mobile) that generated the evidence.',
    `fraud_case_id` BIGINT COMMENT 'Identifier of the fraud case to which this evidence belongs.',
    `evidence_related_fraud_case_id` BIGINT COMMENT 'Identifier of the fraud case to which this evidence belongs.',
    `transaction_id` BIGINT COMMENT 'Identifier of the transaction that is the subject of this evidence.',
    `evidence_transaction_id` BIGINT COMMENT 'Identifier of the transaction that is the subject of this evidence.',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder associated with the evidence.',
    `related_cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder associated with the evidence.',
    `access_control_level` STRING COMMENT 'Data classification level governing who may view or retrieve the evidence.. Valid values are `restricted|confidential|internal|public`',
    `admissibility_flag` BOOLEAN COMMENT 'Indicates whether the evidence meets regulatory and legal standards for use in dispute or law‑enforcement proceedings.',
    `chain_of_custody_status` STRING COMMENT 'Current integrity status of the evidence for legal admissibility.. Valid values are `intact|tampered|pending_review`',
    `collection_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the evidence was captured.',
    `compliance_requirements` STRING COMMENT 'Applicable regulatory or internal compliance mandates (e.g., PCI‑DSS, GDPR, AML) linked to the evidence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the evidence record was first created in the data lake.',
    `encryption_status` STRING COMMENT 'Indicates whether the evidence is stored encrypted and the encryption state.. Valid values are `encrypted|plain|unknown`',
    `evidence_description` STRING COMMENT 'Free‑text narrative describing the content and relevance of the evidence.',
    `evidence_source` STRING COMMENT 'Originating system or component that produced the evidence.. Valid values are `gateway|fraud_platform|digital_wallet|risk_engine|external_source`',
    `evidence_status` STRING COMMENT 'Current lifecycle state of the evidence within the fraud investigation process.. Valid values are `collected|reviewed|archived|rejected`',
    `evidence_type` STRING COMMENT 'Category of the evidence artifact captured for a fraud investigation.. Valid values are `transaction_record|device_log|cardholder_statement|network_advisory|3ds_result|sca_log`',
    `file_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA‑256) of the stored evidence file for integrity verification.',
    `file_size_bytes` BIGINT COMMENT 'Size of the evidence file in bytes.',
    `format` STRING COMMENT 'File format or serialization of the stored evidence.. Valid values are `json|xml|pdf|csv|binary`',
    `is_sensitive` BOOLEAN COMMENT 'True if the evidence contains personally identifiable or regulated data.',
    `jurisdiction` STRING COMMENT 'Regulatory jurisdiction governing the evidence, expressed as ISO‑3166‑1 alpha‑3 country code.. Valid values are `US|EU|UK|CA|AU|SG`',
    `retention_expiry_date` DATE COMMENT 'Date after which the evidence must be archived or securely destroyed per regulatory policy.',
    `storage_uri` STRING COMMENT 'Reference (e.g., S3 URI, file path) to the physical location of the stored evidence.',
    `updated_by` STRING COMMENT 'System user or service account that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the evidence record.',
    `created_by` STRING COMMENT 'System user or service account that created the evidence record.',
    CONSTRAINT pk_evidence PRIMARY KEY(`evidence_id`)
) COMMENT 'Evidence artifact record associated with a fraud investigation, capturing evidence type (transaction record, device log, cardholder statement, network advisory, 3DS result, SCA log), evidence source, collection timestamp, storage reference, chain-of-custody status, and admissibility flag. Supports structured evidence management for dispute representment and law enforcement referrals.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`loss` (
    `loss_id` BIGINT COMMENT 'Unique system-generated identifier for the fraud loss record.',
    `dispute_case_id` BIGINT COMMENT 'Foreign key linking to dispute.case. Business justification: Financial loss records must reference the dispute that generated the loss for regulatory loss‑tracking filings.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partner Chargeback Reconciliation Report needs to attribute loss amounts to the responsible partner for settlement and liability.',
    `fraud_case_id` BIGINT COMMENT 'Identifier of the confirmed fraud case to which this loss is linked.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Financial reporting of fraud loss expense requires posting each loss to a GL expense account for SOX compliance and audit trails.',
    `accounting_period` STRING COMMENT 'Fiscal period (e.g., 2023-Q1) to which the loss is booked for financial reporting.. Valid values are `^d{4}-Q[1-4]$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the loss record was first created in the data lake.',
    `currency` STRING COMMENT 'ISO 4217 three‑letter code of the currency in which the loss is measured.. Valid values are `^[A-Z]{3}$`',
    `gross_loss_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the fraudulent transaction before any recovery.',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the regulatory jurisdiction governing the loss.. Valid values are `^[A-Z]{3}$`',
    `loss_category` STRING COMMENT 'Category describing how the fraud occurred (e.g., card‑present, CNP, account takeover).. Valid values are `card_present|card_not_present|account_takeover|synthetic_identity|other`',
    `loss_description` STRING COMMENT 'Free‑form text describing the circumstances of the fraud loss.',
    `loss_status` STRING COMMENT 'Current processing state of the loss record.. Valid values are `open|under_review|closed|reversed`',
    `net_loss_amount` DECIMAL(18,2) COMMENT 'Final loss after subtracting recovered amount from gross loss.',
    `occurrence_timestamp` TIMESTAMP COMMENT 'Exact time the fraudulent loss was realized in the payment flow.',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Amount successfully recovered through chargeback, insurance, or law‑enforcement actions.',
    `recovery_method` STRING COMMENT 'Mechanism used to recover funds from the fraudulent loss.. Valid values are `chargeback|insurance|law_enforcement|self_recovery|none`',
    `reference_number` STRING COMMENT 'Human‑readable reference code for the loss, used in reporting and audit trails.. Valid values are `FL-d{8}`',
    `regulatory_report_flag` BOOLEAN COMMENT 'Indicates whether the loss has been reported to a regulator (true) or not (false).',
    `source_system` STRING COMMENT 'Originating operational system that generated the loss record.. Valid values are `payment_gateway|settlement|dispute|risk`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the loss record.',
    `write_off_date` DATE COMMENT 'Date the loss was formally written off in the accounting system.',
    CONSTRAINT pk_loss PRIMARY KEY(`loss_id`)
) COMMENT 'Financial loss record associated with a confirmed fraud case, capturing gross fraud loss amount, recovered amount, net loss, loss currency, loss category (card-present, CNP, account takeover, synthetic identity), write-off date, recovery method (chargeback, insurance, law enforcement), and accounting period. SSOT for fraud financial impact tracking and regulatory loss reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` (
    `network_fraud_advisory_id` BIGINT COMMENT 'Unique surrogate identifier for the network fraud advisory record.',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_case. Business justification: network_fraud_advisory often relates to a specific fraud case; linking provides context and auditability.',
    `advisory_description` STRING COMMENT 'Free‑text details describing the nature of the fraud advisory.',
    `advisory_severity` STRING COMMENT 'Severity level assigned to the advisory indicating potential impact.. Valid values are `low|medium|high|critical`',
    `advisory_severity_score` STRING COMMENT 'Numeric score representing the advisorys risk magnitude, used for internal prioritization.',
    `advisory_status` STRING COMMENT 'Current processing status of the advisory within the fraud system.. Valid values are `new|reviewed|actioned|closed`',
    `advisory_type` STRING COMMENT 'Category of fraud advisory received from a card network or industry body.. Valid values are `compromised_bin|compromised_pan_range|merchant_compromise|account_takeover|other`',
    `affected_entity_identifier` STRING COMMENT 'Identifier of the affected entity (e.g., compromised BIN number, PAN range, merchant ID).',
    `affected_entity_type` STRING COMMENT 'Type of entity impacted by the advisory (e.g., BIN, PAN, merchant, account).. Valid values are `bin|pan|merchant|account`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the advisory record was first persisted in the lakehouse.',
    `effective_from` DATE COMMENT 'Date from which the advisory is considered active for monitoring.',
    `effective_until` DATE COMMENT 'Date after which the advisory is no longer applicable.',
    `external_reference_number` STRING COMMENT 'Reference number provided by the issuing network for traceability.',
    `internal_action_taken` STRING COMMENT 'Action performed internally in response to the advisory.. Valid values are `monitor|block|investigate|escalate|none`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the advisory is currently active in the system.',
    `network_name` STRING COMMENT 'Card network or industry body that issued the advisory.. Valid values are `visa|mastercard|discover|amex|other`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the advisory was received by the fraud platform.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the advisory record.',
    CONSTRAINT pk_network_fraud_advisory PRIMARY KEY(`network_fraud_advisory_id`)
) COMMENT 'Fraud advisory record received from card network schemes (Visa, Mastercard) or industry bodies, containing advisory type (compromised BIN, compromised PAN range, merchant compromise, account takeover campaign), affected entity identifiers, advisory severity, issuing network, receipt timestamp, and internal action taken. Enables proactive fraud prevention based on network intelligence.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` (
    `compromised_credential_id` BIGINT COMMENT 'System‑generated unique identifier for the compromised credential record.',
    `fraud_case_id` BIGINT COMMENT 'Identifier of the fraud case linked to this compromised credential.',
    `related_fraud_case_id` BIGINT COMMENT 'Identifier of the fraud case linked to this compromised credential.',
    `compliance_requirements` STRING COMMENT 'Applicable regulatory or compliance obligations (e.g., PCI DSS, GDPR) triggered by the compromise.',
    `compromise_date` DATE COMMENT 'Calendar date on which the credential was determined to be compromised.',
    `compromise_source` STRING COMMENT 'Origin of the compromise information indicating how the credential breach was discovered.. Valid values are `network_advisory|dark_web|internal_detection|partner_report`',
    `compromised_credential_status` STRING COMMENT 'Overall lifecycle status of the compromised credential record.. Valid values are `open|closed|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compromised credential record was first created.',
    `credential_identifier_hash` STRING COMMENT 'Hashed representation of the compromised credential value to protect sensitive data while enabling lookup.',
    `credential_type` STRING COMMENT 'Category of the payment credential that was compromised (e.g., PAN, DPAN, IBAN, account number, token).. Valid values are `pan|dpan|iban|account_number|token`',
    `detection_method` STRING COMMENT 'Methodology used to detect the compromise (real‑time scoring, batch analysis, or manual review).. Valid values are `real_time_scoring|batch_analysis|manual_review`',
    `detection_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the compromise was detected by the system.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the compromised credential record is currently active in the system.',
    `issuer_code` BIGINT COMMENT 'Unique identifier of the issuing bank or entity responsible for the compromised credential.',
    `issuer_notified_flag` BOOLEAN COMMENT 'Indicates whether the issuing institution has been notified of the compromise.',
    `jurisdiction` STRING COMMENT 'Three‑letter ISO country code indicating the regulatory jurisdiction relevant to the compromise.',
    `last_modified_by` STRING COMMENT 'User or system identifier that performed the last modification.',
    `notes` STRING COMMENT 'Free‑form text for additional context or comments about the compromise.',
    `notification_status` STRING COMMENT 'Current status of the notification to the issuing bank or cardholder.. Valid values are `pending|sent|failed`',
    `notification_timestamp` TIMESTAMP COMMENT 'Timestamp when the notification was sent (or attempted).',
    `remediation_action` STRING COMMENT 'Planned remediation step to address the compromised credential.. Valid values are `reissue|block|monitor|none`',
    `remediation_completion_date` DATE COMMENT 'Date on which remediation was successfully completed.',
    `remediation_status` STRING COMMENT 'Current state of the remediation process.. Valid values are `pending|in_progress|completed|failed`',
    `remediation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent remediation activity.',
    `risk_score_at_compromise` DECIMAL(18,2) COMMENT 'Fraud risk score assigned to the credential at the time of compromise detection.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_compromised_credential PRIMARY KEY(`compromised_credential_id`)
) COMMENT 'Record of a compromised payment credential (PAN, DPAN, IBAN, account number) identified through network advisories, dark web intelligence, or internal detection. Captures credential type, tokenized/hashed credential identifier, compromise source, compromise date, notification status to issuer, remediation action (reissue, block, monitor), and remediation completion date.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` (
    `case_status_history_id` BIGINT COMMENT 'System-generated unique identifier for each status transition record in the fraud case lifecycle.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Status history location determines regulatory jurisdiction; FK to reference.country supports compliance reporting.',
    `device_fingerprint_id` BIGINT COMMENT 'Reference to the device fingerprint record associated with the event.',
    `fraud_case_id` BIGINT COMMENT 'Unique identifier of the fraud case to which this status transition belongs.',
    `actor` STRING COMMENT 'Name or system identifier of the entity (analyst, automated system, or external partner) that performed the status change.',
    `actor_type` STRING COMMENT 'Classification of the actor that performed the transition.. Valid values are `analyst|automated_system|external_partner`',
    `case_category` STRING COMMENT 'High‑level classification of the fraud type associated with the case.. Valid values are `payment_fraud|identity_theft|account_takeover|friendly_fraud|synthetic_identity`',
    `case_priority` STRING COMMENT 'Business‑defined priority level of the fraud case at the time of the transition.. Valid values are `low|medium|high|critical`',
    `case_status_history_status` STRING COMMENT 'The status of the fraud case after the transition. [ENUM-REF-CANDIDATE: new|under_investigation|escalated|pending_recovery|closed_fraud|closed_no_fraud|referred_to_law_enforcement — promote to reference product]',
    `channel` STRING COMMENT 'Origin channel of the transaction or event that led to the status transition.. Valid values are `web|mobile|pos|api|batch`',
    `compliance_status` STRING COMMENT 'Indicates whether the transition complies with relevant regulatory or internal policies.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this status history record was first inserted into the data store.',
    `fraud_rule_triggered` STRING COMMENT 'Identifier of the fraud rule or model that influenced the status change, if applicable.',
    `investigation_outcome` STRING COMMENT 'Result of the investigation at the time of this transition.. Valid values are `pending|resolved|false_positive|confirmed_fraud`',
    `ip_address` STRING COMMENT 'Source IP address observed for the transaction or event.',
    `is_escalated` BOOLEAN COMMENT 'True if the case was escalated to a higher tier or external authority during this transition.',
    `notes` STRING COMMENT 'Free‑form comments or observations captured at the time of the status transition.',
    `previous_status` STRING COMMENT 'The status of the fraud case before the transition occurred.',
    `regulatory_report_flag` BOOLEAN COMMENT 'True if this status change triggers a regulatory filing (e.g., SAR, STR).',
    `risk_score_at_transition` DECIMAL(18,2) COMMENT 'Fraud risk score associated with the case when the status change was recorded.',
    `sla_deadline_timestamp` TIMESTAMP COMMENT 'Target date‑time by which the status transition should be completed to meet service‑level agreements.',
    `sla_met` BOOLEAN COMMENT 'Indicates whether the transition occurred within the SLA deadline (true) or missed it (false).',
    `source_system` STRING COMMENT 'Name of the operational system that generated the status transition record (e.g., Fraud Detection Platform).',
    `transition_timestamp` TIMESTAMP COMMENT 'Exact date and time when the status change was recorded.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this status history record.',
    CONSTRAINT pk_case_status_history PRIMARY KEY(`case_status_history_id`)
) COMMENT 'Status transition history for a fraud case, recording each status change (new, under investigation, escalated, pending recovery, closed-fraud, closed-no-fraud, referred-to-law-enforcement), the timestamp of the transition, the actor (analyst, automated system), and any status change notes. Enables SLA tracking and case lifecycle audit.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` (
    `fraud_type_id` BIGINT COMMENT 'Unique surrogate key for each fraud type. _canonical_skip_reason: Entity is a reference lookup for fraud classification.',
    `parent_fraud_type_id` BIGINT COMMENT 'Identifier of the parent fraud type for hierarchical classification.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fraud type record was created.',
    `detection_method` STRING COMMENT 'Primary detection technique used for this fraud type.. Valid values are `rule_based|ml_model|behavioral|device_fingerprint|3ds_challenge`',
    `effective_from` DATE COMMENT 'Date when the fraud type definition becomes effective.',
    `effective_until` DATE COMMENT 'Date when the fraud type definition expires (null if indefinite).',
    `fraud_category` STRING COMMENT 'High‑level category grouping similar fraud types. [ENUM-REF-CANDIDATE: card_not_present|card_present|account_takeover|synthetic_identity|merchant_fraud|money_mule|phishing|first_party — 8 candidates stripped; promote to reference product]',
    `fraud_type_code` STRING COMMENT 'Short alphanumeric code representing the fraud type (e.g., CNP for Card-Not-Present).',
    `fraud_type_description` STRING COMMENT 'Detailed description of the fraud scenario and typical characteristics.',
    `fraud_type_name` STRING COMMENT 'Human‑readable name of the fraud type.',
    `fraud_type_status` STRING COMMENT 'Lifecycle status of the fraud type definition.. Valid values are `active|deprecated|pending_review`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the fraud type is currently active in the system.',
    `mitigation_action` STRING COMMENT 'Standard remediation action taken when this fraud type is detected.',
    `payment_channel` STRING COMMENT 'Primary channel where the fraud type is observed.. Valid values are `online|in_store|mobile|atm|pos|mpos`',
    `regulatory_reporting_code` STRING COMMENT 'Code used in regulatory reports (e.g., Visa reason code, Mastercard reason code).',
    `requires_manual_review` BOOLEAN COMMENT 'Indicates if cases of this fraud type automatically trigger manual investigation.',
    `risk_score_weight` DECIMAL(18,2) COMMENT 'Default weight applied to this fraud type in aggregate risk scoring models.',
    `typical_loss_amount` DECIMAL(18,2) COMMENT 'Average monetary loss historically associated with this fraud type.',
    `typical_loss_currency` STRING COMMENT 'ISO 4217 currency code for the typical loss amount.. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fraud type record.',
    CONSTRAINT pk_fraud_type PRIMARY KEY(`fraud_type_id`)
) COMMENT 'Reference classification of fraud types recognized by the platform, including type code, type name (card-not-present, card-present counterfeit, lost-and-stolen, account takeover, synthetic identity, first-party, merchant fraud, money mule, phishing), parent category, applicable payment channel, and regulatory reporting code mapping (e.g., Visa reason code, Mastercard reason code). Used for consistent fraud categorization across cases and reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` (
    `fraud_channel_id` BIGINT COMMENT 'Unique surrogate key for each payment channel used in fraud monitoring.',
    `applicable_rule_categories` STRING COMMENT 'Comma‑separated list of fraud rule categories that apply to this channel (e.g., "velocity|device_fingerprint|geolocation").',
    `average_fraud_rate` DECIMAL(18,2) COMMENT 'Historical average fraud rate for the channel expressed as a proportion (e.g., 0.0125 = 1.25%).',
    `channel_code` STRING COMMENT 'Short, unique alphanumeric code that identifies the payment channel.. Valid values are `^[A-Z0-9_]{3,10}$`',
    `channel_description` STRING COMMENT 'Detailed description of the channels characteristics and typical use cases.',
    `channel_group` STRING COMMENT 'Higher‑level category used to aggregate channels (e.g., "Card", "Bank Transfer", "Digital").',
    `channel_name` STRING COMMENT 'Human‑readable name of the payment channel (e.g., "Card‑Present POS").',
    `channel_type` STRING COMMENT 'Broad classification of the channel (e.g., card‑present, card‑not‑present, ATM, digital wallet, P2P, A2A, ACH, BNPL, QR). [ENUM-REF-CANDIDATE: card_present|card_not_present|atm|digital_wallet|p2p|a2a|ach|bnpl|qr — promote to reference product]',
    `compliance_requirements` STRING COMMENT 'List of regulatory or standards requirements that apply to the channel (e.g., PCI DSS, PSD2).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the channel record was first inserted.',
    `effective_end_date` DATE COMMENT 'Date when the channel definition is retired; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the channel definition becomes active for fraud monitoring.',
    `fraud_channel_status` STRING COMMENT 'Current lifecycle status of the channel definition.. Valid values are `active|inactive|deprecated`',
    `is_3ds_applicable` BOOLEAN COMMENT 'Indicates whether 3‑Domain Secure authentication is supported for the channel.',
    `is_sca_required` BOOLEAN COMMENT 'True if Strong Customer Authentication is mandatory for transactions on this channel.',
    `jurisdiction` STRING COMMENT 'Three‑letter ISO country code indicating the primary regulatory jurisdiction for the channel.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Additional free‑text comments or observations about the channel.',
    `risk_score_weight` DECIMAL(18,2) COMMENT 'Multiplier applied to the channel’s base fraud score to reflect relative risk.',
    `updated_by` STRING COMMENT 'System user or service that performed the latest update.. Valid values are `^[a-zA-Z0-9_]{3,30}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the channel record.',
    `created_by` STRING COMMENT 'System user or service that created the channel record.. Valid values are `^[a-zA-Z0-9_]{3,30}$`',
    CONSTRAINT pk_fraud_channel PRIMARY KEY(`fraud_channel_id`)
) COMMENT 'Reference data defining the payment channels in scope for fraud monitoring (card-present POS, CNP e-commerce, CNP MOTO, ATM, digital wallet, P2P, A2A, ACH, BNPL, QR code). Captures channel code, channel name, applicable fraud rule categories, 3DS applicability flag, SCA requirement flag, and average fraud rate benchmark. Enables channel-specific fraud rule targeting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` (
    `false_positive_review_id` BIGINT COMMENT 'Unique identifier for the false positive review record. _canonical_skip_reason: Entity does not fit standard role categories and is modeled as a custom record.',
    `cardholder_cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder (customer) linked to the transaction.',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder (customer) linked to the transaction.',
    `fraud_case_id` BIGINT COMMENT 'Identifier of the fraud case associated with the alert.',
    `device_fingerprint_id` BIGINT COMMENT 'Identifier of the device fingerprint record associated with the transaction.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partners require a false‑positive review report to assess impact on their transaction volume and risk scores.',
    `employee_id` BIGINT COMMENT 'System identifier of the analyst who performed the review.',
    `fraud_alert_id` BIGINT COMMENT 'Identifier of the fraud alert that was reviewed.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant involved in the transaction.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: False‑positive reviews reference the payment product to assess impact and report product‑level false‑positive rates.',
    `reviewer_employee_id` BIGINT COMMENT 'System identifier of the analyst who performed the review.',
    `transaction_id` BIGINT COMMENT 'Identifier of the transaction that triggered the original alert.',
    `cardholder_name` STRING COMMENT 'Full legal name of the cardholder.',
    `compliance_flag` STRING COMMENT 'Indicates whether the review outcome complies with internal fraud policy and regulatory requirements.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the false positive review record was created in the system.',
    `customer_impact` STRING COMMENT 'Effect of the false positive on the customer, such as a declined legitimate transaction or account freeze.. Valid values are `declined_transaction|account_freeze|none|delayed_settlement`',
    `escalation_reason` STRING COMMENT 'Reason provided for escalating the review.',
    `false_positive_reason_category` STRING COMMENT 'High‑level category describing why the alert was deemed a false positive.. Valid values are `duplicate|test_transaction|low_risk|merchant_error|customer_error|other`',
    `false_positive_reason_detail` STRING COMMENT 'Free‑text explanation providing additional context for the false positive classification.',
    `feedback_action_detail` STRING COMMENT 'Additional details about the corrective action applied.',
    `feedback_action_taken` STRING COMMENT 'Action performed as a result of the false positive review to improve fraud detection (e.g., model tuning).. Valid values are `model_tuning|rule_adjustment|no_action|escalated`',
    `impact_detail` STRING COMMENT 'Narrative description of the specific customer impact experienced.',
    `ip_address` STRING COMMENT 'IP address observed for the transaction.',
    `is_escalated` BOOLEAN COMMENT 'True if the false positive review was escalated to senior fraud management.',
    `jurisdiction_code` STRING COMMENT 'Three‑letter ISO country code of the jurisdiction governing the transaction.. Valid values are `[A-Z]{3}`',
    `original_alert_score` DECIMAL(18,2) COMMENT 'Fraud score value that originally triggered the alert.',
    `original_alert_severity` STRING COMMENT 'Severity level assigned to the original fraud alert.. Valid values are `low|medium|high|critical`',
    `original_alert_timestamp` TIMESTAMP COMMENT 'Date and time when the original fraud alert was generated.',
    `payment_method` STRING COMMENT 'Payment instrument used for the transaction that triggered the alert.. Valid values are `card|bank_transfer|digital_wallet|crypto|cash`',
    `regulatory_report_flag` BOOLEAN COMMENT 'True if the false positive review required regulatory reporting (e.g., SAR filing).',
    `resolution_timestamp` TIMESTAMP COMMENT 'Timestamp when the review was marked as resolved.',
    `review_notes` STRING COMMENT 'Analyst notes captured during the false positive review.',
    `review_outcome` STRING COMMENT 'Result of the review indicating whether the alert was a false positive, true positive, or requires further investigation.. Valid values are `false_positive|true_positive|investigation_continues`',
    `review_status` STRING COMMENT 'Current workflow status of the false positive review.. Valid values are `pending|completed|reopened`',
    `review_timestamp` TIMESTAMP COMMENT 'Date and time when the false positive review was performed.',
    `reviewer_name` STRING COMMENT 'Full name of the analyst who cleared the alert as a false positive.',
    `source_channel` STRING COMMENT 'Channel through which the original transaction was initiated.. Valid values are `online|mobile|pos|api`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the review record.',
    CONSTRAINT pk_false_positive_review PRIMARY KEY(`false_positive_review_id`)
) COMMENT 'Record of a fraud alert or case that was reviewed and determined to be a false positive, capturing the original alert or case reference, the review outcome, the analyst who cleared it, the false positive reason category, the customer impact (declined legitimate transaction, account freeze), and any feedback loop action taken to tune the scoring model or rule. Supports model calibration and customer experience improvement.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`watchlist` (
    `watchlist_id` BIGINT COMMENT 'System-generated unique identifier for each watchlist entry.',
    `watchlist_entry_id` BIGINT COMMENT 'Foreign key linking to compliance.watchlist_entry. Business justification: Fraud detection references the master watchlist maintained by compliance; FK provides authoritative entity details for alerts.',
    `assigned_analyst` STRING COMMENT 'Identifier of the fraud analyst responsible for monitoring this watchlist entry.',
    `contact_method` STRING COMMENT 'Preferred contact channel for the watchlist entity used for notifications or escalations.. Valid values are `email|phone|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the watchlist entry was initially created in the system.',
    `effective_date` DATE COMMENT 'Date when the watchlist entry becomes effective.',
    `entity_identifier` STRING COMMENT 'Unique identifier of the entity (e.g., PAN, MID, device fingerprint, IP address, email domain).',
    `entity_type` STRING COMMENT 'Category of the entity placed on the watchlist (e.g., cardholder, merchant, device, IP range, email domain).. Valid values are `cardholder|merchant|device|ip_range|email_domain`',
    `expiration_date` DATE COMMENT 'Date when the watchlist entry expires or is scheduled for removal.',
    `is_global` BOOLEAN COMMENT 'Indicates whether the watchlist entry applies globally across all jurisdictions.',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code indicating the regulatory jurisdiction relevant to the watchlist entry.. Valid values are `[A-Z]{3}`',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review action performed on the entry.',
    `monitoring_level` STRING COMMENT 'Intensity of monitoring applied to the entity (passive = observation only, active = heightened scrutiny, step_up = requires step‑up authentication).. Valid values are `passive|active|step_up`',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the watchlist entry.',
    `reason` STRING COMMENT 'Business justification for placing the entity on the watchlist (e.g., high velocity, suspicious geography, known fraud pattern).',
    `review_date` DATE COMMENT 'Planned date for the next manual review of the watchlist entry.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk rating assigned to the entity at the time of watchlist inclusion.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the watchlist entry.',
    `watchlist_source` STRING COMMENT 'Origin of the watchlist entry (internal risk team, external network advisory, law‑enforcement notification).. Valid values are `internal|network_advisory|law_enforcement`',
    `watchlist_status` STRING COMMENT 'Current lifecycle status of the watchlist entry.. Valid values are `active|inactive|pending_review`',
    CONSTRAINT pk_watchlist PRIMARY KEY(`watchlist_id`)
) COMMENT 'Watchlist of entities (cardholders, merchants, devices, IP ranges, email domains) under enhanced fraud monitoring without full blocking. Captures entity type, entity identifier, watchlist reason, monitoring level (passive, active, step-up auth required), watchlist source (internal, network advisory, law enforcement), effective date, review date, and assigned analyst. Distinct from blocklist — watchlist entities are monitored but not blocked.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`rule_test` (
    `rule_test_id` BIGINT COMMENT 'Unique identifier for each fraud rule test execution record.',
    `audit_trail_id` BIGINT COMMENT 'Reference to the audit trail entry capturing changes to this test record.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created the test record.',
    `rate_snapshot_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate_snapshot. Business justification: Rule testing uses historical FX rate snapshots to validate rule behavior against real market data.',
    `rule_set_id` BIGINT COMMENT 'Identifier of the rule set applied during the test.',
    `rule_version_id` BIGINT COMMENT 'Identifier of the specific fraud rule version being evaluated.',
    `test_dataset_id` BIGINT COMMENT 'Reference to the dataset (historical or live) used for the simulation.',
    `actual_fraud_loss` DECIMAL(18,2) COMMENT 'Observed monetary loss from fraud during the test period.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the test result was formally approved.',
    `approved_by` BIGINT COMMENT 'User identifier of the person who approved the test.',
    `average_transaction_amount` DECIMAL(18,2) COMMENT 'Mean monetary value of transactions in the test sample.',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance constraints applicable to the test (e.g., PCI DSS, GDPR).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test record was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts in the test.',
    `data_quality_flag` STRING COMMENT 'Assessment of the underlying data quality used for the test.. Valid values are `good|fair|poor`',
    `estimated_false_negative_rate` DECIMAL(18,2) COMMENT 'Projected proportion of fraudulent transactions missed by the rule.',
    `estimated_false_positive_rate` DECIMAL(18,2) COMMENT 'Projected proportion of legitimate transactions incorrectly flagged as fraud.',
    `expected_fraud_loss` DECIMAL(18,2) COMMENT 'Estimated monetary loss from fraud that the rule aims to prevent.',
    `expected_transaction_volume` BIGINT COMMENT 'Projected number of transactions the rule would process if deployed.',
    `financial_impact_estimate` DECIMAL(18,2) COMMENT 'Monetary estimate of the net financial effect (savings vs. loss) if the rule were deployed.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the test record is currently active in the system.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the test execution.',
    `priority` STRING COMMENT 'Business priority assigned to the test (higher value = higher priority).',
    `region_scope` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code(s) indicating geographic coverage of the test.',
    `regulatory_report_flag` BOOLEAN COMMENT 'Indicates whether the test results must be included in regulatory reporting.',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Risk score level that the rule must exceed to trigger a fraud decision during the test.',
    `rule_test_description` STRING COMMENT 'Detailed narrative describing the purpose, design, and expectations of the test.',
    `simulated_hit_rate` DECIMAL(18,2) COMMENT 'Projected proportion of fraudulent transactions correctly identified by the rule during the test.',
    `test_approval_status` STRING COMMENT 'Current approval state of the test result.. Valid values are `pending|approved|rejected`',
    `test_category` STRING COMMENT 'High‑level category of the rule being tested (e.g., velocity, device fingerprint, amount).',
    `test_end_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud rule test execution completed.',
    `test_environment` STRING COMMENT 'Deployment environment where the test was run.. Valid values are `production|staging|dev`',
    `test_execution_mode` STRING COMMENT 'Mode in which the test was executed: live, historical replay, or synthetic data.. Valid values are `live|historical|synthetic`',
    `test_name` STRING COMMENT 'Descriptive name of the fraud rule test scenario.',
    `test_result_summary` STRING COMMENT 'Concise textual summary of test outcomes and key observations.',
    `test_scope` STRING COMMENT 'Narrative of the business scope (e.g., transaction types, payment methods) covered by the test.',
    `test_start_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud rule test execution began.',
    `test_status` STRING COMMENT 'Lifecycle status of the test execution.. Valid values are `draft|running|completed|archived`',
    `test_type` STRING COMMENT 'Classification of the test methodology (A/B, champion‑challenger, baseline).. Valid values are `ab|champion_challenger|baseline`',
    `transaction_sample_size` BIGINT COMMENT 'Number of transactions included in the test dataset.',
    `updated_by` BIGINT COMMENT 'User identifier of the person who last modified the test record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the test record.',
    `version_number` STRING COMMENT 'Version counter for the test record, incremented on each update.',
    CONSTRAINT pk_rule_test PRIMARY KEY(`rule_test_id`)
) COMMENT 'Record of a fraud rule simulation or A/B test run against historical or live transaction data before production deployment. Captures test name, rule version under test, test dataset reference, test period, simulated hit rate, estimated false positive rate, estimated false negative rate, financial impact estimate, and test approval status. Supports safe rule deployment and champion-challenger testing.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`mule_account` (
    `mule_account_id` BIGINT COMMENT 'System-generated unique identifier for the mule account record.',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_case. Business justification: mule_account records should be tied to the fraud case they are associated with for investigation and reporting.',
    `account_type` STRING COMMENT 'Classification of the account based on its underlying payment instrument or ownership model.. Valid values are `personal|business|crypto|prepaid|virtual`',
    `action_taken` STRING COMMENT 'Operational response applied to the mule account after detection.. Valid values are `freeze|close|monitor|none`',
    `contact_email` STRING COMMENT 'Primary email address linked to the mule account for communication and investigation.',
    `contact_phone` STRING COMMENT 'Phone number associated with the mule account, used for verification and outreach.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the mule account record was first created in the data lake.',
    `detection_method` STRING COMMENT 'The process or system that first identified the account as a mule.. Valid values are `transaction_monitoring|manual_review|rule_trigger|ml_model`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date‑time when the mule account was first flagged by the detection system.',
    `display_name` STRING COMMENT 'Human‑readable name associated with the mule account, as provided during onboarding or investigation.',
    `is_blocked` BOOLEAN COMMENT 'True if the account is currently blocked from processing transactions.',
    `is_tokenized` BOOLEAN COMMENT 'Indicates whether the underlying account number has been tokenized (true) or stored in clear (false).',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the primary legal jurisdiction for the mule account.. Valid values are `^[A-Z]{3}$`',
    `last_review_timestamp` TIMESTAMP COMMENT 'Date‑time when the mule account was last reviewed by fraud analysts or compliance.',
    `mule_account_status` STRING COMMENT 'Current lifecycle state of the mule account within the fraud management process.. Valid values are `active|frozen|closed|monitoring|suspended`',
    `mule_category` STRING COMMENT 'Indicates whether the mule is knowingly participating (witting), unaware (unwitting), or a repeat offender (established).. Valid values are `witting|unwitting|established`',
    `notes` STRING COMMENT 'Free‑form text for analyst comments, case details, or additional context.',
    `reporting_status` STRING COMMENT 'Indicates whether a SAR has been filed, law‑enforcement referral made, or no reporting required.. Valid values are `sar_filed|law_enforcement_referred|none`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating (0‑100) assigned to the mule account by fraud scoring models.',
    `risk_score_band` STRING COMMENT 'Categorical bucket derived from the numeric risk score.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Originating operational system that supplied the mule account record.. Valid values are `fraud_detection_platform|aml_system|wallet_platform|crm`',
    `tokenized_account_reference` STRING COMMENT 'Tokenized representation of the account number used by the mule, stored to protect the underlying PAN.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the mule account record.',
    CONSTRAINT pk_mule_account PRIMARY KEY(`mule_account_id`)
) COMMENT 'Record of an identified or suspected money mule account used to receive and transfer fraudulent funds. Captures account identifier (tokenized), account type, mule category (witting, unwitting, established), detection method, linked fraud cases, reporting status (SAR filed, law enforcement referred), account action taken (freeze, close, monitor), and detection timestamp. Supports AML-fraud convergence investigations.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` (
    `fraud_notification_id` BIGINT COMMENT 'Unique identifier for each outbound fraud notification.',
    `dispute_case_id` BIGINT COMMENT 'Foreign key linking to dispute.case. Business justification: Notifications about fraud events often need to include the related dispute case for customer communication compliance.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partner‑facing notification system delivers fraud case updates; FK needed for routing and audit.',
    `fraud_alert_id` BIGINT COMMENT 'Identifier of the alert that caused the notification.',
    `fraud_case_id` BIGINT COMMENT 'Identifier of the fraud case linked to this notification.',
    `message_template_id` BIGINT COMMENT 'Lookup to the template defining the notification body.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Notifications include product details for stakeholder communication and regulatory filing per product.',
    `created_timestamp` TIMESTAMP COMMENT 'When the notification entry was first persisted.',
    `delivery_attempt_count` STRING COMMENT 'How many times the system tried to send the notification.',
    `delivery_channel` STRING COMMENT 'Medium used to deliver the notification.. Valid values are `sms|email|push|ivr`',
    `delivery_status` STRING COMMENT 'Current state of the notification delivery.. Valid values are `sent|delivered|failed|bounced|pending`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date‑time the notification was dispatched.',
    `fraud_event_timestamp` TIMESTAMP COMMENT 'When the fraudulent activity occurred.',
    `is_critical` BOOLEAN COMMENT 'Marks notifications that require immediate attention.',
    `language_code` STRING COMMENT 'Language in which the notification was composed.. Valid values are `en|es|fr|de|zh|ja`',
    `message_content` STRING COMMENT 'Full textual content delivered to the recipient.',
    `notification_type` STRING COMMENT 'Category of the notification sent to the recipient.. Valid values are `fraud_alert|account_freeze|transaction_decline|reissuance`',
    `originating_system` STRING COMMENT 'Name of the internal service that generated the notification.',
    `priority` STRING COMMENT 'Urgency level of the notification.. Valid values are `high|medium|low`',
    `recipient_email` STRING COMMENT 'Email address used for email channel notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_phone` STRING COMMENT 'Phone number used for SMS or IVR channel notifications.. Valid values are `^+?[0-9]{7,15}$`',
    `recipient_type` STRING COMMENT 'Business entity that receives the notification.. Valid values are `cardholder|merchant|internal`',
    `sla_met` BOOLEAN COMMENT 'True if delivery occurred before SLA target.',
    `sla_target_timestamp` TIMESTAMP COMMENT 'Deadline by which the notification must be delivered to meet SLA.',
    `updated_timestamp` TIMESTAMP COMMENT 'When the notification entry was last modified.',
    CONSTRAINT pk_fraud_notification PRIMARY KEY(`fraud_notification_id`)
) COMMENT 'Outbound notification record sent to a cardholder, merchant, or internal team regarding a fraud event. Captures notification type (fraud alert, account freeze notice, transaction decline explanation, reissuance notice), delivery channel (SMS, email, push, IVR), recipient type, delivery status, delivery timestamp, and the triggering fraud case or alert reference. Supports customer communication compliance and SLA tracking.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` (
    `loss_allocation_id` BIGINT COMMENT 'Primary key for the fraud_loss_allocation association',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to the fraud case',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to the GL account',
    `gross_loss_amount` DECIMAL(18,2) COMMENT 'Total loss amount before recoveries',
    `loss_category` STRING COMMENT 'Category of the loss (e.g., chargeback, reserve)',
    `loss_currency` STRING COMMENT 'Currency of the loss amounts',
    `loss_occurrence_timestamp` TIMESTAMP COMMENT 'Timestamp when the loss posting was recorded',
    `loss_reference_number` STRING COMMENT 'Business reference for the loss posting',
    `loss_status` STRING COMMENT 'Current status of the loss posting (e.g., pending, posted)',
    `net_loss_amount` DECIMAL(18,2) COMMENT 'Net loss after recoveries',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Amount recovered from the fraudster or merchant',
    `recovery_method` STRING COMMENT 'Method used to recover the loss (e.g., chargeback, settlement)',
    CONSTRAINT pk_loss_allocation PRIMARY KEY(`loss_allocation_id`)
) COMMENT 'Represents the allocation of a fraud loss from a fraud_case to a GL account. Each record captures the specific loss posting details that belong to the relationship, linking one fraud_case to one gl_account.. Existence Justification: Each fraud case may generate a financial loss that is posted to one or more general‑ledger expense accounts. The organization records each posting with details such as loss amount, currency, and recovery method, creating a many‑to‑many linkage. Conversely, a GL account can receive loss postings from many fraud cases.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`case_payment_link` (
    `case_payment_link_id` BIGINT COMMENT 'Primary key for the case_payment_link association',
    `cross_border_payment_id` BIGINT COMMENT 'Foreign key linking to the cross‑border payment',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to the fraud case',
    `detection_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment was linked to the fraud case',
    `role` STRING COMMENT 'Role of the payment in the investigation (e.g., primary, supporting, related)',
    CONSTRAINT pk_case_payment_link PRIMARY KEY(`case_payment_link_id`)
) COMMENT 'Association product representing the link between a fraud case and a cross‑border payment. It records when the payment was linked to the case and the role of the payment in the investigation.. Existence Justification: Investigators link multiple cross‑border payments to a single fraud case, and a single payment can be part of multiple fraud investigations. The link is managed as a separate record that captures the detection timestamp and the role of the payment in the investigation.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`audit_trail` (
    `audit_trail_id` BIGINT COMMENT 'Primary key for audit_trail',
    `employee_id` BIGINT COMMENT 'Unique identifier of the user, service account, or system that performed the action.',
    `request_id` BIGINT COMMENT 'Unique ID assigned by the source system to the inbound request.',
    `authentication_session_id` BIGINT COMMENT 'Identifier linking the event to a specific user session.',
    `parent_audit_trail_id` BIGINT COMMENT 'Self-referencing FK on audit_trail (parent_audit_trail_id)',
    `action` STRING COMMENT 'Specific operation that was executed and is being audited.',
    `actor_type` STRING COMMENT 'Denotes whether the actor is a human user, an automated system, or a micro‑service.',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Date‑time when the audit entry was first persisted.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the audit entry.',
    `blocklist_flag` BOOLEAN COMMENT 'True if the event involved a blocklisted entity.',
    `correlation_code` STRING COMMENT 'Identifier used to trace a series of related events across systems.',
    `device_fingerprint` STRING COMMENT 'Unique hash representing the device used in the transaction.',
    `event_payload` STRING COMMENT 'Raw data or JSON payload associated with the event (e.g., request body, response code).',
    `event_source` STRING COMMENT 'Logical identifier of the system, device, or service that emitted the event (e.g., transaction_id, device_id).',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date and time when the audited event happened in the source system.',
    `event_type` STRING COMMENT 'Classification of the event for fraud monitoring and audit purposes.',
    `ip_address` STRING COMMENT 'Source IP address from which the event originated.',
    `location_country_code` STRING COMMENT 'Three‑letter country code representing the geographic origin of the event.',
    `notes` STRING COMMENT 'Additional context or comments recorded by fraud analysts.',
    `outcome` STRING COMMENT 'Indicates whether the action succeeded or failed.',
    `remediation_action` STRING COMMENT 'Description of the corrective step performed after the event.',
    `risk_category` STRING COMMENT 'Qualitative classification of the risk score.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk assessment (0.00‑99.99) assigned to the event.',
    `source_system` STRING COMMENT 'Logical name of the application or service that emitted the audit event.',
    `audit_trail_status` STRING COMMENT 'Lifecycle state of the audit entry within the audit pipeline.',
    `user_agent` STRING COMMENT 'Browser or client identifier from which the request originated.',
    CONSTRAINT pk_audit_trail PRIMARY KEY(`audit_trail_id`)
) COMMENT 'Master reference table for audit_trail. Referenced by audit_trail_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`message_template` (
    `message_template_id` BIGINT COMMENT 'Primary key for message_template',
    `base_message_template_id` BIGINT COMMENT 'Self-referencing FK on message_template (base_message_template_id)',
    `archived_timestamp` TIMESTAMP COMMENT 'Date‑time when the template was archived.',
    `audience_segment` STRING COMMENT 'Logical customer segment for which the template is intended.',
    `body_html` STRING COMMENT 'HTML formatted version of the message content.',
    `body_text` STRING COMMENT 'Plain‑text version of the message content.',
    `channel` STRING COMMENT 'Channel through which the message is sent (e.g., email, SMS, push notification).',
    `compliance_notes` STRING COMMENT 'Free‑form notes from compliance review.',
    `compliance_review_status` STRING COMMENT 'Result of the regulatory compliance review process.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the template record was first created in the system.',
    `default_for_channel` STRING COMMENT 'Channel for which this template serves as the default.',
    `message_template_description` STRING COMMENT 'Detailed description of the purpose and usage scenario of the template.',
    `expiration_time` TIMESTAMP COMMENT 'Date‑time after which the template should no longer be used.',
    `is_active` BOOLEAN COMMENT 'True if the template is currently active for use.',
    `is_archived` BOOLEAN COMMENT 'True if the template has been archived and is read‑only.',
    `is_default` BOOLEAN COMMENT 'True if this template is the default for its channel and language.',
    `language` STRING COMMENT 'ISO language code of the template content.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent compliance review.',
    `last_reviewed_by` BIGINT COMMENT 'System user identifier that performed the last compliance review.',
    `last_used_by` BIGINT COMMENT 'System user identifier that most recently sent the template.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Date‑time when the template was last sent.',
    `modified_by` BIGINT COMMENT 'System user identifier that performed the latest update.',
    `message_template_name` STRING COMMENT 'Human‑readable name of the template used for identification in UI and reporting.',
    `placeholders` STRING COMMENT 'JSON string defining dynamic placeholder tokens used in the template.',
    `priority` STRING COMMENT 'Business priority assigned to the template for processing order.',
    `regulatory_category` STRING COMMENT 'Regulatory domain(s) the template must satisfy.',
    `requires_opt_out` BOOLEAN COMMENT 'True if the message must include an opt‑out mechanism per regulation.',
    `schedule_time` TIMESTAMP COMMENT 'Planned date‑time for automatic dispatch of the template, if applicable.',
    `send_limit` STRING COMMENT 'Maximum number of times the template may be sent within a defined cycle.',
    `message_template_status` STRING COMMENT 'Current lifecycle state of the template.',
    `subject` STRING COMMENT 'Subject line used for email‑type messages.',
    `template_type` STRING COMMENT 'High‑level classification of the template purpose.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the template record.',
    `usage_count` BIGINT COMMENT 'Cumulative number of times the template has been used.',
    `version_notes` STRING COMMENT 'Summary of changes introduced in this version.',
    `version_number` STRING COMMENT 'Sequential version of the template; increments on each change.',
    `created_by` BIGINT COMMENT 'System user identifier that created the template.',
    CONSTRAINT pk_message_template PRIMARY KEY(`message_template_id`)
) COMMENT 'Master reference table for message_template. Referenced by message_template_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`test_dataset` (
    `test_dataset_id` BIGINT COMMENT 'Primary key for test_dataset',
    `derived_from_test_dataset_id` BIGINT COMMENT 'Self-referencing FK on test_dataset (derived_from_test_dataset_id)',
    `compliance_framework` STRING COMMENT 'Regulatory or standards framework applicable to the dataset.',
    `contains_pii` BOOLEAN COMMENT 'True if the dataset includes personally identifiable information.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the dataset record was created in the catalog.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Overall data quality rating (0‑100) assigned after validation.',
    `data_source` STRING COMMENT 'Originating operational system or source that supplied the test data.',
    `dataset_name` STRING COMMENT 'Human‑readable name of the test dataset used in fraud model validation.',
    `dataset_version` STRING COMMENT 'Version identifier of the dataset (e.g., v1.0, v2.1).',
    `test_dataset_description` STRING COMMENT 'Detailed description of the dataset purpose, scope, and contents.',
    `effective_from` DATE COMMENT 'Date from which the dataset version is considered valid for testing.',
    `effective_until` DATE COMMENT 'Date after which the dataset version is no longer valid (nullable).',
    `file_format` STRING COMMENT 'File format of the stored dataset.',
    `file_path` STRING COMMENT 'Storage location (e.g., DBFS, S3) of the dataset file.',
    `is_sample` BOOLEAN COMMENT 'Indicates whether the dataset is a full production sample or a synthetic subset.',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent access to the dataset.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the dataset metadata.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the dataset.',
    `owner_email` STRING COMMENT 'Email address of the business owner responsible for the dataset.',
    `record_count` BIGINT COMMENT 'Number of records contained in the test dataset.',
    `retention_period_days` STRING COMMENT 'Number of days the dataset must be retained before deletion per policy.',
    `sensitivity_level` STRING COMMENT 'Classification of the dataset according to internal data governance.',
    `test_dataset_status` STRING COMMENT 'Current lifecycle status of the dataset.',
    CONSTRAINT pk_test_dataset PRIMARY KEY(`test_dataset_id`)
) COMMENT 'Master reference table for test_dataset. Referenced by test_dataset_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`rule_set` (
    `rule_set_id` BIGINT COMMENT 'Primary key for rule_set',
    `superseded_rule_set_id` BIGINT COMMENT 'Self-referencing FK on rule_set (superseded_rule_set_id)',
    `blocklist_flag` BOOLEAN COMMENT 'True if the rule set references a blocklist of entities (e.g., IPs, cards).',
    `rule_set_code` STRING COMMENT 'Business code used to reference the rule set in external systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule set record was first created in the system.',
    `rule_set_description` STRING COMMENT 'Detailed free‑text description of the rule set purpose and scope.',
    `device_fingerprint_required` BOOLEAN COMMENT 'Indicates whether a device fingerprint must be present for the rule to evaluate.',
    `effective_from` DATE COMMENT 'Date when the rule set becomes operational.',
    `effective_until` DATE COMMENT 'Date when the rule set expires or is retired (null if open‑ended).',
    `max_transactions_per_minute` STRING COMMENT 'Upper limit of allowed transactions for the associated entity within a one‑minute window.',
    `rule_set_name` STRING COMMENT 'Human‑readable name of the fraud rule set.',
    `priority` STRING COMMENT 'Integer indicating execution order; lower numbers run first.',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Minimum fraud risk score that triggers the rule set action.',
    `rule_logic` STRING COMMENT 'Serialized representation of the rule conditions and actions (e.g., JSON, DSL).',
    `rule_type` STRING COMMENT 'Category of the rule set indicating the fraud detection technique it implements.',
    `sca_challenge_required` BOOLEAN COMMENT 'Indicates whether an SCA challenge result must be present.',
    `rule_set_status` STRING COMMENT 'Current lifecycle state of the rule set.',
    `three_ds_required` BOOLEAN COMMENT 'Specifies if 3‑DS authentication outcome is required for rule evaluation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the rule set record.',
    `velocity_window_seconds` STRING COMMENT 'Time window in seconds used for velocity calculations.',
    `version` STRING COMMENT 'Semantic version identifier (e.g., 1.0.3) for change management.',
    CONSTRAINT pk_rule_set PRIMARY KEY(`rule_set_id`)
) COMMENT 'Master reference table for rule_set. Referenced by rule_set_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_fraud_rule_id` FOREIGN KEY (`fraud_rule_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_rule`(`fraud_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_fraud_type_id` FOREIGN KEY (`fraud_type_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_type`(`fraud_type_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_watchlist_id` FOREIGN KEY (`watchlist_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`watchlist`(`watchlist_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ADD CONSTRAINT `fk_fraud_fraud_alert_fraud_rule_id` FOREIGN KEY (`fraud_rule_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_rule`(`fraud_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ADD CONSTRAINT `fk_fraud_fraud_rule_fraud_channel_id` FOREIGN KEY (`fraud_channel_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_channel`(`fraud_channel_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ADD CONSTRAINT `fk_fraud_rule_version_fraud_rule_id` FOREIGN KEY (`fraud_rule_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_rule`(`fraud_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ADD CONSTRAINT `fk_fraud_velocity_breach_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ADD CONSTRAINT `fk_fraud_velocity_breach_fraud_velocity_control_id` FOREIGN KEY (`fraud_velocity_control_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_velocity_control`(`fraud_velocity_control_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ADD CONSTRAINT `fk_fraud_auth_3ds_result_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_fraud_rule_id` FOREIGN KEY (`fraud_rule_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_rule`(`fraud_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ADD CONSTRAINT `fk_fraud_blocklist_entry_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ADD CONSTRAINT `fk_fraud_blocklist_audit_blocklist_entry_id` FOREIGN KEY (`blocklist_entry_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`blocklist_entry`(`blocklist_entry_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ADD CONSTRAINT `fk_fraud_blocklist_audit_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ADD CONSTRAINT `fk_fraud_blocklist_audit_related_fraud_case_id` FOREIGN KEY (`related_fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_rule_set_id` FOREIGN KEY (`rule_set_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`rule_set`(`rule_set_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_audit_trail_id` FOREIGN KEY (`audit_trail_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`audit_trail`(`audit_trail_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ADD CONSTRAINT `fk_fraud_investigation_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_evidence_related_fraud_case_id` FOREIGN KEY (`evidence_related_fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ADD CONSTRAINT `fk_fraud_network_fraud_advisory_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ADD CONSTRAINT `fk_fraud_compromised_credential_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ADD CONSTRAINT `fk_fraud_compromised_credential_related_fraud_case_id` FOREIGN KEY (`related_fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ADD CONSTRAINT `fk_fraud_case_status_history_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ADD CONSTRAINT `fk_fraud_case_status_history_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ADD CONSTRAINT `fk_fraud_fraud_type_parent_fraud_type_id` FOREIGN KEY (`parent_fraud_type_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_type`(`fraud_type_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ADD CONSTRAINT `fk_fraud_false_positive_review_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ADD CONSTRAINT `fk_fraud_false_positive_review_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ADD CONSTRAINT `fk_fraud_false_positive_review_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ADD CONSTRAINT `fk_fraud_rule_test_audit_trail_id` FOREIGN KEY (`audit_trail_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`audit_trail`(`audit_trail_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ADD CONSTRAINT `fk_fraud_rule_test_rule_set_id` FOREIGN KEY (`rule_set_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`rule_set`(`rule_set_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ADD CONSTRAINT `fk_fraud_rule_test_rule_version_id` FOREIGN KEY (`rule_version_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`rule_version`(`rule_version_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ADD CONSTRAINT `fk_fraud_rule_test_test_dataset_id` FOREIGN KEY (`test_dataset_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`test_dataset`(`test_dataset_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ADD CONSTRAINT `fk_fraud_mule_account_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ADD CONSTRAINT `fk_fraud_fraud_notification_fraud_alert_id` FOREIGN KEY (`fraud_alert_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_alert`(`fraud_alert_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ADD CONSTRAINT `fk_fraud_fraud_notification_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ADD CONSTRAINT `fk_fraud_fraud_notification_message_template_id` FOREIGN KEY (`message_template_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`message_template`(`message_template_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` ADD CONSTRAINT `fk_fraud_loss_allocation_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_payment_link` ADD CONSTRAINT `fk_fraud_case_payment_link_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`audit_trail` ADD CONSTRAINT `fk_fraud_audit_trail_parent_audit_trail_id` FOREIGN KEY (`parent_audit_trail_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`audit_trail`(`audit_trail_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`message_template` ADD CONSTRAINT `fk_fraud_message_template_base_message_template_id` FOREIGN KEY (`base_message_template_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`message_template`(`message_template_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`test_dataset` ADD CONSTRAINT `fk_fraud_test_dataset_derived_from_test_dataset_id` FOREIGN KEY (`derived_from_test_dataset_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`test_dataset`(`test_dataset_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_set` ADD CONSTRAINT `fk_fraud_rule_set_superseded_rule_set_id` FOREIGN KEY (`superseded_rule_set_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`rule_set`(`rule_set_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`fraud` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `payments_fintech_ecm`.`fraud` SET TAGS ('dbx_domain' = 'fraud');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `assigned_investigator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `billing_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Billing Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `fraud_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `fraud_type_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `regulatory_report_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `response_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Response Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `routing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `wallet_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Transaction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `watchlist_id` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Fraud Watchlist Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `aml_alert` SET TAGS ('dbx_business_glossary_term' = 'AML Alert Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `blocklist_hit` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Hit Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `blocklist_name` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Name');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Number');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|investigating|escalated|closed|rejected|resolved');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'card_not_present|account_takeover|synthetic_identity|first_party|friendly_fraud|other');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile|pos|api|atm|other');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `chargeback_currency` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Currency Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `chargeback_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'pending|completed|exempt|rejected');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Source');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'real_time_scoring|rule_engine|ml_model|manual_review|external_alert|partner_feed');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Potential Financial Exposure');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `exposure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `exposure_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `fraud_category` SET TAGS ('dbx_business_glossary_term' = 'Fraud Category');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `fraud_category` SET TAGS ('dbx_value_regex' = 'cnp|account_takeover|synthetic|first_party|friendly_fraud|other');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `investigation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `investigation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `is_blocked` SET TAGS ('dbx_business_glossary_term' = 'Account Blocked Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `is_chargeback_flagged` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `is_escalated` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `is_fraudulent` SET TAGS ('dbx_business_glossary_term' = 'Final Fraud Determination');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `is_high_risk` SET TAGS ('dbx_business_glossary_term' = 'High Risk Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `payment_instrument_token` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument Token');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `payment_instrument_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `payment_instrument_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'fraud_confirmed|fraud_dismissed|chargeback_won|chargeback_lost|pending_review|false_positive');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `sar_filed` SET TAGS ('dbx_business_glossary_term' = 'SAR Filed Indicator');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Fraud Severity Level');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical|unknown');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` SET TAGS ('dbx_subdomain' = 'detection_scoring');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Identifier (FA_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `assigned_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst Identifier (ANALYST_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `assigned_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `assigned_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier (CARDHOLDER_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier (CARDHOLDER_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `compliance_aml_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Aml Screening Result Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `cross_border_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Cross Border Payment Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Identifier (DEVICE_FP_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Identifier (CASE_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst Identifier (ANALYST_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `fraud_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Identifier (RULE_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Mcc Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MERCHANT_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `risk_model_id` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning Model Identifier (MODEL_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `response_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Response Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier (TXN_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `wallet_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Transaction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Type (ALERT_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'rule_violation|ml_score|velocity|custom');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `auth_response_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Response Code (AUTH_RC)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel (CHANNEL)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile|pos|atm');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason (DECLINE_REASON)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `decline_reason` SET TAGS ('dbx_value_regex' = 'insufficient_funds|card_stolen|invalid_cvv|exceeds_limit|suspected_fraud|other');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Generation Timestamp (AG_TS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `fraud_alert_status` SET TAGS ('dbx_business_glossary_term' = 'Alert Status (ALERT_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `fraud_alert_status` SET TAGS ('dbx_value_regex' = 'open|reviewed|escalated|closed');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `geo_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City (CITY)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `geo_country` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code (COUNTRY_CODE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `geo_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Source IP Address (IP_ADDR)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `is_fraudulent` SET TAGS ('dbx_business_glossary_term' = 'Fraudulent Indicator (IS_FRAUD)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `model_name` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning Model Name (MODEL_NAME)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'card|bank_transfer|wallet|crypto');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `payment_network` SET TAGS ('dbx_business_glossary_term' = 'Payment Network (PAY_NETWORK)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `payment_network` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|other');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action (REMEDIATION)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `remediation_action` SET TAGS ('dbx_value_regex' = 'block|monitor|investigate|none');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Name (RULE_NAME)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Score Threshold (THRESHOLD)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Alert Severity Level (SEVERITY)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name (SOURCE_SYS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount (TXN_AMT)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp (TXN_TS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `triggered_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score (FRAUD_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_alert` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` SET TAGS ('dbx_subdomain' = 'rule_configuration');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `fraud_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Owner Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `fraud_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Channel Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `primary_fraud_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Owner Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `primary_fraud_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `tertiary_fraud_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `tertiary_fraud_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `wallet_scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `action` SET TAGS ('dbx_business_glossary_term' = 'Rule Action');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `action` SET TAGS ('dbx_value_regex' = 'decline|flag|challenge|review');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `condition_expression` SET TAGS ('dbx_business_glossary_term' = 'Rule Condition Expression');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `fraud_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `fraud_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `is_test_rule` SET TAGS ('dbx_business_glossary_term' = 'Test Rule Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `max_decline_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Decline Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `max_decline_currency` SET TAGS ('dbx_business_glossary_term' = 'Maximum Decline Currency');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rule Notes');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `risk_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Threshold');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Description');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Name');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'velocity|threshold|pattern|blocklist');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Rule Severity');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `velocity_limit` SET TAGS ('dbx_business_glossary_term' = 'Velocity Limit');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `velocity_window_seconds` SET TAGS ('dbx_business_glossary_term' = 'Velocity Window (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Rule Version Number');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` SET TAGS ('dbx_subdomain' = 'rule_configuration');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `rule_version_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Version Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Creator');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `fraud_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `fx_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `rate_margin_config_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Margin Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `action_parameters` SET TAGS ('dbx_business_glossary_term' = 'Action Parameters');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `applies_to_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Applicable Payment Method');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `applies_to_payment_method` SET TAGS ('dbx_value_regex' = 'card|bank_transfer|wallet|crypto|other');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `applies_to_region` SET TAGS ('dbx_business_glossary_term' = 'Applicable Region Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `applies_to_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `applies_to_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `applies_to_transaction_type` SET TAGS ('dbx_value_regex' = 'auth|capture|settlement|refund|chargeback');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `condition_logic` SET TAGS ('dbx_business_glossary_term' = 'Condition Logic');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `deactivation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `is_fallback_rule` SET TAGS ('dbx_business_glossary_term' = 'Fallback Rule Indicator');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `max_amount_per_day` SET TAGS ('dbx_business_glossary_term' = 'Maximum Daily Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `max_transactions_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transactions Per Minute');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `risk_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Threshold');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Name');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `rule_source` SET TAGS ('dbx_business_glossary_term' = 'Rule Source');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `rule_source` SET TAGS ('dbx_value_regex' = 'internal|partner|regulatory');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'velocity|device_fingerprint|3ds_outcome|behavioral|ml_model|custom');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `rule_version_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `rule_version_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `rule_version_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|retired|pending_approval');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'points|percent');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` SET TAGS ('dbx_subdomain' = 'rule_configuration');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `fraud_velocity_control_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Velocity Control ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `notification_template_id` SET TAGS ('dbx_business_glossary_term' = 'Notification Template ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `primary_fraud_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `primary_fraud_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `primary_fraud_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `applicable_channels` SET TAGS ('dbx_business_glossary_term' = 'Applicable Channels');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `applicable_channels` SET TAGS ('dbx_value_regex' = 'cnp|pos|mpos|online|mobile');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `applicable_payment_methods` SET TAGS ('dbx_business_glossary_term' = 'Applicable Payment Methods');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `applicable_payment_methods` SET TAGS ('dbx_value_regex' = 'card|token|digital_wallet|bank_transfer|crypto');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `breach_action` SET TAGS ('dbx_business_glossary_term' = 'Breach Action');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `breach_action` SET TAGS ('dbx_value_regex' = 'block|flag|step_up_auth|alert');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `breach_count` SET TAGS ('dbx_business_glossary_term' = 'Breach Count');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'pci|psd2|none');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `control_code` SET TAGS ('dbx_business_glossary_term' = 'Velocity Control Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Velocity Control Name');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Control Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'count|amount|unique_merchant|unique_device');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `effective_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective End Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `effective_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `fraud_velocity_control_description` SET TAGS ('dbx_business_glossary_term' = 'Control Description');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `fraud_velocity_control_status` SET TAGS ('dbx_business_glossary_term' = 'Control Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `fraud_velocity_control_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `is_global` SET TAGS ('dbx_business_glossary_term' = 'Is Global Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `last_breach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Breach Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Control Priority');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `risk_score_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Weight');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `rule_version` SET TAGS ('dbx_business_glossary_term' = 'Rule Version');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `scope_entity` SET TAGS ('dbx_business_glossary_term' = 'Scope Entity');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `scope_entity` SET TAGS ('dbx_value_regex' = 'cardholder|merchant|bin|device|ip_address|channel');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'transactions|currency');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `window_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Window Duration (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` SET TAGS ('dbx_subdomain' = 'detection_scoring');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `velocity_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Velocity Breach ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `fraud_velocity_control_id` SET TAGS ('dbx_business_glossary_term' = 'Velocity Control ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Mcc Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Action Taken');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `action_taken` SET TAGS ('dbx_value_regex' = 'block|flag|challenge|none');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Action Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'open|resolved|escalated');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `breach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile|pos|mpos|nfc');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'regulatory|internal|none');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `control_name` SET TAGS ('dbx_business_glossary_term' = 'Velocity Control Name');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `control_type` SET TAGS ('dbx_business_glossary_term' = 'Velocity Control Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `control_type` SET TAGS ('dbx_value_regex' = 'count|amount|frequency|value');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `detection_engine` SET TAGS ('dbx_business_glossary_term' = 'Detection Engine');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `detection_engine` SET TAGS ('dbx_value_regex' = 'real_time|batch|ml_model');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Entity Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `entity_reference` SET TAGS ('dbx_business_glossary_term' = 'Entity ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'cardholder|merchant|device|bin|account');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `is_fraudulent` SET TAGS ('dbx_business_glossary_term' = 'Is Fraudulent Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `observed_value` SET TAGS ('dbx_business_glossary_term' = 'Observed Value');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `rule_version` SET TAGS ('dbx_business_glossary_term' = 'Rule Version');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'gateway|processing|fraud_platform|digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'count|currency');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `velocity_breach_description` SET TAGS ('dbx_business_glossary_term' = 'Breach Description');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` SET TAGS ('dbx_subdomain' = 'detection_scoring');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `app_version` SET TAGS ('dbx_business_glossary_term' = 'Application Version');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `blocklist_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `blocklist_source` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Source');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `browser_name` SET TAGS ('dbx_business_glossary_term' = 'Browser Name');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `browser_version` SET TAGS ('dbx_business_glossary_term' = 'Browser Version');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_fingerprint_status` SET TAGS ('dbx_business_glossary_term' = 'Device Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_fingerprint_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|retired');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_fingerprint_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_fingerprint_status` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_label` SET TAGS ('dbx_business_glossary_term' = 'Device Label');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|desktop|pos|mpos|tablet|other');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `fingerprint_hash` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Hash (DFH)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `fingerprint_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `fingerprint_hash` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `first_seen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Seen Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `geo_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `hce_flag` SET TAGS ('dbx_business_glossary_term' = 'Host Card Emulation Flag (HCE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `last_seen_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Seen Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (degrees)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (degrees)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `nfc_capable` SET TAGS ('dbx_business_glossary_term' = 'NFC Capability Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `os_name` SET TAGS ('dbx_business_glossary_term' = 'Operating System Name');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `os_version` SET TAGS ('dbx_business_glossary_term' = 'Operating System Version');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (0‑100)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `user_agent` SET TAGS ('dbx_business_glossary_term' = 'User Agent String');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `user_agent` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `user_agent` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` SET TAGS ('dbx_subdomain' = 'detection_scoring');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `auth_3ds_result_id` SET TAGS ('dbx_business_glossary_term' = '3-D Secure Authentication Result ID (3DS_AUTH_RESULT_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MERCHANT_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID (TXN_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `tertiary_auth_acs_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Access Control Server Transaction ID (ACS_TXN_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `tertiary_auth_acs_transaction_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `tertiary_auth_acs_transaction_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `acquirer_bin` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Bank Identification Number (ACQUIRER_BIN)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount (AMOUNT)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `authentication_attempts` SET TAGS ('dbx_business_glossary_term' = 'Number of Authentication Attempts (AUTH_ATTEMPTS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `authentication_error_code` SET TAGS ('dbx_business_glossary_term' = 'Authentication Error Code (AUTH_ERROR_CODE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `authentication_error_message` SET TAGS ('dbx_business_glossary_term' = 'Authentication Error Message (AUTH_ERROR_MSG)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method (AUTH_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'frictionless|challenge|fallback');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `authentication_status` SET TAGS ('dbx_business_glossary_term' = 'Authentication Status (AUTH_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `authentication_status` SET TAGS ('dbx_value_regex' = 'authenticated|attempted|failed|not_enrolled|error');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `authentication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authentication Event Timestamp (AUTH_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `authentication_value` SET TAGS ('dbx_business_glossary_term' = 'Authentication Value (CAVV/AAV)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `authentication_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `authentication_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `card_scheme` SET TAGS ('dbx_business_glossary_term' = 'Card Scheme (CARD_SCHEME)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `card_scheme` SET TAGS ('dbx_value_regex' = 'VISA|MASTERCARD|AMEX|DISCOVER|JCB|UNIONPAY');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `cardholder_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Cardholder IP Address (CARDHOLDER_IP)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `cardholder_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `cardholder_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `challenge_indicator` SET TAGS ('dbx_business_glossary_term' = 'Challenge Indicator (CHALLENGE_IND)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `challenge_indicator` SET TAGS ('dbx_value_regex' = 'no_challenge|challenge_requested|challenge_mandated');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status of Authentication (COMPLIANCE_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `eci_indicator` SET TAGS ('dbx_business_glossary_term' = 'Electronic Commerce Indicator (ECI)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `eci_indicator` SET TAGS ('dbx_value_regex' = '00|01|02|05|06|07');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score (FRAUD_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `is_successful` SET TAGS ('dbx_business_glossary_term' = 'Overall Authentication Success Flag (IS_SUCCESSFUL)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `issuer_bin` SET TAGS ('dbx_business_glossary_term' = 'Issuer Bank Identification Number (ISSUER_BIN)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `liability_shift` SET TAGS ('dbx_business_glossary_term' = 'Liability Shift Indicator (LIABILITY_SHIFT)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes or Comments (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `processing_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Processing Latency in Milliseconds (LATENCY_MS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Requirement Flag (REG_REPORT_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `risk_decision` SET TAGS ('dbx_business_glossary_term' = 'Risk Decision Outcome (RISK_DECISION)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `risk_decision` SET TAGS ('dbx_value_regex' = 'approve|review|reject');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `sca_exemption_type` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication Exemption Type (SCA_EXEMPTION)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `sca_exemption_type` SET TAGS ('dbx_value_regex' = 'low_value|trusted_beneficiary|transaction_risk_analysis|secure_corporate_payment|delegated_authentication|trusted_third_party');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Authentication Record (SOURCE_SYSTEM)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `three_ds_version` SET TAGS ('dbx_business_glossary_term' = '3-D Secure Protocol Version (3DS_VERSION)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `three_ds_version` SET TAGS ('dbx_value_regex' = '1.0|2.0|2.1|2.2');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` SET TAGS ('dbx_subdomain' = 'detection_scoring');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `fraud_sca_challenge_id` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication (SCA) Challenge ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `fraud_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `gateway3ds_authentication_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway3Ds Authentication Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Identification (TID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `auth_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `challenge_attempt_number` SET TAGS ('dbx_business_glossary_term' = 'SCA Challenge Attempt Number');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `challenge_outcome` SET TAGS ('dbx_business_glossary_term' = 'SCA Challenge Outcome');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `challenge_outcome` SET TAGS ('dbx_value_regex' = 'passed|failed|abandoned');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `challenge_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'SCA Challenge Response Time (ms)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `challenge_status` SET TAGS ('dbx_business_glossary_term' = 'SCA Challenge Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `challenge_status` SET TAGS ('dbx_value_regex' = 'pending|completed|timeout');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SCA Challenge Completion Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `exemption_type` SET TAGS ('dbx_business_glossary_term' = 'SCA Exemption Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `exemption_type` SET TAGS ('dbx_value_regex' = 'low_value|transaction_risk_analysis|trusted_beneficiary|recurring|none');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'SCA Failure Reason');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `idempotency_key` SET TAGS ('dbx_business_glossary_term' = 'Idempotency Key');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `initiation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SCA Challenge Initiation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^((25[0-5]|2[0-4]d|[01]?dd?).){3}(25[0-5]|2[0-4]d|[01]?dd?)$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `is_challenge_abandoned` SET TAGS ('dbx_business_glossary_term' = 'Challenge Abandoned Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `is_challenge_blocked` SET TAGS ('dbx_business_glossary_term' = 'Challenge Blocked Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `is_challenge_exempted` SET TAGS ('dbx_business_glossary_term' = 'Challenge Exempted Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `is_challenge_successful` SET TAGS ('dbx_business_glossary_term' = 'Challenge Successful Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `payment_instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `payment_instrument_type` SET TAGS ('dbx_value_regex' = 'card|bank_account|digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `regulatory_context` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Context');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `regulatory_context` SET TAGS ('dbx_value_regex' = 'psd2|other');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `sca_method` SET TAGS ('dbx_business_glossary_term' = 'SCA Method');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `sca_method` SET TAGS ('dbx_value_regex' = 'otp|biometric|push|knowledge');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|pos|api');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` SET TAGS ('dbx_subdomain' = 'rule_configuration');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `blocklist_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Entry ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Fraud Case ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `block_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Block Reason Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `block_reason_code` SET TAGS ('dbx_value_regex' = 'fraud|risk|regulatory|compliance|partner_advisory|custom');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `blocking_scope` SET TAGS ('dbx_business_glossary_term' = 'Blocking Scope');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `blocking_scope` SET TAGS ('dbx_value_regex' = 'decline|flag|step_up|monitor');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `blocklist_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Entry Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `blocklist_entry_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_removal|expired');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `blocklist_version` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Entry Version');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Block Effective Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Entity Identifier (Tokenized/Hashed)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `entity_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `entity_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'pan|bin|ip_address|email|phone|merchant_mid');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Block Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `is_global` SET TAGS ('dbx_business_glossary_term' = 'Global Block Indicator');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Entry Notes');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Review Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'reviewed|not_reviewed|escalated');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `source_of_addition` SET TAGS ('dbx_business_glossary_term' = 'Source of Blocklist Addition');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `source_of_addition` SET TAGS ('dbx_value_regex' = 'manual|automated_rule|network_advisory|regulatory|partner');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` SET TAGS ('dbx_subdomain' = 'rule_configuration');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `blocklist_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Audit Record Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `blocklist_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Entry Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Fraud Case Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `related_fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Fraud Case Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `blocklist_type` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Item Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `blocklist_type` SET TAGS ('dbx_value_regex' = 'ip|pan|device|token|email|phone');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `blocklist_value` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Item Value');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `blocklist_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `blocklist_value` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Additional Comment');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_value_regex' = 'PCI_DSS|AML|KYC|GDPR');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Event Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'add|modify|remove|expire');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `is_successful` SET TAGS ('dbx_business_glossary_term' = 'Action Success Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Blocklist Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `new_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|pending');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `performed_by` SET TAGS ('dbx_business_glossary_term' = 'Performed By');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `performed_by_role` SET TAGS ('dbx_business_glossary_term' = 'Performer Role');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `performed_by_role` SET TAGS ('dbx_value_regex' = 'analyst|system|automated');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Blocklist Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `previous_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|pending');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'gateway|fraud_platform|compliance_system|digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` SET TAGS ('dbx_subdomain' = 'detection_scoring');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `score_event_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score Event Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `risk_model_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Set Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `wallet_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Transaction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile|pos|atm|api');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Final Decision');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'approved|declined|reviewed|challenged');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `event_source` SET TAGS ('dbx_business_glossary_term' = 'Event Source');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `event_source` SET TAGS ('dbx_value_regex' = 'scoring_engine|rule_engine|ml_model');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `feature_set_hash` SET TAGS ('dbx_business_glossary_term' = 'Feature Set Hash');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `fraud_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `fraud_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `is_blocked` SET TAGS ('dbx_business_glossary_term' = 'Block Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `is_high_risk` SET TAGS ('dbx_business_glossary_term' = 'High Risk Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Scoring Latency (ms)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Fraud Model Version');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'card|bank_transfer|wallet|crypto|cash');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `recommended_action` SET TAGS ('dbx_value_regex' = 'approve|decline|review|challenge');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `regulatory_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `rule_set_version` SET TAGS ('dbx_business_glossary_term' = 'Rule Set Version');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `score_band` SET TAGS ('dbx_business_glossary_term' = 'Score Band');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `score_band` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Investigation ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `audit_trail_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_assigned_investigator_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number (CASE_NUM)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `data_retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `evidence_details` SET TAGS ('dbx_business_glossary_term' = 'Evidence Details');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `evidence_summary` SET TAGS ('dbx_business_glossary_term' = 'Evidence Summary');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|escalated|closed|rejected|suspended');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_business_glossary_term' = 'Investigation Type (TYPE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_type` SET TAGS ('dbx_value_regex' = 'fraud|risk|compliance|dispute');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Investigator Name');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `investigator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `investigator_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `is_privileged` SET TAGS ('dbx_business_glossary_term' = 'Privileged Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `outcome_decision` SET TAGS ('dbx_business_glossary_term' = 'Outcome Decision');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `outcome_decision` SET TAGS ('dbx_value_regex' = 'fraud_confirmed|fraud_not_confirmed|false_positive|escalated');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `outcome_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Outcome Recommendation');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Reporting Jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Investigation Severity');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `sla_compliance` SET TAGS ('dbx_business_glossary_term' = 'SLA Compliance');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `sla_due_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA Due Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `steps` SET TAGS ('dbx_business_glossary_term' = 'Investigation Steps');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Investigation Title');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Evidence Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Related Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Fraud Case Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_related_fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Fraud Case Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Related Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Related Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Related Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `related_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Related Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `access_control_level` SET TAGS ('dbx_business_glossary_term' = 'Access Control Level (ACL)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `access_control_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `admissibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Admissibility Flag (FLAG)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_business_glossary_term' = 'Chain of Custody Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `chain_of_custody_status` SET TAGS ('dbx_value_regex' = 'intact|tampered|pending_review');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp (TS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements (REQ)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `encryption_status` SET TAGS ('dbx_business_glossary_term' = 'Encryption Status (ENCRYPT)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `encryption_status` SET TAGS ('dbx_value_regex' = 'encrypted|plain|unknown');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Evidence Description (DESC)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_source` SET TAGS ('dbx_business_glossary_term' = 'Evidence Source (SOURCE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_source` SET TAGS ('dbx_value_regex' = 'gateway|fraud_platform|digital_wallet|risk_engine|external_source');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_status` SET TAGS ('dbx_value_regex' = 'collected|reviewed|archived|rejected');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Evidence Type (TYPE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_type` SET TAGS ('dbx_value_regex' = 'transaction_record|device_log|cardholder_statement|network_advisory|3ds_result|sca_log');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `file_hash` SET TAGS ('dbx_business_glossary_term' = 'File Hash (HASH)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (BYTES)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Evidence Format (FORMAT)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'json|xml|pdf|csv|binary');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `is_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Indicator (FLAG)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JUR)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = 'US|EU|UK|CA|AU|SG');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `storage_uri` SET TAGS ('dbx_business_glossary_term' = 'Storage URI (URI)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (USER)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (USER)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `loss_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Loss Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^d{4}-Q[1-4]$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Loss Currency');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `gross_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Loss Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `gross_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Loss Jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `loss_category` SET TAGS ('dbx_business_glossary_term' = 'Loss Category');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `loss_category` SET TAGS ('dbx_value_regex' = 'card_present|card_not_present|account_takeover|synthetic_identity|other');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `loss_description` SET TAGS ('dbx_business_glossary_term' = 'Loss Description');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `loss_status` SET TAGS ('dbx_business_glossary_term' = 'Loss Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `loss_status` SET TAGS ('dbx_value_regex' = 'open|under_review|closed|reversed');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `net_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Loss Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `net_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `occurrence_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loss Occurrence Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Recovery Method');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `recovery_method` SET TAGS ('dbx_value_regex' = 'chargeback|insurance|law_enforcement|self_recovery|none');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Loss Reference Number');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = 'FL-d{8}');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `regulatory_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'payment_gateway|settlement|dispute|risk');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` SET TAGS ('dbx_subdomain' = 'detection_scoring');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `network_fraud_advisory_id` SET TAGS ('dbx_business_glossary_term' = 'Network Fraud Advisory ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Case Fraud Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `advisory_description` SET TAGS ('dbx_business_glossary_term' = 'Advisory Description (ADVISORY_DESCRIPTION)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `advisory_severity` SET TAGS ('dbx_business_glossary_term' = 'Advisory Severity (ADVISORY_SEVERITY)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `advisory_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `advisory_severity_score` SET TAGS ('dbx_business_glossary_term' = 'Advisory Severity Score (ADVISORY_SEVERITY_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `advisory_status` SET TAGS ('dbx_business_glossary_term' = 'Advisory Status (ADVISORY_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `advisory_status` SET TAGS ('dbx_value_regex' = 'new|reviewed|actioned|closed');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `advisory_type` SET TAGS ('dbx_business_glossary_term' = 'Advisory Type (ADVISORY_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `advisory_type` SET TAGS ('dbx_value_regex' = 'compromised_bin|compromised_pan_range|merchant_compromise|account_takeover|other');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `affected_entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Identifier (AFFECTED_ENTITY_IDENTIFIER)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `affected_entity_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `affected_entity_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `affected_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Type (AFFECTED_ENTITY_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `affected_entity_type` SET TAGS ('dbx_value_regex' = 'bin|pan|merchant|account');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFFECTIVE_FROM)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFFECTIVE_UNTIL)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number (EXTERNAL_REFERENCE_NUMBER)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `internal_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Internal Action Taken (INTERNAL_ACTION_TAKEN)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `internal_action_taken` SET TAGS ('dbx_value_regex' = 'monitor|block|investigate|escalate|none');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag (IS_ACTIVE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `network_name` SET TAGS ('dbx_business_glossary_term' = 'Network Name (NETWORK_NAME)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `network_name` SET TAGS ('dbx_value_regex' = 'visa|mastercard|discover|amex|other');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp (RECEIPT_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`network_fraud_advisory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` SET TAGS ('dbx_subdomain' = 'detection_scoring');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `compromised_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Compromised Credential Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Fraud Case Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `related_fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Fraud Case Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `compromise_date` SET TAGS ('dbx_business_glossary_term' = 'Compromise Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `compromise_source` SET TAGS ('dbx_business_glossary_term' = 'Compromise Source');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `compromise_source` SET TAGS ('dbx_value_regex' = 'network_advisory|dark_web|internal_detection|partner_report');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `compromised_credential_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `compromised_credential_status` SET TAGS ('dbx_value_regex' = 'open|closed|archived');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `credential_identifier_hash` SET TAGS ('dbx_business_glossary_term' = 'Credential Identifier (Hashed)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `credential_identifier_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `credential_identifier_hash` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_business_glossary_term' = 'Credential Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `credential_type` SET TAGS ('dbx_value_regex' = 'pan|dpan|iban|account_number|token');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'real_time_scoring|batch_analysis|manual_review');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `issuer_code` SET TAGS ('dbx_business_glossary_term' = 'Issuer Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `issuer_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Issuer Notified Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `notification_status` SET TAGS ('dbx_value_regex' = 'pending|sent|failed');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `remediation_action` SET TAGS ('dbx_value_regex' = 'reissue|block|monitor|none');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `remediation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Completion Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `remediation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Remediation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `risk_score_at_compromise` SET TAGS ('dbx_business_glossary_term' = 'Risk Score at Compromise');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`compromised_credential` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `case_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Status History Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `actor` SET TAGS ('dbx_business_glossary_term' = 'Transition Actor');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `actor_type` SET TAGS ('dbx_business_glossary_term' = 'Transition Actor Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `actor_type` SET TAGS ('dbx_value_regex' = 'analyst|automated_system|external_partner');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `case_category` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Category');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `case_category` SET TAGS ('dbx_value_regex' = 'payment_fraud|identity_theft|account_takeover|friendly_fraud|synthetic_identity');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `case_priority` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Priority');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `case_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `case_status_history_status` SET TAGS ('dbx_business_glossary_term' = 'Current Fraud Case Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile|pos|api|batch');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `fraud_rule_triggered` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Triggered');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `investigation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Investigation Outcome');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `investigation_outcome` SET TAGS ('dbx_value_regex' = 'pending|resolved|false_positive|confirmed_fraud');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `is_escalated` SET TAGS ('dbx_business_glossary_term' = 'Escalation Indicator');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Status Change Notes');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Fraud Case Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `regulatory_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `risk_score_at_transition` SET TAGS ('dbx_business_glossary_term' = 'Risk Score at Transition');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `sla_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA Deadline Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `sla_met` SET TAGS ('dbx_business_glossary_term' = 'SLA Met Indicator');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Transition Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_status_history` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` SET TAGS ('dbx_subdomain' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `fraud_type_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `parent_fraud_type_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Fraud Type Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_model|behavioral|device_fingerprint|3ds_challenge');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `fraud_category` SET TAGS ('dbx_business_glossary_term' = 'Fraud Category');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `fraud_type_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `fraud_type_description` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type Description');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `fraud_type_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type Name');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `fraud_type_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `fraud_type_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|pending_review');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `mitigation_action` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Action');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'online|in_store|mobile|atm|pos|mpos');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `regulatory_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `requires_manual_review` SET TAGS ('dbx_business_glossary_term' = 'Requires Manual Review Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `risk_score_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Weight');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `typical_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Typical Loss Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `typical_loss_currency` SET TAGS ('dbx_business_glossary_term' = 'Typical Loss Currency');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `typical_loss_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` SET TAGS ('dbx_subdomain' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `fraud_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Channel Identifier (FRAUD_CHNL_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `applicable_rule_categories` SET TAGS ('dbx_business_glossary_term' = 'Applicable Rule Categories (RULE_CAT)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `average_fraud_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Fraud Rate Benchmark (AVG_FR_RATE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Code (CHNL_CD)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,10}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `channel_description` SET TAGS ('dbx_business_glossary_term' = 'Channel Description (CHNL_DESC)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `channel_group` SET TAGS ('dbx_business_glossary_term' = 'Channel Group (CHNL_GRP)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `channel_name` SET TAGS ('dbx_business_glossary_term' = 'Channel Name (CHNL_NM)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type (CHNL_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements (COMP_REQ)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END_DT)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START_DT)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `fraud_channel_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Status (CHNL_STS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `fraud_channel_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `is_3ds_applicable` SET TAGS ('dbx_business_glossary_term' = '3‑DS Applicability Flag (3DS_APPL)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `is_sca_required` SET TAGS ('dbx_business_glossary_term' = 'SCA Requirement Flag (SCA_REQ)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code (JURIS_CD)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `risk_score_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Weight (RISK_WGT)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User (UPDATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `updated_by` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9_]{3,30}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CREATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_channel` ALTER COLUMN `created_by` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9_]{3,30}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` SET TAGS ('dbx_subdomain' = 'detection_scoring');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `false_positive_review_id` SET TAGS ('dbx_business_glossary_term' = 'False Positive Review ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer (Analyst) ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Original Fraud Alert ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer (Analyst) ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Full Name');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `customer_impact` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `customer_impact` SET TAGS ('dbx_value_regex' = 'declined_transaction|account_freeze|none|delayed_settlement');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `false_positive_reason_category` SET TAGS ('dbx_business_glossary_term' = 'False Positive Reason Category');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `false_positive_reason_category` SET TAGS ('dbx_value_regex' = 'duplicate|test_transaction|low_risk|merchant_error|customer_error|other');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `false_positive_reason_detail` SET TAGS ('dbx_business_glossary_term' = 'False Positive Reason Detail');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `feedback_action_detail` SET TAGS ('dbx_business_glossary_term' = 'Feedback Action Detail');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `feedback_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Feedback Action Taken');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `feedback_action_taken` SET TAGS ('dbx_value_regex' = 'model_tuning|rule_adjustment|no_action|escalated');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `impact_detail` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Detail');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `is_escalated` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction ISO Country Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `original_alert_score` SET TAGS ('dbx_business_glossary_term' = 'Original Alert Fraud Score');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `original_alert_severity` SET TAGS ('dbx_business_glossary_term' = 'Original Alert Severity');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `original_alert_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `original_alert_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Original Alert Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'card|bank_transfer|digital_wallet|crypto|cash');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `regulatory_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Review Outcome');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `review_outcome` SET TAGS ('dbx_value_regex' = 'false_positive|true_positive|investigation_continues');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|completed|reopened');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer (Analyst) Full Name');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `source_channel` SET TAGS ('dbx_value_regex' = 'online|mobile|pos|api');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`false_positive_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` SET TAGS ('dbx_subdomain' = 'detection_scoring');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `watchlist_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Watchlist Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `watchlist_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Entry Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `assigned_analyst` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|none');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Effective Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `entity_identifier` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Entity Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `entity_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `entity_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Entity Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'cardholder|merchant|device|ip_range|email_domain');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Expiration Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `is_global` SET TAGS ('dbx_business_glossary_term' = 'Global Watchlist Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `monitoring_level` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Monitoring Level');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `monitoring_level` SET TAGS ('dbx_value_regex' = 'passive|active|step_up');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Notes');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Reason');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Review Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Risk Score');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `watchlist_source` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Source');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `watchlist_source` SET TAGS ('dbx_value_regex' = 'internal|network_advisory|law_enforcement');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `watchlist_status` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Entry Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `watchlist_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_review');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` SET TAGS ('dbx_subdomain' = 'rule_configuration');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `rule_test_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Test Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `audit_trail_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `rate_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Snapshot Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Set Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `rule_version_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Version Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Test Dataset Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `actual_fraud_loss` SET TAGS ('dbx_business_glossary_term' = 'Actual Fraud Loss');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `average_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|fair|poor');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `estimated_false_negative_rate` SET TAGS ('dbx_business_glossary_term' = 'Estimated False Negative Rate (Percentage)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `estimated_false_positive_rate` SET TAGS ('dbx_business_glossary_term' = 'Estimated False Positive Rate (Percentage)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `expected_fraud_loss` SET TAGS ('dbx_business_glossary_term' = 'Expected Fraud Loss');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `expected_transaction_volume` SET TAGS ('dbx_business_glossary_term' = 'Expected Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Estimate');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Test Priority');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `region_scope` SET TAGS ('dbx_business_glossary_term' = 'Region Scope (ISO Country Code)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `regulatory_report_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `risk_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Threshold');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `rule_test_description` SET TAGS ('dbx_business_glossary_term' = 'Test Description');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `simulated_hit_rate` SET TAGS ('dbx_business_glossary_term' = 'Simulated Hit Rate (Percentage)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Test Approval Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Test Category');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test End Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_environment` SET TAGS ('dbx_business_glossary_term' = 'Test Environment');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_environment` SET TAGS ('dbx_value_regex' = 'production|staging|dev');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_execution_mode` SET TAGS ('dbx_business_glossary_term' = 'Test Execution Mode');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_execution_mode` SET TAGS ('dbx_value_regex' = 'live|historical|synthetic');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_name` SET TAGS ('dbx_business_glossary_term' = 'Test Name');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_result_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Result Summary');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_scope` SET TAGS ('dbx_business_glossary_term' = 'Test Scope Description');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Start Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'draft|running|completed|archived');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'ab|champion_challenger|baseline');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `transaction_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Transaction Sample Size');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_test` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` SET TAGS ('dbx_subdomain' = 'detection_scoring');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `mule_account_id` SET TAGS ('dbx_business_glossary_term' = 'Money Mule Account ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Case Fraud Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Mule Account Type (ACCOUNT_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'personal|business|crypto|prepaid|virtual');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `action_taken` SET TAGS ('dbx_business_glossary_term' = 'Account Action Taken (ACTION_TAKEN)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `action_taken` SET TAGS ('dbx_value_regex' = 'freeze|close|monitor|none');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Mule Account Email Address (CONTACT_EMAIL)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Mule Account Phone Number (CONTACT_PHONE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method (DETECTION_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'transaction_monitoring|manual_review|rule_trigger|ml_model');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp (DETECTION_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `display_name` SET TAGS ('dbx_business_glossary_term' = 'Mule Account Display Name (DISPLAY_NAME)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `display_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `display_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `is_blocked` SET TAGS ('dbx_business_glossary_term' = 'Is Blocked Flag (IS_BLOCKED)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `is_tokenized` SET TAGS ('dbx_business_glossary_term' = 'Is Tokenized Flag (IS_TOKENIZED)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JURISDICTION)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp (LAST_REVIEW_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `mule_account_status` SET TAGS ('dbx_business_glossary_term' = 'Mule Account Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `mule_account_status` SET TAGS ('dbx_value_regex' = 'active|frozen|closed|monitoring|suspended');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `mule_category` SET TAGS ('dbx_business_glossary_term' = 'Mule Category (MULE_CATEGORY)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `mule_category` SET TAGS ('dbx_value_regex' = 'witting|unwitting|established');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Reporting Status (REPORTING_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `reporting_status` SET TAGS ('dbx_value_regex' = 'sar_filed|law_enforcement_referred|none');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Mule Risk Score (RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `risk_score_band` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Band (RISK_SCORE_BAND)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `risk_score_band` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'fraud_detection_platform|aml_system|wallet_platform|crm');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `tokenized_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Tokenized Account Identifier (TOKENIZED_ACCOUNT_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `tokenized_account_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `tokenized_account_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`mule_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `fraud_notification_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Notification ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `fraud_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `message_template_id` SET TAGS ('dbx_business_glossary_term' = 'Message Template ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `delivery_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Delivery Attempt Count');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel (Communication Channel)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'sms|email|push|ivr');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status (Notification Delivery Status)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'sent|delivered|failed|bounced|pending');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp (Notification Delivery Time)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `fraud_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fraud Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Notification Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code (Notification Language)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|ja');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `message_content` SET TAGS ('dbx_business_glossary_term' = 'Message Content (Notification Body)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type (Fraud Notification Type)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'fraud_alert|account_freeze|transaction_decline|reissuance');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `originating_system` SET TAGS ('dbx_business_glossary_term' = 'Originating System (Notification Source System)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Notification Priority');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `recipient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Type (Notification Recipient Type)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `recipient_type` SET TAGS ('dbx_value_regex' = 'cardholder|merchant|internal');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `sla_met` SET TAGS ('dbx_business_glossary_term' = 'SLA Met Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `sla_target_timestamp` SET TAGS ('dbx_business_glossary_term' = 'SLA Target Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_notification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` SET TAGS ('dbx_association_edges' = 'fraud.fraud_case,ledger.gl_account');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` ALTER COLUMN `loss_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Loss Allocation - Fraud Loss Allocation Id');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Loss Allocation - Fraud Case Id');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Loss Allocation - Gl Account Id');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` ALTER COLUMN `gross_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Loss Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` ALTER COLUMN `loss_category` SET TAGS ('dbx_business_glossary_term' = 'Loss Category');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` ALTER COLUMN `loss_currency` SET TAGS ('dbx_business_glossary_term' = 'Loss Currency');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` ALTER COLUMN `loss_occurrence_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loss Posting Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` ALTER COLUMN `loss_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Loss Reference Number');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` ALTER COLUMN `loss_status` SET TAGS ('dbx_business_glossary_term' = 'Loss Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` ALTER COLUMN `net_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Loss Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss_allocation` ALTER COLUMN `recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Recovery Method');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_payment_link` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_payment_link` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_payment_link` SET TAGS ('dbx_association_edges' = 'fraud.fraud_case,fx.cross_border_payment');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_payment_link` ALTER COLUMN `case_payment_link_id` SET TAGS ('dbx_business_glossary_term' = 'Case Payment Link - Case Payment Link Id');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_payment_link` ALTER COLUMN `cross_border_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Case Payment Link - Cross Border Payment Id');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_payment_link` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Payment Link - Fraud Case Id');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_payment_link` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Payment Link - Detection Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_payment_link` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`case_payment_link` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Case Payment Link - Role');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`audit_trail` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`audit_trail` SET TAGS ('dbx_subdomain' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`audit_trail` ALTER COLUMN `audit_trail_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`audit_trail` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`audit_trail` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`audit_trail` ALTER COLUMN `parent_audit_trail_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`audit_trail` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`audit_trail` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`audit_trail` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`audit_trail` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`message_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`message_template` SET TAGS ('dbx_subdomain' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`message_template` ALTER COLUMN `message_template_id` SET TAGS ('dbx_business_glossary_term' = 'Message Template Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`message_template` ALTER COLUMN `base_message_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`test_dataset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`test_dataset` SET TAGS ('dbx_subdomain' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`test_dataset` ALTER COLUMN `test_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Test Dataset Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`test_dataset` ALTER COLUMN `derived_from_test_dataset_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`test_dataset` ALTER COLUMN `owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`test_dataset` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_set` SET TAGS ('dbx_subdomain' = 'rule_configuration');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_set` ALTER COLUMN `rule_set_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Set Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_set` ALTER COLUMN `superseded_rule_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
