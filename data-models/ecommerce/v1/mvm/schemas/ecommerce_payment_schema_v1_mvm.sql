-- Schema for Domain: payment | Business: Ecommerce | Version: v1_mvm
-- Generated on: 2026-05-05 00:58:26

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ecommerce_ecm`.`payment` COMMENT 'Authoritative source for all monetary transactions on the platform. Owns payment gateway authorization, settlement, refund processing, chargebacks, fraud detection, PCI DSS-compliant card data tokenization, multi-currency transaction records, payment method management, and payment reconciliation. Tracks transaction success rates and processing fees.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ecommerce_ecm`.`payment`.`payment_transaction` (
    `payment_transaction_id` BIGINT COMMENT 'Unique identifier for the payment transaction.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Required for account‑level financial statements and reconciliation of each payment transaction to the customers account.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Cash application process matches payment transactions to AR records to clear open receivables. Finance AR aging accuracy, cash application reporting, and DSO calculations require linking each payment ',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Required for Marketing ROI report linking each transaction to the driving campaign for revenue attribution.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Tax and regulatory reporting requires mapping each transaction to the catalog item to apply correct jurisdiction‑specific tax codes.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Channel-level revenue attribution and ROAS reporting: e-commerce teams report payment revenue by marketing channel (email, paid search, social). payment_transaction already has campaign_id but not cha',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for allocating processing fees to the appropriate cost center in monthly expense reporting.',
    `gateway_id` BIGINT COMMENT 'Foreign key linking to payment.gateway. Business justification: Every payment transaction is processed through a specific payment gateway. payment_transaction currently captures gateway_response_code and gateway_response_message as string fields but has no FK to t',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Supports direct posting of each payment transaction to a GL account for real‑time financial reconciliation.',
    `header_id` BIGINT COMMENT 'Identifier of the order associated with this payment.',
    `marketplace_promotion_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_promotion. Business justification: Payment transactions are directly discounted by marketplace promotions at checkout. Finance teams need this link for promotion ROI analysis, promotional discount liability accounting, and reconciling ',
    `merchant_account_id` BIGINT COMMENT 'Identifier of the merchant receiving the payment.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Enables attribution of net revenue from each transaction to the correct profit center for performance dashboards.',
    `reconciliation_id` BIGINT COMMENT 'Foreign key linking to payment.reconciliation. Business justification: Transactions are part of a reconciliation run; linking via reconciliation_id enables auditability and variance analysis.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: REQUIRED: Seller‑level revenue and commission reporting needs each transaction linked to the seller who fulfilled the order.',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to payment.settlement. Business justification: Each payment transaction is settled in a settlement batch; adding settlement_id links transaction to its settlement for traceability and reporting.',
    `token_id` BIGINT COMMENT 'Foreign key linking to payment.token. Business justification: Payment transactions processed with tokenized card data reference a specific PCI DSS token in the token registry. payment_transaction currently has card_last4, card_brand, card_expiry_month, card_expi',
    `method_id` BIGINT COMMENT 'PCI‑DSS compliant token representing the stored payment method.',
    `wallet_id` BIGINT COMMENT 'Foreign key linking to payment.wallet. Business justification: Payment transactions can be funded from a customer digital wallet. payment_transaction currently has no FK to the wallet table, despite wallet being a first-class payment instrument in the domain. Add',
    `amount_fee` DECIMAL(18,2) COMMENT 'Processing fee charged by the payment gateway.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount authorized before fees or taxes.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount settled to the merchant after fees and taxes.',
    `amount_tax` DECIMAL(18,2) COMMENT 'Tax component applied to the transaction.',
    `authorization_code` STRING COMMENT 'Code returned by the issuing bank authorizing the transaction.',
    `card_brand` STRING COMMENT 'Brand of the payment card when card‑based method is used.. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `card_expiry_month` STRING COMMENT 'Expiration month of the payment card.',
    `card_expiry_year` STRING COMMENT 'Expiration year of the payment card.',
    `card_last4` STRING COMMENT 'Last four digits of the card number for display and reconciliation.. Valid values are `^d{4}$`',
    `chargeback_flag` BOOLEAN COMMENT 'Indicates whether the transaction resulted in a chargeback.',
    `compliance_flags` STRING COMMENT 'Comma‑separated list of compliance regimes applicable to the transaction.. Valid values are `pci_dss|psd2_sca|gdpr|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the transaction.. Valid values are `^[A-Z]{3}$`',
    `device_fingerprint` STRING COMMENT 'Identifier of the device used to capture the payment.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert from original currency to settlement currency, if applicable.',
    `fraud_score` STRING COMMENT 'Numeric risk score assigned by fraud detection engine (0‑100).',
    `gateway_response_code` STRING COMMENT 'Standardized response code from the payment gateway.',
    `gateway_response_message` STRING COMMENT 'Human‑readable message accompanying the gateway response code.',
    `identifier` STRING COMMENT 'External identifier assigned by the payment gateway for this transaction.',
    `ip_address` STRING COMMENT 'IP address from which the transaction was initiated.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$`',
    `is_recurring` BOOLEAN COMMENT 'True if the transaction is part of a recurring payment schedule.',
    `merchant_category_code` STRING COMMENT 'Four‑digit code classifying the merchants industry.. Valid values are `^d{4}$`',
    `payment_channel` STRING COMMENT 'Digital or physical channel through which the payment was captured.. Valid values are `web|mobile|in_app|pos|api`',
    `payment_method` STRING COMMENT 'Instrument used to fund the transaction.. Valid values are `credit_card|debit_card|bank_transfer|paypal|apple_pay|google_pay`',
    `payment_transaction_description` STRING COMMENT 'Free‑form description or memo for the transaction.',
    `payment_transaction_status` STRING COMMENT 'Current lifecycle state of the transaction.. Valid values are `authorized|captured|settled|voided|failed|refunded`',
    `recurring_cycle` STRING COMMENT 'Frequency of the recurring payment.. Valid values are `daily|weekly|monthly|yearly`',
    `recurring_end_date` DATE COMMENT 'Date when the recurring payment schedule terminates.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount refunded to the customer, if any.',
    `refund_timestamp` TIMESTAMP COMMENT 'Timestamp when the refund was processed.',
    `risk_assessment` STRING COMMENT 'Overall risk classification derived from fraud score and other signals.. Valid values are `low|medium|high`',
    `settlement_date` DATE COMMENT 'Date on which funds were settled to the merchant account.',
    `settlement_status` STRING COMMENT 'Current status of the settlement process.. Valid values are `pending|settled|failed`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Timestamp when the transaction event occurred.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the transaction record.',
    CONSTRAINT pk_payment_transaction PRIMARY KEY(`payment_transaction_id`)
) COMMENT 'Core authoritative record of every monetary transaction processed on the platform, including the immutable event log of all state transitions (authorized, captured, settled, voided, failed) and gateway webhook callbacks. Captures payment amount, currency, exchange rate applied, processing status, gateway response codes, authorization codes, timestamps, retry history, and event-driven lifecycle audit trail. Each transaction references a payment method, may have one or more authorizations, and flows through to settlement. Supports PCI DSS audit requirements and PSD2 Strong Customer Authentication (SCA) compliance evidence. SSOT for all payment transaction records, their lifecycle events, and state transition history.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`payment`.`method` (
    `method_id` BIGINT COMMENT 'Primary key for method',
    `customer_address_id` BIGINT COMMENT 'Foreign key linking to customer.customer_address. Business justification: Address verification and 3NF normalization: payment method billing address is denormalized across five columns. Linking to customer_address enables AVS (Address Verification Service) checks, address c',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who owns this payment method.',
    `card_network` STRING COMMENT 'Card scheme or network for card‑based methods.. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `cardholder_email` STRING COMMENT 'Email address associated with the cardholder.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `cardholder_name` STRING COMMENT 'Legal name of the cardholder as it appears on the card.',
    `cardholder_phone` STRING COMMENT 'Phone number associated with the cardholder.',
    `compliance_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance verification.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the payment method with regulatory standards.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment method record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the payment method.. Valid values are `^[A-Z]{3}$`',
    `daily_limit_amount` DECIMAL(18,2) COMMENT 'Maximum cumulative amount allowed per day.',
    `expiry_month` STRING COMMENT 'Expiration month of the card (1‑12).',
    `expiry_year` STRING COMMENT 'Expiration year of the card (four‑digit).',
    `fraud_score` STRING COMMENT 'Numeric risk score (0‑100) indicating fraud likelihood.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this method is the customers default payment instrument.',
    `is_international_allowed` BOOLEAN COMMENT 'Indicates if the payment method supports cross‑border transactions.',
    `is_one_time_allowed` BOOLEAN COMMENT 'Indicates if the payment method can be used for one‑off transactions.',
    `is_recurring_allowed` BOOLEAN COMMENT 'Indicates if the payment method can be used for recurring billing.',
    `issuing_bank` STRING COMMENT 'Name of the financial institution that issued the card or account.',
    `last_four` STRING COMMENT 'Last four digits of the card number (masked).. Valid values are `^d{4}$`',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment method was last used in a transaction.',
    `method_description` STRING COMMENT 'Optional free‑text description of the payment method.',
    `method_status` STRING COMMENT 'Current lifecycle status of the payment method.. Valid values are `active|inactive|expired|suspended|deleted`',
    `method_type` STRING COMMENT 'Category of the payment instrument.. Valid values are `credit_card|debit_card|digital_wallet|bank_account|bnpl|gift_card`',
    `monthly_limit_amount` DECIMAL(18,2) COMMENT 'Maximum cumulative amount allowed per calendar month.',
    `payment_method_name` STRING COMMENT 'User‑defined nickname for the payment method.',
    `preference_rank` STRING COMMENT 'User‑defined ranking indicating preferred payment method order.',
    `risk_level` STRING COMMENT 'Overall risk classification for the payment method.. Valid values are `low|medium|high`',
    `sca_enrolled` BOOLEAN COMMENT 'Indicates whether the payment method is enrolled for SCA (e.g., 3‑DS).',
    `token_reference` STRING COMMENT 'PCI‑DSS token that represents the underlying card or bank account.',
    `tokenization_provider` STRING COMMENT 'Vendor or service that performed tokenization of the payment instrument.',
    `transaction_limit_amount` DECIMAL(18,2) COMMENT 'Maximum amount allowed per individual transaction.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment method record.',
    `verification_status` STRING COMMENT 'Result of the verification process for the payment method.. Valid values are `verified|unverified|pending`',
    CONSTRAINT pk_method PRIMARY KEY(`method_id`)
) COMMENT 'Master record of all payment instruments registered by customers on the platform, including credit/debit cards (PCI DSS-tokenized), digital wallets (Apple Pay, Google Pay, PayPal), bank accounts (ACH/SEPA), buy-now-pay-later instruments, gift cards, and marketplace credits. Stores tokenized card data reference, billing address, expiry, card network (Visa/MC/Amex/Discover), issuing bank, method lifecycle status (active/expired/suspended/deleted), customer preference ranking, and SCA enrollment status. SSOT for payment instrument definitions referenced by transactions, authorizations, and tokens.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`payment`.`authorization` (
    `authorization_id` BIGINT COMMENT 'System-generated unique identifier for the payment authorization record.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who initiated the payment.',
    `gateway_id` BIGINT COMMENT 'Foreign key linking to payment.gateway. Business justification: Every authorization request is routed through a specific payment gateway. authorization currently has no FK to the gateway master table, despite capturing gateway_response_code and gateway_response_me',
    `marketplace_transaction_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_transaction. Business justification: Authorizations are initiated during marketplace transaction checkout. Risk and payments teams need this link for authorization rate reporting by marketplace segment, 3DS compliance tracking per transa',
    `merchant_account_id` BIGINT COMMENT 'Identifier of the merchant account receiving the payment.',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.method. Business justification: Every authorization attempt is made against a specific payment method (credit card, debit card, etc.). authorization currently stores payment_method as a string and tokenized_card_number as a string, ',
    `token_id` BIGINT COMMENT 'Foreign key linking to payment.token. Business justification: authorization stores tokenized_card_number as a raw string, which is a denormalized reference to the PCI DSS token registry. Adding token_id as a proper FK to the token table normalizes this relations',
    `auth_amount` DECIMAL(18,2) COMMENT 'Monetary amount requested for authorization, expressed in the transaction currency.',
    `auth_code` STRING COMMENT 'Issuer‑provided code confirming successful authorization.',
    `authorization_status` STRING COMMENT 'Current lifecycle state of the authorization (e.g., authorized, declined, voided).. Valid values are `authorized|declined|voided|expired|captured|refunded`',
    `avs_result` STRING COMMENT 'Result of the AVS check comparing billing address to card records.. Valid values are `matched|partial|no_match|not_checked`',
    `billing_country_code` STRING COMMENT 'Three‑letter country code of the billing address.. Valid values are `USA|CAN|GBR|DEU|FRA|JPN`',
    `card_brand` STRING COMMENT 'Brand of the payment card (e.g., Visa, MasterCard, Amex).',
    `card_expiry_month` STRING COMMENT 'Expiration month of the payment card (1‑12).',
    `card_expiry_year` STRING COMMENT 'Expiration year of the payment card (four‑digit).',
    `challenge_status` STRING COMMENT 'Status of any 3‑DS challenge presented to the cardholder.. Valid values are `passed|failed|pending`',
    `compliance_regulation` STRING COMMENT 'Regulatory framework applicable to this authorization (e.g., PCI DSS, PSD2, GDPR).. Valid values are `PCI_DSS|PSD2|GDPR`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the authorization record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the authorization amount.',
    `cvv_result` STRING COMMENT 'Result of the CVV check for the card.. Valid values are `matched|no_match|not_checked`',
    `decline_reason` STRING COMMENT 'Issuer‑provided textual reason for a declined authorization.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact time the authorization request was sent to the issuing bank.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Rate used to convert the transaction amount to the settlement currency, if applicable.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the payment gateway or processor for this authorization.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether the transaction was flagged as potentially fraudulent.',
    `hold_expiry_timestamp` TIMESTAMP COMMENT 'Time when the authorization hold is scheduled to expire if not captured.',
    `is_captured` BOOLEAN COMMENT 'True if the authorized amount has been captured.',
    `is_partial_capture_allowed` BOOLEAN COMMENT 'Indicates whether the authorized amount can be captured in parts.',
    `is_refunded` BOOLEAN COMMENT 'True if the captured amount has been fully refunded.',
    `is_test_transaction` BOOLEAN COMMENT 'True if the authorization was generated in a test or sandbox environment.',
    `is_voided` BOOLEAN COMMENT 'True if the authorization was voided before capture.',
    `merchant_category_code` STRING COMMENT 'Four‑digit code classifying the merchants business type.. Valid values are `^d{4}$`',
    `original_currency_code` STRING COMMENT 'Currency code of the amount originally authorized before any conversion.',
    `payment_channel` STRING COMMENT 'Digital channel through which the payment was initiated.. Valid values are `web|mobile_app|in_store|api`',
    `payment_method` STRING COMMENT 'Instrument used for the payment (e.g., credit card, digital wallet).. Valid values are `credit_card|debit_card|bank_transfer|digital_wallet|paypal|apple_pay`',
    `processing_latency_ms` STRING COMMENT 'Round‑trip latency of the authorization request measured in milliseconds.',
    `risk_score` STRING COMMENT 'Numeric risk assessment (0‑100) generated by fraud detection engine.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Final settled amount after capture, fees, and adjustments.',
    `settlement_date` DATE COMMENT 'Date on which the authorized amount was settled to the merchant.',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Additional amount added to the authorization for surcharges (e.g., service fees).',
    `three_ds_result` STRING COMMENT 'Outcome of the 3‑DS/SCA authentication flow.. Valid values are `success|failure|challenge_required|not_supported`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the authorization record.',
    CONSTRAINT pk_authorization PRIMARY KEY(`authorization_id`)
) COMMENT 'Captures the real-time authorization request and response lifecycle for each payment attempt against the issuing bank via the payment gateway. Records authorization code, AVS/CVV result, issuer response, decline reason, authorization amount, hold expiry, 3DS/SCA authentication result and challenge status, and gateway latency. An authorization may be voided, partially captured, retried, or expire without settlement — distinct from the final captured transaction. Supports PSD2 Strong Customer Authentication compliance tracking.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`payment`.`settlement` (
    `settlement_id` BIGINT COMMENT 'Unique system-generated identifier for the settlement record.',
    `finance_bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.finance_bank_account. Business justification: Settlement funds are deposited into specific bank accounts. Treasury and cash management processes require knowing which bank account received each settlement batch. Bank reconciliation and cash flow ',
    `gateway_id` BIGINT COMMENT 'Foreign key linking to payment.gateway. Business justification: Settlement batches are submitted through specific payment gateways to acquiring banks. settlement currently has acquiring_bank_code but no FK to the gateway master. Adding gateway_id links each settle',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Settlement batches must be posted to specific GL accounts for cash receipt accounting and month-end close. Finance teams run settlement-to-GL reconciliation reports. A finance expert would consider th',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Settlements must be attributed to the correct legal entity for statutory reporting, intercompany reconciliation, and regulatory compliance. Multi-entity e-commerce platforms process settlements under ',
    `merchant_account_id` BIGINT COMMENT 'Identifier of the merchant (seller) account receiving the settlement funds.',
    `reconciliation_id` BIGINT COMMENT 'Foreign key linking to payment.reconciliation. Business justification: Settlement batches are reconciled as part of a reconciliation run. settlement currently stores reconciliation_status and reconciliation_timestamp as denormalized fields, but has no FK to the reconcili',
    `acquiring_bank_code` BIGINT COMMENT 'Identifier of the acquiring bank that processes the settlement.',
    `assessment_fee` DECIMAL(18,2) COMMENT 'Regulatory or network assessment fee applied to the settlement.',
    `audit_user` STRING COMMENT 'User or service account that performed the last update on the settlement record.',
    `batch_number` BIGINT COMMENT 'Identifier linking settlements that belong to the same processing batch.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement record was first created in the system.',
    `cross_border_fee` DECIMAL(18,2) COMMENT 'Additional fee applied for cross‑currency or cross‑border transactions.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the settlement currency.. Valid values are `^[A-Z]{3}$`',
    `currency_conversion_fee` DECIMAL(18,2) COMMENT 'Fee for converting the transaction amount into the settlement currency.',
    `cycle` STRING COMMENT 'Frequency with which settlements are generated for the merchant.. Valid values are `daily|weekly|monthly`',
    `fee_currency` STRING COMMENT 'Currency in which fee amounts are expressed.. Valid values are `^[A-Z]{3}$`',
    `fee_total_amount` DECIMAL(18,2) COMMENT 'Sum of all individual fees associated with the settlement.',
    `gateway_fee` DECIMAL(18,2) COMMENT 'Fee retained by the payment gateway provider for service usage.',
    `interchange_fee` DECIMAL(18,2) COMMENT 'Fee charged by the card scheme for processing the transaction.',
    `is_manual_settlement` BOOLEAN COMMENT 'True if the settlement was created manually (e.g., adjustment or correction).',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount transferred to the merchant after all fees are deducted.',
    `processing_fee_rate` DECIMAL(18,2) COMMENT 'Rate applied to calculate the processing fee (e.g., 0.0025 = 0.25%).',
    `settlement_date` DATE COMMENT 'Calendar date on which the settlement was executed.',
    `settlement_description` STRING COMMENT 'Free‑form notes or comments about the settlement.',
    `settlement_method` STRING COMMENT 'Mechanism used to transfer funds to the merchant (e.g., ACH, wire, card payout).. Valid values are `ach|wire|card|paypal`',
    `settlement_number` STRING COMMENT 'Human‑readable settlement reference number used in finance and reporting.',
    `settlement_status` STRING COMMENT 'Current processing state of the settlement.. Valid values are `pending|settled|failed|reversed`',
    `settlement_timestamp` TIMESTAMP COMMENT 'Exact moment (including time zone) when the settlement was posted to the acquiring bank.',
    `settlement_type` STRING COMMENT 'Indicates whether the record represents a batch settlement or a single‑transaction settlement.. Valid values are `batch|individual`',
    `source_system` STRING COMMENT 'Name of the upstream payment gateway or processing platform that generated the settlement record.',
    `status_detail` STRING COMMENT 'Additional free‑text information describing the current status (e.g., reason for failure).',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross amount of the settlement before fee deductions, expressed in the settlement currency.',
    `transaction_count` STRING COMMENT 'Number of individual payment transactions included in this settlement.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the settlement record.',
    CONSTRAINT pk_settlement PRIMARY KEY(`settlement_id`)
) COMMENT 'Records settlement batches and individual settlement entries submitted to acquiring banks and payment networks for fund transfer, including all associated processing fees at transaction level. Settlement attributes: settlement date, amount, currency, acquiring bank, merchant account, status (pending/settled/failed). Fee attributes: fee type (interchange, assessment, gateway fee, cross-border fee, currency conversion fee), fee amount, fee rate, fee currency. SSOT for settlement records and their associated processing fees. Supports daily reconciliation, financial close, cost-of-payment analysis, and fee reconciliation against gateway invoices.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`payment`.`payment_refund` (
    `payment_refund_id` BIGINT COMMENT 'Unique identifier for the refund transaction.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Refunds must be posted to the originating customer account for balance updates, audit trails, and regulatory reporting.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Refunds reduce or close open AR balances. Cash application and AR reconciliation processes require linking refunds to the AR records they offset. AR aging accuracy and customer account statements depe',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Needed to attribute refunds to the originating campaign, enabling accurate net revenue and ROAS calculations.',
    `channel_id` BIGINT COMMENT 'Foreign key linking to marketing.channel. Business justification: Channel-level net revenue and refund rate reporting: marketing teams track refund rates by acquisition channel to assess channel quality and true ROI. payment_refund has campaign_id but not channel_id',
    `coupon_redemption_id` BIGINT COMMENT 'Foreign key linking to pricing.coupon_redemption. Business justification: Coupon redemption reversal on refund: when a refund is processed for an order where a coupon was redeemed, the specific coupon_redemption record must be located and its status reversed/voided. Direct ',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: Allows refund audit linking each refund to the exact fulfillment order it reverses, required for refund‑to‑fulfillment reporting.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Refunds require GL postings to reverse revenue and record cash outflows. Finance month-end close, refund expense reporting, and revenue reversal entries all require knowing which GL account each refun',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Each refund triggers a journal entry reversing the original revenue and cash postings. SOX controls and finance audit trails require tracing every refund to its corresponding journal entry for complet',
    `logistics_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Shipping cost refunds (lost/damaged shipments) require direct reference to the logistics shipment for carrier claim filing and refund reconciliation. E-commerce ops teams must trace which shipment tri',
    `method_id` BIGINT COMMENT 'Foreign key linking to payment.method. Business justification: Refunds are returned to a specific payment method (typically the original method used for the transaction). payment_refund currently stores refund_method and payment_method as string descriptors but h',
    `payment_transaction_id` BIGINT COMMENT 'Foreign key linking to payment.payment_transaction. Business justification: Refunds must be linked to the original payment transaction for traceability and reconciliation; this FK enables joining refund details to the transaction record.',
    `promotion_rule_id` BIGINT COMMENT 'Foreign key linking to pricing.promotion_rule. Business justification: Promotional refund calculation: when a promotion rule (BOGO, tiered discount) was applied to an order, the refund processor must reference the specific rule mechanics (discount_value, rule_type, stack',
    `promotional_campaign_id` BIGINT COMMENT 'Foreign key linking to pricing.promotional_campaign. Business justification: Regulatory and financial audits track refunds of promotional discounts, requiring a link to the originating campaign.',
    `proof_of_delivery_id` BIGINT COMMENT 'Foreign key linking to fulfillment.proof_of_delivery. Business justification: Refund eligibility verification: e-commerce refund processing checks POD status before approving refunds to prevent refund fraud on confirmed-delivered items. No existing link connects payment_refund ',
    `rma_id` BIGINT COMMENT 'Identifier of the RMA that triggered this refund, if applicable.',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: REQUIRED: Refunds must be attributed to the originating seller for correct financial adjustments and seller performance metrics.',
    `service_refund_id` BIGINT COMMENT 'Foreign key linking to service.service_refund. Business justification: Links financial refund record to service‑side refund process for reconciliation and end‑to‑end refund tracking.',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to payment.settlement. Business justification: Refunds are settled through settlement batches submitted to acquiring banks. payment_refund currently stores settlement_status and settlement_date as denormalized fields but has no FK to the settlemen',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Refund processing must reference the exact SKU being refunded for inventory adjustment and accurate financial reconciliation.',
    `tax_record_id` BIGINT COMMENT 'Foreign key linking to finance.tax_record. Business justification: Refunds require tax credit notes and VAT/GST adjustment entries. Tax compliance reporting (VAT returns, GST filings) requires linking refunds to their tax records to correctly reverse tax liabilities ',
    `amount` DECIMAL(18,2) COMMENT 'Total amount requested for refund before any fees or adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the refund record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the refund amount.. Valid values are `^[A-Z]{3}$`',
    `fee_amount` DECIMAL(18,2) COMMENT 'Processing fee charged by the payment gateway for the refund.',
    `fraud_check_status` STRING COMMENT 'Result of the fraud detection check for this refund.. Valid values are `passed|failed|pending`',
    `initiated_timestamp` TIMESTAMP COMMENT 'Timestamp when the refund was initially requested.',
    `is_fraud` BOOLEAN COMMENT 'Indicates whether the refund is associated with a suspected fraud case.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount that will be returned to the customer after fees.',
    `notes` STRING COMMENT 'Free‑form text for additional information about the refund.',
    `payment_channel` STRING COMMENT 'Channel through which the original payment was made.. Valid values are `web|mobile|api|in_store`',
    `payment_method` STRING COMMENT 'Original payment instrument used for the transaction being refunded.. Valid values are `credit_card|debit_card|paypal|bank_transfer|gift_card|apple_pay`',
    `payment_refund_status` STRING COMMENT 'Current lifecycle status of the refund request.. Valid values are `pending|approved|rejected|processed|failed|cancelled`',
    `processing_fee` DECIMAL(18,2) COMMENT 'Fee charged by the payment processor for handling the refund.',
    `reason_code` STRING COMMENT 'Standardized code indicating why the refund was issued.. Valid values are `product_defect|customer_change_of_mind|shipping_error|price_adjustment|fraud|other`',
    `reference` STRING COMMENT 'External reference number assigned to the refund for tracking and reconciliation.',
    `refund_method` STRING COMMENT 'Method used to return funds to the customer.. Valid values are `original|store_credit|gift_card|bank_transfer`',
    `refund_type` STRING COMMENT 'Indicates whether the refund is for the full transaction amount or a partial amount.. Valid values are `full|partial`',
    `request_source` STRING COMMENT 'Origin of the refund request (e.g., customer service agent, self‑service portal, automated rule).. Valid values are `customer_service|self_service|automated`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the refund record.',
    CONSTRAINT pk_payment_refund PRIMARY KEY(`payment_refund_id`)
) COMMENT 'Tracks all refund transactions initiated against original payment transactions, including full and partial refunds. Records refund amount, refund reason code, originating transaction reference, refund method (original payment method or store credit), processing status, and gateway refund confirmation. Supports RMA-driven refund workflows and customer service-initiated refunds.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`payment`.`chargeback` (
    `chargeback_id` BIGINT COMMENT 'Unique system-generated identifier for the chargeback record.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Chargebacks reverse previously recognized AR balances. AR dispute management and write-off processes require linking chargebacks to the AR record being reversed. AR aging reports and dispute resolutio',
    `dispute_id` BIGINT COMMENT 'External dispute reference number assigned by the cardholders issuing bank.',
    `fulfillment_shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_shipment. Business justification: Chargeback evidence package assembly requires direct access to shipment records (tracking number, delivery status, carrier data) to contest item not received disputes. No existing path connects char',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Chargeback losses and fees must be posted to GL accounts (chargeback expense, fee expense accounts). Finance P&L reporting on chargeback costs and provisioning for chargeback reserves requires linking',
    `header_id` BIGINT COMMENT 'Identifier of the order associated with the disputed transaction.',
    `merchant_account_id` BIGINT COMMENT 'Identifier of the merchant whose account is affected by the chargeback.',
    `payment_transaction_id` BIGINT COMMENT 'Identifier of the original payment transaction that is being disputed.',
    `proof_of_delivery_id` BIGINT COMMENT 'Foreign key linking to fulfillment.proof_of_delivery. Business justification: Chargeback dispute resolution for item not received claims requires POD as primary regulatory evidence submitted to card networks. No existing path connects chargeback to proof_of_delivery. Card sch',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Chargebacks in marketplace e-commerce are filed against specific seller transactions. Chargeback management, seller liability recovery, and order_defect_rate performance scoring all require direct sel',
    `support_case_id` BIGINT COMMENT 'Foreign key linking to service.service_support_case. Business justification: Chargeback dispute resolution in e-commerce requires a linked service support case for evidence gathering, customer communication, and SLA tracking. Operations and compliance teams need to correlate c',
    `tax_record_id` BIGINT COMMENT 'Foreign key linking to finance.tax_record. Business justification: Chargebacks require VAT/GST credit note issuance and tax reversal entries. Tax compliance for disputed transactions requires linking chargebacks to their associated tax records for accurate VAT return',
    `amount_fee` DECIMAL(18,2) COMMENT 'Fee assessed by the card scheme for processing the chargeback.',
    `amount_net` DECIMAL(18,2) COMMENT 'Net amount after fees that the merchant is liable for.',
    `amount_original` DECIMAL(18,2) COMMENT 'The gross amount originally charged to the cardholder.',
    `audit_notes` STRING COMMENT 'Free‑form notes from auditors or investigators regarding the chargeback.',
    `card_brand` STRING COMMENT 'Brand of the card used (e.g., Visa, MasterCard, Amex).',
    `card_last4` STRING COMMENT 'Last four digits of the card number (PCI‑DSS compliant token).',
    `card_type` STRING COMMENT 'Type of card (e.g., credit, debit, prepaid).',
    `chargeback_status` STRING COMMENT 'Current lifecycle state of the chargeback.. Valid values are `open|pending|won|lost|closed|reversed`',
    `compliance_status` STRING COMMENT 'Current compliance verification status for the chargeback.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the chargeback record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the disputed transaction.',
    `dispute_category` STRING COMMENT 'High‑level classification of the dispute reason.. Valid values are `fraud|authorization_error|processing_error|service_issue|goods_not_received|duplicate`',
    `dispute_subcategory` STRING COMMENT 'More granular sub‑type within the dispute category.',
    `dispute_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute was initially filed by the cardholder.',
    `dispute_type` STRING COMMENT 'Indicates who initiated the dispute: cardholder, merchant, or issuing bank.. Valid values are `cardholder|merchant|issuer`',
    `evidence_submission_date` TIMESTAMP COMMENT 'Timestamp when the merchant submitted evidence.',
    `evidence_submitted_flag` BOOLEAN COMMENT 'True if the merchant has submitted required evidence for the dispute.',
    `fee` DECIMAL(18,2) COMMENT 'Additional fee levied by the card scheme for processing the chargeback.',
    `fraud_score` STRING COMMENT 'Numeric risk score assigned by the fraud detection engine.',
    `is_fraudulent_flag` BOOLEAN COMMENT 'True if the dispute is determined to be fraud.',
    `liability_amount` DECIMAL(18,2) COMMENT 'Amount the liable party must pay after the dispute is resolved.',
    `liability_party` STRING COMMENT 'Entity responsible for the net chargeback amount.. Valid values are `merchant|cardholder|issuer`',
    `merchant_category_code` STRING COMMENT 'Four‑digit code that classifies the merchants business type.',
    `merchant_location_city` STRING COMMENT 'City where the merchants primary location resides.',
    `merchant_location_country` STRING COMMENT 'Three‑letter country code of the merchants primary location.',
    `outcome` STRING COMMENT 'Final result of the dispute after adjudication.. Valid values are `won|lost|accepted|reversed`',
    `payment_channel` STRING COMMENT 'Digital channel through which the payment was made.. Valid values are `web|mobile_app|in_store|api`',
    `payment_method` STRING COMMENT 'Instrument used for the original transaction.. Valid values are `credit_card|debit_card|bank_transfer|digital_wallet|gift_card`',
    `reason_code` STRING COMMENT 'Standardized code representing the reason for the dispute (e.g., Visa R01, MC 4837).',
    `reason_description` STRING COMMENT 'Human‑readable description of the dispute reason.',
    `regulatory_reference` STRING COMMENT 'Reference to any regulatory filing or compliance case linked to the chargeback.',
    `response_deadline` TIMESTAMP COMMENT 'Latest timestamp by which the merchant must respond to the dispute.',
    `settlement_date` DATE COMMENT 'Date on which the chargeback amount is settled with the merchant.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the chargeback record.',
    CONSTRAINT pk_chargeback PRIMARY KEY(`chargeback_id`)
) COMMENT 'Manages the full lifecycle of payment disputes and chargebacks initiated by cardholders through their issuing bank. Tracks chargeback reason code (per Visa/MC/Amex dispute categories), dispute amount, dispute date, response deadline, evidence submission status, chargeback outcome (won/lost/accepted), and associated financial liability. Critical for fraud management and financial reconciliation.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`payment`.`fraud_case` (
    `fraud_case_id` BIGINT COMMENT 'Unique system-generated identifier for each fraud case.',
    `agent_id` BIGINT COMMENT 'Identifier of the analyst assigned to the case.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fraud losses are allocated to cost centers for internal management reporting and budget variance analysis. Operations and finance teams track fraud costs by business unit to measure cost center perfor',
    `coupon_id` BIGINT COMMENT 'Foreign key linking to pricing.coupon. Business justification: Coupon fraud investigation: coupon cloning, fake coupon codes, and mass redemption fraud are major e-commerce fraud types. A fraud investigator must identify which specific coupon was involved to asse',
    `customer_address_id` BIGINT COMMENT 'Foreign key linking to customer.customer_address. Business justification: Fraud investigation workflow: fraud analysts must verify the shipping/billing address associated with a suspicious transaction. fraud_case tracks geo_country_code and ip_address but lacks a direct add',
    `fulfillment_shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_shipment. Business justification: Fraud investigation shipment audit: triangulation fraud and friendly fraud detection require verifying whether goods shipped to the claimed address. No direct path from fraud_case to fulfillment_shipm',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Fraud losses and recovery amounts must be posted to GL accounts (fraud loss expense, fraud recovery income). Finance fraud provisioning, loss reporting, and P&L impact analysis require linking fraud c',
    `header_id` BIGINT COMMENT 'Identifier of the order associated with the payment.',
    `marketplace_transaction_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace_transaction. Business justification: Fraud cases originate from specific marketplace transactions. Trust & safety and fraud operations teams need this direct link for seller liability assignment, marketplace fraud rate reporting, and tra',
    `merchant_account_id` BIGINT COMMENT 'Identifier of the merchant/seller linked to the transaction.',
    `promotional_campaign_id` BIGINT COMMENT 'Foreign key linking to pricing.promotional_campaign. Business justification: Promotional fraud analysis: promotional abuse (fake accounts exploiting campaigns, discount stacking) is a primary e-commerce fraud vector. Linking fraud_case to promotional_campaign enables campaign-',
    `seller_profile_id` BIGINT COMMENT 'Foreign key linking to seller.seller_profile. Business justification: Marketplace fraud cases can originate from seller-side fraud (counterfeit listings, payment fraud). Fraud investigation teams must link cases to seller profiles for seller suspension workflows, KYC re',
    `support_case_id` BIGINT COMMENT 'Foreign key linking to service.service_support_case. Business justification: Fraud investigations in e-commerce generate parallel customer service cases (unauthorized charge complaints, account compromise). Fraud operations teams must correlate fraud_case records with service_',
    `case_number` STRING COMMENT 'Human‑readable case number used in investigations and reporting.',
    `case_status` STRING COMMENT 'Current lifecycle status of the fraud case.. Valid values are `open|under_investigation|closed|escalated|false_positive`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the fraud case record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the fraud amount.',
    `detection_source` STRING COMMENT 'Origin of the fraud detection signal.. Valid values are `rule_engine|machine_learning|manual_review|external_alert|partner_feed`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date‑time when the fraud signal was generated.',
    `device_fingerprint` STRING COMMENT 'Hashed identifier of the device used in the transaction.',
    `fraud_amount` DECIMAL(18,2) COMMENT 'Monetary value associated with the suspected fraudulent transaction.',
    `fraud_type` STRING COMMENT 'Category of fraudulent activity detected.. Valid values are `cnp|account_takeover|friendly_fraud|synthetic_identity|chargeback_fraud|other`',
    `geo_country_code` STRING COMMENT 'Three‑letter country code of the transaction origin.',
    `investigation_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the investigation was concluded.',
    `investigation_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the investigation began.',
    `investigator_name` STRING COMMENT 'Name of the analyst handling the investigation.',
    `ip_address` STRING COMMENT 'IP address from which the transaction originated.',
    `is_high_risk` BOOLEAN COMMENT 'Indicates whether the case is flagged as high risk for priority handling.',
    `notes` STRING COMMENT 'Free‑form text notes entered by investigators.',
    `processing_fee` DECIMAL(18,2) COMMENT 'Fee charged by the payment processor for handling the transaction.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Monetary amount recovered from the fraudulent transaction.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the fraud case after investigation.. Valid values are `confirmed_fraud|false_positive|investigation_closed|escalated|pending`',
    `rule_action` STRING COMMENT 'Automated action taken when the rule fires.. Valid values are `block|review|allow|challenge`',
    `rule_activation_status` STRING COMMENT 'Current activation state of the fraud rule.. Valid values are `active|inactive|deprecated`',
    `rule_name` STRING COMMENT 'Descriptive name of the fraud detection rule.',
    `rule_priority` STRING COMMENT 'Priority level of the rule; higher values indicate more critical rules.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date‑time when the underlying payment transaction occurred.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the fraud case record.',
    CONSTRAINT pk_fraud_case PRIMARY KEY(`fraud_case_id`)
) COMMENT 'Operational record of confirmed or suspected fraudulent payment activity requiring investigation and action, plus the authoritative registry of fraud detection rules and velocity checks that drive automated prevention. Case attributes: fraud type (CNP, account takeover, friendly fraud, synthetic identity), detection source, fraud amount, case status, investigator assignment, resolution outcome, recovery amount. Rule attributes: rule logic (e.g., max transaction amount per hour, BIN country mismatch, device fingerprint anomaly), rule priority, action (block/review/allow), activation status, performance thresholds. SSOT for both fraud investigation cases and the fraud prevention ruleset. Supports real-time fraud blocking, post-transaction investigation, rule tuning, and regulatory SAR (Suspicious Activity Report) filing.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`payment`.`gateway` (
    `gateway_id` BIGINT COMMENT 'Primary key for gateway',
    `api_version` STRING COMMENT 'Version string of the gateways API that the platform integrates with.',
    `compliance_gdpr` BOOLEAN COMMENT 'True if the gateway adheres to GDPR data‑privacy obligations.',
    `compliance_iso27001` BOOLEAN COMMENT 'True if the gateway is certified under ISO 27001 information‑security standards.',
    `compliance_pci_dss` BOOLEAN COMMENT 'True if the gateway meets PCI DSS requirements for card data handling.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the gateway record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the gateway configuration becomes active.',
    `effective_until` DATE COMMENT 'Date when the gateway configuration expires or is retired; null if open‑ended.',
    `endpoint_url` STRING COMMENT 'Base URL used for API calls to the payment gateway.',
    `failover_priority` STRING COMMENT 'Numeric priority for automatic failover; lower numbers indicate higher priority.',
    `fraud_detection_enabled` BOOLEAN COMMENT 'True if the gateway includes built‑in fraud detection services.',
    `gateway_description` STRING COMMENT 'Free‑form description of the gateways purpose, capabilities, or special notes.',
    `gateway_name` STRING COMMENT 'Human‑readable name of the payment gateway (e.g., Stripe, Adyen).',
    `gateway_status` STRING COMMENT 'Current operational status of the gateway configuration.. Valid values are `active|inactive|suspended|decommissioned`',
    `gateway_type` STRING COMMENT 'Classification of the gateway (e.g., payment, bank, alternative, crypto).. Valid values are `payment|bank|alternative|crypto`',
    `is_3d_secure_enabled` BOOLEAN COMMENT 'Indicates whether 3‑D Secure authentication is available for this gateway.',
    `is_multi_currency_supported` BOOLEAN COMMENT 'Indicates whether the gateway can process transactions in multiple currencies without separate configurations.',
    `is_tokenization_enabled` BOOLEAN COMMENT 'Indicates whether the gateway supports PCI‑DSS tokenization of card data.',
    `last_tested_timestamp` TIMESTAMP COMMENT 'Date‑time when the gateway configuration was last health‑checked.',
    `max_transaction_amount` DECIMAL(18,2) COMMENT 'Upper monetary limit per transaction that the gateway will accept.',
    `min_transaction_amount` DECIMAL(18,2) COMMENT 'Lower monetary threshold per transaction for the gateway.',
    `notes` STRING COMMENT 'Additional operational notes or comments from administrators.',
    `processing_region` STRING COMMENT 'Three‑letter ISO country code representing the primary region where the gateway processes transactions.. Valid values are `^[A-Z]{3}$`',
    `provider_code` STRING COMMENT 'Internal code used to reference the gateway provider.',
    `provider_name` STRING COMMENT 'Legal name of the gateway service provider.',
    `routing_logic` STRING COMMENT 'Textual description of the routing and fallback logic used when multiple gateways are configured.',
    `settlement_currency` STRING COMMENT 'ISO 4217 currency code used for settlement payouts.. Valid values are `^[A-Z]{3}$`',
    `settlement_cycle_days` STRING COMMENT 'Number of days after a transaction before funds are settled to the merchant.',
    `sla_response_time_ms` STRING COMMENT 'Maximum allowed response time in milliseconds as defined in the service‑level agreement.',
    `sla_uptime_percent` DECIMAL(18,2) COMMENT 'Targeted uptime percentage for the gateway service (e.g., 99.95).',
    `supported_currencies` STRING COMMENT 'Comma‑separated ISO 4217 currency codes that the gateway accepts.',
    `supported_payment_methods` STRING COMMENT 'Comma‑separated list of payment methods (e.g., credit_card, debit_card, paypal, apple_pay) the gateway can process.',
    `supports_chargebacks` BOOLEAN COMMENT 'Indicates whether the gateway provides chargeback handling capabilities.',
    `supports_partial_refunds` BOOLEAN COMMENT 'Indicates whether the gateway allows partial refunds.',
    `supports_recurring` BOOLEAN COMMENT 'Indicates whether the gateway can process recurring subscription payments.',
    `supports_refunds` BOOLEAN COMMENT 'Indicates whether the gateway allows full refunds.',
    `test_status` STRING COMMENT 'Result of the most recent connectivity/health test.. Valid values are `passed|failed|pending|unknown`',
    `transaction_fee_fixed` DECIMAL(18,2) COMMENT 'Fixed monetary fee (in the settlement currency) applied per transaction.',
    `transaction_fee_percent` DECIMAL(18,2) COMMENT 'Variable fee percentage applied to each transaction processed through the gateway.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the gateway record.',
    CONSTRAINT pk_gateway PRIMARY KEY(`gateway_id`)
) COMMENT 'Master reference for all payment gateway integrations and acquiring bank connections configured on the platform. Records gateway provider (Stripe, Adyen, Braintree, etc.), supported payment methods, supported currencies, processing region, gateway endpoint configuration, failover priority, and SLA parameters. Enables multi-gateway routing and fallback logic for transaction processing.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`payment`.`merchant_account` (
    `merchant_account_id` BIGINT COMMENT 'Unique identifier for the merchant account record.',
    `gateway_id` BIGINT COMMENT 'Foreign key linking to payment.gateway. Business justification: Merchant accounts are established with specific payment gateways and acquiring banks. merchant_account currently has no FK to the gateway master table despite being the primary entity that configures ',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Merchant account processing fees, chargeback fees, and settlement amounts are posted to specific GL accounts. Finance reporting on payment processing costs and fee analysis requires linking merchant a',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Merchant accounts are registered under specific legal entities for regulatory compliance, PCI-DSS scope, and tax reporting. Finance and compliance teams must know which legal entity owns each merchant',
    `marketplace_id` BIGINT COMMENT 'Foreign key linking to marketplace.marketplace. Business justification: Merchant accounts are registered and operated within a specific marketplace context in multi-marketplace platforms. Compliance, settlement routing, and fee configuration differ by marketplace. Finance',
    `account_type` STRING COMMENT 'Type of merchant account.. Valid values are `acquiring|processor|gateway`',
    `acquiring_bank_code` STRING COMMENT 'Internal identifier for the acquiring bank.',
    `acquiring_bank_name` STRING COMMENT 'Name of the bank that acquires transactions for the merchant.',
    `chargeback_fee_fixed` DECIMAL(18,2) COMMENT 'Fixed fee per chargeback transaction.',
    `chargeback_fee_rate` DECIMAL(18,2) COMMENT 'Fee rate applied to chargeback transactions.',
    `compliance_audit_date` DATE COMMENT 'Date of the most recent compliance audit.',
    `compliance_audit_status` STRING COMMENT 'Result of the most recent compliance audit.. Valid values are `passed|failed|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the merchant account record was created.',
    `daily_transaction_limit` BIGINT COMMENT 'Maximum number of transactions allowed per day.',
    `daily_volume_limit` DECIMAL(18,2) COMMENT 'Maximum total transaction amount per day.',
    `effective_from` DATE COMMENT 'Date when the merchant account became active.',
    `effective_until` DATE COMMENT 'Date when the merchant account is terminated or expires (nullable).',
    `external_reference_code` STRING COMMENT 'Identifier used by external systems to reference this merchant account.',
    `fraud_detection_enabled` BOOLEAN COMMENT 'Indicates if fraud detection is active for this account.',
    `is_multi_currency` BOOLEAN COMMENT 'Indicates if the account supports multiple currencies.',
    `is_test_account` BOOLEAN COMMENT 'Indicates if this is a test or sandbox merchant account.',
    `last_settlement_date` DATE COMMENT 'Date of the most recent settlement for this account.',
    `merchant_account_number` STRING COMMENT 'Unique account number assigned by acquiring bank.',
    `merchant_account_status` STRING COMMENT 'Current status of the merchant account.. Valid values are `active|inactive|suspended|closed|pending`',
    `merchant_category_code` STRING COMMENT 'Standard code that classifies the merchants business type.',
    `monthly_transaction_limit` BIGINT COMMENT 'Maximum number of transactions allowed per month.',
    `monthly_volume_limit` DECIMAL(18,2) COMMENT 'Maximum total transaction amount per month.',
    `notes` STRING COMMENT 'Free-text field for additional information or comments.',
    `onboarding_date` DATE COMMENT 'Date when the merchant was onboarded to the platform.',
    `payment_network` STRING COMMENT 'Payment card network associated with the merchant account.',
    `pci_compliance_status` STRING COMMENT 'PCI DSS compliance status.. Valid values are `compliant|non_compliant|pending`',
    `processing_currency` STRING COMMENT 'Currency in which transactions are processed.',
    `processing_fee_fixed` DECIMAL(18,2) COMMENT 'Fixed fee per transaction.',
    `processing_fee_rate` DECIMAL(18,2) COMMENT 'Percentage fee applied to each transaction.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates if the account is subject to special regulatory reporting.',
    `risk_score` STRING COMMENT 'Internal risk assessment score for the merchant account.',
    `settlement_bank_account` STRING COMMENT 'Bank account number where settlements are deposited.',
    `settlement_bank_name` STRING COMMENT 'Name of the bank where settlements are deposited.',
    `settlement_bank_swift_code` STRING COMMENT 'SWIFT/BIC code of the settlement bank.',
    `settlement_currency` STRING COMMENT 'Currency in which funds are settled to the merchant.',
    `settlement_cycle` STRING COMMENT 'Frequency of settlement for the merchant account.. Valid values are `daily|weekly|monthly`',
    `supported_currencies` STRING COMMENT 'Comma-separated list of ISO currency codes supported.',
    `termination_date` DATE COMMENT 'Date when the merchant account was terminated.',
    `tokenization_enabled` BOOLEAN COMMENT 'Indicates if card data tokenization is used.',
    `tokenization_method` STRING COMMENT 'Method of tokenization applied.. Valid values are `single_use|multi_use|none`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the merchant account record.',
    CONSTRAINT pk_merchant_account PRIMARY KEY(`merchant_account_id`)
) COMMENT 'Master record of merchant accounts established with acquiring banks and payment processors for fund collection. Tracks merchant account number, acquiring bank, payment network agreements, processing currency, settlement currency, merchant category code (MCC), account status, and associated processing fees. Supports multi-merchant-account routing for marketplace and DTC channels.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`payment`.`reconciliation` (
    `reconciliation_id` BIGINT COMMENT 'System-generated unique identifier for each reconciliation run.',
    `finance_bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.finance_bank_account. Business justification: Payment reconciliation matches gateway settlement records against bank account statements. The bank account is the primary reference for reconciliation; treasury and finance teams need this link to ru',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Payment reconciliation matches internal transaction records against GL account balances to identify variances. Finance close process and external audit require reconciliation records to reference the ',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the legal entity (e.g., corporate subsidiary) for which the reconciliation is performed.',
    `merchant_account_id` BIGINT COMMENT 'Foreign key linking to payment.merchant_account. Business justification: Reconciliation runs are performed for specific merchant accounts, comparing internal transaction records against external bank/gateway statements. reconciliation currently has no FK to merchant_accoun',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reconciliation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the monetary values.',
    `exception_reason_code` STRING COMMENT 'Code indicating the primary reason for any reconciliation exception.',
    `matched_line_count` BIGINT COMMENT 'Number of line items where internal transaction matched the external statement.',
    `period_end_date` DATE COMMENT 'End date of the financial period covered by this reconciliation.',
    `period_start_date` DATE COMMENT 'Start date of the financial period covered by this reconciliation.',
    `reconciliation_number` STRING COMMENT 'Business-visible identifier for the reconciliation run, often used in reporting and audit trails.',
    `reconciliation_status` STRING COMMENT 'Current lifecycle status of the reconciliation run.. Valid values are `open|reconciled|exception|pending`',
    `run_timestamp` TIMESTAMP COMMENT 'Exact time when the reconciliation process was executed.',
    `run_type` STRING COMMENT 'Classification of the reconciliation run frequency or trigger.. Valid values are `daily|monthly|ad_hoc`',
    `source_system` STRING COMMENT 'Originating system of the external statement (e.g., payment_gateway, bank).',
    `total_external_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary value of external bank/gateway statement records for the period.',
    `total_internal_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary value of internal transaction records for the period.',
    `total_line_count` BIGINT COMMENT 'Total number of line items processed in the reconciliation run.',
    `unmatched_line_count` BIGINT COMMENT 'Number of line items that did not find a matching counterpart.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reconciliation record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between total internal and external amounts (internal - external).',
    CONSTRAINT pk_reconciliation PRIMARY KEY(`reconciliation_id`)
) COMMENT 'Tracks the daily and periodic reconciliation process between internal transaction records and external bank/gateway statements, at both run-level summary and individual line-item detail. Run attributes: reconciliation period, matched/unmatched counts, variance totals, status (open/reconciled/exception). Line-item attributes: internal transaction reference, external statement reference, match status, variance amount, exception reason code. SSOT for all reconciliation runs and their constituent line items. Supports financial close, SOX-compliant payment reconciliation, and drill-down investigation of discrepancies.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`payment`.`wallet` (
    `wallet_id` BIGINT COMMENT 'System-generated unique identifier for the digital wallet record.',
    `customer_profile_id` BIGINT COMMENT 'Identifier of the customer who owns this wallet.',
    `gateway_id` BIGINT COMMENT 'Foreign key linking to payment.gateway. Business justification: Digital wallet transactions are processed through a payment gateway for top-ups, withdrawals, and transfers. wallet currently has no FK to the gateway master table. Adding gateway_id links each wallet',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Wallet balances represent a customer liability on the balance sheet and must be tracked against a GL account (deferred revenue or customer deposit liability). Finance balance sheet reporting and e-mon',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Wallets are issued under specific legal entities for e-money regulatory compliance and financial reporting. Multi-jurisdiction e-commerce platforms must attribute wallet liabilities to the correct leg',
    `balance` DECIMAL(18,2) COMMENT 'Current available balance in the wallet, expressed in the wallets currency.',
    `compliance_token` STRING COMMENT 'PCI‑DSS‑compliant token representing the underlying payment instrument used for funding; stored instead of raw card data.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the wallet record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the wallet (e.g., USD, EUR).. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'Date on which the wallet becomes inactive or expires, if applicable.',
    `is_default_wallet` BOOLEAN COMMENT 'Indicates whether this wallet is the default payment source for the owner customer.',
    `last_topup_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent top‑up (funding) transaction.',
    `last_transaction_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent balance‑affecting transaction recorded for the wallet.',
    `last_withdrawal_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent withdrawal or redemption transaction.',
    `pending_balance` DECIMAL(18,2) COMMENT 'Balance amount that is pending settlement (e.g., authorizations awaiting capture).',
    `total_credits` DECIMAL(18,2) COMMENT 'Cumulative sum of all credit‑type movements (top‑ups, refunds, promotions) to the wallet.',
    `total_debits` DECIMAL(18,2) COMMENT 'Cumulative sum of all debit‑type movements (purchases, withdrawals, redemptions) from the wallet.',
    `transaction_count` BIGINT COMMENT 'Total number of ledger entries recorded for this wallet.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the wallet record.',
    `wallet_name` STRING COMMENT 'Descriptive name for the wallet (e.g., "My Store Credit").',
    `wallet_number` STRING COMMENT 'Human‑readable unique wallet number assigned to the account.',
    `wallet_status` STRING COMMENT 'Current operational state of the wallet.. Valid values are `active|inactive|suspended|closed|pending`',
    `wallet_type` STRING COMMENT 'Category of wallet indicating its purpose and rules (store credit, loyalty points, prepaid balance, gift, promotional).. Valid values are `store_credit|loyalty_points|prepaid|gift|promo`',
    CONSTRAINT pk_wallet PRIMARY KEY(`wallet_id`)
) COMMENT 'Master record of customer digital wallet accounts on the platform with complete transactional ledger of all balance movements. Wallet attributes: balance, currency, type (store credit, loyalty points, prepaid balance), funding sources, status. Transaction attributes: movement type (top-up, refund credit, promotional credit, loyalty redemption, purchase payment, withdrawal, expiry), amount, balance before/after, reference order or promotion, timestamp. SSOT for wallet accounts and their full transaction history. Provides complete audit trail for wallet balance integrity. Distinct from third-party digital wallets (Apple Pay, PayPal) which are captured as payment_method records.';

CREATE OR REPLACE TABLE `ecommerce_ecm`.`payment`.`token` (
    `token_id` BIGINT COMMENT 'Globally unique identifier for the token record.',
    `merchant_account_id` BIGINT COMMENT 'Identifier of the merchant that owns or uses the token.',
    `method_id` BIGINT COMMENT 'Reference to the underlying payment method (e.g., credit card, bank account) associated with the token.',
    `audit_log_reference` BIGINT COMMENT 'Reference to the audit log entry that records token lifecycle events.',
    `compliance_check_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance verification.',
    `compliance_status` STRING COMMENT 'Current PCI‑DSS compliance status of the token.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the token record was first inserted.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for transactions using this token.. Valid values are `^[A-Z]{3}$`',
    `encryption_key_reference` STRING COMMENT 'Identifier of the cryptographic key used to encrypt the token.',
    `expiry_date` DATE COMMENT 'Date when the token becomes invalid.',
    `format` STRING COMMENT 'Technical format of the token (e.g., alphanumeric, numeric).',
    `hash_algorithm` STRING COMMENT 'Hash algorithm applied to the token for integrity verification.. Valid values are `sha256|sha384|sha512`',
    `is_test` BOOLEAN COMMENT 'Indicates whether the token is used for testing purposes only.',
    `issued_timestamp` TIMESTAMP COMMENT 'Date‑time when the token was created.',
    `last_used_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent transaction that used this token.',
    `length` STRING COMMENT 'Number of characters in the token.',
    `method` STRING COMMENT 'Process used to generate the token.. Valid values are `offline|online|api`',
    `provider` STRING COMMENT 'Entity that issued or generated the token.. Valid values are `visa|mastercard|discover|amex|internal`',
    `scope` STRING COMMENT 'Defines whether the token can be used once or multiple times.. Valid values are `single_use|multiple_use`',
    `secure_value` DECIMAL(18,2) COMMENT 'PCI‑compliant token that replaces the original PAN for transaction processing.',
    `token_status` STRING COMMENT 'Current lifecycle status of the token.. Valid values are `active|inactive|revoked|suspended`',
    `token_type` STRING COMMENT 'Indicates whether the token is a network‑issued token or a platform‑generated token.. Valid values are `network|platform`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the token record.',
    `usage_count` BIGINT COMMENT 'Cumulative number of times the token has been used in successful transactions.',
    `version` STRING COMMENT 'Version identifier for the token format or schema.',
    CONSTRAINT pk_token PRIMARY KEY(`token_id`)
) COMMENT 'PCI DSS-compliant tokenization registry mapping sensitive payment card data (PAN) to platform-generated tokens used in transaction processing. Stores token value, token type (network token vs. platform token), associated payment method reference, tokenization provider (Visa Token Service, Mastercard MDES, internal vault), token status, and expiry. Ensures raw card data never persists in application systems.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `ecommerce_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `ecommerce_ecm`.`payment`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_reconciliation_id` FOREIGN KEY (`reconciliation_id`) REFERENCES `ecommerce_ecm`.`payment`.`reconciliation`(`reconciliation_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `ecommerce_ecm`.`payment`.`settlement`(`settlement_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_token_id` FOREIGN KEY (`token_id`) REFERENCES `ecommerce_ecm`.`payment`.`token`(`token_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_method_id` FOREIGN KEY (`method_id`) REFERENCES `ecommerce_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ADD CONSTRAINT `fk_payment_payment_transaction_wallet_id` FOREIGN KEY (`wallet_id`) REFERENCES `ecommerce_ecm`.`payment`.`wallet`(`wallet_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `ecommerce_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `ecommerce_ecm`.`payment`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_method_id` FOREIGN KEY (`method_id`) REFERENCES `ecommerce_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ADD CONSTRAINT `fk_payment_authorization_token_id` FOREIGN KEY (`token_id`) REFERENCES `ecommerce_ecm`.`payment`.`token`(`token_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ADD CONSTRAINT `fk_payment_settlement_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `ecommerce_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ADD CONSTRAINT `fk_payment_settlement_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `ecommerce_ecm`.`payment`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ADD CONSTRAINT `fk_payment_settlement_reconciliation_id` FOREIGN KEY (`reconciliation_id`) REFERENCES `ecommerce_ecm`.`payment`.`reconciliation`(`reconciliation_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_method_id` FOREIGN KEY (`method_id`) REFERENCES `ecommerce_ecm`.`payment`.`method`(`method_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ADD CONSTRAINT `fk_payment_payment_refund_settlement_id` FOREIGN KEY (`settlement_id`) REFERENCES `ecommerce_ecm`.`payment`.`settlement`(`settlement_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `ecommerce_ecm`.`payment`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ADD CONSTRAINT `fk_payment_chargeback_payment_transaction_id` FOREIGN KEY (`payment_transaction_id`) REFERENCES `ecommerce_ecm`.`payment`.`payment_transaction`(`payment_transaction_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ADD CONSTRAINT `fk_payment_fraud_case_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `ecommerce_ecm`.`payment`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ADD CONSTRAINT `fk_payment_merchant_account_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `ecommerce_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ADD CONSTRAINT `fk_payment_reconciliation_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `ecommerce_ecm`.`payment`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ADD CONSTRAINT `fk_payment_wallet_gateway_id` FOREIGN KEY (`gateway_id`) REFERENCES `ecommerce_ecm`.`payment`.`gateway`(`gateway_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ADD CONSTRAINT `fk_payment_token_merchant_account_id` FOREIGN KEY (`merchant_account_id`) REFERENCES `ecommerce_ecm`.`payment`.`merchant_account`(`merchant_account_id`);
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ADD CONSTRAINT `fk_payment_token_method_id` FOREIGN KEY (`method_id`) REFERENCES `ecommerce_ecm`.`payment`.`method`(`method_id`);

-- ========= TAGS =========
ALTER SCHEMA `ecommerce_ecm`.`payment` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `ecommerce_ecm`.`payment` SET TAGS ('dbx_domain' = 'payment');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction ID (PTID)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (ORDER_ID)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `marketplace_promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Promotion Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MERCH_ID)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `token_id` SET TAGS ('dbx_business_glossary_term' = 'Token Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Tokenized Payment Method Identifier (TOKEN_ID)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `method_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `method_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `amount_fee` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Amount (AMT_FEE)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `amount_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `amount_fee` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Transaction Amount (AMT_GROSS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `amount_gross` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `amount_gross` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Transaction Amount (AMT_NET)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `amount_net` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `amount_net` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `amount_tax` SET TAGS ('dbx_business_glossary_term' = 'Transaction Tax Amount (AMT_TAX)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `amount_tax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `amount_tax` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code (AUTH_CODE)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `authorization_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand (CARD_BRAND)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_brand` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_expiry_month` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Month (CARD_EXP_MONTH)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_expiry_month` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_expiry_month` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_expiry_year` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Year (CARD_EXP_YEAR)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_expiry_year` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_expiry_year` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_last4` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits (CARD_LAST4)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_last4` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_last4` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `card_last4` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `chargeback_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Flag (CHARGEBACK_FLAG)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `compliance_flags` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flags (COMPLIANCE_FLAGS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `compliance_flags` SET TAGS ('dbx_value_regex' = 'pci_dss|psd2_sca|gdpr|none');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier (DEVICE_ID)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Applied (EXCH_RATE)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score (FRAUD_SCORE)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `gateway_response_code` SET TAGS ('dbx_business_glossary_term' = 'Gateway Response Code (GW_RESP_CODE)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `gateway_response_message` SET TAGS ('dbx_business_glossary_term' = 'Gateway Response Message (GW_RESP_MSG)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `identifier` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier (TXN_ID)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address of Transaction Origin (IP_ADDR)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Recurring Transaction Indicator (IS_RECURRING)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel (PAY_CHANNEL)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|in_app|pos|api');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|bank_transfer|paypal|apple_pay|google_pay');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_transaction_description` SET TAGS ('dbx_business_glossary_term' = 'Transaction Description (TXN_DESC)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Lifecycle Status (TXN_STATUS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `payment_transaction_status` SET TAGS ('dbx_value_regex' = 'authorized|captured|settled|voided|failed|refunded');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `recurring_cycle` SET TAGS ('dbx_business_glossary_term' = 'Recurring Cycle (RECURRING_CYCLE)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `recurring_cycle` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|yearly');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `recurring_end_date` SET TAGS ('dbx_business_glossary_term' = 'Recurring End Date (RECURRING_END_DATE)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount (REFUND_AMT)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `refund_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `refund_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp (REFUND_TS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Level (RISK_ASSESSMENT)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date (SETTLEMENT_DATE)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status (SETTLEMENT_STATUS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Event Timestamp (TXN_TS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` SET TAGS ('dbx_subdomain' = 'instrument_registry');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Method Identifier');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Customer Address Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CID)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `card_network` SET TAGS ('dbx_business_glossary_term' = 'Card Network (Network)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `card_network` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `cardholder_email` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Email Address (Cardholder Email)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `cardholder_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `cardholder_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `cardholder_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Full Name (Cardholder Name)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `cardholder_phone` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Phone Number (Cardholder Phone)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `cardholder_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `cardholder_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `compliance_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Timestamp (Compliance TS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (Compliance)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created TS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `daily_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit Amount (Daily Limit)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `expiry_month` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Month (ExpMonth)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `expiry_year` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Year (ExpYear)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score (Fraud Score)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Payment Method Flag (Default Flag)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `is_international_allowed` SET TAGS ('dbx_business_glossary_term' = 'International Payments Allowed Flag (International Allowed)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `is_one_time_allowed` SET TAGS ('dbx_business_glossary_term' = 'One-Time Payments Allowed Flag (One-Time Allowed)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `is_recurring_allowed` SET TAGS ('dbx_business_glossary_term' = 'Recurring Payments Allowed Flag (Recurring Allowed)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `issuing_bank` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Name (Bank)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits (Last4)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `last_four` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `last_four` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp (Last Used TS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `method_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Description (Description)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `method_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Status (PM Status)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `method_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|suspended|deleted');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type (PMT)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `method_type` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|digital_wallet|bank_account|bnpl|gift_card');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `monthly_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Transaction Limit Amount (Monthly Limit)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `payment_method_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Nickname (Nickname)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `preference_rank` SET TAGS ('dbx_business_glossary_term' = 'Preference Rank (Pref Rank)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level (Risk)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `sca_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Strong Customer Authentication Enrolled (SCA Enrolled)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `token_reference` SET TAGS ('dbx_business_glossary_term' = 'Tokenized Payment Instrument Reference (Token Ref)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `token_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `token_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `tokenization_provider` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Provider (Token Provider)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `transaction_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Per Transaction Limit Amount (Txn Limit)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (Updated TS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status (Verification)');
ALTER TABLE `ecommerce_ecm`.`payment`.`method` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Authorization ID');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `marketplace_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant ID');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Method Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `token_id` SET TAGS ('dbx_business_glossary_term' = 'Token Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `auth_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorization Amount (USD)');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `auth_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'authorized|declined|voided|expired|captured|refunded');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `avs_result` SET TAGS ('dbx_business_glossary_term' = 'Address Verification Service Result');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `avs_result` SET TAGS ('dbx_value_regex' = 'matched|partial|no_match|not_checked');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code (ISO 3166‑1 Alpha‑3)');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|GBR|DEU|FRA|JPN');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `card_expiry_month` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Month');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `card_expiry_year` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Year');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `challenge_status` SET TAGS ('dbx_business_glossary_term' = '3‑DS Challenge Status');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `challenge_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_value_regex' = 'PCI_DSS|PSD2|GDPR');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `cvv_result` SET TAGS ('dbx_business_glossary_term' = 'Card Verification Value Result');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `cvv_result` SET TAGS ('dbx_value_regex' = 'matched|no_match|not_checked');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `cvv_result` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `cvv_result` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `decline_reason` SET TAGS ('dbx_business_glossary_term' = 'Decline Reason');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `hold_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Hold Expiry Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `is_captured` SET TAGS ('dbx_business_glossary_term' = 'Captured Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `is_partial_capture_allowed` SET TAGS ('dbx_business_glossary_term' = 'Partial Capture Allowed Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `is_refunded` SET TAGS ('dbx_business_glossary_term' = 'Refunded Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `is_test_transaction` SET TAGS ('dbx_business_glossary_term' = 'Test Transaction Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Voided Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_value_regex' = '^d{4}$');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `original_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Original Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|in_store|api');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|bank_transfer|digital_wallet|paypal|apple_pay');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `processing_latency_ms` SET TAGS ('dbx_business_glossary_term' = 'Processing Latency (ms)');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `three_ds_result` SET TAGS ('dbx_business_glossary_term' = '3‑Domain Secure Result');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `three_ds_result` SET TAGS ('dbx_value_regex' = 'success|failure|challenge_required|not_supported');
ALTER TABLE `ecommerce_ecm`.`payment`.`authorization` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement ID');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Bank Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account ID');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `acquiring_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank ID');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `assessment_fee` SET TAGS ('dbx_business_glossary_term' = 'Assessment Fee');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `audit_user` SET TAGS ('dbx_business_glossary_term' = 'Audit User');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `cross_border_fee` SET TAGS ('dbx_business_glossary_term' = 'Cross‑Border Fee');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `currency_conversion_fee` SET TAGS ('dbx_business_glossary_term' = 'Currency Conversion Fee');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `cycle` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `cycle` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `fee_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fee Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `gateway_fee` SET TAGS ('dbx_business_glossary_term' = 'Gateway Fee');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `interchange_fee` SET TAGS ('dbx_business_glossary_term' = 'Interchange Fee');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `is_manual_settlement` SET TAGS ('dbx_business_glossary_term' = 'Manual Settlement Indicator');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `processing_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Rate');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `settlement_description` SET TAGS ('dbx_business_glossary_term' = 'Settlement Description');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'ach|wire|card|paypal');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Number');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed|reversed');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'batch|individual');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `status_detail` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status Detail');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Settlement Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Transaction Count');
ALTER TABLE `ecommerce_ecm`.`payment`.`settlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` SET TAGS ('dbx_subdomain' = 'dispute_management');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `payment_refund_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Refund Identifier (REFUND_ID)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `coupon_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon Redemption Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `logistics_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Method Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `promotion_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Rule Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `promotional_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `proof_of_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Proof Of Delivery Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization Identifier (RMA_ID)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `service_refund_id` SET TAGS ('dbx_business_glossary_term' = 'Service Refund Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Gross Amount (REF_GROSS_AMT)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATE_TS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR_CODE)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Fee Amount (REF_FEE_AMT)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `fraud_check_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Check Status (FRAUD_STATUS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `fraud_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Initiated Timestamp (REF_INIT_TS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `is_fraud` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag (IS_FRAUD)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Net Amount (REF_NET_AMT)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Refund Notes (REF_NOTES)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel (PAY_CHANNEL)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|api|in_store');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|paypal|bank_transfer|gift_card|apple_pay');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `payment_refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status (REF_STATUS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `payment_refund_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|processed|failed|cancelled');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `processing_fee` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Amount (PROC_FEE_AMT)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code (REF_REASON_CD)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'product_defect|customer_change_of_mind|shipping_error|price_adjustment|fraud|other');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Refund Reference Number (REF_NUM)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method (REF_METHOD)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'original|store_credit|gift_card|bank_transfer');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_business_glossary_term' = 'Refund Type (REF_TYPE)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_value_regex' = 'full|partial');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `request_source` SET TAGS ('dbx_business_glossary_term' = 'Refund Request Source (REQ_SOURCE)');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `request_source` SET TAGS ('dbx_value_regex' = 'customer_service|self_service|automated');
ALTER TABLE `ecommerce_ecm`.`payment`.`payment_refund` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATE_TS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` SET TAGS ('dbx_subdomain' = 'dispute_management');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Identifier');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Identifier');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Shipment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `payment_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Identifier');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `proof_of_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Proof Of Delivery Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Support Case Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Record Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `amount_fee` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Fee Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Chargeback Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `amount_original` SET TAGS ('dbx_business_glossary_term' = 'Original Dispute Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `card_last4` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `card_last4` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `card_last4` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Status');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_value_regex' = 'open|pending|won|lost|closed|reversed');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `dispute_category` SET TAGS ('dbx_business_glossary_term' = 'Dispute Category');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `dispute_category` SET TAGS ('dbx_value_regex' = 'fraud|authorization_error|processing_error|service_issue|goods_not_received|duplicate');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `dispute_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Dispute Subcategory');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `dispute_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Event Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `dispute_type` SET TAGS ('dbx_value_regex' = 'cardholder|merchant|issuer');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `evidence_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Submission Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `evidence_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Evidence Submitted Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `fee` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Processing Fee');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `is_fraudulent_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraudulent Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `liability_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `liability_party` SET TAGS ('dbx_business_glossary_term' = 'Liability Party');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `liability_party` SET TAGS ('dbx_value_regex' = 'merchant|cardholder|issuer');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `merchant_location_city` SET TAGS ('dbx_business_glossary_term' = 'Merchant City');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `merchant_location_country` SET TAGS ('dbx_business_glossary_term' = 'Merchant Country Code');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Outcome');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'won|lost|accepted|reversed');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|in_store|api');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|bank_transfer|digital_wallet|gift_card');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reason Code');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reason Description');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `ecommerce_ecm`.`payment`.`chargeback` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` SET TAGS ('dbx_subdomain' = 'dispute_management');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `fraud_case_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Identifier (FCID)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator Identifier (IID)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `coupon_id` SET TAGS ('dbx_business_glossary_term' = 'Coupon Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Address Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `fulfillment_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Shipment Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (OID)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `marketplace_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Transaction Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier (MID)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `promotional_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `seller_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Profile Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `support_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Support Case Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Fraud Case Number (FCN)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status (CS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|closed|escalated|false_positive');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `detection_source` SET TAGS ('dbx_business_glossary_term' = 'Detection Source (DS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `detection_source` SET TAGS ('dbx_value_regex' = 'rule_engine|machine_learning|manual_review|external_alert|partner_feed');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp (DT)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint (DF)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `fraud_amount` SET TAGS ('dbx_business_glossary_term' = 'Fraud Amount (FA)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `fraud_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `fraud_type` SET TAGS ('dbx_business_glossary_term' = 'Fraud Type (FT)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `fraud_type` SET TAGS ('dbx_value_regex' = 'cnp|account_takeover|friendly_fraud|synthetic_identity|chargeback_fraud|other');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `geo_country_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Country Code (GCC)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `investigation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Timestamp (IET)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `investigation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Timestamp (IST)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Investigator Name (IN)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `investigator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address (IP)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `is_high_risk` SET TAGS ('dbx_business_glossary_term' = 'High Risk Flag (HRF)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes (IN)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `processing_fee` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee (PF)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `processing_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount (RA)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome (RO)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'confirmed_fraud|false_positive|investigation_closed|escalated|pending');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `rule_action` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Action (FRA)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `rule_action` SET TAGS ('dbx_value_regex' = 'block|review|allow|challenge');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `rule_activation_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Activation Status (RAS)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `rule_activation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Name (FRN)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `rule_priority` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Priority (FRP)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Timestamp (OTT)');
ALTER TABLE `ecommerce_ecm`.`payment`.`fraud_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` SET TAGS ('dbx_subdomain' = 'instrument_registry');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Identifier');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `api_version` SET TAGS ('dbx_business_glossary_term' = 'API Version');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `compliance_gdpr` SET TAGS ('dbx_business_glossary_term' = 'GDPR Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `compliance_iso27001` SET TAGS ('dbx_business_glossary_term' = 'ISO 27001 Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `compliance_pci_dss` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `endpoint_url` SET TAGS ('dbx_business_glossary_term' = 'Gateway Endpoint URL');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `failover_priority` SET TAGS ('dbx_business_glossary_term' = 'Failover Priority');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `fraud_detection_enabled` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_description` SET TAGS ('dbx_business_glossary_term' = 'Gateway Description');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_name` SET TAGS ('dbx_business_glossary_term' = 'Gateway Name');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_status` SET TAGS ('dbx_business_glossary_term' = 'Gateway Status');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|decommissioned');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_type` SET TAGS ('dbx_business_glossary_term' = 'Gateway Type');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `gateway_type` SET TAGS ('dbx_value_regex' = 'payment|bank|alternative|crypto');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `is_3d_secure_enabled` SET TAGS ('dbx_business_glossary_term' = '3‑D Secure Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `is_multi_currency_supported` SET TAGS ('dbx_business_glossary_term' = 'Multi‑Currency Support Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `is_tokenization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Enabled Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `last_tested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Tested Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `max_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transaction Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `min_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transaction Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Gateway Notes');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `processing_region` SET TAGS ('dbx_business_glossary_term' = 'Processing Region');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `processing_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `provider_code` SET TAGS ('dbx_business_glossary_term' = 'Gateway Provider Code');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Gateway Provider Name');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `routing_logic` SET TAGS ('dbx_business_glossary_term' = 'Routing Logic Description');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `settlement_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle (Days)');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `sla_response_time_ms` SET TAGS ('dbx_business_glossary_term' = 'SLA Response Time (ms)');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `sla_uptime_percent` SET TAGS ('dbx_business_glossary_term' = 'SLA Uptime Percentage');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `supported_currencies` SET TAGS ('dbx_business_glossary_term' = 'Supported Currencies');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `supported_payment_methods` SET TAGS ('dbx_business_glossary_term' = 'Supported Payment Methods');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `supports_chargebacks` SET TAGS ('dbx_business_glossary_term' = 'Chargebacks Support Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `supports_partial_refunds` SET TAGS ('dbx_business_glossary_term' = 'Partial Refunds Support Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `supports_recurring` SET TAGS ('dbx_business_glossary_term' = 'Recurring Payments Support Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `supports_refunds` SET TAGS ('dbx_business_glossary_term' = 'Refunds Support Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Gateway Test Status');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|unknown');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `transaction_fee_fixed` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fixed Fee');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `transaction_fee_percent` SET TAGS ('dbx_business_glossary_term' = 'Transaction Fee Percentage');
ALTER TABLE `ecommerce_ecm`.`payment`.`gateway` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` SET TAGS ('dbx_subdomain' = 'instrument_registry');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account ID');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `marketplace_id` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'acquiring|processor|gateway');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `acquiring_bank_code` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Identifier');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `acquiring_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank Name');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `chargeback_fee_fixed` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Fixed Fee');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `chargeback_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Fee Rate');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `compliance_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Date');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `compliance_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Status');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `compliance_audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `daily_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Transaction Limit');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `daily_volume_limit` SET TAGS ('dbx_business_glossary_term' = 'Daily Volume Limit (currency)');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `fraud_detection_enabled` SET TAGS ('dbx_business_glossary_term' = 'Fraud Detection Enabled');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `is_multi_currency` SET TAGS ('dbx_business_glossary_term' = 'Multi-Currency Support Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `is_test_account` SET TAGS ('dbx_business_glossary_term' = 'Test Account Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `last_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Settlement Date');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `merchant_account_number` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Number (MA Number)');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `merchant_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `merchant_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `merchant_account_status` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Status');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `merchant_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `merchant_category_code` SET TAGS ('dbx_business_glossary_term' = 'Merchant Category Code (MCC)');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `monthly_transaction_limit` SET TAGS ('dbx_business_glossary_term' = 'Monthly Transaction Limit');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `monthly_volume_limit` SET TAGS ('dbx_business_glossary_term' = 'Monthly Volume Limit (currency)');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `payment_network` SET TAGS ('dbx_business_glossary_term' = 'Payment Network (e.g., Visa, MasterCard)');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `pci_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance Status');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `pci_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `processing_currency` SET TAGS ('dbx_business_glossary_term' = 'Processing Currency (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `processing_fee_fixed` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Fixed Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `processing_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Rate (percentage)');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `settlement_bank_account` SET TAGS ('dbx_business_glossary_term' = 'Settlement Bank Account Number');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `settlement_bank_account` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `settlement_bank_account` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `settlement_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Settlement Bank Name');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `settlement_bank_swift_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Bank SWIFT Code');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `settlement_bank_swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `settlement_bank_swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `supported_currencies` SET TAGS ('dbx_business_glossary_term' = 'Supported Currencies List');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `tokenization_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Enabled');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Method');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `tokenization_method` SET TAGS ('dbx_value_regex' = 'single_use|multi_use|none');
ALTER TABLE `ecommerce_ecm`.`payment`.`merchant_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation ID');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Bank Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `finance_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Account Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `exception_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Code');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `matched_line_count` SET TAGS ('dbx_business_glossary_term' = 'Matched Line Count');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period End Date');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period Start Date');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_number` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Number');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'open|reconciled|exception|pending');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Run Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Run Type');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'daily|monthly|ad_hoc');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `total_external_amount` SET TAGS ('dbx_business_glossary_term' = 'Total External Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `total_internal_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Internal Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `total_line_count` SET TAGS ('dbx_business_glossary_term' = 'Total Line Count');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `unmatched_line_count` SET TAGS ('dbx_business_glossary_term' = 'Unmatched Line Count');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`reconciliation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` SET TAGS ('dbx_subdomain' = 'instrument_registry');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `wallet_id` SET TAGS ('dbx_business_glossary_term' = 'Wallet ID');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `customer_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Customer ID');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Gateway Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `balance` SET TAGS ('dbx_business_glossary_term' = 'Wallet Balance');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `compliance_token` SET TAGS ('dbx_business_glossary_term' = 'Compliance Token');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `compliance_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `compliance_token` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wallet Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Wallet Expiration Date');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `is_default_wallet` SET TAGS ('dbx_business_glossary_term' = 'Default Wallet Indicator');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `last_topup_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Top‑Up Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `last_topup_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `last_transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `last_withdrawal_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Withdrawal Amount');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `last_withdrawal_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `pending_balance` SET TAGS ('dbx_business_glossary_term' = 'Pending Balance');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `pending_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `total_credits` SET TAGS ('dbx_business_glossary_term' = 'Total Credits');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `total_credits` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `total_debits` SET TAGS ('dbx_business_glossary_term' = 'Total Debits');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `total_debits` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Wallet Transaction Count');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Wallet Last Updated Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `wallet_name` SET TAGS ('dbx_business_glossary_term' = 'Wallet Name');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `wallet_number` SET TAGS ('dbx_business_glossary_term' = 'Wallet Number');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `wallet_status` SET TAGS ('dbx_business_glossary_term' = 'Wallet Status');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `wallet_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `wallet_type` SET TAGS ('dbx_business_glossary_term' = 'Wallet Type');
ALTER TABLE `ecommerce_ecm`.`payment`.`wallet` ALTER COLUMN `wallet_type` SET TAGS ('dbx_value_regex' = 'store_credit|loyalty_points|prepaid|gift|promo');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` SET TAGS ('dbx_subdomain' = 'instrument_registry');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `token_id` SET TAGS ('dbx_business_glossary_term' = 'Token Identifier');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Merchant Identifier');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Identifier');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `audit_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Log Identifier');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `compliance_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Status');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `encryption_key_reference` SET TAGS ('dbx_business_glossary_term' = 'Encryption Key Identifier');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Token Expiry Date');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Token Format');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Hash Algorithm');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_value_regex' = 'sha256|sha384|sha512');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `is_test` SET TAGS ('dbx_business_glossary_term' = 'Test Token Flag');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Token Issuance Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `length` SET TAGS ('dbx_business_glossary_term' = 'Token Length');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Tokenization Method');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `method` SET TAGS ('dbx_value_regex' = 'offline|online|api');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `provider` SET TAGS ('dbx_business_glossary_term' = 'Token Provider');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `provider` SET TAGS ('dbx_value_regex' = 'visa|mastercard|discover|amex|internal');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Token Scope');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'single_use|multiple_use');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `secure_value` SET TAGS ('dbx_business_glossary_term' = 'Secure Token Value (PCI Token)');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `secure_value` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `secure_value` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `token_status` SET TAGS ('dbx_business_glossary_term' = 'Token Status');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `token_status` SET TAGS ('dbx_value_regex' = 'active|inactive|revoked|suspended');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `token_type` SET TAGS ('dbx_business_glossary_term' = 'Token Type');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `token_type` SET TAGS ('dbx_value_regex' = 'network|platform');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Token Usage Count');
ALTER TABLE `ecommerce_ecm`.`payment`.`token` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Token Version');
