-- Schema for Domain: billing | Business: Telecommunication | Version: v1_ecm
-- Generated on: 2026-05-08 05:07:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `telecommunication_ecm`.`billing` COMMENT 'SSOT for all customer financial transactions including rating, charging, invoicing, collections, payment processing, prepaid balance management, postpaid billing cycles, disputes, adjustments, dunning, MRR/ARPU reporting, and revenue recognition. Managed via Amdocs Revenue Management and Comverse ONE.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`billing_account` (
    `billing_account_id` BIGINT COMMENT 'Unique surrogate identifier for the billing account record in the Amdocs Revenue Management system. Serves as the primary key and financial anchor for all monetary transactions, invoices, payments, and collections associated with this account.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer (party) who owns this billing account. One customer may have multiple billing accounts to support split billing arrangements across different service lines or business units.',
    `customer_address_id` BIGINT COMMENT 'Reference to the postal address record used for paper invoice delivery and tax jurisdiction determination. Drives state and local tax calculation based on service address rules.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Enterprise/B2B billing accounts are assigned account managers for relationship management, escalation routing, and commission tracking. Standard telco practice for high-value accounts. No existing col',
    `parent_account_billing_account_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent billing account in a hierarchical account structure. Used for enterprise split billing where a master account consolidates charges from multiple child accounts. Null for standalone accounts.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: MVNO and wholesale customers have billing accounts managed by host operator. Required for MVNO billing, wholesale invoicing, partner revenue tracking, and settlement reconciliation in telecommunicatio',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Accounts are assigned to service territories for sales team management, regional revenue reporting, franchise fee calculation, and regulatory jurisdiction determination. Standard telco ops practice fo',
    `account_name` STRING COMMENT 'Descriptive name assigned to the billing account, typically the customer legal name or a business unit label for corporate accounts. Displayed on invoices and used in collections correspondence.',
    `account_number` STRING COMMENT 'Externally visible, human-readable account number assigned by Amdocs Revenue Management and printed on invoices and statements. Used by customers and agents to reference the account in all billing interactions.. Valid values are `^[A-Z0-9]{8,20}$`',
    `account_status` STRING COMMENT 'Current lifecycle state of the billing account as managed in Amdocs Revenue Management. Controls whether new charges can be applied, invoices generated, and services provisioned. [ENUM-REF-CANDIDATE: active|suspended|closed|pending|delinquent|write_off — promote to reference product]. Valid values are `active|suspended|closed|pending|delinquent|write_off`',
    `account_type` STRING COMMENT 'Classification of the billing account by customer segment. Drives applicable rate plans, credit policies, dunning rules, and regulatory treatment. [ENUM-REF-CANDIDATE: residential|small_business|enterprise|wholesale|mvno|government — promote to reference product]. Valid values are `residential|small_business|enterprise|wholesale|mvno|government`',
    `arpu_segment_code` STRING COMMENT 'Segment classification of the billing account based on Average Revenue Per User (ARPU) banding (e.g., HIGH_VALUE, MID_VALUE, LOW_VALUE). Used for targeted retention campaigns, churn management, and revenue analytics.',
    `auto_pay_enabled` BOOLEAN COMMENT 'Indicates whether automatic payment is configured for this billing account. When true, the system initiates payment collection on the due date using the stored payment instrument without manual customer action.',
    `bill_delivery_method` STRING COMMENT 'Preferred channel through which invoices are delivered to the customer. Drives the bill production and distribution workflow in Amdocs Revenue Management. Suppressed is used for internal or wholesale accounts billed via EDI.. Valid values are `paper|ebill|app|email|suppressed`',
    `bill_language_code` STRING COMMENT 'IETF BCP 47 language tag specifying the language in which invoices and billing communications are generated for this account (e.g., en-US, es-MX, fr-CA). Supports multilingual billing for diverse customer bases.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `billing_cycle_code` STRING COMMENT 'Code identifying the billing cycle assigned to this account in Amdocs Revenue Management (e.g., MONTHLY-01, MONTHLY-15, QUARTERLY). Determines the invoice generation schedule and the period over which charges are accumulated.',
    `consolidated_billing` BOOLEAN COMMENT 'Indicates whether this billing account is configured to receive a consolidated invoice aggregating charges from multiple sub-accounts or service lines. Common for enterprise customers with split billing arrangements.',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA cost center code associated with this billing account for internal financial allocation and OPEX/CAPEX reporting. Relevant for enterprise and wholesale accounts where charges are allocated to specific business units.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing account record was first created in Amdocs Revenue Management. Used for account age calculations, onboarding analytics, and audit trail compliance.',
    `credit_class_code` STRING COMMENT 'Credit risk classification assigned to the billing account by the credit management system (e.g., GOLD, SILVER, BRONZE, HIGH_RISK). Drives credit limit assignment, deposit requirements, and dunning profile selection in Amdocs Revenue Management.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding balance permitted on this billing account before service suspension is triggered. Set based on credit class and customer risk profile. Monitored in real time by Amdocs Revenue Management.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all charges, invoices, and payments on this billing account are denominated (e.g., USD, EUR, GBP). Critical for multi-currency billing in international operations.. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'Outstanding monetary balance on the billing account as of the last billing run or payment posting. Positive value indicates amount owed by the customer; negative value indicates a credit balance. Used for collections prioritization and MRR reporting.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Monetary deposit held by the carrier against this billing account as a credit risk mitigation measure. Applied to high-risk credit classes. Refundable upon account closure in good standing per FCC deposit rules.',
    `deposit_date` DATE COMMENT 'Date on which the security deposit was collected from the customer. Used to calculate deposit holding period and determine refund eligibility under FCC regulations.',
    `dispute_in_progress` BOOLEAN COMMENT 'Indicates whether there is an active billing dispute on this account. When true, dunning escalation may be paused per dispute resolution policy. Linked to the dispute management workflow in Amdocs Revenue Management.',
    `dunning_profile_code` STRING COMMENT 'Code referencing the dunning workflow profile assigned to this billing account in Amdocs Revenue Management. Defines the sequence, timing, and escalation steps (reminder, warning, suspension, collections referral) applied when payment is overdue.',
    `dunning_status` STRING COMMENT 'Current step in the dunning escalation workflow for this billing account. Tracks the collections lifecycle from initial reminder through suspension and potential write-off. Updated by Amdocs Revenue Management collections engine.. Valid values are `none|reminder_sent|warning_sent|suspended|collections|write_off`',
    `effective_from_date` DATE COMMENT 'Date on which the billing account became active and eligible to receive charges. Marks the start of the billing relationship and is used for revenue recognition and contract term calculations.',
    `effective_until_date` DATE COMMENT 'Date on which the billing account is scheduled to close or was closed. Null for open-ended accounts. Used for contract expiry tracking, churn analysis, and revenue recognition cutoff.',
    `gl_account_code` STRING COMMENT 'General Ledger (GL) account code in SAP S/4HANA to which revenue and receivables from this billing account are posted. Ensures accurate financial reporting and audit trail between the BSS billing system and the ERP.',
    `hierarchy_level` STRING COMMENT 'Numeric level of this billing account within the enterprise account hierarchy (1 = top-level master account, 2 = sub-account, 3 = sub-sub-account). Supports multi-tier corporate billing structures.',
    `invoice_format_code` STRING COMMENT 'Specifies the invoice presentation format assigned to this billing account. Itemized includes per-call detail; summary shows charge categories only; consolidated merges multiple sub-accounts into a single invoice.. Valid values are `standard|itemized|summary|consolidated`',
    `last_invoice_date` DATE COMMENT 'Date on which the most recent invoice was generated for this billing account. Used to track billing cycle adherence, identify accounts that have not been billed, and support collections workflows.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the billing account record in Amdocs Revenue Management. Used for change data capture (CDC), data lineage tracking, and audit compliance in the Silver layer.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Monetary value of the most recent payment posted to this billing account. Used alongside last_payment_date to assess partial vs. full payment behavior and inform collections strategy.',
    `last_payment_date` DATE COMMENT 'Date on which the most recent payment was posted to this billing account. Used by collections agents to assess payment recency, calculate days since last payment, and prioritize dunning actions.',
    `mrr_amount` DECIMAL(18,2) COMMENT 'The contracted Monthly Recurring Revenue (MRR) value of this billing account, representing the predictable monthly charge for subscribed services excluding one-time and usage-based charges. Used for revenue forecasting and EBITDA reporting.',
    `overdue_amount` DECIMAL(18,2) COMMENT 'Total monetary amount past the payment due date on this billing account. Drives dunning escalation, credit limit monitoring, and collections referral decisions in Amdocs Revenue Management.',
    `payment_method` STRING COMMENT 'Instrument used to settle invoices on this billing account. Determines auto-pay eligibility and dunning escalation paths. [ENUM-REF-CANDIDATE: auto_pay_card|auto_pay_ach|manual_card|manual_ach|check|wire|cash|voucher — promote to reference product]',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due (e.g., 14, 21, 30). Governs the due date calculation on each invoice and triggers dunning escalation if payment is not received within this window.',
    `prepaid_postpaid_indicator` STRING COMMENT 'Indicates whether this billing account operates on a prepaid (advance payment, Comverse ONE), postpaid (invoice-based, Amdocs Revenue Management), or hybrid charging model. Determines the rating engine and balance management system used.. Valid values are `prepaid|postpaid|hybrid`',
    `revenue_recognition_code` STRING COMMENT 'Code identifying the revenue recognition treatment applied to charges on this billing account per IFRS 15 / ASC 606 (e.g., STRAIGHT_LINE, USAGE_BASED, MILESTONE). Used by the finance team for accurate revenue reporting in SAP S/4HANA.',
    `sales_channel_code` STRING COMMENT 'Channel through which the billing account was originally acquired. Used for ARPU and revenue attribution analysis by channel, commission calculations, and churn analysis by acquisition source. [ENUM-REF-CANDIDATE: direct|retail|online|dealer|telesales|mvno|wholesale — 7 candidates stripped; promote to reference product]',
    `source_system_code` STRING COMMENT 'Identifier of the originating operational system from which this billing account record was sourced (e.g., AMDOCS_RM, COMVERSE_ONE). Supports data lineage, reconciliation, and multi-system integration in the Databricks Silver layer.',
    `spend_limit` DECIMAL(18,2) COMMENT 'Maximum total spend threshold configured on this billing account for real-time usage control. When the accumulated charges approach this limit, alerts are triggered or services are throttled. Distinct from credit_limit which governs outstanding balance.',
    `tax_exempt` BOOLEAN COMMENT 'Indicates whether this billing account is exempt from applicable taxes (e.g., government entities, non-profit organizations). When true, the rating and invoicing engine suppresses tax calculation for charges on this account.',
    `tax_exemption_certificate` STRING COMMENT 'Reference number of the tax exemption certificate provided by the customer. Required for audit and regulatory compliance when tax_exempt is true. Stored for verification by the finance and compliance teams.',
    CONSTRAINT pk_billing_account PRIMARY KEY(`billing_account_id`)
) COMMENT 'Master record for a customers billing account serving as the financial anchor for all monetary transactions. Captures billing cycle assignment, payment terms, credit class, bill delivery preferences (paper/eBill/app), currency, tax exemption status, dunning profile rules, account-level credit limit, auto-pay configuration, and account status (active, suspended, closed). Links subscriber identity to charges, invoices, payments, and collections. One customer may have multiple billing accounts (split billing). Sourced from Amdocs Revenue Management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique surrogate identifier for the invoice record in the billing system. Primary key for the invoice data product in the Databricks Silver Layer.',
    `billing_cycle_id` BIGINT COMMENT 'Reference to the billing cycle period during which this invoice was generated. Determines the charge period start and end dates for postpaid billing.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise invoices must link directly to corporate legal entities for consolidated billing reports, multi-site GL reconciliation, contract compliance auditing, and tax jurisdiction determination. B2B',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer who is the recipient of this invoice. Supports customer-level billing analytics and ARPU (Average Revenue Per User) reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Manual invoices, corrections, and off-cycle bills require audit trail of generating employee for dispute resolution and regulatory compliance. Critical for billing operations accountability and SOX co',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Partner-related invoices (wholesale, MVNO, roaming settlements) must track originating partner. Required for partner invoicing, revenue share calculation, settlement reconciliation, and partner accoun',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Invoice generation pipelines must be traceable for SOX compliance, revenue assurance audits, and data lineage requirements. Enables root cause analysis when invoice discrepancies occur and supports re',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Invoices inherit territory assignment for regional revenue recognition, tax jurisdiction determination, regulatory reporting by geography, and franchise authority compliance. Essential for state/local',
    `adjustments_amount` DECIMAL(18,2) COMMENT 'Net total of all billing adjustments, credits, and discounts applied to the invoice. Can be negative (credit to customer) or positive (additional charge). Includes dispute resolutions, goodwill credits, and promotional adjustments.',
    `bill_date` DATE COMMENT 'The date on which the invoice was generated and issued to the customer. Represents the principal business event timestamp for the invoice. Used as the reference date for payment due date calculation and revenue recognition.',
    `bill_format` STRING COMMENT 'The level of detail included in the customer-facing billing statement. Detailed includes full CDR (Call Detail Record) itemization; Summary shows charge categories only; Itemized shows line-item charges without full CDR detail.. Valid values are `detailed|summary|itemized`',
    `bill_language_code` STRING COMMENT 'ISO 639-1 language code specifying the language in which the invoice is rendered for the customer (e.g., en, es, fr, zh-CN). Supports multilingual billing for diverse customer bases and regulatory language requirements.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `billing_period_end_date` DATE COMMENT 'The last day of the billing cycle period covered by this invoice. Defines the end boundary for all charges, usage, and credits included in the invoice.',
    `billing_period_start_date` DATE COMMENT 'The first day of the billing cycle period covered by this invoice. Defines the start boundary for all charges, usage, and credits included in the invoice.',
    `billing_segment` STRING COMMENT 'Customer segment classification for this invoice, used for segmented revenue reporting, ARPU (Average Revenue Per User) analysis, and MRR (Monthly Recurring Revenue) tracking. MVNO (Mobile Virtual Network Operator) segment covers reseller billing.. Valid values are `consumer|small_business|enterprise|wholesale|mvno|government`',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA cost center code associated with the business unit responsible for this invoice. Used for internal financial reporting, OPEX (Operational Expenditure) allocation, and profitability analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the billing system (Amdocs Revenue Management). Represents the audit creation time for data lineage and compliance purposes. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary amounts on this invoice are denominated (e.g., USD, EUR, GBP). Supports multi-currency billing for international and roaming customers.. Valid values are `^[A-Z]{3}$`',
    `current_charges_amount` DECIMAL(18,2) COMMENT 'Total of all new charges incurred during the current billing period before taxes and fees. Includes recurring subscription charges, usage charges, and one-time charges rated by Amdocs Revenue Management.',
    `delivery_channel` STRING COMMENT 'The channel through which the invoice is delivered to the customer. Drives the bill presentment workflow in Amdocs Revenue Management. Email: electronic PDF delivery; Paper: physical mail; Portal: self-service web/app; SMS: summary notification; API: machine-to-machine for enterprise customers.. Valid values are `email|paper|portal|sms|api`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The portion of the total invoice amount that is under active dispute by the customer. May be less than or equal to total_amount_due. Used for revenue assurance reporting and collections hold management.',
    `due_date` DATE COMMENT 'The date by which the customer must settle the invoice to avoid late payment charges or dunning actions. Calculated from bill_date plus the payment terms defined on the billing account.',
    `dunning_level` STRING COMMENT 'Current dunning escalation level for overdue invoices, ranging from 0 (not in dunning) to the maximum configured dunning step. Drives automated collections actions in Amdocs Revenue Management including reminder notices, service suspension warnings, and write-off triggers.',
    `dunning_status` STRING COMMENT 'Current state of the collections/dunning process for this invoice. Tracks the progression of overdue invoice handling from initial reminder through potential write-off. Managed by Amdocs Revenue Management collections module.. Valid values are `not_in_dunning|reminder_sent|warning_issued|suspended|collections|written_off`',
    `fees_amount` DECIMAL(18,2) COMMENT 'Total regulatory fees, administrative fees, and surcharges applied to the invoice that are distinct from taxes. Includes items such as regulatory recovery fees, network access fees, and late payment fees.',
    `gl_account_code` STRING COMMENT 'The General Ledger (GL) account code to which this invoices revenue is posted in SAP S/4HANA Finance. Enables financial reporting, revenue assurance reconciliation, and audit trail between billing and accounting systems.',
    `invoice_number` STRING COMMENT 'Externally-visible, human-readable invoice reference number issued to the customer. Printed on the billing statement and used for customer service inquiries and payment references. Sourced from Amdocs Revenue Management invoicing module.. Valid values are `^INV-[0-9]{10}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle state of the invoice. Drives collections workflows, dunning processes, and revenue recognition in Amdocs Revenue Management. Valid states: draft (being prepared), issued (sent to customer), paid (fully settled), disputed (customer raised dispute), written_off (deemed uncollectable), cancelled (voided before issuance).. Valid values are `draft|issued|paid|disputed|written_off|cancelled`',
    `invoice_type` STRING COMMENT 'Classification of the invoice by its business purpose. Standard: regular periodic billing; Final: issued upon account closure; Interim: mid-cycle billing; Credit Note: net credit to customer; Debit Note: additional charge; Pro Forma: estimate before final billing.. Valid values are `standard|final|interim|credit_note|debit_note|pro_forma`',
    `is_disputed` BOOLEAN COMMENT 'Indicates whether this invoice is currently under a customer billing dispute. True when a dispute has been raised and is pending resolution. Used to flag invoices for collections hold and dispute management workflows.',
    `is_paperless` BOOLEAN COMMENT 'Indicates whether the customer has opted into paperless billing for this invoice. True when delivery_channel is email or portal. Used for sustainability reporting and paper bill fee waiver logic.',
    `issued_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the invoice was dispatched to the customer via the configured delivery channel. Distinct from bill_date (the billing date) and created_timestamp (record creation). Used for SLA (Service Level Agreement) compliance on bill delivery timeliness.',
    `late_payment_fee` DECIMAL(18,2) COMMENT 'Fee assessed on this invoice for late payment of a prior invoice, per the terms and conditions of the customers service agreement. Included in fees_amount but tracked separately for fee revenue reporting and customer dispute management.',
    `notes` STRING COMMENT 'Free-text notes or remarks associated with the invoice, entered by billing operations staff. May include reasons for manual adjustments, special billing arrangements, or customer communication notes. Not displayed on the customer-facing bill.',
    `outstanding_amount` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on this invoice, calculated as total_amount_due minus paid_amount. Used for accounts receivable aging, collections prioritization, and MRR (Monthly Recurring Revenue) reporting.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Total amount paid by the customer against this specific invoice to date. Used to calculate the outstanding balance and determine if the invoice is fully or partially settled.',
    `paid_timestamp` TIMESTAMP COMMENT 'The timestamp when the invoice was fully settled and transitioned to paid status. Null for unpaid or partially paid invoices. Used for days-sales-outstanding (DSO) calculation and payment behavior analytics.',
    `paper_bill_fee` DECIMAL(18,2) COMMENT 'Fee charged to the customer for receiving a paper invoice by mail, where applicable. Zero or null for customers enrolled in paperless billing. Supports paperless billing adoption tracking and fee revenue reporting.',
    `payment_method` STRING COMMENT 'The payment instrument or method associated with this invoice for settlement. Auto_pay: automatic charge to stored payment method; Direct_debit: bank pull; Credit_card: card charge; Bank_transfer: wire/ACH; Cash: in-store payment. Drives collections and dunning strategy.. Valid values are `auto_pay|manual|direct_debit|credit_card|bank_transfer|cash`',
    `payment_terms_days` STRING COMMENT 'Number of days from the bill_date within which payment is due, as defined by the customers billing account payment terms (e.g., 14, 21, 30 days). Used to calculate due_date and trigger dunning workflows.',
    `payments_received_amount` DECIMAL(18,2) COMMENT 'Total payments and credits received from the customer since the last invoice, applied against the previous balance. Reduces the amount owed on the current statement.',
    `previous_balance_amount` DECIMAL(18,2) COMMENT 'Outstanding balance carried forward from the prior billing cycle before any new charges or payments are applied. Represents the opening balance on the current invoice statement.',
    `revenue_recognition_date` DATE COMMENT 'The accounting date on which revenue from this invoice is recognized in the general ledger per IFRS 15 / ASC 606 revenue recognition standards. May differ from bill_date for deferred or advance billing scenarios.',
    `source_invoice_ref` STRING COMMENT 'The native invoice identifier from the originating source system (Amdocs or Comverse ONE) before transformation into the enterprise data lakehouse. Enables traceability and reconciliation between the Silver Layer and the operational billing system.',
    `source_system` STRING COMMENT 'The operational system of record that generated this invoice. Amdocs Revenue Management for postpaid billing; Comverse ONE for prepaid balance settlement invoices; Manual for adjustments entered directly by billing operations teams.. Valid values are `amdocs|comverse_one|manual`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charges applied to the invoice including all applicable federal, state, local, and regulatory taxes and surcharges (e.g., USF, E911, sales tax). Calculated by the tax engine within Amdocs Revenue Management.',
    `tax_exempt` BOOLEAN COMMENT 'Indicates whether the customer account is exempt from standard tax charges on this invoice. True for government entities, non-profit organizations, or customers with valid tax exemption certificates on file.',
    `tax_exemption_certificate` STRING COMMENT 'The reference number of the tax exemption certificate on file for the customer, when tax_exempt is True. Required for audit compliance and tax authority reporting.',
    `total_amount_due` DECIMAL(18,2) COMMENT 'The net total amount the customer must pay, calculated as previous_balance_amount minus payments_received_amount plus current_charges_amount plus adjustments_amount plus tax_amount plus fees_amount. This is the authoritative amount printed on the customer-facing billing statement.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last modified in the source billing system. Tracks the most recent update for change data capture (CDC) processing in the Databricks Silver Layer pipeline. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Periodic billing document issued to a customer summarizing all charges, credits, taxes, and fees for a billing cycle. Captures invoice number, bill date, due date, total amount due, previous balance, payments received, current charges, tax breakdown, bill format, delivery channel, and invoice status (draft, issued, paid, disputed, written-off). SSOT for all customer-facing billing statements. Sourced from Amdocs Revenue Management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual invoice line item within the Amdocs Revenue Management system. Serves as the primary key for the invoice_line data product in the Databricks Silver Layer.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Invoice lines for addon charges must reference the addon product for addon revenue reporting, attach rate analysis, addon profitability tracking, and product portfolio optimization.',
    `billing_dispute_id` BIGINT COMMENT 'Reference to an active or resolved billing dispute record associated with this invoice line item. Populated when a customer has raised a dispute against this specific charge. Enables dispute-to-line traceability for collections and customer service operations.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Invoice lines must reference the catalog item being billed for revenue recognition by product, regulatory reporting, margin analysis, and product performance dashboards. Essential for commercial produ',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this invoice line. Enables customer-level billing analytics, ARPU calculation, and dispute resolution traceability.',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: Wholesale customers are billed for fiber lease by cable segment. Required for wholesale fiber lease billing, dark fiber revenue recognition, and infrastructure monetization.',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Invoice lines for equipment rental, installation fees, damage charges, or replacement fees must reference the specific CPE asset (modem, router, set-top box). Required for itemized equipment billing a',
    `spectrum_allocation_id` BIGINT COMMENT 'Foreign key linking to inventory.spectrum_allocation. Business justification: For wholesale spectrum sharing, invoice lines must reference the spectrum allocation. Required for spectrum sharing revenue billing, MVNO billing, and infrastructure sharing agreements.',
    `invoice_id` BIGINT COMMENT 'Reference to the parent invoice header to which this line item belongs. Establishes the header-detail relationship between the invoice and its constituent charge or credit lines.',
    `iptv_channel_id` BIGINT COMMENT 'Foreign key linking to content.iptv_channel. Business justification: Pay-per-view channel charges billed as individual line items. Necessary for PPV event billing, channel revenue tracking, and reconciliation with content licensing agreements in telco operations.',
    `msisdn_range_id` BIGINT COMMENT 'Foreign key linking to inventory.msisdn_range. Business justification: Number porting fees, premium number charges, or vanity number fees must reference the MSISDN range. Required for number-related billing, regulatory fee allocation, and premium number revenue tracking.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Invoice lines should reference the offering sold (commercial package) for sales performance tracking, commission calculation, offer-level revenue reporting, and promotional campaign effectiveness anal',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: Fiber service invoice lines for ONT installation, rental, or equipment charges must reference the specific ONT. Required for fiber equipment billing, asset tracking, and customer service reconciliatio',
    `original_line_invoice_line_id` BIGINT COMMENT 'Reference to the original invoice line item that this adjustment, credit, or reversal line corrects or offsets. Populated only for adjustment and reversal lines to maintain the audit chain between original charges and their corrections. Enables complete billing history reconstruction.',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Monthly recurring charges for content packages (HBO, sports bundles) appear as invoice lines. Required for subscription billing, revenue allocation, and package performance analysis in telecommunicati',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Individual line items may be partner-specific (roaming charges, wholesale usage). Required for detailed partner revenue attribution, line-level dispute resolution, and granular settlement reconciliati',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Line-level rating and charging pipelines require traceability for dispute resolution, re-rating scenarios, and usage validation. Critical for identifying which ETL run produced specific charges when c',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Invoice line detail is required for tariff compliance filings and universal service fund (USF) contribution calculations. Real business process: USF reporting requires service-type revenue breakdowns ',
    `spec_id` BIGINT COMMENT 'Reference to the product or service catalog item that generated this charge or credit line. Links to the Netcracker Product Catalog to identify the specific product offering (e.g., 5G NR data plan, VoLTE bundle, FTTH broadband).',
    `subscriber_id` BIGINT COMMENT 'Reference to the specific service subscription or agreement that originated this charge. Links to the customers active service contract for wireless, broadband, IPTV, or other telecom services.',
    `tap_record_id` BIGINT COMMENT 'Foreign key linking to interconnect.tap_record. Business justification: Retail invoice lines for roaming services must trace to originating TAP records for customer dispute investigation and retail-to-wholesale charge reconciliation—required for proving charge validity to',
    `vod_asset_id` BIGINT COMMENT 'Foreign key linking to content.vod_asset. Business justification: VOD rentals and purchases generate invoice line items with asset-specific charges. Essential for VOD revenue recognition, dispute resolution, and content performance reporting in telco billing systems',
    `adjustment_reason_code` STRING COMMENT 'Standardized code indicating the reason for any billing adjustment or credit applied to this line item. Examples include billing error corrections, goodwill credits, SLA breach credits, or dispute resolutions. Populated only when charge_type is adjustment or credit. Used for revenue assurance and dispute analytics.',
    `billing_cycle_code` STRING COMMENT 'The billing cycle identifier to which this invoice line belongs, as defined in Amdocs Revenue Management. Identifies the specific monthly or periodic billing run that generated this line item. Used for billing cycle reconciliation and MRR period alignment.',
    `cdr_reference` STRING COMMENT 'The originating CDR (Call Detail Record) or usage event reference identifier that generated this charge line. Links the billed charge back to the raw network usage event for revenue assurance, dispute resolution, and audit purposes. Sourced from the Amdocs mediation layer.',
    `charge_category` STRING COMMENT 'High-level service category to which this charge belongs, enabling revenue segmentation and MRR/ARPU reporting by service type. Maps to the telecom service taxonomy used in Amdocs Revenue Management. [ENUM-REF-CANDIDATE: voice|data|sms|roaming|equipment|interconnect|content|broadband|iptv|other — promote to reference product]',
    `charge_description` STRING COMMENT 'Human-readable description of the charge or credit line item as it appears on the customers itemized bill. Examples include Monthly 5G Unlimited Plan, International Roaming Data - Zone A, Late Payment Fee, or Loyalty Discount Credit. Used for bill presentment and dispute resolution.',
    `charge_period_end` DATE COMMENT 'The end date of the billing period covered by this charge line item. For recurring charges, this is the last day of the service period. For usage charges, this is the end of the usage aggregation window. Used alongside charge_period_start for proration and revenue recognition period allocation.',
    `charge_period_start` DATE COMMENT 'The start date of the billing period covered by this charge line item. For recurring charges, this is the first day of the service period. For usage charges, this is the start of the usage aggregation window. Essential for proration calculations and dispute resolution.',
    `charge_type` STRING COMMENT 'Classification of the charge or credit line item indicating its billing nature. Recurring charges apply each billing cycle (e.g., monthly plan fee), one_time charges are non-recurring (e.g., activation fee), usage charges are consumption-based (e.g., CDR-rated calls/data), adjustments correct prior billing errors, credits reduce the customers balance, and tax lines represent applicable tax amounts.. Valid values are `recurring|one_time|usage|adjustment|credit|tax`',
    `cost_center_code` STRING COMMENT 'The SAP S/4HANA cost center code associated with the business unit or service line responsible for this charge. Used for internal cost allocation, OPEX/CAPEX reporting, and profitability analysis by business segment.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this invoice line record was first created in the Amdocs Revenue Management system and ingested into the Databricks Silver Layer. Provides the audit trail creation timestamp for data governance and lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this line item (e.g., USD, EUR, GBP). Supports multi-currency billing for international customers and roaming scenarios.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The monetary value of any discount applied to this line item, including promotional discounts, loyalty discounts, bundle discounts, or negotiated contract discounts. A positive value reduces the net charge. Sourced from Amdocs Revenue Management discount engine.',
    `discount_code` STRING COMMENT 'The promotional or contractual discount code applied to this line item. References the specific discount offer or loyalty program that generated the discount_amount. Used for discount effectiveness analysis and revenue leakage detection in revenue assurance.',
    `gl_account_code` STRING COMMENT 'The General Ledger account code to which this charge line is posted in SAP S/4HANA for financial reporting. Maps the billing line to the appropriate revenue, tax, or adjustment account in the chart of accounts. Required for financial close and regulatory financial reporting.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The pre-discount, pre-tax charge amount for this line item, calculated as rated_quantity multiplied by unit_rate for usage charges, or the flat recurring/one-time fee for non-usage charges. Represents the full list price before any adjustments.',
    `is_prorated` BOOLEAN COMMENT 'Indicates whether this charge line has been prorated to reflect a partial billing period. True when the customer activated, deactivated, or changed a service mid-cycle, resulting in a partial-period charge. Used for billing accuracy validation and customer dispute resolution.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this charge is a recurring Monthly Recurring Revenue (MRR) component. True for subscription-based charges that appear each billing cycle (e.g., monthly plan fees, equipment rental). Used for MRR reporting and revenue forecasting.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether this line item is subject to taxation. False for tax-exempt charges such as certain government or non-profit customer lines, or for line items that are themselves tax charges. Used by the Amdocs tax engine and for regulatory tax reporting.',
    `line_sequence_number` STRING COMMENT 'Sequential ordering number of this line item within the parent invoice. Used for itemized bill presentation, dispute resolution, and maintaining consistent line ordering across billing cycles.',
    `line_status` STRING COMMENT 'Current lifecycle status of this invoice line item. Active lines are valid billed charges. Disputed lines are under customer dispute investigation. Adjusted lines have been corrected. Cancelled lines have been voided. Reversed lines have been credited back. Written_off lines have been deemed uncollectable.. Valid values are `active|disputed|adjusted|cancelled|reversed|written_off`',
    `net_amount` DECIMAL(18,2) COMMENT 'The charge amount after applying discounts but before tax. Calculated as gross_amount minus discount_amount. Represents the taxable base for this line item and is the primary amount used for revenue recognition per IFRS 15.',
    `prepaid_indicator` BOOLEAN COMMENT 'Indicates whether this charge line originated from a prepaid account managed by Comverse ONE real-time rating and balance management, as opposed to a postpaid account managed by Amdocs Revenue Management. Drives different revenue recognition and reporting treatment.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the rated_quantity field. Specifies the dimension in which consumption is expressed (e.g., minutes for voice, MB/GB for data, SMS for messaging). Essential for correct interpretation of the rated quantity in billing analytics and dispute resolution. [ENUM-REF-CANDIDATE: minutes|seconds|MB|GB|TB|SMS|units|events|days|months — 10 candidates stripped; promote to reference product]',
    `rated_quantity` DECIMAL(18,2) COMMENT 'The metered or rated quantity of consumption that forms the basis for this charge. Represents units consumed such as minutes of voice calls, megabytes of data, number of SMS messages, or number of pay-per-view events. Sourced from the Amdocs rating engine after processing CDRs.',
    `rating_plan_code` STRING COMMENT 'The identifier of the tariff or rating plan applied by the Amdocs rating engine to compute the charge for this line item. Enables traceability of the pricing logic used and supports revenue assurance validation against the product catalog.',
    `rating_timestamp` TIMESTAMP COMMENT 'The date and time when the Amdocs rating engine processed and rated this charge. Provides an audit trail for the rating event and is used to reconcile rated charges against CDR processing windows in revenue assurance.',
    `revenue_recognition_code` STRING COMMENT 'The revenue recognition classification code assigned to this line item per IFRS 15 / ASC 606 performance obligation mapping. Determines how and when revenue from this charge is recognized in the general ledger. Used by SAP S/4HANA finance integration for revenue accounting.',
    `roaming_indicator` BOOLEAN COMMENT 'Indicates whether this charge was incurred while the customer was roaming on a visited network outside their home network. True for roaming charges subject to GSMA TAP/NRTRDE inter-operator settlement and IOT (Inter-Operator Tariff) pricing.',
    `service_identifier` STRING COMMENT 'The specific service instance identifier associated with this charge, such as the MSISDN (mobile number), IMSI, broadband circuit ID, or IPTV subscriber ID. Enables line-level traceability to the specific service that generated the charge.',
    `source_system_line_ref` STRING COMMENT 'The native line item identifier from the originating source system (Amdocs Revenue Management or Comverse ONE) before surrogate key assignment in the Databricks Silver Layer. Enables lineage tracing back to the operational system of record for reconciliation and audit purposes.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The monetary value of tax assessed on this line item, calculated by applying the tax_rate to the net_amount. Includes all applicable taxes and regulatory surcharges (e.g., federal excise tax, state sales tax, USF contributions, E911 fees). Required for regulatory tax reporting.',
    `tax_code` STRING COMMENT 'The tax jurisdiction or tax type code applied to this line item, as determined by the Amdocs tax engine. Examples include federal excise tax codes, state sales tax codes, USF (Universal Service Fund) surcharge codes, or VAT codes for international customers. Maps to the applicable tax authority.',
    `tax_rate` DECIMAL(18,2) COMMENT 'The applicable tax rate as a decimal fraction (e.g., 0.0875 for 8.75%) applied to the net_amount to compute the tax_amount for this line item. Sourced from the tax jurisdiction configuration in Amdocs Revenue Management.',
    `total_amount` DECIMAL(18,2) COMMENT 'The final billed amount for this line item inclusive of all taxes and after all discounts. Calculated as net_amount plus tax_amount. This is the amount that contributes to the invoice total and the customers payable balance.',
    `unit_rate` DECIMAL(18,2) COMMENT 'The per-unit price applied to the rated quantity to compute the gross charge amount. Sourced from the Amdocs rating engines tariff tables. For example, the per-minute rate for international calls or the per-GB rate for data overage charges.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this invoice line record was last modified, such as when a dispute status changed, an adjustment was applied, or a reversal was processed. Used for incremental data pipeline processing and audit trail maintenance.',
    `visited_network_code` STRING COMMENT 'The Public Land Mobile Network (PLMN) code of the visited operators network where roaming usage was consumed. Composed of MCC (Mobile Country Code) and MNC (Mobile Network Code). Required for GSMA TAP inter-operator settlement and roaming revenue reconciliation.. Valid values are `^[0-9]{5,6}$`',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual charge or credit line item on a customer invoice. Captures service type, charge description, rated quantity, unit rate, charge amount, tax code, tax amount, discount applied, charge period start/end, and originating CDR or event reference. Enables itemized bill presentation and dispute resolution at the line level. Sourced from Amdocs Revenue Management rating engine.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique surrogate identifier for each payment record in the billing system. Primary key for the payment data product. Sourced from Amdocs Collections module.',
    `billing_account_id` BIGINT COMMENT 'Reference to the customer billing account against which this payment is applied. Links the payment to the account in Amdocs Revenue Management.',
    `billing_dispute_id` BIGINT COMMENT 'Reference to an active billing dispute record associated with this payment. Populated when the payment is under investigation or linked to a customer dispute. Null for undisputed payments.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise payments originate from corporate treasury systems with corporate account references for cash application, AR reconciliation, and consolidated payment allocation across multi-site accounts.',
    `employee_id` BIGINT COMMENT 'Reference to the customer service or collections agent who processed or recorded this payment on behalf of the customer. Null for self-service and automated payments. Used for agent performance and accountability tracking.',
    `invoice_id` BIGINT COMMENT 'Reference to the primary invoice this payment is applied against. A payment may partially or fully settle an invoice. Null for unapplied or advance payments.',
    `original_payment_id` BIGINT COMMENT 'Reference to the original payment record that this record reverses, refunds, or adjusts. Enables chargeback and reversal lineage tracing. Null for original (non-derived) payments.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Payments from partners (MVNOs paying wholesale bills, roaming settlement payments). Required for partner payment tracking, accounts receivable management, and settlement payment reconciliation in tele',
    `rate_plan_id` BIGINT COMMENT 'Reference to an instalment or payment arrangement plan under which this payment was made. Null for standard one-off payments. Used to track compliance with payment arrangement agreements in collections.',
    `regulatory_penalty_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_penalty. Business justification: Payments settle regulatory fines and penalties. Real business process: compliance teams track penalty payments for closure verification, financial reporting, and audit trail. Payment records provide p',
    `amount` DECIMAL(18,2) COMMENT 'Gross monetary amount of the payment as submitted by the customer or payment processor, before any adjustments or fees. Expressed in the billing currency. Core field for revenue reconciliation and MRR reporting.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has been successfully applied to outstanding invoice balances or account credits. May differ from payment_amount if partially applied or pending allocation.',
    `authorization_code` STRING COMMENT 'Alphanumeric authorization or approval code returned by the payment gateway or card network upon successful transaction authorization. Used for dispute resolution, chargeback processing, and reconciliation with payment processors.. Valid values are `^[A-Z0-9]{4,20}$`',
    `bank_account_last_four` STRING COMMENT 'Last four digits of the bank account number used for direct debit or bank transfer payments. Stored as a masked identifier for verification. Null for non-bank payment methods.. Valid values are `^[0-9]{4}$`',
    `bank_routing_code` STRING COMMENT 'Bank routing number (ABA/ACH in the US) or sort code (UK) or BIC/SWIFT code for international transfers, identifying the financial institution for direct debit and bank transfer payments. Null for non-bank payment methods.',
    `base_currency_amount` DECIMAL(18,2) COMMENT 'Payment amount converted to the companys functional (base) currency using the exchange_rate at the time of payment. Used for consolidated financial reporting and revenue recognition in the base currency.',
    `billing_period_end` DATE COMMENT 'End date of the billing cycle period that this payment is intended to cover. Used alongside billing_period_start for MRR attribution and period-based revenue recognition.',
    `billing_period_start` DATE COMMENT 'Start date of the billing cycle period that this payment is intended to cover. Used for MRR attribution and period-based revenue recognition.',
    `card_last_four` STRING COMMENT 'Last four digits of the payment card number used for the transaction. Stored as a masked identifier for customer service verification and reconciliation. Full card number is never stored per PCI DSS requirements.. Valid values are `^[0-9]{4}$`',
    `card_type` STRING COMMENT 'Card network brand for credit or debit card payments (e.g., Visa, Mastercard, Amex). Null for non-card payment methods. Used for interchange fee analysis and payment mix reporting.. Valid values are `visa|mastercard|amex|discover|unionpay|other`',
    `channel` STRING COMMENT 'The customer-facing interface or touchpoint through which the payment was submitted. Distinct from payment_method (instrument). Values: ivr (Interactive Voice Response), web (self-service portal), mobile_app, agent (call centre or retail agent), auto_pay (recurring automated), retail_store, kiosk. Used for channel analytics and cost-to-collect reporting. [ENUM-REF-CANDIDATE: ivr|web|mobile_app|agent|auto_pay|retail_store|kiosk — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment record was first created in the source system (Amdocs Collections). Used for audit trail and data lineage in the Silver layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the payment amount (e.g., USD, EUR, GBP). Required for multi-currency billing environments and international roaming settlement.. Valid values are `^[A-Z]{3}$`',
    `dunning_level` STRING COMMENT 'Numeric dunning escalation level associated with this payment attempt within the collections dunning cycle (e.g., 0 = no dunning, 1 = first reminder, 2 = second notice, 3 = final notice). Used by Amdocs Collections dunning engine to track collection escalation.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert the payment amount from the transaction currency to the billing base currency at the time of payment. Relevant for international customers and roaming settlement. 1.0 for same-currency transactions.',
    `gateway` STRING COMMENT 'Name or identifier of the external payment gateway or processor that handled the transaction (e.g., Stripe, Adyen, PayPal, WorldPay, internal BSS gateway). Used for reconciliation, gateway performance monitoring, and fee analysis.',
    `is_auto_pay` BOOLEAN COMMENT 'Indicates whether this payment was collected automatically via a recurring auto-pay mandate (True) or was manually initiated by the customer or agent (False). Used for auto-pay adoption analytics and churn risk modelling.',
    `is_partial_payment` BOOLEAN COMMENT 'Indicates whether this payment covers only a portion of the total outstanding balance (True) or fully settles the billed amount (False). Used in collections and dunning workflows to identify accounts with partial payment arrangements.',
    `net_received_amount` DECIMAL(18,2) COMMENT 'Net amount received after deducting payment processing fees from the gross payment_amount. Represents the actual funds credited to the telcos account. Used for cash flow reporting and revenue assurance.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by a collections agent or system regarding this payment. May include special handling instructions, customer communication summaries, or exception details. Not used for structured data.',
    `payment_date` DATE COMMENT 'The calendar date on which the payment was received or initiated by the customer. This is the principal business event date used for revenue recognition, aging analysis, and MRR reporting.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to make the payment. Distinguishes the type of payment instrument: credit_card, direct_debit (ACH/SEPA), bank_transfer (wire), cash, voucher (prepaid/gift), or digital_wallet (e.g., PayPal, Apple Pay). Critical for payment processing routing and fraud analysis.. Valid values are `credit_card|direct_debit|bank_transfer|cash|voucher|digital_wallet`',
    `payment_status` STRING COMMENT 'Current lifecycle state of the payment transaction. pending — received but not yet confirmed; cleared — funds confirmed; reversed — payment reversed/chargeback; failed — transaction declined or errored; refunded — amount returned to customer; disputed — under dispute investigation. Drives collections and dunning workflows.. Valid values are `pending|cleared|reversed|failed|refunded|disputed`',
    `payment_type` STRING COMMENT 'Classification of the payment by its business purpose: standard (regular bill payment), advance (payment before bill issuance), deposit (security deposit), refund (return of funds to customer), reversal (cancellation of a prior payment), adjustment (billing correction). Drives accounting treatment and revenue recognition.. Valid values are `standard|advance|deposit|refund|reversal|adjustment`',
    `processing_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the payment gateway or processor for handling this transaction. Deducted from the gross payment amount to derive net received funds. Used for payment cost analysis and OPEX reporting.',
    `received_timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone offset) when the payment transaction was received and recorded in the Amdocs Collections system. Used for real-time reconciliation and SLA tracking.',
    `reference_number` STRING COMMENT 'Externally visible, human-readable reference number assigned to this payment transaction. Used by customers and agents to track and reconcile payments. Sourced from Amdocs Collections module.. Valid values are `^[A-Z0-9-]{6,40}$`',
    `reversal_reason` STRING COMMENT 'Business reason code or description explaining why a payment was reversed or charged back (e.g., insufficient_funds, duplicate_payment, customer_dispute, fraud, bank_error). Populated only when payment_status is reversed or failed.',
    `reversal_timestamp` TIMESTAMP COMMENT 'Date and time when the payment reversal or chargeback was processed. Null for non-reversed payments. Used for collections workflow timing and dispute SLA tracking.',
    `settlement_date` DATE COMMENT 'The date on which the payment funds were actually settled and confirmed by the bank or payment processor. May differ from payment_date for card and bank transfer payments due to clearing cycles. Used for cash flow and revenue recognition reporting.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this payment record was sourced. Supports data lineage, reconciliation, and Silver layer provenance tracking. Primary sources are Amdocs Collections and Comverse ONE for prepaid.. Valid values are `amdocs_collections|comverse_one|salesforce_crm|manual_entry|payment_gateway`',
    `transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the external payment gateway, bank, or payment processor. Used to cross-reference and reconcile payments with third-party payment systems and bank statements.. Valid values are `^[A-Za-z0-9-_]{6,60}$`',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount not yet allocated to any invoice or charge. Represents an overpayment credit or advance payment held on the billing account pending future allocation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this payment record in the source system. Tracks status changes, reversals, and adjustments for audit and reconciliation purposes.',
    `value_date` DATE COMMENT 'The effective date from which the payment is considered valid for interest and balance calculations. Used in financial accounting and bank reconciliation. May differ from payment_date and settlement_date.',
    `voucher_code` STRING COMMENT 'Unique alphanumeric code of the prepaid voucher or gift card redeemed as payment. Applicable only when payment_method is voucher. Used for voucher reconciliation and prepaid balance management in Comverse ONE.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Record of a financial payment received from or applied to a customer billing account. Captures payment date, amount, payment method (credit card, direct debit, bank transfer, cash, voucher), payment channel (IVR, web, agent, auto-pay), authorization code, transaction reference, applied invoice references, and payment status (pending, cleared, reversed, failed). SSOT for all inbound monetary receipts. Sourced from Amdocs Collections module.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`rated_event` (
    `rated_event_id` BIGINT COMMENT 'Unique surrogate primary key for each rated usage event record in the billing silver layer. Generated by the Amdocs Rating engine or Comverse ONE real-time rating pipeline upon successful rating of a raw CDR, IPDR, or partner usage feed.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Usage events may consume addon allowances (data packs, international calling, roaming). Required for accurate addon usage tracking, quota enforcement, overage billing, and addon product performance an',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account under which this rated event is charged. Links the usage event to the customer financial account for invoice aggregation and ARPU/MRR reporting in Amdocs Revenue Management.',
    `billing_cycle_id` BIGINT COMMENT 'The billing period (formatted as YYYY-MM) to which this rated event is allocated for invoicing. Determines which invoice cycle aggregates this charge. Used for MRR reporting, revenue recognition, and billing cycle reconciliation in Amdocs.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Rated usage events must link to the catalog item whose allowances and rating rules apply. Essential for usage analytics by product, fair use policy enforcement, and product design optimization.',
    `cdr_id` BIGINT COMMENT 'Reference to the originating raw CDR, IPDR, or partner usage feed record from which this rated event was produced. Bridges the CDR domain to the billing/financial domain and enables traceability back to the network event.',
    `ran_cell_id` BIGINT COMMENT 'The network cell or base station identifier (e.g., eNodeB/gNB cell ID) where the subscriber was served during this event. Used for network-level usage analytics, RAN capacity planning, and geographic revenue reporting. Sourced from CDR network element data.',
    `coverage_area_id` BIGINT COMMENT 'Foreign key linking to location.coverage_area. Business justification: Usage events occur within specific coverage areas; critical for roaming settlement calculations, network performance correlation with billing disputes, coverage quality analysis, and inter-operator ch',
    `fiber_cable_id` BIGINT COMMENT 'Foreign key linking to inventory.fiber_cable. Business justification: For wholesale/carrier billing, usage events on leased fiber must reference the cable segment. Required for wholesale fiber usage billing, capacity planning, and inter-carrier settlement.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice on which this rated event charge appears. Populated after invoice generation; null for events not yet invoiced or for prepaid events settled via balance deduction.',
    `lawful_intercept_order_id` BIGINT COMMENT 'Foreign key linking to compliance.lawful_intercept_order. Business justification: Rated events (CDRs) are delivered to law enforcement under lawful intercept orders. Real business process: LEA requests require CDR extraction with chain of custody tracking. Compliance teams link del',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Usage events (data consumption, API calls, voice minutes) must link to managed service instances for capacity planning, SLA performance measurement, usage-based billing validation, and service-specifi',
    `original_rated_event_id` BIGINT COMMENT 'Reference to the original rated event record that this record supersedes or corrects. Populated for re-rated or reversed events to maintain the audit chain. Enables before/after comparison for revenue assurance and dispute resolution.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Roaming events and wholesale usage must track originating/terminating partner network. Required for roaming event settlement, wholesale usage billing, inter-operator charging, and TAP/RAP file reconci',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Usage rating pipelines must be tracked for re-rating workflows, interconnect settlement reconciliation, and roaming dispute resolution. Enables identification of which rating engine run processed spec',
    `rate_plan_id` BIGINT COMMENT 'Reference to the rate plan applied during rating of this event. Determines the pricing tiers, bundle allowances, and charging rules used to compute the charge amount.',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Events are served by specific cell sites; essential for site-level revenue attribution, capacity planning ROI analysis, interconnect settlement by site, and correlating billing disputes with site outa',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: Usage events (calls, SMS, data sessions) are generated by specific SIM cards. Rating engines need SIM-to-event linkage for fraud detection, roaming reconciliation, and SIM swap validation. Critical fo',
    `customer_subscription_id` BIGINT COMMENT 'Reference to the active subscriber service subscription (rate plan contract) under which this usage event is rated. Determines applicable rate plan, bundles, and allowances in Amdocs and Comverse ONE.',
    `tap_record_id` BIGINT COMMENT 'Foreign key linking to interconnect.tap_record. Business justification: Roaming CDRs rated in billing must reference source TAP records for wholesale settlement reconciliation, dispute resolution, and revenue assurance audits—critical for matching retail charges to wholes',
    `access_point_name` STRING COMMENT 'The APN used by the subscriber for data sessions, identifying the packet data network gateway and service context (e.g., internet, enterprise VPN, IMS). Used for data service classification, QoS policy application, and DPI-based rating.',
    `bundle_consumed` BOOLEAN COMMENT 'Indicates whether this rated event was charged against an included bundle allowance (True) or rated as an out-of-bundle/overage charge (False). Used to track bundle utilization, identify overage revenue, and support customer usage analytics.',
    `called_party_number` STRING COMMENT 'The destination number (B-party) dialed or messaged by the subscriber for voice calls and SMS events. Used for inter-operator settlement, fraud analysis, and regulatory lawful intercept compliance. Classified as confidential PII.. Valid values are `^+?[1-9]d{6,14}$`',
    `charge_amount` DECIMAL(18,2) COMMENT 'The gross charge amount applied to this rated event before discounts and taxes, in the billing currency. Computed by the rating engine based on the applicable rate plan tier and rated volume/duration. Core financial field for revenue recognition and invoice line generation.',
    `charge_type` STRING COMMENT 'Classifies the nature of the charge associated with this rated event. usage = consumption-based charge; recurring = periodic subscription charge; one_time = activation/setup fee; adjustment = billing correction; reversal = credit/reversal of a prior charge. Used for revenue categorization and GL posting.. Valid values are `usage|recurring|one_time|adjustment|reversal`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this rated event record was first persisted in the Databricks silver layer. Used for data lineage, audit trail, and pipeline monitoring. Distinct from rating_timestamp (when rated) and event_start_timestamp (when the event occurred).',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code in which the charge, discount, and tax amounts are expressed (e.g., USD, EUR, GBP). Essential for multi-currency billing environments and inter-operator settlement.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total discount amount applied to this rated event (promotional, loyalty, bundle, or contractual discounts) in the billing currency. Reduces the gross charge to arrive at the net charge. Used for discount analytics and revenue assurance.',
    `dispute_reference` STRING COMMENT 'The reference number of the billing dispute or inter-operator dispute case associated with this rated event, if applicable. Populated when rating_status = disputed. Links to the dispute management workflow in Amdocs or ServiceNow ITSM for resolution tracking.',
    `event_direction` STRING COMMENT 'Indicates the origination direction of the usage event. MO (Mobile Originated) = subscriber initiated the call/session; MT (Mobile Terminated) = subscriber received the call/session. Relevant for voice and SMS rating and inter-operator settlement.. Valid values are `MO|MT|forward|unknown`',
    `event_end_timestamp` TIMESTAMP COMMENT 'The date and time when the usage event concluded (e.g., call release time, data session termination). Used to compute event duration and for billing cycle boundary determination.',
    `event_sequence_number` STRING COMMENT 'Externally-known business identifier assigned by the rating engine or source OSS/BSS system to uniquely identify this rated event within a billing cycle or batch. Used for reconciliation, dispute resolution, and inter-operator settlement references.',
    `event_start_timestamp` TIMESTAMP COMMENT 'The date and time when the usage event began (e.g., call answer time, data session start, SMS submission time). This is the principal real-world event time used for billing cycle allocation, time-of-day rating, and CDR correlation.',
    `event_type` STRING COMMENT 'Classification of the usage event by service type. Drives rating logic selection and reporting segmentation. Examples: voice (MO/MT calls), SMS, data (packet sessions), roaming (visited network), content (OTT/IPTV), IoT (machine-to-machine). [ENUM-REF-CANDIDATE: voice|sms|data|roaming|content|iot|mms|video — promote to reference product]',
    `home_plmn` STRING COMMENT 'The MCC+MNC code identifying the subscribers home network operator (HPLMN). Used to determine domestic vs. roaming status and to apply correct inter-operator tariffs (IOT) for roaming settlement via GSMA TAP/NRTRDE.. Valid values are `^[0-9]{5,6}$`',
    `imei` STRING COMMENT 'The IMEI of the device used during this usage event. Used for device-level analytics, fraud detection (stolen device usage), and regulatory reporting. Classified as confidential device identifier.. Valid values are `^[0-9]{15}$`',
    `imsi` STRING COMMENT 'The IMSI uniquely identifying the SIM/subscriber on the network. Used for roaming settlement, fraud detection, and subscriber authentication correlation. Classified as restricted PII as it uniquely identifies a subscriber.. Valid values are `^[0-9]{14,15}$`',
    `inter_operator_charge` DECIMAL(18,2) COMMENT 'The inter-operator tariff (IOT) charge amount payable to or receivable from the visited network operator for roaming events, in the settlement currency. Populated only for roaming events (is_roaming = true). Used for GSMA TAP/NRTRDE wholesale settlement and interconnect accounting.',
    `is_roaming` BOOLEAN COMMENT 'Flag indicating whether this usage event occurred while the subscriber was roaming on a visited network (VPLMN). True = roaming event subject to inter-operator settlement; False = domestic event. Drives roaming-specific rating rules and GSMA TAP/NRTRDE processing.',
    `msisdn` STRING COMMENT 'The subscribers MSISDN (phone number in E.164 format) associated with this usage event. Primary subscriber identifier for rating, billing, and inter-operator settlement. Classified as restricted PII as it directly identifies an individual subscriber.. Valid values are `^+?[1-9]d{6,14}$`',
    `net_charge_amount` DECIMAL(18,2) COMMENT 'The final net charge amount for this rated event after applying discounts and taxes (charge_amount - discount_amount + tax_amount) in the billing currency. This is the amount posted to the customer invoice and used for revenue recognition and ARPU calculation.',
    `network_technology` STRING COMMENT 'The radio access or network technology used to deliver the service for this event (e.g., 4G LTE, 5G NR, VoLTE, FTTH/GPON). Used for technology-based revenue analytics, network capacity planning, and QoS reporting. [ENUM-REF-CANDIDATE: 2G|3G|4G_LTE|5G_NR|VoLTE|VoIP|WiFi|FTTH|unknown — promote to reference product]',
    `rated_duration_seconds` STRING COMMENT 'The billable duration of the usage event in seconds as determined by the rating engine after applying rounding rules (e.g., per-second, per-minute rounding). Applicable for voice and video call events. May differ from raw CDR duration due to rating rounding rules.',
    `rated_unit_count` DECIMAL(18,2) COMMENT 'The number of billable units consumed in this event as determined by the rating engine. For SMS: number of message segments; for content: number of items; for IoT: number of transactions. Complements rated_duration_seconds and rated_volume_bytes for non-time/non-data event types.',
    `rated_volume_bytes` BIGINT COMMENT 'The billable data volume in bytes as determined by the rating engine after applying any volume rounding or threshold rules. Applicable for data, roaming data, and IoT events. Used for bundle consumption tracking and overage charge calculation.',
    `rating_engine` STRING COMMENT 'Identifies the rating system that processed and priced this event. amdocs = Amdocs Revenue Management batch/real-time rating; comverse_one = Comverse ONE prepaid real-time rating; partner_feed = rated by a partner/MVNO; manual = manually rated adjustment. Used for data lineage and revenue assurance.. Valid values are `amdocs|comverse_one|partner_feed|manual`',
    `rating_mode` STRING COMMENT 'Indicates whether this event was rated in real-time (online charging, e.g., Comverse ONE prepaid), batch mode (Amdocs post-processing), or offline (delayed/manual). Affects revenue recognition timing and prepaid balance deduction sequencing.. Valid values are `real_time|batch|offline`',
    `rating_status` STRING COMMENT 'Current lifecycle state of the rated event within the billing workflow. rated = successfully priced; re_rated = repriced after correction; disputed = under customer or inter-operator dispute; written_off = revenue written off; pending = awaiting rating completion; rejected = failed rating validation. [ENUM-REF-CANDIDATE: rated|re_rated|disputed|written_off|pending|rejected — promote to reference product]. Valid values are `rated|re_rated|disputed|written_off|pending|rejected`',
    `rating_tier` STRING COMMENT 'The specific pricing tier or band within the rate plan applied to this event (e.g., TIER_1_BUNDLE, TIER_2_OVERAGE, PEAK, OFF_PEAK, ROAM_ZONE_A). Indicates which step of a tiered or time-of-day pricing structure was used. Critical for revenue assurance and rate plan analytics.',
    `rating_timestamp` TIMESTAMP COMMENT 'The date and time when the rating engine (Amdocs or Comverse ONE) processed and priced this usage event. Distinct from the event start/end timestamps. Used for rating pipeline SLA monitoring, re-rating audit trails, and revenue recognition timing.',
    `re_rating_reason` STRING COMMENT 'Free-text or coded reason explaining why this event was re-rated (e.g., rate plan correction, tariff update, CDR amendment, dispute resolution). Populated only when rating_status = re_rated. Essential for revenue assurance audit trails.',
    `roaming_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the roaming event occurred. Populated only when is_roaming = true. Used for roaming revenue reporting, IOT application, and regulatory compliance with visited country regulations.. Valid values are `^[A-Z]{3}$`',
    `service_identifier` STRING COMMENT 'The specific service or product code from the Netcracker Service Catalog that this usage event is associated with (e.g., VOICE_DOMESTIC, DATA_4G, SMS_INTL, ROAM_DATA_EU). Used to apply service-specific rating rules and bundle consumption tracking.',
    `serving_plmn` STRING COMMENT 'The MCC+MNC code of the network that served the subscriber during this event. For domestic events equals the home PLMN; for roaming events identifies the visited network (VPLMN). Critical for inter-operator settlement and roaming IOT application.. Valid values are `^[0-9]{5,6}$`',
    `tap_file_reference` STRING COMMENT 'The GSMA TAP3 file identifier referencing the inter-operator roaming data exchange file from which this roaming rated event was sourced. Used for roaming settlement reconciliation, dispute management, and NRTRDE compliance tracking.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax amount levied on this rated event in the billing currency (e.g., VAT, GST, USF, E911 surcharges). Computed based on applicable tax jurisdiction rules. Required for tax reporting, regulatory compliance, and invoice accuracy.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this rated event record was last modified in the silver layer (e.g., after re-rating, dispute resolution, or status update). Used for change tracking, incremental processing, and audit compliance.',
    CONSTRAINT pk_rated_event PRIMARY KEY(`rated_event_id`)
) COMMENT 'Processed and priced usage event produced by the real-time or batch rating engine from raw CDRs, IPDRs, or partner usage feeds. Captures event type (voice, SMS, data, roaming, content, IoT), originating network event reference, subscriber MSISDN/IMSI, serving network (home/visited PLMN for roaming), service identifier, rated volume/duration, applied rate plan and tier, charge amount, discount amount, tax amount, rating timestamp, and rating status (rated, re-rated, disputed, written-off). Supports both domestic and roaming usage with inter-operator settlement attributes for visited network events. Bridges raw usage (CDR domain) and financial charges on invoices. Sourced from Amdocs Rating engine and Comverse ONE real-time rating.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`billing_charge` (
    `billing_charge_id` BIGINT COMMENT 'Unique system-generated identifier for each individual monetary charge record within the billing domain. Serves as the primary key for the charge entity in Amdocs Revenue Management.',
    `addon_id` BIGINT COMMENT 'Foreign key linking to product.addon. Business justification: Addon charges (recurring, one-time, usage-based) must link to addon definition for billing validation, addon revenue attribution, dispute resolution, and addon product performance measurement.',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account to which this charge is applied. Links the charge to the customers financial account in Amdocs Revenue Management for invoice consolidation and MRR/ARPU reporting.',
    `employee_id` BIGINT COMMENT 'Reference to the supervisor or authorized agent who approved this charge when approval_status is approved. Null for system-generated or not_required charges. Supports SOX compliance and internal audit requirements.',
    `billing_cycle_id` BIGINT COMMENT 'Reference to the billing cycle in which this charge was generated and processed. Links the charge to the specific monthly or periodic billing run in Amdocs Revenue Management for cycle-level reconciliation.',
    `billing_employee_id` BIGINT COMMENT 'Reference to the customer service agent or system user who manually applied this charge. Populated for manual and adjustment charge types. Null for system-generated charges. Used for audit and accountability tracking.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: Charges originate from catalog items sold to customers. Required for product revenue attribution, profitability analysis, product lifecycle management, and sales performance reporting by catalog item.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the originating order that triggered this charge, such as a new activation, upgrade, or equipment purchase order managed in Oracle Communications Order and Service Management.',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: One-time charges for equipment installation, damage, replacement, or early termination must link to the specific CPE asset. Essential for equipment damage billing, warranty claim processing, and asset',
    `spectrum_allocation_id` BIGINT COMMENT 'Foreign key linking to inventory.spectrum_allocation. Business justification: Spectrum lease or sharing revenue charges must reference the specific spectrum allocation. Required for spectrum monetization, cost allocation to services, and regulatory compliance reporting.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice on which this charge appears for bill presentation. Null if the charge has not yet been invoiced. Distinct from the charge itself per TM Forum SID separation of charge and invoice_line.',
    `ip_address_pool_id` BIGINT COMMENT 'Foreign key linking to inventory.ip_address_pool. Business justification: Static IP address assignment charges must reference the pool from which the IP was allocated. Required for premium IP address billing, resource utilization tracking, and enterprise service billing.',
    `managed_service_id` BIGINT COMMENT 'Foreign key linking to enterprise.managed_service. Business justification: Recurring and one-time charges must trace to specific managed service instances (MPLS circuits, SD-WAN nodes, UCaaS seats) for service-level revenue recognition, contract compliance validation, disput',
    `offering_id` BIGINT COMMENT 'Foreign key linking to product.offering. Business justification: Charges stem from offerings purchased by customers. Required for offer performance analysis, revenue forecasting by offering, promotional offer ROI measurement, and channel effectiveness reporting.',
    `ont_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.ont_asset. Business justification: ONT installation, replacement, or damage charges must link to the specific asset. Essential for fiber equipment charge management, warranty tracking, and asset lifecycle cost allocation.',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Activation fees, prorated charges, and early termination fees for content packages. Essential for package lifecycle charging, proration calculations, and revenue recognition in telco billing operation',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Partner-specific charges (wholesale access fees, roaming charges, MVNO platform fees). Required for partner charge management, revenue recognition, and partner-specific billing in telecommunications o',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Charge creation pipelines require lineage for revenue recognition validation, financial close processes, and MRR/ARR reporting accuracy. Supports audit requirements to trace which ETL run generated sp',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to billing.rate_plan. Business justification: Charges (especially recurring and usage-based charges) are priced according to a rate plan definition. The charge table currently has charge_type and charge_category but no direct FK to the rate_plan ',
    `reversal_charge_billing_charge_id` BIGINT COMMENT 'Reference to the original charge that this record reverses or credits. Populated only for reversal/credit adjustment charges. Enables audit trail linking of original charge to its reversal for revenue assurance.',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: One-time and recurring charges are governed by contract pricing terms; contract_id is required for contract compliance validation, revenue assurance audits, pricing dispute resolution, and contract am',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: One-time charges (installation, equipment, connection fees) are territory-specific for field technician dispatch coordination, cost center allocation, franchise fee calculation, and regional pricing v',
    `spec_id` BIGINT COMMENT 'Reference to the charge specification or charge template in the Netcracker Product/Service Catalog that defines the rules, rates, and conditions for this type of charge. Enables catalog-driven charge validation.',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: Subscriber-specific charges (SIM swap fees, number portability fees, device insurance premiums, international roaming add-ons) require direct subscriber attribution for accurate billing, dispute resol',
    `svc_instance_id` BIGINT COMMENT 'Reference to the subscribed product or service instance that originated this charge (e.g., a specific mobile plan, broadband subscription, or equipment). Links charge to the Product and Service Catalog in Netcracker OSS/BSS.',
    `vod_asset_id` BIGINT COMMENT 'Foreign key linking to content.vod_asset. Business justification: One-time VOD charges tracked in charge management before invoicing. Required for charge approval workflows, revenue recognition timing, and content-specific charge dispute resolution in telecommunicat',
    `approval_status` STRING COMMENT 'Approval workflow status for charges requiring authorization before posting, particularly manual adjustments and credits above threshold amounts. not_required for system-generated charges; pending_approval, approved, or rejected for manual charges requiring supervisor sign-off.. Valid values are `not_required|pending_approval|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the charge was approved by an authorized agent or supervisor. Null for system-generated charges or those not requiring approval. Supports audit trail and SOX compliance reporting.',
    `charge_category` STRING COMMENT 'High-level business category grouping charges for revenue reporting and GL account mapping: service (subscription/plan fees), equipment (CPE/device), penalty (late fees, breach), tax (regulatory levies), discount (promotional credits), surcharge (regulatory recovery fees), interconnect (IOT/wholesale). [ENUM-REF-CANDIDATE: service|equipment|penalty|tax|discount|surcharge|interconnect — promote to reference product]',
    `charge_description` STRING COMMENT 'Human-readable description of the charge as it appears on the customers bill and in customer service interactions. Examples: Monthly Unlimited Plan Fee, iPhone 15 Equipment Charge, Late Payment Penalty. Sourced from Amdocs charge specification.',
    `charge_number` STRING COMMENT 'Externally visible, human-readable business identifier for the charge as displayed on customer bills and used in dispute resolution and customer service interactions within Amdocs Revenue Management.. Valid values are `^CHG-[0-9]{10,15}$`',
    `charge_source` STRING COMMENT 'Originating system that generated or triggered this charge: amdocs (Amdocs Revenue Management automated billing), comverse (Comverse ONE prepaid/real-time charging), manual (agent-applied via CRM), order_management (Oracle OSM order fulfillment), product_catalog (Netcracker catalog-driven), crm (Salesforce CRM agent action).. Valid values are `amdocs|comverse|manual|order_management|product_catalog|crm`',
    `charge_status` STRING COMMENT 'Current lifecycle state of the charge within the billing workflow: pending (created, not yet billed), active (approved for billing), invoiced (included on an invoice), disputed (under customer dispute), waived (forgiven without reversal), cancelled (voided before invoicing), reversed (credited back after invoicing). [ENUM-REF-CANDIDATE: pending|active|invoiced|disputed|waived|cancelled|reversed — promote to reference product]',
    `charge_type` STRING COMMENT 'Classification of the charge by its billing nature: recurring (monthly service fee), one_time (single occurrence), activation (service provisioning fee), equipment (CPE/device charge), late_payment (penalty fee), adjustment (credit or debit correction), or manual (agent-applied charge). [ENUM-REF-CANDIDATE: recurring|one_time|activation|equipment|late_payment|adjustment|manual — promote to reference product]',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA cost center code identifying the organizational unit responsible for this charge for internal financial allocation and OPEX reporting purposes.. Valid values are `^[A-Z0-9]{3,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this charge record was first created in the billing system. Serves as the audit creation timestamp for data lineage, Silver layer ingestion tracking, and compliance with ISO/IEC 27001 audit trail requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the charge amounts are denominated (e.g., USD, EUR, GBP). Supports multi-currency billing for international and roaming scenarios.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of any promotional, loyalty, or contractual discount applied to reduce the gross charge amount. Negative value reduces the net charge. Sourced from Amdocs Revenue Management discount engine.',
    `dunning_level` STRING COMMENT 'Current dunning escalation level for unpaid charges, ranging from 0 (no dunning) to the maximum configured level (e.g., 4 = final notice before collections). Managed by the Amdocs Revenue Management dunning engine for collections workflow.',
    `dunning_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent dunning action taken on this charge (e.g., reminder notice sent, suspension warning issued). Null if dunning_level is 0. Used to track collections escalation timeline.',
    `effective_date` DATE COMMENT 'The business date on which the charge becomes effective and is recognized as a financial obligation on the billing account. Used for revenue recognition alignment per IFRS 15 and for billing cycle proration calculations.',
    `external_reference_number` STRING COMMENT 'External or cross-system reference identifier for this charge, such as a partner billing reference, wholesale interconnect settlement reference (TAP/IOT), or regulatory reporting reference number. Supports reconciliation with partner and regulatory systems.',
    `gl_account_code` STRING COMMENT 'SAP S/4HANA General Ledger account code to which this charge is posted for financial reporting, EBITDA calculation, and revenue recognition. Maps charge categories to the chart of accounts for CAPEX/OPEX classification.. Valid values are `^[0-9]{4,10}$`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Pre-tax, pre-discount gross monetary value of the charge in the billing currency. Represents the base charge amount before any tax calculation or promotional discount is applied. Used as the basis for revenue recognition and MRR reporting.',
    `is_prorated` BOOLEAN COMMENT 'Indicates whether this charge has been prorated to reflect a partial billing period (e.g., mid-cycle activation or cancellation). True when the charge amount has been adjusted proportionally to the number of days in the service period.',
    `mrr_contribution` DECIMAL(18,2) COMMENT 'The portion of this charge that contributes to Monthly Recurring Revenue (MRR) calculations. For recurring charges, this equals the normalized monthly gross amount. Zero for one-time charges. Used in MRR/ARPU reporting and revenue forecasting.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final billable amount after applying discounts and adding taxes: net_amount = gross_amount - discount_amount + tax_amount. This is the amount posted to the customers billing account and reflected on the invoice line.',
    `payment_due_date` DATE COMMENT 'The date by which payment for this charge must be received to avoid late payment penalties and dunning escalation. Derived from the billing cycle due date and any applicable grace period configured in Amdocs Revenue Management.',
    `period_end` DATE COMMENT 'End date of the billing period covered by this charge. Together with charge_period_start, defines the service period for which the recurring or prorated charge applies. Null for one-time charges with no period.',
    `period_start` DATE COMMENT 'Start date of the billing period covered by this charge. Applicable for recurring charges (e.g., monthly plan fee covering 2024-01-01 to 2024-01-31). Used for proration and revenue period matching.',
    `proration_factor` DECIMAL(18,2) COMMENT 'Decimal factor applied to the full-period charge to derive the prorated amount (e.g., 0.516129 for 16 days out of 31). Null when is_prorated is False. Used for revenue assurance validation of prorated charges.',
    `reason_code` STRING COMMENT 'Standardized code identifying the business reason or trigger for the charge (e.g., NEW_ACTIVATION, PLAN_UPGRADE, EQUIPMENT_PURCHASE, LATE_PAYMENT, MANUAL_CREDIT, PRORATION). Used for revenue assurance analysis and dispute management.. Valid values are `^[A-Z0-9_]{2,30}$`',
    `revenue_recognition_date` DATE COMMENT 'The accounting date on which revenue from this charge is recognized in the financial statements per IFRS 15 / ASC 606 performance obligation satisfaction criteria. May differ from effective_date for multi-period or bundled service charges.',
    `source_system_charge_code` STRING COMMENT 'The native charge identifier as recorded in the originating operational system (Amdocs Revenue Management or Comverse ONE). Preserved for cross-system reconciliation, data lineage tracing, and support of revenue assurance processes.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax levied on this charge, including VAT, GST, USF (Universal Service Fund), and other regulatory surcharges as determined by the tax class and jurisdiction. Calculated by the Amdocs tax engine per FCC and ITU regulatory requirements.',
    `tax_class` STRING COMMENT 'Tax classification of the charge that determines the applicable tax treatment and rate. Drives the Amdocs tax engine calculation: taxable (standard rate), exempt (no tax), zero_rated (0% VAT/GST), reduced_rate (preferential rate), regulatory_surcharge (FCC/NTIA mandated levies).. Valid values are `taxable|exempt|zero_rated|reduced_rate|regulatory_surcharge`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Effective tax rate percentage applied to this charge at the time of billing, expressed as a decimal (e.g., 0.0875 for 8.75%). Captured for audit and revenue assurance purposes as rates may change over time.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this charge record was last modified in the billing system. Tracks status changes, amount adjustments, and dispute updates. Used for incremental data pipeline processing in the Databricks Silver layer.',
    `waiver_reason` STRING COMMENT 'Free-text or coded reason explaining why this charge was waived (charge_status = waived). Examples: Customer goodwill gesture, Service outage credit, Regulatory compliance. Required for revenue assurance audit when charges are forgiven.',
    CONSTRAINT pk_billing_charge PRIMARY KEY(`billing_charge_id`)
) COMMENT 'Individual monetary charge applied to a billing account outside of usage rating — including recurring monthly fees, one-time activation fees, equipment charges, late payment fees, and manually applied charges. Captures charge type, charge category, amount, tax class, effective date, charge period, originating product/service reference, and charge status. Distinct from rated_event (usage-based) and invoice_line (bill presentation). Sourced from Amdocs Revenue Management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Unique system-generated identifier for the billing adjustment record. Primary key for the adjustment data product in the Amdocs Revenue Management adjustments module.',
    `billing_account_id` BIGINT COMMENT 'Identifier of the billing account to which this adjustment is applied. Links the adjustment to the customers financial account in Amdocs Revenue Management.',
    `billing_dispute_id` BIGINT COMMENT 'Identifier of the customer dispute or trouble ticket that triggered this adjustment. Supports dispute resolution tracking and SLA breach compensation workflows.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise billing adjustments (retroactive discounts, contract amendments, goodwill credits) require corporate account context for approval threshold enforcement, audit trail compliance, and corporat',
    `employee_id` BIGINT COMMENT 'Identifier of the agent or user who approved this adjustment. Supports authorization audit trails and approval workflow compliance in Amdocs Revenue Management.',
    `invoice_id` BIGINT COMMENT 'Identifier of the invoice to which this adjustment is applied or referenced. Used for overbilling corrections, dispute resolutions, and credit note linkage in Amdocs Revenue Management.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Billing adjustments (credits, debits, waivers) trigger GL postings. Finance teams must trace journal entries to source adjustments for audit, revenue assurance, and SOX compliance. Standard telco mont',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Goodwill credits and billing corrections for package issues. Essential for package adjustment tracking, approval workflows, and revenue impact analysis in telecommunications billing operations.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Billing adjustments related to partner disputes or settlement corrections. Required for partner dispute resolution, settlement reconciliation, and partner-specific billing corrections in telecommunica',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Adjustment processing pipelines must be traceable for compliance reporting, revenue leakage analysis, and audit trail requirements. Critical for identifying which batch process applied credits or debi',
    `regulatory_penalty_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_penalty. Business justification: Adjustments document customer remediation for regulatory violations (unauthorized charge refunds, service quality credits). Real business process: penalty settlements require proof of customer restitu',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Contract-related adjustments for SLA violations, pricing corrections, and service level failures require contract reference for audit trails, revenue recognition adjustments, legal compliance, and con',
    `settlement_dispute_id` BIGINT COMMENT 'Foreign key linking to interconnect.settlement_dispute. Business justification: Billing adjustments for roaming charges must reference wholesale settlement disputes that justified the credit—required for audit trail, revenue assurance, and proving adjustments were based on valida',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: Adjustments credit specific subscribers for service outages, roaming disputes, usage rating errors. Regulatory requirements mandate subscriber-level adjustment audit trails. Direct link enables subscr',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: Adjustments frequently apply to specific service instances for outage credits, proration calculations, and service-level dispute resolution. Required for SLA breach compensation, network downtime cred',
    `vod_asset_id` BIGINT COMMENT 'Foreign key linking to content.vod_asset. Business justification: Manual billing adjustments for VOD transaction errors or goodwill credits. Required for VOD billing correction workflows, audit trails, and content-specific adjustment reporting in telco billing.',
    `adjustment_category` STRING COMMENT 'Business category classifying the nature of the adjustment for reporting, revenue assurance, and analytics purposes. Supports MRR/ARPU impact analysis and churn management reporting. [ENUM-REF-CANDIDATE: goodwill|sla_compensation|dispute_resolution|overbilling_correction|equipment_return|service_outage|promotional|other — promote to reference product]',
    `adjustment_number` STRING COMMENT 'Externally visible, human-readable reference number for the adjustment. Used in customer communications, dispute correspondence, and financial reconciliation. Format: ADJ- followed by 10 digits.. Valid values are `^ADJ-[0-9]{10}$`',
    `adjustment_status` STRING COMMENT 'Current lifecycle state of the adjustment. Pending: awaiting approval. Approved: authorized but not yet applied to the account. Applied: posted to the billing account. Reversed: previously applied adjustment that has been undone. Expired: approved adjustment that was not applied within the validity window.. Valid values are `pending|approved|applied|reversed|expired`',
    `adjustment_type` STRING COMMENT 'Indicates whether the adjustment increases (credit) or decreases (debit) the customers account balance. A credit reduces the amount owed; a debit increases it.. Valid values are `credit|debit`',
    `applied_date` DATE COMMENT 'Date on which the adjustment was posted and applied to the billing account balance. Populated when adjustment_status transitions to applied.',
    `approval_date` DATE COMMENT 'Date on which the adjustment was formally approved by the authorizing agent. Supports approval audit trails and SLA compliance for dispute resolution timelines.',
    `approval_threshold_breached` BOOLEAN COMMENT 'Indicates whether the adjustment amount exceeded the standard agent approval threshold, requiring escalated authorization. Supports revenue assurance controls and fraud prevention.',
    `billing_period_end` DATE COMMENT 'End date of the billing period to which this adjustment relates. Used alongside billing_period_start for period-accurate revenue recognition and financial reporting.',
    `billing_period_start` DATE COMMENT 'Start date of the billing period to which this adjustment relates. Used for period-accurate revenue recognition, MRR reporting, and financial close processes.',
    `cost_center_code` STRING COMMENT 'SAP cost center code associated with this adjustment for internal financial allocation and OPEX reporting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this adjustment record was first created in the system. Supports audit trail, data lineage, and compliance reporting requirements.',
    `credit_note_issue_date` DATE COMMENT 'Date on which the credit note was formally issued to the customer. Populated only when document_type is credit_note. Determines the financial period for revenue recognition and regulatory reporting.',
    `credit_note_number` STRING COMMENT 'Formal reference number of the customer-facing credit note document. Populated only when document_type is credit_note. Used in customer communications, accounts receivable reconciliation, and regulatory financial reporting. Format: CN- followed by 10 digits.. Valid values are `^CN-[0-9]{10}$`',
    `credited_onetime_amount` DECIMAL(18,2) COMMENT 'Portion of the net adjustment amount attributable to one-time charges such as activation fees, equipment charges, or installation fees.',
    `credited_recurring_amount` DECIMAL(18,2) COMMENT 'Portion of the net adjustment amount attributable to recurring subscription or plan charges (e.g., monthly plan fees, MRR components). Supports MRR impact analysis.',
    `credited_usage_amount` DECIMAL(18,2) COMMENT 'Portion of the net adjustment amount attributable to usage charges (e.g., voice, data, SMS). Supports breakdown of credited amounts by charge type for revenue assurance reporting.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this adjustment record (e.g., USD, EUR, GBP). Supports multi-currency billing environments.. Valid values are `^[A-Z]{3}$`',
    `document_type` STRING COMMENT 'Classifies the adjustment as either an internal account balance correction (internal_adjustment) or a formal customer-facing financial document (credit_note). When document_type is credit_note, the credit_note_number and credit_note_issue_date fields are populated.. Valid values are `internal_adjustment|credit_note`',
    `effective_date` DATE COMMENT 'The business date on which the adjustment takes effect on the billing account. Determines the billing period impacted and is used for revenue recognition period alignment.',
    `expiry_date` DATE COMMENT 'Date after which an approved but unapplied adjustment expires and can no longer be applied to the billing account. Supports dunning and collections workflows.',
    `gl_account_code` STRING COMMENT 'General Ledger account code to which this adjustment is posted for financial accounting purposes. Supports SAP S/4HANA integration and revenue recognition journal entries.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The pre-tax gross amount of the adjustment before tax impact is applied. Positive value for credits; negative value for debits. Used in revenue recognition and MRR reporting.',
    `is_customer_visible` BOOLEAN COMMENT 'Indicates whether this adjustment is visible to the customer on their invoice or self-service portal. Internal adjustments may not be customer-facing.',
    `net_amount` DECIMAL(18,2) COMMENT 'Total net amount of the adjustment including gross amount, tax amount, and tax reversal. Represents the actual financial impact posted to the billing account. Used for revenue assurance and ARPU impact reporting.',
    `notes` STRING COMMENT 'Additional free-text notes or comments entered by the agent or system regarding this adjustment. Captures supplementary context not covered by structured fields.',
    `reason_code` STRING COMMENT 'Standardized code identifying the business reason for the adjustment. Examples include: GOODWILL, SLA_BREACH, OVERBILLING, DISPUTE_RESOLUTION, EQUIPMENT_RETURN, SERVICE_OUTAGE, BILLING_ERROR. [ENUM-REF-CANDIDATE: GOODWILL|SLA_BREACH|OVERBILLING|DISPUTE_RESOLUTION|EQUIPMENT_RETURN|SERVICE_OUTAGE|BILLING_ERROR — promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text narrative describing the specific reason for the adjustment, supplementing the reason_code with contextual details such as the nature of the SLA breach, outage duration, or billing discrepancy.',
    `requires_manager_approval` BOOLEAN COMMENT 'Indicates whether this adjustment requires manager-level approval due to amount thresholds, category sensitivity, or policy rules. Drives approval workflow routing in Amdocs Revenue Management.',
    `revenue_recognition_date` DATE COMMENT 'Date on which the adjustment amount was recognized in the financial statements under IFRS 15. Populated when revenue_recognition_flag is true.',
    `revenue_recognition_flag` BOOLEAN COMMENT 'Indicates whether this adjustment has been recognized in the financial revenue recognition process under IFRS 15. Supports financial close and revenue assurance reporting.',
    `reversal_date` DATE COMMENT 'Date on which a previously applied adjustment was reversed. Populated when adjustment_status transitions to reversed. Used for revenue assurance and audit trail purposes.',
    `reversal_reason` STRING COMMENT 'Free-text description of the reason why a previously applied adjustment was reversed. Populated when adjustment_status is reversed. Supports revenue assurance and audit compliance.',
    `source_reference_code` STRING COMMENT 'The native identifier of this adjustment record in the originating source system (e.g., Amdocs internal adjustment ID, Comverse ONE transaction reference). Supports cross-system reconciliation and data lineage.',
    `source_system` STRING COMMENT 'Identifies the operational system of record that originated this adjustment. Supports data lineage, reconciliation, and audit trail requirements across BSS platforms.. Valid values are `amdocs_revenue_management|comverse_one|salesforce_crm|servicenow_itsm|manual`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax component of the adjustment, representing the tax impact associated with the gross adjustment amount. May be positive (credit) or negative (debit) depending on adjustment_type.',
    `tax_exempt` BOOLEAN COMMENT 'Indicates whether this adjustment is exempt from tax calculation. Applicable for certain goodwill credits or adjustments on tax-exempt accounts.',
    `tax_reversal_amount` DECIMAL(18,2) COMMENT 'Amount of tax reversed as part of this adjustment, applicable when the original invoice tax must be partially or fully reversed. Distinct from tax_amount which represents new tax applied to the adjustment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this adjustment record. Supports change tracking, audit compliance, and incremental data pipeline processing in the Databricks Silver Layer.',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Credit or debit adjustment applied to a billing account, serving as SSOT for all account balance corrections including internal adjustments and customer-facing credit note documents. Captures adjustment type (credit/debit), document type (internal adjustment or customer-facing credit note), reason code, amount, tax impact, tax reversal amount, credit note number and issue date (when document type is credit note), approving agent, approval date, reference dispute or ticket ID, reference invoice, credited amount breakdown, and adjustment status (pending, approved, applied, reversed, expired). Covers goodwill credits, SLA breach compensation, dispute resolutions, overbilling corrections, returned equipment credits, and service outage compensation. When document type is credit note, serves as the formal financial document issued to the customer. Sourced from Amdocs Revenue Management adjustments module.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`billing_dispute` (
    `billing_dispute_id` BIGINT COMMENT 'Unique system-generated identifier for the billing dispute record. Primary key for the dispute entity in the Amdocs Revenue Management system.',
    `billing_account_id` BIGINT COMMENT 'Identifier of the billing account against which the dispute has been raised. A customer may have multiple billing accounts (e.g., consumer vs. business lines).',
    `billing_charge_id` BIGINT COMMENT 'Identifier of the specific charge or rated event being disputed. Nullable when the dispute covers an entire invoice rather than a single line item.',
    `case_id` BIGINT COMMENT 'Reference to the associated customer service case in Salesforce CRM Case Management or ServiceNow ITSM, enabling end-to-end dispute-to-case traceability.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise disputes require corporate account context for executive escalation workflows, relationship health scoring, churn risk assessment, and corporate-level dispute trend analysis. B2B dispute ma',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Disputes are raised by specific authorized contacts (account holders, authorized users, corporate account managers). Tracking who raised dispute is critical for authorization validation, communication',
    `employee_id` BIGINT COMMENT 'Identifier of the billing resolution agent or team member currently assigned to investigate and resolve the dispute. Links to the workforce/employee master record.',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Disputes over package features, channel availability, or billing errors. Essential for package dispute management, trend analysis, and service improvement in telecommunications operations.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Billing disputes involving partners (roaming charge disputes, wholesale billing disputes). Required for partner dispute management, settlement dispute resolution, and inter-operator dispute tracking i',
    `previous_dispute_billing_dispute_id` BIGINT COMMENT 'Reference to the earlier dispute record if this is a repeat or re-opened dispute. Enables dispute lineage tracking and repeat-dispute root-cause analysis. Nullable for first-time disputes.',
    `regulatory_penalty_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_penalty. Business justification: Disputes can trigger regulatory penalties (systematic billing errors, cramming violations) or result from penalty-mandated remediation. Real business process: FCC/FTC penalties for billing accuracy vi',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Billing disputes often reference contract terms for SLA violations, pricing disagreements, and service level failures; contract_id is essential for dispute resolution, legal documentation, and contrac',
    `settlement_dispute_id` BIGINT COMMENT 'Foreign key linking to interconnect.settlement_dispute. Business justification: Customer billing disputes for roaming charges often trigger or relate to wholesale settlement disputes with roaming partners—essential for coordinated dispute resolution and determining liability betw',
    `subscriber_id` BIGINT COMMENT 'Identifier of the customer subscription or service agreement to which the disputed charge is associated. Links to the subscription/service master record.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: Disputes reference specific service instances for usage validation, roaming charge verification, and service quality claims. Essential for CDR audit trails, network performance correlation, and regula',
    `vod_asset_id` BIGINT COMMENT 'Foreign key linking to content.vod_asset. Business justification: Customers dispute VOD charges for content not delivered or quality issues. Required for VOD dispute tracking, root cause analysis, and content provider accountability in telco customer care.',
    `approved_credit_amount` DECIMAL(18,2) COMMENT 'The monetary credit amount approved and issued to the customer as the resolution outcome. May be less than, equal to, or zero relative to the disputed amount depending on the resolution decision (upheld, partially upheld, rejected).',
    `billing_period_end` DATE COMMENT 'End date of the billing cycle to which the disputed charge belongs. Used alongside billing_period_start to scope the dispute to a specific invoice period.',
    `billing_period_start` DATE COMMENT 'Start date of the billing cycle to which the disputed charge belongs. Enables period-specific dispute analysis and reconciliation against invoice billing cycles.',
    `cdr_reference` STRING COMMENT 'Reference to the specific Call Detail Record (CDR) or usage event record that is the subject of the dispute. Enables direct linkage between the dispute and the rated usage event in the mediation/rating system.',
    `channel` STRING COMMENT 'Channel through which the customer submitted the billing dispute. Used for channel analytics, agent routing, and omnichannel experience reporting. [ENUM-REF-CANDIDATE: ivr|web_portal|mobile_app|retail_store|call_center|email|chat|written_correspondence — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the dispute record was first created in the data platform. Distinct from raised_timestamp which captures the business event time. Used for audit trail and data lineage.',
    `credit_note_number` STRING COMMENT 'Human-readable credit note reference number generated by Amdocs Revenue Management when a credit is issued as the dispute resolution outcome. Used for customer communication and financial reconciliation.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the disputed and credit amounts (e.g., USD, EUR, GBP). Supports multi-currency billing environments for international and wholesale customers.. Valid values are `^[A-Z]{3}$`',
    `customer_segment` STRING COMMENT 'Market segment of the customer raising the dispute. Drives SLA targets, resolution authority thresholds, and regulatory reporting categorization. MVNO refers to Mobile Virtual Network Operator partners.. Valid values are `consumer|small_business|enterprise|wholesale|mvno`',
    `dispute_number` STRING COMMENT 'Externally-visible, human-readable reference number assigned to the dispute at creation. Used in customer communications, agent workflows, and regulatory correspondence. Format: DSP- followed by 10 digits.. Valid values are `^DSP-[0-9]{10}$`',
    `dispute_status` STRING COMMENT 'Current lifecycle state of the billing dispute. Drives workflow routing in Amdocs and Salesforce CRM. Valid states: open (newly raised), under_review (agent investigating), escalated (referred to senior team or regulator), resolved (outcome determined), closed (credit/adjustment applied and confirmed), withdrawn (customer retracted the dispute).. Valid values are `open|under_review|escalated|resolved|closed|withdrawn`',
    `dispute_type` STRING COMMENT 'Classification of the nature of the billing dispute. Drives routing rules and SLA targets. [ENUM-REF-CANDIDATE: charge_error|service_not_received|unauthorized_charge|roaming_dispute|early_termination_fee|late_payment_fee|promotional_credit_missing|other — promote to reference product]',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The gross monetary amount the customer is disputing, expressed in the billing currency. Represents the full value under contention before any partial resolution.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the dispute has been escalated beyond the first-line resolution team (e.g., to a senior billing specialist, legal team, or external regulator such as FCC or Ofcom). True = escalated.',
    `escalation_level` STRING COMMENT 'Tier to which the dispute has been escalated. tier_1: first-line agent; tier_2: senior billing specialist; tier_3: billing management/legal; regulatory: external regulator (FCC, Ofcom, BEREC).. Valid values are `tier_1|tier_2|tier_3|regulatory`',
    `escalation_reason` STRING COMMENT 'Narrative or coded reason explaining why the dispute was escalated. Populated only when escalation_flag is True. Examples: SLA breach, high-value dispute, regulatory complaint, repeat dispute.',
    `evidence_reference` STRING COMMENT 'Reference identifier or URL pointing to supporting evidence documents (e.g., CDR extracts, call recordings, usage reports, screenshots) stored in the document management system. Supports dispute investigation and audit.',
    `priority` STRING COMMENT 'Priority level assigned to the dispute for workflow queue management. Determined by factors such as disputed amount, customer segment (e.g., enterprise vs. consumer), SLA proximity, and regulatory complaint status.. Valid values are `low|medium|high|critical`',
    `raised_date` DATE COMMENT 'Calendar date on which the customer formally raised the billing dispute. Used for SLA measurement, regulatory reporting, and aging analysis. Distinct from the system record creation timestamp.',
    `raised_timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone offset) at which the dispute was formally submitted by the customer. Used for exact SLA clock-start calculations and audit trail.',
    `reason_code` STRING COMMENT 'Standardized alphanumeric code identifying the specific reason for the dispute as defined in the Amdocs Revenue Management reason code catalog. Used for root-cause analytics and regulatory reporting.. Valid values are `^[A-Z]{2,4}-[0-9]{3}$`',
    `reason_description` STRING COMMENT 'Free-text narrative provided by the customer or agent describing the reason for the dispute. Captured at intake and used for agent context and NLP-based dispute analytics.',
    `regulatory_complaint_flag` BOOLEAN COMMENT 'Indicates whether the dispute has been formally lodged with or referred to a regulatory body (e.g., FCC, Ofcom, BEREC). True = regulatory complaint filed. Triggers mandatory regulatory reporting workflows.',
    `regulatory_reference_number` STRING COMMENT 'Reference number assigned by the regulatory body (e.g., FCC complaint ID, Ofcom case reference) when the dispute has been escalated to a regulator. Nullable when regulatory_complaint_flag is False.',
    `repeat_dispute_flag` BOOLEAN COMMENT 'Indicates whether this dispute is a repeat submission by the same customer for the same or similar charge within a defined lookback window. True = repeat dispute. Used for churn risk analysis and root-cause remediation.',
    `resolution_date` DATE COMMENT 'Calendar date on which the dispute was formally resolved and an outcome was communicated to the customer. Used for SLA compliance reporting and regulatory submissions.',
    `resolution_notes` STRING COMMENT 'Agent-authored narrative summarizing the investigation findings, evidence reviewed, and rationale for the resolution outcome. Retained for audit, regulatory inspection, and quality assurance.',
    `resolution_outcome` STRING COMMENT 'Final decision on the billing dispute. upheld: full credit issued; partially_upheld: partial credit issued; rejected: no credit, charge stands; withdrawn: customer retracted before resolution.. Valid values are `upheld|partially_upheld|rejected|withdrawn`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise date and time at which the dispute resolution was finalized in the system. Used for exact SLA elapsed-time calculations and audit trail integrity.',
    `service_type` STRING COMMENT 'Type of telecommunications service to which the disputed charge relates. Enables service-level dispute analytics and product-specific resolution routing. [ENUM-REF-CANDIDATE: mobile_voice|mobile_data|fixed_broadband|fiber_ftth|iptv|voip|roaming|sms|mms|wholesale — promote to reference product]',
    `sla_breached` BOOLEAN COMMENT 'Indicates whether the dispute resolution exceeded the SLA due date without resolution. True = SLA was breached. Used for regulatory compliance reporting and agent performance management.',
    `sla_due_date` DATE COMMENT 'Target date by which the dispute must be resolved per the applicable SLA or regulatory requirement (e.g., FCC mandates, Ofcom billing dispute resolution timelines). Calculated from raised_date plus the applicable SLA window.',
    `source_system` STRING COMMENT 'Operational system of record from which the dispute record originated. Enables data lineage tracking and cross-system reconciliation. Values: amdocs (Amdocs Revenue Management), salesforce (Salesforce CRM), comverse (Comverse ONE), servicenow (ServiceNow ITSM), manual (manually entered).. Valid values are `amdocs|salesforce|comverse|servicenow|manual`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent modification to the dispute record. Used for change tracking, incremental data pipeline processing, and audit trail integrity.',
    CONSTRAINT pk_billing_dispute PRIMARY KEY(`billing_dispute_id`)
) COMMENT 'Formal record of a customer-initiated billing dispute against a charge, invoice, or rated event. Captures dispute date, disputed amount, dispute reason, supporting evidence references, assigned resolution agent, resolution date, resolution outcome (upheld, partially upheld, rejected), credit issued, and dispute status lifecycle (open, under review, resolved, escalated). Enables dispute management workflow and regulatory compliance tracking.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`dunning_event` (
    `dunning_event_id` BIGINT COMMENT 'Unique surrogate identifier for each dunning action record within the Amdocs Collections dunning engine. Primary key for the dunning_event data product in the billing domain Silver layer.',
    `billing_account_id` BIGINT COMMENT 'Reference to the delinquent billing account against which this dunning action was raised. Links to the billing account master in Amdocs Revenue Management.',
    `billing_dispute_id` BIGINT COMMENT 'Reference to the billing dispute case raised in response to this dunning action. Populated when customer_response_code is DISPUTE_RAISED. Links to the dispute management workflow in Salesforce CRM or ServiceNow ITSM.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: Enterprise collections follow corporate account hierarchies with specialized dunning profiles, executive escalation paths, and relationship-based hold strategies. Corporate account link required for T',
    `dunning_profile_id` BIGINT COMMENT 'Reference to the dunning policy/profile configuration that governs the escalation rules, timing intervals, and communication templates applied to this account segment.',
    `employee_id` BIGINT COMMENT 'Reference to the collections agent or automated system user who executed or supervised this dunning action. Populated for agent-assisted dunning steps; may reference a system agent ID for fully automated actions.',
    `invoice_id` BIGINT COMMENT 'Reference to the primary outstanding invoice that triggered this dunning action. A single dunning event may relate to the oldest or highest-value unpaid invoice on the account.',
    `payment_arrangement_id` BIGINT COMMENT 'Reference to a formal payment arrangement or instalment plan agreed with the customer as an outcome of this dunning action. Links to the payment arrangement entity in Amdocs Revenue Management.',
    `previous_dunning_event_id` BIGINT COMMENT 'Reference to the immediately preceding dunning event on the same billing account in the current collections cycle. Enables traversal of the dunning escalation chain for audit and analytics purposes.',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: Dunning actions execute subscriber-level service controls (suspension, barring, termination) not just account-level notifications. Subscriber-specific dunning enables granular service restriction (bar',
    `action_timestamp` TIMESTAMP COMMENT 'The precise date and time at which this dunning action was executed by the Amdocs Collections dunning engine. This is the principal real-world event time for the dunning event, distinct from record audit timestamps.',
    `agent_notes` STRING COMMENT 'Free-text notes entered by the collections agent during or after the dunning interaction. Captures context not covered by structured fields, such as customer circumstances or negotiation details.',
    `collections_cycle_number` STRING COMMENT 'Sequential number identifying which collections cycle this dunning event belongs to for the billing account. Resets to 1 at the start of each new collections cycle following account resolution. Enables multi-cycle delinquency pattern analysis.',
    `collections_queue` STRING COMMENT 'Name of the collections work queue within the Amdocs Collections dunning engine to which this dunning event was assigned for processing. Used for workload management and agent performance reporting.',
    `communication_channel` STRING COMMENT 'The delivery channel used to communicate this dunning action to the customer. [ENUM-REF-CANDIDATE: SMS|EMAIL|LETTER|IVR|PUSH_NOTIFICATION|AGENT_CALL — promote to reference product]. Valid values are `SMS|EMAIL|LETTER|IVR|PUSH_NOTIFICATION|AGENT_CALL`',
    `communication_template_code` STRING COMMENT 'Code identifying the specific message template used for the dunning communication, as configured in the Amdocs Collections template library. Enables audit of messaging content applied at each dunning level.. Valid values are `^TMPL-[A-Z0-9]{4,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time at which this dunning event record was first created in the source system. Audit trail field for data lineage and Silver layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to all monetary amounts on this dunning event record (e.g., USD, EUR, GBP). Ensures correct financial reporting across multi-currency deployments.. Valid values are `^[A-Z]{3}$`',
    `customer_response_code` STRING COMMENT 'Coded response received from the customer following this dunning action. PAYMENT_PROMISE indicates a commitment to pay by a specified date; DISPUTE_RAISED triggers a billing dispute workflow; HARDSHIP_CLAIM routes to a customer retention or hardship program. [ENUM-REF-CANDIDATE: PAYMENT_PROMISE|PAYMENT_MADE|DISPUTE_RAISED|NO_RESPONSE|CONTACT_REQUESTED|HARDSHIP_CLAIM — promote to reference product]. Valid values are `PAYMENT_PROMISE|PAYMENT_MADE|DISPUTE_RAISED|NO_RESPONSE|CONTACT_REQUESTED|HARDSHIP_CLAIM`',
    `customer_response_timestamp` TIMESTAMP COMMENT 'Date and time at which the customer response to this dunning action was recorded in the collections system. Null if no response was received.',
    `days_overdue` STRING COMMENT 'Number of calendar days the oldest unpaid invoice on the billing account has been past its due date at the time this dunning action was executed. Key metric for collections aging analysis and dunning level eligibility.',
    `delivery_status` STRING COMMENT 'Outcome of the dunning communication delivery attempt via the selected channel. BOUNCED applies to email; OPTED_OUT indicates the customer has unsubscribed from the channel; UNDELIVERED covers SMS/IVR failures.. Valid values are `DELIVERED|UNDELIVERED|BOUNCED|OPTED_OUT|PENDING`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time at which the dunning communication was confirmed as delivered to the customer via the selected channel. Null if delivery has not been confirmed or failed.',
    `dunning_level` STRING COMMENT 'Ordinal stage in the collections escalation workflow at which this dunning action was executed. Progresses from 1ST_NOTICE through to TERMINATION as the account remains delinquent. Sourced from Amdocs Collections dunning engine.. Valid values are `1ST_NOTICE|2ND_NOTICE|SUSPENSION_WARNING|SUSPENSION|TERMINATION`',
    `dunning_segment` STRING COMMENT 'Customer segment classification applied to this dunning event, determining which dunning profile and escalation rules are applicable. MVNO refers to Mobile Virtual Network Operator wholesale customers.. Valid values are `CONSUMER|SMB|ENTERPRISE|WHOLESALE|MVNO`',
    `dunning_status` STRING COMMENT 'Current lifecycle status of this dunning action. PENDING indicates scheduled but not yet executed; SENT indicates dispatched to communication channel; DELIVERED confirms receipt; FAILED indicates delivery failure; CANCELLED indicates the action was voided (e.g., payment received); RESOLVED indicates the delinquency was cleared.. Valid values are `PENDING|SENT|DELIVERED|FAILED|CANCELLED|RESOLVED`',
    `escalation_reason_code` STRING COMMENT 'Coded reason explaining why this dunning event was escalated to the current dunning level (e.g., PROMISE_BROKEN, NO_PAYMENT, PARTIAL_PAYMENT, REPEATED_DELINQUENCY). Sourced from Amdocs Collections dunning engine. [ENUM-REF-CANDIDATE: PROMISE_BROKEN|NO_PAYMENT|PARTIAL_PAYMENT|REPEATED_DELINQUENCY|FIRST_DELINQUENCY|RETURNED_PAYMENT — promote to reference product]',
    `hardship_program_flag` BOOLEAN COMMENT 'Indicates whether the customer has been enrolled in a financial hardship assistance program as a result of this dunning interaction. True when enrolled; False otherwise. Triggers modified dunning rules and retention workflows.',
    `mrr_at_risk_amount` DECIMAL(18,2) COMMENT 'The Monthly Recurring Revenue (MRR) value of the services on the billing account at the time of this dunning action. Quantifies the revenue at risk of churn if the account is terminated, enabling prioritisation of high-value collections efforts.',
    `next_action_date` DATE COMMENT 'The calendar date on which the next dunning escalation action is scheduled to execute if the outstanding balance remains unpaid. Null if the account has been resolved or terminated.',
    `next_dunning_level` STRING COMMENT 'The dunning escalation level that will be applied if the current delinquency is not resolved. NONE indicates this is the final dunning step (termination executed or account resolved). Sourced from the dunning profile escalation rules.. Valid values are `1ST_NOTICE|2ND_NOTICE|SUSPENSION_WARNING|SUSPENSION|TERMINATION|NONE`',
    `outstanding_balance_amt` DECIMAL(18,2) COMMENT 'Total overdue balance on the billing account at the time this dunning action was executed, expressed in the account currency. Represents the gross amount subject to collections at this dunning level.',
    `overdue_amount` DECIMAL(18,2) COMMENT 'The portion of the outstanding balance that is past the payment due date at the time of this dunning action. May differ from outstanding_balance_amt if partial payments have been received or if some charges are not yet due.',
    `promise_to_pay_amount` DECIMAL(18,2) COMMENT 'The monetary amount the customer has committed to pay by the promise_to_pay_date. May be a partial payment arrangement. Null if no payment promise was made.',
    `promise_to_pay_date` DATE COMMENT 'The date by which the customer has committed to settle the outstanding balance, as captured during a PAYMENT_PROMISE response. Used to defer further dunning escalation and monitor promise fulfilment.',
    `ref` STRING COMMENT 'Externally-known business reference number assigned by the Amdocs Collections dunning engine to uniquely identify this dunning action across BSS systems. Used in customer communications and dispute resolution.. Valid values are `^DUN-[0-9]{10,15}$`',
    `regulatory_hold_flag` BOOLEAN COMMENT 'Indicates whether this dunning action has been placed on hold due to a regulatory restriction (e.g., FCC emergency relief orders, Ofcom consumer protection rules, or BEREC guidelines prohibiting disconnection during declared emergencies). True when a regulatory hold is active.',
    `scheduled_action_date` DATE COMMENT 'The calendar date on which this dunning action was originally scheduled to execute per the dunning profile rules. Used for SLA tracking and collections workflow planning.',
    `source_system_code` STRING COMMENT 'Identifies the operational system of record that originated this dunning event record. AMDOCS_COLLECTIONS is the primary source; COMVERSE_ONE applies to prepaid balance depletion dunning; MANUAL covers agent-initiated actions.. Valid values are `AMDOCS_COLLECTIONS|COMVERSE_ONE|MANUAL`',
    `suspension_date` DATE COMMENT 'The date on which the customers services were suspended as a result of this dunning action. Populated only when dunning_level is SUSPENSION. Null for all other dunning levels.',
    `termination_date` DATE COMMENT 'The date on which the customers services were terminated as a result of this dunning action. Populated only when dunning_level is TERMINATION. Null for all other dunning levels.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time at which this dunning event record was most recently modified in the source system. Used for incremental data pipeline processing and audit trail maintenance in the Databricks Lakehouse Silver layer.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'The monetary value of the outstanding balance that was written off as bad debt following this dunning event. Null if write_off_flag is False. Used for revenue assurance, bad debt provisioning, and IFRS 9 impairment reporting.',
    `write_off_date` DATE COMMENT 'The date on which the bad debt write-off was approved and posted in the financial system. Null if write_off_flag is False. Aligns with SAP S/4HANA finance posting date for revenue recognition.',
    `write_off_flag` BOOLEAN COMMENT 'Indicates whether the outstanding balance associated with this dunning event has been written off as a bad debt following failed collections. True when the balance has been written off; False otherwise. Feeds revenue assurance and bad debt reporting.',
    CONSTRAINT pk_dunning_event PRIMARY KEY(`dunning_event_id`)
) COMMENT 'Record of a dunning action taken against a delinquent billing account as part of the collections workflow. Captures dunning level (1st notice, 2nd notice, suspension warning, suspension, termination), action date, outstanding balance at time of action, communication channel used (SMS, email, letter, IVR), agent reference, response received, and next scheduled dunning action. Sourced from Amdocs Collections dunning engine.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` (
    `prepaid_balance_id` BIGINT COMMENT 'Unique surrogate identifier for the prepaid balance record in the Databricks Silver Layer. Primary key for this entity.',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account associated with this prepaid balance. Links to the account master entity in Comverse ONE Balance Management.',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Prepaid subscribers consume balance for content package subscriptions. Required for prepaid content monetization, balance reservation, and package entitlement validation in telecommunications prepaid ',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Balance snapshot pipelines require tracking for reconciliation workflows, fraud detection analytics, and revenue assurance. Enables identification of which ETL run captured specific balance states whe',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Prepaid balances track allowances defined in price plans. Required for balance bucket management, plan change processing, validity period enforcement, and prepaid product analytics. Removes denormaliz',
    `primary_prepaid_migration_target_account_billing_account_id` BIGINT COMMENT 'Reference to the postpaid billing account to which this prepaid balance was migrated. Populated only when balance_status = migrated_to_postpaid. Supports prepaid-to-postpaid migration tracking and balance transfer reconciliation.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to location.service_territory. Business justification: Prepaid subscribers are managed by territory for recharge channel planning, dealer commission allocation by region, regional product availability, and territory-specific promotions. Essential for prep',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: Prepaid balances are tied to physical SIM cards (ICCID/IMSI). Required for prepaid balance management, SIM swap reconciliation, and fraud prevention. Essential for prepaid mobile service operations.',
    `subscriber_id` BIGINT COMMENT 'Reference to the subscriber (customer) who owns this prepaid balance account. Links to the subscriber/customer master entity.',
    `customer_subscription_id` BIGINT COMMENT 'Reference to the active prepaid subscription or service plan associated with this balance record.',
    `activation_date` DATE COMMENT 'Date on which this prepaid balance account was first activated. Marks the start of the subscribers prepaid lifecycle. Used for tenure calculation, cohort analysis, and regulatory reporting.',
    `auto_recharge_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount to be automatically recharged when the auto-recharge trigger threshold is reached. Expressed in the account currency. Configured by the subscriber or defaulted by the plan.',
    `auto_recharge_enabled` BOOLEAN COMMENT 'Indicates whether the subscriber has configured automatic recharge (top-up) to trigger when the main balance falls below the auto_recharge_trigger_threshold. True = auto-recharge active; False = manual recharge only.',
    `auto_recharge_payment_token` STRING COMMENT 'Tokenized reference to the payment instrument (e.g., credit/debit card token, bank account token) used for automatic recharge transactions. The actual card/account details are stored in the payment vault; this token is the PCI-compliant reference. Sourced from Amdocs Revenue Management payment tokenization.',
    `auto_recharge_trigger_threshold` DECIMAL(18,2) COMMENT 'Monetary balance level at which the auto-recharge process is automatically triggered. When main_balance_amount falls at or below this value and auto_recharge_enabled is True, a recharge of auto_recharge_amount is initiated. Expressed in the account currency.',
    `balance_freeze_reason` STRING COMMENT 'Reason code explaining why the balance is in frozen status. Populated only when balance_status = frozen. Supports compliance audit trails and operational workflows. [ENUM-REF-CANDIDATE: fraud_investigation|regulatory_hold|subscriber_request|legal_order|sim_swap_pending — promote to reference product]. Valid values are `fraud_investigation|regulatory_hold|subscriber_request|legal_order|sim_swap_pending`',
    `balance_reference_number` STRING COMMENT 'Externally-known unique alphanumeric reference number for this prepaid balance record, as assigned by Comverse ONE Balance Management. Used in customer-facing communications and balance inquiries.. Valid values are `^BAL-[A-Z0-9]{10,20}$`',
    `balance_snapshot_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent balance snapshot captured from Comverse ONE Balance Management. Indicates the freshness of the balance data in the Silver Layer. Critical for real-time authorization latency monitoring and data quality SLA tracking.',
    `balance_status` STRING COMMENT 'Current lifecycle state of the prepaid balance account. active indicates the balance is usable; expired indicates the validity period has lapsed; frozen indicates the balance is temporarily locked (e.g., fraud hold); migrated_to_postpaid indicates the subscriber has converted to a postpaid plan; suspended indicates service suspension due to non-recharge or regulatory action.. Valid values are `active|expired|frozen|migrated_to_postpaid|suspended`',
    `balance_validity_days` STRING COMMENT 'Number of days the main balance remains valid from the last recharge date. Determines the main_balance_expiry_date. Defined by the subscribers active prepaid plan or recharge denomination.',
    `bonus_balance_amount` DECIMAL(18,2) COMMENT 'Monetary value of promotional or bonus credits awarded to the subscriber (e.g., recharge bonuses, loyalty rewards, campaign credits). Typically consumed after the main balance is exhausted. Expressed in the account currency.',
    `content_credit_balance` DECIMAL(18,2) COMMENT 'Remaining balance in the subscribers dedicated content credit bucket, used for OTT content, IPTV, or digital entertainment purchases. Expressed in the account currency. Sourced from Comverse ONE Balance Management.',
    `content_credit_expiry_date` DATE COMMENT 'Date on which the content credit bucket expires. Unused content credits are forfeited after this date.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the monetary balance amounts on this prepaid account (e.g., USD, EUR, GBP). Determines the denomination of main_balance_amount and all monetary bucket values.. Valid values are `^[A-Z]{3}$`',
    `data_bucket_expiry_date` DATE COMMENT 'Date on which the dedicated mobile data bucket expires. Remaining data allowance is forfeited after this date unless renewed via a recharge or data add-on purchase.',
    `data_bucket_mb` DECIMAL(18,2) COMMENT 'Remaining dedicated mobile data balance in the subscribers data allowance bucket, expressed in megabytes (MB). Decremented in real-time during data sessions via Comverse ONE online charging and DPI-based usage reporting.',
    `deactivation_date` DATE COMMENT 'Date on which this prepaid balance account was deactivated (e.g., after grace period expiry, subscriber-initiated cancellation, or regulatory action). Null if the account is still active. Used for churn analysis and MSISDN recycling workflows.',
    `grace_period_days` STRING COMMENT 'Number of days after the main balance expiry date during which the subscriber may still receive incoming calls/SMS but cannot initiate outgoing services. After the grace period, the account may be deactivated. Defined by regulatory requirements and plan configuration.',
    `grace_period_expiry_date` DATE COMMENT 'Date on which the grace period ends. After this date, the prepaid account may be deactivated and the MSISDN released for recycling if no recharge is made. Calculated as main_balance_expiry_date + grace_period_days.',
    `iccid` STRING COMMENT 'Unique identifier of the physical SIM or eSIM card associated with this prepaid balance account. Used for SIM swap detection, fraud management, and device-balance association. Follows ITU-T E.118 format.. Valid values are `^[0-9]{18,22}$`',
    `imsi` STRING COMMENT 'Unique identifier stored on the SIM/eSIM that identifies the subscriber on the mobile network. Used by the HLR/HSS/UDM for authentication and real-time charging authorization. Classified as restricted PII as it uniquely identifies a subscriber on the network.. Valid values are `^[0-9]{14,15}$`',
    `last_recharge_amount` DECIMAL(18,2) COMMENT 'Monetary value of the most recent recharge (top-up) applied to this prepaid account, expressed in the account currency. Used for ARPU calculation, recharge pattern analysis, and revenue reporting.',
    `last_recharge_channel` STRING COMMENT 'Channel through which the most recent recharge was applied. Supports channel performance analytics and customer journey analysis. [ENUM-REF-CANDIDATE: ussd|ivr|mobile_app|web_portal|retail_store|agent|voucher|bank_transfer — promote to reference product]',
    `last_recharge_date` DATE COMMENT 'Calendar date of the most recent successful recharge (top-up) applied to this prepaid account. Used for churn analysis, recharge frequency reporting, and dormancy detection.',
    `last_recharge_timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone) of the most recent successful recharge event applied to this prepaid account. Provides sub-day precision for real-time authorization and fraud detection workflows.',
    `low_balance_notification_enabled` BOOLEAN COMMENT 'Indicates whether the subscriber has opted in to receive low-balance notifications when the main balance falls below the low_balance_threshold. True = notifications enabled; False = notifications disabled.',
    `low_balance_threshold` DECIMAL(18,2) COMMENT 'Monetary threshold below which a low-balance notification is triggered to the subscriber (e.g., via SMS, push notification, or USSD). Expressed in the account currency. Configurable per subscriber or plan.',
    `main_balance_amount` DECIMAL(18,2) COMMENT 'Current monetary balance available in the subscribers primary prepaid wallet, expressed in the account currency. This is the principal cash-equivalent balance used for general service charges, roaming, and out-of-bundle usage. Sourced from Comverse ONE real-time balance management.',
    `main_balance_expiry_date` DATE COMMENT 'Date on which the main monetary balance expires and becomes unavailable for use if not recharged. After this date, the balance_status transitions to expired. Critical for low-balance notification and recharge prompting workflows.',
    `msisdn` STRING COMMENT 'The subscribers mobile phone number in E.164 format, uniquely identifying the prepaid SIM/eSIM on the network. Used for balance inquiries, recharge operations, and real-time authorization. Classified as PII as it directly identifies an individual subscriber.. Valid values are `^+?[1-9]d{6,14}$`',
    `recharge_count_current_month` STRING COMMENT 'Number of successful recharge transactions applied to this prepaid account in the current calendar month. Supports MRR calculation, monthly ARPU reporting, and recharge frequency analytics.',
    `recharge_count_lifetime` STRING COMMENT 'Total number of successful recharge (top-up) transactions applied to this prepaid account since activation. Used for subscriber loyalty segmentation, ARPU analysis, and churn prediction models.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prepaid balance record was first created in the Databricks Silver Layer. Supports audit trail, data lineage, and compliance reporting requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this prepaid balance record in the Databricks Silver Layer. Used for change data capture (CDC), incremental processing, and audit trail compliance.',
    `reserved_balance_amount` DECIMAL(18,2) COMMENT 'Amount of the main balance currently reserved (locked) for active in-progress sessions (e.g., ongoing voice calls, active data sessions). Prevents double-spending during real-time authorization. Released upon session termination. Sourced from Comverse ONE online charging.',
    `sms_bucket_expiry_date` DATE COMMENT 'Date on which the dedicated SMS units bucket expires. Remaining SMS units are forfeited after this date unless renewed via a recharge or bundle purchase.',
    `sms_bucket_units` DECIMAL(18,2) COMMENT 'Remaining dedicated SMS units in the subscribers SMS allowance bucket. Each unit typically represents one standard SMS message. Decremented in real-time via Comverse ONE charging.',
    `source_system_code` STRING COMMENT 'Identifier of the originating operational system record in Comverse ONE Balance Management from which this prepaid balance record was sourced. Supports data lineage, reconciliation, and audit trail requirements.',
    `voice_bucket_expiry_date` DATE COMMENT 'Date on which the dedicated voice minutes bucket expires. Remaining voice minutes are forfeited after this date unless renewed via a recharge or bundle purchase.',
    `voice_bucket_minutes` DECIMAL(18,2) COMMENT 'Remaining dedicated voice minutes balance in the subscribers voice allowance bucket. Decremented in real-time during voice calls via Comverse ONE real-time rating. Expressed in minutes.',
    CONSTRAINT pk_prepaid_balance PRIMARY KEY(`prepaid_balance_id`)
) COMMENT 'Real-time prepaid account balance record for a subscriber. Captures main monetary balance, dedicated balance buckets (voice minutes, SMS units, data MB/GB, content credits), per-bucket expiry dates, last recharge date/amount/channel, low-balance threshold for notifications, auto-recharge configuration, balance reservation for active sessions, and balance status (active, expired, frozen, migrated-to-postpaid). SSOT for prepaid monetary and unit balances supporting real-time authorization, balance inquiries, and recharge application. Sourced from Comverse ONE Balance Management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`recharge` (
    `recharge_id` BIGINT COMMENT 'Unique system-generated identifier for each prepaid recharge/top-up transaction record in Comverse ONE. Serves as the primary key for this entity.',
    `balance_id` BIGINT COMMENT 'Foreign key linking to usage.usage_balance. Business justification: Recharges can top up usage balances (data/voice bundles) in addition to monetary prepaid_balance. Link required for bundle top-up tracking, bonus allocation, and hybrid prepaid-postpaid scenarios.',
    `billing_account_id` BIGINT COMMENT 'Reference to the prepaid billing account associated with the subscriber in Amdocs Revenue Management. A subscriber may have multiple accounts (e.g., main and data wallet).',
    `employee_id` BIGINT COMMENT 'Reference to the retail agent, dealer, or distributor who processed the recharge on behalf of the subscriber. Populated only for agent-channel recharges. Used for agent commission calculation and channel performance reporting.',
    `location_site_id` BIGINT COMMENT 'Foreign key linking to location.location_site. Business justification: Recharges processed at specific retail sites, kiosks, or dealer locations for dealer settlement, site performance tracking, fraud pattern detection by location, and commission calculation. Role prefix',
    `original_recharge_id` BIGINT COMMENT 'Reference to the original recharge transaction that this record reverses or adjusts. Populated only when reversal_flag is True. Enables audit trail linking between original and reversal transactions.',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Recharge transactions can include content bundle activation (e.g., data+Netflix bundle). Essential for prepaid content bundling, promotional tracking, and partner revenue sharing in telco operations.',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Recharge transaction pipelines must be traceable for revenue assurance, fraud analytics, and distributor commission reconciliation. Critical for identifying which processing run handled specific top-u',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Recharges credit balances per price plan definitions (main balance, data buckets, voice minutes). Essential for applying correct allowances, bonus calculations, and validity extensions per product ter',
    `promotion_id` BIGINT COMMENT 'Reference to the promotional offer applied to this recharge event, if any. Links to the product/promotion catalog in Netcracker OSS/BSS. Null if no promotion was applied.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Prepaid recharge volumes are reported to regulators for market monitoring and AML compliance. Real business process: some jurisdictions require prepaid activation/recharge reporting for fraud monitori',
    `sim_stock_id` BIGINT COMMENT 'Foreign key linking to inventory.sim_stock. Business justification: Recharge transactions must track which SIM card was recharged for fraud prevention, reconciliation, and SIM swap validation. Essential for prepaid recharge processing and revenue assurance.',
    `subscriber_id` BIGINT COMMENT 'Reference to the prepaid subscriber whose balance was recharged. Links to the subscriber/customer master record in the CRM and Comverse ONE.',
    `svc_instance_id` BIGINT COMMENT 'Foreign key linking to service.svc_instance. Business justification: Recharges apply to specific prepaid service instances, not just subscriber-level. Required for multi-SIM accounts, data-only devices (IoT, tablets), and family plan bucket allocation. Critical for pre',
    `voucher_batch_id` BIGINT COMMENT 'Identifier of the voucher production batch from which the recharge voucher was issued. Populated only for voucher-channel recharges. Supports batch-level fraud investigation and distributor reconciliation.',
    `amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the recharge applied to the subscribers prepaid balance, in the transaction currency. This is the face value paid by the subscriber before any tax deductions or bonus credits.',
    `balance_after` DECIMAL(18,2) COMMENT 'The subscribers prepaid main balance immediately after this recharge was applied, as recorded by Comverse ONE. Equals balance_before plus net_credited_amount plus bonus_amount. Used for balance audit trails.',
    `balance_before` DECIMAL(18,2) COMMENT 'The subscribers prepaid main balance immediately before this recharge was applied, as recorded by Comverse ONE real-time balance management. Used for balance reconciliation and fraud detection.',
    `balance_expiry_date` DATE COMMENT 'The new expiry date of the subscribers prepaid balance after this recharge was applied. Recharges typically extend the validity period of the prepaid account. Used for balance lifecycle management and subscriber retention analytics.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Additional bonus credit amount awarded to the subscribers balance as part of a promotional offer associated with this recharge. Separate from the net_credited_amount; tracked for promotional liability and revenue assurance.',
    `channel` STRING COMMENT 'The channel or interface through which the recharge was initiated. Supports channel analytics and commission calculations. [ENUM-REF-CANDIDATE: voucher|online|agent|ussd|bank_transfer|mobile_app|ivr|retailer_pos|direct_debit — promote to reference product if more than 6 values are operationally active]. Valid values are `voucher|online|agent|ussd|bank_transfer|mobile_app`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this recharge record was first created and persisted in the Databricks Silver layer. Serves as the RECORD_AUDIT_CREATED marker for data lineage and audit trail purposes.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the recharge transaction (e.g., USD, EUR, GBP). Required for multi-currency operators and international roaming recharge scenarios.. Valid values are `^[A-Z]{3}$`',
    `data_bonus_mb` DECIMAL(18,2) COMMENT 'Additional data allowance in megabytes (MB) credited to the subscribers data bucket as part of a promotional recharge offer. Null if no data bonus was awarded. Tracked separately from monetary bonus for usage analytics.',
    `failure_reason_code` STRING COMMENT 'Standardized error or failure reason code returned by Comverse ONE or the payment gateway when a recharge transaction fails. Null for successful transactions. Used for failure analysis and NOC troubleshooting.',
    `home_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the subscribers home network. Used for international roaming recharge scenarios and regulatory reporting to FCC/ITU/Ofcom.. Valid values are `^[A-Z]{3}$`',
    `msisdn` STRING COMMENT 'The mobile phone number (MSISDN) of the prepaid subscriber receiving the recharge, in E.164 international format. Used for real-time balance lookup and recharge routing in Comverse ONE.. Valid values are `^+?[1-9]d{6,14}$`',
    `net_credited_amount` DECIMAL(18,2) COMMENT 'The net monetary value actually credited to the subscribers prepaid main balance after tax deductions. Equals recharge_amount minus tax_amount. Used for revenue recognition and balance reconciliation.',
    `network_node_code` STRING COMMENT 'Identifier of the network node (e.g., HLR, HSS, or UDM) that processed the recharge authorization and balance update. Used for network-level troubleshooting and capacity planning in NOC operations.',
    `payment_method` STRING COMMENT 'The payment instrument used to fund the recharge (e.g., credit card, mobile wallet, bank transfer). Distinct from recharge_channel (the interface). Used for payment mix analytics and reconciliation.. Valid values are `credit_card|debit_card|bank_transfer|mobile_wallet|cash|direct_debit`',
    `payment_reference` STRING COMMENT 'External payment gateway or bank transaction reference number associated with this recharge, for non-voucher channels (online, bank transfer, mobile app). Used for payment reconciliation with Amdocs Revenue Management collections.',
    `processing_duration_ms` STRING COMMENT 'Time in milliseconds taken by Comverse ONE to process and complete the recharge transaction from request receipt to balance credit confirmation. Used for SLA monitoring and real-time rating performance analytics.',
    `recharge_date` DATE COMMENT 'Calendar date on which the recharge was applied, derived from recharge_timestamp. Used for daily/monthly MRR reporting, ARPU calculations, and partitioning in the Databricks Silver layer.',
    `recharge_timestamp` TIMESTAMP COMMENT 'The exact date and time (in ISO 8601 format with timezone offset) when the recharge event was processed and the subscribers prepaid balance was credited. This is the principal business event timestamp, distinct from record audit timestamps.',
    `recharge_type` STRING COMMENT 'Classification of the recharge event by its business nature. Distinguishes standard top-ups from promotional, emergency credit, auto-recharge triggers, or gifted recharges from another subscriber.. Valid values are `standard|promotional|bonus|emergency|auto_recharge|gifted`',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this recharge transaction has been reversed or cancelled after initial processing. True = reversed; False = not reversed. Used for revenue assurance and balance reconciliation.',
    `roaming_flag` BOOLEAN COMMENT 'Indicates whether the subscriber was roaming on a visited network at the time of the recharge event. True = subscriber was roaming; False = subscriber was on home network. Relevant for NRTRDE/TAP roaming reconciliation.',
    `sms_bonus_count` STRING COMMENT 'Additional SMS messages credited to the subscribers SMS bucket as part of a promotional recharge offer. Null if no SMS bonus was awarded.',
    `source_system_code` STRING COMMENT 'Identifies the operational source system that originated this recharge record (e.g., Comverse ONE, Amdocs, external payment gateway). Used for data lineage tracking in the Databricks Silver layer.. Valid values are `comverse_one|amdocs|external_gateway|ussd_platform|ivr_platform`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The tax component deducted from or applied to the recharge amount, such as VAT, GST, or excise duty on prepaid top-ups, as applicable per jurisdiction. Part of the MONETARY_TRIPLET for revenue recognition.',
    `tax_rate` DECIMAL(18,2) COMMENT 'The tax rate (as a decimal fraction, e.g., 0.1500 for 15%) applied to this recharge transaction for VAT, GST, or excise duty calculation. Used for tax reporting and revenue recognition compliance.',
    `transaction_reference` STRING COMMENT 'Externally visible, human-readable reference number for the recharge transaction as generated by Comverse ONE or the recharge channel. Used for customer-facing receipts, dispute resolution, and reconciliation with payment gateways.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the recharge transaction as processed by Comverse ONE. success indicates balance was credited; failed indicates processing error; reversed indicates a chargeback or correction; partial indicates partial credit applied.. Valid values are `success|failed|pending|reversed|expired|partial`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this recharge record was last modified in the Databricks Silver layer (e.g., due to a status update, reversal, or correction). Serves as the RECORD_AUDIT_UPDATED marker.',
    `ussd_session_code` STRING COMMENT 'The USSD session identifier from the IMS/HLR for recharges initiated via USSD short codes. Populated only when recharge_channel is ussd. Supports USSD session tracing and troubleshooting.',
    `validity_days` STRING COMMENT 'Number of days of service validity granted to the subscriber by this recharge event. Determines how long the subscriber can use the credited balance before it expires.',
    `voice_bonus_minutes` DECIMAL(18,2) COMMENT 'Additional voice call minutes credited to the subscribers voice bucket as part of a promotional recharge offer. Null if no voice bonus was awarded. Tracked for promotional liability and usage analytics.',
    `voucher_serial_number` STRING COMMENT 'The unique serial number of the physical or electronic prepaid voucher used for this recharge. Populated only when recharge_channel is voucher. Used for voucher fraud detection and inventory reconciliation.',
    CONSTRAINT pk_recharge PRIMARY KEY(`recharge_id`)
) COMMENT 'Transactional record of a prepaid top-up or recharge event applied to a subscribers prepaid balance. Captures recharge date and time, recharge amount, recharge channel (voucher, online, agent, USSD, bank transfer), voucher serial number, promotion applied, bonus credited, balance before and after recharge, and transaction status. Sourced from Comverse ONE real-time rating and balance management.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`rate_plan` (
    `rate_plan_id` BIGINT COMMENT 'Unique surrogate identifier for the rate plan record in the Amdocs Rating engine. Primary key for the rate_plan data product in the billing domain Silver layer.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Rate plan authorship required for pricing governance, regulatory tariff filing audit trail, and product management accountability. Standard telco practice for pricing change control and regulatory com',
    `price_plan_id` BIGINT COMMENT 'Foreign key linking to product.price_plan. Business justification: Billing engine rate plans must reference product catalog price plans to ensure rating configuration matches commercial product definitions. Critical for billing accuracy, price plan migration, and cat',
    `promotion_id` BIGINT COMMENT 'Foreign key linking to sales.promotion. Business justification: Rate plans are frequently tied to promotional campaigns; promotion_id tracks which promotion drove rate plan selection for campaign ROI analysis, promotional effectiveness measurement, and marketing a',
    `activation_fee` DECIMAL(18,2) COMMENT 'One-time fee charged at the time of service activation for this rate plan. Denominated in currency_code. A value of 0 indicates no activation fee. Captured as a one-time charge in Amdocs Revenue Management.',
    `billing_period` STRING COMMENT 'The frequency at which the recurring charge is applied and the billing cycle is closed. Drives invoice generation scheduling in Amdocs Revenue Management.. Valid values are `monthly|quarterly|annual|weekly|daily`',
    `charging_model` STRING COMMENT 'The pricing model applied by the rating engine to calculate charges. flat = fixed charge regardless of usage; tiered = stepped rates at volume thresholds; volume = single rate applied to total volume; event_based = per-event charge; time_based = charge per unit of time.. Valid values are `flat|tiered|volume|event_based|time_based`',
    `contract_term_months` STRING COMMENT 'Minimum contractual commitment period in months associated with this rate plan (e.g., 12, 24, 36 months). A value of 0 indicates a month-to-month or no-commitment plan. Drives early termination fee (ETF) calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this rate plan record was first created in the Amdocs Rating engine and ingested into the Silver layer. Supports audit trail and data lineage tracking per ISO/IEC 27001 information security requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which all monetary amounts on this rate plan are denominated (e.g., USD, EUR, GBP). Required for multi-currency billing environments and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `day_of_week_modifier_enabled` BOOLEAN COMMENT 'Indicates whether this rate plan applies day-of-week pricing modifiers (e.g., weekend discount rates). When TRUE, the rating engine evaluates the CDR date against the configured weekend/weekday windows.',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Fixed monetary penalty charged to a subscriber who cancels the service before the contract_term_months expires. Denominated in currency_code. A value of 0 indicates no early termination fee. Used in churn management and collections workflows.',
    `effective_end_date` DATE COMMENT 'The calendar date after which this rate plan is no longer valid for rating new events. Exclusive boundary. NULL indicates an open-ended plan with no scheduled termination. Used for plan deprecation and migration workflows.',
    `effective_start_date` DATE COMMENT 'The calendar date from which this rate plan becomes active and eligible for rating new subscriptions and usage events. Inclusive boundary. Used for temporal validity checks in the rating engine and revenue recognition.',
    `fair_use_cap_mb` DECIMAL(18,2) COMMENT 'Maximum data volume in megabytes beyond which the fair-use policy is triggered, resulting in speed throttling or additional charges. Distinct from the included_data_volume_mb allowance — this is the absolute ceiling before network management actions are applied. NULL indicates no fair-use cap.',
    `gl_account_code` STRING COMMENT 'The General Ledger account code in SAP S/4HANA to which revenue from this rate plan is posted. Enables financial reporting, EBITDA analysis, and MRR/ARPU reconciliation at the plan level.. Valid values are `^[0-9]{6,10}$`',
    `included_data_volume_mb` DECIMAL(18,2) COMMENT 'Data volume allowance included in the base recurring charge, expressed in megabytes (MB). A value of -1 or NULL indicates unlimited data. The rating engine deducts consumed data against this allowance before applying overage rates or fair-use policy throttling.',
    `included_sms_count` STRING COMMENT 'Number of SMS messages included in the base recurring charge before overage rates apply. A value of -1 or NULL indicates unlimited SMS. Used by the rating engine for SMS CDR allowance tracking.',
    `included_voice_minutes` DECIMAL(18,2) COMMENT 'Number of voice call minutes included in the rate plans base recurring charge before overage rates apply. A value of -1 or NULL indicates unlimited voice. Used by the rating engine to track allowance consumption against CDRs.',
    `is_promotional` BOOLEAN COMMENT 'Indicates whether this rate plan is a promotional or limited-time offer. When TRUE, the plan may have an associated promotion expiry date and is tracked separately in ARPU and MRR reporting to distinguish promotional revenue from base revenue.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this rate plan record was last updated in the source system or Silver layer. Used for incremental ETL processing, change detection, and audit compliance.',
    `market_segment` STRING COMMENT 'Commercial market segment for which this rate plan is designed. Drives eligibility rules in the product catalog and CRM. consumer = individual retail customers; smb = Small and Medium Business; enterprise = large corporate accounts; wholesale = carrier/MVNO partners; government = public sector accounts.. Valid values are `consumer|smb|enterprise|wholesale|government`',
    `off_peak_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to the base rate during off-peak hours when time_of_day_modifier_enabled is TRUE. A value of 0.5 means 50% discount during off-peak. NULL when time-of-day pricing is not enabled.',
    `overage_rate_per_unit` DECIMAL(18,2) COMMENT 'The per-unit charge applied to usage that exceeds the included allowance. The unit of measure is defined by overage_unit_of_measure. For data, this is typically per MB or per GB; for voice, per minute; for SMS, per message. Denominated in currency_code.',
    `overage_unit_of_measure` STRING COMMENT 'The unit of measure against which the overage_rate_per_unit is applied. Defines the granularity of overage billing (e.g., per MB for data, per minute for voice, per message for SMS). [ENUM-REF-CANDIDATE: MB|GB|minute|second|message|event|kB — 7 candidates stripped; promote to reference product]',
    `peak_end_time` TIMESTAMP COMMENT 'The daily end time (HH:MM, 24-hour format) of the peak pricing window. Used by the rating engine to determine whether a CDR falls within peak or off-peak hours. NULL when time-of-day pricing is not enabled.',
    `peak_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to the base rate during peak hours when time_of_day_modifier_enabled is TRUE. A value of 1.0 means no adjustment; 1.5 means 50% premium during peak. NULL when time-of-day pricing is not enabled.',
    `peak_start_time` TIMESTAMP COMMENT 'The daily start time (HH:MM, 24-hour format) of the peak pricing window. Used by the rating engine to determine whether a CDR falls within peak or off-peak hours. NULL when time-of-day pricing is not enabled.',
    `plan_status` STRING COMMENT 'Current lifecycle state of the rate plan within the Amdocs Rating engine. Controls whether the plan is available for new subscriptions and active rating. draft = under configuration; active = live for rating; suspended = temporarily halted; deprecated = replaced by a newer plan; inactive = decommissioned.. Valid values are `active|inactive|draft|deprecated|suspended`',
    `plan_type` STRING COMMENT 'Billing modality of the rate plan. postpaid = charges billed after consumption cycle; prepaid = charges deducted from pre-loaded balance via Comverse ONE real-time rating; hybrid = mixed prepaid/postpaid; wholesale = inter-operator or MVNO wholesale pricing; mvno = Mobile Virtual Network Operator resale pricing.. Valid values are `postpaid|prepaid|hybrid|wholesale|mvno`',
    `promotion_end_date` DATE COMMENT 'The date on which the promotional pricing expires and the standard rate plan pricing takes effect. Applicable only when is_promotional is TRUE. NULL for non-promotional plans.',
    `proration_method` STRING COMMENT 'Method used to calculate partial-period charges when a subscription starts or ends mid-billing-cycle. daily = charge proportional to days active; full_period = charge full cycle regardless; none = no proration applied.. Valid values are `daily|none|full_period`',
    `rate_plan_code` STRING COMMENT 'Externally-known alphanumeric code that uniquely identifies the rate plan within the Amdocs Rating engine and is referenced by downstream billing, CDR processing, and invoice generation systems. Used as the business key for cross-system reconciliation.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `rate_plan_description` STRING COMMENT 'Detailed narrative description of the rate plans pricing logic, applicable services, and commercial intent. Used by product managers, billing analysts, and regulatory reporting teams to understand the plans scope.',
    `rate_plan_name` STRING COMMENT 'Human-readable name of the rate plan as displayed in the Amdocs Rating engine configuration and referenced in billing statements and internal reporting (e.g., Unlimited 5G Consumer Postpaid, SMB Data Tier 3).',
    `rate_tier_count` STRING COMMENT 'Number of pricing tiers (step thresholds) defined for this rate plan. A value of 1 indicates flat-rate pricing; values greater than 1 indicate tiered/stepped pricing where different rates apply at different usage volumes. Drives the rating engines tier evaluation logic.',
    `rating_method` STRING COMMENT 'Indicates whether usage events (CDRs) under this rate plan are rated in real-time (online charging via Comverse ONE for prepaid) or in batch mode (offline charging via Amdocs for postpaid), or a hybrid of both.. Valid values are `real_time|batch|hybrid`',
    `recurring_charge_amount` DECIMAL(18,2) COMMENT 'The fixed periodic charge applied to a subscription on this rate plan per billing cycle (e.g., monthly base fee). Represents the Monthly Recurring Revenue (MRR) component at the plan level. Denominated in the currency specified by currency_code.',
    `revenue_recognition_code` STRING COMMENT 'Code that maps this rate plan to the appropriate revenue recognition treatment in SAP S/4HANA Finance. Determines how recurring and one-time charges are recognized over the contract term per IFRS 15 / ASC 606 performance obligation rules.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `roaming_data_rate_per_mb` DECIMAL(18,2) COMMENT 'Per-megabyte charge applied to data usage while roaming internationally, denominated in currency_code. Applies when roaming_enabled is TRUE and the subscriber is on a visited network. Used for IOT (Inter-Operator Tariff) reconciliation.',
    `roaming_enabled` BOOLEAN COMMENT 'Indicates whether international roaming usage is permitted and rated under this rate plan. When FALSE, roaming CDRs are blocked or rated at a default barring rate. Relevant for NRTRDE/TAP roaming data exchange compliance.',
    `roaming_voice_rate_per_min` DECIMAL(18,2) COMMENT 'Per-minute charge applied to voice calls while roaming internationally, denominated in currency_code. Applies when roaming_enabled is TRUE. Used for IOT reconciliation and NRTRDE reporting.',
    `service_type` STRING COMMENT 'The telecommunications service category to which this rate plan applies. Determines which usage event types (CDRs) are rated against this plan. [ENUM-REF-CANDIDATE: voice|data|sms|roaming|iot|iptv|voip|mms — promote to reference product]',
    `source_system_code` STRING COMMENT 'Identifier of the operational source system from which this rate plan record was extracted (e.g., AMDOCS_RATING, COMVERSE_ONE). Supports data lineage, multi-source reconciliation, and Silver layer provenance tracking.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `tax_class_code` STRING COMMENT 'Tax classification code assigned to this rate plan, used by the Amdocs tax engine to determine applicable tax rates (e.g., USF, VAT, GST, E911 surcharges). Maps to the tax jurisdiction configuration in the billing system.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `technology_type` STRING COMMENT 'The radio access or fixed-line network technology to which this rate plan applies. Used by the rating engine to apply technology-specific pricing tiers (e.g., 5G NR premium data rates vs LTE standard rates). [ENUM-REF-CANDIDATE: 2G|3G|4G_LTE|5G_NR|FTTH|GPON|ADSL|VDSL|WIFI — promote to reference product]',
    `tier_rate_1` DECIMAL(18,2) COMMENT 'Per-unit charge applied to usage within the first pricing tier (from 0 to tier_threshold_1_mb). Denominated in currency_code per overage_unit_of_measure.',
    `tier_rate_2` DECIMAL(18,2) COMMENT 'Per-unit charge applied to usage within the second pricing tier (from tier_threshold_1_mb to tier_threshold_2_mb). Denominated in currency_code per overage_unit_of_measure. NULL if fewer than 2 tiers.',
    `tier_rate_3` DECIMAL(18,2) COMMENT 'Per-unit charge applied to usage beyond tier_threshold_2_mb (third tier and above). Denominated in currency_code per overage_unit_of_measure. NULL if fewer than 3 tiers.',
    `tier_threshold_1_mb` DECIMAL(18,2) COMMENT 'Usage volume threshold in MB at which the first pricing tier ends and the second tier begins. NULL if the plan has fewer than 2 tiers. Used by the Amdocs rating engine for stepped-rate calculation.',
    `tier_threshold_2_mb` DECIMAL(18,2) COMMENT 'Usage volume threshold in MB at which the second pricing tier ends and the third tier begins. NULL if the plan has fewer than 3 tiers.',
    `time_of_day_modifier_enabled` BOOLEAN COMMENT 'Indicates whether this rate plan applies time-of-day pricing modifiers (e.g., peak/off-peak rates). When TRUE, the rating engine evaluates the CDR timestamp against the defined peak/off-peak windows to apply the appropriate rate multiplier.',
    `version_number` STRING COMMENT 'Monotonically incrementing version counter for this rate plan record. Incremented each time the plan configuration is modified. Supports audit trail, change management, and point-in-time rating reconstruction for dispute resolution.',
    `weekend_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to the base rate on weekend days (Saturday and Sunday) when day_of_week_modifier_enabled is TRUE. A value of 0.0 means free weekend calls/data. NULL when day-of-week pricing is not enabled.',
    CONSTRAINT pk_rate_plan PRIMARY KEY(`rate_plan_id`)
) COMMENT 'Master definition of a pricing rate plan used by the rating engine to price usage events and recurring charges. Captures rate plan code, name, applicable service type (voice, data, SMS, roaming, IoT), rate tiers and step thresholds, unit of measure, included allowances and fair-use caps, overage rates, time-of-day and day-of-week modifiers, effective date range, currency, and applicable market segment (consumer, SMB, enterprise, wholesale). Distinct from the commercial product catalog (product domain) — this is the financial pricing engine configuration that translates catalog offers into monetary amounts. Sourced from Amdocs Rating engine.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`credit_note` (
    `credit_note_id` BIGINT COMMENT 'Unique surrogate identifier for the credit note record in the billing system. Primary key for the credit_note data product in the Databricks Silver Layer.',
    `adjustment_id` BIGINT COMMENT 'Reference to the internal billing adjustment that resulted in this customer-facing credit note. Nullable — populated when the credit note is the external representation of an internal adjustment record in Amdocs Revenue Management.',
    `billing_account_id` BIGINT COMMENT 'Reference to the billing account to which this credit note is issued. Links the credit note to the customers billing account in the BSS platform for account-level financial reconciliation and ARPU reporting.',
    `billing_dispute_id` BIGINT COMMENT 'Reference to the customer dispute or complaint that triggered the issuance of this credit note. Nullable — populated only when the credit note originates from a formal dispute resolution process in Salesforce CRM or ServiceNow ITSM.',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to enterprise.corporate_account. Business justification: SLA breach credits, service failure compensations, and contract amendment credits must link to corporate accounts for consolidated credit management, contract compliance tracking, and corporate-level ',
    `cpe_asset_id` BIGINT COMMENT 'Foreign key linking to inventory.cpe_asset. Business justification: Credits for faulty equipment, early returns, or service outages caused by equipment failure must reference the asset. Required for equipment-related credit processing, warranty tracking, and customer ',
    `invoice_id` BIGINT COMMENT 'Reference to the original invoice against which this credit note is raised. Establishes the financial linkage between the credit note and the source billing document for revenue reversal and reconciliation purposes.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Credit notes impact revenue recognition and require employee accountability for audit and performance tracking. Real business process: dispute resolution metrics, regulatory compliance. Replaces denor',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Credit notes generate GL entries for revenue reversals and liability recognition. Finance links journal postings to originating credit notes for revenue recognition adjustments and financial statement',
    `package_id` BIGINT COMMENT 'Foreign key linking to content.content_package. Business justification: Credits for content package service outages or feature unavailability. Essential for SLA-based credit automation, package dispute resolution, and regulatory compliance in telecommunications billing.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner. Business justification: Credit notes issued to partners for billing corrections or SLA breaches. Required for partner credit management, SLA penalty application, and partner financial reconciliation in telecommunications ope',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Credits for SLA breaches, early termination refunds, and contract amendment adjustments require contract reference for revenue recognition reversal, regulatory compliance reporting, and contract perfo',
    `settlement_dispute_id` BIGINT COMMENT 'Foreign key linking to interconnect.settlement_dispute. Business justification: Credit notes issued for roaming overcharges must reference wholesale settlement disputes that validated the error—critical for financial reconciliation, audit compliance, and tracking wholesale disput',
    `spec_id` BIGINT COMMENT 'Reference to the product or tariff plan associated with the credited charge. Enables product-level credit analysis and supports product catalog management reporting in Netcracker OSS/BSS.',
    `subscriber_id` BIGINT COMMENT 'Foreign key linking to customer.subscriber. Business justification: Credit notes for subscriber-specific service failures (network outage affecting specific cell tower, roaming overcharge for specific MSISDN, VoLTE quality issue) require direct subscriber link for acc',
    `svc_instance_id` BIGINT COMMENT 'Reference to the specific service (e.g., mobile line, broadband, IPTV, VoIP) for which the credit is being issued. Nullable — populated when the credit is attributable to a specific service instance rather than the entire account.',
    `trouble_ticket_id` BIGINT COMMENT 'Foreign key linking to assurance.trouble_ticket. Business justification: Credit notes issued for service failures reference originating trouble tickets. Standard customer compensation workflow linking financial credits to documented service issues for audit trail, regulato',
    `vod_asset_id` BIGINT COMMENT 'Foreign key linking to content.vod_asset. Business justification: Credits issued for failed VOD playback, buffering issues, or content quality problems. Required for VOD quality dispute resolution, SLA compliance tracking, and content provider performance management',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to workforce.work_order. Business justification: Service outage credits and SLA breach compensations are directly tied to failed/delayed work orders (installations, repairs) for cost recovery from contractors and root cause analysis. Telecommunicati',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the total credit amount that has been applied against invoices or account balances to date. Enables tracking of partial credit consumption and remaining credit balance for aged credit analysis.',
    `applied_date` DATE COMMENT 'The date on which the credit note was fully or partially applied against an invoice or account balance. Nullable until the credit is consumed. Used for cash flow and revenue reconciliation reporting.',
    `approval_status` STRING COMMENT 'The approval workflow status of the credit note. pending = awaiting manager/finance approval; approved = authorized for issuance; rejected = denied by approver; auto_approved = system-approved within automated threshold limits in Amdocs Revenue Management.. Valid values are `pending|approved|rejected|auto_approved`',
    `approved_by` STRING COMMENT 'The employee ID or username of the billing manager or finance officer who approved the credit note issuance. Nullable for auto-approved credits. Required for SOX compliance audit trails and segregation of duties controls.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the credit note was approved by the authorized approver. Nullable for auto-approved or pending credits. Used for approval SLA monitoring and SOX audit compliance.',
    `billing_period_end` DATE COMMENT 'The end date of the billing period to which this credit note relates. Together with billing_period_start, defines the revenue period impacted by this credit for financial reporting and revenue assurance.',
    `billing_period_start` DATE COMMENT 'The start date of the billing period to which this credit note relates. Used to associate the credit with the correct revenue period for IFRS 15 revenue recognition reversal and MRR impact reporting.',
    `cost_center_code` STRING COMMENT 'The SAP S/4HANA cost center code associated with the business unit responsible for the credit note. Used for internal financial reporting, OPEX allocation, and departmental P&L analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the credit note record was first created in the billing system or data platform. Serves as the RECORD_AUDIT_CREATED marker for data lineage, audit trails, and Silver Layer ingestion tracking.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The gross pre-tax credit amount to be applied to the customers account, expressed in the billing currency. Represents the principal financial value of the credit note before tax reversal. Core component of the MONETARY_TRIPLET for revenue reversal reporting.',
    `credit_category` STRING COMMENT 'The billing charge category being credited. Identifies whether the credit relates to recurring service charges, usage-based charges (CDR-level), equipment fees, tax adjustments, interconnect/wholesale charges, or roaming charges. Supports revenue assurance and MRR impact analysis.. Valid values are `service_charge|usage_charge|equipment|tax|interconnect|roaming`',
    `credit_note_number` STRING COMMENT 'Externally-visible, human-readable unique identifier for the credit note as printed on the customer-facing financial document. Assigned by Amdocs Revenue Management upon issuance. Used for customer correspondence, dispute tracking, and audit trails.. Valid values are `^CN-[0-9]{10}$`',
    `credit_note_status` STRING COMMENT 'Current lifecycle state of the credit note. issued = generated and sent to customer; applied = fully offset against an invoice or balance; partially_applied = partially consumed; expired = validity period lapsed without full application; cancelled = withdrawn before application; voided = reversed post-issuance for error correction. [ENUM-REF-CANDIDATE: issued|applied|partially_applied|expired|cancelled|voided — promote to reference product]. Valid values are `issued|applied|partially_applied|expired|cancelled|voided`',
    `credit_note_type` STRING COMMENT 'Classification of the credit note by its business nature. financial = billing error correction; commercial = commercial dispute resolution; regulatory = mandated by FCC/Ofcom/BEREC regulatory ruling; goodwill = customer retention gesture; equipment_return = CPE/ONT/OLT equipment return credit.. Valid values are `financial|commercial|regulatory|goodwill|equipment_return`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this credit note (e.g., USD, EUR, GBP). Required for multi-currency billing environments and international roaming credit scenarios.. Valid values are `^[A-Z]{3}$`',
    `delivery_channel` STRING COMMENT 'The channel through which the credit note document was delivered to the customer. Supports omnichannel customer communication tracking and digital delivery compliance requirements.. Valid values are `email|portal|post|sms|in_app`',
    `delivery_timestamp` TIMESTAMP COMMENT 'The timestamp when the credit note document was delivered to the customer via the specified delivery channel. Used for customer communication audit trails and regulatory compliance with billing notification requirements.',
    `effective_date` DATE COMMENT 'The date from which the credit note becomes effective for application against the customers account balance or future invoices. May differ from issue_date when backdated credits are applied for service outage periods.',
    `expiry_date` DATE COMMENT 'The date after which the credit note can no longer be applied to the customers account. Nullable for credits with no expiry. Used for dunning management and aged credit reporting.',
    `gl_account_code` STRING COMMENT 'The General Ledger account code in SAP S/4HANA to which the credit note reversal is posted. Enables financial reconciliation between the billing system (Amdocs) and the ERP (SAP S/4HANA) for period-close and audit purposes.',
    `is_regulatory_mandated` BOOLEAN COMMENT 'Indicates whether this credit note was issued as a result of a regulatory mandate from FCC, Ofcom, BEREC, or other governing body. True = regulatory-mandated credit; False = commercially or operationally initiated. Used for regulatory reporting and compliance tracking.',
    `issue_date` DATE COMMENT 'The calendar date on which the credit note was formally issued to the customer. This is the principal business event date printed on the credit note document and used for revenue recognition reversal under IFRS 15.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to the credit note record. Serves as the RECORD_AUDIT_UPDATED marker for change data capture (CDC) processing in the Databricks Silver Layer and audit compliance.',
    `outage_duration_minutes` STRING COMMENT 'The total duration of the service outage in minutes, used as the basis for calculating SLA-based credit amounts. Derived from outage start and end timestamps but stored explicitly for audit and regulatory reporting to FCC/Ofcom.',
    `outage_end_timestamp` TIMESTAMP COMMENT 'The timestamp when the service outage or degradation was resolved. Together with outage_start_timestamp, defines the outage duration used to calculate the credit amount for SLA breach compensation.',
    `outage_start_timestamp` TIMESTAMP COMMENT 'The timestamp when the service outage or degradation began, for credits issued due to SLA breaches or network outages. Nullable — populated only for outage-related credit notes. Links to NOC incident records.',
    `reason_code` STRING COMMENT 'Standardized code identifying the business reason for issuing the credit note. Examples include: OVERBILLING, SVC_OUTAGE, EQUIP_RETURN, DISPUTE_RESOLUTION, GOODWILL, RATE_ERROR, PROMO_ADJUSTMENT. Drives revenue assurance analytics and root cause reporting. [ENUM-REF-CANDIDATE: OVERBILLING|SVC_OUTAGE|EQUIP_RETURN|DISPUTE_RESOLUTION|GOODWILL|RATE_ERROR|PROMO_ADJUSTMENT — promote to reference product]',
    `reason_description` STRING COMMENT 'Free-text narrative description of the reason for issuing the credit note, providing additional context beyond the reason_code. Populated by billing agents or automated systems in Amdocs Revenue Management. Used for customer communication and audit documentation.',
    `regulatory_reference` STRING COMMENT 'The specific regulatory ruling, order number, or compliance reference that mandated this credit note. Nullable — populated only when is_regulatory_mandated is True. Required for FCC/Ofcom regulatory reporting submissions.',
    `remaining_credit_amount` DECIMAL(18,2) COMMENT 'The unapplied balance of the credit note (total_credit_amount minus applied_amount). Represents the credit still available for future application. Used for credit liability reporting and customer account balance management.',
    `revenue_recognition_period` STRING COMMENT 'The accounting period (YYYY-MM format) in which the revenue reversal from this credit note is recognized under IFRS 15 / ASC 606. Used by SAP S/4HANA Finance for general ledger posting and period-close reporting.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `source_reference_number` STRING COMMENT 'The native identifier of this credit note in the originating source system (e.g., Amdocs internal credit note ID, Comverse ONE transaction reference). Enables cross-system traceability and reconciliation between the lakehouse Silver Layer and operational BSS/CRM systems.',
    `source_system` STRING COMMENT 'The operational system of record that originated this credit note. amdocs = Amdocs Revenue Management (postpaid billing); comverse_one = Comverse ONE (prepaid balance management); salesforce = Salesforce CRM (dispute-driven); servicenow = ServiceNow ITSM (incident-driven); manual = manually entered by billing agent.. Valid values are `amdocs|comverse_one|salesforce|servicenow|manual`',
    `tax_code` STRING COMMENT 'The tax jurisdiction or tax type code applied to the credit note for tax reversal calculation. Aligns with the tax code on the original invoice. Used for tax authority reporting and VAT/GST compliance.',
    `tax_jurisdiction` STRING COMMENT 'The geographic tax jurisdiction (e.g., state, country, municipality) applicable to the tax reversal on this credit note. Required for multi-jurisdiction tax compliance reporting to federal, state, and local tax authorities.',
    `tax_reversal_amount` DECIMAL(18,2) COMMENT 'The tax component reversed as part of this credit note, corresponding to the tax originally charged on the credited amount. Enables accurate tax liability adjustments and compliance with tax authority reporting requirements.',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'The total credit amount inclusive of tax reversal (credit_amount + tax_reversal_amount). This is the net financial value credited to the customers account and the figure printed on the customer-facing credit note document.',
    CONSTRAINT pk_credit_note PRIMARY KEY(`credit_note_id`)
) COMMENT 'Formal financial document issued to a customer to credit their account for overbilling, service outages, returned equipment, or dispute resolutions. Captures credit note number, issue date, credited amount, tax reversal amount, reason code, reference invoice, reference dispute or adjustment, and credit note status (issued, applied, expired). Distinct from adjustment (internal) — credit note is a customer-facing financial document.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`write_off` (
    `write_off_id` BIGINT COMMENT 'Unique surrogate identifier for the write-off record in the Amdocs Collections system. Primary key for the write_off data product in the Databricks Silver Layer.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to people.employee. Business justification: Write-offs are material financial decisions requiring documented approval chain for bad debt management and SOX compliance. Distinct from processing employee. Replaces denormalized approving_authority',
    `billing_dispute_id` BIGINT COMMENT 'Reference to the associated billing dispute record if the written-off balance was subject to a formal dispute. Populated only when dispute_flag is True.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer (subscriber or business entity) whose outstanding balance is being written off. Links to the customer master record in Salesforce CRM / Amdocs.',
    `case_id` BIGINT COMMENT 'Reference to the dunning case that was exhausted prior to initiating the write-off. Confirms that all collection attempts were made before write-off approval.',
    `invoice_id` BIGINT COMMENT 'Reference to the original invoice that generated the uncollectable outstanding balance subject to write-off. Links to the invoice master in Amdocs Revenue Management.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Write-offs create GL postings for bad debt expense and AR reduction. Finance must link journal entries to write-off events for allowance for doubtful accounts reconciliation and regulatory reporting.',
    `recovery_agency_id` BIGINT COMMENT 'Reference to the third-party debt recovery agency to which the written-off account has been assigned for collection. Populated when write_off_status transitions to sent_to_agency.',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Write-offs of contract-related receivables require contract reference for revenue recognition reversal, legal documentation, contract performance analysis, and early termination financial impact asses',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to workforce.work_order. Business justification: Uncollectible amounts stemming from unresolved service delivery disputes (customer refuses payment due to installation defects, repeated outages) require work order attribution to determine contractor',
    `agency_assignment_date` DATE COMMENT 'Date on which the written-off account was formally assigned to the third-party recovery agency. Marks the start of the external collection process.',
    `agency_reference_number` STRING COMMENT 'External reference number assigned by the third-party recovery agency to track this write-off case within their own system. Used for reconciliation between Amdocs Collections and the agency.',
    `aging_bucket` STRING COMMENT 'Receivables aging classification of the outstanding balance at the time of write-off, indicating how long the debt has been overdue (30, 60, 90, or 120+ days). Used for bad debt provisioning and revenue assurance reporting.. Valid values are `30_days|60_days|90_days|120_plus_days`',
    `amount` DECIMAL(18,2) COMMENT 'Gross monetary amount of the outstanding balance being written off, expressed in the account billing currency. Represents the full uncollectable debt before any partial recovery deductions.',
    `approval_date` DATE COMMENT 'Calendar date on which the write-off was formally approved by the designated approving authority. Used for audit trail, SOX compliance, and separation of duties verification.',
    `approval_reference` STRING COMMENT 'Unique reference number or ticket ID from the approval workflow (e.g., ServiceNow change/approval record) authorizing the write-off. Supports audit trail and regulatory compliance.',
    `billing_segment` STRING COMMENT 'Customer billing segment classification at the time of write-off (e.g., consumer, SMB, enterprise, wholesale, MVNO). Enables segmented bad debt analysis and ARPU/MRR impact reporting.. Valid values are `consumer|small_medium_business|enterprise|wholesale|mvno`',
    `collection_attempts_count` STRING COMMENT 'Total number of collection contact attempts made against the account prior to write-off (calls, letters, emails, SMS). Evidences due diligence for regulatory and audit purposes.',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA cost center to which the bad debt expense is allocated. Enables departmental P&L reporting and OPEX tracking for the collections function.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the write-off record was first created and persisted in the Databricks Silver Layer. Used for audit trail, data lineage, and SLA compliance tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the write-off amount (e.g., USD, EUR, GBP). Supports multi-currency operations across international telecommunications markets.. Valid values are `^[A-Z]{3}$`',
    `days_overdue` STRING COMMENT 'Exact number of calendar days the outstanding balance has been overdue at the time of write-off. Provides precise aging data beyond the bucket classification for analytics and provisioning models.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the written-off balance was subject to a customer dispute at any point during the collections process. Relevant for regulatory reporting and revenue assurance investigations.',
    `dunning_stage_at_writeoff` STRING COMMENT 'The final dunning stage reached before the write-off was initiated (e.g., Final Notice, Legal Warning, Pre-Legal). Confirms exhaustion of the dunning process and supports regulatory compliance documentation.',
    `gl_account_code` STRING COMMENT 'SAP S/4HANA General Ledger account code to which the write-off amount is posted (e.g., bad debt expense account). Required for financial reporting, revenue assurance, and audit compliance.',
    `invoice_date` DATE COMMENT 'Date of the original invoice that generated the uncollectable balance. Used for aging calculation, statute of limitations assessment, and regulatory reporting.',
    `legal_action_flag` BOOLEAN COMMENT 'Indicates whether legal proceedings were initiated against the customer prior to or concurrent with the write-off. Relevant for compliance, regulatory reporting, and recovery strategy.',
    `legal_case_reference` STRING COMMENT 'External legal case or court reference number associated with legal proceedings against the customer. Populated only when legal_action_flag is True.',
    `outstanding_balance_at_writeoff` DECIMAL(18,2) COMMENT 'Total overdue balance on the account at the time the write-off was initiated, which may include multiple invoices, late fees, and interest charges. May differ from write_off_amount if only a partial balance is written off.',
    `provision_amount` DECIMAL(18,2) COMMENT 'Amount previously provisioned for this debt under the expected credit loss (ECL) model prior to the actual write-off. Used to reconcile the provision account in SAP S/4HANA Finance and assess provisioning accuracy.',
    `reason` STRING COMMENT 'Categorized reason code explaining why the outstanding balance is deemed uncollectable and eligible for write-off. Drives regulatory reporting, bad debt provisioning, and fraud analytics. [ENUM-REF-CANDIDATE: bankruptcy|deceased|uncontactable|fraud|statute_of_limitations|other — promote to reference product if additional reason codes are required]. Valid values are `bankruptcy|deceased|uncontactable|fraud|statute_of_limitations|other`',
    `reason_notes` STRING COMMENT 'Free-text narrative providing additional context or supporting detail for the write-off reason code. May include case reference numbers, legal citations, or collector observations from Amdocs Collections.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Total monetary amount recovered from the customer or recovery agency against the written-off balance. Populated when write_off_status is recovered or partially_recovered. Used for revenue assurance and bad debt recovery reporting.',
    `recovery_date` DATE COMMENT 'Date on which the recovery amount was received and posted back to the account. Used for revenue recognition reversal and bad debt recovery analytics.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this write-off record must be included in regulatory bad debt reporting submissions to bodies such as the FCC, Ofcom, or BEREC. Drives automated regulatory report generation.',
    `service_type` STRING COMMENT 'Type of telecommunications service associated with the written-off balance (e.g., mobile, broadband, fiber/FTTH, IPTV, VoIP). Supports product-level bad debt analytics and revenue assurance. [ENUM-REF-CANDIDATE: mobile|broadband|fiber|iptv|voip|fixed_line|enterprise_data — promote to reference product if additional service types are required]',
    `source_system` STRING COMMENT 'Operational system of record from which the write-off record was sourced (Amdocs Collections, Comverse ONE for prepaid, or manual entry). Supports data lineage and reconciliation in the Databricks Silver Layer.. Valid values are `amdocs_collections|comverse_one|manual`',
    `source_system_reference` STRING COMMENT 'Native identifier of the write-off record in the originating operational system (e.g., Amdocs Collections internal write-off ID). Enables traceability and reconciliation between the lakehouse Silver Layer and the source system.',
    `statute_of_limitations_date` DATE COMMENT 'Date on which the legal right to pursue collection of the debt expires under applicable jurisdiction law. Used to trigger write-off when statute_of_limitations is the write_off_reason.',
    `tax_write_back_amount` DECIMAL(18,2) COMMENT 'Amount of tax (e.g., VAT, GST, sales tax) reclaimed or reversed as a result of the write-off. Reported to tax authorities and reflected in SAP S/4HANA Finance for tax compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the write-off record in the Databricks Silver Layer. Used for change tracking, audit trail, and incremental data pipeline processing.',
    `write_off_date` DATE COMMENT 'The calendar date on which the bad debt write-off action was formally executed and posted to the general ledger in SAP S/4HANA Finance. Represents the principal business event date for revenue recognition and regulatory reporting.',
    `write_off_number` STRING COMMENT 'Externally-known, human-readable business identifier for the write-off transaction as assigned by Amdocs Collections. Used in correspondence with recovery agencies, auditors, and regulatory bodies.. Valid values are `^WO-[0-9]{10}$`',
    `write_off_status` STRING COMMENT 'Current lifecycle state of the write-off record within the Amdocs Collections workflow. Drives downstream actions such as agency assignment, tax write-back, and revenue assurance reporting.. Valid values are `pending_approval|approved|sent_to_agency|recovered|partially_recovered|closed`',
    `write_off_timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone offset) at which the write-off transaction was created and committed in the Amdocs Collections system. Used for audit trail and intraday reconciliation.',
    CONSTRAINT pk_write_off PRIMARY KEY(`write_off_id`)
) COMMENT 'Record of a bad debt write-off action on an uncollectable outstanding balance after dunning exhaustion. Captures write-off date, written-off amount, original invoice references, aging bucket at write-off (30/60/90/120+ days), write-off reason (bankruptcy, deceased, uncontactable, fraud, statute of limitations), approving authority, recovery agency assignment, recovery amount received, tax write-back amount, and write-off status (pending approval, approved, sent-to-agency, recovered, partially recovered, closed). Supports revenue assurance, bad debt provisioning, and regulatory reporting on uncollectable accounts. Sourced from Amdocs Collections.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`payment_allocation` (
    `payment_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for each payment allocation record in the Amdocs Collections module. Serves as the primary key for the payment_allocation data product in the billing domain Silver layer.',
    `adjustment_id` BIGINT COMMENT 'Reference to a billing adjustment record that is being settled or applied through this allocation. Populated when allocation_type = adjustment or credit_memo. Links to the adjustment entity in Amdocs Revenue Management.',
    `billing_account_id` BIGINT COMMENT 'Reference to the customer billing account against which the payment and invoice are recorded. Supports AR aging and account-level reconciliation in Amdocs Revenue Management.',
    `billing_dispute_id` BIGINT COMMENT 'Reference to an active or resolved billing dispute associated with this allocation. Populated when allocation_method = dispute_hold or allocation_type = dispute_settlement. Links to the dispute management record in Amdocs or Salesforce CRM Case Management.',
    `employee_id` BIGINT COMMENT 'Reference to the collections agent or automated process that performed or approved this allocation. Populated for manual allocations or collector-override scenarios. Supports workforce performance reporting in collections operations.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice being settled by this allocation. A single payment may generate multiple allocation records, each referencing a distinct invoice in the accounts receivable ledger.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Payment allocations trigger GL postings for cash application to AR. Finance traces journal entries to allocation events for cash reconciliation, unapplied cash tracking, and revenue recognition timing',
    `payment_id` BIGINT COMMENT 'Reference to the parent payment record from which this allocation originates. Links the allocation back to the specific payment transaction in Amdocs Revenue Management Collections.',
    `pipeline_run_id` BIGINT COMMENT 'Foreign key linking to analytics.pipeline_run. Business justification: Payment allocation pipelines require lineage for cash application accuracy validation, DSO reporting, and dunning process effectiveness analysis. Enables identification of which auto-allocation run ap',
    `reversed_allocation_payment_allocation_id` BIGINT COMMENT 'Self-referencing identifier pointing to the original payment_allocation_id that this record reverses. Populated only when allocation_type = reversal. Enables full reversal chain traceability in the AR ledger.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The monetary amount from the payment that has been applied to the referenced invoice or charge in this allocation record. Core financial field for AR reconciliation and partial payment tracking.',
    `allocation_date` DATE COMMENT 'The business date on which the payment was formally allocated to the invoice or charge. Used as the key date for AR aging buckets, financial close, and revenue recognition reporting.',
    `allocation_method` STRING COMMENT 'The business rule or strategy used to determine how the payment is distributed across invoices or charges. oldest_first applies payment to the most aged invoice first (standard dunning); proportional distributes across all open invoices by balance ratio; specific_invoice applies to a customer-designated invoice; dispute_hold suspends allocation pending dispute resolution; newest_first applies to the most recent invoice; manual indicates a collector override. [ENUM-REF-CANDIDATE: oldest_first|proportional|specific_invoice|dispute_hold|newest_first|manual — promote to reference product]. Valid values are `oldest_first|proportional|specific_invoice|dispute_hold|newest_first|manual`',
    `allocation_number` STRING COMMENT 'Externally visible, human-readable business identifier for this allocation record as generated by Amdocs Collections. Used in customer correspondence, dispute resolution, and financial audit trails.. Valid values are `^ALLOC-[0-9]{10,15}$`',
    `allocation_status` STRING COMMENT 'Current lifecycle state of the allocation record. allocated indicates the amount has been successfully applied to the invoice; reversed indicates a prior allocation was undone; pending_review indicates the allocation is under dispute or manual review; partially_allocated indicates only a portion of the payment has been applied; cancelled indicates the allocation was voided; on_hold indicates a dispute-hold is in effect. [ENUM-REF-CANDIDATE: allocated|reversed|pending_review|partially_allocated|cancelled|on_hold — promote to reference product]. Valid values are `allocated|reversed|pending_review|partially_allocated|cancelled|on_hold`',
    `allocation_timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone offset) when the allocation transaction was processed in Amdocs Collections. Distinct from allocation_date; used for intraday reconciliation and audit trail.',
    `allocation_type` STRING COMMENT 'Classifies the nature of the allocation transaction. standard is a normal payment-to-invoice application; reversal undoes a prior allocation; adjustment applies a billing adjustment; dispute_settlement closes a disputed amount; write_off applies a bad debt write-off; credit_memo applies a credit note. [ENUM-REF-CANDIDATE: standard|reversal|adjustment|dispute_settlement|write_off|credit_memo — promote to reference product]. Valid values are `standard|reversal|adjustment|dispute_settlement|write_off|credit_memo`',
    `billing_period_end` DATE COMMENT 'The end date of the billing cycle covered by the invoice being settled. Used alongside billing_period_start for period-accurate MRR reporting and revenue recognition.',
    `billing_period_start` DATE COMMENT 'The start date of the billing cycle covered by the invoice being settled. Enables MRR (Monthly Recurring Revenue) period attribution and revenue recognition alignment per IFRS 15 / ASC 606.',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA cost center code associated with the business unit responsible for the billing account. Used for internal financial reporting, OPEX allocation, and segment-level revenue reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment allocation record was first created in the system. Mandatory audit field for the Silver layer data product. Conforms to ISO 8601 timestamp format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this allocation record (e.g., USD, EUR, GBP). Supports multi-currency billing environments in global telecommunications operations.. Valid values are `^[A-Z]{3}$`',
    `days_overdue` STRING COMMENT 'The number of calendar days the invoice was past its due date at the time this allocation was applied. Captured as a point-in-time snapshot for AR aging analysis, collections performance reporting, and dunning effectiveness measurement.',
    `dunning_level` STRING COMMENT 'The dunning escalation level of the invoice at the time this allocation was applied (e.g., 0 = not in dunning, 1 = first reminder, 2 = second notice, 3 = final notice, 4 = collections agency). Captured as a point-in-time snapshot for collections effectiveness analysis.',
    `gl_account_code` STRING COMMENT 'The General Ledger account code to which this allocation is posted in SAP S/4HANA Finance. Enables AR sub-ledger to GL reconciliation and financial close reporting. Follows the chart of accounts defined in SAP.',
    `invoice_balance_after` DECIMAL(18,2) COMMENT 'The remaining outstanding balance on the invoice immediately after this allocation was applied. A zero value indicates the invoice is fully settled; a positive value indicates a partial payment.',
    `invoice_balance_before` DECIMAL(18,2) COMMENT 'The outstanding balance on the invoice immediately prior to this allocation being applied. Enables audit trail of how each allocation reduced the invoice balance and supports dispute resolution.',
    `is_auto_allocated` BOOLEAN COMMENT 'Indicates whether this allocation was performed automatically by the Amdocs Collections engine (True) or was manually applied by a collections agent (False). Supports operational analytics on automation rates and manual intervention tracking.',
    `is_partial_payment` BOOLEAN COMMENT 'Indicates whether this allocation represents a partial settlement of the referenced invoice (True) or a full settlement (False). Key flag for AR aging, dunning workflow, and collections prioritization.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'The portion of the allocated_amount that corresponds to late payment fees or penalty charges applied to the invoice. Tracked separately for fee revenue reporting and customer dispute management.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by a collections agent or automated process to provide additional context for this allocation. Examples include dispute resolution notes, manual override justifications, or special handling instructions.',
    `overpayment_amount` DECIMAL(18,2) COMMENT 'The amount by which the payment exceeds the total invoice balance, resulting in a credit or refund. Populated when the payment amount is greater than the invoice due amount. Zero if no overpayment exists.',
    `overpayment_handling` STRING COMMENT 'Defines how any overpayment amount is to be processed. credit_balance retains the excess as a credit on the account; refund triggers a refund transaction back to the customer; apply_to_next carries the credit forward to the next billing cycle; write_off writes off the overpayment per policy; pending indicates the handling decision is awaiting approval.. Valid values are `credit_balance|refund|apply_to_next|write_off|pending`',
    `principal_amount` DECIMAL(18,2) COMMENT 'The portion of the allocated_amount that corresponds to the base service charges (excluding taxes and fees). Supports revenue recognition, MRR reporting, and ARPU calculation by isolating the core service revenue component.',
    `revenue_recognition_date` DATE COMMENT 'The date on which the allocated amount is recognized as revenue in the financial ledger per IFRS 15 / ASC 606 performance obligation satisfaction criteria. May differ from allocation_date for deferred revenue scenarios.',
    `reversal_reason` STRING COMMENT 'Free-text or coded reason explaining why a previously applied allocation was reversed. Populated only when allocation_type = reversal. Examples include: returned payment, duplicate allocation, incorrect invoice reference, customer dispute resolution.',
    `source_system` STRING COMMENT 'Identifies the operational system of record that originated this allocation record. Supports data lineage, reconciliation between BSS systems, and Silver layer audit requirements. Primary sources are Amdocs Revenue Management Collections and Comverse ONE for prepaid scenarios.. Valid values are `amdocs_collections|comverse_one|manual_entry|sap_fi|migration`',
    `source_system_allocation_code` STRING COMMENT 'The native allocation identifier as recorded in the originating source system (Amdocs Collections or Comverse ONE). Preserved for end-to-end traceability and reconciliation between the Silver lakehouse layer and the operational BSS system.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The portion of the allocated_amount that corresponds to taxes (VAT, GST, or applicable local taxes) included in the invoice. Required for tax reporting, VAT reconciliation, and regulatory compliance with FCC and international tax authorities.',
    `unapplied_balance` DECIMAL(18,2) COMMENT 'The portion of the original payment that remains unallocated after this allocation record is processed. Critical for unallocated cash management and financial close reporting in Amdocs Collections.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this payment allocation record was most recently modified. Updated on every status change, reversal, or correction. Mandatory audit field for the Silver layer data product.',
    CONSTRAINT pk_payment_allocation PRIMARY KEY(`payment_allocation_id`)
) COMMENT 'Association record linking a payment to one or more invoices or charges it settles. Captures allocation amount per invoice, allocation date, allocation method (oldest-first, proportional, specific-invoice, dispute-hold), remaining unapplied balance, over-payment handling (credit balance, refund), and allocation status (allocated, reversed, pending-review). Enables accurate accounts receivable aging, partial payment tracking, and unallocated cash management. Required for financial close and AR reconciliation. Sourced from Amdocs Collections.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` (
    `contract_billing_arrangement_id` BIGINT COMMENT 'Unique identifier for this contract-billing account arrangement record',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to the billing account that receives charges under this arrangement',
    `employee_id` BIGINT COMMENT 'Reference to the employee or system user who created this billing arrangement',
    `sales_contract_id` BIGINT COMMENT 'Foreign key linking to the sales contract that defines the commercial terms',
    `arrangement_status` STRING COMMENT 'Current lifecycle status of this billing arrangement: active (charges flowing), suspended (temporarily halted), terminated (ended), pending_activation (configured but not yet active)',
    `arrangement_type` STRING COMMENT 'Classification of how this billing account relates to the contract: primary (main billing account), secondary (additional account), split_billing (charges split across accounts), consolidated (receives consolidated invoice), cost_center (departmental billing)',
    `billing_allocation_percentage` DECIMAL(18,2) COMMENT 'For split billing arrangements, the percentage of contract charges allocated to this billing account (e.g., 60.00 means 60% of charges go to this account, 40% to another)',
    `consolidated_billing_flag` BOOLEAN COMMENT 'Indicates whether charges from this contract should be consolidated with other contracts on a single invoice for this billing account (true) or invoiced separately (false)',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this billing arrangement record was created in the system',
    `effective_end_date` DATE COMMENT 'Date when this billing arrangement terminated or is scheduled to terminate. Null for active arrangements.',
    `effective_start_date` DATE COMMENT 'Date when this billing arrangement became active and charges from the contract began flowing to this billing account',
    `invoice_format_override` STRING COMMENT 'Contract-specific invoice format that overrides the billing account default for this contracts charges (e.g., detailed_itemized, summary, regulatory_format)',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this billing arrangement record',
    `notes` STRING COMMENT 'Free-text notes documenting special billing instructions, customer requests, or arrangement-specific details',
    `payment_terms_override` STRING COMMENT 'Contract-specific payment terms that override the billing account default payment terms for charges originating from this contract (e.g., net_45 instead of account default net_30)',
    CONSTRAINT pk_contract_billing_arrangement PRIMARY KEY(`contract_billing_arrangement_id`)
) COMMENT 'This association product represents the billing arrangement between a sales contract and one or more billing accounts. In telecommunications, enterprise contracts often span multiple billing accounts (subsidiaries, cost centers, departments), and a single billing account can receive charges from multiple active service contracts (mobile, broadband, TV). Each record captures the contract-specific billing configuration including payment terms overrides, consolidated billing flags, arrangement effective dates, and billing status for that specific contract-account pairing.. Existence Justification: In telecommunications operations, a single billing account frequently receives charges from multiple active service contracts (e.g., mobile, broadband, TV services purchased at different times), and enterprise sales contracts routinely span multiple billing accounts across subsidiaries, cost centers, or departmental structures. Billing operations actively manage these arrangements with contract-specific configurations for payment terms, consolidated billing flags, split billing percentages, and invoice formats that exist only in the context of each contract-account pairing.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`billing_subscription` (
    `billing_subscription_id` BIGINT COMMENT 'Primary key for billing_subscription',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to the billing account that holds this content package subscription',
    `package_id` BIGINT COMMENT 'Foreign key linking to the content package being subscribed to by this billing account',
    `activation_channel` STRING COMMENT 'Channel through which this subscription was activated (web, mobile app, call center, retail store, self-service portal). Used for channel performance analysis.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this subscription automatically renews at the end of the current billing period (True) or requires manual renewal (False). Explicitly identified in detection phase as auto_renewal_flag.',
    `billing_subscription_status` STRING COMMENT 'Current lifecycle state of this subscription: active (content accessible), suspended (temporarily disabled), cancelled (terminated by customer), pending_activation (ordered but not yet provisioned), trial (in trial period), expired (end_date passed). Explicitly identified in detection phase as subscription_status.',
    `cancellation_date` DATE COMMENT 'Date on which the customer requested cancellation of this subscription. May differ from end_date if cancellation is scheduled for end of billing period.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code indicating the reason for subscription cancellation (e.g., price_too_high, content_not_satisfactory, moving_to_competitor, technical_issues). Used for churn analysis.',
    `commitment_end_date` DATE COMMENT 'Date on which the minimum commitment period for this subscription ends. Early cancellation before this date may incur early termination fees.',
    `end_date` DATE COMMENT 'Date on which this subscription is scheduled to end or was terminated. Null for active ongoing subscriptions. Explicitly identified in detection phase as subscription_end_date.',
    `monthly_recurring_charge` DECIMAL(18,2) COMMENT 'Actual monthly recurring charge for this specific subscription, which may differ from the content packages standard rate due to promotional pricing, contract terms, or grandfathered pricing. Explicitly identified in detection phase as monthly_recurring_charge.',
    `next_renewal_date` DATE COMMENT 'Date on which this subscription is scheduled for its next automatic renewal. Null if auto_renewal_flag is False or subscription is cancelled.',
    `promotional_code` STRING COMMENT 'Promotional or discount code applied to this specific subscription, affecting pricing or trial terms. Null if no promotion applied. Explicitly identified in detection phase as promotional_code.',
    `start_date` DATE COMMENT 'Date on which this billing accounts subscription to this content package became active and content access was provisioned. Explicitly identified in detection phase as subscription_start_date.',
    `subscription_id` BIGINT COMMENT 'Unique identifier for this subscription record. Primary key.',
    `trial_end_date` DATE COMMENT 'Date on which the trial period for this subscription ends and standard billing begins. Null if no trial period applies.',
    CONSTRAINT pk_billing_subscription PRIMARY KEY(`billing_subscription_id`)
) COMMENT 'This association product represents the subscription contract between a billing account and a content package. It captures the lifecycle of a customers subscription to a specific content offering, including activation dates, renewal terms, promotional pricing, and subscription status. Each record links one billing account to one content package with attributes that exist only in the context of this subscription relationship.. Existence Justification: In telecommunications operations, billing accounts subscribe to multiple content packages simultaneously (e.g., a customer may have HBO, Sports Pack, and Kids Bundle on the same account), and each content package is subscribed by thousands of billing accounts. The subscription itself is a managed business entity with its own lifecycle: customers activate subscriptions, modify renewal terms, apply promotional codes, and cancel subscriptions. This is the core content subscription model in telecom.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` (
    `rate_plan_content_package_id` BIGINT COMMENT 'Unique identifier for this rate plan content package association record',
    `package_id` BIGINT COMMENT 'Foreign key linking to the content package included in this rate plan',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to the rate plan that includes this content package offering',
    `association_status` STRING COMMENT 'Current lifecycle status of this rate plan content package association: active (available for provisioning), inactive (temporarily unavailable), pending (scheduled for future activation), discontinued (no longer offered)',
    `bundle_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the content package monthly recurring charge when bundled with this specific rate plan (e.g., 15.00 = 15% discount)',
    `effective_end_date` DATE COMMENT 'Date when this content package is no longer available within this specific rate plan. Null for open-ended availability.',
    `effective_start_date` DATE COMMENT 'Date when this content package becomes available within this specific rate plan',
    `is_included_in_base` BOOLEAN COMMENT 'Indicates whether this content package is included in the base recurring charge of the rate plan (true) or requires an additional charge (false)',
    `minimum_commitment_months` STRING COMMENT 'Minimum subscription commitment period in months required for this content package when purchased as part of this rate plan. May differ from the standalone content package commitment.',
    `pricing_tier` STRING COMMENT 'Pricing tier classification for this content package within this rate plan context (base = included in base rate, premium = premium add-on, add_on = optional add-on, promotional = temporary promotional pricing)',
    `promotional_rate` DECIMAL(18,2) COMMENT 'Special promotional monthly recurring charge for this content package when bundled with this rate plan. Null if standard pricing applies.',
    CONSTRAINT pk_rate_plan_content_package PRIMARY KEY(`rate_plan_content_package_id`)
) COMMENT 'This association product represents the commercial bundling relationship between rate plans and content packages in the telecommunications product catalog. It captures the specific pricing, promotional terms, and commitment requirements that apply when a particular content package is offered as part of a specific rate plan. Each record links one rate plan to one content package with pricing and promotional attributes that exist only in the context of this specific bundle configuration.. Existence Justification: In telecommunications, rate plans (e.g., Unlimited Family, Prepaid Basic, Enterprise Data) are commercial pricing structures that can include multiple content packages (Sports Bundle, Entertainment Pack, Kids Plus), and each content package is made available across multiple rate plans with varying pricing terms. The business actively manages these bundle configurations, tracking promotional rates, bundle discounts, and commitment periods specific to each rate-plan-package combination. This is an operational product catalog management activity, not an analytical correlation.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` (
    `corporate_rate_plan_agreement_id` BIGINT COMMENT 'Unique identifier for this corporate rate plan agreement record',
    `corporate_account_id` BIGINT COMMENT 'Foreign key linking to the corporate account that has negotiated this rate plan agreement',
    `rate_plan_id` BIGINT COMMENT 'Foreign key linking to the rate plan definition in the billing rating engine that defines the pricing structure applied to this corporate account',
    `agreement_status` STRING COMMENT 'Current lifecycle status of this rate plan agreement indicating whether it is active, pending activation, expired, terminated early, or suspended.',
    `commitment_term_months` STRING COMMENT 'Duration in months of the commitment period for this rate plan agreement, determining contract lock-in and early termination penalties. Explicitly identified in detection phase relationship data.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the master service agreement or contract addendum that governs this rate plan agreement. Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate plan agreement record was created in the system',
    `effective_end_date` DATE COMMENT 'Date when this negotiated rate plan agreement expires or is superseded. Explicitly identified in detection phase relationship data.',
    `effective_start_date` DATE COMMENT 'Date when this negotiated rate plan agreement becomes effective for the corporate account. Explicitly identified in detection phase relationship data.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate plan agreement record was last modified',
    `minimum_commitment_amount` DECIMAL(18,2) COMMENT 'Minimum revenue commitment amount that the corporate account has agreed to spend on this rate plan over the commitment term. Explicitly identified in detection phase relationship data.',
    `negotiated_discount_percentage` DECIMAL(18,2) COMMENT 'Custom discount percentage negotiated for this corporate account on this rate plan, applied on top of the standard rate plan pricing. Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_corporate_rate_plan_agreement PRIMARY KEY(`corporate_rate_plan_agreement_id`)
) COMMENT 'This association product represents the Contract between rate_plan and corporate_account. It captures the negotiated pricing agreements between enterprise customers and the telco, including custom discounts, commitment terms, and contract-specific pricing overrides. Each record links one rate_plan to one corporate_account with attributes that exist only in the context of this negotiated commercial relationship. Sourced from enterprise contract management and billing systems.. Existence Justification: In telecommunications B2B operations, corporate accounts negotiate multiple rate plans simultaneously (voice, data, international, IoT) across different service types, sites, and business units. Conversely, standard enterprise rate plans (e.g., Enterprise Data Tier 2) are offered to multiple corporate accounts with account-specific negotiated discounts, commitment terms, and contract periods. The business actively manages these agreements as commercial contracts with lifecycle states, renewal processes, and compliance tracking.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`billing_cycle` (
    `billing_cycle_id` BIGINT COMMENT 'Primary key for billing_cycle',
    `prior_billing_cycle_id` BIGINT COMMENT 'Self-referencing FK on billing_cycle (prior_billing_cycle_id)',
    `billing_day_of_month` STRING COMMENT 'Calendar day (1‑31) on which billing is executed for the cycle.',
    `billing_period_end_day` STRING COMMENT 'Offset (in days) from the cycle start to the last billable day.',
    `billing_period_start_day` STRING COMMENT 'Offset (in days) from the cycle start to the first billable day.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing cycle record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code applicable to the cycle.',
    `cycle_code` STRING COMMENT 'External code used to reference the billing cycle in downstream systems.',
    `cycle_name` STRING COMMENT 'Human‑readable name of the billing cycle (e.g., "July 2024 Cycle").',
    `cycle_type` STRING COMMENT 'Category that defines the periodicity of the cycle.',
    `billing_cycle_description` STRING COMMENT 'Free‑form description providing additional context about the cycle.',
    `effective_from` DATE COMMENT 'Date when the billing cycle becomes effective.',
    `effective_until` DATE COMMENT 'Date when the billing cycle ends; null for open‑ended cycles.',
    `external_system_code` STRING COMMENT 'Identifier of the billing cycle in the source system (e.g., Amdocs RM).',
    `frequency_months` STRING COMMENT 'Number of months that define the cycle frequency (e.g., 1 for monthly).',
    `is_prorated` BOOLEAN COMMENT 'Indicates whether the cycle allows prorated charges.',
    `notes` STRING COMMENT 'Additional remarks or operational notes for the billing cycle.',
    `revenue_recognition_method` STRING COMMENT 'Method used to recognize revenue for this billing cycle.',
    `billing_cycle_status` STRING COMMENT 'Current lifecycle state of the billing cycle.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the billing cycle record.',
    CONSTRAINT pk_billing_cycle PRIMARY KEY(`billing_cycle_id`)
) COMMENT 'Master reference table for billing_cycle. Referenced by billing_cycle_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`dunning_profile` (
    `dunning_profile_id` BIGINT COMMENT 'Primary key for dunning_profile',
    `escalation_dunning_profile_id` BIGINT COMMENT 'Self-referencing FK on dunning_profile (escalation_dunning_profile_id)',
    `action_type` STRING COMMENT 'Type of collection action performed when the profile is applied.',
    `communication_channel` STRING COMMENT 'Preferred channel used to notify the customer for this dunning step.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dunning profile record was first created in the system.',
    `days_before_action` STRING COMMENT 'Number of days after invoice due date before the first dunning action is triggered.',
    `dunning_profile_description` STRING COMMENT 'Detailed free‑text description of the profiles purpose, rules, and usage.',
    `effective_from` DATE COMMENT 'Date when the dunning profile becomes effective.',
    `effective_until` DATE COMMENT 'Date when the dunning profile expires; null if open‑ended.',
    `escalation_level` STRING COMMENT 'Level of escalation within the dunning workflow; higher numbers indicate later stages.',
    `is_automatic` BOOLEAN COMMENT 'Indicates whether the dunning actions are executed automatically by the system.',
    `last_action_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent dunning action executed under this profile.',
    `max_attempts` STRING COMMENT 'Maximum number of times the dunning actions will be attempted before the profile is considered exhausted.',
    `notes` STRING COMMENT 'Optional free‑form notes for internal reference or special handling instructions.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty applied when the dunning profile reaches a specified escalation level.',
    `penalty_currency` STRING COMMENT 'ISO 4217 currency code for the penalty amount.',
    `priority` STRING COMMENT 'Numeric priority used to select the profile when multiple apply (lower number = higher priority).',
    `profile_code` STRING COMMENT 'Business identifier or code for the dunning profile, often used in external systems.',
    `profile_name` STRING COMMENT 'Human‑readable name of the dunning profile used in reporting and UI.',
    `profile_type` STRING COMMENT 'Category of the dunning profile based on customer segment or contract type.',
    `dunning_profile_status` STRING COMMENT 'Current lifecycle state of the profile.',
    `updated_by` STRING COMMENT 'Identifier of the user or process that last modified the dunning profile.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the dunning profile record.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the dunning profile.',
    CONSTRAINT pk_dunning_profile PRIMARY KEY(`dunning_profile_id`)
) COMMENT 'Master reference table for dunning_profile. Referenced by dunning_profile_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`payment_arrangement` (
    `payment_arrangement_id` BIGINT COMMENT 'Primary key for payment_arrangement',
    `billing_account_id` BIGINT COMMENT 'Billing account linked to the payment arrangement.',
    `billing_cycle_id` BIGINT COMMENT 'Identifier of the billing cycle to which this arrangement applies.',
    `subscriber_id` BIGINT COMMENT 'Identifier of the customer associated with this payment arrangement.',
    `restructured_payment_arrangement_id` BIGINT COMMENT 'Self-referencing FK on payment_arrangement (restructured_payment_arrangement_id)',
    `arrangement_number` STRING COMMENT 'External reference number assigned to the payment arrangement by the billing system.',
    `arrangement_type` STRING COMMENT 'Category of the payment arrangement indicating the billing model.',
    `arrears_flag` BOOLEAN COMMENT 'True if the arrangement is currently past due.',
    `auto_renew_flag` BOOLEAN COMMENT 'True if the arrangement automatically renews at expiry.',
    `contract_reference` STRING COMMENT 'External contract or service agreement identifier linked to this payment arrangement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment arrangement record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter code of the transaction currency.',
    `payment_arrangement_description` STRING COMMENT 'Narrative description or notes about the payment arrangement.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the arrangement.',
    `dunning_stage` STRING COMMENT 'Current step in the collections process for overdue payments.',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Fee charged if the arrangement is terminated before the effective_until date.',
    `effective_from` DATE COMMENT 'Date when the payment arrangement becomes binding.',
    `effective_until` DATE COMMENT 'Date when the payment arrangement ends; null for open‑ended agreements.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before discounts, taxes, or adjustments.',
    `installment_amount` DECIMAL(18,2) COMMENT 'Standard amount for each installment when equal payments are used.',
    `installment_count` STRING COMMENT 'Number of scheduled installments for the arrangement.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment.',
    `last_payment_date` DATE COMMENT 'Date when the most recent payment was received.',
    `net_amount` DECIMAL(18,2) COMMENT 'Amount payable after discounts and taxes.',
    `next_due_date` DATE COMMENT 'Date of the next scheduled payment.',
    `notes` STRING COMMENT 'Supplementary free‑text information.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining amount due under the arrangement.',
    `payment_channel` STRING COMMENT 'Customer‑facing interface through which the payment is made.',
    `payment_frequency` STRING COMMENT 'Regular interval at which payments are scheduled.',
    `payment_method` STRING COMMENT 'Instrument used to settle the payment.',
    `payment_plan_code` STRING COMMENT 'Internal code representing the specific payment plan configuration.',
    `payment_arrangement_status` STRING COMMENT 'Current lifecycle state of the payment arrangement.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the arrangement.',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Cumulative sum of all payments received to date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment arrangement record.',
    CONSTRAINT pk_payment_arrangement PRIMARY KEY(`payment_arrangement_id`)
) COMMENT 'Master reference table for payment_arrangement. Referenced by payment_arrangement_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`voucher_batch` (
    `voucher_batch_id` BIGINT COMMENT 'Primary key for voucher_batch',
    `campaign_id` BIGINT COMMENT 'Identifier of the marketing campaign associated with the voucher batch.',
    `employee_id` BIGINT COMMENT 'System user identifier that created the voucher batch record.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'System user identifier that performed the most recent update.',
    `vendor_id` BIGINT COMMENT 'Identifier of the external vendor that supplied the voucher batch.',
    `parent_voucher_batch_id` BIGINT COMMENT 'Self-referencing FK on voucher_batch (parent_voucher_batch_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the voucher batch was approved.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the voucher batch for activation.',
    `batch_category` STRING COMMENT 'Higher‑level grouping used for reporting and pricing strategy.',
    `batch_code` STRING COMMENT 'External code used to reference the voucher batch in business processes.',
    `batch_name` STRING COMMENT 'Human‑readable name of the voucher batch.',
    `batch_type` STRING COMMENT 'Category describing the purpose or product family of the voucher batch.',
    `batch_version` STRING COMMENT 'Version number of the batch definition, incremented on each change.',
    `creation_timestamp` TIMESTAMP COMMENT 'Date‑time when the voucher batch record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for the voucher values.',
    `voucher_batch_description` STRING COMMENT 'Free‑form text describing the purpose, target audience, or special conditions of the voucher batch.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the face value of each voucher (e.g., 0.1500 = 15%).',
    `effective_end_date` DATE COMMENT 'Date when the voucher batch expires or is no longer valid.',
    `effective_start_date` DATE COMMENT 'Date when the voucher batch becomes valid for redemption.',
    `expiration_policy` STRING COMMENT 'Rule that determines how voucher expiration is calculated.',
    `is_active` BOOLEAN COMMENT 'Convenient boolean indicating if the batch is currently active (true) or not (false).',
    `is_restricted` BOOLEAN COMMENT 'Indicates whether the voucher batch is limited to a specific customer segment or loyalty tier.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the voucher batch record.',
    `max_redemptions_per_voucher` STRING COMMENT 'Maximum number of times a single voucher in the batch can be redeemed.',
    `notes` STRING COMMENT 'Additional internal comments or processing notes for the voucher batch.',
    `redemption_window_days` STRING COMMENT 'Number of days after activation during which vouchers may be redeemed.',
    `region_code` STRING COMMENT 'Three‑letter code representing the geographic region where the batch is issued.',
    `voucher_batch_status` STRING COMMENT 'Current lifecycle state of the voucher batch.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether vouchers in this batch are exempt from tax.',
    `total_face_value` DECIMAL(18,2) COMMENT 'Aggregate monetary value of all vouchers in the batch before any adjustments.',
    `total_voucher_count` BIGINT COMMENT 'Number of individual vouchers generated in this batch.',
    CONSTRAINT pk_voucher_batch PRIMARY KEY(`voucher_batch_id`)
) COMMENT 'Master reference table for voucher_batch. Referenced by voucher_batch_id.';

CREATE OR REPLACE TABLE `telecommunication_ecm`.`billing`.`recovery_agency` (
    `recovery_agency_id` BIGINT COMMENT 'Primary key for recovery_agency',
    `escalated_to_recovery_agency_id` BIGINT COMMENT 'Self-referencing FK on recovery_agency (escalated_to_recovery_agency_id)',
    `address_line1` STRING COMMENT 'First line of the agencys mailing address.',
    `address_line2` STRING COMMENT 'Second line of the agencys mailing address (optional).',
    `agency_code` STRING COMMENT 'External reference code assigned to the agency by the telecoms vendor management system.',
    `agency_name` STRING COMMENT 'Legal name of the recovery agency as used in contracts and billing.',
    `agency_type` STRING COMMENT 'Category describing the nature of the agencys services.',
    `city` STRING COMMENT 'City component of the agencys mailing address.',
    `compliance_status` STRING COMMENT 'Current compliance posture of the agency with regulatory requirements.',
    `contact_email` STRING COMMENT 'Email address used for official communications with the agency.',
    `contact_name` STRING COMMENT 'Name of the primary person responsible for the agency relationship.',
    `contact_phone` STRING COMMENT 'International phone number of the primary contact.',
    `contract_end_date` DATE COMMENT 'Date when the recovery agreement expires or is terminated (null if open‑ended).',
    `contract_start_date` DATE COMMENT 'Date when the recovery agreement with the agency became effective.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code for the agencys location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agency record was first created in the system.',
    `currency_code` STRING COMMENT 'Currency in which fees and recoveries are settled.',
    `data_sharing_agreement_flag` BOOLEAN COMMENT 'Indicates whether a signed data‑sharing agreement exists with the agency.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Fixed fee amount charged by the agency per billing cycle.',
    `fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of recovered amount retained by the agency as fee.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit performed on the agency.',
    `legal_entity_name` STRING COMMENT 'Full legal entity name of the agency for regulatory and tax purposes.',
    `max_recovery_amount` DECIMAL(18,2) COMMENT 'Maximum monetary amount the agency is authorized to recover per period.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the agency.',
    `performance_rating` DECIMAL(18,2) COMMENT 'Internal rating of the agencys recovery performance.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the agencys mailing address.',
    `primary_contact_role` STRING COMMENT 'Business role of the primary contact within the agency.',
    `registration_number` STRING COMMENT 'Official registration number of the agency with the corporate registry.',
    `sla_response_time_days` STRING COMMENT 'Maximum number of days the agency must respond to a collection request.',
    `state_province` STRING COMMENT 'State or province component of the agencys mailing address.',
    `recovery_agency_status` STRING COMMENT 'Current operational status of the agency relationship.',
    `tax_identifier` STRING COMMENT 'Tax identification number used for reporting and withholding.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agency record.',
    `website_url` STRING COMMENT 'Public website address of the recovery agency.',
    CONSTRAINT pk_recovery_agency PRIMARY KEY(`recovery_agency_id`)
) COMMENT 'Master reference table for recovery_agency. Referenced by recovery_agency_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_parent_account_billing_account_id` FOREIGN KEY (`parent_account_billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_original_line_invoice_line_id` FOREIGN KEY (`original_line_invoice_line_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_original_payment_id` FOREIGN KEY (`original_payment_id`) REFERENCES `telecommunication_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_original_rated_event_id` FOREIGN KEY (`original_rated_event_id`) REFERENCES `telecommunication_ecm`.`billing`.`rated_event`(`rated_event_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ADD CONSTRAINT `fk_billing_rated_event_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ADD CONSTRAINT `fk_billing_billing_charge_reversal_charge_billing_charge_id` FOREIGN KEY (`reversal_charge_billing_charge_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_charge`(`billing_charge_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_billing_charge_id` FOREIGN KEY (`billing_charge_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_charge`(`billing_charge_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_previous_dispute_billing_dispute_id` FOREIGN KEY (`previous_dispute_billing_dispute_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_dunning_profile_id` FOREIGN KEY (`dunning_profile_id`) REFERENCES `telecommunication_ecm`.`billing`.`dunning_profile`(`dunning_profile_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_payment_arrangement_id` FOREIGN KEY (`payment_arrangement_id`) REFERENCES `telecommunication_ecm`.`billing`.`payment_arrangement`(`payment_arrangement_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ADD CONSTRAINT `fk_billing_dunning_event_previous_dunning_event_id` FOREIGN KEY (`previous_dunning_event_id`) REFERENCES `telecommunication_ecm`.`billing`.`dunning_event`(`dunning_event_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ADD CONSTRAINT `fk_billing_prepaid_balance_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ADD CONSTRAINT `fk_billing_prepaid_balance_primary_prepaid_migration_target_account_billing_account_id` FOREIGN KEY (`primary_prepaid_migration_target_account_billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_original_recharge_id` FOREIGN KEY (`original_recharge_id`) REFERENCES `telecommunication_ecm`.`billing`.`recharge`(`recharge_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ADD CONSTRAINT `fk_billing_recharge_voucher_batch_id` FOREIGN KEY (`voucher_batch_id`) REFERENCES `telecommunication_ecm`.`billing`.`voucher_batch`(`voucher_batch_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `telecommunication_ecm`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_recovery_agency_id` FOREIGN KEY (`recovery_agency_id`) REFERENCES `telecommunication_ecm`.`billing`.`recovery_agency`(`recovery_agency_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_adjustment_id` FOREIGN KEY (`adjustment_id`) REFERENCES `telecommunication_ecm`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `telecommunication_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `telecommunication_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_reversed_allocation_payment_allocation_id` FOREIGN KEY (`reversed_allocation_payment_allocation_id`) REFERENCES `telecommunication_ecm`.`billing`.`payment_allocation`(`payment_allocation_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ADD CONSTRAINT `fk_billing_contract_billing_arrangement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ADD CONSTRAINT `fk_billing_billing_subscription_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` ADD CONSTRAINT `fk_billing_rate_plan_content_package_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` ADD CONSTRAINT `fk_billing_corporate_rate_plan_agreement_rate_plan_id` FOREIGN KEY (`rate_plan_id`) REFERENCES `telecommunication_ecm`.`billing`.`rate_plan`(`rate_plan_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_cycle` ADD CONSTRAINT `fk_billing_billing_cycle_prior_billing_cycle_id` FOREIGN KEY (`prior_billing_cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_profile` ADD CONSTRAINT `fk_billing_dunning_profile_escalation_dunning_profile_id` FOREIGN KEY (`escalation_dunning_profile_id`) REFERENCES `telecommunication_ecm`.`billing`.`dunning_profile`(`dunning_profile_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_billing_cycle_id` FOREIGN KEY (`billing_cycle_id`) REFERENCES `telecommunication_ecm`.`billing`.`billing_cycle`(`billing_cycle_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_restructured_payment_arrangement_id` FOREIGN KEY (`restructured_payment_arrangement_id`) REFERENCES `telecommunication_ecm`.`billing`.`payment_arrangement`(`payment_arrangement_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`voucher_batch` ADD CONSTRAINT `fk_billing_voucher_batch_parent_voucher_batch_id` FOREIGN KEY (`parent_voucher_batch_id`) REFERENCES `telecommunication_ecm`.`billing`.`voucher_batch`(`voucher_batch_id`);
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ADD CONSTRAINT `fk_billing_recovery_agency_escalated_to_recovery_agency_id` FOREIGN KEY (`escalated_to_recovery_agency_id`) REFERENCES `telecommunication_ecm`.`billing`.`recovery_agency`(`recovery_agency_id`);

-- ========= TAGS =========
ALTER SCHEMA `telecommunication_ecm`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `telecommunication_ecm`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `customer_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `parent_account_billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Billing Account ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Name');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `account_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending|delinquent|write_off');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'residential|small_business|enterprise|wholesale|mvno|government');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `arpu_segment_code` SET TAGS ('dbx_business_glossary_term' = 'Average Revenue Per User (ARPU) Segment Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `auto_pay_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Pay Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `bill_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Bill Delivery Method');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `bill_delivery_method` SET TAGS ('dbx_value_regex' = 'paper|ebill|app|email|suppressed');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `bill_language_code` SET TAGS ('dbx_business_glossary_term' = 'Bill Language Code (IETF BCP 47)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `bill_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `consolidated_billing` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Billing Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_class_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Class Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_class_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Account Credit Limit');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Account Balance');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `dispute_in_progress` SET TAGS ('dbx_business_glossary_term' = 'Dispute In Progress Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `dunning_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Dunning Profile Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `dunning_status` SET TAGS ('dbx_business_glossary_term' = 'Dunning Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `dunning_status` SET TAGS ('dbx_value_regex' = 'none|reminder_sent|warning_sent|suspended|collections|write_off');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Account Effective From Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Account Effective Until Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Account Hierarchy Level');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `invoice_format_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Format Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `invoice_format_code` SET TAGS ('dbx_value_regex' = 'standard|itemized|summary|consolidated');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `last_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Account Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `mrr_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Recurring Revenue (MRR) Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `mrr_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `mrr_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdue Balance Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (Days)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `prepaid_postpaid_indicator` SET TAGS ('dbx_business_glossary_term' = 'Prepaid/Postpaid Indicator');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `prepaid_postpaid_indicator` SET TAGS ('dbx_value_regex' = 'prepaid|postpaid|hybrid');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `revenue_recognition_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `sales_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Channel Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `spend_limit` SET TAGS ('dbx_business_glossary_term' = 'Account Spend Limit');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `spend_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `spend_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exemption_certificate` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exemption_certificate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'invoice_processing');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Generated By Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustments Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `adjustments_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `bill_date` SET TAGS ('dbx_business_glossary_term' = 'Bill Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `bill_format` SET TAGS ('dbx_business_glossary_term' = 'Bill Format');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `bill_format` SET TAGS ('dbx_value_regex' = 'detailed|summary|itemized');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `bill_language_code` SET TAGS ('dbx_business_glossary_term' = 'Bill Language Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `bill_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `billing_segment` SET TAGS ('dbx_business_glossary_term' = 'Billing Segment');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `billing_segment` SET TAGS ('dbx_value_regex' = 'consumer|small_business|enterprise|wholesale|mvno|government');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `current_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Charges Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `current_charges_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `current_charges_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Bill Delivery Channel');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'email|paper|portal|sms|api');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `dunning_status` SET TAGS ('dbx_business_glossary_term' = 'Dunning Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `dunning_status` SET TAGS ('dbx_value_regex' = 'not_in_dunning|reminder_sent|warning_issued|suspended|collections|written_off');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Fees Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `fees_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `fees_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|issued|paid|disputed|written_off|cancelled');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|final|interim|credit_note|debit_note|pro_forma');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `is_disputed` SET TAGS ('dbx_business_glossary_term' = 'Is Disputed Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `is_paperless` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Issued Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `late_payment_fee` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Fee');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `late_payment_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `late_payment_fee` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `outstanding_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `outstanding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `outstanding_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Paid Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `paper_bill_fee` SET TAGS ('dbx_business_glossary_term' = 'Paper Bill Fee');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `paper_bill_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `paper_bill_fee` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'auto_pay|manual|direct_debit|credit_card|bank_transfer|cash');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `payments_received_amount` SET TAGS ('dbx_business_glossary_term' = 'Payments Received Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `payments_received_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `payments_received_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `previous_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Previous Balance Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `previous_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `previous_balance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `source_invoice_ref` SET TAGS ('dbx_business_glossary_term' = 'Source Invoice Reference');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'amdocs|comverse_one|manual');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `tax_exemption_certificate` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Due');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_processing');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `spectrum_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Spectrum Allocation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `iptv_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Iptv Channel Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_business_glossary_term' = 'Msisdn Range Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `msisdn_range_id` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `original_line_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Line ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `tap_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tap Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vod Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `cdr_reference` SET TAGS ('dbx_business_glossary_term' = 'Call Detail Record (CDR) Reference');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `charge_description` SET TAGS ('dbx_business_glossary_term' = 'Charge Description');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `charge_period_end` SET TAGS ('dbx_business_glossary_term' = 'Charge Period End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `charge_period_start` SET TAGS ('dbx_business_glossary_term' = 'Charge Period Start Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'recurring|one_time|usage|adjustment|credit|tax');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `discount_code` SET TAGS ('dbx_business_glossary_term' = 'Discount Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Charge Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `is_prorated` SET TAGS ('dbx_business_glossary_term' = 'Is Prorated Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'active|disputed|adjusted|cancelled|reversed|written_off');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Charge Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `prepaid_indicator` SET TAGS ('dbx_business_glossary_term' = 'Prepaid Indicator');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `rated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rated Quantity');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `rating_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Rating Plan Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `rating_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rating Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `roaming_indicator` SET TAGS ('dbx_business_glossary_term' = 'Roaming Indicator');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_identifier` SET TAGS ('dbx_business_glossary_term' = 'Service Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `source_system_line_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Line Reference');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Line Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `total_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `visited_network_code` SET TAGS ('dbx_business_glossary_term' = 'Visited Network Code (PLMN)');
ALTER TABLE `telecommunication_ecm`.`billing`.`invoice_line` ALTER COLUMN `visited_network_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5,6}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Collector Agent ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `original_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Original Payment ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `regulatory_penalty_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Payment Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Authorization Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Last Four Digits');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `bank_routing_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `bank_routing_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|unionpay|other');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `gateway` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `is_auto_pay` SET TAGS ('dbx_business_glossary_term' = 'Auto-Pay Indicator');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `is_partial_payment` SET TAGS ('dbx_business_glossary_term' = 'Partial Payment Indicator');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `net_received_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Received Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `net_received_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `net_received_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|direct_debit|bank_transfer|cash|voucher|digital_wallet');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|reversed|failed|refunded|disputed');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'standard|advance|deposit|refund|reversal|adjustment');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `processing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Processing Fee Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `processing_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `processing_fee_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,40}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Reversal Reason');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Reversal Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'amdocs_collections|comverse_one|salesforce_crm|manual_entry|payment_gateway');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9-_]{6,60}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Payment Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment` ALTER COLUMN `voucher_code` SET TAGS ('dbx_business_glossary_term' = 'Voucher Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` SET TAGS ('dbx_subdomain' = 'rate_planning');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `rated_event_id` SET TAGS ('dbx_business_glossary_term' = 'Rated Event Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `cdr_id` SET TAGS ('dbx_business_glossary_term' = 'Call Detail Record (CDR) Reference Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `ran_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Cell Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `coverage_area_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `fiber_cable_id` SET TAGS ('dbx_business_glossary_term' = 'Fiber Cable Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `lawful_intercept_order_id` SET TAGS ('dbx_business_glossary_term' = 'Lawful Intercept Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `original_rated_event_id` SET TAGS ('dbx_business_glossary_term' = 'Original Rated Event Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Serving Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `customer_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `tap_record_id` SET TAGS ('dbx_business_glossary_term' = 'Tap Record Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `access_point_name` SET TAGS ('dbx_business_glossary_term' = 'Access Point Name (APN)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `bundle_consumed` SET TAGS ('dbx_business_glossary_term' = 'Bundle Allowance Consumed Indicator');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `called_party_number` SET TAGS ('dbx_business_glossary_term' = 'Called Party Number (B-Number)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `called_party_number` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{6,14}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `called_party_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `called_party_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Charge Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `charge_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'usage|recurring|one_time|adjustment|reversal');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code (ISO 4217)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `dispute_reference` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reference Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `event_direction` SET TAGS ('dbx_business_glossary_term' = 'Event Direction');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `event_direction` SET TAGS ('dbx_value_regex' = 'MO|MT|forward|unknown');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Usage Event End Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Usage Event Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Event Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `home_plmn` SET TAGS ('dbx_business_glossary_term' = 'Home Public Land Mobile Network (Home PLMN)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `home_plmn` SET TAGS ('dbx_value_regex' = '^[0-9]{5,6}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `imei` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Equipment Identity (IMEI)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `imei` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `imei` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `imei` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `imsi` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `imsi` SET TAGS ('dbx_value_regex' = '^[0-9]{14,15}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `imsi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `imsi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `inter_operator_charge` SET TAGS ('dbx_business_glossary_term' = 'Inter-Operator Charge Amount (IOT)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `is_roaming` SET TAGS ('dbx_business_glossary_term' = 'Roaming Indicator');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `msisdn` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `msisdn` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{6,14}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `net_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Charge Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `net_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `net_charge_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `network_technology` SET TAGS ('dbx_business_glossary_term' = 'Network Access Technology');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `rated_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Rated Duration (Seconds)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `rated_unit_count` SET TAGS ('dbx_business_glossary_term' = 'Rated Unit Count');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `rated_volume_bytes` SET TAGS ('dbx_business_glossary_term' = 'Rated Data Volume (Bytes)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `rating_engine` SET TAGS ('dbx_business_glossary_term' = 'Rating Engine Source');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `rating_engine` SET TAGS ('dbx_value_regex' = 'amdocs|comverse_one|partner_feed|manual');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `rating_mode` SET TAGS ('dbx_business_glossary_term' = 'Rating Processing Mode');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `rating_mode` SET TAGS ('dbx_value_regex' = 'real_time|batch|offline');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `rating_status` SET TAGS ('dbx_value_regex' = 'rated|re_rated|disputed|written_off|pending|rejected');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `rating_tier` SET TAGS ('dbx_business_glossary_term' = 'Rating Tier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `rating_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rating Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `re_rating_reason` SET TAGS ('dbx_business_glossary_term' = 'Re-Rating Reason');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `roaming_country_code` SET TAGS ('dbx_business_glossary_term' = 'Roaming Country Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `roaming_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `service_identifier` SET TAGS ('dbx_business_glossary_term' = 'Service Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `serving_plmn` SET TAGS ('dbx_business_glossary_term' = 'Serving Public Land Mobile Network (Serving PLMN / Visited PLMN)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `serving_plmn` SET TAGS ('dbx_value_regex' = '^[0-9]{5,6}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `tap_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Transferred Account Procedure (TAP) File Reference');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rated_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` SET TAGS ('dbx_subdomain' = 'invoice_processing');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `billing_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `addon_id` SET TAGS ('dbx_business_glossary_term' = 'Addon Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Agent ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `billing_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Applied By Agent ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `billing_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `billing_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `spectrum_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Spectrum Allocation Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Ip Address Pool Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `ip_address_pool_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `managed_service_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Service Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `ont_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ont Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `reversal_charge_billing_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal Charge ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Specification ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Product Instance ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vod Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Charge Approval Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending_approval|approved|rejected');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Charge Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `charge_description` SET TAGS ('dbx_business_glossary_term' = 'Charge Description');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `charge_number` SET TAGS ('dbx_business_glossary_term' = 'Charge Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `charge_number` SET TAGS ('dbx_value_regex' = '^CHG-[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `charge_source` SET TAGS ('dbx_business_glossary_term' = 'Charge Source System');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `charge_source` SET TAGS ('dbx_value_regex' = 'amdocs|comverse|manual|order_management|product_catalog|crm');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `charge_status` SET TAGS ('dbx_business_glossary_term' = 'Charge Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `dunning_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dunning Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Charge Effective Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Charge Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `is_prorated` SET TAGS ('dbx_business_glossary_term' = 'Is Prorated Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `mrr_contribution` SET TAGS ('dbx_business_glossary_term' = 'Monthly Recurring Revenue (MRR) Contribution');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `mrr_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `mrr_contribution` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Charge Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Charge Period End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Charge Period Start Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `proration_factor` SET TAGS ('dbx_business_glossary_term' = 'Proration Factor');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Reason Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `source_system_charge_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Charge ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `tax_class` SET TAGS ('dbx_business_glossary_term' = 'Tax Class');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `tax_class` SET TAGS ('dbx_value_regex' = 'taxable|exempt|zero_rated|reduced_rate|regulatory_surcharge');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_charge` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Charge Waiver Reason');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` SET TAGS ('dbx_subdomain' = 'invoice_processing');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Dispute ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Agent ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Invoice ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `regulatory_penalty_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `settlement_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Dispute Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vod Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_category` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Category');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_value_regex' = '^ADJ-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|applied|reversed|expired');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'credit|debit');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `applied_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Applied Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Approval Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `approval_threshold_breached` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Breached Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `credit_note_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Issue Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `credit_note_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `credit_note_number` SET TAGS ('dbx_value_regex' = '^CN-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `credited_onetime_amount` SET TAGS ('dbx_business_glossary_term' = 'Credited One-Time Charge Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `credited_onetime_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `credited_onetime_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `credited_recurring_amount` SET TAGS ('dbx_business_glossary_term' = 'Credited Recurring Charge Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `credited_recurring_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `credited_recurring_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `credited_usage_amount` SET TAGS ('dbx_business_glossary_term' = 'Credited Usage Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `credited_usage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `credited_usage_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Document Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'internal_adjustment|credit_note');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Effective Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Expiry Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Gross Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `is_customer_visible` SET TAGS ('dbx_business_glossary_term' = 'Customer Visible Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Net Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `requires_manager_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Manager Approval Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `revenue_recognition_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reversal Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reversal Reason');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'amdocs_revenue_management|comverse_one|salesforce_crm|servicenow_itsm|manual');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Tax Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `tax_reversal_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Reversal Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `tax_reversal_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `tax_reversal_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` SET TAGS ('dbx_subdomain' = 'dunning_collections');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `billing_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Charge ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Agent ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `previous_dispute_billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Dispute ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `regulatory_penalty_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Penalty Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `settlement_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Dispute Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vod Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `approved_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Credit Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `approved_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `approved_credit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `cdr_reference` SET TAGS ('dbx_business_glossary_term' = 'Call Detail Record (CDR) Reference');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Dispute Intake Channel');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `credit_note_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'consumer|small_business|enterprise|wholesale|mvno');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_value_regex' = '^DSP-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|under_review|escalated|resolved|closed|withdrawn');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|regulatory');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Dispute Priority');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `raised_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `raised_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Description');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `regulatory_complaint_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Complaint Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `repeat_dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Dispute Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Notes');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Outcome');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'upheld|partially_upheld|rejected|withdrawn');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `sla_breached` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breached Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `sla_due_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Due Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'amdocs|salesforce|comverse|servicenow|manual');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` SET TAGS ('dbx_subdomain' = 'dunning_collections');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `dunning_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Event ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Dispute Case ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `dunning_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Profile ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Collections Agent ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `payment_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `previous_dunning_event_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Dunning Event ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dunning Action Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `agent_notes` SET TAGS ('dbx_business_glossary_term' = 'Collections Agent Notes');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `collections_cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Collections Cycle Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `collections_queue` SET TAGS ('dbx_business_glossary_term' = 'Collections Queue Name');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'SMS|EMAIL|LETTER|IVR|PUSH_NOTIFICATION|AGENT_CALL');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `communication_template_code` SET TAGS ('dbx_business_glossary_term' = 'Communication Template Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `communication_template_code` SET TAGS ('dbx_value_regex' = '^TMPL-[A-Z0-9]{4,20}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `customer_response_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `customer_response_code` SET TAGS ('dbx_value_regex' = 'PAYMENT_PROMISE|PAYMENT_MADE|DISPUTE_RAISED|NO_RESPONSE|CONTACT_REQUESTED|HARDSHIP_CLAIM');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `customer_response_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Communication Delivery Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'DELIVERED|UNDELIVERED|BOUNCED|OPTED_OUT|PENDING');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Communication Delivery Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `dunning_level` SET TAGS ('dbx_value_regex' = '1ST_NOTICE|2ND_NOTICE|SUSPENSION_WARNING|SUSPENSION|TERMINATION');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `dunning_segment` SET TAGS ('dbx_business_glossary_term' = 'Dunning Customer Segment');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `dunning_segment` SET TAGS ('dbx_value_regex' = 'CONSUMER|SMB|ENTERPRISE|WHOLESALE|MVNO');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `dunning_status` SET TAGS ('dbx_business_glossary_term' = 'Dunning Event Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `dunning_status` SET TAGS ('dbx_value_regex' = 'PENDING|SENT|DELIVERED|FAILED|CANCELLED|RESOLVED');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `escalation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dunning Escalation Reason Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `hardship_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Hardship Program Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `mrr_at_risk_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Recurring Revenue (MRR) at Risk Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `mrr_at_risk_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `mrr_at_risk_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `next_action_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Dunning Action Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `next_dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Next Dunning Level');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `next_dunning_level` SET TAGS ('dbx_value_regex' = '1ST_NOTICE|2ND_NOTICE|SUSPENSION_WARNING|SUSPENSION|TERMINATION|NONE');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `outstanding_balance_amt` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `outstanding_balance_amt` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `outstanding_balance_amt` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_business_glossary_term' = 'Overdue Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `overdue_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `promise_to_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Promise-to-Pay Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `promise_to_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `promise_to_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `promise_to_pay_date` SET TAGS ('dbx_business_glossary_term' = 'Promise-to-Pay Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `ref` SET TAGS ('dbx_business_glossary_term' = 'Dunning Event Reference Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `ref` SET TAGS ('dbx_value_regex' = '^DUN-[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `regulatory_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `scheduled_action_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Dunning Action Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'AMDOCS_COLLECTIONS|COMVERSE_ONE|MANUAL');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Service Suspension Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Service Termination Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_event` ALTER COLUMN `write_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `prepaid_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Prepaid Balance ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `primary_prepaid_migration_target_account_billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Migration Target Account ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `customer_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Balance Account Activation Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `auto_recharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Auto-Recharge Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `auto_recharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `auto_recharge_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `auto_recharge_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Recharge Enabled');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `auto_recharge_payment_token` SET TAGS ('dbx_business_glossary_term' = 'Auto-Recharge Payment Token');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `auto_recharge_payment_token` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `auto_recharge_payment_token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `auto_recharge_trigger_threshold` SET TAGS ('dbx_business_glossary_term' = 'Auto-Recharge Trigger Threshold');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `balance_freeze_reason` SET TAGS ('dbx_business_glossary_term' = 'Balance Freeze Reason');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `balance_freeze_reason` SET TAGS ('dbx_value_regex' = 'fraud_investigation|regulatory_hold|subscriber_request|legal_order|sim_swap_pending');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `balance_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Balance Reference Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `balance_reference_number` SET TAGS ('dbx_value_regex' = '^BAL-[A-Z0-9]{10,20}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `balance_snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Balance Snapshot Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_business_glossary_term' = 'Balance Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `balance_status` SET TAGS ('dbx_value_regex' = 'active|expired|frozen|migrated_to_postpaid|suspended');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `balance_validity_days` SET TAGS ('dbx_business_glossary_term' = 'Balance Validity Days');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `bonus_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Balance Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `bonus_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `bonus_balance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `content_credit_balance` SET TAGS ('dbx_business_glossary_term' = 'Content Credit Balance');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `content_credit_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `content_credit_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `content_credit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Content Credit Expiry Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `data_bucket_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Bucket Expiry Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `data_bucket_mb` SET TAGS ('dbx_business_glossary_term' = 'Data Bucket Megabytes (MB)');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Balance Account Deactivation Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `grace_period_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Expiry Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `iccid` SET TAGS ('dbx_business_glossary_term' = 'Integrated Circuit Card Identifier (ICCID)');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `iccid` SET TAGS ('dbx_value_regex' = '^[0-9]{18,22}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `iccid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `iccid` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `imsi` SET TAGS ('dbx_business_glossary_term' = 'International Mobile Subscriber Identity (IMSI)');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `imsi` SET TAGS ('dbx_value_regex' = '^[0-9]{14,15}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `imsi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `imsi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `last_recharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Recharge Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `last_recharge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `last_recharge_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `last_recharge_channel` SET TAGS ('dbx_business_glossary_term' = 'Last Recharge Channel');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `last_recharge_date` SET TAGS ('dbx_business_glossary_term' = 'Last Recharge Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `last_recharge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Recharge Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `low_balance_notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Low Balance Notification Enabled');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `low_balance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Low Balance Threshold');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `main_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Main Balance Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `main_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `main_balance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `main_balance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Main Balance Expiry Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `msisdn` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `msisdn` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{6,14}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `msisdn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `msisdn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `recharge_count_current_month` SET TAGS ('dbx_business_glossary_term' = 'Current Month Recharge Count');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `recharge_count_lifetime` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Recharge Count');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `reserved_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserved Balance Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `reserved_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `reserved_balance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `sms_bucket_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'SMS Bucket Expiry Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `sms_bucket_units` SET TAGS ('dbx_business_glossary_term' = 'SMS Bucket Units');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `voice_bucket_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Voice Bucket Expiry Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`prepaid_balance` ALTER COLUMN `voice_bucket_minutes` SET TAGS ('dbx_business_glossary_term' = 'Voice Bucket Minutes');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `recharge_id` SET TAGS ('dbx_business_glossary_term' = 'Recharge Transaction ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `balance_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Balance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent / Retailer ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `location_site_id` SET TAGS ('dbx_business_glossary_term' = 'Recharge Location Site Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `original_recharge_id` SET TAGS ('dbx_business_glossary_term' = 'Original Recharge Transaction ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `sim_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Sim Stock Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service Instance Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `voucher_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Voucher Batch ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Recharge Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `balance_after` SET TAGS ('dbx_business_glossary_term' = 'Balance After Recharge');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `balance_after` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `balance_after` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `balance_before` SET TAGS ('dbx_business_glossary_term' = 'Balance Before Recharge');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `balance_before` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `balance_before` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `balance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Balance Expiry Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Credit Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Recharge Channel');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'voucher|online|agent|ussd|bank_transfer|mobile_app');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `data_bonus_mb` SET TAGS ('dbx_business_glossary_term' = 'Data Bonus Credit (MB)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `failure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Recharge Failure Reason Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `home_country_code` SET TAGS ('dbx_business_glossary_term' = 'Home Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `home_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `msisdn` SET TAGS ('dbx_business_glossary_term' = 'Mobile Station International Subscriber Directory Number (MSISDN)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `msisdn` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{6,14}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `msisdn` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `msisdn` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `net_credited_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Credited Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `net_credited_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `net_credited_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `network_node_code` SET TAGS ('dbx_business_glossary_term' = 'Network Node ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|debit_card|bank_transfer|mobile_wallet|cash|direct_debit');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Gateway Reference');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `processing_duration_ms` SET TAGS ('dbx_business_glossary_term' = 'Recharge Processing Duration (Milliseconds)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `recharge_date` SET TAGS ('dbx_business_glossary_term' = 'Recharge Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `recharge_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recharge Event Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `recharge_type` SET TAGS ('dbx_business_glossary_term' = 'Recharge Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `recharge_type` SET TAGS ('dbx_value_regex' = 'standard|promotional|bonus|emergency|auto_recharge|gifted');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Recharge Reversal Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `roaming_flag` SET TAGS ('dbx_business_glossary_term' = 'Roaming Recharge Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `sms_bonus_count` SET TAGS ('dbx_business_glossary_term' = 'SMS Bonus Credit (Count)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'comverse_one|amdocs|external_gateway|ussd_platform|ivr_platform');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Applicable Tax Rate');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Recharge Transaction Reference Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Recharge Transaction Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'success|failed|pending|reversed|expired|partial');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `ussd_session_code` SET TAGS ('dbx_business_glossary_term' = 'Unstructured Supplementary Service Data (USSD) Session ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `validity_days` SET TAGS ('dbx_business_glossary_term' = 'Recharge Validity Period (Days)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `voice_bonus_minutes` SET TAGS ('dbx_business_glossary_term' = 'Voice Bonus Credit (Minutes)');
ALTER TABLE `telecommunication_ecm`.`billing`.`recharge` ALTER COLUMN `voucher_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Voucher Serial Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` SET TAGS ('dbx_subdomain' = 'rate_planning');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `price_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Price Plan Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `promotion_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `activation_fee` SET TAGS ('dbx_business_glossary_term' = 'Activation Fee');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `activation_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `billing_period` SET TAGS ('dbx_business_glossary_term' = 'Billing Period');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `billing_period` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|weekly|daily');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `charging_model` SET TAGS ('dbx_business_glossary_term' = 'Charging Model');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `charging_model` SET TAGS ('dbx_value_regex' = 'flat|tiered|volume|event_based|time_based');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Months)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `day_of_week_modifier_enabled` SET TAGS ('dbx_business_glossary_term' = 'Day-of-Week Modifier Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `early_termination_fee` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee (ETF)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `early_termination_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Effective End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `fair_use_cap_mb` SET TAGS ('dbx_business_glossary_term' = 'Fair Use Policy (FUP) Cap (MB)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `included_data_volume_mb` SET TAGS ('dbx_business_glossary_term' = 'Included Data Volume Allowance (MB)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `included_sms_count` SET TAGS ('dbx_business_glossary_term' = 'Included SMS Count Allowance');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `included_voice_minutes` SET TAGS ('dbx_business_glossary_term' = 'Included Voice Minutes Allowance');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `is_promotional` SET TAGS ('dbx_business_glossary_term' = 'Promotional Rate Plan Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'consumer|smb|enterprise|wholesale|government');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `off_peak_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Off-Peak Period Rate Multiplier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `off_peak_rate_multiplier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `overage_rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Overage Rate Per Unit');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `overage_rate_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `overage_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Overage Unit of Measure');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `peak_end_time` SET TAGS ('dbx_business_glossary_term' = 'Peak Period End Time (HH:MM)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `peak_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Peak Period Rate Multiplier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `peak_rate_multiplier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `peak_start_time` SET TAGS ('dbx_business_glossary_term' = 'Peak Period Start Time (HH:MM)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated|suspended');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'postpaid|prepaid|hybrid|wholesale|mvno');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `promotion_end_date` SET TAGS ('dbx_business_glossary_term' = 'Promotion End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `proration_method` SET TAGS ('dbx_business_glossary_term' = 'Proration Method');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `proration_method` SET TAGS ('dbx_value_regex' = 'daily|none|full_period');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `rate_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `rate_plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `rate_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Description');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `rate_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Name');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `rate_tier_count` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier Count');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `rating_method` SET TAGS ('dbx_business_glossary_term' = 'Rating Method');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `rating_method` SET TAGS ('dbx_value_regex' = 'real_time|batch|hybrid');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `recurring_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Recurring Charge Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `recurring_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `revenue_recognition_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `revenue_recognition_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `roaming_data_rate_per_mb` SET TAGS ('dbx_business_glossary_term' = 'Roaming Data Rate Per MB');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `roaming_data_rate_per_mb` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `roaming_enabled` SET TAGS ('dbx_business_glossary_term' = 'Roaming Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `roaming_voice_rate_per_min` SET TAGS ('dbx_business_glossary_term' = 'Roaming Voice Rate Per Minute');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `roaming_voice_rate_per_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `tax_class_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `tax_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Network Technology Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `tier_rate_1` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier 1 Unit Rate');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `tier_rate_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `tier_rate_2` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier 2 Unit Rate');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `tier_rate_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `tier_rate_3` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier 3 Unit Rate');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `tier_rate_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `tier_threshold_1_mb` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier 1 Threshold (MB)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `tier_threshold_2_mb` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier 2 Threshold (MB)');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `time_of_day_modifier_enabled` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Day Modifier Enabled Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Version Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `weekend_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Weekend Rate Multiplier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan` ALTER COLUMN `weekend_rate_multiplier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` SET TAGS ('dbx_subdomain' = 'invoice_processing');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Adjustment ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Dispute ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Account Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `cpe_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cpe Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Invoice ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issued By Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Content Package Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `settlement_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Dispute Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `spec_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `svc_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Service ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `trouble_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Trouble Ticket Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `vod_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Vod Asset Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `applied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `applied_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `applied_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Applied Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Approval Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|auto_approved');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_category` SET TAGS ('dbx_business_glossary_term' = 'Credit Category');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_category` SET TAGS ('dbx_value_regex' = 'service_charge|usage_charge|equipment|tax|interconnect|roaming');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_number` SET TAGS ('dbx_value_regex' = '^CN-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_status` SET TAGS ('dbx_value_regex' = 'issued|applied|partially_applied|expired|cancelled|voided');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_type` SET TAGS ('dbx_value_regex' = 'financial|commercial|regulatory|goodwill|equipment_return');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Delivery Channel');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'email|portal|post|sms|in_app');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Delivery Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Effective Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Expiry Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `is_regulatory_mandated` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandated Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Issue Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Outage Duration (Minutes)');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `outage_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Outage End Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `outage_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Outage Start Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Reason Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Reason Description');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `remaining_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Credit Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `remaining_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `remaining_credit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `revenue_recognition_period` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Period');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `revenue_recognition_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `source_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'amdocs|comverse_one|salesforce|servicenow|manual');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `tax_reversal_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Reversal Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `tax_reversal_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `tax_reversal_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`credit_note` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` SET TAGS ('dbx_subdomain' = 'dunning_collections');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_id` SET TAGS ('dbx_business_glossary_term' = 'Write-Off ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Case ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `recovery_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Recovery Agency ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `agency_assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Assignment Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `agency_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Agency Reference Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = '30_days|60_days|90_days|120_plus_days');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `billing_segment` SET TAGS ('dbx_business_glossary_term' = 'Billing Segment');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `billing_segment` SET TAGS ('dbx_value_regex' = 'consumer|small_medium_business|enterprise|wholesale|mvno');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `collection_attempts_count` SET TAGS ('dbx_business_glossary_term' = 'Collection Attempts Count');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `dunning_stage_at_writeoff` SET TAGS ('dbx_business_glossary_term' = 'Dunning Stage at Write-Off');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `legal_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `legal_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Legal Case Reference');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `outstanding_balance_at_writeoff` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance at Write-Off');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `outstanding_balance_at_writeoff` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `outstanding_balance_at_writeoff` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Provision Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `provision_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `provision_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `reason` SET TAGS ('dbx_value_regex' = 'bankruptcy|deceased|uncontactable|fraud|statute_of_limitations|other');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `reason_notes` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Notes');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'amdocs_collections|comverse_one|manual');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `source_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `statute_of_limitations_date` SET TAGS ('dbx_business_glossary_term' = 'Statute of Limitations Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `tax_write_back_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Write-Back Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `tax_write_back_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `tax_write_back_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_number` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{10}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|sent_to_agency|recovered|partially_recovered|closed');
ALTER TABLE `telecommunication_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `payment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Adjustment ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Collections Agent ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `pipeline_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Run Id (Foreign Key)');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reversed_allocation_payment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Allocation ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Method');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'oldest_first|proportional|specific_invoice|dispute_hold|newest_first|manual');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^ALLOC-[0-9]{10,15}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'allocated|reversed|pending_review|partially_allocated|cancelled|on_hold');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'standard|reversal|adjustment|dispute_settlement|write_off|credit_memo');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue at Allocation');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level at Allocation');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Invoice Balance After Allocation');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_balance_after` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_balance_after` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Invoice Balance Before Allocation');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_balance_before` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_balance_before` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `is_auto_allocated` SET TAGS ('dbx_business_glossary_term' = 'Auto-Allocation Indicator');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `is_partial_payment` SET TAGS ('dbx_business_glossary_term' = 'Partial Payment Indicator');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Fee Amount Allocated');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `overpayment_amount` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `overpayment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `overpayment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `overpayment_handling` SET TAGS ('dbx_business_glossary_term' = 'Overpayment Handling Method');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `overpayment_handling` SET TAGS ('dbx_value_regex' = 'credit_balance|refund|apply_to_next|write_off|pending');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `principal_amount` SET TAGS ('dbx_business_glossary_term' = 'Principal Amount Allocated');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `principal_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `principal_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Allocation Reversal Reason');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'amdocs_collections|comverse_one|manual_entry|sap_fi|migration');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `source_system_allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Allocation ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount Allocated');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `unapplied_balance` SET TAGS ('dbx_business_glossary_term' = 'Unapplied (Unallocated) Cash Balance');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `unapplied_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `unapplied_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` SET TAGS ('dbx_association_edges' = 'billing.billing_account,sales.sales_contract');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `contract_billing_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Billing Arrangement ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Billing Arrangement - Billing Account Id');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `sales_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Billing Arrangement - Sales Contract Id');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Arrangement Type');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `billing_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Billing Allocation Percentage');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `consolidated_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Billing Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Created Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Arrangement End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Start Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `invoice_format_override` SET TAGS ('dbx_business_glossary_term' = 'Invoice Format Override');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Notes');
ALTER TABLE `telecommunication_ecm`.`billing`.`contract_billing_arrangement` ALTER COLUMN `payment_terms_override` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Override');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` SET TAGS ('dbx_association_edges' = 'billing.billing_account,content.content_package');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `billing_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'billing_subscription Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription - Billing Account Id');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription - Content Package Id');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `activation_channel` SET TAGS ('dbx_business_glossary_term' = 'Subscription Activation Channel');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Indicator');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `billing_subscription_status` SET TAGS ('dbx_business_glossary_term' = 'Subscription Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Cancellation Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `commitment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Commitment Period End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `monthly_recurring_charge` SET TAGS ('dbx_business_glossary_term' = 'Subscription Monthly Recurring Charge');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `promotional_code` SET TAGS ('dbx_business_glossary_term' = 'Promotional Code');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Start Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Subscription Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_subscription` ALTER COLUMN `trial_end_date` SET TAGS ('dbx_business_glossary_term' = 'Trial Period End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` SET TAGS ('dbx_subdomain' = 'rate_planning');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` SET TAGS ('dbx_association_edges' = 'billing.rate_plan,content.content_package');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` ALTER COLUMN `rate_plan_content_package_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Content Package Association ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Content Package - Content Package Id');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Content Package - Rate Plan Id');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` ALTER COLUMN `association_status` SET TAGS ('dbx_business_glossary_term' = 'Association Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` ALTER COLUMN `bundle_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Bundle Discount Percentage');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` ALTER COLUMN `is_included_in_base` SET TAGS ('dbx_business_glossary_term' = 'Included in Base Flag');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` ALTER COLUMN `minimum_commitment_months` SET TAGS ('dbx_business_glossary_term' = 'Minimum Commitment Months');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `telecommunication_ecm`.`billing`.`rate_plan_content_package` ALTER COLUMN `promotional_rate` SET TAGS ('dbx_business_glossary_term' = 'Promotional Rate');
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` SET TAGS ('dbx_subdomain' = 'rate_planning');
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` SET TAGS ('dbx_association_edges' = 'billing.rate_plan,enterprise.corporate_account');
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` ALTER COLUMN `corporate_rate_plan_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Rate Plan Agreement ID');
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` ALTER COLUMN `corporate_account_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Rate Plan Agreement - Corporate Account Id');
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` ALTER COLUMN `rate_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Rate Plan Agreement - Rate Plan Id');
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` ALTER COLUMN `commitment_term_months` SET TAGS ('dbx_business_glossary_term' = 'Commitment Term in Months');
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Agreement Created Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective End Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Start Date');
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Agreement Last Modified Timestamp');
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` ALTER COLUMN `minimum_commitment_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Commitment Amount');
ALTER TABLE `telecommunication_ecm`.`billing`.`corporate_rate_plan_agreement` ALTER COLUMN `negotiated_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Discount Percentage');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_cycle` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_cycle` ALTER COLUMN `billing_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`billing_cycle` ALTER COLUMN `prior_billing_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_profile` SET TAGS ('dbx_subdomain' = 'dunning_collections');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_profile` ALTER COLUMN `dunning_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Profile Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`dunning_profile` ALTER COLUMN `escalation_dunning_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_arrangement` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `payment_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`payment_arrangement` ALTER COLUMN `restructured_payment_arrangement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`voucher_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`voucher_batch` SET TAGS ('dbx_subdomain' = 'payment_operations');
ALTER TABLE `telecommunication_ecm`.`billing`.`voucher_batch` ALTER COLUMN `voucher_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Voucher Batch Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`voucher_batch` ALTER COLUMN `parent_voucher_batch_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` SET TAGS ('dbx_subdomain' = 'dunning_collections');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `recovery_agency_id` SET TAGS ('dbx_business_glossary_term' = 'Recovery Agency Identifier');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `escalated_to_recovery_agency_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `telecommunication_ecm`.`billing`.`recovery_agency` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
