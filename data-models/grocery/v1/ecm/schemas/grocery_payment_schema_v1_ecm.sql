-- Schema for Domain: payment | Business: Grocery | Version: v1_ecm
-- Generated on: 2026-05-04 18:34:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `grocery_ecm`.`payment` COMMENT 'Payment processing for all transaction types including credit/debit cards, EBT, SNAP, WIC, mobile wallets, gift cards, and fuel rewards. Manages payment authorization, settlement, chargebacks, refunds, and PCI DSS compliance. Integrates with NCR POS systems, payment gateways, and digital commerce checkout.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`tender_type` (
    `tender_type_id` BIGINT COMMENT 'Unique identifier for the tender type. Primary key for the tender type reference master.',
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
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: In‑store card enrollment requires the associate who captured the payment method for audit, fraud prevention, and compliance reporting.',
    `gateway_id` BIGINT COMMENT 'Foreign key linking to payment.payment_gateway. Business justification: A payment_method is processed through a specific payment gateway; linking via payment_gateway_id enforces consistency and removes the free‑text gateway column.',
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
    `gift_card_balance` DECIMAL(18,2) COMMENT 'The current available balance on the gift card in USD. Updated after each transaction. Null for non-gift-card payment methods.',
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
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: PCI‑DSS certification: gateways must be associated with a compliance program to track certification status and audit schedules.',
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
    `payment_transaction_id` BIGINT COMMENT 'Reference to the parent transaction or order that initiated this authorization request. Links authorization to the originating business transaction.',
    `settlement_batch_id` BIGINT COMMENT 'Identifier of the settlement batch to which this authorization will be or has been submitted. Used for reconciliation between authorizations and settlements.',
    `shopper_id` BIGINT COMMENT 'Identifier of the customer associated with this authorization. Links payment authorization to customer loyalty and transaction history.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store location where the authorization was initiated. Null for digital commerce channels.',
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
    `tender_type` STRING COMMENT 'Type of payment instrument used for the authorization. Distinguishes between credit/debit cards, government assistance programs (EBT, SNAP, WIC), digital wallets, gift cards, fuel rewards, and traditional payment methods. [ENUM-REF-CANDIDATE: credit_card|debit_card|ebt|snap|wic|mobile_wallet|gift_card|fuel_rewards|cash|check — 10 candidates stripped; promote to reference product]',
    `three_d_secure_eci` STRING COMMENT 'Two-digit code indicating the level of 3D Secure authentication completed. Determines liability shift for fraudulent transactions in card-not-present scenarios.. Valid values are `^[0-9]{2}$`',
    `three_d_secure_status` STRING COMMENT 'Status of 3D Secure authentication for eCommerce and card-not-present transactions. Indicates whether cardholder authentication was successful, attempted, or not available.. Valid values are `authenticated|attempted|not_enrolled|error|bypassed`',
    `token_reference` STRING COMMENT 'Tokenized representation of the payment card used for recurring transactions and stored payment methods. Replaces actual card number for PCI DSS compliance.. Valid values are `^[A-Z0-9-]{16,50}$`',
    `voided_at_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorization was voided. Null if authorization has not been voided.',
    CONSTRAINT pk_authorization PRIMARY KEY(`authorization_id`)
) COMMENT 'Transactional record of each payment authorization request and response processed through Grocerys payment gateways. Captures authorization_code, authorization_status (approved, declined, referred, timeout), tender_type, card_brand, masked_pan, authorization_amount, currency_code, response_code, avs_result_code, cvv_result_code, gateway_reference_id, acquirer_reference_number (ARN), pos_terminal_id, store_id, channel (POS, eCommerce, mobile), requested_at_timestamp, responded_at_timestamp, response_time_ms, partial_approval_flag, partial_approved_amount, and is_void flag. Core transactional entity for real-time payment decisioning sourced from NCR POS and Salesforce Commerce Cloud.';

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`payment_transaction` (
    `payment_transaction_id` BIGINT COMMENT 'Unique identifier for the payment transaction record. Primary key for the payment_transaction product.',
    `associate_id` BIGINT COMMENT 'Identifier of the employee who processed the transaction at POS (Point of Sale). Used for performance tracking, training, and audit trail. Null for self-checkout and ecommerce transactions.',
    `center_id` BIGINT COMMENT 'Foreign key linking to fuel.fuel_center. Business justification: REQUIRED: Associate each payment transaction with the specific fuel center for center‑level revenue and tax reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for allocating each POS payment to the responsible cost center for profitability analysis and daily expense reporting.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Links each transaction to its accounting period, supporting period‑close reporting, variance analysis, and SOX compliance.',
    `fuel_grade_id` BIGINT COMMENT 'Foreign key linking to product.product_fuel_grade. Business justification: Fuel sales reporting requires linking each fuel payment to the sold fuel grade for inventory, pricing, and regulatory compliance.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Enables automatic GL posting of revenue from each payment transaction, essential for the revenue recognition and financial statement generation process.',
    `price_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.price_rule. Business justification: Enables audit of which pricing rule generated the final sale price for each transaction, supporting margin optimization reviews.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Required for pricing compliance reports linking each sale to the pricing zone (fuel, pharmacy, etc.) used at transaction time.',
    `product_order_id` BIGINT COMMENT 'Identifier of the order or shopping basket associated with this payment. Links payment to order details including items purchased, quantities, and pricing.',
    `promo_campaign_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_campaign. Business justification: REQUIRED: Attributing each transaction to the driving promotion campaign enables campaign ROI analysis and financial reporting.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: AP reconciliation: match each supplier invoice payment to its purchase order for financial reporting and audit.',
    `refund_reference_transaction_id` BIGINT COMMENT 'Reference to the original payment_transaction_id that this refund or reversal is associated with. Null for original sale transactions. Used to link refunds back to original purchases.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Regulatory filing generation: certain transactions are required to be reported in regulatory filings (tax, AML), linking enables automated filing assembly.',
    `settlement_batch_id` BIGINT COMMENT 'Identifier for the settlement batch that includes this transaction. Used for reconciliation between POS (Point of Sale) systems and payment processor settlement reports.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: Required for Shipment Financial Reconciliation Report linking each payment to its shipment for carrier settlement and audit.',
    `shopper_id` BIGINT COMMENT 'Identifier of the customer who made the payment. Links to customer master data for loyalty tracking, personalization, and customer lifetime value analysis. Null for anonymous cash transactions.',
    `store_location_id` BIGINT COMMENT 'Identifier of the physical store location where the transaction occurred. Links to store master data for location-based reporting and analysis.',
    `wave_id` BIGINT COMMENT 'Foreign key linking to fulfillment.wave. Business justification: Enables Wave Cost Accounting to allocate payment amounts to specific fulfillment waves for SLA impact analysis.',
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
    `tender_type` STRING COMMENT 'Payment instrument type used for the transaction. Credit_card and debit_card for standard card payments, EBT (Electronic Benefits Transfer) for government assistance, SNAP (Supplemental Nutrition Assistance Program) for food benefits, WIC (Women Infants and Children) for nutrition program, mobile_wallet for digital payment apps, gift_card for store value cards, cash for physical currency, check for paper checks, fuel_rewards for loyalty point redemption, store_credit for merchandise credits. [ENUM-REF-CANDIDATE: credit_card|debit_card|ebt|snap|wic|mobile_wallet|gift_card|cash|check|fuel_rewards|store_credit — 11 candidates stripped; promote to reference product]',
    `tip_amount` DECIMAL(18,2) COMMENT 'Gratuity amount added by customer for delivery or service. Applicable primarily to delivery orders and curbside pickup with assisted service.',
    `transaction_number` STRING COMMENT 'Externally-visible unique transaction number assigned by the payment system. Used for customer receipts, reconciliation, and customer service inquiries.. Valid values are `^[A-Z0-9]{10,20}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Completed indicates successful settlement, failed indicates unsuccessful attempt, voided indicates cancelled before settlement, reversed indicates post-settlement cancellation, pending indicates awaiting authorization response, declined indicates rejected by issuer.. Valid values are `completed|failed|voided|reversed|pending|declined`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the payment transaction was initiated at the point of sale or digital commerce checkout. Represents the business event time, not the system record creation time.',
    `transaction_type` STRING COMMENT 'Type of payment transaction: sale (standard purchase), refund (return of funds), void (cancellation before settlement), reversal (post-settlement cancellation), force (offline authorization), preauth (authorization hold), capture (completion of preauth). [ENUM-REF-CANDIDATE: sale|refund|void|reversal|force|preauth|capture — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this payment transaction record was last modified. Updated when transaction status changes or corrections are applied.',
    `wic_eligible_amount` DECIMAL(18,2) COMMENT 'Portion of transaction amount that qualifies for WIC (Women Infants and Children) program benefits payment. Only approved WIC items per state program guidelines are included.',
    CONSTRAINT pk_payment_transaction PRIMARY KEY(`payment_transaction_id`)
) COMMENT 'Core payment transaction record representing a completed payment event at Grocery across all channels and tender types. Captures transaction_type (sale, refund, void, force), transaction_status (completed, failed, voided, reversed), tender_type, transaction_amount, tax_amount, tip_amount, cashback_amount, currency_code, pos_terminal_id, store_id, register_number, cashier_id, channel (in-store POS, eCommerce, curbside pickup, fuel center), transaction_timestamp, batch_id, authorization_id reference, loyalty_account_reference, snap_eligible_amount, wic_eligible_amount, fuel_reward_discount_applied, and receipt_number. SSOT for all payment transactions across NCR POS and Salesforce Commerce Cloud.';

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`transaction_tender` (
    `transaction_tender_id` BIGINT COMMENT 'Unique identifier for the transaction tender line item. Primary key for this association entity capturing individual tender applications within a payment transaction.',
    `associate_id` BIGINT COMMENT 'Reference to the store associate who processed this tender at point of sale. Used for performance tracking, training needs identification, and investigation of transaction exceptions or fraud. Links to workforce management systems.',
    `authorization_id` BIGINT COMMENT 'Reference to the payment authorization record for this tender. Links to the authorization response from the payment gateway or processor, enabling reconciliation of authorizations to settlements and supporting chargeback investigation.',
    `fuel_grade_id` BIGINT COMMENT 'Foreign key linking to product.product_fuel_grade. Business justification: POS tender at fuel pumps must capture the fuel grade to reconcile fuel rewards, tax calculations, and compliance with fuel‑grade reporting.',
    `payment_transaction_id` BIGINT COMMENT 'Reference to the parent payment transaction header. Links this tender line to the overall transaction, supporting split-tender scenarios where multiple payment methods are applied to a single purchase.',
    `settlement_batch_id` BIGINT COMMENT 'Identifier for the processor settlement batch containing this tender. Links individual tenders to batch settlement reports for reconciliation. Used to identify and resolve settlement discrepancies.',
    `store_location_id` BIGINT COMMENT 'Reference to the retail store location where this tender was processed. Supports location-based payment method analysis, regional tender preference trends, and store-level financial reconciliation.',
    `tender_type_id` BIGINT COMMENT 'Foreign key linking to payment.tender_type. Business justification: Each transaction_tender record references a tender type; a foreign key to tender_type.tender_type_id provides referential integrity and allows removal of the redundant string column.',
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
    `gift_card_reference` STRING COMMENT 'Masked or tokenized gift card number used for this tender. Links to gift card balance and transaction history for customer service inquiries, fraud detection, and escheatment compliance. Stored in compliance with PCI DSS standards.',
    `mobile_wallet_type` STRING COMMENT 'Specific mobile wallet platform used for digital payment tenders. Distinguishes between Apple Pay, Google Pay, Samsung Pay, and other mobile payment applications. Enables analysis of digital payment adoption and customer payment preferences.. Valid values are `apple_pay|google_pay|samsung_pay|paypal|venmo|other`',
    `payment_method_reference` STRING COMMENT 'Tokenized or masked reference to the specific payment instrument used (e.g., last 4 digits of card, gift card number, EBT card reference). Stored in PCI DSS compliant format to protect cardholder data while enabling transaction reconciliation and customer service lookups.',
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
    `gateway_id` BIGINT COMMENT 'Identifier of the payment gateway or processor that handled the transactions in this batch. Used for gateway-specific reconciliation and fee analysis.',
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
    `gl_document_number` STRING COMMENT 'The SAP FI document number assigned to the journal entry created for this settlement batch. Used for financial audit trail and reconciliation.',
    `gl_posting_date` DATE COMMENT 'The accounting date on which the settlement batch financial entries are posted to the general ledger in SAP FI for financial reporting.',
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
    `associate_id` BIGINT COMMENT 'Reference to the employee or user responsible for managing and resolving this chargeback case.',
    `payment_transaction_id` BIGINT COMMENT 'Reference to the original payment transaction that is being disputed.',
    `product_order_id` BIGINT COMMENT 'Reference to the order associated with the disputed payment transaction.',
    `store_location_id` BIGINT COMMENT 'Reference to the store location where the disputed transaction occurred.',
    `vendor_chargeback_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_chargeback. Business justification: Chargeback alignment: link payment‑side chargeback records to supplier‑side chargebacks for unified dispute tracking.',
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
    `original_authorization_code` STRING COMMENT 'Authorization code from the original payment transaction, used to match and validate the chargeback claim.',
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
    `fulfillment_order_line_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order_line. Business justification: Supports line‑level refund tracking, tying each refund to the exact order line for inventory and financial adjustments.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Ensures refund amounts are recorded against the appropriate GL account, needed for net revenue reconciliation and audit trails.',
    `payment_transaction_id` BIGINT COMMENT 'Reference to the original payment transaction that is being refunded. Links to the source payment record in the payment transaction system.',
    `product_order_id` BIGINT COMMENT 'Reference to the order associated with this refund for in-store Point of Sale (POS) returns and eCommerce order cancellations.',
    `associate_id` BIGINT COMMENT 'Reference to the manager or supervisor who approved the refund transaction when approval is required based on amount thresholds or policy rules. Null for auto-approved refunds. Links to workforce employee record.',
    `refund_initiated_by_associate_id` BIGINT COMMENT 'Reference to the store associate or customer service representative who initiated the refund transaction. Null for customer self-service refunds. Links to workforce employee record.',
    `settlement_batch_id` BIGINT COMMENT 'Identifier for the payment processor settlement batch that included this refund transaction. Used for reconciliation with payment gateway and bank settlement reports.',
    `shopper_id` BIGINT COMMENT 'Reference to the shopper receiving the refund. Links to the customer master record.',
    `store_location_id` BIGINT COMMENT 'Reference to the store location where the refund was initiated for in-store returns. Null for eCommerce refunds.',
    `tender_type_id` BIGINT COMMENT 'Reference to the payment tender type used for issuing the refund (credit card, debit card, Electronic Benefits Transfer (EBT), store credit, cash, gift card). Links to tender_type reference table.',
    `vendor_return_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_return. Business justification: Refund tracking: associate refunds issued to suppliers with the original vendor return for credit reconciliation.',
    `amount` DECIMAL(18,2) COMMENT 'Total monetary amount being refunded to the customer in the transaction currency, including product cost and applicable taxes. Does not include fees retained by the business.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was approved by authorized personnel. Null for auto-approved refunds. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `authorization_code` STRING COMMENT 'Authorization code returned by the payment processor or card network approving the refund transaction. Null for cash or store credit refunds.',
    `chargeback_related_flag` BOOLEAN COMMENT 'Indicates whether this refund was issued in response to or in anticipation of a payment chargeback dispute. True if chargeback-related, False for standard customer-initiated returns.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this refund record was first created in the data system. Used for audit trail and data lineage tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the refund transaction. Typically USD for United States operations, CAD for Canada, MXN for Mexico.. Valid values are `USD|CAD|MXN`',
    `ebt_snap_reversal_flag` BOOLEAN COMMENT 'Indicates whether this refund involves reversal of a Supplemental Nutrition Assistance Program (SNAP) Electronic Benefits Transfer (EBT) payment. True for SNAP EBT refunds which require special handling per USDA regulations, False otherwise.',
    `fuel_rewards_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary value of fuel rewards points or discounts that were reversed or adjusted as part of this refund. Null if no fuel rewards impact. Used when refunded purchase had earned fuel center loyalty discounts.',
    `gift_card_reissue_number` STRING COMMENT 'Gift card number issued to the customer as the refund method when original payment was gift card or when customer opted for gift card refund. Null if refund not issued as gift card.',
    `initiated_by_channel` STRING COMMENT 'Channel through which the refund was initiated. Point of Sale (POS) for in-store returns, ecommerce for online order cancellations, mobile_app for app-based returns, customer_service for call center initiated refunds, pharmacy for prescription reversals.. Valid values are `pos|ecommerce|mobile_app|customer_service|pharmacy`',
    `initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the refund request was first created in the system, before approval or processing. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this refund record was last updated in the data system. Used for audit trail and change tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `loyalty_points_reversed` STRING COMMENT 'Number of customer loyalty program points that were deducted from the customers account due to this refund. Null if no loyalty points impact. Negative value indicates points removed.',
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
    `associate_id` BIGINT COMMENT 'Identifier of the employee who processed the gift card issuance or activation. Used for audit trail and fraud investigation.',
    `shopper_id` BIGINT COMMENT 'Identifier of the customer who purchased the gift card. Nullable for anonymous purchases or third-party bulk orders.',
    `replacement_for_gift_card_id` BIGINT COMMENT 'Identifier of the original gift card that this card replaces, in cases of lost, stolen, or damaged cards. Nullable for original issuances.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store location where the gift card was issued or purchased. Nullable for online or bulk purchases.',
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

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`gift_card_transaction` (
    `gift_card_transaction_id` BIGINT COMMENT 'Unique identifier for the gift card transaction record. Primary key for the gift card transaction ledger.',
    `associate_id` BIGINT COMMENT 'Reference to the employee who processed the gift card transaction at POS. Used for audit trail and training purposes. Null for self-service channels.',
    `gift_card_id` BIGINT COMMENT 'Reference to the gift card involved in this transaction. Links to the gift card master record for balance tracking and lifecycle management.',
    `original_transaction_gift_card_transaction_id` BIGINT COMMENT 'Reference to the original gift card transaction being reversed or voided. Null for original transactions, populated for reversals to maintain audit trail.',
    `payment_transaction_id` BIGINT COMMENT 'Reference to the parent payment transaction when this gift card activity is part of a larger purchase or load transaction. Null for standalone balance inquiries.',
    `product_order_id` BIGINT COMMENT 'Reference to the order when the gift card was used as payment tender for a purchase. Null for activations, loads, and balance inquiries.',
    `settlement_batch_id` BIGINT COMMENT 'Identifier of the settlement batch in which this gift card transaction was reconciled. Used for financial close and liability reporting.',
    `shopper_id` BIGINT COMMENT 'Reference to the customer who initiated the gift card transaction. Links to customer master for loyalty integration and purchase history.',
    `store_location_id` BIGINT COMMENT 'Reference to the store location where the gift card transaction occurred. Links to store master for location-based reporting and liability allocation.',
    `authorization_code` STRING COMMENT 'Authorization code returned by the gift card processing system confirming the transaction was approved. Used for dispute resolution and reconciliation.',
    `balance_after` DECIMAL(18,2) COMMENT 'Gift card balance immediately after this transaction was applied. Represents the new available balance for future redemptions.',
    `balance_before` DECIMAL(18,2) COMMENT 'Gift card balance immediately before this transaction was applied. Used for audit trail and balance reconciliation.',
    `channel` STRING COMMENT 'Channel through which the gift card transaction was initiated. Distinguishes in-store POS, online, mobile app, customer service, and self-service kiosk transactions.. Valid values are `pos|ecommerce|mobile_app|customer_service|kiosk`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gift card transaction record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction amount. Typically USD for domestic operations.. Valid values are `^[A-Z]{3}$`',
    `decline_reason_code` STRING COMMENT 'Code indicating why the gift card transaction was declined. Examples include insufficient balance, expired card, inactive card, or system error. Null for approved transactions.',
    `device_fingerprint` STRING COMMENT 'Unique identifier of the device used for the gift card transaction. Used for fraud detection and multi-device tracking. Captured for digital channels.',
    `expiration_date` DATE COMMENT 'Date when the gift card balance expires per regulatory and business policy. Null for non-expiring gift cards or transactions before expiration policy was applied.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Service fee charged for the gift card transaction. Examples include activation fees, dormancy fees, or reload fees. Zero for most redemption transactions.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the gift card transaction was flagged as potentially fraudulent by automated or manual review. True for flagged transactions requiring investigation.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Fraud risk score assigned to the gift card transaction by the fraud detection system. Higher scores indicate higher risk. Used for transaction review and blocking decisions.',
    `ip_address` STRING COMMENT 'IP address of the device from which the gift card transaction was initiated. Used for fraud detection and security analysis. Captured for ecommerce and mobile app channels.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this gift card transaction record was last updated. Used for audit trail and change tracking. Updated when status changes or corrections are applied.',
    `notes` STRING COMMENT 'Free-text notes or comments about the gift card transaction. Used by customer service and operations teams to document exceptions, issues, or special handling.',
    `pos_terminal_code` STRING COMMENT 'Identifier of the POS terminal or device where the gift card transaction was processed. Used for terminal-level reconciliation and fraud detection.',
    `processor_name` STRING COMMENT 'Name of the third-party payment processor or gateway that handled the gift card transaction. Used for reconciliation and processor performance analysis.',
    `processor_transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the payment processor. Used for cross-system reconciliation and dispute resolution with the processor.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this transaction is a reversal of a previous gift card transaction. True for voids and refunds, false for original transactions.',
    `settlement_date` DATE COMMENT 'Date when the gift card transaction was settled and posted to the general ledger. May differ from transaction date for end-of-day batch processing.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount associated with the gift card transaction. Typically zero for gift card loads and activations, may be non-zero for redemptions depending on jurisdiction.',
    `transaction_amount` DECIMAL(18,2) COMMENT 'Monetary value of the gift card transaction. Positive for loads and activations, negative for redemptions and expirations, zero for balance inquiries.',
    `transaction_number` STRING COMMENT 'Externally visible unique transaction number for this gift card activity. Used for customer service inquiries and reconciliation.',
    `transaction_status` STRING COMMENT 'Current processing status of the gift card transaction in the authorization and settlement workflow.. Valid values are `pending|approved|declined|reversed|completed`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the gift card transaction was initiated at the point of interaction. Business event timestamp for activity sequencing and reconciliation.',
    `transaction_type` STRING COMMENT 'Type of gift card transaction activity. Activation creates new card, load adds funds, redemption deducts funds, void reverses prior transaction, balance_inquiry checks current balance, expiration removes unused balance.. Valid values are `activation|load|redemption|void|balance_inquiry|expiration`',
    CONSTRAINT pk_gift_card_transaction PRIMARY KEY(`gift_card_transaction_id`)
) COMMENT 'Transactional ledger of all gift card activity including activations, loads, redemptions, balance inquiries, and voids. Captures gift_card_id reference, transaction_type (activation, load, redemption, void, balance_inquiry, expiration), transaction_amount, balance_before, balance_after, pos_terminal_id, store_id, channel, transaction_timestamp, and associated_payment_transaction_id reference. Provides complete gift card activity history for balance reconciliation and liability reporting.';

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`fraud_case` (
    `fraud_case_id` BIGINT COMMENT 'Unique identifier for the fraud case record. Primary key.',
    `associate_id` BIGINT COMMENT 'Identifier of the loss prevention or fraud analyst assigned to investigate this case.',
    `chargeback_id` BIGINT COMMENT 'Identifier of the associated chargeback record if a chargeback was filed. Null if no chargeback filed.',
    `method_id` BIGINT COMMENT 'Identifier of the payment method (card, account) involved in the fraud case.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: Obligation tracking: each fraud case fulfills a specific compliance obligation to investigate and remediate fraud, supporting obligation‑based reporting.',
    `payment_transaction_id` BIGINT COMMENT 'Identifier of the payment transaction that triggered the fraud alert. May be null if case originated from pattern analysis.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Required for Fraud Case Compliance Program Reporting: links each fraud case to the compliance program governing anti‑fraud policies, enabling program‑level metrics.',
    `shopper_id` BIGINT COMMENT 'Identifier of the customer or shopper account associated with the suspected fraud activity.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store location where the fraudulent transaction occurred. Null for ecommerce or mobile transactions.',
    `account_blocked_flag` BOOLEAN COMMENT 'Indicates whether the customer account or payment method was blocked as a result of this fraud case.',
    `alert_severity` STRING COMMENT 'Severity level assigned to the fraud alert based on risk scoring and detection confidence.. Valid values are `low|medium|high|critical`',
    `alert_type` STRING COMMENT 'Type of real-time fraud detection alert that triggered the case investigation.. Valid values are `velocity_check|geolocation_mismatch|high_risk_merchant|unusual_amount|multiple_declines|device_fingerprint`',
    `case_closed_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud case was closed or resolved. Null if case is still open.',
    `case_number` STRING COMMENT 'Business-facing unique case number assigned to the fraud investigation for external reference and tracking.. Valid values are `^FC-[0-9]{10}$`',
    `case_opened_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud case was first opened and investigation initiated.',
    `case_status` STRING COMMENT 'Current lifecycle status of the fraud case investigation.. Valid values are `open|under_investigation|resolved|closed|escalated|law_enforcement_referred`',
    `channel` STRING COMMENT 'Sales channel through which the fraudulent transaction was attempted or completed.. Valid values are `pos|ecommerce|mobile_app|fuel_center|pharmacy|phone_order`',
    `chargeback_filed_flag` BOOLEAN COMMENT 'Indicates whether a chargeback was filed with the card issuer or payment processor related to this fraud case.',
    `confirmed_fraud_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of confirmed fraudulent transactions after investigation completion. Null if investigation is ongoing.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this fraud case record was first created in the database.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the fraud amounts.. Valid values are `^[A-Z]{3}$`',
    `detection_source` STRING COMMENT 'System or channel that originated the fraud detection alert or case.. Valid values are `real_time_pos|payment_gateway|manual_review|customer_report|chargeback_notification|law_enforcement`',
    `device_fingerprint` STRING COMMENT 'Unique identifier of the device used for the transaction, generated by device fingerprinting technology.',
    `disposition_code` STRING COMMENT 'Final determination or outcome classification of the fraud investigation.. Valid values are `confirmed_fraud|false_positive|customer_error|merchant_error|insufficient_evidence|pending_review`',
    `disposition_notes` STRING COMMENT 'Detailed investigator notes documenting findings, evidence reviewed, and rationale for the case disposition.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Numerical risk score (0-100) assigned by the fraud detection system at the time of alert generation.',
    `fraud_type` STRING COMMENT 'Classification of the fraud incident based on the method or pattern detected.. Valid values are `card_not_present|counterfeit_card|lost_stolen_card|account_takeover|refund_fraud|gift_card_fraud`',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the transaction location based on IP geolocation or device GPS.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the transaction location based on IP geolocation or device GPS.',
    `investigation_priority` STRING COMMENT 'Priority level assigned to the case based on financial impact, risk, and resource availability.. Valid values are `low|medium|high|urgent`',
    `ip_address` STRING COMMENT 'Internet Protocol address from which the suspicious transaction originated. Applicable to digital channels.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this fraud case record was last updated.',
    `law_enforcement_agency` STRING COMMENT 'Name of the law enforcement agency to which the case was referred. Null if not referred.',
    `law_enforcement_case_number` STRING COMMENT 'External case number assigned by law enforcement agency. Null if not referred or not yet assigned.',
    `law_enforcement_referral_flag` BOOLEAN COMMENT 'Indicates whether the case was referred to law enforcement authorities for criminal investigation.',
    `loss_amount` DECIMAL(18,2) COMMENT 'Net financial loss to the business after recovery efforts, calculated as confirmed fraud amount minus recovery amount.',
    `pci_incident_flag` BOOLEAN COMMENT 'Indicates whether this fraud case constitutes a PCI DSS security incident requiring formal reporting to payment brands and acquirers.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Dollar amount recovered from the fraudulent transaction through chargebacks, insurance claims, or other recovery mechanisms.',
    `related_case_count` STRING COMMENT 'Number of other fraud cases linked to this case through common patterns, accounts, or devices.',
    `suspected_fraud_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of suspected fraudulent transactions associated with this case at the time of case opening.',
    CONSTRAINT pk_fraud_case PRIMARY KEY(`fraud_case_id`)
) COMMENT 'Operational record of confirmed or suspected payment fraud cases including real-time detection alerts that triggered investigation. Captures case lifecycle (case_number, fraud_type, case_status, opened/closed dates), financial impact (suspected and confirmed amounts), detection context (alert_type, alert_severity, triggering_transaction, detection_source), investigation details (investigator_id, disposition_notes), and law enforcement referral. Supports PCI DSS fraud management, real-time fraud intervention at POS, and loss prevention operations.';

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`reconciliation` (
    `reconciliation_id` BIGINT COMMENT 'Unique identifier for the payment reconciliation record. Primary key.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Associates each reconciliation batch with its fiscal period, enabling period‑based variance analysis and SOX control reporting.',
    `gateway_id` BIGINT COMMENT 'Identifier of the payment gateway or processor for which this reconciliation applies. Links to payment gateway configuration.',
    `associate_id` BIGINT COMMENT 'Identifier of the supervisor or manager who approved this reconciliation and authorized exception resolution actions.',
    `reconciliation_associate_id` BIGINT COMMENT 'Identifier of the cash office employee or finance user who performed or reviewed this reconciliation.',
    `settlement_batch_id` BIGINT COMMENT 'External batch identifier from the payment gateway or bank settlement report used to match transactions for this reconciliation.',
    `store_location_id` BIGINT COMMENT 'Identifier of the store location for which this reconciliation applies. Links to store master data.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation was formally approved by a supervisor or manager, authorizing financial close progression.',
    `completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation process was completed and all exceptions were resolved or escalated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this reconciliation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this reconciliation record.. Valid values are `^[A-Z]{3}$`',
    `exception_count` STRING COMMENT 'Total number of individual exception records identified during this reconciliation requiring detailed investigation and resolution.',
    `external_report_filename` STRING COMMENT 'Filename or reference identifier of the external bank settlement report or gateway confirmation file used as the reconciliation source.',
    `external_report_received_timestamp` TIMESTAMP COMMENT 'Timestamp when the external settlement report or gateway confirmation was received from the bank or payment processor.',
    `external_total_amount` DECIMAL(18,2) COMMENT 'Total payment amount reported by the external payment gateway, bank, or processor settlement report for this reconciliation scope.',
    `external_transaction_count` STRING COMMENT 'Total number of payment transactions reported by the external payment gateway, bank settlement report, or processor for this reconciliation scope.',
    `fiscal_period` STRING COMMENT 'Fiscal period identifier (YYYYMM or YYYYPP format) to which this reconciliation belongs for financial reporting and close processes.',
    `gl_document_number` STRING COMMENT 'SAP FI General Ledger (GL) document number generated when reconciliation variances or adjustments are posted to the financial ledger.',
    `gl_posting_status` STRING COMMENT 'Status of the General Ledger (GL) journal entry posting in SAP FI for this reconciliation, tracking financial close integration.. Valid values are `not_posted|posted|posting_failed|reversed`',
    `internal_total_amount` DECIMAL(18,2) COMMENT 'Total payment amount recorded in Grocerys internal systems (POS, OMS) for this reconciliation scope, representing the merchants view of transactions.',
    `internal_transaction_count` STRING COMMENT 'Total number of payment transactions recorded in Grocerys internal Point of Sale (POS) and Order Management System (OMS) for this reconciliation scope.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this reconciliation record was last updated, tracking audit trail for changes to reconciliation status or resolution.',
    `match_status` STRING COMMENT 'Overall reconciliation outcome status indicating whether internal and external totals match within acceptable tolerance levels.. Valid values are `matched|variance_within_threshold|variance_exceeds_threshold|unmatched|pending_review`',
    `notes` STRING COMMENT 'Free-text notes documenting reconciliation findings, variance explanations, and resolution actions taken by cash office or finance team.',
    `pci_audit_flag` BOOLEAN COMMENT 'Indicates whether this reconciliation record was selected for Payment Card Industry Data Security Standard (PCI DSS) compliance audit review.',
    `reconciliation_date` DATE COMMENT 'Business date for which this reconciliation was performed, representing the transaction date being reconciled.',
    `reconciliation_method` STRING COMMENT 'Method used to perform this reconciliation, indicating level of automation versus manual cash office review.. Valid values are `automated|manual|hybrid`',
    `reconciliation_status` STRING COMMENT 'Current lifecycle status of the reconciliation process, tracking progress from initiation through exception resolution to closure.. Valid values are `in_progress|completed|exceptions_pending|closed|reopened`',
    `reconciliation_type` STRING COMMENT 'Category of reconciliation being performed, indicating the payment processing scope and settlement method.. Valid values are `daily_settlement|batch_settlement|gateway_settlement|ebt_settlement|gift_card_settlement|manual_adjustment`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this reconciliation is subject to Sarbanes-Oxley Act (SOX) internal control testing for financial reporting accuracy.',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation process was initiated, either automatically by batch job or manually by cash office user.',
    `tolerance_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum acceptable variance amount for this reconciliation type before escalation is required, supporting materiality-based exception management.',
    `tolerance_threshold_percentage` DECIMAL(18,2) COMMENT 'Maximum acceptable variance percentage for this reconciliation type before escalation is required.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Calculated difference between internal_total_amount and external_total_amount, representing the reconciliation discrepancy requiring investigation.',
    `variance_transaction_count` STRING COMMENT 'Calculated difference between internal_transaction_count and external_transaction_count, indicating missing or extra transactions.',
    CONSTRAINT pk_reconciliation PRIMARY KEY(`reconciliation_id`)
) COMMENT 'Daily payment reconciliation record comparing Grocerys internal payment transaction totals against bank settlement reports and gateway confirmations, including individual exception records for discrepancies requiring resolution. Captures reconciliation header (reconciliation_date, store_id, reconciliation_type, internal_total_amount vs external_total_amount, variance_amount, match_status) and exception details (exception_type such as missing_in_bank/missing_in_pos/amount_mismatch, exception_amount, transaction_reference, root_cause_code, resolution_status, resolved_by, resolution_notes, resolution_timestamp). Supports daily cash office reconciliation, systematic exception management, financial variance resolution, and SAP FI financial close processes.';

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`payment_plan` (
    `payment_plan_id` BIGINT COMMENT 'Unique identifier for the payment plan record. Primary key.',
    `associate_id` BIGINT COMMENT 'Foreign key linking to workforce.associate. Business justification: Financing plans must be approved by a store associate; the approving employee is recorded for regulatory audit and risk management.',
    `method_id` BIGINT COMMENT 'Reference to the payment method used for automatic installment payments.',
    `shopper_id` BIGINT COMMENT 'Reference to the customer or wholesale account associated with this payment plan.',
    `store_location_id` BIGINT COMMENT 'Store location where the payment plan was originated, if applicable.',
    `approval_status` STRING COMMENT 'Status of the payment plan application approval process.. Valid values are `approved|pending|denied|conditional`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or system that approved the payment plan.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the payment plan was approved.',
    `auto_pay_enabled_flag` BOOLEAN COMMENT 'Indicates whether automatic payment processing is enabled for this plan.',
    `cancellation_reason` STRING COMMENT 'Reason for payment plan cancellation, if applicable.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the payment plan was cancelled.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the payment plan was fully paid and completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this plan.. Valid values are `^[A-Z]{3}$`',
    `days_past_due` STRING COMMENT 'Number of days the payment plan is overdue, calculated from the most recent missed payment date.',
    `default_timestamp` TIMESTAMP COMMENT 'Date and time when the payment plan was marked as defaulted due to non-payment.',
    `delinquency_status` STRING COMMENT 'Classification of payment plan delinquency based on days past due. [ENUM-REF-CANDIDATE: current|30_days|60_days|90_days|120_plus_days|default — promote to reference product]. Valid values are `current|30_days|60_days|90_days|120_plus_days|default`',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fees charged for the payment plan (origination, service, administrative).',
    `final_payment_date` DATE COMMENT 'Scheduled date for the final installment payment.',
    `first_payment_date` DATE COMMENT 'Scheduled date for the first installment payment.',
    `grace_period_days` STRING COMMENT 'Number of days after a missed payment before late fees are applied or the plan is marked delinquent.',
    `interest_amount` DECIMAL(18,2) COMMENT 'Total interest charged over the life of the payment plan.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual percentage rate (APR) applied to the payment plan, expressed as a decimal (e.g., 0.0599 for 5.99%).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payment plan record was last updated.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Standard late fee charged per missed or overdue installment payment.',
    `maturity_date` DATE COMMENT 'Date when the payment plan is scheduled to be fully paid and closed.',
    `next_payment_amount` DECIMAL(18,2) COMMENT 'Amount due for the next scheduled installment payment.',
    `next_payment_due_date` DATE COMMENT 'Date when the next installment payment is due.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the payment plan for internal reference.',
    `number_of_installments` STRING COMMENT 'Total number of scheduled installment payments for this plan.',
    `originating_channel` STRING COMMENT 'Channel through which the payment plan was initiated. [ENUM-REF-CANDIDATE: pos|ecommerce|mobile_app|pharmacy|customer_service|wholesale_portal — promote to reference product]. Valid values are `pos|ecommerce|mobile_app|pharmacy|customer_service|wholesale_portal`',
    `origination_date` DATE COMMENT 'Date when the payment plan was established and became effective.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the payment plan.',
    `payment_frequency` STRING COMMENT 'Frequency at which installment payments are scheduled.. Valid values are `weekly|biweekly|monthly|quarterly|annual`',
    `plan_number` STRING COMMENT 'Externally-known unique business identifier for the payment plan, used for customer communication and account management.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the payment plan. [ENUM-REF-CANDIDATE: active|completed|defaulted|cancelled|suspended|pending — promote to reference product]. Valid values are `active|completed|defaulted|cancelled|suspended|pending`',
    `plan_type` STRING COMMENT 'Classification of the payment plan arrangement. [ENUM-REF-CANDIDATE: layaway|pharmacy_payment_assistance|b2b_net_terms|installment_purchase|deferred_payment|other — promote to reference product]. Valid values are `layaway|pharmacy_payment_assistance|b2b_net_terms|installment_purchase|deferred_payment|other`',
    `principal_amount` DECIMAL(18,2) COMMENT 'Base amount financed before interest and fees.',
    `program_name` STRING COMMENT 'Name of the payment assistance or financing program (e.g., Pharmacy Patient Assistance, Wholesale Net-30 Terms).',
    `program_sponsor` STRING COMMENT 'Organization or entity sponsoring the payment plan program (e.g., pharmaceutical manufacturer, third-party lender).',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Cumulative amount paid to date across all installments.',
    `total_plan_amount` DECIMAL(18,2) COMMENT 'Total amount financed under the payment plan, including principal and any fees.',
    CONSTRAINT pk_payment_plan PRIMARY KEY(`payment_plan_id`)
) COMMENT 'Master record for installment payment plans and deferred payment arrangements offered by Grocery, with embedded installment schedule tracking. Captures plan_type (layaway, pharmacy payment assistance, B2B net terms), plan_status (active, completed, defaulted, cancelled), total_plan_amount, number_of_installments, payment_frequency (weekly, biweekly, monthly), interest_rate, origination_date, originating_channel, and customer_reference. Includes installment-level tracking: scheduled_date, scheduled_amount, actual_payment_date, actual_amount_paid, installment_status (scheduled, paid, overdue, waived), late_fee_applied, and days_past_due. Supports pharmacy patient payment assistance programs, B2B wholesale account net terms, and collections management.';

CREATE OR REPLACE TABLE `grocery_ecm`.`payment`.`promotion_application` (
    `promotion_application_id` BIGINT COMMENT 'Primary key for the promotion_application association',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to the payment transaction',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to the promo offer',
    `coupon_code` STRING COMMENT 'Code of the digital coupon used for this promo offer in the transaction',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discount applied by this promo offer to the transaction',
    CONSTRAINT pk_promotion_application PRIMARY KEY(`promotion_application_id`)
) COMMENT 'This association product represents the application of a promotional offer to a payment transaction. It captures the discount amount and coupon code that are specific to each transaction‑offer pair.. Existence Justification: In Grocery, promotional offers are applied to payment transactions at the point of sale or online. A single payment transaction can have multiple promo offers applied, and each promo offer can be applied to many payment transactions across stores and channels. The application of an offer is tracked with specific data such as the discount amount and coupon code, which belong to the transaction‑offer relationship itself.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `grocery_ecm`.`payment`.`method` ADD CONSTRAINT `fk_payment_method_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `grocery_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `grocery_ecm`.`payment`.`method` ADD CONSTRAINT `fk_payment_method_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `grocery_ecm`.`payment`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_refund_reference_transaction_id` FOREIGN KEY (`refund_reference_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `grocery_ecm`.`payment`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ADD CONSTRAINT `fk_payment_transaction_tender_authorization_id` FOREIGN KEY (`authorization_id`) REFERENCES `grocery_ecm`.`payment`.`authorization`(`authorization_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ADD CONSTRAINT `fk_payment_transaction_tender_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ADD CONSTRAINT `fk_payment_transaction_tender_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `grocery_ecm`.`payment`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ADD CONSTRAINT `fk_payment_transaction_tender_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ADD CONSTRAINT `fk_payment_settlement_batch_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `grocery_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `grocery_ecm`.`payment`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `grocery_ecm`.`payment`.`refund` ADD CONSTRAINT `fk_payment_refund_tender_type_id` FOREIGN KEY (`tender_type_id`) REFERENCES `grocery_ecm`.`payment`.`tender_type`(`tender_type_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ADD CONSTRAINT `fk_payment_gift_card_replacement_for_gift_card_id` FOREIGN KEY (`replacement_for_gift_card_id`) REFERENCES `grocery_ecm`.`payment`.`gift_card`(`gift_card_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ADD CONSTRAINT `fk_payment_gift_card_transaction_gift_card_id` FOREIGN KEY (`gift_card_id`) REFERENCES `grocery_ecm`.`payment`.`gift_card`(`gift_card_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ADD CONSTRAINT `fk_payment_gift_card_transaction_original_transaction_gift_card_transaction_id` FOREIGN KEY (`original_transaction_gift_card_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`gift_card_transaction`(`gift_card_transaction_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ADD CONSTRAINT `fk_payment_gift_card_transaction_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ADD CONSTRAINT `fk_payment_gift_card_transaction_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `grocery_ecm`.`payment`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `grocery_ecm`.`payment`.`chargeback`(`chargeback_id`);
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_method_id` FOREIGN KEY (`method_id`) REFERENCES `grocery_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `grocery_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `grocery_ecm`.`payment`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ADD CONSTRAINT `fk_payment_payment_plan_method_id` FOREIGN KEY (`method_id`) REFERENCES `grocery_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `grocery_ecm`.`payment`.`promotion_application` ADD CONSTRAINT `fk_payment_promotion_application_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `grocery_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);

-- ========= TAGS =========
ALTER SCHEMA `grocery_ecm`.`payment` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `grocery_ecm`.`payment` SET TAGS ('dbx_domain' = 'payment');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` SET TAGS ('dbx_subdomain' = 'instrument_services');
ALTER TABLE `grocery_ecm`.`payment`.`tender_type` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Type ID');
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
ALTER TABLE `grocery_ecm`.`payment`.`method` SET TAGS ('dbx_subdomain' = 'instrument_services');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method ID');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`payment`.`method` ALTER COLUMN `gift_card_balance` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Balance');
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
ALTER TABLE `grocery_ecm`.`payment`.`gateway` SET TAGS ('dbx_subdomain' = 'instrument_services');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway ID');
ALTER TABLE `grocery_ecm`.`payment`.`gateway` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`payment`.`authorization` SET TAGS ('dbx_subdomain' = 'transaction_management');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization ID');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
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
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `tender_type` SET TAGS ('dbx_business_glossary_term' = 'Tender Type');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `three_d_secure_eci` SET TAGS ('dbx_business_glossary_term' = '3D Secure Electronic Commerce Indicator (ECI)');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `three_d_secure_eci` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `three_d_secure_status` SET TAGS ('dbx_business_glossary_term' = '3D Secure Authentication Status');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `three_d_secure_status` SET TAGS ('dbx_value_regex' = 'authenticated|attempted|not_enrolled|error|bypassed');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `token_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Token ID');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `token_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{16,50}$');
ALTER TABLE `grocery_ecm`.`payment`.`authorization` ALTER COLUMN `voided_at_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Voided At Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` SET TAGS ('dbx_subdomain' = 'transaction_management');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Cashier ID');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `fuel_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Product Fuel Grade Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `price_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Rule Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Price Zone Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Campaign Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `refund_reference_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Reference Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch ID');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_entry_mode` SET TAGS ('dbx_business_glossary_term' = 'Card Entry Mode');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_entry_mode` SET TAGS ('dbx_value_regex' = 'chip|swipe|contactless|manual|ecommerce|mobile_wallet');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `cashback_amount` SET TAGS ('dbx_business_glossary_term' = 'Cashback Amount');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_store_pos|ecommerce|curbside_pickup|fuel_center|mobile_app|call_center');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `chargeback_date` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Date');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `chargeback_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Flag');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `chargeback_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reason Code');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `chargeback_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `fuel_reward_discount_applied` SET TAGS ('dbx_business_glossary_term' = 'Fuel Reward Discount Applied');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `loyalty_points_earned` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Earned');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `loyalty_points_redeemed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Redeemed');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_token` SET TAGS ('dbx_business_glossary_term' = 'Payment Token');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_token` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{16,64}$');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_token` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `pos_terminal_code` SET TAGS ('dbx_business_glossary_term' = 'POS (Point of Sale) Terminal ID');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `pos_terminal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `processor_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Name');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `processor_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Processor Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `processor_transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,40}$');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `register_number` SET TAGS ('dbx_business_glossary_term' = 'Register Number');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `register_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,4}$');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `snap_eligible_amount` SET TAGS ('dbx_business_glossary_term' = 'SNAP (Supplemental Nutrition Assistance Program) Eligible Amount');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `tender_type` SET TAGS ('dbx_business_glossary_term' = 'Tender Type');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `tip_amount` SET TAGS ('dbx_business_glossary_term' = 'Tip Amount');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'completed|failed|voided|reversed|pending|declined');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`payment_transaction` ALTER COLUMN `wic_eligible_amount` SET TAGS ('dbx_business_glossary_term' = 'WIC (Women Infants and Children) Eligible Amount');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` SET TAGS ('dbx_subdomain' = 'transaction_management');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `transaction_tender_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Tender ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Cashier ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `fuel_grade_id` SET TAGS ('dbx_business_glossary_term' = 'Product Fuel Grade Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Type Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `gift_card_reference` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Reference');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `gift_card_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `gift_card_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `mobile_wallet_type` SET TAGS ('dbx_business_glossary_term' = 'Mobile Wallet Type');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `mobile_wallet_type` SET TAGS ('dbx_value_regex' = 'apple_pay|google_pay|samsung_pay|paypal|venmo|other');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `mobile_wallet_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `mobile_wallet_type` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `payment_method_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Reference');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `payment_method_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`transaction_tender` ALTER COLUMN `payment_method_reference` SET TAGS ('dbx_pii_financial' = 'true');
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
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` SET TAGS ('dbx_subdomain' = 'transaction_management');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway ID');
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
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `gl_document_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Document Number');
ALTER TABLE `grocery_ecm`.`payment`.`settlement_batch` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
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
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` SET TAGS ('dbx_subdomain' = 'risk_operations');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Chargeback ID');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User ID');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `vendor_chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Chargeback Id (Foreign Key)');
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
ALTER TABLE `grocery_ecm`.`payment`.`chargeback` ALTER COLUMN `original_authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Original Authorization Code');
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
ALTER TABLE `grocery_ecm`.`payment`.`refund` SET TAGS ('dbx_subdomain' = 'transaction_management');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Refund ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `fulfillment_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Line Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Associate ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `refund_initiated_by_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Initiated By Associate ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `tender_type_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Tender Type ID');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `vendor_return_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Return Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
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
ALTER TABLE `grocery_ecm`.`payment`.`refund` ALTER COLUMN `loyalty_points_reversed` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Points Reversed');
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
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` SET TAGS ('dbx_subdomain' = 'instrument_services');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `gift_card_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Card ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Employee ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Purchaser Customer ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `replacement_for_gift_card_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement For Gift Card ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Store ID');
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
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` SET TAGS ('dbx_subdomain' = 'transaction_management');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `gift_card_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Card Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Cashier ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `gift_card_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Card ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `original_transaction_gift_card_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Payment Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `product_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `balance_after` SET TAGS ('dbx_business_glossary_term' = 'Balance After Transaction');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `balance_before` SET TAGS ('dbx_business_glossary_term' = 'Balance Before Transaction');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'pos|ecommerce|mobile_app|customer_service|kiosk');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `decline_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason Code');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `pos_terminal_code` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Terminal ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `processor_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Name');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `processor_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Processor Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Amount');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|approved|declined|reversed|completed');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `grocery_ecm`.`payment`.`gift_card_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'activation|load|redemption|void|balance_inquiry|expiration');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` SET TAGS ('dbx_subdomain' = 'risk_operations');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case ID');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator ID');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback ID');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method ID');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Transaction ID');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Shopper ID');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `account_blocked_flag` SET TAGS ('dbx_business_glossary_term' = 'Account Blocked Flag');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `alert_severity` SET TAGS ('dbx_business_glossary_term' = 'Alert Severity Level');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `alert_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Fraud Alert Type');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'velocity_check|geolocation_mismatch|high_risk_merchant|unusual_amount|multiple_declines|device_fingerprint');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `case_closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Number');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^FC-[0-9]{10}$');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `case_opened_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Opened Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Status');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|resolved|closed|escalated|law_enforcement_referred');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Transaction Channel');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'pos|ecommerce|mobile_app|fuel_center|pharmacy|phone_order');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `chargeback_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Filed Flag');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `confirmed_fraud_amount` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Fraud Amount');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Source');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'real_time_pos|payment_gateway|manual_review|customer_report|chargeback_notification|law_enforcement');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Case Disposition Code');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'confirmed_fraud|false_positive|customer_error|merchant_error|insufficient_evidence|pending_review');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Disposition Notes');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `fraud_type` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `fraud_type` SET TAGS ('dbx_value_regex' = 'card_not_present|counterfeit_card|lost_stolen_card|account_takeover|refund_fraud|gift_card_fraud');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_business_glossary_term' = 'Investigation Priority');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `investigation_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `law_enforcement_agency` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Agency');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `law_enforcement_case_number` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Case Number');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `law_enforcement_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Law Enforcement Referral Flag');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Loss Amount');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `pci_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Incident Flag');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `related_case_count` SET TAGS ('dbx_business_glossary_term' = 'Related Case Count');
ALTER TABLE `grocery_ecm`.`payment`.`fraud_case` ALTER COLUMN `suspected_fraud_amount` SET TAGS ('dbx_business_glossary_term' = 'Suspected Fraud Amount');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` SET TAGS ('dbx_subdomain' = 'transaction_management');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation ID');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway ID');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_associate_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By User ID');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Completed Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `external_report_filename` SET TAGS ('dbx_business_glossary_term' = 'External Report Filename');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `external_report_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'External Report Received Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `external_total_amount` SET TAGS ('dbx_business_glossary_term' = 'External Total Amount');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `external_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'External Transaction Count');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `gl_document_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Document Number');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `gl_posting_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Status');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `gl_posting_status` SET TAGS ('dbx_value_regex' = 'not_posted|posted|posting_failed|reversed');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `internal_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Internal Total Amount');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `internal_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Internal Transaction Count');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'matched|variance_within_threshold|variance_exceeds_threshold|unmatched|pending_review');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `pci_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Card Industry Data Security Standard (PCI DSS) Audit Flag');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Method');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_method` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'in_progress|completed|exceptions_pending|closed|reopened');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Type');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_value_regex' = 'daily_settlement|batch_settlement|gateway_settlement|ebt_settlement|gift_card_settlement|manual_adjustment');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Flag');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Start Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `tolerance_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Threshold Amount');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `tolerance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Threshold Percentage');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `grocery_ecm`.`payment`.`reconciliation` ALTER COLUMN `variance_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Variance Transaction Count');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` SET TAGS ('dbx_subdomain' = 'instrument_services');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan ID');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `associate_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Associate Id (Foreign Key)');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Auto-Pay Payment Method ID');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `shopper_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `store_location_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Store ID');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|denied|conditional');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `auto_pay_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Pay Enabled Flag');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `default_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Default Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `delinquency_status` SET TAGS ('dbx_business_glossary_term' = 'Delinquency Status');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `delinquency_status` SET TAGS ('dbx_value_regex' = 'current|30_days|60_days|90_days|120_plus_days|default');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fee Amount');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `final_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Date');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `first_payment_date` SET TAGS ('dbx_business_glossary_term' = 'First Payment Date');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Interest Amount');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Maturity Date');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `next_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Next Payment Amount');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `next_payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Payment Due Date');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Notes');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `number_of_installments` SET TAGS ('dbx_business_glossary_term' = 'Number of Installments');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `originating_channel` SET TAGS ('dbx_business_glossary_term' = 'Originating Channel');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `originating_channel` SET TAGS ('dbx_value_regex' = 'pos|ecommerce|mobile_app|pharmacy|customer_service|wholesale_portal');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `origination_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Origination Date');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|annual');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Number');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Status');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|completed|defaulted|cancelled|suspended|pending');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Type');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'layaway|pharmacy_payment_assistance|b2b_net_terms|installment_purchase|deferred_payment|other');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Principal Amount');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `program_sponsor` SET TAGS ('dbx_business_glossary_term' = 'Program Sponsor');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `total_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `grocery_ecm`.`payment`.`payment_plan` ALTER COLUMN `total_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Plan Amount');
ALTER TABLE `grocery_ecm`.`payment`.`promotion_application` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `grocery_ecm`.`payment`.`promotion_application` SET TAGS ('dbx_subdomain' = 'risk_operations');
ALTER TABLE `grocery_ecm`.`payment`.`promotion_application` SET TAGS ('dbx_association_edges' = 'payment.payment_transaction,promotion.promo_offer');
ALTER TABLE `grocery_ecm`.`payment`.`promotion_application` ALTER COLUMN `promotion_application_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Application - Promotion Application Id');
ALTER TABLE `grocery_ecm`.`payment`.`promotion_application` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Application - Payment Transaction Id');
ALTER TABLE `grocery_ecm`.`payment`.`promotion_application` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Application - Promo Offer Id');
ALTER TABLE `grocery_ecm`.`payment`.`promotion_application` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `grocery_ecm`.`payment`.`promotion_application` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
