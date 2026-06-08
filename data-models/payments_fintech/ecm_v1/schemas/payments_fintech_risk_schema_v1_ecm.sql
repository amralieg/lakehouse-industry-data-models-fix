-- Schema for Domain: risk | Business: Payments Fintech | Version: v1_ecm
-- Generated on: 2026-05-03 18:25:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`risk` COMMENT 'Aggregates enterprise risk scores, underwriting rules, exposure limits, and risk appetite frameworks used for transaction approval decisions and merchant risk profiling. SSOT for risk thresholds, risk models, and risk-based decisioning across the payment lifecycle.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`risk_profile` (
    `risk_profile_id` BIGINT COMMENT 'Unique surrogate key for the risk profile record.',
    `appetite_framework_id` BIGINT COMMENT 'Foreign key linking to risk.risk_appetite_framework. Business justification: Each risk profile aligns to a single risk appetite framework; replace string alignment with FK.',
    `cardholder_profile_id` BIGINT COMMENT 'Foreign key linking to cardholder.cardholder_profile. Business justification: Required to associate each cardholders risk profile used in AML/fraud scoring and regulatory reporting; risk profile is generated per cardholder profile.',
    `compliance_kyc_verification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_kyc_verification. Business justification: Risk profiles incorporate KYC verification results to adjust risk scores per AML regulations.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Risk profile reporting needs authoritative currency metadata for exposure limits; linking to reference.currency enables accurate conversion and compliance.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: Risk scoring per digital wallet for AML/fraud monitoring requires linking each risk_profile to its digital_wallet.',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier of the counterparty (merchant, cardholder, partner, issuer, or acquirer) to which this risk profile belongs.',
    `merchant_id` BIGINT COMMENT 'Foreign key linking to merchant.merchant. Business justification: Regulatory AML/KYC reporting requires linking each merchants risk profile to the merchant record for audit and monitoring.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Required for Partner Risk Profiling report, linking each partners risk profile to its ecosystem partner record for compliance and monitoring.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Required for product‑specific risk profiling used in the Product Risk Tiering report, which assigns risk scores per payment product.',
    `risk_model_id` BIGINT COMMENT 'Identifier of the risk model (e.g., model name or UUID) that produced the risk_score.',
    `risk_policy_id` BIGINT COMMENT 'Identifier of the risk policy governing this profile.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Risk scoring varies by card scheme; risk profiles must reference scheme for compliance reporting and scheme‑specific fraud rules.',
    `aml_score` DECIMAL(18,2) COMMENT 'Score (0‑100) reflecting anti‑money‑laundering risk based on screening and transaction patterns.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Overall compliance rating derived from regulatory checks, KYC, AML, and sanctions results.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk profile record was first created.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Score (0‑100) indicating likelihood of fraudulent activity associated with the counterparty.',
    `kyc_status` STRING COMMENT 'Current status of Know‑Your‑Customer verification.. Valid values are `verified|pending|failed`',
    `last_assessment_date` DATE COMMENT 'Date of the most recent comprehensive risk assessment.',
    `next_review_date` DATE COMMENT 'Planned date for the next scheduled risk review.',
    `party_type` STRING COMMENT 'Classification of the counterparty indicating its role in the payment ecosystem.. Valid values are `merchant|cardholder|partner|issuer|acquirer`',
    `primary_contact_method` STRING COMMENT 'Preferred channel used to reach the counterparty for risk communications.. Valid values are `email|phone|sms|push`',
    `primary_contact_value` DECIMAL(18,2) COMMENT 'Contact detail corresponding to the selected primary_contact_method (e.g., email address or phone number).',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the counterparty is subject to special regulatory reporting.',
    `risk_approval_by` STRING COMMENT 'Identifier of the user or system that performed the risk approval.',
    `risk_approval_required` BOOLEAN COMMENT 'Indicates whether a manual risk approval is required for this counterparty.',
    `risk_approval_status` STRING COMMENT 'Current status of any required risk approval.. Valid values are `approved|rejected|pending`',
    `risk_approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk approval decision was made.',
    `risk_assessment_method` STRING COMMENT 'Technique used to generate the risk score.. Valid values are `rule_based|ml_model|hybrid`',
    `risk_assessment_source` STRING COMMENT 'Origin of the risk assessment data.. Valid values are `real_time|batch|manual`',
    `risk_decision_reason` STRING COMMENT 'Free‑text explanation for the risk decision applied to the counterparty.',
    `risk_exposure_limit` DECIMAL(18,2) COMMENT 'Maximum monetary exposure the organization is willing to accept for this counterparty.',
    `risk_exposure_used` DECIMAL(18,2) COMMENT 'Current monetary exposure incurred by the counterparty.',
    `risk_flags` STRING COMMENT 'Delimited list of risk flags or alerts (e.g., high_velocity|geo_mismatch).',
    `risk_last_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to any risk‑related field.',
    `risk_limit_utilization_pct` DECIMAL(18,2) COMMENT 'Percentage of the risk_exposure_limit that is currently utilized.',
    `risk_model_version` STRING COMMENT 'Version string of the risk model used for scoring.',
    `risk_policy_version` STRING COMMENT 'Version of the risk policy applied to this profile.',
    `risk_profile_status` STRING COMMENT 'Lifecycle status of the risk profile record.. Valid values are `active|archived|deprecated`',
    `risk_review_notes` STRING COMMENT 'Analyst comments and observations from the latest risk review.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score (0‑100) derived from underwriting models, fraud signals, AML checks, and other risk inputs.',
    `risk_score_timestamp` TIMESTAMP COMMENT 'Date‑time when the current risk_score was calculated.',
    `risk_tier` STRING COMMENT 'Risk tier derived from risk_score thresholds used for decisioning and monitoring.. Valid values are `low|medium|high|critical`',
    `sanction_status` STRING COMMENT 'Result of sanctions list screening for the counterparty.. Valid values are `clear|matched|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `version` STRING COMMENT 'Monotonically increasing version number for optimistic concurrency control.',
    CONSTRAINT pk_risk_profile PRIMARY KEY(`risk_profile_id`)
) COMMENT 'Master record for each counterparty (merchant, cardholder, partner) capturing aggregated risk scores, risk tier classification, risk appetite alignment, and overall risk posture. SSOT for entity-level risk assessment used in underwriting, authorization decisioning, and ongoing portfolio monitoring.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` (
    `appetite_framework_id` BIGINT COMMENT 'System-generated unique identifier for the risk appetite framework record.',
    `employee_id` BIGINT COMMENT 'User or system identifier that created the framework record.',
    `appetite_framework_description` STRING COMMENT 'Free‑form textual description of the frameworks purpose, scope, and methodology.',
    `approval_date` DATE COMMENT 'Date on which the framework received formal approval.',
    `approved_by` STRING COMMENT 'User or committee identifier that approved the framework.',
    `classification_or_type` STRING COMMENT 'Category of the framework indicating the primary risk dimension it governs.. Valid values are `transaction|merchant|product|geography|counterparty`',
    `compliance_status` STRING COMMENT 'Overall compliance posture of the framework against internal policies and external regulations.. Valid values are `compliant|non_compliant|under_review`',
    `concentration_limit_percent` DECIMAL(18,2) COMMENT 'Maximum allowed concentration as a percentage of total exposure.',
    `counterparty_segment` STRING COMMENT 'Segment of counterparties (e.g., consumer, enterprise) covered by the framework.. Valid values are `consumer|small_business|enterprise|government|non_profit`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the framework record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the framework becomes operationally effective.',
    `effective_until` DATE COMMENT 'Date when the framework expires or is superseded; null if open‑ended.',
    `exposure_limit_amount` DECIMAL(18,2) COMMENT 'Maximum aggregate exposure permitted under the framework.',
    `exposure_limit_currency` STRING COMMENT 'Currency for the exposure limit amount.. Valid values are `^[A-Z]{3}$`',
    `framework_code` STRING COMMENT 'Business identifier or code used to reference the framework in external systems.',
    `framework_name` STRING COMMENT 'Descriptive name of the risk appetite framework as used by the risk committee.',
    `framework_version` STRING COMMENT 'Version identifier for the framework, following semantic versioning (e.g., v1.0).. Valid values are `^vd+.d+$`',
    `geography` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code or region identifier for the frameworks applicability.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the framework.. Valid values are `draft|active|suspended|retired|pending`',
    `max_loss_amount` DECIMAL(18,2) COMMENT 'Absolute monetary loss limit that the organization is willing to tolerate for the defined scope.',
    `max_loss_currency` STRING COMMENT 'ISO 4217 currency code for the maximum loss amount.. Valid values are `^[A-Z]{3}$`',
    `monitoring_frequency` STRING COMMENT 'How often the frameworks limits are monitored and reported.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `next_review_date` DATE COMMENT 'Planned date for the next formal review of the framework.',
    `notes` STRING COMMENT 'Additional remarks, exceptions, or operational notes related to the framework.',
    `product_line` STRING COMMENT 'Business product line or service to which the framework is scoped.. Valid values are `payments|digital_wallet|merchant_acquiring|cross_border|p2p|b2b`',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates whether regulatory sign‑off is required for this framework.',
    `regulatory_approval_status` STRING COMMENT 'Current status of any required regulatory approval.. Valid values are `not_required|pending|approved|rejected`',
    `review_cycle` STRING COMMENT 'Scheduled interval for formal review of the framework.. Valid values are `quarterly|semi_annual|annual`',
    `risk_capacity_amount` DECIMAL(18,2) COMMENT 'Total risk capacity the organization can absorb for the defined scope.',
    `risk_capacity_currency` STRING COMMENT 'Currency for the risk capacity amount.. Valid values are `^[A-Z]{3}$`',
    `risk_category` STRING COMMENT 'High‑level risk domain that the appetite limits apply to.. Valid values are `credit|operational|market|liquidity|compliance|strategic`',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Score value above which transactions are flagged for additional review.',
    `risk_score_type` STRING COMMENT 'Type of risk score used in the threshold definition.. Valid values are `credit_score|fraud_score|behavior_score|custom_score`',
    `risk_weight` DECIMAL(18,2) COMMENT 'Weight applied to the risk factor when calculating aggregate risk exposure.',
    `tolerance_band` STRING COMMENT 'Qualitative band indicating the severity of tolerance (e.g., low, medium).. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the framework record.',
    CONSTRAINT pk_appetite_framework PRIMARY KEY(`appetite_framework_id`)
) COMMENT 'Defines the enterprise risk appetite thresholds, tolerance bands, and risk capacity limits approved by the risk committee. Captures maximum acceptable loss levels, exposure concentration limits, and risk-reward parameters by product line, geography, and counterparty segment. Governs all downstream risk decisioning rules and underwriting policies.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` (
    `underwriting_policy_id` BIGINT COMMENT 'System‑generated unique identifier for the underwriting policy record.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Underwriting policies are defined per card scheme; linking enables scheme‑aware merchant onboarding and policy enforcement.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether transactions exceeding thresholds require manual underwriting approval.',
    `compliance_requirements` STRING COMMENT 'Textual summary of regulatory and internal compliance obligations tied to the policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the policy record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary limits defined in the policy.',
    `effective_end_date` DATE COMMENT 'Date on which the policy expires or is terminated; null for open‑ended policies.',
    `effective_start_date` DATE COMMENT 'Date on which the policy becomes binding.',
    `max_merchant_discount_rate` DECIMAL(18,2) COMMENT 'Upper bound on the merchant discount rate (MDR) that can be applied under this policy.',
    `mcc_allowed` STRING COMMENT 'Comma‑separated list of MCCs that the merchant is permitted to process under this policy.',
    `mcc_blocked` STRING COMMENT 'Comma‑separated list of MCCs that are prohibited for the merchant under this policy.',
    `policy_code` STRING COMMENT 'External business code or number used to reference the policy in contracts and communications.',
    `policy_description` STRING COMMENT 'Detailed description of the policy purpose, scope and applicable merchant segments.',
    `policy_name` STRING COMMENT 'Human‑readable name of the underwriting policy.',
    `policy_owner` STRING COMMENT 'Business unit or team responsible for maintaining the policy.',
    `policy_review_date` DATE COMMENT 'Scheduled date for periodic review and re‑certification of the policy.',
    `policy_type` STRING COMMENT 'Category of the policy based on the type of entity it governs.. Valid values are `merchant|acquirer|partner|digital_wallet`',
    `regulatory_approval_status` STRING COMMENT 'Current status of required regulator sign‑off for the policy.. Valid values are `approved|pending|rejected`',
    `reserve_rate` DECIMAL(18,2) COMMENT 'Percentage of transaction amount held as a reserve to mitigate chargeback risk.',
    `risk_appetite_category` STRING COMMENT 'Business‑defined risk appetite tier that the policy aligns with.. Valid values are `low|medium|high`',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Maximum risk score a merchant may have to qualify under this policy.',
    `rolling_reserve_rate` DECIMAL(18,2) COMMENT 'Dynamic reserve percentage that can adjust based on merchant performance trends.',
    `tpv_threshold` DECIMAL(18,2) COMMENT 'Maximum total payment volume (in policy currency) a merchant may reach before additional review is required.',
    `transaction_amount_limit` DECIMAL(18,2) COMMENT 'Maximum cumulative monetary value of transactions permitted under the policy for the defined period.',
    `transaction_volume_limit` BIGINT COMMENT 'Maximum number of transactions allowed per defined period (e.g., per month).',
    `underwriting_decision_logic` STRING COMMENT 'Reference to the algorithmic model or rule set used for automated decisions.',
    `underwriting_policy_status` STRING COMMENT 'Current lifecycle status of the policy.. Valid values are `active|inactive|pending|suspended|retired`',
    `underwriting_rules_version` STRING COMMENT 'Version identifier of the rule set applied by this policy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the policy record.',
    CONSTRAINT pk_underwriting_policy PRIMARY KEY(`underwriting_policy_id`)
) COMMENT 'Defines underwriting rules, eligibility criteria, and approval conditions for merchant onboarding, credit extension, and payment product access. Captures MCC-based restrictions, TPV thresholds, reserve requirements, rolling reserve rates, and risk-based pricing parameters. Used by the Merchant Management System and Risk and Compliance Management System to automate underwriting decisions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`risk_rule` (
    `risk_rule_id` BIGINT COMMENT 'Unique system-generated identifier for the risk decisioning rule.',
    `rule_config_id` BIGINT COMMENT 'Foreign key linking to dispute.rule_config. Business justification: Each risk rule can be mapped to a specific dispute rule configuration used by the dispute engine.',
    `employee_id` BIGINT COMMENT 'Team or individual responsible for the rules maintenance.',
    `fraud_rule_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_rule. Business justification: Some risk rules are also fraud rules; linking supports unified rule governance and cross‑domain impact analysis.',
    `mcc_id` BIGINT COMMENT 'Foreign key linking to reference.mcc. Business justification: Rule engine evaluates transaction MCCs; FK to reference.mcc provides standardized category and risk score for rule evaluation.',
    `network_routing_rule_id` BIGINT COMMENT 'Foreign key linking to network.network_routing_rule. Business justification: Specific routing rules may have associated risk rules for fraud checks; FK ties risk rule to the routing rule it governs.',
    `regulatory_jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_jurisdiction. Business justification: Compliance reporting requires mapping rule regulatory references to official jurisdiction records.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory compliance requires each risk rule to be traceable to its governing regulatory obligation for audit and reporting.',
    `risk_model_id` BIGINT COMMENT 'Identifier of the risk scoring model that utilizes this rule.',
    `transaction_type_id` BIGINT COMMENT 'Foreign key linking to reference.transaction_type. Business justification: Risk rules often depend on transaction type; FK ensures consistent type codes for scoring and audit.',
    `action` STRING COMMENT 'Automated action taken when the rule condition is met.. Valid values are `approve|decline|review|hold`',
    `applicable_channel` STRING COMMENT 'Payment channel (e.g., online, mobile, POS) where the rule is evaluated.. Valid values are `online|mobile|pos|atm|api`',
    `applicable_region` STRING COMMENT 'Three‑letter country code indicating geographic scope of the rule.. Valid values are `^[A-Z]{3}$`',
    `audit_notes` STRING COMMENT 'Free‑text notes for audit or change‑management purposes.',
    `compliance_status` STRING COMMENT 'Current compliance state of the rule with its referenced regulation.. Valid values are `compliant|non_compliant|exempt`',
    `concentration_limit` DECIMAL(18,2) COMMENT 'Limit on concentration of transactions to a single merchant or channel.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the rule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code associated with monetary thresholds.. Valid values are `^[A-Z]{3}$`',
    `deprecation_date` DATE COMMENT 'Date on which the rule was officially deprecated.',
    `effective_from` DATE COMMENT 'Date when the rule becomes active for evaluation.',
    `effective_until` DATE COMMENT 'Date when the rule expires or is no longer applied (null if open‑ended).',
    `exposure_limit` DECIMAL(18,2) COMMENT 'Cumulative monetary exposure limit that triggers the rule.',
    `is_compliance_rule` BOOLEAN COMMENT 'Indicates whether the rule enforces regulatory compliance.',
    `is_fraud_rule` BOOLEAN COMMENT 'Indicates whether the rule is part of the fraud detection engine.',
    `last_evaluated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent transaction evaluation against this rule.',
    `logic` STRING COMMENT 'Executable expression or script that defines the rule condition.',
    `max_amount` DECIMAL(18,2) COMMENT 'Upper bound amount for which the rule applies (optional).',
    `min_amount` DECIMAL(18,2) COMMENT 'Lower bound amount for which the rule applies (optional).',
    `parameters` STRING COMMENT 'JSON‑encoded parameter set used by the rule logic.',
    `priority` STRING COMMENT 'Numeric priority used to resolve conflicts when multiple rules fire (higher = higher priority).',
    `retention_period_days` STRING COMMENT 'Number of days the rule definition is retained for audit purposes.',
    `risk_rule_description` STRING COMMENT 'Detailed free‑text description of the rule logic and purpose.',
    `risk_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|deprecated|pending`',
    `risk_score_weight` DECIMAL(18,2) COMMENT 'Weight applied to the rules contribution to the overall risk score (0‑100).',
    `rule_code` STRING COMMENT 'Business identifier or code assigned to the rule for reference in operational systems.',
    `rule_name` STRING COMMENT 'Human‑readable name of the risk rule used for display and reporting.',
    `rule_source` STRING COMMENT 'Originating system that created or manages the rule (e.g., Fraud Detection Platform).',
    `rule_type` STRING COMMENT 'Category of the rule defining the underlying risk model (e.g., velocity, exposure).. Valid values are `velocity|exposure|concentration|behavioral|threshold`',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value (e.g., currency, count, percent).. Valid values are `USD|EUR|GBP|JPY|transactions|percent`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold that must be exceeded for the rule to fire.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the rule record.',
    `velocity_count` STRING COMMENT 'Maximum number of transactions allowed within the velocity window.',
    `velocity_window_seconds` STRING COMMENT 'Time window in seconds over which transaction count is evaluated for velocity rules.',
    `version` STRING COMMENT 'Incremental version number of the rule definition.',
    CONSTRAINT pk_risk_rule PRIMARY KEY(`risk_rule_id`)
) COMMENT 'Risk decisioning rule definitions including rule type (velocity, exposure, concentration, behavioral, threshold-based), evaluation logic, parameterized threshold values, action triggers (approve, decline, review, hold), and rule versioning. Supports real-time transaction rules and batch portfolio rules. Includes threshold configurations that drive automated risk actions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`risk_model` (
    `risk_model_id` BIGINT COMMENT 'Unique surrogate key for each risk scoring model.',
    `region_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_region. Business justification: Risk models are deployed per geographic/ regulatory region; linking model to gateway region supports correct model selection.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Model validation reports must reference the specific regulatory obligation the model addresses, enabling oversight of model compliance.',
    `algorithm` STRING COMMENT 'Machine‑learning algorithm used (e.g., logistic_regression, xgboost, neural_network).',
    `algorithm_parameters` STRING COMMENT 'Serialized hyper‑parameter settings for the algorithm (JSON string).',
    `audit_trail` STRING COMMENT 'Reference or summary of audit events related to model changes.',
    `champion_status` STRING COMMENT 'Indicates whether the model is the champion, challenger, or inactive in the A/B testing framework.. Valid values are `champion|challenger|inactive`',
    `compliance_requirements` STRING COMMENT 'List of compliance controls the model satisfies (e.g., PCI DSS, GDPR).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the model record was first created.',
    `deployment_state` STRING COMMENT 'Current deployment state of the model.. Valid values are `deployed|staged|retired`',
    `deployment_timestamp` TIMESTAMP COMMENT 'Timestamp when the model was deployed to production.',
    `deprecated_flag` BOOLEAN COMMENT 'Indicates if the model is deprecated and should not be used for new decisions.',
    `effective_end_date` DATE COMMENT 'Date when the model ceases to be effective (nullable for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the model becomes effective for decisioning.',
    `exposure_limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary exposure allowed under this model.',
    `exposure_limit_currency` STRING COMMENT 'ISO 4217 currency code for the exposure limit.. Valid values are `^[A-Z]{3}$`',
    `feature_set_description` STRING COMMENT 'Narrative description of the features used by the model.',
    `input_data_source` STRING COMMENT 'Primary data source feeding the model (e.g., transaction_data, merchant_profile).',
    `last_retrained_date` DATE COMMENT 'Date of the most recent retraining cycle.',
    `output_metric` STRING COMMENT 'Name of the metric produced by the model (e.g., risk_score).',
    `owner_team` STRING COMMENT 'Business team responsible for the models governance.',
    `performance_auc` DECIMAL(18,2) COMMENT 'AUC metric for model performance.',
    `performance_gini` DECIMAL(18,2) COMMENT 'Gini coefficient measuring model discrimination power.',
    `performance_ks` DECIMAL(18,2) COMMENT 'KS statistic indicating separation between good and bad outcomes.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory sign‑off for the model.. Valid values are `approved|pending|rejected`',
    `retirement_reason` STRING COMMENT 'Explanation for why the model was retired.',
    `retirement_timestamp` TIMESTAMP COMMENT 'Timestamp when the model was retired (nullable).',
    `risk_category` STRING COMMENT 'High‑level risk domain the model addresses (e.g., credit_risk, operational_risk).',
    `risk_model_code` STRING COMMENT 'Business identifier or code used to reference the model in operational systems.',
    `risk_model_description` STRING COMMENT 'Detailed free‑text description of the models purpose and scope.',
    `risk_model_name` STRING COMMENT 'Human‑readable name of the risk model.',
    `risk_model_status` STRING COMMENT 'Current lifecycle state of the model.. Valid values are `active|inactive|deprecated|retired|draft|pending`',
    `risk_model_type` STRING COMMENT 'Category of underwriting model (e.g., credit, behavioral, velocity, concentration, custom).. Valid values are `credit|behavioral|velocity|concentration|custom`',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Score above which a transaction is declined or flagged.',
    `score_max` DECIMAL(18,2) COMMENT 'Maximum possible value of the models risk score.',
    `score_min` DECIMAL(18,2) COMMENT 'Minimum possible value of the models risk score.',
    `score_units` STRING COMMENT 'Units or scale of the risk score (e.g., points, percentile).',
    `source_system` STRING COMMENT 'Originating system that created or maintains the model record.',
    `status_reason` STRING COMMENT 'Free‑text reason explaining the current status.',
    `training_dataset_ref` BIGINT COMMENT 'Reference to the dataset used to train the model.',
    `training_date` DATE COMMENT 'Date on which the model was originally trained.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the model record.',
    `version` STRING COMMENT 'Version string of the model (e.g., v1.2.3).',
    `version_notes` STRING COMMENT 'Notes describing changes introduced in this version.',
    CONSTRAINT pk_risk_model PRIMARY KEY(`risk_model_id`)
) COMMENT 'Registry of risk scoring models deployed in the risk engine — including model type (credit, behavioral, velocity, concentration), model version, champion/challenger status, training dataset reference, feature set, performance metrics (Gini, KS, AUC), and deployment lifecycle state. Distinct from fraud domain ML models — these are risk underwriting and exposure models.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` (
    `exposure_limit_id` BIGINT COMMENT 'Unique surrogate key for the exposure limit record.',
    `appetite_framework_id` BIGINT COMMENT 'Foreign key linking to risk.risk_appetite_framework. Business justification: Exposure limits belong to a risk appetite framework; one framework can have many exposure limits. Added exposure_limit.risk_appetite_framework_id.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Exposure limits are allocated to internal cost centers for charge‑back, budgeting, and performance measurement.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or role that approved the current limit version.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether changes to the limit require formal approval.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the limit was last approved.',
    `breach_status` STRING COMMENT 'Current breach status of the limit.. Valid values are `none|warning|breached`',
    `business_identifier` STRING COMMENT 'External identifier or code used by the risk system to reference the limit.',
    `counterparty_type` STRING COMMENT 'Type of counterparty to which the limit applies.. Valid values are `merchant|cardholder|partner|institution`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the limit record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code of the limit amount.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `effective_from` TIMESTAMP COMMENT 'Timestamp when the limit becomes effective.',
    `effective_until` TIMESTAMP COMMENT 'Timestamp when the limit expires; null for open‑ended limits.',
    `exposure_limit_status` STRING COMMENT 'Lifecycle status of the limit record.. Valid values are `active|inactive|suspended|pending|closed`',
    `geography` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code where the limit is applicable.. Valid values are `USA|CAN|GBR|FRA|DEU|JPN`',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent review of the limit.',
    `limit_amount` DECIMAL(18,2) COMMENT 'Maximum allowed exposure amount for the defined scope.',
    `limit_name` STRING COMMENT 'Human‑readable name for the limit (e.g., “US Merchant Daily TPV Limit”).',
    `limit_scope` STRING COMMENT 'Scope of the limit – defines the aggregation window or transaction type.. Valid values are `intraday|daily|monthly|annual|settlement|tpv`',
    `limit_source_system` STRING COMMENT 'Source system that originated the limit record (e.g., Risk Management System, Merchant Management System).',
    `next_review_timestamp` TIMESTAMP COMMENT 'Planned timestamp for the next scheduled review.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or exceptions related to the limit.',
    `product_type` STRING COMMENT 'Product or service category the limit governs.. Valid values are `payment|wallet|fx|settlement|credit`',
    `review_cycle_days` STRING COMMENT 'Number of days between mandatory limit reviews.',
    `risk_model_version` STRING COMMENT 'Version identifier of the risk model used to calculate the limit.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk score associated with the counterparty at the time of limit assignment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the limit record.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of the limit that has been utilized (utilized_amount / limit_amount * 100).',
    `utilized_amount` DECIMAL(18,2) COMMENT 'Current amount of exposure already used within the active period.',
    CONSTRAINT pk_exposure_limit PRIMARY KEY(`exposure_limit_id`)
) COMMENT 'Maximum exposure and credit limit assignments by counterparty, counterparty type (merchant, cardholder, institutional partner), limit scope (TPV, settlement, credit line, intraday, FX), geography, and product type. Captures limit amount, currency, utilization, breach status, and review cycle. Enforced during real-time authorization and batch settlement.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`threshold` (
    `threshold_id` BIGINT COMMENT 'System-generated unique identifier for the risk threshold configuration.',
    `appetite_framework_id` BIGINT COMMENT 'Foreign key linking to risk.risk_appetite_framework. Business justification: Risk thresholds are defined within a risk appetite framework; added FK to associate each threshold with its framework.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Thresholds are defined per currency; linking to reference.currency provides official code, symbol, and rounding rules.',
    `mcc_id` BIGINT COMMENT 'Foreign key linking to reference.mcc. Business justification: MCC‑based thresholds need standardized MCC data for accurate risk limits per merchant category.',
    `compliance_requirements` STRING COMMENT 'Textual description of regulatory or internal compliance rules tied to this threshold.',
    `concentration_limit` DECIMAL(18,2) COMMENT 'Maximum exposure amount to a single merchant or risk factor before additional controls apply.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the threshold record was first created.',
    `effective_from` DATE COMMENT 'Date when the threshold becomes active.',
    `effective_until` DATE COMMENT 'Date when the threshold expires or is superseded (null if open‑ended).',
    `escalation_action` STRING COMMENT 'Automated action taken when the threshold is breached.. Valid values are `alert|hold|review|escalate|none`',
    `is_system_default` BOOLEAN COMMENT 'Indicates whether this threshold is a built‑in default provided by the platform.',
    `last_review_date` DATE COMMENT 'Date when the threshold was last reviewed for relevance and accuracy.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Upper monetary limit for a single transaction when this threshold is active.',
    `max_transaction_volume` STRING COMMENT 'Maximum number of transactions allowed within the threshold’s evaluation period.',
    `notes` STRING COMMENT 'Free‑form field for additional comments or audit remarks.',
    `notification_channel` STRING COMMENT 'Channel used to notify stakeholders of a threshold breach.. Valid values are `email|sms|dashboard|api|none`',
    `priority` STRING COMMENT 'Numeric priority used to resolve conflicts when multiple thresholds apply (lower number = higher priority).',
    `region_code` STRING COMMENT 'Three‑letter ISO 3166‑1 alpha‑3 country or region code where the threshold is applicable. [ENUM-REF-CANDIDATE: USA|GBR|CAN|AUS|DEU|FRA|JPN|CHN|IND|BRA — promote to reference product]',
    `regulatory_approval_status` STRING COMMENT 'Current approval state of the threshold with respect to regulatory bodies.. Valid values are `approved|pending|rejected|under_review`',
    `reserve_rate` DECIMAL(18,2) COMMENT 'Percentage of transaction amount to be held in reserve when the threshold is triggered.',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory reviews of the threshold configuration.',
    `risk_appetite_category` STRING COMMENT 'Classification of the threshold within the organization’s risk appetite framework.. Valid values are `low|medium|high|critical`',
    `risk_dimension` STRING COMMENT 'The specific risk metric that this threshold governs (e.g., chargeback ratio, fraud rate).. Valid values are `chargeback_ratio|fraud_rate|decline_rate|reserve_trigger|concentration_limit`',
    `source_system` STRING COMMENT 'Name of the operational system that originated the threshold record.',
    `threshold_code` STRING COMMENT 'Business-friendly code used to reference the threshold in policies and rules.',
    `threshold_description` STRING COMMENT 'Detailed description of the purpose and application of the threshold.',
    `threshold_name` STRING COMMENT 'Human‑readable name of the risk threshold.',
    `threshold_status` STRING COMMENT 'Current lifecycle status of the threshold configuration.. Valid values are `active|inactive|pending|retired`',
    `threshold_type` STRING COMMENT 'Indicates whether the threshold value is an absolute number, a percentage, or a banded range.. Valid values are `absolute|percentage|band`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric value that defines the limit for the selected risk dimension.',
    `unit_of_measure` STRING COMMENT 'Unit in which the threshold value is expressed (e.g., percent, count, currency).. Valid values are `percent|count|currency|ratio|amount`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the threshold record.',
    `version` STRING COMMENT 'Incremental version of the threshold configuration for change tracking.',
    CONSTRAINT pk_threshold PRIMARY KEY(`threshold_id`)
) COMMENT 'Granular risk threshold configurations for specific risk dimensions — chargeback ratio thresholds, fraud rate thresholds, decline rate bands, reserve trigger levels, and concentration risk limits. Linked to risk rules and underwriting policies. Provides the parameterized values that drive automated risk actions and escalation workflows.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` (
    `underwriting_decision_id` BIGINT COMMENT 'System-generated unique identifier for each underwriting decision record.',
    `cardholder_cardholder_profile_id` BIGINT COMMENT 'Reference to the cardholder (or consumer) associated with the decision, if applicable.',
    `cardholder_profile_id` BIGINT COMMENT 'Reference to the cardholder (or consumer) associated with the decision, if applicable.',
    `employee_id` BIGINT COMMENT 'Identifier of the human underwriter who approved or reviewed the decision, if applicable.',
    `merchant_id` BIGINT COMMENT 'Reference to the merchant to which the underwriting decision applies.',
    `partner_profile_id` BIGINT COMMENT 'Reference to a partner entity (e.g., PSP, TSP) involved in the decision context.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Underwriting decisions are evaluated per payment product, supporting the Product‑Level Credit Approval workflow.',
    `transaction_id` BIGINT COMMENT 'Identifier of the transaction that triggered the underwriting evaluation.',
    `underwriter_employee_id` BIGINT COMMENT 'Identifier of the human underwriter who approved or reviewed the decision, if applicable.',
    `underwriting_policy_id` BIGINT COMMENT 'Reference to the underwriting policy applied to this decision.',
    `approving_authority` STRING COMMENT 'Indicates whether the decision was made by an automated engine or a human underwriter.. Valid values are `automated|human`',
    `audit_trail_ref` BIGINT COMMENT 'Link to the detailed audit log entry capturing the decision workflow.',
    `compliance_requirements_met` STRING COMMENT 'List of regulatory or internal compliance checks satisfied by this decision.',
    `conditions_applied` STRING COMMENT 'Free‑text description of any special conditions (e.g., reserve rate, TPV cap) imposed by the decision.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the underwriting decision record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary limits.. Valid values are `^[A-Z]{3}$`',
    `decision_category` STRING COMMENT 'High‑level classification of the decision (e.g., "new_merchant", "risk_adjustment").',
    `decision_confidence` DECIMAL(18,2) COMMENT 'Confidence level (0‑1) associated with the automated decision engines output.',
    `decision_expiration_timestamp` TIMESTAMP COMMENT 'If the decision is conditional, the time after which it expires and must be re‑evaluated.',
    `decision_outcome` STRING COMMENT 'Result of the underwriting evaluation: approved, declined, conditional, or referred.. Valid values are `approved|declined|conditional|referred`',
    `decision_override_allowed` BOOLEAN COMMENT 'Flag indicating whether a human can override the automated decision.',
    `decision_override_reason` STRING COMMENT 'Reason provided when a decision is manually overridden.',
    `decision_reason` STRING COMMENT 'Narrative explanation for the decision outcome.',
    `decision_review_date` DATE COMMENT 'Scheduled date for periodic review of the underwriting decision.',
    `decision_score_components` STRING COMMENT 'Serialized representation of individual score components used in the final risk score.',
    `decision_source` STRING COMMENT 'Origin of the decision request: real‑time engine, batch process, or manual entry.. Valid values are `real_time|batch|manual`',
    `decision_status` STRING COMMENT 'Current lifecycle state of the underwriting decision.. Valid values are `pending|approved|declined|reversed|closed`',
    `decision_tags` STRING COMMENT 'Comma‑separated tags for categorizing the decision (e.g., "new_merchant,high_volume").',
    `decision_timestamp` TIMESTAMP COMMENT 'Exact time the underwriting decision was made, representing the business event moment.',
    `decision_type` STRING COMMENT 'Indicates whether this is the initial underwriting, a reassessment, or a post‑settlement review.. Valid values are `initial|reassessment|post_settlement`',
    `is_fraud_flag` BOOLEAN COMMENT 'Indicates whether the decision was influenced by a fraud detection signal.',
    `is_high_risk_flag` BOOLEAN COMMENT 'True when the decision falls into a high‑risk category requiring extra monitoring.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum single transaction amount permitted under the decision.',
    `max_transaction_volume` DECIMAL(18,2) COMMENT 'Maximum total transaction volume allowed for the merchant over a defined period.',
    `mcc_allowed` STRING COMMENT 'Comma‑separated list of MCCs that the merchant is permitted to process.',
    `mcc_blocked` STRING COMMENT 'Comma‑separated list of MCCs that are prohibited for the merchant.',
    `policy_version` STRING COMMENT 'Version string of the underwriting policy in effect.',
    `regulatory_approval_status` STRING COMMENT 'Status of any required regulatory sign‑off for the underwriting decision.. Valid values are `approved|pending|rejected`',
    `reserve_amount` DECIMAL(18,2) COMMENT 'Monetary amount placed in reserve for the merchant based on the decision.',
    `reserve_rate` DECIMAL(18,2) COMMENT 'Percentage of transaction amount held in reserve as a risk mitigation measure.',
    `risk_appetite_category` STRING COMMENT 'Classification of the decision within the enterprise risk appetite framework.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score calculated at decision time, higher values indicate greater risk.',
    `risk_score_version` STRING COMMENT 'Version identifier of the risk scoring model used for this decision.',
    `tpv_cap` DECIMAL(18,2) COMMENT 'Maximum cumulative payment volume allowed for the merchant within the policy period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the underwriting decision record.',
    CONSTRAINT pk_underwriting_decision PRIMARY KEY(`underwriting_decision_id`)
) COMMENT 'Transactional record of each underwriting decision made for a merchant, cardholder, or partner — capturing decision outcome (approved, declined, conditional, referred), applied policy version, risk score at decision time, conditions imposed (reserve rate, TPV cap, restricted MCCs), decision timestamp, and approving authority (automated engine or human underwriter). SSOT for underwriting audit trail.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`assessment` (
    `assessment_id` BIGINT COMMENT 'Unique system-generated identifier for each risk assessment record.',
    `assessor_employee_id` BIGINT COMMENT 'Unique identifier of the risk analyst or automated engine that generated the assessment.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Assessments calculate risk exposure in a currency; linking to reference.currency ensures consistent currency data across reports.',
    `digital_wallet_id` BIGINT COMMENT 'Foreign key linking to wallet.digital_wallet. Business justification: Risk assessments are performed per wallet to evaluate compliance and fraud risk, requiring a direct wallet reference.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the risk analyst or automated engine that generated the assessment.',
    `exposure_id` BIGINT COMMENT 'Foreign key linking to fx.fx_exposure. Business justification: FX exposure snapshots are needed in risk assessments to calculate overall exposure and regulatory capital.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Enables the Partner Risk Assessment dashboard, associating partner IDs with risk assessment outcomes for regulatory reporting.',
    `party_id` BIGINT COMMENT 'Unique identifier of the merchant, cardholder, or partner being assessed.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Periodic risk assessments are performed per payment product to satisfy the Product Risk Dashboard compliance report.',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_request. Business justification: Real‑time risk assessment is performed per gateway request; linking enables audit trails and compliance reporting of each assessment.',
    `risk_policy_id` BIGINT COMMENT 'Identifier of the underwriting policy governing limits and thresholds for this assessment.',
    `risk_profile_id` BIGINT COMMENT 'Foreign key linking to risk.risk_profile. Business justification: Risk assessments are performed for a specific risk profile; added FK to link assessment to profile.',
    `assessment_date` DATE COMMENT 'The calendar date on which the risk assessment was conducted.',
    `assessment_number` STRING COMMENT 'Human‑readable reference number assigned to the assessment, used in reporting and audit trails.',
    `assessment_status` STRING COMMENT 'Tracks the workflow state of the assessment from creation through completion or rejection.. Valid values are `pending|in_progress|completed|rejected`',
    `assessment_type` STRING COMMENT 'Indicates whether the assessment is an initial onboarding review, a scheduled periodic review, or a review triggered by a specific event.. Valid values are `initial|periodic|triggered`',
    `average_transaction_value` DECIMAL(18,2) COMMENT 'Mean monetary value per transaction for the party in the last 30 days.',
    `compliance_flag_aml` BOOLEAN COMMENT 'True if the assessment included an Anti‑Money‑Laundering screening.',
    `compliance_flag_sanctions` BOOLEAN COMMENT 'True if the assessment incorporated sanctions list checks.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the assessment entry was first persisted.',
    `credit_risk_score` DECIMAL(18,2) COMMENT 'Quantitative score reflecting creditworthiness of the assessed party.',
    `is_high_risk` BOOLEAN COMMENT 'Boolean flag set when the overall risk tier meets or exceeds the high‑risk threshold.',
    `is_manual_review` BOOLEAN COMMENT 'True when a human analyst intervened in the assessment process.',
    `mcc_category` STRING COMMENT 'Four‑digit code classifying the merchants primary business activity.',
    `next_review_date` DATE COMMENT 'Scheduled date for the subsequent risk assessment, supporting periodic review cycles.',
    `notes` STRING COMMENT 'Narrative comments, observations, or justification provided by the assessor.',
    `operational_risk_score` DECIMAL(18,2) COMMENT 'Score measuring operational risk factors such as process failures or system outages.',
    `outcome` STRING COMMENT 'Final decision resulting from the assessment, guiding downstream processing.. Valid values are `approved|declined|conditional|escalated`',
    `overall_risk_score` DECIMAL(18,2) COMMENT 'Composite risk score derived from individual risk dimension scores.',
    `party_type` STRING COMMENT 'Classifies the subject of the assessment as a merchant, cardholder, or partner entity.. Valid values are `merchant|cardholder|partner`',
    `recommended_action` STRING COMMENT 'Prescribed next steps for the assessed party (e.g., increase limits, impose controls, terminate relationship).',
    `region_code` STRING COMMENT 'Three‑letter country code indicating the primary operating region of the assessed party.',
    `regulatory_risk_score` DECIMAL(18,2) COMMENT 'Score reflecting compliance and regulatory exposure of the party.',
    `reputational_risk_score` DECIMAL(18,2) COMMENT 'Score assessing potential damage to brand or public perception.',
    `risk_exposure_amount` DECIMAL(18,2) COMMENT 'Estimated financial exposure associated with the assessed risk, expressed in the reporting currency.',
    `risk_model_version` STRING COMMENT 'Identifier of the scoring model version applied during the assessment.',
    `risk_tier` STRING COMMENT 'Categorical risk tier used for underwriting decisions and monitoring.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Identifies the originating system or process that triggered the assessment.. Valid values are `gateway|fraud|wallet|compliance|manual`',
    `transaction_amount_last_30d` DECIMAL(18,2) COMMENT 'Sum of transaction monetary values for the party over the preceding 30‑day window.',
    `transaction_volume_last_30d` DECIMAL(18,2) COMMENT 'Aggregate count of transactions processed for the party over the preceding 30‑day window.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the assessment record.',
    CONSTRAINT pk_assessment PRIMARY KEY(`assessment_id`)
) COMMENT 'Periodic or event-triggered risk assessment records for merchants, cardholders, and partners — capturing assessment type (initial onboarding, periodic review, triggered review), risk dimensions evaluated (credit, operational, reputational, regulatory), assessment outcome, risk tier assigned, and recommended actions. Distinct from real-time scoring — these are structured review records with human or model-driven conclusions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`risk_event` (
    `risk_event_id` BIGINT COMMENT 'System-generated unique identifier for the risk event record.',
    `cardholder_cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder involved in the event.',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder involved in the event.',
    `cross_border_payment_id` BIGINT COMMENT 'Foreign key linking to fx.cross_border_payment. Business justification: Mitigation actions often stem from cross‑border payments; linking provides traceability from the event to the payment.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Event amounts are recorded in a currency; FK to reference.currency supports reporting, settlement, and AML analysis.',
    `dispute_case_id` BIGINT COMMENT 'Foreign key linking to dispute.case. Business justification: Investigation event logs are tied to the dispute case they belong to, enabling end‑to‑end traceability.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Loss events are booked to GL accounts so that risk‑related losses appear in financial reporting.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant associated with the event.',
    `message_log_id` BIGINT COMMENT 'Foreign key linking to network.network_message_log. Business justification: Fraud investigations require tracing the exact network message that triggered a risk event; FK provides audit linkage.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Links risk events that affect a partner to the partner record, essential for incident response, fraud investigation, and regulatory incident reporting.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Needed to capture the payment product context in fraud event logs for the Regulatory Fraud Reporting process.',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to terminal.pos_terminal. Business justification: Required for Terminal Fraud Monitoring Report: links each risk event to the terminal where the suspicious transaction originated, enabling terminal‑level risk analytics.',
    `rate_id` BIGINT COMMENT 'Foreign key linking to fx.fx_rate. Business justification: Required for FX volatility risk events to reference the exact rate used, enabling audit and compliance reporting.',
    `request_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_request. Business justification: Each fraud or compliance event originates from a specific gateway request; the link is required for incident investigation and remediation.',
    `risk_rule_id` BIGINT COMMENT 'Identifier of the risk rule or policy that fired the event.',
    `transaction_batch_id` BIGINT COMMENT 'Identifier of the processing batch in which the event was recorded.',
    `transaction_id` BIGINT COMMENT 'Identifier of the transaction that triggered the risk event.',
    `wallet_device_id` BIGINT COMMENT 'Foreign key linking to wallet.wallet_device. Business justification: Device‑based fraud detection records the wallet_device used in a risk_event for device fingerprint analysis.',
    `affected_entity_ref` BIGINT COMMENT 'Unique identifier of the affected entity (e.g., transaction_id, merchant_id).',
    `affected_entity_type` STRING COMMENT 'The type of business entity that the event pertains to.. Valid values are `transaction|merchant|cardholder|account|digital_wallet`',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value tied to the event (e.g., transaction amount, chargeback amount).',
    `audit_trail` STRING COMMENT 'JSON string capturing the audit log of changes to the event record.',
    `confidence_score` DECIMAL(18,2) COMMENT 'Probability confidence of the risk prediction (0‑1 range).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk event record was first persisted.',
    `escalation_level` STRING COMMENT 'Level of escalation required based on severity and impact.. Valid values are `tier1|tier2|tier3|escalated`',
    `escalation_status` STRING COMMENT 'Current status of the event within the escalation workflow.. Valid values are `open|in_progress|resolved|closed`',
    `event_source` STRING COMMENT 'System or process that generated the risk event.. Valid values are `fraud_detection_platform|risk_engine|manual_review|external_feed`',
    `event_timestamp` TIMESTAMP COMMENT 'The exact point in time when the risk event occurred in the business domain.',
    `event_type` STRING COMMENT 'High‑level classification of the risk event (e.g., fraud, compliance, operational).. Valid values are `fraud|compliance|operational|dispute|risk_score`',
    `is_manual_override` BOOLEAN COMMENT 'Indicates whether a human manually overrode the automated decision.',
    `is_threshold_exceeded` BOOLEAN COMMENT 'Indicates whether the observed value surpassed the defined threshold.',
    `jurisdiction_code` STRING COMMENT 'Three‑letter ISO country code of the jurisdiction impacted.. Valid values are `^[A-Z]{3}$`',
    `model_version` STRING COMMENT 'Version of the machine‑learning model or rule set used for scoring.',
    `payload` STRING COMMENT 'Raw data or JSON payload describing the event details.',
    `regulatory_flag` BOOLEAN COMMENT 'True if the event must be reported to a regulator (e.g., AML, SAR).',
    `remediation_action` STRING COMMENT 'Recommended or executed action to mitigate the risk event.',
    `risk_dimension` STRING COMMENT 'Specific risk domain impacted by the event (e.g., AML, sanctions, exposure).. Valid values are `fraud|aml|sanctions|exposure|chargeback|behavioral`',
    `risk_event_description` STRING COMMENT 'Free‑form text providing additional context or notes about the event.',
    `risk_event_status` STRING COMMENT 'Current lifecycle status of the risk event record.. Valid values are `active|inactive|archived`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical score representing the risk severity as calculated by the risk engine.',
    `severity_level` STRING COMMENT 'Business‑defined severity of the event, used for prioritization and escalation.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Originating system that supplied the event data.. Valid values are `gateway|processing|fraud|compliance|manual`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Configured threshold that, when exceeded, triggers the risk event.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the risk event record.',
    CONSTRAINT pk_risk_event PRIMARY KEY(`risk_event_id`)
) COMMENT 'Captures discrete risk events that trigger risk management actions — including chargeback ratio breaches, fraud rate spikes, exposure limit violations, sanctions hits, and behavioral anomalies. Each event records the triggering condition, severity level, affected entity, risk dimension, and escalation status. Feeds the risk case management workflow.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`risk_case` (
    `risk_case_id` BIGINT COMMENT 'Unique system-generated identifier for the risk investigation case.',
    `cardholder_cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder (customer) linked to the case.',
    `cardholder_profile_id` BIGINT COMMENT 'Identifier of the cardholder (customer) linked to the case.',
    `created_by_employee_id` BIGINT COMMENT 'System user identifier who created the case record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Case investigations track monetary impact; linking to reference.currency ensures consistent currency attributes for audit.',
    `risk_rule_id` BIGINT COMMENT 'Identifier of the fraud/AML rule that triggered the case.',
    `dispute_case_id` BIGINT COMMENT 'Foreign key linking to dispute.case. Business justification: Internal risk investigations are often opened for a dispute; linking them enables unified case management.',
    `employee_id` BIGINT COMMENT 'Identifier of the risk analyst responsible for the case.',
    `fraud_case_id` BIGINT COMMENT 'Foreign key linking to fraud.fraud_case. Business justification: When a fraud incident triggers a broader risk investigation, the risk case references the originating fraud case for traceability.',
    `last_updated_by_employee_id` BIGINT COMMENT 'System user identifier who last modified the case record.',
    `merchant_id` BIGINT COMMENT 'Identifier of the merchant involved in the case.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Risk case investigations reference the affected payment product for the Case Management system and regulatory audit.',
    `pos_terminal_id` BIGINT COMMENT 'Foreign key linking to terminal.pos_terminal. Business justification: Needed for Terminal Incident Investigation Report: associates each risk case with the specific POS terminal involved, supporting root‑cause analysis and remediation tracking.',
    `primary_risk_employee_id` BIGINT COMMENT 'Identifier of the risk analyst responsible for the case.',
    `related_case_risk_case_id` BIGINT COMMENT 'Identifier of a linked case for cross‑reference or follow‑up.',
    `response_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_response. Business justification: Cases are often opened on declined or flagged gateway responses; linking provides root‑cause context for investigators.',
    `tertiary_risk_last_updated_by_employee_id` BIGINT COMMENT 'System user identifier who last modified the case record.',
    `transaction_id` BIGINT COMMENT 'Identifier of the transaction that triggered the risk case.',
    `aml_status_at_time` TIMESTAMP COMMENT 'AML screening status of the party at case creation.',
    `case_category` STRING COMMENT 'High‑level classification of the case subject.. Valid values are `transaction|merchant|cardholder|system|policy`',
    `case_number` STRING COMMENT 'Human‑readable case number used for tracking and reference.',
    `case_source` STRING COMMENT 'Origin of the case creation.. Valid values are `fraud_detection|aml_monitoring|regulatory_audit|customer_report|internal_review`',
    `case_status` STRING COMMENT 'Current lifecycle state of the case.. Valid values are `open|under_review|escalated|resolved|closed`',
    `case_type` STRING COMMENT 'Category of the risk case indicating the originating risk domain.. Valid values are `fraud|aml|sanctions|compliance|dispute`',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the case reached a final closed state.',
    `compliance_review_status` STRING COMMENT 'Current status of the compliance review process.. Valid values are `pending|approved|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the case record was first created in the system.',
    `detection_timestamp` TIMESTAMP COMMENT 'Timestamp when the triggering rule fired.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the case was escalated to higher authority.',
    `escalation_level` STRING COMMENT 'Level of escalation applied to the case.. Valid values are `tier1|tier2|tier3`',
    `evidence_count` STRING COMMENT 'Number of evidence items attached to the case.',
    `fraud_indicator_codes` STRING COMMENT 'Pipe‑separated list of fraud indicator codes associated with the case.',
    `investigation_summary` STRING COMMENT 'Free‑text summary of investigative findings and actions.',
    `is_high_risk` BOOLEAN COMMENT 'True if the case is flagged as high risk based on scoring thresholds.',
    `kyc_status_at_time` TIMESTAMP COMMENT 'KYC verification status of the party when the case was opened.',
    `mitigation_action_taken` STRING COMMENT 'Description of the remediation or mitigation action applied.',
    `notes` STRING COMMENT 'Additional free‑form notes captured by analysts.',
    `opened_timestamp` TIMESTAMP COMMENT 'Timestamp when the case was officially opened for investigation.',
    `priority` STRING COMMENT 'Business priority assigned to the case for handling urgency.. Valid values are `low|medium|high|critical`',
    `regulatory_flag` BOOLEAN COMMENT 'True if the case requires regulatory reporting or review.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the case (e.g., approved, rejected, dismissed).',
    `risk_exposure_amount` DECIMAL(18,2) COMMENT 'Monetary amount representing the potential financial exposure associated with the case.',
    `risk_model_version` STRING COMMENT 'Version identifier of the risk model used for scoring.',
    `risk_score_at_creation` DECIMAL(18,2) COMMENT 'Risk score calculated at the moment the case was created.',
    `risk_score_current` DECIMAL(18,2) COMMENT 'Most recent risk score reflecting ongoing assessment.',
    `sanction_check_result` STRING COMMENT 'Result of sanctions screening at case creation.. Valid values are `clear|matched|pending|blocked`',
    `severity` STRING COMMENT 'Severity rating reflecting potential impact.. Valid values are `low|medium|high|critical`',
    `subcategory` STRING COMMENT 'More detailed classification within the main category.',
    `tags` STRING COMMENT 'Free‑form tags for ad‑hoc categorisation and search.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the case record.',
    CONSTRAINT pk_risk_case PRIMARY KEY(`risk_case_id`)
) COMMENT 'Operational case management for risk investigations — capturing case type, status lifecycle (open, under review, escalated, resolved, closed), assigned analyst, investigation evidence, mitigation actions taken, resolution outcome, and effectiveness review. SSOT for risk case workflow and intervention tracking.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` (
    `concentration_exposure_id` BIGINT COMMENT 'System-generated unique identifier for each concentration exposure record.',
    `risk_model_id` BIGINT COMMENT 'Identifier of the risk model used to calculate the risk_score.',
    `breach_flag` BOOLEAN COMMENT 'True if the exposure exceeds its defined limit, otherwise false.',
    `breach_status` STRING COMMENT 'Textual status describing the breach condition of the exposure.. Valid values are `breached|within_limit|exceeded`',
    `concentration_exposure_status` STRING COMMENT 'Operational status of the exposure record.. Valid values are `active|inactive|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exposure record was first created in the system.',
    `dimension_code` STRING COMMENT 'Code or identifier representing the specific value within the chosen dimension (e.g., MCC code, ISO country code, merchant ID, BIN number, rail identifier).',
    `dimension_type` STRING COMMENT 'Category of concentration risk dimension (e.g., Merchant Category Code, geographic region, single merchant, BIN, settlement rail).. Valid values are `mcc|geography|merchant|bin|rail`',
    `effective_from` DATE COMMENT 'Date when the exposure measurement becomes effective.',
    `effective_until` DATE COMMENT 'Date when the exposure measurement expires; null for open‑ended exposures.',
    `exposure_amount` DECIMAL(18,2) COMMENT 'Monetary value of the current exposure for the dimension, expressed in the reporting currency.',
    `exposure_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code of the exposure amount.. Valid values are `^[A-Z]{3}$`',
    `exposure_limit` DECIMAL(18,2) COMMENT 'Maximum allowed exposure for the dimension before breach, expressed in the reporting currency.',
    `last_assessed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent risk assessment run that produced the current exposure values.',
    `notes` STRING COMMENT 'Optional free‑text field for comments, remediation actions, or analyst observations.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if this exposure must be included in regulatory capital or compliance reports.',
    `risk_model_version` STRING COMMENT 'Version string of the risk model applied to this exposure.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score associated with the concentration exposure, derived from the enterprise risk model.',
    `source_system` STRING COMMENT 'Name of the operational system that supplied the exposure data (e.g., Risk Management System, Transaction Processing Platform).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the exposure record.',
    `utilization_pct` DECIMAL(18,2) COMMENT 'Percentage of the limit that is currently utilized (exposure_amount / exposure_limit * 100).',
    CONSTRAINT pk_concentration_exposure PRIMARY KEY(`concentration_exposure_id`)
) COMMENT 'Tracks portfolio-level concentration risk exposures by dimension — MCC concentration, geographic concentration, single-merchant TPV concentration, BIN-level exposure, and settlement rail concentration. Captures current exposure value, limit, utilization percentage, and breach status. Used for portfolio risk monitoring and regulatory capital adequacy reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`risk_exception` (
    `risk_exception_id` BIGINT COMMENT 'Unique identifier for the risk exception record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the requesting entity.',
    `requestor_employee_id` BIGINT COMMENT 'Unique identifier of the requesting entity.',
    `risk_policy_id` BIGINT COMMENT 'Identifier of the risk policy that the exception overrides.',
    `approval_status` STRING COMMENT 'Current status of the approval process.. Valid values are `approved|rejected|pending|revoked`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was approved.',
    `approving_authority` STRING COMMENT 'Name or identifier of the authority that approved the exception.',
    `audit_notes` STRING COMMENT 'Additional audit trail notes regarding the exception.',
    `compliance_flag` STRING COMMENT 'Indicates compliance status of the exception with regulatory requirements.. Valid values are `compliant|non_compliant|exempt`',
    `conditions_attached` STRING COMMENT 'Specific conditions or constraints attached to the exception.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the exception record was created.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code applicable to monetary thresholds.. Valid values are `[A-Z]{3}`',
    `end_date` DATE COMMENT 'Date when the exception expires or is no longer valid.',
    `exception_status` STRING COMMENT 'Current lifecycle status of the exception.. Valid values are `active|expired|revoked|cancelled`',
    `exception_type` STRING COMMENT 'Category of exception, e.g., policy deviation, model override, threshold waiver, manual approval.. Valid values are `policy|model|threshold|manual`',
    `notes` STRING COMMENT 'Free-form notes related to the exception.',
    `outcome` STRING COMMENT 'Result of applying the exception to transactions.. Valid values are `success|failure|partial|not_applicable`',
    `overridden_threshold_unit` STRING COMMENT 'Unit of measure for the overridden threshold.. Valid values are `score|amount|percentage`',
    `overridden_threshold_value` DECIMAL(18,2) COMMENT 'Numeric value of the risk threshold that is overridden by the exception.',
    `rationale` STRING COMMENT 'Business justification for granting the exception.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the exception must be reported to regulators.',
    `requestor_entity` STRING COMMENT 'Entity that requested the exception.. Valid values are `merchant|cardholder|partner|internal`',
    `requestor_role` STRING COMMENT 'Role of the requestor within the requesting entity.. Valid values are `owner|operator|analyst|admin`',
    `risk_score_after` DECIMAL(18,2) COMMENT 'Risk score after applying the exception.',
    `risk_score_before` DECIMAL(18,2) COMMENT 'Risk score that would have applied without the exception.',
    `start_date` DATE COMMENT 'Date when the exception becomes effective.',
    `transaction_amount_limit_override` DECIMAL(18,2) COMMENT 'Override for the maximum transaction amount under the exception.',
    `transaction_volume_limit_override` BIGINT COMMENT 'Override for the maximum number of transactions allowed under the exception.',
    `updated_by` STRING COMMENT 'User or system that last updated the exception record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the exception record.',
    `created_by` STRING COMMENT 'User or system that created the exception record.',
    CONSTRAINT pk_risk_exception PRIMARY KEY(`risk_exception_id`)
) COMMENT 'Records approved exceptions to standard risk policies and underwriting rules — capturing exception type, requesting entity, exception rationale, approving authority, exception validity period, conditions attached, and exception outcome. Enables governance oversight of risk policy deviations and supports regulatory audit of exception management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`indicator` (
    `indicator_id` BIGINT COMMENT 'Unique surrogate key for each risk indicator record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Indicators may be measured in specific currencies; FK provides official currency details for dashboards.',
    `employee_id` BIGINT COMMENT 'Identifier of the primary owner or steward of the indicator.',
    `owner_user_employee_id` BIGINT COMMENT 'Identifier of the primary owner or steward of the indicator.',
    `risk_model_id` BIGINT COMMENT 'Identifier of the risk model that produces or influences this indicator.',
    `breach_count` STRING COMMENT 'Number of times the indicator has breached thresholds within the current reporting window.',
    `breach_flag` BOOLEAN COMMENT 'Indicates whether the measured value currently violates any threshold.',
    `breach_severity` STRING COMMENT 'Severity level of the current breach, if any.. Valid values are `green|amber|red|none`',
    `breach_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent breach occurrence.',
    `compliance_requirement` STRING COMMENT 'Regulatory or standards framework that mandates tracking of this indicator.. Valid values are `PCI_DSS|GDPR|SOX|FATF|CCPA|BSA`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the indicator record was first created.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score (0‑100) reflecting the quality of source data for this indicator.',
    `data_source` STRING COMMENT 'Originating system that supplies the raw data for the indicator.. Valid values are `fraud_platform|transaction_processing|merchant_management|digital_wallet|risk_compliance|dispute_management`',
    `effective_end_date` DATE COMMENT 'Date when the indicator definition was retired (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the indicator definition became active.',
    `indicator_description` STRING COMMENT 'Detailed description of what the indicator measures and why it matters.',
    `indicator_name` STRING COMMENT 'Human‑readable name of the risk indicator.',
    `indicator_status` STRING COMMENT 'Current lifecycle status of the indicator definition.. Valid values are `active|inactive|retired|pending`',
    `is_archived` BOOLEAN COMMENT 'True if the indicator record is archived and excluded from active reporting.',
    `last_review_date` DATE COMMENT 'Date when the indicator definition was last reviewed.',
    `measured_value` DECIMAL(18,2) COMMENT 'The actual value recorded for the indicator at the measurement timestamp.',
    `measurement_formula` STRING COMMENT 'Mathematical or logical expression used to calculate the indicator value.',
    `measurement_frequency` STRING COMMENT 'How often the indicator is measured or refreshed.. Valid values are `real_time|hourly|daily|weekly|monthly|quarterly`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the indicator value was captured.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the indicator.',
    `owner_department` STRING COMMENT 'Business department responsible for the indicator.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the indicator must be reported to a regulator.',
    `review_frequency` STRING COMMENT 'How often the indicator definition is formally reviewed.. Valid values are `monthly|quarterly|annually`',
    `risk_category` STRING COMMENT 'High‑level risk domain to which the indicator belongs.. Valid values are `fraud|aml|operational|credit|liquidity|compliance`',
    `risk_model_version` STRING COMMENT 'Version string of the associated risk model.',
    `threshold_amber_high` DECIMAL(18,2) COMMENT 'Upper bound of the amber (caution) range for the indicator.',
    `threshold_amber_low` DECIMAL(18,2) COMMENT 'Lower bound of the amber (caution) range for the indicator.',
    `threshold_green_high` DECIMAL(18,2) COMMENT 'Upper bound of the green (acceptable) range for the indicator.',
    `threshold_green_low` DECIMAL(18,2) COMMENT 'Lower bound of the green (acceptable) range for the indicator.',
    `threshold_red_high` DECIMAL(18,2) COMMENT 'Upper bound of the red (breach) range for the indicator.',
    `threshold_red_low` DECIMAL(18,2) COMMENT 'Lower bound of the red (breach) range for the indicator.',
    `trend_direction` STRING COMMENT 'Observed direction of change compared to previous periods.. Valid values are `up|down|stable|unknown`',
    `unit_of_measure` STRING COMMENT 'Measurement unit applied to the indicator value.. Valid values are `percentage|count|amount_usd|duration_seconds|rate_per_min|score`',
    `updated_by` STRING COMMENT 'User or system identifier that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the indicator record.',
    `created_by` STRING COMMENT 'User or system identifier that created the record.',
    CONSTRAINT pk_indicator PRIMARY KEY(`indicator_id`)
) COMMENT 'Key Risk Indicator (KRI) definitions and their time-series measurement readings. Captures indicator name, measurement formula, data source, frequency, threshold bands (green/amber/red), measured values, trend direction, and breach history. Provides operational data for KRI dashboards and risk committee reporting.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`credit_limit` (
    `credit_limit_id` BIGINT COMMENT 'System-generated unique identifier for the credit limit record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Credit limits are currency‑specific; linking to reference.currency enables correct limit calculations and reporting.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Supports credit limit management per partner, required for credit exposure limits and AML/KYC compliance reporting.',
    `party_id` BIGINT COMMENT 'Identifier of the merchant or cardholder to which the credit limit applies.',
    `underwriting_policy_id` BIGINT COMMENT 'Reference to the underwriting policy that governed the limit decision.',
    `available_credit` DECIMAL(18,2) COMMENT 'Remaining credit available for new transactions (limit_amount minus utilization_amount).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit limit record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the credit limit becomes effective.',
    `effective_until` DATE COMMENT 'Date when the credit limit expires or is scheduled to be terminated (null for open‑ended).',
    `limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit amount approved for the party, expressed in the specified currency.',
    `limit_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent change to the credit limit (amount, type, or status).',
    `limit_expiry_date` DATE COMMENT 'Date when the credit limit is scheduled to expire if not renewed.',
    `limit_reset_date` DATE COMMENT 'Date on which a revolving credit limit resets its utilization cycle.',
    `limit_review_date` DATE COMMENT 'Scheduled date for periodic review of the credit limit.',
    `limit_source` STRING COMMENT 'Origin of the credit limit record (e.g., system‑generated, manual entry, API import).. Valid values are `system|manual|api`',
    `limit_status` STRING COMMENT 'Current lifecycle status of the credit limit.. Valid values are `active|inactive|suspended|closed`',
    `limit_type` STRING COMMENT 'Category of credit limit: revolving, installment, or buy‑now‑pay‑later.. Valid values are `revolving|installment|bnpl`',
    `risk_model_version` STRING COMMENT 'Version identifier of the risk scoring model applied at limit assignment.',
    `risk_score_at_assignment` DECIMAL(18,2) COMMENT 'Risk model score used when the credit limit was originally approved.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the credit limit record.',
    `utilization_amount` DECIMAL(18,2) COMMENT 'Current amount of credit that has been used against the limit.',
    CONSTRAINT pk_credit_limit PRIMARY KEY(`credit_limit_id`)
) COMMENT 'Credit limit assignments for merchants and cardholders — capturing approved credit line amount, currency, credit limit type (revolving, installment, BNPL), utilization amount, available credit, limit review date, and limit change history trigger. Owned by risk domain as the underwriting output that governs payment authorization credit decisions. Distinct from exposure_limit which governs TPV and settlement exposure.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` (
    `mitigation_action_id` BIGINT COMMENT 'Unique identifier for the risk mitigation action record.',
    `action_owner_employee_id` BIGINT COMMENT 'Identifier of the person or team responsible for executing the mitigation action.',
    `cross_border_payment_id` BIGINT COMMENT 'Foreign key linking to fx.cross_border_payment. Business justification: Mitigation actions are often triggered by specific cross‑border payments; linking enables end‑to‑end audit of actions.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Mitigation actions may adjust limits in a currency; FK ensures accurate before/after amounts.',
    `employee_id` BIGINT COMMENT 'User or system that created the record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Financial impact of mitigation actions is posted to a GL account for audit, financial statements, and cost tracking.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Mitigation actions are tied to the specific payment product they remediate, required for the Product‑Specific Risk Mitigation KPI.',
    `primary_employee_id` BIGINT COMMENT 'User or system that performed the latest update.',
    `related_mitigation_action_id` BIGINT COMMENT 'Identifier of a related mitigation action, if any.',
    `risk_event_id` BIGINT COMMENT 'Identifier of the risk event or case that triggered this mitigation action.',
    `risk_model_id` BIGINT COMMENT 'Identifier of the risk model used to evaluate the risk before action.',
    `risk_rule_id` BIGINT COMMENT 'Identifier of the specific risk rule that triggered the action.',
    `action_category` STRING COMMENT 'High-level category of the mitigation action.. Valid values are `financial|operational|compliance|fraud`',
    `action_reference` STRING COMMENT 'Business reference code for the mitigation action, used for external reporting.',
    `action_type` STRING COMMENT 'Type of risk mitigation action taken.. Valid values are `reserve_increase|tpv_cap_reduction|mcc_restriction|account_suspension|enhanced_monitoring`',
    `compliance_flag` STRING COMMENT 'Indicates whether the action complies with regulatory requirements.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mitigation action record was created.',
    `effective_from` DATE COMMENT 'Date when the mitigation action becomes effective.',
    `effective_until` DATE COMMENT 'Date when the mitigation action expires or is scheduled for review.',
    `effectiveness_score` DECIMAL(18,2) COMMENT 'Quantitative score assessing the effectiveness of the mitigation action.',
    `is_manual` BOOLEAN COMMENT 'Indicates whether the mitigation action was performed manually (true) or automatically (false).',
    `limit_after_amount` DECIMAL(18,2) COMMENT 'Monetary exposure limit after action.',
    `limit_before_amount` DECIMAL(18,2) COMMENT 'Monetary exposure limit before action.',
    `mitigation_action_description` STRING COMMENT 'Detailed description of the mitigation action and its purpose.',
    `mitigation_action_status` STRING COMMENT 'Current lifecycle status of the mitigation action.. Valid values are `pending|active|completed|revoked|failed`',
    `priority_level` STRING COMMENT 'Priority assigned to the mitigation action.. Valid values are `low|medium|high|critical`',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval for the mitigation action.. Valid values are `approved|pending|rejected`',
    `review_date` DATE COMMENT 'Date when the mitigation action effectiveness was reviewed.',
    `review_notes` STRING COMMENT 'Notes from the effectiveness review.',
    `risk_score_after` DECIMAL(18,2) COMMENT 'Risk score after the mitigation action was applied.',
    `risk_score_before` DECIMAL(18,2) COMMENT 'Risk score of the entity before the mitigation action was applied.',
    `source_system` STRING COMMENT 'System of record where the mitigation action originated.. Valid values are `risk_management|fraud_platform|compliance_system`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_mitigation_action PRIMARY KEY(`mitigation_action_id`)
) COMMENT 'Records risk mitigation actions taken in response to risk events, assessment findings, or KRI breaches — capturing action type (reserve increase, TPV cap reduction, MCC restriction, account suspension, enhanced monitoring), action status, triggering risk event or case, implementation date, and effectiveness review date. Provides the operational record of risk management interventions.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`model_validation` (
    `model_validation_id` BIGINT COMMENT 'System‑generated unique identifier for each risk model validation record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Validation reports include currency‑based thresholds; linking to reference.currency standardizes reporting.',
    `employee_id` BIGINT COMMENT 'System user identifier that created the validation record.',
    `risk_model_id` BIGINT COMMENT 'Identifier of the risk model that was validated.',
    `auc_roc` DECIMAL(18,2) COMMENT 'Area under the Receiver Operating Characteristic curve for the model.',
    `compliance_requirements` STRING COMMENT 'List of compliance controls the model must satisfy.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the validation record was first created in the system.',
    `data_snapshot_date` DATE COMMENT 'Date of the data snapshot used for validation.',
    `data_source` STRING COMMENT 'Origin of the data used for validation.. Valid values are `production|sandbox|historical`',
    `exposure_limit` DECIMAL(18,2) COMMENT 'Maximum monetary exposure the model is allowed to approve.',
    `gini_coefficient` DECIMAL(18,2) COMMENT 'Statistical measure of model discrimination power.',
    `governance_signoff` STRING COMMENT 'Name or identifier of the person/committee that signed off the validation.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the validation was performed automatically by the platform.',
    `ks_statistic` DECIMAL(18,2) COMMENT 'Maximum distance between cumulative distributions of scores for good vs. bad outcomes.',
    `model_algorithm` STRING COMMENT 'Algorithmic technique employed (e.g., XGBoost, Neural Network).',
    `model_deployment_environment` STRING COMMENT 'Environment where the model is deployed.. Valid values are `dev|test|prod`',
    `model_feature_set_version` STRING COMMENT 'Version identifier of the feature set used to train the model.',
    `model_input_schema_version` STRING COMMENT 'Version of the input data schema expected by the model.',
    `model_owner` STRING COMMENT 'Business unit or team responsible for the model.',
    `model_training_data_version` STRING COMMENT 'Version of the training dataset used for the model.',
    `model_version` STRING COMMENT 'Version string of the risk model at the time of validation.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations.',
    `outcome_reason` STRING COMMENT 'Explanation for the validation outcome, including any conditions or concerns.',
    `performance_summary` STRING COMMENT 'Free‑text summary of validation results and observations.',
    `psi` DECIMAL(18,2) COMMENT 'Metric indicating shift in score distribution between training and validation data.',
    `regulatory_approval_status` STRING COMMENT 'Status of any required regulatory sign‑off for the validation.. Valid values are `approved|pending|rejected`',
    `risk_category` STRING COMMENT 'Overall risk classification derived from validation results.. Valid values are `high|medium|low`',
    `risk_model_type` STRING COMMENT 'Broad classification of the risk model (e.g., credit, fraud).. Valid values are `credit|fraud|compliance|operational`',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Score threshold used by the model to trigger risk actions.',
    `sample_size` BIGINT COMMENT 'Number of records evaluated during validation.',
    `signoff_timestamp` TIMESTAMP COMMENT 'Date‑time when the governance sign‑off was recorded.',
    `updated_by` STRING COMMENT 'System user identifier that last modified the validation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the validation record.',
    `validation_duration_seconds` STRING COMMENT 'Total runtime of the validation process in seconds.',
    `validation_error_count` STRING COMMENT 'Number of errors encountered during validation.',
    `validation_methodology` STRING COMMENT 'Description of the methodology (e.g., back‑testing, hold‑out, statistical test) used for the validation.',
    `validation_outcome` STRING COMMENT 'Governance decision after validation.. Valid values are `approved|conditionally_approved|rejected`',
    `validation_report_url` STRING COMMENT 'Link to the detailed validation report document.',
    `validation_status` STRING COMMENT 'Current processing state of the validation record.. Valid values are `pending|in_progress|completed|failed`',
    `validation_timestamp` TIMESTAMP COMMENT 'Date‑time when the validation activity was executed.',
    `validation_type` STRING COMMENT 'Category of validation activity performed.. Valid values are `initial|periodic|champion_challenger|regulatory`',
    `validation_warning_count` STRING COMMENT 'Number of warnings generated during validation.',
    CONSTRAINT pk_model_validation PRIMARY KEY(`model_validation_id`)
) COMMENT 'Records of risk model validation activities — capturing validation type (initial validation, periodic review, champion/challenger test), validation methodology, performance metrics assessed (Gini coefficient, KS statistic, PSI, AUC-ROC), validation outcome (approved, conditionally approved, rejected), and model governance sign-off. Supports model risk management (MRM) governance requirements.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` (
    `counterparty_risk_limit_id` BIGINT COMMENT 'System‑generated unique identifier for each counterparty risk limit record.',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Counterparty limits are set per currency; FK to reference.currency provides authoritative currency attributes.',
    `employee_id` BIGINT COMMENT 'User or system that created the record.',
    `forward_contract_id` BIGINT COMMENT 'Foreign key linking to fx.fx_forward_contract. Business justification: Counterparty limits are hedged with forward contracts; linking tracks which contract backs each limit.',
    `risk_model_id` BIGINT COMMENT 'Identifier of the risk model used to calculate the risk score.',
    `approval_status` STRING COMMENT 'Current approval state of the risk limit agreement.. Valid values are `approved|pending|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the limit was approved.',
    `approved_by` STRING COMMENT 'Name or identifier of the person/role that approved the limit.',
    `collateral_required` BOOLEAN COMMENT 'Indicates whether the counterparty must provide collateral for the limit.',
    `collateral_type` STRING COMMENT 'Type of collateral pledged against the risk limit.. Valid values are `cash|security|guarantee|none`',
    `collateral_value` DECIMAL(18,2) COMMENT 'Monetary value of the pledged collateral.',
    `compliance_requirements` STRING COMMENT 'Textual description of compliance conditions attached to the limit.',
    `counterparty_name` STRING COMMENT 'Human‑readable name of the counterparty (e.g., acquiring bank, issuing bank, PSP).',
    `counterparty_risk_limit_status` STRING COMMENT 'Current lifecycle state of the risk limit agreement.. Valid values are `active|inactive|suspended|pending|terminated`',
    `counterparty_type` STRING COMMENT 'Category of the counterparty entity involved in the risk limit.. Valid values are `acquiring_bank|issuing_bank|card_scheme|psp|partner`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the risk limit record was first created.',
    `effective_from` DATE COMMENT 'Date on which the risk limit becomes binding.',
    `effective_until` DATE COMMENT 'Date on which the risk limit expires or is terminated (null for open‑ended).',
    `last_utilization_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to limit utilization.',
    `limit_amount` DECIMAL(18,2) COMMENT 'Approved maximum exposure amount for the counterparty.',
    `limit_code` STRING COMMENT 'External reference code or number assigned to the risk limit agreement.',
    `limit_tenor_days` STRING COMMENT 'Maximum duration, in days, that the limit is valid for a single exposure.',
    `limit_type` STRING COMMENT 'Nature of the exposure the limit governs.. Valid values are `settlement_exposure|intraday_credit|fx_exposure|liquidity`',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks about the limit.',
    `regulatory_approval_status` STRING COMMENT 'Regulatory body’s sign‑off status for the limit.. Valid values are `approved|pending|rejected`',
    `risk_score` DECIMAL(18,2) COMMENT 'Aggregated risk score assigned to the counterparty for this limit.',
    `updated_by` STRING COMMENT 'User or system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `utilization_amount` DECIMAL(18,2) COMMENT 'Current amount of the limit that has been utilized.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of the approved limit that is currently used.',
    CONSTRAINT pk_counterparty_risk_limit PRIMARY KEY(`counterparty_risk_limit_id`)
) COMMENT 'Bilateral risk limit agreements with acquiring banks, issuing banks, card schemes, and PSP partners — capturing counterparty entity, limit type (settlement exposure, intraday credit, FX exposure), approved limit amount, currency, limit tenor, collateral requirements, and limit utilization. Distinct from exposure_limit (which governs merchant/cardholder limits) — this governs institutional counterparty risk.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`rule_assignment` (
    `rule_assignment_id` BIGINT COMMENT 'Primary key for the risk_rule_assignment association',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to the payment_product entity',
    `risk_rule_id` BIGINT COMMENT 'Foreign key linking to the risk_rule entity',
    `effective_from` DATE COMMENT 'Date when the rule assignment becomes active for the payment product',
    `effective_until` DATE COMMENT 'Date when the rule assignment expires or is no longer applied',
    `rule_assignment_status` STRING COMMENT 'Current lifecycle status of the rule‑product assignment (e.g., active, inactive, pending)',
    CONSTRAINT pk_rule_assignment PRIMARY KEY(`rule_assignment_id`)
) COMMENT 'This association captures the operational assignment of risk decisioning rules to payment products. Each record links one risk_rule to one payment_product and stores the effective period and current status of that assignment.. Existence Justification: Risk rules are actively assigned to payment products by risk operations. A single risk_rule can be applied to many payment_product records, and each payment_product can have multiple risk_rule assignments, each with its own effective dates and status.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`model_currency_pair_assignment` (
    `model_currency_pair_assignment_id` BIGINT COMMENT 'Primary key for the ModelCurrencyPairAssignment association',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to the currency pair',
    `risk_model_id` BIGINT COMMENT 'Foreign key linking to the risk model',
    `effective_from` DATE COMMENT 'Date when the model becomes active for the currency pair',
    `effective_until` DATE COMMENT 'Date when the model ceases to be active for the currency pair',
    `model_version` STRING COMMENT 'Version identifier of the risk model used for this assignment',
    CONSTRAINT pk_model_currency_pair_assignment PRIMARY KEY(`model_currency_pair_assignment_id`)
) COMMENT 'This association product captures the assignment of a risk scoring model to a specific currency pair, including the period during which the model is effective and the version of the model applied. Each record links one risk_model to one currency_pair and stores relationship‑specific attributes.. Existence Justification: Risk models are actively assigned to multiple currency pairs, and each currency pair can be evaluated by several risk models over time. The assignment is managed as a distinct operational record that includes effective dates and model version information. This many‑to‑many relationship is therefore a business concept that is created, updated, and retired by risk‑management teams.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`party` (
    `party_id` BIGINT COMMENT 'Primary key for party',
    `address_line1` STRING COMMENT 'First line of the partys primary physical address.',
    `address_line2` STRING COMMENT 'Second line of the partys primary physical address (optional).',
    `annual_transaction_amount` DECIMAL(18,2) COMMENT 'Cumulative monetary value of all transactions for the party in the most recent calendar year.',
    `annual_transaction_volume` BIGINT COMMENT 'Total number of transactions processed for the party in the most recent calendar year.',
    `city` STRING COMMENT 'City component of the partys primary address.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the partys primary address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the party record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for monetary amounts associated with the party.',
    `customer_since_date` DATE COMMENT 'Date when the party first became a customer of Payments Fintech.',
    `date_of_birth` DATE COMMENT 'Birth date of an individual party.',
    `external_party_code` STRING COMMENT 'Identifier used by external partner or legacy system to reference the same party.',
    `industry_code` STRING COMMENT 'Standard industry classification (e.g., NAICS) for the party.',
    `is_blacklisted` BOOLEAN COMMENT 'True if the party is flagged for fraud or regulatory blacklisting.',
    `kyc_completed_date` DATE COMMENT 'Date when KYC verification was successfully completed.',
    `kyc_status` STRING COMMENT 'Current status of the partys KYC verification process.',
    `legal_name` STRING COMMENT 'Full legal name of the party as registered with governing authorities.',
    `national_id_number` STRING COMMENT 'National identity document number (e.g., SSN, NIN).',
    `party_type` STRING COMMENT 'Classification of the party indicating its role in the payments ecosystem.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the partys primary address.',
    `primary_contact_email` STRING COMMENT 'Main email address used for electronic communication with the party.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the party.',
    `region` STRING COMMENT 'State, province, or region of the partys primary address.',
    `registration_number` STRING COMMENT 'Official registration number for corporate or legal entities.',
    `risk_last_assessed` TIMESTAMP COMMENT 'Timestamp of the most recent risk evaluation for the party.',
    `risk_level` STRING COMMENT 'Categorical risk tier derived from the risk score.',
    `risk_score` DECIMAL(18,2) COMMENT 'Aggregated risk rating (0‑100) used for underwriting and transaction decisioning.',
    `segment` STRING COMMENT 'Business segment or market cohort the party belongs to.',
    `source_system` STRING COMMENT 'Name of the upstream operational system that supplied the party record.',
    `party_status` STRING COMMENT 'Current operational status of the party within the payments ecosystem.',
    `tax_identifier` STRING COMMENT 'Government‑issued tax identifier for the party.',
    `trade_name` STRING COMMENT 'Commonly used business name or brand under which the party operates.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the party record.',
    CONSTRAINT pk_party PRIMARY KEY(`party_id`)
) COMMENT 'Master reference table for party. Referenced by party_id.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`risk`.`risk_policy` (
    `risk_policy_id` BIGINT COMMENT 'Primary key for risk_policy',
    `risk_model_id` BIGINT COMMENT 'Reference to the risk scoring model used by this policy.',
    `superseded_risk_policy_id` BIGINT COMMENT 'Self-referencing FK on risk_policy (superseded_risk_policy_id)',
    `applicable_merchant_category_codes` STRING COMMENT 'Comma‑separated list of MCC codes to which the policy applies.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether transactions exceeding thresholds require manual approval.',
    `audit_trail_notes` STRING COMMENT 'Free‑form notes capturing audit actions or manual overrides related to the policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the policy record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary limits defined in the policy.',
    `daily_exposure_limit` DECIMAL(18,2) COMMENT 'Cumulative monetary exposure limit for a merchant or account within a single day.',
    `risk_policy_description` STRING COMMENT 'Detailed free‑text description of the policy purpose and scope.',
    `effective_from` DATE COMMENT 'Date on which the policy becomes binding.',
    `effective_until` DATE COMMENT 'Date on which the policy expires or is terminated; null for open‑ended policies.',
    `escalation_contact_email` STRING COMMENT 'Email address of the person or team to notify when policy breaches occur.',
    `escalation_contact_phone` STRING COMMENT 'Phone number for escalation notifications.',
    `geographic_scope` STRING COMMENT 'Geographic region(s) (e.g., country codes) where the policy is enforced.',
    `last_review_date` DATE COMMENT 'Date when the policy was last reviewed for relevance and compliance.',
    `monthly_exposure_limit` DECIMAL(18,2) COMMENT 'Cumulative monetary exposure limit for a merchant or account within a calendar month.',
    `policy_code` STRING COMMENT 'Business identifier or code used to reference the policy in external systems.',
    `policy_name` STRING COMMENT 'Human‑readable name of the risk policy.',
    `policy_type` STRING COMMENT 'Category of risk policy indicating the primary risk domain it governs.',
    `review_frequency_days` STRING COMMENT 'Number of days between mandatory policy reviews.',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Numeric threshold for the composite risk score that triggers policy enforcement.',
    `risk_policy_status` STRING COMMENT 'Current lifecycle status of the policy.',
    `transaction_limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary value allowed per individual transaction under this policy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the policy record.',
    `version_number` STRING COMMENT 'Incremental version of the policy for change management.',
    CONSTRAINT pk_risk_policy PRIMARY KEY(`risk_policy_id`)
) COMMENT 'Master reference table for risk_policy. Referenced by risk_policy_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ADD CONSTRAINT `fk_risk_risk_profile_appetite_framework_id` FOREIGN KEY (`appetite_framework_id`) REFERENCES `payments_fintech_ecm`.`risk`.`appetite_framework`(`appetite_framework_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ADD CONSTRAINT `fk_risk_risk_profile_risk_model_id` FOREIGN KEY (`risk_model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_model`(`risk_model_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ADD CONSTRAINT `fk_risk_risk_profile_risk_policy_id` FOREIGN KEY (`risk_policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_policy`(`risk_policy_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ADD CONSTRAINT `fk_risk_risk_rule_risk_model_id` FOREIGN KEY (`risk_model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_model`(`risk_model_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ADD CONSTRAINT `fk_risk_exposure_limit_appetite_framework_id` FOREIGN KEY (`appetite_framework_id`) REFERENCES `payments_fintech_ecm`.`risk`.`appetite_framework`(`appetite_framework_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ADD CONSTRAINT `fk_risk_threshold_appetite_framework_id` FOREIGN KEY (`appetite_framework_id`) REFERENCES `payments_fintech_ecm`.`risk`.`appetite_framework`(`appetite_framework_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ADD CONSTRAINT `fk_risk_underwriting_decision_underwriting_policy_id` FOREIGN KEY (`underwriting_policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`underwriting_policy`(`underwriting_policy_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_risk_policy_id` FOREIGN KEY (`risk_policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_policy`(`risk_policy_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ADD CONSTRAINT `fk_risk_assessment_risk_profile_id` FOREIGN KEY (`risk_profile_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_profile`(`risk_profile_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ADD CONSTRAINT `fk_risk_risk_event_risk_rule_id` FOREIGN KEY (`risk_rule_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_rule`(`risk_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_risk_rule_id` FOREIGN KEY (`risk_rule_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_rule`(`risk_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ADD CONSTRAINT `fk_risk_risk_case_related_case_risk_case_id` FOREIGN KEY (`related_case_risk_case_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_case`(`risk_case_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ADD CONSTRAINT `fk_risk_concentration_exposure_risk_model_id` FOREIGN KEY (`risk_model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_model`(`risk_model_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ADD CONSTRAINT `fk_risk_risk_exception_risk_policy_id` FOREIGN KEY (`risk_policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_policy`(`risk_policy_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ADD CONSTRAINT `fk_risk_indicator_risk_model_id` FOREIGN KEY (`risk_model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_model`(`risk_model_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ADD CONSTRAINT `fk_risk_credit_limit_party_id` FOREIGN KEY (`party_id`) REFERENCES `payments_fintech_ecm`.`risk`.`party`(`party_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ADD CONSTRAINT `fk_risk_credit_limit_underwriting_policy_id` FOREIGN KEY (`underwriting_policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`underwriting_policy`(`underwriting_policy_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_related_mitigation_action_id` FOREIGN KEY (`related_mitigation_action_id`) REFERENCES `payments_fintech_ecm`.`risk`.`mitigation_action`(`mitigation_action_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_risk_event_id` FOREIGN KEY (`risk_event_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_event`(`risk_event_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_risk_model_id` FOREIGN KEY (`risk_model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_model`(`risk_model_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ADD CONSTRAINT `fk_risk_mitigation_action_risk_rule_id` FOREIGN KEY (`risk_rule_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_rule`(`risk_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ADD CONSTRAINT `fk_risk_model_validation_risk_model_id` FOREIGN KEY (`risk_model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_model`(`risk_model_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ADD CONSTRAINT `fk_risk_counterparty_risk_limit_risk_model_id` FOREIGN KEY (`risk_model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_model`(`risk_model_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`rule_assignment` ADD CONSTRAINT `fk_risk_rule_assignment_risk_rule_id` FOREIGN KEY (`risk_rule_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_rule`(`risk_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_currency_pair_assignment` ADD CONSTRAINT `fk_risk_model_currency_pair_assignment_risk_model_id` FOREIGN KEY (`risk_model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_model`(`risk_model_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_policy` ADD CONSTRAINT `fk_risk_risk_policy_risk_model_id` FOREIGN KEY (`risk_model_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_model`(`risk_model_id`);
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_policy` ADD CONSTRAINT `fk_risk_risk_policy_superseded_risk_policy_id` FOREIGN KEY (`superseded_risk_policy_id`) REFERENCES `payments_fintech_ecm`.`risk`.`risk_policy`(`risk_policy_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`risk` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `payments_fintech_ecm`.`risk` SET TAGS ('dbx_domain' = 'risk');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` SET TAGS ('dbx_subdomain' = 'risk_scoring');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `appetite_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Framework Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `compliance_kyc_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Kyc Verification Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_model_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `aml_score` SET TAGS ('dbx_business_glossary_term' = 'AML Risk Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `kyc_status` SET TAGS ('dbx_business_glossary_term' = 'KYC Verification Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `kyc_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Risk Assessment Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Risk Review Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `party_type` SET TAGS ('dbx_value_regex' = 'merchant|cardholder|partner|issuer|acquirer');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|push');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `primary_contact_value` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Value');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_approval_by` SET TAGS ('dbx_business_glossary_term' = 'Risk Approved By');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Risk Approval Required Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Approval Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Method');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_assessment_method` SET TAGS ('dbx_value_regex' = 'rule_based|ml_model|hybrid');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_assessment_source` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Source');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_assessment_source` SET TAGS ('dbx_value_regex' = 'real_time|batch|manual');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_decision_reason` SET TAGS ('dbx_business_glossary_term' = 'Risk Decision Reason');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_exposure_limit` SET TAGS ('dbx_business_glossary_term' = 'Risk Exposure Limit (Currency)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_exposure_used` SET TAGS ('dbx_business_glossary_term' = 'Risk Exposure Used');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_flags` SET TAGS ('dbx_business_glossary_term' = 'Risk Flags');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_last_updated` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_limit_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Utilization Percentage');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_model_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_policy_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_profile_status` SET TAGS ('dbx_value_regex' = 'active|archived|deprecated');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Review Notes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Aggregated Risk Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_score_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Classification');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `sanction_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `sanction_status` SET TAGS ('dbx_value_regex' = 'clear|matched|pending');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_profile` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` SET TAGS ('dbx_subdomain' = 'policy_management');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `appetite_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Framework ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Framework Created By');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `appetite_framework_description` SET TAGS ('dbx_business_glossary_term' = 'Framework Description');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Framework Approval Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Framework Approved By');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_business_glossary_term' = 'Framework Classification or Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_value_regex' = 'transaction|merchant|product|geography|counterparty');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `concentration_limit_percent` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit Percent');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `counterparty_segment` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Segment');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `counterparty_segment` SET TAGS ('dbx_value_regex' = 'consumer|small_business|enterprise|government|non_profit');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Framework Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Framework Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Framework Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `exposure_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `exposure_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit Currency');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `exposure_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `framework_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Framework Code');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `framework_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Framework Name');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `framework_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Framework Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `framework_version` SET TAGS ('dbx_value_regex' = '^vd+.d+$');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Framework Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired|pending');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `max_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Acceptable Loss Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `max_loss_currency` SET TAGS ('dbx_business_glossary_term' = 'Maximum Loss Currency');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `max_loss_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Framework Notes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `product_line` SET TAGS ('dbx_business_glossary_term' = 'Product Line');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `product_line` SET TAGS ('dbx_value_regex' = 'payments|digital_wallet|merchant_acquiring|cross_border|p2p|b2b');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'quarterly|semi_annual|annual');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `risk_capacity_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Capacity Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `risk_capacity_currency` SET TAGS ('dbx_business_glossary_term' = 'Risk Capacity Currency');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `risk_capacity_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'credit|operational|market|liquidity|compliance|strategic');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `risk_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Threshold');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `risk_score_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `risk_score_type` SET TAGS ('dbx_value_regex' = 'credit_score|fraud_score|behavior_score|custom_score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `risk_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk Weight');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `tolerance_band` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Band');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `tolerance_band` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`risk`.`appetite_framework` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Framework Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` SET TAGS ('dbx_subdomain' = 'policy_management');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `underwriting_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Policy Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Manual Approval Required Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Policy Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Currency Code');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `max_merchant_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Maximum Merchant Discount Rate');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `mcc_allowed` SET TAGS ('dbx_business_glossary_term' = 'Allowed Merchant Category Codes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `mcc_blocked` SET TAGS ('dbx_business_glossary_term' = 'Blocked Merchant Category Codes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Policy Code');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Policy Description');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Policy Name');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `policy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Review Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Policy Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'merchant|acquirer|partner|digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `reserve_rate` SET TAGS ('dbx_business_glossary_term' = 'Reserve Rate');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `risk_appetite_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Category');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `risk_appetite_category` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `risk_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Threshold');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `rolling_reserve_rate` SET TAGS ('dbx_business_glossary_term' = 'Rolling Reserve Rate');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `tpv_threshold` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Volume Threshold');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `transaction_amount_limit` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount Limit');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `transaction_volume_limit` SET TAGS ('dbx_business_glossary_term' = 'Transaction Volume Limit');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `underwriting_decision_logic` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision Logic Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `underwriting_policy_status` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Policy Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `underwriting_policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|retired');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `underwriting_rules_version` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Rules Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Policy Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` SET TAGS ('dbx_subdomain' = 'risk_scoring');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `risk_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Rule Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `rule_config_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Rule Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Owner');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `fraud_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Mcc Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `network_routing_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Network Routing Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `regulatory_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `risk_model_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `transaction_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `action` SET TAGS ('dbx_business_glossary_term' = 'Rule Action Trigger');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `action` SET TAGS ('dbx_value_regex' = 'approve|decline|review|hold');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `applicable_channel` SET TAGS ('dbx_business_glossary_term' = 'Applicable Channel');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `applicable_channel` SET TAGS ('dbx_value_regex' = 'online|mobile|pos|atm|api');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `applicable_region` SET TAGS ('dbx_business_glossary_term' = 'Applicable Region (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `applicable_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `concentration_limit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rule Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `deprecation_date` SET TAGS ('dbx_business_glossary_term' = 'Rule Deprecation Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Rule Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Rule Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `exposure_limit` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `is_compliance_rule` SET TAGS ('dbx_business_glossary_term' = 'Is Compliance Rule Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `is_fraud_rule` SET TAGS ('dbx_business_glossary_term' = 'Is Fraud Rule Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `last_evaluated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Evaluated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `logic` SET TAGS ('dbx_business_glossary_term' = 'Rule Logic Expression');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `max_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `min_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `parameters` SET TAGS ('dbx_business_glossary_term' = 'Rule Parameters (JSON)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Period (Days)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `risk_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `risk_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Rule Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `risk_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `risk_score_weight` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Weight');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Rule Code');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Rule Name');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `rule_source` SET TAGS ('dbx_business_glossary_term' = 'Rule Source System');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Rule Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'velocity|exposure|concentration|behavioral|threshold');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Rule Threshold Unit');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|transactions|percent');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Rule Threshold Value');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rule Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `velocity_count` SET TAGS ('dbx_business_glossary_term' = 'Velocity Transaction Count');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `velocity_window_seconds` SET TAGS ('dbx_business_glossary_term' = 'Velocity Window (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_rule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rule Version Number');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` SET TAGS ('dbx_subdomain' = 'risk_scoring');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `risk_model_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Region Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `algorithm` SET TAGS ('dbx_business_glossary_term' = 'Model Algorithm');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `algorithm_parameters` SET TAGS ('dbx_business_glossary_term' = 'Algorithm Hyper‑Parameters');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Model Audit Trail');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `champion_status` SET TAGS ('dbx_business_glossary_term' = 'Champion Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `champion_status` SET TAGS ('dbx_value_regex' = 'champion|challenger|inactive');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `deployment_state` SET TAGS ('dbx_business_glossary_term' = 'Deployment State');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `deployment_state` SET TAGS ('dbx_value_regex' = 'deployed|staged|retired');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `deployment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deployment Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `deprecated_flag` SET TAGS ('dbx_business_glossary_term' = 'Deprecated Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `exposure_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `exposure_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit Currency');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `exposure_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `feature_set_description` SET TAGS ('dbx_business_glossary_term' = 'Feature Set Description');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `input_data_source` SET TAGS ('dbx_business_glossary_term' = 'Model Input Data Source');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `last_retrained_date` SET TAGS ('dbx_business_glossary_term' = 'Model Last Retrained Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `output_metric` SET TAGS ('dbx_business_glossary_term' = 'Model Output Metric');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `owner_team` SET TAGS ('dbx_business_glossary_term' = 'Owner Team');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `performance_auc` SET TAGS ('dbx_business_glossary_term' = 'Area Under ROC Curve (AUC)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `performance_gini` SET TAGS ('dbx_business_glossary_term' = 'Gini Coefficient');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `performance_ks` SET TAGS ('dbx_business_glossary_term' = 'Kolmogorov‑Smirnov Statistic');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `retirement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Retirement Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `risk_model_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Code');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `risk_model_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Description');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `risk_model_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Name');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `risk_model_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `risk_model_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|retired|draft|pending');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `risk_model_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `risk_model_type` SET TAGS ('dbx_value_regex' = 'credit|behavioral|velocity|concentration|custom');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `risk_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Threshold');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `score_max` SET TAGS ('dbx_business_glossary_term' = 'Score Maximum Value');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `score_min` SET TAGS ('dbx_business_glossary_term' = 'Score Minimum Value');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `score_units` SET TAGS ('dbx_business_glossary_term' = 'Score Units');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `training_dataset_ref` SET TAGS ('dbx_business_glossary_term' = 'Training Dataset Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `training_date` SET TAGS ('dbx_business_glossary_term' = 'Model Training Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_model` ALTER COLUMN `version_notes` SET TAGS ('dbx_business_glossary_term' = 'Version Notes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` SET TAGS ('dbx_subdomain' = 'limit_governance');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `exposure_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `appetite_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Framework Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Breach Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'none|warning|breached');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `business_identifier` SET TAGS ('dbx_business_glossary_term' = 'Business Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_value_regex' = 'merchant|cardholder|partner|institution');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `exposure_limit_status` SET TAGS ('dbx_business_glossary_term' = 'Limit Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `exposure_limit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography (Country Code)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `geography` SET TAGS ('dbx_value_regex' = 'USA|CAN|GBR|FRA|DEU|JPN');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `limit_name` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit Name');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `limit_scope` SET TAGS ('dbx_business_glossary_term' = 'Limit Scope');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `limit_scope` SET TAGS ('dbx_value_regex' = 'intraday|daily|monthly|annual|settlement|tpv');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `limit_source_system` SET TAGS ('dbx_business_glossary_term' = 'Limit Source System');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `next_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Review Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Limit Notes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'payment|wallet|fx|settlement|credit');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `review_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Days)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `risk_model_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `payments_fintech_ecm`.`risk`.`exposure_limit` ALTER COLUMN `utilized_amount` SET TAGS ('dbx_business_glossary_term' = 'Utilized Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` SET TAGS ('dbx_subdomain' = 'limit_governance');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `threshold_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Threshold Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `appetite_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Framework Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `mcc_id` SET TAGS ('dbx_business_glossary_term' = 'Mcc Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `concentration_limit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Limit');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `escalation_action` SET TAGS ('dbx_business_glossary_term' = 'Escalation Action');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `escalation_action` SET TAGS ('dbx_value_regex' = 'alert|hold|review|escalate|none');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `is_system_default` SET TAGS ('dbx_business_glossary_term' = 'System Default Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `max_transaction_volume` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|dashboard|api|none');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|under_review');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `reserve_rate` SET TAGS ('dbx_business_glossary_term' = 'Reserve Rate');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Days)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `risk_appetite_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Category');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `risk_appetite_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `risk_dimension` SET TAGS ('dbx_business_glossary_term' = 'Risk Dimension');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `risk_dimension` SET TAGS ('dbx_value_regex' = 'chargeback_ratio|fraud_rate|decline_rate|reserve_trigger|concentration_limit');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `threshold_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Threshold Code');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `threshold_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Threshold Description');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `threshold_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Threshold Name');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `threshold_status` SET TAGS ('dbx_business_glossary_term' = 'Threshold Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `threshold_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `threshold_type` SET TAGS ('dbx_business_glossary_term' = 'Threshold Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `threshold_type` SET TAGS ('dbx_value_regex' = 'absolute|percentage|band');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'percent|count|currency|ratio|amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`threshold` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` SET TAGS ('dbx_subdomain' = 'policy_management');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `underwriting_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Decision Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `partner_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `underwriter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriter Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `underwriting_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Policy Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `approving_authority` SET TAGS ('dbx_value_regex' = 'automated|human');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `audit_trail_ref` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `compliance_requirements_met` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements Met');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `conditions_applied` SET TAGS ('dbx_business_glossary_term' = 'Applied Decision Conditions');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_category` SET TAGS ('dbx_business_glossary_term' = 'Decision Category');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_confidence` SET TAGS ('dbx_business_glossary_term' = 'Decision Confidence');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Expiration Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Decision Outcome');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_value_regex' = 'approved|declined|conditional|referred');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Decision Override Allowed');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Decision Override Reason');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_reason` SET TAGS ('dbx_business_glossary_term' = 'Decision Reason');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_review_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Review Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_score_components` SET TAGS ('dbx_business_glossary_term' = 'Decision Score Components');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_source` SET TAGS ('dbx_business_glossary_term' = 'Decision Source');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_source` SET TAGS ('dbx_value_regex' = 'real_time|batch|manual');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_status` SET TAGS ('dbx_business_glossary_term' = 'Decision Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_status` SET TAGS ('dbx_value_regex' = 'pending|approved|declined|reversed|closed');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_tags` SET TAGS ('dbx_business_glossary_term' = 'Decision Tags');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decision Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_type` SET TAGS ('dbx_business_glossary_term' = 'Decision Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `decision_type` SET TAGS ('dbx_value_regex' = 'initial|reassessment|post_settlement');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `is_fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `is_high_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'High Risk Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `max_transaction_volume` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `mcc_allowed` SET TAGS ('dbx_business_glossary_term' = 'Allowed Merchant Category Codes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `mcc_blocked` SET TAGS ('dbx_business_glossary_term' = 'Blocked Merchant Category Codes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserve Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `reserve_rate` SET TAGS ('dbx_business_glossary_term' = 'Reserve Rate');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `risk_appetite_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Category');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `risk_score_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Model Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `tpv_cap` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Volume Cap');
ALTER TABLE `payments_fintech_ecm`.`risk`.`underwriting_decision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` SET TAGS ('dbx_subdomain' = 'risk_scoring');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `assessor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `digital_wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Exposure Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Assessed Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `risk_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `risk_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Profile Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Number');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|rejected');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'initial|periodic|triggered');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `average_transaction_value` SET TAGS ('dbx_business_glossary_term' = 'Average Transaction Value');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `compliance_flag_aml` SET TAGS ('dbx_business_glossary_term' = 'AML Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `compliance_flag_sanctions` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `credit_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `is_high_risk` SET TAGS ('dbx_business_glossary_term' = 'High Risk Indicator');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `is_manual_review` SET TAGS ('dbx_business_glossary_term' = 'Manual Review Indicator');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `mcc_category` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `operational_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Assessment Outcome');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'approved|declined|conditional|escalated');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `overall_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Assessed Party Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `party_type` SET TAGS ('dbx_value_regex' = 'merchant|cardholder|partner');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `regulatory_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Risk Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `reputational_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Reputational Risk Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `risk_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Exposure Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `risk_exposure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `risk_exposure_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `risk_model_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'gateway|fraud|wallet|compliance|manual');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `transaction_amount_last_30d` SET TAGS ('dbx_business_glossary_term' = '30‑Day Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `transaction_volume_last_30d` SET TAGS ('dbx_business_glossary_term' = '30‑Day Transaction Volume');
ALTER TABLE `payments_fintech_ecm`.`risk`.`assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` SET TAGS ('dbx_subdomain' = 'risk_scoring');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Event Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `cross_border_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Cross Border Payment Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `message_log_id` SET TAGS ('dbx_business_glossary_term' = 'Network Message Log Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Rate Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Request Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `risk_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Rule Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `transaction_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Device Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `wallet_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `affected_entity_ref` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `affected_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Entity Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `affected_entity_type` SET TAGS ('dbx_value_regex' = 'transaction|merchant|cardholder|account|digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Event Monetary Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Confidence Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|escalated');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `escalation_status` SET TAGS ('dbx_business_glossary_term' = 'Escalation Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `escalation_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `event_source` SET TAGS ('dbx_business_glossary_term' = 'Event Source');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `event_source` SET TAGS ('dbx_value_regex' = 'fraud_detection_platform|risk_engine|manual_review|external_feed');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'fraud|compliance|operational|dispute|risk_score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `is_manual_override` SET TAGS ('dbx_business_glossary_term' = 'Manual Override Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `is_threshold_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Threshold Exceeded Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `payload` SET TAGS ('dbx_business_glossary_term' = 'Event Payload');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `risk_dimension` SET TAGS ('dbx_business_glossary_term' = 'Risk Dimension');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `risk_dimension` SET TAGS ('dbx_value_regex' = 'fraud|aml|sanctions|exposure|chargeback|behavioral');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `risk_event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `risk_event_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `risk_event_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'gateway|processing|fraud|compliance|manual');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` SET TAGS ('dbx_subdomain' = 'policy_management');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `risk_case_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Case Identifier (RCID)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `cardholder_cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier (CHID)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `cardholder_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Identifier (CHID)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `created_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (CBUI)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `risk_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Detection Rule Identifier (DRI)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `dispute_case_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst Identifier (AAI)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `last_updated_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User Identifier (LUBUI)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `merchant_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MID)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `pos_terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `primary_risk_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst Identifier (AAI)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `primary_risk_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `primary_risk_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `related_case_risk_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Case Identifier (RCID)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `response_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Response Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `tertiary_risk_last_updated_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User Identifier (LUBUI)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `tertiary_risk_last_updated_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `tertiary_risk_last_updated_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Related Transaction Identifier (RTI)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `aml_status_at_time` SET TAGS ('dbx_business_glossary_term' = 'AML Status at Time (AMLST)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `case_category` SET TAGS ('dbx_business_glossary_term' = 'Case Category (CCAT)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `case_category` SET TAGS ('dbx_value_regex' = 'transaction|merchant|cardholder|system|policy');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Case Number (RCN)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `case_source` SET TAGS ('dbx_business_glossary_term' = 'Case Source (CSRC)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `case_source` SET TAGS ('dbx_value_regex' = 'fraud_detection|aml_monitoring|regulatory_audit|customer_report|internal_review');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Case Status (RCS)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|under_review|escalated|resolved|closed');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Case Type (RCT)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'fraud|aml|sanctions|compliance|dispute');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Timestamp (CCT)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status (CRS)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Record Creation Timestamp (CRCT)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp (DT)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag (EF)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level (EL)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `evidence_count` SET TAGS ('dbx_business_glossary_term' = 'Evidence Item Count (EIC)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `fraud_indicator_codes` SET TAGS ('dbx_business_glossary_term' = 'Fraud Indicator Codes (FIC)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `investigation_summary` SET TAGS ('dbx_business_glossary_term' = 'Investigation Summary (ISUM)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `is_high_risk` SET TAGS ('dbx_business_glossary_term' = 'High Risk Indicator (HRI)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `kyc_status_at_time` SET TAGS ('dbx_business_glossary_term' = 'KYC Status at Time (KYCST)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `mitigation_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Action Taken (MAT)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes (CNOTE)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Opened Timestamp (COT)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority (CPR)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Flag (RF)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome (RO)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `risk_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Exposure Amount (REA)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `risk_model_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Version (RMV)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `risk_score_at_creation` SET TAGS ('dbx_business_glossary_term' = 'Initial Risk Score (IRS)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `risk_score_current` SET TAGS ('dbx_business_glossary_term' = 'Current Risk Score (CRS)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `sanction_check_result` SET TAGS ('dbx_business_glossary_term' = 'Sanction Check Result (SCR)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `sanction_check_result` SET TAGS ('dbx_value_regex' = 'clear|matched|pending|blocked');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Case Severity (CSEV)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Case Subcategory (CSUB)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Case Tags (CTAG)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Record Update Timestamp (CRUT)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` SET TAGS ('dbx_subdomain' = 'limit_governance');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `concentration_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Concentration Exposure Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `risk_model_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Exposure Breach Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `breach_status` SET TAGS ('dbx_business_glossary_term' = 'Exposure Breach Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `breach_status` SET TAGS ('dbx_value_regex' = 'breached|within_limit|exceeded');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `concentration_exposure_status` SET TAGS ('dbx_business_glossary_term' = 'Concentration Exposure Record Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `concentration_exposure_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `dimension_code` SET TAGS ('dbx_business_glossary_term' = 'Concentration Dimension Code');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `dimension_type` SET TAGS ('dbx_business_glossary_term' = 'Concentration Dimension Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `dimension_type` SET TAGS ('dbx_value_regex' = 'mcc|geography|merchant|bin|rail');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Exposure Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Exposure Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Exposure Amount (USD)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `exposure_currency` SET TAGS ('dbx_business_glossary_term' = 'Exposure Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `exposure_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `exposure_limit` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit (USD)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `last_assessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Exposure Notes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Indicator');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `risk_model_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`concentration_exposure` ALTER COLUMN `utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Exposure Utilization Percentage');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` SET TAGS ('dbx_subdomain' = 'policy_management');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `risk_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Exception ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `requestor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `risk_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending|revoked');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `conditions_attached` SET TAGS ('dbx_business_glossary_term' = 'Exception Conditions');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Exception End Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'active|expired|revoked|cancelled');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type (TYPE)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'policy|model|threshold|manual');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Exception Outcome');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'success|failure|partial|not_applicable');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `overridden_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Overridden Threshold Unit');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `overridden_threshold_unit` SET TAGS ('dbx_value_regex' = 'score|amount|percentage');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `overridden_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Overridden Threshold Value');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `rationale` SET TAGS ('dbx_business_glossary_term' = 'Exception Rationale');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `requestor_entity` SET TAGS ('dbx_business_glossary_term' = 'Requestor Entity (ENTITY)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `requestor_entity` SET TAGS ('dbx_value_regex' = 'merchant|cardholder|partner|internal');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `requestor_role` SET TAGS ('dbx_business_glossary_term' = 'Requestor Role (ROLE)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `requestor_role` SET TAGS ('dbx_value_regex' = 'owner|operator|analyst|admin');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `risk_score_after` SET TAGS ('dbx_business_glossary_term' = 'Risk Score After Exception');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `risk_score_before` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Before Exception');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Start Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `transaction_amount_limit_override` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount Limit Override');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `transaction_volume_limit_override` SET TAGS ('dbx_business_glossary_term' = 'Transaction Volume Limit Override');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_exception` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` SET TAGS ('dbx_subdomain' = 'risk_scoring');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Indicator ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner User ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `owner_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner User ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `owner_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `owner_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `risk_model_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Model ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `breach_count` SET TAGS ('dbx_business_glossary_term' = 'Breach Count (BREACH_CNT)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Flag (BREACH)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Breach Severity (SEVERITY)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `breach_severity` SET TAGS ('dbx_value_regex' = 'green|amber|red|none');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `breach_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Breach Timestamp (BREACH_TS)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement (COMPLIANCE)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `compliance_requirement` SET TAGS ('dbx_value_regex' = 'PCI_DSS|GDPR|SOX|FATF|CCPA|BSA');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score (DQ_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System (DSS)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'fraud_platform|transaction_processing|merchant_management|digital_wallet|risk_compliance|dispute_management');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `indicator_description` SET TAGS ('dbx_business_glossary_term' = 'Key Risk Indicator (KRI) Description');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `indicator_name` SET TAGS ('dbx_business_glossary_term' = 'Key Risk Indicator (KRI) Name');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `indicator_status` SET TAGS ('dbx_business_glossary_term' = 'Indicator Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `indicator_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Archived Flag (ARCHIVED)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (REVIEW_DATE)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Indicator Value (VALUE)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `measurement_formula` SET TAGS ('dbx_business_glossary_term' = 'Measurement Formula (FORMULA)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency (FREQ)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|quarterly');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp (MEAS_TS)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department (DEPT)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag (REG_FLAG)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (REVIEW_FREQ)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category (CATEGORY)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'fraud|aml|operational|credit|liquidity|compliance');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `risk_model_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Version (VERSION)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `threshold_amber_high` SET TAGS ('dbx_business_glossary_term' = 'Amber Threshold Upper Bound (AMBER_HIGH)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `threshold_amber_low` SET TAGS ('dbx_business_glossary_term' = 'Amber Threshold Lower Bound (AMBER_LOW)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `threshold_green_high` SET TAGS ('dbx_business_glossary_term' = 'Green Threshold Upper Bound (GREEN_HIGH)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `threshold_green_low` SET TAGS ('dbx_business_glossary_term' = 'Green Threshold Lower Bound (GREEN_LOW)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `threshold_red_high` SET TAGS ('dbx_business_glossary_term' = 'Red Threshold Upper Bound (RED_HIGH)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `threshold_red_low` SET TAGS ('dbx_business_glossary_term' = 'Red Threshold Lower Bound (RED_LOW)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `trend_direction` SET TAGS ('dbx_business_glossary_term' = 'Trend Direction (TREND)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `trend_direction` SET TAGS ('dbx_value_regex' = 'up|down|stable|unknown');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'percentage|count|amount_usd|duration_seconds|rate_per_min|score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (UPDATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`indicator` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` SET TAGS ('dbx_subdomain' = 'limit_governance');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `credit_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `underwriting_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Underwriting Policy Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `available_credit` SET TAGS ('dbx_business_glossary_term' = 'Available Credit');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `available_credit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `available_credit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Credit Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `limit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `limit_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Limit Change Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `limit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `limit_reset_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Reset Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `limit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Limit Review Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `limit_source` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Source');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `limit_source` SET TAGS ('dbx_value_regex' = 'system|manual|api');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `limit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `limit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'revolving|installment|bnpl');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `risk_model_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `risk_score_at_assignment` SET TAGS ('dbx_business_glossary_term' = 'Risk Score at Assignment');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `risk_score_at_assignment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `utilization_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Utilization Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `utilization_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`credit_limit` ALTER COLUMN `utilization_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` SET TAGS ('dbx_subdomain' = 'policy_management');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `mitigation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Action ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Action Owner ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `cross_border_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Cross Border Payment Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `primary_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `related_mitigation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Related Mitigation Action ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `risk_model_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Model ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `risk_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Rule ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_category` SET TAGS ('dbx_business_glossary_term' = 'Action Category');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_category` SET TAGS ('dbx_value_regex' = 'financial|operational|compliance|fraud');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_reference` SET TAGS ('dbx_business_glossary_term' = 'Action Reference Code');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Action Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'reserve_increase|tpv_cap_reduction|mcc_restriction|account_suspension|enhanced_monitoring');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `is_manual` SET TAGS ('dbx_business_glossary_term' = 'Manual Action Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `limit_after_amount` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit After Action (Amount)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `limit_before_amount` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit Before Action (Amount)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `mitigation_action_description` SET TAGS ('dbx_business_glossary_term' = 'Action Description');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `mitigation_action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `mitigation_action_status` SET TAGS ('dbx_value_regex' = 'pending|active|completed|revoked|failed');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `risk_score_after` SET TAGS ('dbx_business_glossary_term' = 'Risk Score After Action');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `risk_score_before` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Before Action');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'risk_management|fraud_platform|compliance_system');
ALTER TABLE `payments_fintech_ecm`.`risk`.`mitigation_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` SET TAGS ('dbx_subdomain' = 'risk_scoring');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `model_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Validation ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `risk_model_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Model ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `auc_roc` SET TAGS ('dbx_business_glossary_term' = 'AUC‑ROC');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `data_snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Data Snapshot Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'production|sandbox|historical');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `exposure_limit` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `gini_coefficient` SET TAGS ('dbx_business_glossary_term' = 'Gini Coefficient');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `governance_signoff` SET TAGS ('dbx_business_glossary_term' = 'Governance Sign‑off');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `ks_statistic` SET TAGS ('dbx_business_glossary_term' = 'Kolmogorov‑Smirnov Statistic');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `model_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Model Algorithm');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `model_deployment_environment` SET TAGS ('dbx_business_glossary_term' = 'Model Deployment Environment');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `model_deployment_environment` SET TAGS ('dbx_value_regex' = 'dev|test|prod');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `model_feature_set_version` SET TAGS ('dbx_business_glossary_term' = 'Model Feature Set Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `model_input_schema_version` SET TAGS ('dbx_business_glossary_term' = 'Model Input Schema Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `model_owner` SET TAGS ('dbx_business_glossary_term' = 'Model Owner');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `model_training_data_version` SET TAGS ('dbx_business_glossary_term' = 'Model Training Data Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `outcome_reason` SET TAGS ('dbx_business_glossary_term' = 'Outcome Reason');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `performance_summary` SET TAGS ('dbx_business_glossary_term' = 'Performance Summary');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `psi` SET TAGS ('dbx_business_glossary_term' = 'Population Stability Index');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `risk_model_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Model Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `risk_model_type` SET TAGS ('dbx_value_regex' = 'credit|fraud|compliance|operational');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `risk_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Threshold');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `signoff_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sign‑off Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Validation Duration (Seconds)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_error_count` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Count');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Validation Methodology');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Validation Outcome');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_outcome` SET TAGS ('dbx_value_regex' = 'approved|conditionally_approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_report_url` SET TAGS ('dbx_business_glossary_term' = 'Validation Report URL');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_type` SET TAGS ('dbx_business_glossary_term' = 'Validation Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_type` SET TAGS ('dbx_value_regex' = 'initial|periodic|champion_challenger|regulatory');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_validation` ALTER COLUMN `validation_warning_count` SET TAGS ('dbx_business_glossary_term' = 'Validation Warning Count');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` SET TAGS ('dbx_subdomain' = 'limit_governance');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `counterparty_risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Risk Limit ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `forward_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Fx Forward Contract Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `risk_model_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Model ID');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `collateral_required` SET TAGS ('dbx_business_glossary_term' = 'Collateral Required Flag');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `collateral_type` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `collateral_type` SET TAGS ('dbx_value_regex' = 'cash|security|guarantee|none');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `collateral_value` SET TAGS ('dbx_business_glossary_term' = 'Collateral Value');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `counterparty_risk_limit_status` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Risk Limit Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `counterparty_risk_limit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_value_regex' = 'acquiring_bank|issuing_bank|card_scheme|psp|partner');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `last_utilization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Utilization Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `limit_code` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Risk Limit Code');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `limit_tenor_days` SET TAGS ('dbx_business_glossary_term' = 'Limit Tenor (Days)');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Type');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'settlement_exposure|intraday_credit|fx_exposure|liquidity');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `utilization_amount` SET TAGS ('dbx_business_glossary_term' = 'Utilized Amount');
ALTER TABLE `payments_fintech_ecm`.`risk`.`counterparty_risk_limit` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `payments_fintech_ecm`.`risk`.`rule_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`rule_assignment` SET TAGS ('dbx_subdomain' = 'policy_management');
ALTER TABLE `payments_fintech_ecm`.`risk`.`rule_assignment` SET TAGS ('dbx_association_edges' = 'risk.risk_rule,product.payment_product');
ALTER TABLE `payments_fintech_ecm`.`risk`.`rule_assignment` ALTER COLUMN `rule_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Rule Assignment - Risk Rule Assignment Id');
ALTER TABLE `payments_fintech_ecm`.`risk`.`rule_assignment` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Rule Assignment - Payment Product Id');
ALTER TABLE `payments_fintech_ecm`.`risk`.`rule_assignment` ALTER COLUMN `risk_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Rule Assignment - Risk Rule Id');
ALTER TABLE `payments_fintech_ecm`.`risk`.`rule_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective From');
ALTER TABLE `payments_fintech_ecm`.`risk`.`rule_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Until');
ALTER TABLE `payments_fintech_ecm`.`risk`.`rule_assignment` ALTER COLUMN `rule_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_currency_pair_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_currency_pair_assignment` SET TAGS ('dbx_subdomain' = 'risk_scoring');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_currency_pair_assignment` SET TAGS ('dbx_association_edges' = 'risk.risk_model,fx.currency_pair');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_currency_pair_assignment` ALTER COLUMN `model_currency_pair_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Modelcurrencypairassignment - Model Currency Pair Assignment Id');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_currency_pair_assignment` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Modelcurrencypairassignment - Currency Pair Id');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_currency_pair_assignment` ALTER COLUMN `risk_model_id` SET TAGS ('dbx_business_glossary_term' = 'Modelcurrencypairassignment - Risk Model Id');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_currency_pair_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_currency_pair_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`risk`.`model_currency_pair_assignment` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Model Version');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` SET TAGS ('dbx_subdomain' = 'policy_management');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `annual_transaction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `annual_transaction_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `region` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `region` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `risk_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `trade_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`party` ALTER COLUMN `trade_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_policy` SET TAGS ('dbx_subdomain' = 'policy_management');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_policy` ALTER COLUMN `risk_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Policy Identifier');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_policy` ALTER COLUMN `superseded_risk_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_policy` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_policy` ALTER COLUMN `escalation_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_policy` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `payments_fintech_ecm`.`risk`.`risk_policy` ALTER COLUMN `escalation_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
