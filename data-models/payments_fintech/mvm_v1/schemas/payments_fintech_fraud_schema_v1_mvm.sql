-- Schema for Domain: fraud | Business: Payments Fintech | Version: v1_mvm
-- Generated on: 2026-05-03 21:29:49

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`fraud` COMMENT 'Operational domain for real-time fraud detection, case management, and prevention. Owns fraud scoring rule configurations, velocity controls, device fingerprint records, 3DS authentication outcomes, SCA challenge results, blocklists, and fraud case lifecycle tracking from detection through remediation.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` (
    `fraud_case_id` BIGINT COMMENT 'Unique system-generated identifier for the fraud case record.',
    `application_id` BIGINT COMMENT 'Foreign key linking to merchant.application. Business justification: Application fraud (synthetic merchant identity, falsified onboarding documents) is a distinct fraud case type opened before a merchant_id exists. Acquirers and PayFacs must link fraud cases to the ori',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to transaction.authorization. Business justification: Fraud cases opened at authorization time require direct reference to the triggering authorization record. Fraud investigation and chargeback workflows depend on auth code, AVS/CVV results, and issuer ',
    `bnpl_plan_id` BIGINT COMMENT 'Foreign key linking to product.bnpl_plan. Business justification: Fraud cases on BNPL transactions require direct plan linkage for credit risk assessment, installment fraud pattern detection, early default analysis, and regulatory reporting on consumer credit fraud ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Internal cost allocation of fraud investigation resources is tracked via cost centers for budgeting and performance reporting.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Cross-border fraud cases must track the currency pair involved for regulatory reporting, fraud pattern analysis by corridor, and AML screening requirements specific to high-risk currency pairs.',
    `device_fingerprint_id` BIGINT COMMENT 'Identifier of the device fingerprint record linked to the event.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partner Fraud Risk Dashboard aggregates fraud cases per acquiring partner; linking case to ecosystem_partner enables required reporting.',
    `fraud_rule_id` BIGINT COMMENT 'Identifier of the rule or model that generated the alert.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Regulatory filing and jurisdictional reporting of fraud cases require linking each case to the responsible legal entity.',
    `location_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_location. Business justification: Card scheme fraud reporting (Visa/MC) requires location-level fraud attribution to identify compromised POS terminals or specific store locations. Fraud investigators need to pinpoint which merchant_l',
    `mdr_config_id` BIGINT COMMENT 'Foreign key linking to interchange.mdr_config. Business justification: Acquirers track fraud exposure by MDR configuration to adjust risk-based pricing and negotiate merchant discount rates. Fraud cases directly impact pricing exceptions and contract renewals for high-ri',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant associated with the case.',
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: Fraud cases involve specific parties (cardholders, merchants, counterparties) whose compliance profile (KYC, AML screening, sanctions status) is essential for investigation and regulatory reporting.',
    `payment_credential_id` BIGINT COMMENT 'Foreign key linking to cardholder.payment_credential. Business justification: Compromised credential fraud cases require linking directly to the specific payment credential (tokenized card, biometric) that was compromised. payment_instrument_token is a denormalized string repre',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Required for regulatory fraud reporting and risk scoring that depend on the specific payment product (card, BNPL, A2A) used in the transaction.',
    `payment_txn_id` BIGINT COMMENT 'FK to transaction.payment_txn.payment_txn_id — MUST-HAVE: Enables linking a fraud case to its triggering transaction — essential for fraud investigation, loss calculation, and network reporting.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: Fraud cases on multi-currency transactions require the FX rate applied at transaction time for accurate loss calculation, chargeback amount validation, and regulatory reporting of cross-border fraud e',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_request. Business justification: Investigation reports require linking each fraud case to the original gateway request that initiated the disputed transaction.',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Risk assessment reports require linking each fraud case to the partys risk profile to correlate fraud outcomes with risk scores.',
    `routing_decision_id` BIGINT COMMENT 'Foreign key linking to gateway.routing_decision. Business justification: Case reviews often examine the routing decision that selected the acquirer to understand risk exposure.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Regulatory loss and risk reporting are often aggregated by card scheme; associating each fraud case with its scheme enables accurate reporting.',
    `scheme_invoice_id` BIGINT COMMENT 'Foreign key linking to interchange.scheme_invoice. Business justification: Fraud chargebacks appear as adjustments on scheme invoices. Fraud teams reconcile cases against scheme billing for dispute resolution and to validate chargeback reimbursement fees—required for scheme ',
    `sub_merchant_id` BIGINT COMMENT 'Foreign key linking to merchant.sub_merchant. Business justification: Visa/MC PayFac rules require fraud monitoring and case attribution at the sub-merchant level, not just the parent merchant. PayFac acquirers must report sub-merchant fraud rates separately for complia',
    `transaction_id` BIGINT COMMENT 'Identifier of the transaction that triggered the fraud alert.',
    `type_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_type. Business justification: fraud_case needs a classification of the case type; linking to fraud_type provides hierarchy and risk weighting.',
    `watchlist_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_watchlist. Business justification: fraud_case may reference a watchlist entry that triggered the case; linking to fraud_watchlist enables traceability.',
    `aml_alert` BOOLEAN COMMENT 'Indicates whether the case triggered an AML screening alert.',
    `blocklist_hit` BOOLEAN COMMENT 'True if the entity matched an internal or external blocklist.',
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
    `priority` STRING COMMENT 'Operational priority assigned to the case for handling.. Valid values are `low|medium|high|critical`',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Monetary amount successfully recovered from fraudster or merchant.',
    `resolution_outcome` STRING COMMENT 'Final outcome after case investigation.. Valid values are `fraud_confirmed|fraud_dismissed|chargeback_won|chargeback_lost|pending_review|false_positive`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score generated by scoring models (0‑100).',
    `sar_filed` BOOLEAN COMMENT 'True if a Suspicious Activity Report was filed for this case.',
    `severity_level` STRING COMMENT 'Business‑defined severity rating indicating potential impact.. Valid values are `low|medium|high|critical|unknown`',
    `updated_timestamp` TIMESTAMP COMMENT 'Most recent time the case record was modified.',
    CONSTRAINT pk_fraud_case PRIMARY KEY(`fraud_case_id`)
) COMMENT 'Core operational record representing a fraud investigation lifecycle from initial detection through remediation. Tracks case type (card-not-present, account takeover, synthetic identity, first-party fraud, etc.), case status, assigned investigator, detection source, financial exposure, recovery amount, and resolution outcome. SSOT for fraud case management in the Fraud Detection and Prevention Platform.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`alert` (
    `alert_id` BIGINT COMMENT 'System-generated unique identifier for the fraud alert record.',
    `aml_screening_result_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_aml_screening_result. Business justification: Regulatory reporting requires attaching AML screening results to each fraud alert for audit trails and SAR/STR filing.',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to transaction.authorization. Business justification: Fraud alerts are generated during authorization processing based on auth response codes, AVS/CVV results, and 3DS outcomes. Real-time fraud decisioning systems correlate alerts to specific authorizati',
    `billing_id` BIGINT COMMENT 'Foreign key linking to interchange.billing. Business justification: Fraud alerts trigger billing adjustments and chargeback processing. Fraud operations teams trace alerts to billing cycles for revenue impact analysis and dispute reconciliation—critical for acquirer P',
    `bnpl_plan_id` BIGINT COMMENT 'Foreign key linking to product.bnpl_plan. Business justification: Real-time fraud alerts on BNPL purchases need plan context for velocity checks against plan-specific limits, installment fraud pattern matching, and credit exposure monitoring during transaction autho',
    `cardholder_profile_id` BIGINT COMMENT 'Unique identifier of the cardholder (primary account holder).',
    `cross_border_payment_id` BIGINT COMMENT 'Foreign key linking to fx.cross_border_payment. Business justification: Real‑time fraud alerts for cross‑border payments need the payment ID to fetch transaction details for immediate response.',
    `device_fingerprint_id` BIGINT COMMENT 'Identifier of the device fingerprint record associated with the transaction.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Regulatory and SLA alerts are sent to the partner owning the merchant; linking alerts to partner supports AML/Fraud notification workflow.',
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.network_endpoint. Business justification: Forensic analysis of alerts needs the exact network endpoint that processed the transaction, supporting root‑cause investigations.',
    `fraud_rule_id` BIGINT COMMENT 'Identifier of the rule that triggered the alert, if rule‑based.',
    `location_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant_location. Business justification: Real-time fraud monitoring systems generate alerts at the terminal/location level for geographic clustering analysis and hotspot detection. Fraud operations teams need location-level alert attribution',
    `merchant_id` BIGINT COMMENT 'Unique identifier of the merchant involved in the transaction.',
    `model_id` BIGINT COMMENT 'Identifier of the ML model that produced the fraud score, if applicable.',
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: Fraud alerts are generated for specific parties whose compliance profile (risk tier, PEP status, sanctions screening) determines alert disposition and escalation requirements.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Alerts must reference the payment product to apply product‑specific risk thresholds and generate compliance reports.',
    `payment_txn_id` BIGINT COMMENT 'Foreign key linking to transaction.payment_txn. Business justification: Fraud alerts are generated on payment_txn records during payment processing. fraud_alert.transaction_id links to transaction.transaction but payment_txn carries channel, instrument, and processing-spe',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.rate. Business justification: Fraud alerts on FX transactions need the applied rate to detect rate manipulation fraud, validate converted amounts against market rates, and trigger alerts on suspicious rate deviations.',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_request. Business justification: Alert triage uses the exact gateway request payload to reproduce the event and assess fraud indicators.',
    `response_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_response. Business justification: Linking alerts to the gateway response enables auditors to see the response code and fraud flag that triggered the alert.',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Real-time fraud monitoring systems route alerts to analysts based on entity risk tier (VIP/high-risk get priority SLA). Alert decisioning (auto-block vs manual review) depends on risk profile threshol',
    `sanctions_check_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_check. Business justification: Sanctions screening is executed as part of fraud alert processing; linking records the check result for regulatory filing.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Scheme-specific fraud alert reporting and scheme-mandated notification SLAs (e.g., Visa CAMS, Mastercard SAFE) require direct scheme linkage on fraud_alert. The existing `payment_network` plain-text c',
    `score_event_id` BIGINT COMMENT 'Foreign key linking to fraud.score_event. Business justification: A fraud alert is triggered by a fraud scoring evaluation (score_event). The alerts triggered_score and score_threshold are denormalized copies of data owned by score_event (fraud_score, score_band th',
    `transaction_id` BIGINT COMMENT 'Unique identifier of the transaction that triggered the alert.',
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
    `notes` STRING COMMENT 'Free‑form text notes added by analysts during investigation.',
    `payment_method` STRING COMMENT 'Instrument used for the transaction (e.g., card, bank transfer).. Valid values are `card|bank_transfer|wallet|crypto`',
    `remediation_action` STRING COMMENT 'Recommended action taken by the system or analyst in response to the alert.. Valid values are `block|monitor|investigate|none`',
    `rule_name` STRING COMMENT 'Human‑readable name of the rule that caused the alert.',
    `severity_level` STRING COMMENT 'Business‑defined severity indicating potential impact of the alert.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Name of the upstream system that emitted the alert (e.g., gateway, fraud_engine).',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the transaction in the transaction currency.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Exact time the underlying transaction occurred.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the alert record.',
    CONSTRAINT pk_alert PRIMARY KEY(`alert_id`)
) COMMENT 'Real-time fraud alert generated by the fraud detection engine when a transaction or account activity breaches a scoring threshold or rule condition. Captures alert type, severity level, triggering rule or model identifier, alert status (open, reviewed, escalated, closed), and the associated transaction or account reference. Feeds the case management workflow.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` (
    `fraud_rule_id` BIGINT COMMENT 'System-generated unique identifier for the fraud rule.',
    `bnpl_plan_id` BIGINT COMMENT 'Foreign key linking to product.bnpl_plan. Business justification: BNPL fraud rules (installment velocity limits, early default patterns, credit limit breach detection, application fraud rules) are plan-specific and require direct association for rule configuration a',
    `card_program_id` BIGINT COMMENT 'Foreign key linking to product.card_program. Business justification: Fraud rules are frequently card-program-specific (BIN-based rules, contactless fraud limits, digital wallet authentication requirements, EMV vs. magstripe rules) and require direct program linkage for',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: FX‑specific fraud rules are defined per currency pair; the rule must reference the pair for correct applicability.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Fraud rules are commonly partner-specific in payments fintech (e.g., different risk thresholds for Visa vs Mastercard processors, wallet providers like Apple Pay). Partner-specific fraud controls are ',
    `endpoint_id` BIGINT COMMENT 'Foreign key linking to network.endpoint. Business justification: Fraud rules are operationally scoped to specific network endpoints — stricter thresholds apply on high-risk or cross-border endpoints. Endpoint-specific fraud rule configuration is a named operational',
    `policy_id` BIGINT COMMENT 'Foreign key linking to risk.risk_policy. Business justification: Fraud rules enforce risk policy limits (max transaction amounts, velocity thresholds, exposure caps). Policy changes trigger rule recalibration. Audit and compliance require traceability from rule to ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Each fraud rule is derived from a specific regulatory obligation; linking enables compliance impact analysis and rule audits.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Payment schemes have distinct fraud rule sets; linking rules to scheme_id allows scheme‑specific rule activation and compliance reporting.',
    `txn_type_id` BIGINT COMMENT 'Foreign key linking to transaction.txn_type. Business justification: Fraud rules are scoped to transaction types in real fraud management systems — CNP rules differ from card-present rules, recurring transaction rules differ from one-time payment rules. Fraud rule conf',
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
    `bnpl_plan_id` BIGINT COMMENT 'Foreign key linking to product.bnpl_plan. Business justification: BNPL velocity controls (max applications per day, installment frequency limits, credit exposure velocity) are plan-specific and require direct association for control configuration, breach detection, ',
    `card_program_id` BIGINT COMMENT 'Foreign key linking to product.card_program. Business justification: Velocity controls are card-program-specific (contactless transaction limits, virtual card velocity caps, BIN-level controls, program-specific daily limits) and require direct program linkage for enfor',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Velocity controls often vary by currency pair, requiring a FK to identify the pair for each control.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Velocity controls vary by partner type in real operations (e.g., stricter limits for high-risk processors, different thresholds for issuer vs acquirer partners). Partner-specific velocity limits are e',
    `fraud_rule_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_rule. Business justification: A velocity control is a specific type of fraud rule configuration — it enforces transaction frequency and volume limits that are defined within the fraud rule engine. The rule_version string on fraud_',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Velocity controls vary by product type; linking enables enforcement of product‑specific transaction limits.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to risk.risk_policy. Business justification: Velocity controls operationalize risk policy exposure limits and concentration thresholds. Policy defines max transaction counts/amounts per time window that controls enforce. Regulatory reporting req',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Velocity controls are scheme-specific: Visa and Mastercard mandate different velocity thresholds and compliance windows. Scheme-scoped velocity control configuration is a named compliance and operatio',
    `threshold_id` BIGINT COMMENT 'Foreign key linking to risk.threshold. Business justification: Velocity controls enforce specific threshold values for breach detection. Each control references threshold configuration (value, unit, escalation action). Threshold changes propagate to controls. Ess',
    `txn_type_id` BIGINT COMMENT 'Foreign key linking to transaction.txn_type. Business justification: Velocity controls are configured per transaction type in fraud management platforms — contactless tap limits differ from CNP velocity limits. fraud_velocity_control has applicable_channels but no txn_',
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
    `scope_entity` STRING COMMENT 'Entity to which the velocity limit applies (e.g., individual cardholder, merchant, BIN, device, IP address, or channel).. Valid values are `cardholder|merchant|bin|device|ip_address|channel`',
    `threshold_unit` STRING COMMENT 'Unit of the threshold value: number of transactions or monetary currency.. Valid values are `transactions|currency`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric limit that triggers the breach action; interpreted according to threshold_unit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the control record.',
    `window_duration_seconds` STRING COMMENT 'Length of the rolling time window over which the control is evaluated, expressed in seconds.',
    CONSTRAINT pk_fraud_velocity_control PRIMARY KEY(`fraud_velocity_control_id`)
) COMMENT 'Velocity control configuration defining transaction frequency and volume limits applied per cardholder, merchant, BIN, or device within a rolling time window. Captures control type (count, amount, unique merchant), window duration, threshold value, breach action (block, flag, step-up auth), and applicability scope. Core fraud prevention mechanism for CNP and POS channels.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` (
    `velocity_breach_id` BIGINT COMMENT 'System-generated unique identifier for the velocity control breach event.',
    `alert_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_alert. Business justification: A velocity breach event triggers a fraud alert when the breach threshold is exceeded. Linking velocity_breach to the resulting fraud_alert closes the operational loop between breach detection and aler',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to transaction.authorization. Business justification: Velocity breaches are detected during authorization processing. Fraud teams need to identify which authorization triggered a velocity breach to analyze decline reasons and tune velocity controls. Auth',
    `device_fingerprint_id` BIGINT COMMENT 'Unique identifier of the device fingerprint used in risk assessment.',
    `event_id` BIGINT COMMENT 'Foreign key linking to risk.risk_event. Business justification: Velocity breaches are material risk events that feed enterprise risk dashboards, exposure monitoring, and regulatory reporting (operational risk capital). Risk event aggregation requires linking breac',
    `fraud_velocity_control_id` BIGINT COMMENT 'Identifier of the velocity control rule that was breached.',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.request. Business justification: Velocity breaches are detected during real-time request processing. Linking to the originating gateway request is essential for breach remediation, merchant notification of blocked transactions, regul',
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
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Device fingerprints are tracked per partner ecosystem in practice (e.g., different wallet providers like Google Pay, Samsung Pay have distinct device profiles). Partner-specific device risk profiling ',
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
    `authorization_id` BIGINT COMMENT 'Foreign key linking to transaction.authorization. Business justification: 3DS authentication results are produced as part of the authorization flow. PSD2 SCA compliance reporting requires linking 3DS outcomes to the specific authorization record. Payments experts universall',
    `card_program_id` BIGINT COMMENT 'Foreign key linking to product.card_program. Business justification: 3DS authentication results are card-program-specific (different programs have different SCA requirements, liability shift rules, exemption eligibility) and require direct program linkage for authentic',
    `device_fingerprint_id` BIGINT COMMENT 'Foreign key linking to fraud.device_fingerprint. Business justification: auth_3ds_result stores device fingerprint as a string; linking to device_fingerprint table normalizes device data and removes redundant column.',
    `fraud_sca_challenge_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_sca_challenge. Business justification: A 3DS authentication result is the outcome of an SCA challenge process. The fraud_sca_challenge record captures the challenge initiation and method, while auth_3ds_result captures the authentication o',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.request. Business justification: 3DS authentication results are generated from gateway authentication requests. Critical for SCA compliance tracking, linking authentication outcomes to originating API requests. Required for PSD2 audi',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant involved in the transaction.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: 3DS authentication results must meet PSD2 SCA regulatory obligations for liability shift and exemption handling. Essential for regulatory compliance reporting and scheme rule adherence.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: 3DS authentication is scheme-specific (Visa Secure, Mastercard Identity Check). Scheme-level 3DS compliance reporting, liability shift analysis, and ECI indicator interpretation require direct scheme ',
    `acquirer_bin` STRING COMMENT 'BIN of the acquiring bank that processed the transaction.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount of the transaction associated with this 3DS authentication.',
    `authentication_attempts` STRING COMMENT 'Count of how many authentication attempts were made for this transaction.',
    `authentication_error_code` STRING COMMENT 'Standardized error code returned when authentication fails.',
    `authentication_error_message` STRING COMMENT 'Human‑readable error message describing the authentication failure.',
    `authentication_method` STRING COMMENT 'Method used for authentication: frictionless, challenge, or fallback.. Valid values are `frictionless|challenge|fallback`',
    `authentication_status` STRING COMMENT 'Outcome of the 3-D Secure authentication attempt.. Valid values are `authenticated|attempted|failed|not_enrolled|error`',
    `authentication_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the 3-D Secure authentication event occurred.',
    `authentication_value` DECIMAL(18,2) COMMENT 'Cryptographic authentication value returned by the ACS (CAVV for 3DS 1.x, AAV for 3DS 2.x).',
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
    `card_program_id` BIGINT COMMENT 'Foreign key linking to product.card_program. Business justification: SCA challenges are card-program-specific (contactless exemptions, digital wallet authentication flows, program-level SCA policies) and require direct program association for challenge configuration, e',
    `device_fingerprint_id` BIGINT COMMENT 'Foreign key linking to fraud.device_fingerprint. Business justification: fraud_sca_challenge stores device fingerprint as a string; linking to device_fingerprint table normalizes device data and removes redundant column.',
    `fraud_rule_id` BIGINT COMMENT 'Identifier of the fraud rule that triggered the SCA challenge.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant involved in the transaction.',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder (customer) subject to the SCA challenge.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: SCA challenges must comply with PSD2 Strong Customer Authentication regulatory obligations. Links authentication events to specific regulatory requirements for exemption validation and audit.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: SCA challenge flows and exemption rules are scheme-mandated under PSD2. Scheme-specific SCA configuration (exemption thresholds, challenge methods, regulatory reporting) requires direct scheme linkage',
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
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Blocklists are commonly maintained per partner in payments (e.g., processor-specific merchant blocklists, acquirer-managed card blocklists). Partner-managed blocklists are standard practice for distri',
    `party_id` BIGINT COMMENT 'Foreign key linking to compliance.party. Business justification: Blocklist entries should reference the compliance party record for the blocked entity to maintain single source of truth for entity risk profile, sanctions status, and PEP screening.',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Blocklist decisions are risk-based; each entry should reference the risk profile that justified the block. Required for audit, customer appeals, periodic review workflows, and regulatory examination o',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Scheme-specific blocklists are a real operational pattern: a BIN or entity may be blocked only on the Visa network but permitted on Mastercard. Scheme-scoped blocklist management enables targeted bloc',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`score_event` (
    `score_event_id` BIGINT COMMENT 'Globally unique identifier for the fraud scoring event record.',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to transaction.authorization. Business justification: Fraud scoring engines evaluate transactions at authorization time. score_event records the fraud score produced during authorization processing. Fraud analytics dashboards and model performance report',
    `bnpl_plan_id` BIGINT COMMENT 'Foreign key linking to product.bnpl_plan. Business justification: Fraud scoring for BNPL transactions requires plan context (credit limit, installment count, interest rate, repayment terms) for accurate risk assessment, credit exposure calculation, and early default',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder (or account holder) involved in the transaction.',
    `device_fingerprint_id` BIGINT COMMENT 'Identifier of the device fingerprint record associated with the transaction.',
    `fraud_rule_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_rule. Business justification: A score event is evaluated against a specific fraud rule configuration. The rule_set_version string on score_event is a denormalized reference to the fraud_rule version. Adding fraud_rule_id creates a',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the transaction.',
    `model_id` BIGINT COMMENT 'Foreign key linking to risk.risk_model. Business justification: Fraud scoring uses a specific risk model; linking enables audit of model version per score event for compliance.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Score events need product context for analytics and to trigger product‑specific actions.',
    `payment_txn_id` BIGINT COMMENT 'Foreign key linking to transaction.payment_txn. Business justification: Fraud scoring engines score payment_txn records directly. score_event.transaction_id links to transaction.transaction but payment_txn is the atomic payment processing record. Fraud analytics and model',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Fraud scoring models incorporate the FX rate at transaction time to assess risk of currency conversion anomalies.',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Scoring events evaluate specific entity risk profiles. Linking enables profile-level score history, trend analysis (score drift detection), model performance monitoring by risk tier, and regulatory mo',
    `transaction_id` BIGINT COMMENT 'Identifier of the transaction that triggered the fraud scoring.',
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
    `score_band` STRING COMMENT 'Categorical band derived from the fraud score for operational handling.. Valid values are `low|medium|high|critical`',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the transaction being evaluated.',
    CONSTRAINT pk_score_event PRIMARY KEY(`score_event_id`)
) COMMENT 'Operational record of a fraud scoring evaluation performed on a transaction or account event. Captures the scoring model identifier, model version, input feature set hash, composite fraud score, score band (low, medium, high, critical), scoring latency in milliseconds, and the recommended action output. This is an OPERATIONAL event record — not an analytics aggregate — representing each real-time scoring invocation.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`investigation` (
    `investigation_id` BIGINT COMMENT 'Unique identifier for the fraud investigation record.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.assessment. Business justification: Investigations produce risk assessments as outcomes (e.g., merchant re-underwriting after fraud incident). Linking investigation to resulting assessment enables audit trail, decision traceability, and',
    `chargeback_id` BIGINT COMMENT 'Foreign key linking to dispute.chargeback. Business justification: Fraud investigations examine specific chargebacks as evidence of fraud patterns or organized fraud rings. Investigators need direct link to chargeback being analyzed, distinct from dispute_case link w',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Fraud investigations frequently involve specific partners (e.g., coordinating with acquiring banks on chargeback investigations, working with processors on dispute resolution). Partner collaboration t',
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
    `chargeback_id` BIGINT COMMENT 'Foreign key linking to dispute.chargeback. Business justification: Fraud investigation evidence (device fingerprints, behavioral analysis, transaction patterns) is directly submitted in chargeback representments. Merchants and acquirers need direct link from fraud ev',
    `device_id` BIGINT COMMENT 'Identifier of the device (e.g., terminal, mobile) that generated the evidence.',
    `fraud_case_id` BIGINT COMMENT 'Identifier of the fraud case to which this evidence belongs.',
    `evidence_package_id` BIGINT COMMENT 'Foreign key linking to dispute.evidence_package. Business justification: Fraud evidence is assembled into dispute evidence packages for chargeback representment. Direct link required for evidence package assembly workflow where fraud investigation artifacts are bundled wit',
    `evidence_related_fraud_case_id` BIGINT COMMENT 'Identifier of the fraud case to which this evidence belongs.',
    `transaction_id` BIGINT COMMENT 'Identifier of the transaction that is the subject of this evidence.',
    `evidence_transaction_id` BIGINT COMMENT 'Identifier of the transaction that is the subject of this evidence.',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to fraud.investigation. Business justification: Evidence artifacts are collected as part of a fraud investigation. While evidence already links to fraud_case, the more granular operational parent is the investigation record (which tracks the invest',
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
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to ledger.accounting_period. Business justification: Losses must be assigned to the correct accounting period for financial close, period-based fraud loss reporting, regulatory filings (PCI DSS Requirement 12.9), and variance analysis. Critical for temp',
    `chargeback_id` BIGINT COMMENT 'Foreign key linking to dispute.chargeback. Business justification: Fraud losses are realized through chargebacks. Finance teams need direct link from loss record to the chargeback that caused it for fraud loss reconciliation, reserve calculation, and regulatory repor',
    `dispute_case_id` BIGINT COMMENT 'Foreign key linking to dispute.case. Business justification: Financial loss records must reference the dispute that generated the loss for regulatory loss‑tracking filings.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Partner Chargeback Reconciliation Report needs to attribute loss amounts to the responsible partner for settlement and liability.',
    `event_id` BIGINT COMMENT 'Foreign key linking to risk.risk_event. Business justification: Realized losses are material risk events triggering risk model recalibration, exposure limit reviews, and regulatory capital calculations (operational risk under Basel). Linking enables loss-based ris',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Financial reporting of fraud loss expense requires posting each loss to a GL expense account for SOX compliance and audit trails.',
    `investigation_id` BIGINT COMMENT 'Foreign key linking to fraud.investigation. Business justification: A financial loss record is quantified and confirmed during a fraud investigation. While loss already links to fraud_case, the investigation record contains the specific outcome_decision and outcome_re',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Fraud losses must reference the specific journal entry recording the write-off or recovery for SOX audit trail, GL reconciliation, and regulatory compliance. Essential accounting control linking fraud',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Losses must be attributed to the specific legal entity bearing the loss for consolidated financial statements, inter-company reconciliation, jurisdiction-specific regulatory reporting, and entity-leve',
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

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`type` (
    `type_id` BIGINT COMMENT 'Unique surrogate key for each fraud type. _canonical_skip_reason: Entity is a reference lookup for fraud classification.',
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
    CONSTRAINT pk_type PRIMARY KEY(`type_id`)
) COMMENT 'Reference classification of fraud types recognized by the platform, including type code, type name (card-not-present, card-present counterfeit, lost-and-stolen, account takeover, synthetic identity, first-party, merchant fraud, money mule, phishing), parent category, applicable payment channel, and regulatory reporting code mapping (e.g., Visa reason code, Mastercard reason code). Used for consistent fraud categorization across cases and reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`fraud`.`watchlist` (
    `watchlist_id` BIGINT COMMENT 'System-generated unique identifier for each watchlist entry.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_fraud_rule_id` FOREIGN KEY (`fraud_rule_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_rule`(`fraud_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_type_id` FOREIGN KEY (`type_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`type`(`type_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ADD CONSTRAINT `fk_fraud_fraud_case_watchlist_id` FOREIGN KEY (`watchlist_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`watchlist`(`watchlist_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_fraud_rule_id` FOREIGN KEY (`fraud_rule_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_rule`(`fraud_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ADD CONSTRAINT `fk_fraud_alert_score_event_id` FOREIGN KEY (`score_event_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`score_event`(`score_event_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ADD CONSTRAINT `fk_fraud_rule_version_fraud_rule_id` FOREIGN KEY (`fraud_rule_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_rule`(`fraud_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ADD CONSTRAINT `fk_fraud_fraud_velocity_control_fraud_rule_id` FOREIGN KEY (`fraud_rule_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_rule`(`fraud_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ADD CONSTRAINT `fk_fraud_velocity_breach_alert_id` FOREIGN KEY (`alert_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`alert`(`alert_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ADD CONSTRAINT `fk_fraud_velocity_breach_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ADD CONSTRAINT `fk_fraud_velocity_breach_fraud_velocity_control_id` FOREIGN KEY (`fraud_velocity_control_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_velocity_control`(`fraud_velocity_control_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ADD CONSTRAINT `fk_fraud_auth_3ds_result_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ADD CONSTRAINT `fk_fraud_auth_3ds_result_fraud_sca_challenge_id` FOREIGN KEY (`fraud_sca_challenge_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge`(`fraud_sca_challenge_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ADD CONSTRAINT `fk_fraud_fraud_sca_challenge_fraud_rule_id` FOREIGN KEY (`fraud_rule_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_rule`(`fraud_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_device_fingerprint_id` FOREIGN KEY (`device_fingerprint_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`device_fingerprint`(`device_fingerprint_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ADD CONSTRAINT `fk_fraud_score_event_fraud_rule_id` FOREIGN KEY (`fraud_rule_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_rule`(`fraud_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_fraud_case_id` FOREIGN KEY (`fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_evidence_related_fraud_case_id` FOREIGN KEY (`evidence_related_fraud_case_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`fraud_case`(`fraud_case_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ADD CONSTRAINT `fk_fraud_evidence_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`investigation`(`investigation_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ADD CONSTRAINT `fk_fraud_loss_investigation_id` FOREIGN KEY (`investigation_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`investigation`(`investigation_id`);
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ADD CONSTRAINT `fk_fraud_type_parent_fraud_type_id` FOREIGN KEY (`parent_fraud_type_id`) REFERENCES `payments_fintech_ecm`.`fraud`.`type`(`type_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`fraud` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `payments_fintech_ecm`.`fraud` SET TAGS ('dbx_domain' = 'fraud');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `bnpl_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Bnpl Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `fraud_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Location Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `mdr_config_id` SET TAGS ('dbx_business_glossary_term' = 'Mdr Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `payment_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Credential Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `routing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Decision Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `scheme_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Invoice Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `sub_merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Sub Merchant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `type_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `watchlist_id` SET TAGS ('dbx_business_glossary_term' = 'Watchlist Fraud Watchlist Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `aml_alert` SET TAGS ('dbx_business_glossary_term' = 'AML Alert Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_case` ALTER COLUMN `blocklist_hit` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Hit Flag');
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
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` SET TAGS ('dbx_subdomain' = 'fraud_detection');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Identifier (FA_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `aml_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Aml Screening Result Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `billing_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `bnpl_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Bnpl Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier (CARDHOLDER_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `cross_border_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Cross Border Payment Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Identifier (DEVICE_FP_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Network Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `fraud_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Identifier (RULE_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Location Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MERCHANT_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Machine Learning Model Identifier (MODEL_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Txn Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `response_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Response Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `sanctions_check_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `score_event_id` SET TAGS ('dbx_business_glossary_term' = 'Score Event Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier (TXN_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Alert Type (ALERT_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'rule_violation|ml_score|velocity|custom');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `auth_response_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Response Code (AUTH_RC)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel (CHANNEL)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|mobile|pos|atm');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason (DECLINE_REASON)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `decline_reason` SET TAGS ('dbx_value_regex' = 'insufficient_funds|card_stolen|invalid_cvv|exceeds_limit|suspected_fraud|other');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Generation Timestamp (AG_TS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `fraud_alert_status` SET TAGS ('dbx_business_glossary_term' = 'Alert Status (ALERT_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `fraud_alert_status` SET TAGS ('dbx_value_regex' = 'open|reviewed|escalated|closed');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `geo_city` SET TAGS ('dbx_business_glossary_term' = 'Geographic City (CITY)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `geo_country` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code (COUNTRY_CODE)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `geo_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Source IP Address (IP_ADDR)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `is_fraudulent` SET TAGS ('dbx_business_glossary_term' = 'Fraudulent Indicator (IS_FRAUD)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Analyst Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'card|bank_transfer|wallet|crypto');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action (REMEDIATION)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `remediation_action` SET TAGS ('dbx_value_regex' = 'block|monitor|investigate|none');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Name (RULE_NAME)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Alert Severity Level (SEVERITY)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name (SOURCE_SYS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount (TXN_AMT)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp (TXN_TS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`alert` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` SET TAGS ('dbx_subdomain' = 'fraud_detection');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `fraud_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `bnpl_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Bnpl Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_rule` ALTER COLUMN `txn_type_id` SET TAGS ('dbx_business_glossary_term' = 'Txn Type Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` SET TAGS ('dbx_subdomain' = 'fraud_detection');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`rule_version` ALTER COLUMN `rule_version_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Version Identifier');
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
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` SET TAGS ('dbx_subdomain' = 'fraud_detection');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `fraud_velocity_control_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Velocity Control ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `bnpl_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Bnpl Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `fraud_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Threshold Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `txn_type_id` SET TAGS ('dbx_business_glossary_term' = 'Txn Type Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `scope_entity` SET TAGS ('dbx_business_glossary_term' = 'Scope Entity');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `scope_entity` SET TAGS ('dbx_value_regex' = 'cardholder|merchant|bin|device|ip_address|channel');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'transactions|currency');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_velocity_control` ALTER COLUMN `window_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Window Duration (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` SET TAGS ('dbx_subdomain' = 'fraud_detection');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `velocity_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Velocity Breach ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `alert_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Event Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `fraud_velocity_control_id` SET TAGS ('dbx_business_glossary_term' = 'Velocity Control ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`velocity_breach` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` SET TAGS ('dbx_subdomain' = 'authentication_review');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`device_fingerprint` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` SET TAGS ('dbx_subdomain' = 'authentication_review');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `auth_3ds_result_id` SET TAGS ('dbx_business_glossary_term' = '3-D Secure Authentication Result ID (3DS_AUTH_RESULT_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `fraud_sca_challenge_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Sca Challenge Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MERCHANT_ID)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`auth_3ds_result` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` SET TAGS ('dbx_subdomain' = 'authentication_review');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `fraud_sca_challenge_id` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication (SCA) Challenge ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `fraud_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`fraud_sca_challenge` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` SET TAGS ('dbx_subdomain' = 'fraud_detection');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `blocklist_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Blocklist Entry ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`blocklist_entry` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` SET TAGS ('dbx_subdomain' = 'fraud_detection');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `score_event_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score Event Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `bnpl_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Bnpl Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `device_fingerprint_id` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `fraud_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `payment_txn_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Txn Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
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
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `score_band` SET TAGS ('dbx_business_glossary_term' = 'Score Band');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `score_band` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`score_event` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Investigation ID');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`investigation` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `device_id` SET TAGS ('dbx_business_glossary_term' = 'Related Device Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Fraud Case Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_package_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Package Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_related_fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Fraud Case Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Related Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `evidence_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Related Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`evidence` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Event Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `investigation_id` SET TAGS ('dbx_business_glossary_term' = 'Investigation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`loss` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
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
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `type_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `parent_fraud_type_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Fraud Type Identifier');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_model|behavioral|device_fingerprint|3ds_challenge');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `fraud_category` SET TAGS ('dbx_business_glossary_term' = 'Fraud Category');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `fraud_type_code` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `fraud_type_description` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type Description');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `fraud_type_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type Name');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `fraud_type_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type Status');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `fraud_type_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|pending_review');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `mitigation_action` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Action');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'online|in_store|mobile|atm|pos|mpos');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `regulatory_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Code');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `requires_manual_review` SET TAGS ('dbx_business_glossary_term' = 'Requires Manual Review Flag');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `risk_score_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Weight');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `typical_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Typical Loss Amount');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `typical_loss_currency` SET TAGS ('dbx_business_glossary_term' = 'Typical Loss Currency');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `typical_loss_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` SET TAGS ('dbx_subdomain' = 'fraud_detection');
ALTER TABLE `payments_fintech_ecm`.`fraud`.`watchlist` ALTER COLUMN `watchlist_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Watchlist Identifier');
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
