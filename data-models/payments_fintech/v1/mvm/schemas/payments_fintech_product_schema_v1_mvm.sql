-- Schema for Domain: product | Business: Payments Fintech | Version: v1_mvm
-- Generated on: 2026-05-03 21:29:51

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `payments_fintech_ecm`.`product` COMMENT 'SSOT for the payment product and pricing catalog — card programs, BNPL offerings, P2P transfer products, A2A rails, virtual account products, fee schedule configurations, pricing plans, promotional offers, bundled services, and product eligibility rules used across merchant and cardholder agreements.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`payment_product` (
    `payment_product_id` BIGINT COMMENT 'System‑generated unique identifier for the payment product.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Foreign key linking to gateway.acquirer_endpoint. Business justification: Primary acquirer endpoint assigned to a payment product for settlement and processing, required for settlement reporting.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Regulatory reporting of product issuance requires linking each payment product to its issuing partner for compliance and revenue sharing.',
    `irf_table_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_table. Business justification: Required for pricing engine to map each payment product to the specific IRF table that defines its interchange rates, used in rate calculation reports.',
    `multi_network_routing_id` BIGINT COMMENT 'Foreign key linking to network.multi_network_routing. Business justification: Durbin Amendment compliance mandates debit payment products support multiple unaffiliated networks. Linking payment_product to a multi_network_routing profile enables least-cost routing assignment, Du',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Each payment product is subject to specific regulatory obligations; mapping enables compliance monitoring.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Revenue Posting: Each payment product’s transaction fees and interchange income must be posted to a specific GL account for financial reporting and regulatory compliance.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Required for mapping each payment product to its card scheme for interchange fee calculation, compliance reporting and settlement routing.',
    `aml_screening_required` BOOLEAN COMMENT 'Indicates whether AML screening is performed on transactions of this product.',
    `compliance_status` STRING COMMENT 'Current compliance verification state of the product.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the product record was first created.',
    `effective_from` DATE COMMENT 'Date when the product becomes legally effective.',
    `effective_until` DATE COMMENT 'Date when the product ceases to be effective; null if open‑ended.',
    `eligibility_criteria` STRING COMMENT 'Business rules that determine which merchants or cardholders may use the product.',
    `is_contactless_supported` BOOLEAN COMMENT 'True if the product can be used for contactless (NFC) transactions.',
    `is_international_supported` BOOLEAN COMMENT 'True if the product can be used for cross‑border payments.',
    `is_online_supported` BOOLEAN COMMENT 'True if the product can be used for online e‑commerce transactions.',
    `is_tokenizable` BOOLEAN COMMENT 'Indicates whether the product supports tokenization of sensitive data.',
    `kyc_required` BOOLEAN COMMENT 'Indicates whether KYC verification is mandatory for using the product.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Upper limit for a single transaction processed with this product.',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'Lower limit for a single transaction processed with this product.',
    `notes` STRING COMMENT 'Free‑form field for internal comments or special handling instructions.',
    `payment_product_category` STRING COMMENT 'Target market segment for the product.. Valid values are `consumer|business|partner`',
    `payment_product_code` STRING COMMENT 'Business‑unique alphanumeric code used to reference the product in downstream systems.. Valid values are `^[A-Z0-9_]{3,10}$`',
    `payment_product_description` STRING COMMENT 'Full textual description of the product, its purpose and key features.',
    `payment_product_name` STRING COMMENT 'Human‑readable name of the payment product.',
    `payment_product_status` STRING COMMENT 'Current lifecycle status of the product.. Valid values are `active|inactive|pending|retired|suspended`',
    `product_type` STRING COMMENT 'High‑level classification of the payment product.. Valid values are `card|bnpl|p2p|a2a|virtual_account|digital_wallet`',
    `product_version` STRING COMMENT 'Semantic version identifier for the product definition.',
    `regulatory_classification` STRING COMMENT 'Regulatory regimes that apply to the product.. Valid values are `pci|psd2|sox|gdpr|ccpa`',
    `risk_tier` STRING COMMENT 'Risk classification assigned to the product based on fraud and compliance exposure.. Valid values are `low|medium|high|critical`',
    `supported_rails` STRING COMMENT 'Payment networks or clearing rails the product can be processed on.. Valid values are `visa|mastercard|ach|swift|sepa|upi`',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Fixed surcharge amount applied when surcharge_applicable is true.',
    `surcharge_applicable` BOOLEAN COMMENT 'True if a surcharge may be added to the transaction fee.',
    `tokenization_method` STRING COMMENT 'Technique used to generate tokens for the product.. Valid values are `pan_token|device_token|account_token`',
    `transaction_fee_fixed_amount` DECIMAL(18,2) COMMENT 'Flat fee amount applied per transaction, in the products currency.',
    `transaction_fee_percent` DECIMAL(18,2) COMMENT 'Variable percentage fee applied to each transaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the product record.',
    `version_effective_from` DATE COMMENT 'Date when this product version became effective.',
    `version_effective_until` DATE COMMENT 'Date when this product version was superseded; null if current.',
    CONSTRAINT pk_payment_product PRIMARY KEY(`payment_product_id`)
) COMMENT 'Master catalog of all payment products offered by the platform — card programs (credit, debit, prepaid), BNPL offerings, P2P transfer products, A2A rail products, virtual account products, and digital wallet products. Each record defines a distinct product type with its commercial identity, lifecycle status, supported rails, and regulatory classification. SSOT for product identity across merchant and cardholder agreements.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`card_program` (
    `card_program_id` BIGINT COMMENT 'Unique system-generated identifier for the card program.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Foreign key linking to gateway.acquirer_endpoint. Business justification: Card program must reference issuing acquirer endpoint for BIN allocation and settlement.',
    `dcc_config_id` BIGINT COMMENT 'Foreign key linking to fx.dcc_config. Business justification: Card programs enabling international transactions require DCC configuration to offer cardholders currency choice at point-of-sale. Core business process: program setup includes DCC enablement rules an',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Card programs are owned and managed by a partner bank; linking enables program governance, fee allocation, and audit trails.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: A card program is a specialized instantiation of a payment product — it represents a branded card product issued under a specific scheme. The master payment_product catalog is the SSOT for all product',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Fee Accounting: Card program fees (annual, network, surcharge) are allocated to a dedicated GL account to track expense and revenue per program.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Card programs are issued under a specific scheme; linking enables eligibility checks, regulatory approval tracking, and scheme‑specific fee structures.',
    `audit_trail_notes` STRING COMMENT 'Free‑form notes capturing audit‑related observations or manual overrides.',
    `bin_end` STRING COMMENT 'Last six digits of the BIN range allocated to the program.',
    `bin_start` STRING COMMENT 'First six digits of the BIN range allocated to the program.',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the program.. Valid values are `compliant|non_compliant|under_review`',
    `contactless_enabled` BOOLEAN COMMENT 'Indicates whether contactless (NFC) payments are enabled for the program.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `daily_spend_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate spend allowed per cardholder per day, expressed in the program currency.',
    `digital_wallet_enabled` BOOLEAN COMMENT 'Flag indicating if the program can be provisioned to digital wallets.',
    `effective_end_date` DATE COMMENT 'Date when the program is terminated or expires; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the program becomes legally binding and operational.',
    `eligibility_criteria` STRING COMMENT 'Business rules that determine which merchants or cardholders may enroll in the program.',
    `emv_configuration` STRING COMMENT 'EMV chip specifications and version used for the program.',
    `fee_structure` STRING COMMENT 'Description of the fee model applied to merchants (e.g., flat, tiered, volume‑based).',
    `interchange_qualification` STRING COMMENT 'Description of the interchange qualification rules applicable to the program.',
    `is_3ds_enabled` BOOLEAN COMMENT 'Indicates whether 3‑Domain Secure authentication is required.',
    `is_fraud_detection_enabled` BOOLEAN COMMENT 'Flag indicating if real‑time fraud detection rules are applied to the program.',
    `is_tokenization_supported` BOOLEAN COMMENT 'Indicates whether the program supports tokenization of PANs.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Upper bound for a single transaction amount.',
    `merchant_category_code` STRING COMMENT 'Default MCC assigned to transactions under this program.',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'Lower bound for a single transaction amount.',
    `program_description` STRING COMMENT 'Detailed description of the card program, including its value proposition and target market.',
    `program_name` STRING COMMENT 'Human‑readable name of the card program as marketed to merchants and cardholders.',
    `program_status` STRING COMMENT 'Current lifecycle status of the card program.. Valid values are `active|inactive|suspended|pending|retired`',
    `program_type` STRING COMMENT 'Classification of the program (e.g., credit, debit, prepaid, commercial, virtual, gift).. Valid values are `credit|debit|prepaid|commercial|virtual|gift`',
    `program_version` STRING COMMENT 'Version identifier for the program configuration (e.g., v1.0, v2.1).',
    `regulatory_approval_date` DATE COMMENT 'Date when the program received all required regulatory approvals.',
    `risk_score` STRING COMMENT 'Numerical risk rating (0‑100) assigned by the fraud risk engine.',
    `spending_control_enabled` BOOLEAN COMMENT 'Flag indicating if program‑level spending controls (e.g., daily limits) are active.',
    `surcharge_applicable` BOOLEAN COMMENT 'Indicates whether surcharges are allowed on the program.',
    `surcharge_rate` DECIMAL(18,2) COMMENT 'Percentage surcharge applied to qualifying transactions.',
    `token_service_provider` STRING COMMENT 'Name of the token service provider used for the program.',
    `transaction_type_supported` STRING COMMENT 'Types of transactions the program permits.. Valid values are `purchase|cash_advance|balance_transfer|online|offline`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the program record.',
    CONSTRAINT pk_card_program PRIMARY KEY(`card_program_id`)
) COMMENT 'Defines a card program as a distinct business entity — a branded card product issued under a specific BIN range, card scheme (Visa, Mastercard, Amex), and issuing bank arrangement. Captures program type (credit, debit, prepaid, commercial), co-brand partnerships, EMV configuration, contactless enablement, and program-level spending controls. Links to BIN registry and interchange qualification rules.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` (
    `bnpl_plan_id` BIGINT COMMENT 'Unique surrogate key for each BNPL plan template.',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Cross-border BNPL plans must specify supported currency pairs for installment calculations and FX conversion. Business need: multi-currency BNPL requires defined currency pair for converting purchase ',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: BNPL plans are provided by a partner; the link supports partner‑specific risk scoring, KYC, and revenue‑share calculations.',
    `eligibility_rule_id` BIGINT COMMENT 'Foreign key linking to product.eligibility_rule. Business justification: bnpl_plan carries three denormalized eligibility fields (eligibility_cardholder_segments, eligibility_merchant_category_codes, eligibility_merchant_ids) that duplicate the structured eligibility logic',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Interest Revenue: BNPL plans generate interest income that must be recorded in a designated GL account for accurate revenue recognition and compliance.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: BNPL plans are defined for a specific payment product; child BNPL plan references parent payment_product.',
    `product_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to product.product_fee_schedule. Business justification: bnpl_plan carries a denormalized fee_schedule_description string field and embedded fee parameters (early_repayment_fee_percent, late_payment_fee_amount) that should be governed by a formal product_fe',
    `allowed_countries` STRING COMMENT 'Comma‑separated list of ISO 3166‑1 alpha‑3 country codes where the plan is offered.',
    `bnpl_plan_description` STRING COMMENT 'Detailed description of the plan, including marketing copy and eligibility notes.',
    `bnpl_plan_status` STRING COMMENT 'Current lifecycle status of the plan.. Valid values are `active|inactive|draft|retired|suspended`',
    `compliance_regulation_codes` STRING COMMENT 'Comma‑separated list of regulation identifiers (e.g., PCI_DSS, PSD2) that this plan must satisfy.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the plan record was first created in the system.',
    `disallowed_countries` STRING COMMENT 'Comma‑separated list of ISO 3166‑1 alpha‑3 country codes where the plan is prohibited.',
    `early_repayment_fee_percent` DECIMAL(18,2) COMMENT 'Fee charged as a percentage of the outstanding balance if the cardholder repays early.',
    `effective_end_date` DATE COMMENT 'Date when the plan is retired or expires; null for open‑ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the plan becomes available for enrollment.',
    `installment_count` STRING COMMENT 'Total number of equal payments the cardholder must make.',
    `installment_interval_days` STRING COMMENT 'Number of days between successive installment due dates.',
    `interest_rate_annual_percent` DECIMAL(18,2) COMMENT 'Standard annual interest rate applied to the outstanding balance after any promotional period.',
    `is_promotion_active` BOOLEAN COMMENT 'Indicates whether the plan is currently being marketed as a promotion.',
    `late_payment_fee_amount` DECIMAL(18,2) COMMENT 'Flat fee applied when an installment is missed or paid after the due date.',
    `late_payment_grace_period_days` STRING COMMENT 'Number of days after the due date before a late fee is assessed.',
    `max_installment_amount` DECIMAL(18,2) COMMENT 'Upper bound on the amount of any single installment.',
    `max_total_amount` DECIMAL(18,2) COMMENT 'Maximum total purchase amount that can be financed under this plan.',
    `maximum_credit_limit` DECIMAL(18,2) COMMENT 'Upper bound on the total credit exposure a cardholder can have under this plan.',
    `min_installment_amount` DECIMAL(18,2) COMMENT 'Lower bound on the amount of any single installment.',
    `min_total_amount` DECIMAL(18,2) COMMENT 'Minimum total purchase amount required to qualify for the plan.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount required for a purchase to qualify for this BNPL plan.',
    `plan_code` STRING COMMENT 'External business identifier used in merchant and cardholder agreements.',
    `plan_name` STRING COMMENT 'Human‑readable name of the BNPL installment plan.',
    `plan_type` STRING COMMENT 'Category of BNPL offering: installment, revolving credit, or hybrid.. Valid values are `installment|revolving|hybrid`',
    `promotional_apr_end_date` DATE COMMENT 'Last date the promotional APR is applied; after this the standard APR applies.',
    `promotional_apr_percent` DECIMAL(18,2) COMMENT 'Reduced APR offered during the promotional window.',
    `promotional_apr_start_date` DATE COMMENT 'First date the promotional APR becomes effective.',
    `repayment_schedule_type` STRING COMMENT 'Method used to calculate installment amounts.. Valid values are `fixed|declining|custom`',
    `requires_credit_check` BOOLEAN COMMENT 'Indicates whether a creditworthiness assessment is performed before approval.',
    `requires_kyc` BOOLEAN COMMENT 'Indicates whether Know‑Your‑Customer verification is mandatory for enrollment.',
    `risk_score_threshold` DECIMAL(18,2) COMMENT 'Minimum risk score a cardholder must have to be eligible for this plan.',
    `updated_by` STRING COMMENT 'Identifier of the internal user or process that last updated the plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the plan record.',
    CONSTRAINT pk_bnpl_plan PRIMARY KEY(`bnpl_plan_id`)
) COMMENT 'Master definition of Buy Now Pay Later installment plan structures offered to cardholders and merchants. Captures installment count, interest rate, promotional APR windows, minimum purchase threshold, maximum credit limit, merchant eligibility criteria, and repayment schedule logic. Distinct from a cardholders active BNPL enrollment — this is the plan template in the product catalog.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` (
    `product_fee_schedule_id` BIGINT COMMENT 'Unique system-generated identifier for each fee schedule record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.agreement. Business justification: Fee schedules are often governed by partner agreements, especially for scheme fees, acquirer fees, and revenue-sharing arrangements. Real business process: contract compliance verification, fee reconc',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Multi-currency fee schedules require currency pair specification for cross-border merchant pricing. Essential for determining applicable fees when transaction currency differs from settlement currency',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Fee Booking: Each product fee schedule defines fees that are posted to a specific GL account to ensure proper expense/revenue tracking.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Fee schedules can be governed by regulatory rules; linking captures which obligations drive fee structures.',
    `scheme_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to network.scheme_fee_schedule. Business justification: Product fee schedules must be reconciled against scheme-published fee schedules for scheme billing and pass-through fee compliance. Linking product_fee_schedule to network.scheme_fee_schedule enables ',
    `scheme_fee_table_id` BIGINT COMMENT 'Foreign key linking to interchange.scheme_fee_table. Business justification: Fee schedules for products must align with scheme fee tables; FK ensures consistency and supports fee audit reports.',
    `applicable_card_type` STRING COMMENT 'Card types eligible for the fee.. Valid values are `credit|debit|prepaid|virtual|contactless`',
    `applicable_mcc` STRING COMMENT 'MCC values for which the fee applies.',
    `applicable_product_code` STRING COMMENT 'Product code to which this fee schedule applies.',
    `applicable_region` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code where the fee is valid.',
    `applicable_transaction_type` STRING COMMENT 'Transaction message types to which the fee applies.. Valid values are `sale|auth|capture|refund|void|settlement`',
    `calculation_method` STRING COMMENT 'Method used to compute the fee.. Valid values are `flat|percentage|tiered|per_transaction`',
    `compliance_regulation` STRING COMMENT 'Regulatory framework(s) governing the fee (e.g., PSD2, PCI DSS). [ENUM-REF-CANDIDATE: PSD2|PCI_DSS|SOX|GDPR|CCPA|FATF|OFAC|other — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fee schedule record was created.',
    `effective_from` DATE COMMENT 'Date when the fee schedule becomes binding.',
    `effective_until` DATE COMMENT 'Date when the fee schedule expires or is superseded (null for open‑ended).',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount charged per applicable event, expressed in the fee_currency.',
    `fee_application_scope` STRING COMMENT 'Geographic scope of the fee.. Valid values are `domestic|cross_border|both`',
    `fee_category` STRING COMMENT 'Category of the fee such as transaction, monthly, setup, chargeback, FX, BNPL, interchange, MDR, MSF. [ENUM-REF-CANDIDATE: transaction|monthly|annual|setup|chargeback|fx|bnpl|interchange|mdr|msf|other — promote to reference product]',
    `fee_code` STRING COMMENT 'Business‑defined unique code for the fee schedule entry.',
    `fee_description` STRING COMMENT 'Detailed narrative describing the fee purpose and calculation.',
    `fee_name` STRING COMMENT 'Human‑readable name of the fee (e.g., "MDR Tier 1", "FX Markup").',
    `fee_rate` DECIMAL(18,2) COMMENT 'Percentage‑based rate applied to the transaction amount (e.g., 0.0250 for 2.5%).',
    `fee_source` STRING COMMENT 'Origin of the fee cost.. Valid values are `interchange|issuer|acquirer|network|internal|partner`',
    `fee_taxable` BOOLEAN COMMENT 'Indicates whether the fee is subject to tax.',
    `is_promotional` BOOLEAN COMMENT 'True if the fee is part of a promotional offer.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether the fee recurs on a schedule.',
    `max_fee_cap` DECIMAL(18,2) COMMENT 'Upper limit on the fee amount that can be charged.',
    `min_fee_floor` DECIMAL(18,2) COMMENT 'Lower bound on the fee amount that will be charged.',
    `notes` STRING COMMENT 'Free‑form comments or business rationale for the fee.',
    `product_fee_schedule_status` STRING COMMENT 'Current lifecycle status of the fee schedule.. Valid values are `active|inactive|deprecated|pending`',
    `promotional_end_date` DATE COMMENT 'Date when the promotional fee expires.',
    `promotional_start_date` DATE COMMENT 'Date when the promotional fee becomes effective.',
    `recurrence_interval` STRING COMMENT 'Interval at which a recurring fee is applied.. Valid values are `monthly|quarterly|yearly|none`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the fee has been validated against applicable regulations (e.g., PSD2, PCI).',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate (e.g., 0.0700 for 7%).',
    `tier_level` STRING COMMENT 'Ordinal number of the tier when the fee uses a tiered structure.',
    `tier_max_volume` DECIMAL(18,2) COMMENT 'Maximum transaction volume or amount for this tier.',
    `tier_min_volume` DECIMAL(18,2) COMMENT 'Minimum transaction volume or amount that qualifies for this tier.',
    `tier_rate` DECIMAL(18,2) COMMENT 'Rate applied within this tier (percentage or flat).',
    `updated_by` STRING COMMENT 'User or system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fee schedule record.',
    `version_number` STRING COMMENT 'Sequential version number for change tracking.',
    CONSTRAINT pk_product_fee_schedule PRIMARY KEY(`product_fee_schedule_id`)
) COMMENT 'Master fee schedule defining all fee types, rates, and calculation methods applicable to a payment product or pricing plan. Covers MDR tiers, MSF rates, interchange pass-through configurations, monthly maintenance fees, transaction fees, chargeback fees, FX markup fees, and BNPL origination fees. Each schedule is versioned and effective-dated to support regulatory and commercial changes.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` (
    `fee_schedule_line_id` BIGINT COMMENT 'Unique surrogate key for each fee schedule line record.',
    `product_fee_schedule_id` BIGINT COMMENT 'Identifier of the fee schedule to which this line belongs.',
    `amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount applied when rate_type is flat.',
    `applicable_product_code` STRING COMMENT 'Identifier of the product (e.g., card program, BNPL) for which the fee is applicable.',
    `applicable_transaction_type` STRING COMMENT 'Type of transaction that triggers this fee line.. Valid values are `authorization|capture|settlement|refund|chargeback|reversal`',
    `compliance_flag` STRING COMMENT 'Indicates if the fee line is subject to specific compliance regimes.. Valid values are `pci|aml|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the fee schedule line was first inserted.',
    `effective_from` DATE COMMENT 'Start date of the fee lines validity period.',
    `effective_until` DATE COMMENT 'End date of the fee lines validity period; null indicates indefinite.',
    `fee_category` STRING COMMENT 'High‑level classification of the fee (e.g., interchange, network, service).. Valid values are `interchange|network|processor|service|other`',
    `fee_component_name` STRING COMMENT 'Descriptive name of the fee component (e.g., "MDR Flat Fee").',
    `fee_description` STRING COMMENT 'Narrative description providing context for the fee component.',
    `fee_schedule_line_status` STRING COMMENT 'Operational status of the fee line.. Valid values are `active|inactive|pending|retired`',
    `fee_source` STRING COMMENT 'Origin of the fee definition (e.g., internal policy, partner agreement, regulatory mandate).. Valid values are `internal|partner|regulatory`',
    `is_taxable` BOOLEAN COMMENT 'True if the fee is subject to tax, otherwise false.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system that last modified the record.',
    `line_sequence` STRING COMMENT 'Sequential position of the line within the fee schedule.',
    `max_cap` DECIMAL(18,2) COMMENT 'Upper bound on the fee amount for this line.',
    `min_cap` DECIMAL(18,2) COMMENT 'Lower bound on the fee amount for this line.',
    `percentage` DECIMAL(18,2) COMMENT 'Percentage applied to the transaction amount when rate_type is percentage.',
    `rate_type` STRING COMMENT 'Calculation method for the fee line.. Valid values are `flat|percentage|tiered|blended`',
    `regulatory_code` STRING COMMENT 'Reference to the regulatory rule or standard that mandates or influences the fee.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Percentage tax rate applied to the fee when is_taxable is true.',
    `tier_end_amount` DECIMAL(18,2) COMMENT 'Maximum transaction amount that qualifies for this tier.',
    `tier_rate` DECIMAL(18,2) COMMENT 'Percentage fee applied to transactions whose amount falls within the tier range.',
    `tier_start_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount that qualifies for this tier.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the fee line.',
    `version_number` STRING COMMENT 'Incremental version of the fee line for audit and change management.',
    CONSTRAINT pk_fee_schedule_line PRIMARY KEY(`fee_schedule_line_id`)
) COMMENT 'Individual line-item entries within a fee schedule, each representing a single fee component with its own rate type (flat, percentage, tiered, blended), applicable transaction type, currency, minimum/maximum cap, and effective date range. Enables granular fee modeling for complex MDR structures, interchange-plus pricing, and tiered volume discounts.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` (
    `product_pricing_plan_id` BIGINT COMMENT 'Unique surrogate key for the pricing plan record.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Pricing plans are negotiated with partners; the FK supports partner‑specific pricing rules and audit.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Pricing Impact: Pricing plans affect transaction fees and discounts; linking to a GL account enables automated posting of pricing-related revenue and expense.',
    `product_fee_schedule_id` BIGINT COMMENT 'Reference to the fee schedule definition applied by the plan.',
    `program_id` BIGINT COMMENT 'Foreign key linking to interchange.interchange_program. Business justification: Pricing plans are built on specific interchange programs; linking allows automated plan generation and regulatory reporting of program‑based rates.',
    `approval_date` DATE COMMENT 'Date the plan received final approval.',
    `approval_status` STRING COMMENT 'Current approval workflow state of the plan.',
    `approved_by` STRING COMMENT 'Identifier of the user or system that approved the plan.',
    `compliance_review_status` STRING COMMENT 'Result of the compliance review for the plan.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing plan record was first created in the system.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Discount applied to fees within the tier, expressed as a decimal fraction.',
    `discount_tier_end` DECIMAL(18,2) COMMENT 'Upper bound of transaction volume for a discount tier.',
    `discount_tier_start` DECIMAL(18,2) COMMENT 'Lower bound of transaction volume for a discount tier.',
    `effective_end_date` DATE COMMENT 'Date the pricing plan ceases to be binding (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date the pricing plan becomes binding for the counterparties.',
    `eligibility_criteria` STRING COMMENT 'Business rules that determine which merchants or cardholders may use the plan.',
    `external_reference_code` STRING COMMENT 'Identifier used by external partners or legacy systems to reference the plan.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fixed fee component of the plan, expressed in the plan currency.',
    `fee_cap_amount` DECIMAL(18,2) COMMENT 'Maximum fee that can be charged under the plan per defined period.',
    `fee_cap_type` STRING COMMENT 'Granularity of the fee cap (per transaction, monthly, or annual).. Valid values are `per_transaction|monthly|annual`',
    `fee_percentage` DECIMAL(18,2) COMMENT 'Variable fee component expressed as a decimal fraction (e.g., 0.0250 = 2.50%).',
    `is_default_plan` BOOLEAN COMMENT 'True if this plan is the default offering for its category.',
    `is_test_plan` BOOLEAN COMMENT 'True if the plan is used for testing or sandbox environments.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum transaction value for which the plan fees apply.',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'Minimum transaction value for which the plan fees apply.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the plan.',
    `plan_category` STRING COMMENT 'High‑level category of the product offering (e.g., transaction‑based, subscription, BNPL).. Valid values are `transaction|subscription|installment|bnpl|p2p|a2a`',
    `plan_code` STRING COMMENT 'External business identifier for the pricing plan, used in contracts and merchant agreements.',
    `plan_name` STRING COMMENT 'Human‑readable name of the pricing plan.',
    `plan_type` STRING COMMENT 'Indicates whether the plan applies to merchants, cardholders, or both.. Valid values are `merchant|cardholder|both`',
    `pricing_model` STRING COMMENT 'Pricing methodology used in the plan.. Valid values are `flat|interchange_plus|tiered|blended`',
    `product_pricing_plan_description` STRING COMMENT 'Detailed description of the plan, including purpose and scope.',
    `product_pricing_plan_status` STRING COMMENT 'Current lifecycle status of the plan.. Valid values are `active|inactive|pending|suspended|retired|draft`',
    `promotional_discount_rate` DECIMAL(18,2) COMMENT 'Discount rate applied during the promotional window.',
    `promotional_window_end` DATE COMMENT 'End date of any promotional pricing period.',
    `promotional_window_start` DATE COMMENT 'Start date of any promotional pricing period.',
    `regulatory_approval_flag` BOOLEAN COMMENT 'Indicates whether the plan has passed all required regulatory approvals.',
    `sales_channel` STRING COMMENT 'Channel through which the plan was offered to the counterparties.. Valid values are `online|partner|direct|api`',
    `termination_date` DATE COMMENT 'Date the plan was terminated, if applicable.',
    `termination_reason` STRING COMMENT 'Reason for plan termination (e.g., regulatory, business decision).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the pricing plan record.',
    `version_number` STRING COMMENT 'Sequential version of the plan for change management.',
    CONSTRAINT pk_product_pricing_plan PRIMARY KEY(`product_pricing_plan_id`)
) COMMENT 'Commercial pricing plan assigned to merchants or cardholders, bundling a fee schedule with interchange model (flat-rate, interchange-plus, tiered, blended), volume discount thresholds, and promotional pricing windows. Tracks plan version, effective dates, approval status, and the sales channel through which the plan was offered. SSOT for the commercial pricing agreement at the plan level.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` (
    `eligibility_rule_id` BIGINT COMMENT 'System-generated unique identifier for the eligibility rule.',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to fx.payment_corridor. Business justification: Eligibility rules restrict products by payment corridor (e.g., only EU→UK corridor eligible for certain card programs due to regulatory or risk constraints). Business need: corridor-based product elig',
    `payment_product_id` BIGINT COMMENT 'Identifier of the payment product or pricing plan governed by this rule.',
    `bin_range_end` STRING COMMENT 'Last six digits of the issuing BIN that marks the end of the applicable range.',
    `bin_range_start` STRING COMMENT 'First six digits of the issuing BIN that marks the start of the applicable range.',
    `cardholder_segment` STRING COMMENT 'Segment label of cardholders (e.g., consumer, corporate) to which the rule applies.',
    `condition_expression` STRING COMMENT 'Logical expression (e.g., SQL‑like or DSL) that defines the rule criteria.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code for geographic eligibility; empty when not a geography rule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created in the system.',
    `effective_from` DATE COMMENT 'Date on which the rule becomes active.',
    `effective_until` DATE COMMENT 'Date on which the rule expires; null for open‑ended.',
    `eligibility_rule_description` STRING COMMENT 'Free‑form description of the rule purpose and business rationale.',
    `eligibility_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|draft|retired`',
    `is_override_allowed` BOOLEAN COMMENT 'Indicates whether an authorized user can override the rule for a specific case.',
    `kyc_tier` STRING COMMENT 'KYC verification tier required for eligibility.. Valid values are `low|medium|high|very_high`',
    `mcc_code` STRING COMMENT 'MCC that the rule filters on; empty when not an MCC‑type rule.',
    `merchant_segment` STRING COMMENT 'Segment label of merchants (e.g., enterprise, SMB) to which the rule applies.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the rule.',
    `override_authority` STRING COMMENT 'Entity authorized to perform an override when allowed.. Valid values are `system|admin|compliance`',
    `priority` STRING COMMENT 'Integer indicating rule precedence when multiple rules apply (lower number = higher priority).',
    `region_code` STRING COMMENT 'Sub‑national region or state code used for finer geographic filtering.',
    `risk_score_max` DECIMAL(18,2) COMMENT 'Highest risk‑score value (inclusive) for which the rule applies.',
    `risk_score_min` DECIMAL(18,2) COMMENT 'Lowest risk‑score value (inclusive) for which the rule applies.',
    `rule_category` STRING COMMENT 'High‑level classification of what the rule applies to (e.g., merchant, cardholder, segment).. Valid values are `merchant|cardholder|segment|product|pricing|promotion`',
    `rule_code` STRING COMMENT 'Business code that uniquely identifies the rule within the product catalog.',
    `rule_logic` STRING COMMENT 'Indicates whether matching entities are included or excluded by the rule.. Valid values are `include|exclude`',
    `rule_name` STRING COMMENT 'Human‑readable name of the rule used in UI and reports.',
    `rule_type` STRING COMMENT 'Specific type of eligibility filter expressed by the rule.. Valid values are `mcc_restriction|bin_range|geography|tpv_threshold|kyc_tier|risk_score_band`',
    `tpv_threshold` DECIMAL(18,2) COMMENT 'Cumulative TPV amount that must be met or exceeded for the rule to be applicable.',
    `transaction_amount_max` DECIMAL(18,2) COMMENT 'Upper bound of transaction amount for which the rule applies.',
    `transaction_amount_min` DECIMAL(18,2) COMMENT 'Lower bound of transaction amount (in the product currency) for which the rule applies.',
    `updated_by` STRING COMMENT 'Identifier of the user or process that last updated the rule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the rule.',
    `version` STRING COMMENT 'Version number of the rule definition; increments on each change.',
    CONSTRAINT pk_eligibility_rule PRIMARY KEY(`eligibility_rule_id`)
) COMMENT 'Business rules governing which merchants, cardholders, or segments are eligible for a given payment product, pricing plan, or promotional offer. Captures rule type (MCC restriction, BIN range filter, geography, TPV threshold, KYC tier, risk score band), rule logic (include/exclude), effective dates, and override authority. Used by onboarding and agreement workflows to validate product assignment.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`version` (
    `version_id` BIGINT COMMENT 'Unique identifier for the product version record.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Product versions track changes to a payment product; child version references parent payment_product.',
    `aml_screening_required` BOOLEAN COMMENT 'Indicates whether AML screening is performed for transactions using this product.',
    `approval_authority` STRING COMMENT 'Name or role of the individual/committee that approved the version.',
    `approval_date` DATE COMMENT 'Date the version was approved.',
    `approval_status` STRING COMMENT 'Result of the approval workflow for this version.. Valid values are `approved|rejected|pending|revoked`',
    `change_reason` STRING COMMENT 'Narrative explaining why the product definition was changed.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the product version.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the version record was first created.',
    `effective_from` DATE COMMENT 'Date when this product version becomes binding.',
    `effective_until` DATE COMMENT 'Date when this product version ceases to be binding (null for open‑ended).',
    `eligibility_criteria` STRING COMMENT 'Business rules that determine which merchants or cardholders may use the product.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Primary monetary fee associated with the product version.',
    `interchange_fee_category` STRING COMMENT 'Category of interchange fee applied to the product.. Valid values are `IRF|MDR|MSF|DCC|Other`',
    `is_contactless_supported` BOOLEAN COMMENT 'True if the product can be used for contactless transactions.',
    `is_international_supported` BOOLEAN COMMENT 'True if the product can be used for cross‑border payments.',
    `is_online_supported` BOOLEAN COMMENT 'True if the product can be used for online e‑commerce transactions.',
    `is_tokenizable` BOOLEAN COMMENT 'Indicates whether the product supports tokenization of payment credentials.',
    `kyc_required` BOOLEAN COMMENT 'Indicates whether Know‑Your‑Customer verification is required for this product.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum allowed transaction amount for this product version.',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'Minimum allowed transaction amount for this product version.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the product version.',
    `product_code` STRING COMMENT 'Business code used to reference the product in external systems.',
    `product_name` STRING COMMENT 'Human‑readable name of the payment product.',
    `product_type` STRING COMMENT 'Category of the payment product (e.g., card, BNPL, P2P, A2A, virtual account, digital wallet).. Valid values are `card|bnpl|p2p|a2a|virtual_account|digital_wallet`',
    `regulatory_classification` STRING COMMENT 'Regulatory category (e.g., PCI‑DSS, PSD2, AML) applicable to the product.',
    `risk_tier` STRING COMMENT 'Risk classification assigned to the product version.. Valid values are `low|medium|high|critical`',
    `settlement_cycle` STRING COMMENT 'Standard settlement timing for the product (e.g., T+0, T+1).. Valid values are `T+0|T+1|T+2|T+3|T+4|T+5`',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Fixed surcharge amount applied when surcharge_applicable is true.',
    `surcharge_applicable` BOOLEAN COMMENT 'Indicates whether a surcharge may be applied to the product.',
    `tokenization_method` STRING COMMENT 'Method used for tokenizing payment data (e.g., DPAN, HCE, Token Service Provider).. Valid values are `DPAN|HCE|TSP`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the version record.',
    `version_number` STRING COMMENT 'Sequential version number of the product definition.',
    `version_status` STRING COMMENT 'Current lifecycle status of the product version.. Valid values are `active|inactive|deprecated|pending|retired|draft`',
    CONSTRAINT pk_version PRIMARY KEY(`version_id`)
) COMMENT 'Tracks the versioned lifecycle of a payment product definition — capturing each material change to product terms, fee structures, regulatory classifications, or feature sets. Stores version number, change reason, approval authority, effective date, and the delta from the prior version. Supports regulatory audit trails and backward-compatible product agreement references.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`rate_tier` (
    `rate_tier_id` BIGINT COMMENT 'Unique surrogate key for the rate tier definition.',
    `product_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to product.product_fee_schedule. Business justification: rate_tier is described as volume-based rate tier definitions used within pricing plans AND fee schedules. Currently rate_tier only has product_pricing_plan_id, but product_fee_schedule also has embe',
    `product_pricing_plan_id` BIGINT COMMENT 'Foreign key linking to product.product_pricing_plan. Business justification: Rate tiers are defined within a pricing plan; linking rate_tier to product_pricing_plan clarifies hierarchy and eliminates the redundant payment_product_id column.',
    `compliance_status` STRING COMMENT 'Result of internal compliance review for the tier definition.. Valid values are `pending|approved|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tier record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the tier becomes effective.',
    `effective_until` DATE COMMENT 'Date when the tier expires or is superseded; null for open‑ended.',
    `eligibility_criteria` STRING COMMENT 'Business rules or conditions that must be satisfied for a merchant or portfolio to qualify for this tier.',
    `fee_cap_amount` DECIMAL(18,2) COMMENT 'Maximum fee that can be charged under this tier, if a cap applies.',
    `fee_cap_type` STRING COMMENT 'Frequency or basis of the fee cap (e.g., per transaction, per month, per year).. Valid values are `per_transaction|monthly|annual`',
    `is_default_tier` BOOLEAN COMMENT 'Flag indicating whether this tier is the default when no other tier matches.',
    `max_volume` DECIMAL(18,2) COMMENT 'Upper bound of the volume band for this tier.',
    `min_volume` DECIMAL(18,2) COMMENT 'Lower bound of the volume band that triggers this tier.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the tier.',
    `rate_tier_status` STRING COMMENT 'Current lifecycle status of the tier.. Valid values are `active|inactive|deprecated`',
    `rate_type` STRING COMMENT 'Indicates whether the tier rate is a percentage of the transaction amount or a fixed monetary amount.. Valid values are `percentage|fixed`',
    `rate_value` DECIMAL(18,2) COMMENT 'Numeric value of the rate applied within the tier (percentage expressed as decimal or fixed amount).',
    `regulatory_approval_flag` BOOLEAN COMMENT 'Indicates whether the tier has received required regulatory sign‑off.',
    `tier_code` STRING COMMENT 'Business code used to reference the tier in pricing rules.',
    `tier_name` STRING COMMENT 'Human‑readable name of the pricing tier.',
    `tier_priority` STRING COMMENT 'Numeric priority used to resolve overlapping tiers; lower numbers have higher precedence.',
    `tier_type` STRING COMMENT 'Classification of the tier based on the metric it governs (e.g., volume‑based, transaction‑based, value‑based).. Valid values are `volume|transaction|value`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tier record.',
    `volume_unit` STRING COMMENT 'Unit used for the volume thresholds (e.g., transaction count or currency).. Valid values are `transaction|usd|eur|gbp|jpy`',
    CONSTRAINT pk_rate_tier PRIMARY KEY(`rate_tier_id`)
) COMMENT 'Volume-based rate tier definitions used within pricing plans and fee schedules — specifying TPV bands (e.g., $0–$10K, $10K–$100K, $100K+) and the corresponding MDR or MSF rate applicable at each tier. Supports both merchant-level and portfolio-level tiered pricing models. Effective-dated to support periodic rate reviews.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` (
    `interchange_qualification_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each interchange qualification configuration record.',
    `card_program_id` BIGINT COMMENT 'Foreign key linking to product.card_program. Business justification: interchange_qualification is described as product-level interchange qualification configuration mapping card program and transaction attributes — the entity description explicitly references card pr',
    `currency_pair_id` BIGINT COMMENT 'Foreign key linking to fx.currency_pair. Business justification: Interchange qualification rules differ by currency pair (domestic vs cross-border, specific currency combinations). Business need: scheme compliance requires currency-specific interchange qualificatio',
    `irf_rate_category_id` BIGINT COMMENT 'Foreign key linking to interchange.irf_rate_category. Business justification: Needed for product qualification rules to reference the exact interchange rate category, enabling compliance checks and pricing simulations.',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: Interchange qualification settings apply to a payment product; child qualification references parent payment_product.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Interchange qualification categories (Visa CPS, Mastercard Merit, Amex OptBlue) are scheme-specific. Linking interchange_qualification to scheme enables scheme-specific qualification rule management, ',
    `authorization_method` STRING COMMENT 'Mechanism used to obtain transaction authorization.. Valid values are `online|offline|fallback`',
    `card_type` STRING COMMENT 'Type of card instrument the qualification applies to.. Valid values are `debit|credit|prepaid|commercial|corporate`',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the qualification against applicable standards.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification record was first created in the system.',
    `effective_from` DATE COMMENT 'Date on which the qualification becomes effective for new transactions.',
    `effective_until` DATE COMMENT 'Date after which the qualification is no longer applicable (null for open‑ended).',
    `entry_mode` STRING COMMENT 'Method by which card data was entered for the transaction.. Valid values are `chip|magstripe|contactless|manual|mobile`',
    `interchange_category` STRING COMMENT 'Resulting interchange rate category that the qualification maps to.. Valid values are `visa_cps_retail|mc_merit_iii|interac_interac|discover|jcb`',
    `interchange_qualification_description` STRING COMMENT 'Free‑form description of the qualification logic and any special notes.',
    `interchange_qualification_status` STRING COMMENT 'Current lifecycle status of the qualification configuration.. Valid values are `active|inactive|pending|retired`',
    `notes` STRING COMMENT 'Additional free‑form remarks or operational comments.',
    `qualification_code` STRING COMMENT 'Business identifier code used in downstream systems to reference this qualification configuration.',
    `qualification_name` STRING COMMENT 'Human‑readable name describing the qualification rule set (e.g., "Visa CPS Retail Qualification").',
    `qualification_type` STRING COMMENT 'Category of product to which the qualification applies (e.g., card program, BNPL offering, P2P transfer).. Valid values are `card_program|bnpl|p2p|a2a|virtual_account`',
    `regulatory_approval_flag` BOOLEAN COMMENT 'True if the qualification has received formal regulatory approval.',
    `sca_compliance` BOOLEAN COMMENT 'Indicates whether the transaction flow meets Strong Customer Authentication requirements.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the qualification record.',
    `version_effective_from` DATE COMMENT 'Date when this version of the qualification became effective.',
    `version_effective_until` DATE COMMENT 'Date when this version ceased to be effective (null if current).',
    `version_number` STRING COMMENT 'Incremental version identifier for change management.',
    CONSTRAINT pk_interchange_qualification PRIMARY KEY(`interchange_qualification_id`)
) COMMENT 'Product-level interchange qualification configuration mapping card program and transaction attributes (card type, entry mode, MCC, authorization method, SCA compliance) to the expected interchange rate category (e.g., Visa CPS Retail, MC Merit III). Distinct from the interchange rate table owned by the interchange domain — this entity defines the qualification logic for a products expected interchange outcome.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`p2p_product` (
    `p2p_product_id` BIGINT COMMENT 'Unique identifier for the P2P product.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: P2P products are typically provided by a partner; the FK enables partner‑level fee schedules and fraud monitoring.',
    `gateway_api_credential_id` BIGINT COMMENT 'Foreign key linking to gateway.gateway_api_credential. Business justification: P2P products require dedicated API credentials for wallet provider integration, KYC/AML screening APIs, and cross-border remittance gateways. Real-world P2P platforms configure product-specific creden',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: P2P transfer products are a type of payment product; child P2P product references parent payment_product.',
    `product_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to product.product_fee_schedule. Business justification: p2p_product currently carries denormalized fee fields (fee_cap_amount, fee_fixed_amount, fee_percentage) that duplicate the authoritative fee structure defined in product_fee_schedule. Adding product_',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: P2P products generate fee revenue that must be recognized in specific GL revenue accounts. Financial statement preparation and revenue recognition schedules require direct GL mapping for P2P transacti',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: P2P products (Visa Direct, Mastercard Send) operate on specific card network schemes. Scheme association drives routing, interchange qualification, compliance rules, and SLA enforcement. A payments do',
    `aml_screening_required` BOOLEAN COMMENT 'Indicates if Anti-Money Laundering screening is performed for transfers.',
    `compliance_status` STRING COMMENT 'Current compliance status of the product.. Valid values are `compliant|non_compliant|pending_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the product record was created.',
    `cross_border_allowed` BOOLEAN COMMENT 'Indicates if cross-border transfers are permitted.',
    `currency_supported` STRING COMMENT 'Currency in which transfers are settled.. Valid values are `USD|EUR|GBP|JPY|AUD|CAD`',
    `daily_limit` DECIMAL(18,2) COMMENT 'Maximum cumulative amount allowed per day.',
    `effective_from` DATE COMMENT 'Date when the product becomes effective.',
    `effective_until` DATE COMMENT 'Date when the product ceases to be effective, if applicable.',
    `funding_sources` STRING COMMENT 'Supported funding source types for the P2P product.. Valid values are `debit_card|bank_account|wallet_balance`',
    `fx_eligibility` BOOLEAN COMMENT 'Indicates if foreign exchange is supported for cross-border transfers.',
    `is_contactless_supported` BOOLEAN COMMENT 'Indicates if contactless transfers (e.g., NFC) are supported.',
    `is_default_plan` BOOLEAN COMMENT 'Indicates if this product uses the default pricing plan.',
    `is_international_supported` BOOLEAN COMMENT 'Indicates if the product supports international transfers.',
    `is_online_supported` BOOLEAN COMMENT 'Indicates if the product can be used via online channels.',
    `is_test_product` BOOLEAN COMMENT 'Indicates if this product is for testing purposes only.',
    `is_tokenizable` BOOLEAN COMMENT 'Indicates if the product supports tokenization of payment credentials.',
    `jurisdiction` STRING COMMENT 'Primary jurisdiction where the product is offered. [ENUM-REF-CANDIDATE: USA|GBR|CAN|AUS|DEU|FRA|JPN|SGP — 8 candidates stripped; promote to reference product]',
    `kyc_required` BOOLEAN COMMENT 'Indicates if Know Your Customer verification is required for using the product.',
    `monthly_limit` DECIMAL(18,2) COMMENT 'Maximum cumulative amount allowed per month.',
    `notes` STRING COMMENT 'Additional free-form notes about the product.',
    `p2p_product_code` STRING COMMENT 'Unique business code for the P2P product.',
    `p2p_product_description` STRING COMMENT 'Detailed description of the P2P product offering.',
    `p2p_product_name` STRING COMMENT 'Human readable name of the P2P product offering.',
    `p2p_product_status` STRING COMMENT 'Current lifecycle status of the product.. Valid values are `active|inactive|deprecated|pending`',
    `per_transaction_limit` DECIMAL(18,2) COMMENT 'Maximum amount allowed per individual transfer.',
    `product_type` STRING COMMENT 'Type of P2P transfer offered.. Valid values are `instant|scheduled|cross_border`',
    `promotional_offer_code` STRING COMMENT 'Code of any promotional offer linked to the product.',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the product per jurisdiction.. Valid values are `regulated|unregulated|restricted|exempt`',
    `tokenization_method` STRING COMMENT 'Method used for tokenizing payment credentials.. Valid values are `device_token|virtual_token|network_token`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the product record was last updated.',
    CONSTRAINT pk_p2p_product PRIMARY KEY(`p2p_product_id`)
) COMMENT 'Master definition of Peer-to-Peer transfer products offered on the platform — including instant P2P, scheduled P2P, and cross-border P2P variants. Captures supported funding sources (debit card, bank account, wallet balance), transfer limits, FX eligibility, SLA for fund availability, and regulatory classification per jurisdiction. Distinct from A2A rail products which are bank-to-bank.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`a2a_product` (
    `a2a_product_id` BIGINT COMMENT 'Unique system-generated identifier for the A2A product.',
    `acquirer_endpoint_id` BIGINT COMMENT 'Foreign key linking to gateway.acquirer_endpoint. Business justification: Account-to-account products require specific acquirer/bank endpoints for direct debit and instant payment rails (FPS, SEPA Instant, RTP). Real-world A2A platforms configure product-to-endpoint mapping',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Account‑to‑account products are offered by a partner institution; linking is required for settlement routing and compliance reporting.',
    `payment_corridor_id` BIGINT COMMENT 'Foreign key linking to fx.payment_corridor. Business justification: A2A products are inherently corridor-specific (SEPA for EU, Faster Payments for UK, ACH for US). Business process: A2A product configuration requires corridor definition for routing, settlement instru',
    `payment_product_id` BIGINT COMMENT 'Foreign key linking to product.payment_product. Business justification: An A2A (Account-to-Account) transfer rail product is a specialized payment product type. Like p2p_product (which already has payment_product_id), a2a_product should reference the master payment_produc',
    `product_fee_schedule_id` BIGINT COMMENT 'Reference to the fee schedule governing this product.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: A2A products generate transaction fee revenue requiring GL account mapping for revenue recognition. Financial reporting and product profitability analysis depend on tracking A2A revenue to specific GL',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: A2A products (ACH, SEPA, Faster Payments) operate on specific payment schemes. Scheme association is required for routing rule application, SLA compliance monitoring, scheme fee billing, and ISO 20022',
    `a2a_product_code` STRING COMMENT 'Business‑oriented code used to reference the product in external systems.',
    `a2a_product_description` STRING COMMENT 'Detailed description of the product offering.',
    `a2a_product_name` STRING COMMENT 'Human‑readable name of the A2A transfer product.',
    `a2a_product_status` STRING COMMENT 'Current lifecycle state of the product.. Valid values are `active|inactive|draft|retired`',
    `aml_screening_required` BOOLEAN COMMENT 'Indicates whether AML screening is performed on transactions using this product.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the product.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the product record was first created.',
    `effective_from` DATE COMMENT 'Date when the product becomes effective.',
    `effective_until` DATE COMMENT 'Date when the product ceases to be effective (null if open‑ended).',
    `eligibility_criteria` STRING COMMENT 'Business rules that determine which parties may use the product.',
    `interchange_fee_category` STRING COMMENT 'Category of interchange fee applicable to the product.. Valid values are `IRF|MDR|MSF`',
    `is_contactless_supported` BOOLEAN COMMENT 'Indicates if contactless transactions are allowed.',
    `is_international_supported` BOOLEAN COMMENT 'Indicates if cross‑border transfers are permitted.',
    `is_online_supported` BOOLEAN COMMENT 'Indicates if the product can be used for online transfers.',
    `is_tokenizable` BOOLEAN COMMENT 'Indicates whether the product supports tokenization of payment credentials.',
    `iso_20022_version` STRING COMMENT 'Version of the ISO 20022 message schema used for this product.. Valid values are `v2.0|v2.1|v3.0`',
    `kyc_required` BOOLEAN COMMENT 'Indicates whether KYC verification is mandatory for using this product.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Upper monetary limit per transaction for this product.',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'Lower monetary limit per transaction for this product.',
    `notes` STRING COMMENT 'Free‑form field for any extra information.',
    `product_type` STRING COMMENT 'Category of the A2A rail (e.g., ACH, RTP, RTGS, SWIFT, Open Banking).. Valid values are `ACH|RTP|RTGS|SWIFT|OPEN_BANKING`',
    `product_version` STRING COMMENT 'Human‑readable version label for the product.',
    `regulatory_classification` STRING COMMENT 'Classification for regulatory reporting purposes.. Valid values are `domestic|cross_border`',
    `regulatory_reporting` STRING COMMENT 'Regulatory frameworks applicable to the product.. Valid values are `RegE|PSD2|FATF|SOX`',
    `risk_tier` STRING COMMENT 'Risk classification for the product based on fraud exposure.. Valid values are `low|medium|high`',
    `settlement_window_days` STRING COMMENT 'Number of days between transaction initiation and settlement.',
    `stp_eligibility` BOOLEAN COMMENT 'Indicates whether transactions can be processed end‑to‑end without manual intervention.',
    `supported_rails` STRING COMMENT 'List of transfer rails supported by this product.. Valid values are `ACH|SAME_DAY_ACH|RTP|RTGS|SWIFT|OPEN_BANKING`',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Fixed surcharge amount applied when surcharge_applicable is true.',
    `surcharge_applicable` BOOLEAN COMMENT 'Whether a surcharge may be applied to the transaction.',
    `surcharge_rate` DECIMAL(18,2) COMMENT 'Percentage‑based surcharge applied when surcharge_applicable is true.',
    `tokenization_method` STRING COMMENT 'Method used for tokenization when supported.. Valid values are `DPAN|HCE|TSP`',
    `transaction_fee_fixed_amount` DECIMAL(18,2) COMMENT 'Fixed monetary fee applied to each transaction.',
    `transaction_fee_percent` DECIMAL(18,2) COMMENT 'Percentage‑based fee applied to each transaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the product record.',
    `version_effective_from` DATE COMMENT 'Date when this version becomes effective.',
    `version_effective_until` DATE COMMENT 'Date when this version expires (null if ongoing).',
    `version_number` STRING COMMENT 'Sequential version number for product changes.',
    CONSTRAINT pk_a2a_product PRIMARY KEY(`a2a_product_id`)
) COMMENT 'Master definition of Account-to-Account transfer rail products — ACH (standard and same-day), RTP, RTGS, SWIFT, and open banking A2A variants. Captures supported rails, settlement windows, transaction limits, STP eligibility, ISO 20022 message schema version, and regulatory reporting obligations (Reg E, PSD2). Distinct from P2P products which are consumer-wallet-funded.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` (
    `virtual_account_product_id` BIGINT COMMENT 'Unique system-generated identifier for the virtual account product.',
    `card_program_id` BIGINT COMMENT 'Identifier of the issuing program or card program to which this virtual account belongs.',
    `ecosystem_partner_id` BIGINT COMMENT 'Foreign key linking to partner.ecosystem_partner. Business justification: Virtual account products are issued and managed by ecosystem partners (banks, fintechs). Operations require tracking which partner provides each virtual account product for settlement, compliance, and',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Virtual account products hold customer balances that must be tracked as liabilities on the balance sheet. Financial reporting and regulatory capital adequacy calculations require mapping virtual accou',
    `nostro_account_id` BIGINT COMMENT 'Foreign key linking to fx.nostro_account. Business justification: Virtual accounts for cross-border use must be backed by specific nostro accounts for settlement. Business need: liquidity management and settlement routing for multi-currency virtual accounts require ',
    `product_fee_schedule_id` BIGINT COMMENT 'Reference to the fee schedule that defines fees applicable to this product.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Virtual accounts are e-money instruments regulated under EMD2/PSD2 in EU, state money transmitter laws in US. Compliance teams must map obligations to products for licensing and audit purposes.',
    `scheme_id` BIGINT COMMENT 'Foreign key linking to network.scheme. Business justification: Virtual accounts inherit scheme rules (tokenization, KYC, fee models); a FK provides accurate scheme association for audit and compliance.',
    `activation_date` DATE COMMENT 'Date when the virtual account becomes active and usable.',
    `allowed_mcc_codes` STRING COMMENT 'Comma‑separated list of Merchant Category Codes permitted for transactions on this virtual account.',
    `aml_screening_required` BOOLEAN COMMENT 'Specifies if Anti‑Money‑Laundering screening is performed on the account holder.',
    `bin_end` STRING COMMENT 'Last six digits of the Bank Identification Number range assigned to this product.. Valid values are `^d{6}$`',
    `bin_start` STRING COMMENT 'First six digits of the Bank Identification Number range assigned to this product.. Valid values are `^d{6}$`',
    `classification` STRING COMMENT 'Business classification that groups the product for reporting and eligibility rules.. Valid values are `card_program|b2b_payables|expense_management|marketplace_disbursement`',
    `compliance_status` STRING COMMENT 'Indicates whether the product meets all applicable compliance requirements.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the product record was first created in the system.',
    `daily_spend_limit` DECIMAL(18,2) COMMENT 'Maximum aggregate spend allowed per calendar day.',
    `effective_from` DATE COMMENT 'Date when the product becomes effective for issuance.',
    `effective_until` DATE COMMENT 'Date when the product ceases to be offered (null if open‑ended).',
    `expiry_date` DATE COMMENT 'Date on which the virtual account automatically expires if not used.',
    `is_contactless_supported` BOOLEAN COMMENT 'Indicates whether the virtual account can be used for contactless transactions.',
    `is_international_supported` BOOLEAN COMMENT 'Indicates whether the virtual account can be used for cross‑border payments.',
    `is_online_supported` BOOLEAN COMMENT 'Indicates whether the virtual account can be used for online e‑commerce transactions.',
    `is_tokenizable` BOOLEAN COMMENT 'Indicates whether the virtual account number can be tokenized for secure usage.',
    `issuance_fee_amount` DECIMAL(18,2) COMMENT 'One‑time fee charged when the virtual account is created.',
    `kyc_required` BOOLEAN COMMENT 'Specifies if Know‑Your‑Customer verification is mandatory for activation.',
    `maintenance_fee_amount` DECIMAL(18,2) COMMENT 'Recurring fee for maintaining the virtual account product.',
    `max_balance_amount` DECIMAL(18,2) COMMENT 'Upper bound on the cumulative balance that can be held in the virtual account.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Absolute ceiling for any single transaction processed with this virtual account.',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'Floor amount below which a transaction will be declined.',
    `product_code` STRING COMMENT 'Business‑defined alphanumeric code that uniquely identifies the product in catalogs and pricing systems.',
    `product_type` STRING COMMENT 'Indicates whether the virtual account is single‑use, multi‑use, or a virtual IBAN.. Valid values are `single_use|multi_use|virtual_iban`',
    `promo_eligible` BOOLEAN COMMENT 'Indicates whether the product can be included in promotional offers.',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory approval for the product.. Valid values are `approved|pending|rejected`',
    `risk_tier` STRING COMMENT 'Risk classification used for underwriting and fraud monitoring.. Valid values are `low|medium|high`',
    `settlement_cycle` STRING COMMENT 'Frequency at which funds are settled to the underlying account.. Valid values are `daily|weekly|monthly`',
    `spend_control_rules` STRING COMMENT 'JSON‑encoded rules that define merchant category restrictions, geographic limits, and velocity controls.',
    `surcharge_applicable` BOOLEAN COMMENT 'Indicates whether a surcharge may be applied to transactions using this product.',
    `token_service_provider` STRING COMMENT 'Name of the third‑party token service provider, if tokenization is enabled.',
    `tokenization_method` STRING COMMENT 'Method used to tokenize the virtual account number (Token Service Provider, Host Card Emulation, or none).. Valid values are `tsp|hce|none`',
    `transaction_limit_amount` DECIMAL(18,2) COMMENT 'Maximum amount allowed for a single transaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the product record.',
    `virtual_account_product_description` STRING COMMENT 'Free‑form description of the virtual account product, including marketing and functional details.',
    `virtual_account_product_name` STRING COMMENT 'Human‑readable name of the virtual account product.',
    `virtual_account_product_status` STRING COMMENT 'Current lifecycle status of the product.. Valid values are `active|inactive|retired|pending`',
    CONSTRAINT pk_virtual_account_product PRIMARY KEY(`virtual_account_product_id`)
) COMMENT 'Master definition of virtual account products — single-use virtual card numbers, multi-use virtual accounts, and virtual IBANs issued for B2B payables, expense management, or marketplace disbursements. Captures account type, BIN assignment, spending controls, expiry logic, tokenization method (TSP/HCE), and the issuing program it belongs to.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`feature` (
    `feature_id` BIGINT COMMENT 'Unique identifier for the product feature.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Features with fee_amount or fee_percentage generate incremental revenue requiring GL mapping. Revenue recognition and product margin analysis need to allocate feature fees to appropriate GL revenue ac',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Features may be mandated by particular regulations; linking tracks required regulatory obligations per feature.',
    `activation_rules` STRING COMMENT 'Business rules or conditions that must be satisfied for the feature to be activated (e.g., eligibility criteria, risk thresholds).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the feature record was first created.',
    `effective_from` DATE COMMENT 'Date when the feature becomes available for activation.',
    `effective_until` DATE COMMENT 'Date when the feature is retired or no longer available (null if indefinite).',
    `feature_code` STRING COMMENT 'Unique business code used to reference the feature in configurations and contracts.',
    `feature_description` STRING COMMENT 'Detailed description of the feature, its purpose and behavior.',
    `feature_name` STRING COMMENT 'Human‑readable name of the feature.',
    `feature_status` STRING COMMENT 'Current lifecycle status of the feature.. Valid values are `active|inactive|deprecated|pending`',
    `feature_type` STRING COMMENT 'Categorization of the feature based on its functional role.. Valid values are `capability|control|service|addon`',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount charged when the feature is enabled (applicable when fee_impact_type = fixed).',
    `fee_impact_type` STRING COMMENT 'How the feature influences pricing (no impact, fixed fee, percentage fee, or tiered fee).. Valid values are `none|fixed|percentage|tiered`',
    `fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of transaction amount charged when the feature is enabled (applicable when fee_impact_type = percentage).',
    `is_enabled_by_default` BOOLEAN COMMENT 'Indicates whether the feature is enabled by default on new product instances.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the feature.',
    `regulatory_dependency` STRING COMMENT 'Regulations or standards that govern the use of this feature.. Valid values are `PCI_DSS|PSD2|EMV|SCA|AML|KYC`',
    `requires_3ds` BOOLEAN COMMENT 'Indicates whether 3‑D Secure authentication is required when the feature is used.',
    `requires_aml` BOOLEAN COMMENT 'Indicates whether Anti‑Money‑Laundering screening is required for the feature.',
    `requires_contactless` BOOLEAN COMMENT 'Indicates whether contactless (NFC) capability is required for the feature.',
    `requires_dcc` BOOLEAN COMMENT 'Indicates whether Dynamic Currency Conversion is required for the feature.',
    `requires_international` BOOLEAN COMMENT 'Indicates whether the feature can be used for cross‑border or international payments.',
    `requires_kyc` BOOLEAN COMMENT 'Indicates whether Know‑Your‑Customer verification is required to enable the feature.',
    `requires_online` BOOLEAN COMMENT 'Indicates whether the feature is applicable only to online transactions.',
    `requires_tokenization` BOOLEAN COMMENT 'Indicates whether tokenization of payment credentials is mandatory for the feature.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk rating associated with the feature (higher values indicate greater risk).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the feature record.',
    `version_number` STRING COMMENT 'Version number of the feature definition, incremented on each change.',
    CONSTRAINT pk_feature PRIMARY KEY(`feature_id`)
) COMMENT 'Catalog of discrete features and capabilities that can be enabled or disabled on a payment product — e.g., contactless NFC, 3DS authentication, DCC, instalment conversion, rewards accrual, spend controls, real-time notifications, and open banking data sharing. Each feature has its own activation rules, regulatory dependencies, and fee implications. Supports modular product configuration.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`feature_assignment` (
    `feature_assignment_id` BIGINT COMMENT 'System-generated unique identifier for each product-feature assignment record.',
    `feature_id` BIGINT COMMENT 'Identifier of the feature (e.g., 3DS, DCC, tokenization) being enabled for the product.',
    `payment_product_id` BIGINT COMMENT 'Identifier of the payment product or card program to which the feature is assigned.',
    `activation_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the feature became active for the product.',
    `agreement_code` STRING COMMENT 'Reference code of the merchant or cardholder agreement that triggered the feature activation.',
    `approval_status` STRING COMMENT 'Result of the governance review for enabling the feature.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the approval decision was recorded.',
    `approved_by` BIGINT COMMENT 'Identifier of the user or system that approved the feature activation.',
    `channel` STRING COMMENT 'Channel or source through which the feature was activated (e.g., online portal, API call, partner integration).. Valid values are `online|api|partner|internal`',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the feature assignment.. Valid values are `compliant|non_compliant|exempt`',
    `configuration_parameters` STRING COMMENT 'JSON‑encoded key‑value pairs for feature‑specific settings (e.g., 3DS version, DCC markup rate).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the assignment record was first created in the system.',
    `deactivation_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the feature was de‑activated or expired; null if still active.',
    `feature_assignment_status` STRING COMMENT 'Current lifecycle status of the feature assignment.. Valid values are `active|inactive|pending|suspended|revoked`',
    `is_default` BOOLEAN COMMENT 'Indicates whether the feature is the default setting for the product.',
    `notes` STRING COMMENT 'Free‑form comments or audit trail notes related to the assignment.',
    `risk_tier` STRING COMMENT 'Risk classification associated with enabling the feature for the product.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the assignment record.',
    `version` STRING COMMENT 'Incremental version number tracking changes to the assignment record.',
    CONSTRAINT pk_feature_assignment PRIMARY KEY(`feature_assignment_id`)
) COMMENT 'Association entity recording which features are enabled on a specific payment product or card program, including activation date, configuration parameters (e.g., 3DS version, DCC markup rate), approval status, and the channel or agreement that triggered the feature activation. Enables per-product feature matrix management.';

CREATE OR REPLACE TABLE `payments_fintech_ecm`.`product`.`limit` (
    `limit_id` BIGINT COMMENT 'Unique surrogate key for each product limit definition.',
    `bnpl_plan_id` BIGINT COMMENT 'Foreign key linking to product.bnpl_plan. Business justification: The limit table has a bnpl_credit_exposure_limit field and max_installments/installment_interval_days fields that are clearly BNPL-specific limit configurations. Limits can be scoped to specific BNPL ',
    `payment_product_id` BIGINT COMMENT 'FK to product.payment_product',
    `amount` DECIMAL(18,2) COMMENT 'Numeric value representing the primary monetary threshold for the limit.',
    `atm_withdrawal_cap_amount` DECIMAL(18,2) COMMENT 'Maximum cash withdrawal amount per ATM transaction.',
    `audit_trail_notes` STRING COMMENT 'Free‑form notes capturing audit actions or change rationale.',
    `bnpl_credit_exposure_limit` DECIMAL(18,2) COMMENT 'Total credit exposure allowed for a BNPL product.',
    `compliance_status` STRING COMMENT 'Indicates whether the limit has been reviewed and approved for compliance.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the limit record was first created.',
    `cross_border_limit_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount allowed for cross‑border transactions.',
    `daily_cumulative_limit` DECIMAL(18,2) COMMENT 'Aggregate monetary limit for all transactions within a calendar day.',
    `effective_from` DATE COMMENT 'Date when the limit becomes active.',
    `effective_until` DATE COMMENT 'Date when the limit expires or is superseded (null for open‑ended).',
    `enforcement_mode` STRING COMMENT 'Indicates whether the limit is a hard block (transaction declined) or a soft alert.. Valid values are `hard|soft`',
    `installment_interval_days` STRING COMMENT 'Number of days between successive BNPL installments.',
    `is_cross_border_allowed` BOOLEAN COMMENT 'Indicates whether the limit applies to cross‑border transactions.',
    `limit_category` STRING COMMENT 'Broad category of the limit, indicating the business purpose.. Valid values are `transaction|velocity|credit|atm|cross_border|bnpl`',
    `limit_code` STRING COMMENT 'Business code used to reference the limit in downstream systems.',
    `limit_description` STRING COMMENT 'Free‑form description providing additional context for the limit.',
    `limit_name` STRING COMMENT 'Human‑readable name describing the limit (e.g., "Daily Transaction Cap").',
    `limit_status` STRING COMMENT 'Current lifecycle status of the limit definition.. Valid values are `active|inactive|pending|retired`',
    `limit_type` STRING COMMENT 'Specifies whether the limit applies per transaction (single) or over a period (cumulative).. Valid values are `single|cumulative`',
    `max_installments` STRING COMMENT 'Maximum number of installments allowed for BNPL plans.',
    `monthly_cumulative_limit` DECIMAL(18,2) COMMENT 'Aggregate monetary limit for all transactions within a month.',
    `period` STRING COMMENT 'Time window to which a cumulative limit applies.. Valid values are `daily|weekly|monthly|yearly`',
    `regulatory_rationale` STRING COMMENT 'Explanation of the regulatory requirement that drives this limit (e.g., AML, PSD2).',
    `risk_rationale` STRING COMMENT 'Business or risk‑based justification for the limit (e.g., fraud exposure).',
    `updated_by` STRING COMMENT 'User or system identifier that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the limit record.',
    `version_number` BIGINT COMMENT 'Monotonically increasing version for optimistic concurrency control.',
    `weekly_cumulative_limit` DECIMAL(18,2) COMMENT 'Aggregate monetary limit for all transactions within a week.',
    CONSTRAINT pk_limit PRIMARY KEY(`limit_id`)
) COMMENT 'Defines transaction and velocity limits configured at the product level — single transaction maximum, daily/weekly/monthly cumulative limits, cross-border limits, ATM withdrawal caps, and BNPL credit exposure limits. Captures limit type, currency, enforcement mode (hard block vs. soft alert), and the regulatory or risk rationale for each limit. Distinct from cardholder-level spending controls.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ADD CONSTRAINT `fk_product_card_program_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ADD CONSTRAINT `fk_product_bnpl_plan_eligibility_rule_id` FOREIGN KEY (`eligibility_rule_id`) REFERENCES `payments_fintech_ecm`.`product`.`eligibility_rule`(`eligibility_rule_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ADD CONSTRAINT `fk_product_bnpl_plan_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ADD CONSTRAINT `fk_product_bnpl_plan_product_fee_schedule_id` FOREIGN KEY (`product_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`product`.`product_fee_schedule`(`product_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ADD CONSTRAINT `fk_product_fee_schedule_line_product_fee_schedule_id` FOREIGN KEY (`product_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`product`.`product_fee_schedule`(`product_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ADD CONSTRAINT `fk_product_product_pricing_plan_product_fee_schedule_id` FOREIGN KEY (`product_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`product`.`product_fee_schedule`(`product_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ADD CONSTRAINT `fk_product_version_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ADD CONSTRAINT `fk_product_rate_tier_product_fee_schedule_id` FOREIGN KEY (`product_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`product`.`product_fee_schedule`(`product_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ADD CONSTRAINT `fk_product_rate_tier_product_pricing_plan_id` FOREIGN KEY (`product_pricing_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`product_pricing_plan`(`product_pricing_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ADD CONSTRAINT `fk_product_interchange_qualification_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ADD CONSTRAINT `fk_product_interchange_qualification_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ADD CONSTRAINT `fk_product_p2p_product_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ADD CONSTRAINT `fk_product_p2p_product_product_fee_schedule_id` FOREIGN KEY (`product_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`product`.`product_fee_schedule`(`product_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ADD CONSTRAINT `fk_product_a2a_product_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ADD CONSTRAINT `fk_product_a2a_product_product_fee_schedule_id` FOREIGN KEY (`product_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`product`.`product_fee_schedule`(`product_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ADD CONSTRAINT `fk_product_virtual_account_product_card_program_id` FOREIGN KEY (`card_program_id`) REFERENCES `payments_fintech_ecm`.`product`.`card_program`(`card_program_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ADD CONSTRAINT `fk_product_virtual_account_product_product_fee_schedule_id` FOREIGN KEY (`product_fee_schedule_id`) REFERENCES `payments_fintech_ecm`.`product`.`product_fee_schedule`(`product_fee_schedule_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ADD CONSTRAINT `fk_product_feature_assignment_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `payments_fintech_ecm`.`product`.`feature`(`feature_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ADD CONSTRAINT `fk_product_feature_assignment_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ADD CONSTRAINT `fk_product_limit_bnpl_plan_id` FOREIGN KEY (`bnpl_plan_id`) REFERENCES `payments_fintech_ecm`.`product`.`bnpl_plan`(`bnpl_plan_id`);
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ADD CONSTRAINT `fk_product_limit_payment_product_id` FOREIGN KEY (`payment_product_id`) REFERENCES `payments_fintech_ecm`.`product`.`payment_product`(`payment_product_id`);

-- ========= TAGS =========
ALTER SCHEMA `payments_fintech_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `payments_fintech_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `irf_table_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `multi_network_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Multi Network Routing Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `aml_screening_required` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Required (AML)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria (EC)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `is_contactless_supported` SET TAGS ('dbx_business_glossary_term' = 'Contactless Supported (CS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `is_international_supported` SET TAGS ('dbx_business_glossary_term' = 'International Supported (IS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `is_online_supported` SET TAGS ('dbx_business_glossary_term' = 'Online Supported (OS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `is_tokenizable` SET TAGS ('dbx_business_glossary_term' = 'Is Tokenizable (IT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `kyc_required` SET TAGS ('dbx_business_glossary_term' = 'KYC Required (KYC)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount (MTA)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount (MiTA)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Product Notes (PN)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `payment_product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category (PCAT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `payment_product_category` SET TAGS ('dbx_value_regex' = 'consumer|business|partner');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `payment_product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code (PC)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `payment_product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,10}$');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `payment_product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description (PD)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `payment_product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name (PN)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `payment_product_status` SET TAGS ('dbx_business_glossary_term' = 'Product Status (PS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `payment_product_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired|suspended');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type (PT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'card|bnpl|p2p|a2a|virtual_account|digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `product_version` SET TAGS ('dbx_business_glossary_term' = 'Product Version (PV)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification (RC)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'pci|psd2|sox|gdpr|ccpa');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier (RT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `supported_rails` SET TAGS ('dbx_business_glossary_term' = 'Supported Payment Rails (SPR)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `supported_rails` SET TAGS ('dbx_value_regex' = 'visa|mastercard|ach|swift|sepa|upi');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount (SAmt)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Applicable (SA)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Method (TM)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_value_regex' = 'pan_token|device_token|account_token');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `transaction_fee_fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fixed Fee Amount (TFFA)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `transaction_fee_percent` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Percent (TFP)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `version_effective_from` SET TAGS ('dbx_business_glossary_term' = 'Version Effective From (VEF)');
ALTER TABLE `payments_fintech_ecm`.`product`.`payment_product` ALTER COLUMN `version_effective_until` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Until (VEU)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program Identifier');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `dcc_config_id` SET TAGS ('dbx_business_glossary_term' = 'Dcc Config Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Program Fee Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes (AUDIT_NOTES)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `bin_end` SET TAGS ('dbx_business_glossary_term' = 'BIN End (BIN_END)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `bin_start` SET TAGS ('dbx_business_glossary_term' = 'BIN Start (BIN_START)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `contactless_enabled` SET TAGS ('dbx_business_glossary_term' = 'Contactless Enabled (CONTACTLESS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `daily_spend_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Spend Limit (DAILY_LIMIT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `digital_wallet_enabled` SET TAGS ('dbx_business_glossary_term' = 'Digital Wallet Enabled (DW_ENABLED)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (END_DATE)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (START_DATE)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria (ELIGIBILITY)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `emv_configuration` SET TAGS ('dbx_business_glossary_term' = 'EMV Configuration (EMV_CFG)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Fee Structure (FEE_STR)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `interchange_qualification` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification (INTERCHANGE_Q)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `is_3ds_enabled` SET TAGS ('dbx_business_glossary_term' = '3‑DS Enabled (3DS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `is_fraud_detection_enabled` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Enabled (FRAUD_DET)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `is_tokenization_supported` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Supported (TOKEN_SUPPORT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount (MAX_TXN)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount (MIN_TXN)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Card Program Description');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Card Program Name');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status (STATUS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Card Program Type (TYPE)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|commercial|virtual|gift');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `program_version` SET TAGS ('dbx_business_glossary_term' = 'Program Version (VERSION)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date (REG_APPROVAL)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `spending_control_enabled` SET TAGS ('dbx_business_glossary_term' = 'Spending Control Enabled (SPEND_CTRL)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Applicable (SURCHARGE)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Rate (SURCHARGE_RATE)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider (TSP)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `transaction_type_supported` SET TAGS ('dbx_business_glossary_term' = 'Supported Transaction Types (TXN_TYPES)');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `transaction_type_supported` SET TAGS ('dbx_value_regex' = 'purchase|cash_advance|balance_transfer|online|offline');
ALTER TABLE `payments_fintech_ecm`.`product`.`card_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `bnpl_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Buy Now Pay Later Plan Identifier (BNPL_PLAN_ID)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Interest Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `product_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `allowed_countries` SET TAGS ('dbx_business_glossary_term' = 'Allowed Countries (BNPL_ALLOWED_COUNTRIES)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `bnpl_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Buy Now Pay Later Plan Description (BNPL_PLAN_DESC)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `bnpl_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Buy Now Pay Later Plan Status (BNPL_PLAN_STATUS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `bnpl_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired|suspended');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `compliance_regulation_codes` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulation Codes (BNPL_REG_CODES)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (BNPL_CREATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `disallowed_countries` SET TAGS ('dbx_business_glossary_term' = 'Disallowed Countries (BNPL_DISALLOWED_COUNTRIES)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `early_repayment_fee_percent` SET TAGS ('dbx_business_glossary_term' = 'Early Repayment Fee Percent (BNPL_EARLY_FEE_PCT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective End Date (BNPL_PLAN_EFF_END)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Start Date (BNPL_PLAN_EFF_START)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `installment_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Installments (BNPL_INSTALL_COUNT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `installment_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Installment Interval (BNPL_INSTALL_INTERVAL_DAYS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `interest_rate_annual_percent` SET TAGS ('dbx_business_glossary_term' = 'Annual Interest Rate Percent (BNPL_INT_RATE_APR)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `is_promotion_active` SET TAGS ('dbx_business_glossary_term' = 'Promotion Active Flag (BNPL_PROMO_ACTIVE)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `late_payment_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Fee Amount (BNPL_LATE_FEE)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `late_payment_grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Grace Period Days (BNPL_LATE_GRACE_DAYS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `max_installment_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Installment Amount (BNPL_MAX_INSTALL)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `max_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Total Plan Amount (BNPL_MAX_TOTAL)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `maximum_credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Credit Limit (BNPL_MAX_CREDIT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `min_installment_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Installment Amount (BNPL_MIN_INSTALL)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `min_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Total Plan Amount (BNPL_MIN_TOTAL)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount (BNPL_MIN_PURCHASE)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Buy Now Pay Later Plan Code (BNPL_PLAN_CODE)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Buy Now Pay Later Plan Name (BNPL_PLAN_NAME)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Buy Now Pay Later Plan Type (BNPL_PLAN_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'installment|revolving|hybrid');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `promotional_apr_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional APR End Date (BNPL_PROMO_APR_END)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `promotional_apr_percent` SET TAGS ('dbx_business_glossary_term' = 'Promotional APR Percent (BNPL_PROMO_APR)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `promotional_apr_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional APR Start Date (BNPL_PROMO_APR_START)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `repayment_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Repayment Schedule Type (BNPL_REPAY_SCHED_TYPE)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `repayment_schedule_type` SET TAGS ('dbx_value_regex' = 'fixed|declining|custom');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `requires_credit_check` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Requirement Flag (BNPL_REQUIRES_CREDIT_CHECK)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `requires_kyc` SET TAGS ('dbx_business_glossary_term' = 'KYC Requirement Flag (BNPL_REQUIRES_KYC)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `risk_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Score Threshold (BNPL_RISK_THRESHOLD)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User (BNPL_UPDATED_BY)');
ALTER TABLE `payments_fintech_ecm`.`product`.`bnpl_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (BNPL_UPDATED_TS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` SET TAGS ('dbx_subdomain' = 'pricing_fees');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `product_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Fee Schedule Identifier');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `scheme_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `scheme_fee_table_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Fee Table Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `applicable_card_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Card Type');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `applicable_card_type` SET TAGS ('dbx_value_regex' = 'credit|debit|prepaid|virtual|contactless');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `applicable_mcc` SET TAGS ('dbx_business_glossary_term' = 'Applicable Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `applicable_product_code` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Code');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `applicable_region` SET TAGS ('dbx_business_glossary_term' = 'Applicable Region');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `applicable_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `applicable_transaction_type` SET TAGS ('dbx_value_regex' = 'sale|auth|capture|refund|void|settlement');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Fee Calculation Method');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'flat|percentage|tiered|per_transaction');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `fee_application_scope` SET TAGS ('dbx_business_glossary_term' = 'Fee Application Scope');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `fee_application_scope` SET TAGS ('dbx_value_regex' = 'domestic|cross_border|both');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `fee_category` SET TAGS ('dbx_business_glossary_term' = 'Fee Category');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `fee_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Code');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `fee_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Description');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `fee_name` SET TAGS ('dbx_business_glossary_term' = 'Fee Name');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate (Percentage)');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `fee_source` SET TAGS ('dbx_business_glossary_term' = 'Fee Source');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `fee_source` SET TAGS ('dbx_value_regex' = 'interchange|issuer|acquirer|network|internal|partner');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `fee_taxable` SET TAGS ('dbx_business_glossary_term' = 'Fee Taxable Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `is_promotional` SET TAGS ('dbx_business_glossary_term' = 'Promotional Fee Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Recurring Fee Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `max_fee_cap` SET TAGS ('dbx_business_glossary_term' = 'Maximum Fee Cap');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `min_fee_floor` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fee Floor');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Notes');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `product_fee_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `product_fee_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `promotional_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional End Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `promotional_start_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional Start Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `recurrence_interval` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Interval');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `recurrence_interval` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|yearly|none');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `tier_level` SET TAGS ('dbx_business_glossary_term' = 'Tier Level');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `tier_max_volume` SET TAGS ('dbx_business_glossary_term' = 'Tier Maximum Volume');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `tier_min_volume` SET TAGS ('dbx_business_glossary_term' = 'Tier Minimum Volume');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `tier_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier Rate');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_fee_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` SET TAGS ('dbx_subdomain' = 'pricing_fees');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `fee_schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `product_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `applicable_product_code` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Code');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `applicable_transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Transaction Type');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `applicable_transaction_type` SET TAGS ('dbx_value_regex' = 'authorization|capture|settlement|refund|chargeback|reversal');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_value_regex' = 'pci|aml|none');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `fee_category` SET TAGS ('dbx_business_glossary_term' = 'Fee Category');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `fee_category` SET TAGS ('dbx_value_regex' = 'interchange|network|processor|service|other');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `fee_component_name` SET TAGS ('dbx_business_glossary_term' = 'Fee Component Name');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `fee_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Description');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `fee_schedule_line_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Line Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `fee_schedule_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `fee_source` SET TAGS ('dbx_business_glossary_term' = 'Fee Source');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `fee_source` SET TAGS ('dbx_value_regex' = 'internal|partner|regulatory');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `max_cap` SET TAGS ('dbx_business_glossary_term' = 'Maximum Fee Cap');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `min_cap` SET TAGS ('dbx_business_glossary_term' = 'Minimum Fee Cap');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Percentage Rate');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'flat|percentage|tiered|blended');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `regulatory_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Code');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `tier_end_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier End Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `tier_rate` SET TAGS ('dbx_business_glossary_term' = 'Tier Percentage Rate');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `tier_start_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier Start Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`fee_schedule_line` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` SET TAGS ('dbx_subdomain' = 'pricing_fees');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `product_pricing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Plan ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `product_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `discount_tier_end` SET TAGS ('dbx_business_glossary_term' = 'Discount Tier End Threshold');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `discount_tier_start` SET TAGS ('dbx_business_glossary_term' = 'Discount Tier Start Threshold');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Code');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `fee_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `fee_cap_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Type');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `fee_cap_type` SET TAGS ('dbx_value_regex' = 'per_transaction|monthly|annual');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fee Percentage');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `is_default_plan` SET TAGS ('dbx_business_glossary_term' = 'Default Plan Indicator');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `is_test_plan` SET TAGS ('dbx_business_glossary_term' = 'Test Plan Indicator');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_business_glossary_term' = 'Pricing Plan Category');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_value_regex' = 'transaction|subscription|installment|bnpl|p2p|a2a');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Plan Code');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Pricing Plan Name');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Plan Type');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'merchant|cardholder|both');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'flat|interchange_plus|tiered|blended');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `product_pricing_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Pricing Plan Description');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `product_pricing_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Plan Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `product_pricing_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|retired|draft');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `promotional_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Promotional Discount Rate');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `promotional_window_end` SET TAGS ('dbx_business_glossary_term' = 'Promotional Window End');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `promotional_window_start` SET TAGS ('dbx_business_glossary_term' = 'Promotional Window Start');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `regulatory_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `sales_channel` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `sales_channel` SET TAGS ('dbx_value_regex' = 'online|partner|direct|api');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`product_pricing_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` SET TAGS ('dbx_subdomain' = 'eligibility_limits');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `bin_range_end` SET TAGS ('dbx_business_glossary_term' = 'BIN Range End');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `bin_range_start` SET TAGS ('dbx_business_glossary_term' = 'BIN Range Start');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `cardholder_segment` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Segment');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `condition_expression` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Condition Expression');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rule Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Rule Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Rule Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `eligibility_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Description');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `eligibility_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `eligibility_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `is_override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Override Allowed Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `kyc_tier` SET TAGS ('dbx_business_glossary_term' = 'KYC Tier');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `kyc_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|very_high');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `mcc_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `merchant_segment` SET TAGS ('dbx_business_glossary_term' = 'Merchant Segment');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Notes');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `override_authority` SET TAGS ('dbx_business_glossary_term' = 'Override Authority');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `override_authority` SET TAGS ('dbx_value_regex' = 'system|admin|compliance');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `risk_score_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Risk Score');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `risk_score_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Risk Score');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Category');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'merchant|cardholder|segment|product|pricing|promotion');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Code');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_logic` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Logic');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_logic` SET TAGS ('dbx_value_regex' = 'include|exclude');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Name');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Type');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'mcc_restriction|bin_range|geography|tpv_threshold|kyc_tier|risk_score_band');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `tpv_threshold` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Volume Threshold');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `transaction_amount_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `transaction_amount_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Rule Updated By');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rule Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`eligibility_rule` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Rule Version');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` SET TAGS ('dbx_subdomain' = 'eligibility_limits');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Product Version ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `aml_screening_required` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Required');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending|revoked');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `compliance_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `interchange_fee_category` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Category');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `interchange_fee_category` SET TAGS ('dbx_value_regex' = 'IRF|MDR|MSF|DCC|Other');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `is_contactless_supported` SET TAGS ('dbx_business_glossary_term' = 'Contactless Support');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `is_international_supported` SET TAGS ('dbx_business_glossary_term' = 'International Support');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `is_online_supported` SET TAGS ('dbx_business_glossary_term' = 'Online Support');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `is_tokenizable` SET TAGS ('dbx_business_glossary_term' = 'Is Tokenizable');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `kyc_required` SET TAGS ('dbx_business_glossary_term' = 'KYC Required');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'card|bnpl|p2p|a2a|virtual_account|digital_wallet');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_value_regex' = 'T+0|T+1|T+2|T+3|T+4|T+5');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Applicable');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Method');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_value_regex' = 'DPAN|HCE|TSP');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Product Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending|retired|draft');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` SET TAGS ('dbx_subdomain' = 'pricing_fees');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `rate_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier Identifier (RTID)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `product_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `product_pricing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Product Pricing Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status (CRS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria (EC)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `fee_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Amount (FCA)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `fee_cap_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Cap Type (FCT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `fee_cap_type` SET TAGS ('dbx_value_regex' = 'per_transaction|monthly|annual');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `is_default_tier` SET TAGS ('dbx_business_glossary_term' = 'Default Tier Indicator (DTI)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `max_volume` SET TAGS ('dbx_business_glossary_term' = 'Maximum Volume Threshold (MXVT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `min_volume` SET TAGS ('dbx_business_glossary_term' = 'Minimum Volume Threshold (MVT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (AN)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `rate_tier_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier Status (RTS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `rate_tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type (RT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Rate Value (RV)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `regulatory_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Flag (RAF)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier Code (RTC)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier Name (RTN)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `tier_priority` SET TAGS ('dbx_business_glossary_term' = 'Tier Priority Order (TPO)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `tier_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier Type (RTT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `tier_type` SET TAGS ('dbx_value_regex' = 'volume|transaction|value');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (VUM)');
ALTER TABLE `payments_fintech_ecm`.`product`.`rate_tier` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'transaction|usd|eur|gbp|jpy');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` SET TAGS ('dbx_subdomain' = 'pricing_fees');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `interchange_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Card Program Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `currency_pair_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Pair Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `irf_rate_category_id` SET TAGS ('dbx_business_glossary_term' = 'Irf Rate Category Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `authorization_method` SET TAGS ('dbx_business_glossary_term' = 'Authorization Method');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `authorization_method` SET TAGS ('dbx_value_regex' = 'online|offline|fallback');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'debit|credit|prepaid|commercial|corporate');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `entry_mode` SET TAGS ('dbx_business_glossary_term' = 'Entry Mode');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `entry_mode` SET TAGS ('dbx_value_regex' = 'chip|magstripe|contactless|manual|mobile');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `interchange_category` SET TAGS ('dbx_business_glossary_term' = 'Interchange Category');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `interchange_category` SET TAGS ('dbx_value_regex' = 'visa_cps_retail|mc_merit_iii|interac_interac|discover|jcb');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `interchange_qualification_description` SET TAGS ('dbx_business_glossary_term' = 'Qualification Description');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `interchange_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `interchange_qualification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `qualification_code` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification Code (IQC)');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `qualification_name` SET TAGS ('dbx_business_glossary_term' = 'Interchange Qualification Name (IQN)');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'card_program|bnpl|p2p|a2a|virtual_account');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `regulatory_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `sca_compliance` SET TAGS ('dbx_business_glossary_term' = 'SCA Compliance Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `version_effective_from` SET TAGS ('dbx_business_glossary_term' = 'Version Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `version_effective_until` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`interchange_qualification` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `p2p_product_id` SET TAGS ('dbx_business_glossary_term' = 'Peer-to-Peer Product ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `gateway_api_credential_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Api Credential Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `product_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Fee Schedule Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `aml_screening_required` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Required');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `cross_border_allowed` SET TAGS ('dbx_business_glossary_term' = 'Cross-Border Transfer Allowed');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `currency_supported` SET TAGS ('dbx_business_glossary_term' = 'Supported Currency');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `currency_supported` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|AUD|CAD');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `daily_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transfer Limit');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `funding_sources` SET TAGS ('dbx_business_glossary_term' = 'Funding Sources');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `funding_sources` SET TAGS ('dbx_value_regex' = 'debit_card|bank_account|wallet_balance');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `fx_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Foreign Exchange Eligibility');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `is_contactless_supported` SET TAGS ('dbx_business_glossary_term' = 'Contactless Supported');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `is_default_plan` SET TAGS ('dbx_business_glossary_term' = 'Default Pricing Plan Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `is_international_supported` SET TAGS ('dbx_business_glossary_term' = 'International Supported');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `is_online_supported` SET TAGS ('dbx_business_glossary_term' = 'Online Supported');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `is_test_product` SET TAGS ('dbx_business_glossary_term' = 'Test Product Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `is_tokenizable` SET TAGS ('dbx_business_glossary_term' = 'Tokenizable');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `kyc_required` SET TAGS ('dbx_business_glossary_term' = 'KYC Required');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `monthly_limit` SET TAGS ('dbx_business_glossary_term' = 'Monthly Transfer Limit');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `p2p_product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `p2p_product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `p2p_product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `p2p_product_status` SET TAGS ('dbx_business_glossary_term' = 'Product Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `p2p_product_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `per_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Per Transaction Limit (Amount)');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type (Instant, Scheduled, Cross-Border)');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'instant|scheduled|cross_border');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `promotional_offer_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Offer Code');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'regulated|unregulated|restricted|exempt');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Method');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_value_regex' = 'device_token|virtual_token|network_token');
ALTER TABLE `payments_fintech_ecm`.`product`.`p2p_product` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `a2a_product_id` SET TAGS ('dbx_business_glossary_term' = 'Account-to-Account Product Identifier (A2A Product ID)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `acquirer_endpoint_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Endpoint Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `payment_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Corridor Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Product Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `product_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Identifier (Fee Schedule ID)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `a2a_product_code` SET TAGS ('dbx_business_glossary_term' = 'Account-to-Account Product Code (A2A Product Code)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `a2a_product_description` SET TAGS ('dbx_business_glossary_term' = 'Account-to-Account Product Description (A2A Product Description)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `a2a_product_name` SET TAGS ('dbx_business_glossary_term' = 'Account-to-Account Product Name (A2A Product Name)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `a2a_product_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Status (Product Status)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `a2a_product_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `aml_screening_required` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Requirement Flag (AML Screening Required)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (Compliance Status)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created Timestamp)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (Effective From)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (Effective Until)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria (Eligibility Criteria)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `interchange_fee_category` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee Category (Interchange Fee Category)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `interchange_fee_category` SET TAGS ('dbx_value_regex' = 'IRF|MDR|MSF');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `is_contactless_supported` SET TAGS ('dbx_business_glossary_term' = 'Contactless Support Flag (Contactless Supported)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `is_international_supported` SET TAGS ('dbx_business_glossary_term' = 'International Transaction Support Flag (International Supported)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `is_online_supported` SET TAGS ('dbx_business_glossary_term' = 'Online Transaction Support Flag (Online Supported)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `is_tokenizable` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Support Flag (Is Tokenizable)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `iso_20022_version` SET TAGS ('dbx_business_glossary_term' = 'ISO 20022 Message Schema Version (ISO 20022 Version)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `iso_20022_version` SET TAGS ('dbx_value_regex' = 'v2.0|v2.1|v3.0');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `kyc_required` SET TAGS ('dbx_business_glossary_term' = 'KYC Requirement Flag (KYC Required)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount (Max Transaction Amount)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount (Min Transaction Amount)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (Notes)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Account-to-Account Product Type (A2A Product Type)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'ACH|RTP|RTGS|SWIFT|OPEN_BANKING');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `product_version` SET TAGS ('dbx_business_glossary_term' = 'Product Version Label (Product Version)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification (Regulatory Classification)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'domestic|cross_border');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `regulatory_reporting` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Obligations (Regulatory Reporting)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `regulatory_reporting` SET TAGS ('dbx_value_regex' = 'RegE|PSD2|FATF|SOX');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Classification (Risk Tier)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `settlement_window_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Window (Days) (Settlement Window Days)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `stp_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Straight-Through Processing Eligibility (STP Eligibility)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `supported_rails` SET TAGS ('dbx_business_glossary_term' = 'Supported Transfer Rails (Supported Rails)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `supported_rails` SET TAGS ('dbx_value_regex' = 'ACH|SAME_DAY_ACH|RTP|RTGS|SWIFT|OPEN_BANKING');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount (Surcharge Amount)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Applicability Flag (Surcharge Applicable)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Rate Percentage (Surcharge Rate)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Method (Tokenization Method)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_value_regex' = 'DPAN|HCE|TSP');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `transaction_fee_fixed_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fixed Fee Amount (Transaction Fee Fixed Amount)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `transaction_fee_percent` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Percentage (Transaction Fee Percent)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (Updated Timestamp)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `version_effective_from` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Start Date (Version Effective From)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `version_effective_until` SET TAGS ('dbx_business_glossary_term' = 'Version Effective End Date (Version Effective Until)');
ALTER TABLE `payments_fintech_ecm`.`product`.`a2a_product` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Product Version Number (Version Number)');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` SET TAGS ('dbx_subdomain' = 'product_catalog');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `virtual_account_product_id` SET TAGS ('dbx_business_glossary_term' = 'Virtual Account Product ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `card_program_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Program ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `ecosystem_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Ecosystem Partner Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Liability Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `nostro_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nostro Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `product_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `scheme_id` SET TAGS ('dbx_business_glossary_term' = 'Scheme Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Virtual Account Activation Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `allowed_mcc_codes` SET TAGS ('dbx_business_glossary_term' = 'Allowed MCC Codes');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `aml_screening_required` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Required Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `bin_end` SET TAGS ('dbx_business_glossary_term' = 'BIN End');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `bin_end` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `bin_start` SET TAGS ('dbx_business_glossary_term' = 'BIN Start');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `bin_start` SET TAGS ('dbx_value_regex' = '^d{6}$');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Virtual Account Classification');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'card_program|b2b_payables|expense_management|marketplace_disbursement');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `daily_spend_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Spend Limit');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Virtual Account Expiry Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `is_contactless_supported` SET TAGS ('dbx_business_glossary_term' = 'Contactless Support Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `is_international_supported` SET TAGS ('dbx_business_glossary_term' = 'International Use Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `is_online_supported` SET TAGS ('dbx_business_glossary_term' = 'Online Support Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `is_tokenizable` SET TAGS ('dbx_business_glossary_term' = 'Tokenizable Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `issuance_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Issuance Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `kyc_required` SET TAGS ('dbx_business_glossary_term' = 'KYC Required Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `maintenance_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `max_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Balance Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Virtual Account Product Code');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Virtual Account Product Type');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'single_use|multi_use|virtual_iban');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `promo_eligible` SET TAGS ('dbx_business_glossary_term' = 'Promotional Eligibility Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `spend_control_rules` SET TAGS ('dbx_business_glossary_term' = 'Spend Control Rules');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Applicable Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `token_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Token Service Provider');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Method');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_value_regex' = 'tsp|hce|none');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `transaction_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Per‑Transaction Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `virtual_account_product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `virtual_account_product_name` SET TAGS ('dbx_business_glossary_term' = 'Virtual Account Product Name');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `virtual_account_product_status` SET TAGS ('dbx_business_glossary_term' = 'Virtual Account Product Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`virtual_account_product` ALTER COLUMN `virtual_account_product_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` SET TAGS ('dbx_subdomain' = 'eligibility_limits');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `feature_id` SET TAGS ('dbx_business_glossary_term' = 'Product Feature ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Gl Account Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `activation_rules` SET TAGS ('dbx_business_glossary_term' = 'Activation Rules');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Feature Effective Start Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Feature Effective End Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `feature_code` SET TAGS ('dbx_business_glossary_term' = 'Feature Code');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `feature_description` SET TAGS ('dbx_business_glossary_term' = 'Feature Description');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `feature_name` SET TAGS ('dbx_business_glossary_term' = 'Feature Name');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `feature_status` SET TAGS ('dbx_business_glossary_term' = 'Feature Lifecycle Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `feature_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `feature_type` SET TAGS ('dbx_business_glossary_term' = 'Feature Type (CAPABILITY/CONTROL/SERVICE/ADDON)');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `feature_type` SET TAGS ('dbx_value_regex' = 'capability|control|service|addon');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Fee Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `fee_impact_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Impact Type');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `fee_impact_type` SET TAGS ('dbx_value_regex' = 'none|fixed|percentage|tiered');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fee Percentage Impact');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `is_enabled_by_default` SET TAGS ('dbx_business_glossary_term' = 'Default Enablement Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `regulatory_dependency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Dependency');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `regulatory_dependency` SET TAGS ('dbx_value_regex' = 'PCI_DSS|PSD2|EMV|SCA|AML|KYC');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `requires_3ds` SET TAGS ('dbx_business_glossary_term' = '3‑D Secure Requirement Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `requires_aml` SET TAGS ('dbx_business_glossary_term' = 'AML Screening Requirement Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `requires_contactless` SET TAGS ('dbx_business_glossary_term' = 'Contactless Capability Requirement Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `requires_dcc` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Currency Conversion Requirement Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `requires_international` SET TAGS ('dbx_business_glossary_term' = 'International Transaction Capability Requirement Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `requires_kyc` SET TAGS ('dbx_business_glossary_term' = 'KYC Requirement Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `requires_online` SET TAGS ('dbx_business_glossary_term' = 'Online Transaction Capability Requirement Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `requires_tokenization` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Requirement Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Feature Definition Version Number');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` SET TAGS ('dbx_subdomain' = 'eligibility_limits');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `feature_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Product Feature Assignment ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `feature_id` SET TAGS ('dbx_business_glossary_term' = 'Feature ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Feature Activation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Agreement Code');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Activation Channel');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online|api|partner|internal');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `configuration_parameters` SET TAGS ('dbx_business_glossary_term' = 'Configuration Parameters');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `deactivation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Feature Deactivation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `feature_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Feature Assignment Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `feature_assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|revoked');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Feature Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`feature_assignment` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Assignment Version');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` SET TAGS ('dbx_subdomain' = 'eligibility_limits');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `limit_id` SET TAGS ('dbx_business_glossary_term' = 'Product Limit Identifier');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `bnpl_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Bnpl Plan Id (Foreign Key)');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `payment_product_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Product Limit Amount (AMOUNT)');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `atm_withdrawal_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'ATM Withdrawal Cap Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `bnpl_credit_exposure_limit` SET TAGS ('dbx_business_glossary_term' = 'BNPL Credit Exposure Limit');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `cross_border_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Limit Amount');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `daily_cumulative_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Cumulative Limit');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `enforcement_mode` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Mode (MODE)');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `enforcement_mode` SET TAGS ('dbx_value_regex' = 'hard|soft');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `installment_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Installment Interval (DAYS)');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `is_cross_border_allowed` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Allowed Flag');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `limit_category` SET TAGS ('dbx_business_glossary_term' = 'Product Limit Category (CATEGORY)');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `limit_category` SET TAGS ('dbx_value_regex' = 'transaction|velocity|credit|atm|cross_border|bnpl');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `limit_code` SET TAGS ('dbx_business_glossary_term' = 'Product Limit Code');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `limit_description` SET TAGS ('dbx_business_glossary_term' = 'Limit Description');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `limit_name` SET TAGS ('dbx_business_glossary_term' = 'Product Limit Name');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `limit_status` SET TAGS ('dbx_business_glossary_term' = 'Product Limit Status');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `limit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Product Limit Type (TYPE)');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_value_regex' = 'single|cumulative');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `max_installments` SET TAGS ('dbx_business_glossary_term' = 'Maximum Installments');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `monthly_cumulative_limit` SET TAGS ('dbx_business_glossary_term' = 'Monthly Cumulative Limit');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `period` SET TAGS ('dbx_business_glossary_term' = 'Limit Period (PERIOD)');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `period` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|yearly');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `regulatory_rationale` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rationale');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `risk_rationale` SET TAGS ('dbx_business_glossary_term' = 'Risk Rationale');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `payments_fintech_ecm`.`product`.`limit` ALTER COLUMN `weekly_cumulative_limit` SET TAGS ('dbx_business_glossary_term' = 'Weekly Cumulative Limit');
