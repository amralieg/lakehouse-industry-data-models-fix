-- Schema for Domain: billing | Business: Transport Shipping | Version: v1_mvm
-- Generated on: 2026-05-08 22:35:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`billing` COMMENT 'SSOT for all revenue transactions, invoicing, freight audit and payment, payment processing, and accounts receivable across all service lines. Owns customer invoices, carrier payables, COD collections, credit notes, dispute resolution, charge-back management, and revenue recognition aligned to IFRS 15. Integrates with SAP S/4HANA Finance and Coupa for end-to-end procure-to-pay and order-to-cash cycles.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique system identifier for the invoice record. Primary key. TRANSACTION_HEADER role inferred.',
    `agreement_id` BIGINT COMMENT 'Reference to the master contract or service agreement under which this invoice was generated. Links invoice to contractual terms, pricing, and SLA commitments.',
    `address_book_id` BIGINT COMMENT 'Foreign key linking to customer.address_book. Business justification: Invoice address standardization: logistics invoices are sent to a billing address from the customers validated address book. bill_to_address_line1/2, bill_to_city, bill_to_country_code, bill_to_posta',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Invoice-to-contact billing workflow: logistics billing teams direct invoice delivery, payment chasing, and dispute escalation to a specific billing contact. bill_to_name is a denormalized contact name',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Invoice should reference the billing account master (billing.account) for in-domain linking. Currently invoice only has customer_account_id pointing to customer domain. The billing.account product is ',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Invoices for carrier-provided transport services (e.g., carrier haulage, carrier-direct bookings) require carrier reference for service delivery tracking, dispute resolution, and carrier performance r',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Invoices bill shipments moving on specific lanes. Lane determines pricing structure, transit time commitments, and service level. Essential for invoice validation, lane revenue analysis, pricing dispu',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Agent-originated shipments generate invoices that must track the originating agent for commission calculation, agent performance reporting, and revenue attribution by sales channel. Critical for agent',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Invoice currently has payment_terms as STRING. This should be normalized to reference billing.payment_term master table. The payment_term_id FK allows joining to get code, name, net_days, discount ter',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Invoices for corridor-based services (hub-to-hub networks, regional express). Required for corridor profitability analysis, service product revenue tracking, and network design ROI assessment. Common ',
    `sla_entitlement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_entitlement. Business justification: SLA-based billing: logistics invoices for SLA-governed shipments reference the applicable SLA entitlement to apply penalty deductions or incentive credits (penalty_rate_pct, incentive_rate_pct). Billi',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Additional adjustments applied to the invoice. Includes surcharges, fuel adjustment factors (BAF), currency adjustment factors, and other miscellaneous charges or credits.',
    `amount_outstanding` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the invoice. Calculated as total_amount minus amount_paid. Used for accounts receivable reporting and collections.',
    `amount_paid` DECIMAL(18,2) COMMENT 'Total amount received from customer to date. Used to calculate outstanding balance and track partial payments.',
    `billing_period_end_date` DATE COMMENT 'End date of the period covered by this invoice. Relevant for consolidated and recurring invoices that cover a range of services.',
    `billing_period_start_date` DATE COMMENT 'Start date of the period covered by this invoice. Relevant for consolidated and recurring invoices that cover a range of services.',
    `created_by_user` STRING COMMENT 'User identifier of the person or system that created this invoice record. Audit trail for accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts on this invoice. Determines currency for subtotal, tax, discount, and total amounts.. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Method by which the invoice was or will be delivered to the customer. Email is electronic delivery; postal_mail is physical mail; EDI is electronic data interchange; customer_portal is self-service download; fax is facsimile transmission.. Valid values are `email|postal_mail|edi|customer_portal|fax`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the invoice. Includes volume discounts, promotional discounts, early payment discounts, and contractual discounts.',
    `dispute_date` DATE COMMENT 'Date the customer raised a dispute on this invoice. Used for dispute aging and resolution tracking.',
    `dispute_reason` STRING COMMENT 'Reason provided by customer for disputing the invoice. Populated when invoice_status is disputed. Used for dispute resolution and root cause analysis.',
    `due_date` DATE COMMENT 'Date by which payment is expected from the customer. Calculated based on invoice date and payment terms. Used for accounts receivable aging and collections management.',
    `gl_posting_date` DATE COMMENT 'Date the invoice was posted to the general ledger in SAP S/4HANA Finance. Used for financial period closing and accounting reconciliation.',
    `invoice_date` DATE COMMENT 'Date the invoice was issued to the customer. Principal business event timestamp for the invoice transaction. Used for revenue recognition, aging analysis, and payment term calculation.',
    `invoice_number` STRING COMMENT 'Externally-known unique invoice document number issued to customer. Business identifier for the invoice transaction. Used for customer communication, payment reference, and audit trail.. Valid values are `^INV-[0-9]{8,12}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice. Draft invoices are being prepared; issued invoices are finalized but not yet sent; sent invoices have been transmitted to customer; partially_paid invoices have received partial payment; paid invoices are fully settled; overdue invoices are past due date; disputed invoices are under customer challenge; cancelled invoices are voided; written_off invoices are uncollectible. [ENUM-REF-CANDIDATE: draft|issued|sent|partially_paid|paid|overdue|disputed|cancelled|written_off — 9 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice document type. Standard invoices are regular billing documents; proforma invoices are preliminary estimates; credit notes reduce amounts owed; debit notes increase amounts owed; consolidated invoices combine multiple shipments; recurring invoices are for subscription-based services.. Valid values are `standard|proforma|credit_note|debit_note|consolidated|recurring`',
    `modified_by_user` STRING COMMENT 'User identifier of the person or system that last modified this invoice record. Audit trail for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was last modified. Audit trail for record updates.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the invoice. May include special instructions, billing clarifications, or customer-specific information.',
    `payment_method` STRING COMMENT 'Method by which customer is expected to pay or has paid the invoice. Instrument used for payment transaction. [ENUM-REF-CANDIDATE: bank_transfer|credit_card|debit_card|check|cash|ach|wire_transfer|direct_debit|electronic_payment — 9 candidates stripped; promote to reference product]',
    `payment_received_date` DATE COMMENT 'Date the payment was received from the customer. Used for cash flow analysis and days sales outstanding (DSO) calculation.',
    `purchase_order_number` STRING COMMENT 'Customer purchase order number associated with this invoice. Used for customer invoice matching and accounts payable reconciliation on customer side.',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue from this invoice was or will be recognized in the general ledger. May differ from invoice date based on service delivery and IFRS 15 performance obligations.',
    `revenue_recognition_status` STRING COMMENT 'Status of revenue recognition for this invoice under IFRS 15. Not_recognized indicates revenue has not yet been booked; partially_recognized indicates partial revenue booking for multi-period services; fully_recognized indicates complete revenue booking; deferred indicates revenue is held for future recognition.. Valid values are `not_recognized|partially_recognized|fully_recognized|deferred`',
    `sap_document_number` STRING COMMENT 'Reference to the corresponding financial document in SAP S/4HANA Finance system. Used for reconciliation between billing and financial systems.',
    `sent_date` DATE COMMENT 'Date the invoice was transmitted to the customer. Used for tracking invoice delivery and calculating customer response time.',
    `service_line` STRING COMMENT 'Primary logistics service line that originated this invoice. Used for revenue segmentation and P&L reporting by business unit. [ENUM-REF-CANDIDATE: express_parcel|air_freight|ocean_freight|road_freight|rail_freight|customs_brokerage|warehousing|ecommerce_fulfillment|contract_logistics|last_mile — 10 candidates stripped; promote to reference product]',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item charges before taxes, discounts, and adjustments. Base amount for invoice calculation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice. Includes VAT, GST, sales tax, and other applicable taxes based on jurisdiction.',
    `tax_registration_number` STRING COMMENT 'Tax identification number of the billing party. VAT number, GST number, or equivalent tax registration identifier used for tax compliance and reporting.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final invoice amount due from customer. Calculated as subtotal + tax + adjustment - discount. Net amount for payment and revenue recognition.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Master billing document issued to customers for logistics services rendered across all service lines (express parcel, freight forwarding, customs brokerage, warehousing, e-commerce fulfillment). Captures invoice header data including invoice number, invoice date, due date, billing period, currency, total amount, tax amount, discount amount, invoice status (draft, issued, sent, partially_paid, paid, overdue, disputed, cancelled, written_off), invoice type (standard, proforma, credit_note, debit_note, consolidated, recurring), payment terms (NET30, NET60, COD, prepaid), IFRS 15 revenue recognition status, SAP S/4HANA document reference, and originating service line. SSOT for all customer-facing billing documents.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` (
    `billing_invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key for the invoice_line product.',
    `accessorial_charge_id` BIGINT COMMENT 'Foreign key linking to pricing.accessorial_charge. Business justification: Accessorial charges (liftgate, residential delivery, inside delivery, etc.) appear as invoice line items and must reference the charge definition for GL posting, revenue recognition, waiver tracking, ',
    `agreement_id` BIGINT COMMENT 'Reference to the customer contract or rate agreement under which this charge was calculated.',
    `blocked_space_agreement_id` BIGINT COMMENT 'Foreign key linking to network.blocked_space_agreement. Business justification: Ocean freight charges under BSA contracts must link to agreement for capacity utilization tracking and minimum commitment billing. Enables penalty calculation for underutilization and rate validation ',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier or service provider associated with this charge, used for freight audit and carrier payables.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Freight audit and revenue allocation require service-level detail (express vs. economy, air vs. ocean) beyond carrier alone. Invoice lines must link to carrier_service for rate validation against cont',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment that this charge relates to. Enables traceability from invoice line to physical shipment.',
    `contract_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.contract_rate. Business justification: Invoice lines must reference the specific contracted rate applied for audit compliance, billing dispute resolution, margin analysis, and contract performance reporting. Essential for validating that c',
    `contract_surcharge_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.contract_surcharge_schedule. Business justification: Invoice line surcharges must reference contracted surcharge schedules for revenue assurance and audit compliance. Enables validation that invoiced surcharge rates match agreement terms, critical for d',
    `interline_agreement_id` BIGINT COMMENT 'Foreign key linking to network.interline_agreement. Business justification: Interline shipments generate revenue splits per agreement. Invoice lines must link to agreement for prorate calculation, partner settlement, and revenue allocation between origin and destination carri',
    `invoice_id` BIGINT COMMENT 'Reference to the parent customer invoice header that this line item belongs to.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Individual line items charge for lane-specific services (base freight, fuel surcharge per lane, lane commitment fees). Essential for lane-level revenue recognition, cost allocation, audit trail, and l',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: When shipments are booked through agents (GSA model), invoice lines must track originating agent for commission calculation and revenue sharing. Critical for agent settlement and performance tracking ',
    `performance_obligation_id` BIGINT COMMENT 'IFRS 15 performance obligation identifier linking this charge to a specific contractual promise to deliver goods or services. Used for revenue recognition compliance.',
    `surcharge_id` BIGINT COMMENT 'Foreign key linking to pricing.surcharge. Business justification: Invoice lines itemizing surcharges (fuel, security, peak season) must reference the surcharge definition for revenue recognition, customer transparency, dispute resolution, and regulatory reporting. C',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Freight-collect and cost allocation workflows require tracing customer-billed revenue lines to the inbound purchase order that triggered the freight movement, enabling accurate margin analysis and fre',
    `rate_card_id` BIGINT COMMENT 'Reference to the rate card or pricing schedule used to determine the unit rate for this charge.',
    `route_delivery_zone_id` BIGINT COMMENT 'Foreign key linking to route.route_delivery_zone. Business justification: Line items charge zone-specific fees (remote area surcharge, residential delivery fee, extended area). Essential for zone-based accessorial billing, last-mile cost recovery, and zone surcharge validat',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Line items for corridor-based charges (corridor capacity fees, hub handling). Required for corridor revenue tracking, service product margin analysis, and network service profitability reporting.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Interline and subcontractor billing scenarios require attributing revenue lines to the third-party supplier who performed the service, enabling accurate revenue-share calculations, supplier performanc',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: Tariff-based pricing must be traceable from invoice lines to published tariffs for regulatory compliance (especially in international shipping), audit requirements, and dispute resolution. Mandatory f',
    `tax_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.tax_schedule. Business justification: Invoice_line currently has tax_code (STRING) and tax_rate (DECIMAL). The tax_code should be normalized to reference billing.tax_schedule master table. The tax_schedule_id FK allows joining to get sche',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: 3PL services (warehousing, distribution, last-mile) generate billable charges that must link to provider for cost reconciliation and vendor performance tracking. Supports margin analysis and 3PL spend',
    `transit_time_standard_id` BIGINT COMMENT 'Foreign key linking to route.transit_time_standard. Business justification: Line items reference transit standards for SLA-based billing (guaranteed delivery, express service premiums). Essential for SLA compliance verification, premium service billing validation, and service',
    `audit_status` STRING COMMENT 'Status of freight audit review for this line item (pending, approved, rejected, under_review).. Valid values are `pending|approved|rejected|under_review`',
    `awb_number` STRING COMMENT 'Air waybill number (MAWB or HAWB) associated with this charge, if applicable to air freight shipments.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether this line item is billable to the customer (True) or non-billable/internal (False).',
    `bol_number` STRING COMMENT 'Bill of lading number (MBL or HBL) associated with this charge, if applicable to ocean or ground freight shipments.',
    `charge_category` STRING COMMENT 'High-level categorization of the charge type for reporting and analysis purposes. [ENUM-REF-CANDIDATE: freight|surcharge|accessorial|customs|storage|handling|insurance|other — 8 candidates stripped; promote to reference product]',
    `charge_description` STRING COMMENT 'Human-readable description of the charge or service provided on this line item.',
    `chargeback_flag` BOOLEAN COMMENT 'Indicates whether this line item has been charged back to a carrier or vendor (True) or not (False).',
    `cost_center` STRING COMMENT 'Cost center code to which this charge is allocated for internal cost accounting and management reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line item record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the line amount and unit rate (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'Code identifying the destination location for this charge (airport, seaport, warehouse, or facility code).',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount applied to this line item, if any. Reduces the line_amount before tax calculation.',
    `discount_reason` STRING COMMENT 'Reason or code for the discount applied (e.g., volume discount, promotional discount, service failure credit).',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this line item is under dispute by the customer (True) or not (False).',
    `dispute_reason` STRING COMMENT 'Reason code or description for the dispute if dispute_flag is True (e.g., incorrect rate, service not provided, duplicate charge).',
    `gl_account_code` STRING COMMENT 'General ledger revenue account code to which this line item revenue is posted for financial reporting.',
    `hs_code` STRING COMMENT 'Harmonized System code reference for customs-related charges, used for tariff classification and duty calculation.',
    `line_amount` DECIMAL(18,2) COMMENT 'Total charge amount for this line item before tax (quantity × unit_rate, or flat charge if quantity is 1).',
    `line_number` STRING COMMENT 'Sequential line number within the invoice, used for ordering and referencing individual charge items.',
    `line_total` DECIMAL(18,2) COMMENT 'Total amount for this line item including tax (line_amount + tax_amount).',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this invoice line item.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line item record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this invoice line item, used for clarifications or special instructions.',
    `origin_location_code` STRING COMMENT 'Code identifying the origin location for this charge (airport, seaport, warehouse, or facility code).',
    `profit_center` STRING COMMENT 'Profit center code for internal profitability analysis and segment reporting.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the service or unit being charged (e.g., weight, volume, number of shipments, number of pallets).',
    `revenue_recognition_date` DATE COMMENT 'Date when revenue for this line item is recognized in the financial statements per IFRS 15 guidelines.',
    `revenue_type` STRING COMMENT 'Classification of revenue type for financial reporting and revenue recognition purposes.. Valid values are `freight_revenue|surcharge_revenue|accessorial_revenue|customs_revenue|storage_revenue|other_revenue`',
    `service_code` STRING COMMENT 'Code identifying the type of billable service or charge (e.g., freight, handling, storage, customs clearance).',
    `service_date` DATE COMMENT 'Date when the service was performed or the charge was incurred. Used for revenue recognition timing.',
    `surcharge_type` STRING COMMENT 'Specific type of surcharge applied (BAF - Bunker Adjustment Factor, THC - Terminal Handling Charge, GRI - General Rate Increase, fuel surcharge, peak season surcharge, remote area surcharge, DIM weight surcharge). Null if not a surcharge.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated for this line item based on line_amount and tax_rate.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate percentage applied to this line item (e.g., 20.00 for 20% VAT).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity (kg - kilogram, lb - pound, CBM - cubic meter, CFT - cubic foot, TEU - twenty-foot equivalent unit, shipment, pallet, container, hour, day, piece). [ENUM-REF-CANDIDATE: kg|lb|cbm|cft|teu|shipment|pallet|container|hour|day|piece|other — 12 candidates stripped; promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'Rate charged per unit of measure. Used to calculate line amount (quantity × unit_rate).',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this invoice line item.',
    CONSTRAINT pk_billing_invoice_line PRIMARY KEY(`billing_invoice_line_id`)
) COMMENT 'Individual charge line items on a customer invoice, representing discrete billable services or surcharges. Each line captures the service code, charge description, quantity, unit of measure (kg, CBM, TEU, shipment, pallet), unit rate, line amount, tax code, tax amount, cost center, profit center, revenue account GL code, HS code reference for customs-related charges, surcharge type (BAF, THC, GRI, fuel surcharge, peak season surcharge, remote area surcharge), and IFRS 15 performance obligation identifier. Supports detailed revenue recognition and freight audit reconciliation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`credit_note` (
    `credit_note_id` BIGINT COMMENT 'Unique identifier for the credit note record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Credit notes reference master agreements for contractual credit terms, dispute resolution clauses, and revenue recognition policies. Essential for contract compliance tracking and financial audit trai',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: A credit note is issued within the context of a specific billing account relationship. Linking credit_note directly to billing_account enables AR reconciliation at the account level, supports consolid',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the cargo claim case if this credit note is issued as settlement for cargo loss, damage, or delay. Nullable for non-claim credits. Supports claims management integration.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Credit notes issued for carrier service failures, delays, or billing disputes require carrier reference for root cause analysis, carrier performance tracking, and carrier chargeback processing. Essent',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Credit notes for duty refunds, drawback claims, and customs adjustments require declaration reference for customs reconciliation, audit trail, and regulatory compliance documentation.',
    `invoice_id` BIGINT COMMENT 'Reference to the original invoice being credited or adjusted. Links this credit note to the source billing document.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Credit note issuance process: in logistics, credit notes are issued to a designated billing contact for acknowledgment and application against open invoices. The contact receives notification and conf',
    `application_status` STRING COMMENT 'Tracks whether the credit note has been applied to customer invoices. Open indicates unused credit, partially_applied shows partial usage, fully_applied means completely consumed, expired for time-lapsed credits, and voided for cancelled credits.. Valid values are `open|partially_applied|fully_applied|expired|voided`',
    `applied_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of this credit note that has been applied to customer invoices. Tracks utilization for accounts receivable netting and credit balance management.',
    `approval_status` STRING COMMENT 'Current approval workflow state of the credit note. Tracks progression from draft through approval gates to final approved or rejected state. Supports SOX compliance and segregation of duties.. Valid values are `draft|pending_approval|approved|rejected|cancelled`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the credit note was approved. Nullable for unapproved credits. Provides precise audit trail for financial controls.',
    `business_unit` STRING COMMENT 'Organizational business unit or division responsible for this credit note. Supports multi-entity financial reporting and cost center allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the credit note record was first created in the system. Provides audit trail for record lifecycle tracking.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Gross credit amount before tax adjustments. Represents the base value being credited to the customer account in the transaction currency.',
    `credit_note_number` STRING COMMENT 'Externally-known unique business identifier for the credit note, typically following company numbering convention (e.g., CN-20240001234). Used for customer communication and audit trail.. Valid values are `^CN-[0-9]{8,12}$`',
    `credit_reason_code` STRING COMMENT 'Standardized code indicating the business reason for issuing the credit note. Categories include billing errors, service failures, SLA breaches, rate disputes, duplicate charges, and goodwill adjustments. Used for root cause analysis and process improvement.. Valid values are `billing_error|service_failure|sla_breach|rate_dispute|duplicate_charge|goodwill_adjustment`',
    `credit_reason_description` STRING COMMENT 'Detailed free-text explanation of the specific circumstances that led to the credit note issuance. Provides context beyond the standardized reason code for audit and customer service purposes.',
    `credit_type` STRING COMMENT 'Classification of the credit note by its financial impact type. Distinguishes between full invoice reversals, partial adjustments, tax-only corrections, freight-specific adjustments, and claim settlements.. Valid values are `full_reversal|partial_adjustment|tax_correction|freight_adjustment|claim_settlement`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit note transaction (e.g., USD, EUR, GBP). Defines the monetary unit for all amount fields.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date from which the credit note becomes effective for accounts receivable netting and financial reporting. May differ from issue date for backdated adjustments.',
    `expiry_date` DATE COMMENT 'Date after which the credit note can no longer be applied to customer invoices. Nullable for credits with no expiration. Used to enforce time-bound credit policies.',
    `gl_posting_date` DATE COMMENT 'Date when the credit note was posted to the general ledger in the financial system. Used for period-end close and financial statement preparation.',
    `is_automated` BOOLEAN COMMENT 'Flag indicating whether this credit note was generated by an automated system rule (true) or manually created by a user (false). Supports process automation analysis and quality control.',
    `issue_date` DATE COMMENT 'Date when the credit note was officially issued to the customer. This is the business event date used for financial period allocation and revenue recognition reversal.',
    `issuing_location_code` STRING COMMENT 'Three-letter code identifying the station, branch, or facility that issued the credit note. Supports geographic performance analysis and operational accountability.. Valid values are `^[A-Z]{3}$`',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified the credit note record. Supports change tracking and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the credit note record was last modified. Tracks the most recent change for audit and data quality purposes.',
    `notes` STRING COMMENT 'Free-text field for additional comments, instructions, or context related to the credit note. Used for internal communication and customer service reference.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Unapplied credit balance available for future invoice netting. Calculated as total_credit_amount minus applied_amount. Used for customer credit balance reporting.',
    `revenue_reversal_period` STRING COMMENT 'Fiscal period (YYYY-MM format) to which the revenue reversal is allocated for financial reporting. Supports IFRS 15 revenue recognition compliance and period-specific P&L adjustments.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `sap_credit_memo_number` STRING COMMENT 'Reference to the corresponding credit memo document in SAP S/4HANA Finance system. Enables reconciliation between lakehouse and ERP financial records.',
    `service_line` STRING COMMENT 'Business service line to which this credit note applies. Enables service-specific credit analysis and performance tracking across express, freight, warehousing, and other logistics services. [ENUM-REF-CANDIDATE: express_parcel|air_freight|ocean_freight|road_freight|rail_freight|warehousing|customs_brokerage|ecommerce_fulfillment — 8 candidates stripped; promote to reference product]',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax adjustment associated with this credit note. May be positive (tax credit) or negative depending on the nature of the adjustment. Supports VAT, GST, and other applicable tax regimes.',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'Net total credit amount including all tax adjustments. This is the final amount that will be applied to the customers accounts receivable balance.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or automated process that created the credit note record. Supports audit trail and accountability.',
    CONSTRAINT pk_credit_note PRIMARY KEY(`credit_note_id`)
) COMMENT 'Formal credit document issued to customers to reverse or reduce a previously issued invoice amount. Captures credit note number, originating invoice reference, credit reason code (billing error, service failure, SLA breach, rate dispute, duplicate charge, goodwill adjustment, cargo claim settlement), credit amount, tax adjustment, approval status, approver identity, issue date, expiry date, application status (open, partially_applied, fully_applied), and SAP S/4HANA credit memo document reference. Supports dispute resolution and accounts receivable netting.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction. Primary key for the payment record.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Payments are received against a billing account, not just a single invoice (advance payments, consolidated payments, and unapplied cash all exist at the account level). Linking payment directly to bil',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Direct carrier payments (COD remittance to carriers, interline settlement payments, carrier refunds) require carrier reference for payment reconciliation, cash flow tracking, and carrier account manag',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice against which this payment is applied. Links payment to the billing document.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Payment remittance tracking: logistics payments are submitted by a specific AP contact. Linking payment to contact enables remittance advice matching, payment confirmation workflows, and audit trails.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: payment.terms_code is a denormalized STRING reference to the payment term applied to this payment (e.g., NET30, COD). Replacing it with a FK to billing.payment_term normalizes this reference to th',
    `amount` DECIMAL(18,2) COMMENT 'The total monetary value of the payment received in the transaction currency. Represents the gross payment before any adjustments.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this payment was approved for processing. Used for workflow tracking and authorization audit.',
    `authorization_code` STRING COMMENT 'Authorization code provided by the payment processor confirming the transaction was approved. Used for fraud prevention and dispute resolution.',
    `bank_account_reference` STRING COMMENT 'Reference to the bank account into which the payment was deposited. Used for bank reconciliation and cash management.',
    `bank_charges` DECIMAL(18,2) COMMENT 'Bank fees or charges deducted from the payment amount during processing. Reduces the net amount received.',
    `base_currency_amount` DECIMAL(18,2) COMMENT 'The payment amount converted to the organizations base reporting currency using the exchange rate. Used for consolidated financial reporting.',
    `batch_reference` STRING COMMENT 'Reference to the batch or file in which this payment was received. Used for bulk payment processing and reconciliation.',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit or division that received this payment. Used for segment reporting and profitability analysis.',
    `channel` STRING COMMENT 'The interface or channel through which the payment was submitted. Used for channel performance analysis and customer experience optimization.. Valid values are `online_portal|edi|manual|bank_file|mobile_app|api`',
    `clearing_date` DATE COMMENT 'The date on which the payment was cleared against one or more invoices in the accounts receivable system.',
    `clearing_document_reference` STRING COMMENT 'Reference to the SAP S/4HANA clearing document that applied this payment to outstanding invoices. Used for audit trail and reconciliation.',
    `clearing_status` STRING COMMENT 'Current clearing status of the payment indicating whether it has been applied against outstanding invoices. Drives accounts receivable aging and dunning processes.. Valid values are `uncleared|partially_cleared|fully_cleared|reversed`',
    `cost_center_code` STRING COMMENT 'Cost center to which this payment is allocated for internal management accounting. Used for cost allocation and performance measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the payment was made.. Valid values are `^[A-Z]{3}$`',
    `early_payment_discount_amount` DECIMAL(18,2) COMMENT 'Discount amount granted for early payment according to agreed payment terms. Reduces the net amount due.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the payment amount to the base currency. Used for multi-currency accounting and consolidation.',
    `gl_document_reference` STRING COMMENT 'Reference to the general ledger document created for this payment transaction. Used for financial audit and traceability.',
    `gl_posting_date` DATE COMMENT 'The accounting date on which the payment was posted to the general ledger. Determines the financial period for revenue recognition.',
    `instruction_reference` STRING COMMENT 'Reference to the original payment instruction or request that initiated this payment. Used for traceability and audit.',
    `is_disputed` BOOLEAN COMMENT 'Boolean flag indicating whether this payment is under dispute or chargeback. Drives exception handling and customer service workflows.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payment record was last modified. Used for change tracking and audit trail.',
    `narrative` STRING COMMENT 'Free-text description or notes provided by the payer with the payment. Used for manual reconciliation and customer service.',
    `payer_bank_identifier` STRING COMMENT 'Bank identifier code or SWIFT code of the payers bank. Used for international payment tracking and reconciliation.',
    `payment_date` DATE COMMENT 'The date on which the payment was received or processed. Used for cash flow analysis and aging calculations.',
    `payment_method` STRING COMMENT 'The instrument or mechanism used to make the payment. Determines processing rules and settlement timelines. [ENUM-REF-CANDIDATE: bank_transfer|cheque|credit_card|debit_card|direct_debit|cod_collection|letter_of_credit — 7 candidates stripped; promote to reference product]',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Drives workflow and exception handling processes.. Valid values are `pending|completed|failed|reversed|cancelled`',
    `payment_timestamp` TIMESTAMP COMMENT 'The precise date and time when the payment transaction was recorded in the system. Used for audit trail and real-time reconciliation.',
    `processor_reference` STRING COMMENT 'Transaction identifier provided by the payment processor or gateway. Used for dispute resolution and chargeback management.',
    `profit_center_code` STRING COMMENT 'Profit center to which this payment is allocated for profitability analysis. Used for segment P&L reporting.',
    `reconciliation_date` DATE COMMENT 'The date on which the payment was reconciled with bank statements. Used for cash management and audit trail.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether the payment has been successfully reconciled with bank statements and invoice records. Drives exception management workflow.. Valid values are `unreconciled|reconciled|exception|under_review`',
    `reference_number` STRING COMMENT 'External payment reference number provided by the customer or payment processor. Used for reconciliation and customer inquiries.',
    `remittance_advice_reference` STRING COMMENT 'Reference to the remittance advice document provided by the customer detailing which invoices this payment covers. Used for automated payment application.',
    `reversal_date` DATE COMMENT 'The date on which the payment was reversed or cancelled. Used for financial period reconciliation.',
    `reversal_reason` STRING COMMENT 'Business reason for reversing or cancelling the payment. Used for root cause analysis and process improvement.',
    `unapplied_balance` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has not yet been applied to any invoice. Represents customer credit or overpayment requiring manual review.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount withheld by the customer at source as per local tax regulations. Reduces the net payment received.',
    `withholding_tax_certificate_reference` STRING COMMENT 'Reference to the tax withholding certificate provided by the customer. Required for tax compliance and audit.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Record of customer payment received against outstanding invoices. Captures payment reference number, payment date, payment method (bank transfer, cheque, credit card, direct debit, COD collection, letter of credit), payment amount, currency, exchange rate, bank account reference, payment channel (online portal, EDI, manual, bank file), clearing status (uncleared, partially_cleared, fully_cleared), SAP S/4HANA clearing document reference, remittance advice reference, and any unapplied balance. SSOT for all inbound cash receipts in the order-to-cash cycle.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` (
    `payment_allocation_id` BIGINT COMMENT 'Unique identifier for the payment allocation record. Primary key.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for which this payment allocation is recorded. Enables customer-level AR reconciliation.',
    `invoice_id` BIGINT COMMENT 'Reference to the customer invoice being settled by this allocation. Primary open item being cleared.',
    `payment_id` BIGINT COMMENT 'Reference to the customer payment transaction being allocated. Links to the payment header record.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'The monetary amount from the payment that is allocated to this specific open item. Must not exceed the payment amount or the open item balance.',
    `allocation_date` DATE COMMENT 'The business date on which the payment was allocated to the open item. Determines AR aging bucket calculation.',
    `allocation_number` STRING COMMENT 'Business-readable unique identifier for the payment allocation. Used for audit trail and user reference.. Valid values are `^[A-Z0-9]{8,20}$`',
    `allocation_status` STRING COMMENT 'Current lifecycle state of the allocation: provisional (auto-matched, pending review), confirmed (finalized in AR sub-ledger), reversed (allocation cancelled), pending_approval (requires manual review), rejected (allocation failed validation).. Valid values are `provisional|confirmed|reversed|pending_approval|rejected`',
    `allocation_timestamp` TIMESTAMP COMMENT 'Precise date and time when the allocation was created in the system. Used for audit and sequencing.',
    `allocation_type` STRING COMMENT 'Classification of how the payment is being applied: full settlement (complete invoice clearance), partial payment (portion of invoice), advance application (prepayment applied), credit offset (credit note applied), on-account (unallocated payment), write-off (bad debt clearance).. Valid values are `full_settlement|partial_payment|advance_application|credit_offset|on_account|write_off`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the allocation was approved. Nullable for auto-confirmed allocations.',
    `auto_match_confidence_score` DECIMAL(18,2) COMMENT 'Machine learning confidence score (0-100) indicating the likelihood that the automatic payment-to-invoice match is correct. Supports cash application automation and exception handling.',
    `clearing_document_number` STRING COMMENT 'SAP S/4HANA clearing document reference that records the offsetting entries in the AR sub-ledger. Critical for financial reconciliation and audit.. Valid values are `^[A-Z0-9]{10,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was first created in the data platform. Used for data lineage and audit.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allocated amount. Must match the payment and open item currency for direct allocation.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Early payment discount amount granted and deducted during allocation. Nullable when no discount applies.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage rate of early payment discount applied. Nullable when no discount applies.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this allocation is associated with a customer dispute or chargeback. True when the payment is contested or under review.',
    `dispute_reason` STRING COMMENT 'Free-text description of the dispute reason when dispute_flag is true. Captures customer objection details for resolution tracking.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied when payment currency differs from invoice currency. Nullable for same-currency allocations.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when the allocation was posted. Supports monthly AR close and reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the allocation was posted. Used for period-based financial reporting and AR aging analysis.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'Allocated amount converted to the companys local reporting currency. Used for consolidated financial reporting.',
    `matching_method` STRING COMMENT 'The technique used to match the payment to the open item: exact_invoice_match (invoice number provided), amount_match (amount-based matching), customer_match (customer-level matching), remittance_advice (EDI 820 or bank file), manual (user-entered), ai_predicted (ML model).. Valid values are `exact_invoice_match|amount_match|customer_match|remittance_advice|manual|ai_predicted`',
    `notes` STRING COMMENT 'Free-text comments or special instructions related to this allocation. Used for exception handling and communication between AR team members.',
    `open_balance_after` DECIMAL(18,2) COMMENT 'The remaining outstanding balance of the open item after this allocation. Zero indicates full settlement. Drives aging bucket recalculation.',
    `open_balance_before` DECIMAL(18,2) COMMENT 'The outstanding balance of the open item immediately before this allocation was applied. Used for reconciliation and audit.',
    `posting_date` DATE COMMENT 'The date on which the allocation was posted to the general ledger. May differ from allocation_date due to period-end processing.',
    `reversal_date` DATE COMMENT 'The date on which the allocation was reversed. Nullable when reversal_flag is false.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this allocation has been reversed. True when the allocation was cancelled and the open item balance restored.',
    `reversal_reason` STRING COMMENT 'Explanation of why the allocation was reversed. Nullable when reversal_flag is false. Used for audit and process improvement.',
    `source_system` STRING COMMENT 'The originating system that created this allocation record. Supports multi-system integration and data lineage tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this allocation record was last modified in the data platform. Supports change tracking and audit.',
    `value_date` DATE COMMENT 'The effective date for interest calculation and cash flow purposes. Typically the bank value date from the payment transaction.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Amount written off as uncollectible during this allocation. Typically small residual balances or bad debt. Nullable when not applicable.',
    `write_off_reason_code` STRING COMMENT 'Classification of why the write-off was applied: bad_debt (uncollectible), small_balance (immaterial residual), customer_dispute (settlement concession), bankruptcy (insolvency), goodwill (customer retention), other.. Valid values are `bad_debt|small_balance|customer_dispute|bankruptcy|goodwill|other`',
    CONSTRAINT pk_payment_allocation PRIMARY KEY(`payment_allocation_id`)
) COMMENT 'Cash application record linking a customer payment to one or more open items (invoices, credit notes, debit notes) with the allocated amount per item. Captures allocation amount, allocation date, allocation type (full settlement, partial payment, advance application, credit offset, on-account, write-off), remaining open balance after allocation, allocation status (provisional, confirmed, reversed), auto-match confidence score, and SAP S/4HANA clearing document reference. Enables accurate AR sub-ledger reconciliation, supports multi-invoice remittances common in enterprise freight forwarding, and drives aging bucket calculations. Critical for cash application automation and bank file processing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`receivable` (
    `receivable_id` BIGINT COMMENT 'Unique identifier for the accounts receivable balance record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: AR teams track receivables by customer agreement for credit limit enforcement, payment term application, contract-level aging analysis, and volume commitment reconciliation. Essential for contract-bas',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Receivable tracks AR balance by customer account. Should reference billing.account for in-domain linking to billing account master. Currently only has customer_account_id to customer domain. The billi',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Collections and dunning workflow: logistics AR teams direct dunning letters and collection calls to a designated customer contact. Linking receivable to contact enables automated dunning targeting the',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to customer.credit_profile. Business justification: AR credit management: logistics AR teams link receivables to credit profiles to drive dunning levels, collection actions, and write-off decisions based on credit risk rating and limit utilization. cre',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Agent-originated business creates receivables that must track agent for commission offset calculations, credit risk assessment by origination channel, and agent performance impact on collections. Esse',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: receivable.payment_terms is a denormalized STRING field capturing the payment terms applicable to the AR balance (e.g., Net 30). Replacing it with a FK to billing.payment_term normalizes this to the',
    `aging_bucket` STRING COMMENT 'Classification of the receivable based on days outstanding: current (0 days), 1-30 days, 31-60 days, 61-90 days, or over 90 days past due.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `ar_balance_amount` DECIMAL(18,2) COMMENT 'Total outstanding amount owed by the customer at the snapshot date.',
    `bad_debt_provision_amount` DECIMAL(18,2) COMMENT 'Amount reserved as provision for potential bad debt based on credit risk assessment and aging analysis.',
    `business_area` STRING COMMENT 'Business area or division to which this receivable is attributed for internal reporting and profitability analysis.',
    `collection_agency_name` STRING COMMENT 'Name of the external collection agency handling the receivable, if referred.',
    `collection_agency_referral_flag` BOOLEAN COMMENT 'Indicates whether the receivable has been referred to an external collection agency (True) or not (False).',
    `collection_referral_date` DATE COMMENT 'Date when the receivable was referred to the external collection agency.',
    `company_code` STRING COMMENT 'Company code representing the legal entity that owns this receivable in the SAP S/4HANA Finance system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this receivable balance record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the receivable balance.. Valid values are `^[A-Z]{3}$`',
    `current_amount` DECIMAL(18,2) COMMENT 'Portion of the AR balance that is not yet past due (0 days outstanding).',
    `days_1_30_amount` DECIMAL(18,2) COMMENT 'Portion of the AR balance that is 1 to 30 days past due.',
    `days_31_60_amount` DECIMAL(18,2) COMMENT 'Portion of the AR balance that is 31 to 60 days past due.',
    `days_61_90_amount` DECIMAL(18,2) COMMENT 'Portion of the AR balance that is 61 to 90 days past due.',
    `days_over_90_amount` DECIMAL(18,2) COMMENT 'Portion of the AR balance that is more than 90 days past due.',
    `days_sales_outstanding` STRING COMMENT 'Average number of days it takes to collect payment from the customer, calculated as (AR balance / average daily sales).',
    `dispute_hold_flag` BOOLEAN COMMENT 'Indicates whether the receivable is on hold due to a customer dispute (True) or not (False).',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Total amount currently under dispute by the customer.',
    `dunning_date` DATE COMMENT 'Date when the most recent dunning notice was sent to the customer.',
    `dunning_level` STRING COMMENT 'Current stage of the collection process: none, first notice, second notice, final notice, collections, or legal action.. Valid values are `none|first_notice|second_notice|final_notice|collections|legal_action`',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this receivable balance is posted in the financial system.',
    `last_invoice_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent invoice issued to the customer.',
    `last_invoice_date` DATE COMMENT 'Date of the most recent invoice issued to the customer.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment received from the customer.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received from the customer.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the receivable balance, collection efforts, or customer communication.',
    `reconciliation_status` STRING COMMENT 'Status of the receivable balance reconciliation between operational systems and the general ledger: reconciled, pending, or discrepancy identified.. Valid values are `reconciled|pending|discrepancy`',
    `sap_customer_account_number` STRING COMMENT 'Customer account number in the SAP S/4HANA Finance system for reconciliation and integration.',
    `snapshot_date` DATE COMMENT 'Date on which this receivable balance snapshot was captured for reporting and analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this receivable balance record was last updated in the system.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Total amount written off as uncollectible bad debt.',
    `write_off_date` DATE COMMENT 'Date when the receivable was written off as uncollectible.',
    `write_off_status` STRING COMMENT 'Indicates whether the receivable is active, partially written off, or fully written off as uncollectible.. Valid values are `active|partial_write_off|full_write_off`',
    CONSTRAINT pk_receivable PRIMARY KEY(`receivable_id`)
) COMMENT 'Accounts receivable balance record tracking the outstanding amount owed by each customer at any point in time. Captures AR balance, aging bucket (current, 1-30 days, 31-60 days, 61-90 days, 90+ days), credit limit, credit utilization percentage, last payment date, last invoice date, dunning level (1st notice, 2nd notice, final notice, collections), dunning date, dispute hold flag, bad debt provision amount, write-off status, collection agency referral flag, and SAP S/4HANA customer account reference. Supports credit risk management and DSO (Days Sales Outstanding) tracking.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`freight_audit` (
    `freight_audit_id` BIGINT COMMENT 'Unique identifier for the freight audit record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Identifier of the carrier contract or rate agreement used as the baseline for this audit.',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier who issued the invoice being audited.',
    `carrier_lane_allocation_id` BIGINT COMMENT 'Foreign key linking to route.carrier_lane_allocation. Business justification: Audits verify charges against allocated carrier-lane contracts (volume commitments, contracted rates). Essential for contract compliance verification, allocation utilization tracking, and minimum volu',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Audit process validates invoiced service codes against contracted carrier service definitions. Critical for verifying rate correctness, transit time compliance, and resolving service-level disputes be',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Freight audit validates carrier invoices against actual shipment execution data. Auditors compare contracted rates, weights, and service levels from the consignment to detect billing errors and captur',
    `contract_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.contract_rate. Business justification: Freight audits compare carrier invoices to negotiated contract rates to capture savings and validate pricing accuracy. Essential audit workflow: match shipment charges to specific contracted rate agre',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Freight audits verify customs-declared values, duties, and taxes; direct link supports audit trail, variance analysis, and validation of customs charges against carrier invoices.',
    `lane_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.lane_commitment. Business justification: Freight audit validates carrier invoices against lane-specific contracted rates and capacity commitments. Direct link enables automated audit to verify lane pricing, capacity utilization vs. commitmen',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Freight auditors validate carrier invoices against contracted lane rates. Auditors need lane_id to retrieve contracted pricing, transit times, and service levels for variance analysis. Standard pre-pa',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Freight audits for agent-originated shipments require agent reference to validate commission basis, resolve rate disputes involving agent quotes, and track audit findings by origination channel. Criti',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Freight audit validates carrier charges against PO terms for procured services. Essential for rate verification, variance analysis, and identifying overbilling on contracted transportation purchases.',
    `rate_card_id` BIGINT COMMENT 'Foreign key linking to pricing.rate_card. Business justification: Freight audits validate carrier invoices against contracted rate cards to identify overcharges and ensure billing compliance. Core audit workflow in logistics operations requires comparing invoiced am',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.rate_schedule. Business justification: Core audit process compares carrier-invoiced rates against contracted rate schedules to identify overcharges, incorrect surcharges, and rate discrepancies. Essential for freight cost control and carri',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Audits verify carrier invoices against contracted corridor rates and service levels. Required for corridor-level audit variance analysis, contract compliance verification, and corridor cost benchmarki',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: Freight audit at leg level: carrier invoices are audited against specific transport legs (distance, weight, mode). Freight audit teams require leg-level linkage to compare contracted vs invoiced amoun',
    `sla_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.contract_sla_commitment. Business justification: Freight audits validate carrier invoices against contracted SLA commitments (transit time, on-time delivery targets). Direct link enables automated SLA breach detection and penalty calculation in audi',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Links audit findings to supplier master for performance tracking, dispute history, and vendor scorecard updates. Critical for identifying chronic billing issues and supporting supplier review meetings',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: Audits verify carrier invoices comply with published tariff rates, especially for regulated services. Business process: regulatory compliance validation and tariff adherence checking against governing',
    `tariff_rate_id` BIGINT COMMENT 'Identifier of the specific tariff rate record from the pricing domain used to validate the contracted rate in this audit.',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: 3PL invoices require audit against contracted rates for warehousing, handling, and distribution services. Linking to provider enables rate validation, dispute resolution, and savings capture on 3PL sp',
    `transit_time_standard_id` BIGINT COMMENT 'Foreign key linking to route.transit_time_standard. Business justification: Audits validate transit time charges against published standards. Essential for SLA breach detection, late delivery penalty validation, and billing dispute resolution for time-definite services.',
    `accessorial_charges_amount` DECIMAL(18,2) COMMENT 'Total amount of accessorial charges (additional services beyond base freight) included in the carrier invoice, such as liftgate, inside delivery, residential delivery, detention, demurrage, or special handling.',
    `audit_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit was completed and a final determination was made (approved, disputed, or adjusted).',
    `audit_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this freight audit case for tracking and communication purposes.. Valid values are `^FA[0-9]{10}$`',
    `audit_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit process was initiated for this carrier invoice.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the freight audit: pending_review (queued for auditor assignment), in_audit (actively being reviewed), approved (invoice validated and approved for payment), disputed (discrepancy identified and under negotiation), adjusted (carrier agreed to correction), escalated (sent to senior management or legal), closed (audit completed and resolved). [ENUM-REF-CANDIDATE: pending_review|in_audit|approved|disputed|adjusted|escalated|closed — 7 candidates stripped; promote to reference product]',
    `awb_number` STRING COMMENT 'Air Waybill number if the audited shipment was air freight. Format: 3-digit airline prefix followed by 8-digit serial number.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `bol_number` STRING COMMENT 'Bill of Lading number if the audited shipment was ocean or ground freight.',
    `carrier_invoice_number` STRING COMMENT 'The invoice number issued by the carrier for the freight charges being audited. This is the primary document under review.',
    `carrier_invoiced_amount` DECIMAL(18,2) COMMENT 'The total amount the carrier invoiced for this shipment, subject to audit verification.',
    `container_number` STRING COMMENT 'ISO 6346 container number if the audited shipment involved containerized freight.. Valid values are `^[A-Z]{4}[0-9]{7}$`',
    `contracted_rate_amount` DECIMAL(18,2) COMMENT 'The rate amount agreed upon in the contract or tariff for this shipment, used as the baseline for audit comparison.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight audit record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this audit record.. Valid values are `^[A-Z]{3}$`',
    `delivery_date` DATE COMMENT 'The date the shipment was delivered, used to validate SLA compliance and service failure deductions.',
    `destination_location_code` STRING COMMENT 'IATA or UN/LOCODE three-letter code for the shipment destination location, used to validate rate applicability by lane.. Valid values are `^[A-Z]{3}$`',
    `dim_weight_contracted_kg` DECIMAL(18,2) COMMENT 'The dimensional weight (volumetric weight) calculated per contract terms, used when DIM weight exceeds actual weight for rate determination.',
    `dim_weight_invoiced_kg` DECIMAL(18,2) COMMENT 'The dimensional weight the carrier used for invoicing, which may differ due to measurement discrepancies or calculation method differences.',
    `dispute_notes` STRING COMMENT 'Free-text notes documenting the nature of the dispute, findings, carrier responses, and resolution discussions. Used for audit trail and knowledge management.',
    `finding_type` STRING COMMENT 'Classification of the audit finding: rate_overcharge (carrier charged higher rate than contracted), duplicate_billing (same shipment invoiced multiple times), accessorial_not_contracted (charges for services not in contract), weight_discrepancy (invoiced weight differs from actual), dim_discrepancy (dimensional weight calculation error), service_failure_deduction (SLA breach requiring credit), fuel_surcharge_miscalculation (BAF/fuel surcharge incorrectly applied), no_finding (invoice validated as correct). [ENUM-REF-CANDIDATE: rate_overcharge|duplicate_billing|accessorial_not_contracted|weight_discrepancy|dim_discrepancy|service_failure_deduction|fuel_surcharge_miscalculation|no_finding — 8 candidates stripped; promote to reference product]',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Fuel surcharge (BAF - Bunker Adjustment Factor for ocean, FSC - Fuel Surcharge for air/road) amount included in the carrier invoice.',
    `invoice_date` DATE COMMENT 'The date the carrier issued the invoice being audited.',
    `invoice_due_date` DATE COMMENT 'The payment due date specified on the carrier invoice. Audit completion must occur before this date to prevent late payment penalties.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this freight audit record was last modified.',
    `origin_location_code` STRING COMMENT 'IATA or UN/LOCODE three-letter code for the shipment origin location, used to validate rate applicability by lane.. Valid values are `^[A-Z]{3}$`',
    `resolution_action` STRING COMMENT 'The action taken or recommended to resolve the audit: approve_as_is (invoice is correct, approve for payment), request_credit_note (ask carrier to issue credit for overcharge), request_revised_invoice (ask carrier to reissue corrected invoice), escalate_to_carrier (send to carrier management for negotiation), escalate_internal (send to internal legal or finance), write_off (variance too small to pursue), pending_carrier_response (awaiting carrier reply). [ENUM-REF-CANDIDATE: approve_as_is|request_credit_note|request_revised_invoice|escalate_to_carrier|escalate_internal|write_off|pending_carrier_response — 7 candidates stripped; promote to reference product]',
    `savings_captured_amount` DECIMAL(18,2) COMMENT 'The total amount of cost savings or recovery achieved through this audit, representing overcharges identified and successfully recovered or credited. Typically 2-8% of freight spend for large shippers.',
    `service_type` STRING COMMENT 'Type of freight service being audited: air freight, ocean freight, road freight, rail freight, express parcel, LTL (Less Than Truckload), FTL (Full Truckload), FCL (Full Container Load), LCL (Less Than Container Load), or multimodal. [ENUM-REF-CANDIDATE: air_freight|ocean_freight|road_freight|rail_freight|express_parcel|ltl|ftl|fcl|lcl|multimodal — 10 candidates stripped; promote to reference product]',
    `shipment_date` DATE COMMENT 'The date the shipment was picked up or departed, used to validate rate applicability and service level compliance.',
    `shipment_reference_number` STRING COMMENT 'Reference to the shipment associated with this audit. May be an internal shipment ID, AWB (Air Waybill), BOL (Bill of Lading), or container number depending on service type.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the shipment associated with this audit experienced an SLA breach (late delivery, service failure) that may warrant a service failure deduction.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The absolute difference between the contracted rate and the carrier-invoiced amount. Positive values indicate overcharges; negative values indicate undercharges.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the contracted rate, calculated as (variance_amount / contracted_rate_amount) * 100.',
    `volume_contracted_cbm` DECIMAL(18,2) COMMENT 'The shipment volume (in cubic meters) used in the contracted rate calculation.',
    `volume_invoiced_cbm` DECIMAL(18,2) COMMENT 'The shipment volume (in cubic meters) the carrier used for invoicing.',
    `weight_contracted_kg` DECIMAL(18,2) COMMENT 'The shipment weight (in kilograms) used in the contracted rate calculation, typically from the original booking or manifest.',
    `weight_invoiced_kg` DECIMAL(18,2) COMMENT 'The shipment weight (in kilograms) the carrier used for invoicing, which may differ from the contracted weight due to reweighing or discrepancies.',
    `weight_variance_kg` DECIMAL(18,2) COMMENT 'The difference between invoiced weight and contracted weight in kilograms. Positive values indicate the carrier invoiced for more weight than contracted.',
    CONSTRAINT pk_freight_audit PRIMARY KEY(`freight_audit_id`)
) COMMENT 'Freight audit record capturing the systematic verification of carrier invoices against contracted rates, actual shipment parameters, and service level agreements before payment authorization. Covers inbound carrier payables (Freight Audit and Payment — FAP) validation. Each audit record captures: audit reference, carrier invoice number, shipment/AWB/BOL/container reference, contracted tariff rate, carrier-invoiced rate, variance amount and percentage, weight/volume discrepancy details, audit status (pending_review, in_audit, approved, disputed, adjusted, escalated, closed), finding type (rate overcharge, duplicate billing, accessorial not contracted, weight/dim discrepancy, service failure deduction, fuel surcharge miscalculation), auditor identity, audit completion date, resolution action, and savings captured amount. Integrates with carrier_payable for payment release and with pricing domain for rate validation. Typically recovers 2-8% of freight spend for large shippers.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` (
    `carrier_payable_id` BIGINT COMMENT 'Unique identifier for the carrier payable record. Primary key for the carrier payable entity.',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: Carrier payables must be validated against carrier agreement terms (rates, surcharges, payment terms) during AP processing and freight audit. Direct link enables automated 3-way match (PO/agreement/in',
    `carrier_buy_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.carrier_buy_rate. Business justification: Carrier payables are validated and settled based on negotiated buy rates. Business process: AP teams verify carrier invoices against agreed buy rate schedules before authorizing payment to ensure cost',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier, subcontractor, or transport partner to whom payment is owed.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Payables must reconcile to specific carrier service agreements for accrual accuracy and cost allocation by service type. Enables spend analysis by service tier and variance tracking against contracted',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Carrier invoices for customs-related services (clearance, bonds, duties advanced) need declaration reference for cost allocation, reconciliation, and customs charge validation.',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Payables to carriers for lane-specific services. Essential for lane cost tracking, carrier payment reconciliation, lane profitability analysis (revenue vs. cost), and carrier performance settlement.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Agent-facilitated carrier bookings may generate payables where agent acts as booking intermediary, requiring agent reference for settlement routing, commission offset, and agent-carrier relationship t',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Carrier_payable currently has payment_terms as STRING. This should be normalized to reference billing.payment_term master table. The payment_term_id FK allows joining to get code, name, net_days, etc.',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: Payables for corridor operations (hub-to-hub carrier services). Required for corridor cost analysis, carrier settlement by corridor, and corridor margin calculation (corridor revenue vs. corridor carr',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: AP cost allocation: carrier payables are generated per transport leg executed. AP teams match payables to specific legs for cost-per-leg reporting, carrier performance scoring, and GL posting by trans',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Carriers are suppliers in logistics. Links payable to supplier master for vendor management, payment terms, tax registration, and AP processing. Essential for three-way matching and supplier performan',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: Carrier invoices reference published tariff rates for standard services. Business process: payable validation against carriers published tariff structure to ensure charges align with regulatory-appro',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: 3PL provider invoices are processed as payables. Linking enables accrual accuracy, spend analysis by provider, and cost variance tracking against contracted 3PL rates for warehousing and distribution ',
    `approval_date` DATE COMMENT 'Date on which the carrier payable was approved for payment.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the carrier payable for payment. Used for audit trail and accountability.',
    `awb_number` STRING COMMENT 'Master Air Waybill number for air freight shipments. Null for non-air service types.',
    `bol_number` STRING COMMENT 'Bill of Lading number for ocean, road, or rail freight shipments. Null for non-applicable service types.',
    `carrier_invoice_number` STRING COMMENT 'Invoice number provided by the carrier for the services rendered. Used for matching and reconciliation with carrier billing documents.',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'The greater of actual weight or dimensional weight, used as the basis for freight charges. Critical for rate verification and freight audit.',
    `cost_center_code` STRING COMMENT 'Cost center code for internal cost allocation and management reporting. Identifies the business unit or department responsible for this expense.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier payable record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payable amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'Code representing the destination location of the shipment for which carrier services were provided. May be an airport code, port code, or facility identifier.',
    `dim_weight_kg` DECIMAL(18,2) COMMENT 'Dimensional weight of the shipment in kilograms, calculated based on volume. Used for freight rating when dimensional weight exceeds actual weight.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount applied to the payable amount, such as early payment discounts or volume-based rebates.',
    `dispute_date` DATE COMMENT 'Date on which the payable was flagged as disputed. Null if no dispute exists.',
    `dispute_reason` STRING COMMENT 'Reason for disputing the carrier invoice, such as incorrect charges, service quality issues, or billing discrepancies. Null if no dispute exists.',
    `dispute_resolution_date` DATE COMMENT 'Date on which the dispute was resolved and the payable was cleared for payment. Null if dispute is unresolved or no dispute exists.',
    `due_date` DATE COMMENT 'Date by which the payment to the carrier is due, calculated based on invoice date and payment terms.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this carrier payable expense is posted in the financial system.',
    `invoice_date` DATE COMMENT 'Date on which the carrier issued the invoice for services rendered.',
    `net_payable_amount` DECIMAL(18,2) COMMENT 'Net amount payable to the carrier after applying taxes, discounts, and any other adjustments. This is the final amount to be paid.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the carrier payable, such as special instructions, audit findings, or payment exceptions.',
    `origin_location_code` STRING COMMENT 'Code representing the origin location of the shipment for which carrier services were provided. May be an airport code, port code, or facility identifier.',
    `payable_amount` DECIMAL(18,2) COMMENT 'Total amount owed to the carrier for services rendered, in the specified currency. Represents the gross payable before any adjustments or deductions.',
    `payable_reference_number` STRING COMMENT 'Externally-known unique reference number for this carrier payable transaction, used for reconciliation and audit purposes.',
    `payment_date` DATE COMMENT 'Actual date on which payment was made to the carrier. Null if payment has not yet been completed.',
    `payment_method` STRING COMMENT 'Method used to remit payment to the carrier, such as wire transfer, ACH, check, or electronic funds transfer.. Valid values are `wire_transfer|ach|check|credit_card|electronic_funds_transfer`',
    `payment_reference_number` STRING COMMENT 'Reference number or transaction ID for the payment made to the carrier, used for reconciliation and tracking.',
    `payment_status` STRING COMMENT 'Current status of the carrier payable in the payment lifecycle. Tracks progression from audit through final payment or dispute resolution.. Valid values are `pending_audit|approved|scheduled|paid|disputed|on_hold`',
    `sap_vendor_document_number` STRING COMMENT 'SAP S/4HANA vendor payment document reference number. Links this payable to the financial system payment record.',
    `service_end_date` DATE COMMENT 'Date on which the carrier service period ended. Used for accrual accounting and service period tracking.',
    `service_start_date` DATE COMMENT 'Date on which the carrier service period began. Used for accrual accounting and service period tracking.',
    `service_type` STRING COMMENT 'Type of transportation or logistics service provided by the carrier for which payment is owed.. Valid values are `air_freight|ocean_freight|road_haulage|rail_freight|last_mile_delivery|port_handling`',
    `shipment_reference` STRING COMMENT 'Reference to the shipment document associated with this payable. May be a Master Air Waybill (MAWB), Master Bill of Lading (MBL), or Bill of Lading (BOL) number.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount included in or added to the payable amount, such as VAT, GST, or other applicable taxes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier payable record was last modified. Used for audit trail and change tracking.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the shipment in cubic meters. Used for rate verification, especially for ocean and air freight.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment in kilograms for which the carrier provided services. Used for rate verification and freight audit.',
    CONSTRAINT pk_carrier_payable PRIMARY KEY(`carrier_payable_id`)
) COMMENT 'Accounts payable record for amounts owed to carriers, subcontractors, and transport partners for services rendered on behalf of Transport Shipping customers. Captures carrier payable reference, carrier identity, carrier invoice number, service type (air freight, ocean freight, road haulage, rail, last-mile delivery, port handling), shipment reference (MAWB, MBL, BOL), payable amount, currency, payment terms, due date, payment status (pending_audit, approved, scheduled, paid, disputed, on_hold), Coupa purchase order reference, and SAP S/4HANA vendor payment document reference. SSOT for procure-to-pay carrier cost management.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`dispute` (
    `dispute_id` BIGINT COMMENT 'Unique identifier for the billing dispute record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Disputes frequently cite contractual terms, payment conditions, liability clauses, or service scope definitions from master agreements. Required for dispute resolution teams to validate claims against',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier involved in the disputed shipment. Used when the dispute involves carrier performance or carrier invoice discrepancies.',
    `carrier_payable_id` BIGINT COMMENT 'Foreign key linking to billing.carrier_payable. Business justification: A billing dispute can be raised against a specific carrier payable record (e.g., when a carrier invoice is disputed during freight audit). billing_dispute already has carrier_id and supplier_id but la',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Disputes often challenge service level delivered vs. invoiced (e.g., charged for express but delivered standard). Linking to carrier_service enables root cause analysis, SLA breach validation, and res',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Billing disputes frequently stem from shipment service failures (late delivery, damage, incorrect service level). Dispute investigators require direct access to consignment execution details, tracking',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that raised the dispute. Identifies the party challenging the invoice accuracy.',
    `invoice_id` BIGINT COMMENT 'Reference to the customer invoice being disputed. Links to the invoice that contains the disputed charges.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Disputes over customs charges, duties, and clearance fees require declaration reference for investigation, resolution, and documentation of customs-related billing issues.',
    `duty_assessment_id` BIGINT COMMENT 'Foreign key linking to customs.duty_assessment. Business justification: Duty disputes require assessment reference for investigation, adjustment calculation, and resolution of customs duty billing discrepancies and overcharges.',
    `exception_event_id` BIGINT COMMENT 'Foreign key linking to shipment.exception_event. Business justification: Dispute root-cause process: billing disputes arising from operational failures (damage, delay, loss) must reference the originating exception event. Claims and dispute resolution teams trace financial',
    `freight_audit_id` BIGINT COMMENT 'Foreign key linking to billing.freight_audit. Business justification: A billing dispute is frequently generated as a direct result of a freight audit finding (e.g., weight variance, rate discrepancy, SLA breach). Linking billing_dispute to the originating freight_audit ',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Disputes often involve lane-specific charges (incorrect lane rate applied, wrong lane classification). Essential for dispute resolution, lane pricing validation, and root cause analysis of billing err',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Disputes on agent-originated shipments require agent reference for investigation coordination, corrective action assignment, agent performance impact tracking, and commission adjustment processing. Es',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Customer billing disputes frequently trace to procurement commitments (contracted rates, service levels, delivery terms) documented in the originating purchase order; essential for root-cause analysis',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Dispute management workflow: logistics billing disputes are raised by a specific customer contact (e.g., AP manager). Linking enables SLA tracking, communication routing, and CSAT measurement per cont',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.rate_schedule. Business justification: Rate disputes require direct access to applicable rate schedules to validate disputed charges against contracted rates, surcharges, and volume breaks. Common in freight audit and customer dispute reso',
    `route_delivery_zone_id` BIGINT COMMENT 'Foreign key linking to route.route_delivery_zone. Business justification: Disputes over zone classification (residential vs. commercial, remote area designation), surcharge applicability. Essential for zone dispute resolution, surcharge validation, and correcting zone miscl',
    `shipment_leg_id` BIGINT COMMENT 'Foreign key linking to shipment.shipment_leg. Business justification: Leg-level dispute resolution: billing disputes frequently arise from specific leg charges (incorrect weight, wrong distance, wrong carrier on a segment). Dispute resolution teams need leg-level linkag',
    `sla_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.contract_sla_commitment. Business justification: Many billing disputes arise from SLA breaches (late delivery, damaged cargo, missed cutoffs). Direct link enables dispute teams to reference specific SLA thresholds, measurement methods, and penalty c',
    `sla_entitlement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_entitlement. Business justification: SLA breach dispute resolution: logistics billing disputes frequently arise from SLA breaches (billing_dispute has sla_breach_flag). Linking to sla_entitlement enables dispute teams to validate penalty',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Billing disputes often involve carrier (supplier) errors—incorrect rates, unauthorized charges, service failures. Links dispute to supplier for vendor performance tracking, escalation workflow, and ro',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: Disputes involving 3PL services (warehousing errors, value-added service failures, 3PL billing discrepancies) require tpl_provider reference for root cause analysis, provider performance tracking, and',
    `transit_time_standard_id` BIGINT COMMENT 'Foreign key linking to route.transit_time_standard. Business justification: Disputes over SLA failures, late delivery penalties, guaranteed service credits. Essential for SLA dispute adjudication, service credit calculation, and validating whether transit standard was met or ',
    `approval_date` DATE COMMENT 'Date when the dispute resolution was formally approved by the authorized approver.',
    `approved_by` STRING COMMENT 'Name or identifier of the manager or authority who approved the dispute resolution and credit issuance. Required for financial control and SOX compliance.',
    `assigned_to_team` STRING COMMENT 'The team or department responsible for investigating and resolving the dispute (e.g., Billing Operations, Freight Audit, Customer Service, Revenue Assurance).',
    `assigned_to_user` STRING COMMENT 'The individual user or agent currently assigned to handle the dispute. May be employee ID or username from Workday HCM.',
    `awb_number` STRING COMMENT 'Air Waybill number if the dispute relates to air freight charges. Format: XXX-XXXXXXXX (3-digit airline prefix and 8-digit serial number).. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `bol_number` STRING COMMENT 'Bill of Lading number if the dispute relates to ocean or ground freight charges.',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'The chargeable weight (greater of actual weight or dimensional weight) used for billing the disputed shipment. Relevant for weight_dispute type.',
    `corrective_action_taken` STRING COMMENT 'Description of corrective actions implemented to prevent recurrence of similar disputes (e.g., rate table updated, training provided, process revised).',
    `cost_center_code` STRING COMMENT 'Cost center code in SAP S/4HANA Finance responsible for absorbing the dispute resolution cost. Used for internal chargeback and P&L reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was first created in the system. Audit trail for record creation.',
    `credit_note_reference` STRING COMMENT 'Reference number of the credit note issued to the customer as a result of the dispute resolution. Links to the credit note document in SAP S/4HANA Finance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the disputed amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `customer_satisfaction_rating` STRING COMMENT 'Customer-provided satisfaction rating for the dispute resolution process, typically on a scale of 1-5 or 1-10. Captured via post-resolution survey.',
    `destination_location_code` STRING COMMENT 'Three-letter IATA or UN/LOCODE for the shipment destination location associated with the disputed charges.. Valid values are `^[A-Z]{3}$`',
    `dispute_category` STRING COMMENT 'High-level categorization of the dispute for reporting and root cause analysis. Values: pricing (rate or charge calculation issues), operations (service delivery failures), documentation (missing or incorrect paperwork), compliance (customs or regulatory issues), service_quality (performance below SLA), billing_error (invoice processing mistakes).. Valid values are `pricing|operations|documentation|compliance|service_quality|billing_error`',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the dispute. Values: open (newly raised, awaiting review), under_review (being investigated by billing or operations team), escalated (requires senior management or legal review), resolved_accepted (dispute validated, customer claim accepted), resolved_rejected (dispute investigated and rejected), partially_accepted (partial credit issued). [ENUM-REF-CANDIDATE: open|under_review|escalated|resolved_accepted|resolved_rejected|partially_accepted|withdrawn|pending_customer_response|pending_carrier_response — promote to reference product]. Valid values are `open|under_review|escalated|resolved_accepted|resolved_rejected|partially_accepted`',
    `dispute_type` STRING COMMENT 'Classification of the dispute by root cause. Values: rate_dispute (incorrect rate applied), weight_dispute (chargeable weight calculation error), service_failure (service not delivered as promised), duplicate_charge (same charge billed multiple times), unauthorized_surcharge (surcharge applied without authorization), sla_breach_deduction (customer claims SLA breach and requests deduction). [ENUM-REF-CANDIDATE: rate_dispute|weight_dispute|service_failure|duplicate_charge|unauthorized_surcharge|sla_breach_deduction|customs_duty_dispute|dimensional_weight_dispute|fuel_surcharge_dispute|accessorial_charge_dispute — promote to reference product]. Valid values are `rate_dispute|weight_dispute|service_failure|duplicate_charge|unauthorized_surcharge|sla_breach_deduction`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The monetary amount being disputed by the customer. Represents the portion of the invoice that the customer challenges as incorrect.',
    `disputed_weight_kg` DECIMAL(18,2) COMMENT 'The weight value that the customer claims is correct, if the dispute is related to weight calculation discrepancies.',
    `escalation_level` STRING COMMENT 'Numeric indicator of how many times the dispute has been escalated. 0 = no escalation, 1 = first escalation (supervisor), 2 = second escalation (manager), 3+ = senior management or legal.',
    `escalation_reason` STRING COMMENT 'Reason why the dispute was escalated beyond the initial assigned team (e.g., high value, customer VIP status, complex legal issue, repeated dispute).',
    `gl_account_code` STRING COMMENT 'General Ledger account code in SAP S/4HANA Finance to which the dispute resolution amount is posted (e.g., revenue adjustment account, bad debt account).',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the dispute. Used for supplementary information not captured in structured fields.',
    `origin_location_code` STRING COMMENT 'Three-letter IATA or UN/LOCODE for the shipment origin location associated with the disputed charges.. Valid values are `^[A-Z]{3}$`',
    `priority_level` STRING COMMENT 'Priority classification for dispute resolution based on customer tier, disputed amount, or business impact. Values: low, medium, high, critical.. Valid values are `low|medium|high|critical`',
    `raised_channel` STRING COMMENT 'The channel through which the dispute was submitted. Values: email, phone, web_portal (customer self-service portal), edi (Electronic Data Interchange), salesforce_case (CRM service case), manual_entry (internal team entry).. Valid values are `email|phone|web_portal|edi|salesforce_case|manual_entry`',
    `raised_date` DATE COMMENT 'The date the dispute was formally raised by the customer or internal team. Represents the business event timestamp for dispute initiation.',
    `reason_narrative` STRING COMMENT 'Free-text narrative provided by the customer or internal team explaining the reason for the dispute. Captures detailed justification and supporting context.',
    `reference_number` STRING COMMENT 'Externally-visible unique reference number assigned to the dispute for tracking and communication purposes. Format: DSP-XXXXXXXXXX.. Valid values are `^DSP-[0-9]{10}$`',
    `resolution_amount` DECIMAL(18,2) COMMENT 'The monetary amount credited or adjusted as a result of the dispute resolution. May be equal to, less than, or zero relative to disputed_amount.',
    `resolution_date` DATE COMMENT 'The date the dispute was formally resolved and closed. Represents the business event timestamp for dispute closure.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the investigation findings, resolution rationale, and actions taken. Provides audit trail for dispute outcome.',
    `resolution_type` STRING COMMENT 'The type of resolution action taken. Values: full_credit (entire disputed amount credited), partial_credit (portion of disputed amount credited), no_credit (dispute rejected, no adjustment), rate_adjustment (rate corrected and invoice adjusted), rebill (invoice cancelled and reissued), waiver (charge waived as goodwill gesture).. Valid values are `full_credit|partial_credit|no_credit|rate_adjustment|rebill|waiver`',
    `root_cause_code` STRING COMMENT 'Standardized code identifying the underlying root cause of the dispute (e.g., system error, manual entry mistake, rate table outdated, service failure). Used for trend analysis and process improvement.',
    `service_failure_type` STRING COMMENT 'Specific type of service failure if dispute_type is service_failure (e.g., late_delivery, damaged_goods, lost_shipment, incorrect_routing, missed_pickup). Used for operational performance analysis.',
    `shipment_reference` STRING COMMENT 'Reference to the shipment associated with the disputed charges. May reference AWB, BOL, or internal shipment tracking number.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator whether the dispute resolution exceeded the SLA target resolution date. True if breached, False otherwise.',
    `sla_target_resolution_date` DATE COMMENT 'The target date by which the dispute must be resolved per the customer SLA or internal policy. Calculated from dispute_raised_date plus SLA resolution window.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispute record was last modified. Audit trail for record updates.',
    CONSTRAINT pk_dispute PRIMARY KEY(`dispute_id`)
) COMMENT 'Formal dispute record raised by customers or internal teams challenging the accuracy of an invoice, charge, or freight audit finding. Captures dispute reference number, dispute type (rate dispute, weight dispute, service failure, duplicate charge, unauthorized surcharge, SLA breach deduction, customs duty dispute), disputed invoice reference, disputed amount, dispute reason narrative, dispute status (open, under_review, escalated, resolved_accepted, resolved_rejected, partially_accepted, withdrawn), resolution type, resolution amount, resolution date, responsible team, SLA breach flag, and credit note issued reference. Supports chargeback management and customer satisfaction.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`billing_account` (
    `billing_account_id` BIGINT COMMENT 'Unique identifier for the billing account. Primary key for the billing account entity.',
    `address_book_id` BIGINT COMMENT 'Foreign key linking to customer.address_book. Business justification: Billing account address normalization: logistics billing accounts reference a validated billing address from the customer address book for invoice delivery and regulatory compliance. billing_address_l',
    `credit_profile_id` BIGINT COMMENT 'Foreign key linking to customer.credit_profile. Business justification: Billing account credit governance: in logistics, a billing accounts credit limit, status, and review schedule are governed by the customers credit profile. credit_limit_amount, credit_status, credit',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer entity that owns this billing account. Links to the customer master record in the customer domain.',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.billing_cycle. Business justification: Account currently has billing_cycle as STRING. This should be normalized to reference billing.billing_cycle master table. The billing_cycle_id FK allows joining to get cycle configuration (frequency, ',
    `parent_billing_account_id` BIGINT COMMENT 'Reference to the parent billing account if this account is part of a hierarchical billing structure. Used for consolidated invoicing and corporate account management.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Account currently has payment_terms as STRING. This should be normalized to reference billing.payment_term master table. The payment_term_id FK allows joining to get code, name, net_days, discount ter',
    `tax_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.tax_schedule. Business justification: A billing account has a default tax schedule that governs the applicable tax rules, rates, and jurisdictions for all invoices generated under that account. This is standard in logistics billing where ',
    `account_name` STRING COMMENT 'Descriptive name for the billing account, typically reflecting the customer legal entity or division name for this billing relationship.',
    `account_number` STRING COMMENT 'Externally visible unique billing account number used in invoices, statements, and customer communications. This is the business identifier for the billing relationship.. Valid values are `^[A-Z0-9]{8,20}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the billing account. Active accounts can transact and be invoiced. Suspended accounts have temporary restrictions due to payment issues. On-hold accounts are pending review. Closed accounts are terminated. Blacklisted accounts are permanently blocked due to fraud or severe non-compliance.. Valid values are `active|suspended|on_hold|closed|blacklisted`',
    `account_type` STRING COMMENT 'Classification of the billing account based on customer segment and billing complexity. Corporate accounts typically have negotiated terms, individual accounts are retail customers, government accounts follow public sector procurement rules, and partner accounts are for strategic alliances.. Valid values are `corporate|individual|government|partner`',
    `auto_pay_enabled_flag` BOOLEAN COMMENT 'Indicates whether automatic payment processing is enabled for this account. When true, invoices are automatically charged to the preferred payment method on the due date.',
    `billing_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which this account is billed. All invoices and payments for this account are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `business_area_code` STRING COMMENT 'SAP business area code representing the service line or division (e.g., express parcel, freight forwarding, contract logistics) for internal P&L (Profit and Loss) reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity within Transport Shipping that owns this billing relationship. Used for financial consolidation and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidated_billing_flag` BOOLEAN COMMENT 'Indicates whether this account participates in consolidated billing where multiple accounts or locations are invoiced together under a master account.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing account record was first created in the system. Used for audit trail and data lineage.',
    `dunning_block_flag` BOOLEAN COMMENT 'Indicates whether automated dunning (collections reminders) is blocked for this account. True when account is in dispute resolution, under special payment arrangement, or managed by dedicated account manager.',
    `dunning_profile` STRING COMMENT 'Collections strategy profile defining the escalation sequence and tone for overdue payment reminders. Standard for typical accounts. Aggressive for high-risk accounts. Gentle for strategic customers. VIP for top-tier accounts with relationship managers. Legal for accounts in litigation.. Valid values are `standard|aggressive|gentle|vip|legal`',
    `effective_end_date` DATE COMMENT 'Date when this billing account was closed or terminated. Null for active accounts. Once set, no new transactions can be posted to this account.',
    `effective_start_date` DATE COMMENT 'Date when this billing account became active and eligible for transactions and invoicing. Marks the beginning of the billing relationship.',
    `gl_account_code` STRING COMMENT 'Default general ledger account code in the chart of accounts to which revenue from this billing account is posted. Typically an accounts receivable control account.. Valid values are `^[0-9]{6,10}$`',
    `invoice_delivery_method` STRING COMMENT 'Primary method by which invoices are delivered to the customer. Email for electronic PDF delivery. EDI (Electronic Data Interchange) for automated system-to-system transmission. Portal for customer self-service download. Post for physical mail. Fax for legacy customers.. Valid values are `email|edi|portal|post|fax`',
    `invoice_email_address` STRING COMMENT 'Primary email address to which electronic invoices are sent. May differ from the customer contact email if invoices go to accounts payable department.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `last_invoice_date` DATE COMMENT 'Date of the most recent invoice generated for this billing account. Used for billing cycle tracking and customer service inquiries.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received from this billing account. Used for credit monitoring and collections management.',
    `notes` STRING COMMENT 'Free-text field for additional billing account information, special instructions, payment arrangements, or historical context not captured in structured fields.',
    `paperless_billing_flag` BOOLEAN COMMENT 'Indicates whether the customer has opted for paperless billing. When true, all invoices and statements are delivered electronically only, with no postal mail.',
    `preferred_payment_method` STRING COMMENT 'Customer preferred payment instrument. ACH (Automated Clearing House) for US bank transfers. Wire transfer for international payments. Credit card for smaller accounts. Check for traditional payment. Direct debit for automated recurring payments.. Valid values are `ach|wire_transfer|credit_card|check|direct_debit`',
    `sap_customer_account_code` STRING COMMENT 'Customer account number in SAP S/4HANA Finance system. Used for integration and reconciliation between lakehouse and ERP system of record.. Valid values are `^[A-Z0-9]{10}$`',
    `tax_exemption_certificate_number` STRING COMMENT 'Reference number of the tax exemption certificate on file, if applicable. Required for audit trail when tax exemption status is exempt or partially exempt.',
    `tax_exemption_status` STRING COMMENT 'Indicates whether this billing account is subject to standard taxation, fully exempt (e.g., government entities, non-profits), or partially exempt for specific service types.. Valid values are `taxable|exempt|partially_exempt`',
    `tax_registration_number` STRING COMMENT 'Customer tax registration identifier such as VAT (Value Added Tax) number in EU, GST (Goods and Services Tax) number in other jurisdictions, or EIN (Employer Identification Number) in US. Used for tax compliance and invoice generation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing account record was last modified. Used for audit trail, change tracking, and data synchronization.',
    CONSTRAINT pk_billing_account PRIMARY KEY(`billing_account_id`)
) COMMENT 'Billing account master record defining the billing relationship and financial terms between Transport Shipping and a customer entity. Distinct from the customer identity record (owned by the customer domain), this entity captures billing-specific attributes: billing account number, billing currency, payment terms (NET30, NET60, prepaid, COD), credit limit, credit status (active, suspended, on_hold, blacklisted), billing cycle (weekly, bi-weekly, monthly, on-demand), invoice delivery method (email, EDI, portal, post), tax registration number (VAT/GST), tax exemption status, billing address, preferred payment method, dunning profile, and SAP S/4HANA customer account code. SSOT for billing configuration per customer.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` (
    `tax_schedule_id` BIGINT COMMENT 'Unique identifier for the tax schedule record. Primary key.',
    `applicable_service_types` STRING COMMENT 'Comma-separated list of service types to which this tax schedule applies (e.g., express_parcel, air_freight, ocean_freight, road_freight, rail_freight, warehousing, customs_brokerage, last_mile_delivery).',
    `compound_tax_flag` BOOLEAN COMMENT 'Indicates whether this tax is calculated on top of other taxes (compound/cascading tax). True if compound tax applies, False if calculated on base amount only.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code in which the minimum and maximum taxable amounts are denominated.. Valid values are `^[A-Z]{3}$`',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code of the goods destination, relevant for destination-based tax calculations. Nullable if not destination-dependent.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date from which this tax schedule becomes active and applicable to transactions. Must be on or before the transaction date for the schedule to apply.',
    `exemption_category` STRING COMMENT 'Category or code identifying the type of tax exemption that may apply (e.g., diplomatic, humanitarian, re-export, AEO certified, C-TPAT certified). Nullable if no exemption applies.',
    `exemption_certificate_required_flag` BOOLEAN COMMENT 'Indicates whether a tax exemption certificate must be provided to apply this schedule. True if certificate is required, False otherwise.',
    `expiry_date` DATE COMMENT 'The date on which this tax schedule ceases to be applicable. Nullable for schedules with indefinite validity.',
    `gl_account_code` STRING COMMENT 'General Ledger account code to which tax amounts calculated using this schedule are posted in the financial system.. Valid values are `^[0-9]{4,10}$`',
    `hs_code_range_end` STRING COMMENT 'Ending HS Code in the range of commodity codes to which this tax schedule applies. Nullable if not commodity-specific.. Valid values are `^[0-9]{6,10}$`',
    `hs_code_range_start` STRING COMMENT 'Starting HS Code in the range of commodity codes to which this tax schedule applies. Nullable if not commodity-specific.. Valid values are `^[0-9]{6,10}$`',
    `jurisdiction_country_code` STRING COMMENT 'Three-letter ISO country code identifying the tax jurisdiction country where this tax schedule applies.. Valid values are `^[A-Z]{3}$`',
    `jurisdiction_state_province` STRING COMMENT 'State, province, or regional subdivision within the country where this tax schedule applies. Nullable for country-level taxes.',
    `jurisdiction_zone_type` STRING COMMENT 'Type of economic or customs zone. FTZ (Free Trade Zone), ICD (Inland Container Depot), CFS (Container Freight Station), or special economic zone with distinct tax treatment.. Valid values are `standard|FTZ|ICD|CFS|special_economic_zone`',
    `maximum_taxable_amount` DECIMAL(18,2) COMMENT 'Maximum transaction amount threshold above which this tax schedule does not apply or a different schedule takes effect. Nullable if no maximum threshold exists.',
    `minimum_taxable_amount` DECIMAL(18,2) COMMENT 'Minimum transaction amount threshold below which this tax schedule does not apply. Nullable if no minimum threshold exists.',
    `notes` STRING COMMENT 'Free-text field for additional information, special instructions, or clarifications regarding the application of this tax schedule.',
    `origin_country_code` STRING COMMENT 'Three-letter ISO country code of the goods origin, relevant for preferential tax treatment under trade agreements. Nullable if not origin-dependent.. Valid values are `^[A-Z]{3}$`',
    `priority_rank` STRING COMMENT 'Numeric rank used to determine precedence when multiple tax schedules could apply to the same transaction. Lower numbers indicate higher priority.',
    `regulatory_authority` STRING COMMENT 'Name of the government or regulatory body that mandates this tax schedule (e.g., IRS, HMRC, GST Council, Customs Authority).',
    `regulatory_reference_number` STRING COMMENT 'Official reference number, gazette notification, or legal citation from the regulatory authority that establishes this tax schedule.',
    `reverse_charge_applicable_flag` BOOLEAN COMMENT 'Indicates whether reverse charge mechanism applies, where the recipient of goods or services is responsible for tax payment instead of the supplier. True if reverse charge applies, False otherwise.',
    `sap_tax_code` STRING COMMENT 'SAP tax code identifier used in SAP S/4HANA for GL posting and tax reporting. Links to SAP tax determination logic.. Valid values are `^[A-Z0-9]{2,4}$`',
    `sap_tax_condition_type` STRING COMMENT 'SAP S/4HANA tax condition type code used for integration with the financial system. Maps this tax schedule to SAP pricing and billing configuration.. Valid values are `^[A-Z0-9]{4}$`',
    `schedule_code` STRING COMMENT 'Business identifier code for the tax schedule used in billing and invoicing systems. Externally known reference code.. Valid values are `^[A-Z0-9]{4,20}$`',
    `schedule_name` STRING COMMENT 'Descriptive name of the tax schedule for business user identification and reporting purposes.',
    `tax_basis` STRING COMMENT 'The valuation basis on which the tax is calculated. CIF (Cost Insurance and Freight), DDP (Delivered Duty Paid), FOB (Free on Board), EXW (Ex Works), or other Incoterms-based valuation.. Valid values are `freight_value|declared_value|CIF_value|DDP_value|FOB_value|EXW_value`',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'The applicable tax rate expressed as a percentage (e.g., 15.0000 for 15%). Supports up to four decimal places for precision in multi-jurisdictional tax calculations.',
    `tax_reporting_category` STRING COMMENT 'Category used for grouping tax amounts in statutory tax returns and regulatory reports (e.g., domestic sales, export sales, import duties, inter-state supplies).',
    `tax_schedule_status` STRING COMMENT 'Current lifecycle status of the tax schedule. Active schedules are in use, inactive are retired, pending are awaiting approval, superseded have been replaced by newer schedules.. Valid values are `active|inactive|pending|superseded`',
    `tax_type` STRING COMMENT 'Classification of the tax applied. VAT (Value Added Tax), GST (Goods and Services Tax), WHT (Withholding Tax), customs duty, excise tax, or service tax.. Valid values are `VAT|GST|WHT|customs_duty|excise|service_tax`',
    `trade_agreement_code` STRING COMMENT 'Code identifying the bilateral or multilateral trade agreement under which preferential tax rates or exemptions apply (e.g., USMCA, EU-UK TCA, RCEP). Nullable if no trade agreement applies.',
    `updated_by` STRING COMMENT 'User ID or name of the person who last updated this tax schedule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this tax schedule record was last modified in the system.',
    `withholding_tax_flag` BOOLEAN COMMENT 'Indicates whether this schedule represents a withholding tax that must be deducted at source. True if withholding tax applies, False otherwise.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this tax schedule record in the system.',
    CONSTRAINT pk_tax_schedule PRIMARY KEY(`tax_schedule_id`)
) COMMENT 'Reference master defining applicable tax rules, rates, and jurisdictions for logistics billing. Captures tax schedule code, tax type (VAT, GST, WHT, customs duty, excise, service tax), jurisdiction (country, state/province, free trade zone), tax rate percentage, tax basis (freight value, declared value, CIF value, DDP value), applicable service types, exemption categories, effective date, expiry date, regulatory authority reference, and SAP S/4HANA tax condition type. Supports multi-jurisdictional tax compliance for cross-border shipments and ensures correct tax calculation on customer invoices.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`payment_term` (
    `payment_term_id` BIGINT COMMENT 'Unique identifier for the payment term. Primary key.',
    `applicable_customer_segments` STRING COMMENT 'Comma-separated list of customer segments to which this payment term is applicable (e.g., enterprise, SMB, government, retail). Used to enforce eligibility rules during contract setup and invoicing. [ENUM-REF-CANDIDATE: enterprise|smb|government|retail|ecommerce|3pl|freight_forwarder — promote to reference product]',
    `applicable_service_lines` STRING COMMENT 'Comma-separated list of service lines to which this payment term applies (e.g., express_parcel, freight_forwarding, warehousing, customs_brokerage, ecommerce_fulfillment). Ensures payment terms align with service-specific billing policies. [ENUM-REF-CANDIDATE: express_parcel|freight_forwarding|warehousing|customs_brokerage|ecommerce_fulfillment|contract_logistics|last_mile — promote to reference product]',
    `approved_by` STRING COMMENT 'User ID or name of the finance manager or credit manager who approved this payment term for use. Null if approval is not required or pending. Supports governance and compliance.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this payment term was approved for use. Null if approval is not required or pending. Supports governance and compliance audit trail.',
    `auto_dunning_enabled_flag` BOOLEAN COMMENT 'Indicates whether automated dunning (collections reminder) processes are enabled for invoices using this payment term. True for standard credit terms. False for prepaid or special arrangement terms.',
    `cod_collection_method` STRING COMMENT 'Specifies the acceptable payment collection method for COD (Cash on Delivery) terms. Applicable only when type is cash_on_delivery. Not_applicable for non-COD terms.. Valid values are `cash|check|card|bank_transfer|not_applicable`',
    `coupa_payment_term_code` STRING COMMENT 'Payment term code used in Coupa Procurement and Spend Management system for carrier payables and supplier invoice processing. Ensures alignment between customer receivables and carrier payables payment terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment term record was first created in the system. Supports audit trail and data lineage.',
    `currency_restrictions` STRING COMMENT 'Comma-separated list of ISO 4217 three-letter currency codes for which this payment term is valid (e.g., USD, EUR, GBP). Null or empty if the term applies to all currencies. Used to enforce currency-specific payment policies.',
    `default_for_customer_segment` STRING COMMENT 'Customer segment for which this payment term is the default option during contract setup or customer onboarding. Null if not a default term. Streamlines contract creation workflows.',
    `default_for_service_line` STRING COMMENT 'Service line for which this payment term is the default option during contract setup or service agreement creation. Null if not a default term. Ensures service-specific billing alignment.',
    `dunning_start_days_after_due` STRING COMMENT 'Number of days after the invoice due date when automated dunning (collections reminder) process begins. Null if auto_dunning_enabled_flag is false.',
    `early_payment_discount_days` STRING COMMENT 'Number of days from invoice date within which payment must be made to qualify for the early payment discount (e.g., 10 for 2/10 NET30 terms). Null if no early payment discount applies.',
    `early_payment_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount offered if payment is made within the early payment discount period (e.g., 2.00 for 2% discount in 2/10 NET30 terms). Null if no early payment discount applies.',
    `effective_end_date` DATE COMMENT 'Date after which this payment term is no longer valid for new contracts or invoices. Null for open-ended terms. Used to phase out deprecated payment terms while preserving historical data.',
    `effective_start_date` DATE COMMENT 'Date from which this payment term becomes valid and available for use in contracts and invoicing. Supports time-based payment term changes and regulatory compliance.',
    `gl_account_code` STRING COMMENT 'General Ledger account code in SAP S/4HANA Finance to which revenue or payables using this payment term are posted. Supports financial reporting and reconciliation.. Valid values are `^[0-9]{4,10}$`',
    `grace_period_days` STRING COMMENT 'Number of additional days after the net due date before late payment penalties are applied. Provides a buffer period for customers. Zero or null if no grace period is offered.',
    `installment_count` STRING COMMENT 'Number of installment payments allowed under this payment term. Applicable for installment-based payment terms. Null or 1 for single-payment terms.',
    `installment_frequency_days` STRING COMMENT 'Number of days between each installment payment. Applicable for installment-based payment terms. Null for single-payment terms.',
    `late_payment_penalty_rate` DECIMAL(18,2) COMMENT 'Percentage penalty or interest rate applied to overdue balances after the net payment due date. Expressed as an annual percentage rate (APR) or per-period rate. Null if no late payment penalty applies.',
    `maximum_credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding accounts receivable balance allowed for customers using this payment term. Enforces credit exposure limits. Null if no limit applies (e.g., for prepaid or COD terms).',
    `minimum_credit_score_required` STRING COMMENT 'Minimum credit risk score a customer must have to be eligible for this payment term. Used to enforce credit policy and reduce bad debt risk. Null if no minimum score is required.',
    `net_days` STRING COMMENT 'Number of days from invoice date by which full payment is due. Standard payment window for the term (e.g., 30 for NET30, 60 for NET60). Zero for immediate payment terms like COD or PREPAID.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or exceptions related to this payment term. Used by finance and credit teams for context and clarification.',
    `payment_term_code` STRING COMMENT 'Short alphanumeric code representing the payment term (e.g., NET30, NET60, NET90, COD, PREPAID, 2_10_NET30). Used as the business identifier across invoicing, contracts, and carrier payable management.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `payment_term_description` STRING COMMENT 'Detailed explanation of the payment term, including conditions, discount eligibility, and any special instructions. Provides clarity for finance teams and customers.',
    `payment_term_name` STRING COMMENT 'Full descriptive name of the payment term (e.g., Net 30 Days, Cash on Delivery, Prepaid, 2% 10 Net 30). Human-readable label used in customer-facing documents and internal reports.',
    `payment_term_status` STRING COMMENT 'Current lifecycle status of the payment term. Active terms are available for use in new contracts and invoices. Inactive or deprecated terms are retained for historical reference but not available for new transactions.. Valid values are `active|inactive|deprecated|pending_approval`',
    `payment_term_type` STRING COMMENT 'Classification of the payment term based on its structure and purpose. Determines how the term is applied in billing and collections workflows.. Valid values are `standard|early_payment_discount|cash_on_delivery|prepaid|deferred|installment`',
    `prepayment_required_flag` BOOLEAN COMMENT 'Indicates whether full payment must be received before service delivery or shipment. True for prepaid terms. False for post-service payment terms.',
    `requires_credit_approval_flag` BOOLEAN COMMENT 'Indicates whether assignment of this payment term to a customer requires credit manager approval. True for extended terms (e.g., NET90) or high-risk terms. False for standard or prepaid terms.',
    `revenue_recognition_method` STRING COMMENT 'Specifies the IFRS 15 revenue recognition method associated with this payment term. Point_in_time for immediate recognition (e.g., COD, prepaid). Over_time or deferred for extended terms. Guides accounting treatment.. Valid values are `point_in_time|over_time|deferred|not_applicable`',
    `sap_payment_term_key` STRING COMMENT 'Four-character alphanumeric key used in SAP S/4HANA Finance to represent this payment term. Enables seamless integration with SAP AR, AP, and revenue recognition modules.. Valid values are `^[A-Z0-9]{4}$`',
    `updated_by` STRING COMMENT 'User ID or name of the person who last updated this payment term record. Supports audit trail and change tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payment term record was last modified. Supports audit trail and change tracking.',
    `usage_count` BIGINT COMMENT 'Total number of active customer accounts, contracts, or invoices currently using this payment term. Provides insight into term popularity and impact of changes. Updated periodically via batch process.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this payment term record in the system. Supports audit trail and accountability.',
    CONSTRAINT pk_payment_term PRIMARY KEY(`payment_term_id`)
) COMMENT 'Reference master defining standard payment terms offered to customers and applied to carrier payables. Captures payment term code, payment term description (NET30, NET60, NET90, COD, prepaid, 2/10 NET30), number of days, early payment discount percentage, early payment discount days, late payment penalty rate, applicable customer segments, applicable service lines, currency restrictions, and SAP S/4HANA payment term key. Provides standardized payment term taxonomy used across invoice issuance, contract agreements, and carrier payable management.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`cycle` (
    `cycle_id` BIGINT COMMENT 'Unique identifier for the billing cycle configuration record.',
    `applicable_customer_tiers` STRING COMMENT 'Comma-separated list of customer tier codes or segments to which this billing cycle applies (e.g., ENTERPRISE, SMB, RETAIL, PLATINUM, GOLD). Empty means applicable to all customer tiers.',
    `applicable_service_lines` STRING COMMENT 'Comma-separated list of service lines to which this billing cycle applies (e.g., Express Parcel, Air Freight, Ocean Freight, LTL, FTL, Warehousing, Customs Brokerage, E-Commerce Fulfillment). Empty means applicable to all service lines.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether invoices generated under this billing cycle require manual approval before being dispatched to customers.',
    `approver_role_code` STRING COMMENT 'Role code or job function authorized to approve invoices generated under this billing cycle (e.g., BILLING_MANAGER, FINANCE_CONTROLLER). Null if no approval required.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `auto_invoice_generation_flag` BOOLEAN COMMENT 'Indicates whether invoices are automatically generated by the billing system when the trigger event occurs (True) or require manual approval (False).',
    `business_unit_code` STRING COMMENT 'Business unit or division code to which this billing cycle belongs (e.g., EXPRESS, FREIGHT, ECOMMERCE, WAREHOUSING).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity under which invoices are issued for this billing cycle.. Valid values are `^[A-Z0-9]{4,10}$`',
    `consolidation_level` STRING COMMENT 'Defines the level at which charges are consolidated into invoices for this billing cycle (e.g., shipment-level for individual AWB/BOL invoices, account-level for consolidated monthly statements).. Valid values are `shipment|account|business-unit|consolidated`',
    `cost_center_code` STRING COMMENT 'Default cost center code for financial reporting and cost allocation of invoices generated under this billing cycle.. Valid values are `^[A-Z0-9]{4,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing cycle configuration record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for invoices generated under this billing cycle (e.g., USD, EUR, GBP). Can be overridden at customer account level.. Valid values are `^[A-Z]{3}$`',
    `cycle_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the billing cycle configuration (e.g., MONTHLY_STD, WEEKLY_EXPRESS, ONDEMAND_FCL).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `cycle_name` STRING COMMENT 'Human-readable descriptive name of the billing cycle (e.g., Standard Monthly Billing, Weekly Express Parcel Cycle).',
    `cycle_status` STRING COMMENT 'Current lifecycle status of the billing cycle configuration.. Valid values are `active|inactive|draft|deprecated|suspended`',
    `dispute_resolution_sla_days` STRING COMMENT 'Target number of days for resolving billing disputes for invoices generated under this billing cycle, as defined in customer SLA agreements.',
    `dunning_enabled_flag` BOOLEAN COMMENT 'Indicates whether automated dunning (payment reminder) processes are enabled for overdue invoices generated under this billing cycle.',
    `dunning_grace_period_days` STRING COMMENT 'Number of days after payment due date before the first dunning notice is sent. Null if dunning is not enabled.',
    `early_payment_discount_days` STRING COMMENT 'Number of days from invoice date within which payment must be received to qualify for early payment discount. Null if no early payment discount applies.',
    `early_payment_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount offered for early payment (e.g., 2% discount if paid within 10 days). Null if no early payment discount applies.',
    `effective_end_date` DATE COMMENT 'Date after which this billing cycle configuration is no longer active and cannot be assigned to new customer billing accounts. Null indicates no end date (indefinite validity).',
    `effective_start_date` DATE COMMENT 'Date from which this billing cycle configuration becomes active and can be assigned to customer billing accounts.',
    `end_day` STRING COMMENT 'Day of the month or week when the billing cycle period ends (1-31 for monthly, 1-7 for weekly). Null for on-demand cycles.',
    `frequency` STRING COMMENT 'Frequency at which invoices are generated for accounts assigned to this billing cycle. [ENUM-REF-CANDIDATE: daily|weekly|bi-weekly|monthly|quarterly|annual|on-demand — 7 candidates stripped; promote to reference product]',
    `gl_account_code` STRING COMMENT 'Default General Ledger account code for revenue posting of invoices generated under this billing cycle in SAP S/4HANA Finance.. Valid values are `^[A-Z0-9]{4,20}$`',
    `invoice_delivery_lead_time_days` STRING COMMENT 'Number of days between invoice generation and invoice delivery/dispatch to the customer.',
    `invoice_delivery_method` STRING COMMENT 'Default method for delivering invoices to customers under this billing cycle (e.g., email, EDI transmission, customer portal, postal mail, API push).. Valid values are `email|edi|portal|mail|api`',
    `invoice_format` STRING COMMENT 'Default format for invoice delivery under this billing cycle (e.g., PDF for email, EDI-810 for Electronic Data Interchange, XML for API integration).. Valid values are `pdf|edi-810|xml|csv|api`',
    `invoice_generation_trigger` STRING COMMENT 'Business event that triggers invoice generation for this billing cycle (e.g., cycle-end for periodic billing, shipment-completion for transactional billing, pod-confirmed for proof-of-delivery based billing).. Valid values are `cycle-end|shipment-completion|milestone|manual|pod-confirmed|customs-cleared`',
    `late_payment_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage fee applied to overdue invoice amounts for late payment under this billing cycle. Null if no late fees apply.',
    `minimum_invoice_amount` DECIMAL(18,2) COMMENT 'Minimum invoice amount threshold below which invoices are not generated and charges are carried forward to the next billing cycle. Null if no minimum applies.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing cycle configuration record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or business context related to this billing cycle configuration.',
    `payment_due_offset_days` STRING COMMENT 'Number of days from invoice date when payment is due, defining the payment terms for this billing cycle (e.g., 30 for Net 30, 15 for Net 15).',
    `profit_center_code` STRING COMMENT 'Default profit center code for profitability analysis of invoices generated under this billing cycle.. Valid values are `^[A-Z0-9]{4,20}$`',
    `revenue_recognition_method` STRING COMMENT 'Method for recognizing revenue for invoices generated under this billing cycle, aligned to IFRS 15 performance obligation satisfaction (e.g., point-in-time for express delivery, over-time for warehousing, pod-based for proof-of-delivery confirmation).. Valid values are `point-in-time|over-time|milestone|pod-based|customs-cleared`',
    `start_day` STRING COMMENT 'Day of the month or week when the billing cycle period begins (1-31 for monthly, 1-7 for weekly). Null for on-demand cycles.',
    `tax_calculation_method` STRING COMMENT 'Method for calculating and displaying tax on invoices generated under this billing cycle (e.g., inclusive for tax-included pricing, exclusive for tax added at invoice time, reverse-charge for VAT reverse charge mechanism).. Valid values are `inclusive|exclusive|exempt|reverse-charge`',
    CONSTRAINT pk_cycle PRIMARY KEY(`cycle_id`)
) COMMENT 'Master configuration record defining the billing cycle parameters for a billing account or customer segment. Captures billing cycle code, cycle name, cycle frequency (daily, weekly, bi-weekly, monthly, quarterly, on-demand), cycle start day, cycle end day, invoice generation trigger (cycle-end, shipment-completion, milestone, manual), invoice delivery lead time (days), payment due offset (days from invoice date), applicable service lines, applicable customer tiers, and effective date range. Governs when invoices are generated and dispatched for each customer billing account.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` (
    `performance_obligation_id` BIGINT COMMENT 'Primary key for performance_obligation',
    `agreement_id` BIGINT COMMENT 'Identifier of the underlying contract that contains this performance obligation.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer to whom the obligation is owed.',
    `parent_performance_obligation_id` BIGINT COMMENT 'Self-referencing FK on performance_obligation (parent_performance_obligation_id)',
    `sla_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.contract_sla_commitment. Business justification: Performance obligations in revenue recognition often map to specific SLA commitments (delivery milestones, service completion events). Required for ASC 606 compliance and milestone-based revenue recog',
    `sla_entitlement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_entitlement. Business justification: SLA-driven revenue recognition: logistics performance obligations (volume commitments, transit guarantees) are tied to SLA entitlements. This link enables revenue recognition reporting that validates ',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Portion of the contract total that has been allocated to this performance obligation.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Cumulative amount invoiced against the performance obligation.',
    `billing_cycle` STRING COMMENT 'Frequency or trigger for invoicing the obligation.',
    `collection_method` STRING COMMENT 'Method used to collect payment for the obligation.',
    `collection_status` STRING COMMENT 'Current status of cash collection for the obligation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the performance obligation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the obligation.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount granted against the obligation.',
    `discount_type` STRING COMMENT 'Method by which the discount is applied.',
    `due_date` DATE COMMENT 'Date by which the customer must satisfy the performance obligation.',
    `effective_end_date` DATE COMMENT 'Date when the performance obligation ends or expires; null for open‑ended contracts.',
    `effective_start_date` DATE COMMENT 'Date when the performance obligation becomes binding.',
    `is_partial_obligation` BOOLEAN COMMENT 'True if the obligation represents a portion of a larger contract obligation.',
    `metric_actual_value` DECIMAL(18,2) COMMENT 'Actual measured value of the performance metric to date.',
    `metric_target_value` DECIMAL(18,2) COMMENT 'Target value for the performance metric that triggers revenue recognition.',
    `metric_unit` STRING COMMENT 'Unit of measure for the performance metric.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or special conditions.',
    `obligation_number` STRING COMMENT 'External identifier assigned to the performance obligation by the billing system.',
    `obligation_type` STRING COMMENT 'Category of the promised deliverable underlying the obligation.',
    `payment_terms` STRING COMMENT 'Standard payment terms governing when payment is due (e.g., Net 30).',
    `performance_metric` STRING COMMENT 'Metric used to measure progress toward satisfying the obligation (e.g., shipped_weight, miles_travelled).',
    `performance_obligation_description` STRING COMMENT 'Free‑form text describing the goods or services promised.',
    `performance_obligation_status` STRING COMMENT 'Current lifecycle state of the performance obligation.',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue for the obligation was recognized.',
    `revenue_recognition_method` STRING COMMENT 'Method used to recognize revenue for this obligation.',
    `revenue_recognition_status` STRING COMMENT 'Current status of revenue recognition for the obligation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the obligation amount.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction and rate applied.',
    `total_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary value of the performance obligation at contract inception.',
    `unbilled_amount` DECIMAL(18,2) COMMENT 'Remaining monetary value of the obligation that has not yet been invoiced.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the performance obligation record.',
    CONSTRAINT pk_performance_obligation PRIMARY KEY(`performance_obligation_id`)
) COMMENT 'Master reference table for performance_obligation. Referenced by performance_obligation_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `transport_shipping_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `transport_shipping_ecm`.`billing`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_tax_schedule_id` FOREIGN KEY (`tax_schedule_id`) REFERENCES `transport_shipping_ecm`.`billing`.`tax_schedule`(`tax_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `transport_shipping_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `transport_shipping_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ADD CONSTRAINT `fk_billing_receivable_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ADD CONSTRAINT `fk_billing_receivable_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `transport_shipping_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `transport_shipping_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_freight_audit_id` FOREIGN KEY (`freight_audit_id`) REFERENCES `transport_shipping_ecm`.`billing`.`freight_audit`(`freight_audit_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `transport_shipping_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_parent_billing_account_id` FOREIGN KEY (`parent_billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `transport_shipping_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_tax_schedule_id` FOREIGN KEY (`tax_schedule_id`) REFERENCES `transport_shipping_ecm`.`billing`.`tax_schedule`(`tax_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_parent_performance_obligation_id` FOREIGN KEY (`parent_performance_obligation_id`) REFERENCES `transport_shipping_ecm`.`billing`.`performance_obligation`(`performance_obligation_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `transport_shipping_ecm`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'customer_invoicing');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `address_book_id` SET TAGS ('dbx_business_glossary_term' = 'Bill To Address Book Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `address_book_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `address_book_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Bill To Contact Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `sla_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Entitlement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `amount_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Amount Outstanding');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|edi|customer_portal|fax');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|proforma|credit_note|debit_note|consolidated|recurring');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `revenue_recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Status (IFRS 15)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `revenue_recognition_status` SET TAGS ('dbx_value_regex' = 'not_recognized|partially_recognized|fully_recognized|deferred');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Document Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `sent_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Sent Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` SET TAGS ('dbx_subdomain' = 'customer_invoicing');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `billing_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `blocked_space_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Blocked Space Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `contract_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `contract_surcharge_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Surcharge Schedule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `interline_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Surcharge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `route_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Route Delivery Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `tax_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Schedule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `transit_time_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Transit Time Standard Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `charge_description` SET TAGS ('dbx_business_glossary_term' = 'Charge Description');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `chargeback_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `discount_reason` SET TAGS ('dbx_business_glossary_term' = 'Discount Reason');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `line_total` SET TAGS ('dbx_business_glossary_term' = 'Line Total');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `revenue_type` SET TAGS ('dbx_business_glossary_term' = 'Revenue Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `revenue_type` SET TAGS ('dbx_value_regex' = 'freight_revenue|surcharge_revenue|accessorial_revenue|customs_revenue|storage_revenue|other_revenue');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` SET TAGS ('dbx_subdomain' = 'customer_invoicing');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Claim ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Issued To Contact Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'open|partially_applied|fully_applied|expired|voided');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|cancelled');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_number` SET TAGS ('dbx_value_regex' = '^CN-[0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Reason Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_reason_code` SET TAGS ('dbx_value_regex' = 'billing_error|service_failure|sla_breach|rate_dispute|duplicate_charge|goodwill_adjustment');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Credit Reason Description');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_type` SET TAGS ('dbx_value_regex' = 'full_reversal|partial_adjustment|tax_correction|freight_adjustment|claim_settlement');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `issuing_location_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `issuing_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `revenue_reversal_period` SET TAGS ('dbx_business_glossary_term' = 'Revenue Reversal Period');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `revenue_reversal_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `sap_credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'SAP (Systems Applications and Products) Credit Memo Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contact Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Reference');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `bank_charges` SET TAGS ('dbx_business_glossary_term' = 'Bank Charges');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Reference');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'online_portal|edi|manual|bank_file|mobile_app|api');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `clearing_date` SET TAGS ('dbx_business_glossary_term' = 'Clearing Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `clearing_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Reference');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Clearing Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `clearing_status` SET TAGS ('dbx_value_regex' = 'uncleared|partially_cleared|fully_cleared|reversed');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `early_payment_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `gl_document_reference` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Document Reference');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `instruction_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Instruction Reference');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `is_disputed` SET TAGS ('dbx_business_glossary_term' = 'Is Disputed Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `narrative` SET TAGS ('dbx_business_glossary_term' = 'Payment Narrative');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `payer_bank_identifier` SET TAGS ('dbx_business_glossary_term' = 'Payer Bank Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `payer_bank_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|reversed|cancelled');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `processor_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Reference');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|exception|under_review');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `remittance_advice_reference` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Reference');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `unapplied_balance` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Balance');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `withholding_tax_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Certificate Reference');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `payment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_business_glossary_term' = 'Allocation Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'provisional|confirmed|reversed|pending_approval|rejected');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Allocation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'full_settlement|partial_payment|advance_application|credit_offset|on_account|write_off');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `auto_match_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Auto-Match Confidence Score');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cash Discount Percentage');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `matching_method` SET TAGS ('dbx_business_glossary_term' = 'Matching Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `matching_method` SET TAGS ('dbx_value_regex' = 'exact_invoice_match|amount_match|customer_match|remittance_advice|manual|ai_predicted');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `open_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Open Balance After Allocation');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `open_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Open Balance Before Allocation');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `value_date` SET TAGS ('dbx_business_glossary_term' = 'Value Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `write_off_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `write_off_reason_code` SET TAGS ('dbx_value_regex' = 'bad_debt|small_balance|customer_dispute|bankruptcy|goodwill|other');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Receivable ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Collections Contact Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `ar_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Balance Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `bad_debt_provision_amount` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Provision Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `bad_debt_provision_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `collection_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Name');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `collection_agency_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Referral Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `collection_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Referral Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `current_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `days_1_30_amount` SET TAGS ('dbx_business_glossary_term' = '1-30 Days Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `days_31_60_amount` SET TAGS ('dbx_business_glossary_term' = '31-60 Days Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `days_61_90_amount` SET TAGS ('dbx_business_glossary_term' = '61-90 Days Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `days_over_90_amount` SET TAGS ('dbx_business_glossary_term' = 'Over 90 Days Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `days_sales_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `dispute_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Hold Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Dunning Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `dunning_level` SET TAGS ('dbx_value_regex' = 'none|first_notice|second_notice|final_notice|collections|legal_action');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `last_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `last_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|pending|discrepancy');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `sap_customer_account_number` SET TAGS ('dbx_business_glossary_term' = 'SAP S/4HANA Customer Account Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `sap_customer_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `sap_customer_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `write_off_status` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `write_off_status` SET TAGS ('dbx_value_regex' = 'active|partial_write_off|full_write_off');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `freight_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `carrier_lane_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Lane Allocation Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `contract_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `lane_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Commitment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sla Commitment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `tariff_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `transit_time_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Transit Time Standard Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `accessorial_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `audit_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Completion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `audit_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `audit_reference_number` SET TAGS ('dbx_value_regex' = '^FA[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `audit_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `carrier_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `carrier_invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Carrier Invoiced Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `contracted_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `dim_weight_contracted_kg` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight Contracted (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `dim_weight_invoiced_kg` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight Invoiced (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `dispute_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `invoice_due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `savings_captured_amount` SET TAGS ('dbx_business_glossary_term' = 'Savings Captured Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `shipment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `volume_contracted_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Contracted (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `volume_invoiced_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume Invoiced (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `weight_contracted_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Contracted (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `weight_invoiced_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Invoiced (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `weight_variance_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Variance (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `carrier_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payable ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `carrier_buy_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Buy Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `carrier_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight in Kilograms');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `dim_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight in Kilograms (DIM Weight)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `net_payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payable Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `payable_amount` SET TAGS ('dbx_business_glossary_term' = 'Payable Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `payable_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payable Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|electronic_funds_transfer');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending_audit|approved|scheduled|paid|disputed|on_hold');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `sap_vendor_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Vendor Payment Document Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'air_freight|ocean_freight|road_haulage|rail_freight|last_mile_delivery|port_handling');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `shipment_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` SET TAGS ('dbx_subdomain' = 'customer_invoicing');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Dispute Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `carrier_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Invoice Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `duty_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Duty Assessment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `exception_event_id` SET TAGS ('dbx_business_glossary_term' = 'Exception Event Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `freight_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Raised By Contact Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `route_delivery_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Route Delivery Zone Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `shipment_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Leg Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sla Commitment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `sla_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Entitlement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `transit_time_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Transit Time Standard Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `assigned_to_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Team');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `assigned_to_user` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `credit_note_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Rating');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_category` SET TAGS ('dbx_business_glossary_term' = 'Dispute Category');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_category` SET TAGS ('dbx_value_regex' = 'pricing|operations|documentation|compliance|service_quality|billing_error');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|under_review|escalated|resolved_accepted|resolved_rejected|partially_accepted');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_value_regex' = 'rate_dispute|weight_dispute|service_failure|duplicate_charge|unauthorized_surcharge|sla_breach_deduction');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `disputed_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Disputed Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `raised_channel` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Channel');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `raised_channel` SET TAGS ('dbx_value_regex' = 'email|phone|web_portal|edi|salesforce_case|manual_entry');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `raised_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `reason_narrative` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Narrative');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^DSP-[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_business_glossary_term' = 'Resolution Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'full_credit|partial_credit|no_credit|rate_adjustment|rebill|waiver');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `service_failure_type` SET TAGS ('dbx_business_glossary_term' = 'Service Failure Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `shipment_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `sla_target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` SET TAGS ('dbx_subdomain' = 'customer_invoicing');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `address_book_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Book Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `address_book_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `address_book_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `parent_billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Billing Account ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Schedule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Name');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|on_hold|closed|blacklisted');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'corporate|individual|government|partner');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `auto_pay_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `consolidated_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Billing Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `dunning_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Dunning Block Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `dunning_profile` SET TAGS ('dbx_business_glossary_term' = 'Dunning Profile');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `dunning_profile` SET TAGS ('dbx_value_regex' = 'standard|aggressive|gentle|vip|legal');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|edi|portal|post|fax');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `invoice_email_address` SET TAGS ('dbx_business_glossary_term' = 'Invoice Email Address');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `invoice_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `invoice_email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `invoice_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `last_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `paperless_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|credit_card|check|direct_debit');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `sap_customer_account_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Customer Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `sap_customer_account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exemption_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exemption_status` SET TAGS ('dbx_value_regex' = 'taxable|exempt|partially_exempt');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `tax_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `applicable_service_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Types');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `compound_tax_flag` SET TAGS ('dbx_business_glossary_term' = 'Compound Tax Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `exemption_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Category');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `exemption_certificate_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Exemption Certificate Required Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `hs_code_range_end` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code Range End');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `hs_code_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `hs_code_range_start` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code Range Start');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `hs_code_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `jurisdiction_state_province` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State or Province');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `jurisdiction_zone_type` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Zone Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `jurisdiction_zone_type` SET TAGS ('dbx_value_regex' = 'standard|FTZ|ICD|CFS|special_economic_zone');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `maximum_taxable_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Taxable Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `minimum_taxable_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Taxable Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Schedule Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `reverse_charge_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Reverse Charge Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `sap_tax_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Tax Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `sap_tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `sap_tax_condition_type` SET TAGS ('dbx_business_glossary_term' = 'SAP Tax Condition Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `sap_tax_condition_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Schedule Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Schedule Name');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `tax_basis` SET TAGS ('dbx_business_glossary_term' = 'Tax Basis');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `tax_basis` SET TAGS ('dbx_value_regex' = 'freight_value|declared_value|CIF_value|DDP_value|FOB_value|EXW_value');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `tax_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Category');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `tax_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Schedule Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `tax_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'VAT|GST|WHT|customs_duty|excise|service_tax');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `trade_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `withholding_tax_flag` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax (WHT) Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` SET TAGS ('dbx_subdomain' = 'payment_settlement');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `applicable_customer_segments` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Segments');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `applicable_service_lines` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Lines');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `auto_dunning_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Dunning Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `cod_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Collection Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `cod_collection_method` SET TAGS ('dbx_value_regex' = 'cash|check|card|bank_transfer|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `coupa_payment_term_code` SET TAGS ('dbx_business_glossary_term' = 'Coupa Payment Term Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `currency_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Currency Restrictions');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `default_for_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Default for Customer Segment');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `default_for_service_line` SET TAGS ('dbx_business_glossary_term' = 'Default for Service Line');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `dunning_start_days_after_due` SET TAGS ('dbx_business_glossary_term' = 'Dunning Start Days After Due Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `early_payment_discount_days` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Days');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `early_payment_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percentage');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `installment_count` SET TAGS ('dbx_business_glossary_term' = 'Installment Count');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `installment_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Installment Frequency Days');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `late_payment_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Rate');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `maximum_credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Maximum Credit Limit');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `minimum_credit_score_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Credit Score Required');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `net_days` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Days');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Description');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Name');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_approval');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `payment_term_type` SET TAGS ('dbx_value_regex' = 'standard|early_payment_discount|cash_on_delivery|prepaid|deferred|installment');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `prepayment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Required Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `requires_credit_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Requires Credit Approval Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time|deferred|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `sap_payment_term_key` SET TAGS ('dbx_business_glossary_term' = 'SAP S/4HANA Payment Term Key');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `sap_payment_term_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` SET TAGS ('dbx_subdomain' = 'customer_invoicing');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `applicable_customer_tiers` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Tiers');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `applicable_service_lines` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Lines');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Approval Required Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `approver_role_code` SET TAGS ('dbx_business_glossary_term' = 'Invoice Approver Role Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `approver_role_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `auto_invoice_generation_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Invoice Generation Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_business_glossary_term' = 'Invoice Consolidation Level');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_value_regex' = 'shipment|account|business-unit|consolidated');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Default Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Name');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|deprecated|suspended');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `dispute_resolution_sla_days` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Service Level Agreement (SLA) Days');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `dunning_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Dunning Process Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `dunning_grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Dunning Grace Period (Days)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `early_payment_discount_days` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Days');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `early_payment_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percentage');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `end_day` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle End Day');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Frequency');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `invoice_delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Lead Time (Days)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|edi|portal|mail|api');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `invoice_format` SET TAGS ('dbx_business_glossary_term' = 'Invoice Format');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `invoice_format` SET TAGS ('dbx_value_regex' = 'pdf|edi-810|xml|csv|api');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `invoice_generation_trigger` SET TAGS ('dbx_business_glossary_term' = 'Invoice Generation Trigger');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `invoice_generation_trigger` SET TAGS ('dbx_value_regex' = 'cycle-end|shipment-completion|milestone|manual|pod-confirmed|customs-cleared');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `late_payment_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Fee Percentage');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `minimum_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Invoice Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `payment_due_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Offset (Days)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'point-in-time|over-time|milestone|pod-based|customs-cleared');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `start_day` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Start Day');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `tax_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Calculation Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `tax_calculation_method` SET TAGS ('dbx_value_regex' = 'inclusive|exclusive|exempt|reverse-charge');
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` SET TAGS ('dbx_subdomain' = 'customer_invoicing');
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` ALTER COLUMN `parent_performance_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` ALTER COLUMN `sla_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sla Commitment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` ALTER COLUMN `sla_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Entitlement Id (Foreign Key)');
