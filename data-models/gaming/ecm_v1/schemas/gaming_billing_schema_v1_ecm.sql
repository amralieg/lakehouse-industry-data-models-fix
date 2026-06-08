-- Schema for Domain: billing | Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:01

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`billing` COMMENT 'Single source of truth for all financial transactions, payment processing, invoices, refunds, chargebacks, and revenue recognition across storefronts (Steam, Epic, console first-party, mobile app stores). Owns PCI DSS-compliant payment instrument records, payout settlements with platform holders, and subscription billing cycles. Distinct from monetization: monetization owns virtual economy design; billing owns the real-money settlement layer.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice. Primary key for the invoice entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue invoices are attributed to cost centers (studio/title) for internal P&L reporting and budget variance analysis. Gaming finance teams track revenue by cost center to measure title profitability',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Manual invoice creation (credits, adjustments, enterprise billing) requires audit trail of the billing operations employee who created it for SOX compliance, dispute resolution, and internal controls.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Royalty invoices are issued under specific IP licensing agreements. Links invoice to governing agreement terms for royalty billing, reconciliation, and audit. Essential for royalty revenue recognition',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Invoices must track tax jurisdiction for VAT/sales tax filing and audit compliance. Gaming platforms operate globally with complex tax nexus rules. Replaces denormalized tax_jurisdiction_code with pro',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Invoices must be issued by a legal entity for tax compliance, VAT/sales tax reporting, and consolidated financial statements. Gaming companies operate multiple legal entities across jurisdictions; inv',
    `payment_id` BIGINT COMMENT 'External payment processor transaction identifier linking this invoice to the actual payment settlement. Used for payment reconciliation and chargeback tracking. Null if invoice is unpaid.',
    `player_account_id` BIGINT COMMENT 'Identifier of the player to whom this invoice is issued. Links to the player master for customer billing and payment history.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address for the invoice recipient. Required for tax jurisdiction determination and payment processing compliance.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (apartment, suite, unit number). Optional address component for complete billing address capture.',
    `billing_city` STRING COMMENT 'City component of the billing address. Used for tax jurisdiction determination and geographic revenue reporting.',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period covered by this invoice. Defines the close of the billing cycle for subscription and recurring charges.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period covered by this invoice. Used for subscription billing cycles and recurring revenue recognition.',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code of the billing address. Used for tax jurisdiction determination and payment fraud detection.',
    `billing_state_province` STRING COMMENT 'State or province component of the billing address. Critical for US state sales tax and Canadian provincial tax calculations.',
    `chargeback_flag` BOOLEAN COMMENT 'Indicates whether this invoice was subject to a payment chargeback initiated by the cardholder or payment processor. True if chargeback occurred; false otherwise. Critical for fraud detection and payment risk management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was first created in the billing system. Audit field for data lineage and compliance tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this invoice. Critical for multi-currency revenue reporting and foreign exchange reconciliation.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to this invoice, including promotional discounts, volume discounts, early payment discounts, or platform-specific adjustments. Reduces the net amount due.',
    `dispute_reason_code` STRING COMMENT 'Code identifying the reason for invoice dispute if status is disputed (e.g., unauthorized charge, service not delivered, billing error, pricing discrepancy). Null if no dispute. Used for customer service escalation and fraud pattern analysis.',
    `due_date` DATE COMMENT 'Date by which payment is expected per the agreed payment terms. Used for accounts receivable aging and overdue invoice identification.',
    `invoice_date` DATE COMMENT 'Date the invoice was formally issued to the customer or platform partner. Serves as the baseline for payment terms and aging calculations.',
    `invoice_number` STRING COMMENT 'Externally-visible unique invoice number issued to the player or platform partner. Human-readable business identifier used for customer service, accounting reconciliation, and dispute resolution.. Valid values are `^INV-[0-9]{8,12}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice. Tracks progression from draft through issuance, payment, or dispute resolution. Critical for accounts receivable aging and revenue recognition workflows.. Valid values are `draft|issued|paid|void|disputed|overdue`',
    `invoice_type` STRING COMMENT 'Classification of invoice document type. Standard invoices represent normal sales; credit memos represent refunds or adjustments; debit memos represent additional charges; proforma invoices are estimates; recurring invoices are for subscription billing cycles.. Valid values are `standard|credit_memo|debit_memo|proforma|recurring`',
    `notes` STRING COMMENT 'Free-text notes or comments related to this invoice. May include special billing instructions, customer service annotations, or accounting adjustments. Used for audit trail and customer communication context.',
    `paid_date` DATE COMMENT 'Date the invoice was fully paid. Null if invoice is unpaid or partially paid. Used for cash flow analysis and Days Sales Outstanding (DSO) calculations.',
    `payment_channel` STRING COMMENT 'Interface or channel through which the payment was initiated. Distinct from payment method; tracks the user experience touchpoint for conversion funnel analysis and channel-specific revenue attribution.. Valid values are `web|mobile_app|console|in_game|customer_service|platform_direct`',
    `payment_method` STRING COMMENT 'Payment instrument type used or expected for this invoice. Identifies the financial instrument (credit card, PayPal, bank transfer, platform wallet, etc.) for PCI DSS (Payment Card Industry Data Security Standard) compliance tracking and payment processing reconciliation. [ENUM-REF-CANDIDATE: credit_card|debit_card|paypal|bank_transfer|platform_wallet|gift_card|cryptocurrency — 7 candidates stripped; promote to reference product]',
    `payment_terms` STRING COMMENT 'Contractual payment terms defining the period within which payment is due. Immediate means payment on receipt; net_X means payment due X days after invoice date.. Valid values are `immediate|net_15|net_30|net_45|net_60|net_90`',
    `platform_fee_amount` DECIMAL(18,2) COMMENT 'Total platform commission or distribution fee charged by the storefront (e.g., 30% Apple App Store fee, 12% Epic Games Store fee). Deducted from gross revenue to calculate net payout to the studio.',
    `platform_partner_code` BIGINT COMMENT 'Identifier of the platform partner (Steam, Epic, console first-party, mobile app store) for B2B invoices related to revenue share settlements and payout reconciliation. Null for direct player invoices.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total amount refunded to the customer if this invoice was partially or fully refunded. Zero if no refund issued. Tracked separately from credit memos for chargeback and dispute analysis.',
    `revenue_recognition_category` STRING COMMENT 'Accounting classification determining when and how revenue from this invoice is recognized per ASC 606 / IFRS 15 standards. Immediate for one-time purchases; deferred for DLC (Downloadable Content) or season passes; subscription for recurring GaaS (Game as a Service) revenue; usage-based for consumption models; milestone for performance-based contracts.. Valid values are `immediate|deferred|subscription|usage_based|milestone`',
    `storefront_code` STRING COMMENT 'Code identifying the digital storefront or distribution channel where the transaction originated. Critical for revenue attribution and platform-specific reconciliation. [ENUM-REF-CANDIDATE: STEAM|EPIC|PSN|XBOX|NINTENDO|APPLE|GOOGLE|DIRECT — 8 candidates stripped; promote to reference product]',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item amounts before taxes, fees, and discounts. Base amount for revenue recognition calculations.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to this invoice, including sales tax, VAT (Value-Added Tax), GST (Goods and Services Tax), or other jurisdiction-specific taxes. Sum of all line-level tax amounts.',
    `tax_exemption_code` STRING COMMENT 'Code indicating tax exemption status if applicable (e.g., non-profit organization, educational institution, tax-exempt jurisdiction). Null if no exemption applies.',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'Effective tax rate percentage applied to this invoice. Composite rate if multiple tax types apply (e.g., state + local sales tax, or VAT).',
    `total_amount` DECIMAL(18,2) COMMENT 'Final invoice total after applying subtotal, taxes, discounts, and fees. This is the net amount due from the customer or platform partner. Used for payment reconciliation and revenue recognition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was last modified. Tracks changes to invoice status, amounts, or payment information for audit and reconciliation purposes.',
    `voided_reason` STRING COMMENT 'Explanation for why this invoice was voided (e.g., billing error, duplicate invoice, customer cancellation, fraud). Null if invoice has not been voided. Required for financial audit and compliance reporting.',
    `voided_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice was voided or cancelled. Null if invoice has not been voided. Used for audit trail and revenue reversal tracking.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Master billing document representing a formal request for payment issued to a player or platform partner. Captures invoice number, billing period, total amount, currency, tax breakdown, storefront origin, invoice status (draft, issued, paid, void, disputed), due date, payment terms, and embedded line-item detail (SKU reference, product type, quantity, unit price, line total, tax amount, discount applied, revenue recognition category). SSOT for all real-money billing documents and their granular line breakdowns across storefronts and subscription cycles.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key for this entity.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Invoice lines track which content drop/DLC release a purchase belongs to. Critical for launch revenue tracking, content drop P&L reporting, and measuring commercial success of major content releases a',
    `game_studio_id` BIGINT COMMENT 'Reference to the development studio responsible for the product sold on this line. Used for studio-level revenue attribution and royalty calculations.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title or Intellectual Property (IP) this line item is associated with. Used for title-level revenue reporting and Profit and Loss (P&L) analysis.',
    `iap_transaction_id` BIGINT COMMENT 'Foreign key linking to monetization.iap_transaction. Business justification: Invoice lines for IAP purchases need transaction linkage for refund reconciliation, entitlement revocation, and chargeback dispute resolution. Financial operations require tracing invoice lines to ori',
    `invoice_id` BIGINT COMMENT 'Reference to the parent invoice header that contains this line item. Links this line to the overall billing transaction.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Invoice lines itemize specific licensed IP usage (engine licenses, middleware components, music tracks, brand assets). Enables IP-specific revenue recognition, royalty calculation, and usage-based bil',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that drove this purchase. Used to calculate Return on Ad Spend (ROAS) and campaign effectiveness. Null if purchase was organic.',
    `player_account_id` BIGINT COMMENT 'Unique identifier for the player who made this purchase. Links billing transactions to player behavior analytics and Lifetime Value (LTV) calculations.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Invoice lines itemize sales per storefront for multi-platform publishers. Required for storefront-specific revenue attribution, platform fee reconciliation, and regional tax compliance reporting.',
    `storefront_order_id` BIGINT COMMENT 'External transaction identifier provided by the platform or storefront (Steam order ID, Epic transaction ID, Apple receipt ID, Google order token). Used for reconciliation with platform payout reports.',
    `chargeback_amount` DECIMAL(18,2) COMMENT 'Amount reversed due to chargeback initiated by the payment card issuer. Zero if no chargeback has occurred. Expressed in the invoice currency.',
    `chargeback_date` DATE COMMENT 'Date when the chargeback was processed against this line item. Null if no chargeback has occurred.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line record was first created in the billing system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to this line item, including promotional discounts, coupon redemptions, loyalty rewards, or platform sale pricing. Expressed in the invoice currency.',
    `discount_code` STRING COMMENT 'Promotional code, coupon identifier, or campaign code applied to this line item. Null if no discount code was used.',
    `line_number` STRING COMMENT 'Sequential line number within the invoice, used for ordering and referencing individual line items on the invoice document.',
    `line_status` STRING COMMENT 'Current status of this invoice line item: active (valid charge), refunded (fully refunded), partially_refunded (partial refund issued), disputed (under dispute), or chargeback (payment reversed by card issuer).. Valid values are `active|refunded|partially_refunded|disputed|chargeback`',
    `line_total` DECIMAL(18,2) COMMENT 'Final total for this line item including all discounts and taxes: subtotal + tax_amount. This is the amount recognized for this line. Expressed in the invoice currency.',
    `list_price` DECIMAL(18,2) COMMENT 'Original catalog or storefront list price per unit before promotional discounts. Used to calculate discount percentage and promotional effectiveness.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line record was last modified. Updated when refunds, chargebacks, or status changes occur. Used for audit trail and change tracking.',
    `net_revenue` DECIMAL(18,2) COMMENT 'Net revenue after platform fees: line_total - platform_fee_amount. This is the amount the studio receives after platform revenue share. Expressed in the invoice currency.',
    `platform_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the distribution platform or storefront (e.g., 30% Apple/Google fee, Steam revenue share). Deducted from gross revenue to calculate net payout. Expressed in the invoice currency.',
    `platform_fee_rate` DECIMAL(18,2) COMMENT 'Platform fee rate expressed as a decimal (e.g., 0.3000 for 30% platform fee). Used for financial modeling and payout reconciliation.',
    `product_name` STRING COMMENT 'Human-readable name of the product or service sold on this line: game title, expansion pack name, subscription plan name, or virtual item bundle name.',
    `product_type` STRING COMMENT 'Category of the product sold: base game purchase, Downloadable Content (DLC), season pass, subscription period, In-App Purchase (IAP), virtual currency, cosmetic item, or battle pass. [ENUM-REF-CANDIDATE: base_game|dlc|season_pass|subscription|iap|virtual_currency|cosmetic|battle_pass — 8 candidates stripped; promote to reference product]',
    `quantity` STRING COMMENT 'Number of units of this Stock Keeping Unit (SKU) purchased on this line. Typically 1 for digital goods; may be greater than 1 for virtual currency bundles or multi-license purchases.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total amount refunded for this line item. Zero if no refund has been issued. Expressed in the invoice currency.',
    `refund_date` DATE COMMENT 'Date when the refund was processed for this line item. Null if no refund has been issued.',
    `refund_eligible_flag` BOOLEAN COMMENT 'Indicates whether this line item is eligible for refund based on platform policies (e.g., Steam 2-hour/14-day policy, Apple/Google refund windows). True if refundable, False if non-refundable.',
    `refund_window_end_date` DATE COMMENT 'Last date on which a refund can be requested for this line item per platform policy. Null if item is non-refundable or refund window has no expiration.',
    `revenue_recognition_category` STRING COMMENT 'Accounting treatment for revenue recognition: immediate (one-time purchase), deferred (season pass, pre-order), subscription (recurring), or usage-based (consumable virtual currency).. Valid values are `immediate|deferred|subscription|usage_based`',
    `revenue_recognition_end_date` DATE COMMENT 'Date when revenue recognition ends for this line item. Null for immediate recognition. For subscriptions or deferred items, marks the end of the recognition period.',
    `revenue_recognition_start_date` DATE COMMENT 'Date when revenue recognition begins for this line item. For immediate recognition, equals the invoice date. For deferred or subscription items, marks the start of the recognition period.',
    `sku` STRING COMMENT 'Product identifier representing the specific item sold: game title, Downloadable Content (DLC) pack, season pass, subscription tier, In-App Purchase (IAP) bundle, or virtual currency package.. Valid values are `^[A-Z0-9_-]{6,20}$`',
    `subscription_period_end_date` DATE COMMENT 'End date of the subscription billing period for subscription line items. Null for non-subscription purchases.',
    `subscription_period_start_date` DATE COMMENT 'Start date of the subscription billing period for subscription line items. Null for non-subscription purchases.',
    `subtotal` DECIMAL(18,2) COMMENT 'Line total after discounts but before taxes: (quantity × unit_price) - discount_amount. Expressed in the invoice currency.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to this line item, including sales tax, Value-Added Tax (VAT), Goods and Services Tax (GST), or other jurisdiction-specific taxes. Expressed in the invoice currency.',
    `tax_jurisdiction` STRING COMMENT 'Geographic tax jurisdiction code or name where the tax was assessed (e.g., state, province, country). Required for multi-jurisdiction tax reporting.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Effective tax rate applied to this line item, expressed as a decimal (e.g., 0.0750 for 7.5%). Used for tax reporting and reconciliation.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per single unit of the Stock Keeping Unit (SKU) before any discounts or taxes. Expressed in the invoice currency.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual line items on a billing invoice, representing discrete chargeable units such as a game title purchase, DLC pack, season pass, subscription period, or IAP bundle. Captures SKU reference, quantity, unit price, line total, tax amount, discount applied, and revenue recognition category. Enables granular revenue breakdown per storefront transaction.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction. Primary key for the payment entity.',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title for which the payment was made. Links to the game title master entity.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Links payments to specific licensing agreements for advance payments, milestone payments, minimum guarantees, and royalty payments. Enables agreement-specific payment tracking, recoupment calculation,',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Payments are received by specific legal entities; critical for cash management, bank reconciliation, and intercompany settlement. Gaming companies must track which legal entity received each payment f',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Tracks payments from/to licensees for royalties, license fees, minimum guarantees, and revenue shares. Essential for licensee payment reconciliation, cash application, and accounts receivable/payable ',
    `payment_instrument_id` BIGINT COMMENT 'Foreign key linking to billing.payment_instrument. Business justification: Payment transactions should reference the payment instrument used for the transaction. While payment captures point-in-time card details (card_last_four_digits, card_brand, expiry dates) as historical',
    `player_account_id` BIGINT COMMENT 'Identifier of the player who initiated the payment. Links to the player master entity.',
    `subscription_id` BIGINT COMMENT 'Identifier of the subscription if this payment is part of a recurring subscription billing cycle. Nullable for one-time purchases.',
    `amount` DECIMAL(18,2) COMMENT 'The gross payment amount received from the player before any fees, taxes, or adjustments. Represents the total real-money value of the transaction.',
    `authorization_code` STRING COMMENT 'The authorization code returned by the payment gateway or issuing bank confirming that the payment was approved. Used for reconciliation and dispute resolution.. Valid values are `^[A-Z0-9]{6,12}$`',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address associated with the payment method. Used for tax calculation and fraud detection.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'The postal or ZIP code of the billing address. Used for address verification (AVS) and fraud prevention.',
    `card_brand` STRING COMMENT 'The brand of the payment card used (e.g., Visa, Mastercard, American Express). Applicable only when payment method type is credit or debit card. [ENUM-REF-CANDIDATE: visa|mastercard|amex|discover|jcb|diners_club|unionpay — 7 candidates stripped; promote to reference product]',
    `card_expiry_month` STRING COMMENT 'The expiration month of the payment card (1-12). Used for subscription renewal validation and payment method expiry alerts.',
    `card_expiry_year` STRING COMMENT 'The expiration year of the payment card (four-digit year). Used for subscription renewal validation and payment method expiry alerts.',
    `card_last_four_digits` STRING COMMENT 'The last four digits of the payment card used for the transaction. PCI DSS-compliant - no full card number stored. Used for player reference and support.. Valid values are `^[0-9]{4}$`',
    `channel` STRING COMMENT 'The distribution channel or storefront through which the payment was processed. Distinct from payment method - this identifies the platform interface. [ENUM-REF-CANDIDATE: web|mobile_app|console|in_game|steam|epic_games_store|apple_app_store|google_play_store|playstation_store|xbox_store|nintendo_eshop — 11 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `device_fingerprint` STRING COMMENT 'A unique identifier or hash representing the device used to initiate the payment. Used for fraud detection and device-based analytics.',
    `fraud_review_status` STRING COMMENT 'The status of manual or automated fraud review for this payment. Indicates whether the payment has been cleared, flagged, or is pending investigation.. Valid values are `not_reviewed|approved|declined|pending_review|flagged`',
    `fraud_score` DECIMAL(18,2) COMMENT 'A risk score (0-100) assigned by the fraud detection system indicating the likelihood that this payment is fraudulent. Higher scores indicate higher risk.',
    `gateway_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged by the payment gateway or payment processor (e.g., Stripe, PayPal, Adyen) for processing the payment. Separate from platform fees.',
    `gateway_provider` STRING COMMENT 'The name of the payment gateway or payment processor that handled the transaction (e.g., Stripe, PayPal, Adyen, Braintree, platform-native processor).',
    `gateway_transaction_reference` STRING COMMENT 'The unique transaction identifier assigned by the payment gateway. Used for tracking, reconciliation, and support inquiries with the gateway provider.',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice associated with this payment. Links to the billing invoice entity for financial reconciliation.',
    `ip_address` STRING COMMENT 'The IP address from which the payment transaction was initiated. Used for fraud detection, geolocation analysis, and security auditing.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`',
    `is_test_transaction` BOOLEAN COMMENT 'Flag indicating whether this payment is a test transaction used for QA, UAT, or sandbox testing. Test transactions are excluded from revenue reporting.',
    `method_type` STRING COMMENT 'The type of payment instrument used by the player to complete the transaction (e.g., credit card, PayPal, platform wallet, gift card). [ENUM-REF-CANDIDATE: credit_card|debit_card|paypal|platform_wallet|gift_card|bank_transfer|mobile_payment|cryptocurrency — 8 candidates stripped; promote to reference product]',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'The net revenue amount received by the business after deducting platform fees, payment gateway fees, and taxes from the gross payment amount. This is the recognized revenue for financial reporting.',
    `payer_email` STRING COMMENT 'The email address of the payer as provided during the payment transaction. May differ from the player account email for gift purchases or third-party payments.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `payment_description` STRING COMMENT 'A human-readable description of the payment transaction, typically including the product name and purchase details. Used for player receipts and support inquiries.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Tracks the payment from authorization through settlement or failure. [ENUM-REF-CANDIDATE: pending|authorized|captured|settled|failed|declined|refunded|partially_refunded|chargeback — 9 candidates stripped; promote to reference product]',
    `payment_timestamp` TIMESTAMP COMMENT 'The exact date and time when the payment transaction was initiated by the player. This is the business event timestamp for revenue recognition and analytics.',
    `platform_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged by the distribution platform or storefront (Steam, Epic, Apple, Google, console first-party) for processing the transaction. Deducted from gross payment amount.',
    `purchase_type` STRING COMMENT 'The category of purchase made by the player (e.g., full game purchase, DLC, microtransaction, subscription, virtual currency). [ENUM-REF-CANDIDATE: game_purchase|dlc|mtx|subscription|season_pass|loot_box|battle_pass|virtual_currency — 8 candidates stripped; promote to reference product]',
    `refund_amount` DECIMAL(18,2) COMMENT 'The total amount refunded to the player if the payment was refunded or partially refunded. Nullable for non-refunded payments.',
    `refund_reason_code` STRING COMMENT 'The reason code for refund or chargeback if the payment status is refunded, partially refunded, or chargeback. Nullable for successful payments. [ENUM-REF-CANDIDATE: customer_request|duplicate_charge|fraud|technical_issue|policy_violation|chargeback|other — 7 candidates stripped; promote to reference product]',
    `refund_timestamp` TIMESTAMP COMMENT 'The date and time when the refund was processed. Nullable for non-refunded payments.',
    `settlement_timestamp` TIMESTAMP COMMENT 'The date and time when the payment was settled and funds were transferred to the merchant account. Nullable for pending or failed payments.',
    `sku` STRING COMMENT 'The SKU or product identifier for the item purchased (e.g., game, DLC, in-game currency pack, subscription tier). Links to the monetization catalog.. Valid values are `^[A-Z0-9_-]{4,32}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount collected as part of this payment, including sales tax, VAT, GST, or other applicable taxes based on player jurisdiction.',
    `three_ds_authentication_status` STRING COMMENT 'The status of 3D Secure authentication for this payment. Indicates whether the cardholder was successfully authenticated using 3DS protocol.. Valid values are `authenticated|not_authenticated|attempted|failed|not_applicable`',
    `transaction_reference_number` STRING COMMENT 'Externally-known unique reference number for this payment transaction, provided by the payment gateway or platform. Used for reconciliation and customer support inquiries.. Valid values are `^[A-Z0-9]{8,32}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this payment record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Transactional record of a real-money payment event received from a player or platform holder. Captures payment amount, currency, payment timestamp, payment method type (credit card, PayPal, platform wallet, gift card), payment gateway reference, authorization code, settlement status, and storefront channel. SSOT for all real-money payment receipts across all distribution platforms. PCI DSS-compliant — no raw card data stored.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`payment_instrument` (
    `payment_instrument_id` BIGINT COMMENT 'Unique identifier for the payment instrument record. Primary key.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who owns this payment instrument.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Payment instruments flagged for fraud or requiring manual verification (high-value accounts, suspicious patterns) are assigned to fraud analysts for verification. Tracking the verifying employee is re',
    `virtual_currency_account_id` BIGINT COMMENT 'The identifier for platform-specific wallet payment methods (PlayStation Network Wallet, Xbox Wallet, Steam Wallet). Null for non-platform wallets.',
    `added_timestamp` TIMESTAMP COMMENT 'The date and time when the payment instrument was first added to the players account.',
    `billing_address_line1` STRING COMMENT 'The first line of the billing address associated with the payment instrument. Used for Address Verification Service (AVS).',
    `billing_address_line2` STRING COMMENT 'The second line of the billing address (apartment, suite, etc.). Optional field for AVS.',
    `billing_city` STRING COMMENT 'The city of the billing address associated with the payment instrument.',
    `billing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the billing address. Used for tax jurisdiction and compliance.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'The postal or ZIP code of the billing address. Critical for Address Verification Service (AVS) checks.',
    `billing_state_province` STRING COMMENT 'The state or province of the billing address. Used for tax calculation and AVS.',
    `card_brand` STRING COMMENT 'The card network brand for card-based payment methods (Visa, Mastercard, American Express, etc.). Null for non-card payment methods.. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `cardholder_name` STRING COMMENT 'The name of the cardholder as it appears on the payment instrument. Used for verification and fraud prevention.',
    `data_retention_expiry_date` DATE COMMENT 'The date when this payment instrument record is scheduled for deletion per data retention policies and regulatory requirements.',
    `deleted_timestamp` TIMESTAMP COMMENT 'The date and time when the payment instrument was soft-deleted or removed from the players account. Null if still active.',
    `expiry_month` STRING COMMENT 'The expiration month of the payment instrument (1-12). Used to validate instrument validity.',
    `expiry_notification_sent` BOOLEAN COMMENT 'Indicates whether an expiration notification has been sent to the player for this payment instrument.',
    `expiry_year` STRING COMMENT 'The expiration year of the payment instrument (four-digit year). Used to validate instrument validity.',
    `failed_transaction_count` STRING COMMENT 'The cumulative number of failed transaction attempts using this payment instrument. Used for fraud detection and instrument health monitoring.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether this payment instrument has been flagged for suspected fraudulent activity.',
    `fraud_score` DECIMAL(18,2) COMMENT 'A calculated risk score (0-100) indicating the likelihood of fraudulent activity associated with this payment instrument. Higher scores indicate higher risk.',
    `gdpr_consent_timestamp` TIMESTAMP COMMENT 'The date and time when the player provided consent for storing and processing payment instrument data under GDPR regulations.',
    `instrument_status` STRING COMMENT 'Current lifecycle status of the payment instrument. Determines whether the instrument can be used for transactions.. Valid values are `active|expired|suspended|failed_verification|deleted`',
    `is_default` BOOLEAN COMMENT 'Indicates whether this payment instrument is the players default payment method for transactions.',
    `is_verified` BOOLEAN COMMENT 'Indicates whether the payment instrument has been successfully verified through AVS or other verification methods.',
    `issuing_bank_bin` STRING COMMENT 'The Bank Identification Number (BIN) or Issuer Identification Number (IIN) identifying the issuing financial institution. First 6-8 digits of the card number.. Valid values are `^[0-9]{6,8}$`',
    `issuing_bank_name` STRING COMMENT 'The name of the financial institution that issued the payment instrument. Derived from BIN lookup.',
    `issuing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the payment instrument was issued. Used for fraud detection and regional compliance.. Valid values are `^[A-Z]{3}$`',
    `last_four_digits` STRING COMMENT 'The last four digits of the card number for display and player identification purposes. Safe to store per PCI DSS.. Valid values are `^[0-9]{4}$`',
    `last_used_timestamp` TIMESTAMP COMMENT 'The date and time when this payment instrument was last used for a successful transaction.',
    `payment_method_type` STRING COMMENT 'The type of payment instrument (e.g., credit card, PayPal, digital wallet). Represents the payment instrument category. [ENUM-REF-CANDIDATE: credit_card|debit_card|paypal|apple_pay|google_pay|psn_wallet|xbox_wallet|steam_wallet — 8 candidates stripped; promote to reference product]',
    `pci_compliance_scope` STRING COMMENT 'Indicates the PCI DSS compliance scope for this payment instrument record. Tokenized instruments are out of scope for most PCI requirements.. Valid values are `in_scope|out_of_scope|tokenized`',
    `recurring_billing_enabled` BOOLEAN COMMENT 'Indicates whether this payment instrument is authorized for recurring subscription billing.',
    `successful_transaction_count` STRING COMMENT 'The cumulative number of successful transactions completed using this payment instrument.',
    `three_d_secure_enrolled` BOOLEAN COMMENT 'Indicates whether the payment instrument is enrolled in 3D Secure authentication (Verified by Visa, Mastercard SecureCode, etc.).',
    `tokenized_reference` STRING COMMENT 'PCI DSS-compliant tokenized reference to the payment instrument stored in the vault provider. Does not contain raw Primary Account Number (PAN).',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when the payment instrument record was last modified.',
    `vault_customer_reference` STRING COMMENT 'The customer identifier in the vault providers system. Used to retrieve payment instruments from the vault.',
    `vault_provider` STRING COMMENT 'The third-party payment vault provider that securely stores the tokenized payment instrument (e.g., Braintree, Stripe, Adyen).. Valid values are `braintree|stripe|adyen|paypal|authorize_net|worldpay`',
    `verification_method` STRING COMMENT 'The method used to verify the payment instrument (Address Verification Service, CVV check, 3D Secure, etc.).. Valid values are `avs|cvv|3ds|micro_deposit|manual`',
    `verification_timestamp` TIMESTAMP COMMENT 'The date and time when the payment instrument was successfully verified.',
    CONSTRAINT pk_payment_instrument PRIMARY KEY(`payment_instrument_id`)
) COMMENT 'PCI DSS-compliant master record of a players stored payment method. Captures tokenized card reference (no raw PAN), payment method type (Visa, Mastercard, PayPal, Apple Pay, Google Pay, PSN Wallet, Xbox Wallet), billing address reference, expiry month/year, issuing bank BIN, instrument status (active, expired, suspended), and vault provider (Braintree, Stripe, Adyen). SSOT for all stored payment credentials.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`refund` (
    `refund_id` BIGINT COMMENT 'Unique identifier for the refund or credit memo transaction. Primary key for the refund product.',
    `chargeback_id` BIGINT COMMENT 'Reference to the chargeback case if this refund is related to a payment dispute initiated by the player through their bank or card issuer.',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.defect. Business justification: Refund requests frequently cite specific bugs. Support and finance teams track defect_id to measure quality-driven refund costs, prioritize fixes by revenue impact, and report quality cost of poor qua',
    `employee_id` BIGINT COMMENT 'Identifier of the customer support agent, automated system, or platform representative who approved the refund.',
    `iap_transaction_id` BIGINT COMMENT 'Foreign key linking to monetization.iap_transaction. Business justification: Refunds for IAP purchases require transaction reference for entitlement revocation, virtual currency clawback, and fraud prevention. Customer support workflows depend on linking refunds to originating',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Refunds issued to licensees for overpayments, disputed royalty calculations, or contract adjustments. Enables licensee-specific refund tracking, dispute resolution, and accounts receivable adjustment ',
    `payment_id` BIGINT COMMENT 'Reference to the originating payment transaction that this refund is reversing or crediting against.',
    `player_account_id` BIGINT COMMENT 'Reference to the player receiving the refund or credit.',
    `settlement_batch_id` BIGINT COMMENT 'Identifier of the settlement batch in which this refund was included for platform payout reconciliation or payment processor settlement.',
    `storefront_order_id` BIGINT COMMENT 'Reference to the original order or purchase transaction associated with this refund.',
    `support_ticket_id` BIGINT COMMENT 'Reference to the customer support ticket or case associated with this refund request, linking to player communication history.',
    `amount` DECIMAL(18,2) COMMENT 'The monetary value being refunded or credited to the player, in the transaction currency.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the refund was approved by customer support, automated policy engine, or platform holder.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this refund record was first created in the system.',
    `credit_applied_amount` DECIMAL(18,2) COMMENT 'The cumulative amount of store credit that has been applied or redeemed by the player against subsequent purchases.',
    `credit_balance_remaining` DECIMAL(18,2) COMMENT 'The remaining unused balance of store credit available for future player purchases.',
    `credit_expiry_date` DATE COMMENT 'Expiration date for store credit or platform wallet credit, after which the credit becomes invalid and cannot be applied.',
    `credit_memo_number` STRING COMMENT 'Unique identifier for the credit memo instrument issued when refund is provided as store credit rather than cash refund.. Valid values are `^CM-[A-Z0-9]{8,16}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the refund amount (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `fraud_flag` BOOLEAN COMMENT 'Flag indicating whether this refund is associated with suspected or confirmed fraudulent activity.',
    `is_automated_refund` BOOLEAN COMMENT 'Flag indicating whether the refund was processed automatically by policy engine (true) or required manual approval (false).',
    `is_partial_refund` BOOLEAN COMMENT 'Flag indicating whether this is a partial refund (true) or a full refund (false) of the original transaction amount.',
    `jurisdiction_code` STRING COMMENT 'Two or three-letter code representing the legal jurisdiction governing this refund transaction, relevant for consumer protection compliance (e.g., US, EU, UK, AU, CA).. Valid values are `^[A-Z]{2,3}$`',
    `notes` STRING COMMENT 'Internal notes or comments from customer support agents or finance team regarding special circumstances, exceptions, or additional context for this refund.',
    `original_payment_amount` DECIMAL(18,2) COMMENT 'The original payment amount from the transaction being refunded, for reconciliation and partial refund tracking.',
    `payment_processor` STRING COMMENT 'The payment gateway or processor handling the refund transaction (e.g., Stripe, Adyen, Braintree, Xsolla, first-party platform processor).',
    `platform_fee_refund_amount` DECIMAL(18,2) COMMENT 'Portion of the refund representing platform holder fees (Steam, Epic, Apple, Google) being reversed or reclaimed.',
    `policy_version` STRING COMMENT 'Version identifier of the refund policy rules applied to this transaction, for audit and compliance tracking.',
    `processed_timestamp` TIMESTAMP COMMENT 'The date and time when the refund was successfully processed and funds were returned to the player or credit was issued.',
    `processor_refund_reference` STRING COMMENT 'External refund transaction identifier from the payment processor or gateway, used for reconciliation and dispute resolution.',
    `reason_code` STRING COMMENT 'Standardized code indicating the reason for the refund: player_request, fraud, technical_failure, platform_policy, goodwill, billing_error, duplicate_charge, unauthorized_purchase, game_defect, service_outage, regulatory_compliance, chargeback. [ENUM-REF-CANDIDATE: player_request|fraud|technical_failure|platform_policy|goodwill|billing_error|duplicate_charge|unauthorized_purchase|game_defect|service_outage|regulatory_compliance|chargeback — promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text detailed explanation of the refund reason, capturing context from player support tickets or internal investigation notes.',
    `reconciliation_status` STRING COMMENT 'Status of financial reconciliation between internal refund records and platform holder settlement reports or payment processor statements.. Valid values are `pending|reconciled|discrepancy|under_review`',
    `refund_number` STRING COMMENT 'Externally visible unique business identifier for the refund transaction, used in player communications and support tickets.. Valid values are `^RFN-[A-Z0-9]{8,16}$`',
    `refund_status` STRING COMMENT 'Current lifecycle status of the refund: pending approval, approved, processed (funds returned), rejected, applied (credit used), expired (credit unused past expiry), or cancelled. [ENUM-REF-CANDIDATE: pending|approved|processed|rejected|applied|expired|cancelled — 7 candidates stripped; promote to reference product]',
    `refund_type` STRING COMMENT 'Classification of the refund mechanism: cash refund to original payment method, store credit (credit memo), platform wallet credit, chargeback reversal, or goodwill credit.. Valid values are `cash_refund|store_credit|platform_wallet_credit|chargeback_reversal|goodwill_credit`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Flag indicating whether this refund was issued to comply with regulatory requirements (GDPR right to refund, consumer protection laws, platform policy mandates).',
    `rejected_timestamp` TIMESTAMP COMMENT 'The date and time when the refund request was rejected or denied.',
    `requested_timestamp` TIMESTAMP COMMENT 'The date and time when the player or system initiated the refund request.',
    `return_method` STRING COMMENT 'The mechanism by which the refund value is returned to the player: original payment method (credit card, PayPal), store credit, platform wallet, bank transfer, or physical check.. Valid values are `original_payment_method|store_credit|platform_wallet|bank_transfer|check`',
    `storefront_code` STRING COMMENT 'The digital storefront or platform where the original purchase and refund occurred (Steam, Epic Games Store, PlayStation Network, Xbox Live, Nintendo eShop, Apple App Store, Google Play, direct web store). [ENUM-REF-CANDIDATE: steam|epic|psn|xbox|nintendo|apple_app_store|google_play|direct_web — 8 candidates stripped; promote to reference product]',
    `tax_refund_amount` DECIMAL(18,2) COMMENT 'Portion of the refund amount representing tax reversal (VAT, sales tax, GST) being returned to the player.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this refund record was last modified.',
    CONSTRAINT pk_refund PRIMARY KEY(`refund_id`)
) COMMENT 'Transactional record of value returned to a player or platform partner, whether as cash refund to original payment method, store credit (credit memo), or platform wallet credit. Captures refund/credit amount, currency, reason code (player request, fraud, technical failure, platform policy, goodwill, billing error), originating payment reference, return method (original payment method, store credit, platform wallet), status (pending, approved, processed, rejected, applied, expired), processing timestamp, approving agent, expiry date (for store credits), and credit memo details (issuing reference, application history). SSOT for all refund and credit activity across storefronts — consolidates both cash refunds and store-credit instruments.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`chargeback` (
    `chargeback_id` BIGINT COMMENT 'Unique identifier for the chargeback record. Primary key.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: High-value chargebacks or patterns trigger compliance incidents for fraud investigation and AML reporting. Gaming companies must link chargebacks to incidents for regulatory filings (FinCEN, card netw',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.defect. Business justification: Chargebacks often result from game-breaking bugs preventing content delivery. Finance teams link chargeback cases to defects for dispute evidence, quality accountability reporting, and to quantify qua',
    `game_title_id` BIGINT COMMENT 'Reference to the game title associated with the disputed transaction.',
    `iap_transaction_id` BIGINT COMMENT 'Foreign key linking to monetization.iap_transaction. Business justification: Chargebacks on IAP transactions drive fraud analysis, entitlement revocation, and dispute resolution. Financial operations require linking chargebacks to originating IAP transactions for evidence subm',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice associated with the disputed transaction.',
    `payment_id` BIGINT COMMENT 'Reference to the original payment transaction that is being disputed.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who initiated or is associated with the disputed transaction.',
    `storefront_order_id` BIGINT COMMENT 'Foreign key linking to billing.storefront_order. Business justification: Chargebacks are payment disputes initiated by players on specific storefront orders. While chargeback already links to invoice, the direct link to storefront_order provides the original purchase conte',
    `acquiring_bank` STRING COMMENT 'Merchants bank or payment processor that acquired the original transaction and is handling the chargeback response.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the disputed transaction being charged back to the merchant.',
    `arbitration_fee` DECIMAL(18,2) COMMENT 'Additional fee charged by the card network for arbitration proceedings if the dispute is escalated beyond standard chargeback resolution.',
    `arbitration_requested` BOOLEAN COMMENT 'Flag indicating whether the merchant has escalated the dispute to card network arbitration after losing the initial chargeback.',
    `assigned_to` STRING COMMENT 'Name or identifier of the billing operations team member or fraud analyst assigned to handle this chargeback case.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address associated with the payment method.. Valid values are `^[A-Z]{3}$`',
    `card_last_four` STRING COMMENT 'Last four digits of the payment card involved in the disputed transaction, used for identification while maintaining PCI DSS compliance.. Valid values are `^[0-9]{4}$`',
    `card_network` STRING COMMENT 'Payment card network that processed the original transaction and is handling the chargeback (Visa, Mastercard, American Express, Discover, JCB, UnionPay).. Valid values are `visa|mastercard|amex|discover|jcb|unionpay`',
    `cardholder_name` STRING COMMENT 'Name of the cardholder as it appears on the payment card used for the disputed transaction.',
    `case_number` STRING COMMENT 'Internal case tracking number assigned by the billing or fraud team for dispute management.',
    `chargeback_number` STRING COMMENT 'Externally-known unique identifier for the chargeback case, typically provided by the card network or payment processor.',
    `chargeback_status` STRING COMMENT 'Current lifecycle status of the chargeback dispute. Tracks progression from initial receipt through final resolution.. Valid values are `received|under-review|evidence-submitted|won|lost|pre-arbitration`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this chargeback record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the chargeback amount (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `device_fingerprint` STRING COMMENT 'Unique identifier for the device used to make the original purchase, used for fraud detection and pattern analysis.',
    `dispute_category` STRING COMMENT 'High-level categorization of the chargeback type for reporting and analysis purposes. [ENUM-REF-CANDIDATE: fraud|authorization|processing-error|consumer-dispute|not-as-described|duplicate|service-not-rendered — 7 candidates stripped; promote to reference product]',
    `dispute_reason_code` STRING COMMENT 'Standardized reason code provided by the card network indicating the basis for the chargeback (e.g., fraud, not-as-described, duplicate charge, service not rendered). Codes vary by card network (Visa, Mastercard, Amex, Discover).',
    `dispute_reason_description` STRING COMMENT 'Human-readable description of the dispute reason, providing additional context beyond the reason code.',
    `evidence_documents` STRING COMMENT 'References or identifiers for supporting documentation submitted to contest the chargeback (receipts, terms of service, delivery confirmation, player activity logs).',
    `evidence_submission_date` DATE COMMENT 'Date when supporting evidence and documentation were submitted to contest the chargeback.',
    `fee` DECIMAL(18,2) COMMENT 'Administrative fee charged by the payment processor or card network for handling the chargeback, separate from the disputed amount.',
    `fraud_indicator` BOOLEAN COMMENT 'Flag indicating whether the chargeback was categorized as fraudulent activity (true) or a legitimate customer dispute (false).',
    `fraud_score` DECIMAL(18,2) COMMENT 'Risk score assigned by fraud detection systems at the time of the original transaction, ranging from 0.00 (low risk) to 100.00 (high risk).',
    `internal_notes` STRING COMMENT 'Free-text field for internal team notes, investigation findings, and case management details related to the chargeback dispute.',
    `ip_address` STRING COMMENT 'Internet Protocol address from which the original transaction was initiated, used for fraud analysis and geolocation.',
    `issuing_bank` STRING COMMENT 'Financial institution that issued the payment card and initiated the chargeback on behalf of the cardholder.',
    `original_transaction_date` DATE COMMENT 'Date when the original payment transaction that is being disputed was processed.',
    `payment_method` STRING COMMENT 'Type of payment instrument used for the original transaction (credit card, debit card, prepaid card, digital wallet).. Valid values are `credit-card|debit-card|prepaid-card|digital-wallet`',
    `platform_storefront` STRING COMMENT 'Digital storefront or platform where the original transaction occurred (Steam, Epic Games Store, PlayStation Store, Xbox Store, Nintendo eShop, Apple App Store, Google Play). [ENUM-REF-CANDIDATE: steam|epic|playstation|xbox|nintendo|apple-app-store|google-play — 7 candidates stripped; promote to reference product]',
    `purchase_type` STRING COMMENT 'Type of gaming purchase that was disputed (full game purchase, DLC, microtransaction, subscription, season pass, in-game currency).. Valid values are `game-purchase|dlc|mtx|subscription|season-pass|in-game-currency`',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the chargeback notification was received from the payment processor or card network.',
    `resolution_date` DATE COMMENT 'Date when the chargeback dispute was finalized with a won or lost outcome.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the chargeback dispute indicating whether the merchant successfully defended against the chargeback or lost the dispute.. Valid values are `merchant-won|merchant-lost|partially-reversed|withdrawn`',
    `response_deadline_date` DATE COMMENT 'Final date by which the merchant must submit evidence and response to contest the chargeback, as mandated by card network rules.',
    `reversal_amount` DECIMAL(18,2) COMMENT 'Amount returned to the merchant if the chargeback was won or partially won. Null if the dispute was lost.',
    `total_financial_impact` DECIMAL(18,2) COMMENT 'Total financial loss to the business including the chargeback amount plus any associated fees.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this chargeback record was last modified.',
    CONSTRAINT pk_chargeback PRIMARY KEY(`chargeback_id`)
) COMMENT 'Operational record of a payment dispute initiated by a player through their bank or card issuer. Captures chargeback amount, currency, dispute reason code (per card network codes: fraud, not-as-described, duplicate), chargeback status (received, under-review, won, lost, pre-arbitration), card network (Visa, Mastercard, Amex), response deadline, evidence submission date, and financial impact. Critical for PCI DSS compliance and fraud loss tracking.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`subscription` (
    `subscription_id` BIGINT COMMENT 'Unique identifier for the subscription instance. Primary key for the subscription product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Customer service reps cancel subscriptions on behalf of players (refund requests, account issues). Tracking which employee processed the cancellation is critical for churn analysis, training needs ass',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Subscriptions require explicit consent tracking under GDPR/CCPA for recurring billing. Gaming companies must prove which policy version player accepted at subscription start. Critical for regulatory a',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Subscription revenue is attributed to cost centers (game title/studio) for recurring revenue analysis and title P&L. Gaming finance tracks subscription MRR/ARR by cost center to measure live service p',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Subscription-based licensing models (game engine subscriptions, middleware SaaS, SDK access) are governed by IP agreements. Links recurring billing to license terms, royalty structures, and usage righ',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Subscriptions grant access to specific licensed IP (Unity Pro for Unity engine, Unreal Engine subscription, middleware SDK access). Links subscription entitlement to licensed technology, enabling IP-b',
    `marketing_campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that drove this subscription acquisition. Used for ROAS (Return on Ad Spend) and campaign effectiveness analysis.',
    `matchmaking_pool_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_pool. Business justification: Subscription tiers often gate access to premium matchmaking pools (ranked modes, competitive ladders). Tracks which pool the subscription unlocks. Business process: recurring revenue from competitive ',
    `payment_instrument_id` BIGINT COMMENT 'Identifier of the payment instrument (credit card, PayPal, platform wallet) used for recurring billing.',
    `storefront_id` BIGINT COMMENT 'Identifier of the platform where the subscription was purchased (Steam, Epic Games Store, PlayStation Network, Xbox Live, App Store, Google Play).',
    `player_account_id` BIGINT COMMENT 'Identifier of the player who purchased this subscription as a gift. Null if not a gift subscription.',
    `subscription_plan_id` BIGINT COMMENT 'Identifier of the subscription plan tier that defines pricing, features, and billing frequency for this subscription.',
    `subscription_player_account_id` BIGINT COMMENT 'Identifier of the player who owns this subscription.',
    `acquisition_channel` STRING COMMENT 'Marketing channel through which the player discovered and subscribed (organic, paid search, social media, email, referral, in-game promotion, web, mobile app). [ENUM-REF-CANDIDATE: organic|paid_search|social_media|email|referral|in_game|web|mobile_app — 8 candidates stripped; promote to reference product]',
    `auto_renew_enabled` BOOLEAN COMMENT 'Indicates whether automatic renewal is enabled (True) or the subscription will expire at term end (False).',
    `billing_frequency` STRING COMMENT 'Recurring billing cycle interval for the subscription (monthly, quarterly, annual, lifetime one-time payment).. Valid values are `monthly|quarterly|annual|lifetime`',
    `cancellation_date` DATE COMMENT 'Date when the player cancelled the subscription. Null if subscription has not been cancelled.',
    `cancellation_feedback` STRING COMMENT 'Free-text feedback provided by the player at cancellation explaining their decision. Used for qualitative churn analysis.',
    `cancellation_reason` STRING COMMENT 'Player-provided reason for cancelling the subscription. Used for churn analysis and retention strategy.. Valid values are `too_expensive|not_enough_value|technical_issues|switching_platform|no_longer_playing|other`',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when the player provided explicit consent to the subscription terms and recurring billing authorization. Required for GDPR and payment processor compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subscription record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for subscription pricing and billing (USD, EUR, GBP, JPY, etc.).. Valid values are `^[A-Z]{3}$`',
    `current_period_end_date` DATE COMMENT 'End date of the current billing period. Next renewal or expiration occurs on this date.',
    `current_period_start_date` DATE COMMENT 'Start date of the current billing period for which the player has paid or will be charged.',
    `discount_code` STRING COMMENT 'Promotional or coupon code applied to this subscription providing a price reduction. Null if no discount applied.',
    `discount_end_date` DATE COMMENT 'Date when the promotional discount expires and full price billing resumes. Null if discount is permanent or no discount applied.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the subscription price (0-100). Null if no discount applied.',
    `expiration_date` DATE COMMENT 'Date when the subscription expired due to non-payment, non-renewal, or term completion. Null if subscription is still active.',
    `external_subscription_reference` STRING COMMENT 'Subscription identifier from the external payment processor or platform (e.g., Stripe subscription ID, Apple subscription ID). Used for reconciliation and support.',
    `failed_payment_count` STRING COMMENT 'Total number of failed billing attempts for this subscription. Used to identify at-risk subscriptions and trigger dunning workflows.',
    `grace_period_end_date` DATE COMMENT 'Date when the grace period ends after a failed payment. Subscription will be suspended or cancelled if payment is not resolved by this date.',
    `is_gift_subscription` BOOLEAN COMMENT 'Indicates whether this subscription was purchased as a gift by another player (True) or self-purchased (False).',
    `is_trial_active` BOOLEAN COMMENT 'Indicates whether the subscription is currently in its free trial period (True) or has converted to paid billing (False).',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount charged in the most recent successful payment in the subscription currency.',
    `last_payment_date` DATE COMMENT 'Date of the most recent successful payment for this subscription.',
    `next_billing_date` DATE COMMENT 'Date when the next recurring payment will be charged if auto-renew is enabled. Null if subscription is cancelled or expired.',
    `payment_processor` STRING COMMENT 'Third-party payment processor or platform holder handling the recurring billing transactions (Stripe, PayPal, Apple, Google, Steam, Epic, PSN, Xbox). [ENUM-REF-CANDIDATE: stripe|paypal|apple|google|steam|epic|psn|xbox — 8 candidates stripped; promote to reference product]',
    `platform_subscription_status` STRING COMMENT 'Raw subscription status value from the external platform or payment processor. Used for reconciliation and debugging platform-specific subscription states.',
    `price` DECIMAL(18,2) COMMENT 'Recurring price charged per billing cycle for this subscription in the subscription currency.',
    `referral_code` STRING COMMENT 'Referral code used by the player when subscribing, linking to the referring player for viral growth tracking and referral rewards.',
    `renewal_count` STRING COMMENT 'Total number of successful billing renewals since subscription start. Used to calculate subscription tenure and LTV (Lifetime Value).',
    `start_date` DATE COMMENT 'Date when the subscription became active and the player gained access to subscription benefits.',
    `subscription_number` STRING COMMENT 'Human-readable external subscription identifier displayed to players and used in customer support interactions.. Valid values are `^SUB-[A-Z0-9]{8,16}$`',
    `subscription_status` STRING COMMENT 'Current lifecycle state of the subscription. Active: subscription is live and billing. Paused: temporarily suspended by player. Cancelled: player terminated, no future billing. Expired: ended due to non-payment or term completion. Pending: awaiting payment confirmation. Trial: in free trial period.. Valid values are `active|paused|cancelled|expired|pending|trial`',
    `subscription_tier` STRING COMMENT 'Service tier level of the subscription plan defining feature access and benefits (basic, standard, premium, ultimate).. Valid values are `basic|standard|premium|ultimate`',
    `trial_end_date` DATE COMMENT 'Date when the free trial period ends and first billing occurs. Null if no trial period.',
    `trial_period_days` STRING COMMENT 'Number of days in the free trial period before first billing occurs. Null if no trial offered.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the subscription record was last modified (status change, renewal, cancellation, etc.).',
    CONSTRAINT pk_subscription PRIMARY KEY(`subscription_id`)
) COMMENT 'Master record of player recurring billing subscriptions combining plan definitions and individual subscription instances. Captures plan tiers, billing frequency, pricing, and individual player subscription state, renewal history, and cancellation reasons.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`subscription_cycle` (
    `subscription_cycle_id` BIGINT COMMENT 'Primary key for subscription_cycle',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice document generated for this billing cycle. Links to the invoice master record for player-facing billing documentation.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Each subscription billing cycle generates a payment transaction. The subscription_cycle.transaction_id is an external processor reference (STRING), but the actual payment record in the billing domain ',
    `payment_instrument_id` BIGINT COMMENT 'Reference to the payment instrument used for this billing cycle attempt. Links to the payment method master record.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who owns the subscription being billed in this cycle.',
    `subscription_id` BIGINT COMMENT 'Reference to the parent subscription for which this billing cycle was executed. Links to the subscription master record.',
    `billed_amount` DECIMAL(18,2) COMMENT 'The gross amount charged to the player for this billing cycle before any adjustments or taxes.',
    `billing_attempt_timestamp` TIMESTAMP COMMENT 'The exact timestamp when the billing system attempted to charge the player for this cycle. Primary business event timestamp for the billing execution.',
    `billing_period_type` STRING COMMENT 'The frequency or type of billing period for this cycle (e.g., monthly, quarterly, annual). Defines the subscription billing cadence.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `chargeback_date` DATE COMMENT 'The date when a chargeback was initiated for this billing cycle. Null if no chargeback occurred.',
    `chargeback_flag` BOOLEAN COMMENT 'Indicates whether a chargeback was filed by the player or payment processor for this billing cycle. True if chargeback occurred.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this billing cycle record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this billing cycle (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `cycle_end_date` DATE COMMENT 'The date when this billing cycle period ended. Defines the end of the service period being billed.',
    `cycle_number` STRING COMMENT 'Sequential cycle number within the subscription lifecycle. First cycle is 1, increments with each billing period.',
    `cycle_start_date` DATE COMMENT 'The date when this billing cycle period began. Defines the start of the service period being billed.',
    `cycle_status` STRING COMMENT 'Current status of the billing cycle execution. Tracks the lifecycle state of the billing attempt and settlement. [ENUM-REF-CANDIDATE: pending|billed|failed|retried|skipped|cancelled|refunded — 7 candidates stripped; promote to reference product]',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total discount amount applied to this billing cycle, including promotional discounts, coupons, or loyalty credits.',
    `dunning_level` STRING COMMENT 'The dunning stage or level for this billing cycle if payment failed. Indicates progression through automated retry and notification sequence (0=no dunning, 1-5=escalating stages).',
    `failure_reason_code` STRING COMMENT 'Standardized code indicating the reason for billing failure if the cycle status is failed or retried. Null if successful. Examples: insufficient_funds, card_expired, payment_declined.',
    `failure_reason_description` STRING COMMENT 'Human-readable description of the billing failure reason. Provides additional context beyond the failure reason code.',
    `grace_period_end_date` DATE COMMENT 'The date when the grace period for this billing cycle ends. If payment is not received by this date, subscription may be suspended or cancelled.',
    `net_amount` DECIMAL(18,2) COMMENT 'The final net amount charged to the player after applying taxes and discounts. This is the actual amount settled.',
    `next_billing_date` DATE COMMENT 'The scheduled date for the next billing cycle attempt. Null if subscription is cancelled or this is the final cycle.',
    `notes` STRING COMMENT 'Free-text notes or comments about this billing cycle execution. Used for documenting exceptions, manual interventions, or special circumstances.',
    `payment_gateway` STRING COMMENT 'The payment gateway or processor used to execute this billing cycle charge (e.g., Stripe, PayPal, Braintree).. Valid values are `stripe|paypal|braintree|adyen|square|internal`',
    `platform_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged by the platform holder (Steam, Epic, Apple, Google) for processing this billing cycle transaction. Deducted from gross revenue.',
    `platform_fee_percentage` DECIMAL(18,2) COMMENT 'The percentage rate applied by the platform holder for this billing cycle. Typically 30% for app stores, varies by platform and volume tier.',
    `proration_amount` DECIMAL(18,2) COMMENT 'The prorated adjustment amount applied to this billing cycle. Positive for credits, negative for additional charges. Null if no proration applied.',
    `proration_applied` BOOLEAN COMMENT 'Indicates whether proration was applied to this billing cycle due to mid-cycle subscription changes, upgrades, or downgrades.',
    `refund_amount` DECIMAL(18,2) COMMENT 'The total amount refunded to the player for this billing cycle. Null if no refund was issued. Positive value indicates money returned to player.',
    `refund_date` DATE COMMENT 'The date when a refund was processed for this billing cycle. Null if no refund was issued.',
    `retry_attempt_count` STRING COMMENT 'Number of retry attempts made for this billing cycle if the initial charge failed. Zero indicates first attempt was successful.',
    `revenue_recognition_date` DATE COMMENT 'The date when revenue from this billing cycle is recognized for accounting purposes. May differ from billing date based on revenue recognition policies.',
    `settlement_date` DATE COMMENT 'The date when the funds from this billing cycle were settled and transferred to the company account. Null if not yet settled.',
    `settlement_reference` STRING COMMENT 'Reference identifier for the financial settlement batch or payout that includes this billing cycle. Used for reconciliation with platform holders and payment processors.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applied to this billing cycle charge, including sales tax, VAT, or other applicable taxes.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this billing cycle record was last modified. Audit trail for record updates and status changes.',
    CONSTRAINT pk_subscription_cycle PRIMARY KEY(`subscription_cycle_id`)
) COMMENT 'Operational record of each executed billing cycle run for a subscription. Captures cycle start date, cycle end date, billing attempt timestamp, billed amount, currency, cycle status (pending, billed, failed, retried, skipped), retry attempt count, failure reason code, and settlement reference. Enables tracking of every billing cycle execution and retry logic for GaaS subscription management.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`storefront_order` (
    `storefront_order_id` BIGINT COMMENT 'Unique identifier for the storefront order. Primary key for this entity.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Storefront orders are fulfilled by legal entities; required for revenue recognition, tax nexus determination, and financial statement consolidation. Gaming companies must know which legal entity is th',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Licensees (developers, studios) purchase tools, assets, and services through storefronts (Unity Asset Store, Unreal Marketplace). Tracks licensee procurement, spending patterns, and cross-sell opportu',
    `marketing_campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that drove this purchase. Used for ROAS (Return on Ad Spend) and CPI (Cost Per Install) analysis.',
    `player_account_id` BIGINT COMMENT 'Identifier of the player who placed this order. Links to the player master record.',
    `subscription_id` BIGINT COMMENT 'Identifier of the subscription record if this order is a recurring subscription charge. Null for one-time purchases.',
    `attribution_source` STRING COMMENT 'Marketing attribution source for this order (e.g., organic, paid search, social media, influencer). Tracked via AppsFlyer or Adjust for mobile.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the order was cancelled, either by the player or by the system due to payment failure.',
    `chargeback_flag` BOOLEAN COMMENT 'Indicates whether this order resulted in a chargeback dispute initiated by the player through their payment provider. Used for fraud detection and risk scoring.',
    `chargeback_timestamp` TIMESTAMP COMMENT 'Date and time when the chargeback was filed by the players payment provider.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the order was marked as completed and all entitlements were delivered to the player.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this order record was first created in the system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this order (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'Type of device used to place the order. Used for platform analytics and user experience optimization.. Valid values are `pc|console|mobile|tablet|web`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the order from promotional codes, platform sales events, or bundle pricing.',
    `entitlement_delivered_timestamp` TIMESTAMP COMMENT 'Date and time when all purchased entitlements were successfully delivered to the players account.',
    `entitlement_delivery_status` STRING COMMENT 'Status of digital entitlement delivery to the players account (e.g., game license, DLC unlock, virtual currency). Drives customer support escalation.. Valid values are `pending|in_progress|delivered|failed|partially_delivered`',
    `fraud_risk_score` DECIMAL(18,2) COMMENT 'Fraud risk score assigned by the payment processor or internal fraud detection system (0-100 scale, higher indicates greater risk).',
    `ip_address` STRING COMMENT 'IP address from which the order was placed. Used for fraud detection, regional compliance, and geo-blocking enforcement.',
    `is_first_purchase` BOOLEAN COMMENT 'Indicates whether this is the players first real-money purchase across all storefronts. Used for conversion tracking and LTV (Lifetime Value) analysis.',
    `is_subscription` BOOLEAN COMMENT 'Indicates whether this order is part of a recurring subscription billing cycle (e.g., monthly game pass, season pass auto-renewal).',
    `line_item_count` STRING COMMENT 'Number of distinct SKUs (Stock Keeping Units) included in this order. Used for basket analysis and bundle tracking.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Net revenue received by the publisher after platform fees, refunds, and chargebacks. Used for financial reporting and royalty calculations.',
    `order_number` STRING COMMENT 'Externally-visible unique order number assigned by the storefront platform. Used for customer service, refunds, and reconciliation.',
    `order_status` STRING COMMENT 'Current lifecycle status of the order. Drives revenue recognition, entitlement delivery, and customer support workflows.. Valid values are `pending|payment_authorized|completed|cancelled|partially_refunded|fully_refunded`',
    `order_timestamp` TIMESTAMP COMMENT 'Date and time when the player placed the order. Principal business event timestamp for this transaction.',
    `payment_authorized_timestamp` TIMESTAMP COMMENT 'Date and time when payment authorization was received from the payment processor or platform holder.',
    `payment_method` STRING COMMENT 'Type of payment instrument used by the player (e.g., credit card, PayPal, platform wallet). Does not store sensitive payment details. [ENUM-REF-CANDIDATE: credit_card|debit_card|paypal|platform_wallet|gift_card|bank_transfer|mobile_payment — 7 candidates stripped; promote to reference product]',
    `payment_processor` STRING COMMENT 'Name of the payment processor or gateway that handled the transaction (e.g., Stripe, Adyen, platform first-party processor).',
    `platform_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the storefront platform (e.g., 30% revenue share for Apple App Store, 12% for Epic Games Store). Deducted from gross revenue.',
    `platform_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of the transaction amount retained by the platform holder as distribution fee. Varies by platform and developer agreement tier.',
    `player_region` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the players billing region. Determines tax jurisdiction, content ratings, and regional pricing.. Valid values are `^[A-Z]{3}$`',
    `promotional_code` STRING COMMENT 'Promotional or discount code applied by the player at checkout. Used for marketing attribution and discount tracking.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total amount refunded to the player for this order. Used for revenue reversal and chargeback tracking.',
    `refund_processed_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was processed and funds were returned to the players payment method.',
    `refund_reason` STRING COMMENT 'Reason provided for the refund request (e.g., accidental purchase, technical issue, player dissatisfaction). Used for quality analysis and fraud detection.',
    `refund_requested_timestamp` TIMESTAMP COMMENT 'Date and time when the player or customer support initiated the refund request.',
    `storefront_platform` STRING COMMENT 'Digital distribution platform where the order was placed. Determines revenue share, settlement terms, and certification requirements. [ENUM-REF-CANDIDATE: steam|epic_games_store|playstation_store|xbox_marketplace|nintendo_eshop|apple_app_store|google_play — 7 candidates stripped; promote to reference product]',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item amounts before tax, discounts, and promotional adjustments are applied.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charged on the order, including sales tax, VAT, GST, or other jurisdiction-specific taxes.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final amount charged to the player, calculated as subtotal minus discounts plus tax. Net settlement amount for revenue recognition.',
    `transaction_reference` STRING COMMENT 'External transaction identifier provided by the payment processor or platform holder. Used for reconciliation and dispute resolution.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this order record was last modified. Audit trail for data lineage and change tracking.',
    CONSTRAINT pk_storefront_order PRIMARY KEY(`storefront_order_id`)
) COMMENT 'Master record of a players real-money purchase order placed through a digital storefront (Steam, Epic Games Store, PlayStation Store, Xbox Marketplace, Nintendo eShop, Apple App Store, Google Play). Captures order number, storefront platform, order timestamp, order status (pending, payment-authorized, completed, cancelled, partially-refunded, fully-refunded), total amount, currency, tax amount, player region, promotional code applied, and embedded line-item detail per SKU (product type, quantity, unit price, line total, discount amount, promotional offer reference, entitlement delivery status). SSOT for all real-money purchase orders and their constituent items across distribution channels.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`storefront_order_line` (
    `storefront_order_line_id` BIGINT COMMENT 'Unique identifier for the storefront order line item. Primary key for this entity representing a single SKU within a purchase order.',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: Order lines reference specific asset bundles purchased (map packs, skin bundles, content packs). Essential for bundle sales analytics, bundle pricing optimization, and understanding which content pack',
    `bundle_parent_line_id` BIGINT COMMENT 'Reference to the parent line item if this line is part of a bundle purchase. Enables bundle component tracking and revenue allocation.',
    `entitlement_id` BIGINT COMMENT 'Unique identifier for the digital entitlement granted to the player. Used to track ownership and prevent duplicate grants.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this SKU belongs to. Links to game master data for franchise and studio revenue attribution.',
    `matchmaking_pool_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_pool. Business justification: Competitive games monetize ranked/premium matchmaking access via season passes or priority queue purchases. Line items track which pool the entitlement grants access to. Business process: feature-base',
    `mtx_catalog_id` BIGINT COMMENT 'Foreign key linking to monetization.mtx_catalog. Business justification: Storefront orders for MTX items reference catalog for pricing validation, entitlement delivery, and revenue recognition. Order fulfillment workflows require linking order lines to MTX catalog entries ',
    `catalog_offer_id` BIGINT COMMENT 'Reference to the promotional campaign or offer that provided the discount. Links to marketing campaign master data for attribution analysis.',
    `storefront_id` BIGINT COMMENT 'Reference to the distribution platform where this purchase occurred. Links to platform master data for Steam, Epic Games Store, PlayStation Store, Xbox Store, Nintendo eShop, App Store, or Google Play.',
    `storefront_order_id` BIGINT COMMENT 'Reference to the parent storefront purchase order that contains this line item. Links this line to the header transaction.',
    `title_sku_id` BIGINT COMMENT 'Reference to the product SKU being purchased in this line. Links to the master product catalog entry for base game, DLC, expansion, virtual currency pack, or cosmetic bundle.',
    `coupon_code` STRING COMMENT 'Player-entered coupon or promotional code applied to this line item. Captured for campaign tracking and fraud detection.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this order line record was first created in the billing system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line. Captured at transaction time for multi-currency revenue reporting.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to this line item from promotional offers, coupons, or platform sales. Positive value representing reduction from list price.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to this line item. Calculated as discount amount divided by list price, expressed as percentage for reporting.',
    `entitlement_delivered_timestamp` TIMESTAMP COMMENT 'Date and time when the digital entitlement was successfully delivered to the player account. Critical for fulfillment SLA tracking and player support.',
    `entitlement_status` STRING COMMENT 'Current fulfillment status of the digital entitlement for this line item. Tracks whether the player has received access to the purchased content.. Valid values are `pending|delivered|failed|revoked|refunded`',
    `is_bundle_component` BOOLEAN COMMENT 'Indicates whether this line item is a component of a larger bundle purchase. Used to distinguish standalone purchases from bundle components.',
    `line_number` STRING COMMENT 'Sequential ordering number of this line item within the parent order. Used for display and processing sequence.',
    `line_subtotal` DECIMAL(18,2) COMMENT 'Total amount for this line before taxes. Calculated as quantity multiplied by unit price minus discount amount.',
    `line_total` DECIMAL(18,2) COMMENT 'Final total amount for this line item including all discounts and taxes. Represents the actual revenue recognized for this SKU.',
    `list_price` DECIMAL(18,2) COMMENT 'Original catalog list price for the SKU before promotional discounts. Used to calculate discount percentage and promotional effectiveness.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this order line record was last modified. Tracks updates to fulfillment status, refunds, or corrections.',
    `net_revenue` DECIMAL(18,2) COMMENT 'Net revenue received by the publisher after platform fees and taxes. Used for financial reporting and revenue recognition under ASC 606 / IFRS 15.',
    `platform_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the distribution platform for this line item. Deducted from gross revenue to calculate net payout. Business-confidential commercial terms.',
    `platform_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of line total retained by the platform as commission. Varies by platform, product type, and commercial agreement. Business-confidential.',
    `product_name` STRING COMMENT 'Display name of the product or SKU as shown to the player at time of purchase. Captured for historical accuracy even if product name changes later.',
    `product_type` STRING COMMENT 'Classification of the product being purchased. Distinguishes between base games, downloadable content, virtual currency packs, cosmetic items, and other monetization SKUs. [ENUM-REF-CANDIDATE: base_game|dlc|expansion|season_pass|virtual_currency|cosmetic_bundle|loot_box|battle_pass — 8 candidates stripped; promote to reference product]',
    `quantity` STRING COMMENT 'Number of units of this SKU purchased in this line item. Typically 1 for digital goods, but may be higher for virtual currency packs or bundles.',
    `refund_eligible_flag` BOOLEAN COMMENT 'Indicates whether this line item is eligible for refund based on platform policies, time since purchase, and usage. Used for customer support workflows.',
    `refund_reason` STRING COMMENT 'Reason code or description if this line item was refunded. Captured for chargeback analysis and product quality monitoring.',
    `refund_timestamp` TIMESTAMP COMMENT 'Date and time when this line item was refunded. Used for revenue reversal and financial reconciliation.',
    `revenue_recognition_date` DATE COMMENT 'Date when revenue for this line item is recognized for financial reporting purposes. May differ from purchase date for deferred revenue items like season passes.',
    `revenue_recognition_status` STRING COMMENT 'Current status of revenue recognition for this line item. Tracks whether revenue has been recognized immediately or is being deferred over time.. Valid values are `immediate|deferred|recognized|reversed`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charged on this line item. Includes sales tax, VAT, GST, or other applicable taxes based on player location and platform requirements.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate applied to this line item expressed as decimal. Used for tax reporting and reconciliation with platform remittances.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per single unit of the SKU before any discounts or taxes. Denominated in the transaction currency.',
    `virtual_currency_amount` BIGINT COMMENT 'Quantity of virtual currency granted if this line item is a virtual currency pack. Null for non-currency SKUs.',
    CONSTRAINT pk_storefront_order_line PRIMARY KEY(`storefront_order_line_id`)
) COMMENT 'Individual line items within a storefront purchase order, representing each SKU purchased (base game, DLC, expansion, virtual currency pack, cosmetic bundle). Captures SKU identifier, product type, quantity, unit price, line total, discount amount, promotional offer reference, and entitlement delivery status. Enables per-SKU revenue attribution and fulfillment tracking.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`platform_payout` (
    `platform_payout_id` BIGINT COMMENT 'Unique identifier for the platform payout settlement record.',
    `bank_account_id` BIGINT COMMENT 'Identifier of the bank account that received this payout settlement.',
    `employee_id` BIGINT COMMENT 'Identifier of the finance user who approved and reconciled this payout settlement.',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the journal entry in the general ledger that records this payout settlement.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the receiving legal entity within the gaming business that received this payout settlement.',
    `storefront_id` BIGINT COMMENT 'Identifier of the first-party platform holder or digital storefront (Sony, Microsoft, Nintendo, Valve, Epic, Apple, Google) that issued this payout.',
    `adjustments_amount` DECIMAL(18,2) COMMENT 'Net adjustments applied by the platform holder (e.g., prior period corrections, promotional credits, dispute resolutions).',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this payout settlement was approved by the finance team.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payout settlement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payout settlement (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied by the platform holder for currency conversion, if applicable.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter to which this payout settlement is attributed for financial reporting purposes.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this payout settlement is attributed for financial reporting purposes.',
    `gl_posting_date` DATE COMMENT 'Date when this payout settlement was posted to the general ledger in the ERP system.',
    `gl_posting_status` STRING COMMENT 'Status of the general ledger posting for this payout settlement in the ERP system.. Valid values are `pending|posted|reversed|cancelled`',
    `gross_revenue_amount` DECIMAL(18,2) COMMENT 'Total gross revenue generated across all titles and SKUs during the payout period before platform fees, returns, and refunds.',
    `line_item_count` STRING COMMENT 'Number of per-title or per-SKU line items included in this payout settlement breakdown.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this payout settlement record was last modified.',
    `net_payout_amount` DECIMAL(18,2) COMMENT 'Net settlement amount paid to the gaming business after platform fees, returns, refunds, and adjustments.',
    `payment_method` STRING COMMENT 'Method used by the platform holder to transfer the payout funds.. Valid values are `wire_transfer|ach|direct_deposit|check|paypal`',
    `payout_date` DATE COMMENT 'Date when the platform holder transferred the settlement funds to the gaming business.',
    `payout_period_end_date` DATE COMMENT 'End date of the sales period covered by this payout settlement.',
    `payout_period_start_date` DATE COMMENT 'Start date of the sales period covered by this payout settlement.',
    `platform_fee_amount` DECIMAL(18,2) COMMENT 'Total platform revenue share fee deducted by the platform holder from gross revenue.',
    `platform_fee_percentage` DECIMAL(18,2) COMMENT 'Platform revenue share percentage applied to gross revenue (e.g., 30.00 for 30% platform fee).',
    `reconciliation_date` DATE COMMENT 'Date when this payout settlement was reconciled and approved by the finance team.',
    `reconciliation_notes` STRING COMMENT 'Notes and comments from the finance team regarding reconciliation findings, discrepancies, or resolutions.',
    `reconciliation_status` STRING COMMENT 'Current reconciliation status of this payout settlement against internal revenue records.. Valid values are `pending|reconciled|discrepancy|disputed|resolved`',
    `returns_refunds_amount` DECIMAL(18,2) COMMENT 'Total amount deducted for returns, refunds, and chargebacks during the payout period.',
    `settlement_reference_number` STRING COMMENT 'External reference number or identifier provided by the platform holder for this payout settlement, used for reconciliation and audit trail.',
    `statement_url` STRING COMMENT 'URL or file path to the detailed payout statement document provided by the platform holder.',
    `tax_jurisdiction` STRING COMMENT 'Three-letter country code representing the tax jurisdiction where tax was withheld.. Valid values are `^[A-Z]{3}$`',
    `tax_withheld_amount` DECIMAL(18,2) COMMENT 'Total tax amount withheld by the platform holder for jurisdictional tax compliance (e.g., VAT, sales tax, withholding tax).',
    `units_sold_total` BIGINT COMMENT 'Total number of units (game copies, DLC, MTX, subscriptions) sold across all titles during the payout period.',
    CONSTRAINT pk_platform_payout PRIMARY KEY(`platform_payout_id`)
) COMMENT 'Record of revenue settlement payments received from first-party platform holders and digital storefronts (Sony, Microsoft, Nintendo, Valve, Epic, Apple, Google). Captures payout period, gross revenue, platform revenue share percentage, net payout amount, currency, payout date, settlement reference, platform identifier, reconciliation status, and embedded per-title/SKU line-item breakdown (title reference, SKU type, units sold, gross revenue, returns/refunds deducted, net revenue, platform fee rate, net payout line amount). SSOT for all platform holder revenue share settlements, payout reconciliation, and per-title revenue attribution.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`payout_line` (
    `payout_line_id` BIGINT COMMENT 'Unique identifier for the payout line item. Primary key for this entity.',
    `game_studio_id` BIGINT COMMENT 'Reference to the development studio responsible for the game title, used for revenue attribution and royalty calculations.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that generated the revenue for this payout line. Links to the game title master entity.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Payout lines track region_code for tax/regulatory treatment per jurisdiction. Gaming platforms must allocate revenue by jurisdiction for tax filing and regional compliance reporting. Replaces denormal',
    `platform_payout_id` BIGINT COMMENT 'Reference to the parent payout settlement batch that this line item belongs to. Links to the payout header entity.',
    `storefront_id` BIGINT COMMENT 'Reference to the distribution platform that processed the transactions for this payout line (Steam, Epic Games Store, PlayStation Network, Xbox Live, Apple App Store, Google Play).',
    `title_sku_id` BIGINT COMMENT 'Reference to the specific SKU or product variant that contributed to this payout line (e.g., base game, DLC, season pass, in-game currency pack).',
    `adjustments_amount` DECIMAL(18,2) COMMENT 'Other revenue adjustments applied by the platform holder (e.g., promotional credits, pricing corrections, currency adjustments).',
    `chargebacks_amount` DECIMAL(18,2) COMMENT 'Total value of payment chargebacks for this SKU during the payout period, deducted from gross revenue.',
    `cost_center_code` STRING COMMENT 'Cost center code associated with this payout line for internal cost allocation and profitability analysis (SAP S/4HANA CO module).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payout line record was first created in the billing system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this payout line (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `dispute_reason` STRING COMMENT 'Reason for dispute if reconciliation status is disputed (e.g., unit count mismatch, fee rate discrepancy, missing transactions, incorrect SKU mapping).',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this payout line revenue is posted in the ERP system (SAP S/4HANA FI module).',
    `gross_revenue_amount` DECIMAL(18,2) COMMENT 'Total gross revenue generated by this SKU before any deductions (returns, refunds, chargebacks, platform fees). Reported in the payout currency.',
    `line_number` STRING COMMENT 'Sequential line number within the payout settlement, used for ordering and reference purposes.',
    `net_payout_amount` DECIMAL(18,2) COMMENT 'Final net payout amount for this line item after all deductions and platform fees. This is the amount remitted to the publisher.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Net revenue after deducting returns, refunds, chargebacks, and adjustments from gross revenue. This is the amount subject to platform fee calculation.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this payout line, used for documenting reconciliation issues, adjustments, or special circumstances.',
    `platform_fee_amount` DECIMAL(18,2) COMMENT 'Total platform fee deducted by the platform holder, calculated as net revenue multiplied by platform fee rate.',
    `platform_fee_rate` DECIMAL(18,2) COMMENT 'Platform holder commission rate applied to net revenue, expressed as a decimal (e.g., 0.3000 for 30%, 0.1200 for 12%). Rate varies by platform, title, and contractual terms.',
    `platform_name` STRING COMMENT 'Name of the distribution platform, denormalized for reporting convenience.',
    `platform_statement_reference` STRING COMMENT 'Reference number or identifier from the platform holders settlement statement that corresponds to this payout line, used for audit trail and reconciliation.',
    `reconciliation_status` STRING COMMENT 'Current reconciliation status of this payout line against internal sales records: pending initial review, reconciled and matched, disputed with platform, adjusted after dispute resolution, or approved for revenue recognition.. Valid values are `pending|reconciled|disputed|adjusted|approved`',
    `refunds_amount` DECIMAL(18,2) COMMENT 'Total value of refunds issued for this SKU during the payout period, deducted from gross revenue.',
    `returns_amount` DECIMAL(18,2) COMMENT 'Total value of product returns for this SKU during the payout period, deducted from gross revenue.',
    `revenue_recognition_date` DATE COMMENT 'Date when revenue from this payout line was recognized in the general ledger for financial reporting purposes, per ASC 606 / IFRS 15 guidance.',
    `sales_period_end_date` DATE COMMENT 'End date of the sales period covered by this payout line item.',
    `sales_period_start_date` DATE COMMENT 'Start date of the sales period covered by this payout line item.',
    `sku_code` STRING COMMENT 'Platform-specific SKU code or product identifier as reported by the platform holder (Steam, Epic, PlayStation, Xbox, App Store, Google Play).',
    `sku_type` STRING COMMENT 'Category of the SKU: base game, downloadable content (DLC), season pass, expansion, microtransaction (MTX), in-app purchase (IAP), or subscription. [ENUM-REF-CANDIDATE: base_game|dlc|season_pass|expansion|mtx|iap|subscription — 7 candidates stripped; promote to reference product]',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount collected or withheld for this payout line, including VAT, sales tax, or withholding tax as applicable by jurisdiction.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Effective tax rate applied to this payout line, expressed as a decimal (e.g., 0.2000 for 20% VAT).',
    `units_sold` STRING COMMENT 'Number of units sold for this SKU during the payout period. For consumable MTX or IAP, represents transaction count.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this payout line record was last modified, used for audit trail and change tracking.',
    CONSTRAINT pk_payout_line PRIMARY KEY(`payout_line_id`)
) COMMENT 'Granular line-item breakdown of a platform payout settlement, detailing revenue contribution per game title, SKU, or product category within a payout period. Captures title reference, SKU type, units sold, gross revenue, returns/refunds deducted, net revenue, platform fee rate, and net payout line amount. Enables per-title revenue reconciliation against platform holder statements.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`billing_tax_record` (
    `billing_tax_record_id` BIGINT COMMENT 'Unique identifier for the billing tax record. Primary key for this entity.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Tax records are calculated on billing transactions, primarily invoices. The billing_tax_record.billing_transaction_id is a generic reference, but the primary use case is tax calculation on invoices. A',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Tax records must tie to the legal entity responsible for tax remittance and filing. Gaming companies file VAT/sales tax returns by legal entity; this link enables tax compliance reporting and audit de',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Complex tax jurisdictions (VAT MOSS, digital services tax, nexus determinations) require manual review by finance/tax team before filing. Reviewer tracking is mandatory for compliance audit trails, ta',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this tax record to detailed audit logs, supporting documentation, or compliance evidence. Used for tax authority audits and internal compliance reviews.',
    `billing_transaction_reference` BIGINT COMMENT 'Reference to the parent billing transaction for which this tax was calculated and collected. Links this tax record to the underlying purchase, refund, or chargeback event.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this tax record was first created in the billing system. Audit field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the taxable_amount and tax_amount (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `customer_business_flag` BOOLEAN COMMENT 'Indicates whether the customer is a business entity (True) or a consumer (False). Affects tax treatment (e.g., B2B reverse charge vs B2C standard VAT).',
    `customer_tax_identifier` STRING COMMENT 'The customers tax identification number (e.g., VAT number for B2B transactions, EIN, TIN) if provided and relevant for tax reporting. Nullable for B2C transactions. Confidential business data.',
    `filing_period_end_date` DATE COMMENT 'The end date of the tax filing period (month, quarter, or year) to which this tax record belongs. Used for aggregating tax liability for periodic filings.',
    `filing_period_reference` STRING COMMENT 'Human-readable reference for the filing period (e.g., 2024-Q1, 2024-03, 2024-Annual). Used for reporting and reconciliation.',
    `filing_period_start_date` DATE COMMENT 'The start date of the tax filing period (month, quarter, or year) to which this tax record belongs. Used for aggregating tax liability for periodic filings.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this tax record was last updated. Audit field for tracking changes to remittance status, disputes, or corrections.',
    `nexus_determination_basis` STRING COMMENT 'The legal or business basis for establishing tax nexus in this jurisdiction (e.g., physical presence, economic nexus threshold, marketplace facilitator law, customer location). Critical for US state sales tax compliance.',
    `platform_holder` STRING COMMENT 'The digital storefront or platform through which the transaction was processed. Determines tax collection responsibility under platform-specific agreements (e.g., Steam collects VAT in EU, Apple collects sales tax in US). [ENUM-REF-CANDIDATE: steam|epic|playstation|xbox|nintendo|apple|google — 7 candidates stripped; promote to reference product]',
    `platform_tax_collection_flag` BOOLEAN COMMENT 'Indicates whether the platform holder (e.g., Steam, Apple) collected and will remit the tax on behalf of the publisher (True), or whether the publisher is responsible for collection and remittance (False).',
    `product_taxability_category` STRING COMMENT 'Classification of the product or service for tax purposes (e.g., electronically supplied services, digital content, tangible personal property, software-as-a-service). Determines applicable tax rules.',
    `reverse_charge_flag` BOOLEAN COMMENT 'Indicates whether the reverse charge mechanism applies (True) or not (False). Under reverse charge, the customer (not the seller) is responsible for remitting VAT. Common in B2B cross-border EU transactions.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The actual tax amount calculated and collected from the player, in the transaction currency. Equals taxable_amount multiplied by tax_rate, subject to rounding rules.',
    `tax_authority_name` STRING COMMENT 'Name of the government tax authority to which the tax is owed (e.g., HM Revenue & Customs, IRS, California Department of Tax and Fee Administration, Bundeszentralamt für Steuern).',
    `tax_authority_reference_number` STRING COMMENT 'Reference number or transaction identifier assigned by the tax authority for this remittance or filing. Nullable if not yet assigned.',
    `tax_calculation_timestamp` TIMESTAMP COMMENT 'The date and time when the tax was calculated for this transaction. Captures the moment the tax engine determined the applicable rate and amount.',
    `tax_code` STRING COMMENT 'Internal or external tax code representing the tax treatment category for this transaction (e.g., digital goods, software license, in-game currency). Maps to tax engine product taxability rules.',
    `tax_engine_name` STRING COMMENT 'Name or identifier of the tax calculation engine or service used to determine the tax (e.g., Avalara, Vertex, TaxJar, internal tax engine). Supports audit and troubleshooting.',
    `tax_engine_version` STRING COMMENT 'Version number of the tax calculation engine or tax rate database used at the time of calculation. Supports reproducibility and audit.',
    `tax_exemption_certificate_reference` STRING COMMENT 'Reference number or identifier of the tax exemption certificate on file, if the exemption was granted based on a certificate provided by the customer. Nullable if no certificate applies.',
    `tax_exemption_flag` BOOLEAN COMMENT 'Indicates whether this transaction qualified for a tax exemption. True if exempt, False if tax was applied normally.',
    `tax_exemption_reason` STRING COMMENT 'Business reason or regulatory basis for the tax exemption, if applicable (e.g., educational institution, government entity, below de minimis threshold, reverse charge mechanism). Nullable if no exemption applies.',
    `tax_invoice_number` STRING COMMENT 'The invoice number on which this tax was reported to the customer. Links the tax record to the customer-facing invoice document. Nullable if no formal invoice was issued.',
    `tax_jurisdiction_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country-level tax jurisdiction where the tax obligation arises (e.g., USA, GBR, DEU, JPN).. Valid values are `^[A-Z]{3}$`',
    `tax_jurisdiction_municipality` STRING COMMENT 'City, county, or local municipality name where the tax obligation arises. Nullable for jurisdictions without municipal-level tax.',
    `tax_jurisdiction_state_province` STRING COMMENT 'State, province, or first-level administrative subdivision code where the tax obligation arises (e.g., CA for California, ON for Ontario). Nullable for countries without state-level tax.',
    `tax_rate` DECIMAL(18,2) COMMENT 'The tax rate applied to the taxable amount, expressed as a decimal (e.g., 0.200000 for 20% VAT, 0.0875 for 8.75% sales tax). Supports up to six decimal places for precision in complex jurisdictions.',
    `tax_remittance_date` DATE COMMENT 'The date on which the collected tax was (or will be) remitted to the tax authority. Nullable if remittance has not yet occurred.',
    `tax_remittance_status` STRING COMMENT 'Current status of tax remittance to the tax authority. Pending: collected but not yet remitted; Remitted: paid to authority; Deferred: scheduled for future remittance; Disputed: under audit or dispute; Refunded: returned to customer.. Valid values are `pending|remitted|deferred|disputed|refunded`',
    `tax_type` STRING COMMENT 'Type of tax applied to the transaction. VAT (Value-Added Tax) for EU and other jurisdictions, GST (Goods and Services Tax) for Canada/Australia/India, sales_tax for US state/local, digital_services_tax for DST regimes, withholding_tax for cross-border payments, consumption_tax for Japan.. Valid values are `vat|gst|sales_tax|digital_services_tax|withholding_tax|consumption_tax`',
    `taxable_amount` DECIMAL(18,2) COMMENT 'The base amount subject to tax, in the transaction currency. This is the pre-tax subtotal on which the tax rate is applied. For VAT, this is the net amount; for sales tax, this is the gross sale amount.',
    `vat_moss_scheme_flag` BOOLEAN COMMENT 'Indicates whether this transaction was reported under the EU VAT Mini One Stop Shop scheme (True) or through standard VAT registration in each member state (False). MOSS simplifies VAT compliance for digital services sold to EU consumers.',
    `vat_registration_number` STRING COMMENT 'The VAT registration number of the entity responsible for remitting the tax (either the publisher or the platform holder). Format varies by jurisdiction (e.g., GB123456789, DE123456789). Nullable if not applicable.',
    CONSTRAINT pk_billing_tax_record PRIMARY KEY(`billing_tax_record_id`)
) COMMENT 'Transactional record of tax calculated, collected, and remitted on a billing transaction. Captures tax jurisdiction (country, state/province, municipality), tax type (VAT, GST, sales tax, digital services tax, withholding tax), tax rate applied, taxable amount, tax amount collected, tax exemption flag, exemption certificate reference, remittance status, and filing period reference. Supports multi-jurisdiction tax compliance for global digital game sales including EU VAT MOSS, US state nexus rules, and platform-specific tax collection responsibilities across Steam, console, and mobile storefronts.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`revenue_recognition` (
    `revenue_recognition_id` BIGINT COMMENT 'Primary key for revenue_recognition',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Revenue recognition must be attributed to cost centers for title/studio P&L reporting. Gaming finance tracks recognized revenue by cost center to measure performance against budget and allocate develo',
    `game_title_id` BIGINT COMMENT 'Reference to the game title (product) for which revenue is being recognized. Links to the specific game, DLC, or season pass.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice that triggered this revenue recognition event. Links to the billing invoice that contains the underlying transaction.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Revenue recognition events generate GL journal entries; this link provides audit trail from billing transactions to financial statements. Required for ASC 606/IFRS 15 compliance and external audit sup',
    `original_recognition_event_revenue_recognition_id` BIGINT COMMENT 'Reference to the original revenue recognition event being reversed, if reversal_flag is True. Null for non-reversal events.',
    `performance_obligation_id` BIGINT COMMENT 'Identifier for the specific performance obligation being satisfied. Relevant for contracts with multiple deliverables (e.g., game + season pass + in-game currency).',
    `player_account_id` BIGINT COMMENT 'Reference to the player (customer) for whom revenue is being recognized. The counterparty in the revenue transaction.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that created this revenue recognition record. Supports audit and compliance requirements.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue recognition drives profit center reporting for title performance analysis and portfolio management. Gaming companies use profit centers to track title-level profitability and make investment d',
    `storefront_id` BIGINT COMMENT 'Reference to the distribution platform (Steam, Epic Games Store, PlayStation Store, Xbox Store, App Store, Google Play) where the transaction occurred.',
    `storefront_order_id` BIGINT COMMENT 'Reference to the underlying financial transaction (purchase, subscription charge, DLC sale, MTX) that generated revenue to be recognized.',
    `subscription_id` BIGINT COMMENT 'Reference to the player contract or subscription agreement under which this revenue is recognized. Relevant for GaaS and subscription-based revenue streams.',
    `accounting_period` STRING COMMENT 'The fiscal period (YYYY-MM or YYYY-QX) to which this revenue recognition is allocated. Used for period-end close and financial reporting.. Valid values are `^[0-9]{4}-(Q[1-4]|[0-9]{2})$`',
    `allocation_method` STRING COMMENT 'Method used to allocate transaction price to multiple performance obligations. Standalone_selling_price for observable prices; residual for unobservable prices; adjusted_market_assessment for market-based estimates.. Valid values are `standalone_selling_price|residual|adjusted_market_assessment`',
    `contract_modification_date` DATE COMMENT 'Date the contract was modified, if contract_modification_flag is True. Null for unmodified contracts.',
    `contract_modification_flag` BOOLEAN COMMENT 'Indicates whether this recognition event resulted from a contract modification (e.g., subscription upgrade, refund, chargeback, price adjustment). True if modified; False if original contract terms.',
    `contract_modification_reason` STRING COMMENT 'Reason for contract modification (e.g., Player upgraded subscription tier, Refund issued, Chargeback processed, Price adjustment applied).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `deferred_amount` DECIMAL(18,2) COMMENT 'The amount of revenue deferred to future periods. Represents unearned revenue for services not yet delivered (e.g., remaining months of a subscription, unreleased DLC in a season pass).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert transaction currency to reporting currency at the time of recognition. Used for multi-currency revenue consolidation.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this revenue is recognized. Supports multi-year revenue recognition for long-term GaaS contracts.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this revenue is posted. Links to the chart of accounts for financial reporting.',
    `notes` STRING COMMENT 'Free-text notes providing additional context for this revenue recognition event (e.g., special accounting treatment, manual adjustments, auditor comments).',
    `performance_obligation_description` STRING COMMENT 'Textual description of the performance obligation being satisfied (e.g., Deliver base game, Provide 12 months of live service, Grant access to DLC content).',
    `recognition_date` DATE COMMENT 'The date on which revenue was recognized in the general ledger. The principal business event timestamp for this transaction.',
    `recognition_event_number` STRING COMMENT 'Externally-visible unique business identifier for this revenue recognition event. Format: RRE-XXXXXXXXXX.. Valid values are `^RRE-[0-9]{10}$`',
    `recognition_method` STRING COMMENT 'The method used to recognize revenue per ASC 606. Point-in-time for one-time purchases (game sales, DLC); over-time for subscriptions and GaaS; proportional for bundled offerings; milestone for performance-based contracts; usage-based for consumption models.. Valid values are `point_in_time|over_time|proportional|milestone|usage_based`',
    `recognition_percentage` DECIMAL(18,2) COMMENT 'Percentage of total transaction amount recognized in this event. Used for proportional and milestone-based recognition. Range: 0.00 to 100.00.',
    `recognition_status` STRING COMMENT 'Current lifecycle status of the revenue recognition event. Tracks whether revenue has been recognized, is still deferred, or has been adjusted.. Valid values are `pending|recognized|deferred|partially_recognized|reversed|adjusted`',
    `recognized_amount` DECIMAL(18,2) COMMENT 'The amount of revenue recognized in this event. For point-in-time recognition, equals total_transaction_amount. For over-time, represents the portion recognized in this period.',
    `remaining_deferred_balance` DECIMAL(18,2) COMMENT 'The cumulative deferred revenue balance remaining after this recognition event. Tracks the liability for unearned revenue.',
    `revenue_category` STRING COMMENT 'High-level categorization of revenue. Product for one-time sales; service for ongoing subscriptions/GaaS; hybrid for bundled offerings.. Valid values are `product|service|hybrid`',
    `revenue_type` STRING COMMENT 'Classification of the revenue stream. Game_sale for base game purchases; DLC for downloadable content; season_pass for bundled future content; subscription for recurring GaaS fees; MTX/IAP for in-game microtransactions; licensing for engine/IP licensing; advertising for ad-supported F2P models. [ENUM-REF-CANDIDATE: game_sale|dlc|season_pass|subscription|mtx|iap|licensing|advertising — 8 candidates stripped; promote to reference product]',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this event reverses previously recognized revenue (e.g., due to refund, chargeback, or accounting correction). True if reversal; False if original recognition.',
    `service_period_end_date` DATE COMMENT 'End date of the service period for over-time revenue recognition (e.g., subscription end date, GaaS service period end). Null for point-in-time recognition.',
    `service_period_start_date` DATE COMMENT 'Start date of the service period for over-time revenue recognition (e.g., subscription start date, GaaS service period start). Null for point-in-time recognition.',
    `total_transaction_amount` DECIMAL(18,2) COMMENT 'The total transaction price allocated to this performance obligation. Gross amount before recognition adjustments.',
    `transaction_date` DATE COMMENT 'The date the underlying transaction (purchase, subscription charge) occurred. May differ from recognition_date for deferred revenue scenarios.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this revenue recognition record was last modified. Audit trail for record changes.',
    CONSTRAINT pk_revenue_recognition PRIMARY KEY(`revenue_recognition_id`)
) COMMENT 'Transactional record capturing the recognition of deferred or earned revenue per ASC 606 / IFRS 15 accounting standards. Captures recognition date, recognized amount, deferred amount, recognition method (point-in-time vs. over-time), performance obligation reference, contract modification flag, and accounting period. Enables compliant revenue recognition for game sales, DLC, season passes, and GaaS subscriptions where revenue may be deferred over service periods.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`promo_code` (
    `promo_code_id` BIGINT COMMENT 'Primary key for promo_code',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Promotional campaigns are budgeted and tracked by cost center for marketing spend analysis and ROI measurement. Gaming finance allocates promo discount costs to title/studio cost centers to measure cu',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Promotional codes issued as part of partnership agreements, co-marketing obligations, or brand licensing deals. Links promotional campaigns to governing agreements for compliance tracking and partners',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Promo codes often have jurisdiction-specific restrictions for tax treatment, gambling regulations, or regional compliance. Gaming platforms must enforce offer eligibility by jurisdiction. Replaces den',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that issued this promotional code.',
    `employee_id` BIGINT COMMENT 'Reference to the internal user or system account that created this promo code record.',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Promotional codes are frequently tied to seasonal events (Halloween sale, Winter event discounts). Marketing teams track promo performance by event to measure event-driven monetization lift and optimi',
    `applicable_sku_scope` STRING COMMENT 'Defines the scope of products to which this promo code applies: all (any purchase), specific_skus (listed SKUs only), category (product category), platform (specific platform purchases).. Valid values are `all|specific_skus|category|platform`',
    `attribution_channel` STRING COMMENT 'The marketing channel through which this promo code was distributed, used for campaign performance attribution and ROAS (Return on Ad Spend) analysis. [ENUM-REF-CANDIDATE: email|social_media|paid_search|organic|affiliate|in_game|customer_support — 7 candidates stripped; promote to reference product]',
    `auto_apply_flag` BOOLEAN COMMENT 'Indicates whether this promo code is automatically applied at checkout for eligible players without requiring manual entry. True if auto-applied, False if manual entry required.',
    `code_type` STRING COMMENT 'Classification of the promotional code based on redemption limits: single_use (one redemption total), multi_use (limited redemptions), unlimited (no cap).. Valid values are `single_use|multi_use|unlimited`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this promo code record was first created in the billing system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for fixed_amount discounts (e.g., USD, EUR, GBP). Null for percentage or free_trial discounts.. Valid values are `^[A-Z]{3}$`',
    `current_redemption_count` STRING COMMENT 'The current total number of times this promo code has been successfully redeemed. Incremented with each successful redemption.',
    `deactivated_timestamp` TIMESTAMP COMMENT 'The date and time when this promo code was manually deactivated or suspended. Null if never deactivated.',
    `deactivation_reason` STRING COMMENT 'The reason why this promo code was deactivated: fraud (fraudulent use detected), abuse (terms violation), campaign_ended (promotional period concluded), business_decision (strategic change), error_correction (code issued in error).. Valid values are `fraud|abuse|campaign_ended|business_decision|error_correction`',
    `discount_type` STRING COMMENT 'The mechanism by which the discount is applied: percentage (e.g., 20% off), fixed_amount (e.g., $5 off), free_trial (e.g., 30 days free), bundle_discount (special bundle pricing).. Valid values are `percentage|fixed_amount|free_trial|bundle_discount`',
    `discount_value` DECIMAL(18,2) COMMENT 'The numeric value of the discount. For percentage discounts, this is the percentage (e.g., 20.00 for 20%). For fixed_amount, this is the currency amount. For free_trial, this is the number of days.',
    `first_time_purchaser_only_flag` BOOLEAN COMMENT 'Indicates whether this promo code is restricted to players making their first real-money purchase. True if restricted to first-time buyers, False otherwise.',
    `internal_notes` STRING COMMENT 'Free-text field for internal business notes about this promo code, such as campaign objectives, special handling instructions, or approval references. Not visible to players.',
    `issuing_source` STRING COMMENT 'The origin or channel through which this promo code was issued: marketing_campaign, partner_promotion, influencer, customer_support (service recovery), loyalty_program, event_giveaway.. Valid values are `marketing_campaign|partner_promotion|influencer|customer_support|loyalty_program|event_giveaway`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this promo code record was last updated.',
    `max_redemption_count` STRING COMMENT 'The total number of times this promo code can be redeemed across all players. Null for unlimited redemption codes.',
    `maximum_discount_amount` DECIMAL(18,2) COMMENT 'The maximum discount amount that can be applied when using this code, used to cap percentage-based discounts. Null if no cap applies.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'The minimum order subtotal required for this promo code to be applicable. Null if no minimum is required.',
    `partner_name` STRING COMMENT 'Name of the external partner or influencer associated with this promo code, if applicable. Used for co-marketing and attribution tracking.',
    `per_player_redemption_limit` STRING COMMENT 'The maximum number of times a single player can redeem this promo code. Typically 1 for single-use-per-player codes.',
    `platform_scope` STRING COMMENT 'The gaming platform(s) on which this promo code is valid. Restricts redemption to specific storefronts or first-party platforms. [ENUM-REF-CANDIDATE: all|steam|epic|playstation|xbox|nintendo|mobile_ios|mobile_android — 8 candidates stripped; promote to reference product]',
    `promo_code_code` STRING COMMENT 'The alphanumeric promotional code string that players enter at checkout to receive the discount. Must be unique across all active codes.. Valid values are `^[A-Z0-9]{6,20}$`',
    `promo_code_status` STRING COMMENT 'Current lifecycle status of the promo code: active (available for redemption), inactive (not yet active or manually disabled), expired (past valid_until_date), depleted (max_redemption_count reached), suspended (temporarily disabled by admin).. Valid values are `active|inactive|expired|depleted|suspended`',
    `public_description` STRING COMMENT 'Player-facing description of the promotional offer associated with this code, displayed in marketing materials and at checkout. Example: Get 20% off your next purchase!',
    `sku_filter_list` STRING COMMENT 'Comma-separated list of SKU identifiers or category codes to which this promo code is restricted. Null if applicable_sku_scope is all.',
    `stackable_flag` BOOLEAN COMMENT 'Indicates whether this promo code can be combined with other promotional codes in a single transaction. True if stackable, False if exclusive.',
    `terms_and_conditions_url` STRING COMMENT 'URL link to the full terms and conditions governing the use of this promo code, ensuring compliance with consumer protection regulations.. Valid values are `^https?://.*$`',
    `total_discount_amount_applied` DECIMAL(18,2) COMMENT 'The cumulative total discount amount (in the promo codes currency) that has been applied across all redemptions of this code. Used for financial reconciliation and ROI (Return on Investment) analysis.',
    `total_revenue_attributed` DECIMAL(18,2) COMMENT 'The cumulative gross revenue (before discount) from all orders that used this promo code. Used to measure the revenue-driving impact of the promotion.',
    `valid_from_date` DATE COMMENT 'The date from which this promo code becomes active and can be redeemed. Part of the promotional window.',
    `valid_until_date` DATE COMMENT 'The date after which this promo code expires and can no longer be redeemed. Null for codes with no expiration.',
    CONSTRAINT pk_promo_code PRIMARY KEY(`promo_code_id`)
) COMMENT 'Master record of promotional discount codes and vouchers applicable to real-money purchases, including their redemption history. Captures promo code string, discount type (percentage, fixed amount, free trial), discount value, applicable SKU scope, maximum redemption count, per-player redemption limit, valid date range, issuing campaign reference, current redemption count, and embedded redemption log (player reference, order reference, redemption timestamp, discount amount applied, redemption channel, redemption status). Distinct from in-game virtual currency promotions — this owns real-money discount instruments and their utilization tracking.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`promo_redemption` (
    `promo_redemption_id` BIGINT COMMENT 'Unique identifier for the promotional code redemption transaction. Primary key.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title for which the promotional code was redeemed, if the promo is title-specific.',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Promotional discounts are applied at the line-item level on invoices. While promo_redemption already links to storefront_order, the actual discount application happens on invoice_line (which represent',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that issued this promotional code, enabling ROI tracking and campaign performance analysis.',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: Promo codes apply to specific platform SKUs. Required for promotional effectiveness tracking, discount attribution by product, and marketing campaign ROI analysis at SKU level.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who redeemed the promotional code.',
    `promo_code_id` BIGINT COMMENT 'Reference to the promotional code definition that was redeemed.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to monetization.promotion. Business justification: Billing promo redemptions tied to monetization promotions enable campaign attribution, discount validation, and ROI analysis. Marketing operations require linking redemptions to promotions for perform',
    `storefront_order_id` BIGINT COMMENT 'Reference to the purchase order or transaction where the promotional code was applied.',
    `transaction_storefront_order_id` BIGINT COMMENT 'The external transaction identifier from the payment processor or platform SDK, used for reconciliation and dispute resolution.',
    `attribution_source` STRING COMMENT 'The marketing attribution source that led to this promotional code redemption (e.g., email campaign, social media ad, influencer partnership, organic search).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this promotional redemption record was first created in the billing system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the discount amount (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary value of the discount applied to the purchase in the transaction currency. For percentage discounts, this is the calculated dollar amount saved.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'The percentage discount applied if the promo code is percentage-based (e.g., 10.00 for 10% off). Null for fixed-amount discounts.',
    `discount_type` STRING COMMENT 'The type of promotional discount applied: percentage off, fixed amount off, free shipping, bonus virtual currency, free item, or bundle discount.. Valid values are `percentage|fixed_amount|free_shipping|bonus_currency|free_item|bundle_discount`',
    `expiration_date` DATE COMMENT 'The expiration date of the promotional code at the time of redemption, captured for historical tracking and compliance.',
    `final_order_amount` DECIMAL(18,2) COMMENT 'The total order amount after the promotional discount was applied.',
    `fraud_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this redemption was flagged as potentially fraudulent by automated or manual review.',
    `fraud_score` DECIMAL(18,2) COMMENT 'The fraud risk score assigned to this redemption transaction by the fraud detection system (0.00 = no risk, 100.00 = high risk).',
    `is_first_purchase` BOOLEAN COMMENT 'Boolean flag indicating whether this redemption was associated with the players first-ever purchase (true) or a repeat purchase (false).',
    `is_stackable` BOOLEAN COMMENT 'Boolean flag indicating whether this promotional code was allowed to be combined with other promotions on the same order.',
    `notes` STRING COMMENT 'Free-text notes or comments about this promotional redemption, typically used for customer service annotations or special handling instructions.',
    `original_order_amount` DECIMAL(18,2) COMMENT 'The total order amount before the promotional discount was applied.',
    `partner_code` BIGINT COMMENT 'Reference to the external partner or affiliate who distributed the promotional code, enabling partner payout tracking.',
    `redemption_channel` STRING COMMENT 'The storefront or platform where the promotional code was redeemed (e.g., Steam, Epic Games Store, console first-party stores, mobile app stores, in-game store, web store). [ENUM-REF-CANDIDATE: steam|epic_games_store|playstation_store|xbox_store|nintendo_eshop|mobile_app_store|in_game_store|web_store|retail_partner — 9 candidates stripped; promote to reference product]',
    `redemption_code` STRING COMMENT 'The actual promotional code string entered or applied by the player (e.g., SUMMER2024, WELCOME10).',
    `redemption_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the geographic location where the redemption occurred.. Valid values are `^[A-Z]{3}$`',
    `redemption_device_type` STRING COMMENT 'The type of device used to redeem the promotional code (PC, console, mobile, tablet, web browser).. Valid values are `pc|console|mobile|tablet|web|unknown`',
    `redemption_ip_address` STRING COMMENT 'The IP address from which the promotional code redemption was initiated, used for fraud detection and geographic analysis.',
    `redemption_platform` STRING COMMENT 'The operating system or gaming platform on which the promotional code was redeemed. [ENUM-REF-CANDIDATE: windows|macos|linux|playstation|xbox|nintendo_switch|ios|android|web|unknown — 10 candidates stripped; promote to reference product]',
    `redemption_region` STRING COMMENT 'The geographic region or market where the promotional code was redeemed (e.g., North America, Europe, Asia-Pacific).',
    `redemption_status` STRING COMMENT 'Current lifecycle status of the promotional redemption indicating whether the discount was successfully applied, reversed due to refund, or failed validation.. Valid values are `applied|reversed|expired|invalid|pending`',
    `redemption_timestamp` TIMESTAMP COMMENT 'The exact date and time when the promotional code was successfully redeemed by the player.',
    `referral_code` STRING COMMENT 'The referral or affiliate code associated with this promotional redemption, if the promo was distributed through a referral program.',
    `reversal_reason` STRING COMMENT 'The business reason why the promotional discount was reversed (e.g., order refund, chargeback, fraud detection, policy violation). Null if not reversed.',
    `reversal_timestamp` TIMESTAMP COMMENT 'The date and time when the promotional discount was reversed. Null if the redemption has not been reversed.',
    `source_system` STRING COMMENT 'The name of the operational system that originated this promotional redemption record (e.g., Steamworks, Epic Games Store SDK, SAP S/4HANA, proprietary billing platform).',
    `terms_accepted_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the player explicitly accepted the promotional terms and conditions at redemption time.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this promotional redemption record was last modified in the billing system.',
    `usage_sequence_number` STRING COMMENT 'The sequential usage count for this promotional code by this player (e.g., 1 for first use, 2 for second use), enabling multi-use promo tracking.',
    `validation_error_code` STRING COMMENT 'The system error code returned if the promotional code failed validation (e.g., EXPIRED, INVALID_CODE, USAGE_LIMIT_EXCEEDED, REGION_RESTRICTED). Null if validation succeeded.',
    `validation_error_message` STRING COMMENT 'Human-readable error message explaining why the promotional code redemption failed validation. Null if validation succeeded.',
    CONSTRAINT pk_promo_redemption PRIMARY KEY(`promo_redemption_id`)
) COMMENT 'Transactional record of a promotional code or discount voucher being redeemed by a player on a real-money purchase. Captures redemption timestamp, player reference, promo code reference, order reference, discount amount applied, redemption channel (storefront, in-game store, web), and redemption status (applied, reversed). Enables tracking of promotional discount utilization and ROI measurement.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`billing_account` (
    `billing_account_id` BIGINT COMMENT 'Unique identifier for the billing account. Primary key for the billing account entity.',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Licensees (publishers, developers, middleware vendors) maintain billing accounts for royalty payments, license fees, and revenue shares. Enables licensee financial management, payment term enforcement',
    `player_account_id` BIGINT COMMENT 'Reference to the player identity who owns this billing account. Links the billing account to the player domain master record.',
    `account_number` STRING COMMENT 'Externally visible unique account number for customer service and billing correspondence. Format: BA followed by 10 digits.. Valid values are `^BA[0-9]{10}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the billing account. Active accounts can transact; suspended accounts are temporarily blocked; closed accounts are permanently terminated; under-review accounts are flagged for fraud investigation; pending-activation accounts await verification; delinquent accounts have overdue payments.. Valid values are `active|suspended|closed|under_review|pending_activation|delinquent`',
    `account_tier` STRING COMMENT 'Segmentation tier based on lifetime spend and engagement. Standard represents typical players; premium represents moderate spenders; VIP represents high-value players; whale represents top-tier spenders with dedicated account management.. Valid values are `standard|premium|vip|whale`',
    `activated_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing account was activated and became eligible for transactions. May differ from creation timestamp if verification was required.',
    `auto_renew_enabled` BOOLEAN COMMENT 'Boolean indicator whether automatic renewal is enabled for recurring subscriptions on this account. False requires manual renewal by player.',
    `balance` DECIMAL(18,2) COMMENT 'Current store credit or wallet balance available for purchases. Positive balance represents prepaid funds; negative balance represents outstanding debt. Denominated in preferred currency.',
    `billing_address_line1` STRING COMMENT 'Primary street address line for billing correspondence and tax jurisdiction determination.',
    `billing_address_line2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number.',
    `billing_city` STRING COMMENT 'City name for billing address.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for billing address. Determines applicable tax rules, payment methods, and regulatory requirements.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for billing address. Critical for tax jurisdiction and fraud detection.',
    `billing_state_province` STRING COMMENT 'State, province, or region code for billing address. Used for sales tax calculation.',
    `chargeback_count` STRING COMMENT 'Total number of chargebacks filed against this account. High chargeback rates may result in account suspension and increased fraud scrutiny.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing account was permanently closed. Null for active accounts.',
    `coppa_compliant_flag` BOOLEAN COMMENT 'Boolean indicator whether this account is subject to COPPA restrictions (player under 13 years old in the US). True enforces parental consent requirements and restricted data collection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing account was first created in the system. Represents the start of the billing relationship.',
    `data_retention_expiry_date` DATE COMMENT 'Date when billing account data must be purged or anonymized per GDPR right-to-erasure or internal data retention policies. Null for active accounts with ongoing retention requirements.',
    `dunning_cycle_count` STRING COMMENT 'Number of dunning cycles (payment retry attempts) executed for the current outstanding balance. Resets to zero when balance is cleared.',
    `dunning_status` STRING COMMENT 'Current stage in the payment recovery process for failed recurring charges. None indicates no outstanding issues; soft-dunning represents initial retry attempts; hard-dunning indicates escalated recovery; final-notice is last warning before suspension; collections indicates account sent to external recovery.. Valid values are `none|soft_dunning|hard_dunning|final_notice|collections`',
    `failed_transaction_count` STRING COMMENT 'Cumulative count of failed payment transactions on this account. High failure rates trigger fraud alerts and dunning workflows.',
    `fraud_flag` BOOLEAN COMMENT 'Boolean indicator whether the account has been flagged for suspected fraudulent activity. True triggers additional verification steps for transactions.',
    `fraud_risk_score` DECIMAL(18,2) COMMENT 'Calculated fraud risk score ranging from 0.00 (lowest risk) to 100.00 (highest risk). Generated by fraud detection algorithms based on transaction patterns, device fingerprints, and behavioral analysis.',
    `gdpr_consent_timestamp` TIMESTAMP COMMENT 'Timestamp when the player provided explicit consent for processing billing and payment data under GDPR Article 6. Required for EU players.',
    `last_failed_transaction_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent failed payment transaction. Used to trigger dunning workflows and fraud alerts.',
    `last_successful_transaction_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful payment transaction on this account. Used for account activity monitoring and churn prediction.',
    `lifetime_spend_amount` DECIMAL(18,2) COMMENT 'Total cumulative amount spent by this billing account across all transactions since account creation. Denominated in the accounts preferred currency. Used for player segmentation and LTV (Lifetime Value) analysis.',
    `marketing_opt_in_flag` BOOLEAN COMMENT 'Boolean indicator whether the player has consented to receive promotional offers and marketing communications related to billing and monetization. Required for GDPR and CAN-SPAM compliance.',
    `parental_consent_verified` BOOLEAN COMMENT 'Boolean indicator whether parental consent has been verified for accounts subject to COPPA or similar child protection regulations. Required before processing payments for minors.',
    `pci_compliance_scope` STRING COMMENT 'Indicates whether this account stores payment card data subject to PCI DSS requirements. In-scope accounts require full compliance controls; out-of-scope accounts do not handle card data; tokenized-only accounts use vault tokens exclusively.. Valid values are `in_scope|out_of_scope|tokenized_only`',
    `preferred_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the players preferred currency for pricing display and billing. Transactions may still settle in platform currency.. Valid values are `^[A-Z]{3}$`',
    `refund_count` STRING COMMENT 'Total number of refunds issued to this account. Used for customer satisfaction analysis and fraud pattern detection.',
    `subscription_active_flag` BOOLEAN COMMENT 'Boolean indicator whether the account has at least one active recurring subscription (e.g., battle pass, premium membership). Used for churn analysis and retention campaigns.',
    `successful_transaction_count` STRING COMMENT 'Cumulative count of successful payment transactions on this account. Used to calculate transaction success rate.',
    `tax_exemption_certificate_number` STRING COMMENT 'Government-issued certificate number supporting tax exemption claim. Required for audit trail when tax_exemption_status is exempt or partial.',
    `tax_exemption_expiry_date` DATE COMMENT 'Date when the tax exemption certificate expires and must be renewed. Null for permanent exemptions or non-exempt accounts.',
    `tax_exemption_status` STRING COMMENT 'Indicates whether the account qualifies for sales tax exemption. Exempt accounts bypass tax calculation; partial exemptions apply reduced rates; pending-verification accounts await documentation review.. Valid values are `none|exempt|partial|pending_verification`',
    `total_transaction_count` STRING COMMENT 'Cumulative count of all payment transactions (successful and failed) processed on this account since creation. Used for engagement and fraud analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in this billing account record. Used for change tracking and audit trails.',
    CONSTRAINT pk_billing_account PRIMARY KEY(`billing_account_id`)
) COMMENT 'Master billing account record linking a player identity to their real-money financial relationship with the platform. Captures account status (active, suspended, closed, under-review), account creation date, default payment instrument reference, billing address, preferred currency, tax exemption status, lifetime spend amount, account balance (store credit), fraud risk score, and dunning status. SSOT for the players billing identity — distinct from the player profile (owned by the player domain) and from virtual wallet (owned by monetization domain).';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`dunning_event` (
    `dunning_event_id` BIGINT COMMENT 'Unique identifier for the dunning event record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Dunning and retention costs are tracked by cost center for customer lifetime value analysis and subscription economics. Gaming finance allocates dunning campaign costs to title cost centers to measure',
    `dunning_cycle_id` BIGINT COMMENT 'Identifier grouping all dunning attempts for a single payment failure incident, allowing tracking of the complete recovery workflow.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title associated with the subscription in dunning.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice that could not be collected, triggering this dunning event.',
    `payment_instrument_id` BIGINT COMMENT 'Reference to the payment instrument that failed during the billing attempt.',
    `player_account_id` BIGINT COMMENT 'Reference to the player whose payment failed and triggered dunning.',
    `catalog_offer_id` BIGINT COMMENT 'Identifier of the retention offer presented to the player. Null if no offer was made.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: When automated dunning fails and escalates to manual intervention, the CS rep who resolved the payment issue (updated card, applied credit, negotiated payment plan) must be tracked for performance met',
    `subscription_cycle_id` BIGINT COMMENT 'Foreign key linking to billing.subscription_cycle. Business justification: Dunning events are triggered by failed billing cycles. While dunning_event already links to subscription (the parent), linking to the specific subscription_cycle that failed provides granular tracking',
    `subscription_id` BIGINT COMMENT 'Reference to the subscription that triggered this dunning event.',
    `access_revoked_flag` BOOLEAN COMMENT 'Flag indicating whether subscription access has been revoked due to unresolved payment failure.',
    `access_revoked_timestamp` TIMESTAMP COMMENT 'Date and time when subscription access was revoked. Null if access has not been revoked.',
    `attempt_timestamp` TIMESTAMP COMMENT 'Date and time when this dunning attempt was executed.',
    `attempted_amount` DECIMAL(18,2) COMMENT 'Monetary amount that was attempted to be charged during this dunning event.',
    `churn_risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score (0-100) indicating the likelihood that this player will churn due to this payment failure.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this dunning event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the attempted payment amount.. Valid values are `^[A-Z]{3}$`',
    `dunning_attempt_number` STRING COMMENT 'Sequential number of this dunning attempt within the dunning cycle (1 for first attempt, 2 for second, etc.).',
    `dunning_status` STRING COMMENT 'Current status of the dunning process (active: awaiting retry, resolved: payment succeeded, escalated: moved to manual collection, subscription_cancelled: player cancelled, grace_period_expired: access revoked, payment_updated: player updated payment method).. Valid values are `active|resolved|escalated|subscription_cancelled|grace_period_expired|payment_updated`',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when this dunning case was escalated to manual collection or customer support. Null if not escalated.',
    `failure_reason_code` STRING COMMENT 'Standardized code indicating why the payment failed (insufficient funds, card expired, card declined, bank block, invalid card, fraud suspected).. Valid values are `insufficient_funds|card_expired|card_declined|bank_block|invalid_card|fraud_suspected`',
    `failure_reason_description` STRING COMMENT 'Detailed human-readable description of the payment failure reason provided by the payment processor.',
    `gateway_response_code` STRING COMMENT 'Raw response code returned by the payment gateway for this dunning attempt.',
    `grace_period_days` STRING COMMENT 'Total number of days in the grace period granted to the player for this dunning cycle.',
    `grace_period_end_date` DATE COMMENT 'Date when the grace period expires and subscription access will be revoked if payment is not resolved.',
    `grace_period_start_date` DATE COMMENT 'Date when the grace period began, allowing the player continued access despite payment failure.',
    `is_voluntary_cancellation` BOOLEAN COMMENT 'Flag indicating whether the subscription was voluntarily cancelled by the player (true) or involuntarily cancelled due to dunning failure (false).',
    `ltv_at_dunning` DECIMAL(18,2) COMMENT 'Players lifetime value at the time of this dunning event, used to prioritize recovery efforts.',
    `max_retry_attempts` STRING COMMENT 'Maximum number of automated retry attempts configured for this dunning cycle before escalation or cancellation.',
    `next_retry_date` DATE COMMENT 'Scheduled date for the next automated payment retry attempt. Null if no further retries are scheduled.',
    `notification_channel` STRING COMMENT 'Communication channel used to notify the player about the payment failure (email, push notification, in-game message, SMS, or none if no notification sent).. Valid values are `email|push|in_game|sms|none`',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the dunning notification was sent to the player. Null if no notification was sent.',
    `notification_template_code` STRING COMMENT 'Identifier of the message template used for player communication during this dunning attempt.',
    `payment_processor` STRING COMMENT 'Name of the payment processor or gateway that handled this transaction attempt (Stripe, Braintree, Adyen, etc.).',
    `platform_code` STRING COMMENT 'Platform where the subscription and payment failure originated (Steam, Epic Games Store, PlayStation Network, Xbox Live, Nintendo eShop, iOS App Store, Google Play, web). [ENUM-REF-CANDIDATE: steam|epic|psn|xbox|nintendo|ios|android|web — 8 candidates stripped; promote to reference product]',
    `player_response_action` STRING COMMENT 'Action taken by the player in response to the dunning notification (updated payment method, contacted support, ignored notification, cancelled subscription, or no action).. Valid values are `updated_payment|contacted_support|ignored|cancelled_subscription|none`',
    `processor_transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the payment processor for this dunning attempt.',
    `recovery_offer_presented` BOOLEAN COMMENT 'Flag indicating whether a special retention offer (discount, free period) was presented to the player during this dunning event.',
    `resolution_method` STRING COMMENT 'Method by which the dunning event was resolved (automatic retry succeeded, manual payment by player, player updated payment method, subscription cancelled, or written off as uncollectible).. Valid values are `automatic_retry|manual_payment|payment_method_update|subscription_cancelled|write_off`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the dunning event was resolved (payment succeeded or subscription cancelled). Null if still active.',
    `retry_interval_days` STRING COMMENT 'Number of days between this attempt and the next scheduled retry.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this dunning event record was last modified.',
    CONSTRAINT pk_dunning_event PRIMARY KEY(`dunning_event_id`)
) COMMENT 'Transactional record of a dunning action taken when a recurring billing payment fails. Captures dunning attempt number, attempt timestamp, failure reason code (insufficient funds, card expired, card declined, bank block), notification channel (email, push, in-game), next retry date, dunning status (active, resolved, escalated, subscription-cancelled), and grace period expiry date. Supports automated retry and player communication workflows for GaaS subscription recovery.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`credit_memo` (
    `credit_memo_id` BIGINT COMMENT 'Unique identifier for the credit memo. Primary key.',
    `defect_id` BIGINT COMMENT 'Foreign key linking to quality.defect. Business justification: Credit memos issued for bug-related compensation track defect_id for quality cost accounting, defect impact measurement, and to report cost of quality (COQ) to finance and executive teams for quality ',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title associated with this credit memo, if the credit is game-specific (e.g., in-game currency credit). Null if credit is account-wide.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Credit memos generate GL journal entries for revenue reversals and customer credits; audit trail requirement. Gaming companies must link credit memos to GL for financial statement accuracy and revenue',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the marketing or promotional campaign that generated this credit memo, if applicable. Null if not campaign-related.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice that this credit memo is correcting or crediting against. Null if the credit is not tied to a specific invoice (e.g., goodwill credit).',
    `player_account_id` BIGINT COMMENT 'Reference to the player account to which this credit memo is issued. Null if issued to a platform partner account instead.',
    `employee_id` BIGINT COMMENT 'Reference to the customer service agent, finance team member, or automated system process that authorized and issued this credit memo.',
    `storefront_order_id` BIGINT COMMENT 'Reference to the payment transaction that triggered this credit memo (e.g., a refund request, chargeback event). Null if not transaction-specific.',
    `subscription_id` BIGINT COMMENT 'Foreign key linking to billing.subscription. Business justification: Credit memos are issued for subscription billing issues (e.g., failed auto-renewal, service outage credits, prorated cancellations). While credit_memo already links to invoice and storefront_order, ma',
    `support_ticket_id` BIGINT COMMENT 'Reference to the customer support ticket that resulted in this credit memo being issued. Null if not ticket-driven.',
    `tertiary_credit_voided_by_agent_employee_id` BIGINT COMMENT 'Reference to the agent who voided or cancelled this credit memo. Null if not voided.',
    `applied_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the credit that has been consumed (applied to purchases). Zero if not yet used.',
    `cost_center_code` STRING COMMENT 'Cost center code responsible for the financial impact of this credit memo (e.g., customer service department, marketing department).. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit memo record was first created in the billing system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the credit issued, in the specified currency. This is the gross credit before any application or expiry.',
    `credit_memo_number` STRING COMMENT 'Externally-visible unique business identifier for the credit memo, typically formatted as CM-XXXXXXXXXX for customer and platform partner reference.. Valid values are `^CM-[0-9]{8,12}$`',
    `credit_memo_status` STRING COMMENT 'Current lifecycle state of the credit memo: issued (active and available for use), applied (fully consumed against purchases), partially_applied (some balance remaining), expired (past expiry date and no longer usable), voided (cancelled by issuing agent), pending (awaiting approval or system processing).. Valid values are `issued|applied|partially_applied|expired|voided|pending`',
    `credit_memo_type` STRING COMMENT 'Classification of the credit memo indicating the business reason category: goodwill (customer service gesture), billing_error_correction (invoice mistake), partial_refund (store credit instead of cash refund), promotional (marketing campaign credit), chargeback_reversal (chargeback won and credit issued), platform_adjustment (platform partner settlement correction).. Valid values are `goodwill|billing_error_correction|partial_refund|promotional|chargeback_reversal|platform_adjustment`',
    `credit_reason_code` STRING COMMENT 'Standardized internal code representing the specific reason for issuing the credit (e.g., BILLING_ERROR, GOODWILL_GESTURE, PROMO_CAMPAIGN, CHARGEBACK_WON). Used for reporting and analytics.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `credit_reason_description` STRING COMMENT 'Free-text explanation of why the credit memo was issued, providing business context and details for audit and customer service reference.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit amount (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `data_retention_expiry_date` DATE COMMENT 'Date on which this credit memo record is eligible for archival or deletion per data retention policies and regulatory requirements (GDPR, CCPA, tax law retention periods).',
    `expiry_date` DATE COMMENT 'Date on which the credit memo expires and any remaining balance becomes unusable. Null if the credit has no expiration.',
    `external_reference_code` STRING COMMENT 'External system identifier or reference number from the platform partner or payment processor related to this credit memo (e.g., Steam transaction ID, Epic order ID). Used for reconciliation.',
    `fully_applied_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit memo balance was fully consumed (remaining_balance reached zero). Null if not yet fully applied.',
    `gdpr_consent_timestamp` TIMESTAMP COMMENT 'Timestamp when the player provided consent for processing their personal data in relation to this credit memo, if applicable under GDPR. Null if not subject to GDPR or consent not required.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this credit memo is posted for financial reporting and reconciliation.. Valid values are `^[0-9]{4,10}$`',
    `issue_date` DATE COMMENT 'Date on which the credit memo was officially issued and became available for use by the player or platform partner.',
    `notes` STRING COMMENT 'Free-text field for additional internal notes, comments, or context about this credit memo for audit trail and customer service reference.',
    `pci_compliance_scope` STRING COMMENT 'Indicates whether this credit memo record is within PCI DSS compliance scope: IN_SCOPE (contains or references cardholder data), OUT_OF_SCOPE (no cardholder data), NOT_APPLICABLE (non-card transaction).. Valid values are `IN_SCOPE|OUT_OF_SCOPE|NOT_APPLICABLE`',
    `platform_partner_code` BIGINT COMMENT 'Reference to the platform partner (Steam, Epic, console first-party, mobile app store) to which this credit memo is issued. Null if issued to a player account instead.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Current available credit balance (credit_amount minus applied_amount). This is the amount still available for future purchases.',
    `revenue_reversal_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this credit memo triggers a revenue reversal in the general ledger (True) or is treated as a marketing expense (False).',
    `storefront_code` STRING COMMENT 'Code identifying the digital storefront or platform where the original transaction occurred and where this credit will be applied (Steam, Epic Games Store, PlayStation Network, Xbox Live, Nintendo eShop, Apple App Store, Google Play, Direct Web Store). [ENUM-REF-CANDIDATE: STEAM|EPIC|PSN|XBOX|NINTENDO|APPLE|GOOGLE|DIRECT — 8 candidates stripped; promote to reference product]',
    `tax_jurisdiction_code` STRING COMMENT 'Code identifying the tax jurisdiction applicable to this credit memo (e.g., US-CA for California, GB for United Kingdom, EU-VAT for EU VAT area).. Valid values are `^[A-Z]{2,3}(-[A-Z0-9]{2,5})?$`',
    `tax_treatment_code` STRING COMMENT 'Code indicating how this credit memo is treated for tax purposes: TAXABLE (credit includes tax component), NON_TAXABLE (credit is pre-tax), TAX_EXEMPT (recipient is tax-exempt), REVERSE_CHARGE (VAT reverse charge applies).. Valid values are `TAXABLE|NON_TAXABLE|TAX_EXEMPT|REVERSE_CHARGE`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit memo record was last modified (status change, balance update, etc.).',
    `voided_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit memo was voided or cancelled. Null if not voided.',
    CONSTRAINT pk_credit_memo PRIMARY KEY(`credit_memo_id`)
) COMMENT 'Formal financial document issued to a player or platform partner representing a credit against a billing account (e.g., goodwill credit, billing error correction, partial refund as store credit). Captures credit amount, currency, credit reason, originating invoice reference, expiry date, credit status (issued, applied, expired, voided), and applying agent. Distinct from a refund (cash back) — a credit memo applies value to the billing account for future purchases.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`payment_hold` (
    `payment_hold_id` BIGINT COMMENT 'Unique identifier for the payment hold record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the fraud analyst or automated system agent assigned to review this payment hold. Null for unassigned holds.',
    `fraud_rule_id` BIGINT COMMENT 'Identifier of the specific fraud prevention rule or model that triggered the hold. Enables rule performance analysis and optimization.',
    `payment_id` BIGINT COMMENT 'Reference to the payment transaction that is subject to this hold. Links to the payment record under review.',
    `payment_instrument_id` BIGINT COMMENT 'Foreign key linking to billing.payment_instrument. Business justification: Payment holds are placed on specific payment instruments during fraud review or high-value purchase verification. The hold is instrument-specific (e.g., a specific credit card is flagged). This FK ena',
    `player_account_id` BIGINT COMMENT 'Reference to the player whose payment is being held for review. Enables player-level fraud analysis and velocity checks.',
    `sanctions_screening_result_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening_result. Business justification: Payment holds often result from sanctions screening hits (OFAC, export control). Gaming companies must link holds to screening results for AML compliance and hold resolution workflows. Critical for re',
    `storefront_order_id` BIGINT COMMENT 'Reference to the storefront order associated with this payment hold. Links the hold to the original purchase transaction.',
    `original_payment_hold_id` BIGINT COMMENT 'Self-referencing FK on payment_hold (original_payment_hold_id)',
    `authorization_code` STRING COMMENT 'Authorization code returned by the payment processor when the hold was placed. Used to reference the authorization during capture or void operations.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166 country code of the billing address associated with the payment method. Used for geo-mismatch fraud detection.. Valid values are `^[A-Z]{3}$`',
    `capture_timestamp` TIMESTAMP COMMENT 'Date and time when the held payment authorization was captured and settled. Null if the hold was declined, voided, or expired.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment hold record was first created in the system. Used for audit trails and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the held payment amount. Essential for multi-currency fraud analysis and settlement.. Valid values are `^[A-Z]{3}$`',
    `decline_reason_code` STRING COMMENT 'Standardized code indicating the reason the payment hold was declined and voided. Used for fraud pattern analysis and player communication.',
    `decline_reason_description` STRING COMMENT 'Detailed explanation of why the payment hold was declined. Provides context for player support and dispute resolution.',
    `device_fingerprint` STRING COMMENT 'Unique identifier for the device used to initiate the payment. Used for device-based fraud detection and velocity checks.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the payment hold was escalated to senior fraud analysts or management for additional review. True if escalated.',
    `escalation_reason` STRING COMMENT 'Explanation of why the payment hold required escalation beyond standard fraud review procedures.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the payment hold was escalated for senior review. Null if never escalated.',
    `fraud_rule_version` STRING COMMENT 'Version number of the fraud rule or model that was active when the hold was triggered. Critical for audit trails and rule effectiveness analysis.',
    `fraud_score` DECIMAL(18,2) COMMENT 'Numerical fraud risk score assigned to the payment at the time of hold. Higher scores indicate greater fraud risk. Typically ranges from 0 to 100.',
    `fraud_score_threshold` DECIMAL(18,2) COMMENT 'The fraud score threshold that was exceeded, triggering the payment hold. Used to evaluate and tune fraud prevention rules.',
    `gateway_transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the payment gateway for this authorization hold. Used for reconciliation and dispute resolution.',
    `hold_amount` DECIMAL(18,2) COMMENT 'The monetary amount of the payment authorization that is being held pending fraud review. Represents the value at risk.',
    `hold_created_timestamp` TIMESTAMP COMMENT 'Date and time when the payment hold was initially placed. Marks the start of the authorization hold period.',
    `hold_expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the payment authorization hold will expire if not captured or voided. Typically 7-30 days from creation depending on card network rules.',
    `hold_number` STRING COMMENT 'Human-readable unique identifier for the payment hold, used for tracking and reference in fraud review workflows and customer support interactions.',
    `hold_reason_code` STRING COMMENT 'Standardized code indicating the primary reason the payment was placed on hold. Used for categorization and reporting of fraud prevention triggers.',
    `hold_reason_description` STRING COMMENT 'Detailed human-readable explanation of why the payment was placed on hold. Provides context for fraud analysts and support agents reviewing the case.',
    `hold_status` STRING COMMENT 'Current status of the payment hold in the fraud review and settlement workflow. Tracks progression from initial hold through final resolution. [ENUM-REF-CANDIDATE: pending_review|approved_for_capture|declined|expired|escalated|cancelled|captured|voided — 8 candidates stripped; promote to reference product]',
    `hold_trigger_type` STRING COMMENT 'Classification of the fraud prevention mechanism that triggered the hold. Distinguishes between automated rules, ML models, and manual interventions. [ENUM-REF-CANDIDATE: fraud_score_threshold|velocity_check|geo_mismatch|first_purchase|high_value|card_verification_failure|suspicious_device|manual_review|rule_engine|machine_learning_model — 10 candidates stripped; promote to reference product]',
    `ip_address` STRING COMMENT 'IP address from which the payment transaction originated. Used for geo-location analysis and fraud pattern detection.',
    `payment_processor` STRING COMMENT 'Name of the payment gateway or processor handling this authorization hold. Critical for routing capture and void requests.',
    `player_contact_attempted_flag` BOOLEAN COMMENT 'Indicates whether the fraud team attempted to contact the player to verify the transaction. True if contact was attempted.',
    `player_contact_timestamp` TIMESTAMP COMMENT 'Date and time when the fraud team attempted to contact the player for transaction verification. Null if no contact attempted.',
    `player_verification_status` STRING COMMENT 'Outcome of player identity and transaction verification attempts during fraud review. Indicates whether the player confirmed the purchase.. Valid values are `verified|failed|no_response|not_attempted`',
    `resolution_outcome` STRING COMMENT 'Final outcome of the payment hold after review. Indicates whether the payment was ultimately captured, voided, or allowed to expire.. Valid values are `captured|voided|expired|cancelled`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the payment hold was resolved with a final decision (approved, declined, expired). Marks the end of the review process.',
    `review_notes` STRING COMMENT 'Free-text notes entered by fraud analysts during the review process. Documents investigation findings and decision rationale.',
    `review_priority` STRING COMMENT 'Priority level assigned to the hold review based on fraud risk, transaction value, and player history. Determines review queue ordering.. Valid values are `critical|high|medium|low`',
    `review_started_timestamp` TIMESTAMP COMMENT 'Date and time when fraud review of the held payment began. Used to measure review queue wait times and SLA compliance.',
    `transaction_country_code` STRING COMMENT 'Three-letter ISO 3166 country code derived from the IP address or device location at transaction time. Used for geo-mismatch analysis.. Valid values are `^[A-Z]{3}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payment hold record was last modified. Tracks the most recent change to any field in the record.',
    `void_timestamp` TIMESTAMP COMMENT 'Date and time when the held payment authorization was voided and released. Null if the hold was captured or expired.',
    CONSTRAINT pk_payment_hold PRIMARY KEY(`payment_hold_id`)
) COMMENT 'Transactional record of a payment authorization hold placed during fraud review or high-value purchase verification. Captures hold amount, currency, hold reason (fraud score threshold, velocity check, geo-mismatch, first-purchase, high-value), authorization reference, hold status (pending_review, approved_for_capture, declined, expired, escalated), review agent or automated rule reference, hold creation timestamp, expiry timestamp, resolution timestamp, and capture/void outcome. Critical for managing the gap between payment authorization and settlement in gaming where digital goods fraud rates are elevated.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`dunning_cycle` (
    `dunning_cycle_id` BIGINT COMMENT 'Primary key for dunning_cycle',
    `employee_id` BIGINT COMMENT 'Reference to the user or system account that created this dunning cycle configuration.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user or system account that last modified this dunning cycle configuration.',
    `platform_holder_id` BIGINT COMMENT 'Reference to the platform holder (Steam, Epic, Sony, Microsoft, Apple, Google) for platform-specific dunning cycles that comply with first-party billing policies.',
    `previous_dunning_cycle_id` BIGINT COMMENT 'Self-referencing FK on dunning_cycle (previous_dunning_cycle_id)',
    `auto_update_payment_method` BOOLEAN COMMENT 'Indicates whether this dunning cycle includes automatic payment method update attempts via account updater services (Visa Account Updater, Mastercard Automatic Billing Updater).',
    `cancellation_threshold` STRING COMMENT 'Number of failed attempts after which subscription or service is automatically cancelled if payment is not resolved.',
    `chargeback_protection_enabled` BOOLEAN COMMENT 'Indicates whether this dunning cycle includes chargeback prevention measures such as pre-dispute notifications or representment workflows.',
    `compliance_framework` STRING COMMENT 'Regulatory or compliance framework this dunning cycle adheres to (e.g., PCI DSS, GDPR, CCPA, regional consumer protection laws).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this dunning cycle configuration was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for dunning cycles that are currency-specific due to payment processor or regulatory requirements.',
    `cycle_code` STRING COMMENT 'Business identifier code for the dunning cycle, used for external reference and reporting.',
    `cycle_name` STRING COMMENT 'Human-readable name of the dunning cycle (e.g., Standard Retry, Aggressive Recovery, Soft Reminder).',
    `cycle_type` STRING COMMENT 'Classification of the dunning cycle strategy (standard, aggressive, soft, custom, platform_specific for console/mobile stores, regulatory for compliance-driven cycles).',
    `dunning_cycle_description` STRING COMMENT 'Detailed description of the dunning cycle strategy, business rationale, and intended use cases.',
    `effective_end_date` DATE COMMENT 'Date when this dunning cycle configuration expires or is superseded. Null for open-ended cycles.',
    `effective_start_date` DATE COMMENT 'Date when this dunning cycle configuration becomes active and applicable to payment retry logic.',
    `escalation_enabled` BOOLEAN COMMENT 'Indicates whether failed payments in this cycle are escalated to collections, account management, or alternative recovery processes.',
    `geographic_region` STRING COMMENT 'Geographic region or market this dunning cycle applies to, allowing region-specific retry strategies based on local payment behaviors and regulations. [ENUM-REF-CANDIDATE: NAM|EUR|APAC|LATAM|MEA|CHN|JPN|KOR — promote to reference product]',
    `grace_period_days` STRING COMMENT 'Number of days before the first retry attempt is initiated after initial payment failure, allowing customer self-resolution.',
    `hard_decline_action` STRING COMMENT 'Action taken when a hard decline (permanent failure like stolen card, closed account) occurs: immediate suspension, notification only, request new payment method, or escalate to support.',
    `max_retry_attempts` STRING COMMENT 'Maximum number of payment retry attempts allowed within this dunning cycle before escalation or account suspension.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this dunning cycle configuration was last modified.',
    `notification_channel` STRING COMMENT 'Primary communication channel used for dunning notifications to customers (email, SMS, push notification, in-app message, or multi-channel).',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether automated customer notifications (email, SMS, in-app) are sent during this dunning cycle.',
    `payment_method_type` STRING COMMENT 'Type of payment instrument this dunning cycle applies to. Specific cycles may be configured for different payment methods due to varying retry success rates.',
    `priority_level` STRING COMMENT 'Priority level assigned to this dunning cycle for resource allocation and processing queue management.',
    `retry_interval_days` STRING COMMENT 'Number of days between consecutive payment retry attempts in this dunning cycle.',
    `revenue_recovery_rate_target` DECIMAL(18,2) COMMENT 'Target percentage of failed payment revenue this dunning cycle aims to recover, used for performance measurement and optimization.',
    `soft_decline_retry_enabled` BOOLEAN COMMENT 'Indicates whether soft declines (temporary failures like insufficient funds, issuer timeout) trigger immediate retry attempts within this cycle.',
    `dunning_cycle_status` STRING COMMENT 'Current lifecycle status of the dunning cycle configuration.',
    `subscription_tier` STRING COMMENT 'Subscription tier this dunning cycle applies to, enabling differentiated retry strategies for high-value vs. low-value customers.',
    `suspension_threshold` STRING COMMENT 'Number of failed attempts after which account or subscription is automatically suspended pending payment resolution.',
    CONSTRAINT pk_dunning_cycle PRIMARY KEY(`dunning_cycle_id`)
) COMMENT 'Master reference table for dunning_cycle. Referenced by dunning_cycle_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`fraud_rule` (
    `fraud_rule_id` BIGINT COMMENT 'Primary key for fraud_rule',
    `superseded_fraud_rule_id` BIGINT COMMENT 'Self-referencing FK on fraud_rule (superseded_fraud_rule_id)',
    `action_type` STRING COMMENT 'Automated action taken when the rule is triggered: block transaction, route to manual review, flag for investigation, challenge user with additional authentication, or notify fraud team.',
    `audit_trail_enabled` BOOLEAN COMMENT 'Indicates whether detailed audit logging is enabled for this rule (true) or not (false). Required for high-severity rules and compliance purposes.',
    `compliance_framework` STRING COMMENT 'Regulatory or compliance framework this rule supports (e.g., PCI DSS, GDPR, CCPA, regional gaming regulations). Multiple frameworks separated by commas.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fraud rule record was first created in the system.',
    `fraud_rule_description` STRING COMMENT 'Detailed business description of the fraud pattern this rule detects and the rationale for its configuration.',
    `effective_end_date` DATE COMMENT 'Date when this rule was deactivated or deprecated. Null for currently active rules.',
    `effective_start_date` DATE COMMENT 'Date when this rule became active in the fraud detection system.',
    `execution_order` STRING COMMENT 'Sequence order in which this rule is evaluated in the fraud detection pipeline. Lower numbers execute first. Used to optimize performance and dependency management.',
    `false_positive_rate` DECIMAL(18,2) COMMENT 'Historical false positive rate (0.0000 to 1.0000) for this rule, calculated as the ratio of incorrectly flagged legitimate transactions to total flagged transactions. Used for rule tuning.',
    `is_machine_learning_based` BOOLEAN COMMENT 'Indicates whether this rule uses machine learning models (true) or deterministic logic (false) for fraud detection.',
    `last_tuned_date` DATE COMMENT 'Date when the rule parameters (thresholds, weights, logic) were last adjusted based on performance analysis.',
    `model_version` STRING COMMENT 'Version identifier of the machine learning model or rule logic (semantic versioning format: major.minor.patch). Null for non-ML rules.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this fraud rule.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fraud rule record was last modified.',
    `notes` STRING COMMENT 'Free-text field for operational notes, tuning history, or special considerations related to this fraud rule.',
    `notification_channel` STRING COMMENT 'Communication channel used for fraud alerts when this rule is triggered: email, SMS, Slack, PagerDuty, or webhook integration.',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether real-time notifications are sent to the fraud team when this rule is triggered (true) or not (false).',
    `owner_team` STRING COMMENT 'Name of the business team or department responsible for maintaining and tuning this fraud rule (e.g., Fraud Operations, Risk Management, Payment Security).',
    `payment_method_filter` STRING COMMENT 'Comma-separated list of payment method types (credit_card, debit_card, paypal, wallet, bank_transfer) to which this rule applies. Null indicates all payment methods.',
    `region_filter` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes to which this rule applies. Null indicates all regions.',
    `risk_score_weight` DECIMAL(18,2) COMMENT 'Numeric weight (0.00 to 100.00) assigned to this rule in the composite fraud risk scoring model. Higher weights indicate greater fraud risk contribution.',
    `rule_category` STRING COMMENT 'Business category of fraud the rule is designed to detect: payment fraud, account takeover, chargeback fraud, refund abuse, bonus abuse, or identity theft.',
    `rule_code` STRING COMMENT 'Unique business identifier code for the fraud rule, used for external reference and system integration.',
    `rule_logic_expression` STRING COMMENT 'Technical expression or pseudocode defining the rule logic. May reference transaction attributes, user behavior patterns, or external data sources. Confidential to prevent fraud circumvention.',
    `rule_name` STRING COMMENT 'Human-readable name of the fraud detection rule.',
    `rule_type` STRING COMMENT 'Classification of the fraud rule by detection methodology: velocity-based, threshold-based, pattern matching, geolocation analysis, device fingerprinting, or behavioral analysis.',
    `scope` STRING COMMENT 'Application scope of the rule: global (all transactions), storefront-specific (Steam, Epic, console), region-specific, payment method-specific, or user segment-specific.',
    `severity_level` STRING COMMENT 'Severity classification of fraud events detected by this rule, determining response priority and escalation path.',
    `fraud_rule_status` STRING COMMENT 'Current lifecycle status of the fraud rule: active (in production), inactive (disabled), testing (pilot phase), deprecated (scheduled for removal), or suspended (temporarily disabled).',
    `storefront_filter` STRING COMMENT 'Comma-separated list of storefront codes (Steam, Epic, PSN, Xbox, AppStore, GooglePlay) to which this rule applies. Null indicates all storefronts.',
    `threshold_unit` STRING COMMENT 'Unit of measurement for the threshold value: currency (USD, EUR), transaction count, percentage, or velocity rate (per hour, per day).',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value that triggers the rule. Interpretation depends on threshold_unit (e.g., dollar amount, transaction count, velocity rate).',
    `time_window_minutes` STRING COMMENT 'Time window in minutes over which the rule evaluates activity. Used for velocity and pattern-based rules (e.g., 5 transactions in 60 minutes).',
    `true_positive_rate` DECIMAL(18,2) COMMENT 'Historical true positive rate (0.0000 to 1.0000) for this rule, calculated as the ratio of correctly identified fraudulent transactions to total actual fraud cases. Measures rule effectiveness.',
    `version_number` STRING COMMENT 'Incremental version number of this rule configuration. Incremented with each modification to support change tracking and rollback.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this fraud rule.',
    CONSTRAINT pk_fraud_rule PRIMARY KEY(`fraud_rule_id`)
) COMMENT 'Master reference table for fraud_rule. Referenced by fraud_rule_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Primary key for bank_account',
    `payment_provider_id` BIGINT COMMENT 'Reference to the payment service provider or payment gateway that manages this bank account (e.g., Stripe, PayPal, Adyen).',
    `player_account_id` BIGINT COMMENT 'Reference to the player or user who owns this bank account for payouts, refunds, or withdrawals.',
    `primary_bank_account_id` BIGINT COMMENT 'Self-referencing FK on bank_account (primary_bank_account_id)',
    `account_holder_name` STRING COMMENT 'The legal name of the individual or entity that holds the bank account, as registered with the financial institution.',
    `account_number` STRING COMMENT 'The full bank account number. Stored in encrypted or tokenized form per PCI DSS requirements.',
    `account_status` STRING COMMENT 'The current lifecycle status of the bank account in the gaming platform billing system.',
    `account_type` STRING COMMENT 'The classification of the bank account (checking, savings, business, prepaid).',
    `added_timestamp` TIMESTAMP COMMENT 'The date and time when the bank account was first added to the gaming platform. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `bank_branch_name` STRING COMMENT 'The name of the specific branch where the account is registered, if applicable.',
    `bank_country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 country code where the bank is domiciled (e.g., USA, GBR, DEU).',
    `bank_name` STRING COMMENT 'The name of the financial institution or bank where the account is held.',
    `closure_reason` STRING COMMENT 'The reason why the bank account was closed or deactivated.',
    `closure_timestamp` TIMESTAMP COMMENT 'The date and time when the bank account was closed or deactivated by the player or system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for the account (e.g., USD, EUR, GBP, JPY).',
    `expiration_date` DATE COMMENT 'The date when the bank account record expires or needs re-verification, if applicable. Format: yyyy-MM-dd.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether this bank account has been flagged for suspected fraudulent activity. True if flagged, False otherwise.',
    `iban` STRING COMMENT 'The International Bank Account Number used for international transactions, primarily in Europe and other regions. Up to 34 alphanumeric characters.',
    `is_payout_enabled` BOOLEAN COMMENT 'Indicates whether this bank account is enabled for receiving payouts (e.g., tournament winnings, creator revenue share). True if enabled, False otherwise.',
    `is_primary` BOOLEAN COMMENT 'Indicates whether this is the primary bank account for the player for payouts and refunds. True if primary, False otherwise.',
    `is_refund_enabled` BOOLEAN COMMENT 'Indicates whether this bank account is enabled for receiving refunds. True if enabled, False otherwise.',
    `last_four_digits` STRING COMMENT 'The last four digits of the bank account number, used for display and identification purposes without exposing the full account number.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the bank account record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_used_timestamp` TIMESTAMP COMMENT 'The date and time when this bank account was last used for a transaction (payout, refund, or withdrawal). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text field for internal notes, comments, or special instructions related to this bank account (e.g., manual review notes, customer service remarks).',
    `payment_token` STRING COMMENT 'The tokenized representation of the bank account provided by the payment gateway (e.g., Stripe bank account token, PayPal billing agreement ID). Used for PCI DSS compliance to avoid storing raw account details.',
    `pci_compliance_level` STRING COMMENT 'The PCI DSS compliance level applicable to this bank account record based on transaction volume and risk assessment.',
    `risk_score` DECIMAL(18,2) COMMENT 'A calculated risk score (0.00 to 100.00) for this bank account based on fraud detection algorithms, transaction history, and verification status.',
    `routing_number` STRING COMMENT 'The routing transit number (RTN) or sort code used to identify the financial institution. Format varies by country (e.g., ABA routing number in USA, sort code in UK).',
    `swift_code` STRING COMMENT 'The SWIFT/BIC code identifying the bank for international wire transfers. 8 or 11 alphanumeric characters.',
    `verification_method` STRING COMMENT 'The method used to verify the bank account (e.g., micro-deposit, instant verification via third-party service like Plaid, manual review).',
    `verification_status` STRING COMMENT 'The status of the bank account verification process (micro-deposit verification, instant verification via Plaid/Stripe, etc.).',
    `verified_timestamp` TIMESTAMP COMMENT 'The date and time when the bank account was successfully verified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Master reference table for bank_account. Referenced by bank_account_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`settlement_batch` (
    `settlement_batch_id` BIGINT COMMENT 'Primary key for settlement_batch',
    `storefront_id` BIGINT COMMENT 'Reference to the gaming platform or storefront that originated this settlement batch (Steam, Epic Games Store, PlayStation Network, Xbox Live, Apple App Store, Google Play Store).',
    `previous_settlement_batch_id` BIGINT COMMENT 'Self-referencing FK on settlement_batch (previous_settlement_batch_id)',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total value of manual adjustments, corrections, or promotional credits applied to the settlement batch.',
    `batch_generated_timestamp` TIMESTAMP COMMENT 'The date and time when the platform holder generated this settlement batch report.',
    `batch_number` STRING COMMENT 'Externally-known unique business identifier for the settlement batch, used for reconciliation with platform holders and payment processors.',
    `batch_received_timestamp` TIMESTAMP COMMENT 'The date and time when the settlement batch was received and ingested into the billing system.',
    `batch_status` STRING COMMENT 'Current lifecycle status of the settlement batch in the payment processing workflow.',
    `batch_type` STRING COMMENT 'Classification of the settlement batch indicating the nature of transactions included.',
    `chargeback_amount` DECIMAL(18,2) COMMENT 'Total value of chargebacks disputed by customers during the settlement period, reducing net settlement amount.',
    `chargeback_count` STRING COMMENT 'Total number of chargeback disputes recorded in this settlement batch.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this settlement batch record was first created in the billing system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this settlement batch.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this settlement batch is currently under dispute with the platform holder due to discrepancies or contractual disagreements.',
    `dispute_reason` STRING COMMENT 'Detailed explanation of why the settlement batch is disputed, including specific transaction IDs or calculation errors identified.',
    `gross_revenue_amount` DECIMAL(18,2) COMMENT 'Total gross revenue from all transactions in this settlement batch before platform fees, taxes, and adjustments.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this settlement batch record was last updated or modified.',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'Final net amount payable to the publisher after all fees, taxes, refunds, chargebacks, and adjustments have been applied.',
    `notes` STRING COMMENT 'Free-text field for recording additional context, special circumstances, or operational notes related to this settlement batch.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used by the platform holder to transfer the settlement amount.',
    `payment_reference_number` STRING COMMENT 'External payment transaction reference or wire transfer confirmation number provided by the platform holder or bank.',
    `platform_fee_amount` DECIMAL(18,2) COMMENT 'Total platform holder commission or revenue share deducted from gross revenue (e.g., 30% Steam fee, 12% Epic fee).',
    `platform_report_url` STRING COMMENT 'Secure URL link to the original settlement report document provided by the platform holder, stored in document management system.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether the settlement batch amounts match internal transaction records or if discrepancies exist.',
    `reconciliation_timestamp` TIMESTAMP COMMENT 'The date and time when the settlement batch was successfully reconciled against internal transaction records.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total value of refunds processed during the settlement period, reducing net settlement amount.',
    `refund_count` STRING COMMENT 'Total number of refund transactions processed in this settlement batch.',
    `settlement_due_date` DATE COMMENT 'The contractual date by which the platform holder is obligated to transfer the net settlement amount.',
    `settlement_paid_date` DATE COMMENT 'The actual date when the net settlement amount was received in the publishers bank account.',
    `settlement_period_end_date` DATE COMMENT 'The last date of the transaction period covered by this settlement batch.',
    `settlement_period_start_date` DATE COMMENT 'The first date of the transaction period covered by this settlement batch.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount withheld or collected across all transactions in the settlement batch (VAT, sales tax, digital services tax).',
    `transaction_count` STRING COMMENT 'Total number of individual transactions included in this settlement batch.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The monetary difference between expected settlement amount and actual settlement amount, if a reconciliation discrepancy exists.',
    CONSTRAINT pk_settlement_batch PRIMARY KEY(`settlement_batch_id`)
) COMMENT 'Master reference table for settlement_batch. Referenced by settlement_batch_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`performance_obligation` (
    `performance_obligation_id` BIGINT COMMENT 'Primary key for performance_obligation',
    `dlc_bundle_id` BIGINT COMMENT 'Reference to a bundle product if this performance obligation is part of a multi-item bundle requiring transaction price allocation across multiple obligations.',
    `contract_id` BIGINT COMMENT 'Reference to the parent contract or agreement that contains this performance obligation.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice that billed this performance obligation to the customer.',
    `parent_obligation_id` BIGINT COMMENT 'Reference to a parent performance obligation if this is a child obligation (e.g., individual season pass content drops linked to the season pass purchase).',
    `platform_holder_id` BIGINT COMMENT 'Reference to the platform holder (Steam, Epic Games Store, PlayStation Network, Xbox Live, Apple App Store, Google Play) through which this obligation was sold.',
    `player_account_id` BIGINT COMMENT 'Reference to the customer who purchased this performance obligation.',
    `product_id` BIGINT COMMENT 'Reference to the game, DLC, or virtual item product associated with this performance obligation.',
    `storefront_id` BIGINT COMMENT 'Reference to the specific digital storefront where the transaction originated.',
    `transaction_id` BIGINT COMMENT 'Reference to the originating financial transaction that created this performance obligation.',
    `parent_performance_obligation_id` BIGINT COMMENT 'Self-referencing FK on performance_obligation (parent_performance_obligation_id)',
    `accounting_period` STRING COMMENT 'The accounting period (YYYY-MM or YYYY-QN format) in which this performance obligation was initially recorded.',
    `allocated_transaction_price` DECIMAL(18,2) COMMENT 'The portion of the total contract transaction price allocated to this specific performance obligation based on relative standalone selling prices.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance obligation record was first created in the billing system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this performance obligation.',
    `is_distinct` BOOLEAN COMMENT 'Indicates whether this performance obligation is distinct and separately identifiable from other promises in the contract per ASC 606 criteria.',
    `is_material_right` BOOLEAN COMMENT 'Indicates whether this performance obligation represents a material right granted to the customer (e.g., loyalty points, future purchase discounts) that must be accounted for separately.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this performance obligation is part of a recurring revenue stream (e.g., subscription, season pass with periodic content drops).',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'The net amount payable to the publisher after platform holder fees are deducted from the allocated transaction price.',
    `notes` STRING COMMENT 'Free-text field for additional context, special handling instructions, or accounting notes related to this performance obligation.',
    `obligation_code` STRING COMMENT 'Business-assigned unique code identifying this performance obligation for external reporting and reconciliation.',
    `obligation_description` STRING COMMENT 'Detailed description of the goods or services promised to the customer under this performance obligation.',
    `obligation_name` STRING COMMENT 'Human-readable name describing the performance obligation (e.g., Base Game License, Season Pass Content, In-Game Currency Bundle).',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the performance obligation indicating whether it has been fulfilled or is still outstanding.',
    `obligation_type` STRING COMMENT 'Classification of the performance obligation based on the nature of the deliverable in the gaming context.',
    `platform_fee_percentage` DECIMAL(18,2) COMMENT 'The percentage of the transaction price retained by the platform holder as their distribution fee (e.g., 30% for most console/mobile stores, 12% for Epic).',
    `quantity` STRING COMMENT 'The number of units of this performance obligation purchased (typically 1 for game licenses, may be higher for virtual currency bundles).',
    `recognition_end_date` DATE COMMENT 'The date when revenue recognition is expected to be complete for this performance obligation. Null for point-in-time recognition.',
    `recognition_method` STRING COMMENT 'The method used to recognize revenue for this performance obligation (point in time for game licenses, over time for subscriptions and live service content).',
    `recognition_start_date` DATE COMMENT 'The date when revenue recognition begins for this performance obligation, typically when control transfers to the customer.',
    `refund_eligible` BOOLEAN COMMENT 'Indicates whether this performance obligation is eligible for refund based on platform policies and time elapsed since purchase.',
    `refund_window_end_date` DATE COMMENT 'The last date on which the customer can request a refund for this performance obligation per platform refund policies.',
    `remaining_deferred_revenue` DECIMAL(18,2) COMMENT 'Amount of allocated transaction price not yet recognized as revenue, representing future performance obligations.',
    `revenue_category` STRING COMMENT 'High-level revenue stream classification for financial reporting and analytics.',
    `revenue_recognized_to_date` DECIMAL(18,2) COMMENT 'Cumulative amount of revenue recognized for this performance obligation as of the current reporting period.',
    `satisfaction_date` DATE COMMENT 'The actual date when the performance obligation was fully satisfied and control transferred to the customer.',
    `sku` STRING COMMENT 'Platform-specific SKU or product identifier for the item associated with this performance obligation.',
    `standalone_selling_price` DECIMAL(18,2) COMMENT 'The price at which the entity would sell the promised good or service separately to a customer, used for transaction price allocation.',
    `updated_by` STRING COMMENT 'User or system identifier that last modified this performance obligation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance obligation record was last modified.',
    `created_by` STRING COMMENT 'User or system identifier that created this performance obligation record.',
    CONSTRAINT pk_performance_obligation PRIMARY KEY(`performance_obligation_id`)
) COMMENT 'Master reference table for performance_obligation. Referenced by performance_obligation_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`payment_provider` (
    `payment_provider_id` BIGINT COMMENT 'Primary key for payment_provider',
    `parent_payment_provider_id` BIGINT COMMENT 'Self-referencing FK on payment_provider (parent_payment_provider_id)',
    `activation_date` DATE COMMENT 'Date when the payment provider was first activated and made available for processing transactions in the billing system.',
    `api_endpoint_url` STRING COMMENT 'Base URL for the payment providers API endpoint used for transaction processing, refunds, and status queries. Confidential integration detail.',
    `api_version` STRING COMMENT 'Version of the payment provider API currently integrated (e.g., v1, v2, 2023-10-16). Critical for maintaining compatibility and planning upgrades.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the contract with the payment provider automatically renews at the end of the term. True if auto-renewal is enabled, False otherwise.',
    `average_authorization_time_ms` STRING COMMENT 'Average time in milliseconds for the payment provider to authorize a transaction. Key performance indicator for checkout experience optimization.',
    `chargeback_fee_amount` DECIMAL(18,2) COMMENT 'Fixed fee charged by the payment provider per chargeback dispute (e.g., 15.00 USD). Critical for chargeback cost tracking and fraud prevention ROI analysis.',
    `contact_email` STRING COMMENT 'Primary email address for contacting the payment providers account management or technical support team. Organizational contact data classified as confidential.',
    `contact_phone` STRING COMMENT 'Primary phone number for contacting the payment providers support team. Organizational contact data classified as confidential.',
    `contract_end_date` DATE COMMENT 'End date of the current contract or service agreement with the payment provider. Null for evergreen contracts. Used for renewal planning and vendor management.',
    `contract_start_date` DATE COMMENT 'Start date of the current contract or service agreement with the payment provider. Used for contract lifecycle management and renewal planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment provider record was first created in the billing system. Used for audit trail and data lineage tracking.',
    `deactivation_date` DATE COMMENT 'Date when the payment provider was deactivated or deprecated. Null for currently active providers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment provider record was last updated. Used for change tracking and audit purposes.',
    `merchant_account_id` STRING COMMENT 'The merchant account identifier or merchant ID assigned by the payment provider to the gaming company. Used for reconciliation and settlement tracking.',
    `notes` STRING COMMENT 'Free-text notes about the payment provider, including special configuration details, known issues, integration quirks, or historical context. Used by billing operations and engineering teams.',
    `pci_certification_date` DATE COMMENT 'Date of the most recent PCI DSS compliance certification for this payment provider. Must be renewed annually per PCI DSS requirements.',
    `pci_certification_expiry_date` DATE COMMENT 'Expiration date of the current PCI DSS compliance certification. Providers must be recertified before this date to maintain active status.',
    `pci_compliance_level` STRING COMMENT 'Payment Card Industry Data Security Standard (PCI DSS) compliance level of the provider. Level 1 is the highest (processing over 6M transactions annually), Level 4 is the lowest (under 1M transactions). Critical for security and audit requirements.',
    `priority_rank` STRING COMMENT 'Priority ranking for routing transactions when multiple providers support the same payment method and region (1 = highest priority). Used in payment routing logic to optimize for cost, performance, or approval rates.',
    `provider_code` STRING COMMENT 'Short alphanumeric code used internally to identify the payment provider in transaction records and system integrations.',
    `provider_name` STRING COMMENT 'Official business name of the payment service provider (e.g., Stripe, PayPal, Adyen, Xsolla, Braintree).',
    `provider_type` STRING COMMENT 'Classification of the payment provider based on service model: payment gateway (Stripe, Adyen), payment processor (Worldpay), digital wallet (PayPal, Apple Pay), bank transfer (ACH, SEPA), mobile payment (Google Pay, Samsung Pay), or console first-party (PlayStation Network, Xbox Live, Nintendo eShop).',
    `refund_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the payment provider for processing refunds. Some providers refund the original transaction fee, others charge a separate refund fee.',
    `risk_score` STRING COMMENT 'Internal risk assessment score for the payment provider (0-100 scale, higher = higher risk). Based on chargeback rates, downtime history, compliance issues, and financial stability. Used for provider selection and monitoring.',
    `settlement_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the payment provider settles funds to the merchant account (e.g., USD, EUR). May differ from transaction currency.',
    `settlement_period_days` STRING COMMENT 'Number of days between transaction authorization and funds settlement to the merchant account (e.g., 2 for T+2 settlement). Critical for cash flow forecasting and working capital management.',
    `payment_provider_status` STRING COMMENT 'Current operational status of the payment provider in the billing system. Active providers are available for new transactions; inactive or deprecated providers may only process refunds or chargebacks for historical transactions.',
    `supported_currencies` STRING COMMENT 'Comma-separated list of ISO 4217 three-letter currency codes that this payment provider supports (e.g., USD,EUR,GBP,JPY,KRW). Used to route transactions to appropriate providers based on player currency.',
    `supported_payment_methods` STRING COMMENT 'Comma-separated list of payment methods supported by this provider (e.g., credit_card, debit_card, paypal, apple_pay, google_pay, bank_transfer, gift_card, cryptocurrency). Used for payment method routing logic.',
    `supported_regions` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes or region codes where this payment provider is available (e.g., USA,CAN,GBR,DEU,JPN,KOR,BRA). Used for geographic routing of payment transactions.',
    `supports_3ds` BOOLEAN COMMENT 'Indicates whether the payment provider supports 3D Secure authentication (3DS 1.0 or 3DS 2.0) for fraud prevention and liability shift. Required in many European markets under PSD2 Strong Customer Authentication.',
    `supports_recurring_billing` BOOLEAN COMMENT 'Indicates whether the payment provider supports recurring billing for subscriptions (e.g., monthly game pass, season pass auto-renewal). True if supported, False otherwise.',
    `supports_tokenization` BOOLEAN COMMENT 'Indicates whether the payment provider supports tokenization of payment instruments for secure storage and reuse. Critical for PCI DSS compliance and one-click checkout.',
    `three_ds_version` STRING COMMENT 'Version of 3D Secure protocol supported by the payment provider. 3DS 2.x provides better mobile experience and lower friction than 1.0.',
    `transaction_fee_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the fixed transaction fee (e.g., USD, EUR). Used for multi-currency fee reconciliation.',
    `transaction_fee_fixed_amount` DECIMAL(18,2) COMMENT 'Fixed per-transaction fee charged by the payment provider in the providers base currency (e.g., 0.30 USD). Combined with percentage fee for total cost calculation.',
    `transaction_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage-based transaction fee charged by the payment provider (e.g., 0.0290 for 2.90%). Used for revenue recognition and cost allocation calculations.',
    `uptime_percentage` DECIMAL(18,2) COMMENT 'Rolling 30-day uptime percentage for the payment providers API (e.g., 99.95). Tracked for SLA compliance and provider performance evaluation.',
    `webhook_url` STRING COMMENT 'URL endpoint where the payment provider sends asynchronous notifications for transaction events (payment completed, refund processed, chargeback initiated). Used for real-time payment status updates.',
    CONSTRAINT pk_payment_provider PRIMARY KEY(`payment_provider_id`)
) COMMENT 'Master reference table for payment_provider. Referenced by payment_provider_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`contract` (
    `contract_id` BIGINT COMMENT 'Primary key for contract',
    `master_contract_id` BIGINT COMMENT 'Self-referencing FK on contract (master_contract_id)',
    `amendment_count` STRING COMMENT 'Number of formal amendments or addendums executed against this contract since its original signature.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at the end of its term unless explicitly terminated.',
    `chargeback_liability_party` STRING COMMENT 'Specifies which party bears financial responsibility for payment chargebacks and disputes under this contract.',
    `confidentiality_period_years` STRING COMMENT 'Number of years after contract termination during which confidentiality obligations remain in effect.',
    `contract_document_url` STRING COMMENT 'Secure storage location or reference path to the digitally signed contract document for audit and compliance purposes.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the contract, used in communications with platform holders and partners.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the contract indicating its operational validity and enforceability.',
    `contract_type` STRING COMMENT 'Classification of the contract based on its commercial structure and payment model.',
    `contract_value_estimate` DECIMAL(18,2) COMMENT 'Estimated total monetary value of the contract over its full term, used for financial planning and forecasting. Nullable for open-ended or variable contracts.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this contract record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the billing system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this contract.',
    `dispute_resolution_method` STRING COMMENT 'Contractually agreed mechanism for resolving disputes between parties.',
    `effective_end_date` DATE COMMENT 'Date when the contract terms expire or are no longer binding. Nullable for open-ended contracts.',
    `effective_start_date` DATE COMMENT 'Date when the contract terms become legally binding and enforceable.',
    `excluded_territories` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes explicitly excluded from this contract. Used for regional licensing restrictions.',
    `governing_law_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the legal jurisdiction whose laws govern the interpretation and enforcement of this contract.',
    `included_territories` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this contract is valid. Nullable if territory_scope is global.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the contract. Nullable if no amendments have been executed.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount that the platform holder commits to pay regardless of actual sales performance. Nullable if no minimum guarantee exists.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this contract record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was last updated in the billing system.',
    `notes` STRING COMMENT 'Free-text field for additional context, special terms, or operational notes relevant to contract administration.',
    `payment_frequency` STRING COMMENT 'Cadence at which settlement payments are processed and disbursed to the publisher under this contract.',
    `payment_terms_days` STRING COMMENT 'Number of days after the end of a billing period within which payment must be remitted. Common values are 30, 45, or 60 days.',
    `pci_compliance_level` STRING COMMENT 'PCI DSS compliance tier required for this contract based on transaction volume and payment processing responsibilities.',
    `platform_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of gross revenue retained by the platform holder as commission for distribution and payment processing services.',
    `platform_holder_id` BIGINT COMMENT 'Reference to the platform holder or storefront partner (Steam, Epic, Sony, Microsoft, Apple, Google) with whom this contract is established.',
    `publisher_id` BIGINT COMMENT 'Reference to the game publisher entity that is party to this contract.',
    `refund_policy_type` STRING COMMENT 'Classification of the refund policy governing transactions under this contract.',
    `refund_window_days` STRING COMMENT 'Number of days after purchase during which customers may request a refund under the contract terms. Nullable if refund_policy_type is no_refunds.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to contract expiration that either party must provide notice to prevent automatic renewal. Nullable if auto_renewal_flag is false.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of gross revenue retained by the publisher after platform fees. Typically ranges from 70% to 88% depending on platform and volume tiers.',
    `signature_date` DATE COMMENT 'Date when all parties executed the contract, establishing legal agreement. May differ from effective_start_date.',
    `signed_by_platform` STRING COMMENT 'Name and title of the authorized signatory who executed the contract on behalf of the platform holder.',
    `signed_by_publisher` STRING COMMENT 'Name and title of the authorized signatory who executed the contract on behalf of the publisher.',
    `tax_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the primary tax jurisdiction governing this contract for withholding and reporting purposes.',
    `termination_notice_days` STRING COMMENT 'Minimum number of days advance notice required by either party to terminate the contract before its natural expiration.',
    `territory_scope` STRING COMMENT 'Geographic scope of the contract defining where the agreement terms apply.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'Percentage of payment withheld by the platform holder for tax remittance to applicable jurisdictions. Varies by publisher domicile and tax treaties.',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Master reference table for contract. Referenced by contract_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`product` (
    `product_id` BIGINT COMMENT 'Primary key for product',
    `age_rating` STRING COMMENT 'ESRB age rating classification for the product (E=Everyone, E10+=Everyone 10+, T=Teen, M=Mature 17+, AO=Adults Only 18+, RP=Rating Pending).',
    `base_price` DECIMAL(18,2) COMMENT 'Standard retail price for the product before any discounts, promotions, or regional adjustments. Expressed in the default currency (USD).',
    `bundle_flag` BOOLEAN COMMENT 'Indicates whether this product is a bundle containing multiple sub-products sold as a single SKU.',
    `content_descriptor` STRING COMMENT 'Comma-separated list of ESRB content descriptors (e.g., Violence, Blood, Strong Language) that describe content elements in the product.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product record was first created in the billing system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the base price.',
    `product_description` STRING COMMENT 'Detailed marketing description of the product, including features, gameplay, and content overview.',
    `developer_id` BIGINT COMMENT 'Reference to the development studio that created this product.',
    `discontinuation_date` DATE COMMENT 'Date when the product was delisted or removed from sale. Null for active products.',
    `early_access_flag` BOOLEAN COMMENT 'Indicates whether this product is currently in early access or pre-release state.',
    `genre` STRING COMMENT 'Primary game genre classification (e.g., Action, RPG, Strategy, Sports, Simulation).',
    `is_refundable` BOOLEAN COMMENT 'Indicates whether this product is eligible for customer refunds per platform and internal refund policies.',
    `is_subscription` BOOLEAN COMMENT 'Indicates whether this product is sold as a recurring subscription (true) or one-time purchase (false).',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this product record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product record was last updated in the billing system.',
    `parent_product_id` BIGINT COMMENT 'Reference to the parent base game product for DLC, expansions, and season passes. Null for standalone products.',
    `pci_dss_scope` BOOLEAN COMMENT 'Indicates whether transactions for this product involve payment card data and fall under PCI DSS compliance scope.',
    `platform` STRING COMMENT 'Target gaming platform or device ecosystem for which this product is available.',
    `platform_revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of gross revenue retained by the platform holder (e.g., 30% for Steam, 12% for Epic). Used for payout settlement calculations.',
    `pre_order_available` BOOLEAN COMMENT 'Indicates whether this product is available for pre-order purchase before the official release date.',
    `pre_order_bonus_description` STRING COMMENT 'Description of exclusive content or bonuses provided to customers who pre-order this product. Null if no pre-order bonus exists.',
    `product_type` STRING COMMENT 'Classification of the product offering type within the gaming ecosystem.',
    `publisher_id` BIGINT COMMENT 'Reference to the publishing entity responsible for this product.',
    `refund_window_days` STRING COMMENT 'Number of days from purchase during which a refund can be requested. Null if product is not refundable.',
    `regional_availability` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this product is available for sale. Empty indicates global availability.',
    `regional_restrictions` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this product is explicitly blocked or restricted from sale due to regulatory or licensing constraints.',
    `release_date` DATE COMMENT 'Official public release date of the product on the specified platform.',
    `revenue_recognition_model` STRING COMMENT 'Accounting treatment model for revenue recognition per ASC 606 / IFRS 15 standards.',
    `short_description` STRING COMMENT 'Brief summary description of the product used in storefront listings and search results (typically 100-200 characters).',
    `sku` STRING COMMENT 'Externally-known unique product code used across storefronts (Steam, Epic, console first-party, mobile app stores) for catalog identification and inventory tracking.',
    `product_status` STRING COMMENT 'Current lifecycle state of the product in the catalog and billing system.',
    `storefront_id` STRING COMMENT 'External identifier assigned by the storefront platform (Steam App ID, Epic Catalog Item ID, PlayStation Product ID, etc.).',
    `storefront_name` STRING COMMENT 'Name of the digital storefront or marketplace where this product is sold.',
    `subscription_billing_cycle` STRING COMMENT 'Recurring billing frequency for subscription products. Null for non-subscription products.',
    `tax_category` STRING COMMENT 'Tax classification category used for revenue recognition and tax calculation across jurisdictions.',
    `title` STRING COMMENT 'The official display name of the product as shown to customers across all storefronts and platforms.',
    `trial_available` BOOLEAN COMMENT 'Indicates whether a free trial or demo version is available for this product.',
    `trial_duration_days` STRING COMMENT 'Length of the free trial period in days. Null if no trial is available.',
    `virtual_currency_amount` STRING COMMENT 'Quantity of in-game virtual currency included with this product purchase. Null for non-currency products.',
    `virtual_currency_type` STRING COMMENT 'Type or denomination of virtual currency (e.g., V-Bucks, Apex Coins, Riot Points). Null for non-currency products.',
    `created_by` STRING COMMENT 'User identifier or system account that created this product record.',
    CONSTRAINT pk_product PRIMARY KEY(`product_id`)
) COMMENT 'Master reference table for product. Referenced by product_id.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`transaction` (
    `transaction_id` BIGINT COMMENT 'Primary key for transaction',
    `original_transaction_id` BIGINT COMMENT 'Self-referencing FK on transaction (original_transaction_id)',
    `authorization_code` STRING COMMENT 'The authorization code returned by the payment processor or issuing bank confirming the transaction was approved.',
    `authorization_timestamp` TIMESTAMP COMMENT 'The date and time when the payment was authorized by the payment processor or issuing bank.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the billing address country of the payment instrument.',
    `billing_postal_code` STRING COMMENT 'The postal or ZIP code of the billing address associated with the payment instrument.',
    `chargeback_reason_code` STRING COMMENT 'The reason code provided by the card network or issuing bank for a chargeback dispute.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this transaction record was first created in the billing system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the transaction currency (e.g., USD, EUR, GBP, JPY).',
    `decline_reason` STRING COMMENT 'The reason provided by the payment processor or issuing bank if the transaction was declined or failed.',
    `device_fingerprint` STRING COMMENT 'A unique identifier representing the device used to initiate the transaction, used for fraud prevention and device tracking.',
    `dispute_status` STRING COMMENT 'The current status of a chargeback or payment dispute associated with this transaction.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied if the transaction involved currency conversion from player currency to settlement currency.',
    `fraud_review_status` STRING COMMENT 'The outcome of the fraud review process for this transaction.',
    `fraud_score` DECIMAL(18,2) COMMENT 'A risk score assigned by the fraud detection system indicating the likelihood that this transaction is fraudulent (0-100 scale).',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total transaction amount before any deductions, fees, or adjustments.',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice associated with this transaction, if applicable.',
    `ip_address` STRING COMMENT 'The IP address from which the transaction was initiated, used for fraud detection and geolocation analysis.',
    `is_recurring` BOOLEAN COMMENT 'Flag indicating whether this transaction is part of a recurring billing cycle (e.g., subscription renewal).',
    `is_test_transaction` BOOLEAN COMMENT 'Flag indicating whether this transaction was executed in a test or sandbox environment rather than production.',
    `net_amount` DECIMAL(18,2) COMMENT 'The final amount received by the merchant after all fees, taxes, and deductions have been applied.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context about the transaction for customer support or audit purposes.',
    `order_id` BIGINT COMMENT 'Identifier of the order that generated this transaction.',
    `payment_gateway` STRING COMMENT 'The payment gateway or processor used to execute this transaction.',
    `payment_method_id` BIGINT COMMENT 'Identifier of the payment instrument used for this transaction (credit card, PayPal, digital wallet, platform wallet).',
    `payment_processing_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged by the payment processor or gateway for processing the transaction.',
    `payment_processor_transaction_id` STRING COMMENT 'The unique transaction identifier assigned by the external payment processor or gateway for reconciliation purposes.',
    `payout_batch_id` BIGINT COMMENT 'Identifier of the payout batch in which this transaction was settled with the platform holder or payment processor.',
    `platform_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged by the storefront platform holder (e.g., Steam 30% revenue share, Apple App Store 15-30%).',
    `player_id` BIGINT COMMENT 'Identifier of the player who initiated or is associated with this transaction.',
    `refund_reason` STRING COMMENT 'The business reason for issuing a refund, if this transaction is a refund type.',
    `revenue_recognition_date` DATE COMMENT 'The date on which revenue from this transaction is recognized for accounting purposes, following GAAP or IFRS standards.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which funds were settled to the merchant account.',
    `settlement_timestamp` TIMESTAMP COMMENT 'The date and time when funds were settled and transferred to the merchant account.',
    `storefront_id` BIGINT COMMENT 'Identifier of the storefront platform where the transaction occurred (Steam, Epic Games Store, PlayStation Store, Xbox Store, App Store, Google Play).',
    `subscription_id` BIGINT COMMENT 'Identifier of the subscription if this transaction is part of a recurring subscription billing cycle.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applied to the transaction, including sales tax, VAT, GST, or other applicable taxes.',
    `transaction_number` STRING COMMENT 'Externally-visible unique transaction reference number used for customer support, reconciliation, and audit trails across storefronts.',
    `transaction_status` STRING COMMENT 'Current lifecycle state of the transaction in the payment processing workflow.',
    `transaction_timestamp` TIMESTAMP COMMENT 'The precise date and time when the transaction was initiated by the player or system, representing the business event time.',
    `transaction_type` STRING COMMENT 'Classification of the transaction indicating the nature of the financial event.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this transaction record was last modified.',
    CONSTRAINT pk_transaction PRIMARY KEY(`transaction_id`)
) COMMENT 'Master reference table for transaction. Referenced by transaction_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `gaming_ecm`.`billing`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `gaming_ecm`.`billing`.`chargeback`(`chargeback_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_settlement_batch_id` FOREIGN KEY (`settlement_batch_id`) REFERENCES `gaming_ecm`.`billing`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `gaming_ecm`.`billing`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ADD CONSTRAINT `fk_billing_subscription_cycle_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ADD CONSTRAINT `fk_billing_subscription_cycle_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ADD CONSTRAINT `fk_billing_subscription_cycle_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `gaming_ecm`.`billing`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ADD CONSTRAINT `fk_billing_subscription_cycle_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ADD CONSTRAINT `fk_billing_storefront_order_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_bundle_parent_line_id` FOREIGN KEY (`bundle_parent_line_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order_line`(`storefront_order_line_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `gaming_ecm`.`billing`.`bank_account`(`bank_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ADD CONSTRAINT `fk_billing_payout_line_platform_payout_id` FOREIGN KEY (`platform_payout_id`) REFERENCES `gaming_ecm`.`billing`.`platform_payout`(`platform_payout_id`);
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ADD CONSTRAINT `fk_billing_billing_tax_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_original_recognition_event_revenue_recognition_id` FOREIGN KEY (`original_recognition_event_revenue_recognition_id`) REFERENCES `gaming_ecm`.`billing`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `gaming_ecm`.`billing`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ADD CONSTRAINT `fk_billing_promo_redemption_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `gaming_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ADD CONSTRAINT `fk_billing_promo_redemption_promo_code_id` FOREIGN KEY (`promo_code_id`) REFERENCES `gaming_ecm`.`billing`.`promo_code`(`promo_code_id`);
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ADD CONSTRAINT `fk_billing_promo_redemption_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ADD CONSTRAINT `fk_billing_promo_redemption_transaction_storefront_order_id` FOREIGN KEY (`transaction_storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_dunning_cycle_id` FOREIGN KEY (`dunning_cycle_id`) REFERENCES `gaming_ecm`.`billing`.`dunning_cycle`(`dunning_cycle_id`);
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `gaming_ecm`.`billing`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_subscription_cycle_id` FOREIGN KEY (`subscription_cycle_id`) REFERENCES `gaming_ecm`.`billing`.`subscription_cycle`(`subscription_cycle_id`);
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ADD CONSTRAINT `fk_billing_payment_hold_fraud_rule_id` FOREIGN KEY (`fraud_rule_id`) REFERENCES `gaming_ecm`.`billing`.`fraud_rule`(`fraud_rule_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ADD CONSTRAINT `fk_billing_payment_hold_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ADD CONSTRAINT `fk_billing_payment_hold_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `gaming_ecm`.`billing`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ADD CONSTRAINT `fk_billing_payment_hold_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ADD CONSTRAINT `fk_billing_payment_hold_original_payment_hold_id` FOREIGN KEY (`original_payment_hold_id`) REFERENCES `gaming_ecm`.`billing`.`payment_hold`(`payment_hold_id`);
ALTER TABLE `gaming_ecm`.`billing`.`dunning_cycle` ADD CONSTRAINT `fk_billing_dunning_cycle_previous_dunning_cycle_id` FOREIGN KEY (`previous_dunning_cycle_id`) REFERENCES `gaming_ecm`.`billing`.`dunning_cycle`(`dunning_cycle_id`);
ALTER TABLE `gaming_ecm`.`billing`.`fraud_rule` ADD CONSTRAINT `fk_billing_fraud_rule_superseded_fraud_rule_id` FOREIGN KEY (`superseded_fraud_rule_id`) REFERENCES `gaming_ecm`.`billing`.`fraud_rule`(`fraud_rule_id`);
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` ADD CONSTRAINT `fk_billing_bank_account_payment_provider_id` FOREIGN KEY (`payment_provider_id`) REFERENCES `gaming_ecm`.`billing`.`payment_provider`(`payment_provider_id`);
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` ADD CONSTRAINT `fk_billing_bank_account_primary_bank_account_id` FOREIGN KEY (`primary_bank_account_id`) REFERENCES `gaming_ecm`.`billing`.`bank_account`(`bank_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`settlement_batch` ADD CONSTRAINT `fk_billing_settlement_batch_previous_settlement_batch_id` FOREIGN KEY (`previous_settlement_batch_id`) REFERENCES `gaming_ecm`.`billing`.`settlement_batch`(`settlement_batch_id`);
ALTER TABLE `gaming_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `gaming_ecm`.`billing`.`contract`(`contract_id`);
ALTER TABLE `gaming_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_parent_obligation_id` FOREIGN KEY (`parent_obligation_id`) REFERENCES `gaming_ecm`.`billing`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `gaming_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_product_id` FOREIGN KEY (`product_id`) REFERENCES `gaming_ecm`.`billing`.`product`(`product_id`);
ALTER TABLE `gaming_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_transaction_id` FOREIGN KEY (`transaction_id`) REFERENCES `gaming_ecm`.`billing`.`transaction`(`transaction_id`);
ALTER TABLE `gaming_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_parent_performance_obligation_id` FOREIGN KEY (`parent_performance_obligation_id`) REFERENCES `gaming_ecm`.`billing`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` ADD CONSTRAINT `fk_billing_payment_provider_parent_payment_provider_id` FOREIGN KEY (`parent_payment_provider_id`) REFERENCES `gaming_ecm`.`billing`.`payment_provider`(`payment_provider_id`);
ALTER TABLE `gaming_ecm`.`billing`.`contract` ADD CONSTRAINT `fk_billing_contract_master_contract_id` FOREIGN KEY (`master_contract_id`) REFERENCES `gaming_ecm`.`billing`.`contract`(`contract_id`);
ALTER TABLE `gaming_ecm`.`billing`.`transaction` ADD CONSTRAINT `fk_billing_transaction_original_transaction_id` FOREIGN KEY (`original_transaction_id`) REFERENCES `gaming_ecm`.`billing`.`transaction`(`transaction_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `gaming_ecm`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction ID');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `chargeback_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Flag');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{8,12}$');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|issued|paid|void|disputed|overdue');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|proforma|recurring');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `paid_date` SET TAGS ('dbx_business_glossary_term' = 'Paid Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|console|in_game|customer_service|platform_direct');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'immediate|net_15|net_30|net_45|net_60|net_90');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `platform_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `platform_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Partner ID');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Category');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_value_regex' = 'immediate|deferred|subscription|usage_based|milestone');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `storefront_code` SET TAGS ('dbx_business_glossary_term' = 'Storefront Code');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `tax_exemption_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Code');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `voided_reason` SET TAGS ('dbx_business_glossary_term' = 'Voided Reason');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `voided_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Voided Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Iap Transaction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Transaction Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `chargeback_date` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `discount_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Code');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'active|refunded|partially_refunded|disputed|chargeback');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_total` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `net_revenue` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `platform_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `platform_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Rate');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `refund_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligible Flag');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `refund_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Window End Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Category');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_value_regex' = 'immediate|deferred|subscription|usage_based');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition End Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Start Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{6,20}$');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `subscription_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Period End Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `subscription_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Period Start Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `subtotal` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `gaming_ecm`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `card_expiry_month` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Month');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `card_expiry_month` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `card_expiry_month` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `card_expiry_year` SET TAGS ('dbx_business_glossary_term' = 'Card Expiry Year');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `card_expiry_year` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `card_expiry_year` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four_digits` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review Status');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|approved|declined|pending_review|flagged');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `fraud_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `gateway_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Fee Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `gateway_provider` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Provider');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `gateway_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Gateway Transaction ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `is_test_transaction` SET TAGS ('dbx_business_glossary_term' = 'Is Test Transaction');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `payer_email` SET TAGS ('dbx_business_glossary_term' = 'Payer Email Address');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `payer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `payer_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `payer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `platform_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `purchase_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Type');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `refund_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,32}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `three_ds_authentication_status` SET TAGS ('dbx_business_glossary_term' = '3D Secure (3DS) Authentication Status');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `three_ds_authentication_status` SET TAGS ('dbx_value_regex' = 'authenticated|not_authenticated|attempted|failed|not_applicable');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference Number');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,32}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `virtual_currency_account_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Wallet ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `added_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Added Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `card_brand` SET TAGS ('dbx_business_glossary_term' = 'Card Brand');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `card_brand` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `deleted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deleted Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `expiry_month` SET TAGS ('dbx_business_glossary_term' = 'Expiry Month');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `expiry_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Expiry Notification Sent');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `expiry_year` SET TAGS ('dbx_business_glossary_term' = 'Expiry Year');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `failed_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Transaction Count');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `gdpr_consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'GDPR Consent Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `instrument_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument Status');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `instrument_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|failed_verification|deleted');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Payment Method');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `is_verified` SET TAGS ('dbx_business_glossary_term' = 'Is Verified');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `issuing_bank_bin` SET TAGS ('dbx_business_glossary_term' = 'Bank Identification Number (BIN)');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `issuing_bank_bin` SET TAGS ('dbx_value_regex' = '^[0-9]{6,8}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `issuing_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank Name');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_business_glossary_term' = 'Last Four Digits');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `last_four_digits` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `last_used_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Used Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `pci_compliance_scope` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS Compliance Scope');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `pci_compliance_scope` SET TAGS ('dbx_value_regex' = 'in_scope|out_of_scope|tokenized');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `recurring_billing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Recurring Billing Enabled');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `successful_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Successful Transaction Count');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `three_d_secure_enrolled` SET TAGS ('dbx_business_glossary_term' = '3D Secure (3DS) Enrolled');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `tokenized_reference` SET TAGS ('dbx_business_glossary_term' = 'Tokenized Payment Reference');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `tokenized_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `tokenized_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `vault_customer_reference` SET TAGS ('dbx_business_glossary_term' = 'Vault Customer ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `vault_provider` SET TAGS ('dbx_business_glossary_term' = 'Vault Provider');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `vault_provider` SET TAGS ('dbx_value_regex' = 'braintree|stripe|adyen|paypal|authorize_net|worldpay');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'avs|cvv|3ds|micro_deposit|manual');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`refund` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`refund` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund ID');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback ID');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Agent ID');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Iap Transaction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch ID');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Support Ticket ID');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Approved Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `credit_applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Applied Amount');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `credit_balance_remaining` SET TAGS ('dbx_business_glossary_term' = 'Credit Balance Remaining');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `credit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Expiry Date');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_value_regex' = '^CM-[A-Z0-9]{8,16}$');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `is_automated_refund` SET TAGS ('dbx_business_glossary_term' = 'Is Automated Refund');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `is_partial_refund` SET TAGS ('dbx_business_glossary_term' = 'Is Partial Refund');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Refund Notes');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `original_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Amount');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `platform_fee_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Refund Amount');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Refund Policy Version');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `processor_refund_reference` SET TAGS ('dbx_business_glossary_term' = 'Processor Refund ID');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Description');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|discrepancy|under_review');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `refund_number` SET TAGS ('dbx_business_glossary_term' = 'Refund Number');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `refund_number` SET TAGS ('dbx_value_regex' = '^RFN-[A-Z0-9]{8,16}$');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_business_glossary_term' = 'Refund Type');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_value_regex' = 'cash_refund|store_credit|platform_wallet_credit|chargeback_reversal|goodwill_credit');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `rejected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Rejected Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `requested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Requested Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `return_method` SET TAGS ('dbx_business_glossary_term' = 'Return Method');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `return_method` SET TAGS ('dbx_value_regex' = 'original_payment_method|store_credit|platform_wallet|bank_transfer|check');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `storefront_code` SET TAGS ('dbx_business_glossary_term' = 'Storefront Code');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `tax_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Refund Amount');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback ID');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Iap Transaction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `acquiring_bank` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Amount');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `arbitration_fee` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Fee');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `arbitration_requested` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Requested');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `card_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `card_network` SET TAGS ('dbx_business_glossary_term' = 'Card Network');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `card_network` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|jcb|unionpay');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `cardholder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `chargeback_number` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Number');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Status');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_value_regex' = 'received|under-review|evidence-submitted|won|lost|pre-arbitration');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `dispute_category` SET TAGS ('dbx_business_glossary_term' = 'Dispute Category');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `dispute_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Description');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `evidence_documents` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documents');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `evidence_documents` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `evidence_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Submission Date');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `fee` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Fee');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `fraud_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fraud Indicator');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `issuing_bank` SET TAGS ('dbx_business_glossary_term' = 'Issuing Bank');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `original_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Original Transaction Date');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit-card|debit-card|prepaid-card|digital-wallet');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `platform_storefront` SET TAGS ('dbx_business_glossary_term' = 'Platform Storefront');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `purchase_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Type');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `purchase_type` SET TAGS ('dbx_value_regex' = 'game-purchase|dlc|mtx|subscription|season-pass|in-game-currency');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Received Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'merchant-won|merchant-lost|partially-reversed|withdrawn');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `response_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline Date');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `reversal_amount` SET TAGS ('dbx_business_glossary_term' = 'Reversal Amount');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `total_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Total Financial Impact');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` SET TAGS ('dbx_subdomain' = 'subscription_operations');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Campaign ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gifted By Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `subscription_player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Channel');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `auto_renew_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Renew Enabled');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|lifetime');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `cancellation_feedback` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Feedback');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'too_expensive|not_enough_value|technical_issues|switching_platform|no_longer_playing|other');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `current_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Current Period End Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `current_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Current Period Start Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `discount_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Code');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `discount_end_date` SET TAGS ('dbx_business_glossary_term' = 'Discount End Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `external_subscription_reference` SET TAGS ('dbx_business_glossary_term' = 'External Subscription ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `failed_payment_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Payment Count');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `is_gift_subscription` SET TAGS ('dbx_business_glossary_term' = 'Is Gift Subscription');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `is_trial_active` SET TAGS ('dbx_business_glossary_term' = 'Is Trial Active');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `next_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Next Billing Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `platform_subscription_status` SET TAGS ('dbx_business_glossary_term' = 'Platform Subscription Status');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Subscription Price');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Code');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `renewal_count` SET TAGS ('dbx_business_glossary_term' = 'Renewal Count');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Start Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `subscription_number` SET TAGS ('dbx_business_glossary_term' = 'Subscription Number');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `subscription_number` SET TAGS ('dbx_value_regex' = '^SUB-[A-Z0-9]{8,16}$');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `subscription_status` SET TAGS ('dbx_business_glossary_term' = 'Subscription Status');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `subscription_status` SET TAGS ('dbx_value_regex' = 'active|paused|cancelled|expired|pending|trial');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `subscription_tier` SET TAGS ('dbx_business_glossary_term' = 'Subscription Tier');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `subscription_tier` SET TAGS ('dbx_value_regex' = 'basic|standard|premium|ultimate');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `trial_end_date` SET TAGS ('dbx_business_glossary_term' = 'Trial End Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `trial_period_days` SET TAGS ('dbx_business_glossary_term' = 'Trial Period Days');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` SET TAGS ('dbx_subdomain' = 'subscription_operations');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `subscription_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Cycle Identifier');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Billed Amount');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `billing_attempt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Billing Attempt Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `billing_period_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Type');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `billing_period_type` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `chargeback_date` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `chargeback_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Flag');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `cycle_end_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle End Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Cycle Number');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `cycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Start Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Status');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `failure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Code');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `failure_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Description');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `next_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Next Billing Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Notes');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `payment_gateway` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `payment_gateway` SET TAGS ('dbx_value_regex' = 'stripe|paypal|braintree|adyen|square|internal');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `platform_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Amount');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `platform_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Percentage');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `proration_amount` SET TAGS ('dbx_business_glossary_term' = 'Proration Amount');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `proration_applied` SET TAGS ('dbx_business_glossary_term' = 'Proration Applied');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `retry_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Attempt Count');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `settlement_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reference');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order ID');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `attribution_source` SET TAGS ('dbx_business_glossary_term' = 'Attribution Source');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `chargeback_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Flag');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `chargeback_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'pc|console|mobile|tablet|web');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `entitlement_delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Delivered Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `entitlement_delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Delivery Status');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `entitlement_delivery_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|delivered|failed|partially_delivered');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `is_first_purchase` SET TAGS ('dbx_business_glossary_term' = 'Is First Purchase Flag');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `is_subscription` SET TAGS ('dbx_business_glossary_term' = 'Is Subscription Flag');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'pending|payment_authorized|completed|cancelled|partially_refunded|fully_refunded');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `payment_authorized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Authorized Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `platform_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Amount');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `platform_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Percentage');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `player_region` SET TAGS ('dbx_business_glossary_term' = 'Player Region');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `player_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `promotional_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `refund_processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `refund_reason` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `refund_requested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Requested Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `storefront_platform` SET TAGS ('dbx_business_glossary_term' = 'Storefront Platform');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `storefront_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Line Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `bundle_parent_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Parent Line Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `mtx_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Mtx Catalog Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `catalog_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Offer Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `coupon_code` SET TAGS ('dbx_business_glossary_term' = 'Coupon Code');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `entitlement_delivered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Delivered Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_value_regex' = 'pending|delivered|failed|revoked|refunded');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `is_bundle_component` SET TAGS ('dbx_business_glossary_term' = 'Is Bundle Component Flag');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `line_subtotal` SET TAGS ('dbx_business_glossary_term' = 'Line Subtotal');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `line_total` SET TAGS ('dbx_business_glossary_term' = 'Line Total');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `net_revenue` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `platform_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Amount');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `platform_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `platform_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Percentage');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `platform_fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `refund_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligible Flag');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `refund_reason` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `revenue_recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Status');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `revenue_recognition_status` SET TAGS ('dbx_value_regex' = 'immediate|deferred|recognized|reversed');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `virtual_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Amount');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` SET TAGS ('dbx_subdomain' = 'revenue_settlement');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `platform_payout_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Payout ID');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry ID');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustments Amount');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `gl_posting_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Status');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `gl_posting_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|cancelled');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue Amount');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `net_payout_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payout Amount');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|direct_deposit|check|paypal');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `payout_date` SET TAGS ('dbx_business_glossary_term' = 'Payout Date');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `payout_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payout Period End Date');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `payout_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payout Period Start Date');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `platform_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Amount');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `platform_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Percentage');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `reconciliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|discrepancy|disputed|resolved');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `returns_refunds_amount` SET TAGS ('dbx_business_glossary_term' = 'Returns and Refunds Amount');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `settlement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reference Number');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `statement_url` SET TAGS ('dbx_business_glossary_term' = 'Statement URL');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withheld Amount');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `units_sold_total` SET TAGS ('dbx_business_glossary_term' = 'Units Sold Total');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` SET TAGS ('dbx_subdomain' = 'revenue_settlement');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `payout_line_id` SET TAGS ('dbx_business_glossary_term' = 'Payout Line ID (Identifier)');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio ID (Identifier)');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID (Identifier)');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `platform_payout_id` SET TAGS ('dbx_business_glossary_term' = 'Payout ID (Identifier)');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID (Identifier)');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU (Stock Keeping Unit) ID');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustments Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `chargebacks_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargebacks Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `gross_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Revenue Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `net_payout_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payout Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `platform_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `platform_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Rate');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Platform Name');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `platform_statement_reference` SET TAGS ('dbx_business_glossary_term' = 'Platform Statement Reference');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|disputed|adjusted|approved');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `refunds_amount` SET TAGS ('dbx_business_glossary_term' = 'Refunds Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `returns_amount` SET TAGS ('dbx_business_glossary_term' = 'Returns Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `sales_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Period End Date');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `sales_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Sales Period Start Date');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'SKU (Stock Keeping Unit) Code');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `sku_type` SET TAGS ('dbx_business_glossary_term' = 'SKU (Stock Keeping Unit) Type');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `units_sold` SET TAGS ('dbx_business_glossary_term' = 'Units Sold');
ALTER TABLE `gaming_ecm`.`billing`.`payout_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` SET TAGS ('dbx_subdomain' = 'revenue_settlement');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `billing_tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Tax Record ID');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `billing_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Billing Transaction ID');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `customer_business_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Business Flag');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `customer_tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Customer Tax Identifier');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `customer_tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `filing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period End Date');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `filing_period_reference` SET TAGS ('dbx_business_glossary_term' = 'Filing Period Reference');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `filing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Period Start Date');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `nexus_determination_basis` SET TAGS ('dbx_business_glossary_term' = 'Nexus Determination Basis');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `platform_holder` SET TAGS ('dbx_business_glossary_term' = 'Platform Holder');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `platform_tax_collection_flag` SET TAGS ('dbx_business_glossary_term' = 'Platform Tax Collection Flag');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `product_taxability_category` SET TAGS ('dbx_business_glossary_term' = 'Product Taxability Category');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `reverse_charge_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Charge Flag');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount Collected');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Name');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_authority_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Reference Number');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tax Calculation Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_engine_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Engine Name');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_engine_version` SET TAGS ('dbx_business_glossary_term' = 'Tax Engine Version');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_exemption_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Reference');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Flag');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Reason');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Invoice Number');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_jurisdiction_country` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Country Code');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_jurisdiction_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_jurisdiction_municipality` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Municipality');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_jurisdiction_state_province` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction State or Province');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_remittance_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Remittance Date');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_remittance_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Remittance Status');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_remittance_status` SET TAGS ('dbx_value_regex' = 'pending|remitted|deferred|disputed|refunded');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'vat|gst|sales_tax|digital_services_tax|withholding_tax|consumption_tax');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `taxable_amount` SET TAGS ('dbx_business_glossary_term' = 'Taxable Amount');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `vat_moss_scheme_flag` SET TAGS ('dbx_business_glossary_term' = 'VAT (Value-Added Tax) MOSS (Mini One Stop Shop) Scheme Flag');
ALTER TABLE `gaming_ecm`.`billing`.`billing_tax_record` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'VAT (Value-Added Tax) Registration Number');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` SET TAGS ('dbx_subdomain' = 'revenue_settlement');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Identifier');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `original_recognition_event_revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Original Revenue Recognition Event ID');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation ID');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|[0-9]{2})$');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Transaction Price Allocation Method');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'standalone_selling_price|residual|adjusted_market_assessment');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `contract_modification_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Modification Date');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `contract_modification_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Modification Flag');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `contract_modification_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Modification Reason');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `deferred_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Amount');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Notes');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `performance_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Description');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_event_number` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Event Number');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_event_number` SET TAGS ('dbx_value_regex' = '^RRE-[0-9]{10}$');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|proportional|milestone|usage_based');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Percentage');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Status');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_status` SET TAGS ('dbx_value_regex' = 'pending|recognized|deferred|partially_recognized|reversed|adjusted');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Revenue Amount');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `remaining_deferred_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Deferred Balance');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `revenue_category` SET TAGS ('dbx_value_regex' = 'product|service|hybrid');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `revenue_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Type');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Reversal Flag');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `service_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period End Date');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `service_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period Start Date');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `total_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Amount');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `gaming_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Code Identifier');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `applicable_sku_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicable SKU (Stock Keeping Unit) Scope');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `applicable_sku_scope` SET TAGS ('dbx_value_regex' = 'all|specific_skus|category|platform');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `attribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Attribution Channel');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `auto_apply_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Apply Flag');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `code_type` SET TAGS ('dbx_business_glossary_term' = 'Code Type');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `code_type` SET TAGS ('dbx_value_regex' = 'single_use|multi_use|unlimited');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `current_redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Current Redemption Count');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `deactivated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Deactivated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_value_regex' = 'fraud|abuse|campaign_ended|business_decision|error_correction');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|free_trial|bundle_discount');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `first_time_purchaser_only_flag` SET TAGS ('dbx_business_glossary_term' = 'First-Time Purchaser Only Flag');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `issuing_source` SET TAGS ('dbx_business_glossary_term' = 'Issuing Source');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `issuing_source` SET TAGS ('dbx_value_regex' = 'marketing_campaign|partner_promotion|influencer|customer_support|loyalty_program|event_giveaway');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `max_redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Redemption Count');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `maximum_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Name');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `per_player_redemption_limit` SET TAGS ('dbx_business_glossary_term' = 'Per-Player Redemption Limit');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Platform Scope');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `promo_code_code` SET TAGS ('dbx_business_glossary_term' = 'Promo Code String');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `promo_code_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `promo_code_status` SET TAGS ('dbx_business_glossary_term' = 'Promo Code Status');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `promo_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|depleted|suspended');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `public_description` SET TAGS ('dbx_business_glossary_term' = 'Public Description');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `sku_filter_list` SET TAGS ('dbx_business_glossary_term' = 'SKU (Stock Keeping Unit) Filter List');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `stackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Stackable Flag');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_business_glossary_term' = 'Terms and Conditions URL (Uniform Resource Locator)');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `terms_and_conditions_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `total_discount_amount_applied` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount Applied');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `total_revenue_attributed` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Attributed');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `gaming_ecm`.`billing`.`promo_code` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Valid Until Date');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `promo_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Redemption ID');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `promo_code_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code ID');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `transaction_storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'External Transaction ID');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `attribution_source` SET TAGS ('dbx_business_glossary_term' = 'Attribution Source');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|free_shipping|bonus_currency|free_item|bundle_discount');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code Expiration Date');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `final_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Order Amount');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `is_first_purchase` SET TAGS ('dbx_business_glossary_term' = 'Is First Purchase Flag');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `is_stackable` SET TAGS ('dbx_business_glossary_term' = 'Is Stackable Flag');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Redemption Notes');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `original_order_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Order Amount');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `partner_code` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `redemption_channel` SET TAGS ('dbx_business_glossary_term' = 'Redemption Channel');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `redemption_code` SET TAGS ('dbx_business_glossary_term' = 'Redemption Code');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `redemption_country_code` SET TAGS ('dbx_business_glossary_term' = 'Redemption Country Code');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `redemption_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `redemption_device_type` SET TAGS ('dbx_business_glossary_term' = 'Redemption Device Type');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `redemption_device_type` SET TAGS ('dbx_value_regex' = 'pc|console|mobile|tablet|web|unknown');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `redemption_ip_address` SET TAGS ('dbx_business_glossary_term' = 'Redemption IP Address');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `redemption_ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `redemption_ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `redemption_platform` SET TAGS ('dbx_business_glossary_term' = 'Redemption Platform');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `redemption_region` SET TAGS ('dbx_business_glossary_term' = 'Redemption Region');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'applied|reversed|expired|invalid|pending');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `referral_code` SET TAGS ('dbx_business_glossary_term' = 'Referral Code');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `terms_accepted_flag` SET TAGS ('dbx_business_glossary_term' = 'Terms Accepted Flag');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `usage_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Usage Sequence Number');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `validation_error_code` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Code');
ALTER TABLE `gaming_ecm`.`billing`.`promo_redemption` ALTER COLUMN `validation_error_message` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Message');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Number');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^BA[0-9]{10}$');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Status');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|under_review|pending_activation|delinquent');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'standard|premium|vip|whale');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Activated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `auto_renew_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renew Enabled');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `balance` SET TAGS ('dbx_business_glossary_term' = 'Account Balance');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `chargeback_count` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Count');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `coppa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'COPPA (Childrens Online Privacy Protection Act) Compliant Flag');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `dunning_cycle_count` SET TAGS ('dbx_business_glossary_term' = 'Dunning Cycle Count');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `dunning_status` SET TAGS ('dbx_business_glossary_term' = 'Dunning Status');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `dunning_status` SET TAGS ('dbx_value_regex' = 'none|soft_dunning|hard_dunning|final_notice|collections');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `failed_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Transaction Count');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `gdpr_consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'GDPR (General Data Protection Regulation) Consent Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `last_failed_transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Failed Transaction Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `last_successful_transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Transaction Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `lifetime_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Spend Amount');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `marketing_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `parental_consent_verified` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Verified');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `pci_compliance_scope` SET TAGS ('dbx_business_glossary_term' = 'PCI DSS (Payment Card Industry Data Security Standard) Compliance Scope');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `pci_compliance_scope` SET TAGS ('dbx_value_regex' = 'in_scope|out_of_scope|tokenized_only');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `refund_count` SET TAGS ('dbx_business_glossary_term' = 'Refund Count');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `subscription_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Subscription Active Flag');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `successful_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Successful Transaction Count');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exemption_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Expiry Date');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exemption_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Status');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exemption_status` SET TAGS ('dbx_value_regex' = 'none|exempt|partial|pending_verification');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `total_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Count');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` SET TAGS ('dbx_subdomain' = 'subscription_operations');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `dunning_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Event ID');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `dunning_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Cycle ID');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument ID');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `catalog_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Recovery Offer ID');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolved By Employee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `subscription_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `access_revoked_flag` SET TAGS ('dbx_business_glossary_term' = 'Access Revoked Flag');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `access_revoked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Access Revoked Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `attempt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Attempt Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `attempted_amount` SET TAGS ('dbx_business_glossary_term' = 'Attempted Amount');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `churn_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Churn Risk Score');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `dunning_attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Dunning Attempt Number');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `dunning_status` SET TAGS ('dbx_business_glossary_term' = 'Dunning Status');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `dunning_status` SET TAGS ('dbx_value_regex' = 'active|resolved|escalated|subscription_cancelled|grace_period_expired|payment_updated');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `failure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Code');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `failure_reason_code` SET TAGS ('dbx_value_regex' = 'insufficient_funds|card_expired|card_declined|bank_block|invalid_card|fraud_suspected');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `failure_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Description');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `gateway_response_code` SET TAGS ('dbx_business_glossary_term' = 'Gateway Response Code');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `grace_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `grace_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Start Date');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `is_voluntary_cancellation` SET TAGS ('dbx_business_glossary_term' = 'Is Voluntary Cancellation');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `ltv_at_dunning` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Value (LTV) at Dunning');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `max_retry_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Attempts');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `next_retry_date` SET TAGS ('dbx_business_glossary_term' = 'Next Retry Date');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|push|in_game|sms|none');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `notification_template_code` SET TAGS ('dbx_business_glossary_term' = 'Notification Template ID');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `platform_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Code');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `player_response_action` SET TAGS ('dbx_business_glossary_term' = 'Player Response Action');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `player_response_action` SET TAGS ('dbx_value_regex' = 'updated_payment|contacted_support|ignored|cancelled_subscription|none');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `processor_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Processor Transaction ID');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `recovery_offer_presented` SET TAGS ('dbx_business_glossary_term' = 'Recovery Offer Presented');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Resolution Method');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `resolution_method` SET TAGS ('dbx_value_regex' = 'automatic_retry|manual_payment|payment_method_update|subscription_cancelled|write_off');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `retry_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Retry Interval Days');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo ID');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Defect Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Invoice ID');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issued By Agent ID');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Transaction ID');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `support_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Support Ticket ID');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `tertiary_credit_voided_by_agent_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Voided By Agent ID');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `tertiary_credit_voided_by_agent_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `tertiary_credit_voided_by_agent_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_value_regex' = '^CM-[0-9]{8,12}$');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_memo_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Status');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_memo_status` SET TAGS ('dbx_value_regex' = 'issued|applied|partially_applied|expired|voided|pending');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_memo_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Type');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_memo_type` SET TAGS ('dbx_value_regex' = 'goodwill|billing_error_correction|partial_refund|promotional|chargeback_reversal|platform_adjustment');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Reason Code');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Credit Reason Description');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `data_retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Expiry Date');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `fully_applied_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fully Applied Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `gdpr_consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'GDPR (General Data Protection Regulation) Consent Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `pci_compliance_scope` SET TAGS ('dbx_business_glossary_term' = 'PCI (Payment Card Industry) Compliance Scope');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `pci_compliance_scope` SET TAGS ('dbx_value_regex' = 'IN_SCOPE|OUT_OF_SCOPE|NOT_APPLICABLE');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `platform_partner_code` SET TAGS ('dbx_business_glossary_term' = 'Platform Partner ID');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `revenue_reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Reversal Flag');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `storefront_code` SET TAGS ('dbx_business_glossary_term' = 'Storefront Code');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}(-[A-Z0-9]{2,5})?$');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_value_regex' = 'TAXABLE|NON_TAXABLE|TAX_EXEMPT|REVERSE_CHARGE');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`credit_memo` ALTER COLUMN `voided_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Voided Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `payment_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Hold ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Review Agent ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `fraud_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `sanctions_screening_result_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Result Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `original_payment_hold_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Authorization Code');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `authorization_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `capture_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Capture Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `decline_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Decline Reason Code');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `decline_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Decline Reason Description');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_business_glossary_term' = 'Device Fingerprint');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `fraud_rule_version` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Version');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `fraud_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `fraud_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Fraud Score Threshold');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `gateway_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Transaction ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `hold_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Hold Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `hold_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Hold Created Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `hold_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Hold Expiry Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Hold Number');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Hold Reason Code');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `hold_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Hold Reason Description');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Hold Status');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `hold_trigger_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Hold Trigger Type');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Name');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `player_contact_attempted_flag` SET TAGS ('dbx_business_glossary_term' = 'Player Contact Attempted Flag');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `player_contact_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Player Contact Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `player_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Player Verification Status');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `player_verification_status` SET TAGS ('dbx_value_regex' = 'verified|failed|no_response|not_attempted');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Payment Hold Resolution Outcome');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'captured|voided|expired|cancelled');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Hold Resolution Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review Notes');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `review_priority` SET TAGS ('dbx_business_glossary_term' = 'Review Priority Level');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `review_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `review_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Review Started Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `transaction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Country Code');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `transaction_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`payment_hold` ALTER COLUMN `void_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Void Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_cycle` SET TAGS ('dbx_subdomain' = 'subscription_operations');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_cycle` ALTER COLUMN `dunning_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Cycle Identifier');
ALTER TABLE `gaming_ecm`.`billing`.`dunning_cycle` ALTER COLUMN `previous_dunning_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`fraud_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`billing`.`fraud_rule` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `gaming_ecm`.`billing`.`fraud_rule` ALTER COLUMN `fraud_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Fraud Rule Identifier');
ALTER TABLE `gaming_ecm`.`billing`.`fraud_rule` ALTER COLUMN `superseded_fraud_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`fraud_rule` ALTER COLUMN `rule_logic_expression` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Identifier');
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` ALTER COLUMN `primary_bank_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` ALTER COLUMN `payment_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` ALTER COLUMN `payment_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`settlement_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`billing`.`settlement_batch` SET TAGS ('dbx_subdomain' = 'revenue_settlement');
ALTER TABLE `gaming_ecm`.`billing`.`settlement_batch` ALTER COLUMN `settlement_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Batch Identifier');
ALTER TABLE `gaming_ecm`.`billing`.`settlement_batch` ALTER COLUMN `previous_settlement_batch_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`settlement_batch` ALTER COLUMN `platform_report_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`performance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`billing`.`performance_obligation` SET TAGS ('dbx_subdomain' = 'revenue_settlement');
ALTER TABLE `gaming_ecm`.`billing`.`performance_obligation` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Identifier');
ALTER TABLE `gaming_ecm`.`billing`.`performance_obligation` ALTER COLUMN `parent_performance_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` ALTER COLUMN `payment_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Provider Identifier');
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` ALTER COLUMN `parent_payment_provider_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` ALTER COLUMN `chargeback_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` ALTER COLUMN `merchant_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` ALTER COLUMN `refund_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` ALTER COLUMN `transaction_fee_fixed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` ALTER COLUMN `transaction_fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`payment_provider` ALTER COLUMN `webhook_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`billing`.`contract` SET TAGS ('dbx_subdomain' = 'subscription_operations');
ALTER TABLE `gaming_ecm`.`billing`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `gaming_ecm`.`billing`.`contract` ALTER COLUMN `master_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`contract` ALTER COLUMN `contract_value_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`contract` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`contract` ALTER COLUMN `platform_fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`contract` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`contract` ALTER COLUMN `signed_by_platform` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`contract` ALTER COLUMN `signed_by_publisher` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`contract` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`billing`.`product` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `gaming_ecm`.`billing`.`product` ALTER COLUMN `product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `gaming_ecm`.`billing`.`product` ALTER COLUMN `platform_revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`transaction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`billing`.`transaction` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `gaming_ecm`.`billing`.`transaction` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Identifier');
ALTER TABLE `gaming_ecm`.`billing`.`transaction` ALTER COLUMN `original_transaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`transaction` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`transaction` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`transaction` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`transaction` ALTER COLUMN `device_fingerprint` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`transaction` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
