-- Schema for Domain: billing | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:09

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`billing` COMMENT 'SSOT for all revenue transactions, invoicing, freight audit and payment, payment processing, and accounts receivable across all service lines. Owns customer invoices, carrier payables, COD collections, credit notes, dispute resolution, charge-back management, and revenue recognition aligned to IFRS 15. Integrates with SAP S/4HANA Finance and Coupa for end-to-end procure-to-pay and order-to-cash cycles.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique system identifier for the invoice record. Primary key. TRANSACTION_HEADER role inferred.',
    `agreement_id` BIGINT COMMENT 'Reference to the master contract or service agreement under which this invoice was generated. Links invoice to contractual terms, pricing, and SLA commitments.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Invoice should reference the billing account master (billing.account) for in-domain linking. Currently invoice only has customer_account_id pointing to customer domain. The billing.account product is ',
    `consignment_id` BIGINT COMMENT 'FK to shipment.consignment.consignment_id — MUST-HAVE: Enables billing dispute resolution by linking invoices directly to the shipment they charge for. Required for freight audit, revenue reconciliation, and customer billing inquiries.',
    `consolidated_invoice_id` BIGINT COMMENT 'Foreign key linking to billing.consolidated_invoice. Business justification: An invoice can be part of a consolidated billing document. The consolidated_invoice product has constituent_invoice_references as a STRING field, but proper normalization requires a FK on invoice poin',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account being billed. Links invoice to the party responsible for payment.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Invoice currently has payment_terms as STRING. This should be normalized to reference billing.payment_term master table. The payment_term_id FK allows joining to get code, name, net_days, discount ter',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Billing compliance and revenue assurance in logistics require tracking which employee reviewed/approved high-value freight invoices before issuance. Mandatory for dispute prevention, SOX controls, and',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Additional adjustments applied to the invoice. Includes surcharges, fuel adjustment factors (BAF), currency adjustment factors, and other miscellaneous charges or credits.',
    `amount_outstanding` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the invoice. Calculated as total_amount minus amount_paid. Used for accounts receivable reporting and collections.',
    `amount_paid` DECIMAL(18,2) COMMENT 'Total amount received from customer to date. Used to calculate outstanding balance and track partial payments.',
    `bill_to_address_line1` STRING COMMENT 'Primary street address line for the billing party. Used for invoice delivery and legal correspondence.',
    `bill_to_address_line2` STRING COMMENT 'Secondary street address line for the billing party (suite, floor, building).',
    `bill_to_city` STRING COMMENT 'City of the billing party address.',
    `bill_to_country_code` STRING COMMENT 'Three-letter ISO country code of the billing party address. Used for tax jurisdiction determination and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `bill_to_name` STRING COMMENT 'Legal name of the party being invoiced. May differ from service recipient in third-party billing scenarios.',
    `bill_to_postal_code` STRING COMMENT 'Postal or ZIP code of the billing party address.',
    `bill_to_state_province` STRING COMMENT 'State or province of the billing party address.',
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
    `charge_event_id` BIGINT COMMENT 'Foreign key linking to billing.charge_event. Business justification: Each billing invoice line item is generated from a specific charge event (billing trigger). This provides full lineage from business event to invoice line. One charge_event generates one billing_invoi',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment that this charge relates to. Enables traceability from invoice line to physical shipment.',
    `contract_rate_id` BIGINT COMMENT 'Foreign key linking to pricing.contract_rate. Business justification: Invoice lines must reference the specific contracted rate applied for audit compliance, billing dispute resolution, margin analysis, and contract performance reporting. Essential for validating that c',
    `contract_surcharge_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.contract_surcharge_schedule. Business justification: Invoice line surcharges must reference contracted surcharge schedules for revenue assurance and audit compliance. Enables validation that invoiced surcharge rates match agreement terms, critical for d',
    `hub_gateway_id` BIGINT COMMENT 'Foreign key linking to network.hub_gateway. Business justification: Charges for hub handling, storage, or gateway services must link to facility for cost center allocation and facility P&L reporting. Enables profitability analysis by hub and operational cost recovery ',
    `interline_agreement_id` BIGINT COMMENT 'Foreign key linking to network.interline_agreement. Business justification: Interline shipments generate revenue splits per agreement. Invoice lines must link to agreement for prorate calculation, partner settlement, and revenue allocation between origin and destination carri',
    `invoice_id` BIGINT COMMENT 'Reference to the parent customer invoice header that this line item belongs to.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: When shipments are booked through agents (GSA model), invoice lines must track originating agent for commission calculation and revenue sharing. Critical for agent settlement and performance tracking ',
    `performance_obligation_id` BIGINT COMMENT 'IFRS 15 performance obligation identifier linking this charge to a specific contractual promise to deliver goods or services. Used for revenue recognition compliance.',
    `surcharge_id` BIGINT COMMENT 'Foreign key linking to pricing.surcharge. Business justification: Invoice lines itemizing surcharges (fuel, security, peak season) must reference the surcharge definition for revenue recognition, customer transparency, dispute resolution, and regulatory reporting. C',
    `rate_card_id` BIGINT COMMENT 'Reference to the rate card or pricing schedule used to determine the unit rate for this charge.',
    `tariff_id` BIGINT COMMENT 'Foreign key linking to pricing.tariff. Business justification: Tariff-based pricing must be traceable from invoice lines to published tariffs for regulatory compliance (especially in international shipping), audit requirements, and dispute resolution. Mandatory f',
    `tax_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.tax_schedule. Business justification: Invoice_line currently has tax_code (STRING) and tax_rate (DECIMAL). The tax_code should be normalized to reference billing.tax_schedule master table. The tax_schedule_id FK allows joining to get sche',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: 3PL services (warehousing, distribution, last-mile) generate billable charges that must link to provider for cost reconciliation and vendor performance tracking. Supports margin analysis and 3PL spend',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Individual freight charges (line items) must reference the specific transport document for traceability. Required for freight audit, charge verification, and regulatory compliance in multi-leg shipmen',
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
    `billing_dispute_id` BIGINT COMMENT 'Reference to the customer dispute or service case that triggered this credit note. Nullable if credit was issued proactively. Links credit to dispute resolution workflow.',
    `carbon_offset_transaction_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset_transaction. Business justification: Credit notes for carbon offset refunds or adjustments must reference the original offset transaction for proper reversal, registry updates, and customer account reconciliation in green logistics progr',
    `cargo_claim_id` BIGINT COMMENT 'Reference to the cargo claim case if this credit note is issued as settlement for cargo loss, damage, or delay. Nullable for non-claim credits. Supports claims management integration.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account receiving this credit. Identifies the party to whom the credit is issued.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or system user who approved this credit note. Nullable until approval is granted. Supports audit trail and accountability requirements.',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Credit notes are issued for service failures caused by safety incidents (vehicle accidents, facility incidents, injury-related delays). Real business process: incident-driven service recovery credits.',
    `invoice_id` BIGINT COMMENT 'Reference to the original invoice being credited or adjusted. Links this credit note to the source billing document.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Credit notes trigger revenue reversals requiring GL posting. Finance needs to trace journal entries back to originating credit note for IFRS 15 revenue recognition adjustments, period close validation',
    `route_exception_id` BIGINT COMMENT 'Foreign key linking to route.route_exception. Business justification: Credit notes are issued for service failures documented as route exceptions. Finance needs the exception reference to justify the credit amount, validate SLA breach, and track service quality costs. S',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Credit notes issued for service failures, damage claims, or billing errors must reference the original transport document as proof of the disputed shipment. Critical for cargo claim processing and dis',
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
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account making the payment. Links payment to the payer.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this payment for processing. Used for authorization audit and segregation of duties compliance.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice against which this payment is applied. Links payment to the billing document.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Customer payments generate GL cash and AR clearing entries. Finance reconciliation and audit trails require linking payment transactions to the journal entries that recorded their accounting impact fo',
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
    `payer_name` STRING COMMENT 'Name of the party making the payment as provided in the payment transaction. May differ from the customer account name for third-party payments.',
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
    `terms_code` STRING COMMENT 'Code representing the payment terms applicable to this transaction. Used for discount calculation and aging analysis.',
    `unapplied_balance` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has not yet been applied to any invoice. Represents customer credit or overpayment requiring manual review.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Tax amount withheld by the customer at source as per local tax regulations. Reduces the net payment received.',
    `withholding_tax_certificate_reference` STRING COMMENT 'Reference to the tax withholding certificate provided by the customer. Required for tax compliance and audit.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Record of customer payment received against outstanding invoices. Captures payment reference number, payment date, payment method (bank transfer, cheque, credit card, direct debit, COD collection, letter of credit), payment amount, currency, exchange rate, bank account reference, payment channel (online portal, EDI, manual, bank file), clearing status (uncleared, partially_cleared, fully_cleared), SAP S/4HANA clearing document reference, remittance advice reference, and any unapplied balance. SSOT for all inbound cash receipts in the order-to-cash cycle.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` (
    `payment_allocation_id` BIGINT COMMENT 'Unique identifier for the payment allocation record. Primary key.',
    `bank_statement_line_id` BIGINT COMMENT 'Unique identifier from the bank statement or electronic bank file (MT940, BAI2, CAMT.053) linking this allocation to the source payment.',
    `credit_note_id` BIGINT COMMENT 'Reference to credit note applied in this allocation. Nullable when allocation is against invoice only.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for which this payment allocation is recorded. Enables customer-level AR reconciliation.',
    `debit_note_id` BIGINT COMMENT 'Reference to debit note being settled in this allocation. Nullable when not applicable.',
    `invoice_id` BIGINT COMMENT 'Reference to the customer invoice being settled by this allocation. Primary open item being cleared.',
    `payment_id` BIGINT COMMENT 'Reference to the customer payment transaction being allocated. Links to the payment header record.',
    `employee_id` BIGINT COMMENT 'System user ID of the person or automated process that created the allocation. Supports audit trail and accountability.',
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
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Receivable tracks AR balance by customer account. Should reference billing.account for in-domain linking to billing account master. Currently only has customer_account_id to customer domain. The billi',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that owes this receivable balance.',
    `aging_bucket` STRING COMMENT 'Classification of the receivable based on days outstanding: current (0 days), 1-30 days, 31-60 days, 61-90 days, or over 90 days past due.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `ar_balance_amount` DECIMAL(18,2) COMMENT 'Total outstanding amount owed by the customer at the snapshot date.',
    `bad_debt_provision_amount` DECIMAL(18,2) COMMENT 'Amount reserved as provision for potential bad debt based on credit risk assessment and aging analysis.',
    `business_area` STRING COMMENT 'Business area or division to which this receivable is attributed for internal reporting and profitability analysis.',
    `collection_agency_name` STRING COMMENT 'Name of the external collection agency handling the receivable, if referred.',
    `collection_agency_referral_flag` BOOLEAN COMMENT 'Indicates whether the receivable has been referred to an external collection agency (True) or not (False).',
    `collection_referral_date` DATE COMMENT 'Date when the receivable was referred to the external collection agency.',
    `company_code` STRING COMMENT 'Company code representing the legal entity that owns this receivable in the SAP S/4HANA Finance system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this receivable balance record was first created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount approved for the customer account.',
    `credit_risk_rating` STRING COMMENT 'Internal or external credit rating assigned to the customer based on creditworthiness assessment. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D — 10 candidates stripped; promote to reference product]',
    `credit_utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of the credit limit currently utilized by the outstanding AR balance, calculated as (AR balance / credit limit) * 100.',
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
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the customer (e.g., Net 30, Net 60, 2/10 Net 30).',
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
    `carrier_payable_id` BIGINT COMMENT 'Reference to the carrier payable record that will be created or updated based on this audit outcome. Links to the Freight Audit and Payment (FAP) process for payment release.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Audit process validates invoiced service codes against contracted carrier service definitions. Critical for verifying rate correctness, transit time compliance, and resolving service-level disputes be',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Freight audit validates carrier invoices against actual shipment execution data. Auditors compare contracted rates, weights, and service levels from the consignment to detect billing errors and captur',
    `employee_id` BIGINT COMMENT 'Identifier of the freight audit specialist or system user who performed or is performing this audit.',
    `lane_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.lane_commitment. Business justification: Freight audit validates carrier invoices against lane-specific contracted rates and capacity commitments. Direct link enables automated audit to verify lane pricing, capacity utilization vs. commitmen',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Freight auditors validate carrier invoices against contracted lane rates. Auditors need lane_id to retrieve contracted pricing, transit times, and service levels for variance analysis. Standard pre-pa',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Freight audit validates carrier charges against PO terms for procured services. Essential for rate verification, variance analysis, and identifying overbilling on contracted transportation purchases.',
    `shipment_carbon_footprint_id` BIGINT COMMENT 'Foreign key linking to sustainability.shipment_carbon_footprint. Business justification: Freight audits validate not only cost accuracy but also carbon calculation accuracy for green logistics contracts. Essential for compliance audits, customer carbon reporting validation, and sustainabi',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Links audit findings to supplier master for performance tracking, dispute history, and vendor scorecard updates. Critical for identifying chronic billing issues and supporting supplier review meetings',
    `tariff_rate_id` BIGINT COMMENT 'Identifier of the specific tariff rate record from the pricing domain used to validate the contracted rate in this audit.',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: 3PL invoices require audit against contracted rates for warehousing, handling, and distribution services. Linking to provider enables rate validation, dispute resolution, and savings capture on 3PL sp',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Freight audits verify carrier invoices against actual transport documents issued. The transport document is the source of truth for weight, dimensions, routing, and service level - essential for audit',
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
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Carrier payables are source documents for AP ledger entries. Finance payment processing, vendor reconciliation, and three-way matching (carrier invoice vs. shipment vs. AP) require linking operational',
    `carrier_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.carrier_agreement. Business justification: Carrier payables must be validated against carrier agreement terms (rates, surcharges, payment terms) during AP processing and freight audit. Direct link enables automated 3-way match (PO/agreement/in',
    `carrier_id` BIGINT COMMENT 'Identifier of the carrier, subcontractor, or transport partner to whom payment is owed.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Payables must reconcile to specific carrier service agreements for accrual accuracy and cost allocation by service type. Enables spend analysis by service tier and variance tracking against contracted',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Carrier_payable currently has payment_terms as STRING. This should be normalized to reference billing.payment_term master table. The payment_term_id FK allows joining to get code, name, net_days, etc.',
    `supplier_emissions_disclosure_id` BIGINT COMMENT 'Foreign key linking to sustainability.supplier_emissions_disclosure. Business justification: Carrier payables must reference carrier emissions disclosures for Scope 3 emissions allocation, supplier sustainability performance tracking, and carbon accounting. Critical for accurate GHG inventory',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Carriers are suppliers in logistics. Links payable to supplier master for vendor management, payment terms, tax registration, and AP processing. Essential for three-way matching and supplier performan',
    `surveyor_id` BIGINT COMMENT 'Foreign key linking to claim.surveyor. Business justification: Surveyors invoice carriers for cargo survey services. Real business process: surveyor completes survey, submits invoice, AP processes carrier_payable. Links survey vendor billing to surveyor master da',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`cod_collection` (
    `cod_collection_id` BIGINT COMMENT 'Primary key for cod_collection',
    `bank_statement_line_id` BIGINT COMMENT 'Foreign key linking to finance.bank_statement_line. Business justification: COD collections are deposited and appear as bank statement transactions. Finance daily cash reconciliation requires matching bank statement lines to COD collection records to verify deposits, track re',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: COD collections should link to the billing account for proper financial tracking, reconciliation, and reporting. The billing_account defines the billing relationship and financial terms. One billing_a',
    `agent_id` BIGINT COMMENT 'Reference to the delivery driver or agent who collected the COD payment from the consignee.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment for which COD payment was collected.',
    `customer_account_id` BIGINT COMMENT 'Reference to the shipper customer account on whose behalf the COD amount is being collected.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system that last modified the COD collection record.',
    `awb_number` STRING COMMENT 'The air waybill number associated with the shipment for which COD was collected.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `bank_deposit_date` DATE COMMENT 'The date on which the collected COD cash was deposited into the carriers bank account.',
    `bank_deposit_reference` STRING COMMENT 'Reference number for the bank deposit transaction when the collected COD cash is deposited into the carriers account.',
    `cod_reference_number` STRING COMMENT 'Unique business identifier for the COD collection transaction, used for tracking and reconciliation.. Valid values are `^COD[0-9]{10,15}$`',
    `collected_amount` DECIMAL(18,2) COMMENT 'The actual amount collected from the consignee at the point of delivery.',
    `collection_date` DATE COMMENT 'The date on which the COD payment was collected from the consignee.',
    `collection_location_code` STRING COMMENT 'Code identifying the delivery location or service center where the COD collection occurred.. Valid values are `^[A-Z0-9]{3,10}$`',
    `collection_method` STRING COMMENT 'The payment instrument used by the consignee to settle the COD amount (cash, cheque, card, mobile payment, bank transfer).. Valid values are `cash|cheque|credit_card|debit_card|mobile_payment|bank_transfer`',
    `collection_timestamp` TIMESTAMP COMMENT 'The precise date and time when the COD payment was collected from the consignee.',
    `consignee_contact_number` STRING COMMENT 'Phone number of the consignee who made the COD payment.',
    `consignee_name` STRING COMMENT 'Full name of the consignee from whom the COD payment was collected at delivery.',
    `cost_center_code` STRING COMMENT 'The cost center responsible for the COD collection activity.. Valid values are `^[A-Z0-9]{4,10}$`',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the COD collection occurred.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the COD collection record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the COD transaction (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `declared_cod_amount` DECIMAL(18,2) COMMENT 'The COD amount declared by the shipper to be collected from the consignee at the time of delivery.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the COD collection is under dispute by the shipper or consignee.',
    `dispute_reason` STRING COMMENT 'Description of the reason for any dispute related to the COD collection.',
    `dispute_resolution_date` DATE COMMENT 'The date on which any dispute related to the COD collection was resolved.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which the COD collection transaction is posted for financial reporting.. Valid values are `^[0-9]{4,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the COD collection record was last updated.',
    `net_remittance_amount` DECIMAL(18,2) COMMENT 'The net amount remitted to the shipper after deducting service charges and adjusting for any variances.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the COD collection transaction.',
    `operating_unit_code` STRING COMMENT 'Code identifying the operating unit or business division responsible for the COD collection.. Valid values are `^[A-Z0-9]{3,10}$`',
    `payment_receipt_number` STRING COMMENT 'Receipt number issued to the consignee as proof of COD payment.',
    `reconciliation_date` DATE COMMENT 'The date on which the COD collection was reconciled with financial records.',
    `reconciliation_status` STRING COMMENT 'Status of the reconciliation process between collected COD amounts and financial records.. Valid values are `pending|reconciled|discrepancy|under_review`',
    `remittance_date` DATE COMMENT 'The date on which the collected COD amount was remitted to the shipper.',
    `remittance_reference_number` STRING COMMENT 'Reference number for the remittance transaction when the COD amount is transferred to the shipper.',
    `remittance_status` STRING COMMENT 'Current status of the COD collection and remittance process (collected, remitted to shipper, pending remittance, failed collection, partial collection, disputed).. Valid values are `collected|remitted_to_shipper|pending_remittance|failed_collection|partial_collection|disputed`',
    `service_charge_amount` DECIMAL(18,2) COMMENT 'The COD service fee charged by the carrier for providing cash collection service, deducted from the remittance to the shipper.',
    `service_charge_percentage` DECIMAL(18,2) COMMENT 'The percentage rate applied to calculate the COD service charge.',
    `service_line` STRING COMMENT 'The business service line under which the COD collection was performed (express parcel, freight, e-commerce fulfillment, last-mile delivery).. Valid values are `express_parcel|freight|ecommerce_fulfillment|last_mile`',
    `variance_amount` DECIMAL(18,2) COMMENT 'The difference between the declared COD amount and the actual collected amount (positive for overage, negative for shortfall).',
    `variance_notes` STRING COMMENT 'Free-text notes explaining the circumstances of any variance in the COD collection.',
    `variance_reason_code` STRING COMMENT 'Code indicating the reason for any variance between declared and collected COD amounts.. Valid values are `consignee_refused|partial_payment|incorrect_amount|currency_shortage|payment_dispute|other`',
    CONSTRAINT pk_cod_collection PRIMARY KEY(`cod_collection_id`)
) COMMENT 'Cash on Delivery (COD) collection record tracking the collection of payment from consignees at the point of delivery on behalf of shippers. Captures COD reference number, shipment/AWB reference, declared COD amount, currency, collection method (cash, cheque, card), actual collected amount, collection date, collection agent identity, remittance status (collected, remitted_to_shipper, pending_remittance, failed_collection, partial_collection), remittance date, and any shortfall or overage amount. Critical for e-commerce fulfillment and last-mile delivery operations.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` (
    `billing_dispute_id` BIGINT COMMENT 'Unique identifier for the billing dispute record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier involved in the disputed shipment. Used when the dispute involves carrier performance or carrier invoice discrepancies.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Disputes often challenge service level delivered vs. invoiced (e.g., charged for express but delivered standard). Linking to carrier_service enables root cause analysis, SLA breach validation, and res',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Billing disputes frequently stem from shipment service failures (late delivery, damage, incorrect service level). Dispute investigators require direct access to consignment execution details, tracking',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that raised the dispute. Identifies the party challenging the invoice accuracy.',
    `invoice_id` BIGINT COMMENT 'Reference to the customer invoice being disputed. Links to the invoice that contains the disputed charges.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Billing disputes involving credit notes or write-offs require supervisor/manager approval beyond the assigned handler (existing assigned_to_user field). Financial controls mandate tracking who authori',
    `route_exception_id` BIGINT COMMENT 'Foreign key linking to route.route_exception. Business justification: Customer billing disputes are triggered by route exceptions (delays, missed SLA, service failures). Dispute resolution teams need the exception record to validate customer claims and determine credit ',
    `shipment_carbon_footprint_id` BIGINT COMMENT 'Foreign key linking to sustainability.shipment_carbon_footprint. Business justification: Billing disputes may challenge carbon calculations, green surcharges, or sustainability claims. Links the dispute to the underlying carbon data for investigation, resolution, and audit trail in carbon',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Billing disputes often involve carrier (supplier) errors—incorrect rates, unauthorized charges, service failures. Links dispute to supplier for vendor performance tracking, escalation workflow, and ro',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Billing disputes cite the transport document as evidence for weight discrepancies, service level failures, or routing errors. The transport document is the legal proof of carriage terms and actual ser',
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
    `raised_by` STRING COMMENT 'Name or identifier of the person or system that raised the dispute. May be customer contact name, internal user ID, or automated system identifier.',
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
    CONSTRAINT pk_billing_dispute PRIMARY KEY(`billing_dispute_id`)
) COMMENT 'Formal dispute record raised by customers or internal teams challenging the accuracy of an invoice, charge, or freight audit finding. Captures dispute reference number, dispute type (rate dispute, weight dispute, service failure, duplicate charge, unauthorized surcharge, SLA breach deduction, customs duty dispute), disputed invoice reference, disputed amount, dispute reason narrative, dispute status (open, under_review, escalated, resolved_accepted, resolved_rejected, partially_accepted, withdrawn), resolution type, resolution amount, resolution date, responsible team, SLA breach flag, and credit note issued reference. Supports chargeback management and customer satisfaction.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` (
    `revenue_recognition_id` BIGINT COMMENT 'Unique identifier for the revenue recognition record. Primary key for this entity.',
    `agreement_id` BIGINT COMMENT 'Reference to the logistics service contract under which this revenue is recognized.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for which this revenue is recognized. Links revenue to the customer master for customer profitability analysis and accounts receivable reconciliation.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Revenue_recognition currently has invoice_number (STRING). This should be normalized to invoice_id FK to billing.invoice. Revenue recognition events are triggered by invoicing and should reference the',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Revenue recognition events under IFRS 15 drive GL postings from deferred revenue to recognized revenue. Finance audit trails and period close procedures require linking recognition events to the journ',
    `lane_performance_id` BIGINT COMMENT 'Foreign key linking to route.lane_performance. Business justification: IFRS 15 revenue recognition depends on performance obligation satisfaction. Lane performance metrics (OTD, OTIF, service completion) determine recognition timing. Finance needs lane_performance_id to ',
    `original_recognition_revenue_recognition_id` BIGINT COMMENT 'For reversal or adjustment entries, reference to the original revenue recognition record being reversed or adjusted. Maintains audit trail for revenue corrections.',
    `performance_obligation_id` BIGINT COMMENT 'Unique identifier for the specific performance obligation within the contract to which this revenue recognition event applies. Aligns with IFRS 15 performance obligation tracking.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Revenue recognition in logistics is triggered by transport document issuance or delivery completion per IFRS 15 performance obligations. The transport document evidences the point of service transfer ',
    `accounting_period` STRING COMMENT 'The fiscal accounting period (YYYY-MM format) to which this revenue recognition is posted. Used for period-end reporting and revenue reconciliation.. Valid values are `^d{4}-(0[1-9]|1[0-2])$`',
    `approval_date` DATE COMMENT 'The date when this revenue recognition entry was approved by the finance team. Supports audit trail and internal controls for revenue recognition.',
    `approved_by` STRING COMMENT 'The user ID or name of the finance team member who approved this revenue recognition entry. Supports internal controls and SOX compliance for revenue recognition.',
    `awb_number` STRING COMMENT 'Air Waybill number for air freight shipments associated with this revenue recognition. Provides operational traceability for air freight revenue.',
    `bol_number` STRING COMMENT 'Bill of Lading number for ocean, road, or rail freight shipments associated with this revenue recognition. Provides operational traceability for freight revenue.',
    `business_area` STRING COMMENT 'The business area or division within Transport Shipping to which this revenue is attributed (e.g., Express, Freight, Supply Chain). Supports segment reporting under IFRS 8.',
    `company_code` STRING COMMENT 'The legal entity or company code within the Transport Shipping group that is recognizing this revenue. Used for statutory reporting and consolidation.',
    `contract_modification_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition reflects a contract modification that changed the scope or price of the performance obligation. Used to track revenue adjustments from contract changes.',
    `cost_center_code` STRING COMMENT 'The cost center or profit center code responsible for this revenue. Used for internal management accounting, profitability analysis, and operational performance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this revenue recognition record was first created in the system. Supports audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this revenue recognition record.. Valid values are `^[A-Z]{3}$`',
    `deferred_revenue_amount` DECIMAL(18,2) COMMENT 'The remaining unrecognized revenue amount for this performance obligation after this recognition event. Represents the contract liability balance that will be recognized in future periods.',
    `destination_location_code` STRING COMMENT 'The destination location code for shipment-based revenue recognition. Supports geographic revenue analysis and regional profitability reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this revenue recognition belongs. Supports annual financial reporting and year-over-year revenue analysis.',
    `gl_revenue_account` STRING COMMENT 'The general ledger account code to which this recognized revenue is posted. Maps to the chart of accounts in SAP S/4HANA Finance for revenue classification and reporting.',
    `ifrs15_compliance_flag` BOOLEAN COMMENT 'Indicates whether this revenue recognition record has been validated for compliance with IFRS 15 revenue recognition principles. True indicates the record has passed all compliance checks.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context for this revenue recognition event. May include explanations for adjustments, special circumstances, or audit documentation.',
    `origin_location_code` STRING COMMENT 'The origin location code for shipment-based revenue recognition. Supports geographic revenue analysis and regional profitability reporting.',
    `progress_measurement_method` STRING COMMENT 'For over-time revenue recognition, the method used to measure progress toward complete satisfaction of the performance obligation. Examples include output methods (units delivered, milestones achieved) or input methods (costs incurred, time elapsed).. Valid values are `output_method|input_method|time_elapsed|costs_incurred|units_delivered`',
    `progress_percentage` DECIMAL(18,2) COMMENT 'For over-time revenue recognition, the cumulative percentage of the performance obligation that has been satisfied as of this recognition event. Used to calculate the cumulative revenue to be recognized.',
    `recognition_date` DATE COMMENT 'The date on which revenue was recognized for this performance obligation. This is the accounting date when the revenue was recorded in the general ledger.',
    `recognition_event_reference` STRING COMMENT 'Business reference number or code identifying the specific event that triggered this revenue recognition (e.g., shipment delivery, milestone completion, period-end accrual).',
    `recognition_method` STRING COMMENT 'Method by which revenue is recognized for this performance obligation. Point-in-time recognition occurs at a specific moment when control transfers (e.g., POD). Over-time recognition occurs progressively as the service is performed (e.g., warehousing, contract logistics).. Valid values are `point_in_time|over_time`',
    `recognition_trigger` STRING COMMENT 'The specific business event or condition that triggered this revenue recognition. Examples include Proof of Delivery (POD), contract milestone achievement, accounting period-end accrual, or service completion. [ENUM-REF-CANDIDATE: pod|milestone|period_end|service_completion|shipment_departure|customs_clearance|contract_inception — 7 candidates stripped; promote to reference product]',
    `recognized_amount` DECIMAL(18,2) COMMENT 'The actual revenue amount recognized in this event. For point-in-time recognition, this equals the allocated transaction price. For over-time recognition, this represents the incremental amount recognized in this period based on progress measurement.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this record represents a reversal or adjustment of previously recognized revenue. True for reversal entries, false for original recognition entries.',
    `reversal_reason` STRING COMMENT 'Business reason for reversing or adjusting previously recognized revenue. Examples include service cancellation, contract termination, billing dispute, or accounting error correction.',
    `sap_revenue_document_number` STRING COMMENT 'The document number generated by SAP S/4HANA Finance for this revenue recognition posting. Provides traceability to the source financial system and supports audit trails.',
    `service_end_date` DATE COMMENT 'The date when the service delivery or performance obligation was completed or is expected to be completed. Used for over-time revenue recognition to determine the service period.',
    `service_start_date` DATE COMMENT 'The date when the service delivery or performance obligation began. Used for over-time revenue recognition to determine the service period.',
    `service_type` STRING COMMENT 'Type of logistics service for which revenue is being recognized. Categorizes the revenue stream by operational service line. [ENUM-REF-CANDIDATE: express_parcel|air_freight|ocean_freight|road_freight|rail_freight|warehousing|customs_brokerage|last_mile_delivery|ecommerce_fulfillment|contract_logistics|supply_chain_management — 11 candidates stripped; promote to reference product]',
    `shipment_reference` STRING COMMENT 'Reference to the shipment, consignment, or service delivery associated with this revenue recognition event. Links revenue to operational execution for reconciliation and dispute resolution.',
    `transaction_price_allocated` DECIMAL(18,2) COMMENT 'The portion of the total contract transaction price allocated to this specific performance obligation under IFRS 15 allocation rules. Represents the amount expected to be recognized as revenue when the obligation is satisfied.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this revenue recognition record was last modified. Supports audit trail and change tracking for revenue adjustments.',
    `variable_consideration_amount` DECIMAL(18,2) COMMENT 'The estimated amount of variable consideration included in the transaction price for this performance obligation. Subject to constraint requirements under IFRS 15 to prevent revenue reversal.',
    `variable_consideration_flag` BOOLEAN COMMENT 'Indicates whether this performance obligation includes variable consideration (e.g., volume discounts, performance bonuses, penalties) that requires constraint estimation under IFRS 15.',
    CONSTRAINT pk_revenue_recognition PRIMARY KEY(`revenue_recognition_id`)
) COMMENT 'IFRS 15 revenue recognition record tracking the allocation and timing of revenue recognition for logistics service contracts. Captures recognition event reference, contract performance obligation identifier, service type, transaction price allocated to obligation, recognition method (point-in-time vs over-time), recognition trigger (POD, milestone, period-end), recognized amount, deferred revenue amount, recognition date, accounting period, GL revenue account, cost center, SAP S/4HANA revenue recognition document reference, and IFRS 15 compliance flag. Ensures revenue is recognized when (or as) performance obligations are satisfied.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`billing_account` (
    `billing_account_id` BIGINT COMMENT 'Unique identifier for the billing account. Primary key for the billing account entity.',
    `created_by_user_employee_id` BIGINT COMMENT 'User identifier of the person or system process that created this billing account record. Used for audit trail and accountability.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer entity that owns this billing account. Links to the customer master record in the customer domain.',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.billing_cycle. Business justification: Account currently has billing_cycle as STRING. This should be normalized to reference billing.billing_cycle master table. The billing_cycle_id FK allows joining to get cycle configuration (frequency, ',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for managing this billing account relationship, typically a sales or customer success manager for strategic accounts.',
    `parent_billing_account_id` BIGINT COMMENT 'Reference to the parent billing account if this account is part of a hierarchical billing structure. Used for consolidated invoicing and corporate account management.',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Account currently has payment_terms as STRING. This should be normalized to reference billing.payment_term master table. The payment_term_id FK allows joining to get code, name, net_days, discount ter',
    `updated_by_user_employee_id` BIGINT COMMENT 'User identifier of the person or system process that last modified this billing account record. Used for audit trail and change management.',
    `account_name` STRING COMMENT 'Descriptive name for the billing account, typically reflecting the customer legal entity or division name for this billing relationship.',
    `account_number` STRING COMMENT 'Externally visible unique billing account number used in invoices, statements, and customer communications. This is the business identifier for the billing relationship.. Valid values are `^[A-Z0-9]{8,20}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the billing account. Active accounts can transact and be invoiced. Suspended accounts have temporary restrictions due to payment issues. On-hold accounts are pending review. Closed accounts are terminated. Blacklisted accounts are permanently blocked due to fraud or severe non-compliance.. Valid values are `active|suspended|on_hold|closed|blacklisted`',
    `account_type` STRING COMMENT 'Classification of the billing account based on customer segment and billing complexity. Corporate accounts typically have negotiated terms, individual accounts are retail customers, government accounts follow public sector procurement rules, and partner accounts are for strategic alliances.. Valid values are `corporate|individual|government|partner`',
    `auto_pay_enabled_flag` BOOLEAN COMMENT 'Indicates whether automatic payment processing is enabled for this account. When true, invoices are automatically charged to the preferred payment method on the due date.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address where invoices and statements are sent. Typically contains street number and street name.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address for additional address details such as suite, floor, building, or department name.',
    `billing_city` STRING COMMENT 'City or municipality name for the billing address.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address. Determines tax jurisdiction and regulatory compliance requirements.. Valid values are `^[A-Z]{3}$`',
    `billing_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which this account is billed. All invoices and payments for this account are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal code or ZIP code for the billing address. Format varies by country.',
    `billing_state_province` STRING COMMENT 'State, province, or region code for the billing address. Format varies by country (e.g., two-letter US state codes, Canadian province codes).',
    `business_area_code` STRING COMMENT 'SAP business area code representing the service line or division (e.g., express parcel, freight forwarding, contract logistics) for internal P&L (Profit and Loss) reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity within Transport Shipping that owns this billing relationship. Used for financial consolidation and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidated_billing_flag` BOOLEAN COMMENT 'Indicates whether this account participates in consolidated billing where multiple accounts or locations are invoiced together under a master account.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing account record was first created in the system. Used for audit trail and data lineage.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum outstanding receivable balance allowed for this billing account before credit hold is triggered. Expressed in the billing currency. Zero or null indicates no credit extended (prepay only).',
    `credit_review_date` DATE COMMENT 'Date of the most recent credit review for this account. Credit reviews are performed periodically to assess credit limit adequacy and risk exposure.',
    `credit_status` STRING COMMENT 'Current credit approval status for this billing account. Approved accounts have active credit lines. Pending accounts are under credit review. Suspended accounts have temporary credit holds. Revoked accounts have lost credit privileges and must prepay.. Valid values are `approved|pending|suspended|revoked`',
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
    `tax_account_id` BIGINT COMMENT 'Foreign key linking to finance.tax_account. Business justification: Tax schedules define rates and jurisdictions that map to specific GL tax accounts. Finance tax reporting, VAT returns, and customs duty filings require linking tax accounts to the billing tax schedule',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`dunning_record` (
    `dunning_record_id` BIGINT COMMENT 'Unique identifier for the dunning and collections activity record.',
    `billing_account_id` BIGINT COMMENT 'Reference to the customer billing account subject to dunning activity.',
    `billing_dispute_id` BIGINT COMMENT 'Reference to the dispute case if the customer raised a dispute in response to the dunning notice.',
    `employee_id` BIGINT COMMENT 'Reference to the internal collections specialist or team member assigned to this dunning case.',
    `plan_id` BIGINT COMMENT 'Reference to a payment plan arrangement established as a result of this dunning action.',
    `receivable_id` BIGINT COMMENT 'Foreign key linking to billing.receivable. Business justification: Dunning activities are collections follow-up for overdue receivables. Each dunning record targets a specific receivable balance for a customer. One receivable can have multiple dunning records as esca',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Dunning communications are sent to specific customer contacts. Tracking the recipient contact enables follow-up, communication history tracking, and escalation workflows. Removes denormalized recipien',
    `business_unit` STRING COMMENT 'Business unit or division responsible for this dunning activity.',
    `collections_agency_name` STRING COMMENT 'Name of the external collections agency to which the account was referred.',
    `collections_agency_referral_flag` BOOLEAN COMMENT 'Indicates whether the overdue account has been referred to an external collections agency.',
    `collections_referral_date` DATE COMMENT 'Date when the account was referred to the external collections agency.',
    `communication_channel` STRING COMMENT 'Channel through which the dunning notice was communicated to the customer.. Valid values are `email|letter|phone|sms|edi|portal`',
    `communication_sent_timestamp` TIMESTAMP COMMENT 'Precise date and time when the dunning communication was sent to the customer.',
    `company_code` STRING COMMENT 'Legal entity or company code within the enterprise responsible for this dunning action.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this dunning record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the overdue amount.. Valid values are `^[A-Z]{3}$`',
    `customer_response_type` STRING COMMENT 'Classification of the customers response to the dunning notice.. Valid values are `payment_promise|dispute_raised|payment_plan_request|no_response|partial_payment|full_payment`',
    `days_past_due` STRING COMMENT 'Number of days the oldest invoice has been overdue at the time of dunning action.',
    `dunning_date` DATE COMMENT 'Date when the dunning action was initiated or the reminder was sent to the customer.',
    `dunning_fee_amount` DECIMAL(18,2) COMMENT 'Additional fee charged to the customer for the dunning and collection activity.',
    `dunning_level` STRING COMMENT 'Escalation level of the dunning process indicating the severity and stage of collection activity.. Valid values are `first_reminder|second_reminder|final_notice|legal_notice|collections_referral|write_off_review`',
    `dunning_reference_number` STRING COMMENT 'Externally-known unique reference number for this dunning action, used for tracking and customer communication.',
    `dunning_status` STRING COMMENT 'Current lifecycle status of the dunning record indicating the state of the collection activity.. Valid values are `pending|sent|acknowledged|resolved|escalated|closed`',
    `escalation_date` DATE COMMENT 'Date when the dunning case was escalated to the next level or external collections.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this dunning record has been escalated to a higher collection level or external agency.',
    `gl_account_code` STRING COMMENT 'General ledger account code for tracking dunning-related financial activity.',
    `interest_charge_amount` DECIMAL(18,2) COMMENT 'Late payment interest charges applied to the overdue amount.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, customer interactions, or special circumstances related to this dunning action.',
    `oldest_invoice_date` DATE COMMENT 'Date of the oldest unpaid invoice included in this dunning action, used to calculate aging.',
    `promised_payment_amount` DECIMAL(18,2) COMMENT 'Amount the customer has committed to pay in response to the dunning notice.',
    `promised_payment_date` DATE COMMENT 'Date by which the customer has committed to make payment.',
    `response_date` DATE COMMENT 'Date when the customer responded to the dunning notice.',
    `response_received_flag` BOOLEAN COMMENT 'Indicates whether the customer has responded to the dunning notice.',
    `sap_dunning_run_reference` STRING COMMENT 'Reference to the SAP S/4HANA Finance dunning run that generated this dunning record.',
    `service_line` STRING COMMENT 'Primary service line associated with the overdue invoices in this dunning action. [ENUM-REF-CANDIDATE: express_parcel|air_freight|ocean_freight|road_freight|rail_freight|warehousing|ecommerce_fulfillment|contract_logistics — 8 candidates stripped; promote to reference product]',
    `total_overdue_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all overdue invoices included in this dunning action.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this dunning record was last modified.',
    `write_off_recommendation_date` DATE COMMENT 'Date when the write-off recommendation was made for this overdue account.',
    `write_off_recommendation_flag` BOOLEAN COMMENT 'Indicates whether this dunning record has been flagged for potential bad debt write-off.',
    CONSTRAINT pk_dunning_record PRIMARY KEY(`dunning_record_id`)
) COMMENT 'Dunning and collections activity record tracking the systematic follow-up process for overdue customer invoices. Captures dunning reference, billing account reference, overdue invoice references, total overdue amount, dunning level (1st reminder, 2nd reminder, final notice, legal notice, collections referral), dunning date, communication channel (email, letter, phone, EDI), response received flag, customer response type (payment promise, dispute raised, no response), promised payment date, promised payment amount, escalation flag, collections agency referral date, and write-off recommendation flag. Supports DSO reduction and bad debt management.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`write_off` (
    `write_off_id` BIGINT COMMENT 'Unique identifier for the bad debt write-off record. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Write_off should reference billing.account for in-domain linking. Currently only has customer_account_id to customer domain. Write-offs are managed within billing account context (bad debt tracking, c',
    `billing_dispute_id` BIGINT COMMENT 'Reference to any related billing dispute case that led to or influenced the write-off decision.',
    `customer_account_id` BIGINT COMMENT 'Reference to the billing account for which the receivable is being written off.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or user who approved the write-off transaction.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Write-offs require GL posting to bad debt expense and AR clearing accounts. Finance must link write-off authorization to the journal entry for SOX control testing, provision release tracking, and fina',
    `receivable_id` BIGINT COMMENT 'Foreign key linking to billing.receivable. Business justification: A write-off formally writes off an uncollectable receivable balance. The write-off directly impacts a specific receivable record. One receivable can have multiple partial write-offs over time. No bidi',
    `amount` DECIMAL(18,2) COMMENT 'Total gross amount of the receivable balance being written off before any adjustments.',
    `approval_authority` STRING COMMENT 'Name or title of the authorized individual or committee who approved the write-off decision per delegation of authority policy.',
    `approval_date` DATE COMMENT 'Date on which the write-off was formally approved by the authorized approver.',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise date and time when the write-off approval was recorded in the system.',
    `bad_debt_provision_release_amount` DECIMAL(18,2) COMMENT 'Amount of previously established bad debt provision or allowance for doubtful accounts that is released as a result of this write-off.',
    `base_currency_amount` DECIMAL(18,2) COMMENT 'Write-off amount converted to the organizations base reporting currency using the applicable exchange rate.',
    `business_area` STRING COMMENT 'Business area or segment code for internal management reporting and profitability analysis.',
    `collection_agency_name` STRING COMMENT 'Name of the third-party collection agency to which the account has been referred for recovery efforts.',
    `collection_agency_referral_flag` BOOLEAN COMMENT 'Indicates whether the account has been referred to an external collection agency for recovery attempts post-write-off.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity under which this write-off is recorded for statutory reporting.',
    `cost_center_code` STRING COMMENT 'Cost center to which the write-off expense is allocated for internal cost accounting and budgeting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the write-off record was first created in the system for audit trail purposes.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the write-off amount is denominated.. Valid values are `^[A-Z]{3}$`',
    `days_outstanding` STRING COMMENT 'Number of days between the original invoice date and the write-off decision date, representing the aging of the receivable.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert the write-off amount to the base reporting currency at the time of write-off.',
    `gl_posting_date` DATE COMMENT 'Accounting period date when the write-off transaction is posted to the general ledger for financial reporting purposes.',
    `gl_provision_account` STRING COMMENT 'General ledger account code for the bad debt provision or allowance account that is reduced by this write-off.',
    `gl_write_off_account` STRING COMMENT 'General ledger account code to which the write-off expense or bad debt charge is posted.',
    `insolvency_case_reference` STRING COMMENT 'Reference number of the customers bankruptcy or insolvency proceeding if the write-off is due to customer insolvency.',
    `invoice_references` STRING COMMENT 'Comma-separated list of invoice numbers or identifiers that are included in this write-off transaction.',
    `legal_action_flag` BOOLEAN COMMENT 'Indicates whether legal proceedings have been initiated or are planned to recover the written-off amount.',
    `modified_by` STRING COMMENT 'User ID or name of the individual who last modified the write-off record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the write-off record was last updated in the system for audit trail purposes.',
    `net_write_off_impact` DECIMAL(18,2) COMMENT 'Net impact on profit and loss after deducting the bad debt provision release from the gross write-off amount.',
    `notes` STRING COMMENT 'Additional free-text comments or supporting documentation references related to the write-off decision and approval process.',
    `original_invoice_date` DATE COMMENT 'Date of the earliest invoice included in this write-off, used for aging and statute of limitations analysis.',
    `profit_center_code` STRING COMMENT 'Profit center responsible for the revenue and associated write-off for segment profitability reporting.',
    `reason_code` STRING COMMENT 'Standardized code representing the specific reason for writing off the receivable balance.',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of the circumstances and business justification for the write-off decision.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount subsequently recovered from the customer or third parties after the write-off was recorded.',
    `recovery_date` DATE COMMENT 'Date on which a recovery payment was received against the previously written-off balance.',
    `recovery_flag` BOOLEAN COMMENT 'Indicator of whether the written-off amount is still being pursued for potential future recovery through collection agencies or legal action.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this write-off transaction for tracking and audit purposes.',
    `reversal_date` DATE COMMENT 'Date on which the write-off was reversed and the receivable balance was reinstated.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this write-off has been subsequently reversed due to recovery or correction.',
    `reversal_reason` STRING COMMENT 'Explanation of why the write-off was reversed, such as subsequent payment received or error correction.',
    `sap_write_off_document_number` STRING COMMENT 'Reference to the SAP S/4HANA Finance document number generated for this write-off transaction in the source ERP system.',
    `service_line` STRING COMMENT 'Primary service line or product category associated with the original revenue that is being written off. [ENUM-REF-CANDIDATE: express_parcel|air_freight|ocean_freight|road_freight|rail_freight|contract_logistics|ecommerce_fulfillment|customs_brokerage — 8 candidates stripped; promote to reference product]',
    `write_off_date` DATE COMMENT 'Effective date on which the receivable balance is formally written off and removed from active accounts receivable.',
    `write_off_status` STRING COMMENT 'Current lifecycle status of the write-off record in the approval and posting workflow.. Valid values are `draft|pending_approval|approved|posted|reversed|cancelled`',
    `write_off_type` STRING COMMENT 'Classification of the write-off based on the underlying business reason or circumstance.. Valid values are `bad_debt|commercial_settlement|immaterial_balance|statute_limitation|customer_insolvency|uncontactable`',
    `created_by` STRING COMMENT 'User ID or name of the individual who initiated the write-off record in the system.',
    CONSTRAINT pk_write_off PRIMARY KEY(`write_off_id`)
) COMMENT 'Bad debt write-off record documenting the formal decision to write off an uncollectable receivable balance. Captures write-off reference, billing account reference, invoice references written off, write-off amount, write-off reason (customer insolvency, uncontactable, statute of limitations, commercial settlement, immaterial balance), approval authority, approval date, GL write-off account, SAP S/4HANA write-off document reference, bad debt provision release amount, and recovery flag (for subsequent recoveries). Supports SOX-compliant bad debt management and financial reporting.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` (
    `consolidated_invoice_id` BIGINT COMMENT 'Unique identifier for the consolidated invoice record. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Consolidated_invoice should reference billing.account for in-domain linking, same pattern as invoice. Currently only has customer_account_id to customer domain. The billing account is the authoritativ',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer billing account for which this consolidated invoice was generated. Links to the customer account master.',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.cycle. Business justification: Consolidated invoices are generated as part of a billing cycle. The cycle defines the billing period parameters (frequency, start/end days) that determine when consolidation occurs. One cycle generate',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: Consolidated invoices have payment_terms_code as a STRING but should reference the payment_term master table for consistency and data integrity. The payment_term table has payment_term_code which matc',
    `amount_paid` DECIMAL(18,2) COMMENT 'Total amount paid by the customer against this consolidated invoice to date. May be less than, equal to, or greater than total invoice amount.',
    `billing_location_code` STRING COMMENT 'Three-letter code identifying the billing location or office that issued this consolidated invoice. Typically an IATA or UN/LOCODE location code.. Valid values are `^[A-Z]{3}$`',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period covered by this consolidated invoice. Defines the end of the time window for included shipments.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period covered by this consolidated invoice. Defines the beginning of the time window for included shipments.',
    `business_unit_code` STRING COMMENT 'Code identifying the business unit or division responsible for this consolidated invoice. Used for internal reporting and cost allocation.. Valid values are `^[A-Z0-9]{2,10}$`',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity that issued this consolidated invoice. Used for financial consolidation and statutory reporting.. Valid values are `^[A-Z0-9]{4}$`',
    `consolidated_invoice_number` STRING COMMENT 'Externally visible unique invoice number assigned to this consolidated billing document. Used for customer communication and payment reference.. Valid values are `^[A-Z0-9]{3,4}-[0-9]{6,10}$`',
    `consolidation_method` STRING COMMENT 'Method used to aggregate individual shipments into this consolidated invoice. Defines the grouping logic (e.g., weekly, monthly, by service line, by origin-destination lane). [ENUM-REF-CANDIDATE: weekly|bi-weekly|monthly|by_service_line|by_lane|by_business_unit|custom — 7 candidates stripped; promote to reference product]',
    `constituent_invoice_references` STRING COMMENT 'Comma-separated list of individual invoice numbers or shipment references that were consolidated into this invoice. Used for traceability and audit.',
    `cost_center_code` STRING COMMENT 'Cost center code for internal cost allocation and management reporting. Identifies the organizational unit responsible for this invoice.. Valid values are `^[A-Z0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consolidated invoice record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this consolidated invoice (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_date` DATE COMMENT 'Date on which the customer raised a dispute for this consolidated invoice. Null if no dispute exists.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this consolidated invoice is currently under dispute by the customer. True if disputed, false otherwise.',
    `dispute_reason_code` STRING COMMENT 'Code representing the primary reason for invoice dispute (e.g., pricing error, service failure, damaged goods, incorrect charges). Null if no dispute.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Total amount in dispute on this consolidated invoice. Null or zero if no dispute exists.',
    `edi_acknowledgement_status` STRING COMMENT 'Status of EDI functional acknowledgement (997/CONTRL) received from the customer for this invoice transmission.. Valid values are `pending|acknowledged|rejected|not_applicable`',
    `edi_transmission_date` TIMESTAMP COMMENT 'Timestamp when this consolidated invoice was transmitted to the customer via EDI. Null if EDI transmission has not occurred.',
    `edi_transmission_flag` BOOLEAN COMMENT 'Indicates whether this consolidated invoice was transmitted to the customer via EDI (Electronic Data Interchange). True if EDI transmission occurred, false otherwise.',
    `gl_posting_date` DATE COMMENT 'Date on which revenue from this consolidated invoice was posted to the general ledger. Used for financial period assignment and revenue recognition.',
    `invoice_due_date` DATE COMMENT 'Date by which payment is due for this consolidated invoice. Calculated based on payment terms and issue date.',
    `invoice_issue_date` DATE COMMENT 'Date on which the consolidated invoice was issued to the customer. Used for aging and payment terms calculation.',
    `invoice_line_count` STRING COMMENT 'Total number of line items on this consolidated invoice. Each line represents a charge category or service type.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of this consolidated invoice. Tracks progression from draft through payment or dispute resolution. [ENUM-REF-CANDIDATE: draft|issued|sent|partially_paid|paid|overdue|disputed|cancelled|written_off — 9 candidates stripped; promote to reference product]',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received against this consolidated invoice. Null if no payments have been received.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this consolidated invoice. May include special billing instructions, customer requests, or internal remarks.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on this consolidated invoice. Calculated as total invoice amount minus amount paid and credits applied.',
    `payment_status` STRING COMMENT 'Payment status of this consolidated invoice. Indicates whether payment has been received in full, in part, or not at all.. Valid values are `unpaid|partially_paid|paid|overpaid|refunded`',
    `profit_center_code` STRING COMMENT 'Profit center code for internal management accounting. Used to track profitability by business segment or geographic region.. Valid values are `^[A-Z0-9]{6,10}$`',
    `revenue_recognition_period` STRING COMMENT 'Accounting period (YYYY-MM format) in which revenue from this consolidated invoice is recognized. Aligns with IFRS 15 performance obligation satisfaction.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `sap_billing_document_number` STRING COMMENT 'SAP S/4HANA Finance billing document number for this consolidated invoice. Used for reconciliation with the ERP system.. Valid values are `^[0-9]{10}$`',
    `service_line` STRING COMMENT 'Primary service line for shipments included in this consolidated invoice (e.g., Express Parcel, Air Freight, Ocean Freight, Road Freight, Contract Logistics). [ENUM-REF-CANDIDATE: express_parcel|air_freight|ocean_freight|road_freight|rail_freight|contract_logistics|ecommerce_fulfillment|last_mile — promote to reference product]',
    `shipment_count` STRING COMMENT 'Total number of individual shipments included in this consolidated invoice. Used for invoice summary and validation.',
    `total_accessorial_charges` DECIMAL(18,2) COMMENT 'Sum of all accessorial charges (residential delivery, signature required, liftgate service, etc.) for shipments in this invoice.',
    `total_customs_duties` DECIMAL(18,2) COMMENT 'Sum of all customs duties and tariffs for international shipments included in this consolidated invoice, if billed to customer under DDP or similar terms.',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Sum of all discounts applied to this consolidated invoice (volume discounts, promotional discounts, contract-based discounts).',
    `total_freight_charges` DECIMAL(18,2) COMMENT 'Sum of all base freight charges across all shipments included in this consolidated invoice, before surcharges and taxes.',
    `total_invoice_amount` DECIMAL(18,2) COMMENT 'Grand total amount due for this consolidated invoice, including all charges, surcharges, taxes, and discounts. This is the amount the customer must pay.',
    `total_surcharges` DECIMAL(18,2) COMMENT 'Sum of all surcharges (fuel surcharge, peak season surcharge, remote area surcharge, etc.) across all shipments in this invoice.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Sum of all taxes (VAT, GST, sales tax) applied to this consolidated invoice. Calculated based on applicable tax jurisdictions and rates.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this consolidated invoice record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_consolidated_invoice PRIMARY KEY(`consolidated_invoice_id`)
) COMMENT 'Consolidated billing document that aggregates multiple individual shipment charges into a single periodic invoice for high-volume enterprise customers. Captures consolidated invoice number, billing period start and end dates, number of shipments included, number of invoice lines, total freight charges, total surcharges, total tax, total invoice amount, consolidation method (weekly, bi-weekly, monthly, by service line, by origin-destination lane), customer billing account reference, and constituent invoice or shipment references. Reduces invoice processing overhead for large B2B accounts and supports EDI-based billing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`cycle` (
    `cycle_id` BIGINT COMMENT 'Unique identifier for the billing cycle configuration record.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created this billing cycle configuration record.',
    `cycle_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who last modified this billing cycle configuration record.',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`charge_event` (
    `charge_event_id` BIGINT COMMENT 'Primary key for charge_event',
    `agreement_id` BIGINT COMMENT 'Reference to the pricing contract or service agreement governing the charges triggered by this event. Determines applicable rates, discounts, and billing terms.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to network.carrier_service. Business justification: Billing events must capture service-level detail for accurate charge classification and revenue recognition by service tier. Supports automated invoice generation with correct service codes and rates ',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment associated with this billing event. Links the charge trigger to the physical movement of goods.',
    `employee_id` BIGINT COMMENT 'User identifier of the employee who manually triggered this billing event. Null for system-generated events. Used for audit trail and accountability.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: Charge events trigger invoice generation. Once an invoice is created from charge events, the charge_event should reference the resulting invoice for traceability. Temporal dependency: NULL until billi',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Billing events for agent-originated shipments require agent linkage for commission accrual and revenue allocation. Supports automated commission calculation and agent performance reporting by revenue ',
    `service_scope_id` BIGINT COMMENT 'Foreign key linking to contract.service_scope. Business justification: Charge events must validate against service_scope to determine if service is in-scope (billable under agreement) vs. out-of-scope (ad-hoc pricing). Essential for automated billing rules, revenue recog',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: Billing events for 3PL services must capture provider for accurate charge classification and cost allocation. Supports automated invoice generation for 3PL services and cost recovery tracking by provi',
    `audit_exception_code` STRING COMMENT 'Standardized code identifying the type of audit exception or validation failure detected for this billing event. Null if audit status is passed.. Valid values are `^[A-Z0-9]{2,10}$`',
    `audit_status` STRING COMMENT 'Result of freight audit validation for this billing event. Indicates whether the charge passed automated validation rules or requires manual review.. Valid values are `not_audited|passed|failed|pending_review|exception`',
    `awb_number` STRING COMMENT 'Air waybill number for air freight shipments. Standard 11-digit IATA format (3-digit airline prefix + 8-digit serial number). Null for non-air shipments.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `bol_number` STRING COMMENT 'Bill of lading number for ocean, road, or rail freight shipments. Serves as receipt, contract of carriage, and document of title. Null for air or parcel shipments.. Valid values are `^[A-Z0-9]{8,20}$`',
    `business_unit` STRING COMMENT 'High-level business division or service line that generated this billing event. Aligns with organizational structure and strategic reporting segments.. Valid values are `express|freight|supply_chain|ecommerce|contract_logistics`',
    `charge_amount` DECIMAL(18,2) COMMENT 'Monetary value of the charge triggered by this billing event. Represents the base charge amount before taxes, surcharges, or adjustments.',
    `charge_category` STRING COMMENT 'Classification of the charge type triggered by this event. Distinguishes between base transportation charges, surcharges, accessorial services, and penalty charges. [ENUM-REF-CANDIDATE: base_freight|fuel_surcharge|accessorial|detention|storage|customs_fee|handling — 7 candidates stripped; promote to reference product]',
    `chargeable_weight_kg` DECIMAL(18,2) COMMENT 'Billable weight calculated as the greater of actual weight or dimensional (DIM) weight. Determines the weight basis for freight charge calculation.',
    `cost_center_code` STRING COMMENT 'Cost center responsible for the service delivery that triggered this billing event. Used for internal profitability analysis and management accounting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this billing event record was first created in the data platform. System audit field for data lineage and troubleshooting.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the charge amount. Indicates the currency in which the billing event charge is denominated.. Valid values are `^[A-Z]{3}$`',
    `deferral_reason` STRING COMMENT 'Explanation for why invoice generation was deferred for this billing event. Captures timing rules that delay billing (e.g., awaiting POD confirmation, pending dispute resolution, consolidation period).',
    `destination_location_code` STRING COMMENT 'Three-letter IATA or UN/LOCODE for the shipment destination location. Identifies the geographic endpoint of the service that triggered the billing event.. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this billing event is under dispute by the customer or carrier. True if a dispute case has been opened that affects this charge.',
    `event_reference_number` STRING COMMENT 'Business identifier for the billing trigger event. Externally visible unique reference used for audit and reconciliation purposes.. Valid values are `^[A-Z0-9]{8,20}$`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the billing trigger event occurred in the source operational system. This is the business event time, distinct from record audit timestamps.',
    `event_type` STRING COMMENT 'Classification of the billing trigger event that initiates charge calculation or invoice generation. [ENUM-REF-CANDIDATE: shipment_delivered|pod_confirmed|customs_cleared|warehouse_release|milestone_reached|period_end|manual_trigger|contract_renewal|service_completion|detention_incurred|storage_threshold|rate_adjustment — promote to reference product]. Valid values are `shipment_delivered|pod_confirmed|customs_cleared|warehouse_release|milestone_reached|period_end`',
    `gl_account_code` STRING COMMENT 'General ledger account code for revenue posting. Maps the billing event to the appropriate revenue account in SAP S/4HANA Finance chart of accounts.. Valid values are `^[0-9]{4,10}$`',
    `invoice_generation_status` STRING COMMENT 'Current state of invoice generation for this billing event. Tracks whether the event has been processed into an invoice line or is awaiting consolidation, suppression, or deferral.. Valid values are `pending|generated|suppressed|deferred|failed|cancelled`',
    `manual_trigger_flag` BOOLEAN COMMENT 'Indicates whether this billing event was manually created by a billing analyst rather than automatically generated by an operational system. True for manual adjustments and corrections.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or explanatory comments related to this billing event. Used for manual adjustments and exception handling.',
    `order_reference` STRING COMMENT 'Customer order number or freight order reference associated with the billing event. May reference express parcel orders, freight bookings, or warehouse service orders.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `origin_location_code` STRING COMMENT 'Three-letter IATA or UN/LOCODE for the shipment origin location. Identifies the geographic starting point of the service that triggered the billing event.. Valid values are `^[A-Z]{3}$`',
    `processing_timestamp` TIMESTAMP COMMENT 'Date and time when the billing event was processed by the order-to-cash billing pipeline. Represents when the event was evaluated for invoice generation.',
    `profit_center_code` STRING COMMENT 'Profit center that will recognize revenue from this billing event. Supports segment reporting and business unit performance measurement.. Valid values are `^[A-Z0-9]{4,12}$`',
    `revenue_recognition_date` DATE COMMENT 'Accounting date when revenue from this billing event should be recognized in the general ledger. Aligns with IFRS 15 performance obligation satisfaction criteria.',
    `service_end_date` DATE COMMENT 'Date when the billable service period or activity concluded. Used for time-based billing, storage charges, and contract milestone tracking.',
    `service_start_date` DATE COMMENT 'Date when the billable service period or activity commenced. Used for time-based billing, storage charges, and contract milestone tracking.',
    `service_type` STRING COMMENT 'Classification of the logistics service that generated this billing event. Aligns with core business process categories and revenue streams. [ENUM-REF-CANDIDATE: express_parcel|air_freight|ocean_freight|road_freight|rail_freight|warehousing|customs_brokerage — 7 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'Operational system of record that generated the billing trigger event. Identifies the upstream application that detected the billable milestone or condition.. Valid values are `FourKites|SAP_TM|Oracle_TMS|Manhattan_WMS|Descartes_Customs|Manual`',
    `suppression_reason` STRING COMMENT 'Explanation for why invoice generation was suppressed for this billing event. Captures business rules that prevent billing (e.g., below minimum charge threshold, duplicate event, customer exemption).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this billing event record was last modified. System audit field for change tracking and data quality monitoring.',
    `volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the shipment in cubic meters. Used for volumetric billing calculations and capacity planning.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Actual gross weight of the shipment in kilograms. Used for weight-based billing calculations and freight audit validation.',
    CONSTRAINT pk_charge_event PRIMARY KEY(`charge_event_id`)
) COMMENT 'Business event record capturing billing trigger events that initiate invoice generation or charge calculation. Captures event reference, event type (shipment_delivered, POD_confirmed, customs_cleared, warehouse_release, milestone_reached, period_end, manual_trigger, contract_renewal), event timestamp, source system (FourKites, SAP TM, Oracle TMS, Manhattan WMS, Descartes Customs), shipment or order reference, billing account reference, charge amount triggered, invoice generation status (pending, generated, suppressed, deferred), and processing timestamp. Provides an auditable trigger log for the order-to-cash billing pipeline.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` (
    `intercompany_billing_id` BIGINT COMMENT 'Unique identifier for the intercompany billing transaction record.',
    `consignment_id` BIGINT COMMENT 'Foreign key linking to shipment.consignment. Business justification: Intercompany billing for cross-border or cross-entity shipments requires direct consignment linkage for transfer pricing validation, cost allocation by service type/route, and regulatory compliance do',
    `employee_id` BIGINT COMMENT 'User identifier of the finance manager or controller who approved the intercompany billing transaction.',
    `intercompany_settlement_id` BIGINT COMMENT 'Foreign key linking to finance.intercompany_settlement. Business justification: Intercompany billing transactions are settled through finances netting and settlement process. Finance consolidation, elimination entries, and transfer pricing documentation require linking settlemen',
    `approval_date` DATE COMMENT 'Date when the intercompany billing transaction was approved by the authorized finance personnel.',
    `awb_number` STRING COMMENT 'Air waybill number associated with the cross-border air freight shipment that generated the intercompany charge, formatted as 3-digit airline prefix followed by 8-digit serial number.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `billing_date` DATE COMMENT 'Date when the intercompany billing transaction was created and issued to the receiving entity.',
    `bol_number` STRING COMMENT 'Bill of lading number associated with the cross-border ocean or ground freight shipment that generated the intercompany charge.',
    `business_area` STRING COMMENT 'Business area or service line to which the intercompany billing relates: express parcel, freight forwarding, supply chain, e-commerce fulfillment, contract logistics, or last mile delivery.. Valid values are `express_parcel|freight_forwarding|supply_chain|ecommerce_fulfillment|contract_logistics|last_mile`',
    `charge_amount` DECIMAL(18,2) COMMENT 'Base charge amount for the intercompany service or cost allocation before markup or adjustments.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity for financial reporting and consolidation purposes.. Valid values are `^[A-Z0-9]{4}$`',
    `cost_center_code` STRING COMMENT 'Cost center code associated with the originating entity for internal cost tracking and allocation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the intercompany billing record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the intercompany billing transaction (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_date` DATE COMMENT 'Date when the dispute was raised by the receiving entity.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the receiving entity has raised a dispute on this intercompany billing transaction (True = disputed, False = not disputed).',
    `dispute_reason` STRING COMMENT 'Detailed explanation of why the receiving entity disputed the intercompany billing transaction, if applicable.',
    `dispute_resolution_date` DATE COMMENT 'Date when the dispute was resolved and the intercompany billing was either adjusted or confirmed.',
    `due_date` DATE COMMENT 'Date by which the receiving entity is expected to settle the intercompany billing amount.',
    `fiscal_period` STRING COMMENT 'Fiscal period (1-12 for months or 1-4 for quarters) within the fiscal year for the intercompany billing transaction.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the intercompany billing transaction is assigned for financial reporting purposes.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the intercompany billing transaction is posted in the financial system.. Valid values are `^[0-9]{6,10}$`',
    `ifrs_elimination_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this intercompany transaction should be eliminated in consolidated financial statements per IFRS 10 requirements (True = eliminate, False = retain).',
    `markup_amount` DECIMAL(18,2) COMMENT 'Calculated markup amount added to the base charge based on the markup percentage.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'Percentage markup applied to the base charge amount for transfer pricing purposes, typically ranging from 0% to 100%.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the intercompany billing transaction for audit trail and clarification purposes.',
    `originating_entity_code` STRING COMMENT 'Code identifying the Transport Shipping legal entity, subsidiary, or regional business unit that originated the intercompany charge.. Valid values are `^[A-Z0-9]{4,10}$`',
    `originating_entity_name` STRING COMMENT 'Full legal name of the originating entity that provided the service or incurred the cost being billed.',
    `profit_center_code` STRING COMMENT 'Profit center code associated with the receiving entity for profitability analysis and reporting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `receiving_entity_code` STRING COMMENT 'Code identifying the Transport Shipping legal entity, subsidiary, or regional business unit that is receiving the intercompany charge.. Valid values are `^[A-Z0-9]{4,10}$`',
    `receiving_entity_name` STRING COMMENT 'Full legal name of the receiving entity that is being charged for the service or cost allocation.',
    `revenue_recognition_date` DATE COMMENT 'Date when revenue from this intercompany transaction is recognized in the originating entitys financial statements per IFRS 15.',
    `sap_intercompany_document_number` STRING COMMENT 'Reference to the corresponding intercompany document number in SAP S/4HANA Finance system for reconciliation and audit purposes.. Valid values are `^[0-9]{10}$`',
    `service_description` STRING COMMENT 'Detailed description of the shared service, cross-border shipment handling, or cost allocation being billed between entities.',
    `service_type` STRING COMMENT 'Category of intercompany service being billed: shared services, cross-border handling, cost allocation, freight forwarding, warehouse services, or IT services.. Valid values are `shared_services|cross_border_handling|cost_allocation|freight_forwarding|warehouse_services|it_services`',
    `settlement_date` DATE COMMENT 'Actual date when the intercompany billing amount was settled between entities.',
    `settlement_period` STRING COMMENT 'Fiscal period for which the intercompany billing applies, formatted as YYYY-Q# for quarters or YYYY-M## for months (e.g., 2024-Q1, 2024-M03).. Valid values are `^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$`',
    `settlement_status` STRING COMMENT 'Current status of the intercompany billing settlement: pending approval, approved, settled, disputed, cancelled, or reversed.. Valid values are `pending|approved|settled|disputed|cancelled|reversed`',
    `shipment_reference_number` STRING COMMENT 'Reference to the underlying shipment or freight order that triggered the intercompany billing, if applicable for cross-border handling charges.',
    `tax_treatment_code` STRING COMMENT 'Code indicating the tax treatment applicable to the intercompany transaction based on jurisdictional tax regulations and transfer pricing rules.. Valid values are `^[A-Z0-9]{2,6}$`',
    `total_billing_amount` DECIMAL(18,2) COMMENT 'Total amount billed to the receiving entity including base charge and markup.',
    `transaction_reference_number` STRING COMMENT 'Externally-known unique reference number for the intercompany billing transaction, typically prefixed with IC followed by 10 digits.. Valid values are `^IC[0-9]{10}$`',
    `transfer_pricing_basis` STRING COMMENT 'Transfer pricing methodology applied to determine the intercompany charge: cost plus, market price, resale minus, comparable uncontrolled price, profit split, or transactional net margin method.. Valid values are `cost_plus|market_price|resale_minus|comparable_uncontrolled_price|profit_split|transactional_net_margin`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the intercompany billing record was last modified in the system.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Calculated withholding tax amount deducted from the intercompany billing settlement.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'Withholding tax rate percentage applied to the intercompany billing amount based on applicable tax treaties and local regulations.',
    CONSTRAINT pk_intercompany_billing PRIMARY KEY(`intercompany_billing_id`)
) COMMENT 'Intercompany billing record managing financial settlements between Transport Shipping legal entities, subsidiaries, and regional business units for shared services, cross-border shipment handling, and cost allocation. Captures intercompany transaction reference, originating entity, receiving entity, service description, charge amount, currency, transfer pricing basis, markup percentage, settlement period, settlement status (pending, approved, settled, disputed), SAP S/4HANA intercompany document reference, and IFRS elimination flag. Supports consolidated financial reporting and transfer pricing compliance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`advance_payment` (
    `advance_payment_id` BIGINT COMMENT 'Unique identifier for the advance payment record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the customer contract or service agreement under which the advance payment was made.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Advance_payment should reference billing.account for in-domain linking. Currently only has customer_account_id to customer domain. Advance payments are managed within the billing account context (cred',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer billing account that made the advance payment.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the advance payment for acceptance and recording.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Advance payments create deferred revenue liabilities requiring GL posting. Finance needs to link the liability journal entry to the source advance payment for balance sheet reconciliation, subsequent ',
    `advance_amount` DECIMAL(18,2) COMMENT 'Total amount of the advance payment received from the customer before service delivery.',
    `approval_status` STRING COMMENT 'Internal approval status for accepting and recording the advance payment, particularly for high-value or new customer transactions.. Valid values are `pending_approval|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the advance payment was approved for acceptance.',
    `awb_number` STRING COMMENT 'Air waybill number associated with the advance payment for air freight shipments requiring prepayment.',
    `bank_reference_number` STRING COMMENT 'Bank transaction reference or confirmation number for the advance payment receipt.',
    `base_currency_amount` DECIMAL(18,2) COMMENT 'Advance payment amount converted to the company base reporting currency using the exchange rate.',
    `bol_number` STRING COMMENT 'Bill of lading number associated with the advance payment for ocean or road freight shipments requiring prepayment.',
    `business_unit_code` STRING COMMENT 'Business unit or division code responsible for managing the advance payment and associated service delivery.',
    `company_code` STRING COMMENT 'Legal entity or company code within the enterprise structure that received the advance payment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the advance payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the advance payment amount.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied if the advance payment was received in a currency different from the base reporting currency.',
    `expiry_date` DATE COMMENT 'Date after which the unutilized advance payment balance expires and becomes eligible for refund or forfeiture per contract terms.',
    `gl_account_code` STRING COMMENT 'General ledger account code where the advance payment liability is recorded in the chart of accounts.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the advance payment, including special instructions, customer requests, or internal remarks.',
    `payment_channel` STRING COMMENT 'Interface or channel through which the customer submitted the advance payment transaction.. Valid values are `online_portal|mobile_app|bank_transfer|in_person|mail|edi`',
    `payment_method` STRING COMMENT 'Financial instrument used by the customer to remit the advance payment. [ENUM-REF-CANDIDATE: wire_transfer|ach|credit_card|debit_card|check|cash|electronic_wallet — 7 candidates stripped; promote to reference product]',
    `payment_status` STRING COMMENT 'Current lifecycle status of the advance payment indicating utilization state and availability for application against future invoices. [ENUM-REF-CANDIDATE: pending|received|unutilized|partially_utilized|fully_utilized|refunded|expired|cancelled — 8 candidates stripped; promote to reference product]',
    `payment_type` STRING COMMENT 'Classification of the advance payment purpose: freight deposit for high-value shipments, customs duty prepayment for DDP/DAP terms, COD float for cash-on-delivery services, or general credit for new customer onboarding.. Valid values are `freight_deposit|customs_duty_prepayment|cod_float|general_credit|dap_prepayment|ddp_prepayment`',
    `receipt_date` DATE COMMENT 'Date when the advance payment was received and cleared in the company bank account.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the advance payment transaction was received and recorded in the financial system.',
    `reconciliation_date` DATE COMMENT 'Date when the advance payment was reconciled with bank statements.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether the advance payment has been reconciled with bank statements and financial records.. Valid values are `unreconciled|reconciled|discrepancy`',
    `reference_number` STRING COMMENT 'Externally-known unique reference number for the advance payment transaction, used for customer communication and reconciliation.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount refunded to the customer from the advance payment balance, typically when service is cancelled or advance expires.',
    `refund_date` DATE COMMENT 'Date when the refund was processed and funds returned to the customer.',
    `refund_reference_number` STRING COMMENT 'Transaction reference number for the refund payment issued to the customer.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Unutilized balance available for application against future invoices, calculated as advance amount minus utilized amount.',
    `remittance_advice_reference` STRING COMMENT 'Reference number from the customer remittance advice document accompanying the advance payment.',
    `sap_down_payment_document_number` STRING COMMENT 'SAP S/4HANA down payment document reference number linking this advance payment to the financial accounting system.',
    `service_line` STRING COMMENT 'Primary service line or product category for which the advance payment was received. [ENUM-REF-CANDIDATE: express_parcel|air_freight|ocean_freight|road_freight|rail_freight|contract_logistics|ecommerce_fulfillment|customs_brokerage — 8 candidates stripped; promote to reference product]',
    `shipment_reference` STRING COMMENT 'Reference to a specific shipment or booking for which the advance payment was designated, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the advance payment record was last modified.',
    `utilized_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of the advance payment that has been applied against invoices or service charges to date.',
    CONSTRAINT pk_advance_payment PRIMARY KEY(`advance_payment_id`)
) COMMENT 'Record of advance payments and prepayments received from customers prior to service delivery, common in high-value freight forwarding, DDP shipments, and new customer onboarding. Captures advance payment reference, billing account reference, advance amount, currency, receipt date, payment method, purpose (freight deposit, customs duty prepayment, COD float, general credit), utilization status (unutilized, partially_utilized, fully_utilized, refunded), utilized amount, remaining balance, expiry date, and SAP S/4HANA down payment document reference. Supports prepaid billing models and cash flow management.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` (
    `dunning_invoice_coverage_id` BIGINT COMMENT 'Unique identifier for this dunning invoice coverage record. Primary key.',
    `dunning_record_id` BIGINT COMMENT 'Foreign key linking to the dunning and collections activity record that included this invoice',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to the specific invoice included in this dunning action',
    `communication_sent_flag` BOOLEAN COMMENT 'Indicates whether communication about this specific invoice was sent as part of this dunning action.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice was added to this dunning record. Tracks when the relationship was established.',
    `customer_response_for_invoice` STRING COMMENT 'Customer response specific to this invoice within this dunning action. Customer may respond differently to different invoices in the same dunning cycle.',
    `days_past_due_at_dunning` STRING COMMENT 'Number of days this specific invoice was overdue at the time of this dunning action. Relationship-specific temporal attribute.',
    `dunning_level_for_invoice` STRING COMMENT 'The escalation level applied to this specific invoice in this dunning action. Same invoice may be at different levels in different dunning cycles.',
    `invoice_amount_at_dunning` DECIMAL(18,2) COMMENT 'The outstanding amount of this specific invoice at the time it was included in this dunning action. Captures point-in-time state.',
    `overdue_invoice_references` STRING COMMENT 'Comma-separated list of invoice numbers or identifiers that are overdue and included in this dunning action. [Moved from dunning_record: This is a denormalized STRING list (comma-separated invoice numbers) that represents the M:N relationship. This anti-pattern should be replaced by proper association records in dunning_invoice_coverage. Each invoice reference becomes a row in the association table.]',
    CONSTRAINT pk_dunning_invoice_coverage PRIMARY KEY(`dunning_invoice_coverage_id`)
) COMMENT 'This association product represents the inclusion of specific invoices in dunning and collections activity events. It captures which overdue invoices were included in each dunning action, at what escalation level, with what customer response, and what the invoice status was at the time of dunning. Each record links one dunning_record to one invoice with attributes that exist only in the context of this dunning event coverage.. Existence Justification: In logistics billing operations, dunning is performed at the account level, meaning one dunning action covers ALL overdue invoices for a customer at that point in time. Conversely, a single invoice can be included in multiple dunning cycles over time as it remains unpaid and escalates through dunning levels (1st reminder, 2nd reminder, final notice, legal notice, collections referral). The collections team actively manages which invoices are in which dunning cycles, tracking invoice-specific responses, amounts, and escalation levels.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` (
    `performance_obligation_id` BIGINT COMMENT 'Primary key for performance_obligation',
    `agreement_id` BIGINT COMMENT 'Identifier of the underlying contract that contains this performance obligation.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer to whom the obligation is owed.',
    `service_line_id` BIGINT COMMENT 'Identifier of the specific service line or product associated with the obligation.',
    `parent_performance_obligation_id` BIGINT COMMENT 'Self-referencing FK on performance_obligation (parent_performance_obligation_id)',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Portion of the contract total that has been allocated to this performance obligation.',
    `billed_amount` DECIMAL(18,2) COMMENT 'Cumulative amount invoiced against the performance obligation.',
    `billing_cycle` STRING COMMENT 'Frequency or trigger for invoicing the obligation.',
    `collection_method` STRING COMMENT 'Method used to collect payment for the obligation.',
    `collection_status` STRING COMMENT 'Current status of cash collection for the obligation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the performance obligation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the obligation.',
    `performance_obligation_description` STRING COMMENT 'Free‑form text describing the goods or services promised.',
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
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue for the obligation was recognized.',
    `revenue_recognition_method` STRING COMMENT 'Method used to recognize revenue for this obligation.',
    `revenue_recognition_status` STRING COMMENT 'Current status of revenue recognition for the obligation.',
    `performance_obligation_status` STRING COMMENT 'Current lifecycle state of the performance obligation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the obligation amount.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction and rate applied.',
    `total_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary value of the performance obligation at contract inception.',
    `unbilled_amount` DECIMAL(18,2) COMMENT 'Remaining monetary value of the obligation that has not yet been invoiced.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the performance obligation record.',
    CONSTRAINT pk_performance_obligation PRIMARY KEY(`performance_obligation_id`)
) COMMENT 'Master reference table for performance_obligation. Referenced by performance_obligation_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`debit_note` (
    `debit_note_id` BIGINT COMMENT 'Primary key for debit_note',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer (counterparty) to whom the debit note is issued.',
    `invoice_id` BIGINT COMMENT 'Identifier of the original invoice that this debit note adjusts.',
    `reversed_debit_note_id` BIGINT COMMENT 'Self-referencing FK on debit_note (reversed_debit_note_id)',
    `adjustment_type` STRING COMMENT 'Nature of the financial adjustment represented by the debit note.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the debit note.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the debit note received formal approval.',
    `business_event_timestamp` TIMESTAMP COMMENT 'Exact moment the debit note event occurred in the business process.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the debit note is expressed.',
    `debit_note_number` STRING COMMENT 'External reference number assigned to the debit note for customer and accounting communication.',
    `debit_note_description` STRING COMMENT 'Free‑text description providing additional context for the debit note.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of any discount applied to the gross amount.',
    `discount_reason` STRING COMMENT 'Explanation for why a discount was granted.',
    `due_date` DATE COMMENT 'Date by which the customer is expected to settle the debit note amount.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes, discounts, or other adjustments.',
    `is_refunded` BOOLEAN COMMENT 'Indicates whether the debit note amount has been refunded to the customer.',
    `issue_date` DATE COMMENT 'Date on which the debit note was created and sent to the customer.',
    `lifecycle_status` STRING COMMENT 'Current processing state of the debit note.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after tax, discounts, and other adjustments.',
    `payment_terms` STRING COMMENT 'Textual representation of the payment terms applicable to the debit note (e.g., Net 30).',
    `reason_code` STRING COMMENT 'Standardized code describing why the debit note was issued (e.g., freight surcharge, damage claim).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the debit note record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the debit note record.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount that was refunded to the customer, if applicable.',
    `refund_date` DATE COMMENT 'Date on which the refund was processed.',
    `revenue_recognition_date` DATE COMMENT 'Date on which the revenue associated with the debit note is recognized per IFRS 15.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the gross amount.',
    `tax_code` STRING COMMENT 'Accounting code that identifies the tax jurisdiction or type.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the debit note is exempt from tax.',
    `tax_exempt_reason` STRING COMMENT 'Explanation for tax exemption, if applicable.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage (e.g., 7.25).',
    CONSTRAINT pk_debit_note PRIMARY KEY(`debit_note_id`)
) COMMENT 'Master reference table for debit_note. Referenced by debit_note_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`billing`.`service_line` (
    `service_line_id` BIGINT COMMENT 'Primary key for service_line',
    `billing_frequency` STRING COMMENT 'Default invoicing frequency for customers using this service line, determining how often charges are consolidated and billed.',
    `service_line_category` STRING COMMENT 'High-level classification grouping service lines into broad operational categories for reporting and organizational alignment.',
    `service_line_code` STRING COMMENT 'Short alphanumeric business code uniquely identifying the service line across operational systems (e.g., EXP for Express, FRT for Freight, SCM for Supply Chain Management). Used as the externally-known business identifier.',
    `cost_center_code` STRING COMMENT 'Default cost center code for allocating operational expenses incurred by this service line.',
    `coverage_scope` STRING COMMENT 'Geographic scope of the service line indicating whether it covers domestic shipments, international cross-border movements, or both.',
    `default_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used as the default billing currency for this service line.',
    `service_line_description` STRING COMMENT 'Detailed textual description of the service line, including scope of services offered, target customer segments, and operational characteristics.',
    `effective_from` DATE COMMENT 'Date from which this service line record version becomes effective for billing and operational purposes.',
    `effective_until` DATE COMMENT 'Date until which this service line record version remains effective. Null indicates currently active with no planned end.',
    `external_reference_code` STRING COMMENT 'Code used by external partners, carriers, or regulatory bodies to reference this service line in EDI transactions and customs declarations.',
    `gl_account_code` STRING COMMENT 'Default general ledger account code in SAP S/4HANA Finance used for posting revenue transactions associated with this service line.',
    `hierarchy_level` STRING COMMENT 'Depth level within the service line hierarchy (1 = top-level, 2 = sub-service, etc.) for organizational reporting and drill-down analytics.',
    `incoterms_supported` STRING COMMENT 'Comma-separated list of ICC Incoterms (e.g., DAP, DDP, FOB, CIF) supported by this service line for international trade transactions. [ENUM-REF-CANDIDATE: EXW|FCA|FAS|FOB|CFR|CIF|CPT|CIP|DAP|DPU|DDP — promote to reference product]',
    `is_cod_supported` BOOLEAN COMMENT 'Indicates whether this service line supports cash on delivery payment collection at the point of delivery.',
    `is_customs_brokerage_included` BOOLEAN COMMENT 'Indicates whether customs brokerage and clearance services are bundled as part of this service line offering.',
    `is_ecommerce_eligible` BOOLEAN COMMENT 'Indicates whether this service line is available for e-commerce fulfillment channels and marketplace integrations.',
    `is_hazmat_eligible` BOOLEAN COMMENT 'Indicates whether this service line supports the transport of hazardous materials (dangerous goods) under IATA DGR or IMDG Code regulations.',
    `is_insurance_available` BOOLEAN COMMENT 'Indicates whether shipment insurance or cargo liability coverage can be offered as an add-on for this service line.',
    `is_temperature_controlled` BOOLEAN COMMENT 'Indicates whether this service line offers temperature-controlled (cold chain) logistics capabilities for perishable or pharmaceutical goods.',
    `launch_date` DATE COMMENT 'Date when this service line was first made commercially available to customers.',
    `max_dimensions_cm` STRING COMMENT 'Maximum allowable package dimensions in centimeters expressed as LxWxH for this service line.',
    `max_weight_kg` DECIMAL(18,2) COMMENT 'Maximum allowable shipment weight in kilograms for this service line. Shipments exceeding this limit require special handling or alternative service selection.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'Minimum billable amount per shipment or transaction for this service line, below which the minimum charge applies regardless of actual weight or volume.',
    `service_line_name` STRING COMMENT 'Human-readable name of the service line (e.g., Express Delivery, Freight Forwarding, Supply Chain Management, E-Commerce Fulfillment).',
    `owning_business_unit` STRING COMMENT 'Name or code of the business unit or division that owns and is accountable for the commercial performance of this service line.',
    `parent_service_line_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent service line in a hierarchical service line structure, enabling sub-service categorization.',
    `product_manager` STRING COMMENT 'Name or identifier of the product manager responsible for the strategic direction, pricing, and market positioning of this service line.',
    `profit_center_code` STRING COMMENT 'Profit center assignment in SAP controlling module for internal profitability reporting and cost allocation of this service line.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service line record was first created in the system of record.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this service line record was last modified or updated.',
    `revenue_recognition_method` STRING COMMENT 'Method used for recognizing revenue for this service line in accordance with IFRS 15 performance obligation satisfaction criteria.',
    `sla_transit_days` STRING COMMENT 'Standard service level agreement transit time in business days for this service line, used as the baseline for on-time delivery performance measurement.',
    `sort_order` STRING COMMENT 'Numeric value controlling the display sequence of this service line in user interfaces, reports, and dropdown selections.',
    `service_line_status` STRING COMMENT 'Current lifecycle status of the service line indicating whether it is actively offered, inactive, deprecated, or in planning phase.',
    `sunset_date` DATE COMMENT 'Planned or actual date when this service line will be or was discontinued and no longer offered to customers.',
    `tax_classification` STRING COMMENT 'Default tax treatment classification for this service line, determining applicable VAT/GST rules for invoice generation.',
    `transport_mode` STRING COMMENT 'Primary mode of transport associated with this service line. Determines routing, carrier selection, and transit time expectations.',
    `service_line_type` STRING COMMENT 'Classification of the service line by its strategic role within the business portfolio, distinguishing core revenue-generating services from ancillary or premium offerings.',
    `volumetric_divisor` STRING COMMENT 'Divisor factor used to calculate volumetric (dimensional) weight from package dimensions for this service line (e.g., 5000 for air, 6000 for road).',
    `weight_break_unit` STRING COMMENT 'Unit of measure used for weight-based pricing tiers (weight breaks) applicable to this service line.',
    CONSTRAINT pk_service_line PRIMARY KEY(`service_line_id`)
) COMMENT 'Master reference table for service_line. Referenced by service_line_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_consolidated_invoice_id` FOREIGN KEY (`consolidated_invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`consolidated_invoice`(`consolidated_invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `transport_shipping_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_charge_event_id` FOREIGN KEY (`charge_event_id`) REFERENCES `transport_shipping_ecm`.`billing`.`charge_event`(`charge_event_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `transport_shipping_ecm`.`billing`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ADD CONSTRAINT `fk_billing_billing_invoice_line_tax_schedule_id` FOREIGN KEY (`tax_schedule_id`) REFERENCES `transport_shipping_ecm`.`billing`.`tax_schedule`(`tax_schedule_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ADD CONSTRAINT `fk_billing_credit_note_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_credit_note_id` FOREIGN KEY (`credit_note_id`) REFERENCES `transport_shipping_ecm`.`billing`.`credit_note`(`credit_note_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_debit_note_id` FOREIGN KEY (`debit_note_id`) REFERENCES `transport_shipping_ecm`.`billing`.`debit_note`(`debit_note_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `transport_shipping_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ADD CONSTRAINT `fk_billing_receivable_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ADD CONSTRAINT `fk_billing_freight_audit_carrier_payable_id` FOREIGN KEY (`carrier_payable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`carrier_payable`(`carrier_payable_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ADD CONSTRAINT `fk_billing_carrier_payable_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `transport_shipping_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ADD CONSTRAINT `fk_billing_cod_collection_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_original_recognition_revenue_recognition_id` FOREIGN KEY (`original_recognition_revenue_recognition_id`) REFERENCES `transport_shipping_ecm`.`billing`.`revenue_recognition`(`revenue_recognition_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ADD CONSTRAINT `fk_billing_revenue_recognition_performance_obligation_id` FOREIGN KEY (`performance_obligation_id`) REFERENCES `transport_shipping_ecm`.`billing`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `transport_shipping_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_parent_billing_account_id` FOREIGN KEY (`parent_billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `transport_shipping_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ADD CONSTRAINT `fk_billing_dunning_record_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ADD CONSTRAINT `fk_billing_dunning_record_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ADD CONSTRAINT `fk_billing_dunning_record_receivable_id` FOREIGN KEY (`receivable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`receivable`(`receivable_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_receivable_id` FOREIGN KEY (`receivable_id`) REFERENCES `transport_shipping_ecm`.`billing`.`receivable`(`receivable_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ADD CONSTRAINT `fk_billing_consolidated_invoice_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ADD CONSTRAINT `fk_billing_consolidated_invoice_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `transport_shipping_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ADD CONSTRAINT `fk_billing_consolidated_invoice_payment_term_id` FOREIGN KEY (`payment_term_id`) REFERENCES `transport_shipping_ecm`.`billing`.`payment_term`(`payment_term_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ADD CONSTRAINT `fk_billing_charge_event_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ADD CONSTRAINT `fk_billing_advance_payment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `transport_shipping_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` ADD CONSTRAINT `fk_billing_dunning_invoice_coverage_dunning_record_id` FOREIGN KEY (`dunning_record_id`) REFERENCES `transport_shipping_ecm`.`billing`.`dunning_record`(`dunning_record_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` ADD CONSTRAINT `fk_billing_dunning_invoice_coverage_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_service_line_id` FOREIGN KEY (`service_line_id`) REFERENCES `transport_shipping_ecm`.`billing`.`service_line`(`service_line_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` ADD CONSTRAINT `fk_billing_performance_obligation_parent_performance_obligation_id` FOREIGN KEY (`parent_performance_obligation_id`) REFERENCES `transport_shipping_ecm`.`billing`.`performance_obligation`(`performance_obligation_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `transport_shipping_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`billing`.`debit_note` ADD CONSTRAINT `fk_billing_debit_note_reversed_debit_note_id` FOREIGN KEY (`reversed_debit_note_id`) REFERENCES `transport_shipping_ecm`.`billing`.`debit_note`(`debit_note_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `transport_shipping_ecm`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `consolidated_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `amount_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Amount Outstanding');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Bill To Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Bill To Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_city` SET TAGS ('dbx_business_glossary_term' = 'Bill To City');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Bill To Country Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_name` SET TAGS ('dbx_business_glossary_term' = 'Bill To Name');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Bill To Postal Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_state_province` SET TAGS ('dbx_business_glossary_term' = 'Bill To State or Province');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`invoice` ALTER COLUMN `bill_to_state_province` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `billing_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `accessorial_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `blocked_space_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Blocked Space Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `charge_event_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Event Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `contract_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `contract_surcharge_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Surcharge Schedule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `hub_gateway_id` SET TAGS ('dbx_business_glossary_term' = 'Hub Gateway Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `interline_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interline Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Surcharge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `tax_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Schedule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_invoice_line` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `carbon_offset_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Transaction Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `cargo_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Claim ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `route_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Route Exception Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`credit_note` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'cash_collections');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `payer_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Name');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `unapplied_balance` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Balance');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment` ALTER COLUMN `withholding_tax_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Certificate Reference');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` SET TAGS ('dbx_subdomain' = 'cash_collections');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `payment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `bank_statement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Transaction ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `credit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Note ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `debit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Debit Note ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Allocated By User ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Receivable ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `credit_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Risk Rating');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `credit_risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `credit_utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Credit Utilization Percentage');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`receivable` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` SET TAGS ('dbx_subdomain' = 'carrier_settlements');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `freight_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `carrier_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payable ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `lane_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Commitment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `shipment_carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Carbon Footprint Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `tariff_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`freight_audit` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` SET TAGS ('dbx_subdomain' = 'carrier_settlements');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `carrier_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Payable ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `carrier_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `supplier_emissions_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Emissions Disclosure Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`carrier_payable` ALTER COLUMN `surveyor_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` SET TAGS ('dbx_subdomain' = 'cash_collections');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `cod_collection_id` SET TAGS ('dbx_business_glossary_term' = 'Cod Collection Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `bank_statement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Statement Line Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Agent ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper Account ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `bank_deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Deposit Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `bank_deposit_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Deposit Reference');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `cod_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Cash on Delivery (COD) Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `cod_reference_number` SET TAGS ('dbx_value_regex' = '^COD[0-9]{10,15}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `collected_amount` SET TAGS ('dbx_business_glossary_term' = 'Collected Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `collection_location_code` SET TAGS ('dbx_business_glossary_term' = 'Collection Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `collection_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'cash|cheque|credit_card|debit_card|mobile_payment|bank_transfer');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `collection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `consignee_contact_number` SET TAGS ('dbx_business_glossary_term' = 'Consignee Contact Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `consignee_contact_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `consignee_contact_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `consignee_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `consignee_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `declared_cod_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Cash on Delivery (COD) Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `net_remittance_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Remittance Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `operating_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Unit Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `operating_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `payment_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Receipt Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|discrepancy|under_review');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `remittance_date` SET TAGS ('dbx_business_glossary_term' = 'Remittance Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `remittance_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Remittance Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `remittance_status` SET TAGS ('dbx_business_glossary_term' = 'Remittance Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `remittance_status` SET TAGS ('dbx_value_regex' = 'collected|remitted_to_shipper|pending_remittance|failed_collection|partial_collection|disputed');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `service_charge_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Percentage');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `service_line` SET TAGS ('dbx_value_regex' = 'express_parcel|freight|ecommerce_fulfillment|last_mile');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `variance_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cod_collection` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_value_regex' = 'consignee_refused|partial_payment|incorrect_amount|currency_shortage|payment_dispute|other');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Dispute Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Invoice Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolution Approver Employee Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `route_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Route Exception Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `shipment_carbon_footprint_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Carbon Footprint Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `assigned_to_team` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Team');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `assigned_to_user` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `credit_note_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Note Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Rating');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_category` SET TAGS ('dbx_business_glossary_term' = 'Dispute Category');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_category` SET TAGS ('dbx_value_regex' = 'pricing|operations|documentation|compliance|service_quality|billing_error');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|under_review|escalated|resolved_accepted|resolved_rejected|partially_accepted');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_value_regex' = 'rate_dispute|weight_dispute|service_failure|duplicate_charge|unauthorized_surcharge|sla_breach_deduction');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `disputed_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Disputed Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `raised_by` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised By');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `raised_channel` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Channel');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `raised_channel` SET TAGS ('dbx_value_regex' = 'email|phone|web_portal|edi|salesforce_case|manual_entry');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `raised_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Raised Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `reason_narrative` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Narrative');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^DSP-[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_business_glossary_term' = 'Resolution Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'full_credit|partial_credit|no_credit|rate_adjustment|rebill|waiver');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `root_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `service_failure_type` SET TAGS ('dbx_business_glossary_term' = 'Service Failure Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `shipment_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `sla_target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `lane_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Performance Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `original_recognition_revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Original Revenue Recognition ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `accounting_period` SET TAGS ('dbx_value_regex' = '^d{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `contract_modification_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Modification Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `deferred_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Deferred Revenue Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `gl_revenue_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Revenue Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `ifrs15_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS 15 Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `progress_measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Progress Measurement Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `progress_measurement_method` SET TAGS ('dbx_value_regex' = 'output_method|input_method|time_elapsed|costs_incurred|units_delivered');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `progress_percentage` SET TAGS ('dbx_business_glossary_term' = 'Progress Percentage Complete');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Recognition Event Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_method` SET TAGS ('dbx_value_regex' = 'point_in_time|over_time');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognition_trigger` SET TAGS ('dbx_business_glossary_term' = 'Recognition Trigger Event');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `recognized_amount` SET TAGS ('dbx_business_glossary_term' = 'Recognized Revenue Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Reversal Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Revenue Reversal Reason');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `sap_revenue_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP S/4HANA Revenue Recognition Document Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `shipment_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `transaction_price_allocated` SET TAGS ('dbx_business_glossary_term' = 'Transaction Price Allocated to Obligation');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `variable_consideration_amount` SET TAGS ('dbx_business_glossary_term' = 'Variable Consideration Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`revenue_recognition` ALTER COLUMN `variable_consideration_flag` SET TAGS ('dbx_business_glossary_term' = 'Variable Consideration Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` SET TAGS ('dbx_subdomain' = 'account_configuration');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `parent_billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Billing Account ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `business_area_code` SET TAGS ('dbx_business_glossary_term' = 'Business Area Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `business_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `consolidated_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Billing Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'approved|pending|suspended|revoked');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` SET TAGS ('dbx_subdomain' = 'account_configuration');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `tax_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Schedule ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`tax_schedule` ALTER COLUMN `tax_account_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Account Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`payment_term` SET TAGS ('dbx_subdomain' = 'account_configuration');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` SET TAGS ('dbx_subdomain' = 'cash_collections');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `dunning_record_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Record ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Collector ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Receivable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Contact Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `collections_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Collections Agency Name');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `collections_agency_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Collections Agency Referral Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `collections_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Collections Referral Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'email|letter|phone|sms|edi|portal');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `communication_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Communication Sent Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `customer_response_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Response Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `customer_response_type` SET TAGS ('dbx_value_regex' = 'payment_promise|dispute_raised|payment_plan_request|no_response|partial_payment|full_payment');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Dunning Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `dunning_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Dunning Fee Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `dunning_level` SET TAGS ('dbx_value_regex' = 'first_reminder|second_reminder|final_notice|legal_notice|collections_referral|write_off_review');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `dunning_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Dunning Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `dunning_status` SET TAGS ('dbx_business_glossary_term' = 'Dunning Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `dunning_status` SET TAGS ('dbx_value_regex' = 'pending|sent|acknowledged|resolved|escalated|closed');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `interest_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `oldest_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Oldest Invoice Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `promised_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Promised Payment Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `promised_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Payment Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `response_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Response Received Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `sap_dunning_run_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Dunning Run ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `total_overdue_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Overdue Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `write_off_recommendation_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Recommendation Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_record` ALTER COLUMN `write_off_recommendation_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Recommendation Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` SET TAGS ('dbx_subdomain' = 'cash_collections');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_id` SET TAGS ('dbx_business_glossary_term' = 'Write-Off ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Receivable Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `bad_debt_provision_release_amount` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Provision Release Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `collection_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Name');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `collection_agency_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Referral Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `days_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Outstanding');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `gl_provision_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Provision Account');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `gl_write_off_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Write-Off Account');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `insolvency_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Insolvency Case Reference');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `invoice_references` SET TAGS ('dbx_business_glossary_term' = 'Invoice References');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `legal_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `net_write_off_impact` SET TAGS ('dbx_business_glossary_term' = 'Net Write-Off Impact');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `original_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Description');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `recovery_flag` SET TAGS ('dbx_business_glossary_term' = 'Recovery Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `sap_write_off_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Write-Off Document Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|posted|reversed|cancelled');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_type` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_type` SET TAGS ('dbx_value_regex' = 'bad_debt|commercial_settlement|immaterial_balance|statute_limitation|customer_insolvency|uncontactable');
ALTER TABLE `transport_shipping_ecm`.`billing`.`write_off` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `consolidated_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Invoice ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `billing_location_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `billing_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `consolidated_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `consolidated_invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,4}-[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `consolidation_method` SET TAGS ('dbx_business_glossary_term' = 'Consolidation Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `constituent_invoice_references` SET TAGS ('dbx_business_glossary_term' = 'Constituent Invoice References');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `edi_acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Acknowledgement Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `edi_acknowledgement_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|rejected|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `edi_transmission_date` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transmission Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `edi_transmission_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transmission Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `invoice_due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `invoice_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Issue Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `invoice_line_count` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Count');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partially_paid|paid|overpaid|refunded');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `revenue_recognition_period` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Period');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `revenue_recognition_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `sap_billing_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Billing Document Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `sap_billing_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `shipment_count` SET TAGS ('dbx_business_glossary_term' = 'Shipment Count');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `total_accessorial_charges` SET TAGS ('dbx_business_glossary_term' = 'Total Accessorial Charges');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `total_customs_duties` SET TAGS ('dbx_business_glossary_term' = 'Total Customs Duties');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `total_freight_charges` SET TAGS ('dbx_business_glossary_term' = 'Total Freight Charges');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `total_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `total_surcharges` SET TAGS ('dbx_business_glossary_term' = 'Total Surcharges');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`consolidated_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` SET TAGS ('dbx_subdomain' = 'account_configuration');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `charge_event_id` SET TAGS ('dbx_business_glossary_term' = 'Charge Event Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered By User ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `service_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Service Scope Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `audit_exception_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Exception Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `audit_exception_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'not_audited|passed|failed|pending_review|exception');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `bol_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `business_unit` SET TAGS ('dbx_value_regex' = 'express|freight|supply_chain|ecommerce|contract_logistics');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `chargeable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `deferral_reason` SET TAGS ('dbx_business_glossary_term' = 'Deferral Reason');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `event_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Event Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `event_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'shipment_delivered|pod_confirmed|customs_cleared|warehouse_release|milestone_reached|period_end');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `invoice_generation_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Generation Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `invoice_generation_status` SET TAGS ('dbx_value_regex' = 'pending|generated|suppressed|deferred|failed|cancelled');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `manual_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Manual Trigger Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `order_reference` SET TAGS ('dbx_business_glossary_term' = 'Order Reference');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `order_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'FourKites|SAP_TM|Oracle_TMS|Manhattan_WMS|Descartes_Customs|Manual');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `suppression_reason` SET TAGS ('dbx_business_glossary_term' = 'Suppression Reason');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`charge_event` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `intercompany_billing_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Billing ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `intercompany_settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Settlement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `billing_date` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Billing Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `business_area` SET TAGS ('dbx_business_glossary_term' = 'Business Area');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `business_area` SET TAGS ('dbx_value_regex' = 'express_parcel|freight_forwarding|supply_chain|ecommerce_fulfillment|contract_logistics|last_mile');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `dispute_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Due Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `ifrs_elimination_flag` SET TAGS ('dbx_business_glossary_term' = 'IFRS Elimination Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `markup_amount` SET TAGS ('dbx_business_glossary_term' = 'Markup Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Billing Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `originating_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Originating Legal Entity Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `originating_entity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `originating_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Originating Legal Entity Name');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `receiving_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Legal Entity Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `receiving_entity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `receiving_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Legal Entity Name');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `sap_intercompany_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP S/4HANA Intercompany Document Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `sap_intercompany_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Service Description');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Service Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'shared_services|cross_border_handling|cost_allocation|freight_forwarding|warehouse_services|it_services');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Settlement Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `settlement_period` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `settlement_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|M(0[1-9]|1[0-2]))$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|approved|settled|disputed|cancelled|reversed');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `shipment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Treatment Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `tax_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `total_billing_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Intercompany Billing Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Intercompany Transaction Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `transaction_reference_number` SET TAGS ('dbx_value_regex' = '^IC[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `transfer_pricing_basis` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Basis');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `transfer_pricing_basis` SET TAGS ('dbx_value_regex' = 'cost_plus|market_price|resale_minus|comparable_uncontrolled_price|profit_split|transactional_net_margin');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`intercompany_billing` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` SET TAGS ('dbx_subdomain' = 'cash_collections');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `advance_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `advance_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `bank_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'online_portal|mobile_app|bank_transfer|in_person|mail|edi');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Type');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'freight_deposit|customs_duty_prepayment|cod_float|general_credit|dap_prepayment|ddp_prepayment');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|discrepancy');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `refund_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Refund Reference Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `remittance_advice_reference` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Reference');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `sap_down_payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Down Payment Document Number');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `shipment_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`advance_payment` ALTER COLUMN `utilized_amount` SET TAGS ('dbx_business_glossary_term' = 'Utilized Amount');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` SET TAGS ('dbx_subdomain' = 'cash_collections');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` SET TAGS ('dbx_association_edges' = 'billing.dunning_record,billing.invoice');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` ALTER COLUMN `dunning_invoice_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Invoice Coverage Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` ALTER COLUMN `dunning_record_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Invoice Coverage - Dunning Record Id');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Dunning Invoice Coverage - Invoice Id');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` ALTER COLUMN `communication_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Communication Sent Flag');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` ALTER COLUMN `customer_response_for_invoice` SET TAGS ('dbx_business_glossary_term' = 'Customer Response for Invoice');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` ALTER COLUMN `days_past_due_at_dunning` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due at Dunning');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` ALTER COLUMN `dunning_level_for_invoice` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level for Invoice');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` ALTER COLUMN `invoice_amount_at_dunning` SET TAGS ('dbx_business_glossary_term' = 'Invoice Amount at Dunning');
ALTER TABLE `transport_shipping_ecm`.`billing`.`dunning_invoice_coverage` ALTER COLUMN `overdue_invoice_references` SET TAGS ('dbx_business_glossary_term' = 'Overdue Invoice References');
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` SET TAGS ('dbx_subdomain' = 'revenue_accounting');
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`performance_obligation` ALTER COLUMN `parent_performance_obligation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`debit_note` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`debit_note` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `transport_shipping_ecm`.`billing`.`debit_note` ALTER COLUMN `debit_note_id` SET TAGS ('dbx_business_glossary_term' = 'Debit Note Identifier');
ALTER TABLE `transport_shipping_ecm`.`billing`.`debit_note` ALTER COLUMN `reversed_debit_note_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`billing`.`service_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`billing`.`service_line` SET TAGS ('dbx_subdomain' = 'carrier_settlements');
ALTER TABLE `transport_shipping_ecm`.`billing`.`service_line` ALTER COLUMN `service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Service Line Identifier');
