-- Schema for Domain: licensing | Business: Gaming | Version: v1_ecm
-- Generated on: 2026-05-08 06:58:03

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `gaming_ecm`.`licensing` COMMENT 'Manages IP licensing, game engine technology licensing (Unity/Unreal SDK deals), third-party middleware agreements, music/art asset licensing, franchise/brand partnership contracts, royalty calculation schedules, licensee entitlements, and compliance with IP ownership terms and rating board requirements. Supports both outbound engine licensing revenue and inbound licensed IP usage.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`iap_transaction` (
    `iap_transaction_id` BIGINT COMMENT 'Unique surrogate primary key for each In-App Purchase (IAP) transaction event recorded in the monetization platform. Globally unique across all platforms and storefronts. Entity role: TRANSACTION_HEADER.',
    `build_id` BIGINT COMMENT 'Foreign key linking to studio.build. Business justification: IAP transactions occur within specific game builds. Tracking build version at purchase time is critical for fraud detection (exploit identification by build), A/B test attribution, platform certificat',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: IAP transactions post to specific GL accounts defined in chart of accounts. GL posting requirement for revenue account mapping.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Track which content version was live during purchase for customer support, refund handling, and version-specific entitlement issues. Critical for troubleshooting IAP problems post-patch.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: IAP transactions attributed to cost centers by game title/platform/studio for P&L analysis. Management accounting requirement for profitability tracking.',
    `finance_tax_record_id` BIGINT COMMENT 'Foreign key linking to finance.finance_tax_record. Business justification: IAP transactions generate tax obligations by jurisdiction. Tax compliance requirement for VAT/sales tax calculation and remittance.',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title within which the IAP transaction was executed. Enables per-title revenue reporting and cross-title monetization analysis.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Every IAP transaction must post to general ledger for revenue recognition and financial reporting. Core accounting requirement for ASC 606/IFRS 15 compliance and audit trail.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Direct asset purchases (character skins, weapon skins) via IAP require linking transaction to granted content for entitlement tracking, refund processing, and inventory management.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: IAP transactions generate invoices for revenue recognition, tax compliance, and financial reporting. Gaming companies must reconcile IAP revenue with invoices for audit trails and regulatory filings (',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: IAP transactions generate journal entries for revenue posting. Standard accounting flow linking monetization events to financial records for reconciliation and audit.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Every IAP transaction occurs in a specific regulatory jurisdiction determining tax treatment, age restrictions, loot box regulations, and revenue recognition rules. Essential for regional compliance r',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: IAP transactions booked to specific legal entities based on storefront/jurisdiction. Legal entity accounting requirement for multi-entity revenue recognition.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: IAP transactions for licensed content (Marvel characters, Star Wars items) require IP attribution for royalty calculation and revenue reporting to licensors. Critical for automated royalty accrual in ',
    `mtx_catalog_id` BIGINT COMMENT 'Foreign key reference to the MTX catalog entry representing the SKU purchased (e.g., virtual currency pack, DLC, battle pass, loot box, cosmetic item). Authoritative link to the item definition and pricing.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Revenue reporting by geographic region, tax jurisdiction compliance (VAT, sales tax), regional pricing strategy analysis, and infrastructure cost allocation require linking purchases to network region',
    `offer_campaign_id` BIGINT COMMENT 'Identifier of the promotional offer or marketing campaign that was active at the time of purchase. Used to measure offer conversion rates and discount attribution. Nullable when no campaign was applied.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Every IAP transaction has a corresponding payment record for settlement reconciliation, chargeback disputes, and refund processing. Payment gateway integration requires linking transactions to payment',
    `player_account_id` BIGINT COMMENT 'Unique identifier of the player who executed the IAP transaction. Links to the player master record. Supports ARPU, ARPPU, DAP, LTV, and whale segmentation analytics. PARTY_REFERENCE category per TRANSACTION_HEADER role.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: IAP revenue must be attributed to profit centers for segment reporting. Core management accounting and financial reporting requirement.',
    `royalty_accrual_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_accrual. Business justification: IAP transactions on licensed IP generate royalty obligations. Royalty accounting requirement for IP licensing agreements and payment processing.',
    `session_id` BIGINT COMMENT 'Identifier of the active game session during which the IAP transaction was initiated. Links purchase behavior to session context (session length, game mode, progression state) for behavioral monetization analytics.',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Players purchase items during tournament viewing/participation. Tournament-driven IAP spikes are tracked for revenue attribution, promotional effectiveness analysis, and esports ROI measurement. Real ',
    `attribution_source` STRING COMMENT 'The marketing channel or campaign source attributed to this IAP transaction by the mobile attribution platform (e.g., AppsFlyer, Adjust). Used for ROAS and CPI-to-LTV analysis. Examples: facebook_ads, google_uac, organic, influencer. Null for non-attributed transactions.',
    `bonus_virtual_currency` BIGINT COMMENT 'Additional virtual currency awarded as a promotional bonus on top of the base virtual_currency_awarded (e.g., first-purchase bonus, limited-time offer bonus). Null when no bonus applies. Supports offer effectiveness analysis.',
    `coppa_verified` BOOLEAN COMMENT 'Indicates whether the players age was verified as meeting the minimum age requirement (13+ in the US) prior to this IAP transaction, per COPPA compliance requirements. True = age verification passed. Critical for regulatory compliance and audit trails involving minor players.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when this IAP transaction record was first ingested into the Silver layer data platform. RECORD_AUDIT_CREATED category per TRANSACTION_HEADER role. May differ from purchased_at due to pipeline latency.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code of the currency in which the player was charged (e.g., USD, EUR, GBP, JPY). Part of MONETARY_TRIPLET currency component. Enables multi-currency revenue reporting and FX analysis.. Valid values are `^[A-Z]{3}$`',
    `device_type` STRING COMMENT 'Category of device used by the player to execute the IAP transaction. Supports device-mix revenue analysis and platform-specific monetization strategy.. Valid values are `mobile|tablet|console|pc|handheld`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of any promotional discount or offer reduction applied to the gross amount at the time of purchase. Part of MONETARY_TRIPLET adjustment component. Zero when no discount was applied.',
    `discount_rate` DECIMAL(18,2) COMMENT 'The percentage discount applied to the gross price for this transaction (expressed as a decimal, e.g., 0.20 for 20% off). Derived from the offer campaign. Zero when no discount was applied. Supports offer ROI and conversion rate analysis.',
    `entitlement_granted` BOOLEAN COMMENT 'Indicates whether the purchased item or virtual currency has been successfully delivered and credited to the players account. True = entitlement fulfilled; False = pending or failed delivery. Critical for player support and dispute resolution.',
    `entitlement_granted_at` TIMESTAMP COMMENT 'Timestamp when the purchased item or virtual currency was successfully delivered to the players account. Enables latency measurement between payment confirmation and entitlement fulfillment. Null if entitlement has not yet been granted.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied at the time of transaction to convert the transaction currency to the companys functional reporting currency (USD). Enables consistent cross-currency revenue aggregation and FX impact analysis.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The full retail price charged to the player before any platform fees, taxes, or discounts are applied. Expressed in the transaction currency. Part of MONETARY_TRIPLET category per TRANSACTION_HEADER role. Used as the basis for gross revenue reporting.',
    `is_f2p_conversion` BOOLEAN COMMENT 'Indicates whether this IAP transaction represents the players first-ever purchase, converting them from a Free-to-Play (F2P) non-payer to a paying player. True = first purchase / F2P conversion event. Critical for F2P conversion rate KPI and funnel analysis.',
    `is_first_purchase` BOOLEAN COMMENT 'Indicates whether this is the players first IAP transaction within this specific game title (distinct from is_f2p_conversion which is cross-title). Supports per-title FTUE monetization analysis and first-purchase offer effectiveness measurement.',
    `is_whale` BOOLEAN COMMENT 'Indicates whether the purchasing player was classified as a whale (high-spending player segment) at the time of this transaction, based on the companys LTV and spend segmentation model. Supports whale retention analysis and high-value player monetization reporting.',
    `item_type` STRING COMMENT 'Classification of the purchased item by monetization category. Drives revenue mix reporting, P2W analysis, and regulatory compliance (e.g., loot box disclosure requirements). [ENUM-REF-CANDIDATE: virtual_currency|dlc|battle_pass|loot_box|cosmetic|subscription|season_pass|consumable|durable — promote to reference product]',
    `loot_box_regulatory_flag` BOOLEAN COMMENT 'Indicates whether this IAP transaction involved a loot box or gacha mechanic subject to regulatory disclosure requirements (e.g., ESRB loot box labeling, Belgium/Netherlands gambling regulations). True = disclosure was presented to the player prior to purchase. Required for regulatory compliance reporting.',
    `net_proceeds_amount` DECIMAL(18,2) COMMENT 'The net revenue amount received by the publisher after deducting platform fees, taxes, and discounts from the gross amount. Part of MONETARY_TRIPLET net total component. Primary metric for ARPU and ARPPU net revenue calculations.',
    `payment_method` STRING COMMENT 'The payment instrument used by the player to complete the IAP (e.g., credit card, PayPal, platform wallet, gift card). Distinct from payment_channel. Used for payment mix analysis and fraud detection. [ENUM-REF-CANDIDATE: credit_card|debit_card|paypal|apple_pay|google_pay|platform_wallet|gift_card|bank_transfer — promote to reference product]',
    `platform` STRING COMMENT 'The digital distribution platform or storefront through which the IAP was executed. Drives platform-specific revenue reporting, fee calculation, and certification compliance tracking. [ENUM-REF-CANDIDATE: ios|android|pc_steam|pc_epic|playstation|xbox|nintendo_switch|web — promote to reference product if additional platforms are added]',
    `platform_fee_amount` DECIMAL(18,2) COMMENT 'The fee retained by the platform storefront (e.g., Apple 30%, Google 15-30%, Steam 30%) deducted from gross revenue. Part of MONETARY_TRIPLET adjustment component. Critical for net proceeds and margin calculations.',
    `platform_fee_rate` DECIMAL(18,2) COMMENT 'The percentage rate (expressed as a decimal, e.g., 0.30 for 30%) charged by the platform storefront on this transaction. Varies by platform, developer tier, and subscription program (e.g., Apple Small Business Program at 15%). Enables fee rate variance analysis.',
    `player_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the players registered billing country at the time of transaction. Used for geo-revenue reporting, tax jurisdiction determination, and regulatory compliance (GDPR, COPPA). Captured at transaction time to preserve historical accuracy.. Valid values are `^[A-Z]{3}$`',
    `player_level_at_purchase` STRING COMMENT 'The players in-game progression level at the time of the IAP transaction. Enables purchase propensity analysis by progression stage and informs level-gated offer targeting strategies.',
    `purchased_at` TIMESTAMP COMMENT 'The precise real-world timestamp when the player initiated and confirmed the IAP purchase event on the storefront. BUSINESS_EVENT_TIMESTAMP category per TRANSACTION_HEADER role. Stored in ISO 8601 format with timezone offset. Primary time dimension for ARPU, ARPPU, and DAP calculations.',
    `quantity` STRING COMMENT 'Number of units of the SKU purchased in this transaction. Typically 1 for most IAP events but may be greater for bundle purchases or multi-unit virtual currency packs.',
    `receipt_token` STRING COMMENT 'Cryptographic receipt or validation token issued by the platform storefront to verify the authenticity of the IAP transaction (e.g., Apple App Store receipt, Google Play purchase token). Used for server-side receipt validation to prevent fraud and unauthorized entitlement grants.',
    `refund_eligible_until` TIMESTAMP COMMENT 'The timestamp until which the player is eligible to request a refund for this IAP transaction, per platform policy and applicable consumer protection regulations. After this timestamp, refund requests may be declined. Null if the item is non-refundable.',
    `refund_reason` STRING COMMENT 'Categorized reason for the refund when transaction_status is refunded. Supports refund root-cause analysis and fraud detection. Null when no refund has been issued.. Valid values are `player_request|chargeback|fraud|technical_error|duplicate_purchase|regulatory`',
    `refunded_at` TIMESTAMP COMMENT 'Timestamp when a refund was processed for this IAP transaction. Null if no refund has been issued. Used for refund rate tracking, revenue reversal accounting, and chargeback analysis.',
    `reporting_currency_amount` DECIMAL(18,2) COMMENT 'Net proceeds amount converted to the companys functional reporting currency (USD) using the exchange_rate at transaction time. Enables standardized global revenue aggregation for ARPU, ARPPU, and LTV calculations.',
    `sku_code` STRING COMMENT 'The platform-specific SKU identifier for the purchased item as registered in the storefront (e.g., Apple App Store product ID, Google Play SKU, Steam item ID). Complements mtx_catalog_id with the external storefront identifier for reconciliation.',
    `storefront_transaction_ref` STRING COMMENT 'The externally-known transaction identifier issued by the platform storefront (e.g., Apple App Store order ID, Google Play order ID, Steam transaction ID, PlayStation Store transaction ID). BUSINESS_IDENTIFIER category per TRANSACTION_HEADER role. Used for receipt validation, dispute resolution, and platform reconciliation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component (VAT, GST, sales tax) included in or added to the gross purchase amount, as applicable by jurisdiction. Part of MONETARY_TRIPLET adjustment component. Required for financial reporting and tax compliance.',
    `transaction_status` STRING COMMENT 'Current lifecycle state of the IAP transaction. LIFECYCLE_STATUS category per TRANSACTION_HEADER role. completed = payment confirmed and entitlement granted; pending = awaiting payment confirmation; failed = payment declined or error; refunded = reversal processed; disputed = chargeback or player dispute raised; cancelled = voided before completion.. Valid values are `completed|pending|failed|refunded|disputed|cancelled`',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to this IAP transaction record (e.g., status change from pending to completed, refund processing). RECORD_AUDIT_UPDATED category per TRANSACTION_HEADER role.',
    `virtual_currency_awarded` BIGINT COMMENT 'The amount of in-game virtual currency (e.g., gems, coins, gold) credited to the players account as a result of this IAP. Null for non-currency item purchases. Essential for virtual economy balance tracking and sink/source analysis.',
    CONSTRAINT pk_iap_transaction PRIMARY KEY(`iap_transaction_id`)
) COMMENT 'Core transactional record of every In-App Purchase (IAP) event executed by a player across all platforms (iOS, Android, console, PC storefronts). Captures SKU purchased (FK to mtx_catalog), gross/net revenue, storefront, payment method, currency, exchange rate, platform fee, net proceeds, refund eligibility window, receipt token, transaction status, and offer attribution (offer_campaign_id, discount applied, F2P conversion flag). The authoritative SSOT for individual IAP revenue events — distinct from billing domain payment processing records. Feeds ARPU, ARPPU, DAP, and offer conversion rate calculations.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` (
    `virtual_currency_account_id` BIGINT COMMENT 'Unique surrogate identifier for the virtual currency account record. Primary key for the master ledger account tracking a players virtual currency wallet state.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Player billing accounts track payment methods, fraud scores, and dunning status for virtual currency purchases. Linking VC accounts to billing accounts enables payment instrument management and fraud ',
    `economy_config_id` BIGINT COMMENT 'Reference to the virtual economy configuration that governs this accounts currency rules, earn rates, spend caps, and exchange rates. Allows multiple economy configurations per game title (e.g., standard vs. event economy).',
    `game_title_id` BIGINT COMMENT 'Reference to the game title that scopes this virtual currency account. A player may hold separate accounts per game title (e.g., separate wallets for different games in the portfolio).',
    `player_account_id` BIGINT COMMENT 'Reference to the player who owns this virtual currency account. Links the wallet to the player master record.',
    `storefront_id` BIGINT COMMENT 'Reference to the distribution platform (e.g., PlayStation, Xbox, Steam, iOS, Android) on which this virtual currency account is registered. Platform scope determines applicable store policies, IAP processing rules, and certification requirements.',
    `account_close_date` DATE COMMENT 'Calendar date on which this virtual currency account was permanently closed or deactivated. Null for active accounts. Populated upon player account deletion, GDPR erasure request, or game title sunset.',
    `account_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the virtual currency account, used in player-facing support, reconciliation, and audit workflows. Distinct from the surrogate primary key.. Valid values are `^VCA-[A-Z0-9]{8,16}$`',
    `account_open_date` DATE COMMENT 'Calendar date on which this virtual currency account was first created, typically coinciding with the players first login or registration for the associated game title. Used as the effective start date for the account lifecycle.',
    `account_status` STRING COMMENT 'Current lifecycle state of the virtual currency account. Active accounts allow normal earn/spend operations. Suspended accounts are temporarily blocked (e.g., fraud investigation). Frozen accounts are locked by compliance or legal hold. Closed accounts are permanently deactivated. Pending review accounts are under fraud or abuse assessment.. Valid values are `active|suspended|frozen|closed|pending_review`',
    `balance_expiry_date` DATE COMMENT 'Date on which the current virtual currency balance (or a portion thereof) expires if unused. Applicable for event coins, promotional currencies, and time-limited battle pass tokens. Null for non-expiring currencies.',
    `conversion_status` STRING COMMENT 'Tracks whether the player has ever converted from Free-to-Play (F2P) to a paying user via IAP on this account. Supports F2P conversion funnel analytics and re-engagement campaign targeting.. Valid values are `never_converted|converted|lapsed|reactivated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this virtual currency account record was first created in the data platform. Serves as the audit creation timestamp for the Silver Layer lakehouse record.',
    `currency_code` STRING COMMENT 'Short uppercase alphanumeric code uniquely identifying the virtual currency denomination within the game economy (e.g., GEM, GOLD, BTKN). Used in ledger entries and API payloads.. Valid values are `^[A-Z]{2,8}$`',
    `currency_name` STRING COMMENT 'Human-readable display name of the virtual currency as shown to players in-game (e.g., Gems, Gold Coins, Battle Tokens). Used for player-facing UI and reporting.',
    `currency_type` STRING COMMENT 'Classification of the virtual currency held in this account. Hard currency is typically purchased with real money (e.g., gems, coins bought via IAP). Soft currency is earned through gameplay (e.g., gold, XP coins). Premium tokens are tied to specific premium content. Event coins are limited-time event currencies. Battle pass tokens are entitlement-linked currencies. [ENUM-REF-CANDIDATE: hard_currency|soft_currency|premium_token|event_coin|battle_pass_token|season_pass_token|loyalty_point — promote to reference product]. Valid values are `hard_currency|soft_currency|premium_token|event_coin|battle_pass_token`',
    `current_balance` DECIMAL(18,2) COMMENT 'The real-time current balance of virtual currency units held in this account. This is the authoritative SSOT for the players wallet state and must be reconcilable against the virtual_currency_ledger. Stored with 4 decimal places to support fractional currency economies.',
    `data_residency_region` STRING COMMENT 'Geographic region where this accounts data must be stored and processed to comply with data sovereignty and residency regulations (e.g., GDPR requires EU data to remain in EU). Drives lakehouse partition and storage routing decisions.. Valid values are `EU|US|APAC|LATAM|MEA|CA`',
    `earn_cap_daily` DECIMAL(18,2) COMMENT 'Maximum virtual currency units that can be credited to this account within a single calendar day from gameplay rewards. Prevents exploit-based economy inflation and bot farming abuse.',
    `first_purchase_date` DATE COMMENT 'Calendar date of the players first real-money In-App Purchase (IAP) that credited this virtual currency account. Null for F2P accounts that have never converted. Key metric for FTUE-to-purchase funnel analysis.',
    `fraud_flag` BOOLEAN COMMENT 'Boolean indicator set to True when this account has been flagged for confirmed or suspected fraudulent activity (e.g., chargeback abuse, currency duplication, bot farming). Triggers account suspension workflow.',
    `fraud_risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0.00–100.00) assigned to this account by the fraud detection system, reflecting the likelihood of fraudulent activity such as chargebacks, bot farming, or currency duplication exploits. Higher scores trigger manual review or automated suspension.',
    `gdpr_erasure_requested` BOOLEAN COMMENT 'Indicates whether a GDPR Right to Erasure (Right to be Forgotten) request has been submitted for the player associated with this account. When True, the account must be scheduled for anonymization or deletion per GDPR Article 17 timelines.',
    `is_purchasable` BOOLEAN COMMENT 'Indicates whether this currency type can be acquired via real-money IAP. True for hard currencies; typically false for soft currencies earned through gameplay.',
    `is_refundable` BOOLEAN COMMENT 'Indicates whether the virtual currency in this account is eligible for real-money refund upon player request or chargeback. Governs refund policy enforcement and PCI DSS chargeback handling.',
    `is_transferable` BOOLEAN COMMENT 'Indicates whether the virtual currency in this account can be transferred to another players account. Hard currencies purchased via IAP are typically non-transferable to prevent money laundering and P2W exploitation.',
    `last_earn_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent credit (earn) event on this account, whether from IAP, gameplay reward, or promotion. Supports earn-vs-spend behavioral segmentation.',
    `last_spend_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent debit (spend) event on this account. Used to identify high-frequency spenders (whales), compute time-to-first-purchase, and support MTX funnel analytics.',
    `last_transaction_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent credit or debit transaction applied to this virtual currency account. Used for dormancy detection, churn analysis, and D1/D7/D30 retention reporting.',
    `lifetime_earned` DECIMAL(18,2) COMMENT 'Cumulative total of all virtual currency units ever credited to this account since inception, including IAP purchases, gameplay rewards, promotions, and refunds. Used for LTV analysis and whale segmentation.',
    `lifetime_spent` DECIMAL(18,2) COMMENT 'Cumulative total of all virtual currency units ever debited from this account since inception, including MTX purchases, gacha pulls, DLC unlocks, and cosmetic purchases. Used for ARPPU and conversion rate analytics.',
    `max_balance_cap` DECIMAL(18,2) COMMENT 'Maximum virtual currency units allowed to be held in this account at any point in time. Enforces economy balance controls and prevents hoarding that could destabilize the virtual economy.',
    `minor_account_flag` BOOLEAN COMMENT 'Indicates whether the account holder is classified as a minor (under 18, or under 13 for COPPA jurisdictions). Drives spend cap enforcement, parental consent requirements, and loot box/gacha access restrictions.',
    `notes` STRING COMMENT 'Free-text field for operational notes entered by player support agents or compliance teams regarding this virtual currency account (e.g., manual balance adjustments, fraud investigation notes, legal hold reasons). Classified confidential due to potential sensitivity of support context.',
    `parental_control_flag` BOOLEAN COMMENT 'Indicates whether parental controls are active on this account, restricting IAP and spend capabilities. Required for COPPA compliance for accounts associated with minor players.',
    `pending_balance` DECIMAL(18,2) COMMENT 'Virtual currency units that have been credited but are not yet available for spending, typically due to IAP payment processing delays, chargeback hold periods, or promotional vesting schedules.',
    `player_segment` STRING COMMENT 'Monetization segment classification of the account holder based on spending behavior. F2P (Free-to-Play) players have never purchased. Minnow/Dolphin/Whale tiers reflect increasing spend levels. Used for ARPPU, DAP, and LTV segmentation analytics.. Valid values are `f2p|minnow|dolphin|whale|lapsed_payer|churned`',
    `record_version` STRING COMMENT 'Monotonically incrementing version counter for this virtual currency account record, incremented on each update. Supports optimistic concurrency control and Silver Layer SCD (Slowly Changing Dimension) tracking.',
    `reserved_balance` DECIMAL(18,2) COMMENT 'Virtual currency units currently locked/reserved for in-progress transactions (e.g., a gacha pull in flight, a marketplace listing, or an auction bid). Prevents double-spend scenarios in concurrent transaction environments.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that originated this virtual currency account record (e.g., GAMEANALYTICS, AMPLITUDE, SAP_S4, INTERNAL_WALLET). Used for data lineage, reconciliation, and ETL audit trails.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `spend_cap_daily` DECIMAL(18,2) COMMENT 'Maximum virtual currency units that can be spent from this account within a single calendar day. Used for responsible gaming controls, fraud prevention, and COPPA-compliant spending limits for minor accounts.',
    `total_iap_purchase_count` STRING COMMENT 'Cumulative count of real-money In-App Purchase (IAP) transactions that have credited this virtual currency account since inception. Used for purchase frequency analysis and whale identification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this virtual currency account record was last modified in the data platform. Used for incremental ETL processing, change data capture, and audit trail compliance.',
    CONSTRAINT pk_virtual_currency_account PRIMARY KEY(`virtual_currency_account_id`)
) COMMENT 'Master ledger account tracking a players virtual currency balances across all in-game economies (hard currency, soft currency, premium tokens, event coins). Stores current balance, lifetime earned/spent totals, last transaction timestamp, currency type, game title scope, and account status. The SSOT for a players virtual wallet state — distinct from real-money payment records in billing. Balances are reconcilable against virtual_currency_ledger entries.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` (
    `virtual_currency_ledger_id` BIGINT COMMENT 'Unique surrogate primary key for each immutable ledger entry recording a virtual currency credit or debit event for a player account.',
    `achievement_id` BIGINT COMMENT 'Identifier of the in-game quest or mission whose completion triggered this virtual currency reward credit. Null for non-quest-sourced entries. Enables quest economy reward analysis and player progression correlation.',
    `battle_pass_id` BIGINT COMMENT 'Identifier of the battle pass season associated with this ledger entry when the transaction source is a battle pass grant or battle pass purchase. Enables battle pass economy contribution analysis.',
    `build_id` BIGINT COMMENT 'Foreign key linking to studio.build. Business justification: Virtual currency grants/spends occur within specific builds. Tracking build version supports economy balance analysis (currency flow by build), exploit detection (abnormal currency generation in speci',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Virtual currency movements may post to specific GL accounts. Accounting integration for virtual economy liability account mapping.',
    `gacha_pool_id` BIGINT COMMENT 'Identifier of the gacha or loot box pool that was activated when this ledger entry represents a gacha spend debit. Enables gacha economy spend analysis, pity counter tracking, and regulatory disclosure reporting.',
    `game_server_id` BIGINT COMMENT 'Identifier of the distribution platform (e.g., PC, console, mobile) on which the virtual currency transaction occurred. Supports platform-level economy reporting.',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title within whose virtual economy this ledger entry was recorded. Enables per-title currency economy analysis.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Virtual currency movements have accounting implications for deferred revenue recognition and liability tracking. Required for financial statement accuracy and regulatory compliance.',
    `iap_transaction_id` BIGINT COMMENT 'Reference to the originating In-App Purchase (IAP) transaction record when this ledger entry was funded by a real-money purchase. Null for non-IAP sources.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Virtual currency movements may generate journal entries for liability adjustments. Accounting integration for virtual economy balance sheet impact.',
    `offer_campaign_id` BIGINT COMMENT 'Identifier of the promotional offer, bundle, or limited-time deal associated with this ledger entry. Enables offer performance analysis, conversion rate tracking, and bonus currency grant attribution.',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: Virtual currency purchases via real money require payment linkage for refund processing, chargeback handling, and financial reconciliation. Ledger entries for paid VC must trace to payment records for',
    `player_account_id` BIGINT COMMENT 'Unique identifier of the player whose virtual currency account is affected by this ledger entry. Links to the player master record.',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to monetization.promotion. Business justification: Promotions can grant virtual currency as rewards. The ledger should track when currency is awarded via promotional campaigns. Currently virtual_currency_ledger tracks offer_campaign_id but not promoti',
    `reversal_reference_virtual_currency_ledger_id` BIGINT COMMENT 'Self-referencing identifier pointing to the original ledger entry that this entry reverses, or to the reversal entry that corrects this entry. Null for non-reversal entries. Enables full audit chain reconstruction for refunds and administrative corrections.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Currency ledger entries granting assets (quest rewards, achievement unlocks) need direct asset reference for reward delivery, player inventory updates, and economy balance tracking.',
    `session_id` BIGINT COMMENT 'Identifier of the player game session during which this virtual currency transaction occurred. Enables session-level economy analysis, session length correlation with spend, and fraud detection based on session anomalies.',
    `title_sku_id` BIGINT COMMENT 'The Stock Keeping Unit (SKU) identifier of the in-game store item or bundle that was purchased or consumed in this transaction. Applicable for IAP-funded credits and MTX spend debits. Null for non-store transactions.',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Tracks virtual currency earned/spent during tournament events (watch rewards, participation bonuses, tournament-themed purchases). Essential for tournament engagement economy analysis and reward distr',
    `virtual_currency_account_id` BIGINT COMMENT 'Foreign key linking to monetization.virtual_currency_account. Business justification: Critical missing FK: Every virtual currency ledger entry MUST belong to a specific virtual currency account. The ledger records all credits/debits to accounts. Currently ledger has player_account_id, ',
    `balance_after` DECIMAL(18,2) COMMENT 'The players running virtual currency balance for this currency code immediately after this ledger entry was applied. The authoritative post-transaction balance used for reconciliation and fraud detection.',
    `balance_before` DECIMAL(18,2) COMMENT 'The players virtual currency balance for this currency code immediately before this ledger entry was applied. Enables full audit trail reconstruction and balance reconciliation.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'The additional virtual currency units granted as a promotional bonus on top of the base delta_amount for this credit entry (e.g., Buy 1000 gems, get 200 free). Null or zero for non-promotional entries. Enables bonus economy impact analysis.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the players registered or detected location at the time of the transaction. Used for geo-segmented economy analysis, regulatory compliance (GDPR, COPPA), and regional pricing strategy.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when this ledger record was first written to the data platform. Distinct from transaction_timestamp; used for data pipeline audit, SLA monitoring, and ingestion latency measurement.',
    `currency_code` STRING COMMENT 'Short alphanumeric code identifying the specific virtual currency denomination within the game (e.g., GEMS, GOLD, CRYSTALS, TOKENS). Enables multi-currency economy tracking within a single game title.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `currency_name` STRING COMMENT 'Human-readable display name of the virtual currency as shown to players in-game (e.g., Gems, Gold Coins, Battle Tokens). Used for player-facing reporting and support communications.',
    `currency_type` STRING COMMENT 'Classification of the virtual currency involved in this ledger entry. Hard currency is typically purchased with real money (e.g., gems, coins bought via IAP); soft currency is earned through gameplay (e.g., gold, XP tokens); premium currency bridges both; event and loyalty currencies are time-limited or reward-based.. Valid values are `hard_currency|soft_currency|premium_currency|event_currency|loyalty_token`',
    `data_source_system` STRING COMMENT 'The originating operational system or service that generated this ledger entry record. Enables data lineage tracking, source system reconciliation, and pipeline audit. Aligns with GameAnalytics, Amplitude, internal economy microservices, platform SDKs, or manual administrative entry.. Valid values are `gameanalytics|amplitude|internal_economy_service|platform_sdk|manual`',
    `delta_amount` DECIMAL(18,2) COMMENT 'The absolute change in virtual currency units for this ledger entry. Always a positive value; the entry_type field determines whether this is an addition or subtraction. Enables precise virtual economy flow analysis.',
    `device_type` STRING COMMENT 'The category of device on which the player was playing when this virtual currency transaction occurred. Enables device-level economy analysis and cross-platform spend behavior reporting.. Valid values are `mobile|pc|console|tablet|other`',
    `entry_reference_code` STRING COMMENT 'Externally-known unique business identifier for this ledger entry, used for audit trail reconciliation, player support lookups, and cross-system tracing. Sourced from the originating transaction system.. Valid values are `^[A-Z0-9_-]{8,64}$`',
    `entry_type` STRING COMMENT 'Indicates whether this ledger entry is a credit (addition of virtual currency to the player account) or a debit (deduction of virtual currency from the player account). Fundamental to double-entry virtual economy accounting.. Valid values are `credit|debit`',
    `exchange_rate_to_usd` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the real_money_amount to USD at the time of the transaction. Used for normalized global revenue reporting and ARPU/ARPPU calculations in a common currency.',
    `expiry_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) at which the virtual currency units credited in this entry will expire and be removed from the players balance, if applicable. Used for time-limited event currencies and promotional grants. Null for non-expiring currencies.',
    `fraud_flag` BOOLEAN COMMENT 'Indicates whether this ledger entry has been flagged by the fraud detection system as potentially fraudulent (True) or clean (False). Flagged entries may be subject to manual review or automatic reversal. Supports virtual economy integrity monitoring.',
    `fraud_review_status` STRING COMMENT 'The outcome of the fraud review process for this ledger entry. Not_reviewed: no review initiated; Under_review: active investigation; Cleared: reviewed and confirmed legitimate; Confirmed_fraud: verified fraudulent transaction requiring reversal and potential account action.. Valid values are `not_reviewed|under_review|cleared|confirmed_fraud`',
    `is_first_purchase` BOOLEAN COMMENT 'Indicates whether this ledger entry represents the players first-ever real-money virtual currency purchase (True) or a repeat purchase (False). Critical for F2P conversion funnel analysis and first-purchase conversion rate reporting.',
    `is_reversal` BOOLEAN COMMENT 'Indicates whether this ledger entry is a reversal of a previously posted entry (True) or an original transaction (False). Used to filter reversals from net economy flow calculations and to identify correction patterns.',
    `ledger_entry_status` STRING COMMENT 'Current lifecycle state of this ledger entry. Posted entries are confirmed and applied to the player balance. Reversed entries have been corrected by a corresponding offsetting entry. Pending entries are awaiting confirmation. Failed entries did not complete. Voided entries were cancelled before posting.. Valid values are `posted|reversed|pending|failed|voided`',
    `notes` STRING COMMENT 'Free-text notes added by a game operations administrator or automated system to provide additional context for this ledger entry, particularly for administrative adjustments, manual corrections, or escalated player support resolutions.',
    `player_level_at_transaction` STRING COMMENT 'The players in-game progression level at the time this virtual currency transaction occurred. Enables economy analysis segmented by player progression stage, supporting game balance tuning and monetization funnel optimization.',
    `player_segment` STRING COMMENT 'Monetization segment of the player at the time of this transaction, based on historical spend behavior. Whale: top spenders; Dolphin: mid-tier payers; Minnow: low-spend payers; F2P Non-Payer: free-to-play players who have never paid; Lapsed Payer: previously paying players who have not spent recently. Supports ARPPU and LTV segmentation.. Valid values are `whale|dolphin|minnow|f2p_non_payer|lapsed_payer`',
    `real_money_amount` DECIMAL(18,2) COMMENT 'The real-world fiat currency amount paid by the player to fund this virtual currency credit, applicable only for IAP-sourced entries. Used for ARPU, ARPPU, and LTV calculations and for revenue reconciliation against payment processor records.',
    `real_money_currency_code` STRING COMMENT 'ISO 4217 three-letter fiat currency code of the real-money amount paid for this IAP-funded virtual currency credit (e.g., USD, EUR, GBP). Null for non-IAP entries. Required for multi-currency revenue reporting and FX reconciliation.. Valid values are `^[A-Z]{3}$`',
    `transaction_date` DATE COMMENT 'Calendar date (UTC) on which the virtual currency transaction occurred, derived from transaction_timestamp. Used as a partition key and for day-level aggregations including DAU spend analysis and D1/D7/D30 retention cohort currency flows.',
    `transaction_source` STRING COMMENT 'The originating business event or mechanism that triggered this ledger entry. Classifies the economic source of every credit or debit for virtual economy analytics, monetization reporting, and fraud detection. [ENUM-REF-CANDIDATE: iap|reward|quest_completion|gacha_spend|battle_pass_grant|daily_login|achievement|refund|admin_adjustment|season_pass|dlc_grant — promote to reference product]',
    `transaction_source_category` STRING COMMENT 'High-level grouping of the transaction source for roll-up analytics and reporting. Monetization covers IAP and real-money-funded events; gameplay_reward covers quest, achievement, and daily login grants; promotional covers battle pass and season pass grants; administrative covers manual adjustments; refund covers reversals.. Valid values are `monetization|gameplay_reward|promotional|administrative|refund`',
    `transaction_timestamp` TIMESTAMP COMMENT 'The precise real-world date and time (UTC) at which the virtual currency credit or debit event occurred in the game system. This is the principal business event time, distinct from the record ingestion timestamp. Conforms to yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time (UTC) when this ledger record was last modified in the data platform. For an immutable ledger, updates should be rare and limited to administrative corrections; tracked for audit compliance.',
    `virtual_to_real_ratio` DECIMAL(18,2) COMMENT 'The conversion ratio between virtual currency units and real-world fiat currency at the time of this transaction (e.g., 100 gems = $0.99 USD). Captures the effective price per virtual currency unit for economy valuation and regulatory disclosure.',
    CONSTRAINT pk_virtual_currency_ledger PRIMARY KEY(`virtual_currency_ledger_id`)
) COMMENT 'Immutable transactional ledger recording every credit and debit to a players virtual currency account. Each entry captures the currency type, delta amount, running balance, transaction source (IAP, reward, quest completion, gacha spend, battle pass grant), reference transaction ID, and timestamp. Enables full virtual economy audit trail and reconciliation of soft/hard currency flows.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`mtx_catalog` (
    `mtx_catalog_id` BIGINT COMMENT 'Unique surrogate identifier for each microtransaction catalog entry in the Silver layer lakehouse. Primary key for the mtx_catalog product. Entity role: MASTER_RESOURCE — represents a purchasable offering (product/SKU) the business sells to players.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: MTX items launch with content drops for release coordination. Essential for SKU availability timing, version compatibility, and synchronized store/content updates in live service games.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: MTX catalog items attributed to cost centers for profitability analysis. Product costing requirement for margin analysis and pricing decisions.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: MTX items are designed and versioned within development projects. Product managers track which project/build introduced each SKU for content pipeline management, revenue attribution to dev teams, and ',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: MTX catalog items require visual assets (icons, 3D models, preview images) for storefront display. Essential for store UI rendering and player purchase decisions in live game economy.',
    `game_studio_id` BIGINT COMMENT 'Foreign key linking to studio.game_studio. Business justification: MTX items are created by specific studios (especially in multi-studio publishers). Tracking studio ownership supports royalty calculations (revenue share per studio), content attribution, and studio-l',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title to which this MTX offering belongs. Links the catalog entry to the specific game product in the Game Title domain, enabling per-title revenue analysis, ARPU/ARPPU segmentation, and title-level monetization reporting.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Catalog items based on licensed IP (character skins, branded weapons) must track IP source for royalty rate application, marketing approval workflows, and content rating compliance per license terms.',
    `localization_string_id` BIGINT COMMENT 'Foreign key linking to content.localization_string. Business justification: Store items require localized names/descriptions for international storefronts. Mandatory for global operations, regional compliance, and player-facing store UI in multiple languages.',
    `age_restriction_minimum` STRING COMMENT 'Minimum player age in years required to purchase this MTX offering, derived from content_rating_esrb and content_rating_pegi classifications. Enforced at checkout for COPPA compliance (under-13 restrictions in USA) and GDPR child data protection requirements in EU (under-16 in some jurisdictions).',
    `base_price_usd` DECIMAL(18,2) COMMENT 'Canonical base retail price of the MTX offering denominated in US Dollars (USD). Serves as the reference price from which regional overrides and promotional discounts are derived. Used in ARPU, ARPPU, and LTV calculations. Maps to MASTER_RESOURCE category: MEASUREMENT_OR_VALUE. Source of truth for SAP S/4HANA FI revenue recognition.',
    `bundle_parent_sku_code` STRING COMMENT 'SKU code of the parent bundle offering if this item is a component of a larger bundle package. Null for standalone items. Enables bundle composition analysis, bundle vs. individual item revenue attribution, and bundle discount effectiveness reporting.. Valid values are `^[A-Z0-9_-]{3,64}$`',
    `content_rating_esrb` STRING COMMENT 'ESRB content rating applicable to this MTX offering, restricting purchase eligibility for underage players in North American markets. Critical for COPPA compliance — items rated M or AO must enforce age-gate purchase restrictions. Sourced from ESRB rating submission records.. Valid values are `EC|E|E10+|T|M|AO|RP|RP17+`',
    `content_rating_pegi` STRING COMMENT 'PEGI content rating applicable to this MTX offering for European markets. Restricts purchase eligibility for underage players in EU/EEA jurisdictions. Items with PEGI 18 rating require age verification enforcement per GDPR and national consumer protection laws.. Valid values are `3|7|12|16|18`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MTX catalog entry was first created in the system, recorded in ISO 8601 format with timezone offset (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail requirements, catalog versioning, and data lineage tracking in the Silver layer lakehouse.',
    `currency_rounding_policy` STRING COMMENT 'Defines the mathematical rounding rule applied when converting base_price_usd to regional currencies or when applying promotional discounts that result in fractional currency amounts. Ensures consistent pricing presentation across storefronts and compliance with local consumer protection pricing laws.. Valid values are `round_half_up|round_half_down|round_up|round_down|banker`',
    `drm_protection_type` STRING COMMENT 'Type of Digital Rights Management (DRM) protection applied to this MTX offering to prevent unauthorized duplication or transfer of entitlements. platform_native = Steam/PSN/Xbox DRM; entitlement_server = proprietary server-side entitlement validation; none = no DRM (e.g., promo codes).. Valid values are `none|platform_native|third_party|entitlement_server`',
    `drop_rate_disclosed` BOOLEAN COMMENT 'Indicates whether the probability/drop rate for randomized rewards within this MTX offering (e.g., loot box, gacha pull) has been publicly disclosed to players. Required for compliance with ESRB loot box disclosure policy, Chinese Ministry of Culture gacha regulations, and Apple App Store Review Guidelines Section 3.1.1.',
    `effective_from_date` DATE COMMENT 'Calendar date on which this MTX catalog entry becomes available for purchase on storefronts. Defines the start of the offerings active pricing window. Used in time-series revenue analysis, seasonal campaign planning, and live operations (GaaS) scheduling.',
    `effective_until_date` DATE COMMENT 'Calendar date on which this MTX catalog entry is no longer available for purchase. Null indicates the offering has no planned end date (evergreen). Drives storefront availability logic, seasonal item retirement workflows, and battle pass expiry enforcement.',
    `image_asset_path` STRING COMMENT 'CDN-relative path or URI to the primary promotional image asset for this MTX offering as displayed in the in-game store (e.g., /assets/mtx/skins/dragon_pack_thumb.png). Managed via Perforce Helix Core digital asset management. Used by storefront rendering pipeline.',
    `internal_notes` STRING COMMENT 'Internal business notes for monetization team use, capturing context about pricing decisions, promotional strategy rationale, or platform negotiation notes. Not exposed to players. Classified confidential as it may contain commercially sensitive pricing strategy information.',
    `is_giftable` BOOLEAN COMMENT 'Indicates whether this MTX offering can be purchased by one player and gifted to another player. Relevant for viral K-Factor mechanics and social gifting features. False for account-bound items, consumables with immediate activation, or items restricted by platform gifting policies.',
    `is_promo_code_redeemable` BOOLEAN COMMENT 'Indicates whether this MTX offering can be obtained via promotional or gift code redemption (distinct from direct purchase). Supports marketing campaign attribution in AppsFlyer/Adjust and tracks promo code distribution economics separately from paid IAP revenue.',
    `is_sale_eligible` BOOLEAN COMMENT 'Indicates whether this MTX offering is eligible to be included in promotional sale events (e.g., seasonal sales, platform-wide discount events). False for items with fixed pricing agreements (e.g., certain DLC with publisher pricing floors) or newly released items under launch price protection windows.',
    `item_description` STRING COMMENT 'Detailed player-facing description of the MTX offering explaining its contents, benefits, and any restrictions. Used in storefront listings, player support knowledge base (Zendesk), and community management communications. Must comply with FTC truth-in-advertising standards.',
    `item_type` STRING COMMENT 'Categorical classification of the purchasable offering defining its functional nature within the game economy. Drives monetization analytics segmentation (e.g., cosmetic vs. pay-to-win analysis), ESRB/PEGI disclosure requirements for loot boxes, and revenue recognition rules. Maps to MASTER_RESOURCE category: CLASSIFICATION_OR_TYPE. [ENUM-REF-CANDIDATE: cosmetic|consumable|booster|currency_pack|loot_box_key|dlc|expansion|promo_code — promote to reference product]',
    `lifecycle_status` STRING COMMENT 'Current operational state of the MTX catalog entry governing whether it is purchasable by players. active = currently available for purchase; deprecated = no longer sold but entitlements honored; seasonal = available only during defined seasonal windows; delisted = permanently removed from all storefronts. Maps to MASTER_RESOURCE category: LIFECYCLE_STATUS. Drives storefront availability logic and revenue forecasting.. Valid values are `active|deprecated|seasonal|delisted`',
    `localization_key` STRING COMMENT 'Unique string key used to look up localized display_name and item_description translations in the games localization system (e.g., mtx.skin.dragon.name). Enables multi-language storefront support across global markets without duplicating catalog entries per locale.. Valid values are `^[a-z0-9_.]{3,128}$`',
    `loot_box_disclosure_required` BOOLEAN COMMENT 'Indicates whether this MTX offering requires explicit loot box / randomized reward disclosure to players prior to purchase, as mandated by ESRB Loot Box Disclosure Policy, PEGI Interactive Elements labeling, and various national gambling regulations. True for item_type = loot_box_key or gacha mechanics.',
    `max_purchase_limit` STRING COMMENT 'Maximum number of times a single player account can purchase this MTX offering (e.g., limited edition items capped at 1 per account, or promotional packs capped at 3). Null indicates unlimited purchases. Enforced at transaction time to prevent abuse and maintain virtual economy balance.',
    `platform_availability` STRING COMMENT 'Pipe-delimited list of platform identifiers on which this MTX offering is available for purchase (e.g., steam|epic|psn|xbox|ios|android|switch). Drives storefront availability logic across Steamworks, Epic Games Store, Console SDKs, and mobile app stores. [ENUM-REF-CANDIDATE: steam|epic|psn|xbox|ios|android|switch|gog|amazon — promote to reference product]',
    `platform_fee_pct` DECIMAL(18,2) COMMENT 'Percentage of the retail price retained by the distribution platform (e.g., Steam 30%, Epic Games Store 12%, Apple App Store 30%, Google Play 15-30%) as a marketplace commission. Used in net revenue calculations, ARPPU analysis, and SAP S/4HANA CO profitability reporting. Expressed as a percentage (e.g., 30.00 = 30%).',
    `price_eur` DECIMAL(18,2) COMMENT 'Regional retail price override for the European market denominated in Euros (EUR). Accounts for VAT obligations, PEGI market requirements, and purchasing power parity adjustments. Null indicates base_price_usd converted at current exchange rate applies.',
    `price_gbp` DECIMAL(18,2) COMMENT 'Regional retail price override for the United Kingdom market denominated in British Pounds Sterling (GBP). Reflects UK post-Brexit pricing strategy and VAT requirements. Null indicates base_price_usd converted at current exchange rate applies.',
    `price_jpy` DECIMAL(18,2) COMMENT 'Regional retail price override for the Japanese market denominated in Japanese Yen (JPY). JPY has no decimal subdivision; stored as whole yen. Reflects CERO market requirements and local consumer pricing norms. Null indicates base_price_usd converted at current exchange rate applies.',
    `price_krw` DECIMAL(18,2) COMMENT 'Regional retail price override for the South Korean market denominated in Korean Won (KRW). KRW has no decimal subdivision; stored as whole won. Reflects GRAC rating market requirements and local pricing strategy. Null indicates base_price_usd converted at current exchange rate applies.',
    `promo_discount_pct` DECIMAL(18,2) COMMENT 'Current or default promotional discount percentage applied to the base price during sale events (e.g., 25.00 = 25% off). Drives sale pricing calculations in the storefront. Null or 0 indicates no active promotional discount. Used in conversion rate analysis and F2P monetization funnel reporting.',
    `promo_discount_type` STRING COMMENT 'Defines the mechanism by which the promotional discount is applied: percentage = percentage reduction from base price; fixed_amount = fixed currency amount deducted; bundle_override = price is overridden by a bundle-level price; free = item is granted at no charge (e.g., F2P promotional giveaway).. Valid values are `percentage|fixed_amount|bundle_override|free`',
    `quantity_in_bundle` STRING COMMENT 'Number of units of this item included when purchased as part of a bundle or currency pack (e.g., a 1000 Gold Pack has quantity_in_bundle = 1000 for the gold currency item). Null or 1 for single-unit items. Supports virtual economy sink analysis and bundle value proposition reporting.',
    `release_date` DATE COMMENT 'The date on which this MTX offering was first made publicly available for purchase across any platform. Distinct from effective_from_date which governs pricing windows. Used for cohort analysis, D1/D7/D30 revenue attribution, and new content launch performance reporting.',
    `retirement_date` DATE COMMENT 'The date on which this MTX offering was permanently retired and delisted from all storefronts. Null indicates the offering has not been retired. Used for catalog lifecycle management, legacy entitlement support tracking, and revenue sunset analysis.',
    `revenue_recognition_code` STRING COMMENT 'SAP S/4HANA FI revenue recognition classification code governing how and when revenue from this MTX offering is recognized (e.g., immediate recognition for consumables, deferred recognition for battle passes/subscriptions over the service period). Ensures compliance with ASC 606 / IFRS 15 revenue recognition standards.',
    `sku_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying this purchasable offering across all platforms and storefronts (e.g., SKIN_DRAGON_001, CURRPACK_1000G). Serves as the canonical business identifier used in platform SDKs, SAP S/4HANA SD module, and Steamworks/Epic Games Store product listings. Maps to MASTER_RESOURCE category: BUSINESS_IDENTIFIER.. Valid values are `^[A-Z0-9_-]{3,64}$`',
    `tax_category_code` STRING COMMENT 'Tax classification code used in SAP S/4HANA FI for VAT/GST/sales tax determination on this MTX offering. Different item types (DLC, virtual currency, subscription) may attract different tax treatment across jurisdictions. Drives automated tax calculation in the payment processing pipeline.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this MTX catalog entry, recorded in ISO 8601 format with timezone offset (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used to detect pricing changes, status transitions, and catalog updates for downstream ETL incremental loads and audit compliance.',
    `virtual_currency_cost` DECIMAL(18,2) COMMENT 'The in-game virtual currency amount required to purchase this offering through the in-game soft or hard currency economy (e.g., 500 Gold, 200 Gems). Null if the item is only purchasable with real money. Supports virtual economy balance analysis and P2W mechanics assessment.',
    `virtual_currency_type` STRING COMMENT 'The specific in-game virtual currency denomination used for virtual_currency_cost (e.g., gold, gems, credits, tokens). Null if item is real-money only. Supports multi-currency virtual economy modeling and sink/source balance reporting in GameAnalytics/Amplitude.',
    CONSTRAINT pk_mtx_catalog PRIMARY KEY(`mtx_catalog_id`)
) COMMENT 'Master catalog of all microtransaction (MTX) offerings available for purchase across all game titles, including individual items, bundles, currency packs, DLC SKUs, loot box keys, and promo/gift code redeemable items. Defines each purchasable offering: SKU code, display name, item type (cosmetic, consumable, booster, currency_pack, loot_box_key, dlc, expansion, promo_code), base price, regional price overrides (USD, EUR, GBP, JPY, KRW), platform fee percentage, promotional discount rules, effective pricing date ranges, currency rounding policy, platform availability flags, sale eligibility, content rating restrictions (ESRB/PEGI), release date, retirement date, and lifecycle status (active, deprecated, seasonal, delisted). The SSOT for what can be purchased and at what price — distinct from actual purchase transactions and distinct from virtual item definitions in the content domain.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`battle_pass` (
    `battle_pass_id` BIGINT COMMENT 'Unique surrogate identifier for a battle pass or season pass product definition record. Primary key for this entity.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Battle pass content development may be capitalized as part of game development. Capitalization policy requirement for intangible asset tracking.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Battle passes launch as part of major content releases (seasons, expansions). Critical for live ops planning, marketing coordination, and ensuring content/monetization version alignment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Battle passes are cost center activities for studio P&L tracking. Management accounting for content development cost attribution.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Battle passes are content deliverables created by dev teams. Linking to dev_project enables content pipeline tracking, resource allocation analysis, live-ops planning coordination, and attribution of ',
    `asset_id` BIGINT COMMENT 'Foreign key linking to content.asset. Business justification: Battle passes feature hero cosmetic assets as tier rewards. Links reward content to pass definition for marketing materials, reward fulfillment, and player progression UI display.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Battle pass seasons have development and marketing budgets tracked. Project budget management for content development and launch campaigns.',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Battle passes ARE live-ops content cycles in GaaS titles. Many studios model battle pass seasons as live_ops_cycles with MTX tie-ins. This link enables unified live-ops planning, content-to-revenue at',
    `game_studio_id` BIGINT COMMENT 'Foreign key linking to studio.game_studio. Business justification: Battle passes are designed by specific studios. Tracking studio ownership supports revenue share calculations (studio gets % of battle pass revenue), content pipeline management, and studio-level P&L ',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this battle pass is defined. Links the pass product to its parent game.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Battle passes featuring licensed IP (Fortnite Marvel season) require IP tracking for revenue share calculation, content approval, and regulatory disclosure. Essential for season-based royalty reportin',
    `marketing_campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: Battle passes are major seasonal content releases requiring dedicated marketing campaigns for launch promotion, player acquisition, and conversion tracking. Essential for measuring battle pass marketi',
    `localization_string_id` BIGINT COMMENT 'Foreign key linking to content.localization_string. Business justification: Battle pass UI, tier names, and reward descriptions need localization for international player base. Essential for global live service operations and regional marketing.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Battle passes are profit center products for segment reporting. Financial reporting requirement for product line P&L.',
    `royalty_accrual_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_accrual. Business justification: Battle passes featuring licensed content generate royalty obligations. IP licensing accounting for third-party content in seasonal content.',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Battle passes align with seasonal events (Halloween, Winter, Anniversary) for thematic content coordination. Essential for live ops planning, marketing campaigns, and player engagement timing.',
    `approved_by` STRING COMMENT 'Username or identifier of the business approver (e.g., Monetization Lead, Live Ops Director) who authorized this battle pass product definition for release. Supports governance and release gate compliance.',
    `contains_loot_box` BOOLEAN COMMENT 'Indicates whether this battle pass includes any randomized reward mechanics (loot boxes or gacha elements). Critical for regulatory compliance disclosures under FTC, European Commission Digital Services Act, and PEGI/ESRB loot box disclosure requirements.',
    `content_entitlements` STRING COMMENT 'Comma-separated list or reference to DLC (Downloadable Content) packs, cosmetic bundles, or game content items included as flat entitlements with this pass (primarily for content_access and hybrid types). Supports entitlement management and player support.',
    `coppa_restricted` BOOLEAN COMMENT 'Indicates whether this battle pass is restricted from purchase or display to players identified as under 13 years of age, in compliance with COPPA (Childrens Online Privacy Protection Act) requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this battle pass product definition record was first created in the system. Supports audit trail and data lineage tracking.',
    `duration_days` STRING COMMENT 'Total number of days the battle pass is active, derived from start and end dates. Used for season length planning and player engagement benchmarking.',
    `end_date` DATE COMMENT 'Calendar date on which the battle pass expires and is no longer purchasable or progressable. Marks the end of the associated season.',
    `esrb_rating` STRING COMMENT 'ESRB content rating applicable to this battle pass and its associated content (e.g., T for Teen). Required for North American regulatory compliance and storefront listing.. Valid values are `E|E10+|T|M|AO|RP`',
    `free_tier_count` STRING COMMENT 'Number of tiers accessible on the free track without purchasing the premium pass. Supports F2P (Free-to-Play) conversion funnel analysis by quantifying the free value proposition.',
    `gdpr_data_processing_note` STRING COMMENT 'Free-text note documenting any GDPR-relevant data processing activities associated with this pass product (e.g., behavioral tracking for progression analytics). Supports GDPR Article 30 Records of Processing Activities.',
    `has_free_track` BOOLEAN COMMENT 'Indicates whether this battle pass includes a free progression track accessible to all players without purchase. Core F2P design flag used in conversion funnel and monetization analysis.',
    `has_premium_plus` BOOLEAN COMMENT 'Indicates whether this pass offers a higher-tier premium upgrade (e.g., Battle Pass Bundle or Premium+) that includes additional rewards or tier skips beyond the base premium pass.',
    `is_cross_platform` BOOLEAN COMMENT 'Indicates whether progress and entitlements from this battle pass are shared across multiple platforms (cross-progression). Relevant for platform certification and player experience consistency.',
    `jira_epic_key` STRING COMMENT 'Jira Epic key linking this battle pass product definition to its corresponding live-ops planning epic in the project management system (e.g., LIVEOPS-421). Enables traceability from product definition to development and QA work.. Valid values are `^[A-Z]+-d+$`',
    `launch_region` STRING COMMENT 'Comma-separated ISO 3166-1 alpha-3 country codes identifying the geographic regions where this battle pass is available for sale. Supports regional pricing, compliance, and marketing segmentation.. Valid values are `^[A-Z]{2,3}(,[A-Z]{2,3})*$`',
    `loot_box_disclosure_url` STRING COMMENT 'URL to the publicly accessible odds disclosure page for any randomized reward mechanics included in this pass. Required for regulatory compliance in jurisdictions mandating loot box transparency (FTC, EU DSA). Null when contains_loot_box is false.',
    `max_tier_skips` STRING COMMENT 'Maximum number of tiers a player may purchase to skip (advance instantly) within this battle pass. Governs the pay-to-progress ceiling and P2W (Pay-to-Win) mechanics compliance.',
    `pass_code` STRING COMMENT 'Externally-known alphanumeric code or SKU that uniquely identifies this pass product across distribution platforms (e.g., Steamworks, console SDKs, app stores). Used in platform certification and store listings.. Valid values are `^[A-Z0-9_-]{3,50}$`',
    `pass_status` STRING COMMENT 'Current lifecycle state of the battle pass product definition. draft = in design; scheduled = approved and awaiting season start; active = currently purchasable and progressing; expired = season ended, no longer purchasable; retired = permanently removed from catalog.. Valid values are `draft|scheduled|active|expired|retired`',
    `pass_type` STRING COMMENT 'Classification of the pass monetization model. progression_tiered = XP-gated tier unlock system; content_access = flat subscription-style content entitlement (season pass); hybrid = combines both tier progression and flat content access.. Valid values are `progression_tiered|content_access|hybrid`',
    `pegi_rating` STRING COMMENT 'PEGI content rating applicable to this battle pass and its associated content (e.g., 12). Required for European regulatory compliance and storefront listing.. Valid values are `3|7|12|16|18`',
    `platform_availability` STRING COMMENT 'Comma-separated list of platforms on which this battle pass is available for purchase (e.g., PC,PS5,XBOX,MOBILE,SWITCH). Drives platform-specific store listing and certification via Steamworks/Console SDKs. [ENUM-REF-CANDIDATE: PC|PS5|XBOX|MOBILE|SWITCH|STADIA — promote to reference product]',
    `premium_plus_price_usd` DECIMAL(18,2) COMMENT 'Retail price in USD for the premium-plus or bundle upgrade tier of the battle pass, if applicable. Null when has_premium_plus is false.',
    `premium_price_usd` DECIMAL(18,2) COMMENT 'Base retail price of the premium battle pass in US Dollars. The principal quantitative monetary value of this pass product. Used for ARPU, ARPPU, and revenue forecasting.',
    `premium_price_virtual_currency` STRING COMMENT 'Price of the premium battle pass denominated in the games primary virtual currency (e.g., V-Bucks, Coins). Supports virtual economy pricing analysis and IAP (In-App Purchase) conversion tracking.',
    `premium_tier_count` STRING COMMENT 'Number of tiers exclusively accessible on the premium (paid) track. Represents the incremental value proposition of the premium pass purchase.',
    `reward_schedule_ref` STRING COMMENT 'Reference identifier or document path pointing to the reward schedule definition for this battle pass (e.g., a Jira Epic key, Perforce asset path, or content management system ID). Links to the detailed tier-by-tier reward manifest.',
    `season_label` STRING COMMENT 'Branded or thematic label for the season associated with this pass (e.g., Season of the Void, Chapter 4 Season 2). Used in marketing and player-facing UI.',
    `season_number` STRING COMMENT 'Ordinal number of the game season associated with this pass (e.g., Season 7). Used for chronological ordering and player-facing season labeling.',
    `soft_launch_date` DATE COMMENT 'Date on which the battle pass was made available in a limited set of markets or platforms prior to full global launch. Used for staged rollout tracking and pre-launch performance analysis.',
    `start_date` DATE COMMENT 'Calendar date on which the battle pass becomes active and purchasable by players. Aligns with the season launch date in the live-ops calendar.',
    `tier_count` STRING COMMENT 'Total number of progression tiers available in this battle pass. Applicable to progression_tiered and hybrid pass types. Null for pure content_access passes.',
    `tier_skip_price_usd` DECIMAL(18,2) COMMENT 'Price in USD to purchase a single tier skip within this battle pass. Used for MTX (Microtransaction) revenue modeling and P2W analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this battle pass product definition record was last modified. Supports change tracking, audit compliance, and Silver layer incremental processing.',
    `upgrade_path_code` STRING COMMENT 'Code identifying the upgrade path available for this pass (e.g., free-to-premium, premium-to-premium-plus). Defines the upsell funnel structure for conversion rate analysis.',
    `version` STRING COMMENT 'Version number of this battle pass product definition record, supporting change management and audit trail for pass configuration updates (e.g., price changes, tier adjustments).. Valid values are `^d+.d+(.d+)?$`',
    `virtual_currency_code` STRING COMMENT 'Code identifying the in-game virtual currency used for the virtual currency price (e.g., VBUCKS, COINS, GEMS). Required for multi-currency virtual economy management.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `xp_per_tier` STRING COMMENT 'Amount of XP (Experience Points) required to advance one tier in the battle pass progression system. Governs the grind curve and player engagement pacing.',
    `created_by` STRING COMMENT 'Username or system identifier of the person or process that created this battle pass product definition. Supports audit trail and accountability for monetization product configuration.',
    CONSTRAINT pk_battle_pass PRIMARY KEY(`battle_pass_id`)
) COMMENT 'Master definition of pass-based monetization products per game title and season, encompassing both progression-tiered battle passes and content-access season passes. Captures pass name, pass type (progression_tiered, content_access, hybrid), season identifier, start/end dates, tier count (if applicable), free vs. premium track structure, premium price, XP-per-tier thresholds, reward schedule reference, content entitlements included, max purchasable tier skips, upgrade paths, platform availability, and active status. The SSOT for all pass product definitions — distinct from individual player entitlements.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` (
    `battle_pass_entitlement_id` BIGINT COMMENT 'Unique surrogate identifier for a players battle pass entitlement record. Primary key for this transactional entity.',
    `ab_experiment_id` BIGINT COMMENT 'Foreign key linking to analytics.ab_experiment. Business justification: Battle pass pricing, tier structure, XP requirements, and reward schedules are commonly A/B tested. Linking entitlements to experiments enables conversion rate analysis and revenue impact measurement ',
    `battle_pass_id` BIGINT COMMENT 'Reference to the battle pass product definition (season, name, tier structure, reward catalog) that this entitlement is for.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Battle pass entitlements tracked by cost center for revenue attribution. Management accounting for seasonal content revenue tracking.',
    `deferred_revenue_id` BIGINT COMMENT 'Foreign key linking to finance.deferred_revenue. Business justification: Battle pass purchases create contract liabilities recognized over season duration. Direct ASC 606 requirement for performance obligation tracking and revenue recognition.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title under which this battle pass is operated. Supports multi-title monetization reporting.',
    `iap_transaction_id` BIGINT COMMENT 'The platform-issued transaction identifier from the app store or console SDK for the premium battle pass purchase (e.g., Apple App Store receipt ID, Google Play order ID, PSN transaction ID). Used for receipt validation and refund processing.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Premium battle pass purchases generate invoices for revenue recognition and tax reporting. Gaming companies must link entitlements to invoices for financial compliance and refund processing workflows.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Player entitlements to licensed battle pass content require agreement reference for territory restrictions validation, platform rights verification, and automated compliance checks against license ter',
    `league_id` BIGINT COMMENT 'Foreign key linking to esports.league. Business justification: Battle passes themed around esports leagues (e.g., Championship Series Pass). Common monetization model linking premium content to competitive seasons. Tracks league-specific battle pass sales and e',
    `player_account_id` BIGINT COMMENT 'Reference to the player who owns this battle pass entitlement. Core party reference linking entitlement to the player account.',
    `storefront_id` BIGINT COMMENT 'Reference to the platform (console, PC, mobile) on which the battle pass was purchased and is being progressed.',
    `acquisition_channel` STRING COMMENT 'The marketing or distribution channel through which the player acquired this battle pass entitlement. Supports CPI, ROAS, and conversion funnel analytics. [ENUM-REF-CANDIDATE: organic|paid_ua|influencer|bundle|gifted|promotional_code|loyalty_reward — promote to reference product]',
    `age_gate_verified` BOOLEAN COMMENT 'Indicates whether the player passed the required age verification check prior to purchasing this battle pass. Required for COPPA compliance for players in applicable jurisdictions.',
    `auto_renew_enabled` BOOLEAN COMMENT 'Indicates whether the player has opted into automatic renewal of the battle pass subscription at the start of the next season. Supports subscription retention and churn rate analytics.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the players registered region at the time of entitlement creation. Used for regional revenue reporting, tax compliance, and GDPR/COPPA jurisdiction determination.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this entitlement record was first created in the system, which may precede the purchase timestamp for free-track entitlements granted at season start.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the real-money amounts recorded on this entitlement (e.g., USD, EUR, GBP). Supports multi-currency monetization reporting.. Valid values are `^[A-Z]{3}$`',
    `current_tier` STRING COMMENT 'The highest tier the player has currently unlocked on the battle pass, spanning both free and premium tracks. Used for reward grant eligibility checks at runtime.',
    `current_xp` STRING COMMENT 'The players current accumulated experience points (XP) within this battle pass season. XP determines tier progression and is the primary progression currency.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the battle pass purchase (e.g., promotional discount, loyalty reward, bundle discount). Zero if no discount was applied.',
    `entitlement_reference_code` STRING COMMENT 'Externally-visible alphanumeric code uniquely identifying this entitlement record. Used in player support, receipts, and entitlement enforcement lookups.. Valid values are `^BP-[A-Z0-9]{6,20}$`',
    `entitlement_status` STRING COMMENT 'Current lifecycle state of the battle pass entitlement. Controls whether the player can access premium rewards and progress tiers. [ENUM-REF-CANDIDATE: active|expired|suspended|refunded|pending|cancelled — promote to reference product]. Valid values are `active|expired|suspended|refunded|pending|cancelled`',
    `expiry_date` DATE COMMENT 'The date on which this battle pass entitlement expires and the player can no longer earn or claim rewards. Typically aligned to the end of the game season.',
    `free_tier_unlocked` STRING COMMENT 'The highest tier unlocked on the free reward track. Tracked separately from premium tier to support free-vs-paid conversion analytics and reward grant logic.',
    `is_completed` BOOLEAN COMMENT 'Indicates whether the player has reached the maximum tier and fully completed the battle pass. Used for completion reward grants and engagement analytics.',
    `is_gifted` BOOLEAN COMMENT 'Indicates whether this battle pass entitlement was received as a gift from another player rather than self-purchased. Supports gifting revenue segmentation.',
    `is_premium_active` BOOLEAN COMMENT 'Indicates whether the player has activated the premium battle pass track. True means the player paid for premium access; False means free track only. Core entitlement enforcement flag.',
    `last_progression_timestamp` TIMESTAMP COMMENT 'The most recent timestamp at which the player earned XP or advanced a tier on this battle pass. Used for engagement monitoring, lapsed-player identification, and re-engagement campaign targeting.',
    `max_tier` STRING COMMENT 'The total number of tiers available in this battle pass. Used to calculate completion percentage and determine if the player has fully completed the pass.',
    `net_purchase_amount` DECIMAL(18,2) COMMENT 'The net real-money amount charged to the player after discounts (purchase_price_amount minus discount_amount). Used for revenue recognition and ARPU/ARPPU reporting.',
    `parental_consent_obtained` BOOLEAN COMMENT 'Indicates whether verifiable parental consent was obtained before granting this battle pass entitlement to a minor player. Mandatory for COPPA-regulated accounts.',
    `player_level_at_purchase` STRING COMMENT 'The players account level at the time of battle pass premium track purchase. Used for conversion funnel segmentation and LTV modeling by player maturity cohort.',
    `premium_tier_unlocked` STRING COMMENT 'The highest tier unlocked on the premium reward track. Null or zero if the player has not activated the premium track. Drives premium reward grant eligibility.',
    `promotional_code` STRING COMMENT 'The promotional or discount code applied at the time of battle pass purchase, if any. Used for campaign attribution and promotional effectiveness analysis.',
    `purchase_price_amount` DECIMAL(18,2) COMMENT 'The gross real-money price paid by the player to activate the premium battle pass track, in the currency indicated by currency_code. Null for free-track-only entitlements.',
    `purchase_timestamp` TIMESTAMP COMMENT 'The exact date and time when the player purchased or activated the premium battle pass track. Null for free-track-only entitlements. Principal business event timestamp for this transaction.',
    `refund_status` STRING COMMENT 'Current refund state for this battle pass entitlement purchase. Tracks whether a refund has been requested, processed, or denied. Supports financial reconciliation and player support workflows.. Valid values are `not_refunded|refund_requested|refunded|refund_denied`',
    `refund_timestamp` TIMESTAMP COMMENT 'The date and time when a refund was processed for this battle pass entitlement. Null if no refund has been issued. Used for financial reconciliation and chargeback tracking.',
    `rewards_claimed_count` STRING COMMENT 'The total number of individual tier rewards the player has claimed from this battle pass entitlement. Used to measure reward engagement and identify players who earn but do not claim.',
    `season_number` STRING COMMENT 'The sequential season number associated with this battle pass entitlement. Enables cross-season analytics and cohort comparisons.',
    `tier_skip_spend_amount` DECIMAL(18,2) COMMENT 'Total real-money or virtual currency equivalent amount spent on tier skips for this entitlement. Contributes to ARPPU and LTV calculations for the monetization domain.',
    `tier_skips_purchased` STRING COMMENT 'The total number of tier skip purchases made by the player on this battle pass entitlement. Each skip advances the player one tier without earning XP. Key microtransaction (MTX) revenue signal.',
    `track_type` STRING COMMENT 'Indicates which reward track(s) the player has access to: free (default), premium (paid upgrade), or premium_plus (deluxe tier with bonus rewards). Drives reward grant eligibility at runtime.. Valid values are `free|premium|premium_plus`',
    `unclaimed_rewards_count` STRING COMMENT 'The number of rewards the player has unlocked but not yet claimed from this battle pass. High unclaimed counts may indicate engagement drop-off and trigger re-engagement nudges.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this entitlement record, including tier progression, XP updates, tier skips, or status changes.',
    `virtual_currency_cost` STRING COMMENT 'The amount of in-game virtual currency (e.g., V-Bucks, Coins, Gems) spent to purchase the premium battle pass track, if applicable. Null for real-money-only purchases.',
    `xp_to_next_tier` STRING COMMENT 'The remaining XP required for the player to advance to the next battle pass tier. Supports real-time progression display and engagement nudge triggers.',
    CONSTRAINT pk_battle_pass_entitlement PRIMARY KEY(`battle_pass_entitlement_id`)
) COMMENT 'Transactional record of a players ownership and progression state for a specific battle pass. Tracks player reference, battle pass reference, purchase timestamp, tier unlocked (free and premium), current XP, premium track activated flag, tier skip purchases, expiry date, and completion status. Enables entitlement enforcement and reward grant eligibility checks at runtime.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`gacha_pull` (
    `gacha_pull_id` BIGINT COMMENT 'Unique identifier for the gacha pull transaction. Primary key for this event log entity.',
    `ab_experiment_id` BIGINT COMMENT 'Foreign key linking to analytics.ab_experiment. Business justification: Gacha mechanics (drop rates, pity thresholds, pricing, multi-pull discounts) are heavily A/B tested in F2P games. Experiment attribution is critical for measuring revenue impact and player satisfactio',
    `build_id` BIGINT COMMENT 'Foreign key linking to studio.build. Business justification: Gacha pulls occur within specific builds. Tracking build version is essential for regulatory compliance (disclosed drop rates must match build version), exploit detection (abnormal pull outcomes in sp',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Gacha pulls tracked by cost center for revenue attribution. Revenue tracking for gacha monetization by game/feature.',
    `gacha_pool_id` BIGINT COMMENT 'Identifier of the specific gacha pool or banner from which the pull was executed. Links to the gacha pool configuration entity.',
    `game_title_id` BIGINT COMMENT 'Identifier of the game title in which this gacha pull occurred. Links to the game title master entity.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Gacha pulls are revenue events that must post to GL. Some jurisdictions require specific gacha revenue tracking for regulatory compliance and disclosure.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Gacha pulls must track jurisdiction for loot box disclosure compliance, drop-rate transparency requirements, and age-gate enforcement. Critical for regulatory filings in jurisdictions with loot box re',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Individual gacha pulls yielding licensed items require IP attribution for per-transaction royalty calculation, regulatory reporting in jurisdictions requiring loot box disclosure, and revenue attribut',
    `marketing_campaign_id` BIGINT COMMENT 'Identifier of the promotional campaign or limited-time event associated with this gacha pull, if applicable. Null for standard pulls.',
    `mtx_catalog_id` BIGINT COMMENT 'Identifier of the primary item granted as the outcome of this gacha pull. Links to the in-game item catalog.',
    `player_account_id` BIGINT COMMENT 'Identifier of the player who executed this gacha pull. Links to the player master entity.',
    `session_id` BIGINT COMMENT 'Identifier of the player session during which this gacha pull occurred. Used for session-level analytics and fraud detection.',
    `storefront_id` BIGINT COMMENT 'Identifier of the platform on which this gacha pull was executed (iOS, Android, PC, Console). Links to the platform master entity.',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: Gacha events timed with tournaments (limited-time tournament-themed pools). Real business pattern for promotional gacha during esports events. Tracks tournament-driven gacha revenue and player engagem',
    `iap_transaction_id` BIGINT COMMENT 'Unique transaction identifier generated by the game server for this gacha pull. Used for reconciliation, auditing, and player support investigations.',
    `ab_test_variant` STRING COMMENT 'Identifier of the A/B test variant or experiment group the player was assigned to at the time of this gacha pull. Used for conversion rate optimization and feature testing.',
    `age_gate_verified_flag` BOOLEAN COMMENT 'Indicates whether the player passed age verification requirements for gacha participation in their jurisdiction. True if verified, false otherwise.',
    `bonus_items_granted_flag` BOOLEAN COMMENT 'Indicates whether additional bonus items were granted alongside the primary outcome (e.g., first-time bonuses, promotional extras). True if bonuses granted.',
    `client_version` STRING COMMENT 'Version number of the game client software used to execute this gacha pull. Used for version-specific analytics and bug tracking.',
    `conversion_currency_amount` DECIMAL(18,2) COMMENT 'Amount of conversion currency (e.g., duplicate shards, exchange tokens) granted if the outcome was a duplicate. Null if not a duplicate.',
    `currency_amount` DECIMAL(18,2) COMMENT 'Amount of virtual currency spent on this gacha pull. Denominated in the currency_type specified.',
    `currency_type` STRING COMMENT 'Type of virtual currency used for this gacha pull: premium (paid), soft (earned), free (promotional), or event-specific currency.. Valid values are `premium|soft|free|event`',
    `days_since_install` STRING COMMENT 'Number of days elapsed between the players initial game install and this gacha pull. Used for cohort analysis and LTV modeling.',
    `device_type` STRING COMMENT 'Type of device used to execute the gacha pull: mobile phone, tablet, PC, or console. Used for device-specific analytics.. Valid values are `mobile|tablet|pc|console`',
    `disclosed_drop_rate_pct` DECIMAL(18,2) COMMENT 'The publicly disclosed drop rate percentage for the rarity tier of the outcome item at the time of pull. Required for regulatory compliance in multiple jurisdictions.',
    `duplicate_flag` BOOLEAN COMMENT 'Indicates whether the outcome item was a duplicate of an item the player already owned. True if duplicate, false if new acquisition.',
    `fraud_risk_score` DECIMAL(18,2) COMMENT 'Automated fraud detection score assigned to this gacha pull transaction at the time of execution. Higher scores indicate higher fraud risk. Range 0.00 to 100.00.',
    `lifetime_gacha_spend_usd` DECIMAL(18,2) COMMENT 'Cumulative real-money equivalent amount the player has spent on gacha pulls across all time, up to and including this transaction. Used for whale segmentation and LTV analysis.',
    `outcome_item_quantity` STRING COMMENT 'Quantity of the primary outcome item granted to the player. Typically 1 for character/weapon pulls, may be higher for consumables.',
    `outcome_rarity_tier` STRING COMMENT 'Rarity classification of the primary item granted: common, uncommon, rare, epic, legendary, or mythic. Determines drop rate and player value perception.. Valid values are `common|uncommon|rare|epic|legendary|mythic`',
    `pity_counter_after` STRING COMMENT 'Value of the players pity counter immediately after this pull was executed. Reset to zero if pity was triggered.',
    `pity_counter_before` STRING COMMENT 'Value of the players pity counter immediately before this pull was executed. Tracks cumulative pulls without a guaranteed drop.',
    `pity_triggered_flag` BOOLEAN COMMENT 'Indicates whether the pity mechanism was triggered for this pull, guaranteeing a high-rarity item. True if pity activated, false otherwise.',
    `player_level_at_pull` STRING COMMENT 'The players in-game level at the time this gacha pull was executed. Used for progression-based analytics and monetization funnel analysis.',
    `pull_quantity` STRING COMMENT 'Number of items pulled in this single transaction. Typically 1 for single pulls, 10 for multi-pulls.',
    `pull_timestamp` TIMESTAMP COMMENT 'The exact date and time when the gacha pull was executed by the player. Primary business event timestamp for this transaction.',
    `pull_type` STRING COMMENT 'Type of gacha pull executed: single pull, multi-pull (10x), free pull, premium pull, or discounted pull. Affects cost and pity mechanics.. Valid values are `single|multi|free|premium|discounted`',
    `real_money_equivalent_usd` DECIMAL(18,2) COMMENT 'Equivalent real-world monetary value of the currency spent, converted to USD. Used for revenue recognition and ARPU calculations.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gacha pull record was first written to the data platform. Used for data lineage and audit trail purposes.',
    `refund_flag` BOOLEAN COMMENT 'Indicates whether the currency spent on this gacha pull was subsequently refunded to the player. True if refunded, false otherwise.',
    `refund_timestamp` TIMESTAMP COMMENT 'Date and time when the refund was processed for this gacha pull, if applicable. Null if no refund occurred.',
    `regulatory_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the regulatory jurisdiction of the player at the time of pull. Used for loot box disclosure compliance (Belgium, Netherlands, Japan, China).',
    `server_region` STRING COMMENT 'Geographic region of the game server that processed this gacha pull (e.g., NA-EAST, EU-WEST, ASIA-PACIFIC). Used for latency analysis and regional performance tracking.',
    CONSTRAINT pk_gacha_pull PRIMARY KEY(`gacha_pull_id`)
) COMMENT 'Transactional record of every loot box or gacha pull event executed by a player. Captures game title, gacha pool reference, pull timestamp, currency type and amount spent, pity counter at time of pull, outcome item(s) granted, rarity tier of outcome, guaranteed drop flag (pity triggered), and regulatory jurisdiction. Supports loot box disclosure compliance (Belgium, Netherlands, ESRB loot box labeling) and gacha economy balancing.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`gacha_pool` (
    `gacha_pool_id` BIGINT COMMENT 'Unique identifier for the gacha pool configuration. Primary key.',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: New gacha pools deploy with content updates for version compatibility. Links pool to release for client version validation, asset availability checks, and rollback coordination.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Gacha pools developed by specific cost centers for cost tracking. Development cost attribution for content creation and maintenance.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Gacha pools are designed content requiring dev resources. Linking to dev_project supports content pipeline tracking, A/B test attribution, regulatory compliance documentation (drop rate disclosure per',
    `employee_id` BIGINT COMMENT 'Reference to the internal user who approved this gacha pool configuration for production deployment.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Gacha pool design and content creation consume development budget. Content budget tracking for art, design, and implementation costs.',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Gacha events are time-limited live-ops campaigns (e.g., limited-time banners tied to content updates). Linking enables event-to-revenue attribution, live-ops planning coordination, and analysis of gac',
    `game_studio_id` BIGINT COMMENT 'Foreign key linking to studio.game_studio. Business justification: Gacha pools are designed by specific studios. Tracking studio ownership supports regulatory compliance (studio-level drop rate disclosures in some jurisdictions), revenue attribution for studio P&L, a',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this gacha pool belongs to.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Gacha pools containing licensed characters (Genshin Impact collaborations) must track IP for drop rate disclosure compliance, royalty attribution per pull, and licensor approval of probability mechani',
    `mtx_catalog_id` BIGINT COMMENT 'Reference to the specific item guaranteed at hard pity threshold, if applicable.',
    `royalty_accrual_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_accrual. Business justification: Gacha pools with licensed characters generate royalty obligations. Licensed content accounting for IP collaboration gacha events.',
    `title_season_id` BIGINT COMMENT 'Foreign key linking to title.title_season. Business justification: Gacha pools are seasonal limited-time banners (e.g., Summer Festival Pool). Business tracks which season each pool belongs to for lifecycle management, revenue attribution by season, and content plann',
    `age_gate_required` BOOLEAN COMMENT 'Indicates whether age verification is required before accessing this gacha pool due to regional regulations.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this gacha pool configuration was approved for production deployment.',
    `banner_image_url` STRING COMMENT 'CDN (Content Delivery Network) URL to the promotional banner image for this gacha pool.',
    `base_drop_rate_r` DECIMAL(18,2) COMMENT 'Base probability of obtaining an R (common rarity) item per pull, expressed as decimal (e.g., 0.9430 = 94.3%).',
    `base_drop_rate_sr` DECIMAL(18,2) COMMENT 'Base probability of obtaining an SR (high rarity) item per pull, expressed as decimal (e.g., 0.0510 = 5.1%).',
    `base_drop_rate_ssr` DECIMAL(18,2) COMMENT 'Base probability of obtaining an SSR (highest rarity) item per pull, expressed as decimal (e.g., 0.0060 = 0.6%).',
    `collaboration_partner` STRING COMMENT 'Name of external IP (Intellectual Property) or brand partner if this is a collaboration gacha pool.',
    `cost_per_multi_pull` DECIMAL(18,2) COMMENT 'Amount of currency required for a multi-pull (typically 10-pull) from this pool, often discounted.',
    `cost_per_single_pull` DECIMAL(18,2) COMMENT 'Amount of currency required for a single gacha pull from this pool.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this gacha pool configuration record was first created in the system.',
    `currency_type` STRING COMMENT 'Type of virtual currency required to perform a pull from this gacha pool.. Valid values are `premium|soft|hard|event|special`',
    `duplicate_conversion_enabled` BOOLEAN COMMENT 'Indicates whether duplicate items from this pool are automatically converted to alternative currency or resources.',
    `duplicate_conversion_rate` DECIMAL(18,2) COMMENT 'Amount of alternative currency or resource awarded per duplicate item, if conversion is enabled.',
    `featured_item_boost_rate` DECIMAL(18,2) COMMENT 'Probability multiplier applied to featured items in this pool (e.g., 0.5000 represents 50% rate-up).',
    `hard_pity_threshold` STRING COMMENT 'Maximum number of pulls after which a guaranteed high-rarity item is awarded.',
    `max_pulls_per_player` STRING COMMENT 'Maximum number of pulls a single player can perform on this pool during its active window. Nullable for unlimited.',
    `minimum_player_level` STRING COMMENT 'Minimum player level required to access this gacha pool. Nullable if no restriction.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this gacha pool configuration record was last modified.',
    `multi_pull_quantity` STRING COMMENT 'Number of items granted in a single multi-pull transaction (typically 10).',
    `notes` STRING COMMENT 'Internal operational notes or comments about this gacha pool configuration for product and operations teams.',
    `pity_counter_shared` BOOLEAN COMMENT 'Indicates whether the pity counter for this pool is shared with other pools or independent.',
    `platform_availability` STRING COMMENT 'Gaming platforms where this gacha pool is available.. Valid values are `ios|android|pc|console|web|all`',
    `pool_active_end_timestamp` TIMESTAMP COMMENT 'Date and time when this gacha pool is no longer available to players. Nullable for permanent pools.',
    `pool_active_start_timestamp` TIMESTAMP COMMENT 'Date and time when this gacha pool becomes available to players.',
    `pool_code` STRING COMMENT 'Unique business identifier or SKU (Stock Keeping Unit) for the gacha pool used in game systems and external reporting.',
    `pool_description` STRING COMMENT 'Detailed description of the gacha pool, including thematic elements and featured items for player communication.',
    `pool_display_order` STRING COMMENT 'Sort order for displaying this gacha pool in the game UI, lower numbers appear first.',
    `pool_name` STRING COMMENT 'Human-readable name of the gacha pool (e.g., Summer Event Banner, Standard Wish).',
    `pool_status` STRING COMMENT 'Current lifecycle state of the gacha pool configuration.. Valid values are `draft|active|paused|expired|archived`',
    `pool_theme` STRING COMMENT 'Thematic classification of the gacha pool (e.g., Fantasy, Sci-Fi, Holiday, Collaboration).',
    `pool_type` STRING COMMENT 'Classification of the gacha pool indicating its business purpose and availability pattern.. Valid values are `standard|event|limited|seasonal|promotional|featured`',
    `pool_version` STRING COMMENT 'Version number of this gacha pool configuration, incremented when drop rates or items are modified.',
    `region_availability` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this gacha pool is available (e.g., USA,JPN,KOR). [ENUM-REF-CANDIDATE: promote to reference product if more than 6 regions]',
    `regulatory_disclosure_text` STRING COMMENT 'Full legal disclosure text displayed to players regarding drop rates and probabilities, required by regional regulations.',
    `soft_pity_threshold` STRING COMMENT 'Number of pulls after which drop rates for high-rarity items begin to increase incrementally.',
    `total_pulls_lifetime` BIGINT COMMENT 'Cumulative count of all pulls performed on this gacha pool since inception, for analytics and reporting.',
    `total_revenue_lifetime` DECIMAL(18,2) COMMENT 'Cumulative revenue generated by this gacha pool since inception, in base currency (USD).',
    CONSTRAINT pk_gacha_pool PRIMARY KEY(`gacha_pool_id`)
) COMMENT 'Master definition of each gacha or loot box pool configuration per game title. Defines pool name, associated game title, pool type (standard, event, limited), item drop table with probability weights, pity system parameters (soft pity threshold, hard pity threshold, guaranteed item), cost per pull (currency type and amount), pool active window, and regulatory disclosure text. The SSOT for gacha pool configurations.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`offer_campaign` (
    `offer_campaign_id` BIGINT COMMENT 'Unique identifier for the monetization offer campaign. Primary key.',
    `ab_experiment_id` BIGINT COMMENT 'Reference to the parent A/B test experiment this campaign variant belongs to. Null if not part of an A/B test.',
    `ad_creative_id` BIGINT COMMENT 'Foreign key linking to marketing.ad_creative. Business justification: Offer campaigns display visual creative assets in-game and on storefronts. Linking to ad_creative enables A/B testing of offer visuals, creative performance analysis, and unified asset management acro',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Promotional campaigns timed to content releases for launch marketing. Links campaign to release schedule for coordinated go-live, player acquisition, and new content monetization.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Offer campaigns are cost center activities for expense tracking. Marketing cost management for promotional campaign spending.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Promotional campaigns often tie to content releases or live-ops cycles managed by dev teams. Linking enables campaign-to-content attribution, cross-functional planning between marketing and dev, and a',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to title.dlc_bundle. Business justification: Offer campaigns promote DLC bundles (e.g., Season Pass launch campaign). Business needs to track featured bundles for storefront merchandising, campaign ROI measurement, and marketing attribution. Cri',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Offer campaigns have budget allocations tracked against actuals. Campaign ROI analysis and financial planning requirement.',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Promotional campaigns frequently align with live-ops events (season launches, content drops, tournaments). Linking supports cross-functional event planning, campaign-to-content attribution, and analys',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this offer campaign is associated with.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Offer campaigns promoting licensed content must track IP for marketing approval requirements, brand usage guideline compliance, and revenue attribution when campaigns drive sales of licensed items sub',
    `localization_string_id` BIGINT COMMENT 'Foreign key linking to content.localization_string. Business justification: Campaign messaging requires localization for regional targeting and compliance. Links offer to translated marketing copy for multi-region deployment and A/B testing.',
    `parent_campaign_offer_campaign_id` BIGINT COMMENT 'Reference to the parent campaign if this is a recurring instance or variant. Null if this is a standalone campaign.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Promotional campaigns must comply with specific policies governing advertising to minors, discount disclosure requirements, and gambling-like mechanics restrictions. Required for campaign approval wor',
    `employee_id` BIGINT COMMENT 'Reference to the internal user or system account that created this campaign record.',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Promotional campaigns synchronized with seasonal events for marketing synergy. Links offer timing to event schedule for coordinated launch, player targeting, and revenue optimization.',
    `storefront_id` BIGINT COMMENT 'Reference to the platform (console, PC, mobile) where this campaign is active.',
    `tertiary_offer_approved_by_user_employee_id` BIGINT COMMENT 'Reference to the internal user who approved this campaign for launch. Null if not yet approved.',
    `title_sku_id` BIGINT COMMENT 'Foreign key linking to title.sku. Business justification: Offer campaigns target specific SKUs for promotional pricing (e.g., weekend sale on Deluxe Edition). Business needs this to determine storefront eligibility, apply discounts at checkout, and measure c',
    `tournament_id` BIGINT COMMENT 'Foreign key linking to esports.tournament. Business justification: In-game offers often tie to esports tournaments (e.g., Championship Bundle, Team Skins for playoffs). This links monetization campaigns to the competitive calendar, enabling revenue analysis for tourn',
    `ab_test_variant` STRING COMMENT 'A/B test variant identifier for this campaign (e.g., A, B, control). Null if not part of an A/B test.. Valid values are `^[A-Z]$|control`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this campaign was approved for launch. Null if not yet approved.',
    `campaign_budget` DECIMAL(18,2) COMMENT 'Allocated budget for this campaign including discounts, bonuses, and promotional costs. Null if no budget cap.',
    `campaign_code` STRING COMMENT 'Unique business identifier code for the campaign used in tracking and reporting systems.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `campaign_end_timestamp` TIMESTAMP COMMENT 'Date and time when the offer campaign expires and is no longer available to players.',
    `campaign_name` STRING COMMENT 'Human-readable name of the offer campaign (e.g., Black Friday Flash Sale, Whale Retention Offer Q4).',
    `campaign_notes` STRING COMMENT 'Free-text notes or comments about the campaign for internal reference and collaboration.',
    `campaign_start_timestamp` TIMESTAMP COMMENT 'Date and time when the offer campaign becomes active and visible to players.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the offer campaign.. Valid values are `draft|scheduled|active|paused|completed|cancelled`',
    `compliance_notes` STRING COMMENT 'Internal notes from legal or compliance review regarding regulatory considerations or restrictions for this campaign.',
    `compliance_review_status` STRING COMMENT 'Status of regulatory and legal compliance review for this campaign (e.g., COPPA, gambling regulations, consumer protection).. Valid values are `pending|approved|rejected|not_required`',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Calculated conversion rate (redemptions / impressions) for this campaign. Expressed as a decimal (e.g., 0.0523 = 5.23%).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this campaign record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for monetary values in this campaign (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `discount_type` STRING COMMENT 'Type of discount or bonus structure offered in the campaign.. Valid values are `percentage|fixed_amount|bonus_currency|bundle`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount or bonus. Interpretation depends on discount_type (e.g., 25.00 for 25% off or $25 fixed discount).',
    `display_image_url` STRING COMMENT 'URL to the promotional image or banner asset used to display this offer in-game.. Valid values are `^https?://.*`',
    `eligible_sku_list` STRING COMMENT 'Comma-separated list of SKU identifiers eligible for this offer campaign. Empty if all SKUs are eligible.',
    `geo_restriction_list` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this offer is available. Empty indicates global availability.',
    `impression_cap` STRING COMMENT 'Maximum number of times this offer can be displayed to eligible players. Null indicates no cap.',
    `is_recurring` BOOLEAN COMMENT 'Flag indicating whether this campaign is part of a recurring series (e.g., weekly flash sales). True = recurring; False = one-time.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this campaign record was last modified.',
    `offer_type` STRING COMMENT 'Classification of the offer campaign type based on its monetization strategy and target behavior.. Valid values are `flash_sale|first_purchase_bonus|returning_player|whale_retention|seasonal_event|limited_time`',
    `priority_rank` STRING COMMENT 'Priority ranking for display when multiple campaigns are eligible for the same player. Lower numbers indicate higher priority.',
    `redemption_cap` STRING COMMENT 'Maximum number of times this offer can be redeemed across all players. Null indicates no cap.',
    `redemption_cap_per_player` STRING COMMENT 'Maximum number of times a single player can redeem this offer. Null indicates no per-player limit.',
    `target_dau_min` STRING COMMENT 'Minimum DAU threshold for player eligibility. Players with DAU below this value are excluded. Null indicates no minimum.',
    `target_days_since_last_purchase` STRING COMMENT 'Number of days since players last purchase to qualify for this offer (used for lapsed player targeting). Null indicates no recency requirement.',
    `target_ltv_min` DECIMAL(18,2) COMMENT 'Minimum player lifetime value threshold for campaign eligibility. Null indicates no minimum LTV requirement.',
    `target_player_segment` STRING COMMENT 'Player spending tier or behavioral segment targeted by this campaign. F2P (Free-to-Play) = non-payers; Minnow = low spenders; Dolphin = moderate spenders; Whale = high spenders.. Valid values are `f2p|minnow|dolphin|whale|lapsed|new_user`',
    `total_impressions` BIGINT COMMENT 'Cumulative count of how many times this offer has been displayed to players since campaign start.',
    `total_redemptions` BIGINT COMMENT 'Cumulative count of how many times this offer has been redeemed by players since campaign start.',
    `total_revenue_generated` DECIMAL(18,2) COMMENT 'Cumulative revenue generated from all redemptions of this offer campaign in the campaigns currency.',
    CONSTRAINT pk_offer_campaign PRIMARY KEY(`offer_campaign_id`)
) COMMENT 'Master record of time-limited monetization offer campaigns (flash sales, first-purchase bonuses, returning player offers, whale retention offers). Captures campaign name, offer type, targeted player segment (F2P, minnow, dolphin, whale), eligible SKUs, discount or bonus structure, campaign start/end timestamps, impression cap, redemption cap, A/B test variant, and conversion rate tracking reference. Distinct from marketing campaigns — these are in-game revenue-driving offers.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`ip_agreement` (
    `ip_agreement_id` BIGINT COMMENT 'Unique identifier for the intellectual property licensing agreement. Primary key.',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: IP agreements govern which titles can use licensed IP (middleware engines, music, brands). Essential for legal compliance, royalty calculation, and release approval workflows in gaming.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Agreements specify territorial scope; linking to jurisdiction enables automated compliance rule lookup (GDPR applicability, loot box regulations, age verification). Real process: legal review workflow',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: IP agreements should link to the licensed_ip catalog to identify which specific IP asset is being licensed. Currently uses licensed_ip_asset_reference (STRING) which should be normalized to a FK. This',
    `legal_entity_id` BIGINT COMMENT 'External business identifier for the licensor organization, such as DUNS number or tax identifier.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: License agreements must track applicable regulatory obligations (age ratings, loot box disclosure, GDPR compliance). Real process: compliance teams map obligations to agreements for audit readiness an',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Fleet-level licensing agreements for game engines and middleware (e.g., Unreal Engine fleet license) define deployment scope, enable fleet-wide compliance monitoring, and support aggregated royalty re',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the licensing agreement, typically formatted with prefix and sequential number.. Valid values are `^[A-Z]{2,4}-[0-9]{4,8}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the licensing agreement indicating its operational state and enforceability. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|terminated|expired|under_renewal — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the licensing agreement by commercial structure: outbound engine (Unity/Unreal SDK licensing), inbound brand/franchise (licensed IP usage), middleware (physics, audio, anti-cheat, analytics SDKs), music synchronization, art asset licensing, or brand partnership. [ENUM-REF-CANDIDATE: outbound_engine|inbound_brand|inbound_franchise|middleware|music_sync|art_asset|brand_partnership — 7 candidates stripped; promote to reference product]',
    `assigned_account_manager` STRING COMMENT 'Name or identifier of the internal account manager or business development representative responsible for managing this licensing relationship.',
    `brand_owner_name` STRING COMMENT 'Name of the brand owner or franchise rights holder for brand partnership agreements. Nullable for non-brand-partnership agreements.',
    `brand_partnership_type` STRING COMMENT 'Type of brand partnership: co-marketing (joint promotional campaigns), co-development (collaborative game development), character licensing (use of brand characters), franchise adaptation (game based on existing IP), or cross-promotion. Nullable for non-brand-partnership agreements.. Valid values are `co_marketing|co_development|character_licensing|franchise_adaptation|cross_promotion`',
    `brand_usage_guidelines_url` STRING COMMENT 'URL or document reference to brand usage guidelines, style guides, and trademark usage requirements for brand partnership agreements. Nullable for non-brand-partnership agreements.',
    `co_marketing_obligations` STRING COMMENT 'Description of co-marketing obligations, including minimum spend commitments, promotional activities, and joint campaign requirements for brand partnership agreements. Nullable for non-brand-partnership agreements.',
    `compliance_rating_board_requirements` STRING COMMENT 'Specific rating board compliance requirements imposed by the agreement, including ESRB, PEGI, USK, CERO, or GRAC rating restrictions or content guidelines.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this agreement record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the licensing agreement becomes legally binding and enforceable.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the license grants exclusive rights to the licensee within the defined territory and scope. True if exclusive, False if non-exclusive.',
    `exclusivity_scope` STRING COMMENT 'Detailed description of the exclusivity terms, including any limitations by platform, genre, or use case (e.g., exclusive for mobile RPG games in North America).',
    `expiry_date` DATE COMMENT 'Date when the licensing agreement terminates or expires. Nullable for perpetual or open-ended agreements.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of the agreement (e.g., State of California, USA or England and Wales).',
    `ip_ownership_terms` STRING COMMENT 'Description of intellectual property ownership terms, including whether derivative works, modifications, or improvements belong to licensor, licensee, or are jointly owned.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this agreement record was last updated or modified.',
    `licensee_name` STRING COMMENT 'Legal name of the party receiving the intellectual property license (the entity authorized to use the IP).',
    `licensor_name` STRING COMMENT 'Legal name of the party granting the intellectual property license (the IP owner or rights holder).',
    `middleware_license_type` STRING COMMENT 'Type of middleware license granted: per-title (licensed per game), per-seat (per developer), revenue-share, enterprise (organization-wide), or perpetual. Nullable for non-middleware agreements.. Valid values are `per_title|per_seat|revenue_share|enterprise|perpetual`',
    `middleware_product_name` STRING COMMENT 'Name of the specific middleware product or SDK covered by the agreement (e.g., Havok Physics Engine, Wwise Audio Middleware). Nullable for non-middleware agreements.',
    `middleware_product_version` STRING COMMENT 'Version or release number of the middleware product licensed. Nullable for non-middleware agreements or version-agnostic licenses.',
    `middleware_usage_scope` STRING COMMENT 'Description of permitted usage scope for middleware, including platform restrictions, title limits, or development team size constraints. Nullable for non-middleware agreements.',
    `middleware_vendor_name` STRING COMMENT 'Name of the middleware vendor for middleware-type agreements. Nullable for non-middleware agreements.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount that the licensee must pay regardless of actual usage or revenue, typically in advance or over the agreement term. Nullable if no minimum guarantee applies.',
    `music_composer_name` STRING COMMENT 'Name of the composer or songwriter for music synchronization licenses. Nullable for non-music agreements.',
    `music_media_usage_rights` STRING COMMENT 'Description of permitted media usage rights for music synchronization, including platforms (console, PC, mobile, streaming), territories, and duration. Nullable for non-music agreements.',
    `music_pro_clearance_status` STRING COMMENT 'Status of clearance from performing rights organizations (ASCAP, BMI, SESAC, PRS, etc.) for music synchronization licenses. Nullable for non-music agreements.. Valid values are `not_required|pending|cleared|rejected`',
    `music_publisher_name` STRING COMMENT 'Name of the music publisher holding rights for music synchronization licenses. Nullable for non-music agreements.',
    `music_track_title` STRING COMMENT 'Title of the music track or composition for music synchronization licenses. Nullable for non-music agreements.',
    `payment_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all financial terms in this agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `payment_frequency` STRING COMMENT 'Frequency at which royalty or license fee payments are due from the licensee.. Valid values are `monthly|quarterly|semi_annually|annually|upon_milestone|one_time`',
    `renewal_negotiation_status` STRING COMMENT 'Current status of renewal negotiations for agreements approaching expiry.. Valid values are `not_applicable|not_started|in_progress|completed|declined`',
    `renewal_notice_deadline_days` STRING COMMENT 'Number of days before expiry_date by which renewal notice must be provided to trigger automatic renewal or initiate renewal negotiations.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied to revenue or sales for revenue-share or per-unit royalty calculations. Nullable if not applicable to the royalty structure.',
    `royalty_structure_type` STRING COMMENT 'Classification of the royalty or payment structure: fixed fee (flat payment), revenue share (percentage of revenue), per-unit (per copy sold), per-seat (per developer license), tiered (rate changes by volume), or hybrid (combination).. Valid values are `fixed_fee|revenue_share|per_unit|per_seat|tiered|hybrid`',
    `termination_clause_summary` STRING COMMENT 'Summary of termination conditions and notice requirements, including breach conditions, convenience termination rights, and wind-down obligations.',
    `territory_scope` STRING COMMENT 'Geographic territories or regions where the license is valid, specified as comma-separated ISO 3166-1 alpha-3 country codes or regional descriptors (e.g., USA,CAN,MEX or worldwide).',
    CONSTRAINT pk_ip_agreement PRIMARY KEY(`ip_agreement_id`)
) COMMENT 'Master record for all intellectual property licensing agreements, covering outbound engine/technology licensing, inbound licensed IP usage, third-party middleware agreements (physics engines, audio middleware, anti-cheat SDKs, analytics), music synchronization licenses, and brand/franchise partnership deals. Captures agreement type (outbound engine, inbound brand/franchise, music sync, middleware, art, brand partnership), licensor and licensee identities, territory scope, exclusivity terms, effective and expiry dates, governing law jurisdiction, agreement status, licensed IP asset reference, renewal tracking (expiry date, renewal notice deadline, renewal negotiation status, assigned account manager), and agreement-type-specific metadata including: for middleware — vendor, product version, license type (per-title, per-seat, revenue-share), usage scope; for music sync — track title, composer/publisher, PRO clearance status, media usage rights; for brand partnerships — brand owner, partnership type, co-marketing obligations, brand usage guidelines. This is the single source of truth for ALL licensing contracts in the gaming domain regardless of IP type or commercial structure.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`licensee` (
    `licensee_id` BIGINT COMMENT 'Unique identifier for the licensee entity. Primary key for the licensee master data product.',
    `annual_revenue_range` STRING COMMENT 'The estimated annual revenue range of the licensee organization in USD. Used for partner segmentation and deal sizing. Ranges: under $1M, $1M-$10M, $10M-$50M, $50M-$100M, $100M-$500M, over $500M.. Valid values are `under_1m|1m_to_10m|10m_to_50m|50m_to_100m|100m_to_500m|over_500m`',
    `compliance_tier` STRING COMMENT 'The compliance risk tier assigned to the licensee based on their jurisdiction, business practices, and regulatory history. Tier 1 (high risk, enhanced due diligence), Tier 2 (medium risk, standard due diligence), Tier 3 (low risk, simplified due diligence), Tier 4 (trusted partner, minimal oversight).. Valid values are `tier_1_high_risk|tier_2_medium_risk|tier_3_low_risk|tier_4_trusted`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this licensee record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'The maximum credit exposure allowed for this licensee across all active licensing agreements, expressed in USD. Used for financial risk management.',
    `credit_rating` STRING COMMENT 'The credit rating assigned to the licensee by a recognized credit rating agency (e.g., Moodys, S&P, Fitch). Used for financial risk assessment and payment term determination.',
    `doing_business_as_name` STRING COMMENT 'The trade name or DBA name under which the licensee operates, if different from their legal entity name. Used for brand recognition and marketing purposes.',
    `duns_number` STRING COMMENT 'The 9-digit DUNS number assigned by Dun & Bradstreet for unique business entity identification. Used for credit checks and business verification.. Valid values are `^[0-9]{9}$`',
    `employee_count_range` STRING COMMENT 'The estimated number of employees at the licensee organization. Used for partner segmentation and capacity assessment. Ranges: 1-10, 11-50, 51-200, 201-500, 501-1000, over 1000.. Valid values are `1_to_10|11_to_50|51_to_200|201_to_500|501_to_1000|over_1000`',
    `entity_type` STRING COMMENT 'Classification of the licensee based on their primary business function in the gaming ecosystem. Indie studio (small independent developer), AAA publisher (major game publisher), platform operator (console/store operator), middleware vendor (engine/tool provider), music publisher (audio IP owner), or brand owner (franchise IP holder).. Valid values are `indie_studio|aaa_publisher|platform_operator|middleware_vendor|music_publisher|brand_owner`',
    `first_contract_date` DATE COMMENT 'The date when the first licensing agreement with this licensee was executed. Used for relationship tenure analysis and anniversary tracking.',
    `headquarters_address_line1` STRING COMMENT 'The first line of the licensees headquarters street address, including building number and street name.',
    `headquarters_address_line2` STRING COMMENT 'The second line of the licensees headquarters address, typically used for suite, floor, or building information.',
    `headquarters_city` STRING COMMENT 'The city where the licensees headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 country code for the licensees headquarters location (e.g., USA, GBR, JPN).. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'The postal or ZIP code for the licensees headquarters address.',
    `headquarters_state_province` STRING COMMENT 'The state, province, or administrative region where the licensees headquarters is located.',
    `is_publicly_traded` BOOLEAN COMMENT 'Indicates whether the licensee is a publicly traded company (True) or privately held (False). Used for financial risk assessment and reporting requirements.',
    `jurisdiction_of_incorporation` STRING COMMENT 'The country or jurisdiction where the licensee entity is legally incorporated, using ISO 3166-1 alpha-3 country codes (e.g., USA, GBR, JPN).. Valid values are `^[A-Z]{3}$`',
    `kyc_completion_date` DATE COMMENT 'The date when the Know Your Customer due diligence process was completed and the licensee was approved for business. Required for compliance and audit purposes.',
    `kyc_review_due_date` DATE COMMENT 'The date when the next periodic KYC review is due for this licensee. Typically annual or biennial depending on compliance tier.',
    `last_contract_renewal_date` DATE COMMENT 'The date when the most recent contract renewal or amendment was executed with this licensee. Used for renewal cycle tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this licensee record was last updated. Used for audit trail, change tracking, and data freshness monitoring.',
    `legal_entity_name` STRING COMMENT 'The full legal name of the licensee organization as registered in their jurisdiction of incorporation. This is the official name used in all licensing contracts and legal documents.',
    `licensee_code` STRING COMMENT 'Unique alphanumeric business identifier assigned to the licensee for use in contracts, invoicing, and operational systems. Typically 4-12 characters.. Valid values are `^[A-Z0-9]{4,12}$`',
    `notes` STRING COMMENT 'Free-form text field for capturing additional notes, special considerations, or context about the licensee that doesnt fit in structured fields. Used for relationship management and institutional knowledge.',
    `nps_score` STRING COMMENT 'The Net Promoter Score for this licensee based on relationship satisfaction surveys. Score ranges from -100 to +100, with higher scores indicating stronger partnership satisfaction.',
    `onboarding_status` STRING COMMENT 'The current status of the licensee in the onboarding and lifecycle management process. Prospect (initial contact), KYC in progress (Know Your Customer due diligence underway), approved (cleared for contracting), active (has active agreements), suspended (temporarily inactive), terminated (relationship ended).. Valid values are `prospect|kyc_in_progress|approved|active|suspended|terminated`',
    `preferred_currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for the licensees preferred transaction currency (e.g., USD, EUR, JPY). Used for invoicing and payment processing.. Valid values are `^[A-Z]{3}$`',
    `preferred_payment_terms_days` STRING COMMENT 'The standard payment terms in days negotiated with this licensee for royalty payments or license fees (e.g., Net 30, Net 60). Used for accounts payable and receivable management.',
    `primary_contact_email` STRING COMMENT 'The primary email address for the licensee contact. This is the main channel for licensing communications, contract negotiations, and operational correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact at the licensee organization responsible for licensing relationship management.',
    `primary_contact_phone` STRING COMMENT 'The primary phone number for the licensee contact, including country code. Used for urgent communications and contract discussions.',
    `primary_platform_focus` STRING COMMENT 'The primary gaming platform(s) that the licensee focuses on (e.g., PC, Console, Mobile, VR, Cross-Platform). Free-text field to accommodate multiple platforms and emerging technologies. [ENUM-REF-CANDIDATE: pc|console|mobile|vr|ar|xr|web|cross_platform — promote to reference product]',
    `relationship_direction` STRING COMMENT 'Indicates the direction of the licensing relationship. Licensee (they license FROM Gaming), licensor (they license TO Gaming), or bilateral (both directions active).. Valid values are `licensee|licensor|bilateral`',
    `relationship_manager_name` STRING COMMENT 'The name of the Gaming employee who serves as the primary relationship manager for this licensee. Responsible for contract negotiations, renewals, and ongoing relationship management.',
    `specialization_area` STRING COMMENT 'The primary area of specialization or expertise for the licensee (e.g., Game Engine Technology, Audio Middleware, Physics Engine, Animation Tools, Multiplayer Infrastructure, Analytics SDK, Monetization Platform, IP Licensing, Music Licensing). Free-text to accommodate diverse specializations.',
    `stock_ticker_symbol` STRING COMMENT 'The stock ticker symbol for the licensee if they are publicly traded. Includes exchange prefix if applicable (e.g., NASDAQ:ATVI, NYSE:EA).',
    `tax_identification_number` STRING COMMENT 'The tax identification number or equivalent (EIN, VAT number, etc.) for the licensee in their jurisdiction of incorporation. Used for tax reporting and compliance.',
    `website_url` STRING COMMENT 'The primary website URL for the licensee organization. Used for research, verification, and business intelligence.',
    CONSTRAINT pk_licensee PRIMARY KEY(`licensee_id`)
) COMMENT 'Master entity representing external parties who hold licenses from Gaming or grant licenses to Gaming — studios, publishers, developers, platform operators, music publishers, middleware vendors, and brand owners involved in any licensing relationship. Captures legal entity name, entity type (indie studio, AAA publisher, platform operator, middleware vendor, music publisher, brand owner), jurisdiction of incorporation, primary contact, credit rating, compliance tier, onboarding status, and relationship direction (licensee, licensor, or both). This is the SSOT for all external licensing counterparties regardless of deal direction.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`licensed_ip` (
    `licensed_ip_id` BIGINT COMMENT 'Unique identifier for the licensed intellectual property asset. Primary key for the licensed IP catalog.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Licensed IP (game engines, middleware, branded content) carries age ratings constraining licensee usage. Real process: licensees verify rating compatibility before integration; licensor tracks certifi',
    `franchise_id` BIGINT COMMENT 'Foreign key linking to title.franchise. Business justification: Franchises often license third-party IP (Marvel, Star Wars, sports leagues). Tracks which franchises depend on external IP rights for portfolio planning and renewal negotiations.',
    `active_license_count` STRING COMMENT 'Current number of active licensing agreements in force for this IP asset. Used for portfolio management and capacity planning.',
    `asset_thumbnail_url` STRING COMMENT 'URL path to the thumbnail image or visual representation of the IP asset stored in the Content Delivery Network (CDN) or digital asset management system.',
    `cero_rating` STRING COMMENT 'CERO content rating classification for Japan (A=All Ages, B=12+, C=15+, D=17+, Z=18+, or Not Rated).. Valid values are `CERO_A|CERO_B|CERO_C|CERO_D|CERO_Z|Not_Rated`',
    `content_descriptors` STRING COMMENT 'Comma-separated list of content warning descriptors from rating boards (e.g., Violence, Language, In-Game Purchases, Online Interactions). Used for compliance and parental guidance.',
    `coppa_compliant` BOOLEAN COMMENT 'Indicates whether this IP asset and its associated content meet COPPA compliance requirements for childrens privacy protection (applicable for content targeting users under 13).',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this IP asset record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IP asset record was first created in the licensing catalog system.',
    `documentation_url` STRING COMMENT 'URL path to the official licensing documentation, SDK documentation, or technical specifications for this IP asset.',
    `drm_protection_enabled` BOOLEAN COMMENT 'Indicates whether this IP asset includes or requires DRM (Digital Rights Management) protection mechanisms for distribution and licensing enforcement.',
    `esrb_rating` STRING COMMENT 'ESRB content rating classification for North America (Early Childhood, Everyone, Everyone 10+, Teen, Mature, Adults Only, Rating Pending, or Not Rated).. Valid values are `EC|E|E10+|T|M|AO|RP|Not_Rated`',
    `expiration_date` DATE COMMENT 'Date when the IP registration or protection expires. Null for perpetual rights or unregistered IP.',
    `gdpr_compliant` BOOLEAN COMMENT 'Indicates whether this IP asset and its licensing terms comply with GDPR data protection requirements for EU markets.',
    `grac_rating` STRING COMMENT 'GRAC content rating classification for South Korea (All, 12, 15, 18, or Not Rated).. Valid values are `All|12|15|18|Not_Rated`',
    `ip_category` STRING COMMENT 'High-level category grouping for the IP asset (technology-based, creative content, brand/franchise, or hybrid).. Valid values are `technology|creative_content|brand|hybrid`',
    `ip_code` STRING COMMENT 'Internal business identifier or SKU (Stock Keeping Unit) code for the IP asset used in licensing agreements and royalty tracking.',
    `ip_description` STRING COMMENT 'Detailed business description of the intellectual property asset, including its purpose, key features, and licensing value proposition.',
    `ip_name` STRING COMMENT 'The official name or title of the intellectual property asset (e.g., Unreal Engine 5, Fortnite Brand, Epic Soundtrack Collection).',
    `ip_type` STRING COMMENT 'Classification of the IP asset type. Determines licensing model and royalty structure. [ENUM-REF-CANDIDATE: game_engine|franchise_brand|game_title|character|music_composition|art_asset_library|middleware_library|rating_approved_content_package — 8 candidates stripped; promote to reference product]',
    `last_licensed_date` DATE COMMENT 'Date when the most recent licensing agreement for this IP asset was executed. Null if never licensed.',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this IP asset record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this IP asset record was last updated in the licensing catalog system.',
    `license_model` STRING COMMENT 'Primary licensing business model applied to this IP asset (royalty percentage, fixed fee, subscription, revenue share, hybrid, or not applicable for internal-only IP).. Valid values are `royalty_based|fixed_fee|subscription|revenue_share|hybrid|not_applicable`',
    `licensing_availability_status` STRING COMMENT 'Current availability status of the IP asset for new licensing agreements. Indicates whether the IP can be licensed out and under what terms.. Valid values are `available|licensed_exclusive|licensed_non_exclusive|restricted|retired|pending_approval`',
    `marketing_tagline` STRING COMMENT 'Official marketing tagline or slogan associated with the IP asset, used in licensing promotional materials and partner communications.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Standard minimum guarantee amount (in USD) required from licensees for this IP asset. Null if no minimum guarantee applies.',
    `monetization_restrictions` STRING COMMENT 'Description of any restrictions on how licensees can monetize products built with this IP (e.g., No Pay-to-Win mechanics allowed, In-App Purchases (IAP) permitted, Ad-supported only). Null if no restrictions.',
    `ownership_entity` STRING COMMENT 'The legal entity or studio that owns the intellectual property rights (e.g., Epic Games Inc., Subsidiary Studio LLC).',
    `ownership_type` STRING COMMENT 'Nature of ownership rights held by the business (wholly owned, joint ownership with partner, licensed from third party, or acquired through M&A).. Valid values are `wholly_owned|joint_ownership|licensed_in|acquired`',
    `pegi_rating` STRING COMMENT 'PEGI content rating classification for Europe (3, 7, 12, 16, 18, or Not Rated).. Valid values are `PEGI_3|PEGI_7|PEGI_12|PEGI_16|PEGI_18|Not_Rated`',
    `platform_compatibility` STRING COMMENT 'Comma-separated list of gaming platforms or operating systems this IP asset supports or is compatible with (e.g., PC, PlayStation, Xbox, Nintendo Switch, iOS, Android). Applicable primarily to game engines and middleware.',
    `registration_date` DATE COMMENT 'Date when the intellectual property was officially registered with the governing authority.',
    `registration_jurisdiction` STRING COMMENT 'The legal jurisdiction or territory where the IP is registered (e.g., USA, EUR, JPN, Global). Uses 3-letter country codes or regional identifiers.',
    `registration_number` STRING COMMENT 'Official registration or patent number assigned by governing IP authority (USPTO, EPO, WIPO, copyright office). May include trademark, patent, or copyright registration identifiers.',
    `sdk_version` STRING COMMENT 'Current version number of the SDK or game engine technology if this IP is a licensable technology platform (e.g., UE5.3, Unity 2023.1). Null for non-technology IP.',
    `standard_royalty_rate` DECIMAL(18,2) COMMENT 'Default royalty rate (as decimal, e.g., 0.0500 for 5%) applied to licensees for this IP asset. Actual rates may vary by agreement. Null if not royalty-based.',
    `territory_restrictions` STRING COMMENT 'Geographic territories where licensing of this IP is restricted or prohibited due to legal, regulatory, or contractual constraints. Comma-separated list of 3-letter country codes or None if unrestricted.',
    `third_party_dependencies` STRING COMMENT 'Comma-separated list of third-party middleware, libraries, or licensed components embedded within this IP asset that licensees must also comply with (e.g., Havok Physics, Wwise Audio, SpeedTree).',
    `total_revenue_to_date` DECIMAL(18,2) COMMENT 'Cumulative licensing revenue (in USD) generated from this IP asset since inception. Includes royalties, fixed fees, and minimum guarantees.',
    `ugc_enabled` BOOLEAN COMMENT 'Indicates whether this IP asset supports or allows user-generated content creation and distribution by licensees or end users.',
    `usk_rating` STRING COMMENT 'USK content rating classification for Germany (0, 6, 12, 16, 18, or Not Rated).. Valid values are `USK_0|USK_6|USK_12|USK_16|USK_18|Not_Rated`',
    CONSTRAINT pk_licensed_ip PRIMARY KEY(`licensed_ip_id`)
) COMMENT 'Catalog of all intellectual property assets that are subject to licensing — game engine SDKs (Unity/Unreal-equivalent), franchise brands, game titles, characters, music compositions, art asset libraries, middleware libraries, and rating-board-approved content packages. Captures IP asset name, IP type (engine, brand, music, art, middleware, franchise), ownership entity, registration numbers, territory restrictions, content rating classifications (ESRB, PEGI, USK, CERO, GRAC), and current licensing availability status.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`commercial_term` (
    `commercial_term_id` BIGINT COMMENT 'Primary key for commercial_term',
    `ip_agreement_id` BIGINT COMMENT 'Reference to the parent IP licensing agreement to which these commercial terms apply.',
    `advance_payment_amount` DECIMAL(18,2) COMMENT 'Upfront payment made by licensee, typically recoupable against future royalties.',
    `advance_recoupment_terms` STRING COMMENT 'Detailed terms describing how advance payments are recouped from future royalty payments (e.g., 100% recoupment, cross-collateralization rules).',
    `audit_frequency_limit` STRING COMMENT 'Maximum frequency at which licensor may conduct audits (e.g., once per calendar year, twice per contract term).',
    `audit_rights_clause` STRING COMMENT 'Text describing licensors rights to audit licensees books and records to verify royalty calculations and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this commercial term record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this term set (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `derivative_works_rights` STRING COMMENT 'Specifies licensees rights to create derivative works based on the licensed IP (e.g., sequels, spin-offs, adaptations).. Valid values are `full_rights|limited_rights|no_rights|approval_required`',
    `exclusivity_window_months` STRING COMMENT 'Duration in months for which platform or territory exclusivity applies before rights expand.',
    `indemnification_terms` STRING COMMENT 'Detailed indemnification obligations of each party, including scope of liability, defense obligations, and limitations.',
    `late_payment_penalty_rate` DECIMAL(18,2) COMMENT 'Percentage penalty rate applied to overdue payments, typically expressed as annual percentage rate (APR).',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum liability amount either party may be held responsible for under the agreement, excluding certain carve-outs.',
    `marketing_approval_required_flag` BOOLEAN COMMENT 'Indicates whether licensee must obtain licensor approval for marketing materials, promotional campaigns, and brand usage.',
    `marketing_spend_commitment_amount` DECIMAL(18,2) COMMENT 'Minimum marketing spend amount licensee commits to invest in promoting the licensed IP or product.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount that licensee must pay regardless of actual royalty calculations. Common in IP licensing deals.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this commercial term record was last modified.',
    `payment_due_days` STRING COMMENT 'Number of days after period end or invoice date by which payment must be received.',
    `payment_frequency` STRING COMMENT 'Cadence at which royalty or license fee payments are due (e.g., quarterly, annually).. Valid values are `monthly|quarterly|semi_annually|annually|milestone_based`',
    `performance_milestone_terms` STRING COMMENT 'Detailed terms describing performance milestones that trigger payments, bonuses, or rights adjustments (e.g., sales thresholds, user acquisition targets).',
    `platform_exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this agreement grants exclusive rights to specific gaming platforms (console, PC, mobile).',
    `platform_exclusivity_list` STRING COMMENT 'Comma-separated list of platforms covered by exclusivity (e.g., PlayStation, Xbox, Nintendo Switch, PC, iOS, Android).',
    `quality_assurance_requirements` STRING COMMENT 'Quality standards and certification requirements licensee must meet, including ESRB, PEGI, or platform Technical Requirements Checklist (TRC) compliance.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration by which licensee must provide notice to exercise renewal option.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether licensee has the option to renew the agreement under predefined terms.',
    `renewal_option_periods` STRING COMMENT 'Number of renewal periods available to licensee (e.g., two 2-year renewal options).',
    `revenue_reporting_due_days` STRING COMMENT 'Number of days after period end by which revenue reports must be submitted to licensor.',
    `revenue_reporting_frequency` STRING COMMENT 'Cadence at which licensee must provide revenue and usage reports to licensor for royalty calculation.. Valid values are `monthly|quarterly|semi_annually|annually`',
    `royalty_basis` STRING COMMENT 'The financial or usage metric upon which royalty calculations are based (e.g., net revenue, gross revenue, units sold).. Valid values are `net_revenue|gross_revenue|units_sold|active_users|downloads`',
    `royalty_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage rate applied to revenue or units to calculate royalty payments owed to licensor. Expressed as percentage (e.g., 5.00 for 5%).',
    `sublicensing_permitted_flag` BOOLEAN COMMENT 'Indicates whether licensee is permitted to sublicense the IP or technology to third parties.',
    `sublicensing_terms` STRING COMMENT 'Detailed terms governing sublicensing arrangements, including revenue sharing, approval requirements, and restrictions.',
    `term_effective_date` DATE COMMENT 'Date when this version of commercial terms becomes binding and enforceable.',
    `term_expiration_date` DATE COMMENT 'Date when this version of commercial terms ceases to be effective. Nullable for open-ended terms.',
    `term_status` STRING COMMENT 'Current lifecycle status of this commercial term version.. Valid values are `draft|active|superseded|terminated|expired|suspended`',
    `term_version_number` STRING COMMENT 'Sequential version number for this term set. Agreements may have multiple versioned term sets reflecting amendments over time.',
    `termination_cure_period_days` STRING COMMENT 'Number of days the breaching party has to cure a breach before termination becomes effective.',
    `termination_for_cause_conditions` STRING COMMENT 'Detailed conditions under which either party may terminate the agreement for cause (e.g., material breach, bankruptcy, failure to meet minimum guarantees).',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for termination, either for cause or for convenience.',
    `territory_expansion_option_flag` BOOLEAN COMMENT 'Indicates whether licensee has the option to expand into additional territories under predefined terms.',
    `territory_expansion_terms` STRING COMMENT 'Detailed terms governing territory expansion options, including pricing, approval process, and timing.',
    `territory_list` STRING COMMENT 'Comma-separated list of countries or regions where license rights apply, using ISO 3166-1 alpha-3 country codes.',
    CONSTRAINT pk_commercial_term PRIMARY KEY(`commercial_term_id`)
) COMMENT 'Detailed commercial and legal terms attached to each IP agreement, including royalty rate structures, minimum guarantee amounts, advance payment schedules, audit rights clauses, sublicensing permissions, derivative works rights, platform exclusivity windows, territory expansion options, renewal options, and termination-for-cause conditions. One agreement may have multiple versioned term sets reflecting amendments over time.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`royalty_schedule` (
    `royalty_schedule_id` BIGINT COMMENT 'Unique identifier for the royalty schedule record. Primary key.',
    `ip_agreement_id` BIGINT COMMENT 'Reference to the parent licensing agreement or contract that this royalty schedule governs.',
    `superseded_by_schedule_royalty_schedule_id` BIGINT COMMENT 'Reference to the royalty_schedule_id that supersedes this schedule when a new version is activated. Null if this is the current active schedule.',
    `audit_frequency_months` STRING COMMENT 'The frequency in months at which audits are required (e.g., 12 for annual, 24 for biennial). Null if audit_required_flag is False.',
    `audit_required_flag` BOOLEAN COMMENT 'Indicates whether this royalty schedule requires periodic third-party audit of reported figures (True/False).',
    `base_rate_percentage` DECIMAL(18,2) COMMENT 'The baseline royalty rate expressed as a percentage (e.g., 5.0000 for 5%). Applicable when royalty_basis is revenue-based.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this royalty schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which royalty amounts are denominated (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this royalty schedule ceases to be active. Null for open-ended schedules.',
    `effective_start_date` DATE COMMENT 'The date from which this royalty schedule becomes active and applicable to the agreement.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this royalty schedule is tied to an exclusive licensing arrangement (True) or non-exclusive (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this royalty schedule record was last updated.',
    `late_payment_penalty_rate` DECIMAL(18,2) COMMENT 'The penalty rate (as a percentage per period) applied to overdue royalty payments. Null if no penalty applies.',
    `maximum_cap_amount` DECIMAL(18,2) COMMENT 'The maximum royalty payment cap per reporting period. Null if no cap applies.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum royalty payment guaranteed per reporting period, regardless of actual usage or revenue. Null if no minimum guarantee applies.',
    `notes` STRING COMMENT 'Free-text field for additional business context, special terms, exceptions, or clarifications related to this royalty schedule.',
    `payment_due_days` STRING COMMENT 'Number of days after the end of the reporting period by which royalty payment is due (e.g., 30 days, 60 days).',
    `platform_deduction_rule` STRING COMMENT 'Specifies whether platform fees (e.g., Apple App Store 30%, Steam 30%, console first-party fees) are deducted before or after calculating royalties.. Valid values are `before_platform_fees|after_platform_fees|net_of_all_fees|gross_no_deductions`',
    `platform_scope` STRING COMMENT 'The gaming platforms or distribution channels to which this royalty schedule applies (e.g., Console, PC, Mobile, All Platforms, Steam, Epic Games Store, PlayStation, Xbox, Nintendo Switch).',
    `product_scope` STRING COMMENT 'The specific game titles, SKUs (Stock Keeping Units), or product lines covered by this royalty schedule. May reference specific game IPs (Intellectual Property) or engine versions.',
    `rate_structure` STRING COMMENT 'Describes how the royalty rate is applied: flat (single rate), tiered (different rates at different breakpoints), progressive (rate increases with volume), regressive (rate decreases with volume), or custom formula.. Valid values are `flat_rate|tiered|progressive|regressive|custom`',
    `recoupment_allowed_flag` BOOLEAN COMMENT 'Indicates whether advance payments or minimum guarantees can be recouped against future royalty earnings (True/False).',
    `reporting_period_cadence` STRING COMMENT 'The frequency at which royalty calculations and payments are reported and settled (e.g., monthly, quarterly, annually).. Valid values are `monthly|quarterly|semi_annually|annually|on_demand`',
    `revenue_recognition_method` STRING COMMENT 'The accounting method used to recognize royalty revenue or expense (accrual, cash basis, milestone-based, or usage-based).. Valid values are `accrual|cash|milestone|usage_based`',
    `royalty_basis` STRING COMMENT 'The fundamental metric or basis upon which royalty amounts are calculated (e.g., net revenue after platform fees, gross revenue, units sold, Daily Active Users (DAU), Monthly Active Users (MAU), or fixed periodic fee). [ENUM-REF-CANDIDATE: net_revenue|gross_revenue|units_sold|dau_based|mau_based|fixed_fee|hybrid — 7 candidates stripped; promote to reference product]',
    `royalty_schedule_status` STRING COMMENT 'Current lifecycle status of the royalty schedule.. Valid values are `draft|active|suspended|expired|terminated|superseded`',
    `schedule_name` STRING COMMENT 'Business-friendly name or label for this royalty schedule (e.g., Unity Pro Tier 1, Unreal Engine Standard, IP License Q1 2024).',
    `schedule_type` STRING COMMENT 'Classification of the royalty schedule based on the nature of the licensing arrangement. [ENUM-REF-CANDIDATE: outbound_engine_licensing|inbound_ip_licensing|middleware_licensing|music_licensing|art_asset_licensing|franchise_partnership|technology_sdk — 7 candidates stripped; promote to reference product]',
    `territory_scope` STRING COMMENT 'Geographic territories or regions to which this royalty schedule applies (e.g., Worldwide, North America, EMEA, APAC, or specific country codes).',
    `tier_1_rate_percentage` DECIMAL(18,2) COMMENT 'The royalty rate percentage applicable to revenue or units within the first tier. Null if not applicable.',
    `tier_1_threshold` DECIMAL(18,2) COMMENT 'The upper boundary value for the first royalty rate tier. Null if rate structure is flat or only one tier exists.',
    `tier_2_rate_percentage` DECIMAL(18,2) COMMENT 'The royalty rate percentage applicable to revenue or units within the second tier. Null if not applicable.',
    `tier_2_threshold` DECIMAL(18,2) COMMENT 'The upper boundary value for the second royalty rate tier. Null if fewer than two tiers exist.',
    `tier_3_rate_percentage` DECIMAL(18,2) COMMENT 'The royalty rate percentage applicable to revenue or units within the third tier. Null if not applicable.',
    `tier_3_threshold` DECIMAL(18,2) COMMENT 'The upper boundary value for the third royalty rate tier. Null if fewer than three tiers exist.',
    `version_number` STRING COMMENT 'Version number of this royalty schedule, incremented with each amendment or revision to the terms.',
    `withholding_tax_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage of royalty payment subject to withholding tax, if applicable under the jurisdiction of the licensee or licensor. Null if no withholding applies.',
    CONSTRAINT pk_royalty_schedule PRIMARY KEY(`royalty_schedule_id`)
) COMMENT 'Defines the royalty calculation rules and rate tiers for each IP agreement — including royalty basis (net revenue, gross revenue, units sold, DAU-based, MAU-based), tiered rate breakpoints, currency, reporting period cadence (monthly, quarterly), applicable platform deductions, and effective date ranges. Supports both outbound engine licensing royalties collected from licensees and inbound royalties owed to IP rights holders.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`royalty_report` (
    `royalty_report_id` BIGINT COMMENT 'Unique identifier for the royalty report record. Primary key.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Royalty reports for licensed IP usage (middleware, music, brands) are calculated per-project for revenue attribution and payment reconciliation. Essential for financial reporting and budget variance a',
    `employee_id` BIGINT COMMENT 'Reference to the internal user or team responsible for reviewing and validating this royalty report.',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: Royalty reports track revenue per title for licensed IP (engine royalties, music sync fees). Essential for accurate royalty calculation and licensor reporting.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice generated from this royalty report. Links the report to the billing and accounts receivable process.',
    `ip_agreement_id` BIGINT COMMENT 'Reference to the licensing agreement under which this royalty report is submitted. Links to the master license agreement entity.',
    `kpi_definition_id` BIGINT COMMENT 'Foreign key linking to analytics.kpi_definition. Business justification: Royalty metrics (royalty per user, IP conversion rate, royalty yield) are tracked as business KPIs. Links licensing financial reporting to analytics KPI framework for executive dashboards and performa',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Royalty reports should track which specific licensed IP asset generated the revenue. Currently uses product_line (STRING) which is ambiguous. Adding licensed_ip_id FK enables precise IP-level revenue ',
    `licensee_id` BIGINT COMMENT 'Reference to the party (studio, publisher, or third-party developer) submitting or subject to this royalty report.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Royalty reports may trigger regulatory filings (revenue disclosures, tax withholding reports, cross-border payment notifications). Real process: finance-to-compliance handoff for jurisdictions requiri',
    `applicable_royalty_rate` DECIMAL(18,2) COMMENT 'The royalty rate percentage applied to the net revenue for this reporting period. May vary based on tiered thresholds, product type, or territory as defined in the license agreement.',
    `attachment_url` STRING COMMENT 'URL or file path to supporting documentation attached to this royalty report (e.g., detailed sales breakdowns, platform reports, reconciliation files).',
    `audit_flag` BOOLEAN COMMENT 'Indicates whether this royalty report has been flagged for audit or detailed review due to discrepancies, thresholds, or compliance requirements.',
    `calculated_royalty_amount` DECIMAL(18,2) COMMENT 'The royalty amount due to the licensor, calculated by applying the applicable royalty rate to the reported net revenue. This is the amount subject to invoicing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty report record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this report (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `dispute_reason` STRING COMMENT 'Explanation or categorization of any dispute raised regarding this royalty report. Populated when report status is disputed or under review.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert foreign currency revenue to the reporting currency, if applicable. Used for multi-currency licensing agreements.',
    `minimum_guarantee_credit` DECIMAL(18,2) COMMENT 'Amount of minimum guarantee advance recouped or credited against this royalty payment. Tracks progress toward recoupment of upfront payments.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this royalty report record was last modified. Tracks updates, amendments, or status changes.',
    `net_royalty_payable` DECIMAL(18,2) COMMENT 'The net royalty amount payable after applying minimum guarantee credits and any other adjustments. This is the actual payment due to the licensor.',
    `notes` STRING COMMENT 'Free-text field for additional comments, clarifications, or context provided by the licensee or internal reviewers regarding this royalty report.',
    `payment_due_date` DATE COMMENT 'The date by which the calculated royalty payment is due to the licensor, as specified in the license agreement terms.',
    `platform` STRING COMMENT 'Gaming platform or distribution channel for which revenue is being reported (e.g., PlayStation, Xbox, Steam, mobile app stores, PC).',
    `report_number` STRING COMMENT 'Business identifier for the royalty report, typically assigned by the licensee or licensing system. Used for external reference and audit trails.',
    `report_status` STRING COMMENT 'Current lifecycle status of the royalty report. Tracks progression from submission through review, acceptance, or dispute resolution.. Valid values are `submitted|under_review|accepted|disputed|rejected|amended`',
    `report_type` STRING COMMENT 'Classification of the royalty report based on reporting frequency or purpose (e.g., quarterly, monthly, annual, ad-hoc, final settlement).. Valid values are `quarterly|monthly|annual|ad_hoc|final`',
    `reported_deductions` DECIMAL(18,2) COMMENT 'Total deductions applied to gross revenue as permitted by the license agreement (e.g., platform fees, returns, refunds, taxes). Reduces the royalty base.',
    `reported_gross_revenue` DECIMAL(18,2) COMMENT 'Total gross revenue reported by the licensee for the reporting period, before any deductions or adjustments. Basis for royalty calculation.',
    `reported_net_revenue` DECIMAL(18,2) COMMENT 'Net revenue after deductions, representing the royalty-bearing revenue base. Calculated as gross revenue minus deductions.',
    `reported_unit_sales` BIGINT COMMENT 'Total number of units sold or distributed during the reporting period, as reported by the licensee. May include game copies, DLC, or licensed content units.',
    `reporting_period_end_date` DATE COMMENT 'The last date of the period covered by this royalty report. Defines the end of the revenue or usage window being reported.',
    `reporting_period_start_date` DATE COMMENT 'The first date of the period covered by this royalty report. Defines the beginning of the revenue or usage window being reported.',
    `review_completed_date` DATE COMMENT 'The date on which the internal review of this royalty report was completed and a status decision (accepted, disputed, rejected) was made.',
    `submission_date` DATE COMMENT 'The date on which the licensee submitted this royalty report to the licensor. Used to track timeliness and compliance with reporting deadlines.',
    `submission_method` STRING COMMENT 'The channel or mechanism through which the royalty report was submitted (e.g., licensing portal, email, API integration, manual upload, FTP/SFTP).. Valid values are `portal|email|api|manual|ftp|sftp`',
    `territory_code` STRING COMMENT 'Geographic territory or region covered by this royalty report. May be a country code, regional grouping, or worldwide indicator as defined in the license agreement.',
    CONSTRAINT pk_royalty_report PRIMARY KEY(`royalty_report_id`)
) COMMENT 'Periodic royalty reporting records submitted by licensees or generated internally for outbound agreements. Captures reporting period, reported gross and net revenue, reported unit sales, applicable royalty rate tier applied, calculated royalty amount due, currency, submission date, submission method, and report status (submitted, under review, accepted, disputed). Feeds into royalty invoice generation and audit workflows.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`royalty_payment` (
    `royalty_payment_id` BIGINT COMMENT 'Unique identifier for the royalty payment record. Primary key for the royalty payment entity.',
    `iap_transaction_id` BIGINT COMMENT 'Foreign key linking to monetization.iap_transaction. Business justification: Royalty payments for revenue-based licenses require direct linkage to source IAP transactions for audit trail, dispute resolution, and reconciliation between reported revenue in royalty_report and act',
    `ip_agreement_id` BIGINT COMMENT 'Reference to the governing IP licensing agreement under which this royalty payment is made. Links to the master licensing contract that defines royalty terms, rates, and obligations.',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Royalty payment payees are licensees (either receiving royalties for outbound licenses or paying royalties for inbound licenses). Currently tracked as payee_name (STRING) and payee_identifier (STRING)',
    `royalty_report_id` BIGINT COMMENT 'Reference to the originating royalty report that calculated the amounts due. This payment reconciles against the reports calculated royalty obligation.',
    `approval_status` STRING COMMENT 'Internal approval workflow status for the royalty payment. Indicates whether the payment has been reviewed and authorized by appropriate stakeholders before execution.. Valid values are `pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved this royalty payment for execution. Used for audit trail and accountability.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the royalty payment was approved for execution. Part of the audit trail for payment authorization workflow.',
    `bank_reference` STRING COMMENT 'Bank transaction reference or confirmation number provided by the financial institution. Used for payment tracing and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this royalty payment record was first created in the system. Part of the audit trail for record lifecycle tracking.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the payment amount to the reporting currency, if applicable. Null if payment currency matches reporting currency.',
    `late_payment_flag` BOOLEAN COMMENT 'Boolean indicator of whether this payment was made after the contractual due date. True indicates late payment, which may trigger penalty clauses or interest charges per the licensing agreement.',
    `late_payment_penalty_amount` DECIMAL(18,2) COMMENT 'Additional penalty or interest amount charged or owed due to late payment, as defined in the licensing agreement. Null if payment was on time or no penalty applies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this royalty payment record was last updated. Used for change tracking and audit purposes.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The final net amount paid or received after applying withholding taxes, fees, and any other adjustments. This is the actual cash flow amount.',
    `payee_identifier` STRING COMMENT 'External identifier for the payee party, such as a vendor number, licensee code, or partner ID. Used for cross-system reconciliation.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the royalty payment in the original transaction currency, before any adjustments or fees.',
    `payment_amount_reporting_currency` DECIMAL(18,2) COMMENT 'The payment amount converted to the enterprises standard reporting currency using the applied exchange rate. Used for consolidated financial reporting and analytics.',
    `payment_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount (e.g., USD, EUR, GBP, JPY). Represents the currency in which the payment was originally denominated.. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The date on which the royalty payment was executed or received. This is the business event date for cash flow recognition, distinct from audit timestamps.',
    `payment_direction` STRING COMMENT 'Indicates whether this is an inbound payment (received from a licensee for use of our IP or game engine technology) or an outbound payment (paid to a rights holder for licensed content, music, art assets, or third-party IP).. Valid values are `inbound|outbound`',
    `payment_due_date` DATE COMMENT 'The contractual due date by which this royalty payment was required to be made or received, as defined in the governing IP agreement. Used to track payment timeliness and late payment penalties.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to execute the royalty payment (e.g., wire transfer, ACH, check, PayPal, platform payout system).. Valid values are `wire_transfer|ach|check|paypal|platform_payout|direct_deposit`',
    `payment_notes` STRING COMMENT 'Free-text notes or comments related to this royalty payment. May include special instructions, explanations of adjustments, or contextual information for finance and legal teams.',
    `payment_period_end_date` DATE COMMENT 'The end date of the reporting period covered by this royalty payment. Defines the conclusion of the usage or revenue period for which royalties are being settled.',
    `payment_period_start_date` DATE COMMENT 'The start date of the reporting period covered by this royalty payment. Defines the beginning of the usage or revenue period for which royalties are being settled.',
    `payment_processor_fee` DECIMAL(18,2) COMMENT 'Transaction fee charged by the payment processor or financial institution for executing the royalty payment. Deducted from the gross payment amount.',
    `payment_reference_number` STRING COMMENT 'External payment reference number or transaction identifier used for tracking and reconciliation. May be a bank transaction ID, wire transfer reference, or payment processor confirmation number.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the royalty payment. Tracks progression from initiation through clearing and reconciliation against the originating royalty report.. Valid values are `pending|processed|cleared|failed|reversed|reconciled`',
    `reconciliation_notes` STRING COMMENT 'Free-text notes explaining reconciliation variances, disputes, adjustments, or special circumstances related to this payment. Used for audit trail and dispute resolution.',
    `reconciliation_status` STRING COMMENT 'Status of reconciliation between this payment record and the originating royalty report. Indicates whether the payment amount matches the calculated royalty obligation or if discrepancies exist.. Valid values are `pending|matched|variance|disputed|resolved`',
    `reconciliation_variance_amount` DECIMAL(18,2) COMMENT 'The monetary difference between the payment amount and the expected amount per the royalty report. Positive values indicate overpayment, negative values indicate underpayment. Null if fully reconciled.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of tax withheld from the royalty payment as required by applicable tax jurisdiction regulations. Common for cross-border royalty payments.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'The percentage rate of withholding tax applied to this royalty payment, as mandated by tax treaty or local tax law. Expressed as a percentage (e.g., 15.00 for 15%).',
    CONSTRAINT pk_royalty_payment PRIMARY KEY(`royalty_payment_id`)
) COMMENT 'Records of actual royalty payments made or received against royalty reports. Captures payment direction (inbound from licensee, outbound to rights holder), payment amount, currency, exchange rate applied, payment date, payment method, bank reference, reconciliation status against the originating royalty report, and linkage to the governing IP agreement. This is the SSOT for royalty-specific cash flows within the licensing domain — distinct from the billing domains general payment processing records. Supports royalty reconciliation, cash flow forecasting, and audit trail requirements.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`entitlement` (
    `entitlement_id` BIGINT COMMENT 'Unique identifier for the entitlement record. Primary key for the entitlement entity.',
    `game_server_id` BIGINT COMMENT 'Foreign key linking to infrastructure.game_server. Business justification: Server-level entitlements for licensed technology (engine versions, middleware modules, DRM systems) enforce operational access control, enable per-server license verification, and support audit trail',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: Entitlements specify which titles are covered by license terms (middleware seats, engine versions). Required for compliance audits and build certification processes.',
    `ip_agreement_id` BIGINT COMMENT 'Reference to the parent license agreement under which this entitlement is granted.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to compliance.jurisdiction. Business justification: Entitlements are jurisdiction-specific (regional licensing, platform certifications, content restrictions). Real process: entitlement provisioning respects territorial restrictions; compliance teams v',
    `licensee_id` BIGINT COMMENT 'Reference to the party (organization or individual) who holds this entitlement.',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Fleet-level entitlements define deployment scope for licensed IP (game engines, middleware stacks), authorize which fleets can use specific technology, and support compliance monitoring and capacity p',
    `activation_date` DATE COMMENT 'Date when the entitlement becomes active and the licensee can begin exercising the granted rights.',
    `audit_frequency_limit` STRING COMMENT 'Maximum frequency at which the licensor can conduct compliance audits (e.g., once per year, twice per contract term).',
    `authorized_distribution_channels` STRING COMMENT 'Comma-separated list of distribution channels through which the licensee is authorized to distribute the licensed content (e.g., Steam, Epic Games Store, PlayStation Store, Xbox Store, retail, direct download).',
    `authorized_platforms` STRING COMMENT 'Comma-separated list of gaming platforms on which the licensee is authorized to distribute or use the licensed IP or technology (e.g., PlayStation, Xbox, PC, Mobile, Nintendo Switch).',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the entitlement automatically renews at the end of its term unless terminated by either party.',
    `compliance_audit_rights` BOOLEAN COMMENT 'Indicates whether the licensor retains the right to audit the licensees usage and compliance with entitlement terms.',
    `content_rating_requirements` STRING COMMENT 'Comma-separated list of required content ratings by territory and rating board (e.g., ESRB:M for USA, PEGI:18 for Europe, CERO:D for Japan) that must be obtained before distribution.',
    `covered_territories` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing the geographic territories where the entitlement is valid.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the entitlement record was first created in the system.',
    `drm_activation_limit` STRING COMMENT 'Maximum number of device activations permitted per end-user license under the DRM implementation requirements. Null if unlimited or not applicable.',
    `drm_offline_grace_period_hours` STRING COMMENT 'Number of hours that the licensed content can be used offline without DRM re-authentication. Null if always-online or not applicable.',
    `drm_provider` STRING COMMENT 'The DRM technology provider that must be implemented for content distributed under this entitlement to protect intellectual property.. Valid values are `steamworks|epic_drm|denuvo|custom|none`',
    `engine_version_scope` STRING COMMENT 'Specific game engine versions or SDK versions covered by this entitlement (e.g., Unity 2021.x, Unreal Engine 5.x). Applicable for game engine technology licenses.',
    `entitlement_number` STRING COMMENT 'Business-facing unique identifier for the entitlement, used in contracts and communications.. Valid values are `^ENT-[A-Z0-9]{8,12}$`',
    `entitlement_status` STRING COMMENT 'Current lifecycle status of the entitlement indicating whether the licensee can exercise the granted rights.. Valid values are `active|suspended|expired|revoked|pending_activation|terminated`',
    `entitlement_type` STRING COMMENT 'Classification of the entitlement based on the type of intellectual property or technology being licensed.. Valid values are `game_engine_sdk|ip_franchise|middleware|music_asset|art_asset|technology_patent`',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this entitlement grants exclusive rights to the licensee within the specified scope (territories, platforms, or use cases).',
    `exclusivity_scope` STRING COMMENT 'Description of the scope of exclusivity if the exclusivity flag is true (e.g., exclusive for mobile platforms in North America, exclusive for first-person shooter genre).',
    `expiry_date` DATE COMMENT 'Date when the entitlement expires and the licensee can no longer exercise the granted rights. Null for perpetual licenses.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the entitlement record was last updated or modified.',
    `max_install_count` STRING COMMENT 'Maximum number of installations or deployments permitted under this entitlement. Applicable for SDK, middleware, or technology licenses. Null if unlimited or not applicable.',
    `max_seat_count` STRING COMMENT 'Maximum number of concurrent developer seats or user licenses permitted under this entitlement for SDK or tool licenses. Null if unlimited or not applicable.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount that the licensee must pay regardless of actual usage or revenue. Null if no minimum guarantee applies.',
    `modification_restrictions` STRING COMMENT 'Specific restrictions or conditions on modifications if modification rights are limited (e.g., no changes to core characters, must maintain brand guidelines, requires licensor approval).',
    `modification_rights` STRING COMMENT 'Level of rights granted to the licensee to modify, adapt, or create derivative works from the licensed IP or technology.. Valid values are `full|limited|none`',
    `renewal_term_months` STRING COMMENT 'Duration in months of each renewal period if auto-renewal is enabled. Null if not applicable.',
    `revenue_threshold_for_royalty` DECIMAL(18,2) COMMENT 'Revenue threshold that must be exceeded before royalty payments commence. Null if royalties apply from the first dollar.',
    `royalty_applicable` BOOLEAN COMMENT 'Indicates whether royalty payments are required under this entitlement based on usage, revenue, or other metrics.',
    `royalty_calculation_method` STRING COMMENT 'Method used to calculate royalty payments if applicable (e.g., percentage of revenue, per-unit fee, per-install fee, tiered structure).. Valid values are `revenue_share|per_unit|per_install|per_seat|fixed_fee|tiered`',
    `royalty_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage rate applied to the royalty base (e.g., gross revenue, net revenue) if royalty calculation is revenue-based. Null if not applicable.',
    `sublicensing_conditions` STRING COMMENT 'Specific terms, restrictions, or approval requirements that apply if sublicensing is permitted under this entitlement.',
    `sublicensing_permitted` BOOLEAN COMMENT 'Indicates whether the licensee is permitted to grant sublicenses to third parties under this entitlement.',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the entitlement before the expiry date.',
    `territory_restrictions` STRING COMMENT 'Specific restrictions or conditions applied to certain territories, such as digital-only distribution, physical and digital rights, streaming rights, or content modifications required for regional compliance.',
    `trademark_usage_guidelines` STRING COMMENT 'Reference to the brand guidelines document or specific requirements for trademark usage if permitted.',
    `trademark_usage_permitted` BOOLEAN COMMENT 'Indicates whether the licensee is permitted to use the licensors trademarks, logos, or brand assets in marketing and distribution.',
    `usage_reporting_frequency` STRING COMMENT 'Frequency at which usage reports must be submitted if usage reporting is required.. Valid values are `monthly|quarterly|annually|on_demand`',
    `usage_reporting_required` BOOLEAN COMMENT 'Indicates whether the licensee is required to submit periodic usage reports (e.g., install counts, active users, revenue) to the licensor.',
    CONSTRAINT pk_entitlement PRIMARY KEY(`entitlement_id`)
) COMMENT 'Tracks the specific rights, usage entitlements, and territorial scope granted to a licensee under an IP agreement — including authorized platforms, covered territories and territory-specific restrictions (digital-only, physical+digital, streaming), permitted game titles or engine versions, maximum seat/install counts for SDK licenses, authorized distribution channels, sublicensing rights, DRM implementation requirements (provider, activation limits, offline grace period), and platform-specific content rating requirements per territory. Each entitlement record has its own activation date, expiry date, and current status (active, suspended, expired, revoked). This is the SSOT for what a licensee is permitted to do under their agreement.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`middleware_agreement` (
    `middleware_agreement_id` BIGINT COMMENT 'Unique identifier for the middleware licensing agreement record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee or team responsible for managing this middleware agreement.',
    `game_studio_id` BIGINT COMMENT 'Reference to the game development studio primarily using this middleware. Null for enterprise-wide agreements.',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: Middleware licenses (Unreal Engine, Havok Physics) are often title-specific with per-title royalties. Essential for royalty calculation and compliance reporting to middleware vendors.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Middleware products (physics engines, audio middleware, etc.) are licensed IP assets that should be cataloged in licensed_ip. This normalization removes redundant product identification fields and ena',
    `licensee_id` BIGINT COMMENT 'Reference to the third-party vendor or licensor providing the middleware technology.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the middleware licensing agreement, used in contracts and vendor communications.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the middleware licensing agreement.. Valid values are `draft|active|suspended|expired|terminated|renewed`',
    `attribution_required_flag` BOOLEAN COMMENT 'Indicates whether the agreement requires public attribution or credit to the middleware vendor in game credits or documentation (True/False).',
    `audit_rights` STRING COMMENT 'Vendor rights to audit licensee usage and revenue reporting: none, annual scheduled audits, on-request, or quarterly.. Valid values are `none|annual|on-request|quarterly`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at the end of each term (True) or requires explicit renewal action (False).',
    `compliance_obligations` STRING COMMENT 'Free-text description of specific compliance requirements passed through to game titles using this middleware (e.g., ESRB disclosure requirements, GDPR data handling, platform Technical Requirements Checklist (TRC) compliance).',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the signed legal contract document in the document management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this middleware agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this agreement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when the middleware licensing agreement expires or terminates. Nullable for perpetual or open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the middleware licensing agreement becomes legally binding and usage rights commence.',
    `fixed_license_fee` DECIMAL(18,2) COMMENT 'One-time or recurring fixed fee for the middleware license. Null for revenue-share-only agreements.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law for dispute resolution (e.g., State of California, England and Wales).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this middleware agreement record was last updated.',
    `license_type` STRING COMMENT 'Licensing model governing usage rights: per-title (licensed per game), per-seat (licensed per developer), revenue-share (royalty-based), perpetual (one-time fee), subscription (recurring), or enterprise (unlimited internal use).. Valid values are `per-title|per-seat|revenue-share|perpetual|subscription|enterprise`',
    `notes` STRING COMMENT 'Free-text field for additional notes, special terms, or internal comments about the middleware agreement.',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required to terminate or opt out of renewal. Null if not applicable.',
    `payment_frequency` STRING COMMENT 'Cadence of license fee or royalty payments to the middleware vendor.. Valid values are `one-time|monthly|quarterly|annually|per-title|on-revenue`',
    `permitted_platforms` STRING COMMENT 'Comma-separated list of gaming platforms where the middleware may be deployed (e.g., PlayStation, Xbox, PC, iOS, Android, Nintendo Switch).',
    `post_termination_rights` STRING COMMENT 'Description of rights and obligations after agreement termination (e.g., continued use in already-shipped titles, removal from future releases, wind-down period).',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the middleware vendor.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary business contact at the middleware vendor for this agreement.',
    `redistribution_rights` STRING COMMENT 'Defines rights to redistribute middleware components: none (internal use only), embedded-only (within compiled game), limited (with restrictions), or full redistribution.. Valid values are `none|embedded-only|limited|full`',
    `renewal_term_months` STRING COMMENT 'Duration in months for automatic renewal periods. Null if agreement does not auto-renew.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of game revenue owed to the middleware vendor under revenue-share licensing model. Null if not revenue-share based.',
    `revenue_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum revenue threshold before revenue-share royalties apply (e.g., first $1M exempt). Null if no threshold exists.',
    `source_code_access_flag` BOOLEAN COMMENT 'Indicates whether the agreement grants access to middleware source code (True) or binary-only distribution (False).',
    `support_entitlement` STRING COMMENT 'Level of technical support and maintenance included with the middleware license (e.g., basic email support, premium 24/7 support).. Valid values are `none|basic|standard|premium|enterprise`',
    `termination_conditions` STRING COMMENT 'Free-text description of conditions under which either party may terminate the agreement (e.g., breach of terms, non-payment, change of control).',
    `update_entitlement` STRING COMMENT 'Scope of software updates and upgrades included: patches only, minor version updates, major version updates, or all updates.. Valid values are `none|patches-only|minor-updates|major-updates|all-updates`',
    `usage_scope` STRING COMMENT 'Defines the breadth of permitted usage: single game title, multiple titles, specific studio, entire enterprise, or restricted to specific platforms (console, PC, mobile).. Valid values are `single-title|multi-title|studio-wide|enterprise-wide|platform-specific`',
    CONSTRAINT pk_middleware_agreement PRIMARY KEY(`middleware_agreement_id`)
) COMMENT 'Master records for third-party middleware licensing agreements — covering physics engines, audio middleware (FMOD, Wwise), anti-cheat SDKs, analytics SDKs, voice chat libraries, and other embedded third-party software components used in game development. Captures middleware vendor, product name and version, license type (per-title, per-seat, revenue-share), usage scope, renewal terms, and compliance obligations passed through to game titles.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`music_sync_license` (
    `music_sync_license_id` BIGINT COMMENT 'Unique identifier for the music synchronization license record.',
    `age_rating_cert_id` BIGINT COMMENT 'Foreign key linking to compliance.age_rating_cert. Business justification: Music licenses must comply with games age rating (explicit lyrics restrictions for Teen vs Mature). Real process: content review ensures licensed music matches rating; legal teams verify compliance b',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Music sync licenses are acquired for specific game projects. Project-level tracking enables budget allocation, milestone planning, and compliance verification for licensed music usage in development.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title in which the licensed music will be used.',
    `ip_agreement_id` BIGINT COMMENT 'Reference to the parent licensing agreement under which this sync license is granted.',
    `licensee_id` BIGINT COMMENT 'Reference to the party (composer, publisher, or label) that owns the synchronization rights to the music track.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether rights holder approval is required before each use of the licensed music (true) or not (false).',
    `composer_name` STRING COMMENT 'Name of the composer or songwriter who created the musical composition.',
    `composition_rights_status` STRING COMMENT 'Status of musical composition rights clearance (cleared, pending, not required, denied, or conditional).. Valid values are `cleared|pending|not_required|denied|conditional`',
    `content_rating_restrictions` STRING COMMENT 'Game content rating restrictions for the licensed music (e.g., ESRB ratings, PEGI ratings). Pipe-separated list of allowed ratings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this synchronization license record was first created in the system.',
    `credit_attribution_required` STRING COMMENT 'Specific credit or attribution text that must be displayed when the music is used (e.g., in game credits, promotional materials).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this license.. Valid values are `^[A-Z]{3}$`',
    `derivative_works_allowed_flag` BOOLEAN COMMENT 'Indicates whether the licensee is permitted to create derivative works or remixes of the licensed music (true) or not (false).',
    `effective_end_date` DATE COMMENT 'Date when the synchronization license expires or terminates. Null for perpetual licenses.',
    `effective_start_date` DATE COMMENT 'Date when the synchronization license becomes effective and usage rights commence.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the synchronization license grants exclusive rights (true) or non-exclusive rights (false).',
    `flat_fee_amount` DECIMAL(18,2) COMMENT 'One-time flat fee payment amount for the synchronization license, if applicable.',
    `isrc_code` STRING COMMENT 'International Standard Recording Code uniquely identifying the sound recording.. Valid values are `^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$`',
    `iswc_code` STRING COMMENT 'International Standard Musical Work Code uniquely identifying the musical composition.. Valid values are `^T-[0-9]{9}-[0-9]$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this synchronization license record was last updated or modified.',
    `license_number` STRING COMMENT 'Externally-known unique identifier or contract number for this music synchronization license.',
    `license_status` STRING COMMENT 'Current lifecycle status of the synchronization license (draft, pending approval, active, suspended, expired, terminated, or renewed). [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `licensed_duration_seconds` STRING COMMENT 'Duration of the music track or excerpt licensed for synchronization, measured in seconds.',
    `master_recording_owner` STRING COMMENT 'Name of the party (typically a record label or artist) that owns the master recording rights.',
    `master_recording_rights_status` STRING COMMENT 'Status of master recording rights clearance (cleared, pending, not required, denied, or conditional).. Valid values are `cleared|pending|not_required|denied|conditional`',
    `media_usage_rights` STRING COMMENT 'Specific media contexts where the music may be synchronized (e.g., in-game background music, cinematic trailer, esports broadcast, streaming platform, promotional materials). Pipe-separated list.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount to the rights holder regardless of actual usage or sales.',
    `notes` STRING COMMENT 'Additional notes, comments, or special terms related to this synchronization license.',
    `payment_frequency` STRING COMMENT 'Frequency at which royalty payments are made to the rights holder (one-time, monthly, quarterly, semi-annual, annual, or per milestone).. Valid values are `one_time|monthly|quarterly|semi_annual|annual|per_milestone`',
    `per_unit_royalty_rate` DECIMAL(18,2) COMMENT 'Royalty amount payable per unit sold (e.g., per game copy sold), if applicable.',
    `platform_rights` STRING COMMENT 'Gaming platforms for which synchronization rights are granted (e.g., console, PC, mobile, VR, cloud gaming). Pipe-separated list.',
    `pro_clearance_status` STRING COMMENT 'Status of clearance with the Performance Rights Organization for public performance rights (cleared, pending, not required, or denied).. Valid values are `cleared|pending|not_required|denied`',
    `pro_name` STRING COMMENT 'Name of the Performance Rights Organization managing the performance rights (e.g., ASCAP, BMI, SESAC, PRS, SOCAN).',
    `publisher_name` STRING COMMENT 'Name of the music publisher that controls the publishing rights to the composition.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue shared with the rights holder as royalty payment, if applicable.',
    `royalty_type` STRING COMMENT 'Type of royalty payment structure for the synchronization license (flat fee, per unit sold, per stream, revenue share, or hybrid).. Valid values are `flat_fee|per_unit|per_stream|revenue_share|hybrid`',
    `signed_date` DATE COMMENT 'Date when the synchronization license agreement was signed by all parties.',
    `sublicensing_allowed_flag` BOOLEAN COMMENT 'Indicates whether the licensee is permitted to sublicense the synchronization rights to third parties (true) or not (false).',
    `sync_license_type` STRING COMMENT 'Classification of the synchronization license based on duration and scope (perpetual, term-limited, project-specific, platform-specific, territory-specific, or buyout).. Valid values are `perpetual|term_limited|project_specific|platform_specific|territory_specific|buyout`',
    `territory_scope` STRING COMMENT 'Geographic territories or regions where the synchronization rights are granted (e.g., worldwide, North America, specific countries). Pipe-separated list of ISO 3166-1 alpha-3 country codes or region names.',
    `track_title` STRING COMMENT 'The title of the music track or composition being licensed for synchronization.',
    `usage_restrictions` STRING COMMENT 'Specific restrictions or limitations on how the music may be used (e.g., no use in violent scenes, no association with certain content ratings, no use in competitive titles).',
    CONSTRAINT pk_music_sync_license PRIMARY KEY(`music_sync_license_id`)
) COMMENT 'Licensing records for music synchronization rights used in game soundtracks, trailers, and in-game audio. Captures music track title, composer/publisher rights holder, sync license type (perpetual, term-limited), territory scope, media usage rights (in-game, trailer, esports broadcast, streaming), licensed duration, master recording rights status, performance rights organization (PRO) clearance status, and royalty obligation per use.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`brand_partnership` (
    `brand_partnership_id` BIGINT COMMENT 'Unique identifier for the brand partnership licensing agreement. Primary key.',
    `game_title_id` BIGINT COMMENT 'Foreign key linking to title.game_title. Business justification: Brand partnerships (Nike in FIFA, Porsche in racing games) are title-specific. Required for revenue share calculation, content approval workflows, and marketing rights management.',
    `ip_agreement_id` BIGINT COMMENT 'Foreign key linking to licensing.ip_agreement. Business justification: Brand partnerships are a specialized type of IP licensing agreement. Linking to ip_agreement provides the master agreement framework (effective dates, status, governing law, termination clauses) while',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Brand partnerships involve external brand owners who are licensees. The brand_owner_name and brand_owner_contact_email should be normalized to the licensee table. This FK enables joining to get full l',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Brand deals impose compliance requirements (advertising standards, age-appropriate placement, alcohol/tobacco restrictions). Real process: partnership approval workflow checks regulatory constraints b',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Branded content partnerships (e.g., Marvel, Star Wars) deployed on specific fleets require operational tracking for partnership obligations, co-marketing requirements, usage reporting, and compliance ',
    `approval_turnaround_days` STRING COMMENT 'Maximum number of business days the brand owner has to review and approve submitted materials. Null if no approval workflow.',
    `approval_workflow_required_flag` BOOLEAN COMMENT 'Indicates whether brand owner approval is required for content, marketing materials, or product releases (True) or not (False).',
    `audit_frequency` STRING COMMENT 'How often the brand owner may conduct audits (annual for once per year, semi-annual for twice per year, quarterly for four times per year, on-demand for as needed, none if no audit rights).. Valid values are `annual|semi_annual|quarterly|on_demand|none`',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether the brand owner has the right to audit revenue, usage, or compliance (True) or not (False).',
    `brand_usage_guidelines_url` STRING COMMENT 'URL reference to the brand owners official usage guidelines, style guide, or brand standards documentation.. Valid values are `^https?://.*$`',
    `co_marketing_obligation_flag` BOOLEAN COMMENT 'Indicates whether the partnership includes mandatory co-marketing or cross-promotional activities (True) or not (False).',
    `co_marketing_requirements` STRING COMMENT 'Detailed description of co-marketing obligations (e.g., Minimum 3 social media posts per quarter, Joint press release at launch, Brand logo in all trailers).',
    `compliance_requirements` STRING COMMENT 'Regulatory and legal compliance obligations specific to this partnership (e.g., COPPA compliance for child-targeted content, GDPR data processing agreement, PCI DSS for payment handling).',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the signed legal contract document in the document management system.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this brand partnership record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand partnership record was first created in the system (format: yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this partnership (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when the brand partnership agreement expires or terminates. Null for perpetual or open-ended agreements (format: yyyy-MM-dd).',
    `effective_start_date` DATE COMMENT 'Date when the brand partnership agreement becomes legally binding and rights become active (format: yyyy-MM-dd).',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the partnership grants exclusive rights (True) or non-exclusive rights (False) to use the licensed brand assets.',
    `exclusivity_terms` STRING COMMENT 'Detailed description of exclusivity conditions, restrictions, and carve-outs (e.g., Exclusive for sports simulation genre only, Non-exclusive with right of first refusal).',
    `fixed_fee_amount` DECIMAL(18,2) COMMENT 'One-time or periodic fixed payment amount for the partnership. Null if royalty-based model.',
    `game_title_scope` STRING COMMENT 'Specific game titles or product lines covered by this partnership (e.g., FIFA 24, Marvels Spider-Man Series, All Mobile Titles).',
    `ip_ownership_terms` STRING COMMENT 'Detailed terms regarding IP ownership of derivative works, new characters, or co-created content (e.g., All derivative IP owned by brand owner, Joint ownership of new characters).',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this brand partnership record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand partnership record was last updated in the system (format: yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `licensed_brand_assets` STRING COMMENT 'Detailed description of the specific brand assets covered by the license (character names, logos, trademarks, visual designs, audio elements, storylines, etc.).',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment to brand owner regardless of actual sales performance. Null if no MG applies.',
    `partnership_name` STRING COMMENT 'Human-readable name of the brand partnership (e.g., FIFA World Cup 2024 License, Marvel Cinematic Universe Character Pack).',
    `partnership_status` STRING COMMENT 'Current lifecycle status of the brand partnership agreement (draft for initial creation, negotiation for under discussion, active for in force, suspended for temporarily paused, terminated for ended early, expired for naturally ended, renewed for extended). [ENUM-REF-CANDIDATE: draft|negotiation|active|suspended|terminated|expired|renewed — 7 candidates stripped; promote to reference product]',
    `partnership_type` STRING COMMENT 'Classification of the brand partnership agreement type (character license for fictional characters, franchise license for entire IP universes, sports league for official league/team rights, celebrity likeness for real person representation, music rights for soundtrack/score, art asset license for visual content).. Valid values are `character_license|franchise_license|sports_league|celebrity_likeness|music_rights|art_asset_license`',
    `performance_milestones` STRING COMMENT 'Specific performance targets or milestones tied to the partnership (e.g., Launch within 12 months, Achieve 1M DAU (Daily Active Users) in first quarter, Minimum $5M revenue in year 1).',
    `platform_scope` STRING COMMENT 'Gaming platforms covered by the license (e.g., Console, PC, Mobile, PlayStation and Xbox Only, Mobile Exclusive).',
    `rating_board_restrictions` STRING COMMENT 'Content rating restrictions imposed by the brand owner (e.g., Must maintain ESRB E10+ or lower, No M-rated content allowed, PEGI 12 maximum).',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the partnership includes an option to renew or extend (True) or not (False).',
    `renewal_terms` STRING COMMENT 'Detailed description of renewal conditions, notice periods, and renegotiation terms (e.g., Auto-renew for 2 years with 90-day notice, Right of first refusal on renewal).',
    `reporting_frequency` STRING COMMENT 'How often revenue, usage, or performance reports must be provided to the brand owner (monthly, quarterly, semi-annual, or annual).. Valid values are `monthly|quarterly|semi_annual|annual`',
    `revenue_share_model` STRING COMMENT 'Financial structure of the partnership (fixed fee for flat payment, percentage royalty for revenue share, hybrid for combination, minimum guarantee plus royalty for MG+royalty structure).. Valid values are `fixed_fee|percentage_royalty|hybrid|minimum_guarantee_plus_royalty`',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of revenue paid to brand owner as royalty (e.g., 5.00 for 5% of net revenue). Null if fixed fee model.',
    `termination_clause` STRING COMMENT 'Conditions under which either party may terminate the partnership early (e.g., Breach of contract, Material adverse change, 180-day notice for convenience).',
    `territory_scope` STRING COMMENT 'Geographic territories where the licensed brand assets may be used (e.g., Worldwide, North America Only, EU and APAC).',
    CONSTRAINT pk_brand_partnership PRIMARY KEY(`brand_partnership_id`)
) COMMENT 'Master records for franchise and brand partnership licensing deals — covering co-branded game titles, licensed character integrations (e.g., sports leagues, film franchises, celebrity likenesses), cross-promotional campaigns, and esports sponsorship IP rights. Captures brand owner, partnership type, licensed brand assets, exclusivity terms, co-marketing obligations, revenue share structure, approval workflow requirements, and brand usage guidelines reference.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`compliance_obligation` (
    `compliance_obligation_id` BIGINT COMMENT 'Unique identifier for the compliance obligation record. Primary key.',
    `cdn_node_id` BIGINT COMMENT 'Foreign key linking to infrastructure.cdn_node. Business justification: CDN-level compliance obligations (data residency laws, content filtering requirements, regional restrictions) enforce where content can be cached and served, supporting GDPR compliance, rating board r',
    `game_studio_id` BIGINT COMMENT 'Foreign key linking to studio.game_studio. Business justification: Studio-level compliance obligations (COPPA, GDPR, ISO27001, platform certifications) apply across all studio operations. Required for studio onboarding, contract renewals, and regulatory audits.',
    `ip_agreement_id` BIGINT COMMENT 'Reference to the parent IP agreement or licensing contract from which this compliance obligation arises.',
    `game_title_id` BIGINT COMMENT 'Reference to the specific game title to which this compliance obligation applies, if applicable.',
    `storefront_id` BIGINT COMMENT 'Reference to the platform (console, PC, mobile) to which this compliance obligation applies, if platform-specific.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Region-specific compliance obligations (GDPR, COPPA, data sovereignty laws, rating board jurisdiction) determine operational constraints for each network region, guide deployment decisions, and ensure',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for ensuring this compliance obligation is fulfilled.',
    `primary_compliance_employee_id` BIGINT COMMENT 'Reference to the user who created this compliance obligation record.',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Fleet-level compliance obligations (regional certification requirements, platform-specific restrictions, content rating enforcement) define deployment constraints, guide capacity planning, and ensure ',
    `approval_date` DATE COMMENT 'The date when the governing body or counterparty approved the submitted compliance deliverables.',
    `audit_submission_requirement` STRING COMMENT 'Details of audit reports, financial statements, or compliance documentation that must be submitted to the licensor or regulatory body.',
    `completion_date` DATE COMMENT 'The actual date when the compliance obligation was fulfilled and marked as complete.',
    `content_restriction_clause` STRING COMMENT 'Specific content restrictions imposed by the IP agreement or regulatory body (e.g., no violence, age-appropriate content, no gambling mechanics).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance obligation record was first created in the system.',
    `data_handling_requirement` STRING COMMENT 'Specific data privacy and handling obligations tied to licensed player-facing features (e.g., GDPR consent requirements, COPPA parental consent, data retention limits).',
    `drm_requirement` STRING COMMENT 'Specific DRM implementation requirements mandated by the IP agreement or platform (e.g., Denuvo, Steamworks DRM, platform-native DRM).',
    `due_date` DATE COMMENT 'The deadline by which this compliance obligation must be fulfilled to avoid breach or penalty.',
    `effective_date` DATE COMMENT 'The date when this compliance obligation becomes active and enforceable under the governing agreement or regulation.',
    `escalation_contact` STRING COMMENT 'Email address of the internal or external contact to escalate to if this obligation is at risk of breach.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `governing_body` STRING COMMENT 'The regulatory or industry body that mandates this obligation (e.g., ESRB, PEGI, GDPR Supervisory Authority, FTC, platform holder). [ENUM-REF-CANDIDATE: ESRB|PEGI|USK|CERO|GRAC|FTC|GDPR_Authority|COPPA|PCI_SSC|ISO_IEC|Apple|Google|Sony|Microsoft|Nintendo|Other — 16 candidates stripped; promote to reference product]',
    `is_blocking_release` BOOLEAN COMMENT 'Boolean flag indicating whether this compliance obligation must be fulfilled before a game title can be released (true) or is non-blocking (false).',
    `jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the jurisdiction where this obligation applies (e.g., USA, DEU, JPN, KOR).. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance obligation record was last updated.',
    `next_recurrence_date` DATE COMMENT 'For recurring obligations, the date when the next instance of this obligation is due.',
    `notes` STRING COMMENT 'Free-text field for additional context, clarifications, or internal comments about this compliance obligation.',
    `obligation_code` STRING COMMENT 'Business-assigned unique code identifying the compliance obligation type (e.g., ESRB_SUBMIT, GDPR_DPA, TRC_CERT).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `obligation_description` STRING COMMENT 'Detailed description of the compliance obligation, including specific requirements, deliverables, and conditions that must be met.',
    `obligation_name` STRING COMMENT 'Human-readable name of the compliance obligation (e.g., ESRB Rating Submission, GDPR Data Processing Agreement).',
    `obligation_status` STRING COMMENT 'Current lifecycle status of the compliance obligation: pending (not started), in progress (work underway), submitted (awaiting review), approved (accepted by governing body), rejected (failed review), completed (fulfilled), overdue (past due date), or waived (exempted). [ENUM-REF-CANDIDATE: pending|in_progress|submitted|approved|rejected|completed|overdue|waived — 8 candidates stripped; promote to reference product]',
    `obligation_type` STRING COMMENT 'Category of compliance obligation: rating board submission (ESRB, PEGI, USK, CERO, GRAC), content restriction clause, data privacy requirement (GDPR, COPPA), DRM implementation, platform certification (TRC/TCR), audit submission, royalty reporting, or other. [ENUM-REF-CANDIDATE: rating_board_submission|content_restriction|data_privacy|drm_implementation|platform_certification|audit_submission|royalty_reporting|other — 8 candidates stripped; promote to reference product]',
    `owner_department` STRING COMMENT 'The department or business unit responsible for managing this compliance obligation (e.g., Legal, Compliance, Publishing, Platform Relations).',
    `penalty_for_breach` STRING COMMENT 'Description of penalties, fines, or consequences if this compliance obligation is not met (e.g., financial penalty, license termination, platform delisting).',
    `platform_certification_requirement` STRING COMMENT 'Platform-specific certification obligations (TRC for Sony, TCR for Microsoft, lotcheck for Nintendo) that must be met before release.',
    `priority_level` STRING COMMENT 'Business priority assigned to this obligation based on risk, contractual importance, and regulatory impact.. Valid values are `critical|high|medium|low`',
    `recurrence_frequency` STRING COMMENT 'Indicates how often this obligation recurs: one-time, monthly, quarterly, annually, per game release, or event-driven (triggered by specific business events).. Valid values are `one_time|monthly|quarterly|annually|per_release|event_driven`',
    `risk_score` STRING COMMENT 'Calculated risk score (0-100) representing the business impact and likelihood of breach for this obligation. Higher scores indicate higher risk.',
    `submission_date` DATE COMMENT 'The date when deliverables or documentation for this obligation were submitted to the governing body or counterparty.',
    `supporting_documentation_url` STRING COMMENT 'URL or file path to supporting documentation, guidelines, or reference materials for this compliance obligation.. Valid values are `^https?://.*$`',
    CONSTRAINT pk_compliance_obligation PRIMARY KEY(`compliance_obligation_id`)
) COMMENT 'Tracks specific compliance obligations arising from IP agreements — including rating board submission requirements (ESRB, PEGI, USK, CERO, GRAC), content restriction clauses, GDPR/COPPA data handling obligations tied to licensed player-facing features, DRM implementation requirements, platform certification obligations (TRC/TCR), and audit submission deadlines. Each obligation has an owner, due date, status, and linkage to the governing IP agreement.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`audit_event` (
    `audit_event_id` BIGINT COMMENT 'Unique identifier for the licensing audit or dispute event. Primary key.',
    `claimant_party_licensee_id` BIGINT COMMENT 'Reference to the party initiating the dispute claim (IP owner, licensor, or third party).',
    `game_server_id` BIGINT COMMENT 'Foreign key linking to infrastructure.game_server. Business justification: License audits targeting specific servers (middleware usage verification, DRM compliance checks) require server-level scope tracking for investigation, evidence collection, and remediation of unauthor',
    `infrastructure_incident_id` BIGINT COMMENT 'Foreign key linking to infrastructure.infrastructure_incident. Business justification: License compliance incidents (DRM failures, unauthorized middleware usage, entitlement violations) trigger infrastructure incidents requiring coordinated response. Links audit events to operational in',
    `ip_agreement_id` BIGINT COMMENT 'Reference to the license agreement being audited or disputed.',
    `licensed_ip_id` BIGINT COMMENT 'Reference to the specific IP asset (game title, engine SDK, music track, art asset) that is the subject of the dispute.',
    `licensee_id` BIGINT COMMENT 'Reference to the licensee party being audited or involved in the dispute.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Audits verify compliance with specific obligations (royalty reporting accuracy, usage rights adherence). Real process: audit scoping identifies obligations to test; findings reference violated obligat',
    `respondent_party_licensee_id` BIGINT COMMENT 'Reference to the party responding to the dispute claim (alleged infringer or licensee).',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Fleet-level license audits (engine compliance, middleware usage verification) define audit scope, enable aggregated compliance reporting, and support dispute resolution for technology licensing agreem',
    `audit_period_end_date` DATE COMMENT 'The ending date of the period covered by the audit or dispute.',
    `audit_period_start_date` DATE COMMENT 'The beginning date of the period covered by the audit or dispute.',
    `auditor_name` STRING COMMENT 'Name of the individual auditor, audit firm, or legal counsel assigned to the event.',
    `auditor_organization` STRING COMMENT 'Name of the organization or firm conducting the audit (e.g., Big Four accounting firm, law firm).',
    `auditor_type` STRING COMMENT 'Classification of the entity conducting the audit or investigating the dispute.. Valid values are `internal|third_party|regulatory_body|legal_counsel`',
    `case_number` STRING COMMENT 'Official court or arbitration case number if the dispute has entered formal legal proceedings.',
    `compliance_action_required` STRING COMMENT 'Description of any corrective actions, process changes, or compliance measures required as a result of the audit findings.',
    `confidentiality_agreement_flag` BOOLEAN COMMENT 'Indicates whether the audit findings or settlement terms are subject to a confidentiality or non-disclosure agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit event record was first created in the system.',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The monetary amount in dispute (underpaid royalties, claimed damages, settlement demand). Null for non-financial disputes.',
    `disputed_amount_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the disputed amount (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `event_completed_date` DATE COMMENT 'The date the audit was finalized or the dispute was resolved or closed.',
    `event_initiated_date` DATE COMMENT 'The date the audit was scheduled or the dispute claim was filed.',
    `event_status` STRING COMMENT 'Current lifecycle status of the audit or dispute event. [ENUM-REF-CANDIDATE: scheduled|in_progress|findings_issued|disputed|in_mediation|settled|litigated|closed — 8 candidates stripped; promote to reference product]',
    `event_type` STRING COMMENT 'Classification of the audit or dispute event. Distinguishes between audit types (financial, technical, compliance) and dispute types (infringement, underpayment, unauthorized use). [ENUM-REF-CANDIDATE: financial_royalty_audit|sdk_usage_audit|content_compliance_audit|ip_infringement_claim|royalty_underpayment_dispute|unauthorized_territory_use|unlicensed_derivative_work|contract_breach_claim — 8 candidates stripped; promote to reference product]',
    `findings_summary` STRING COMMENT 'High-level summary of audit findings, compliance gaps, or dispute allegations. Detailed findings are stored in separate audit detail records.',
    `follow_up_audit_date` DATE COMMENT 'Scheduled date for the follow-up audit, if applicable.',
    `follow_up_audit_scheduled_flag` BOOLEAN COMMENT 'Indicates whether a follow-up audit has been scheduled to verify compliance with corrective actions.',
    `governing_law` STRING COMMENT 'The body of law governing the license agreement and dispute resolution (e.g., California Commercial Code, UK Contract Law).',
    `internal_notes` STRING COMMENT 'Internal notes and commentary for audit management and dispute tracking. Not shared externally.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction or territory governing the audit or dispute (e.g., USA-California, EU-Germany, JPN).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit event record was last updated.',
    `legal_counsel_assigned` STRING COMMENT 'Name of the legal counsel or law firm assigned to represent the company in the dispute.',
    `litigation_flag` BOOLEAN COMMENT 'Indicates whether the dispute has escalated to formal litigation or court proceedings.',
    `mediation_flag` BOOLEAN COMMENT 'Indicates whether the dispute is currently in or has entered formal mediation or arbitration.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this record.',
    `resolution_date` DATE COMMENT 'The date a settlement agreement was signed or a judgment was issued.',
    `resolution_outcome` STRING COMMENT 'Final outcome classification of the audit or dispute event. [ENUM-REF-CANDIDATE: no_findings|minor_adjustments|material_breach_identified|settlement_reached|litigation_pending|judgment_for_claimant|judgment_for_respondent|dismissed — 8 candidates stripped; promote to reference product]',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The final agreed settlement or adjustment amount. Null if event is not yet settled.',
    `settlement_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the settlement amount.. Valid values are `^[A-Z]{3}$`',
    `settlement_terms_summary` STRING COMMENT 'High-level summary of settlement terms, including payment schedules, license modifications, or non-monetary remedies. Detailed terms are stored separately.',
    `trigger_reason` STRING COMMENT 'The reason or mechanism that initiated the audit or dispute event.. Valid values are `scheduled_periodic|for_cause|random_selection|third_party_complaint|internal_flag|regulatory_requirement`',
    CONSTRAINT pk_audit_event PRIMARY KEY(`audit_event_id`)
) COMMENT 'Records of formal licensing audits, compliance reviews, and IP dispute resolution events. For audits: captures audit type (financial royalty audit, SDK usage audit, content compliance audit), audit trigger (scheduled, for-cause, random), audit period covered, auditor identity (internal or third-party), findings summary, disputed amount, resolution status, and final settlement outcome. For disputes: captures dispute type (infringement claim, royalty underpayment, unauthorized territory use, unlicensed derivative work), claimant and respondent identities, disputed IP asset, claim amount, legal counsel assigned, dispute status (open, in mediation, settled, litigated), resolution date, and settlement terms. This is the single source of truth for all compliance events, audit findings, and IP dispute resolution within the licensing domain.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`agreement_amendment` (
    `agreement_amendment_id` BIGINT COMMENT 'Unique identifier for the IP agreement amendment record. Primary key.',
    `ip_agreement_id` BIGINT COMMENT 'Reference to the parent IP agreement being amended. Links this amendment to the master licensing agreement.',
    `amendment_date` DATE COMMENT 'Date when the amendment was formally drafted or proposed. Represents the business event timestamp for the amendment creation.',
    `amendment_description` STRING COMMENT 'Detailed narrative description of the changes introduced by this amendment, including specific clauses modified, new terms added, or provisions removed. Supports legal and audit requirements for amendment history.',
    `amendment_number` STRING COMMENT 'Sequential or coded identifier for this amendment within the context of the parent agreement (e.g., AMD-001, AMD-002). Business identifier for the amendment.. Valid values are `^[A-Z0-9-]+$`',
    `amendment_status` STRING COMMENT 'Current lifecycle status of the amendment: draft (being prepared), pending_approval (under review), approved (authorized but not yet signed), executed (fully signed and active), rejected (declined), or superseded (replaced by newer amendment).. Valid values are `draft|pending_approval|approved|executed|rejected|superseded`',
    `amendment_type` STRING COMMENT 'Classification of the amendment by its primary purpose: rate adjustment (pricing changes), territory expansion (geographic scope), term extension (duration), scope modification (deliverables/rights), royalty change (payment terms), or termination clause (exit conditions).. Valid values are `rate_adjustment|territory_expansion|term_extension|scope_modification|royalty_change|termination_clause`',
    `approval_chain` STRING COMMENT 'Comma-separated list of roles or individuals who must approve this amendment (e.g., Legal Counsel, CFO, VP Licensing, General Counsel). Tracks the approval workflow.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who provided final approval for this amendment. Nullable if amendment is not yet approved.',
    `approved_date` DATE COMMENT 'Date when the amendment received final approval. Nullable if amendment is not yet approved.',
    `compliance_impact` STRING COMMENT 'Assessment of the amendments impact on regulatory compliance obligations (ESRB, PEGI, GDPR, COPPA, etc.). Ranges from none (no compliance impact) to critical (significant compliance implications).. Valid values are `none|low|medium|high|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was first created in the system. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial amounts in this amendment (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the physical or digital amendment document stored in the document management system. Supports audit trail and legal discovery.',
    `effective_date` DATE COMMENT 'Date when the amendment terms become legally binding and operational. May differ from amendment_date if the amendment is executed with a future effective date.',
    `executed_by_licensee` STRING COMMENT 'Name or identifier of the licensee representative who signed the amendment. Nullable if amendment is not yet executed.',
    `executed_by_licensor` STRING COMMENT 'Name or identifier of the licensor representative who signed the amendment. Nullable if amendment is not yet executed.',
    `execution_date` DATE COMMENT 'Date when the amendment was fully executed (signed by all parties). Nullable if amendment is not yet executed.',
    `expiration_date` DATE COMMENT 'Date when the amendment terms expire or are no longer applicable. Nullable for amendments that remain in effect for the life of the agreement.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact of this amendment on the agreement value, expressed in the agreements base currency. Positive for revenue increases, negative for decreases. Nullable if financial impact is not quantified.',
    `legal_review_completed` BOOLEAN COMMENT 'Indicates whether legal review has been completed for this amendment. True if review is complete, False otherwise. Nullable if legal review is not required.',
    `legal_review_date` DATE COMMENT 'Date when legal review was completed. Nullable if legal review is not required or not yet completed.',
    `legal_review_required` BOOLEAN COMMENT 'Indicates whether this amendment requires formal legal counsel review before execution. True if legal review is mandatory, False otherwise.',
    `legal_reviewer` STRING COMMENT 'Name or identifier of the legal counsel who reviewed this amendment. Nullable if legal review is not required or not yet completed.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this amendment record. Supports audit trail requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this amendment record was last modified in the system. Supports audit trail and data lineage requirements.',
    `new_minimum_guarantee` DECIMAL(18,2) COMMENT 'Updated minimum guarantee payment amount introduced by this amendment. Represents the floor payment obligation regardless of actual usage or sales. Nullable if amendment does not affect minimum guarantees.',
    `new_royalty_rate` DECIMAL(18,2) COMMENT 'Updated royalty percentage or rate introduced by this amendment. Expressed as a decimal (e.g., 0.0500 for 5%). Nullable if amendment does not affect royalty rates.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context about this amendment. Supports internal documentation and knowledge transfer.',
    `notification_date` DATE COMMENT 'Date when formal notification of this amendment was sent to stakeholders. Nullable if notification has not been sent.',
    `notification_sent` BOOLEAN COMMENT 'Indicates whether formal notification of this amendment has been sent to all relevant stakeholders. True if notification sent, False otherwise.',
    `rejection_reason` STRING COMMENT 'Explanation for why the amendment was rejected, if applicable. Nullable if amendment was not rejected.',
    `scope_change_description` STRING COMMENT 'Detailed description of changes to the agreement scope, including new IP rights granted, restrictions added, or deliverables modified. Supports tracking of scope evolution.',
    `superseded_term_version` STRING COMMENT 'Identifier of the previous agreement version or amendment that this amendment replaces or modifies. Maintains lineage of contract evolution.',
    `term_extension_months` STRING COMMENT 'Number of months by which the agreement term is extended by this amendment. Positive integer for extensions, negative for reductions. Nullable if amendment does not affect term duration.',
    `territory_added` STRING COMMENT 'Geographic territories or markets added to the agreement scope by this amendment. Comma-separated list of ISO 3166-1 alpha-3 country codes or region names.',
    `territory_removed` STRING COMMENT 'Geographic territories or markets removed from the agreement scope by this amendment. Comma-separated list of ISO 3166-1 alpha-3 country codes or region names.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this amendment record. Supports audit trail requirements.',
    CONSTRAINT pk_agreement_amendment PRIMARY KEY(`agreement_amendment_id`)
) COMMENT 'Tracks formal amendments to IP agreements — capturing amendment number, amendment date, description of changes (rate adjustments, territory expansions, term extensions, scope modifications), approval chain, effective date of amendment, and the superseded term version. Maintains a complete amendment history for each IP agreement to support legal and audit requirements.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`usage_report` (
    `usage_report_id` BIGINT COMMENT 'Unique identifier for the usage report record. Primary key.',
    `game_server_id` BIGINT COMMENT 'Foreign key linking to infrastructure.game_server. Business justification: Server-level usage reporting for licensed technology (CCU on middleware-enabled servers, engine runtime hours) provides granular data for royalty calculation, compliance verification, and operational ',
    `ip_agreement_id` BIGINT COMMENT 'Reference to the license agreement under which this usage is being reported.',
    `licensee_id` BIGINT COMMENT 'Reference to the licensee party submitting this usage report.',
    `server_fleet_id` BIGINT COMMENT 'Foreign key linking to infrastructure.server_fleet. Business justification: Fleet-level usage aggregation for licensed technology (total CCU, aggregate runtime, deployment scale) supports royalty reporting, license compliance verification, and capacity planning for middleware',
    `audit_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this usage report requires a formal audit due to variance, dispute, or contractual terms.',
    `contact_email` STRING COMMENT 'Email address of the licensee contact person for follow-up or clarification regarding this usage report.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the licensee contact person responsible for this usage report submission.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this usage report record was first created in the system.',
    `dispute_date` DATE COMMENT 'Date when the dispute was raised regarding this usage report.',
    `dispute_reason` STRING COMMENT 'Explanation of why the usage report is disputed, if applicable.',
    `expected_value` DECIMAL(18,2) COMMENT 'Expected or forecasted usage value for the reporting period based on historical trends or contractual projections.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this usage report record was last modified.',
    `metric_type` STRING COMMENT 'Type of operational consumption metric being reported (e.g., SDK active seat counts, DAU/MAU figures, impression counts, API call volumes). [ENUM-REF-CANDIDATE: active_seats|deployment_count|dau|mau|impression_count|play_count|api_calls — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Additional notes or comments provided by the licensee or licensor regarding this usage report.',
    `platform` STRING COMMENT 'Gaming platform on which the licensed IP or technology was used during the reporting period. [ENUM-REF-CANDIDATE: console|pc|mobile|web|vr|ar|cloud — 7 candidates stripped; promote to reference product]',
    `prior_period_value` DECIMAL(18,2) COMMENT 'Reported value from the previous reporting period for variance comparison.',
    `report_number` STRING COMMENT 'Externally-known unique business identifier for this usage report, typically assigned by the licensee or system.. Valid values are `^UR-[0-9]{8}-[A-Z0-9]{6}$`',
    `report_status` STRING COMMENT 'Current lifecycle status of the usage report in the verification and acceptance workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|verified|disputed|accepted|rejected — 7 candidates stripped; promote to reference product]',
    `report_type` STRING COMMENT 'Classification of the usage report based on the type of licensed IP or technology being reported.. Valid values are `engine_sdk|title_deployment|gaas_metrics|branded_asset|music_licensing|middleware_api`',
    `reported_value` DECIMAL(18,2) COMMENT 'Numeric value of the usage metric reported by the licensee for the reporting period.',
    `reporting_period_end` DATE COMMENT 'End date of the period covered by this usage report.',
    `reporting_period_start` DATE COMMENT 'Start date of the period covered by this usage report.',
    `resolution_date` DATE COMMENT 'Date when the dispute or variance issue was resolved.',
    `resolution_notes` STRING COMMENT 'Detailed notes explaining how the dispute or variance was resolved.',
    `submission_date` DATE COMMENT 'Date when the licensee submitted this usage report to the licensor.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the usage report was submitted, including time zone information.',
    `supporting_documentation_url` STRING COMMENT 'URL or file path to supporting documentation provided by the licensee (e.g., analytics exports, SDK logs, platform reports).. Valid values are `^https?://.*$`',
    `territory` STRING COMMENT 'Geographic territory or market where the usage occurred, represented as ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `title_name` STRING COMMENT 'Name of the game title or product in which the licensed IP or technology was deployed, if applicable.',
    `unit_of_measure` STRING COMMENT 'Unit in which the reported value is measured (e.g., seats, users, impressions, API calls). [ENUM-REF-CANDIDATE: seats|deployments|users|impressions|plays|calls|sessions|downloads — 8 candidates stripped; promote to reference product]',
    `variance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the reported usage shows significant variance compared to prior periods or expected values.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance of the reported value compared to the prior period or expected baseline.',
    `verification_date` DATE COMMENT 'Date when the usage report was verified by the licensor.',
    `verification_status` STRING COMMENT 'Status of the licensors verification process for the reported usage data.. Valid values are `pending|verified|variance_flagged|audit_required|approved`',
    `verified_by` STRING COMMENT 'Name or identifier of the person or system that verified the usage report.',
    CONSTRAINT pk_usage_report PRIMARY KEY(`usage_report_id`)
) COMMENT 'Periodic usage reports submitted by licensees documenting actual consumption of licensed IP assets — including engine SDK active seat counts, title deployment counts by platform, DAU/MAU figures for GaaS titles using licensed IP, in-game branded asset impression counts, music play counts, and API call volumes for middleware. Captures reporting period, submission date, reported metric type, reported value, verification status, and variance flags against prior periods. Feeds royalty calculation engines and compliance monitoring workflows. Distinct from royalty_report which captures financial figures — usage_report captures operational consumption metrics.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`rating_submission` (
    `rating_submission_id` BIGINT COMMENT 'Unique identifier for the rating submission record. Primary key for the rating submission entity.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Rating board submissions (ESRB, PEGI, CERO) are project-specific deliverables tracked alongside development milestones. Required for release gate status and platform certification workflows.',
    `game_title_id` BIGINT COMMENT 'Reference to the game title being submitted for rating. Links to the game title master data.',
    `ip_agreement_id` BIGINT COMMENT 'Reference to the licensing agreement under which this rating submission is required. Links to the license agreement master data.',
    `network_region_id` BIGINT COMMENT 'Foreign key linking to infrastructure.network_region. Business justification: Rating board submissions (ESRB, PEGI, USK) determine which regions can legally serve content. Links submission to deployment region for operational enforcement, content delivery restrictions, and comp',
    `licensee_id` BIGINT COMMENT 'Foreign key linking to licensing.licensee. Business justification: Publishers submitting rating applications are licensees. Currently tracked as publisher_name (STRING). Normalizing to publisher_licensee_id FK enables linking to full licensee details (legal entity, c',
    `appeal_filed` BOOLEAN COMMENT 'Indicates whether an appeal was filed challenging the assigned rating. True if appeal submitted, False otherwise.',
    `appeal_outcome` STRING COMMENT 'The result of the rating appeal process. Upheld (original rating confirmed), overturned (rating changed), modified (rating adjusted), withdrawn (appeal voluntarily dropped). Null if no appeal filed or appeal pending.. Valid values are `upheld|overturned|modified|withdrawn`',
    `assigned_rating` STRING COMMENT 'The official rating assigned by the rating board (e.g., ESRB: E, E10+, T, M, AO; PEGI: 3, 7, 12, 16, 18). Null if rating not yet assigned or submission rejected.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting compliance considerations, special circumstances, rating board feedback, or internal observations related to this submission. Used for audit trail and knowledge management.',
    `content_descriptors` STRING COMMENT 'Comma-separated list of content descriptors submitted to the rating board describing the nature of content in the game (e.g., violence, language, sexual content, drug reference, gambling). Descriptors vary by rating board.',
    `content_modifications_required` BOOLEAN COMMENT 'Indicates whether the rating board mandated content modifications as a condition of the assigned rating. True if modifications required, False if content approved as-is.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this rating submission record was first created in the system. Used for audit trail and data lineage.',
    `developer_name` STRING COMMENT 'Name of the game development studio that created the title being rated.',
    `expected_release_date` DATE COMMENT 'The anticipated commercial release date for the game title. Used by rating boards to prioritize review timelines and ensure rating availability before launch.',
    `interactive_elements` STRING COMMENT 'Comma-separated list of interactive elements disclosed in the submission (e.g., users interact, shares location, in-game purchases, unrestricted internet, digital purchases). Required by most rating boards for online-enabled games.',
    `ip_ownership_confirmed` BOOLEAN COMMENT 'Indicates whether the submitter has confirmed ownership or licensing rights to all intellectual property (IP) contained in the game, including third-party assets, music, art, and franchise elements. Required for compliance with IP licensing terms.',
    `modification_compliance_date` DATE COMMENT 'The date by which mandated content modifications must be completed and verified. Null if no modifications required.',
    `modification_description` STRING COMMENT 'Detailed description of content modifications mandated by the rating board. Includes specific scenes, dialogue, imagery, or gameplay elements that must be altered or removed. Null if no modifications required.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this rating submission record was last modified. Used for audit trail and change tracking.',
    `payment_date` DATE COMMENT 'The date on which the submission fee was paid. Null if payment not yet received.',
    `payment_status` STRING COMMENT 'Status of the submission fee payment. Pending (awaiting payment), paid (payment received), overdue (payment past due), waived (fee exempted), refunded (payment returned).. Valid values are `pending|paid|overdue|waived|refunded`',
    `platform` STRING COMMENT 'Target gaming platform(s) for which the rating is being requested. May include console (PlayStation, Xbox, Nintendo), PC, mobile (iOS, Android), or multi-platform designations.',
    `rating_board` STRING COMMENT 'The rating board organization to which this submission was made. ESRB (Entertainment Software Rating Board - North America), PEGI (Pan European Game Information - Europe), USK (Germany), CERO (Japan), GRAC (South Korea), ACB (Australia), DJCTQ (Brazil). [ENUM-REF-CANDIDATE: ESRB|PEGI|USK|CERO|GRAC|ACB|DJCTQ — 7 candidates stripped; promote to reference product]',
    `rating_certificate_number` STRING COMMENT 'Unique certificate or registration number issued by the rating board upon successful rating assignment. Used for compliance verification and platform certification.',
    `rating_decision_date` DATE COMMENT 'The date on which the rating board issued its rating decision. Null if rating not yet assigned.',
    `rating_effective_date` DATE COMMENT 'The date from which the assigned rating becomes valid and can be used in marketing and distribution. Typically the same as or shortly after the rating decision date.',
    `rating_expiry_date` DATE COMMENT 'The date on which the rating expires and must be renewed, if applicable. Some rating boards require periodic re-certification for live-service games. Null for ratings with no expiry.',
    `submission_date` DATE COMMENT 'The date on which the rating submission materials were formally submitted to the rating board. This is the principal business event timestamp for the submission lifecycle.',
    `submission_fee_amount` DECIMAL(18,2) COMMENT 'The fee charged by the rating board for processing this submission. Amount varies by rating board, submission type, and title complexity.',
    `submission_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the submission fee (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `submission_number` STRING COMMENT 'Externally-known unique identifier for this rating submission, typically assigned by the submitting organization or rating board tracking system.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the rating submission. Draft (being prepared), submitted (sent to board), under_review (board reviewing), pending_info (awaiting additional information), rated (rating assigned), rejected (submission denied), withdrawn (voluntarily pulled), expired (rating validity ended). [ENUM-REF-CANDIDATE: draft|submitted|under_review|pending_info|rated|rejected|withdrawn|expired — 8 candidates stripped; promote to reference product]',
    `submission_type` STRING COMMENT 'Type of rating submission. Initial (first-time rating for new title), re-rating (resubmission after content changes), DLC (Downloadable Content rating), patch (content update rating), update (revised submission), appeal (challenge to assigned rating).. Valid values are `initial|re-rating|dlc|patch|update|appeal`',
    `submitter_email` STRING COMMENT 'Email address of the primary contact for this rating submission. Used for rating board correspondence and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `submitter_name` STRING COMMENT 'Name of the individual or organization that submitted the rating application on behalf of the licensee or publisher.',
    `submitter_phone` STRING COMMENT 'Phone number of the primary contact for this rating submission.',
    `third_party_content_disclosed` BOOLEAN COMMENT 'Indicates whether the submission disclosed the use of third-party licensed content (music, art assets, middleware, game engine components). Required for rating board transparency and IP compliance.',
    `title_name` STRING COMMENT 'The name of the game title or DLC being submitted for rating as it will appear on the rating certificate and in public-facing materials.',
    CONSTRAINT pk_rating_submission PRIMARY KEY(`rating_submission_id`)
) COMMENT 'Records of content rating submissions made to rating boards (ESRB, PEGI, USK, CERO, GRAC) for licensed game titles and DLC. Captures submission date, rating board, title name, submission type (initial, re-rating, DLC), content descriptors submitted, assigned rating received, rating certificate number, rating expiry (where applicable), and any required content modifications mandated by the rating board. Supports IP agreement compliance obligations and platform certification workflows.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`ip_dispute` (
    `ip_dispute_id` BIGINT COMMENT 'Unique identifier for the IP dispute record. Primary key.',
    `ip_agreement_id` BIGINT COMMENT 'Identifier of the license agreement related to this dispute, if applicable.',
    `licensed_ip_id` BIGINT COMMENT 'Identifier of the specific IP asset (game title, engine technology, trademark, patent, or licensed content) that is the subject of the dispute.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal legal counsel or external law firm assigned to manage this dispute on behalf of the company.',
    `legal_entity_id` BIGINT COMMENT 'Identifier of the party (individual or organization) filing the IP dispute claim.',
    `actual_legal_cost` DECIMAL(18,2) COMMENT 'Actual total legal and administrative costs incurred in managing and resolving this IP dispute.',
    `alleged_violation_date` DATE COMMENT 'Date when the alleged IP infringement or violation is claimed to have occurred or begun.',
    `claim_amount` DECIMAL(18,2) COMMENT 'Monetary amount claimed by the claimant as damages or compensation for the alleged IP violation.',
    `claimant_legal_counsel` STRING COMMENT 'Name of the law firm or attorney representing the claimant in this dispute.',
    `claimant_name` STRING COMMENT 'Full legal name of the claimant party filing the IP dispute.',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates whether the dispute and its resolution are subject to confidentiality or non-disclosure agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IP dispute record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the claim amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_description` STRING COMMENT 'Detailed narrative description of the IP dispute, including the nature of the alleged infringement or violation and supporting facts.',
    `dispute_number` STRING COMMENT 'Externally-known case number or reference code assigned to this IP dispute for tracking and legal correspondence.',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the IP dispute case indicating its progression through resolution stages.. Valid values are `open|in_mediation|settled|litigated|dismissed|withdrawn`',
    `dispute_type` STRING COMMENT 'Classification of the IP dispute indicating the nature of the claim or violation.. Valid values are `infringement_claim|royalty_underpayment|unauthorized_territory_use|unlicensed_derivative_work|trademark_violation|patent_infringement`',
    `disputed_ip_asset_name` STRING COMMENT 'Name or title of the IP asset under dispute (e.g., game title, engine SDK, franchise brand).',
    `document_repository_url` STRING COMMENT 'URL or file path to the secure repository containing all legal documents, correspondence, and evidence related to this IP dispute.',
    `estimated_legal_cost` DECIMAL(18,2) COMMENT 'Estimated total legal and administrative costs associated with managing and resolving this IP dispute.',
    `filing_date` DATE COMMENT 'Date when the IP dispute claim was formally filed or initiated.',
    `internal_notes` STRING COMMENT 'Internal notes and commentary from legal, compliance, or business teams regarding the dispute strategy, risks, and progress.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction or court system under which the IP dispute is being adjudicated (e.g., US Federal Court, UK High Court, arbitration panel).',
    `litigation_start_date` DATE COMMENT 'Date when formal litigation or court proceedings were initiated, if the dispute escalated beyond mediation.',
    `mediation_start_date` DATE COMMENT 'Date when formal mediation or alternative dispute resolution proceedings began, if applicable.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this IP dispute record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next internal review or status update meeting regarding this IP dispute.',
    `precedent_flag` BOOLEAN COMMENT 'Indicates whether this dispute case sets a legal or business precedent that may impact future IP licensing or dispute handling.',
    `priority_level` STRING COMMENT 'Business priority level assigned to this dispute based on financial impact, strategic importance, and reputational risk.. Valid values are `critical|high|medium|low`',
    `resolution_date` DATE COMMENT 'Date when the IP dispute was formally resolved, settled, or dismissed.',
    `resolution_method` STRING COMMENT 'Method by which the IP dispute was resolved (e.g., out-of-court settlement, court judgment, arbitration).. Valid values are `settlement|court_judgment|arbitration_award|mediation_agreement|withdrawal|dismissal`',
    `respondent_legal_counsel` STRING COMMENT 'Name of the law firm or attorney representing the respondent in this dispute.',
    `respondent_name` STRING COMMENT 'Full legal name of the respondent party defending against the IP dispute.',
    `risk_category` STRING COMMENT 'Primary risk category associated with this IP dispute (e.g., financial loss, brand reputation damage, operational disruption).. Valid values are `financial|reputational|operational|strategic|regulatory`',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Monetary amount agreed upon or awarded as part of the dispute resolution or settlement.',
    `settlement_terms` STRING COMMENT 'Detailed terms and conditions of the settlement agreement, including non-monetary provisions such as licensing adjustments, territory restrictions, or future royalty modifications.',
    `territory_code` STRING COMMENT 'Three-letter ISO country code representing the geographic territory where the alleged IP violation occurred.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_ip_dispute PRIMARY KEY(`ip_dispute_id`)
) COMMENT 'Tracks IP ownership disputes, infringement claims, and licensing violation cases — capturing dispute type (infringement claim, royalty underpayment, unauthorized territory use, unlicensed derivative work), claimant identity, respondent identity, disputed IP asset, claim amount, legal counsel assigned, dispute status (open, in mediation, settled, litigated), resolution date, and settlement terms. Supports legal and compliance oversight of the IP portfolio.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`sublicense` (
    `sublicense_id` BIGINT COMMENT 'Unique identifier for the sublicense arrangement. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the internal employee or team responsible for managing and monitoring this sublicense arrangement.',
    `ip_agreement_id` BIGINT COMMENT 'Reference to the primary IP agreement that grants sublicensing permissions to the licensee.',
    `licensed_ip_id` BIGINT COMMENT 'Reference to the specific IP asset being sublicensed (game engine SDK, middleware, franchise IP, etc.).',
    `licensee_id` BIGINT COMMENT 'Reference to the original licensee who is granting sublicense rights to the sublicensee under their master agreement.',
    `parent_sublicense_id` BIGINT COMMENT 'Self-referencing FK on sublicense (parent_sublicense_id)',
    `approval_date` DATE COMMENT 'Date when the sublicense arrangement was formally approved by all required parties (primary licensee and original licensor).',
    `approval_status` STRING COMMENT 'Current approval state of the sublicense request, indicating whether the primary licensee and/or original licensor have granted permission.. Valid values are `pending|approved|rejected|conditional`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or role who granted final approval for this sublicense arrangement.',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether the primary licensee or original licensor retains the right to audit the sublicensees usage and revenue reporting.',
    `compliance_monitoring_required_flag` BOOLEAN COMMENT 'Indicates whether the sublicensee must submit regular compliance reports or undergo audits to verify adherence to sublicense terms.',
    `contract_document_reference` STRING COMMENT 'File path, URL, or document management system reference to the signed sublicense agreement and related legal documents.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sublicense record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this sublicense arrangement.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when the sublicense arrangement expires or terminates, after which the sublicensee no longer has rights to the licensed IP.',
    `effective_start_date` DATE COMMENT 'Date when the sublicense arrangement becomes legally binding and the sublicensee may begin exercising granted rights.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the sublicensee has exclusive rights within their territory/platform scope, preventing the primary licensee from granting additional sublicenses.',
    `fixed_fee_amount` DECIMAL(18,2) COMMENT 'One-time or recurring fixed payment amount for the sublicense, independent of usage or revenue.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sublicense record was most recently updated in the system.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum payment amount the sublicensee must pay regardless of actual usage or revenue generated from the sublicensed IP.',
    `modification_rights` STRING COMMENT 'Level of permission granted to the sublicensee to modify, adapt, or create derivative works from the sublicensed IP.. Valid values are `none|limited|full`',
    `notes` STRING COMMENT 'Free-form text field for additional context, special conditions, or internal observations about this sublicense arrangement.',
    `pass_through_royalty_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of sublicense revenue that the primary licensee must pass through to the original licensor as per the parent agreement terms.',
    `payment_frequency` STRING COMMENT 'Cadence at which the sublicensee must remit royalty or fixed fee payments to the primary licensee.. Valid values are `monthly|quarterly|semi_annually|annually|upon_milestone|one_time`',
    `platform_scope` STRING COMMENT 'Permitted gaming platforms and distribution channels for the sublicensed IP (console, PC, mobile, cloud gaming, etc.).',
    `post_termination_obligations` STRING COMMENT 'Requirements the sublicensee must fulfill after sublicense termination, such as ceasing use, destroying copies, or completing sell-off periods.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the sublicensee organization for sublicense communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary business contact at the sublicensee organization responsible for managing this sublicense relationship.',
    `rating_board_compliance_requirements` STRING COMMENT 'Specific content rating obligations the sublicensee must meet (ESRB, PEGI, CERO, etc.) when using the sublicensed IP in their products.',
    `rejection_reason` STRING COMMENT 'Explanation for why the sublicense request was rejected, if applicable, including specific terms or conditions that were not acceptable.',
    `reporting_frequency` STRING COMMENT 'Cadence at which the sublicensee must submit usage reports, revenue reports, or compliance documentation to the primary licensee.. Valid values are `monthly|quarterly|semi_annually|annually|upon_request|none`',
    `revenue_share_model` STRING COMMENT 'Financial structure governing how sublicense revenue is shared between the primary licensee, sublicensee, and original licensor.. Valid values are `pass_through|tiered|flat_fee|hybrid|none`',
    `source_code_access_flag` BOOLEAN COMMENT 'Indicates whether the sublicensee is granted access to source code of the sublicensed SDK or game engine technology.',
    `sublicense_number` STRING COMMENT 'Externally-known unique business identifier for this sublicense arrangement, used in contracts and communications.',
    `sublicense_status` STRING COMMENT 'Current lifecycle state of the sublicense arrangement indicating whether it is pending approval, active, suspended, expired, terminated, or revoked.. Valid values are `pending_approval|active|suspended|expired|terminated|revoked`',
    `sublicense_type` STRING COMMENT 'Classification of the sublicensing arrangement based on the nature of rights granted (SDK access for contractors, co-development partnerships, distribution rights, etc.).. Valid values are `sdk_access|contractor_rights|co_development|distribution|technology_transfer|middleware_pass_through`',
    `sublicensed_ip_scope` STRING COMMENT 'Detailed description of the specific IP assets, SDK components, game engine features, or technology elements covered under this sublicense.',
    `sublicensee_royalty_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue that the sublicensee must pay to the primary licensee for use of the sublicensed IP.',
    `sublicensing_permitted_flag` BOOLEAN COMMENT 'Indicates whether the sublicensee is allowed to further sublicense the IP to additional downstream parties (cascading sublicense).',
    `termination_conditions` STRING COMMENT 'Specific circumstances under which the sublicense may be terminated early by either party, including breach conditions and cure periods.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the sublicense arrangement.',
    `territory_restrictions` STRING COMMENT 'Specific geographic limitations or exclusions where the sublicensee is prohibited from using the sublicensed IP, even if broader territories are granted.',
    `territory_scope` STRING COMMENT 'Geographic territories where the sublicensee is permitted to exercise sublicensed rights, specified as comma-separated ISO 3166-1 alpha-3 country codes or regional descriptors.',
    `usage_restrictions` STRING COMMENT 'Specific limitations on how the sublicensee may use the IP, including prohibited use cases, content restrictions, or technical constraints.',
    CONSTRAINT pk_sublicense PRIMARY KEY(`sublicense_id`)
) COMMENT 'Tracks sublicensing arrangements where a primary licensee grants downstream rights to third parties under sublicensing permissions in their IP agreement. Captures sublicensee identity, parent agreement reference, sublicensed IP scope, territory restrictions, revenue share pass-through terms, sublicense effective/expiry dates, approval status, and compliance monitoring requirements. Critical for gaming engine licensing where studios sublicense SDK access to contractors or co-development partners.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`economy_config` (
    `economy_config_id` BIGINT COMMENT 'Unique identifier for the virtual economy configuration record. Primary key.',
    `ab_experiment_id` BIGINT COMMENT 'Foreign key linking to analytics.ab_experiment. Business justification: Virtual economy parameters (earn rates, sink rates, exchange rates, balance caps) are commonly A/B tested for game balance. Experiment attribution enables economy health analysis and monetization impa',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Economy configurations are versioned game design artifacts managed within dev projects. Tracking provenance supports balance iteration analysis, regulatory audit trails (economy changes per release), ',
    `employee_id` BIGINT COMMENT 'Reference to the internal user (game designer, economy manager) who approved this configuration for production use.',
    `game_studio_id` BIGINT COMMENT 'Foreign key linking to studio.game_studio. Business justification: Economy configs are designed by specific studios. Tracking studio ownership supports multi-studio publishers managing different economy models per studio, studio-level economy health monitoring, and a',
    `game_title_id` BIGINT COMMENT 'Reference to the game title for which this economy configuration applies.',
    `network_region_id` BIGINT COMMENT 'Reference to the gaming platform (console, PC, mobile) for which this economy configuration applies. Null if configuration is cross-platform.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: Economy configurations must comply with policies governing virtual currency regulations, anti-money laundering controls, and minor spending protections. Required for economy design approval, regulator',
    `title_season_id` BIGINT COMMENT 'Reference to the game season or content release period associated with this economy configuration. Null for non-seasonal configurations.',
    `superseded_economy_config_id` BIGINT COMMENT 'Self-referencing FK on economy_config (superseded_economy_config_id)',
    `ab_test_variant` STRING COMMENT 'Identifier for the A/B test variant this economy configuration represents. Used for experimentation and optimization. Null for non-test configurations.. Valid values are `^[A-Z0-9_]{1,20}$`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this economy configuration was approved for production deployment.',
    `base_earn_rate_primary` DECIMAL(18,2) COMMENT 'Default rate at which players earn primary currency per unit of gameplay activity (e.g., per match, per hour, per quest completion).',
    `base_earn_rate_secondary` DECIMAL(18,2) COMMENT 'Default rate at which players earn secondary currency per unit of gameplay activity. Typically lower than primary currency earn rate.',
    `config_code` STRING COMMENT 'Unique business identifier code for this economy configuration, used for external reference and integration.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `config_name` STRING COMMENT 'Human-readable name for this economy configuration (e.g., Season 5 Premium Economy, Launch Week Economy).',
    `config_notes` STRING COMMENT 'Free-text notes documenting the business rationale, design decisions, or special considerations for this economy configuration.',
    `config_status` STRING COMMENT 'Current lifecycle status of this economy configuration. Draft configurations are under development, active configurations are live in-game, suspended configurations are temporarily disabled, and archived configurations are historical records.. Valid values are `draft|active|suspended|archived`',
    `config_version` STRING COMMENT 'Semantic version number of this economy configuration (e.g., 1.0.0, 2.1.3). Used for tracking configuration changes and rollbacks.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `conversion_fee_pct` DECIMAL(18,2) COMMENT 'Percentage fee charged when players convert between primary and secondary currencies. Creates friction and currency sink.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this economy configuration record was first created in the system.',
    `currency_expiry_days` STRING COMMENT 'Number of days after which unspent currency expires and is removed from player accounts. Only applicable when currency_expiry_enabled is true.',
    `currency_expiry_enabled` BOOLEAN COMMENT 'Indicates whether currency balances have expiration dates. When true, unspent currency may expire after a defined period.',
    `daily_earn_cap_primary` BIGINT COMMENT 'Maximum amount of primary currency a player can earn in a single day through gameplay. Prevents exploitation and maintains economy health.',
    `daily_earn_cap_secondary` BIGINT COMMENT 'Maximum amount of secondary currency a player can earn in a single day through gameplay. Typically lower than primary currency cap.',
    `deflation_threshold_pct` DECIMAL(18,2) COMMENT 'Maximum acceptable deflation rate (as percentage) before automated controls trigger. Measured as rate of currency sink exceeding earn rate.',
    `economy_health_score_min` DECIMAL(18,2) COMMENT 'Minimum acceptable economy health score (0-100 scale) before alerts are triggered. Health score measures balance between earn and sink rates, inflation, and player engagement.',
    `economy_health_score_target` DECIMAL(18,2) COMMENT 'Target economy health score (0-100 scale) that represents optimal economy balance. Used for monitoring and automated adjustment decisions.',
    `effective_end_date` DATE COMMENT 'Date when this economy configuration expires and is no longer active. Null for open-ended configurations.',
    `effective_start_date` DATE COMMENT 'Date when this economy configuration becomes active and begins governing in-game economy behavior.',
    `exchange_rate_primary_to_secondary` DECIMAL(18,2) COMMENT 'Conversion rate from primary currency to secondary currency (e.g., 100 gold = 1 gem would be 0.01). Used for in-game currency conversion mechanics.',
    `exchange_rate_secondary_to_primary` DECIMAL(18,2) COMMENT 'Conversion rate from secondary currency to primary currency. May differ from inverse of primary-to-secondary rate to create conversion friction.',
    `inflation_control_enabled` BOOLEAN COMMENT 'Indicates whether automated inflation control mechanisms are active for this economy configuration. When true, system may dynamically adjust earn/sink rates.',
    `inflation_threshold_pct` DECIMAL(18,2) COMMENT 'Maximum acceptable inflation rate (as percentage) before automated controls trigger. Measured as rate of currency supply growth exceeding sink rate.',
    `max_balance_cap_primary` BIGINT COMMENT 'Maximum amount of primary currency a single player account can hold. Prevents hoarding and maintains economy balance.',
    `max_balance_cap_secondary` BIGINT COMMENT 'Maximum amount of secondary currency a single player account can hold. Typically higher than primary currency cap for premium currency.',
    `primary_currency_code` STRING COMMENT 'Code identifying the primary virtual currency governed by this configuration (e.g., GOLD, GEMS, VBUCKS).. Valid values are `^[A-Z]{3,10}$`',
    `real_money_to_primary_rate` DECIMAL(18,2) COMMENT 'Conversion rate from real-world currency (USD) to primary virtual currency for IAP (In-App Purchase) transactions. Used for monetization calculations.',
    `real_money_to_secondary_rate` DECIMAL(18,2) COMMENT 'Conversion rate from real-world currency (USD) to secondary virtual currency for IAP transactions. Typically more favorable than primary currency rate.',
    `region_code` STRING COMMENT 'Three-letter ISO country or region code where this economy configuration applies (e.g., USA, EUR, JPN). Null for global configurations.. Valid values are `^[A-Z]{3}$`',
    `secondary_currency_code` STRING COMMENT 'Code identifying the secondary or premium virtual currency governed by this configuration. Null if only one currency is used.. Valid values are `^[A-Z]{3,10}$`',
    `sink_rate_target_primary` DECIMAL(18,2) COMMENT 'Target rate at which primary currency should be removed from the economy through player spending (e.g., per player per day). Used for economy health monitoring.',
    `sink_rate_target_secondary` DECIMAL(18,2) COMMENT 'Target rate at which secondary currency should be removed from the economy through player spending. Used for economy health monitoring.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this economy configuration record was last modified.',
    CONSTRAINT pk_economy_config PRIMARY KEY(`economy_config_id`)
) COMMENT 'Virtual economy configuration parameters per game title defining currency exchange rates, earn rates, sink rates, inflation controls, and economy health thresholds.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`promotion` (
    `promotion_id` BIGINT COMMENT 'Unique identifier for the promotional pricing event. Primary key for the promotion entity.',
    `ab_experiment_id` BIGINT COMMENT 'Foreign key linking to analytics.ab_experiment. Business justification: Promotional discount percentages, messaging, targeting criteria, and display timing are standard A/B test subjects in live ops. Experiment attribution enables promotion effectiveness analysis and incr',
    `content_release_id` BIGINT COMMENT 'Foreign key linking to content.content_release. Business justification: Promotions coordinated with patch/DLC releases for launch incentives. Essential for release day sales strategy, player re-engagement, and new content adoption tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Promotions executed by specific cost centers for expense tracking. Marketing cost management and campaign cost attribution.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to studio.dev_project. Business justification: Promotions coordinate with content releases managed by dev teams. Dev teams need visibility into which promotions align with their release cycles for go-to-market planning, and monetization teams need',
    `dlc_bundle_id` BIGINT COMMENT 'Foreign key linking to title.dlc_bundle. Business justification: Promotions discount DLC bundles (e.g., holiday bundle sale). Business validates bundle eligibility, applies discounts at checkout, and reports promotional revenue by bundle. Core monetization workflow',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Promotional campaigns consume marketing budget and require budget tracking for cost control and ROI analysis. Standard marketing finance integration.',
    `live_ops_cycle_id` BIGINT COMMENT 'Foreign key linking to studio.live_ops_cycle. Business justification: Promotions often launch alongside live-ops cycles (e.g., season pass discounts at season start). Tracking this relationship enables coordinated go-to-market execution, promotional performance analysis',
    `game_title_id` BIGINT COMMENT 'Reference to the game title this promotion applies to. Links promotion to specific game product.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to licensing.licensed_ip. Business justification: Promotional campaigns featuring licensed IP require tracking for marketing rights compliance, licensor approval workflows, and accurate royalty calculation when discounts affect net revenue subject to',
    `marketing_campaign_id` BIGINT COMMENT 'Reference to the parent marketing campaign or offer campaign that this promotion is part of. Links to broader marketing initiatives.',
    `localization_string_id` BIGINT COMMENT 'Foreign key linking to content.localization_string. Business justification: Promotional text needs translation for multi-region deployment. Essential for localized marketing campaigns, regional compliance, and culturally appropriate messaging.',
    `employee_id` BIGINT COMMENT 'Identifier of the business user who approved this promotion for activation. Required for governance and compliance with promotional pricing policies.',
    `promotion_employee_id` BIGINT COMMENT 'Identifier of the business user or system account that created this promotion record. Used for audit and accountability.',
    `promotion_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the business user or system account that last modified this promotion record. Used for audit and accountability.',
    `seasonal_event_id` BIGINT COMMENT 'Foreign key linking to content.seasonal_event. Business justification: Time-limited promotions tied to in-game events (double XP weekends, event sales). Core live ops coordination for event participation incentives and monetization spikes.',
    `title_sku_id` BIGINT COMMENT 'Foreign key linking to title.sku. Business justification: Promotions apply discounts to specific SKUs (e.g., 20% off Standard Edition). Business validates SKU eligibility and calculates final price at purchase. Core workflow for promotional pricing, revenue ',
    `superseded_promotion_id` BIGINT COMMENT 'Self-referencing FK on promotion (superseded_promotion_id)',
    `ab_test_variant` STRING COMMENT 'Identifier for the experimental variant if this promotion is part of an A/B test. Used to measure conversion rate optimization.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this promotion was approved for activation. Part of the promotional governance workflow.',
    `banner_image_url` STRING COMMENT 'URL path to the promotional banner image asset displayed in the game storefront and marketing materials.',
    `conversion_rate` DECIMAL(18,2) COMMENT 'Ratio of redemptions to impressions, indicating the effectiveness of the promotion in driving purchase behavior. Calculated as total_redemptions / total_impressions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this promotion record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary discount values. Applicable when discount_type is fixed_amount.. Valid values are `^[A-Z]{3}$`',
    `discount_type` STRING COMMENT 'Mechanism by which the promotional discount is applied to the purchase price.. Valid values are `percentage|fixed_amount|bonus_currency|bundle_price|tiered`',
    `discount_value` DECIMAL(18,2) COMMENT 'Numeric value of the discount. Interpretation depends on discount_type: percentage (0-100), fixed amount (currency units), or bonus multiplier.',
    `display_priority` STRING COMMENT 'Numeric ranking used to determine the order in which promotions are displayed in the storefront. Lower numbers indicate higher priority.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the promotion expires and is no longer available to players. Nullable for open-ended promotions.',
    `geographic_restriction` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where promotion is available or restricted. Empty indicates global availability.',
    `max_discount_amount` DECIMAL(18,2) COMMENT 'Cap on the total discount value that can be applied to a single transaction. Prevents excessive discounts on high-value purchases.',
    `min_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum transaction value required to qualify for the promotion. Nullable if no minimum threshold applies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this promotion record was last updated. Audit trail for record changes.',
    `notes` STRING COMMENT 'Internal free-text notes and comments about the promotion for business users. May include rationale, performance observations, or operational instructions.',
    `platform_availability` STRING COMMENT 'Comma-separated list of platform codes where this promotion is available (e.g., iOS, Android, Steam, PlayStation, Xbox). Empty indicates all platforms.',
    `promotion_code` STRING COMMENT 'Unique business identifier code for the promotion used in marketing materials and player-facing interfaces. Externally visible promotion reference.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `promotion_name` STRING COMMENT 'Human-readable display name of the promotional event shown to players in storefront and marketing channels.',
    `promotion_status` STRING COMMENT 'Current lifecycle state of the promotion indicating whether it is in planning, running, or concluded.. Valid values are `draft|scheduled|active|paused|completed|cancelled`',
    `promotion_type` STRING COMMENT 'Classification of the promotional event type indicating the nature and structure of the offer.. Valid values are `flash_sale|bundle_discount|first_purchase_bonus|seasonal_event|limited_time_offer|weekend_special`',
    `redemption_limit_per_player` STRING COMMENT 'Maximum number of times a single player can use this promotion. Nullable for unlimited redemptions.',
    `requires_first_purchase` BOOLEAN COMMENT 'Indicates whether this promotion is exclusively available to players making their first in-app purchase (F2P conversion incentive).',
    `stackable_with_other_promos` BOOLEAN COMMENT 'Indicates whether this promotion can be combined with other active promotions in a single transaction.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the promotion becomes active and eligible purchases can receive the discount. Represents the business event time when the promotional pricing takes effect.',
    `target_player_segment` STRING COMMENT 'Player segmentation criteria defining which players are eligible to see and redeem this promotion. May reference LTV segments, behavioral cohorts, or geographic regions.',
    `total_discount_given` DECIMAL(18,2) COMMENT 'Cumulative monetary value of all discounts applied through this promotion. Represents the revenue foregone to drive conversion.',
    `total_impressions` BIGINT COMMENT 'Cumulative count of how many times this promotion was displayed to players across all channels and sessions.',
    `total_redemption_cap` STRING COMMENT 'Maximum number of total redemptions allowed across all players before the promotion automatically ends. Nullable for uncapped promotions.',
    `total_redemptions` BIGINT COMMENT 'Cumulative count of how many times players successfully used this promotion to complete a purchase.',
    `total_revenue_generated` DECIMAL(18,2) COMMENT 'Cumulative gross revenue (before discount) from all transactions that used this promotion. Measured in USD for reporting consistency.',
    CONSTRAINT pk_promotion PRIMARY KEY(`promotion_id`)
) COMMENT 'Time-limited promotional pricing events for in-game purchases including flash sales, bundle discounts, first-purchase bonuses, and seasonal pricing with eligibility rules and discount structures.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`catalog_offer` (
    `catalog_offer_id` BIGINT COMMENT 'Unique surrogate identifier for this catalog-offer association record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the internal user who added this catalog item to the campaign. Supports audit trail and campaign management accountability.',
    `mtx_catalog_id` BIGINT COMMENT 'Foreign key linking to the MTX catalog item included in this offer campaign',
    `offer_campaign_id` BIGINT COMMENT 'Foreign key linking to the offer campaign featuring this catalog item',
    `ab_test_variant_assignment` STRING COMMENT 'A/B test variant identifier for this specific catalog item within the campaign. Enables testing different item selections or pricing strategies within the same campaign framework. May differ from the campaign-level ab_test_variant when testing item-level variations.',
    `added_to_campaign_timestamp` TIMESTAMP COMMENT 'Date and time when this catalog item was added to the campaign. Supports dynamic campaign composition where items are added/removed during the campaign lifecycle.',
    `campaign_specific_discount_value` DECIMAL(18,2) COMMENT 'The discount or bonus value applied to this specific catalog item within this campaign. May override the catalog items default promo_discount_pct for campaign-specific pricing strategies. Interpretation depends on the campaigns discount_type.',
    `conversion_rate_for_item` DECIMAL(18,2) COMMENT 'Calculated conversion rate (redemption_count / impression_count) for this catalog item within this campaign. Tracks item-level performance to optimize future campaign composition.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this catalog-offer association record was created in the system.',
    `display_priority_in_campaign` STRING COMMENT 'Ranking priority for displaying this catalog item within the campaigns offer UI. Lower numbers indicate higher priority. Used when campaigns feature multiple items and need to control presentation order.',
    `impression_count_for_item` BIGINT COMMENT 'Cumulative count of how many times this specific catalog item was displayed to players as part of this campaign. Used for campaign performance analytics and A/B testing evaluation.',
    `is_featured_item` BOOLEAN COMMENT 'Indicates whether this catalog item is featured or highlighted within the campaigns promotional materials. Featured items receive premium placement and visual emphasis.',
    `redemption_count_for_item` BIGINT COMMENT 'Cumulative count of how many times this specific catalog item was purchased by players through this campaign. Core metric for campaign effectiveness and item performance within campaigns.',
    `removed_from_campaign_timestamp` TIMESTAMP COMMENT 'Date and time when this catalog item was removed from the campaign. Null if the item is still active in the campaign. Supports dynamic campaign management and performance-based item rotation.',
    `revenue_generated_for_item` DECIMAL(18,2) COMMENT 'Total revenue generated from purchases of this catalog item through this campaign. Denominated in the campaigns currency_code. Used for ROI analysis and campaign optimization.',
    CONSTRAINT pk_catalog_offer PRIMARY KEY(`catalog_offer_id`)
) COMMENT 'This association product represents the inclusion of specific MTX catalog items within time-limited monetization offer campaigns. It captures the operational relationship between purchasable offerings and targeted promotional campaigns. Each record links one MTX catalog item to one offer campaign with campaign-specific pricing, display priority, and performance tracking attributes that exist only in the context of this campaign-item pairing. This enables dynamic campaign composition, A/B testing of item selection, and per-item performance analytics within campaigns.. Existence Justification: In F2P gaming monetization, offer campaigns routinely feature multiple catalog items (bundles, currency packs, cosmetics) to maximize conversion across player segments, and individual catalog items appear in multiple campaigns over time (seasonal sales, whale retention offers, new player promotions). The business actively manages campaign composition by adding/removing items, testing different item mixes via A/B testing, and tracking per-item performance metrics (impressions, conversions, revenue) within each campaign to optimize future campaign design.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` (
    `ip_compliance_obligation_id` BIGINT COMMENT 'Unique identifier for this IP-obligation compliance relationship record. Primary key.',
    `licensed_ip_id` BIGINT COMMENT 'Foreign key linking to the licensed intellectual property asset subject to this compliance obligation',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the regulatory obligation that applies to this IP asset',
    `audit_findings` STRING COMMENT 'Summary of findings from the most recent audit of this IP-obligation pair. Documents specific compliance gaps, control weaknesses, or validation results.',
    `compliance_owner` STRING COMMENT 'Name or identifier of the individual or team responsible for ensuring this specific IP asset complies with this specific obligation. Assigns accountability at the IP-obligation level.',
    `compliance_status` STRING COMMENT 'Current compliance status of this specific IP asset with respect to this specific obligation. Tracks whether the IP meets the regulatory requirement.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this IP-obligation compliance relationship record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this regulatory obligation became applicable to this specific IP asset. May differ from the obligations general effective date based on IP release date or territory expansion.',
    `exemption_expiration_date` DATE COMMENT 'Date when the exemption expires and the IP must achieve full compliance. NULL if no exemption or exemption is permanent.',
    `exemption_granted` BOOLEAN COMMENT 'Indicates whether this IP asset has been granted an exemption from this obligation by the governing body or internal compliance authority.',
    `implementation_deadline` DATE COMMENT 'Deadline by which this IP asset must achieve compliance with this obligation. May be driven by regulation enforcement date, IP launch date, or remediation plan.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit conducted for this IP-obligation pair. Tracks audit history at the granular IP-obligation level.',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this compliance relationship record. Tracks when status, audit results, or other attributes were modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review or audit of this IP asset against this obligation. Drives compliance calendar and audit scheduling.',
    `remediation_plan_url` STRING COMMENT 'URL or file path to the remediation plan document for addressing non-compliance of this IP with this obligation. NULL if compliant or no plan exists.',
    `risk_level` STRING COMMENT 'Assessed risk level for non-compliance of this specific IP with this specific obligation. Risk varies by IP-obligation combination based on IP revenue, territory exposure, and obligation severity.',
    CONSTRAINT pk_ip_compliance_obligation PRIMARY KEY(`ip_compliance_obligation_id`)
) COMMENT 'This association product represents the compliance relationship between licensed intellectual property assets and regulatory obligations. It captures the specific compliance requirements, audit history, risk assessment, and implementation status for each IP-obligation pairing. Each record links one licensed IP asset to one regulatory obligation with attributes that track compliance posture, deadlines, and enforcement actions specific to that combination.. Existence Justification: In gaming operations, a single licensed IP asset (e.g., a game engine SDK) is subject to multiple regulatory obligations across jurisdictions (GDPR for EU players, COPPA for US children, PEGI rating requirements for Europe, loot box disclosure laws). Conversely, a single regulatory obligation (e.g., GDPR Article 30 record-keeping) applies to multiple IP assets (all engines with telemetry, all games with user accounts). Compliance teams actively manage a compliance matrix mapping each IP to applicable obligations, tracking compliance status, audit dates, risk levels, and remediation plans for each IP-obligation pair.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` (
    `catalog_promotion_eligibility_id` BIGINT COMMENT 'Unique surrogate identifier for each catalog item-promotion eligibility record',
    `mtx_catalog_id` BIGINT COMMENT 'Foreign key linking to the MTX catalog entry that is eligible for this promotion',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to the promotional campaign that includes this catalog item',
    `added_to_promotion_timestamp` TIMESTAMP COMMENT 'Date and time when this catalog item was added to the promotions eligible item list, supporting audit trail and promotional planning analysis',
    `display_order_in_promotion` STRING COMMENT 'Sequence number controlling the visual presentation order of this catalog item within the promotions storefront display',
    `effective_discount_percentage` DECIMAL(18,2) COMMENT 'The actual discount percentage applied to this specific catalog item within this promotion, which may differ from the promotions default discount based on item-specific rules or overrides',
    `eligibility_status` STRING COMMENT 'Current operational status of this items eligibility within the promotion: active (currently eligible), paused (temporarily suspended), removed (no longer eligible), pending (scheduled for future activation)',
    `eligible_sku_list` STRING COMMENT 'Comma-separated list of MTX catalog SKU codes that qualify for this promotion. Empty indicates all SKUs are eligible. [Moved from promotion: This STRING field containing comma-separated SKU codes is a denormalized representation of the M:N relationship. It should be removed from the promotion product as the association table now properly normalizes this relationship, enabling proper querying, indexing, and relationship-specific attribute tracking.]',
    `featured_flag` BOOLEAN COMMENT 'Indicates whether this catalog item is designated as a featured or hero item within this promotion, receiving prominent placement in promotional materials',
    `item_specific_redemption_count` BIGINT COMMENT 'Cumulative count of how many times this specific catalog item was purchased using this specific promotion, enabling item-level promotional performance analysis',
    `item_specific_revenue_generated` DECIMAL(18,2) COMMENT 'Total gross revenue generated from purchases of this catalog item through this promotion, tracking the revenue contribution of each item-promotion combination',
    `promotion_priority_rank` STRING COMMENT 'Numeric ranking determining the display order and priority of this catalog item within the promotions featured items list',
    `removed_from_promotion_timestamp` TIMESTAMP COMMENT 'Date and time when this catalog item was removed from the promotion (if applicable), enabling tracking of promotional composition changes during the campaign lifecycle',
    CONSTRAINT pk_catalog_promotion_eligibility PRIMARY KEY(`catalog_promotion_eligibility_id`)
) COMMENT 'This association product represents the promotional eligibility relationship between MTX catalog items and promotional campaigns. It captures which purchasable offerings are included in which time-limited promotional events, along with item-specific promotional performance metrics and display configuration. Each record links one MTX catalog entry to one promotion with attributes that track the effectiveness and presentation of that specific item within that specific promotional context.. Existence Justification: In gaming monetization, promotional campaigns are actively managed business events where merchandising teams strategically select which MTX catalog items to include in which promotions, track performance metrics per item-promotion combination, and adjust promotional mix based on conversion data. A single catalog item (e.g., a legendary skin) participates in multiple promotions over time (flash sale, seasonal event, bundle discount), and each promotion includes multiple catalog items with item-specific discount rates, display priority, and performance tracking. This is an operational M:N relationship with its own lifecycle and relationship-specific data.';

CREATE OR REPLACE TABLE `gaming_ecm`.`licensing`.`team_brand_license` (
    `team_brand_license_id` BIGINT COMMENT 'Unique surrogate identifier for each team brand licensing agreement record',
    `mtx_catalog_id` BIGINT COMMENT 'Foreign key linking to the microtransaction catalog item that features the licensed team brand',
    `team_id` BIGINT COMMENT 'Foreign key linking to the esports team whose brand is licensed for this MTX item',
    `approval_status` STRING COMMENT 'Current approval status of the brand licensing agreement. Teams must approve the use of their brand in MTX items before they can be sold.',
    `contract_reference_code` STRING COMMENT 'External reference to the legal contract document or master licensing agreement that governs the terms of this team brand license.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this team brand license record was created in the system.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this licensing agreement grants exclusive rights to feature this team in this item category or time period, preventing other teams from being featured in similar items during the exclusivity window.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this team brand license record was last modified, including sales count or revenue share updates.',
    `licensing_end_date` DATE COMMENT 'The expiration or termination date of the brand licensing agreement for this MTX item. Sales after this date do not accrue royalties unless the agreement is renewed.',
    `licensing_start_date` DATE COMMENT 'The effective start date of the brand licensing agreement for this MTX item. Sales before this date do not accrue royalties to the team.',
    `revenue_share_amount` DECIMAL(18,2) COMMENT 'Cumulative revenue share amount (in USD) paid or owed to the esports team for this specific MTX item under this licensing agreement. Calculated as sales revenue × royalty_percentage.',
    `royalty_percentage` DECIMAL(18,2) COMMENT 'The percentage of net revenue from this MTX item that is paid to the esports team as a royalty for licensing their brand. Varies by team tier, item type, and negotiated contract terms.',
    `sales_count` BIGINT COMMENT 'Cumulative count of units sold for this specific MTX item attributed to this team brand license. Used for performance tracking and royalty calculation verification.',
    CONSTRAINT pk_team_brand_license PRIMARY KEY(`team_brand_license_id`)
) COMMENT 'This association product represents the licensing contract between an esports team and a microtransaction catalog item. It captures the commercial agreement where a team licenses their brand (logo, name, colors, identity) to be featured in purchasable MTX items such as team skins, emotes, banners, or bundles. Each record links one MTX catalog item to one esports team with attributes that govern the revenue sharing, royalty payments, licensing period, and sales performance tracking that exist only in the context of this commercial relationship.. Existence Justification: In the gaming industry, esports teams license their brand identity (logos, names, colors) to be featured in purchasable microtransaction items such as team skins, weapon wraps, emotes, banners, and all-star bundles. A single MTX item can feature multiple teams (e.g., an all-star bundle with skins for 5 different championship teams), and a single teams brand appears across multiple MTX items (team skin pack, team emote, team banner, seasonal variants). The business actively manages these licensing relationships with negotiated royalty percentages, revenue tracking per team-item pair, licensing periods, exclusivity clauses, and approval workflows.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ADD CONSTRAINT `fk_licensing_iap_transaction_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ADD CONSTRAINT `fk_licensing_virtual_currency_account_economy_config_id` FOREIGN KEY (`economy_config_id`) REFERENCES `gaming_ecm`.`licensing`.`economy_config`(`economy_config_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_gacha_pool_id` FOREIGN KEY (`gacha_pool_id`) REFERENCES `gaming_ecm`.`licensing`.`gacha_pool`(`gacha_pool_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `gaming_ecm`.`licensing`.`promotion`(`promotion_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_reversal_reference_virtual_currency_ledger_id` FOREIGN KEY (`reversal_reference_virtual_currency_ledger_id`) REFERENCES `gaming_ecm`.`licensing`.`virtual_currency_ledger`(`virtual_currency_ledger_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ADD CONSTRAINT `fk_licensing_virtual_currency_ledger_virtual_currency_account_id` FOREIGN KEY (`virtual_currency_account_id`) REFERENCES `gaming_ecm`.`licensing`.`virtual_currency_account`(`virtual_currency_account_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ADD CONSTRAINT `fk_licensing_mtx_catalog_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ADD CONSTRAINT `fk_licensing_battle_pass_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_battle_pass_id` FOREIGN KEY (`battle_pass_id`) REFERENCES `gaming_ecm`.`licensing`.`battle_pass`(`battle_pass_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ADD CONSTRAINT `fk_licensing_battle_pass_entitlement_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ADD CONSTRAINT `fk_licensing_gacha_pull_gacha_pool_id` FOREIGN KEY (`gacha_pool_id`) REFERENCES `gaming_ecm`.`licensing`.`gacha_pool`(`gacha_pool_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ADD CONSTRAINT `fk_licensing_gacha_pull_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ADD CONSTRAINT `fk_licensing_gacha_pull_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ADD CONSTRAINT `fk_licensing_gacha_pull_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ADD CONSTRAINT `fk_licensing_gacha_pool_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ADD CONSTRAINT `fk_licensing_offer_campaign_parent_campaign_offer_campaign_id` FOREIGN KEY (`parent_campaign_offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ADD CONSTRAINT `fk_licensing_ip_agreement_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ADD CONSTRAINT `fk_licensing_commercial_term_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ADD CONSTRAINT `fk_licensing_royalty_schedule_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ADD CONSTRAINT `fk_licensing_royalty_schedule_superseded_by_schedule_royalty_schedule_id` FOREIGN KEY (`superseded_by_schedule_royalty_schedule_id`) REFERENCES `gaming_ecm`.`licensing`.`royalty_schedule`(`royalty_schedule_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ADD CONSTRAINT `fk_licensing_royalty_report_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ADD CONSTRAINT `fk_licensing_royalty_report_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ADD CONSTRAINT `fk_licensing_royalty_report_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ADD CONSTRAINT `fk_licensing_royalty_payment_iap_transaction_id` FOREIGN KEY (`iap_transaction_id`) REFERENCES `gaming_ecm`.`licensing`.`iap_transaction`(`iap_transaction_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ADD CONSTRAINT `fk_licensing_royalty_payment_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ADD CONSTRAINT `fk_licensing_royalty_payment_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ADD CONSTRAINT `fk_licensing_royalty_payment_royalty_report_id` FOREIGN KEY (`royalty_report_id`) REFERENCES `gaming_ecm`.`licensing`.`royalty_report`(`royalty_report_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ADD CONSTRAINT `fk_licensing_entitlement_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ADD CONSTRAINT `fk_licensing_entitlement_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ADD CONSTRAINT `fk_licensing_middleware_agreement_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ADD CONSTRAINT `fk_licensing_middleware_agreement_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ADD CONSTRAINT `fk_licensing_music_sync_license_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ADD CONSTRAINT `fk_licensing_music_sync_license_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ADD CONSTRAINT `fk_licensing_brand_partnership_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ADD CONSTRAINT `fk_licensing_brand_partnership_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ADD CONSTRAINT `fk_licensing_compliance_obligation_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ADD CONSTRAINT `fk_licensing_audit_event_claimant_party_licensee_id` FOREIGN KEY (`claimant_party_licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ADD CONSTRAINT `fk_licensing_audit_event_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ADD CONSTRAINT `fk_licensing_audit_event_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ADD CONSTRAINT `fk_licensing_audit_event_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ADD CONSTRAINT `fk_licensing_audit_event_respondent_party_licensee_id` FOREIGN KEY (`respondent_party_licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ADD CONSTRAINT `fk_licensing_agreement_amendment_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ADD CONSTRAINT `fk_licensing_usage_report_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ADD CONSTRAINT `fk_licensing_usage_report_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ADD CONSTRAINT `fk_licensing_rating_submission_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ADD CONSTRAINT `fk_licensing_rating_submission_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ADD CONSTRAINT `fk_licensing_ip_dispute_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ADD CONSTRAINT `fk_licensing_ip_dispute_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ADD CONSTRAINT `fk_licensing_sublicense_ip_agreement_id` FOREIGN KEY (`ip_agreement_id`) REFERENCES `gaming_ecm`.`licensing`.`ip_agreement`(`ip_agreement_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ADD CONSTRAINT `fk_licensing_sublicense_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ADD CONSTRAINT `fk_licensing_sublicense_licensee_id` FOREIGN KEY (`licensee_id`) REFERENCES `gaming_ecm`.`licensing`.`licensee`(`licensee_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ADD CONSTRAINT `fk_licensing_sublicense_parent_sublicense_id` FOREIGN KEY (`parent_sublicense_id`) REFERENCES `gaming_ecm`.`licensing`.`sublicense`(`sublicense_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ADD CONSTRAINT `fk_licensing_economy_config_superseded_economy_config_id` FOREIGN KEY (`superseded_economy_config_id`) REFERENCES `gaming_ecm`.`licensing`.`economy_config`(`economy_config_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ADD CONSTRAINT `fk_licensing_promotion_superseded_promotion_id` FOREIGN KEY (`superseded_promotion_id`) REFERENCES `gaming_ecm`.`licensing`.`promotion`(`promotion_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ADD CONSTRAINT `fk_licensing_catalog_offer_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ADD CONSTRAINT `fk_licensing_catalog_offer_offer_campaign_id` FOREIGN KEY (`offer_campaign_id`) REFERENCES `gaming_ecm`.`licensing`.`offer_campaign`(`offer_campaign_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ADD CONSTRAINT `fk_licensing_ip_compliance_obligation_licensed_ip_id` FOREIGN KEY (`licensed_ip_id`) REFERENCES `gaming_ecm`.`licensing`.`licensed_ip`(`licensed_ip_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` ADD CONSTRAINT `fk_licensing_catalog_promotion_eligibility_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` ADD CONSTRAINT `fk_licensing_catalog_promotion_eligibility_promotion_id` FOREIGN KEY (`promotion_id`) REFERENCES `gaming_ecm`.`licensing`.`promotion`(`promotion_id`);
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ADD CONSTRAINT `fk_licensing_team_brand_license_mtx_catalog_id` FOREIGN KEY (`mtx_catalog_id`) REFERENCES `gaming_ecm`.`licensing`.`mtx_catalog`(`mtx_catalog_id`);

-- ========= TAGS =========
ALTER SCHEMA `gaming_ecm`.`licensing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `gaming_ecm`.`licensing` SET TAGS ('dbx_domain' = 'licensing');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` SET TAGS ('dbx_subdomain' = 'monetization_operations');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'In-App Purchase (IAP) Transaction ID');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `finance_tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Tax Record Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Granted Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `mtx_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Microtransaction (MTX) Catalog ID');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `offer_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Campaign ID');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `royalty_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Accrual Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Game Session ID');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `attribution_source` SET TAGS ('dbx_business_glossary_term' = 'Marketing Attribution Source');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `bonus_virtual_currency` SET TAGS ('dbx_business_glossary_term' = 'Bonus Virtual Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `coppa_verified` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Age Verification Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|tablet|console|pc|handheld');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `entitlement_granted` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Granted Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `entitlement_granted_at` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Granted Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Purchase Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `is_f2p_conversion` SET TAGS ('dbx_business_glossary_term' = 'Free-to-Play (F2P) Conversion Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `is_first_purchase` SET TAGS ('dbx_business_glossary_term' = 'First Purchase Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `is_whale` SET TAGS ('dbx_business_glossary_term' = 'Whale Player Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'IAP Item Type');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `loot_box_regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Regulatory Disclosure Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `net_proceeds_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Proceeds Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `net_proceeds_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `net_proceeds_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Distribution Platform');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `platform_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `platform_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `platform_fee_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `platform_fee_rate` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `player_country_code` SET TAGS ('dbx_business_glossary_term' = 'Player Country Code');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `player_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `player_level_at_purchase` SET TAGS ('dbx_business_glossary_term' = 'Player Level at Purchase');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `purchased_at` SET TAGS ('dbx_business_glossary_term' = 'Purchase Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Purchase Quantity');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `receipt_token` SET TAGS ('dbx_business_glossary_term' = 'Storefront Receipt Token');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `receipt_token` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `refund_eligible_until` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligibility Expiry Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `refund_reason` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `refund_reason` SET TAGS ('dbx_value_regex' = 'player_request|chargeback|fraud|technical_error|duplicate_purchase|regulatory');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `refunded_at` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `reporting_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `reporting_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `reporting_currency_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `storefront_transaction_ref` SET TAGS ('dbx_business_glossary_term' = 'Storefront Transaction Reference');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'IAP Transaction Status');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'completed|pending|failed|refunded|disputed|cancelled');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`iap_transaction` ALTER COLUMN `virtual_currency_awarded` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Awarded');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` SET TAGS ('dbx_subdomain' = 'monetization_operations');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `virtual_currency_account_id` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Account ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `economy_config_id` SET TAGS ('dbx_business_glossary_term' = 'Virtual Economy ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `account_close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `account_code` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Account Code');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `account_code` SET TAGS ('dbx_value_regex' = '^VCA-[A-Z0-9]{8,16}$');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `account_open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Account Status');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|frozen|closed|pending_review');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `balance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Balance Expiry Date');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `conversion_status` SET TAGS ('dbx_business_glossary_term' = 'F2P Conversion Status');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `conversion_status` SET TAGS ('dbx_value_regex' = 'never_converted|converted|lapsed|reactivated');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,8}$');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `currency_name` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Name');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `currency_type` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Type');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `currency_type` SET TAGS ('dbx_value_regex' = 'hard_currency|soft_currency|premium_token|event_coin|battle_pass_token');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Virtual Currency Balance');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `data_residency_region` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Region');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `data_residency_region` SET TAGS ('dbx_value_regex' = 'EU|US|APAC|LATAM|MEA|CA');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `earn_cap_daily` SET TAGS ('dbx_business_glossary_term' = 'Daily Earn Cap');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `first_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'First IAP Purchase Date');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `gdpr_erasure_requested` SET TAGS ('dbx_business_glossary_term' = 'GDPR Erasure Requested Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `gdpr_erasure_requested` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `is_purchasable` SET TAGS ('dbx_business_glossary_term' = 'Is Purchasable Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `is_refundable` SET TAGS ('dbx_business_glossary_term' = 'Is Refundable Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `is_transferable` SET TAGS ('dbx_business_glossary_term' = 'Is Transferable Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `last_earn_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Earn Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `last_spend_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Spend Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `last_transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `lifetime_earned` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Earned Virtual Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `lifetime_earned` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `lifetime_earned` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `lifetime_spent` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Spent Virtual Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `lifetime_spent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `lifetime_spent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `max_balance_cap` SET TAGS ('dbx_business_glossary_term' = 'Maximum Balance Cap');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `minor_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Minor Account Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `minor_account_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `parental_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Parental Control Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `pending_balance` SET TAGS ('dbx_business_glossary_term' = 'Pending Virtual Currency Balance');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `pending_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `pending_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `player_segment` SET TAGS ('dbx_business_glossary_term' = 'Player Monetization Segment');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `player_segment` SET TAGS ('dbx_value_regex' = 'f2p|minnow|dolphin|whale|lapsed_payer|churned');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `record_version` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `reserved_balance` SET TAGS ('dbx_business_glossary_term' = 'Reserved Virtual Currency Balance');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `reserved_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `reserved_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `spend_cap_daily` SET TAGS ('dbx_business_glossary_term' = 'Daily Spend Cap');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `total_iap_purchase_count` SET TAGS ('dbx_business_glossary_term' = 'Total IAP Purchase Count');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` SET TAGS ('dbx_subdomain' = 'monetization_operations');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `virtual_currency_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Ledger ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `achievement_id` SET TAGS ('dbx_business_glossary_term' = 'Quest ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `battle_pass_id` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `gacha_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Gacha Pool ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'In-App Purchase (IAP) Transaction ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `offer_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Monetization Offer ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `player_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `player_account_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `reversal_reference_virtual_currency_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reference Ledger Entry ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Reward Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Game Session ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Store Stock Keeping Unit (SKU) ID');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `virtual_currency_account_id` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Account Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `balance_after` SET TAGS ('dbx_business_glossary_term' = 'Balance After Transaction');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `balance_before` SET TAGS ('dbx_business_glossary_term' = 'Balance Before Transaction');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Virtual Currency Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Player Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `currency_name` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Name');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `currency_type` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Type');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `currency_type` SET TAGS ('dbx_value_regex' = 'hard_currency|soft_currency|premium_currency|event_currency|loyalty_token');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'gameanalytics|amplitude|internal_economy_service|platform_sdk|manual');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `delta_amount` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Delta Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Player Device Type');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|pc|console|tablet|other');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `entry_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Ledger Entry Reference Code');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `entry_reference_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{8,64}$');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Ledger Entry Type');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'credit|debit');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `exchange_rate_to_usd` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to USD');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Expiry Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `fraud_flag` SET TAGS ('dbx_business_glossary_term' = 'Fraud Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_business_glossary_term' = 'Fraud Review Status');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `fraud_review_status` SET TAGS ('dbx_value_regex' = 'not_reviewed|under_review|cleared|confirmed_fraud');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `is_first_purchase` SET TAGS ('dbx_business_glossary_term' = 'Is First Purchase Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `is_reversal` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal Entry Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `ledger_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Ledger Entry Status');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `ledger_entry_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending|failed|voided');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Ledger Entry Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `player_level_at_transaction` SET TAGS ('dbx_business_glossary_term' = 'Player Level at Transaction');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `player_segment` SET TAGS ('dbx_business_glossary_term' = 'Player Monetization Segment');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `player_segment` SET TAGS ('dbx_value_regex' = 'whale|dolphin|minnow|f2p_non_payer|lapsed_payer');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `real_money_amount` SET TAGS ('dbx_business_glossary_term' = 'Real Money Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `real_money_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `real_money_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `real_money_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Real Money ISO 4217 Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `real_money_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Transaction Date');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `transaction_source` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Transaction Source');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `transaction_source_category` SET TAGS ('dbx_business_glossary_term' = 'Transaction Source Category');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `transaction_source_category` SET TAGS ('dbx_value_regex' = 'monetization|gameplay_reward|promotional|administrative|refund');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Transaction Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`virtual_currency_ledger` ALTER COLUMN `virtual_to_real_ratio` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency to Real Money Ratio');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` SET TAGS ('dbx_subdomain' = 'monetization_operations');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `mtx_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Microtransaction (MTX) Catalog ID');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Display Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `localization_string_id` SET TAGS ('dbx_business_glossary_term' = 'Name Localization String Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `age_restriction_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Restriction');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `base_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Base Price USD');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `base_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `bundle_parent_sku_code` SET TAGS ('dbx_business_glossary_term' = 'Bundle Parent SKU Code');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `bundle_parent_sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,64}$');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `content_rating_esrb` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Software Rating Board (ESRB) Content Rating');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `content_rating_esrb` SET TAGS ('dbx_value_regex' = 'EC|E|E10+|T|M|AO|RP|RP17+');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `content_rating_pegi` SET TAGS ('dbx_business_glossary_term' = 'Pan European Game Information (PEGI) Content Rating');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `content_rating_pegi` SET TAGS ('dbx_value_regex' = '3|7|12|16|18');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `currency_rounding_policy` SET TAGS ('dbx_business_glossary_term' = 'Currency Rounding Policy');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `currency_rounding_policy` SET TAGS ('dbx_value_regex' = 'round_half_up|round_half_down|round_up|round_down|banker');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `drm_protection_type` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Protection Type');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `drm_protection_type` SET TAGS ('dbx_value_regex' = 'none|platform_native|third_party|entitlement_server');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `drop_rate_disclosed` SET TAGS ('dbx_business_glossary_term' = 'Drop Rate Disclosed Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `image_asset_path` SET TAGS ('dbx_business_glossary_term' = 'Image Asset Path');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `is_giftable` SET TAGS ('dbx_business_glossary_term' = 'Giftable Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `is_promo_code_redeemable` SET TAGS ('dbx_business_glossary_term' = 'Promo Code Redeemable Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `is_sale_eligible` SET TAGS ('dbx_business_glossary_term' = 'Sale Eligibility Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'MTX Item Description');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'MTX Item Type');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'MTX Lifecycle Status');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|deprecated|seasonal|delisted');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `localization_key` SET TAGS ('dbx_business_glossary_term' = 'Localization Key');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `localization_key` SET TAGS ('dbx_value_regex' = '^[a-z0-9_.]{3,128}$');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `loot_box_disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Disclosure Required Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `max_purchase_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Purchase Limit');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `platform_availability` SET TAGS ('dbx_business_glossary_term' = 'Platform Availability');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `platform_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Platform Fee Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `platform_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `price_eur` SET TAGS ('dbx_business_glossary_term' = 'Regional Price EUR');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `price_eur` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `price_gbp` SET TAGS ('dbx_business_glossary_term' = 'Regional Price GBP');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `price_gbp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `price_jpy` SET TAGS ('dbx_business_glossary_term' = 'Regional Price JPY');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `price_jpy` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `price_krw` SET TAGS ('dbx_business_glossary_term' = 'Regional Price KRW');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `price_krw` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `promo_discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Promotional Discount Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `promo_discount_type` SET TAGS ('dbx_business_glossary_term' = 'Promotional Discount Type');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `promo_discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|bundle_override|free');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `quantity_in_bundle` SET TAGS ('dbx_business_glossary_term' = 'Quantity in Bundle');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'MTX Release Date');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'MTX Retirement Date');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `revenue_recognition_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Code');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `revenue_recognition_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `sku_code` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Code');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `sku_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,64}$');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `virtual_currency_cost` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Cost');
ALTER TABLE `gaming_ecm`.`licensing`.`mtx_catalog` ALTER COLUMN `virtual_currency_type` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Type');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` SET TAGS ('dbx_subdomain' = 'monetization_operations');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `battle_pass_id` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass ID');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Launch Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Featured Reward Asset Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Gaas Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Launch Campaign Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `localization_string_id` SET TAGS ('dbx_business_glossary_term' = 'Name Localization String Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `royalty_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Accrual Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `contains_loot_box` SET TAGS ('dbx_business_glossary_term' = 'Contains Loot Box / Gacha Mechanic');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `content_entitlements` SET TAGS ('dbx_business_glossary_term' = 'Content Entitlements');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `coppa_restricted` SET TAGS ('dbx_business_glossary_term' = 'COPPA Restricted');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Pass Duration (Days)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Pass End Date');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `esrb_rating` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Software Rating Board (ESRB) Rating');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `esrb_rating` SET TAGS ('dbx_value_regex' = 'E|E10+|T|M|AO|RP');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `free_tier_count` SET TAGS ('dbx_business_glossary_term' = 'Free Tier Count');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `gdpr_data_processing_note` SET TAGS ('dbx_business_glossary_term' = 'GDPR Data Processing Note');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `has_free_track` SET TAGS ('dbx_business_glossary_term' = 'Has Free Track');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `has_premium_plus` SET TAGS ('dbx_business_glossary_term' = 'Has Premium Plus Track');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `is_cross_platform` SET TAGS ('dbx_business_glossary_term' = 'Is Cross-Platform');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `jira_epic_key` SET TAGS ('dbx_business_glossary_term' = 'Jira Epic Key');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `jira_epic_key` SET TAGS ('dbx_value_regex' = '^[A-Z]+-d+$');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `launch_region` SET TAGS ('dbx_business_glossary_term' = 'Launch Region');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `launch_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}(,[A-Z]{2,3})*$');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `loot_box_disclosure_url` SET TAGS ('dbx_business_glossary_term' = 'Loot Box Disclosure URL');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `max_tier_skips` SET TAGS ('dbx_business_glossary_term' = 'Maximum Tier Skips');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `pass_code` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Code');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `pass_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,50}$');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `pass_status` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Status');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `pass_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|expired|retired');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `pass_type` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Type');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `pass_type` SET TAGS ('dbx_value_regex' = 'progression_tiered|content_access|hybrid');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `pegi_rating` SET TAGS ('dbx_business_glossary_term' = 'Pan European Game Information (PEGI) Rating');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `pegi_rating` SET TAGS ('dbx_value_regex' = '3|7|12|16|18');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `platform_availability` SET TAGS ('dbx_business_glossary_term' = 'Platform Availability');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `premium_plus_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Premium Plus Pass Price (USD)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `premium_plus_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `premium_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Premium Pass Price (USD)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `premium_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `premium_price_virtual_currency` SET TAGS ('dbx_business_glossary_term' = 'Premium Pass Price (Virtual Currency)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `premium_tier_count` SET TAGS ('dbx_business_glossary_term' = 'Premium Tier Count');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `reward_schedule_ref` SET TAGS ('dbx_business_glossary_term' = 'Reward Schedule Reference');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `season_label` SET TAGS ('dbx_business_glossary_term' = 'Season Label');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `soft_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Soft Launch Date');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Pass Start Date');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `tier_count` SET TAGS ('dbx_business_glossary_term' = 'Tier Count');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `tier_skip_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Tier Skip Price (USD)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `tier_skip_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `upgrade_path_code` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Path Code');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Version');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^d+.d+(.d+)?$');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `virtual_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `virtual_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `xp_per_tier` SET TAGS ('dbx_business_glossary_term' = 'Experience Points (XP) Per Tier');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` SET TAGS ('dbx_subdomain' = 'monetization_operations');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `battle_pass_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Entitlement ID');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Experiment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `battle_pass_id` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass ID');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `deferred_revenue_id` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'In-App Purchase (IAP) Transaction ID');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `league_id` SET TAGS ('dbx_business_glossary_term' = 'League Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `acquisition_channel` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Channel');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `age_gate_verified` SET TAGS ('dbx_business_glossary_term' = 'Age Gate Verified Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `auto_renew_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renew Enabled Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Player Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `current_tier` SET TAGS ('dbx_business_glossary_term' = 'Current Battle Pass Tier');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `current_xp` SET TAGS ('dbx_business_glossary_term' = 'Current Battle Pass Experience Points (XP)');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Purchase Discount Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `entitlement_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Reference Code');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `entitlement_reference_code` SET TAGS ('dbx_value_regex' = '^BP-[A-Z0-9]{6,20}$');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|refunded|pending|cancelled');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Expiry Date');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `free_tier_unlocked` SET TAGS ('dbx_business_glossary_term' = 'Free Track Tier Unlocked');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `is_completed` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Completion Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `is_gifted` SET TAGS ('dbx_business_glossary_term' = 'Gifted Battle Pass Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `is_premium_active` SET TAGS ('dbx_business_glossary_term' = 'Premium Track Activated Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `last_progression_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Progression Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `max_tier` SET TAGS ('dbx_business_glossary_term' = 'Maximum Battle Pass Tier');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `net_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Purchase Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `net_purchase_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `net_purchase_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `parental_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Parental Consent Obtained Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `player_level_at_purchase` SET TAGS ('dbx_business_glossary_term' = 'Player Level at Purchase');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `premium_tier_unlocked` SET TAGS ('dbx_business_glossary_term' = 'Premium Track Tier Unlocked');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `promotional_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `purchase_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Purchase Price Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `purchase_price_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `purchase_price_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `purchase_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Purchase Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `refund_status` SET TAGS ('dbx_value_regex' = 'not_refunded|refund_requested|refunded|refund_denied');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `rewards_claimed_count` SET TAGS ('dbx_business_glossary_term' = 'Rewards Claimed Count');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `season_number` SET TAGS ('dbx_business_glossary_term' = 'Season Number');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `tier_skip_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Tier Skip Spend Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `tier_skip_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `tier_skip_spend_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `tier_skips_purchased` SET TAGS ('dbx_business_glossary_term' = 'Tier Skips Purchased');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `track_type` SET TAGS ('dbx_business_glossary_term' = 'Battle Pass Track Type');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `track_type` SET TAGS ('dbx_value_regex' = 'free|premium|premium_plus');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `unclaimed_rewards_count` SET TAGS ('dbx_business_glossary_term' = 'Unclaimed Rewards Count');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `virtual_currency_cost` SET TAGS ('dbx_business_glossary_term' = 'Virtual Currency Cost');
ALTER TABLE `gaming_ecm`.`licensing`.`battle_pass_entitlement` ALTER COLUMN `xp_to_next_tier` SET TAGS ('dbx_business_glossary_term' = 'Experience Points (XP) to Next Tier');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` SET TAGS ('dbx_subdomain' = 'monetization_operations');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `gacha_pull_id` SET TAGS ('dbx_business_glossary_term' = 'Gacha Pull ID');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Experiment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `build_id` SET TAGS ('dbx_business_glossary_term' = 'Build Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `gacha_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Gacha Pool ID');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Campaign ID');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `mtx_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Outcome Item ID');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `player_account_id` SET TAGS ('dbx_business_glossary_term' = 'Player ID');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `age_gate_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Age Gate Verified Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `bonus_items_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Items Granted Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `client_version` SET TAGS ('dbx_business_glossary_term' = 'Client Version');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `conversion_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Conversion Currency Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Currency Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `currency_type` SET TAGS ('dbx_business_glossary_term' = 'Currency Type');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `currency_type` SET TAGS ('dbx_value_regex' = 'premium|soft|free|event');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `days_since_install` SET TAGS ('dbx_business_glossary_term' = 'Days Since Install (DSI)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'mobile|tablet|pc|console');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `disclosed_drop_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Disclosed Drop Rate Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `duplicate_flag` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `fraud_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fraud Risk Score');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `lifetime_gacha_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Gacha Spend (USD)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `outcome_item_quantity` SET TAGS ('dbx_business_glossary_term' = 'Outcome Item Quantity');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `outcome_rarity_tier` SET TAGS ('dbx_business_glossary_term' = 'Outcome Rarity Tier');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `outcome_rarity_tier` SET TAGS ('dbx_value_regex' = 'common|uncommon|rare|epic|legendary|mythic');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `pity_counter_after` SET TAGS ('dbx_business_glossary_term' = 'Pity Counter After Pull');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `pity_counter_before` SET TAGS ('dbx_business_glossary_term' = 'Pity Counter Before Pull');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `pity_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Pity Triggered Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `player_level_at_pull` SET TAGS ('dbx_business_glossary_term' = 'Player Level at Pull');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `pull_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pull Quantity');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `pull_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pull Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `pull_type` SET TAGS ('dbx_business_glossary_term' = 'Pull Type');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `pull_type` SET TAGS ('dbx_value_regex' = 'single|multi|free|premium|discounted');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `real_money_equivalent_usd` SET TAGS ('dbx_business_glossary_term' = 'Real Money Equivalent (USD)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `refund_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `refund_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Refund Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pull` ALTER COLUMN `server_region` SET TAGS ('dbx_business_glossary_term' = 'Server Region');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` SET TAGS ('dbx_subdomain' = 'monetization_operations');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `gacha_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Gacha Pool ID');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Gaas Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `mtx_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Item ID');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `royalty_accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Accrual Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Title Season Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `age_gate_required` SET TAGS ('dbx_business_glossary_term' = 'Age Gate Required');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `banner_image_url` SET TAGS ('dbx_business_glossary_term' = 'Banner Image Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `base_drop_rate_r` SET TAGS ('dbx_business_glossary_term' = 'Base Drop Rate Rare (R)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `base_drop_rate_sr` SET TAGS ('dbx_business_glossary_term' = 'Base Drop Rate Super Rare (SR)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `base_drop_rate_ssr` SET TAGS ('dbx_business_glossary_term' = 'Base Drop Rate Super Super Rare (SSR)');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `collaboration_partner` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Partner');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `collaboration_partner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `cost_per_multi_pull` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Multi Pull');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `cost_per_single_pull` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Single Pull');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `currency_type` SET TAGS ('dbx_business_glossary_term' = 'Currency Type');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `currency_type` SET TAGS ('dbx_value_regex' = 'premium|soft|hard|event|special');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `duplicate_conversion_enabled` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Conversion Enabled');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `duplicate_conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Conversion Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `featured_item_boost_rate` SET TAGS ('dbx_business_glossary_term' = 'Featured Item Boost Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `hard_pity_threshold` SET TAGS ('dbx_business_glossary_term' = 'Hard Pity Threshold');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `max_pulls_per_player` SET TAGS ('dbx_business_glossary_term' = 'Maximum Pulls Per Player');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `minimum_player_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Player Level');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `multi_pull_quantity` SET TAGS ('dbx_business_glossary_term' = 'Multi Pull Quantity');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `pity_counter_shared` SET TAGS ('dbx_business_glossary_term' = 'Pity Counter Shared');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `platform_availability` SET TAGS ('dbx_business_glossary_term' = 'Platform Availability');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `platform_availability` SET TAGS ('dbx_value_regex' = 'ios|android|pc|console|web|all');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `pool_active_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pool Active End Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `pool_active_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pool Active Start Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `pool_code` SET TAGS ('dbx_business_glossary_term' = 'Gacha Pool Code');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `pool_description` SET TAGS ('dbx_business_glossary_term' = 'Gacha Pool Description');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `pool_display_order` SET TAGS ('dbx_business_glossary_term' = 'Pool Display Order');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `pool_name` SET TAGS ('dbx_business_glossary_term' = 'Gacha Pool Name');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `pool_status` SET TAGS ('dbx_business_glossary_term' = 'Gacha Pool Status');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `pool_status` SET TAGS ('dbx_value_regex' = 'draft|active|paused|expired|archived');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `pool_theme` SET TAGS ('dbx_business_glossary_term' = 'Pool Theme');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `pool_type` SET TAGS ('dbx_business_glossary_term' = 'Gacha Pool Type');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `pool_type` SET TAGS ('dbx_value_regex' = 'standard|event|limited|seasonal|promotional|featured');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `pool_version` SET TAGS ('dbx_business_glossary_term' = 'Pool Version');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `region_availability` SET TAGS ('dbx_business_glossary_term' = 'Region Availability');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `regulatory_disclosure_text` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Disclosure Text');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `soft_pity_threshold` SET TAGS ('dbx_business_glossary_term' = 'Soft Pity Threshold');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `total_pulls_lifetime` SET TAGS ('dbx_business_glossary_term' = 'Total Pulls Lifetime');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `total_revenue_lifetime` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Lifetime');
ALTER TABLE `gaming_ecm`.`licensing`.`gacha_pool` ALTER COLUMN `total_revenue_lifetime` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` SET TAGS ('dbx_subdomain' = 'monetization_operations');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `offer_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Campaign ID');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'A/B Test ID');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `ad_creative_id` SET TAGS ('dbx_business_glossary_term' = 'Ad Creative Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Featured Dlc Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Gaas Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `localization_string_id` SET TAGS ('dbx_business_glossary_term' = 'Message Localization String Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `parent_campaign_offer_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Campaign ID');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `tertiary_offer_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `tertiary_offer_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `tertiary_offer_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Target Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `tournament_id` SET TAGS ('dbx_business_glossary_term' = 'Tournament Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_value_regex' = '^[A-Z]$|control');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `campaign_budget` SET TAGS ('dbx_business_glossary_term' = 'Campaign Budget');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `campaign_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `campaign_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `campaign_notes` SET TAGS ('dbx_business_glossary_term' = 'Campaign Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `campaign_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|completed|cancelled');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|bonus_currency|bundle');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `display_image_url` SET TAGS ('dbx_business_glossary_term' = 'Display Image URL (Uniform Resource Locator)');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `display_image_url` SET TAGS ('dbx_value_regex' = '^https?://.*');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `eligible_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Eligible SKU (Stock Keeping Unit) List');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `geo_restriction_list` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction List');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `impression_cap` SET TAGS ('dbx_business_glossary_term' = 'Impression Cap');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `offer_type` SET TAGS ('dbx_business_glossary_term' = 'Offer Type');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `offer_type` SET TAGS ('dbx_value_regex' = 'flash_sale|first_purchase_bonus|returning_player|whale_retention|seasonal_event|limited_time');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `redemption_cap` SET TAGS ('dbx_business_glossary_term' = 'Redemption Cap');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `redemption_cap_per_player` SET TAGS ('dbx_business_glossary_term' = 'Redemption Cap Per Player');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `target_dau_min` SET TAGS ('dbx_business_glossary_term' = 'Target DAU (Daily Active Users) Minimum');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `target_days_since_last_purchase` SET TAGS ('dbx_business_glossary_term' = 'Target Days Since Last Purchase');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `target_ltv_min` SET TAGS ('dbx_business_glossary_term' = 'Target LTV (Lifetime Value) Minimum');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `target_player_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Player Segment');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `target_player_segment` SET TAGS ('dbx_value_regex' = 'f2p|minnow|dolphin|whale|lapsed|new_user');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `total_impressions` SET TAGS ('dbx_business_glossary_term' = 'Total Impressions');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `total_redemptions` SET TAGS ('dbx_business_glossary_term' = 'Total Redemptions');
ALTER TABLE `gaming_ecm`.`licensing`.`offer_campaign` ALTER COLUMN `total_revenue_generated` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Generated');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Agreement ID');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Licensor Entity Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4,8}$');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `assigned_account_manager` SET TAGS ('dbx_business_glossary_term' = 'Assigned Account Manager');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `brand_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Owner Name');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `brand_partnership_type` SET TAGS ('dbx_business_glossary_term' = 'Brand Partnership Type');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `brand_partnership_type` SET TAGS ('dbx_value_regex' = 'co_marketing|co_development|character_licensing|franchise_adaptation|cross_promotion');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `brand_usage_guidelines_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Usage Guidelines Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `co_marketing_obligations` SET TAGS ('dbx_business_glossary_term' = 'Co-Marketing Obligations');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `compliance_rating_board_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rating Board Requirements');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `ip_ownership_terms` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership Terms');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `ip_ownership_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `licensee_name` SET TAGS ('dbx_business_glossary_term' = 'Licensee Name');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `licensee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `licensor_name` SET TAGS ('dbx_business_glossary_term' = 'Licensor Name');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `licensor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `middleware_license_type` SET TAGS ('dbx_business_glossary_term' = 'Middleware License Type');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `middleware_license_type` SET TAGS ('dbx_value_regex' = 'per_title|per_seat|revenue_share|enterprise|perpetual');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `middleware_product_name` SET TAGS ('dbx_business_glossary_term' = 'Middleware Product Name');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `middleware_product_version` SET TAGS ('dbx_business_glossary_term' = 'Middleware Product Version');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `middleware_usage_scope` SET TAGS ('dbx_business_glossary_term' = 'Middleware Usage Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `middleware_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Middleware Vendor Name');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `music_composer_name` SET TAGS ('dbx_business_glossary_term' = 'Music Composer Name');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `music_media_usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Music Media Usage Rights');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `music_pro_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Music Performing Rights Organization (PRO) Clearance Status');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `music_pro_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|rejected');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `music_publisher_name` SET TAGS ('dbx_business_glossary_term' = 'Music Publisher Name');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `music_track_title` SET TAGS ('dbx_business_glossary_term' = 'Music Track Title');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|upon_milestone|one_time');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `renewal_negotiation_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Negotiation Status');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `renewal_negotiation_status` SET TAGS ('dbx_value_regex' = 'not_applicable|not_started|in_progress|completed|declined');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `renewal_notice_deadline_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Deadline Days');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `royalty_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Structure Type');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `royalty_structure_type` SET TAGS ('dbx_value_regex' = 'fixed_fee|revenue_share|per_unit|per_seat|tiered|hybrid');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `termination_clause_summary` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause Summary');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_agreement` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `annual_revenue_range` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Range');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `annual_revenue_range` SET TAGS ('dbx_value_regex' = 'under_1m|1m_to_10m|10m_to_50m|50m_to_100m|100m_to_500m|over_500m');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `annual_revenue_range` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `compliance_tier` SET TAGS ('dbx_business_glossary_term' = 'Compliance Tier');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `compliance_tier` SET TAGS ('dbx_value_regex' = 'tier_1_high_risk|tier_2_medium_risk|tier_3_low_risk|tier_4_trusted');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `doing_business_as_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `employee_count_range` SET TAGS ('dbx_business_glossary_term' = 'Employee Count Range');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `employee_count_range` SET TAGS ('dbx_value_regex' = '1_to_10|11_to_50|51_to_200|201_to_500|501_to_1000|over_1000');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'indie_studio|aaa_publisher|platform_operator|middleware_vendor|music_publisher|brand_owner');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `first_contract_date` SET TAGS ('dbx_business_glossary_term' = 'First Contract Date');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 2');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `is_publicly_traded` SET TAGS ('dbx_business_glossary_term' = 'Is Publicly Traded');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `jurisdiction_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction of Incorporation');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `jurisdiction_of_incorporation` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `kyc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Completion Date');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `kyc_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Customer (KYC) Review Due Date');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `last_contract_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contract Renewal Date');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `licensee_code` SET TAGS ('dbx_business_glossary_term' = 'Licensee Code');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `licensee_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'prospect|kyc_in_progress|approved|active|suspended|terminated');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `preferred_payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Terms (Days)');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `primary_platform_focus` SET TAGS ('dbx_business_glossary_term' = 'Primary Platform Focus');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `relationship_direction` SET TAGS ('dbx_business_glossary_term' = 'Relationship Direction');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `relationship_direction` SET TAGS ('dbx_value_regex' = 'licensee|licensor|bilateral');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `relationship_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Relationship Manager Name');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `specialization_area` SET TAGS ('dbx_business_glossary_term' = 'Specialization Area');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `stock_ticker_symbol` SET TAGS ('dbx_business_glossary_term' = 'Stock Ticker Symbol');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensee` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Intellectual Property (IP) ID');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `franchise_id` SET TAGS ('dbx_business_glossary_term' = 'Franchise Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `active_license_count` SET TAGS ('dbx_business_glossary_term' = 'Active License Count');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `asset_thumbnail_url` SET TAGS ('dbx_business_glossary_term' = 'Asset Thumbnail Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `cero_rating` SET TAGS ('dbx_business_glossary_term' = 'Computer Entertainment Rating Organization (CERO) Rating');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `cero_rating` SET TAGS ('dbx_value_regex' = 'CERO_A|CERO_B|CERO_C|CERO_D|CERO_Z|Not_Rated');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `content_descriptors` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptors');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `coppa_compliant` SET TAGS ('dbx_business_glossary_term' = 'Childrens Online Privacy Protection Act (COPPA) Compliant');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `drm_protection_enabled` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Protection Enabled');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `esrb_rating` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Software Rating Board (ESRB) Rating');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `esrb_rating` SET TAGS ('dbx_value_regex' = 'EC|E|E10+|T|M|AO|RP|Not_Rated');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'IP Registration Expiration Date');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `gdpr_compliant` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Compliant');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `grac_rating` SET TAGS ('dbx_business_glossary_term' = 'Game Rating and Administration Committee (GRAC) Rating');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `grac_rating` SET TAGS ('dbx_value_regex' = 'All|12|15|18|Not_Rated');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `ip_category` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Category');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `ip_category` SET TAGS ('dbx_value_regex' = 'technology|creative_content|brand|hybrid');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `ip_code` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset Code');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `ip_description` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Description');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `ip_name` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset Name');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `ip_type` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Type');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `last_licensed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Licensed Date');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `license_model` SET TAGS ('dbx_business_glossary_term' = 'License Model');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `license_model` SET TAGS ('dbx_value_regex' = 'royalty_based|fixed_fee|subscription|revenue_share|hybrid|not_applicable');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `licensing_availability_status` SET TAGS ('dbx_business_glossary_term' = 'Licensing Availability Status');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `licensing_availability_status` SET TAGS ('dbx_value_regex' = 'available|licensed_exclusive|licensed_non_exclusive|restricted|retired|pending_approval');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `marketing_tagline` SET TAGS ('dbx_business_glossary_term' = 'Marketing Tagline');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `monetization_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Monetization Restrictions');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `ownership_entity` SET TAGS ('dbx_business_glossary_term' = 'IP Ownership Entity');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `ownership_entity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'IP Ownership Type');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'wholly_owned|joint_ownership|licensed_in|acquired');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `pegi_rating` SET TAGS ('dbx_business_glossary_term' = 'Pan European Game Information (PEGI) Rating');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `pegi_rating` SET TAGS ('dbx_value_regex' = 'PEGI_3|PEGI_7|PEGI_12|PEGI_16|PEGI_18|Not_Rated');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `platform_compatibility` SET TAGS ('dbx_business_glossary_term' = 'Platform Compatibility');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'IP Registration Date');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `registration_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'IP Registration Jurisdiction');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'IP Registration Number');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `sdk_version` SET TAGS ('dbx_business_glossary_term' = 'Software Development Kit (SDK) Version');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `standard_royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Standard Royalty Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `standard_royalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `territory_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Territory Restrictions');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `third_party_dependencies` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Dependencies');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `total_revenue_to_date` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue to Date');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `total_revenue_to_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `ugc_enabled` SET TAGS ('dbx_business_glossary_term' = 'User-Generated Content (UGC) Enabled');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `usk_rating` SET TAGS ('dbx_business_glossary_term' = 'Unterhaltungssoftware Selbstkontrolle (USK) Rating');
ALTER TABLE `gaming_ecm`.`licensing`.`licensed_ip` ALTER COLUMN `usk_rating` SET TAGS ('dbx_value_regex' = 'USK_0|USK_6|USK_12|USK_16|USK_18|Not_Rated');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `commercial_term_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Term Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `advance_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `advance_recoupment_terms` SET TAGS ('dbx_business_glossary_term' = 'Advance Recoupment Terms');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `audit_frequency_limit` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency Limit');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `audit_rights_clause` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Clause');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `derivative_works_rights` SET TAGS ('dbx_business_glossary_term' = 'Derivative Works Rights');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `derivative_works_rights` SET TAGS ('dbx_value_regex' = 'full_rights|limited_rights|no_rights|approval_required');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `exclusivity_window_months` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Window Months');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `indemnification_terms` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Terms');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `late_payment_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `marketing_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Approval Required Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `marketing_spend_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Marketing Spend Commitment Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `marketing_spend_commitment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `payment_due_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Days');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|milestone_based');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `performance_milestone_terms` SET TAGS ('dbx_business_glossary_term' = 'Performance Milestone Terms');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `platform_exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Platform Exclusivity Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `platform_exclusivity_list` SET TAGS ('dbx_business_glossary_term' = 'Platform Exclusivity List');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `quality_assurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Requirements');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `renewal_option_periods` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Periods');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `revenue_reporting_due_days` SET TAGS ('dbx_business_glossary_term' = 'Revenue Reporting Due Days');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `revenue_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Revenue Reporting Frequency');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `revenue_reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `royalty_basis` SET TAGS ('dbx_business_glossary_term' = 'Royalty Basis');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `royalty_basis` SET TAGS ('dbx_value_regex' = 'net_revenue|gross_revenue|units_sold|active_users|downloads');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `royalty_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `royalty_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `sublicensing_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Permitted Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `sublicensing_terms` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Terms');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `term_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Term Effective Date');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `term_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Term Expiration Date');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `term_status` SET TAGS ('dbx_business_glossary_term' = 'Term Status');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `term_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|terminated|expired|suspended');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `term_version_number` SET TAGS ('dbx_business_glossary_term' = 'Term Version Number');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `termination_cure_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Cure Period Days');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `termination_for_cause_conditions` SET TAGS ('dbx_business_glossary_term' = 'Termination for Cause Conditions');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `territory_expansion_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Territory Expansion Option Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `territory_expansion_terms` SET TAGS ('dbx_business_glossary_term' = 'Territory Expansion Terms');
ALTER TABLE `gaming_ecm`.`licensing`.`commercial_term` ALTER COLUMN `territory_list` SET TAGS ('dbx_business_glossary_term' = 'Territory List');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `royalty_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Schedule Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `superseded_by_schedule_royalty_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Schedule Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency in Months');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `base_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Base Royalty Rate Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `late_payment_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Rate Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `maximum_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Cap Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `maximum_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Royalty Schedule Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `payment_due_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Days');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `platform_deduction_rule` SET TAGS ('dbx_business_glossary_term' = 'Platform Deduction Rule');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `platform_deduction_rule` SET TAGS ('dbx_value_regex' = 'before_platform_fees|after_platform_fees|net_of_all_fees|gross_no_deductions');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Platform Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `rate_structure` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Structure');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `rate_structure` SET TAGS ('dbx_value_regex' = 'flat_rate|tiered|progressive|regressive|custom');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `recoupment_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Allowed Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `reporting_period_cadence` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Cadence');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `reporting_period_cadence` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|on_demand');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'accrual|cash|milestone|usage_based');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `royalty_basis` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation Basis');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `royalty_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Royalty Schedule Status');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `royalty_schedule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|superseded');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Royalty Schedule Name');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Schedule Type');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `tier_1_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Rate Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `tier_1_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier 1 Threshold');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `tier_2_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Rate Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `tier_2_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier 2 Threshold');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `tier_3_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Rate Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `tier_3_threshold` SET TAGS ('dbx_business_glossary_term' = 'Tier 3 Threshold');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Royalty Schedule Version Number');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_schedule` ALTER COLUMN `withholding_tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `royalty_report_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Report ID');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement ID');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `kpi_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Kpi Definition Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee ID');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `applicable_royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Applicable Royalty Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment URL');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `calculated_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Calculated Royalty Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `minimum_guarantee_credit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Credit');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `net_royalty_payable` SET TAGS ('dbx_business_glossary_term' = 'Net Royalty Payable');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|accepted|disputed|rejected|amended');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'quarterly|monthly|annual|ad_hoc|final');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `reported_deductions` SET TAGS ('dbx_business_glossary_term' = 'Reported Deductions');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `reported_gross_revenue` SET TAGS ('dbx_business_glossary_term' = 'Reported Gross Revenue');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `reported_net_revenue` SET TAGS ('dbx_business_glossary_term' = 'Reported Net Revenue');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `reported_unit_sales` SET TAGS ('dbx_business_glossary_term' = 'Reported Unit Sales');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `review_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completed Date');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'portal|email|api|manual|ftp|sftp');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_report` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `royalty_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment ID');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `iap_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Iap Transaction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Agreement ID');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Payee Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `royalty_report_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Report ID');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `bank_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Reference');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `bank_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `late_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `late_payment_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payee_identifier` SET TAGS ('dbx_business_glossary_term' = 'Payee Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payee_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_amount_reporting_currency` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount in Reporting Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_currency` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_direction` SET TAGS ('dbx_business_glossary_term' = 'Payment Direction');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|paypal|platform_payout|direct_deposit');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Period End Date');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Period Start Date');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_processor_fee` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Fee');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|cleared|failed|reversed|reconciled');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `reconciliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|matched|variance|disputed|resolved');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `reconciliation_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Variance Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`royalty_payment` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Game Server Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `audit_frequency_limit` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency Limit');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `authorized_distribution_channels` SET TAGS ('dbx_business_glossary_term' = 'Authorized Distribution Channels');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `authorized_platforms` SET TAGS ('dbx_business_glossary_term' = 'Authorized Platforms');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `compliance_audit_rights` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Rights Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `content_rating_requirements` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Requirements');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `covered_territories` SET TAGS ('dbx_business_glossary_term' = 'Covered Territories');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `drm_activation_limit` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Activation Limit');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `drm_offline_grace_period_hours` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Offline Grace Period Hours');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `drm_provider` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Provider');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `drm_provider` SET TAGS ('dbx_value_regex' = 'steamworks|epic_drm|denuvo|custom|none');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `engine_version_scope` SET TAGS ('dbx_business_glossary_term' = 'Engine Version Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `entitlement_number` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Number');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `entitlement_number` SET TAGS ('dbx_value_regex' = '^ENT-[A-Z0-9]{8,12}$');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Status');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `entitlement_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|revoked|pending_activation|terminated');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Type');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `entitlement_type` SET TAGS ('dbx_value_regex' = 'game_engine_sdk|ip_franchise|middleware|music_asset|art_asset|technology_patent');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `max_install_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Install Count');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `max_seat_count` SET TAGS ('dbx_business_glossary_term' = 'Maximum Seat Count');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `modification_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Modification Restrictions');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `modification_rights` SET TAGS ('dbx_business_glossary_term' = 'Modification Rights');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `modification_rights` SET TAGS ('dbx_value_regex' = 'full|limited|none');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `revenue_threshold_for_royalty` SET TAGS ('dbx_business_glossary_term' = 'Revenue Threshold for Royalty');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `revenue_threshold_for_royalty` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `royalty_applicable` SET TAGS ('dbx_business_glossary_term' = 'Royalty Applicable Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Royalty Calculation Method');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `royalty_calculation_method` SET TAGS ('dbx_value_regex' = 'revenue_share|per_unit|per_install|per_seat|fixed_fee|tiered');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `royalty_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `sublicensing_conditions` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Conditions');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `sublicensing_permitted` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Permitted Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `territory_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Territory Restrictions');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `trademark_usage_guidelines` SET TAGS ('dbx_business_glossary_term' = 'Trademark Usage Guidelines');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `trademark_usage_permitted` SET TAGS ('dbx_business_glossary_term' = 'Trademark Usage Permitted Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `usage_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Usage Reporting Frequency');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `usage_reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|on_demand');
ALTER TABLE `gaming_ecm`.`licensing`.`entitlement` ALTER COLUMN `usage_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Usage Reporting Required Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `middleware_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Middleware Agreement Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Owner Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Middleware Vendor Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|renewed');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `attribution_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Attribution Required Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `audit_rights` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `audit_rights` SET TAGS ('dbx_value_regex' = 'none|annual|on-request|quarterly');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `compliance_obligations` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligations');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `fixed_license_fee` SET TAGS ('dbx_business_glossary_term' = 'Fixed License Fee');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `fixed_license_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'per-title|per-seat|revenue-share|perpetual|subscription|enterprise');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'one-time|monthly|quarterly|annually|per-title|on-revenue');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `permitted_platforms` SET TAGS ('dbx_business_glossary_term' = 'Permitted Platforms');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `post_termination_rights` SET TAGS ('dbx_business_glossary_term' = 'Post-Termination Rights');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `redistribution_rights` SET TAGS ('dbx_business_glossary_term' = 'Redistribution Rights');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `redistribution_rights` SET TAGS ('dbx_value_regex' = 'none|embedded-only|limited|full');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `revenue_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Threshold Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `revenue_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `source_code_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Source Code Access Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `support_entitlement` SET TAGS ('dbx_business_glossary_term' = 'Support Entitlement');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `support_entitlement` SET TAGS ('dbx_value_regex' = 'none|basic|standard|premium|enterprise');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `termination_conditions` SET TAGS ('dbx_business_glossary_term' = 'Termination Conditions');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `update_entitlement` SET TAGS ('dbx_business_glossary_term' = 'Update Entitlement');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `update_entitlement` SET TAGS ('dbx_value_regex' = 'none|patches-only|minor-updates|major-updates|all-updates');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `usage_scope` SET TAGS ('dbx_business_glossary_term' = 'Usage Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`middleware_agreement` ALTER COLUMN `usage_scope` SET TAGS ('dbx_value_regex' = 'single-title|multi-title|studio-wide|enterprise-wide|platform-specific');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `music_sync_license_id` SET TAGS ('dbx_business_glossary_term' = 'Music Synchronization License ID');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `age_rating_cert_id` SET TAGS ('dbx_business_glossary_term' = 'Age Rating Cert Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement ID');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Holder ID');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `composer_name` SET TAGS ('dbx_business_glossary_term' = 'Composer Name');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `composition_rights_status` SET TAGS ('dbx_business_glossary_term' = 'Composition Rights Status');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `composition_rights_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|not_required|denied|conditional');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `content_rating_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Content Rating Restrictions');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `credit_attribution_required` SET TAGS ('dbx_business_glossary_term' = 'Credit Attribution Required');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `derivative_works_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Derivative Works Allowed Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `isrc_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Recording Code (ISRC)');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `isrc_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{3}[0-9]{7}$');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `iswc_code` SET TAGS ('dbx_business_glossary_term' = 'International Standard Musical Work Code (ISWC)');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `iswc_code` SET TAGS ('dbx_value_regex' = '^T-[0-9]{9}-[0-9]$');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `licensed_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Licensed Duration (Seconds)');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `master_recording_owner` SET TAGS ('dbx_business_glossary_term' = 'Master Recording Owner');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `master_recording_rights_status` SET TAGS ('dbx_business_glossary_term' = 'Master Recording Rights Status');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `master_recording_rights_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|not_required|denied|conditional');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `media_usage_rights` SET TAGS ('dbx_business_glossary_term' = 'Media Usage Rights');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'License Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|semi_annual|annual|per_milestone');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `per_unit_royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Unit Royalty Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `per_unit_royalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `platform_rights` SET TAGS ('dbx_business_glossary_term' = 'Platform Rights');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `pro_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Rights Organization (PRO) Clearance Status');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `pro_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|not_required|denied');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `pro_name` SET TAGS ('dbx_business_glossary_term' = 'Performance Rights Organization (PRO) Name');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `publisher_name` SET TAGS ('dbx_business_glossary_term' = 'Publisher Name');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `royalty_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Type');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `royalty_type` SET TAGS ('dbx_value_regex' = 'flat_fee|per_unit|per_stream|revenue_share|hybrid');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Allowed Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `sync_license_type` SET TAGS ('dbx_business_glossary_term' = 'Synchronization License Type');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `sync_license_type` SET TAGS ('dbx_value_regex' = 'perpetual|term_limited|project_specific|platform_specific|territory_specific|buyout');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `track_title` SET TAGS ('dbx_business_glossary_term' = 'Music Track Title');
ALTER TABLE `gaming_ecm`.`licensing`.`music_sync_license` ALTER COLUMN `usage_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Usage Restrictions');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `brand_partnership_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Partnership Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Agreement Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `approval_turnaround_days` SET TAGS ('dbx_business_glossary_term' = 'Approval Turnaround Days');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `approval_workflow_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Required Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|on_demand|none');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `brand_usage_guidelines_url` SET TAGS ('dbx_business_glossary_term' = 'Brand Usage Guidelines Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `brand_usage_guidelines_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `co_marketing_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Co-Marketing Obligation Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `co_marketing_requirements` SET TAGS ('dbx_business_glossary_term' = 'Co-Marketing Requirements');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `exclusivity_terms` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Terms');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `exclusivity_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `fixed_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Fee Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `fixed_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `game_title_scope` SET TAGS ('dbx_business_glossary_term' = 'Game Title Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `ip_ownership_terms` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership Terms');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `ip_ownership_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `licensed_brand_assets` SET TAGS ('dbx_business_glossary_term' = 'Licensed Brand Assets');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `partnership_name` SET TAGS ('dbx_business_glossary_term' = 'Partnership Name');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `partnership_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Status');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `partnership_type` SET TAGS ('dbx_business_glossary_term' = 'Partnership Type');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `partnership_type` SET TAGS ('dbx_value_regex' = 'character_license|franchise_license|sports_league|celebrity_likeness|music_rights|art_asset_license');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `performance_milestones` SET TAGS ('dbx_business_glossary_term' = 'Performance Milestones');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `performance_milestones` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Platform Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `rating_board_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Rating Board Restrictions');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `revenue_share_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Model');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `revenue_share_model` SET TAGS ('dbx_value_regex' = 'fixed_fee|percentage_royalty|hybrid|minimum_guarantee_plus_royalty');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `revenue_share_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `termination_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`brand_partnership` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `cdn_node_id` SET TAGS ('dbx_business_glossary_term' = 'Cdn Node Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Studio Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Agreement Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Game Title Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Platform Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Employee Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `primary_compliance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `primary_compliance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `primary_compliance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `audit_submission_requirement` SET TAGS ('dbx_business_glossary_term' = 'Audit Submission Requirement');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `content_restriction_clause` SET TAGS ('dbx_business_glossary_term' = 'Content Restriction Clause');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `data_handling_requirement` SET TAGS ('dbx_business_glossary_term' = 'Data Handling Requirement');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Requirement');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_business_glossary_term' = 'Escalation Contact');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `escalation_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `is_blocking_release` SET TAGS ('dbx_business_glossary_term' = 'Is Blocking Release Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `next_recurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recurrence Date');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Status');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `penalty_for_breach` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Breach');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `penalty_for_breach` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `platform_certification_requirement` SET TAGS ('dbx_business_glossary_term' = 'Platform Certification Requirement');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|annually|per_release|event_driven');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `supporting_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`licensing`.`compliance_obligation` ALTER COLUMN `supporting_documentation_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event ID');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `claimant_party_licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant Party ID');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Game Server Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `infrastructure_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Infrastructure Incident Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement ID');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Disputed Intellectual Property (IP) Asset ID');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee ID');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `respondent_party_licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Respondent Party ID');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `auditor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `auditor_type` SET TAGS ('dbx_business_glossary_term' = 'Auditor Type');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `auditor_type` SET TAGS ('dbx_value_regex' = 'internal|third_party|regulatory_body|legal_counsel');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Case Number');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `compliance_action_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Action Required');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `confidentiality_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Agreement Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `disputed_amount_currency` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `disputed_amount_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `event_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Event Completed Date');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `event_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Event Initiated Date');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Type');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Summary');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `findings_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `follow_up_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Date');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `follow_up_audit_scheduled_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Scheduled Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Legal Jurisdiction');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `legal_counsel_assigned` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Assigned');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `legal_counsel_assigned` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `litigation_flag` SET TAGS ('dbx_business_glossary_term' = 'Litigation Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `mediation_flag` SET TAGS ('dbx_business_glossary_term' = 'Mediation Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `settlement_terms_summary` SET TAGS ('dbx_business_glossary_term' = 'Settlement Terms Summary');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `settlement_terms_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Audit Trigger Reason');
ALTER TABLE `gaming_ecm`.`licensing`.`audit_event` ALTER COLUMN `trigger_reason` SET TAGS ('dbx_value_regex' = 'scheduled_periodic|for_cause|random_selection|third_party_complaint|internal_flag|regulatory_requirement');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `agreement_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Amendment Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Agreement Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|executed|rejected|superseded');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'rate_adjustment|territory_expansion|term_extension|scope_modification|royalty_change|termination_clause');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `approval_chain` SET TAGS ('dbx_business_glossary_term' = 'Approval Chain');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `compliance_impact` SET TAGS ('dbx_business_glossary_term' = 'Compliance Impact Level');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `compliance_impact` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `executed_by_licensee` SET TAGS ('dbx_business_glossary_term' = 'Executed By Licensee');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `executed_by_licensor` SET TAGS ('dbx_business_glossary_term' = 'Executed By Licensor');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Expiration Date');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `legal_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `legal_review_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `legal_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `new_minimum_guarantee` SET TAGS ('dbx_business_glossary_term' = 'New Minimum Guarantee Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `new_minimum_guarantee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `new_royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'New Royalty Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Amendment Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `scope_change_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Description');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `superseded_term_version` SET TAGS ('dbx_business_glossary_term' = 'Superseded Term Version');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `term_extension_months` SET TAGS ('dbx_business_glossary_term' = 'Term Extension Months');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `territory_added` SET TAGS ('dbx_business_glossary_term' = 'Territory Added');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `territory_removed` SET TAGS ('dbx_business_glossary_term' = 'Territory Removed');
ALTER TABLE `gaming_ecm`.`licensing`.`agreement_amendment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `usage_report_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Report ID');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `game_server_id` SET TAGS ('dbx_business_glossary_term' = 'Game Server Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement ID');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee ID');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `server_fleet_id` SET TAGS ('dbx_business_glossary_term' = 'Server Fleet Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Name');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `expected_value` SET TAGS ('dbx_business_glossary_term' = 'Expected Value');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `metric_type` SET TAGS ('dbx_business_glossary_term' = 'Metric Type');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `prior_period_value` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Value');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Usage Report Number');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `report_number` SET TAGS ('dbx_value_regex' = '^UR-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'engine_sdk|title_deployment|gaas_metrics|branded_asset|music_licensing|middleware_api');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `reported_value` SET TAGS ('dbx_business_glossary_term' = 'Reported Value');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `supporting_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation URL');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `supporting_documentation_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `territory` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `title_name` SET TAGS ('dbx_business_glossary_term' = 'Title Name');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `variance_flag` SET TAGS ('dbx_business_glossary_term' = 'Variance Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|variance_flagged|audit_required|approved');
ALTER TABLE `gaming_ecm`.`licensing`.`usage_report` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `rating_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Submission ID');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement ID');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Network Region Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Publisher Licensee Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `appeal_filed` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|modified|withdrawn');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `assigned_rating` SET TAGS ('dbx_business_glossary_term' = 'Assigned Rating');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `content_descriptors` SET TAGS ('dbx_business_glossary_term' = 'Content Descriptors');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `content_modifications_required` SET TAGS ('dbx_business_glossary_term' = 'Content Modifications Required');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `developer_name` SET TAGS ('dbx_business_glossary_term' = 'Developer Name');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `expected_release_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Release Date');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `interactive_elements` SET TAGS ('dbx_business_glossary_term' = 'Interactive Elements');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `ip_ownership_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership Confirmed');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `modification_compliance_date` SET TAGS ('dbx_business_glossary_term' = 'Modification Compliance Date');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `modification_description` SET TAGS ('dbx_business_glossary_term' = 'Modification Description');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|overdue|waived|refunded');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `platform` SET TAGS ('dbx_business_glossary_term' = 'Platform');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `rating_board` SET TAGS ('dbx_business_glossary_term' = 'Rating Board');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `rating_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Rating Certificate Number');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `rating_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Decision Date');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `rating_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Effective Date');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `rating_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rating Expiry Date');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submission_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Submission Fee Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submission_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Submission Fee Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submission_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'initial|re-rating|dlc|patch|update|appeal');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submitter_email` SET TAGS ('dbx_business_glossary_term' = 'Submitter Email');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submitter_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submitter_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submitter_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submitter_name` SET TAGS ('dbx_business_glossary_term' = 'Submitter Name');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submitter_phone` SET TAGS ('dbx_business_glossary_term' = 'Submitter Phone');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submitter_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `submitter_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `third_party_content_disclosed` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Content Disclosed');
ALTER TABLE `gaming_ecm`.`licensing`.`rating_submission` ALTER COLUMN `title_name` SET TAGS ('dbx_business_glossary_term' = 'Title Name');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `ip_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Dispute Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Disputed Intellectual Property (IP) Asset Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Legal Counsel Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant Party Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `actual_legal_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Legal Cost');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `actual_legal_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `alleged_violation_date` SET TAGS ('dbx_business_glossary_term' = 'Alleged Violation Date');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `claim_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `claimant_legal_counsel` SET TAGS ('dbx_business_glossary_term' = 'Claimant Legal Counsel');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `claimant_legal_counsel` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `claimant_name` SET TAGS ('dbx_business_glossary_term' = 'Claimant Name');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `claimant_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `dispute_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case Number');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|in_mediation|settled|litigated|dismissed|withdrawn');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_value_regex' = 'infringement_claim|royalty_underpayment|unauthorized_territory_use|unlicensed_derivative_work|trademark_violation|patent_infringement');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `disputed_ip_asset_name` SET TAGS ('dbx_business_glossary_term' = 'Disputed Intellectual Property (IP) Asset Name');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `document_repository_url` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `document_repository_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `estimated_legal_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Legal Cost');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `estimated_legal_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Filing Date');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Legal Jurisdiction');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `litigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Litigation Start Date');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `mediation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Mediation Start Date');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `precedent_flag` SET TAGS ('dbx_business_glossary_term' = 'Precedent Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Resolution Method');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `resolution_method` SET TAGS ('dbx_value_regex' = 'settlement|court_judgment|arbitration_award|mediation_agreement|withdrawal|dismissal');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `respondent_legal_counsel` SET TAGS ('dbx_business_glossary_term' = 'Respondent Legal Counsel');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `respondent_legal_counsel` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `respondent_name` SET TAGS ('dbx_business_glossary_term' = 'Respondent Name');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `respondent_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'financial|reputational|operational|strategic|regulatory');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Settlement Terms');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_dispute` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `sublicense_id` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Owner Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Parent License Agreement Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Intellectual Property (IP) Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `licensee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Licensee Identifier (ID)');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `parent_sublicense_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `compliance_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Required Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `fixed_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Fee Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `modification_rights` SET TAGS ('dbx_business_glossary_term' = 'Modification Rights');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `modification_rights` SET TAGS ('dbx_value_regex' = 'none|limited|full');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `pass_through_royalty_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pass-Through Royalty Rate Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|upon_milestone|one_time');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Platform Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `post_termination_obligations` SET TAGS ('dbx_business_glossary_term' = 'Post-Termination Obligations');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `rating_board_compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Rating Board Compliance Requirements');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|upon_request|none');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `revenue_share_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Model');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `revenue_share_model` SET TAGS ('dbx_value_regex' = 'pass_through|tiered|flat_fee|hybrid|none');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `source_code_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Source Code Access Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `sublicense_number` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Number');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `sublicense_status` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Status');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `sublicense_status` SET TAGS ('dbx_value_regex' = 'pending_approval|active|suspended|expired|terminated|revoked');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `sublicense_type` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Type');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `sublicense_type` SET TAGS ('dbx_value_regex' = 'sdk_access|contractor_rights|co_development|distribution|technology_transfer|middleware_pass_through');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `sublicensed_ip_scope` SET TAGS ('dbx_business_glossary_term' = 'Sublicensed Intellectual Property (IP) Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `sublicensee_royalty_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Sublicensee Royalty Rate Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `sublicensing_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Permitted Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `termination_conditions` SET TAGS ('dbx_business_glossary_term' = 'Termination Conditions');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `territory_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Territory Restrictions');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `territory_scope` SET TAGS ('dbx_business_glossary_term' = 'Territory Scope');
ALTER TABLE `gaming_ecm`.`licensing`.`sublicense` ALTER COLUMN `usage_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Usage Restrictions');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` SET TAGS ('dbx_subdomain' = 'monetization_operations');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `economy_config_id` SET TAGS ('dbx_business_glossary_term' = 'Economy Configuration ID');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Experiment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `game_studio_id` SET TAGS ('dbx_business_glossary_term' = 'Game Studio Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title ID');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `network_region_id` SET TAGS ('dbx_business_glossary_term' = 'Platform ID');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `title_season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `superseded_economy_config_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant Code');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{1,20}$');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `base_earn_rate_primary` SET TAGS ('dbx_business_glossary_term' = 'Base Earn Rate Primary Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `base_earn_rate_secondary` SET TAGS ('dbx_business_glossary_term' = 'Base Earn Rate Secondary Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `config_code` SET TAGS ('dbx_business_glossary_term' = 'Economy Configuration Code');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `config_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `config_name` SET TAGS ('dbx_business_glossary_term' = 'Economy Configuration Name');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `config_notes` SET TAGS ('dbx_business_glossary_term' = 'Configuration Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `config_status` SET TAGS ('dbx_business_glossary_term' = 'Economy Configuration Status');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `config_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|archived');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `config_version` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `config_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `conversion_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Currency Conversion Fee Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `currency_expiry_days` SET TAGS ('dbx_business_glossary_term' = 'Currency Expiry Days');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `currency_expiry_enabled` SET TAGS ('dbx_business_glossary_term' = 'Currency Expiry Enabled Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `daily_earn_cap_primary` SET TAGS ('dbx_business_glossary_term' = 'Daily Earn Cap Primary Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `daily_earn_cap_secondary` SET TAGS ('dbx_business_glossary_term' = 'Daily Earn Cap Secondary Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `deflation_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Deflation Threshold Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `economy_health_score_min` SET TAGS ('dbx_business_glossary_term' = 'Economy Health Score Minimum Threshold');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `economy_health_score_min` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `economy_health_score_min` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `economy_health_score_target` SET TAGS ('dbx_business_glossary_term' = 'Economy Health Score Target');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `economy_health_score_target` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `economy_health_score_target` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `exchange_rate_primary_to_secondary` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Primary to Secondary Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `exchange_rate_secondary_to_primary` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Secondary to Primary Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `inflation_control_enabled` SET TAGS ('dbx_business_glossary_term' = 'Inflation Control Enabled Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `inflation_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Inflation Threshold Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `max_balance_cap_primary` SET TAGS ('dbx_business_glossary_term' = 'Maximum Balance Cap Primary Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `max_balance_cap_secondary` SET TAGS ('dbx_business_glossary_term' = 'Maximum Balance Cap Secondary Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `primary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Virtual Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `primary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,10}$');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `real_money_to_primary_rate` SET TAGS ('dbx_business_glossary_term' = 'Real Money to Primary Currency Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `real_money_to_secondary_rate` SET TAGS ('dbx_business_glossary_term' = 'Real Money to Secondary Currency Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `secondary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Secondary Virtual Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `secondary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,10}$');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `sink_rate_target_primary` SET TAGS ('dbx_business_glossary_term' = 'Sink Rate Target Primary Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `sink_rate_target_secondary` SET TAGS ('dbx_business_glossary_term' = 'Sink Rate Target Secondary Currency');
ALTER TABLE `gaming_ecm`.`licensing`.`economy_config` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` SET TAGS ('dbx_subdomain' = 'monetization_operations');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `ab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Ab Experiment Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `content_release_id` SET TAGS ('dbx_business_glossary_term' = 'Content Drop Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `dlc_bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Featured Dlc Bundle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `live_ops_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Gaas Live Ops Cycle Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `game_title_id` SET TAGS ('dbx_business_glossary_term' = 'Game Title Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Licensed Ip Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `marketing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `localization_string_id` SET TAGS ('dbx_business_glossary_term' = 'Message Localization String Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `promotion_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `promotion_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `promotion_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `promotion_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `promotion_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `promotion_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `seasonal_event_id` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Event Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `title_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Target Sku Id (Foreign Key)');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `superseded_promotion_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `ab_test_variant` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `banner_image_url` SET TAGS ('dbx_business_glossary_term' = 'Banner Image Uniform Resource Locator (URL)');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `conversion_rate` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `discount_type` SET TAGS ('dbx_business_glossary_term' = 'Discount Type');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `discount_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|bonus_currency|bundle_price|tiered');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `discount_value` SET TAGS ('dbx_business_glossary_term' = 'Discount Value');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `display_priority` SET TAGS ('dbx_business_glossary_term' = 'Display Priority');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `max_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Discount Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `min_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Promotion Notes');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `platform_availability` SET TAGS ('dbx_business_glossary_term' = 'Platform Availability');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `promotion_code` SET TAGS ('dbx_business_glossary_term' = 'Promotion Code');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `promotion_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `promotion_name` SET TAGS ('dbx_business_glossary_term' = 'Promotion Name');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_business_glossary_term' = 'Promotion Status');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `promotion_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|paused|completed|cancelled');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_business_glossary_term' = 'Promotion Type');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `promotion_type` SET TAGS ('dbx_value_regex' = 'flash_sale|bundle_discount|first_purchase_bonus|seasonal_event|limited_time_offer|weekend_special');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `redemption_limit_per_player` SET TAGS ('dbx_business_glossary_term' = 'Redemption Limit Per Player');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `requires_first_purchase` SET TAGS ('dbx_business_glossary_term' = 'Requires First Purchase Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `stackable_with_other_promos` SET TAGS ('dbx_business_glossary_term' = 'Stackable With Other Promotions Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Promotion Start Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `target_player_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Player Segment');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `total_discount_given` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Given');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `total_impressions` SET TAGS ('dbx_business_glossary_term' = 'Total Impressions');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `total_redemption_cap` SET TAGS ('dbx_business_glossary_term' = 'Total Redemption Cap');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `total_redemptions` SET TAGS ('dbx_business_glossary_term' = 'Total Redemptions');
ALTER TABLE `gaming_ecm`.`licensing`.`promotion` ALTER COLUMN `total_revenue_generated` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Generated');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` SET TAGS ('dbx_subdomain' = 'monetization_operations');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` SET TAGS ('dbx_association_edges' = 'monetization.mtx_catalog,monetization.offer_campaign');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `catalog_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Offer ID');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee ID');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `mtx_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Offer - Mtx Catalog Id');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `offer_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Offer - Offer Campaign Id');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `ab_test_variant_assignment` SET TAGS ('dbx_business_glossary_term' = 'A/B Test Variant Assignment');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `added_to_campaign_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Added to Campaign Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `campaign_specific_discount_value` SET TAGS ('dbx_business_glossary_term' = 'Campaign Specific Discount Value');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `conversion_rate_for_item` SET TAGS ('dbx_business_glossary_term' = 'Conversion Rate');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `display_priority_in_campaign` SET TAGS ('dbx_business_glossary_term' = 'Display Priority');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `impression_count_for_item` SET TAGS ('dbx_business_glossary_term' = 'Impression Count');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `is_featured_item` SET TAGS ('dbx_business_glossary_term' = 'Featured Item Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `redemption_count_for_item` SET TAGS ('dbx_business_glossary_term' = 'Redemption Count');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `removed_from_campaign_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Removed from Campaign Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_offer` ALTER COLUMN `revenue_generated_for_item` SET TAGS ('dbx_business_glossary_term' = 'Revenue Generated');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` SET TAGS ('dbx_subdomain' = 'rights_management');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` SET TAGS ('dbx_association_edges' = 'licensing.licensed_ip,compliance.regulatory_obligation');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `ip_compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'IP Compliance Obligation ID');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `licensed_ip_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Compliance Obligation - Licensed Ip Id');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Compliance Obligation - Regulatory Obligation Id');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `audit_findings` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `compliance_owner` SET TAGS ('dbx_business_glossary_term' = 'Compliance Owner');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `exemption_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Exemption Expiration Date');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `exemption_granted` SET TAGS ('dbx_business_glossary_term' = 'Exemption Granted');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `implementation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Implementation Deadline');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `remediation_plan_url` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan URL');
ALTER TABLE `gaming_ecm`.`licensing`.`ip_compliance_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` SET TAGS ('dbx_subdomain' = 'monetization_operations');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` SET TAGS ('dbx_association_edges' = 'monetization.mtx_catalog,monetization.promotion');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` ALTER COLUMN `catalog_promotion_eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Promotion Eligibility ID');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` ALTER COLUMN `mtx_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Promotion Eligibility - Mtx Catalog Id');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Promotion Eligibility - Promotion Id');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` ALTER COLUMN `added_to_promotion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Added to Promotion Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` ALTER COLUMN `display_order_in_promotion` SET TAGS ('dbx_business_glossary_term' = 'Display Order in Promotion');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` ALTER COLUMN `effective_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Effective Discount Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` ALTER COLUMN `eligible_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Eligible Stock Keeping Unit (SKU) List');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` ALTER COLUMN `featured_flag` SET TAGS ('dbx_business_glossary_term' = 'Featured Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` ALTER COLUMN `item_specific_redemption_count` SET TAGS ('dbx_business_glossary_term' = 'Item-Specific Redemption Count');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` ALTER COLUMN `item_specific_revenue_generated` SET TAGS ('dbx_business_glossary_term' = 'Item-Specific Revenue Generated');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` ALTER COLUMN `promotion_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Promotion Priority Rank');
ALTER TABLE `gaming_ecm`.`licensing`.`catalog_promotion_eligibility` ALTER COLUMN `removed_from_promotion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Removed from Promotion Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` SET TAGS ('dbx_subdomain' = 'monetization_operations');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` SET TAGS ('dbx_association_edges' = 'monetization.mtx_catalog,esports.esports_team');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `team_brand_license_id` SET TAGS ('dbx_business_glossary_term' = 'Team Brand License Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `mtx_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Team Brand License - Mtx Catalog Id');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Brand License - Esports Team Id');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `contract_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Identifier');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `contract_reference_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `licensing_end_date` SET TAGS ('dbx_business_glossary_term' = 'Licensing End Date');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `licensing_start_date` SET TAGS ('dbx_business_glossary_term' = 'Licensing Start Date');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `revenue_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Amount');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `revenue_share_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `royalty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Royalty Percentage');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `royalty_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `gaming_ecm`.`licensing`.`team_brand_license` ALTER COLUMN `sales_count` SET TAGS ('dbx_business_glossary_term' = 'Sales Count');
