-- Schema for Domain: billing | Business: Gaming | Version: v1_mvm
-- Generated on: 2026-05-08 09:46:24

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`billing` COMMENT 'Single source of truth for all financial transactions, payment processing, invoices, refunds, chargebacks, and revenue recognition across storefronts (Steam, Epic, console first-party, mobile app stores). Owns PCI DSS-compliant payment instrument records, payout settlements with platform holders, and subscription billing cycles. Distinct from monetization: monetization owns virtual economy design; billing owns the real-money settlement layer.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice. Primary key for the invoice entity.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: An invoice is issued under a specific billing account — the master financial relationship record for a player. Adding billing_account_id to invoice directly links the formal payment request to the acc',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Invoices for DLC, expansions, and content drops must track which content release generated the sale for revenue recognition, royalty calculation, and platform reporting requirements.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Development projects generate invoices for development services, milestone payments, and licensing fees. Project-level invoice attribution is required for project P&L reporting, budget tracking agains',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: B2B invoices for platform revenue share, SDK licensing fees, and certification charges are issued to developer accounts. Gaming platform operators generate developer-facing invoices that must referenc',
    `game_studio_id` BIGINT COMMENT 'Foreign key linking to studio.game_studio. Business justification: Invoices for milestone payments, revenue share, and development services are issued to/from specific game studios. Studio-level invoice attribution is required for studio P&L reporting, accounts payab',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Royalty invoices are issued under specific IP licensing agreements. Links invoice to governing agreement terms for royalty billing, reconciliation, and audit. Essential for royalty revenue recognition',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Invoices must track tax jurisdiction for VAT/sales tax filing and audit compliance. Gaming platforms operate globally with complex tax nexus rules. Replaces denormalized tax_jurisdiction_code with pro',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Live ops cycles (seasons, battle passes, content drops) generate invoices for revenue share, platform fees, and content licensing. Finance teams reconcile invoices against live ops cycles for season-l',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to studio.milestone. Business justification: Publisher milestone payment invoicing: when a studio completes a contractual milestone (alpha, beta, gold master), an invoice is generated for that milestone payment. milestone.payment_amount confirms',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Invoices must reference applicable compliance policies for audit trails (invoicing policies, data retention policies, revenue recognition policies) for governance compliance.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Invoices must reference applicable regulatory obligations for audit trails (GDPR invoicing requirements, tax authority compliance, digital goods invoicing regulations). Core invoice compliance.',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Invoices for event-driven purchases (battle passes, event bundles) must link to seasonal events for event revenue tracking, marketing campaign effectiveness measurement, and live-ops financial reporti',
    `spend_limit_control_id` BIGINT COMMENT 'Foreign key linking to compliance.spend_limit_control. Business justification: Invoices must validate against spend limit controls for compliance verification (minor spending limits enforced at invoice level). Critical regulatory enforcement documentation.',
    `sponsorship_id` BIGINT COMMENT 'Foreign key linking to esports.sponsorship. Business justification: Sponsorship contracts generate invoices for sponsor payment collection. Finance teams reconcile sponsorship revenue by linking invoices to sponsorship deals for AR reporting, revenue recognition, and ',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Platform revenue share invoices and payout statements must reference the specific storefront. Gaming finance teams reconcile invoices per storefront for platform fee audits and tax reporting. storefro',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Tournaments generate invoices for entry fees, venue costs, and production services. Finance teams reconcile tournament P&L by linking invoices to tournaments — essential for tournament profitability r',
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
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Invoice lines for age-restricted content must reference age rating certificates for audit trails and compliance verification at line-item level. Critical content compliance documentation.',
    `campaign_id` BIGINT COMMENT 'Reference to the marketing campaign that drove this purchase. Used to calculate Return on Ad Spend (ROAS) and campaign effectiveness. Null if purchase was organic.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Invoice lines track which content drop/DLC release a purchase belongs to. Critical for launch revenue tracking, content drop P&L reporting, and measuring commercial success of major content releases a',
    `game_studio_id` BIGINT COMMENT 'Reference to the development studio responsible for the product sold on this line. Used for studio-level revenue attribution and royalty calculations.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title or Intellectual Property (IP) this line item is associated with. Used for title-level revenue reporting and Profit and Loss (P&L) analysis.',
    `iap_transaction_id` BIGINT COMMENT 'Foreign key linking to monetization.iap_transaction. Business justification: Invoice lines for IAP purchases need transaction linkage for refund reconciliation, entitlement revocation, and chargeback dispute resolution. Financial operations require tracing invoice lines to ori',
    `invoice_id` BIGINT COMMENT 'Reference to the parent invoice header that contains this line item. Links this line to the overall billing transaction.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Invoice lines itemize specific licensed IP usage (engine licenses, middleware components, music tracks, brand assets). Enables IP-specific revenue recognition, royalty calculation, and usage-based bil',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: Revenue recognition and royalty reporting require linking invoice lines to the specific platform SKU sold. Gaming finance teams report revenue by platform SKU for platform fee reconciliation and devel',
    `player_account_id` BIGINT COMMENT 'Unique identifier for the player who made this purchase. Links billing transactions to player behavior analytics and Lifetime Value (LTV) calculations.',
    `spend_limit_control_id` BIGINT COMMENT 'Foreign key linking to compliance.spend_limit_control. Business justification: Invoice lines must validate against spend limit controls for itemized compliance verification (line-item spending limits for specific product types). Critical regulatory enforcement.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Invoice lines itemize sales per storefront for multi-platform publishers. Required for storefront-specific revenue attribution, platform fee reconciliation, and regional tax compliance reporting.',
    `storefront_item_id` BIGINT COMMENT 'Foreign key linking to monetization.storefront_item. Business justification: Invoice lines must reference the monetization catalog item for revenue recognition by product, tax category determination, and audit trails. Gaming finance and compliance teams require this link to ma',
    `storefront_order_id` BIGINT COMMENT 'External transaction identifier provided by the platform or storefront (Steam order ID, Epic transaction ID, Apple receipt ID, Google order token). Used for reconciliation with platform payout reports.',
    `storefront_order_line_id` BIGINT COMMENT 'Foreign key linking to billing.storefront_order_line. Business justification: An invoice line item directly corresponds to a specific storefront order line item (the SKU purchased). invoice_line already has storefront_order_id linking to the order header, but the line-level lin',
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
    `quantity` STRING COMMENT 'Number of units of this Stock Keeping Unit (SKU) purchased on this line. Typically 1 for digital goods; may be greater than 1 for virtual currency bundles or multi-license purchases.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total amount refunded for this line item. Zero if no refund has been issued. Expressed in the invoice currency.',
    `refund_date` DATE COMMENT 'Date when the refund was processed for this line item. Null if no refund has been issued.',
    `refund_eligible_flag` BOOLEAN COMMENT 'Indicates whether this line item is eligible for refund based on platform policies (e.g., Steam 2-hour/14-day policy, Apple/Google refund windows). True if refundable, False if non-refundable.',
    `refund_window_end_date` DATE COMMENT 'Last date on which a refund can be requested for this line item per platform policy. Null if item is non-refundable or refund window has no expiration.',
    `revenue_recognition_category` STRING COMMENT 'Accounting treatment for revenue recognition: immediate (one-time purchase), deferred (season pass, pre-order), subscription (recurring), or usage-based (consumable virtual currency).. Valid values are `immediate|deferred|subscription|usage_based`',
    `revenue_recognition_end_date` DATE COMMENT 'Date when revenue recognition ends for this line item. Null for immediate recognition. For subscriptions or deferred items, marks the end of the recognition period.',
    `revenue_recognition_start_date` DATE COMMENT 'Date when revenue recognition begins for this line item. For immediate recognition, equals the invoice date. For deferred or subscription items, marks the start of the recognition period.',
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
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Payments are applied against a billing account. Linking payment.billing_account_id to billing_account enables direct account-level payment history, failed transaction tracking, and lifetime spend aggr',
    `data_subject_request_id` BIGINT COMMENT 'Foreign key linking to compliance.data_subject_request. Business justification: Payments involved in GDPR/CCPA data subject requests (data portability of transaction history, deletion requests) must reference DSRs for compliance audit trails.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Milestone and development service payments reference the dev_project they fund. Required for project-level cash flow tracking, budget vs. actuals reporting, and publisher payment reconciliation agains',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title for which the payment was made. Links to the game title master entity.',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice associated with this payment. Links to the billing invoice entity for financial reconciliation.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Links payments to specific licensing agreements for advance payments, milestone payments, minimum guarantees, and royalty payments. Enables agreement-specific payment tracking, recoupment calculation,',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Payments must track jurisdiction for tax remittance, VAT/GST compliance, payment method regulations, and cross-border payment rules. Core payment compliance requirement in global gaming operations.',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Tracks payments from/to licensees for royalties, license fees, minimum guarantees, and revenue shares. Essential for licensee payment reconciliation, cash application, and accounts receivable/payable ',
    `milestone_id` BIGINT COMMENT 'Foreign key linking to studio.milestone. Business justification: Milestone-triggered payments are a core game development business process. Publishers disburse payments upon milestone sign-off. Payment records must reference the triggering milestone for accounts pa',
    `payment_instrument_id` BIGINT COMMENT 'Foreign key linking to billing.payment_instrument. Business justification: Payment transactions should reference the payment instrument used for the transaction. While payment captures point-in-time card details (card_last_four_digits, card_brand, expiry dates) as historical',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.processing_activity. Business justification: Payments involve data processing activities (payment authorization, fraud detection, transaction logging) that must be tracked in GDPR Article 30 records for compliance.',
    `spend_limit_control_id` BIGINT COMMENT 'Foreign key linking to compliance.spend_limit_control. Business justification: Payments must validate against spend limit controls for minors and vulnerable players before authorization. Critical regulatory enforcement point for responsible gaming compliance.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Payment settlement and platform fee calculation require storefront context. Gaming platform operators calculate revenue share per storefront per payment for financial reporting and settlement. No exis',
    `subscription_id` BIGINT COMMENT 'Identifier of the subscription if this payment is part of a recurring subscription billing cycle. Nullable for one-time purchases.',
    `amount` DECIMAL(18,2) COMMENT 'The gross payment amount received from the player before any fees, taxes, or adjustments. Represents the total real-money value of the transaction.',
    `authorization_code` STRING COMMENT 'The authorization code returned by the payment gateway or issuing bank confirming that the payment was approved. Used for reconciliation and dispute resolution.. Valid values are `^[A-Z0-9]{6,12}$`',
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
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Payment instruments (stored cards, wallets) are owned by and managed under a billing account. This FK links the PCI DSS-compliant payment method record to the master billing account, enabling account-',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Payment instruments require consent policies for storing payment data under GDPR/PCI-DSS (explicit consent for tokenization, recurring billing consent). Critical privacy-billing intersection.',
    `data_subject_request_id` BIGINT COMMENT 'Foreign key linking to compliance.data_subject_request. Business justification: Payment instruments deleted via GDPR/CCPA data subject requests (right to erasure) must reference DSRs for compliance audit trails and data deletion verification.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Payment instruments must track issuing jurisdiction for PCI-DSS compliance scope, payment method restrictions (regional regulations), and fraud rule enforcement. Core payment compliance requirement.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Payment instruments must reference payment data handling policies for PCI-DSS compliance, data retention policies, and tokenization policies for audit compliance.',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.processing_activity. Business justification: Payment instruments involve data processing activities (payment data storage, tokenization, recurring billing) that must be tracked in GDPR Article 30 records.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Payment instruments must reference regulatory obligations governing payment data storage (PCI-DSS, GDPR data minimization, regional payment regulations) for compliance tracking.',
    `spend_limit_control_id` BIGINT COMMENT 'Foreign key linking to compliance.spend_limit_control. Business justification: Payment instruments used by minors must enforce spend limit controls at instrument level. Critical regulatory enforcement for responsible gaming and minor protection.',
    `virtual_currency_account_id` BIGINT COMMENT 'The identifier for platform-specific wallet payment methods (PlayStation Network Wallet, Xbox Wallet, Steam Wallet). Null for non-platform wallets.',
    `added_timestamp` TIMESTAMP COMMENT 'The date and time when the payment instrument was first added to the players account.',
    `billing_address_line1` STRING COMMENT 'The first line of the billing address associated with the payment instrument. Used for Address Verification Service (AVS).',
    `billing_address_line2` STRING COMMENT 'The second line of the billing address (apartment, suite, etc.). Optional field for AVS.',
    `billing_city` STRING COMMENT 'The city of the billing address associated with the payment instrument.',
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
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Refunds are processed against a billing account. billing_account.refund_count is an account-level aggregate that tracks refund history — the FK makes the source relationship explicit. This enables acc',
    `chargeback_id` BIGINT COMMENT 'Reference to the chargeback case if this refund is related to a payment dispute initiated by the player through their bank or card issuer.',
    `data_subject_request_id` BIGINT COMMENT 'Foreign key linking to compliance.data_subject_request. Business justification: Refunds triggered by GDPR/CCPA data deletion requests must reference the DSR for audit trails (refunds issued as part of account closure/data erasure).',
    `iap_transaction_id` BIGINT COMMENT 'Foreign key linking to monetization.iap_transaction. Business justification: Refunds for IAP purchases require transaction reference for entitlement revocation, virtual currency clawback, and fraud prevention. Customer support workflows depend on linking refunds to originating',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: A refund is typically issued against a specific invoice. While refund already links to payment (which links to invoice), the direct refund→invoice FK is operationally important for invoice-level recon',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Refunds must track jurisdiction for consumer protection law compliance (EU 14-day right of withdrawal, regional refund policies, cooling-off periods). Core refund compliance requirement.',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Refunds issued to licensees for overpayments, disputed royalty calculations, or contract adjustments. Enables licensee-specific refund tracking, dispute resolution, and accounts receivable adjustment ',
    `payment_id` BIGINT COMMENT 'Reference to the originating payment transaction that this refund is reversing or crediting against.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Refunds must reference refund policies for compliance verification (refund eligibility rules, processing timelines, dispute resolution policies) and audit compliance.',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.processing_activity. Business justification: Refunds involve data processing activities (refund authorization, payment reversal, transaction logging) that must be tracked in GDPR Article 30 records.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Refunds must reference regulatory obligations that mandate them (consumer protection laws, cooling-off periods, digital goods refund regulations) for compliance verification and audit trails.',
    `virtual_currency_ledger_id` BIGINT COMMENT 'Foreign key linking to licensing.virtual_currency_ledger. Business justification: Refunds of IAP transactions that awarded virtual currency require reversal ledger entries to clawback currency and maintain accurate player balances. Essential for fraud prevention and economy integri',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Refund policy enforcement (storefront.refund_policy_days), platform fee refund calculation, and storefront-level refund rate reporting all require this link. Gaming operators enforce different refund ',
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
    `tax_refund_amount` DECIMAL(18,2) COMMENT 'Portion of the refund amount representing tax reversal (VAT, sales tax, GST) being returned to the player.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this refund record was last modified.',
    CONSTRAINT pk_refund PRIMARY KEY(`refund_id`)
) COMMENT 'Transactional record of value returned to a player or platform partner, whether as cash refund to original payment method, store credit (credit memo), or platform wallet credit. Captures refund/credit amount, currency, reason code (player request, fraud, technical failure, platform policy, goodwill, billing error), originating payment reference, return method (original payment method, store credit, platform wallet), status (pending, approved, processed, rejected, applied, expired), processing timestamp, approving agent, expiry date (for store credits), and credit memo details (issuing reference, application history). SSOT for all refund and credit activity across storefronts — consolidates both cash refunds and store-credit instruments.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`chargeback` (
    `chargeback_id` BIGINT COMMENT 'Unique identifier for the chargeback record. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Chargebacks are disputes raised against a billing account. billing_account.chargeback_count is an account-level aggregate — the FK makes the authoritative source relationship explicit. This enables ac',
    `game_title_id` BIGINT COMMENT 'Reference to the game title associated with the disputed transaction.',
    `iap_transaction_id` BIGINT COMMENT 'Foreign key linking to monetization.iap_transaction. Business justification: Chargebacks on IAP transactions drive fraud analysis, entitlement revocation, and dispute resolution. Financial operations require linking chargebacks to originating IAP transactions for evidence subm',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice associated with the disputed transaction.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Chargebacks must track jurisdiction for dispute resolution procedures, chargeback rights (regional card network rules), and payment network regional regulations. Core chargeback compliance requirement',
    `payment_id` BIGINT COMMENT 'Reference to the original payment transaction that is being disputed.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Chargebacks must reference dispute resolution policies for compliance verification (chargeback response procedures, evidence submission policies, fraud investigation policies).',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Chargebacks must reference regulatory obligations governing dispute resolution (payment card network regulations, consumer protection laws) for compliance tracking.',
    `virtual_currency_ledger_id` BIGINT COMMENT 'Foreign key linking to licensing.virtual_currency_ledger. Business justification: Chargebacks of IAP transactions that granted virtual currency require clawback ledger entries to reverse fraudulent currency awards. Critical for fraud detection, chargeback abuse prevention, and virt',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Chargeback dispute management and fraud rate reporting require identifying the originating storefront. Platform holders track chargeback rates per storefront for compliance and fraud thresholds. platf',
    `storefront_order_id` BIGINT COMMENT 'Foreign key linking to billing.storefront_order. Business justification: Chargebacks are payment disputes initiated by players on specific storefront orders. While chargeback already links to invoice, the direct link to storefront_order provides the original purchase conte',
    `acquiring_bank` STRING COMMENT 'Merchants bank or payment processor that acquired the original transaction and is handling the chargeback response.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the disputed transaction being charged back to the merchant.',
    `arbitration_fee` DECIMAL(18,2) COMMENT 'Additional fee charged by the card network for arbitration proceedings if the dispute is escalated beyond standard chargeback resolution.',
    `arbitration_requested` BOOLEAN COMMENT 'Flag indicating whether the merchant has escalated the dispute to card network arbitration after losing the initial chargeback.',
    `assigned_to` STRING COMMENT 'Name or identifier of the billing operations team member or fraud analyst assigned to handle this chargeback case.',
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
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Subscriptions are managed under a billing account. billing_account.subscription_active_flag and auto_renew_enabled are account-level flags that correspond to active subscriptions — the FK makes the au',
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Subscriptions require explicit consent tracking under GDPR/CCPA for recurring billing. Gaming companies must prove which policy version player accepted at subscription start. Critical for regulatory a',
    `data_subject_request_id` BIGINT COMMENT 'Foreign key linking to compliance.data_subject_request. Business justification: Subscriptions cancelled via GDPR/CCPA data subject requests (right to erasure, withdrawal of consent) must reference DSRs for compliance audit trails.',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: Game subscriptions (e.g., game-specific battle pass, online service) are tied to a specific game title. Title-level subscription revenue reporting, churn analysis by title, and lifecycle management re',
    `player_account_id` BIGINT COMMENT 'Identifier of the player who purchased this subscription as a gift. Null if not a gift subscription.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Subscription-based licensing models (game engine subscriptions, middleware SaaS, SDK access) are governed by IP agreements. Links recurring billing to license terms, royalty structures, and usage righ',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Subscriptions must track jurisdiction for auto-renewal regulations, cancellation rights (EU consumer protection), and subscription-specific consumer protection laws. Core subscription compliance requi',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Subscriptions grant access to specific licensed IP (Unity Pro for Unity engine, Unreal Engine subscription, middleware SDK access). Links subscription entitlement to licensed technology, enabling IP-b',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Season pass and battle pass subscriptions are directly tied to live ops cycles — the subscription product IS the live ops season. Subscription billing periods align with live ops cycle dates. Required',
    `matchmaking_pool_id` BIGINT COMMENT 'Foreign key linking to infrastructure.matchmaking_pool. Business justification: Subscription tiers often gate access to premium matchmaking pools (ranked modes, competitive ladders). Tracks which pool the subscription unlocks. Business process: recurring revenue from competitive ',
    `payment_instrument_id` BIGINT COMMENT 'Identifier of the payment instrument (credit card, PayPal, platform wallet) used for recurring billing.',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: Gaming subscriptions (Game Pass, PS Plus) are sold as specific platform SKUs. Linking subscription to platform_sku enables platform-specific subscription reporting, entitlement validation, and certifi',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Subscriptions must reference subscription management policies for compliance verification (auto-renewal policies, cancellation policies, trial period policies).',
    `processing_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.processing_activity. Business justification: Subscriptions involve data processing activities (auto-renewal processing, subscription data storage, billing history) that must be tracked in GDPR Article 30 records.',
    `spend_limit_control_id` BIGINT COMMENT 'Foreign key linking to compliance.spend_limit_control. Business justification: Subscriptions must enforce spend limit controls mandated by jurisdictions (minor spending limits, gambling-adjacent regulations for loot box subscriptions). Critical regulatory enforcement.',
    `storefront_id` BIGINT COMMENT 'Identifier of the platform where the subscription was purchased (Steam, Epic Games Store, PlayStation Network, Xbox Live, App Store, Google Play).',
    `subscription_plan_id` BIGINT COMMENT 'Identifier of the subscription plan tier that defines pricing, features, and billing frequency for this subscription.',
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
    `consent_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_policy. Business justification: Subscription cycles involving auto-renewal must reference consent policies for transparency requirements (explicit consent for recurring billing, renewal notifications). Critical privacy-billing inter',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice document generated for this billing cycle. Links to the invoice master record for player-facing billing documentation.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Subscription cycles must track jurisdiction for period-specific tax rates, regulatory changes (VAT rate changes), and billing period compliance. Core subscription billing compliance.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Subscription renewal rate, billing success rate, and dunning effectiveness are KPIs measured at the billing cycle level. Subscription operations teams track cycle performance against defined KPI targe',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Subscription billing cycles for season passes align with live ops cycles — each subscription renewal period corresponds to a game season. Required for season pass renewal rate analysis, subscriber chu',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Each subscription billing cycle generates a payment transaction. The subscription_cycle.transaction_id is an external processor reference (STRING), but the actual payment record in the billing domain ',
    `payment_instrument_id` BIGINT COMMENT 'Reference to the payment instrument used for this billing cycle attempt. Links to the payment method master record.',
    `player_account_id` BIGINT COMMENT 'Reference to the player who owns the subscription being billed in this cycle.',
    `price_point_id` BIGINT COMMENT 'Foreign key linking to monetization.price_point. Business justification: Each subscription billing cycle is charged at a specific price point. Linking subscription_cycle to price_point enables price change impact analysis, regional pricing compliance reporting, and revenue',
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
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Orders for age-restricted content must validate against age rating certificates to ensure compliance with regional age restrictions. Critical content compliance enforcement point.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Storefront orders are placed under a billing account. This FK enables account-level order history, fraud risk aggregation, and lifetime spend tracking. billing_account.lifetime_spend_amount and billin',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign that drove this purchase. Used for ROAS (Return on Ad Spend) and CPI (Cost Per Install) analysis.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Orders must track buyer jurisdiction for tax calculation, age verification requirements, and consumer protection compliance. Core e-commerce compliance requirement in global gaming storefronts.',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Licensees (developers, studios) purchase tools, assets, and services through storefronts (Unity Asset Store, Unreal Marketplace). Tracks licensee procurement, spending patterns, and cross-sell opportu',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Storefront orders for event-exclusive items (limited skins, battle passes) must track the driving seasonal event for attribution analysis, event ROI calculation, and live-ops performance reporting.',
    `session_id` BIGINT COMMENT 'Foreign key linking to player.session. Business justification: Session-level purchase attribution: linking a storefront order to the session in which it was placed enables session-revenue analytics, fraud detection (purchase during anomalous session), and LTV-per',
    `spend_limit_control_id` BIGINT COMMENT 'Foreign key linking to compliance.spend_limit_control. Business justification: Orders must validate against spend limit controls before completion (minor spending limits, daily/monthly caps). Critical regulatory enforcement point for responsible gaming.',
    `storefront_id` BIGINT COMMENT 'Foreign key linking to platform.storefront. Business justification: Order fulfillment, platform fee calculation, and revenue reconciliation require knowing which storefront each order was placed on. Gaming domain experts expect every order to reference its originating',
    `subscription_id` BIGINT COMMENT 'Identifier of the subscription record if this order is a recurring subscription charge. Null for one-time purchases.',
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
    `refund_amount` DECIMAL(18,2) COMMENT 'Total amount refunded to the player for this order. Used for revenue reversal and chargeback tracking.',
    `refund_processed_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was processed and funds were returned to the players payment method.',
    `refund_reason` STRING COMMENT 'Reason provided for the refund request (e.g., accidental purchase, technical issue, player dissatisfaction). Used for quality analysis and fraud detection.',
    `refund_requested_timestamp` TIMESTAMP COMMENT 'Date and time when the player or customer support initiated the refund request.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item amounts before tax, discounts, and promotional adjustments are applied.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charged on the order, including sales tax, VAT, GST, or other jurisdiction-specific taxes.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final amount charged to the player, calculated as subtotal minus discounts plus tax. Net settlement amount for revenue recognition.',
    `transaction_reference` STRING COMMENT 'External transaction identifier provided by the payment processor or platform holder. Used for reconciliation and dispute resolution.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this order record was last modified. Audit trail for data lineage and change tracking.',
    CONSTRAINT pk_storefront_order PRIMARY KEY(`storefront_order_id`)
) COMMENT 'Master record of a players real-money purchase order placed through a digital storefront (Steam, Epic Games Store, PlayStation Store, Xbox Marketplace, Nintendo eShop, Apple App Store, Google Play). Captures order number, storefront platform, order timestamp, order status (pending, payment-authorized, completed, cancelled, partially-refunded, fully-refunded), total amount, currency, tax amount, player region, promotional code applied, and embedded line-item detail per SKU (product type, quantity, unit price, line total, discount amount, promotional offer reference, entitlement delivery status). SSOT for all real-money purchase orders and their constituent items across distribution channels.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`storefront_order_line` (
    `storefront_order_line_id` BIGINT COMMENT 'Unique identifier for the storefront order line item. Primary key for this entity representing a single SKU within a purchase order.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Order lines for age-restricted content must validate against age rating certificates at line-item level. Critical content compliance enforcement for mixed-age-rating orders.',
    `asset_bundle_id` BIGINT COMMENT 'Foreign key linking to content.asset_bundle. Business justification: Order lines reference specific asset bundles purchased (map packs, skin bundles, content packs). Essential for bundle sales analytics, bundle pricing optimization, and understanding which content pack',
    `bundle_parent_line_id` BIGINT COMMENT 'Reference to the parent line item if this line is part of a bundle purchase. Enables bundle component tracking and revenue allocation.',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to title.dlc_bundle. Business justification: DLC bundle purchases are recorded as storefront order line items. Revenue attribution, entitlement delivery, and refund processing for DLC require linking the order line to the specific dlc_bundle sol',
    `game_edition_id` BIGINT COMMENT 'Foreign key linking to title.game_edition. Business justification: Players purchase specific game editions (Standard, Deluxe, Ultimate). Edition-level revenue reporting, bundle content entitlement delivery, and edition upgrade tracking require linking the order line ',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this SKU belongs to. Links to game master data for franchise and studio revenue attribution.',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Individual storefront order lines for live ops content items (battle pass tiers, season content bundles) reference the live ops cycle. Required for line-level revenue attribution per content cycle, li',
    `mtx_catalog_id` BIGINT COMMENT 'Foreign key linking to monetization.mtx_catalog. Business justification: Storefront orders for MTX items reference catalog for pricing validation, entitlement delivery, and revenue recognition. Order fulfillment workflows require linking order lines to MTX catalog entries ',
    `platform_sku_id` BIGINT COMMENT 'Foreign key linking to platform.platform_sku. Business justification: Order lines must reference the exact platform SKU purchased for entitlement delivery, certification compliance tracking, and storefront-specific pricing validation. Gaming domain experts expect order ',
    `price_point_id` BIGINT COMMENT 'Foreign key linking to monetization.price_point. Business justification: Order lines must reference the price point applied at purchase for promotional price audit trails, A/B price test analysis, and revenue recognition validation. Gaming monetization teams require this l',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Order lines must reference regulatory obligations governing specific product types (loot box disclosure requirements, virtual currency regulations) for line-item compliance tracking.',
    `storefront_id` BIGINT COMMENT 'Reference to the distribution platform where this purchase occurred. Links to platform master data for Steam, Epic Games Store, PlayStation Store, Xbox Store, Nintendo eShop, App Store, or Google Play.',
    `storefront_item_id` BIGINT COMMENT 'Foreign key linking to monetization.storefront_item. Business justification: Order lines must reference the catalog item purchased for revenue reporting by SKU, refund eligibility checks, and entitlement delivery. Gaming billing systems require this link to validate what was s',
    `storefront_order_id` BIGINT COMMENT 'Reference to the parent storefront purchase order that contains this line item. Links this line to the header transaction.',
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
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Platform payouts are credited to a specific billing account (the publisher/developers account with the platform holder). This FK connects the payout settlement to the master billing account, enabling',
    `build_id` BIGINT COMMENT 'Foreign key linking to studio.build. Business justification: Platform payouts are tied to specific game build versions sold on storefronts. Finance and engineering teams reconcile payout periods against build versions to attribute revenue to specific releases, ',
    `developer_account_id` BIGINT COMMENT 'Foreign key linking to platform.developer_account. Business justification: Platform payouts are disbursed to developer accounts; this link enables developer revenue reporting, tax withholding calculation per developer, and payment terms enforcement. Gaming platform operators',
    `game_studio_id` BIGINT COMMENT 'Foreign key linking to studio.game_studio. Business justification: Platform payouts are disbursed to specific game studios for their titles sold on storefronts. Studio-level payout attribution is required for revenue share calculations, studio financial reporting, an',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: Platform payouts from storefronts (Steam, PlayStation Store, etc.) are attributed to specific game titles for title-level P&L, royalty reporting, and financial reconciliation. Finance teams running ti',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Platform payouts from first-party platform holders (Steam, Epic, console stores) are reconciled against invoices in the billing system. Linking platform_payout.invoice_id to invoice enables direct rec',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Platform payouts must track jurisdiction for tax withholding, cross-border payment regulations, and revenue recognition rules. Core financial compliance requirement for platform revenue sharing.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Platform payouts are measured against revenue KPIs (net revenue, platform fee %, payout timing). Finance teams track payout performance against defined KPI targets for reconciliation, variance analysi',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: Platform payouts to league organizers represent revenue share from storefront sales, broadcast rights, and in-game purchases tied to league content. Finance teams reconcile platform payouts by league ',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Platform payouts for season passes, battle passes, and live ops content map directly to live ops cycles. Publishers and finance teams need payout→live_ops_cycle attribution for season-level revenue re',
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
    `tax_withheld_amount` DECIMAL(18,2) COMMENT 'Total tax amount withheld by the platform holder for jurisdictional tax compliance (e.g., VAT, sales tax, withholding tax).',
    `units_sold_total` BIGINT COMMENT 'Total number of units (game copies, DLC, MTX, subscriptions) sold across all titles during the payout period.',
    CONSTRAINT pk_platform_payout PRIMARY KEY(`platform_payout_id`)
) COMMENT 'Record of revenue settlement payments received from first-party platform holders and digital storefronts (Sony, Microsoft, Nintendo, Valve, Epic, Apple, Google). Captures payout period, gross revenue, platform revenue share percentage, net payout amount, currency, payout date, settlement reference, platform identifier, reconciliation status, and embedded per-title/SKU line-item breakdown (title reference, SKU type, units sold, gross revenue, returns/refunds deducted, net revenue, platform fee rate, net payout line amount). SSOT for all platform holder revenue share settlements, payout reconciliation, and per-title revenue attribution.';

CREATE OR REPLACE TABLE `gaming_ecm`.`billing`.`billing_account` (
    `billing_account_id` BIGINT COMMENT 'Unique identifier for the billing account. Primary key for the billing account entity.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Billing accounts must track tax jurisdiction for proper tax calculation, VAT/GST compliance, and regulatory reporting. Core billing compliance requirement in multi-jurisdiction gaming operations.',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Licensees (publishers, developers, middleware vendors) maintain billing accounts for royalty payments, license fees, and revenue shares. Enables licensee financial management, payment term enforcement',
    `player_account_id` BIGINT COMMENT 'Reference to the player identity who owns this billing account. Links the billing account to the player domain master record.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Billing accounts must reference master compliance policies governing their operations (data retention policies, privacy policies, payment handling policies) for governance and audit compliance.',
    `account_number` STRING COMMENT 'Externally visible unique account number for customer service and billing correspondence. Format: BA followed by 10 digits.. Valid values are `^BA[0-9]{10}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the billing account. Active accounts can transact; suspended accounts are temporarily blocked; closed accounts are permanently terminated; under-review accounts are flagged for fraud investigation; pending-activation accounts await verification; delinquent accounts have overdue payments.. Valid values are `active|suspended|closed|under_review|pending_activation|delinquent`',
    `account_tier` STRING COMMENT 'Segmentation tier based on lifetime spend and engagement. Standard represents typical players; premium represents moderate spenders; VIP represents high-value players; whale represents top-tier spenders with dedicated account management.. Valid values are `standard|premium|vip|whale`',
    `activated_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing account was activated and became eligible for transactions. May differ from creation timestamp if verification was required.',
    `auto_renew_enabled` BOOLEAN COMMENT 'Boolean indicator whether automatic renewal is enabled for recurring subscriptions on this account. False requires manual renewal by player.',
    `balance` DECIMAL(18,2) COMMENT 'Current store credit or wallet balance available for purchases. Positive balance represents prepaid funds; negative balance represents outstanding debt. Denominated in preferred currency.',
    `billing_address_line1` STRING COMMENT 'Primary street address line for billing correspondence and tax jurisdiction determination.',
    `billing_address_line2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number.',
    `billing_city` STRING COMMENT 'City name for billing address.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_storefront_order_line_id` FOREIGN KEY (`storefront_order_line_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order_line`(`storefront_order_line_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `gaming_ecm`.`billing`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ADD CONSTRAINT `fk_billing_payment_instrument_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_chargeback_id` FOREIGN KEY (`chargeback_id`) REFERENCES `gaming_ecm`.`billing`.`chargeback`(`chargeback_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ADD CONSTRAINT `fk_billing_chargeback_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ADD CONSTRAINT `fk_billing_subscription_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `gaming_ecm`.`billing`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ADD CONSTRAINT `fk_billing_subscription_cycle_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ADD CONSTRAINT `fk_billing_subscription_cycle_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `gaming_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ADD CONSTRAINT `fk_billing_subscription_cycle_payment_instrument_id` FOREIGN KEY (`payment_instrument_id`) REFERENCES `gaming_ecm`.`billing`.`payment_instrument`(`payment_instrument_id`);
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ADD CONSTRAINT `fk_billing_subscription_cycle_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ADD CONSTRAINT `fk_billing_storefront_order_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ADD CONSTRAINT `fk_billing_storefront_order_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `gaming_ecm`.`billing`.`subscription`(`subscription_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_bundle_parent_line_id` FOREIGN KEY (`bundle_parent_line_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order_line`(`storefront_order_line_id`);
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ADD CONSTRAINT `fk_billing_storefront_order_line_storefront_order_id` FOREIGN KEY (`storefront_order_id`) REFERENCES `gaming_ecm`.`billing`.`storefront_order`(`storefront_order_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `gaming_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ADD CONSTRAINT `fk_billing_platform_payout_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `gaming_ecm`.`billing`.`invoice`(`invoice_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `gaming_ecm`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'revenue_documentation');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Release Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `spend_limit_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Limit Control Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `sponsorship_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `tax_exemption_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Code');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `voided_reason` SET TAGS ('dbx_business_glossary_term' = 'Voided Reason');
ALTER TABLE `gaming_ecm`.`billing`.`invoice` ALTER COLUMN `voided_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Voided Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'revenue_documentation');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Iap Transaction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `spend_limit_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Limit Control Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `storefront_item_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Item Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Transaction Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `storefront_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Line Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `refund_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligible Flag');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `refund_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Window End Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Category');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_category` SET TAGS ('dbx_value_regex' = 'immediate|deferred|subscription|usage_based');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_end_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition End Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_start_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Start Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `subscription_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Period End Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `subscription_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Period Start Date');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `subtotal` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `gaming_ecm`.`billing`.`invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `gaming_ecm`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Milestone Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `spend_limit_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Limit Control Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `gaming_ecm`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_confidential' = 'true');
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
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Instrument ID');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`payment_instrument` ALTER COLUMN `spend_limit_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Limit Control Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`billing`.`refund` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund ID');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback ID');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Iap Transaction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `virtual_currency_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Virtual Currency Ledger Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `tax_refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Refund Amount');
ALTER TABLE `gaming_ecm`.`billing`.`refund` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback ID');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Iap Transaction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `virtual_currency_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Virtual Currency Ledger Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `acquiring_bank` SET TAGS ('dbx_business_glossary_term' = 'Acquiring Bank');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Amount');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `arbitration_fee` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Fee');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `arbitration_requested` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Requested');
ALTER TABLE `gaming_ecm`.`billing`.`chargeback` ALTER COLUMN `assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Assigned To');
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
ALTER TABLE `gaming_ecm`.`billing`.`subscription` SET TAGS ('dbx_subdomain' = 'recurring_services');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gifted By Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `matchmaking_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Matchmaking Pool Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `processing_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Activity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `spend_limit_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Limit Control Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription` ALTER COLUMN `subscription_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Plan ID');
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
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` SET TAGS ('dbx_subdomain' = 'recurring_services');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `subscription_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Cycle Identifier');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `consent_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `payment_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`subscription_cycle` ALTER COLUMN `price_point_id` SET TAGS ('dbx_business_glossary_term' = 'Price Point Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` SET TAGS ('dbx_subdomain' = 'revenue_documentation');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order ID');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Marketing Campaign ID');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `spend_limit_control_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Limit Control Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
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
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `refund_processed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `refund_reason` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `refund_requested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Requested Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` SET TAGS ('dbx_subdomain' = 'revenue_documentation');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `storefront_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Line Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `asset_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `bundle_parent_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Parent Line Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Dlc Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `game_edition_id` SET TAGS ('dbx_business_glossary_term' = 'Game Edition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `mtx_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Mtx Catalog Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `platform_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `price_point_id` SET TAGS ('dbx_business_glossary_term' = 'Price Point Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Identifier (ID)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `storefront_item_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Item Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`storefront_order_line` ALTER COLUMN `storefront_order_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Order Identifier (ID)');
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
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `platform_payout_id` SET TAGS ('dbx_business_glossary_term' = 'Platform Payout ID');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `developer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Developer Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Live Ops Cycle Id (Foreign Key)');
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
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `tax_withheld_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Withheld Amount');
ALTER TABLE `gaming_ecm`.`billing`.`platform_payout` ALTER COLUMN `units_sold_total` SET TAGS ('dbx_business_glossary_term' = 'Units Sold Total');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`billing`.`billing_account` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
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
