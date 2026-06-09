-- Schema for Domain: payment | Business: Grocery | Version: v1_mvm
-- Generated on: 2026-05-04 20:42:50

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`payment` COMMENT 'Payment processing for all transaction types including credit/debit cards, EBT, SNAP, WIC, mobile wallets, gift cards, and fuel rewards. Manages payment authorization, settlement, chargebacks, refunds, and PCI DSS compliance. Integrates with NCR POS systems, payment gateways, and digital commerce checkout.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`tender_type` (
    `tender_type_id` BIGINT COMMENT 'Unique identifier for the tender type. Primary key for the tender type reference master.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Tender-to-GL mapping: each tender type (cash, credit card, EBT, gift card) maps to a distinct GL account for cash management and reconciliation. Grocery finance uses this mapping to automatically rout',
    `accepted_ecommerce_flag` BOOLEAN COMMENT 'Indicates whether this tender type is accepted for online orders through Salesforce Commerce Cloud. True for credit/debit cards and digital wallets; false for cash and check.',
    `accepted_fuel_center_flag` BOOLEAN COMMENT 'Indicates whether this tender type is accepted at fuel center pay-at-pump terminals. True for credit/debit cards and fleet cards; false for government benefits and gift cards.',
    `accepted_mobile_app_flag` BOOLEAN COMMENT 'Indicates whether this tender type is accepted for orders placed through the Grocery mobile application. True for digital payment methods; false for cash and check.',
    `accepted_pharmacy_flag` BOOLEAN COMMENT 'Indicates whether this tender type is accepted for pharmacy prescription transactions. True for most tender types; may have restrictions for certain government benefit programs.',
    `accepted_pos_flag` BOOLEAN COMMENT 'Indicates whether this tender type is accepted at in-store NCR POS terminals. True for most tender types; false for online-only payment methods.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this tender type is currently active and available for use across all channels. False indicates the tender type has been discontinued or temporarily suspended.',
    `chargeback_eligible_flag` BOOLEAN COMMENT 'Indicates whether transactions using this tender type are subject to chargeback disputes initiated by cardholders. True for credit/debit cards; false for cash, check, and gift cards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tender type record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for this tender type. Typically USD for US operations. Supports multi-currency scenarios for international expansion.. Valid values are `^[A-Z]{3}$`',
    `display_order` STRING COMMENT 'Numeric sequence controlling the display order of tender types in POS and eCommerce checkout interfaces. Lower numbers appear first. Used to prioritize preferred payment methods.',
    `effective_end_date` DATE COMMENT 'Date when this tender type was or will be discontinued. Null for currently active tender types with no planned end date. Supports sunset of deprecated payment methods.',
    `effective_start_date` DATE COMMENT 'Date when this tender type became or will become available for use. Supports future-dated activation of new payment methods.',
    `eligible_item_restriction_code` STRING COMMENT 'Code identifying product eligibility restrictions for this tender type. Used for government benefit programs (SNAP/WIC) that restrict purchases to approved product categories. Null for unrestricted tender types.',
    `is_contactless_flag` BOOLEAN COMMENT 'Indicates whether this tender type supports contactless payment via NFC (Near Field Communication) or RFID (Radio Frequency Identification) technology. True for Apple Pay, Google Pay, and contactless cards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this tender type record was last updated. Used for audit trail and change tracking. Updated whenever any attribute value changes.',
    `maximum_transaction_amount` DECIMAL(18,2) COMMENT 'Maximum transaction amount allowed for this tender type per transaction. Null if no maximum applies. Used for gift cards, fuel rewards, and certain government benefit programs.',
    `minimum_transaction_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount required to use this tender type. Null if no minimum applies. Used for certain credit card merchant agreements or promotional tender types.',
    `processing_network` STRING COMMENT 'Payment processing network or gateway used to authorize and settle transactions for this tender type. Examples: Visa, Mastercard, Discover, American Express, NYCE, STAR, Pulse, FIS, First Data, EBT Network.',
    `refund_allowed_flag` BOOLEAN COMMENT 'Indicates whether refunds can be issued back to this tender type. True for most tender types; false for certain government benefit programs with regulatory restrictions.',
    `regulatory_program_code` STRING COMMENT 'Code identifying the government regulatory program associated with this tender type. Examples: SNAP (Supplemental Nutrition Assistance Program), WIC (Women Infants and Children), EBT (Electronic Benefits Transfer). Null for non-government tender types.',
    `requires_pin_flag` BOOLEAN COMMENT 'Indicates whether this tender type requires PIN entry for authorization. True for debit cards, EBT, and some gift cards. False for credit cards and contactless wallets.',
    `requires_signature_flag` BOOLEAN COMMENT 'Indicates whether this tender type requires customer signature for authorization above certain transaction thresholds. True for credit cards above signature threshold; false for PIN-based and contactless payments.',
    `settlement_batch_flag` BOOLEAN COMMENT 'Indicates whether transactions using this tender type are included in end-of-day settlement batch processing. True for electronic payment methods; false for cash and check which are reconciled separately.',
    `signature_threshold_amount` DECIMAL(18,2) COMMENT 'Transaction amount threshold above which signature is required for this tender type. Null if signature is never required or always required regardless of amount.',
    `supports_partial_tender_flag` BOOLEAN COMMENT 'Indicates whether this tender type can be used for partial payment of a transaction total, allowing split tender scenarios. True for most tender types; false for some government benefit programs with restrictions.',
    `tender_category` STRING COMMENT 'High-level classification grouping similar tender types for reporting and analytics. Categories: card (credit/debit), electronic_wallet (mobile wallets), government_benefit (EBT/SNAP/WIC), gift_card, fuel_reward, cash, check. [ENUM-REF-CANDIDATE: card|electronic_wallet|government_benefit|gift_card|fuel_reward|cash|check — 7 candidates stripped; promote to reference product]',
    `tender_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the tender type across all systems. Used by NCR POS and Salesforce Commerce Cloud for payment routing. Examples: CC, DC, EBT, SNAP, WIC, GPAY, APAY, GC, FUEL, CHK, CASH.. Valid values are `^[A-Z0-9]{2,10}$`',
    `tender_description` STRING COMMENT 'Detailed description of the tender type including usage guidelines, restrictions, and business rules. Provides context for associates and system integrators.',
    `tender_name` STRING COMMENT 'Full business name of the tender type displayed to customers and associates. Examples: Credit Card, Debit Card, EBT/SNAP, WIC, Apple Pay, Google Pay, Gift Card, Fuel Rewards, Check, Cash.',
    `tokenization_supported_flag` BOOLEAN COMMENT 'Indicates whether this tender type supports payment tokenization for secure storage and recurring transactions. True for credit/debit cards and digital wallets; false for cash and check.',
    CONSTRAINT pk_tender_type PRIMARY KEY(`tender_type_id`)
) COMMENT 'Reference master defining all accepted payment tender types at Grocery including credit card, debit card, EBT/SNAP, WIC, mobile wallet (Apple Pay, Google Pay), gift card, fuel rewards redemption, check, and cash. Captures tender code, tender name, tender category, accepted channels (POS, eCommerce, mobile app), processing network, requires_pin flag, supports_partial_tender flag, is_contactless flag, regulatory_program_code (e.g., SNAP, WIC), and active status. Used by NCR POS and Salesforce Commerce Cloud checkout to validate and route payment instruments.';

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`method` (
    `method_id` BIGINT COMMENT 'Unique identifier for the stored payment method. Primary key for the payment_method entity.',
    `gateway_id` BIGINT COMMENT 'Foreign key linking to payment.payment_gateway. Business justification: A payment_method is processed through a specific payment gateway; linking via payment_gateway_id enforces consistency and removes the free‑text gateway column.',
    `gift_card_id` BIGINT COMMENT 'Foreign key linking to payment.gift_card. Business justification: The method table represents stored payment instruments including gift cards (evidenced by gift_card_balance column). When a method represents a gift card instrument, it should link to the gift_card ma',
    `shopper_id` BIGINT COMMENT 'Reference to the shopper who owns this stored payment credential. Links to the customer domain shopper entity.',
    `tender_type_id` BIGINT COMMENT 'Reference to the tender type category (credit card, debit card, EBT, gift card, mobile wallet) that this payment method belongs to.',
    `avs_result_code` STRING COMMENT 'The most recent AVS result code returned during payment method verification. Used to assess fraud risk and address match quality.',
    `billing_address_line1` STRING COMMENT 'The primary street address line associated with the payment method for billing and Address Verification Service (AVS) checks.',
    `billing_address_line2` STRING COMMENT 'The secondary street address line (apartment, suite, unit) associated with the payment method for billing purposes. Optional field.',
    `billing_city` STRING COMMENT 'The city associated with the billing address for this payment method. Used for AVS verification.',
    `billing_country` STRING COMMENT 'The three-letter ISO country code for the billing address (e.g., USA, CAN, MEX). Used for international payment processing and compliance.. Valid values are `^[A-Z]{3}$`',
    `billing_state` STRING COMMENT 'The state or province code associated with the billing address. Used for AVS verification and tax calculation.',
    `billing_zip` STRING COMMENT 'The postal code associated with the billing address. Critical for Address Verification Service (AVS) fraud prevention checks.',
    `bin_number` STRING COMMENT 'The first six digits of the payment card number, identifying the issuing bank and card type. Used for routing and fraud detection. Not considered PII per PCI DSS.. Valid values are `^[0-9]{6}$`',
    `card_brand` STRING COMMENT 'The payment card network brand for credit and debit cards (Visa, Mastercard, American Express, Discover, JCB, Diners Club). Null for non-card payment methods.. Valid values are `Visa|Mastercard|American Express|Discover|JCB|Diners Club`',
    `card_type` STRING COMMENT 'The functional type of payment card: Credit (revolving credit), Debit (linked to bank account), Prepaid (preloaded funds), Charge (full payment required), Unknown (type not determined). Null for non-card payment methods.. Valid values are `Credit|Debit|Prepaid|Charge|Unknown`',
    `cardholder_name` STRING COMMENT 'The name embossed on the payment card as provided by the cardholder. Used for verification and display purposes.',
    `channel` STRING COMMENT 'The channel through which this payment method was originally registered: POS (Point of Sale), eCommerce, Mobile App, Call Center, or Kiosk. Distinct from tender_type.. Valid values are `POS|eCommerce|Mobile App|Call Center|Kiosk`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment method record was first created in the system. Immutable audit field.',
    `cvv_verification_status` STRING COMMENT 'The result of the most recent CVV verification check: Verified (match), Failed (no match), Not Checked (skipped), Not Applicable (non-card payment method).. Valid values are `Verified|Failed|Not Checked|Not Applicable`',
    `deleted_timestamp` TIMESTAMP COMMENT 'The date and time when this payment method was soft-deleted by the customer or system. Null for active records. Supports GDPR right to erasure compliance.',
    `ebt_card_number_token` STRING COMMENT 'Tokenized EBT card number for SNAP or WIC benefit programs. Complies with federal privacy requirements for benefit program data.',
    `ebt_program_type` STRING COMMENT 'The government assistance program type for EBT cards: SNAP (Supplemental Nutrition Assistance Program), WIC (Women Infants and Children), TANF (Temporary Assistance for Needy Families). Null for non-EBT payment methods.. Valid values are `SNAP|WIC|TANF|None`',
    `expiration_month` STRING COMMENT 'The month (1-12) when the payment card expires. Used to validate card validity at transaction time. Null for non-expiring payment methods.',
    `expiration_year` STRING COMMENT 'The four-digit year when the payment card expires. Used to validate card validity at transaction time. Null for non-expiring payment methods.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Risk score (0-100) assigned by fraud detection systems based on payment method characteristics, usage patterns, and verification results. Higher scores indicate higher fraud risk.',
    `is_default` BOOLEAN COMMENT 'Boolean flag indicating whether this is the shoppers default payment method for transactions. Only one payment method per shopper should be marked as default.',
    `is_expired` BOOLEAN COMMENT 'Boolean flag indicating whether this payment method has passed its expiration date and is no longer valid for transactions. Calculated based on expiration_month and expiration_year.',
    `is_verified` BOOLEAN COMMENT 'Boolean flag indicating whether this payment method has been successfully verified through AVS, CVV check, or micro-deposit validation.',
    `issuing_bank` STRING COMMENT 'The name of the financial institution that issued the payment card. Derived from the Bank Identification Number (BIN) during tokenization.',
    `last_four_digits` STRING COMMENT 'The last four digits of the payment account number, used for customer identification and display purposes without exposing the full PAN.. Valid values are `^[0-9]{4}$`',
    `last_used_timestamp` TIMESTAMP COMMENT 'The date and time when this payment method was last successfully used for a transaction. Used to identify dormant payment methods for cleanup.',
    `method_status` STRING COMMENT 'Current lifecycle status of the payment method: Active (available for use), Inactive (customer disabled), Suspended (fraud hold), Expired (past expiration date), Pending Verification (awaiting validation), Blocked (permanently disabled).. Valid values are `Active|Inactive|Suspended|Expired|Pending Verification|Blocked`',
    `nickname` STRING COMMENT 'Optional customer-provided friendly name for this payment method (e.g., My Visa Card, Work Amex) to help identify it in the wallet UI.',
    `payment_method_token` STRING COMMENT 'PCI DSS compliant tokenized representation of the payment account number (PAN). This token is used in place of the actual card number for secure storage and processing.',
    `tokenization_provider` STRING COMMENT 'The third-party tokenization service provider that generated the payment_method_token (e.g., Fiserv, Worldpay, Stripe, internal vault). Critical for token lifecycle management.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this payment method record was last modified. Updated on any field change for audit trail purposes.',
    `vault_reference_code` STRING COMMENT 'The unique identifier in the external payment vault or tokenization system. Used to retrieve or update the tokenized credential from the vault provider.',
    `verification_date` DATE COMMENT 'The date when this payment method was last successfully verified. Used to determine if re-verification is required per security policies.',
    `wallet_provider` STRING COMMENT 'The digital wallet provider if this payment method is a mobile or digital wallet credential (Apple Pay, Google Pay, Samsung Pay, PayPal, Venmo). Null or None for traditional payment methods.. Valid values are `Apple Pay|Google Pay|Samsung Pay|PayPal|Venmo|None`',
    `wallet_token` STRING COMMENT 'The tokenized credential provided by the digital wallet provider for secure transaction processing. Distinct from payment_method_token.',
    CONSTRAINT pk_method PRIMARY KEY(`method_id`)
) COMMENT 'Master record of a shoppers stored payment instrument on file with Grocery, representing a tokenized payment credential registered for use across POS, eCommerce, and mobile channels. Distinct from tender_type (which defines accepted payment categories), this entity represents a specific customers saved card, wallet, or benefit credential. Captures payment_method_token (PCI DSS tokenized PAN), tender_type_id reference, card_brand (Visa, Mastercard, Amex, Discover), last_four_digits, expiration_month, expiration_year, billing_zip, wallet_provider (Apple Pay, Google Pay, Samsung Pay), gift_card_balance, EBT_card_number_token, is_default flag, is_expired flag, tokenization_provider, and vault_reference_id. Owned by the payment domain as the SSOT for stored payment credentials; shopper identity is linked via FK to customer domain.';

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`gateway` (
    `gateway_id` BIGINT COMMENT 'Unique identifier for the payment gateway configuration record. Primary key.',
    `acquirer_bank` STRING COMMENT 'Name of the acquiring bank or financial institution that sponsors the merchant account and settles funds (e.g., JPMorgan Chase, Wells Fargo Merchant Services).',
    `api_version` STRING COMMENT 'Version of the gateway API currently in use (e.g., v2.1, 2023-10). Critical for integration compatibility and upgrade planning.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the gateway contract automatically renews at the end of the contract term. True = auto-renews, False = requires manual renewal.',
    `average_response_time_ms` STRING COMMENT 'Rolling average response time in milliseconds for authorization requests to this gateway over the last 24 hours. Performance metric for gateway selection and monitoring.',
    `batch_settlement_time` TIMESTAMP COMMENT 'Time of day (HH:MM format, 24-hour) when batch settlement is submitted to this gateway. Determines when daily transaction batches are closed and funds are transferred.',
    `certification_expiry_date` DATE COMMENT 'Date when the gateway providers PCI DSS certification or compliance attestation expires. Requires renewal to maintain operational status.',
    `chargeback_fee` DECIMAL(18,2) COMMENT 'Fee charged by the processor per chargeback dispute in settlement currency. Confidential pricing information.',
    `contract_end_date` DATE COMMENT 'Date when the contract with the gateway provider expires or is scheduled for renewal. Null for open-ended contracts.',
    `contract_start_date` DATE COMMENT 'Date when the contract with the gateway provider became effective. Marks the beginning of the service agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gateway configuration record was first created in the system. Audit trail for record lifecycle.',
    `endpoint_url` STRING COMMENT 'The HTTPS endpoint URL for authorization and settlement API calls. Confidential operational configuration.',
    `gateway_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the gateway configuration (e.g., FIRSTDATA_POS, STRIPE_ECOM, WORLDPAY_FUEL). Used for routing logic and system integration references.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `gateway_name` STRING COMMENT 'Human-readable name of the payment gateway configuration (e.g., First Data POS Gateway, Stripe eCommerce Gateway).',
    `gateway_status` STRING COMMENT 'Current operational status of the gateway configuration. Active gateways are available for transaction routing; inactive/suspended gateways are excluded from routing logic.. Valid values are `active|inactive|suspended|testing|decommissioned`',
    `gateway_type` STRING COMMENT 'Classification of the gateway by channel or use case. Determines which business systems route transactions through this gateway.. Valid values are `pos|ecommerce|fuel|mobile|kiosk|pharmacy`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this gateway is currently active and available for transaction routing. True = active, False = inactive.',
    `last_health_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful health check or connectivity test to the gateway endpoint. Used for monitoring and alerting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this gateway configuration record was last updated. Audit trail for record lifecycle.',
    `merchant_account_number` STRING COMMENT 'The unique merchant identifier assigned by the processor or acquirer. Used in authorization and settlement messages. Confidential business identifier.',
    `monthly_gateway_fee` DECIMAL(18,2) COMMENT 'Fixed monthly fee charged by the gateway provider for access and maintenance in settlement currency. Confidential pricing information.',
    `notes` STRING COMMENT 'Free-text field for operational notes, configuration details, or special instructions related to this gateway configuration.',
    `pci_dss_compliance_level` STRING COMMENT 'The PCI DSS compliance level of the gateway provider based on annual transaction volume. Level 1 is highest (6M+ transactions/year), Level 4 is lowest (under 1M transactions/year). Determines audit and validation requirements.. Valid values are `level_1|level_2|level_3|level_4`',
    `priority_rank` STRING COMMENT 'Numeric priority rank for multi-gateway routing logic. Lower numbers indicate higher priority. When multiple gateways support the same tender type, the system routes to the highest priority (lowest rank number) available gateway.',
    `processor_name` STRING COMMENT 'Name of the underlying payment processor or acquirer (e.g., First Data, Worldpay, Stripe, Chase Paymentech, Elavon). The entity that processes authorization and settlement requests.',
    `retry_policy` STRING COMMENT 'Defines the retry behavior when a gateway request fails or times out. Options: none (no retry), once (single retry), twice (two retries), exponential_backoff (progressive delay retries).. Valid values are `none|once|twice|exponential_backoff`',
    `settlement_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which this gateway settles funds (e.g., USD, CAD, MXN). Determines currency conversion and reconciliation logic.. Valid values are `^[A-Z]{3}$`',
    `settlement_lag_days` STRING COMMENT 'Number of business days between batch settlement submission and funds availability in the merchant bank account. Typical values: 1-3 days.',
    `support_contact_email` STRING COMMENT 'Email address for the primary technical support contact at the gateway provider. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `support_contact_name` STRING COMMENT 'Name of the primary technical support contact at the gateway provider for incident escalation and operational issues.',
    `support_contact_phone` STRING COMMENT 'Phone number for the primary technical support contact at the gateway provider. Organizational contact data classified as confidential.',
    `supported_tender_types` STRING COMMENT 'Comma-separated list of tender types this gateway can process (e.g., credit_card, debit_card, ebt, snap, wic, gift_card, mobile_wallet, contactless, fuel_rewards). Drives tender routing logic at Point of Sale (POS) and digital checkout.',
    `supports_3ds` BOOLEAN COMMENT 'Indicates whether this gateway supports 3D Secure authentication protocol for card-not-present transactions (e.g., eCommerce). True = 3DS supported, False = not supported.',
    `supports_recurring_billing` BOOLEAN COMMENT 'Indicates whether this gateway supports recurring billing or subscription payment processing. True = recurring billing supported, False = not supported.',
    `supports_tokenization` BOOLEAN COMMENT 'Indicates whether this gateway supports payment tokenization for secure storage and reuse of payment credentials. True = tokenization supported, False = not supported.',
    `terminal_id_prefix` STRING COMMENT 'Prefix used to construct terminal identifiers for Point of Sale (POS) devices routing through this gateway. Enables terminal-level transaction tracking and reconciliation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `timeout_ms` STRING COMMENT 'Maximum time in milliseconds to wait for a response from the gateway before timing out the authorization request. Critical for customer experience at Point of Sale (POS).',
    `transaction_fee_fixed` DECIMAL(18,2) COMMENT 'Fixed per-transaction fee charged by the processor in settlement currency (e.g., 0.1000 = $0.10 per transaction). Confidential pricing information.',
    `transaction_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage-based transaction fee charged by the processor per authorization (e.g., 0.0250 = 2.50%). Confidential pricing information used for cost allocation and profitability analysis.',
    `uptime_percentage` DECIMAL(18,2) COMMENT 'Gateway uptime percentage over the last 30 days (e.g., 99.95). Service level agreement (SLA) performance metric.',
    CONSTRAINT pk_gateway PRIMARY KEY(`gateway_id`)
) COMMENT 'Reference master of external payment gateway and processor configurations used by Grocery to route authorization and settlement requests. Captures gateway_code, gateway_name, processor_name (e.g., First Data, Worldpay, Stripe), supported_tender_types, gateway_endpoint_url, timeout_ms, retry_policy, settlement_currency, acquirer_bank, merchant_id, terminal_id_prefix, pci_dss_compliance_level, certification_expiry_date, and is_active flag. Supports multi-gateway routing logic for POS, eCommerce, and fuel center payment lanes.';

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`authorization` (
    `authorization_id` BIGINT COMMENT 'Unique identifier for the payment authorization transaction. Primary key for the authorization data product.',
    `gateway_id` BIGINT COMMENT 'Foreign key linking to payment.gateway. Business justification: Each authorization request is routed through a specific payment gateway. The authorization table has gateway_reference_code (STRING) and processor_name (STRING) as denormalized captures, but lacks a p',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.method. Business justification: An authorization is performed against a specific stored payment instrument (method). Linking authorization to method enables fraud analysis, tokenization tracking, and stored-instrument lifecycle mana',
    `settlement_batch_id` BIGINT COMMENT 'Identifier of the settlement batch to which this authorization will be or has been submitted. Used for reconciliation between authorizations and settlements.',
    `shopper_id` BIGINT COMMENT 'Identifier of the customer associated with this authorization. Links payment authorization to customer loyalty and transaction history.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store location where the authorization was initiated. Null for digital commerce channels.',
    `tender_type_id` BIGINT COMMENT 'Foreign key linking to payment.tender_type. Business justification: Each authorization is for a specific tender type (credit, debit, EBT, etc.). The authorization table currently stores tender_type as a STRING, which is a denormalized copy of the tender_type master. A',
    `transaction_id` BIGINT COMMENT 'Reference to the parent transaction or order that initiated this authorization request. Links authorization to the originating business transaction.',
    `acquirer_reference_number` STRING COMMENT '23-character unique reference number assigned by the acquiring bank for card transactions. Critical for chargeback and dispute tracking across the payment network.. Valid values are `^[A-Z0-9]{23}$`',
    `amount` DECIMAL(18,2) COMMENT 'Total amount requested for authorization in the transaction currency. Represents the full payment amount submitted to the payment gateway.',
    `authorization_code` STRING COMMENT 'Approval code returned by the payment gateway or card issuer upon successful authorization. Used for settlement reconciliation and dispute resolution.. Valid values are `^[A-Z0-9]{6,10}$`',
    `authorization_status` STRING COMMENT 'Current status of the authorization request indicating whether the payment was approved, declined, referred for manual review, timed out, encountered an error, or partially approved.. Valid values are `approved|declined|referred|timeout|error|partial_approval`',
    `avs_result_code` STRING COMMENT 'Single-character code indicating the result of address verification check comparing billing address to issuer records. Used for fraud prevention (e.g., Y=Match, N=No Match, U=Unavailable).. Valid values are `^[A-Z]{1}$`',
    `card_brand` STRING COMMENT 'Brand or network of the payment card used (Visa, Mastercard, American Express, Discover, etc.). Null for non-card tender types. [ENUM-REF-CANDIDATE: visa|mastercard|amex|discover|jcb|diners|maestro|unionpay|other — 9 candidates stripped; promote to reference product]',
    `cardholder_verification_method` STRING COMMENT 'Method used to verify the cardholder identity during the transaction (PIN entry, signature, no verification required, biometric, device authentication for mobile wallets).. Valid values are `pin|signature|no_verification|biometric|device_authentication`',
    `channel` STRING COMMENT 'Channel through which the authorization was initiated (in-store POS, eCommerce website, mobile app, phone order, self-service kiosk, fuel pump).. Valid values are `pos|ecommerce|mobile_app|phone|kiosk|fuel_pump`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the authorization amount (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `cvv_result_code` STRING COMMENT 'Single-character code indicating the result of CVV/CVC verification check. Used for fraud prevention (e.g., M=Match, N=No Match, P=Not Processed).. Valid values are `^[A-Z]{1}$`',
    `ebt_balance_remaining` DECIMAL(18,2) COMMENT 'Remaining balance on the EBT card after this authorization. Returned by the EBT processor for SNAP and WIC transactions to inform the customer of available benefits.',
    `entry_mode` STRING COMMENT 'Method by which the payment card data was captured (chip/EMV, magnetic stripe swipe, contactless/NFC, manual key entry, eCommerce, mobile wallet, tokenized). Impacts interchange rates and fraud liability. [ENUM-REF-CANDIDATE: chip|swipe|contactless|manual|ecommerce|mobile_wallet|token — 7 candidates stripped; promote to reference product]',
    `fuel_rewards_redeemed_amount` DECIMAL(18,2) COMMENT 'Dollar amount of fuel rewards redeemed and applied to this authorization. Specific to fuel center transactions where loyalty fuel rewards are used as partial payment.',
    `gateway_reference_code` STRING COMMENT 'Unique transaction identifier assigned by the payment gateway. Used for reconciliation, dispute resolution, and gateway-specific transaction tracking.. Valid values are `^[A-Z0-9-]{10,50}$`',
    `is_void` BOOLEAN COMMENT 'Indicates whether this authorization has been voided before settlement. Voided authorizations release the hold on customer funds and are not submitted for settlement.',
    `loyalty_card_number` STRING COMMENT 'Customer loyalty card number presented during the transaction. Used to link payment authorization to loyalty program benefits and fuel rewards redemption.. Valid values are `^[0-9]{10,16}$`',
    `masked_pan` STRING COMMENT 'Masked version of the payment card number showing only the first 4 and last 4 digits (e.g., 4532********1234). Used for customer service and reconciliation while maintaining PCI DSS compliance.. Valid values are `^[0-9]{4}[*]{6,10}[0-9]{4}$`',
    `merchant_category_code` STRING COMMENT 'Four-digit code classifying the type of business for the merchant (e.g., 5411=Grocery Stores, 5542=Automated Fuel Dispensers). Used for interchange rate determination and card program restrictions.. Valid values are `^[0-9]{4}$`',
    `network_transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the card network (Visa, Mastercard, etc.). Used for end-to-end transaction tracking across the payment ecosystem.. Valid values are `^[A-Z0-9]{15,25}$`',
    `partial_approval_flag` BOOLEAN COMMENT 'Indicates whether the authorization was partially approved for an amount less than the requested amount. Common for prepaid cards and EBT transactions with insufficient balance.',
    `partial_approved_amount` DECIMAL(18,2) COMMENT 'Amount actually approved when partial_approval_flag is true. Null when full amount is approved or authorization is declined.',
    `pos_terminal_code` STRING COMMENT 'Identifier of the physical POS terminal or register that initiated the authorization. Null for digital commerce channels.. Valid values are `^[A-Z0-9]{4,16}$`',
    `processor_name` STRING COMMENT 'Name of the payment processor or gateway that handled this authorization (e.g., First Data, Worldpay, Chase Paymentech). Used for multi-processor routing analysis and reconciliation.',
    `requested_at_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorization request was submitted to the payment gateway. Represents the start of the authorization lifecycle.',
    `responded_at_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorization response was received from the payment gateway. Used to calculate response time and monitor gateway performance.',
    `response_code` STRING COMMENT 'Standardized response code returned by the payment gateway or card issuer indicating the reason for approval or decline (e.g., 00=Approved, 05=Do Not Honor, 51=Insufficient Funds).. Valid values are `^[A-Z0-9]{2,4}$`',
    `response_time_ms` STRING COMMENT 'Time elapsed in milliseconds between authorization request and response. Key performance indicator for payment gateway and network performance monitoring.',
    `retrieval_reference_number` STRING COMMENT '12-character reference number used to identify and retrieve transaction details from the card network. Critical for dispute resolution and chargeback processing.. Valid values are `^[A-Z0-9]{12}$`',
    `risk_score` STRING COMMENT 'Numerical fraud risk score assigned by the payment gateway or fraud detection system. Higher scores indicate higher fraud risk. Used for real-time fraud prevention and manual review decisioning.',
    `three_d_secure_eci` STRING COMMENT 'Two-digit code indicating the level of 3D Secure authentication completed. Determines liability shift for fraudulent transactions in card-not-present scenarios.. Valid values are `^[0-9]{2}$`',
    `three_d_secure_status` STRING COMMENT 'Status of 3D Secure authentication for eCommerce and card-not-present transactions. Indicates whether cardholder authentication was successful, attempted, or not available.. Valid values are `authenticated|attempted|not_enrolled|error|bypassed`',
    `token_reference` STRING COMMENT 'Tokenized representation of the payment card used for recurring transactions and stored payment methods. Replaces actual card number for PCI DSS compliance.. Valid values are `^[A-Z0-9-]{16,50}$`',
    `voided_at_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorization was voided. Null if authorization has not been voided.',
    CONSTRAINT pk_authorization PRIMARY KEY(`authorization_id`)
) COMMENT 'Transactional record of each payment authorization request and response processed through Grocerys payment gateways. Captures authorization_code, authorization_status (approved, declined, referred, timeout), tender_type, card_brand, masked_pan, authorization_amount, currency_code, response_code, avs_result_code, cvv_result_code, gateway_reference_id, acquirer_reference_number (ARN), pos_terminal_id, store_id, channel (POS, eCommerce, mobile), requested_at_timestamp, responded_at_timestamp, response_time_ms, partial_approval_flag, partial_approved_amount, and is_void flag. Core transactional entity for real-time payment decisioning sourced from NCR POS and Salesforce Commerce Cloud.';

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`transaction` (
    `transaction_id` BIGINT COMMENT 'Unique identifier for the payment transaction record. Primary key for the payment_transaction product.',
    `channel_price_id` BIGINT COMMENT 'Foreign key linking to pricing.channel_price. Business justification: Omnichannel price audit and compliance: grocery retailers operating e-commerce, delivery, and in-store channels must verify the correct channel-specific price was charged per transaction. This link en',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for allocating each POS payment to the responsible cost center for profitability analysis and daily expense reporting.',
    `direct_store_delivery_id` BIGINT COMMENT 'Foreign key linking to supply.direct_store_delivery. Business justification: DSD invoices generate vendor payment transactions. Linking payment_transaction to the originating DSD record enables DSD invoice payment tracking, AP reconciliation, and audit of which DSD delivery ea',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Links each transaction to its accounting period, supporting period‑close reporting, variance analysis, and SOX compliance.',
    `gateway_id` BIGINT COMMENT 'Foreign key linking to payment.gateway. Business justification: Each payment transaction is processed through a specific payment gateway. The payment_transaction table has processor_name (STRING) as a denormalized capture but lacks a FK to the gateway master. Addi',
    `gift_card_id` BIGINT COMMENT 'Foreign key linking to payment.gift_card. Business justification: When a gift card is used in a payment transaction, linking payment_transaction to the gift_card master record enables balance tracking, redemption history, and escheatment analysis. Nullable for non-g',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Enables automatic GL posting of revenue from each payment transaction, essential for the revenue recognition and financial statement generation process.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Three-way match (PO + goods receipt + vendor invoice) is the standard grocery procurement payment control. Linking payment_transaction to goods_receipt enables AP to verify receipt confirmation before',
    `markdown_id` BIGINT COMMENT 'Foreign key linking to pricing.markdown. Business justification: Markdown clearance effectiveness reporting: grocery operations track whether markdown events actually drove transactions to measure sell-through rates and ROI. Linking payment_transaction to the markd',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.method. Business justification: A payment transaction uses a specific stored payment instrument when the shopper pays with a saved method (card on file, digital wallet). Linking payment_transaction to method enables stored-instrumen',
    `order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Order-to-cash reconciliation and omnichannel payment reporting require linking each payment transaction directly to its fulfillment order. Grocery finance teams reconcile delivery/pickup payments agai',
    `price_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.price_rule. Business justification: Enables audit of which pricing rule generated the final sale price for each transaction, supporting margin optimization reviews.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Required for pricing compliance reports linking each sale to the pricing zone (fuel, pharmacy, etc.) used at transaction time.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: REQUIRED: Attributing each transaction to the driving promotion campaign enables campaign ROI analysis and financial reporting.',
    `refund_reference_transaction_id` BIGINT COMMENT 'Reference to the original payment_transaction_id that this refund or reversal is associated with. Null for original sale transactions. Used to link refunds back to original purchases.',
    `settlement_batch_id` BIGINT COMMENT 'Identifier for the settlement batch that includes this transaction. Used for reconciliation between POS (Point of Sale) systems and payment processor settlement reports.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: Required for Shipment Financial Reconciliation Report linking each payment to its shipment for carrier settlement and audit.',
    `shopper_id` BIGINT COMMENT 'Identifier of the customer who made the payment. Links to customer master data for loyalty tracking, personalization, and customer lifetime value analysis. Null for anonymous cash transactions.',
    `store_location_id` BIGINT COMMENT 'Identifier of the physical store location where the transaction occurred. Links to store master data for location-based reporting and analysis.',
    `tender_type_id` BIGINT COMMENT 'Foreign key linking to payment.tender_type. Business justification: Each payment transaction has a primary tender type. The payment_transaction table currently stores tender_type as a STRING, which is a denormalized copy of the tender_type master. Adding tender_type_i',
    `tpr_id` BIGINT COMMENT 'Foreign key linking to pricing.tpr. Business justification: Vendor-funded TPR reconciliation and TPR lift reporting: grocery retailers must reconcile which specific TPR event drove each discounted transaction to bill back suppliers for vendor-funded TPRs and m',
    `amount` DECIMAL(18,2) COMMENT 'Total payment amount processed in this transaction, including all charges, taxes, tips, and fees. Represents the gross amount authorized and captured.',
    `authorization_code` STRING COMMENT 'Approval code returned by the payment processor or card issuer confirming the transaction was authorized. Required for settlement and chargeback defense.. Valid values are `^[A-Z0-9]{6,10}$`',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time when the payment authorization was received from the payment gateway or card issuer. May differ from transaction_timestamp due to network latency.',
    `card_entry_mode` STRING COMMENT 'Method by which card data was captured. Chip for EMV chip read, swipe for magnetic stripe, contactless for NFC tap, manual for keyed entry, ecommerce for online entry, mobile_wallet for tokenized digital wallet.. Valid values are `chip|swipe|contactless|manual|ecommerce|mobile_wallet`',
    `card_last_four` STRING COMMENT 'Last four digits of the payment card number. Stored for customer service and dispute resolution while maintaining PCI DSS (Payment Card Industry Data Security Standard) compliance by not storing full card number.. Valid values are `^[0-9]{4}$`',
    `card_type` STRING COMMENT 'Payment card network or brand for credit and debit card transactions. Determines interchange fees and processing rules. Unknown used for non-card tender types. [ENUM-REF-CANDIDATE: visa|mastercard|amex|discover|jcb|diners|maestro|unknown — 8 candidates stripped; promote to reference product]',
    `cashback_amount` DECIMAL(18,2) COMMENT 'Cash disbursement amount requested by customer during debit card transaction at POS (Point of Sale). Common in grocery retail for customer convenience.',
    `channel` STRING COMMENT 'Sales channel where the payment transaction originated. In_store_pos for traditional checkout lanes, ecommerce for online orders, curbside_pickup for click-and-collect, fuel_center for gas station pumps, mobile_app for native mobile application, call_center for phone orders.. Valid values are `in_store_pos|ecommerce|curbside_pickup|fuel_center|mobile_app|call_center`',
    `chargeback_date` DATE COMMENT 'Date when chargeback was initiated by the card issuer. Null if no chargeback has occurred. Used for chargeback rate monitoring and dispute management.',
    `chargeback_flag` BOOLEAN COMMENT 'Indicates whether this transaction has been disputed by the cardholder and resulted in a chargeback. True if chargeback initiated, false otherwise.',
    `chargeback_reason_code` STRING COMMENT 'Standardized code provided by card network indicating the reason for chargeback. Examples include fraud, authorization issue, processing error, customer dispute.. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this payment transaction record was first created in the database. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount. Typically USD for US-based grocery operations, but supports multi-currency for international expansion.. Valid values are `^[A-Z]{3}$`',
    `decline_reason` STRING COMMENT 'Reason code or message provided by card issuer or payment processor when transaction is declined. Examples include insufficient funds, expired card, invalid CVV, suspected fraud.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the transaction from promotions, coupons, loyalty rewards, or markdown pricing. Reduces the subtotal before tax calculation.',
    `fuel_reward_discount_applied` DECIMAL(18,2) COMMENT 'Dollar amount of fuel rewards discount applied to this transaction. Common in grocery retail loyalty programs that offer cents-per-gallon discounts at affiliated fuel centers.',
    `loyalty_points_earned` STRING COMMENT 'Number of loyalty program points earned by the customer for this transaction. Based on purchase amount and promotional multipliers.',
    `loyalty_points_redeemed` STRING COMMENT 'Number of loyalty program points redeemed by the customer to reduce transaction amount or receive discounts.',
    `payment_token` STRING COMMENT 'Tokenized representation of payment card or account number. Used for recurring payments and stored payment methods while maintaining PCI DSS compliance.. Valid values are `^[A-Z0-9]{16,64}$`',
    `pos_terminal_code` STRING COMMENT 'Unique identifier of the POS (Point of Sale) terminal or checkout lane where transaction was processed. Used for terminal reconciliation and performance tracking.. Valid values are `^[A-Z0-9]{4,12}$`',
    `processor_name` STRING COMMENT 'Name of the payment gateway or processor that handled the transaction authorization and settlement. Examples include First Data, Worldpay, Chase Paymentech.',
    `processor_transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the payment processor. Used for transaction lookup, dispute resolution, and reconciliation with processor settlement files.. Valid values are `^[A-Z0-9]{10,40}$`',
    `receipt_number` STRING COMMENT 'Customer-facing receipt identifier printed on transaction receipt. Used for returns, exchanges, and customer service inquiries.. Valid values are `^[A-Z0-9]{8,20}$`',
    `register_number` STRING COMMENT 'Human-readable register or lane number within the store. Used by store operations for shift reconciliation and cashier assignment.. Valid values are `^[0-9]{1,4}$`',
    `settlement_date` DATE COMMENT 'Date when the payment transaction was settled and funds were transferred from the card issuer to the merchant account. Typically T+1 or T+2 business days after authorization.',
    `snap_eligible_amount` DECIMAL(18,2) COMMENT 'Portion of transaction amount that qualifies for SNAP (Supplemental Nutrition Assistance Program) benefits payment. Only food items meeting USDA eligibility criteria are included.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Base merchandise or service amount before taxes, tips, fees, and adjustments. Used for financial reporting and tax calculation reconciliation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax charged on the transaction. Includes state, county, and municipal taxes as applicable to the store location and product categories.',
    `tip_amount` DECIMAL(18,2) COMMENT 'Gratuity amount added by customer for delivery or service. Applicable primarily to delivery orders and curbside pickup with assisted service.',
    `transaction_number` STRING COMMENT 'Externally-visible unique transaction number assigned by the payment system. Used for customer receipts, reconciliation, and customer service inquiries.. Valid values are `^[A-Z0-9]{10,20}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Completed indicates successful settlement, failed indicates unsuccessful attempt, voided indicates cancelled before settlement, reversed indicates post-settlement cancellation, pending indicates awaiting authorization response, declined indicates rejected by issuer.. Valid values are `completed|failed|voided|reversed|pending|declined`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the payment transaction was initiated at the point of sale or digital commerce checkout. Represents the business event time, not the system record creation time.',
    `transaction_type` STRING COMMENT 'Type of payment transaction: sale (standard purchase), refund (return of funds), void (cancellation before settlement), reversal (post-settlement cancellation), force (offline authorization), preauth (authorization hold), capture (completion of preauth). [ENUM-REF-CANDIDATE: sale|refund|void|reversal|force|preauth|capture — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this payment transaction record was last modified. Updated when transaction status changes or corrections are applied.',
    `wic_eligible_amount` DECIMAL(18,2) COMMENT 'Portion of transaction amount that qualifies for WIC (Women Infants and Children) program benefits payment. Only approved WIC items per state program guidelines are included.',
    CONSTRAINT pk_transaction PRIMARY KEY(`transaction_id`)
) COMMENT 'Core payment transaction record representing a completed payment event at Grocery across all channels and tender types. Captures transaction_type (sale, refund, void, force), transaction_status (completed, failed, voided, reversed), tender_type, transaction_amount, tax_amount, tip_amount, cashback_amount, currency_code, pos_terminal_id, store_id, register_number, cashier_id, channel (in-store POS, eCommerce, curbside pickup, fuel center), transaction_timestamp, batch_id, authorization_id reference, loyalty_account_reference, snap_eligible_amount, wic_eligible_amount, fuel_reward_discount_applied, and receipt_number. SSOT for all payment transactions across NCR POS and Salesforce Commerce Cloud.';

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`transaction_tender` (
    `transaction_tender_id` BIGINT COMMENT 'Unique identifier for the transaction tender line item. Primary key for this association entity capturing individual tender applications within a payment transaction.',
    `authorization_id` BIGINT COMMENT 'Reference to the payment authorization record for this tender. Links to the authorization response from the payment gateway or processor, enabling reconciliation of authorizations to settlements and supporting chargeback investigation.',
    `gift_card_id` BIGINT COMMENT 'Foreign key linking to payment.gift_card. Business justification: When a gift card tender is applied to a transaction, the tender line should link to the gift_card master record for balance verification, redemption tracking, and fraud detection. transaction_tender c',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.method. Business justification: Each tender line item in a transaction is applied using a specific stored payment instrument. transaction_tender currently has payment_method_reference (STRING) as a denormalized reference. Adding met',
    `settlement_batch_id` BIGINT COMMENT 'Identifier for the processor settlement batch containing this tender. Links individual tenders to batch settlement reports for reconciliation. Used to identify and resolve settlement discrepancies.',
    `store_location_id` BIGINT COMMENT 'Reference to the retail store location where this tender was processed. Supports location-based payment method analysis, regional tender preference trends, and store-level financial reconciliation.',
    `tender_type_id` BIGINT COMMENT 'Foreign key linking to payment.tender_type. Business justification: Each transaction_tender record references a tender type; a foreign key to tender_type.tender_type_id provides referential integrity and allows removal of the redundant string column.',
    `transaction_id` BIGINT COMMENT 'Reference to the parent payment transaction header. Links this tender line to the overall transaction, supporting split-tender scenarios where multiple payment methods are applied to a single purchase.',
    `avs_response_code` STRING COMMENT 'Response code from Address Verification Service indicating match status between billing address provided and address on file with card issuer. Used for fraud detection in card-not-present transactions. Standardized codes vary by card network.',
    `card_brand` STRING COMMENT 'Credit or debit card network brand for card-based tenders. Used for interchange fee calculation, processor routing, and payment method performance analysis. Applicable to credit_card and debit_card tender types. [ENUM-REF-CANDIDATE: visa|mastercard|amex|discover|jcb|diners_club|other — 7 candidates stripped; promote to reference product]',
    `card_entry_method` STRING COMMENT 'Method by which card data was captured at point of sale. Distinguishes between EMV chip, magnetic stripe swipe, contactless/NFC, manual key entry, and digital commerce channels. Critical for fraud analysis, chargeback liability determination, and PCI DSS compliance reporting.. Valid values are `chip|swipe|contactless|manual_entry|ecommerce|mobile_app`',
    `change_due_amount` DECIMAL(18,2) COMMENT 'Cash change returned to customer when cash tender exceeds transaction total. Applicable only to cash tender types. Null for non-cash tenders. Used for cash drawer reconciliation and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this tender record was first created in the database. Used for audit trail, data lineage tracking, and troubleshooting data pipeline issues. Distinct from tender_timestamp which represents the business event time.',
    `cvv_verified_flag` BOOLEAN COMMENT 'Indicates whether card CVV/CVV2 code was verified for card-not-present transactions (ecommerce, phone orders). True if CVV matched, False otherwise. Reduces fraud risk and may affect chargeback liability for digital commerce transactions.',
    `ebt_benefit_type` STRING COMMENT 'Specific government benefit program category for EBT tenders. Distinguishes between SNAP food benefits (eligible food items only), SNAP cash benefits (broader usage), TANF (Temporary Assistance for Needy Families), and WIC (Women, Infants, and Children) vouchers. Required for regulatory reporting and program compliance.. Valid values are `snap_food|snap_cash|tanf|wic`',
    `ebt_voucher_number` STRING COMMENT 'Unique voucher or transaction identifier for WIC or other voucher-based benefit programs. Used for state agency reconciliation and program audit compliance. Stored securely to protect participant privacy per HIPAA and state regulations.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Risk score assigned by fraud detection system for this tender. Higher scores indicate elevated fraud risk. Used for real-time transaction decisioning, post-transaction review, and fraud pattern analysis. Scale and interpretation vary by fraud detection vendor.',
    `fuel_reward_discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of fuel rewards discount applied to this transaction. Calculated from fuel_reward_points_redeemed based on program conversion rates. Used for financial reconciliation and loyalty program liability tracking.',
    `fuel_reward_points_redeemed` STRING COMMENT 'Number of loyalty fuel reward points applied as tender toward this transaction. Common in grocery retail where fuel center partnerships allow customers to redeem accumulated points for discounts on groceries or fuel. Null if no fuel rewards were applied.',
    `gateway_response_code` STRING COMMENT 'Response code returned by payment gateway indicating approval, decline, or error condition. Standardized codes enable automated exception handling, decline analysis, and customer service troubleshooting. Mapped to internal status values for reporting.',
    `gateway_response_message` STRING COMMENT 'Human-readable message from payment gateway describing the transaction outcome. Provides additional context for declines, errors, or special conditions. Used for customer service inquiries and operational troubleshooting.',
    `mobile_wallet_type` STRING COMMENT 'Specific mobile wallet platform used for digital payment tenders. Distinguishes between Apple Pay, Google Pay, Samsung Pay, and other mobile payment applications. Enables analysis of digital payment adoption and customer payment preferences.. Valid values are `apple_pay|google_pay|samsung_pay|paypal|venmo|other`',
    `pin_verified_flag` BOOLEAN COMMENT 'Indicates whether PIN verification was successfully completed for debit card or EBT tenders. True if PIN was verified, False otherwise. Affects interchange rates and fraud liability. Critical for EBT compliance and debit card routing.',
    `processor_transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the payment processor or gateway. Used for reconciliation with processor settlement files, chargeback investigation, and dispute resolution. Links internal transaction records to external processor systems.',
    `refund_reason_code` STRING COMMENT 'Categorized reason for tender refund or reversal. Enables analysis of refund patterns, identification of operational issues, and fraud detection. Populated only when tender_status indicates refund or reversal.. Valid values are `customer_request|damaged_goods|pricing_error|duplicate_charge|fraud|other`',
    `register_code` BIGINT COMMENT 'Reference to the specific POS register or terminal where this tender was processed. Enables device-level performance analysis, hardware issue identification, and audit trail for cash drawer reconciliation.',
    `settlement_date` DATE COMMENT 'Date when this tender was settled with the payment processor or financial institution. May differ from tender_timestamp due to batch processing cycles. Critical for cash flow forecasting, working capital management, and financial reconciliation.',
    `signature_captured_flag` BOOLEAN COMMENT 'Indicates whether customer signature was captured for this tender. Required for certain transaction types and amounts per card network rules. Used for chargeback defense and fraud investigation. True if signature was obtained, False otherwise.',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Additional fee applied to this tender method (e.g., credit card surcharge where legally permitted). Must comply with card network rules and state regulations. Used for fee revenue tracking and customer communication.',
    `tender_amount` DECIMAL(18,2) COMMENT 'Monetary value applied from this specific tender method toward the transaction total. In split-tender scenarios, the sum of all tender_amount values equals the transaction total. Always expressed in the stores base currency.',
    `tender_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the tender amount. Typically USD for US-based grocery operations, but supports multi-currency scenarios for international locations or border stores.. Valid values are `^[A-Z]{3}$`',
    `tender_sequence_number` STRING COMMENT 'Sequential ordering of tender applications within the parent transaction. Indicates the order in which payment methods were applied (e.g., 1 for first tender, 2 for second in split-tender scenario).',
    `tender_status` STRING COMMENT 'Current lifecycle state of this tender line item. Tracks progression from initial authorization through settlement, and captures post-transaction events such as voids, refunds, and reversals. Critical for financial reconciliation and exception handling. [ENUM-REF-CANDIDATE: approved|declined|pending|voided|refunded|partially_refunded|reversed|settled — 8 candidates stripped; promote to reference product]',
    `tender_timestamp` TIMESTAMP COMMENT 'Precise date and time when this tender was applied to the transaction. In split-tender scenarios, may differ slightly from transaction timestamp if multiple payment methods were processed sequentially. Used for transaction sequencing and audit trail.',
    `tip_amount` DECIMAL(18,2) COMMENT 'Gratuity amount added to the tender by customer. Applicable primarily to delivery and pickup orders where tipping is enabled. Null for in-store transactions unless tip functionality is supported. Used for driver compensation and service quality analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this tender record was last modified. Captures updates due to status changes (voids, refunds), settlement processing, or data corrections. Used for audit trail and change data capture processing.',
    CONSTRAINT pk_transaction_tender PRIMARY KEY(`transaction_tender_id`)
) COMMENT 'Association entity capturing the individual tender line items applied to a single payment transaction, supporting split-tender scenarios common in grocery retail (e.g., partial EBT + debit card). Captures transaction_id reference, tender_type, tender_amount, tender_sequence_number, payment_method_reference, authorization_id reference, change_due_amount (for cash), ebt_benefit_type (SNAP food, SNAP cash, WIC), gift_card_reference, fuel_reward_points_redeemed, and tender_status. Enables accurate tender-level reconciliation and regulatory reporting for SNAP/WIC transactions.';

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`settlement_batch` (
    `settlement_batch_id` BIGINT COMMENT 'Unique identifier for the settlement batch record. Primary key for the settlement batch entity.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Bank reconciliation process: settlement batch funds are deposited into a specific bank account. Grocery treasury teams match settlement batches to bank account deposits daily. This link is essential f',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Period-end close process: settlement batches must be assigned to a fiscal period for revenue recognition and financial close. Grocery finance requires this to ensure all card settlements are captured ',
    `gateway_id` BIGINT COMMENT 'Identifier of the payment gateway or processor that handled the transactions in this batch. Used for gateway-specific reconciliation and fee analysis.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Daily cash settlement reconciliation: each settlement batch is posted to a specific GL account (e.g., cash clearing). Grocery finance teams require this link for period-end GL reconciliation and cash ',
    `store_location_id` BIGINT COMMENT 'Identifier of the store location where the payment transactions in this batch originated. Links to the store master for location-based settlement analysis.',
    `acquirer_batch_reference` STRING COMMENT 'External reference number assigned by the acquiring bank to this settlement batch. Used for cross-referencing with bank statements and acquirer reports.',
    `batch_close_timestamp` TIMESTAMP COMMENT 'Date and time when the settlement batch was closed and no additional transactions were accepted. Triggers batch submission workflow.',
    `batch_date` DATE COMMENT 'The business date on which the settlement batch was created and transactions were grouped for submission to the acquiring bank.',
    `batch_number` STRING COMMENT 'Business identifier for the settlement batch assigned by the payment gateway or acquiring bank. Used for reconciliation and reference in financial systems.',
    `batch_open_timestamp` TIMESTAMP COMMENT 'Date and time when the settlement batch was opened and began accepting transactions for grouping.',
    `batch_status` STRING COMMENT 'Current lifecycle status of the settlement batch indicating its position in the settlement workflow from creation through funding.. Valid values are `open|submitted|accepted|rejected|reconciled|disputed`',
    `batch_type` STRING COMMENT 'Classification of the settlement batch based on processing priority and submission method. Impacts funding timeline and processing fees.. Valid values are `standard|expedited|manual|correction`',
    `chargeback_count` STRING COMMENT 'Number of chargeback transactions included in this settlement batch that reduce the net settlement amount due to disputed charges.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the settlement batch record was first created in the payment system.',
    `ecommerce_transaction_count` STRING COMMENT 'Number of online digital commerce transactions included in this settlement batch. Used for channel-specific settlement analysis.',
    `exception_count` STRING COMMENT 'Number of transactions in this batch that were flagged with exceptions, disputes, or exclusions from settlement. Used for exception management and quality monitoring.',
    `fuel_transaction_count` STRING COMMENT 'Number of fuel center payment transactions included in this settlement batch. Used for fuel operations settlement analysis.',
    `funding_date` DATE COMMENT 'The business date on which the net settlement amount is expected to be deposited into the merchant bank account. Critical for cash flow forecasting and reconciliation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the settlement batch record was last updated. Used for tracking batch lifecycle changes and audit trail.',
    `merchant_account_number` STRING COMMENT 'The merchant bank account number to which the net settlement amount will be deposited. Used for bank reconciliation and funding verification.',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'Net amount to be funded to the merchant account after deduction of all interchange fees, assessment fees, and gateway processing fees from the total batch amount.',
    `pharmacy_transaction_count` STRING COMMENT 'Number of pharmacy prescription payment transactions included in this settlement batch. Used for pharmacy operations settlement analysis.',
    `pos_terminal_count` STRING COMMENT 'Number of distinct POS terminals that contributed transactions to this settlement batch. Used for terminal-level settlement analysis.',
    `processor_response_code` STRING COMMENT 'Response code returned by the payment processor or acquiring bank indicating acceptance or rejection of the settlement batch.',
    `reconciliation_status` STRING COMMENT 'Status of the reconciliation process comparing the settlement batch totals with bank statement deposits and SAP FI postings.. Valid values are `pending|matched|variance|resolved`',
    `refund_count` STRING COMMENT 'Number of refund transactions included in this settlement batch that reduce the net settlement amount due to returned merchandise or cancelled orders.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the acquiring bank or processor when a settlement batch is rejected. Used for issue resolution and resubmission.',
    `settlement_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the settlement batch will be funded to the merchant bank account.. Valid values are `^[A-Z]{3}$`',
    `settlement_timestamp` TIMESTAMP COMMENT 'Date and time when the settlement batch was accepted and processed by the acquiring bank, confirming the batch for funding.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the settlement batch was submitted to the acquiring bank or payment processor for funding.',
    `total_assessment_fee_amount` DECIMAL(18,2) COMMENT 'Total assessment fees charged by card networks (Visa, Mastercard, etc.) for all transactions in this batch. Used for network fee reconciliation.',
    `total_batch_amount` DECIMAL(18,2) COMMENT 'Total gross transaction amount for all payments included in this settlement batch before deduction of interchange fees and assessments.',
    `total_chargeback_amount` DECIMAL(18,2) COMMENT 'Total amount of chargebacks processed in this settlement batch. Reduces the net settlement amount and indicates dispute activity.',
    `total_interchange_fee_amount` DECIMAL(18,2) COMMENT 'Total interchange fees charged by card-issuing banks for all transactions in this batch. Key component of payment processing cost analysis.',
    `total_refund_amount` DECIMAL(18,2) COMMENT 'Total amount of refunds processed in this settlement batch. Reduces the net settlement amount and impacts cash flow analysis.',
    `total_transaction_count` STRING COMMENT 'Total number of payment transactions included in this settlement batch. Used for batch validation and reconciliation control totals.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between expected net settlement amount and actual funded amount. Non-zero values trigger variance investigation and resolution workflows.',
    CONSTRAINT pk_settlement_batch PRIMARY KEY(`settlement_batch_id`)
) COMMENT 'Settlement batch record grouping completed payment transactions submitted to the acquiring bank for funding. Captures batch_number, batch_date, store_id, gateway_id, batch_status (open, submitted, accepted, rejected), total_transaction_count, total_batch_amount, submission_timestamp, settlement_timestamp, acquirer_batch_reference, funding_date, and settlement_currency. Each batch contains line-level settlement details: authorization_code, card_brand, masked_pan, transaction_amount, interchange_fee_amount, assessment_fee_amount, net_settlement_amount, settlement_status (included, excluded, disputed), and exception_reason_code. Supports daily cash reconciliation, interchange fee analysis, exception management, and financial close processes aligned with SAP FI.';

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`chargeback` (
    `chargeback_id` BIGINT COMMENT 'Unique identifier for the payment chargeback record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Chargeback cost allocation: chargeback losses are absorbed by the store or business unit cost center. Grocery operations allocate fraud and dispute costs to store cost centers for shrink/loss reportin',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Chargeback period accrual: chargebacks must be accrued in the correct fiscal period for accurate financial reporting. Grocery finance teams track chargeback aging and period-over-period dispute trends',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Chargeback loss accounting: chargeback net_financial_impact and fees must be posted to specific GL accounts (chargeback expense, fraud loss). Grocery finance requires this for P&L reporting, SOX contr',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to payment.authorization. Business justification: A chargeback is initiated against a specific original authorization. The chargeback table has original_authorization_code (STRING) as a denormalized reference. Adding original_authorization_id FK norm',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: Grocery delivery chargebacks (item not received, wrong items) require shipment-level evidence: proof-of-delivery photo, tracking number, carrier details. Dispute resolution teams must pull shipment re',
    `shopper_id` BIGINT COMMENT 'Foreign key linking to customer.shopper. Business justification: Chargeback dispute management requires direct shopper identification for customer communication (customer_contacted_flag), fraud pattern analysis by customer, and regulatory dispute response. In groce',
    `store_location_id` BIGINT COMMENT 'Reference to the store location where the disputed transaction occurred.',
    `transaction_id` BIGINT COMMENT 'Reference to the original payment transaction that is being disputed.',
    `acquirer_reference_number` STRING COMMENT 'Reference number assigned by the acquiring bank or payment processor for tracking the chargeback.',
    `card_last_four_digits` STRING COMMENT 'Last four digits of the payment card number for identification purposes, compliant with PCI DSS masking requirements.. Valid values are `^[0-9]{4}$`',
    `card_type` STRING COMMENT 'Type of payment card involved in the disputed transaction.. Valid values are `visa|mastercard|amex|discover|other`',
    `case_number` STRING COMMENT 'Internal case tracking number assigned by Grocery for chargeback management and resolution workflow.',
    `chargeback_status` STRING COMMENT 'Current lifecycle status of the chargeback case through the dispute resolution process. [ENUM-REF-CANDIDATE: received|under_review|representment_submitted|won|lost|withdrawn|expired — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this chargeback record was first created in the Grocery system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the dispute amount and fees.. Valid values are `^[A-Z]{3}$`',
    `customer_contacted_flag` BOOLEAN COMMENT 'Indicates whether Grocery attempted to contact the cardholder to resolve the dispute before representment.',
    `dispute_amount` DECIMAL(18,2) COMMENT 'The monetary amount being disputed by the cardholder, typically matching the original transaction amount.',
    `dispute_category` STRING COMMENT 'High-level classification of the chargeback type for reporting and analysis purposes.. Valid values are `fraud|authorization|processing_error|consumer_dispute|other`',
    `evidence_submitted_flag` BOOLEAN COMMENT 'Indicates whether supporting evidence has been submitted to contest the chargeback.',
    `fee` DECIMAL(18,2) COMMENT 'Administrative fee charged by the payment processor or card network for processing the chargeback.',
    `fraud_indicator_flag` BOOLEAN COMMENT 'Indicates whether the chargeback is classified as a fraud-related dispute.',
    `issuing_bank_code` STRING COMMENT 'Unique identifier for the issuing bank, typically the Bank Identification Number (BIN) or Issuer Identification Number (IIN).',
    `issuing_bank_name` STRING COMMENT 'Name of the financial institution that issued the payment card and initiated the chargeback.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this chargeback record was last updated, tracking the most recent change to case status or details.',
    `net_financial_impact` DECIMAL(18,2) COMMENT 'Total financial impact to Grocery including dispute amount, fees, and any recovery, calculated as (dispute_amount + chargeback_fee - recovery_amount).',
    `notes` STRING COMMENT 'Free-text notes and comments from chargeback analysts regarding case investigation, evidence, and resolution strategy.',
    `original_transaction_date` DATE COMMENT 'Date when the original payment transaction that is being disputed occurred.',
    `reason_code` STRING COMMENT 'Standardized code provided by the card network indicating the reason for the chargeback (e.g., fraud, authorization issue, processing error, cardholder dispute).',
    `reason_description` STRING COMMENT 'Detailed explanation of the chargeback reason provided by the cardholder or issuing bank.',
    `received_date` DATE COMMENT 'Date when Grocery was notified of the chargeback by the payment processor or acquiring bank.',
    `received_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the chargeback notification was received in Grocery systems.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered by Grocery if the chargeback was won or partially reversed.',
    `reference_number` STRING COMMENT 'Unique reference number assigned by the card issuer or payment network to identify this chargeback case.',
    `representment_count` STRING COMMENT 'Number of times Grocery has submitted representment evidence for this chargeback case.',
    `representment_deadline` DATE COMMENT 'Final deadline for submitting representment evidence as specified by the card network rules.',
    `representment_submitted_date` DATE COMMENT 'Date when Grocery submitted representment evidence to contest the chargeback.',
    `resolution_date` DATE COMMENT 'Date when the chargeback case was resolved with a final decision (won, lost, or withdrawn).',
    `resolution_outcome` STRING COMMENT 'Final outcome of the chargeback dispute indicating whether Grocery successfully defended the transaction.. Valid values are `merchant_won|merchant_lost|cardholder_withdrew|expired_uncontested|partial_reversal`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the chargeback case reached final resolution.',
    `response_due_date` DATE COMMENT 'Deadline by which Grocery must submit a response or representment to contest the chargeback.',
    CONSTRAINT pk_chargeback PRIMARY KEY(`chargeback_id`)
) COMMENT 'Master record for payment chargebacks and disputes initiated by cardholders or issuing banks against Grocery transactions, including supporting evidence submitted during representment. Captures chargeback lifecycle (reference_number, reason_code, dispute_amount, status through received/review/representment/resolution), card and issuer details, key dates (received, response_due, representment_deadline, resolution), financial impact, and evidence records (evidence_type, file_reference, submission_timestamp, evidence_status). Supports PCI DSS compliance, chargeback win-rate optimization, and financial loss management.';

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`refund` (
    `refund_id` BIGINT COMMENT 'Unique identifier for the payment refund transaction. Primary key for the payment_refund product.',
    `chargeback_id` BIGINT COMMENT 'Foreign key linking to payment.chargeback. Business justification: The refund table has chargeback_related_flag (BOOLEAN) indicating some refunds are issued in response to chargebacks. Adding chargeback_id FK links the refund to the specific chargeback record, enabli',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Refund cost allocation: refund costs (restocking fees, processing fees) are allocated to store cost centers. Grocery store operations track refund rates by cost center for shrink management, store per',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Grocery department P&L and shrink reporting require refunds attributed to the originating department (pharmacy prescription reversals, deli, produce). refund already has prescription_reversal_flag and',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Refund period-end accrual: refunds must be recorded in the correct fiscal period for accurate revenue and liability reporting. Grocery finance requires this for period-end close, refund liability accr',
    `fulfillment_order_line_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order_line. Business justification: Supports line‑level refund tracking, tying each refund to the exact order line for inventory and financial adjustments.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Ensures refund amounts are recorded against the appropriate GL account, needed for net revenue reconciliation and audit trails.',
    `loyalty_redemption_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_redemption. Business justification: When a grocery transaction is refunded, loyalty points redeemed in that transaction must be reversed. The refund record must reference the originating loyalty_redemption to trigger the points reversal',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.method. Business justification: When a refund is returned to the original payment instrument (return_to_original_tender_flag = true), linking refund to the method master record enables tracking of which stored instrument received th',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to payment.authorization. Business justification: A refund is typically tied to the original authorization for the purchase being refunded. The refund table has authorization_code (STRING) as a denormalized reference. Adding original_authorization_id',
    `rx_fill_id` BIGINT COMMENT 'Foreign key linking to pharmacy.rx_fill. Business justification: Prescription copay reversals generate refunds requiring direct traceability to the original rx_fill for insurance reversal processing, DEA audit trails, and copay reconciliation. The refund table alre',
    `settlement_batch_id` BIGINT COMMENT 'Identifier for the payment processor settlement batch that included this refund transaction. Used for reconciliation with payment gateway and bank settlement reports.',
    `shopper_id` BIGINT COMMENT 'Reference to the shopper receiving the refund. Links to the customer master record.',
    `shrink_record_id` BIGINT COMMENT 'Foreign key linking to inventory.shrink_record. Business justification: Return-to-shrink workflow: when a customer refund results in unsaleable product (damaged, expired, food safety risk), a shrink_record is created. Loss prevention and P&L reconciliation reports require',
    `store_location_id` BIGINT COMMENT 'Reference to the store location where the refund was initiated for in-store returns. Null for eCommerce refunds.',
    `tender_type_id` BIGINT COMMENT 'Reference to the payment tender type used for issuing the refund (credit card, debit card, Electronic Benefits Transfer (EBT), store credit, cash, gift card). Links to tender_type reference table.',
    `transaction_id` BIGINT COMMENT 'Reference to the original payment transaction that is being refunded. Links to the source payment record in the payment transaction system.',
    `amount` DECIMAL(18,2) COMMENT 'Total monetary amount being refunded to the customer in the transaction currency, including product cost and applicable taxes. Does not include fees retained by the business.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was approved by authorized personnel. Null for auto-approved refunds. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `chargeback_related_flag` BOOLEAN COMMENT 'Indicates whether this refund was issued in response to or in anticipation of a payment chargeback dispute. True if chargeback-related, False for standard customer-initiated returns.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this refund record was first created in the data system. Used for audit trail and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the refund transaction. Typically USD for United States operations, CAD for Canada, MXN for Mexico.. Valid values are `USD|CAD|MXN`',
    `ebt_snap_reversal_flag` BOOLEAN COMMENT 'Indicates whether this refund involves reversal of a Supplemental Nutrition Assistance Program (SNAP) Electronic Benefits Transfer (EBT) payment. True for SNAP EBT refunds which require special handling per USDA regulations, False otherwise.',
    `fuel_rewards_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary value of fuel rewards points or discounts that were reversed or adjusted as part of this refund. Null if no fuel rewards impact. Used when refunded purchase had earned fuel center loyalty discounts.',
    `gift_card_reissue_number` STRING COMMENT 'Gift card number issued to the customer as the refund method when original payment was gift card or when customer opted for gift card refund. Null if refund not issued as gift card.',
    `initiated_by_channel` STRING COMMENT 'Channel through which the refund was initiated. Point of Sale (POS) for in-store returns, ecommerce for online order cancellations, mobile_app for app-based returns, customer_service for call center initiated refunds, pharmacy for prescription reversals.. Valid values are `pos|ecommerce|mobile_app|customer_service|pharmacy`',
    `initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the refund request was first created in the system, before approval or processing. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this refund record was last updated in the data system. Used for audit trail and change tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `payment_gateway_transaction_reference` STRING COMMENT 'External transaction identifier assigned by the payment gateway or processor for this refund. Used for reconciliation and dispute resolution with payment networks.',
    `prescription_reversal_flag` BOOLEAN COMMENT 'Indicates whether this refund represents a pharmacy prescription transaction reversal. True for pharmacy prescription refunds, False for retail merchandise refunds. Pharmacy refunds have additional Health Insurance Portability and Accountability Act (HIPAA) compliance requirements.',
    `processing_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by payment processor or card network for processing the refund transaction. Represents cost to the business, not charged to customer. Null if no processing fee.',
    `reason_code` STRING COMMENT 'Standardized code categorizing the business reason for the refund. DEFECTIVE indicates product quality issue, WRONG_ITEM indicates fulfillment error, NOT_AS_DESCRIBED indicates product mismatch with listing, CUSTOMER_REMORSE indicates buyer changed mind, DUPLICATE_ORDER indicates accidental repeat purchase, PRICING_ERROR indicates incorrect charge.. Valid values are `DEFECTIVE|WRONG_ITEM|NOT_AS_DESCRIBED|CUSTOMER_REMORSE|DUPLICATE_ORDER|PRICING_ERROR`',
    `reason_description` STRING COMMENT 'Free-text detailed explanation of the refund reason provided by the associate or customer. Supplements the refund_reason_code with specific context.',
    `refund_number` STRING COMMENT 'Externally visible unique refund transaction number displayed on customer receipts and used for customer service inquiries. Format: RFN followed by 10 digits.. Valid values are `^RFN[0-9]{10}$`',
    `refund_status` STRING COMMENT 'Current lifecycle status of the refund transaction. Pending indicates awaiting approval, approved indicates authorized but not yet processed, processed indicates funds returned to customer, failed indicates processing error, cancelled indicates refund voided before processing, reversed indicates refund was clawed back.. Valid values are `pending|approved|processed|failed|cancelled|reversed`',
    `refund_timestamp` TIMESTAMP COMMENT 'Date and time when the refund transaction was processed and funds were released back to the customer. Represents the principal business event timestamp for this transaction. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `refund_type` STRING COMMENT 'Classification of refund scope. Full indicates complete order/transaction refund, partial indicates refund of selected items or amount, exchange indicates refund paired with replacement purchase.. Valid values are `full|partial|exchange`',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Fee deducted from the refund amount charged to the customer for restocking returned merchandise. Null if no restocking fee applied. Used for certain product categories per return policy.',
    `return_to_original_tender_flag` BOOLEAN COMMENT 'Indicates whether the refund was issued back to the original payment method used in the source transaction. True if refunded to original tender, False if refunded via alternative method such as store credit.',
    `store_credit_amount` DECIMAL(18,2) COMMENT 'Monetary value of store credit issued to the customer as part of this refund. Null if no store credit issued. Used when customer opts for store credit instead of original tender refund or when original payment method is unavailable.',
    `store_credit_issued_flag` BOOLEAN COMMENT 'Indicates whether store credit was issued as part of this refund transaction instead of or in addition to monetary refund. True if store credit issued, False otherwise.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Portion of the refund amount representing sales tax being returned to the customer. Subset of refund_amount.',
    `wic_reversal_flag` BOOLEAN COMMENT 'Indicates whether this refund involves reversal of a Women Infants and Children (WIC) program payment. True for WIC refunds which require special handling per USDA regulations, False otherwise.',
    CONSTRAINT pk_refund PRIMARY KEY(`refund_id`)
) COMMENT 'Transactional record of payment refunds issued to shoppers across all channels including in-store POS returns, eCommerce order cancellations, and pharmacy prescription reversals. Captures refund_type (full, partial, exchange), refund_status (pending, approved, processed, failed), original_transaction_id reference, refund_amount, refund_tender_type, refund_reason_code, refund_reason_description, initiated_by_channel, initiated_by_associate_id, approved_by_associate_id, refund_timestamp, return_to_original_tender_flag, store_credit_issued_flag, and store_credit_amount. Sourced from NCR POS returns workflow and Salesforce Commerce Cloud order management.';

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`gift_card` (
    `gift_card_id` BIGINT COMMENT 'Unique identifier for the gift card record. Primary key.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Gift card deferred revenue accounting: unredeemed gift card balances represent a liability posted to a specific GL account. Grocery finance tracks gift card breakage, escheatment liability, and deferr',
    `shopper_id` BIGINT COMMENT 'Identifier of the customer who purchased the gift card. Nullable for anonymous purchases or third-party bulk orders.',
    `replacement_for_gift_card_id` BIGINT COMMENT 'Identifier of the original gift card that this card replaces, in cases of lost, stolen, or damaged cards. Nullable for original issuances.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store location where the gift card was issued or purchased. Nullable for online or bulk purchases.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Grocery stores sell third-party gift cards (Blackhawk Network, InComm) sourced from specific suppliers. Linking gift_card to supplier enables procurement tracking, settlement reconciliation, and compl',
    `tender_type_id` BIGINT COMMENT 'Foreign key linking to payment.tender_type. Business justification: A gift card is a specific payment instrument that corresponds to a tender type in the tender_type master (e.g., Gift Card tender category). Linking gift_card to tender_type enables JOIN to tender ru',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to vendor.trade_agreement. Business justification: Third-party gift card programs in grocery (e.g., Blackhawk, InComm) are governed by supplier trade agreements specifying fees, settlement terms, and program rules. Linking gift_card to trade_agreement',
    `activation_status` STRING COMMENT 'Current activation lifecycle status of the gift card: pending (issued but not yet activated), activated (ready for use), suspended (temporarily blocked), or closed (permanently deactivated).. Valid values are `pending|activated|suspended|closed`',
    `activation_timestamp` TIMESTAMP COMMENT 'The date and time when the gift card was activated and became available for redemption. Nullable for cards that have not yet been activated.',
    `barcode` STRING COMMENT 'Barcode or UPC (Universal Product Code) printed on physical gift cards for POS scanning. Nullable for digital cards.',
    `batch_number` STRING COMMENT 'Batch or lot number for physical gift cards, used for inventory tracking and recall management. Nullable for digital cards.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the gift card record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the gift card monetary value (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'The current available balance on the gift card after all redemptions, reloads, and adjustments. Updated in real-time with each transaction.',
    `escheatment_date` DATE COMMENT 'The date on which the gift card balance was escheated to state authorities due to dormancy. Nullable for non-escheated cards.',
    `escheatment_status` STRING COMMENT 'Status of the gift card balance with respect to state escheatment (unclaimed property) laws. Not_applicable for active cards, pending for dormant cards approaching escheatment, escheated for balances transferred to state authorities.. Valid values are `not_applicable|pending|escheated`',
    `expiration_date` DATE COMMENT 'The date on which the gift card expires and can no longer be used for purchases. Nullable for non-expiring cards. Subject to state and federal gift card regulations.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the gift card has been flagged for suspected fraudulent activity. True if fraud is suspected, False otherwise.',
    `fraud_reason` STRING COMMENT 'Description of the reason the gift card was flagged for fraud (e.g., stolen card, unauthorized use, suspicious transaction pattern). Nullable if no fraud flag is set.',
    `gift_card_type` STRING COMMENT 'Type of gift card instrument: physical (plastic card issued in-store or mailed), digital (mobile wallet or app-based), or e-gift (email delivery).. Valid values are `physical|digital|e-gift`',
    `initial_load_amount` DECIMAL(18,2) COMMENT 'The original monetary value loaded onto the gift card at the time of issuance or first activation. Immutable after creation.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the gift card is currently active and available for use. False if the card has been deactivated, suspended, or closed.',
    `is_expired` BOOLEAN COMMENT 'Indicates whether the gift card has passed its expiration date and is no longer valid for redemption. True if expired, False if still valid.',
    `is_reloadable` BOOLEAN COMMENT 'Indicates whether the gift card supports reloading of additional funds after initial issuance. True for reloadable cards, False for single-load cards.',
    `issue_date` DATE COMMENT 'The date the gift card was issued or created in the system. Distinct from activation date.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the gift card record was last updated. Used for audit trail and data synchronization.',
    `last_transaction_timestamp` TIMESTAMP COMMENT 'The date and time of the most recent transaction (redemption, reload, or balance inquiry) on this gift card. Used for dormancy tracking and fraud detection.',
    `number_token` STRING COMMENT 'Tokenized gift card number for PCI DSS compliance. The actual card number is stored securely in the payment gateway; this token is used for transaction processing and balance inquiries.',
    `personalized_message` STRING COMMENT 'Custom message from the purchaser to the recipient, displayed on e-gift cards or included with physical card delivery. Limited to 250 characters.',
    `pin_hash` STRING COMMENT 'One-way cryptographic hash of the gift card PIN for secure validation. The actual PIN is never stored in plaintext.',
    `pin_required_flag` BOOLEAN COMMENT 'Indicates whether a PIN is required for gift card transactions. True for cards requiring PIN entry at POS or online checkout, False for swipe-only cards.',
    `program_name` STRING COMMENT 'Name of the gift card program or campaign (e.g., Grocery Gift Card, Holiday Gift Card, Employee Appreciation Card). Used for marketing segmentation and program performance tracking.',
    `purchase_channel` STRING COMMENT 'The channel through which the gift card was originally purchased: POS (in-store point of sale), ecommerce (online storefront), mobile_app (mobile application), customer_service (phone or chat), bulk_order (corporate or wholesale), or third_party (external retailer or marketplace).. Valid values are `pos|ecommerce|mobile_app|customer_service|bulk_order|third_party`',
    `recipient_email` STRING COMMENT 'Email address of the gift card recipient for e-gift delivery and balance notifications. Required for digital and e-gift card types.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_phone` STRING COMMENT 'Phone number of the gift card recipient for SMS delivery and balance inquiry notifications. Optional field for digital card delivery.',
    CONSTRAINT pk_gift_card PRIMARY KEY(`gift_card_id`)
) COMMENT 'Master record for Grocery-issued gift cards and store credit instruments. Captures gift_card_number_token, gift_card_type (physical, digital, e-gift), initial_load_amount, current_balance, currency_code, issue_date, expiration_date, is_expired flag, is_active flag, is_reloadable flag, purchase_channel, activation_status, activation_timestamp, last_transaction_timestamp, and program_name (e.g., Grocery Gift Card, Holiday Gift Card). Supports gift card issuance, activation, balance inquiry, and redemption workflows across POS and eCommerce channels.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`payment`.`method` ADD CONSTRAINT `fk_payment_method_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `grocery_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `grocery_ecm`.`payment`.`method` ADD CONSTRAINT `fk_payment_method_gift_card_id` FOREIGN KEY (`gift_card_id`) REFERENCES `grocery_ecm`.`payment`.`gift_card`(`gift_card_id`);
ALTER TABLE `grocery_ecm`.`payment`.`method` ADD CONSTRAINT `fk_payment_method_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `grocery_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_method_id` FOREIGN KEY (`method_id`) REFERENCES `grocery_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `grocery_ecm`.`payment`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `grocery_ecm`.`payment`.`transaction`(`transaction_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `grocery_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_gift_card_id` FOREIGN KEY (`gift_card_id`) REFERENCES `grocery_ecm`.`payment`.`gift_card`(`gift_card_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_method_id` FOREIGN KEY (`method_id`) REFERENCES `grocery_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_refund_reference_transaction_id` FOREIGN KEY (`refund_reference_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`transaction`(`transaction_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `grocery_ecm`.`payment`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ADD CONSTRAINT `fk_payment_transaction_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ADD CONSTRAINT `fk_payment_transaction_tender_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `grocery_ecm`.`payment`.`authorization`(`authorization_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ADD CONSTRAINT `fk_payment_transaction_tender_gift_card_id` FOREIGN KEY (`gift_card_id`) REFERENCES `grocery_ecm`.`payment`.`gift_card`(`gift_card_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ADD CONSTRAINT `fk_payment_transaction_tender_method_id` FOREIGN KEY (`method_id`) REFERENCES `grocery_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ADD CONSTRAINT `fk_payment_transaction_tender_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `grocery_ecm`.`payment`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ADD CONSTRAINT `fk_payment_transaction_tender_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ADD CONSTRAINT `fk_payment_transaction_tender_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `grocery_ecm`.`payment`.`transaction`(`transaction_id`);
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ADD CONSTRAINT `fk_payment_settlement_batch_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `grocery_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `grocery_ecm`.`payment`.`authorization`(`authorization_id`);
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `grocery_ecm`.`payment`.`transaction`(`transaction_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `grocery_ecm`.`payment`.`chargeback`(`chargeback_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_method_id` FOREIGN KEY (`method_id`) REFERENCES `grocery_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `grocery_ecm`.`payment`.`authorization`(`authorization_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `grocery_ecm`.`payment`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `grocery_ecm`.`payment`.`transaction`(`transaction_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ADD CONSTRAINT `fk_payment_gift_card_replacement_for_gift_card_id` FOREIGN KEY (`replacement_for_gift_card_id`) REFERENCES `grocery_ecm`.`payment`.`gift_card`(`gift_card_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ADD CONSTRAINT `fk_payment_gift_card_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`payment` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `grocery_ecm`.`payment` SET TAGS ('dbx_domain' = 'payment');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` SET TAGS ('dbx_subdomain' = 'payment_configuration');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Type ID');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `accepted_ecommerce_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepted at eCommerce Flag');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `accepted_fuel_center_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepted at Fuel Center Flag');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `accepted_mobile_app_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepted at Mobile App Flag');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `accepted_mobile_app_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `accepted_mobile_app_flag` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `accepted_pharmacy_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepted at Pharmacy Flag');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `accepted_pos_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepted at POS (Point of Sale) Flag');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `chargeback_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Eligible Flag');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `eligible_item_restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Eligible Item Restriction Code');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `is_contactless_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Contactless Flag');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `maximum_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `minimum_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `processing_network` SET TAGS ('dbx_business_glossary_term' = 'Processing Network');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `refund_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Allowed Flag');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `regulatory_program_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program Code');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `requires_pin_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires PIN (Personal Identification Number) Flag');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `requires_signature_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Signature Flag');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `settlement_batch_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Flag');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `signature_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Signature Threshold Amount');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `supports_partial_tender_flag` SET TAGS ('dbx_business_glossary_term' = 'Supports Partial Tender Flag');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `tender_category` SET TAGS ('dbx_business_glossary_term' = 'Tender Category');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `tender_code` SET TAGS ('dbx_business_glossary_term' = 'Tender Code');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `tender_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `tender_description` SET TAGS ('dbx_business_glossary_term' = 'Tender Description');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `tender_name` SET TAGS ('dbx_business_glossary_term' = 'Tender Name');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `tokenization_supported_flag` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Supported Flag');
ALTER TABLE `grocery_ecm`.`payment`.`method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`payment`.`method` SET TAGS ('dbx_subdomain' = 'payment_configuration');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method ID');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `gift_card_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper ID');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Type ID');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `avs_result_code` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Service (AVS) Result Code');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_country` SET TAGS ('dbx_business_glossary_term' = 'Billing Country');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_state` SET TAGS ('dbx_business_glossary_term' = 'Billing State');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_zip` SET TAGS ('dbx_business_glossary_term' = 'Billing ZIP Code');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_zip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `billing_zip` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `bin_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `bin_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `card_brand` SET TAGS ('dbx_value_regex' = 'Visa|Mastercard|American Express|Discover|JCB|Diners Club');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'Credit|Debit|Prepaid|Charge|Unknown');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Channel');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'POS|eCommerce|Mobile App|Call Center|Kiosk');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `cvv_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Card Verification Value (CVV) Verification Status');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `cvv_verification_status` SET TAGS ('dbx_value_regex' = 'Verified|Failed|Not Checked|Not Applicable');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `cvv_verification_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `cvv_verification_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `deleted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deleted Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `ebt_card_number_token` SET TAGS ('dbx_business_glossary_term' = 'Electronic Benefits Transfer (EBT) Card Number Token');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `ebt_card_number_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `ebt_card_number_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `ebt_program_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Benefits Transfer (EBT) Program Type');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `ebt_program_type` SET TAGS ('dbx_value_regex' = 'SNAP|WIC|TANF|None');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `expiration_month` SET TAGS ('dbx_business_glossary_term' = 'Expiration Month');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `expiration_year` SET TAGS ('dbx_business_glossary_term' = 'Expiration Year');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Payment Method');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `is_expired` SET TAGS ('dbx_business_glossary_term' = 'Is Expired');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Is Verified');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `issuing_bank` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_business_glossary_term' = 'Last Four Digits');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `method_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Status');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `method_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Expired|Pending Verification|Blocked');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `nickname` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Nickname');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `payment_method_token` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Token');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `payment_method_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `payment_method_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `tokenization_provider` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Provider');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `vault_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Vault Reference ID');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `wallet_provider` SET TAGS ('dbx_business_glossary_term' = 'Wallet Provider');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `wallet_provider` SET TAGS ('dbx_value_regex' = 'Apple Pay|Google Pay|Samsung Pay|PayPal|Venmo|None');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `wallet_token` SET TAGS ('dbx_business_glossary_term' = 'Wallet Token');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `wallet_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `wallet_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` SET TAGS ('dbx_subdomain' = 'payment_configuration');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway ID');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `acquirer_bank` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Bank');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `api_version` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Version');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `average_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Average Response Time Milliseconds');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `batch_settlement_time` SET TAGS ('dbx_business_glossary_term' = 'Batch Settlement Time');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `chargeback_fee` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Fee');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `chargeback_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Gateway Endpoint Uniform Resource Locator (URL)');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_code` SET TAGS ('dbx_business_glossary_term' = 'Gateway Code');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_name` SET TAGS ('dbx_business_glossary_term' = 'Gateway Name');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_status` SET TAGS ('dbx_business_glossary_term' = 'Gateway Status');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|testing|decommissioned');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_type` SET TAGS ('dbx_business_glossary_term' = 'Gateway Type');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_type` SET TAGS ('dbx_value_regex' = 'pos|ecommerce|fuel|mobile|kiosk|pharmacy');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Health Check Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `last_health_check_timestamp` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `merchant_account_number` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `merchant_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `monthly_gateway_fee` SET TAGS ('dbx_business_glossary_term' = 'Monthly Gateway Fee');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `monthly_gateway_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `pci_dss_compliance_level` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Industry Data Security Standard (PCI DSS) Compliance Level');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `pci_dss_compliance_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `processor_name` SET TAGS ('dbx_business_glossary_term' = 'Processor Name');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `retry_policy` SET TAGS ('dbx_business_glossary_term' = 'Retry Policy');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `retry_policy` SET TAGS ('dbx_value_regex' = 'none|once|twice|exponential_backoff');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `settlement_lag_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Lag Days');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Email Address');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `support_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `support_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Name');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `support_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `support_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Support Contact Phone Number');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `support_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `supported_tender_types` SET TAGS ('dbx_business_glossary_term' = 'Supported Tender Types');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `supports_3ds` SET TAGS ('dbx_business_glossary_term' = 'Supports 3D Secure (3DS) Flag');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `supports_recurring_billing` SET TAGS ('dbx_business_glossary_term' = 'Supports Recurring Billing Flag');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `supports_tokenization` SET TAGS ('dbx_business_glossary_term' = 'Supports Tokenization Flag');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `terminal_id_prefix` SET TAGS ('dbx_business_glossary_term' = 'Terminal ID Prefix');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `terminal_id_prefix` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `timeout_ms` SET TAGS ('dbx_business_glossary_term' = 'Timeout Milliseconds');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `transaction_fee_fixed` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Fixed Amount');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `transaction_fee_fixed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `transaction_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Percentage');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `transaction_fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Uptime Percentage');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization ID');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Method Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Type Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `acquirer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Reference Number (ARN)');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `acquirer_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{23}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Authorization Amount');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `authorization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'approved|declined|referred|timeout|error|partial_approval');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `avs_result_code` SET TAGS ('dbx_business_glossary_term' = 'Address Verification System (AVS) Result Code');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `avs_result_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `cardholder_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Verification Method (CVM)');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `cardholder_verification_method` SET TAGS ('dbx_value_regex' = 'pin|signature|no_verification|biometric|device_authentication');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'pos|ecommerce|mobile_app|phone|kiosk|fuel_pump');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_business_glossary_term' = 'Card Verification Value (CVV) Result Code');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `cvv_result_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `ebt_balance_remaining` SET TAGS ('dbx_business_glossary_term' = 'Electronic Benefits Transfer (EBT) Balance Remaining');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `ebt_balance_remaining` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `ebt_balance_remaining` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `entry_mode` SET TAGS ('dbx_business_glossary_term' = 'Card Entry Mode');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `fuel_rewards_redeemed_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Rewards Redeemed Amount');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `gateway_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Gateway Reference ID');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `gateway_reference_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,50}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `is_void` SET TAGS ('dbx_business_glossary_term' = 'Is Void Flag');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Card Number');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10,16}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `loyalty_card_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `masked_pan` SET TAGS ('dbx_business_glossary_term' = 'Masked Primary Account Number (PAN)');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `masked_pan` SET TAGS ('dbx_value_regex' = '^[0-9]{4}[*]{6,10}[0-9]{4}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `masked_pan` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `masked_pan` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `network_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Network Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `network_transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{15,25}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `partial_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Approval Flag');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `partial_approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Partial Approved Amount');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `pos_terminal_code` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `pos_terminal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,16}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `processor_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Name');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `requested_at_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Requested At Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `responded_at_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Responded At Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `response_code` SET TAGS ('dbx_business_glossary_term' = 'Response Code');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `response_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Response Time Milliseconds');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `retrieval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Retrieval Reference Number (RRN)');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `retrieval_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `three_d_secure_eci` SET TAGS ('dbx_business_glossary_term' = '3D Secure Electronic Commerce Indicator (ECI)');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `three_d_secure_eci` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `three_d_secure_status` SET TAGS ('dbx_business_glossary_term' = '3D Secure Authentication Status');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `three_d_secure_status` SET TAGS ('dbx_value_regex' = 'authenticated|attempted|not_enrolled|error|bypassed');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `token_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Token ID');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `token_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{16,50}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `voided_at_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Voided At Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `channel_price_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Price Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `direct_store_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `gift_card_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `markdown_id` SET TAGS ('dbx_business_glossary_term' = 'Markdown Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Method Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Rule Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Price Zone Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `refund_reference_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Reference Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Type Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `tpr_id` SET TAGS ('dbx_business_glossary_term' = 'Tpr Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `card_entry_mode` SET TAGS ('dbx_business_glossary_term' = 'Card Entry Mode');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `card_entry_mode` SET TAGS ('dbx_value_regex' = 'chip|swipe|contactless|manual|ecommerce|mobile_wallet');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `card_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `cashback_amount` SET TAGS ('dbx_business_glossary_term' = 'Cashback Amount');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_store_pos|ecommerce|curbside_pickup|fuel_center|mobile_app|call_center');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `chargeback_date` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Date');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `chargeback_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Flag');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `chargeback_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reason Code');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `chargeback_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `fuel_reward_discount_applied` SET TAGS ('dbx_business_glossary_term' = 'Fuel Reward Discount Applied');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `payment_token` SET TAGS ('dbx_business_glossary_term' = 'Payment Token');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `payment_token` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{16,64}$');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `payment_token` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `payment_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `pos_terminal_code` SET TAGS ('dbx_business_glossary_term' = 'POS (Point of Sale) Terminal ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `pos_terminal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `processor_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Name');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `processor_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Processor Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `processor_transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,40}$');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `register_number` SET TAGS ('dbx_business_glossary_term' = 'Register Number');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `register_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,4}$');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `snap_eligible_amount` SET TAGS ('dbx_business_glossary_term' = 'SNAP (Supplemental Nutrition Assistance Program) Eligible Amount');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'completed|failed|voided|reversed|pending|declined');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`transaction` ALTER COLUMN `wic_eligible_amount` SET TAGS ('dbx_business_glossary_term' = 'WIC (Women Infants and Children) Eligible Amount');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `transaction_tender_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Tender ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `gift_card_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Method Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Type Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `avs_response_code` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Service (AVS) Response Code');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `card_entry_method` SET TAGS ('dbx_business_glossary_term' = 'Card Entry Method');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `card_entry_method` SET TAGS ('dbx_value_regex' = 'chip|swipe|contactless|manual_entry|ecommerce|mobile_app');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `change_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Change Due Amount');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `cvv_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Card Verification Value (CVV) Verified Flag');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `cvv_verified_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `cvv_verified_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `ebt_benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Benefits Transfer (EBT) Benefit Type');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `ebt_benefit_type` SET TAGS ('dbx_value_regex' = 'snap_food|snap_cash|tanf|wic');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `ebt_voucher_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Benefits Transfer (EBT) Voucher Number');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `ebt_voucher_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `ebt_voucher_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `fuel_reward_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Reward Discount Amount');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `fuel_reward_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Fuel Reward Points Redeemed');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `gateway_response_code` SET TAGS ('dbx_business_glossary_term' = 'Gateway Response Code');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `gateway_response_message` SET TAGS ('dbx_business_glossary_term' = 'Gateway Response Message');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `mobile_wallet_type` SET TAGS ('dbx_business_glossary_term' = 'Mobile Wallet Type');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `mobile_wallet_type` SET TAGS ('dbx_value_regex' = 'apple_pay|google_pay|samsung_pay|paypal|venmo|other');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `mobile_wallet_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `mobile_wallet_type` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `pin_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Personal Identification Number (PIN) Verified Flag');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `processor_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Processor Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `refund_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `refund_reason_code` SET TAGS ('dbx_value_regex' = 'customer_request|damaged_goods|pricing_error|duplicate_charge|fraud|other');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `register_code` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Register ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `tender_amount` SET TAGS ('dbx_business_glossary_term' = 'Tender Amount');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `tender_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Tender Currency Code');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `tender_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `tender_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Tender Sequence Number');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `tender_status` SET TAGS ('dbx_business_glossary_term' = 'Tender Status');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `tender_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tender Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway ID');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `acquirer_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Batch Reference');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `batch_close_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Close Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `batch_date` SET TAGS ('dbx_business_glossary_term' = 'Batch Date');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `batch_open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Batch Open Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_business_glossary_term' = 'Batch Status');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `batch_status` SET TAGS ('dbx_value_regex' = 'open|submitted|accepted|rejected|reconciled|disputed');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Type');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|manual|correction');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `chargeback_count` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Count');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `ecommerce_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'eCommerce Transaction Count');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `fuel_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Fuel Transaction Count');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `funding_date` SET TAGS ('dbx_business_glossary_term' = 'Funding Date');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `merchant_account_number` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Number');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `merchant_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `pharmacy_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Transaction Count');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `pos_terminal_count` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal Count');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `processor_response_code` SET TAGS ('dbx_business_glossary_term' = 'Processor Response Code');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|matched|variance|resolved');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `refund_count` SET TAGS ('dbx_business_glossary_term' = 'Refund Count');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `total_assessment_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Assessment Fee Amount');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `total_batch_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Batch Amount');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `total_chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Chargeback Amount');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `total_interchange_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Interchange Fee Amount');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `total_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Refund Amount');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `total_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Count');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` SET TAGS ('dbx_subdomain' = 'dispute_settlement');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Chargeback ID');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Original Authorization Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `acquirer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Acquirer Reference Number');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|other');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Status');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `customer_contacted_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Contacted Flag');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `dispute_amount` SET TAGS ('dbx_business_glossary_term' = 'Dispute Amount');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `dispute_category` SET TAGS ('dbx_business_glossary_term' = 'Dispute Category');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `dispute_category` SET TAGS ('dbx_value_regex' = 'fraud|authorization|processing_error|consumer_dispute|other');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `evidence_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence Submitted Flag');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `fee` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Fee');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `fraud_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Indicator Flag');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `issuing_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank ID');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `issuing_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Name');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `net_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Net Financial Impact');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `original_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Date');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Received Date');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Received Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reference Number');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `representment_count` SET TAGS ('dbx_business_glossary_term' = 'Representment Count');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `representment_deadline` SET TAGS ('dbx_business_glossary_term' = 'Representment Deadline');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `representment_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Representment Submitted Date');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'merchant_won|merchant_lost|cardholder_withdrew|expired_uncontested|partial_reversal');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `grocery_ecm`.`payment`.`refund` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`payment`.`refund` SET TAGS ('dbx_subdomain' = 'dispute_settlement');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Refund ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `fulfillment_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Line Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `loyalty_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Redemption Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Method Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Original Authorization Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `rx_fill_id` SET TAGS ('dbx_business_glossary_term' = 'Rx Fill Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `shrink_record_id` SET TAGS ('dbx_business_glossary_term' = 'Shrink Record Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Tender Type ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `chargeback_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Related Flag');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `ebt_snap_reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Benefits Transfer (EBT) Supplemental Nutrition Assistance Program (SNAP) Reversal Flag');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `fuel_rewards_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Rewards Adjustment Amount');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `gift_card_reissue_number` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Reissue Number');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `initiated_by_channel` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Channel');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `initiated_by_channel` SET TAGS ('dbx_value_regex' = 'pos|ecommerce|mobile_app|customer_service|pharmacy');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Initiated Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `payment_gateway_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `prescription_reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Prescription Reversal Flag');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `prescription_reversal_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `prescription_reversal_flag` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `processing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Amount');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'DEFECTIVE|WRONG_ITEM|NOT_AS_DESCRIBED|CUSTOMER_REMORSE|DUPLICATE_ORDER|PRICING_ERROR');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Description');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `refund_number` SET TAGS ('dbx_business_glossary_term' = 'Refund Number');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `refund_number` SET TAGS ('dbx_value_regex' = '^RFN[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `refund_status` SET TAGS ('dbx_value_regex' = 'pending|approved|processed|failed|cancelled|reversed');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_business_glossary_term' = 'Refund Type');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_value_regex' = 'full|partial|exchange');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `return_to_original_tender_flag` SET TAGS ('dbx_business_glossary_term' = 'Return to Original Tender Flag');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `store_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Store Credit Amount');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `store_credit_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Store Credit Issued Flag');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Tax Amount');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `wic_reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Women Infants and Children (WIC) Reversal Flag');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` SET TAGS ('dbx_subdomain' = 'payment_configuration');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `gift_card_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Card ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Purchaser Customer ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `replacement_for_gift_card_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement For Gift Card ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Store ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Type Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `activation_status` SET TAGS ('dbx_business_glossary_term' = 'Activation Status');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `activation_status` SET TAGS ('dbx_value_regex' = 'pending|activated|suspended|closed');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `activation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Activation Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `barcode` SET TAGS ('dbx_business_glossary_term' = 'Barcode');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `escheatment_date` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Date');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `escheatment_status` SET TAGS ('dbx_business_glossary_term' = 'Escheatment Status');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `escheatment_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|escheated');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `fraud_reason` SET TAGS ('dbx_business_glossary_term' = 'Fraud Reason');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `gift_card_type` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Type');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `gift_card_type` SET TAGS ('dbx_value_regex' = 'physical|digital|e-gift');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `initial_load_amount` SET TAGS ('dbx_business_glossary_term' = 'Initial Load Amount');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `is_expired` SET TAGS ('dbx_business_glossary_term' = 'Is Expired Flag');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `is_reloadable` SET TAGS ('dbx_business_glossary_term' = 'Is Reloadable Flag');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `last_transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `number_token` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Number Token');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `number_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `number_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `personalized_message` SET TAGS ('dbx_business_glossary_term' = 'Personalized Message');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `pin_hash` SET TAGS ('dbx_business_glossary_term' = 'PIN (Personal Identification Number) Hash');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `pin_hash` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `pin_hash` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `pin_required_flag` SET TAGS ('dbx_business_glossary_term' = 'PIN (Personal Identification Number) Required Flag');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Program Name');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `purchase_channel` SET TAGS ('dbx_business_glossary_term' = 'Purchase Channel');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `purchase_channel` SET TAGS ('dbx_value_regex' = 'pos|ecommerce|mobile_app|customer_service|bulk_order|third_party');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `recipient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_business_glossary_term' = 'Recipient Phone Number');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `recipient_phone` SET TAGS ('dbx_pii_phone' = 'true');
