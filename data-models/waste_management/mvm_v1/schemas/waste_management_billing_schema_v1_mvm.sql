-- Schema for Domain: billing | Business: Waste Management | Version: v1_mvm
-- Generated on: 2026-05-07 22:44:05

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`billing` COMMENT 'Revenue cycle management including invoice generation, usage-based billing (tonnage, pickups, container rentals), tipping fee schedules, rate management, payment processing, accounts receivable (AR), collections, payment plans, billing disputes, adjustments, and revenue recognition. Supports multiple billing models (subscription, transactional, tipping fees) for both residential and commercial accounts. Integrates with Oracle Revenue Management and SAP FI/CO. Supports GAAP/IFRS revenue recognition and SOX compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique identifier for the invoice record. Primary key.',
    `amendment_id` BIGINT COMMENT 'Foreign key linking to contract.amendment. Business justification: Invoices generated after a contract amendment must reference the amendment that triggered rate or scope changes. Revenue recognition, customer dispute resolution, and audit trails in waste management ',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to billing.ar_account. Business justification: An invoice posts to an AR sub-ledger account. The ar_account tracks the outstanding balance, aging buckets, and collection status for the customer. Adding ar_account_id to invoice creates the direct A',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.service_area. Business justification: Invoices must be attributed to service areas for franchise fee allocation, municipal revenue sharing, regulatory reporting to local authorities, and geographic revenue analysis. Critical for complianc',
    `billing_term_id` BIGINT COMMENT 'Foreign key linking to contract.billing_term. Business justification: Invoices must reference the contract billing_term that governed their generation to enforce payment due dates, grace periods, and dunning procedures. Contract compliance reporting and collections mana',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to service.bundle. Business justification: Bundle invoicing: when a customer is billed for a service bundle, the invoice header must reference the bundle for bundle revenue recognition, bundle discount reconciliation, and bundle performance re',
    `commodity_sale_id` BIGINT COMMENT 'Foreign key linking to recycling.commodity_sale. Business justification: Commodity sales to buyers generate AR invoices for payment collection. Every sale transaction must be invoiced. Core accounts receivable process in recycling operations requires linking invoices to or',
    `contract_id` BIGINT COMMENT 'Reference to the master service contract or service level agreement governing the services billed on this invoice.',
    `customer_account_id` BIGINT COMMENT 'FK to customer.customer_account.customer_account_id — Fundamental billing relationship: every invoice must link to the customer being billed. Required for AR aging, collections, and customer portal display.',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.billing_cycle. Business justification: Invoice currently has billing_cycle (STRING) denormalized field but no FK to billing_cycle master. The billing_cycle table contains full cycle configuration including payment terms, due date offsets, ',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Invoices for facility-based services (landfill tipping fees, transfer station processing, MRF sorting) require facility attribution for revenue recognition by operating segment, facility P&L reporting',
    `performance_obligation_id` BIGINT COMMENT 'Foreign key linking to contract.performance_obligation. Business justification: ASC 606 revenue recognition compliance requires invoices to reference the performance obligation they satisfy. Waste management companies must allocate transaction prices to performance obligations an',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Invoices for permitted facility services (landfill tipping, transfer station fees) must reference the authorizing operating permit for regulatory audit trails and compliance verification. Permit-based',
    `pricing_id` BIGINT COMMENT 'Foreign key linking to contract.pricing. Business justification: Invoices generated after a rate escalation must reference the specific pricing version active at billing time for revenue recognition (ASC 606) and rate dispute resolution. Waste management billing au',
    `program_id` BIGINT COMMENT 'Foreign key linking to recycling.recycling_program. Business justification: Municipal and commercial recycling programs generate periodic program-level invoices for processing fees and revenue share. Linking invoice to recycling_program enables program-level billing reconcili',
    `run_id` BIGINT COMMENT 'Foreign key linking to billing.billing_run. Business justification: Invoices are generated by batch billing runs, but invoice table currently has no FK to billing_run. Adding billing_run_id FK establishes audit trail of which batch execution created each invoice, enab',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Invoices are issued for services at a specific service address, required for tax jurisdiction determination, franchise fee calculation, and regulatory reporting by municipality. service_address_line1,',
    `sla_term_id` BIGINT COMMENT 'Foreign key linking to contract.sla_term. Business justification: SLA penalty and credit invoices in waste management must reference the specific SLA term that triggered the charge or credit. Regulatory reporting, customer dispute resolution, and contract performanc',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Net adjustments applied to the invoice for credits, billing corrections, dispute resolutions, or service exceptions.',
    `billing_model_type` STRING COMMENT 'Classification of the billing approach used for this invoice: subscription (fixed recurring), transactional (per-pickup), tipping fee (per-ton disposal), usage-based (metered), hybrid, or one-time charge.. Valid values are `subscription|transactional|tipping_fee|usage_based|hybrid|one_time`',
    `billing_period_end_date` DATE COMMENT 'End date of the service period covered by this invoice.',
    `billing_period_start_date` DATE COMMENT 'Start date of the service period covered by this invoice.',
    `cost_center_code` STRING COMMENT 'Cost center responsible for the services billed on this invoice. Used for internal profitability analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this invoice (typically USD for US operations).. Valid values are `^[A-Z]{3}$`',
    `customer_type` STRING COMMENT 'Classification of the customer being billed: residential household, commercial business, industrial facility, municipal contract, or government entity.. Valid values are `residential|commercial|industrial|municipal|government`',
    `delivery_method` STRING COMMENT 'Method by which the invoice was or will be delivered to the customer: email, postal mail, customer portal, or EDI.. Valid values are `email|postal_mail|customer_portal|edi`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discounts applied to the invoice, including promotional discounts, volume discounts, or contractual rate reductions.',
    `dispute_date` DATE COMMENT 'Date the customer initiated the dispute on this invoice.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the customer has disputed this invoice. True if disputed, false otherwise.',
    `dispute_reason` STRING COMMENT 'Customer-provided or agent-recorded reason for disputing the invoice (e.g., service not provided, incorrect charges, billing error).',
    `due_date` DATE COMMENT 'Date by which payment is expected from the customer. Used for aging buckets and collections prioritization.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which revenue from this invoice is posted in the SAP FI/CO system.. Valid values are `^[0-9]{4,10}$`',
    `invoice_date` DATE COMMENT 'Date the invoice was generated and issued to the customer. Used for aging analysis and revenue recognition.',
    `invoice_number` STRING COMMENT 'Externally-visible unique invoice number used for customer communication, payment reference, and accounts receivable tracking.. Valid values are `^INV-[0-9]{8,12}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the billing and collections workflow. [ENUM-REF-CANDIDATE: draft|issued|sent|paid|partially_paid|overdue|void|disputed|cancelled — 9 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text notes or comments related to this invoice, including special instructions, billing exceptions, or customer communications.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining unpaid amount on the invoice (total_amount minus paid_amount). Used for accounts receivable aging and collections.',
    `paid_amount` DECIMAL(18,2) COMMENT 'Total amount paid by the customer against this invoice to date. Used to calculate outstanding balance.',
    `payment_date` DATE COMMENT 'Date the invoice was fully paid by the customer. Null if unpaid or partially paid.',
    `payment_method` STRING COMMENT 'Primary payment instrument or method the customer is expected to use for this invoice.. Valid values are `credit_card|ach|check|wire_transfer|cash|auto_pay`',
    `payment_terms` STRING COMMENT 'Contractual payment terms specifying when payment is due relative to the invoice date.. Valid values are `net_15|net_30|net_45|net_60|due_on_receipt|prepaid`',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue from this invoice is recognized in the general ledger per GAAP/IFRS standards.',
    `revenue_recognition_period` STRING COMMENT 'Fiscal period (YYYY-MM format) in which revenue from this invoice is recognized for financial reporting.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `source_system` STRING COMMENT 'System of record that originated this invoice: Oracle Revenue Management, SAP SD, AMCS Platform, or manual entry.. Valid values are `oracle_revenue_management|sap_sd|amcs_platform|manual_entry`',
    `source_system_invoice_reference` STRING COMMENT 'Original invoice identifier in the source system. Used for traceability and reconciliation.',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Sum of all line item charges before taxes, fees, adjustments, and discounts.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax, use tax, or other government-mandated taxes applied to this invoice based on service jurisdiction.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final amount due from the customer after applying subtotal, taxes, discounts, and adjustments. This is the amount the customer must pay.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was last modified.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Core billing document representing a charge issued to a residential or commercial customer for waste collection, recycling, container rental, tipping fees, or other environmental services. Captures invoice number, billing period, due date, total amount, tax, invoice status (draft, issued, paid, void, disputed), billing model type (subscription, transactional, tipping fee), service address, invoice source system (Oracle Revenue Management / SAP SD), and revenue recognition period. SSOT for all customer-facing billing documents.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key for this entity.',
    `asset_container_id` BIGINT COMMENT 'Reference to the specific container associated with this charge. Used for container rental fees, service charges tied to specific containers, and asset tracking.',
    `bale_id` BIGINT COMMENT 'Foreign key linking to recycling.bale. Business justification: Individual bales sold to commodity buyers generate specific invoice line items. High-value commodity transactions require bale-level traceability to invoice lines for quality disputes, payment reconci',
    `billing_tipping_fee_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.billing_tipping_fee_schedule. Business justification: Invoice lines for tipping fees (landfill disposal charges) should reference the specific tipping fee schedule used for rating. While invoice_line.tipping_fee_rate_id references collection.tipping_fee_',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to service.bundle. Business justification: Bundle discount allocation and bundle component billing reconciliation require each invoice line to reference the service bundle it belongs to. Bundle pricing audits and promotional discount tracking ',
    `container_placement_id` BIGINT COMMENT 'Foreign key linking to collection.container_placement. Business justification: Container rental charges are billed based on placement records that track deployment dates, removal dates, rental duration, and container condition for accurate billing and asset tracking.',
    `contract_id` BIGINT COMMENT 'Reference to the customer contract governing pricing and terms for this line item. Links billing to contractual agreements and service level agreements (SLA).',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Equipment rental billing lines (compactors, balers, transfer trailers rented to commercial customers) must reference the specific fixed asset being rented. Asset utilization revenue reporting and rent',
    `frequency_plan_id` BIGINT COMMENT 'Foreign key linking to service.frequency_plan. Business justification: Invoice lines for recurring collection services must reference the frequency plan (weekly, bi-weekly, on-call) to validate billing periods, prorate charges for partial periods, and reconcile billed se',
    `haul_manifest_id` BIGINT COMMENT 'Foreign key linking to collection.haul_manifest. Business justification: Invoicing outbound haul services requires linking to the manifest that documents waste classification, tonnage, regulatory compliance, and destination facility for accurate billing and reporting.',
    `inbound_load_id` BIGINT COMMENT 'Foreign key linking to recycling.inbound_load. Business justification: MRF tipping fee billing: invoice lines for recycling load tipping fees and contamination surcharges must reference the specific inbound_load for weight reconciliation and charge audit. Environmental s',
    `invoice_id` BIGINT COMMENT 'Reference to the parent invoice header that contains this line item. Links this line to the overall customer invoice.',
    `load_ticket_id` BIGINT COMMENT 'Foreign key linking to collection.load_ticket. Business justification: Transfer station tipping fee invoicing requires linking to the load ticket that captured inbound tonnage, waste classification, and fee calculation for regulatory compliance and customer billing.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Invoice lines should reference the service catalog offering being billed. This provides a direct link from billing to the service catalog, enabling accurate service-level revenue reporting. The servic',
    `on_demand_request_id` BIGINT COMMENT 'Foreign key linking to collection.on_demand_request. Business justification: One-time service charges for bulk pickups, extra collections, and special requests are billed directly from the on-demand request that authorized the service and captured pricing.',
    `outbound_haul_id` BIGINT COMMENT 'Foreign key linking to collection.outbound_haul. Business justification: Invoicing outbound transportation from transfer stations to disposal facilities requires linking to the haul record with actual tonnage, destination facility, and transportation costs for accurate bil',
    `outbound_shipment_id` BIGINT COMMENT 'Foreign key linking to recycling.outbound_shipment. Business justification: Freight charges, transportation fees, and export handling costs on outbound commodity shipments are billed as invoice line items. Linking invoice_line to outbound_shipment enables freight charge pass-',
    `performance_obligation_id` BIGINT COMMENT 'Foreign key linking to contract.performance_obligation. Business justification: ASC 606 requires each invoice line to be traceable to the performance obligation it satisfies for granular revenue recognition. Waste management revenue recognition reports and external audit support ',
    `pickup_event_id` BIGINT COMMENT 'Foreign key linking to collection.pickup_event. Business justification: Proof-of-service billing for residential and commercial collection requires linking invoice charges to RFID-confirmed pickup events with timestamps, GPS coordinates, and lift confirmation for dispute ',
    `program_id` BIGINT COMMENT 'Foreign key linking to recycling.recycling_program. Business justification: Processing fees, revenue share credits, and program administration charges are billed as individual invoice line items tied to a specific recycling program. This link enables program-level billing det',
    `rate_component_id` BIGINT COMMENT 'Foreign key linking to billing.rate_component. Business justification: Each invoice line represents a specific charge component priced using a rate component definition. While invoice_line already has billing_rate_schedule_id (the parent schedule), it should also referen',
    `residue_disposal_id` BIGINT COMMENT 'Foreign key linking to recycling.residue_disposal. Business justification: Residue disposal costs are rebilled to customers as pass-through charges on invoice lines. MRFs must link invoice line items to specific disposal events for cost recovery, margin analysis, and custome',
    `rolloff_order_id` BIGINT COMMENT 'Foreign key linking to collection.rolloff_order. Business justification: Rolloff rental and disposal invoicing requires direct link to the order defining container size, rental duration, actual weight, overage charges, and service dates for accurate billing.',
    `route_execution_id` BIGINT COMMENT 'Foreign key linking to collection.route_execution. Business justification: Service-to-bill reconciliation: invoice lines for route-based service charges must reference the route_execution that delivered the service. Billing reconciliation reports join invoice_line to route_e',
    `route_id` BIGINT COMMENT 'Reference to the collection route associated with this service charge. Links billing to operational route execution for service verification.',
    `scale_transaction_id` BIGINT COMMENT 'Foreign key linking to collection.scale_transaction. Business justification: Tonnage-based charges require direct link to the scale transaction that captured certified weights, scale calibration date, and weighmaster certification for accurate billing and audit compliance.',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Invoice line items are for services rendered at a specific service address. Multi-site commercial accounts require address-level billing detail for cost allocation, franchise fee reporting by municipa',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Each invoice line item corresponds to a specific service enrollment (e.g., weekly recycling pickup, hazardous waste collection). This link enables enrollment-level revenue reporting, contract billing ',
    `service_exception_id` BIGINT COMMENT 'Foreign key linking to collection.service_exception. Business justification: Exception-based credit line traceability: invoice credit lines issued for service exceptions (missed pickups, contamination events) must reference the originating service_exception. Billing auditors a',
    `service_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to service.service_rate_schedule. Business justification: Rate audit process: billing_rate_schedule (billing engine) and service_rate_schedule (service catalog) are distinct products. Invoice line must reference the service catalog rate to enable rate reconc',
    `service_schedule_id` BIGINT COMMENT 'Foreign key linking to collection.service_schedule. Business justification: Recurring service billing reconciliation: invoice lines for scheduled recurring service charges reference the service_schedule that defines contracted frequency and container configuration. Billing au',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: SLA breach credits appear as invoice lines. The invoice line representing an SLA credit must reference the SLA definition that was breached to support SLA financial impact reporting and customer SLA p',
    `stop_id` BIGINT COMMENT 'Foreign key linking to collection.collection_stop. Business justification: Per-stop billing reconciliation: per-lift and per-stop charge invoice lines must reference the collection_stop for stop-level billing accuracy verification. Commercial customers with per-stop pricing ',
    `surcharge_id` BIGINT COMMENT 'Foreign key linking to billing.surcharge. Business justification: Invoice line items can include surcharges (fuel surcharge, environmental fees, disposal surcharges) beyond base service charges. The surcharge master table defines available surcharges with rates, app',
    `tax_rule_id` BIGINT COMMENT 'Foreign key linking to billing.tax_rule. Business justification: Invoice line items currently have tax_code (STRING) and tax_amount but no FK to the tax_rule master. Tax rules define jurisdiction-specific tax rates, calculation methods, and applicability. Adding ta',
    `tipping_fee_rate_id` BIGINT COMMENT 'Reference to the tipping fee rate schedule applied to this disposal charge. Links to the rate card for landfill or disposal facility charges.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Waste stream revenue reporting and EPA/state diversion reporting require invoice lines to be classified by canonical waste stream. material_type is a denormalized representation. Regulatory revenue-by',
    `weight_ticket_id` BIGINT COMMENT 'Reference to the weight ticket or scale transaction for tonnage-based charges. Links billing to actual measured waste weight at disposal facilities.',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the reason for any billing adjustment on this line (e.g., service credit, billing correction, dispute resolution, promotional discount). Used for audit trail and dispute management.',
    `charge_category` STRING COMMENT 'Revenue category classification for this line item. Used for financial reporting and revenue recognition (e.g., service charge, rental fee, disposal fee, fuel surcharge, environmental levy, late fee).. Valid values are `service_charge|rental_fee|disposal_fee|fuel_surcharge|environmental_fee|late_fee`',
    `cost_center_code` STRING COMMENT 'Cost center code associated with the service delivery. Used for internal cost allocation and profitability analysis by business unit or service area.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line record was first created in the billing system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line (e.g., USD, CAD, MXN). Supports multi-currency billing.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to this line item. Reduces the line amount based on promotional offers, contract terms, or customer agreements.',
    `dispute_date` DATE COMMENT 'Date when the customer disputed this line item. Used for tracking dispute aging and resolution timelines.',
    `gl_account_code` STRING COMMENT 'General ledger account code for revenue posting. Maps this line item to the appropriate revenue account in the financial system for accounting and reporting.',
    `invoice_line_description` STRING COMMENT 'Detailed textual description of the charge appearing on the customer invoice. Provides human-readable explanation of what is being billed.',
    `is_disputed` BOOLEAN COMMENT 'Boolean flag indicating whether this line item is under dispute by the customer. Used for accounts receivable management and dispute resolution tracking.',
    `line_amount` DECIMAL(18,2) COMMENT 'Extended amount for this line item before taxes and adjustments. Calculated as quantity multiplied by unit rate, representing the base charge.',
    `line_number` STRING COMMENT 'Sequential line number within the invoice, used for ordering and referencing specific charges on the invoice document.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line record was last modified. Used for change tracking and audit compliance.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final net amount for this line item after applying discounts and adding taxes. Represents the total charge to the customer for this line.',
    `quantity` DECIMAL(18,2) COMMENT 'Numeric quantity of the service or item being billed. Represents count of pickups, tons of waste, days of rental, or other measurable units.',
    `revenue_recognition_rule` STRING COMMENT 'Rule governing when and how revenue from this line item is recognized. Supports GAAP/IFRS compliance (e.g., immediate, deferred, prorated over service period, milestone-based).. Valid values are `immediate|deferred|prorated|milestone`',
    `revenue_recognized_date` DATE COMMENT 'Date when revenue from this line item was recognized in the general ledger. Used for GAAP/IFRS compliance and financial period closing.',
    `service_date` DATE COMMENT 'Date when the service was performed or the charge was incurred. Used for service period tracking and revenue recognition timing.',
    `service_period_end_date` DATE COMMENT 'End date of the service period covered by this charge. Defines the conclusion of the billing period for recurring or subscription services.',
    `service_period_start_date` DATE COMMENT 'Start date of the service period covered by this charge. Used for subscription-based and recurring services to define the billing period.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charged on this line item. Includes sales tax, environmental levies, and other applicable taxes based on jurisdiction and service type.',
    `tonnage` DECIMAL(18,2) COMMENT 'Weight of waste in tons for this line item. Used for tonnage-based billing at landfills, transfer stations, and disposal facilities. Measured in short tons (US) or metric tonnes.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity field. Defines how the service is quantified (e.g., pickup, ton, day, month, cubic yard, gallon, each, hour). [ENUM-REF-CANDIDATE: pickup|ton|day|month|cubic_yard|gallon|each|hour — 8 candidates stripped; promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'Price per unit of measure for this line item. The rate charged per pickup, per ton, per day, etc., before applying quantity.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Individual line-item detail on a customer invoice representing a specific charge component — e.g., MSW pickup charge, container rental fee, fuel surcharge, environmental levy, tonnage-based tipping fee, or recycling processing fee. Captures service type, unit of measure (pickup, ton, day, month), quantity, unit rate, extended amount, tax code, GL account code, and revenue category. Supports itemized billing for both residential and commercial accounts.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction. Primary key.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to billing.ar_account. Business justification: Payments directly affect AR account balances and aging buckets. While payment.customer_account_id provides customer context and payment.invoice_id links to specific invoices, a direct FK to ar_account',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who made the payment. Links to the customer master record.',
    `invoice_id` BIGINT COMMENT 'Identifier of the primary invoice this payment is applied against. Null for prepayments or unapplied payments.',
    `payment_plan_id` BIGINT COMMENT 'Foreign key linking to billing.payment_plan. Business justification: When a customer is on a payment plan, individual installment payments must reference the payment plan they satisfy. This FK enables tracking of which payments fulfill which installment obligations, su',
    `amount` DECIMAL(18,2) COMMENT 'Total amount of the payment received from the customer, in the payment currency.',
    `applied_amount` DECIMAL(18,2) COMMENT 'Portion of the payment amount that has been applied to one or more invoices.',
    `ar_batch_reference` STRING COMMENT 'Identifier of the accounts receivable batch in which this payment was processed, used for AR reconciliation and audit.',
    `bank_account_number` STRING COMMENT 'Bank account number from which the payment was drawn (for ACH, EFT, wire transfers). Masked or tokenized for security.',
    `bank_deposit_batch_reference` STRING COMMENT 'Identifier of the bank deposit batch in which this payment was deposited, used for cash management and reconciliation.',
    `bank_routing_number` STRING COMMENT 'Bank routing number (ABA number) for ACH, EFT, or wire transfer payments.',
    `channel` STRING COMMENT 'The interface or channel through which the payment was submitted (customer portal, mail, phone, in-person, bank transfer, auto-pay, third-party processor). [ENUM-REF-CANDIDATE: customer_portal|mail|phone|in_person|bank_transfer|auto_pay|third_party — 7 candidates stripped; promote to reference product]',
    `cleared_date` DATE COMMENT 'The date the payment cleared the bank and funds became available.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system.',
    `credit_card_last_four` STRING COMMENT 'Last four digits of the credit or debit card used for payment, for reference and reconciliation purposes.. Valid values are `^[0-9]{4}$`',
    `credit_card_type` STRING COMMENT 'Type of credit or debit card used for payment (Visa, MasterCard, American Express, Discover, other).. Valid values are `visa|mastercard|amex|discover|other`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `deposit_date` DATE COMMENT 'The date the payment was deposited into the company bank account.',
    `gl_date` DATE COMMENT 'The accounting date on which the payment was posted to the general ledger for financial reporting purposes.',
    `gl_period` STRING COMMENT 'The accounting period (e.g., 2024-01, Q1-2024) in which the payment was posted to the general ledger.',
    `lockbox_batch_reference` STRING COMMENT 'Identifier of the lockbox batch for payments received via bank lockbox service, used for automated payment processing and reconciliation.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified the payment record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the payment transaction, including customer instructions, special handling, or internal annotations.',
    `nsf_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged to the customer for a returned payment due to non-sufficient funds.',
    `payment_date` DATE COMMENT 'The date the payment was received or recorded in the system.',
    `payment_number` STRING COMMENT 'Business-facing unique reference number for the payment transaction, used for customer communication and reconciliation.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment: received, cleared, applied to invoice, unapplied, returned (NSF), reversed, held for review, or voided. [ENUM-REF-CANDIDATE: received|cleared|applied|unapplied|returned|reversed|held|voided — 8 candidates stripped; promote to reference product]',
    `payment_type` STRING COMMENT 'Classification of the payment transaction: standard payment against invoice, prepayment, advance deposit, retainer, refund, or credit memo application.. Valid values are `standard|prepayment|deposit|retainer|refund|credit_memo`',
    `prepayment_expiry_date` DATE COMMENT 'Expiration date for prepayments or advance deposits, after which the unapplied amount may be refunded or forfeited per contract terms.',
    `processor` STRING COMMENT 'Name of the third-party payment processor or gateway used to process the payment (e.g., Stripe, PayPal, Authorize.Net).',
    `processor_transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the payment processor or gateway for tracking and reconciliation.',
    `reference` STRING COMMENT 'External reference number provided by the customer or payment processor (check number, transaction ID, confirmation code).',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount refunded to the customer from this payment, if applicable.',
    `refund_date` DATE COMMENT 'The date the refund was issued to the customer.',
    `refund_status` STRING COMMENT 'Status of any refund associated with this payment: not refunded, refund requested, refund approved, refund issued, or refund rejected.. Valid values are `not_refunded|refund_requested|refund_approved|refund_issued|refund_rejected`',
    `reversal_date` DATE COMMENT 'The date the payment was reversed or returned.',
    `reversal_reason` STRING COMMENT 'Reason code or description for payment reversal (NSF, stop payment, customer dispute, processing error, fraud).',
    `source_system` STRING COMMENT 'Name of the source system from which the payment record originated (Oracle AR, SAP FI, Waste Logics, customer portal).',
    `source_system_code` STRING COMMENT 'Unique identifier of the payment record in the source system, used for data lineage and reconciliation.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'Portion of the payment amount that remains unapplied and available for future invoice application or refund.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created the payment record.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Record of a payment or prepayment received from a customer against one or more invoices or as an advance deposit. Captures payment date, payment method (check, ACH, credit card, EFT, lockbox, wire), payment amount, applied amount, unapplied amount, payment reference number, bank deposit batch, payment status (received, cleared, returned, reversed, held), payment type (standard, prepayment, deposit, retainer), prepayment expiry date, refund status, and source system (Oracle AR, SAP FI). SSOT for all customer payment transactions including advance deposits for roll-off rentals and new commercial account mobilizations.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`payment_application` (
    `payment_application_id` BIGINT COMMENT 'Unique identifier for the payment application record. Primary key.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to billing.ar_account. Business justification: A payment application reduces the balance on a specific AR account. While payment already links to ar_account, the payment_application record (which captures the exact allocation of funds to invoices)',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account for which this payment application is processed. Denormalized for reporting performance and customer AR analysis.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice receiving payment application. Links to the invoice record in the billing system.',
    `payment_id` BIGINT COMMENT 'Reference to the payment transaction being applied to invoices. Links to the payment record in the payment processing system.',
    `accounting_period` STRING COMMENT 'The fiscal period identifier (e.g., 2024-Q1, 2024-01) to which this payment application is assigned for financial reporting and period close processes.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'The amount of billing adjustment applied concurrently with this payment application. Used for dispute resolutions, service credits, and billing corrections.',
    `application_date` DATE COMMENT 'The date when the payment was applied to the invoice. This is the business event date used for accounting period assignment and Accounts Receivable (AR) aging calculations.',
    `application_number` STRING COMMENT 'Business identifier for the payment application transaction. Used for tracking and reference in customer service and accounting operations.',
    `application_source` STRING COMMENT 'The system or process that originated this payment application. Manual applications are entered by AR staff; automatic applications are system-matched; lockbox applications come from bank lockbox processing; customer portal applications are self-service; batch imports are from external systems; API applications are from integrated systems.. Valid values are `manual|automatic|lockbox|customer_portal|batch_import|api`',
    `application_status` STRING COMMENT 'Current lifecycle status of the payment application. Pending applications are awaiting approval; applied applications are finalized; reversed applications have been undone; voided applications are cancelled; adjusted applications have been modified post-application.. Valid values are `pending|applied|reversed|voided|adjusted`',
    `application_timestamp` TIMESTAMP COMMENT 'Precise date and time when the payment application was processed in the system. Used for audit trail and transaction sequencing.',
    `application_type` STRING COMMENT 'Classification of how the payment is being applied. Standard applications reduce open AR balance; prepayments are applied to future invoices; credit memo offsets apply credits; dispute settlements resolve billing disputes; overpayment allocations handle excess payments; refund reversals correct previously issued refunds.. Valid values are `standard|prepayment|credit_memo_offset|dispute_settlement|overpayment_allocation|refund_reversal`',
    `applied_amount` DECIMAL(18,2) COMMENT 'The monetary amount from the payment that was applied to this specific invoice. Supports partial payment scenarios where a single payment is split across multiple invoices.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this payment application was approved. Null for auto-approved applications. Used for workflow tracking and compliance reporting.',
    `comments` STRING COMMENT 'Free-text notes or comments about this payment application. Used to document special circumstances, customer requests, dispute resolutions, or manual intervention reasons.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment application record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the applied amount. Supports multi-currency billing scenarios for international commercial accounts.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The amount of early payment discount or settlement discount applied with this payment application. Common in commercial accounts with negotiated payment terms.',
    `discount_date` DATE COMMENT 'The date by which payment must be received to qualify for early payment discount. Used to validate discount eligibility at application time.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The currency exchange rate used to convert payment amount to invoice currency, if cross-currency application. Null for same-currency applications.',
    `exchange_rate_date` DATE COMMENT 'The date for which the exchange rate was determined. Used for foreign exchange gain/loss calculations and audit trail.',
    `exchange_rate_type` STRING COMMENT 'The type of exchange rate used for cross-currency applications. Spot rates are market rates at transaction time; corporate rates are company-defined standard rates; user-defined rates are manually entered.. Valid values are `spot|corporate|user_defined`',
    `gl_date` DATE COMMENT 'The accounting period date when this payment application is posted to the General Ledger (GL). May differ from application_date due to period close rules and accounting calendar constraints.',
    `invoice_balance_after` DECIMAL(18,2) COMMENT 'The outstanding balance of the invoice immediately after this payment application was processed. Used for audit trail and to determine if invoice is fully paid.',
    `invoice_balance_before` DECIMAL(18,2) COMMENT 'The outstanding balance of the invoice immediately before this payment application was processed. Used for audit trail and reconciliation.',
    `is_cross_currency` BOOLEAN COMMENT 'Indicates whether this payment application involves currency conversion (payment currency differs from invoice currency). Used for foreign exchange gain/loss tracking.',
    `is_on_account` BOOLEAN COMMENT 'Indicates whether this payment application represents an on-account credit (payment received without a specific invoice to apply to). True for prepayments and overpayments held for future application.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payment application record was last updated. Used for audit trail and change tracking.',
    `matching_rule_code` STRING COMMENT 'The automated matching rule that was used to apply this payment to the invoice (e.g., exact amount match, invoice number match, customer account match). Used for automatic cash application processes.',
    `original_applied_amount` DECIMAL(18,2) COMMENT 'The initial applied amount before any subsequent adjustments or reversals. Used to track the history of changes to the payment application.',
    `payment_method_code` STRING COMMENT 'The payment instrument used for this payment (e.g., check, ACH, credit card, wire transfer, cash). Denormalized from payment record for application-level reporting.',
    `payment_reference_number` STRING COMMENT 'External reference number from the payment transaction (e.g., check number, ACH trace number, credit card authorization code). Denormalized for reconciliation and customer service.',
    `remaining_unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the original payment that remains unapplied after this application. Used for tracking partial payment scenarios and multi-invoice applications.',
    `reversal_date` DATE COMMENT 'The date when this payment application was reversed, if applicable. Null for active applications. Used to track corrections and adjustments in AR management.',
    `reversal_reason_code` STRING COMMENT 'Standardized code indicating why the payment application was reversed. Examples include payment error, incorrect invoice, customer dispute, NSF (Non-Sufficient Funds), or administrative correction.',
    `reversal_reason_description` STRING COMMENT 'Detailed explanation of why the payment application was reversed. Provides context for audit and customer service inquiries.',
    `writeoff_amount` DECIMAL(18,2) COMMENT 'The amount of invoice balance written off as uncollectible at the time of this payment application. Used in partial payment scenarios where remaining balance is deemed uncollectible.',
    CONSTRAINT pk_payment_application PRIMARY KEY(`payment_application_id`)
) COMMENT 'Association record linking a payment to one or more invoices, capturing how payment funds are allocated across open AR balances. Tracks applied amount per invoice, application date, application type (standard, prepayment, credit memo offset, dispute settlement), and application status. Supports partial payments, overpayments, and multi-invoice payment scenarios common in commercial waste hauling accounts.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`ar_account` (
    `ar_account_id` BIGINT COMMENT 'Unique identifier for the accounts receivable account. Primary key for the AR sub-ledger account representing the financial relationship with a customer.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: AR account is the sub-ledger representation of a billing accounts receivables. While ar_account.customer_account_id provides customer hierarchy linkage, a direct FK to billing_account is essential fo',
    `payment_plan_id` BIGINT COMMENT 'Reference to the active payment plan agreement if the customer is on a payment plan. Null if no payment plan exists.',
    `account_closed_date` DATE COMMENT 'Date when the AR account was closed or terminated. Null for active accounts. Used for churn analysis and account lifecycle tracking.',
    `account_opened_date` DATE COMMENT 'Date when the AR account was first established for the customer. Used to calculate customer tenure and lifetime value.',
    `account_status` STRING COMMENT 'Current lifecycle status of the AR account. Active accounts are in good standing; suspended accounts have service holds; closed accounts are no longer active; write-off accounts have been deemed uncollectible; bankruptcy accounts are in legal proceedings.. Valid values are `active|inactive|suspended|closed|write_off|bankruptcy`',
    `aging_bucket_0_30_days` DECIMAL(18,2) COMMENT 'Outstanding balance for invoices aged 0 to 30 days past due date. Current receivables within normal payment terms. Expressed in USD.',
    `aging_bucket_31_60_days` DECIMAL(18,2) COMMENT 'Outstanding balance for invoices aged 31 to 60 days past due date. Moderately overdue receivables requiring follow-up. Expressed in USD.',
    `aging_bucket_61_90_days` DECIMAL(18,2) COMMENT 'Outstanding balance for invoices aged 61 to 90 days past due date. Significantly overdue receivables requiring escalated collection efforts. Expressed in USD.',
    `aging_bucket_over_90_days` DECIMAL(18,2) COMMENT 'Outstanding balance for invoices aged more than 90 days past due date. Severely overdue receivables at high risk of uncollectibility, may require legal action or write-off consideration. Expressed in USD.',
    `ar_account_number` STRING COMMENT 'Business identifier for the AR account, typically the customer account number used in billing and collections. May align with SAP FI AR account number or Oracle Revenue Management customer account number.',
    `auto_pay_enrolled_flag` BOOLEAN COMMENT 'Indicates whether the customer is enrolled in automatic payment processing. True means payments are automatically processed on due date; false means manual payment required.',
    `available_credit` DECIMAL(18,2) COMMENT 'Remaining credit available to the customer, calculated as credit limit minus current balance. Expressed in USD.',
    `bad_debt_reserve` DECIMAL(18,2) COMMENT 'Amount reserved for potential uncollectible receivables based on aging analysis and credit risk assessment. Used for allowance for doubtful accounts calculation. Expressed in USD.',
    `billing_currency` STRING COMMENT 'ISO 4217 three-letter currency code for invoicing and payments. Typically USD for US operations but may vary for international customers.. Valid values are `^[A-Z]{3}$`',
    `billing_cycle` STRING COMMENT 'Frequency at which the customer is billed for services. Monthly is standard residential; quarterly/annual are common for commercial; on-demand is for transactional services; custom is negotiated frequency.. Valid values are `monthly|quarterly|annual|on_demand|custom`',
    `collection_status` STRING COMMENT 'Current stage in the collections process. Current indicates no collection activity; reminder/notices indicate escalating communication; collections-agency indicates third-party involvement; legal-action indicates court proceedings; payment-plan indicates negotiated repayment; settled indicates resolved. [ENUM-REF-CANDIDATE: current|reminder_sent|first_notice|second_notice|final_notice|collections_agency|legal_action|payment_plan|settled — 9 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this AR account record was first created in the system. Used for audit trail and data lineage.',
    `credit_hold_flag` BOOLEAN COMMENT 'Indicates whether the account is on credit hold. True means services are suspended due to credit issues; false means account is in good standing.',
    `credit_hold_reason` STRING COMMENT 'Reason code for why the account is on credit hold. Over-limit indicates balance exceeds credit limit; past-due indicates overdue invoices; bankruptcy indicates legal proceedings; fraud indicates suspected fraudulent activity; dispute indicates billing dispute; manual-hold indicates administrative hold; none indicates no hold. [ENUM-REF-CANDIDATE: over_limit|past_due|bankruptcy|fraud|dispute|manual_hold|none — 7 candidates stripped; promote to reference product]',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum amount of credit extended to the customer. Services may be suspended if current balance exceeds this limit. Expressed in USD.',
    `credit_status` STRING COMMENT 'Current credit standing of the account. Approved accounts can receive services; on-hold accounts have credit restrictions; under-review accounts are being evaluated; restricted accounts have limited credit; revoked accounts have no credit privileges.. Valid values are `approved|on_hold|under_review|restricted|revoked`',
    `current_balance` DECIMAL(18,2) COMMENT 'Total outstanding balance owed by the customer across all invoices. Represents the sum of all unpaid charges, fees, and adjustments. Expressed in USD.',
    `days_sales_outstanding` STRING COMMENT 'Average number of days it takes the customer to pay invoices. Key metric for assessing payment behavior and credit risk. Calculated as (current balance / average daily sales).',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether there are active billing disputes on the account. True means one or more invoices are disputed; false means no disputes.',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Total amount of charges currently under dispute by the customer. Expressed in USD.',
    `dunning_level` STRING COMMENT 'Current collection escalation level for overdue accounts. 0 indicates no dunning; 1-3 indicate progressive collection notice levels; higher numbers indicate more aggressive collection actions including legal proceedings.',
    `last_invoice_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent invoice issued to the customer. Expressed in USD.',
    `last_invoice_date` DATE COMMENT 'Date of the most recent invoice issued to the customer. Used to track billing activity and calculate days since last invoice.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment received from the customer. Expressed in USD.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received from the customer. Used to track payment history and calculate days since last payment.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this AR account record was last updated. Used for audit trail and change tracking.',
    `paperless_billing_flag` BOOLEAN COMMENT 'Indicates whether the customer has opted for electronic invoicing instead of paper statements. True means electronic delivery only; false means paper statements are sent.',
    `payment_method` STRING COMMENT 'Primary payment method used by the customer. ACH is Automated Clearing House electronic transfer; credit-card is card payment; check is paper check; wire-transfer is bank wire; cash is physical currency; auto-pay is automatic recurring payment; other is alternative methods. [ENUM-REF-CANDIDATE: ach|credit_card|check|wire_transfer|cash|auto_pay|other — 7 candidates stripped; promote to reference product]',
    `payment_plan_flag` BOOLEAN COMMENT 'Indicates whether the customer is on a negotiated payment plan for overdue balances. True means payment plan is active; false means no payment plan.',
    `payment_terms` STRING COMMENT 'Standard payment terms for this AR account. Net-15/30/45/60 indicates number of days from invoice date; due-on-receipt requires immediate payment; prepaid requires payment before service; custom indicates negotiated terms. [ENUM-REF-CANDIDATE: net_15|net_30|net_45|net_60|due_on_receipt|prepaid|custom — 7 candidates stripped; promote to reference product]',
    `sap_fi_ar_account_number` STRING COMMENT 'The SAP FI customer account number in the accounts receivable sub-ledger. Used for integration and reconciliation with the SAP S/4HANA FI module.',
    `tax_exempt_certificate_number` STRING COMMENT 'Government-issued tax exemption certificate number for tax-exempt customers. Required for audit compliance when tax-exempt flag is true.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the customer is exempt from sales tax on waste management services. True means tax-exempt status verified; false means standard tax applies.',
    `total_adjustments_ytd` DECIMAL(18,2) COMMENT 'Total amount of billing adjustments (credits, write-offs, discounts) applied to the customer account in the current fiscal year. Expressed in USD.',
    `total_invoiced_ytd` DECIMAL(18,2) COMMENT 'Total amount invoiced to the customer in the current fiscal year. Used for revenue analysis and customer value assessment. Expressed in USD.',
    `total_payments_ytd` DECIMAL(18,2) COMMENT 'Total amount of payments received from the customer in the current fiscal year. Used for cash flow analysis and payment behavior assessment. Expressed in USD.',
    `write_off_amount_ytd` DECIMAL(18,2) COMMENT 'Total amount of receivables written off as uncollectible in the current fiscal year. Used for bad debt expense tracking and financial reporting. Expressed in USD.',
    CONSTRAINT pk_ar_account PRIMARY KEY(`ar_account_id`)
) COMMENT 'Accounts receivable sub-ledger account representing the outstanding balance owed by a customer for environmental services. Tracks current balance, aging buckets (0-30, 31-60, 61-90, 90+ days), credit limit, credit hold status, last payment date, last invoice date, dunning level, collection status, and SAP FI AR account number. Distinct from the customer master (owned by customer domain) — this is the financial AR view of the customer relationship.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` (
    `billing_rate_schedule_id` BIGINT COMMENT 'Unique identifier for the billing rate schedule. Primary key.',
    `agreement_type_id` BIGINT COMMENT 'Foreign key linking to contract.agreement_type. Business justification: billing_rate_schedule.contract_type is a denormalized reference to contract.agreement_type. Normalizing this supports rate schedule management by agreement type, enables filtering rate schedules by cu',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.area. Business justification: Rate schedules are area-specific in waste management due to franchise agreements and municipal contracts. Area-based rate management, franchise compliance reporting, and municipal rate filings require',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.class. Business justification: Rate schedules in waste management are differentiated by asset class (front-load vs. roll-off vs. compactor class drives different base rates, rental fees, and overage rates). Pricing configuration an',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Container-type pricing is fundamental in waste management (2-yard vs. 4-yard dumpster, roll-off vs. rear-load have distinct rates). Pricing setup and container rental fee management require rate sched',
    `facility_id` BIGINT COMMENT 'Reference to the facility (landfill, transfer station, MRF, WTE plant) where tipping fees or processing rates apply. Null for collection service rates.',
    `frequency_plan_id` BIGINT COMMENT 'Foreign key linking to service.frequency_plan. Business justification: Frequency-based pricing is standard in waste management (weekly vs. twice-weekly pickup has different rates). Rate schedule setup and frequency-based pricing validation require linking billing rate sc',
    `line_id` BIGINT COMMENT 'Foreign key linking to service.line. Business justification: Rate schedules are defined per service line (residential, commercial, industrial, hazmat). Service line drives revenue account, pricing model, and regulatory classification. Billing managers setting u',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Billing rate schedules must reference the service offering they price for invoice generation and rate validation. Critical for automated billing systems to apply correct rates based on subscribed serv',
    `pricing_id` BIGINT COMMENT 'Foreign key linking to contract.pricing. Business justification: Rate audits and contract compliance checks require tracing each billing rate schedule to the contract pricing record that authorized it. Revenue assurance processes in waste management validate that o',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Rate schedules in waste management are defined per customer segment (residential, small commercial, large commercial, industrial). Pricing analysts use this link to manage segment-specific rate struct',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Rate schedules are defined per waste stream (MSW, C&D, hazmat, organics have distinct rates). Pricing setup and regulatory rate filing require linking rate schedules to canonical waste stream definiti',
    `approval_date` DATE COMMENT 'Date when this rate schedule was formally approved for activation. Part of the audit trail for rate change management.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the rate schedule in the approval and activation workflow.. Valid values are `draft|pending_approval|approved|active|suspended|retired`',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this rate schedule for use. Supports audit trail and SOX compliance.',
    `base_rate_amount` DECIMAL(18,2) COMMENT 'Primary charge amount for the service before surcharges, fees, or adjustments. Unit of measure depends on billing model.',
    `billing_model` STRING COMMENT 'Pricing methodology applied to calculate charges. Defines whether billing is fixed, usage-based, or hybrid.. Valid values are `flat_rate|per_pickup|per_ton|per_yard|container_rental|subscription`',
    `container_rental_fee` DECIMAL(18,2) COMMENT 'Monthly or periodic charge for rental of waste containers, dumpsters, or roll-off boxes. Separate from service pickup charges.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this rate schedule record was first created in the system. Part of the audit trail.',
    `disposal_surcharge` DECIMAL(18,2) COMMENT 'Additional charge applied for disposal at landfill or processing facility. May vary by waste type or facility capacity.',
    `effective_end_date` DATE COMMENT 'Date when this rate schedule expires or is superseded. Null indicates an open-ended schedule currently in effect.',
    `effective_start_date` DATE COMMENT 'Date when this rate schedule becomes active and applicable for billing. Supports rate change management and historical tracking.',
    `environmental_fee` DECIMAL(18,2) COMMENT 'Regulatory or operational fee charged to cover environmental compliance, remediation, or sustainability program costs.',
    `fuel_surcharge_rate` DECIMAL(18,2) COMMENT 'Percentage or fixed amount added to base rate to recover fuel costs. May be indexed to diesel fuel price benchmarks.',
    `gl_cost_center` STRING COMMENT 'Cost center code for internal cost allocation and profitability analysis. Used for transfer pricing and divisional reporting.',
    `gl_revenue_account` STRING COMMENT 'General ledger account code where revenue from this rate schedule is recognized. Supports financial reporting and SOX compliance.',
    `indexation_formula` STRING COMMENT 'Formula or reference index used for automatic rate adjustments. May reference CPI, fuel price index, or commodity pricing.',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Ceiling amount for billing to cap customer exposure. Null indicates no maximum limit.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Floor amount for billing regardless of usage or quantity. Ensures minimum revenue per transaction or billing period.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this rate schedule record was last updated. Supports change tracking and audit compliance.',
    `notes` STRING COMMENT 'Free-text field for additional context, special terms, or operational instructions related to this rate schedule.',
    `overage_rate` DECIMAL(18,2) COMMENT 'Rate charged for usage exceeding contracted or included quantities. Applies to weight, volume, or pickup frequency overages.',
    `pricing_tier` STRING COMMENT 'Tiered pricing level or bracket identifier for volume-based or loyalty-based rate differentiation.',
    `rate_calculation_method` STRING COMMENT 'Methodology used to compute the final charge. Defines whether rate is static, variable, or formula-driven.. Valid values are `fixed|percentage|per_unit|tiered|indexed`',
    `rate_unit_of_measure` STRING COMMENT 'Unit of measure for the base rate amount. Defines the quantity basis for billing calculations. [ENUM-REF-CANDIDATE: ton|cubic_yard|pickup|month|gallon|container|pound — 7 candidates stripped; promote to reference product]',
    `schedule_code` STRING COMMENT 'Unique alphanumeric code used to reference this rate schedule in billing systems and customer contracts.',
    `schedule_name` STRING COMMENT 'Business name of the rate schedule for identification and reporting purposes.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether charges under this rate schedule are exempt from sales tax. True for municipal or government contracts.',
    CONSTRAINT pk_billing_rate_schedule PRIMARY KEY(`billing_rate_schedule_id`)
) COMMENT 'Master rate schedule defining the complete pricing structure for waste management services, including individual rate components and tipping fee configurations. Header captures rate schedule name, effective date range, service type (residential MSW, commercial dumpster, roll-off, tipping fee, recycling processing), billing model (flat rate, per-pickup, per-ton, per-yard, container rental), applicable customer segment, geographic zone, facility (for tipping fees), waste stream type, and approval status. Component detail captures charge elements (base fee, fuel surcharge, environmental fee, overage, disposal surcharge) with calculation method (fixed, percentage, per-unit), unit of measure, rate value, min/max charges, taxability, and GL mapping. Supports both external customer billing and internal transfer pricing. Managed in Oracle Revenue Management and SAP SD condition records.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`rate_component` (
    `rate_component_id` BIGINT COMMENT 'Unique identifier for the rate component. Primary key.',
    `billing_rate_schedule_id` BIGINT COMMENT 'Reference to the parent rate schedule that contains this component.',
    `escalation_clause_id` BIGINT COMMENT 'Foreign key linking to contract.escalation_clause. Business justification: Rate components subject to contractual escalation (base rate, fuel surcharge) must reference the escalation clause governing their periodic adjustment. Automated escalation processing and contract com',
    `pricing_id` BIGINT COMMENT 'Foreign key linking to contract.pricing. Business justification: Each rate component (fuel surcharge, environmental fee, base rate) must be traceable to the contract pricing record that authorized it. Revenue recognition audits and contract compliance reporting in ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Rate components with regulatory_fee_flag=true (e.g., state environmental fees, host community fees) are mandated by specific regulatory requirements. Linking enables compliance reporting on fee pass-t',
    `superseded_by_component_rate_component_id` BIGINT COMMENT 'Reference to the rate component that replaces this one when a new version is created. Null if this is the current version.',
    `applies_to_container_type` STRING COMMENT 'Container type(s) to which this component applies (e.g., 96-gallon cart, 2-yard dumpster, 40-yard rolloff). Pipe-separated list for multiple types. [ENUM-REF-CANDIDATE: 32_gal_cart|64_gal_cart|96_gal_cart|1_yard_dumpster|2_yard_dumpster|4_yard_dumpster|6_yard_dumpster|8_yard_dumpster|10_yard_rolloff|20_yard_rolloff|30_yard_rolloff|40_yard_rolloff|compactor — promote to reference product]',
    `applies_to_service_type` STRING COMMENT 'Service type(s) to which this component applies (e.g., residential collection, commercial hauling, recycling). Pipe-separated list for multiple types. [ENUM-REF-CANDIDATE: residential_collection|commercial_collection|recycling|landfill_disposal|hazardous_waste|rolloff|compactor_rental|transfer_station — promote to reference product]',
    `approval_status` STRING COMMENT 'Approval workflow status for rate component changes requiring management authorization.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved this rate component.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the rate component was approved.',
    `calculation_method` STRING COMMENT 'Method used to calculate the charge: fixed amount, percentage of base, per-unit rate, tiered pricing, or custom formula.. Valid values are `fixed|percentage|per_unit|tiered|formula`',
    `component_code` STRING COMMENT 'Unique business identifier code for the rate component (e.g., BASE_FEE, FUEL_SRCHG, ENV_FEE).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `component_description` STRING COMMENT 'Detailed description of the rate component purpose, calculation logic, and business rules.',
    `component_name` STRING COMMENT 'Human-readable name of the rate component (e.g., Base Service Fee, Fuel Surcharge, Environmental Fee).',
    `component_status` STRING COMMENT 'Current lifecycle status of the rate component.. Valid values are `draft|active|suspended|expired|archived`',
    `component_type` STRING COMMENT 'Classification of the rate component indicating its purpose in the billing structure. [ENUM-REF-CANDIDATE: base_fee|surcharge|discount|rental|overage|disposal|environmental|fuel|administrative|other — 10 candidates stripped; promote to reference product]',
    `cost_center` STRING COMMENT 'Cost center code for management accounting allocation of this revenue component.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this rate component record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rate component value.. Valid values are `USD|CAD|MXN`',
    `deferral_period_months` STRING COMMENT 'Number of months over which revenue should be deferred when revenue_recognition_rule is deferred or over_service_period.',
    `effective_end_date` DATE COMMENT 'Date after which this rate component is no longer active. Null indicates open-ended validity.',
    `effective_start_date` DATE COMMENT 'Date from which this rate component becomes active and applicable to billing.',
    `formula_expression` STRING COMMENT 'Custom calculation formula expression when calculation_method is formula. Uses Oracle Revenue Management formula syntax.',
    `gl_revenue_account` STRING COMMENT 'General ledger account code to which revenue from this component is posted.. Valid values are `^[0-9]{4,10}$`',
    `invoice_label` STRING COMMENT 'Customer-facing label text to display on invoices when print_on_invoice_flag is true.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this rate component record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this rate component record was last modified.',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Maximum charge amount for this component regardless of calculated value. Implements ceiling pricing.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum charge amount for this component regardless of calculated value. Ensures floor pricing.',
    `notes` STRING COMMENT 'Internal notes and comments about this rate component for operational reference.',
    `pass_through_flag` BOOLEAN COMMENT 'Indicates whether this component is a pass-through charge (collected from customer and remitted to third party) versus company revenue.',
    `print_on_invoice_flag` BOOLEAN COMMENT 'Indicates whether this component should be displayed as a separate line item on customer invoices.',
    `profit_center` STRING COMMENT 'Profit center code for segment reporting and profitability analysis.. Valid values are `^[A-Z0-9]{4,12}$`',
    `proration_method` STRING COMMENT 'Method for prorating charges when service period is partial (e.g., mid-month start/stop).. Valid values are `none|daily|monthly|actual_days`',
    `rate_value` DECIMAL(18,2) COMMENT 'Numeric value of the rate component. Interpretation depends on calculation_method (e.g., dollar amount for fixed, percentage for percentage-based, rate per unit for per-unit).',
    `regulatory_fee_flag` BOOLEAN COMMENT 'Indicates whether this component represents a government-mandated or regulatory fee that must be separately tracked for compliance reporting.',
    `revenue_recognition_rule` STRING COMMENT 'Accounting rule for when revenue from this component should be recognized per GAAP/IFRS standards.. Valid values are `immediate|deferred|over_service_period|milestone`',
    `rounding_rule` STRING COMMENT 'Rounding rule applied to calculated component amount.. Valid values are `none|nearest_cent|round_up|round_down|nearest_dollar`',
    `sequence_number` STRING COMMENT 'Order in which this component is calculated and displayed within the rate schedule. Lower numbers are processed first.',
    `tax_category` STRING COMMENT 'Tax treatment category for this component when taxable_flag is true.. Valid values are `standard|exempt|reduced|zero_rated`',
    `taxable_flag` BOOLEAN COMMENT 'Indicates whether this rate component is subject to sales tax or other applicable taxes.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for per-unit rate components (e.g., ton for tonnage-based, pickup for per-pickup, day for daily rental). [ENUM-REF-CANDIDATE: ton|yard|pickup|day|month|gallon|mile|container|each — 9 candidates stripped; promote to reference product]',
    `version_number` STRING COMMENT 'Version number of this rate component for tracking changes over time. Incremented with each modification.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this rate component record.',
    CONSTRAINT pk_rate_component PRIMARY KEY(`rate_component_id`)
) COMMENT 'Individual pricing component within a rate schedule, defining a specific charge element such as base service fee, fuel surcharge, environmental fee, container rental, overage charge, or disposal surcharge. Captures component code, component type, calculation method (fixed, percentage, per-unit), unit of measure, rate value, minimum charge, maximum charge, taxability flag, and GL revenue account mapping. Enables granular rate construction for complex commercial billing.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` (
    `billing_tipping_fee_schedule_id` BIGINT COMMENT 'Unique identifier for the tipping fee schedule record. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.area. Business justification: Tipping fee schedules are area-specific in waste management (different municipalities and franchise areas have distinct tipping fee rates). Area-based tipping fee management and franchise compliance r',
    `container_type_id` BIGINT COMMENT 'Foreign key linking to service.container_type. Business justification: Tipping fees vary by container type (roll-off containers vs. rear-load vs. front-load have different minimum load fees and per-ton rates). Container-type tipping fee management and scale ticket reconc',
    `contract_id` BIGINT COMMENT 'Identifier of the contract or service agreement to which this tipping fee schedule is linked, if applicable.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility (landfill, transfer station, or WTE facility) where the tipping fee applies.',
    `mrf_facility_id` BIGINT COMMENT 'Foreign key linking to recycling.mrf_facility. Business justification: Tipping fee schedules are facility-specific, varying by MRF operational costs, market conditions, and capacity. Each facility maintains its own fee schedule. Core pricing configuration for MRF tipping',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Tipping fee schedules at landfills and transfer stations are directly governed by facility operating permits — permitted waste types, capacity limits, and permit conditions set the legal bounds of the',
    `program_id` BIGINT COMMENT 'Foreign key linking to recycling.recycling_program. Business justification: Tipping fee schedules are often program-specific (municipal curbside vs. commercial recycling programs carry different fee structures). Linking fee schedule to recycling_program enables program-scoped',
    `transfer_station_id` BIGINT COMMENT 'Foreign key linking to collection.transfer_station. Business justification: Tipping fee schedules are facility-specific; direct link enables rate lookup, contract enforcement, and automated billing for inbound loads at each transfer station.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Tipping fees are priced by waste stream classification (MSW, C&D, hazardous, recyclables). Disposal facilities require this link for regulatory compliance, cost recovery calculations, and accurate inv',
    `approval_status` STRING COMMENT 'Approval workflow status for the tipping fee schedule, ensuring proper authorization before activation.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this tipping fee schedule.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the tipping fee schedule was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this tipping fee schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the tipping fee amounts.. Valid values are `USD|CAD|MXN`',
    `customer_tier` STRING COMMENT 'Customer segment or tier to which this tipping fee schedule applies, enabling tiered pricing strategies.. Valid values are `municipal|commercial|industrial|self_haul|broker|internal`',
    `effective_end_date` DATE COMMENT 'Date when this tipping fee schedule expires or is superseded. Null indicates an open-ended schedule.',
    `effective_start_date` DATE COMMENT 'Date when this tipping fee schedule becomes active and applicable for billing.',
    `environmental_surcharge` DECIMAL(18,2) COMMENT 'Additional regulatory or environmental surcharge per ton, covering compliance costs such as landfill gas monitoring, leachate treatment, or closure reserves.',
    `fee_per_ton` DECIMAL(18,2) COMMENT 'Base tipping fee charged per ton of waste disposed. Primary pricing component for tonnage-based billing.',
    `host_community_fee` DECIMAL(18,2) COMMENT 'Fee per ton paid to the host municipality or community as part of landfill operating agreements.',
    `internal_transfer_pricing_flag` BOOLEAN COMMENT 'Indicates whether this schedule is used for internal transfer pricing between operational units (True) or external customer billing (False).',
    `local_tax_rate` DECIMAL(18,2) COMMENT 'Local jurisdiction tax rate applied to tipping fees, expressed as a decimal.',
    `minimum_load_fee` DECIMAL(18,2) COMMENT 'Minimum charge applied per load regardless of tonnage, ensuring cost recovery for small loads.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this tipping fee schedule record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the tipping fee schedule, including special terms, exceptions, or business context.',
    `pricing_model` STRING COMMENT 'Pricing methodology applied by this schedule (flat rate per ton, tiered pricing based on volume thresholds, time-of-day pricing).. Valid values are `flat_rate|tiered|volume_based|time_of_day`',
    `schedule_code` STRING COMMENT 'Business identifier code for the tipping fee schedule, used for external reference and reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `schedule_name` STRING COMMENT 'Descriptive name of the tipping fee schedule for business user identification.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the tipping fee schedule. Controls whether the schedule is available for billing transactions.. Valid values are `draft|active|suspended|expired|superseded`',
    `state_tax_rate` DECIMAL(18,2) COMMENT 'State-level tax rate applied to tipping fees, expressed as a decimal (e.g., 0.0650 for 6.5%).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the tipping fee calculation (ton, cubic yard, or per load).. Valid values are `ton|cubic_yard|load`',
    CONSTRAINT pk_billing_tipping_fee_schedule PRIMARY KEY(`billing_tipping_fee_schedule_id`)
) COMMENT 'Reference schedule of tipping fees charged per ton (or per load) for waste disposal at landfill, transfer station, or WTE facility. Captures facility ID, waste stream type (MSW, C&D, special waste, hazardous), fee per ton (TPD-based pricing), minimum load fee, effective date range, customer tier (municipal, commercial, self-haul), and regulatory surcharge components. Supports both external customer billing and internal transfer pricing between operational units.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`cycle` (
    `cycle_id` BIGINT COMMENT 'Unique identifier for the billing cycle configuration. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.area. Business justification: Billing cycles are area-specific in waste management (different municipalities and franchise areas have different billing cycle requirements). Area-based billing cycle management and municipal billing',
    `line_id` BIGINT COMMENT 'Foreign key linking to service.line. Business justification: Billing cycles are service-line-specific (residential monthly vs. commercial weekly billing cycles). Service line drives cycle frequency and billing model. service_type on cycle is a denormalized repr',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Billing cycles are configured per customer segment (e.g., residential customers billed monthly, large commercial quarterly). This link enables segment-level billing operations management and ensures n',
    `advance_billing_enabled` BOOLEAN COMMENT 'Indicates whether invoices are generated in advance of the service period (prepaid model) or after service delivery (arrears model). True for advance billing (invoice before service), False for arrears billing (invoice after service).',
    `ar_aging_bucket_days` STRING COMMENT 'Comma-separated list of day thresholds for AR aging bucket calculations (e.g., 30,60,90,120 for standard 30-day buckets). Used to categorize outstanding receivables by age for collections prioritization and financial reporting.',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether accounts in this billing cycle automatically renew at the end of each period without requiring manual intervention. True for ongoing subscription services, False for term-limited contracts requiring explicit renewal.',
    `billing_model` STRING COMMENT 'Revenue model applied in this billing cycle. Subscription for fixed recurring fees (monthly container rental), transactional for per-event charges (per-haul roll-off), usage-based for metered consumption (tonnage-based tipping fees), hybrid for combination of fixed and variable charges.. Valid values are `subscription|transactional|usage-based|hybrid`',
    `billing_period_day` STRING COMMENT 'Day of the month when the billing period closes and invoices are generated (1-31). For monthly cycles, this is the cutoff day. For bi-monthly or quarterly, this represents the anchor day.',
    `consolidation_level` STRING COMMENT 'Defines how invoices are consolidated for multi-site or hierarchical accounts. Account-level generates one invoice per account, site-level generates separate invoices per service location, parent-account rolls up all child accounts, consolidated combines all services into single invoice.. Valid values are `account|site|parent-account|consolidated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing cycle record was first created in the system. Audit trail for configuration management and SOX compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this billing cycle. Typically USD for US operations, CAD for Canadian operations. Supports multi-currency billing for international accounts.. Valid values are `^[A-Z]{3}$`',
    `cycle_code` STRING COMMENT 'Short alphanumeric code identifying the billing cycle (e.g., MC01 for Monthly Cycle 01, BC15 for Bi-Monthly Cycle 15). Used as business identifier in Oracle Revenue Management.. Valid values are `^[A-Z0-9]{2,10}$`',
    `cycle_description` STRING COMMENT 'Detailed description of the billing cycle purpose, scope, and applicable customer segments.',
    `cycle_name` STRING COMMENT 'Descriptive name of the billing cycle for business user identification (e.g., Monthly Residential East, Quarterly Commercial West).',
    `cycle_status` STRING COMMENT 'Current operational status of the billing cycle. Active for cycles currently in use, inactive for cycles not yet activated, suspended for temporarily disabled cycles, archived for historical cycles no longer in use but retained for audit purposes.. Valid values are `active|inactive|suspended|archived`',
    `discount_eligibility_enabled` BOOLEAN COMMENT 'Indicates whether accounts in this billing cycle are eligible for early payment discounts, volume discounts, or promotional pricing. True enables discount application rules, False excludes cycle from discount programs.',
    `dunning_process_enabled` BOOLEAN COMMENT 'Indicates whether automated dunning (collections reminder) process is enabled for overdue accounts in this billing cycle. True triggers escalating reminder notices and collection actions, False requires manual collections management.',
    `early_payment_discount_days` STRING COMMENT 'Number of days from invoice date within which payment must be received to qualify for early payment discount. Typically 10 days for 2/10 net-30 terms.',
    `early_payment_discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount offered for payment within specified early payment window (e.g., 2% discount if paid within 10 days). Common for commercial accounts to incentivize faster payment and improve cash flow.',
    `effective_end_date` DATE COMMENT 'Date when this billing cycle configuration expires and can no longer be assigned to new accounts. Null for open-ended cycles. Used for phasing out legacy billing structures.',
    `effective_start_date` DATE COMMENT 'Date when this billing cycle configuration becomes effective and can be assigned to customer accounts. Supports future-dated cycle changes for rate updates or term modifications.',
    `frequency` STRING COMMENT 'Recurrence pattern for invoice generation. Monthly for standard residential/commercial, bi-monthly for certain municipal contracts, quarterly for large commercial accounts, annual for prepaid contracts, per-haul for roll-off containers, on-demand for special services.. Valid values are `monthly|bi-monthly|quarterly|annual|per-haul|on-demand`',
    `gl_ar_account_code` STRING COMMENT 'Default GL account code for posting accounts receivable from invoices in this billing cycle. Maps to SAP FI/CO chart of accounts for balance sheet reporting.. Valid values are `^[0-9]{4,10}$`',
    `gl_revenue_account_code` STRING COMMENT 'Default GL account code for posting revenue from invoices in this billing cycle. Maps to SAP FI/CO chart of accounts for financial reporting and revenue recognition.. Valid values are `^[0-9]{4,10}$`',
    `grace_period_days` STRING COMMENT 'Number of days after payment due date before late fees are assessed or collection actions begin. Typically 5-10 days to accommodate payment processing delays.',
    `invoice_delivery_method` STRING COMMENT 'Primary method for delivering invoices to customers in this billing cycle. Email for electronic delivery, postal-mail for paper invoices, portal for customer self-service access, EDI for electronic data interchange with large commercial accounts, both for dual delivery.. Valid values are `email|postal-mail|portal|edi|both`',
    `invoice_generation_date` DATE COMMENT 'The date when invoices for this billing cycle are generated and made available to customers. Typically 1-3 days after billing period closes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing cycle record was last updated. Tracks configuration changes for audit and compliance purposes.',
    `late_fee_flat_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount charged as late fee regardless of balance, used as alternative or supplement to percentage-based late fees. Common for residential accounts ($5-$25 flat fee).',
    `late_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of outstanding balance charged as late fee when payment is overdue beyond grace period. Typically 1.5% to 3% per month, subject to state usury laws.',
    `late_fee_trigger_enabled` BOOLEAN COMMENT 'Indicates whether late fees are automatically triggered for overdue invoices in this billing cycle. True enables automatic late fee assessment, False requires manual review.',
    `payment_due_date_offset_days` STRING COMMENT 'Number of days after invoice generation date when payment is due. Typically 15, 30, or 45 days representing net-15, net-30, or net-45 payment terms.',
    `payment_terms` STRING COMMENT 'Standard payment terms applied to invoices in this billing cycle. Net-30 is most common for commercial accounts, net-15 for residential, net-45 or net-60 for large municipal contracts, due-on-receipt for certain transactional services, prepaid for annual contracts.. Valid values are `net-15|net-30|net-45|net-60|due-on-receipt|prepaid`',
    `proration_enabled` BOOLEAN COMMENT 'Indicates whether charges are prorated for partial billing periods when accounts are activated or terminated mid-cycle. True enables daily proration calculations, False bills full period regardless of start/end dates.',
    `revenue_recognition_method` STRING COMMENT 'Accounting method for recognizing revenue from invoices in this billing cycle per GAAP/IFRS standards. Point-in-time for transactional services (per-haul), over-time for subscription services (monthly collection), milestone-based for project-based contracts.. Valid values are `point-in-time|over-time|milestone-based`',
    `statement_generation_enabled` BOOLEAN COMMENT 'Indicates whether monthly account statements are generated in addition to individual invoices. True for accounts requiring consolidated statements showing all activity, False for invoice-only delivery.',
    `tax_calculation_method` STRING COMMENT 'Method for calculating sales tax or VAT on invoices in this billing cycle. Standard applies jurisdiction-based tax rates, exempt for tax-exempt customers (municipalities, non-profits), reverse-charge for certain B2B transactions, mixed for accounts with both taxable and exempt services.. Valid values are `standard|exempt|reverse-charge|mixed`',
    `write_off_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount that can be written off as bad debt without requiring executive approval. Balances below this threshold can be written off by collections team, amounts above require CFO or controller authorization per SOX controls.',
    CONSTRAINT pk_cycle PRIMARY KEY(`cycle_id`)
) COMMENT 'Configuration entity defining the recurring billing schedule for customer accounts. Captures cycle code, frequency (monthly, bi-monthly, quarterly, per-haul for roll-off), billing run date, invoice generation date, payment terms (net 30, net 15, net 45), grace period days, late fee trigger rules, and applicable customer segments. Each billing account is assigned to one billing cycle that governs when invoices are generated and when payments are due. Drives the automated billing run schedule in Oracle Revenue Management and determines AR aging calculations.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`run` (
    `run_id` BIGINT COMMENT 'Unique identifier for the billing run batch execution. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.area. Business justification: Billing runs are executed per service area (municipal billing runs, franchise area billing runs). Area-specific billing run management, run performance reporting, and municipal billing compliance requ',
    `cycle_id` BIGINT COMMENT 'Reference to the billing cycle for which this run was executed. Links to the billing cycle master data defining the period and frequency.',
    `line_id` BIGINT COMMENT 'Foreign key linking to service.line. Business justification: Billing runs are executed per service line (run all residential accounts, run all commercial accounts). Service-line-specific billing run management and run performance reporting by service line requi',
    `accounts_on_hold` STRING COMMENT 'Count of customer accounts excluded from billing due to hold status (e.g., payment dispute, account under review, service suspension).',
    `accounts_with_errors` STRING COMMENT 'Count of customer accounts that encountered errors during billing run processing. Requires manual review and correction.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this billing run requires managerial approval before invoice release. True for correction and manual runs; false for scheduled runs.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the billing run was approved for invoice release. Null if approval not required or not yet approved.',
    `ar_posting_status` STRING COMMENT 'Status of the accounts receivable posting for this billing run. Pending indicates awaiting posting; posted indicates successfully recorded in AR; failed indicates posting error; reversed indicates posting was reversed due to correction.. Valid values are `pending|posted|failed|reversed`',
    `billing_period_end_date` DATE COMMENT 'Last date of the billing period covered by this run. Defines the inclusive end boundary for usage and service charges.',
    `billing_period_start_date` DATE COMMENT 'First date of the billing period covered by this run. Defines the inclusive start boundary for usage and service charges.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this billing run record was first created in the system. Used for audit trail and data lineage.',
    `duration_seconds` STRING COMMENT 'Total elapsed time in seconds from run start to run end. Used for performance analysis and capacity planning.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the billing run execution completed or failed. Null if run is still in progress or pending.',
    `error_log_summary` STRING COMMENT 'High-level summary of errors encountered during billing run execution. Detailed error records are stored in separate error log tables.',
    `gl_batch_number` STRING COMMENT 'SAP FI/CO batch identifier for the general ledger posting of this billing run revenue. Used for financial reconciliation and audit trail.',
    `gl_posting_date` DATE COMMENT 'Date when revenue from this billing run was posted to the general ledger in SAP FI/CO. Used for financial period close and revenue recognition.',
    `invoice_release_date` DATE COMMENT 'Date when invoices from this billing run were released to customers. May differ from run completion date if approval or review was required.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this billing run record was last updated. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes entered by billing operators regarding special circumstances, manual interventions, or issues requiring follow-up.',
    `run_number` STRING COMMENT 'Business-friendly identifier for the billing run, typically formatted as cycle-sequence (e.g., 2024-01-001). Used for operational tracking and audit trail.',
    `run_status` STRING COMMENT 'Current lifecycle state of the billing run. Pending indicates queued for execution; in-progress indicates active processing; completed indicates successful finish; failed indicates error termination; cancelled indicates operator abort; suspended indicates paused awaiting intervention.. Valid values are `pending|in_progress|completed|failed|cancelled|suspended`',
    `run_type` STRING COMMENT 'Classification of the billing run execution mode. Scheduled runs are automated per billing cycle calendar; manual runs are operator-initiated; correction runs address prior errors; supplemental runs handle mid-cycle adjustments; final runs close the cycle; interim runs are preliminary.. Valid values are `scheduled|manual|correction|supplemental|final|interim`',
    `source_system` STRING COMMENT 'Name of the system that executed the billing run (e.g., Oracle Revenue Management, SAP SD). Used for multi-system environments and data lineage.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the billing run execution began. Used for performance monitoring and SLA tracking.',
    `total_accounts_processed` STRING COMMENT 'Count of distinct customer accounts included in this billing run. Used for reconciliation and completeness validation.',
    `total_adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of all billing adjustments (credits, discounts, dispute resolutions) applied in this run, in USD. Negative values represent credits to customers.',
    `total_billed_amount` DECIMAL(18,2) COMMENT 'Sum of all invoice amounts generated by this billing run, in USD. Represents gross revenue recognized for the billing period before payments and adjustments.',
    `total_invoices_generated` STRING COMMENT 'Count of invoices created by this billing run. May differ from accounts processed if some accounts have zero balance or are on hold.',
    `total_service_charge_amount` DECIMAL(18,2) COMMENT 'Sum of all recurring service charges (container rentals, subscription fees) included in this run, in USD. Excludes usage-based charges and taxes.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Sum of all tax charges included in the invoices generated by this run, in USD. Includes sales tax, environmental fees, and regulatory surcharges.',
    `total_usage_charge_amount` DECIMAL(18,2) COMMENT 'Sum of all usage-based charges (tonnage, pickups, tipping fees) included in this run, in USD. Excludes recurring service charges and taxes.',
    `zero_balance_accounts` STRING COMMENT 'Count of customer accounts processed that resulted in zero invoice amount due to no usage or offsetting credits.',
    CONSTRAINT pk_run PRIMARY KEY(`run_id`)
) COMMENT 'Operational record of a batch billing execution that generates invoices for a defined set of customer accounts within a billing cycle. Captures run date, billing cycle reference, run type (scheduled, manual, correction), total accounts processed, total invoices generated, total billed amount, run status (pending, in-progress, completed, failed), and operator ID. Provides audit trail for SOX compliance and billing operations management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'Unique identifier for the billing adjustment record. Primary key.',
    `accident_report_id` BIGINT COMMENT 'Foreign key linking to fleet.accident_report. Business justification: When a vehicle accident causes missed or incomplete service, a billing adjustment (credit/rebill) is issued to the affected customer. Direct traceability from adjustment to accident_report supports cl',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to billing.ar_account. Business justification: Adjustments (credits, debits, write-offs) directly impact AR account balances. While adjustment.invoice_id and adjustment.billing_account_id exist, a direct FK to ar_account is essential for AR sub-le',
    `billing_account_id` BIGINT COMMENT 'Reference to the customer account receiving the adjustment. Links to the billing account impacted by this adjustment.',
    `commodity_sale_id` BIGINT COMMENT 'Foreign key linking to recycling.commodity_sale. Business justification: Post-sale quality deductions, price corrections, and revenue adjustments on commodity sales are processed as billing adjustments directly against the commodity_sale record. AR teams in recycling opera',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to customer.complaint. Business justification: When a customer complaint results in a billing credit or adjustment (e.g., missed pickup, overcharge), the adjustment record must reference the originating complaint for audit trails, credit reconcili',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Compliance inspections that identify weight discrepancies, service failures, or overcharges directly trigger billing adjustments. Linking adjustment to compliance_inspection supports the named process',
    `contamination_event_id` BIGINT COMMENT 'Foreign key linking to recycling.contamination_event. Business justification: Contamination events trigger billing adjustments (surcharges when contamination exceeds contract thresholds, or credits for processing issues). Real-world process requires linking adjustments to conta',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Billing adjustments stem from contract disputes, SLA breaches, or rate corrections. Audit trail requires linking adjustment back to governing agreement for regulatory compliance, revenue recognition c',
    `dispute_id` BIGINT COMMENT 'Reference to the billing dispute case that triggered this adjustment. Links adjustments to customer dispute resolution workflows.',
    `downtime_event_id` BIGINT COMMENT 'Foreign key linking to maintenance.downtime_event. Business justification: Service disruption credit process: equipment downtime events (vehicle breakdowns, compactor failures) that cause missed collections trigger customer billing adjustments. Linking adjustment to downtime',
    `haul_manifest_id` BIGINT COMMENT 'Foreign key linking to collection.haul_manifest. Business justification: Outbound haul charge adjustment process: billing adjustments for haul weight corrections, rejected loads, or manifest discrepancies require direct reference to the haul_manifest. Regulatory compliance',
    `invoice_id` BIGINT COMMENT 'Reference to the original invoice being adjusted. Links to the invoice that this adjustment modifies or corrects.',
    `load_ticket_id` BIGINT COMMENT 'Foreign key linking to collection.load_ticket. Business justification: Tipping fee adjustment traceability: load ticket corrections (rejected loads, weight restatements) generate billing adjustments that must reference the source load_ticket. Regulatory audit trails in w',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Service-related adjustments (missed pickup credits, contamination charges, SLA breach credits) must reference the offering to categorize revenue impact, track service quality costs, and analyze adjust',
    `on_demand_request_id` BIGINT COMMENT 'Foreign key linking to collection.on_demand_request. Business justification: On-demand service credit process: pricing corrections and cancellation credits for on-demand requests require direct reference to the on_demand_request. Billing adjustments for cancelled or mispriced ',
    `pickup_event_id` BIGINT COMMENT 'Foreign key linking to collection.pickup_event. Business justification: Pickup-level credit issuance: adjustments for contamination fee reversals, missed lift credits, and overage corrections are issued directly against pickup events. Billing ops issues credits referencin',
    `reversed_adjustment_id` BIGINT COMMENT 'Reference to the original adjustment being reversed by this adjustment. Maintains bidirectional linkage for audit trail and correction tracking.',
    `rolloff_order_id` BIGINT COMMENT 'Foreign key linking to collection.rolloff_order. Business justification: Rolloff charge adjustment workflow: rental period corrections and weight overage reversals on rolloff orders require direct reference to the rolloff_order. Billing teams issue adjustments tied to spec',
    `service_address_id` BIGINT COMMENT 'Foreign key linking to customer.service_address. Business justification: Billing adjustments (missed pickup credits, contamination fees) are tied to a specific service address. Multi-site commercial customers require address-level adjustment tracking for site-level P&L rep',
    `service_exception_id` BIGINT COMMENT 'Foreign key linking to collection.service_exception. Business justification: Billing adjustments for missed pickups, contamination, access issues, or service failures require linking to the documented service exception with root cause and resolution notes.',
    `service_request_id` BIGINT COMMENT 'Foreign key linking to customer.service_request. Business justification: Credits and adjustments frequently originate from service requests (missed pickups, service failures, complaint resolutions). Tracking this relationship enables root cause analysis of revenue leakage,',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: SLA breach credits are a specific adjustment type in waste management (missed pickup credit, late delivery penalty). Linking adjustments to the triggering SLA definition enables SLA financial impact t',
    `sla_term_id` BIGINT COMMENT 'Foreign key linking to contract.sla_term. Business justification: SLA breach adjustments (credits and penalties) must reference the specific SLA term violated to validate penalty calculations and support SLA performance reporting. Waste management contract complianc',
    `vehicle_assignment_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_assignment. Business justification: Missed or incomplete vehicle assignments (no-shows, partial routes) directly trigger billing adjustments/credits. Linking adjustment to vehicle_assignment provides operational justification for the cr',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.violation_notice. Business justification: Billing adjustments frequently result from violation notices: credits for service interruptions due to compliance shutdowns, charge corrections for non-permitted waste acceptance, or penalty-related b',
    `weight_ticket_id` BIGINT COMMENT 'Foreign key linking to collection.weight_ticket. Business justification: Weight-based billing correction process: tipping fee adjustments after reweigh or scale calibration corrections require direct reference to the weight_ticket. Regulatory and audit requirements in wast',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Service credit audit trail: when a maintenance work order documents a failed or missed service, the resulting billing adjustment (credit to customer) must reference the originating work order for SOX ',
    `adjustment_number` STRING COMMENT 'Externally visible unique business identifier for the adjustment. Used for customer communication, dispute tracking, and audit trails.. Valid values are `^ADJ-[0-9]{8,12}$`',
    `adjustment_status` STRING COMMENT 'Current lifecycle state of the adjustment in the approval and posting workflow. Determines whether the adjustment has impacted financial statements and customer balances. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|rejected|posted|reversed|cancelled — 7 candidates stripped; promote to reference product]',
    `adjustment_type` STRING COMMENT 'Classification of the adjustment indicating the nature of the correction or modification. Determines accounting treatment and approval workflow requirements. [ENUM-REF-CANDIDATE: credit_memo|debit_memo|service_credit|write_off|bad_debt|rate_correction|small_balance_write_off|promotional_discount|dispute_settlement|billing_error_correction — 10 candidates stripped; promote to reference product]',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the adjustment. Positive values represent debits (charges to customer), negative values represent credits (refunds or reductions). Expressed in the accounts billing currency.',
    `approval_status` STRING COMMENT 'Status of the approval workflow for this adjustment. Tracks whether required management authorization has been obtained per SOX-controlled approval thresholds.. Valid values are `not_required|pending|approved|rejected|escalated`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment was approved by authorized personnel. Critical for SOX compliance and audit trail documentation.',
    `bad_debt_flag` BOOLEAN COMMENT 'Indicates whether this adjustment represents a bad debt write-off or uncollectible balance. Used for bad debt reserve calculations per ASC 326 Current Expected Credit Loss (CECL) standard.',
    `corrected_charge_amount` DECIMAL(18,2) COMMENT 'Corrected invoice line item amount after adjustment. Used for billing error analysis and process improvement initiatives.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment record was first created in the system. Supports audit trail and lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the adjustment amount. Supports multi-currency billing operations.. Valid values are `^[A-Z]{3}$`',
    `customer_notification_date` DATE COMMENT 'Date on which the customer was notified of the adjustment. Tracks communication timeliness and customer service performance.',
    `customer_notification_flag` BOOLEAN COMMENT 'Indicates whether the customer has been notified of this adjustment. Supports customer communication tracking and service quality management.',
    `effective_date` DATE COMMENT 'Business date on which the adjustment becomes effective for revenue recognition and customer billing purposes. May differ from posting date for backdated corrections.',
    `external_reference_number` STRING COMMENT 'External reference identifier from the source system or third-party system. Supports cross-system reconciliation and audit trail linkage.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the adjustment is posted. Determines whether the adjustment impacts revenue reversal, bad debt expense, or other GL accounts per GAAP requirements.. Valid values are `^[0-9]{4,10}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment record was last modified. Tracks changes throughout the approval and posting workflow.',
    `notes` STRING COMMENT 'Free-form text notes providing additional context, justification, or instructions related to the adjustment. Used for audit documentation and customer service reference.',
    `original_charge_amount` DECIMAL(18,2) COMMENT 'Original invoice line item amount before adjustment. Provides context for variance analysis and billing accuracy metrics.',
    `posted_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment was posted to the general ledger and customer account balance. Marks the point at which the adjustment impacts financial statements.',
    `reason_code` STRING COMMENT 'Standardized code indicating the specific business reason for the adjustment. Used for root cause analysis, trend reporting, and process improvement initiatives.. Valid values are `^[A-Z0-9]{3,10}$`',
    `reason_description` STRING COMMENT 'Detailed narrative explanation of why the adjustment was necessary. Provides business context for audit, compliance, and customer service purposes.',
    `recovery_amount` DECIMAL(18,2) COMMENT 'Amount recovered from a previously written-off balance. Tracks bad debt recoveries for financial reporting and collections performance metrics.',
    `recovery_date` DATE COMMENT 'Date on which a previously written-off amount was recovered. Used for bad debt recovery reporting and collections analytics.',
    `recovery_eligible_flag` BOOLEAN COMMENT 'Indicates whether a written-off balance is eligible for future recovery attempts. Used by collections teams to prioritize recovery efforts.',
    `revenue_impact_amount` DECIMAL(18,2) COMMENT 'Amount by which this adjustment impacts recognized revenue in the current accounting period. Used for revenue recognition reporting per ASC 606 and IFRS 15.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this adjustment reverses a previous adjustment. Used to track adjustment corrections and maintain audit trail integrity.',
    `service_period_end_date` DATE COMMENT 'End date of the service period to which this adjustment applies. Supports revenue recognition and period-specific billing corrections.',
    `service_period_start_date` DATE COMMENT 'Start date of the service period to which this adjustment applies. Used for revenue recognition timing and period-specific adjustments.',
    `source_system_code` STRING COMMENT 'Identifies the system of record that originated this adjustment. Supports data lineage tracking and system integration reconciliation.. Valid values are `ORACLE_RM|SAP_FICO|MANUAL|AMCS|WASTE_LOGICS`',
    `write_off_flag` BOOLEAN COMMENT 'Indicates whether this adjustment represents a write-off of an uncollectible or immaterial balance. Supports accounts receivable aging and collections management.',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Credit or debit adjustment applied to a customer account or invoice to correct billing errors, honor service credits, apply promotional discounts, settle disputes, or write off uncollectible balances. Captures adjustment type (credit memo, debit memo, service credit, write-off, bad debt, rate correction, small balance write-off), adjustment reason code, original invoice reference, adjustment amount, approval status, approver ID, GL impact (revenue reversal or bad debt expense), recovery status for write-off types, and approval workflow audit trail. Supports GAAP revenue recognition adjustments, SOX-controlled approval workflows, and bad debt management per ASC 326 (CECL).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`dispute` (
    `dispute_id` BIGINT COMMENT 'Unique identifier for the billing dispute record. Primary key.',
    `accident_report_id` BIGINT COMMENT 'Foreign key linking to fleet.accident_report. Business justification: Customers dispute charges when service was missed due to a vehicle accident. Linking dispute directly to accident_report enables root-cause documentation for dispute resolution, supports SOX complianc',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to billing.ar_account. Business justification: A billing dispute places a hold on the disputed amount within the AR account (dispute_flag and disputed_amount on ar_account). The dispute record should directly reference the ar_account to enable AR ',
    `asset_container_id` BIGINT COMMENT 'Reference to the container involved in the dispute, relevant for container size error or rental charge disputes.',
    `billing_account_id` BIGINT COMMENT 'Reference to the customer account that raised the dispute.',
    `complaint_id` BIGINT COMMENT 'Reference to the Salesforce CRM case record associated with this dispute for tracking and resolution workflow.',
    `compliance_inspection_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_inspection. Business justification: Customer disputes often stem from inspection findings: contamination charges, service denials due to non-compliance, or disputed fees for regulatory violations. Linking disputes to triggering inspecti',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Billing disputes are initiated and managed by a specific customer contact. Dispute resolution workflows, SLA tracking, and customer satisfaction scoring require knowing which contact raised the disput',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Disputes involve contract interpretation (rate disputes, service level failures, scope disagreements). Resolution teams need direct access to governing agreement terms, SLA thresholds, penalty provisi',
    `downtime_event_id` BIGINT COMMENT 'Foreign key linking to maintenance.downtime_event. Business justification: Dispute root-cause resolution: customer billing disputes arising from missed collections due to equipment downtime must reference the downtime event record. Dispute resolution teams in Waste Managemen',
    `driver_id` BIGINT COMMENT 'Foreign key linking to fleet.driver. Business justification: Customer disputes about service quality, missed pickups, or driver conduct require identifying the specific driver who performed the service. Essential for investigation, coaching, and resolution trac',
    `haul_manifest_id` BIGINT COMMENT 'Foreign key linking to collection.haul_manifest. Business justification: Haul charge dispute investigation: disputes about outbound haul tipping fees and transport charges require direct reference to the haul_manifest (gross_weight_tons, epa_waste_code, manifest_number). M',
    `inbound_load_id` BIGINT COMMENT 'Foreign key linking to recycling.inbound_load. Business justification: Customer disputes about tipping fees, contamination surcharges, and weight discrepancies reference the specific inbound load. Dispute resolution teams require direct access to the load record for weig',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice being disputed by the customer.',
    `invoice_line_id` BIGINT COMMENT 'Reference to the specific invoice line item being disputed, if the dispute is line-item specific rather than invoice-level.',
    `load_ticket_id` BIGINT COMMENT 'Foreign key linking to collection.load_ticket. Business justification: Tipping fee dispute investigation: customers and haulers dispute tipping fee charges by referencing the load ticket (net_weight_tons, tipping_fee_rate, rejection_reason_code). Direct FK enables disput',
    `on_demand_request_id` BIGINT COMMENT 'Foreign key linking to collection.on_demand_request. Business justification: On-demand service dispute process: customers dispute charges for on-demand pickups (pricing, completion status). Dispute investigators must directly access the on_demand_request to verify request_stat',
    `pickup_event_id` BIGINT COMMENT 'Foreign key linking to collection.pickup_event. Business justification: Service disputes often reference specific pickup events; direct link enables investigation of RFID scans, timestamps, GPS coordinates, driver notes, and contamination flags for resolution.',
    `rolloff_order_id` BIGINT COMMENT 'Foreign key linking to collection.rolloff_order. Business justification: Rolloff billing dispute process: rolloff weight overage and rental duration disputes are among the most common in waste management. Dispute investigators reference rolloff_order for actual_weight_tons',
    `route_execution_id` BIGINT COMMENT 'Foreign key linking to collection.route_execution. Business justification: Dispute investigation process: when a customer disputes a charge for a service day, billing ops must reference the route_execution record to verify completion_percentage, total_stops_missed, and execu',
    `route_id` BIGINT COMMENT 'Reference to the collection route associated with the disputed service, relevant for missed pickup or service quality disputes.',
    `service_address_id` BIGINT COMMENT 'Reference to the service address associated with the disputed charges, relevant for location-specific billing disputes.',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Billing disputes in waste management are frequently about a specific enrolled service (e.g., disputed container rental fee, incorrect service frequency charge). Linking dispute to service_enrollment e',
    `sla_definition_id` BIGINT COMMENT 'Foreign key linking to service.sla_definition. Business justification: Disputes are frequently triggered by SLA breaches (missed pickup, late container delivery). Linking disputes to the breached SLA definition enables SLA compliance dispute tracking, SLA breach root cau',
    `sla_term_id` BIGINT COMMENT 'Foreign key linking to contract.sla_term. Business justification: Billing disputes arising from SLA breaches (missed pickups, service failures) require referencing the specific SLA term violated to determine penalty amounts and resolution obligations. Waste manageme',
    `stop_id` BIGINT COMMENT 'Foreign key linking to collection.collection_stop. Business justification: Stop-level dispute resolution: customers dispute charges for specific stops (e.g., container not serviced). Disputes can exist without a pickup_event when service was never attempted. Direct FK to col',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle. Business justification: Disputes involving property damage, equipment malfunction, or service delivery issues require identifying the specific vehicle involved. Critical for insurance claims, maintenance investigation, and r',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.violation_notice. Business justification: Customers frequently dispute penalty charges associated with violation notices (e.g., disputing a regulatory penalty billed to their account). Direct FK enables the dispute resolution process to refer',
    `weight_ticket_id` BIGINT COMMENT 'Foreign key linking to collection.weight_ticket. Business justification: Tonnage and tipping fee disputes require direct access to the weight ticket with certified gross/tare/net weights, scale calibration date, and weighmaster certification for validation.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Maintenance-caused dispute traceability: billing disputes triggered by a maintenance failure (e.g., vehicle breakdown causing missed service) must reference the work order documenting the failure. Env',
    `approval_required_flag` BOOLEAN COMMENT 'Indicator of whether the dispute resolution requires management approval due to amount threshold or policy exception.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the dispute resolution was formally approved by authorized management.',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period covered by the disputed invoice.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period covered by the disputed invoice.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when the dispute was formally closed in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the dispute record was first created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The monetary amount credited to the customer account as a result of the dispute resolution, in USD.',
    `customer_satisfaction_rating` STRING COMMENT 'Post-resolution customer satisfaction score (1-5 scale) collected via survey to measure dispute handling quality.',
    `dispute_date` DATE COMMENT 'The date the customer formally raised the billing dispute.',
    `dispute_number` STRING COMMENT 'Human-readable business identifier for the dispute, used in customer communications and internal tracking.. Valid values are `^DSP-[0-9]{8}$`',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the dispute in the resolution workflow.. Valid values are `open|under review|resolved|escalated|closed|withdrawn`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The total monetary amount being contested by the customer in the dispute, in USD.',
    `escalation_date` DATE COMMENT 'The date the dispute was escalated to a higher authority for resolution.',
    `escalation_level` STRING COMMENT 'Numeric indicator of how many times the dispute has been escalated to higher management tiers (0 = no escalation, 1 = first escalation, etc.).',
    `financial_impact_category` STRING COMMENT 'Classification of the financial impact of the dispute and its resolution on the business.. Valid values are `revenue loss|customer retention risk|goodwill gesture|operational cost|no financial impact`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the dispute record was last updated.',
    `priority` STRING COMMENT 'Priority level assigned to the dispute based on amount, customer tier, or business impact.. Valid values are `low|medium|high|critical`',
    `reason_code` STRING COMMENT 'Standardized code categorizing the primary reason for the dispute. [ENUM-REF-CANDIDATE: incorrect rate|missed pickup|container size error|duplicate charge|tipping fee discrepancy|service not rendered|billing cycle error|proration error|tax calculation error|unauthorized charge|other — 11 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Detailed free-text explanation provided by the customer or customer service representative describing the nature of the dispute.',
    `refund_amount` DECIMAL(18,2) COMMENT 'The monetary amount refunded to the customer via payment reversal as a result of the dispute resolution, in USD.',
    `resolution_date` DATE COMMENT 'The date the dispute was formally resolved and closed.',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the investigation findings, actions taken, and rationale for the resolution decision.',
    `resolution_type` STRING COMMENT 'The outcome classification of the dispute resolution indicating how the dispute was settled. [ENUM-REF-CANDIDATE: credit issued|charge upheld|partial credit|invoice corrected|waived|refund issued|adjustment applied — 7 candidates stripped; promote to reference product]',
    `root_cause_category` STRING COMMENT 'Classification of the underlying root cause identified during dispute investigation, used for process improvement and trend analysis. [ENUM-REF-CANDIDATE: billing system error|rate table error|service delivery failure|data entry error|customer misunderstanding|policy exception|system integration issue — 7 candidates stripped; promote to reference product]',
    `service_date` DATE COMMENT 'The date of the service event that is the subject of the dispute (e.g., scheduled pickup date for a missed pickup dispute).',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicator of whether the dispute resolution exceeded the SLA target resolution timeframe.',
    `sla_target_resolution_date` DATE COMMENT 'The target date by which the dispute should be resolved per service level agreement commitments.',
    `sox_compliance_flag` BOOLEAN COMMENT 'Indicator of whether the dispute resolution followed SOX-compliant approval and documentation procedures for financial adjustments.',
    CONSTRAINT pk_dispute PRIMARY KEY(`dispute_id`)
) COMMENT 'Formal billing dispute raised by a customer contesting charges on an invoice. Captures dispute date, disputed invoice reference, disputed amount, dispute reason (incorrect rate, missed pickup, container size error, duplicate charge, tipping fee discrepancy), dispute status (open, under review, resolved, escalated), resolution type (credit issued, charge upheld, partial credit), resolution date, and assigned billing analyst. Integrates with Salesforce CRM case management.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`payment_plan` (
    `payment_plan_id` BIGINT COMMENT 'Unique identifier for the payment plan arrangement. Primary key.',
    `billing_account_id` BIGINT COMMENT 'Reference to the customer account enrolled in this payment plan.',
    `billing_term_id` BIGINT COMMENT 'Foreign key linking to contract.billing_term. Business justification: Payment plans are negotiated deviations from standard contract billing terms. Referencing the original billing_term being modified supports collections management, dunning configuration, and contract ',
    `contract_id` BIGINT COMMENT 'Foreign key linking to contract.contract. Business justification: Payment plans are negotiated as part of contract terms. Collections and credit teams need to trace payment arrangements back to originating agreement for covenant compliance, early termination penalty',
    `approval_date` DATE COMMENT 'Date the payment plan was approved by management. Null if no approval was required.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this payment plan required management approval before activation. Typically true for large balances, extended terms, or settlement plans.',
    `auto_pay_enabled_flag` BOOLEAN COMMENT 'Indicates whether automatic payment processing is enabled for this plan. When true, installments are automatically charged to the customers payment method on file on each due date.',
    `bankruptcy_case_number` STRING COMMENT 'Court-assigned bankruptcy case number if this payment plan is part of a bankruptcy arrangement. Null for non-bankruptcy plans.. Valid values are `^[0-9]{2}-[0-9]{5}$`',
    `bankruptcy_chapter` STRING COMMENT 'Type of bankruptcy filing if this payment plan is part of a bankruptcy arrangement. Chapter 7 is liquidation; Chapter 11 is business reorganization; Chapter 13 is individual debt adjustment. Null for non-bankruptcy plans.. Valid values are `chapter_7|chapter_11|chapter_13`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payment plan record was first created in the system.',
    `default_threshold_count` STRING COMMENT 'Number of missed installments allowed before the plan is automatically moved to defaulted status. Typically 2 for standard plans, may be higher for hardship programs.',
    `down_payment_amount` DECIMAL(18,2) COMMENT 'Initial payment required at plan setup before installment schedule begins. May be zero for certain hardship programs.',
    `down_payment_received_date` DATE COMMENT 'Date the down payment was received and processed. Null if no down payment was required or if down payment is still outstanding.',
    `enrolled_balance_amount` DECIMAL(18,2) COMMENT 'The portion of the original balance that was enrolled into this payment plan. May be less than original balance if customer made partial payment or if certain charges were excluded from the plan.',
    `final_installment_due_date` DATE COMMENT 'Scheduled due date for the last installment payment. Represents the planned completion date of the payment plan.',
    `first_installment_due_date` DATE COMMENT 'Scheduled due date for the first installment payment. Subsequent installments are calculated based on this date and the installment frequency.',
    `grace_period_days` STRING COMMENT 'Number of days after installment due date before payment is considered missed. Standard grace period is typically 10 days.',
    `installment_amount` DECIMAL(18,2) COMMENT 'Standard amount due for each installment payment. Calculated as (enrolled_balance_amount - down_payment_amount) / total_installment_count. Final installment may differ to account for rounding.',
    `installment_frequency` STRING COMMENT 'Cadence at which installment payments are scheduled. Monthly is most common; weekly and biweekly are used for residential hardship programs; quarterly may be used for large commercial accounts.. Valid values are `weekly|biweekly|monthly|quarterly`',
    `interest_accrued_amount` DECIMAL(18,2) COMMENT 'Total interest charges accrued on this payment plan to date. Zero for interest-free plans.',
    `interest_rate_percent` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the enrolled balance, if any. Most residential hardship plans have zero interest; commercial workout agreements may include interest. Expressed as percentage (e.g., 5.00 for 5%).',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Standard late fee charged for each missed installment payment. May be waived for hardship programs.',
    `missed_installment_count` STRING COMMENT 'Number of scheduled installments that were not paid by their due date. Used to determine default status and trigger collections escalation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payment plan record was last modified. Updated whenever plan status, payment amounts, or other attributes change.',
    `notes` STRING COMMENT 'Free-text notes capturing special terms, customer circumstances, negotiation details, or other relevant information about this payment plan.',
    `original_balance_amount` DECIMAL(18,2) COMMENT 'Total outstanding accounts receivable (AR) balance at the time the payment plan was established. Represents the full amount owed before any plan payments were made.',
    `plan_end_date` DATE COMMENT 'Actual date the payment plan was completed, defaulted, or cancelled. Null for active or suspended plans. For completed plans, this is the date the final payment was received; for defaulted or cancelled plans, this is the date the plan was terminated.',
    `plan_number` STRING COMMENT 'Externally visible unique business identifier for the payment plan, formatted as PP-NNNNNNNN.. Valid values are `^PP-[0-9]{8}$`',
    `plan_start_date` DATE COMMENT 'Effective date when the payment plan became active and the installment schedule began. Typically the date the plan was approved and down payment (if required) was received.',
    `plan_status` STRING COMMENT 'Current lifecycle state of the payment plan. Draft indicates plan is being set up but not yet active; active means plan is in effect and installments are being processed; completed indicates all installments paid successfully; defaulted means customer missed installments per default criteria; cancelled indicates plan was terminated before completion; suspended means plan is temporarily on hold pending resolution of dispute or other issue.. Valid values are `draft|active|completed|defaulted|cancelled|suspended`',
    `plan_type` STRING COMMENT 'Classification of the payment plan based on the business program and customer segment. Residential hardship programs support customers facing temporary financial difficulty; commercial workout agreements are negotiated arrangements for business accounts; standard installment plans are routine payment schedules; seasonal deferral plans accommodate seasonal business fluctuations; bankruptcy arrangements comply with court-ordered payment terms; settlement plans represent negotiated reduced-balance agreements.. Valid values are `residential_hardship|commercial_workout|standard_installment|seasonal_deferral|bankruptcy_arrangement|settlement_plan`',
    `remaining_balance_amount` DECIMAL(18,2) COMMENT 'Current outstanding balance remaining on the payment plan after all payments received to date. Calculated as enrolled_balance_amount minus sum of all installment payments received.',
    `settlement_discount_amount` DECIMAL(18,2) COMMENT 'Dollar amount of discount applied to the original balance as part of a settlement agreement. Zero for standard payment plans.',
    `settlement_discount_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to the original balance as part of a settlement agreement. Zero for standard payment plans. Expressed as percentage (e.g., 20.00 for 20% discount).',
    `total_installment_count` STRING COMMENT 'Total number of scheduled installment payments in this plan. Typically ranges from 3 to 24 installments depending on plan type and balance amount.',
    `total_late_fees_assessed` DECIMAL(18,2) COMMENT 'Cumulative sum of all late fees assessed on this payment plan due to missed installments.',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Cumulative sum of all payments received against this payment plan, including down payment and all installment payments to date.',
    CONSTRAINT pk_payment_plan PRIMARY KEY(`payment_plan_id`)
) COMMENT 'Structured installment arrangement established for customers unable to pay their full outstanding AR balance, including individual scheduled installment records. Header captures plan start/end dates, total balance enrolled, number of installments, installment amount, frequency, down payment, plan status (active, completed, defaulted, cancelled), and collection agent ID. Each installment detail captures sequence number, scheduled due date, scheduled amount, actual payment date, actual amount paid, installment status (scheduled, paid, missed, waived), and days past due. Supports residential hardship programs, commercial account workout agreements, and enables collections teams to track compliance and trigger dunning on missed installments.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`surcharge` (
    `surcharge_id` BIGINT COMMENT 'Unique identifier for the surcharge definition. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.area. Business justification: Surcharges are area-specific (franchise fees, local regulatory surcharges, host community fees vary by service area). Area-based surcharge applicability management and franchise compliance reporting r',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Facility-specific surcharges (host community fees, landfill environmental levies, MRF processing surcharges) must be scoped to a specific facility. Waste management billing requires linking surcharges',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Environmental surcharges (host community fees, state environmental fees) are mandated by permit conditions and regulatory requirements. Surcharges must be traceable to the authorizing permit for compl',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Surcharges marked is_regulatory_mandated are directly required by specific regulatory requirements. The existing regulatory_authority and regulatory_reference columns are denormalized representations ',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Surcharges are waste-stream-specific (hazmat surcharge, organics processing surcharge, contamination surcharge). Regulatory surcharge reporting and applicability validation require linking surcharges ',
    `applicability_customer_type` STRING COMMENT 'Pipe-separated list of customer types to which this surcharge applies (e.g., residential|commercial|industrial|municipal). Empty if applicable to all customer types. [ENUM-REF-CANDIDATE: residential|commercial|industrial|municipal|government|non_profit|construction — promote to reference product]',
    `applicability_service_type` STRING COMMENT 'Pipe-separated list of service types to which this surcharge applies (e.g., collection|disposal|recycling|hazardous_waste|roll_off). Empty if applicable to all service types. [ENUM-REF-CANDIDATE: collection|disposal|recycling|hazardous_waste|roll_off|compactor|special_waste|medical_waste — promote to reference product]',
    `approval_required` BOOLEAN COMMENT 'Indicates whether application of this surcharge to a customer invoice requires managerial approval. True if approval required, False if can be applied automatically.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when this surcharge definition was approved for use in billing. Populated when approval_required is True and surcharge has been approved.',
    `calculation_basis` STRING COMMENT 'Method used to calculate the surcharge amount: percentage_of_base (percentage of base service charge), flat_fee (fixed dollar amount), per_ton (rate per ton of waste), per_yard (rate per cubic yard), per_pickup (rate per pickup event), per_container (rate per container), tiered (tiered rate structure), formula (custom formula-based calculation). [ENUM-REF-CANDIDATE: percentage_of_base|flat_fee|per_ton|per_yard|per_pickup|per_container|tiered|formula — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this surcharge definition record was first created in the system. Part of audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the surcharge rate (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this surcharge definition expires and can no longer be applied to new invoices. Nullable for open-ended surcharges. Part of the temporal validity range.',
    `effective_start_date` DATE COMMENT 'Date when this surcharge definition becomes effective and can be applied to customer invoices. Part of the temporal validity range.',
    `gl_account_code` STRING COMMENT 'General Ledger account code to which revenue from this surcharge is posted in the financial system. Maps to SAP FI/CO chart of accounts.. Valid values are `^[0-9]{4,10}$`',
    `invoice_description` STRING COMMENT 'Customer-facing description of the surcharge as it appears on invoices. May differ from internal surcharge_name to provide clearer customer communication.',
    `invoice_display_order` STRING COMMENT 'Numeric sequence order in which this surcharge should appear on customer invoices. Lower numbers appear first. Used to control invoice line item presentation.',
    `is_prorated` BOOLEAN COMMENT 'Indicates whether this surcharge should be prorated for partial billing periods (e.g., mid-month service start/stop). True if prorated, False if charged in full regardless of period.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this surcharge is applied on a recurring basis (e.g., monthly fuel surcharge) or is a one-time charge. True if recurring, False if one-time.',
    `is_regulatory_mandated` BOOLEAN COMMENT 'Indicates whether this surcharge is mandated by regulatory authority (EPA, state environmental agency, local solid waste authority) or is a discretionary business charge. True if regulatory-mandated, False if discretionary.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether this surcharge is subject to sales tax or other applicable taxes. True if taxable, False if tax-exempt.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this surcharge definition record was last updated. Part of audit trail.',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Maximum dollar amount for this surcharge regardless of calculation basis. Nullable if no maximum applies. Ensures surcharge does not exceed a cap value.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum dollar amount for this surcharge regardless of calculation basis. Nullable if no minimum applies. Ensures surcharge meets a floor value.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, business rules, or special instructions for applying this surcharge. Used for internal documentation and billing team guidance.',
    `rate_value` DECIMAL(18,2) COMMENT 'Current rate value for the surcharge. Interpretation depends on calculation_basis: for percentage_of_base this is the percentage (e.g., 5.5 for 5.5%), for flat_fee this is the dollar amount, for per_ton/per_yard/per_pickup/per_container this is the unit rate.',
    `recurrence_frequency` STRING COMMENT 'Frequency at which this surcharge recurs: monthly (every month), quarterly (every quarter), annually (every year), per_service (each service event), one_time (single occurrence). Populated only when is_recurring is True.. Valid values are `monthly|quarterly|annually|per_service|one_time`',
    `revenue_category` STRING COMMENT 'High-level revenue classification for financial reporting: service_revenue (core service charges), surcharge_revenue (fuel and environmental surcharges), fee_revenue (administrative and regulatory fees), penalty_revenue (late payment and violation penalties), other_revenue (miscellaneous revenue).. Valid values are `service_revenue|surcharge_revenue|fee_revenue|penalty_revenue|other_revenue`',
    `surcharge_code` STRING COMMENT 'Unique business identifier code for the surcharge (e.g., FUEL_SUR, ENV_FEE, REG_REC, ADMIN_FEE, LATE_PAY). Used in billing systems and customer communications.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `surcharge_name` STRING COMMENT 'Full descriptive name of the surcharge as it appears on customer invoices (e.g., Fuel Surcharge, Environmental Fee, Regulatory Recovery Fee, Administrative Fee, Late Payment Fee).',
    `surcharge_status` STRING COMMENT 'Current lifecycle status of the surcharge definition: active (currently in use), inactive (not in use), pending (approved but not yet effective), expired (past effective end date), suspended (temporarily disabled).. Valid values are `active|inactive|pending|expired|suspended`',
    `surcharge_type` STRING COMMENT 'Classification of the surcharge by business purpose: fuel (fuel cost recovery), environmental (environmental compliance fees), regulatory (regulatory recovery fees), administrative (administrative processing fees), late_payment (late payment penalties), disposal (special disposal fees), contamination (contamination processing fees), distance (distance-based fees), special_handling (special handling fees), other (miscellaneous surcharges). [ENUM-REF-CANDIDATE: fuel|environmental|regulatory|administrative|late_payment|disposal|contamination|distance|special_handling|other — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_surcharge PRIMARY KEY(`surcharge_id`)
) COMMENT 'Master definition of surcharges and fees that can be applied to customer invoices beyond base service rates. Captures surcharge code, surcharge name (fuel surcharge, environmental fee, regulatory recovery fee, administrative fee, late payment fee), calculation basis (percentage of base, flat fee, per-ton), current rate, effective date range, applicability rules (customer type, service type, geography), and regulatory mandate flag. Managed centrally to ensure consistent application across all billing runs.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`rated_usage` (
    `rated_usage_id` BIGINT COMMENT 'Unique identifier for the rated usage record. Primary key for the rated usage entity.',
    `surcharge_id` BIGINT COMMENT 'Foreign key linking to billing.surcharge. Business justification: Rated usage records capture priced usage events with fuel_surcharge_amount, environmental_fee_amount, and other_surcharge_amount. Adding applied_surcharge_id FK links to the surcharge master definitio',
    `asset_container_id` BIGINT COMMENT 'Reference to the specific container associated with this usage event. Applicable for container rental and pickup usage types.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: rated_usage currently references customer_account_id (cross-domain) but lacks a direct reference to the billing_account, which is the financial entity governing billing terms, cycle, and AR. Adding bi',
    `contract_id` BIGINT COMMENT 'Reference to the service contract under which this usage occurred. Determines applicable rate schedules and pricing terms.',
    `facility_id` BIGINT COMMENT 'Reference to the Waste Management facility where usage was processed (landfill, transfer station, MRF). Applicable for disposal and processing usage types.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice to which this rated usage was aggregated. Null if not yet invoiced. Links rated usage to billing output.',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: rated_usage is the output of the rating engine that produces the priced charge which becomes an invoice line. Linking rated_usage to the specific invoice_line it generated enables end-to-end revenue t',
    `load_ticket_id` BIGINT COMMENT 'Foreign key linking to collection.load_ticket. Business justification: Transfer station tipping fees are rated from load tickets; direct link enables automated rating, reconciliation between operational and billing systems, and regulatory compliance reporting.',
    `on_demand_request_id` BIGINT COMMENT 'Foreign key linking to collection.on_demand_request. Business justification: On-demand charge rating audit trail: rated_usage records the rating calculation for on-demand service charges. Direct FK to on_demand_request enables billing auditors to verify rated charges match the',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Rated usage for billing must link to the permit authorizing the service, especially for regulated waste streams. Ensures charges align with permitted activities and supports regulatory reporting of bi',
    `pickup_event_id` BIGINT COMMENT 'Foreign key linking to collection.pickup_event. Business justification: Rated usage records require direct link to the pickup event that generated the billable service for audit trail, dispute resolution, and regulatory reporting of service delivery.',
    `pricing_id` BIGINT COMMENT 'Foreign key linking to contract.pricing. Business justification: The rating engine applies a specific contract pricing record to compute charges for each usage event. Tracing rated_usage to the pricing record applied is essential for billing audits, rate dispute re',
    `program_id` BIGINT COMMENT 'Foreign key linking to recycling.recycling_program. Business justification: Usage rating for recycling program processing charges, diversion fees, and revenue share calculations requires identifying the specific recycling program driving the usage event. Billing rating engine',
    `rate_component_id` BIGINT COMMENT 'Reference to the specific rate component within the rate schedule that was applied (e.g., base rate, overage rate, peak rate). Enables granular charge attribution.',
    `rolloff_order_id` BIGINT COMMENT 'Foreign key linking to collection.rolloff_order. Business justification: Rolloff charge rating audit trail: rated_usage records the pre-invoice rating calculation for rolloff rental and disposal charges. Direct FK to rolloff_order supports rating engine audit — verifying t',
    `route_execution_id` BIGINT COMMENT 'Foreign key linking to collection.route_execution. Business justification: Rating engine reconciliation: rated_usage must trace back to the route_execution that generated billable events. Billing analysts verifying service-to-bill accuracy join rated_usage to route_execution',
    `route_id` BIGINT COMMENT 'Reference to the collection route on which usage occurred. Applicable for pickup and collection usage types.',
    `run_id` BIGINT COMMENT 'Foreign key linking to billing.run. Business justification: rated_usage has a rating_batch_reference (STRING) that identifies the billing run that processed it. This should be a proper FK to the run entity rather than a free-text batch reference string. Adding',
    `service_address_id` BIGINT COMMENT 'Reference to the service location where usage occurred. Used for tax jurisdiction determination and geographic reporting.',
    `service_commitment_id` BIGINT COMMENT 'Foreign key linking to contract.service_commitment. Business justification: Rated usage must reference the service commitment that defines rate schedule, service frequency, and overage thresholds. Critical for tiered pricing application, minimum commitment true-ups, variance ',
    `service_enrollment_id` BIGINT COMMENT 'Foreign key linking to customer.service_enrollment. Business justification: Rated usage records represent billable consumption for a specific enrolled service. In waste management, each pickup event is rated against the service enrollments contracted terms. This link is esse',
    `service_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to service.service_rate_schedule. Business justification: Rate reconciliation audit: rated_usage applies billing engine rates (billing_rate_schedule) but must also reference the service catalog rate (service_rate_schedule) to detect and report rate variances',
    `service_schedule_id` BIGINT COMMENT 'Foreign key linking to collection.service_schedule. Business justification: Recurring service rating process: rated_usage for scheduled recurring services must reference the service_schedule to apply correct frequency-based rates and container configurations. Rating engine us',
    `tax_rule_id` BIGINT COMMENT 'Foreign key linking to billing.tax_rule. Business justification: Rated usage records include tax_amount but no FK to tax_rule master. During rating, tax rules are applied based on service type, jurisdiction, and customer exemption status. Adding tax_rule_id FK link',
    `vehicle_assignment_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle_assignment. Business justification: Rated usage records the billable service event; vehicle_assignment is the operational execution of that event. Direct link enables cost-per-assignment vs. revenue-per-assignment reporting, driver/vehi',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to fleet.vehicle. Business justification: Revenue-per-vehicle reporting and fleet cost-recovery analysis require direct linkage between billable service events and the vehicle that performed them. Waste management operations track vehicle uti',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Rated usage records drive tipping fees, environmental fees, and surcharges — all waste-stream-dependent. Revenue reporting by waste stream and EPA tonnage reporting require rated_usage to reference ca',
    `weight_ticket_id` BIGINT COMMENT 'Foreign key linking to collection.weight_ticket. Business justification: Tonnage-based rated usage requires direct link to weight ticket for audit trail, regulatory reporting, and reconciliation between operational weights and billed quantities.',
    `accounting_period` STRING COMMENT 'Fiscal period to which this rated usage is assigned for financial reporting. Format typically YYYY-MM or YYYY-Qn.',
    `base_charge_amount` DECIMAL(18,2) COMMENT 'Calculated charge amount before surcharges, fees, and taxes. Computed as usage_quantity multiplied by unit_rate.',
    `comments` STRING COMMENT 'Free-text notes or comments about this rated usage record. May include override justification, special handling notes, or dispute resolution details.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this rated usage record was first created in the system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rated usage record. Supports multi-currency billing for international operations.. Valid values are `USD|CAD|MXN`',
    `environmental_fee_amount` DECIMAL(18,2) COMMENT 'Regulatory or operational environmental fee applied to the usage. May include host community fees, state environmental fees, or landfill closure fees.',
    `fuel_surcharge_amount` DECIMAL(18,2) COMMENT 'Additional charge applied to cover fuel cost fluctuations. Calculated based on fuel surcharge rate schedule and usage quantity.',
    `gl_date` DATE COMMENT 'Accounting date for general ledger posting. Determines the accounting period for revenue recognition. May differ from usage_date based on revenue recognition rules.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this rated usage record was last updated. Tracks changes for audit and compliance purposes.',
    `override_flag` BOOLEAN COMMENT 'Indicates whether this rated usage was manually overridden by a billing analyst. True if rates or amounts were manually adjusted, false for standard rating engine output.',
    `override_reason_code` STRING COMMENT 'Reason code for manual override if override_flag is true. Null for non-overridden records. Supports audit trail and dispute resolution.. Valid values are `CUSTOMER_DISPUTE|PRICING_ERROR|GOODWILL_ADJUSTMENT|CONTRACT_EXCEPTION|SYSTEM_ERROR|RATE_CORRECTION`',
    `override_timestamp` TIMESTAMP COMMENT 'Date and time when the manual override was performed. Null for non-overridden records.',
    `rated_timestamp` TIMESTAMP COMMENT 'Date and time when the rating engine processed and priced this usage event. Represents the rating execution time, not the usage occurrence time.',
    `rating_error_code` STRING COMMENT 'Error code if rating failed or encountered issues. Null for successfully rated records. Used for troubleshooting and reprocessing.',
    `rating_error_message` STRING COMMENT 'Detailed error message describing why rating failed or what issue was encountered. Null for successfully rated records.',
    `rating_status` STRING COMMENT 'Current status of the rating process for this usage event. Indicates whether rating completed successfully or requires intervention.. Valid values are `RATED|PENDING|ERROR|OVERRIDE|REPROCESSED|CANCELLED`',
    `revenue_recognition_rule` STRING COMMENT 'Revenue recognition method applied to this rated usage. Determines timing of revenue recognition per GAAP/IFRS standards.. Valid values are `IMMEDIATE|DEFERRED|PRORATED|MILESTONE`',
    `service_type_code` STRING COMMENT 'Type of waste management service for which usage was rated. Categorizes the billable service line.. Valid values are `RESIDENTIAL_COLLECTION|COMMERCIAL_COLLECTION|ROLLOFF|RECYCLING|LANDFILL_DISPOSAL|TRANSFER_STATION`',
    `subtotal_amount` DECIMAL(18,2) COMMENT 'Total charge amount before taxes. Sum of base_charge_amount plus all applicable surcharges and fees.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the rated usage. Includes sales tax, use tax, and any other applicable taxes based on service location and tax jurisdiction.',
    `total_charge_amount` DECIMAL(18,2) COMMENT 'Final billable amount for this rated usage event. Sum of subtotal_amount and tax_amount. This is the amount that will appear on the customer invoice.',
    `unit_of_measure` STRING COMMENT 'Unit in which the usage quantity is expressed. Aligns with rate schedule unit definitions.. Valid values are `EACH|TON|CUBIC_YARD|DAY|GALLON|POUND`',
    `unit_rate` DECIMAL(18,2) COMMENT 'Price per unit applied from the rate schedule. The rate component value used in the charge calculation.',
    `usage_date` DATE COMMENT 'Date when the actual usage event occurred (pickup date, disposal date, rental day). Business event date for revenue recognition and reporting.',
    `usage_quantity` DECIMAL(18,2) COMMENT 'Measured quantity of usage that was rated. Value depends on usage type: number of pickups, tons of waste, days of container rental, etc.',
    CONSTRAINT pk_rated_usage PRIMARY KEY(`rated_usage_id`)
) COMMENT 'Priced and rated version of a usage event, representing the output of the rating engine that applies the appropriate rate schedule to a raw usage event to produce a billable charge amount. Captures rated date, applied rate schedule, applied rate component, rated quantity, unit rate, calculated charge amount, applicable surcharges, tax amount, and rating status (rated, pending, error, override). Bridges raw operational usage data and the invoice generation process.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`tax_rule` (
    `tax_rule_id` BIGINT COMMENT 'Unique identifier for the tax rule configuration. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.area. Business justification: Tax rules are jurisdiction-specific and service areas map to jurisdictions. Area-based tax rule lookup and state/local tax compliance reporting require this link. jurisdiction_county, jurisdiction_mun',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Waste disposal tax rules (landfill taxes, state waste fees) are mandated by specific regulatory requirements. The existing regulatory_reference column is a denormalized pointer to regulatory_requireme',
    `superseded_by_rule_tax_rule_id` BIGINT COMMENT 'Identifier of the tax rule that replaces this rule when it expires or is updated, maintaining audit trail of rule changes.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.waste_stream. Business justification: Tax rules are waste-stream-specific (MSW, C&D, hazmat, and recyclables have different tax treatments under state/local law). Regulatory tax compliance reporting and tax rule applicability validation r',
    `applicable_service_types` STRING COMMENT 'Comma-separated list of waste management service types to which this tax rule applies (e.g., residential collection, commercial hauling, landfill disposal, recycling, hazardous waste). [ENUM-REF-CANDIDATE: residential_collection|commercial_collection|landfill_disposal|recycling|hazardous_waste|transfer_station|waste_to_energy|rolloff_service — promote to reference product]',
    `approval_status` STRING COMMENT 'Approval workflow status for the tax rule configuration: pending review, approved for use, or rejected.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the tax rule was approved (format: yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `calculation_method` STRING COMMENT 'Method used to calculate the tax: percentage of base amount, flat fee, tiered rate structure, per-unit charge, or compound (tax on tax).. Valid values are `percentage|flat_fee|tiered|per_unit|compound`',
    `compounding_sequence` STRING COMMENT 'Order in which this tax is applied when multiple taxes compound on each other. Lower numbers are applied first.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this tax rule record was first created in the system (format: yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for tax amounts (typically USD for U.S. operations).. Valid values are `^[A-Z]{3}$`',
    `customer_type_applicability` STRING COMMENT 'Customer segments to which this tax rule applies (all, residential, commercial, industrial, municipal, government).. Valid values are `all|residential|commercial|industrial|municipal|government`',
    `effective_end_date` DATE COMMENT 'Date when this tax rule expires or is superseded by a new rule. Null indicates an open-ended rule (format: yyyy-MM-dd).',
    `effective_start_date` DATE COMMENT 'Date when this tax rule becomes active and begins applying to transactions (format: yyyy-MM-dd).',
    `exemption_categories` STRING COMMENT 'Comma-separated list of exemption categories that exclude customers or transactions from this tax (e.g., nonprofit, government, recycling-only, tax-exempt certificate holders).',
    `exemption_certificate_required` BOOLEAN COMMENT 'Indicates whether a valid tax exemption certificate must be on file to apply the exemption (True/False).',
    `flat_fee_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount charged per transaction or unit when tax is assessed as a flat fee rather than a percentage rate.',
    `gl_account_code` STRING COMMENT 'General Ledger account code in SAP FI/CO where tax revenue or liability is posted for financial reporting and reconciliation.. Valid values are `^[0-9]{4,10}$`',
    `gl_cost_center` STRING COMMENT 'Cost center code for internal allocation and management reporting of tax-related revenue or expenses.. Valid values are `^[A-Z0-9]{4,10}$`',
    `jurisdiction_state` STRING COMMENT 'Two-letter state code where the tax rule applies (ISO 3166-2:US format).. Valid values are `^[A-Z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this tax rule record was last updated (format: yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `maximum_tax_amount` DECIMAL(18,2) COMMENT 'Maximum tax amount cap per transaction or billing period, limiting tax liability for high-value transactions.',
    `minimum_tax_amount` DECIMAL(18,2) COMMENT 'Minimum tax amount to be charged regardless of calculated tax, ensuring a floor for tax collection.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, special instructions, or business rationale for the tax rule configuration.',
    `remittance_due_day` STRING COMMENT 'Day of the month (1-31) or days after period end when tax remittance payment is due to the authority.',
    `remittance_frequency` STRING COMMENT 'Frequency at which collected taxes must be remitted to the tax authority: monthly, quarterly, annually, or on-demand.. Valid values are `monthly|quarterly|annually|on_demand`',
    `reporting_code` STRING COMMENT 'Code used for regulatory tax reporting and filing with state or local authorities (e.g., sales tax jurisdiction code, waste tax category code).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `revenue_recognition_rule` STRING COMMENT 'Accounting rule for when tax revenue is recognized: immediate upon billing, deferred to service delivery, prorated over service period, or milestone-based.. Valid values are `immediate|deferred|prorated|milestone`',
    `rule_code` STRING COMMENT 'Business identifier code for the tax rule, used for external reference and system integration.. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `rule_description` STRING COMMENT 'Detailed description of the tax rule including applicability conditions, exemptions, and business context.',
    `rule_name` STRING COMMENT 'Descriptive name of the tax rule for business user identification and reporting purposes.',
    `rule_status` STRING COMMENT 'Current lifecycle status of the tax rule: draft, pending approval, active, suspended, expired, or superseded.. Valid values are `draft|pending_approval|active|suspended|expired|superseded`',
    `tax_authority_code` STRING COMMENT 'Standardized code identifying the tax authority (e.g., state FIPS code, county code, municipality tax ID).. Valid values are `^[A-Z0-9]{2,10}$`',
    `tax_authority_name` STRING COMMENT 'Name of the governmental entity or tax authority imposing the tax (e.g., State of California, Cook County, City of Houston).',
    `tax_authority_type` STRING COMMENT 'Level of government or jurisdiction imposing the tax (state, county, municipality, special district, federal, tribal).. Valid values are `state|county|municipality|special_district|federal|tribal`',
    `tax_base` STRING COMMENT 'The base amount or unit upon which the tax is calculated: gross invoice amount, net amount after discounts, tonnage disposed, number of pickups, container count, or service days.. Valid values are `gross_amount|net_amount|tonnage|pickup_count|container_count|service_days`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate expressed as a decimal (e.g., 0.0825 for 8.25% tax rate). Supports up to six decimal places for precision.',
    `tax_rate_percentage` DECIMAL(18,2) COMMENT 'Tax rate expressed as a percentage (e.g., 8.25 for 8.25% tax). Used for display and reporting purposes.',
    `tax_type` STRING COMMENT 'Category of tax being applied: sales tax, excise tax, solid waste tax, environmental surcharge, tipping fee tax, or franchise fee.. Valid values are `sales_tax|excise_tax|solid_waste_tax|environmental_surcharge|tipping_fee_tax|franchise_fee`',
    CONSTRAINT pk_tax_rule PRIMARY KEY(`tax_rule_id`)
) COMMENT 'Reference configuration defining tax applicability rules for waste management services by jurisdiction. Captures tax authority (state, county, municipality), tax type (sales tax, excise tax, solid waste tax, environmental surcharge tax), applicable service types, tax rate, effective date range, exemption categories, and tax account GL mapping. Supports multi-jurisdiction tax compliance for Waste Managements nationwide operations.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`billing`.`billing_account` (
    `billing_account_id` BIGINT COMMENT 'Unique identifier for the billing account. Primary key.',
    `area_id` BIGINT COMMENT 'Foreign key linking to service.service_area. Business justification: Billing accounts are domiciled in service areas for franchise compliance, tax jurisdiction determination, service territory management, and regulatory reporting. Essential for municipal contract compl',
    `contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: The billing account must reference the designated billing contact for invoice delivery, payment reminders, and dunning communications. billing_contact_name, billing_contact_email, billing_contact_phon',
    `bundle_id` BIGINT COMMENT 'Foreign key linking to service.bundle. Business justification: Account-level bundle enrollment drives billing account pricing, invoice generation, and bundle discount application. A billing account enrolled in a service bundle must reference that bundle for bundl',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer master account in the customer domain. A single customer may have multiple billing accounts for different service locations or business units.',
    `cycle_id` BIGINT COMMENT 'FK to billing.billing_cycle',
    `account_name` STRING COMMENT 'Descriptive name for the billing account, often matching the customer legal name or a business unit designation.',
    `account_number` STRING COMMENT 'Human-readable billing account number displayed on invoices and customer communications. Externally visible identifier.. Valid values are `^BA[0-9]{8,12}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the billing account indicating its operational state and billing eligibility.. Valid values are `active|suspended|closed|pending_activation|delinquent|collections`',
    `account_type` STRING COMMENT 'Classification of the billing account based on customer segment and service model.. Valid values are `residential|commercial|industrial|municipal|government|non_profit`',
    `autopay_enrolled_flag` BOOLEAN COMMENT 'Indicates whether the account is enrolled in automatic payment processing on invoice due date.',
    `autopay_enrollment_date` DATE COMMENT 'Date when the customer enrolled in automatic payment processing.',
    `billing_address_line1` STRING COMMENT 'Primary street address line for billing correspondence and invoice delivery.',
    `billing_address_line2` STRING COMMENT 'Secondary address line for suite, apartment, or unit number for billing correspondence.',
    `billing_city` STRING COMMENT 'City name for the billing address.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO country code for the billing address.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'ZIP or postal code for the billing address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `billing_state_province` STRING COMMENT 'Two-letter state or province code for the billing address.. Valid values are `^[A-Z]{2}$`',
    `business_unit_code` STRING COMMENT 'Business unit or division code for organizational hierarchy and reporting segmentation.. Valid values are `^[A-Z0-9]{2,6}$`',
    `close_date` DATE COMMENT 'Date when the billing account was closed and billing operations ceased.',
    `close_reason_code` STRING COMMENT 'Standardized code indicating the reason for account closure (e.g., customer request, non-payment, service termination).. Valid values are `^[A-Z0-9]{2,6}$`',
    `cost_center_code` STRING COMMENT 'Cost center code for internal financial reporting and profitability analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing account record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum outstanding balance allowed for the account before service suspension or payment requirement.',
    `credit_rating` STRING COMMENT 'Internal or external credit assessment classification used for credit limit determination and collections risk management.. Valid values are `excellent|good|fair|poor|no_rating`',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all billing transactions on this account.. Valid values are `^[A-Z]{3}$`',
    `dunning_level` STRING COMMENT 'Current escalation level in the collections process, indicating severity of delinquency and collection actions taken.',
    `gl_account_code` STRING COMMENT 'General ledger account code in SAP FI/CO for revenue recognition and accounts receivable posting.. Valid values are `^[0-9]{4,10}$`',
    `last_dunning_date` DATE COMMENT 'Most recent date when a dunning notice or collection communication was sent to the customer.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing account record was most recently updated.',
    `notes` STRING COMMENT 'Free-form text field for special billing instructions, account-specific arrangements, or internal comments.',
    `open_date` DATE COMMENT 'Date when the billing account was first established and activated for billing operations.',
    `oracle_account_number` STRING COMMENT 'External account identifier in Oracle Revenue Management system used for billing and invoicing integration.. Valid values are `^[A-Z0-9]{8,20}$`',
    `paperless_billing_flag` BOOLEAN COMMENT 'Indicates whether the customer has opted for electronic invoice delivery instead of paper statements.',
    `paperless_enrollment_date` DATE COMMENT 'Date when the customer enrolled in paperless billing.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date until payment is due, defining the standard payment window.',
    `preferred_payment_method` STRING COMMENT 'Default payment instrument type preferred by the customer for invoice settlement.. Valid values are `ach|credit_card|check|wire_transfer|cash`',
    `profit_center_code` STRING COMMENT 'Profit center code for segment reporting and business unit performance tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the account is exempt from sales tax or other applicable taxes on waste management services.',
    `tax_exemption_certificate_number` STRING COMMENT 'Government-issued certificate number validating the tax-exempt status of the account.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `tax_exemption_expiration_date` DATE COMMENT 'Date when the tax exemption certificate expires and requires renewal.',
    CONSTRAINT pk_billing_account PRIMARY KEY(`billing_account_id`)
) COMMENT 'Billing-specific account entity representing the financial relationship between Waste Management and a customer for invoicing and payment purposes. Distinct from the customer master (owned by customer domain) — this entity captures billing address, billing contact, preferred payment method, autopay enrollment, paperless billing flag, billing currency, tax exemption status, tax exemption certificate number, credit rating, and Oracle Revenue Management account number. A single customer may have multiple billing accounts (e.g., separate accounts per service location or business unit).';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `waste_management_ecm`.`billing`.`ar_account`(`ar_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `waste_management_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_run_id` FOREIGN KEY (`run_id`) REFERENCES `waste_management_ecm`.`billing`.`run`(`run_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_billing_tipping_fee_schedule_id` FOREIGN KEY (`billing_tipping_fee_schedule_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule`(`billing_tipping_fee_schedule_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_rate_component_id` FOREIGN KEY (`rate_component_id`) REFERENCES `waste_management_ecm`.`billing`.`rate_component`(`rate_component_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_surcharge_id` FOREIGN KEY (`surcharge_id`) REFERENCES `waste_management_ecm`.`billing`.`surcharge`(`surcharge_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_tax_rule_id` FOREIGN KEY (`tax_rule_id`) REFERENCES `waste_management_ecm`.`billing`.`tax_rule`(`tax_rule_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `waste_management_ecm`.`billing`.`ar_account`(`ar_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `waste_management_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `waste_management_ecm`.`billing`.`ar_account`(`ar_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `waste_management_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ADD CONSTRAINT `fk_billing_ar_account_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ADD CONSTRAINT `fk_billing_ar_account_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `waste_management_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ADD CONSTRAINT `fk_billing_rate_component_superseded_by_component_rate_component_id` FOREIGN KEY (`superseded_by_component_rate_component_id`) REFERENCES `waste_management_ecm`.`billing`.`rate_component`(`rate_component_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`run` ADD CONSTRAINT `fk_billing_run_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `waste_management_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `waste_management_ecm`.`billing`.`ar_account`(`ar_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `waste_management_ecm`.`billing`.`dispute`(`dispute_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_reversed_adjustment_id` FOREIGN KEY (`reversed_adjustment_id`) REFERENCES `waste_management_ecm`.`billing`.`adjustment`(`adjustment_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_ar_account_id` FOREIGN KEY (`ar_account_id`) REFERENCES `waste_management_ecm`.`billing`.`ar_account`(`ar_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_surcharge_id` FOREIGN KEY (`surcharge_id`) REFERENCES `waste_management_ecm`.`billing`.`surcharge`(`surcharge_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `waste_management_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `waste_management_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_rate_component_id` FOREIGN KEY (`rate_component_id`) REFERENCES `waste_management_ecm`.`billing`.`rate_component`(`rate_component_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_run_id` FOREIGN KEY (`run_id`) REFERENCES `waste_management_ecm`.`billing`.`run`(`run_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ADD CONSTRAINT `fk_billing_rated_usage_tax_rule_id` FOREIGN KEY (`tax_rule_id`) REFERENCES `waste_management_ecm`.`billing`.`tax_rule`(`tax_rule_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ADD CONSTRAINT `fk_billing_tax_rule_superseded_by_rule_tax_rule_id` FOREIGN KEY (`superseded_by_rule_tax_rule_id`) REFERENCES `waste_management_ecm`.`billing`.`tax_rule`(`tax_rule_id`);
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ADD CONSTRAINT `fk_billing_billing_account_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `waste_management_ecm`.`billing`.`cycle`(`cycle_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `waste_management_ecm`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Amendment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `billing_term_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Term Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `commodity_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Sale Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Recycling Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `sla_term_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Term Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `billing_model_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Model Type');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `billing_model_type` SET TAGS ('dbx_value_regex' = 'subscription|transactional|tipping_fee|usage_based|hybrid|one_time');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `customer_type` SET TAGS ('dbx_business_glossary_term' = 'Customer Type');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `customer_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|government');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|customer_portal|edi');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{8,12}$');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|ach|check|wire_transfer|cash|auto_pay');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|due_on_receipt|prepaid');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `revenue_recognition_period` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Period');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `revenue_recognition_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'oracle_revenue_management|sap_sd|amcs_platform|manual_entry');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `source_system_invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Invoice Identifier');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Subtotal Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Total Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container ID (CID)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `bale_id` SET TAGS ('dbx_business_glossary_term' = 'Bale Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_tipping_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Tipping Fee Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `container_placement_id` SET TAGS ('dbx_business_glossary_term' = 'Container Placement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `haul_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Haul Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `inbound_load_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Load Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `load_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Load Ticket Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `on_demand_request_id` SET TAGS ('dbx_business_glossary_term' = 'On Demand Request Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `outbound_haul_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Haul Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `outbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Shipment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `performance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `pickup_event_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Event Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Recycling Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `residue_disposal_id` SET TAGS ('dbx_business_glossary_term' = 'Residue Disposal Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `rolloff_order_id` SET TAGS ('dbx_business_glossary_term' = 'Rolloff Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `scale_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Scale Transaction Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Service Exception Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Rate Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `stop_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Stop Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Rule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `tipping_fee_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Rate ID');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `weight_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Weight Ticket ID');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `charge_category` SET TAGS ('dbx_value_regex' = 'service_charge|rental_fee|disposal_fee|fuel_surcharge|environmental_fee|late_fee');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Item Description');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `is_disputed` SET TAGS ('dbx_business_glossary_term' = 'Is Disputed Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_rule` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Rule');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_rule` SET TAGS ('dbx_value_regex' = 'immediate|deferred|prorated|milestone');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognized_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognized Date');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period End Date');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period Start Date');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `tonnage` SET TAGS ('dbx_business_glossary_term' = 'Tonnage');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`billing`.`invoice_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `ar_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Batch ID');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `bank_deposit_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Deposit Batch ID');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Cleared Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Credit Card Last Four Digits');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Card Type');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover|other');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `gl_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `gl_period` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Period');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `lockbox_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Lockbox Batch ID');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `nsf_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Non-Sufficient Funds (NSF) Fee Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'standard|prepayment|deposit|retainer|refund|credit_memo');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `prepayment_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Expiry Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `processor_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Processor Transaction ID');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `refund_status` SET TAGS ('dbx_value_regex' = 'not_refunded|refund_requested|refund_approved|refund_issued|refund_rejected');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `payment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Application ID');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `application_source` SET TAGS ('dbx_business_glossary_term' = 'Application Source');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `application_source` SET TAGS ('dbx_value_regex' = 'manual|automatic|lockbox|customer_portal|batch_import|api');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'pending|applied|reversed|voided|adjusted');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `application_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Application Type');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'standard|prepayment|credit_memo_offset|dispute_settlement|overpayment_allocation|refund_reversal');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Application Comments');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `discount_date` SET TAGS ('dbx_business_glossary_term' = 'Discount Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `exchange_rate_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Type');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `exchange_rate_type` SET TAGS ('dbx_value_regex' = 'spot|corporate|user_defined');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `gl_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `invoice_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Invoice Balance After Application');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `invoice_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Invoice Balance Before Application');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `is_cross_currency` SET TAGS ('dbx_business_glossary_term' = 'Is Cross-Currency Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `is_on_account` SET TAGS ('dbx_business_glossary_term' = 'Is On-Account Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `matching_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Matching Rule Code');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `original_applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Applied Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `payment_method_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Code');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `remaining_unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Unapplied Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `reversal_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Description');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_application` ALTER COLUMN `writeoff_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Account ID');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan ID');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `account_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `account_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|write_off|bankruptcy');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `aging_bucket_0_30_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket 0-30 Days');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `aging_bucket_31_60_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket 31-60 Days');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `aging_bucket_61_90_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket 61-90 Days');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `aging_bucket_over_90_days` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket Over 90 Days');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `ar_account_number` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Account Number');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `ar_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `ar_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `auto_pay_enrolled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Pay Enrolled Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `available_credit` SET TAGS ('dbx_business_glossary_term' = 'Available Credit');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `bad_debt_reserve` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Reserve');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `billing_currency` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `billing_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|on_demand|custom');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `credit_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `credit_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Hold Reason');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'approved|on_hold|under_review|restricted|revoked');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Balance');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `days_sales_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Days Sales Outstanding (DSO)');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `last_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `last_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Date');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `paperless_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `payment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `sap_fi_ar_account_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Financial Accounting (FI) Accounts Receivable (AR) Account Number');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `sap_fi_ar_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `sap_fi_ar_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Certificate Number');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `total_adjustments_ytd` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustments Year-to-Date (YTD)');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `total_invoiced_ytd` SET TAGS ('dbx_business_glossary_term' = 'Total Invoiced Year-to-Date (YTD)');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `total_payments_ytd` SET TAGS ('dbx_business_glossary_term' = 'Total Payments Year-to-Date (YTD)');
ALTER TABLE `waste_management_ecm`.`billing`.`ar_account` ALTER COLUMN `write_off_amount_ytd` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount Year-to-Date (YTD)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` SET TAGS ('dbx_subdomain' = 'rate_configuration');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Schedule ID');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `agreement_type_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `frequency_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Frequency Plan Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|active|suspended|retired');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `base_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'flat_rate|per_pickup|per_ton|per_yard|container_rental|subscription');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `container_rental_fee` SET TAGS ('dbx_business_glossary_term' = 'Container Rental Fee');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `disposal_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Disposal Surcharge');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `environmental_fee` SET TAGS ('dbx_business_glossary_term' = 'Environmental Fee');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `fuel_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Rate');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `gl_cost_center` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Cost Center');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `gl_revenue_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Revenue Account');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `indexation_formula` SET TAGS ('dbx_business_glossary_term' = 'Indexation Formula');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Notes');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `overage_rate` SET TAGS ('dbx_business_glossary_term' = 'Overage Rate');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `rate_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Rate Calculation Method');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `rate_calculation_method` SET TAGS ('dbx_value_regex' = 'fixed|percentage|per_unit|tiered|indexed');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `rate_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` SET TAGS ('dbx_subdomain' = 'rate_configuration');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Component ID');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule ID');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `escalation_clause_id` SET TAGS ('dbx_business_glossary_term' = 'Escalation Clause Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `superseded_by_component_rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Component ID');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `applies_to_container_type` SET TAGS ('dbx_business_glossary_term' = 'Applies to Container Type');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `applies_to_service_type` SET TAGS ('dbx_business_glossary_term' = 'Applies to Service Type');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'fixed|percentage|per_unit|tiered|formula');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `component_code` SET TAGS ('dbx_business_glossary_term' = 'Component Code');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `component_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `component_name` SET TAGS ('dbx_business_glossary_term' = 'Component Name');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `component_status` SET TAGS ('dbx_business_glossary_term' = 'Component Status');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `component_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|archived');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `deferral_period_months` SET TAGS ('dbx_business_glossary_term' = 'Deferral Period in Months');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `formula_expression` SET TAGS ('dbx_business_glossary_term' = 'Formula Expression');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `gl_revenue_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Revenue Account');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `gl_revenue_account` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `invoice_label` SET TAGS ('dbx_business_glossary_term' = 'Invoice Label');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `pass_through_flag` SET TAGS ('dbx_business_glossary_term' = 'Pass-Through Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `print_on_invoice_flag` SET TAGS ('dbx_business_glossary_term' = 'Print on Invoice Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `proration_method` SET TAGS ('dbx_business_glossary_term' = 'Proration Method');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `proration_method` SET TAGS ('dbx_value_regex' = 'none|daily|monthly|actual_days');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Rate Value');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `regulatory_fee_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Fee Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `revenue_recognition_rule` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Rule');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `revenue_recognition_rule` SET TAGS ('dbx_value_regex' = 'immediate|deferred|over_service_period|milestone');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `rounding_rule` SET TAGS ('dbx_business_glossary_term' = 'Rounding Rule');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `rounding_rule` SET TAGS ('dbx_value_regex' = 'none|nearest_cent|round_up|round_down|nearest_dollar');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `tax_category` SET TAGS ('dbx_business_glossary_term' = 'Tax Category');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `tax_category` SET TAGS ('dbx_value_regex' = 'standard|exempt|reduced|zero_rated');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `waste_management_ecm`.`billing`.`rate_component` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` SET TAGS ('dbx_subdomain' = 'rate_configuration');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `billing_tipping_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Tipping Fee Schedule ID');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `container_type_id` SET TAGS ('dbx_business_glossary_term' = 'Container Type Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `mrf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Mrf Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Recycling Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `transfer_station_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Station Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Service Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `customer_tier` SET TAGS ('dbx_business_glossary_term' = 'Customer Tier');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `customer_tier` SET TAGS ('dbx_value_regex' = 'municipal|commercial|industrial|self_haul|broker|internal');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `environmental_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Environmental Surcharge');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `fee_per_ton` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Per Ton');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `host_community_fee` SET TAGS ('dbx_business_glossary_term' = 'Host Community Fee');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `internal_transfer_pricing_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Transfer Pricing Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `local_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Local Tax Rate');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `minimum_load_fee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Load Fee');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'flat_rate|tiered|volume_based|time_of_day');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Schedule Code');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Schedule Name');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Schedule Status');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|superseded');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `state_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'State Tax Rate');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_tipping_fee_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'ton|cubic_yard|load');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` SET TAGS ('dbx_subdomain' = 'billing_accounts');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `advance_billing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Advance Billing Enabled Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `ar_aging_bucket_days` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Aging Bucket Days');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Enabled Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'subscription|transactional|usage-based|hybrid');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `billing_period_day` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Day of Month');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_business_glossary_term' = 'Invoice Consolidation Level');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `consolidation_level` SET TAGS ('dbx_value_regex' = 'account|site|parent-account|consolidated');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Description');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Name');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Status');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|archived');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `discount_eligibility_enabled` SET TAGS ('dbx_business_glossary_term' = 'Discount Eligibility Enabled Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `dunning_process_enabled` SET TAGS ('dbx_business_glossary_term' = 'Dunning Process Enabled Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `early_payment_discount_days` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Days');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `early_payment_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percentage');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi-monthly|quarterly|annual|per-haul|on-demand');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `gl_ar_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Accounts Receivable (AR) Account Code');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `gl_ar_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `gl_revenue_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Revenue Account Code');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `gl_revenue_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|postal-mail|portal|edi|both');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `invoice_generation_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Generation Date');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `late_fee_flat_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Flat Amount (USD)');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `late_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Percentage');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `late_fee_trigger_enabled` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Trigger Enabled Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `payment_due_date_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date Offset Days');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net-15|net-30|net-45|net-60|due-on-receipt|prepaid');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `proration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Proration Enabled Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Method');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `revenue_recognition_method` SET TAGS ('dbx_value_regex' = 'point-in-time|over-time|milestone-based');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `statement_generation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Statement Generation Enabled Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `tax_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Calculation Method');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `tax_calculation_method` SET TAGS ('dbx_value_regex' = 'standard|exempt|reverse-charge|mixed');
ALTER TABLE `waste_management_ecm`.`billing`.`cycle` ALTER COLUMN `write_off_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Threshold Amount (USD)');
ALTER TABLE `waste_management_ecm`.`billing`.`run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`billing`.`run` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `accounts_on_hold` SET TAGS ('dbx_business_glossary_term' = 'Accounts on Billing Hold');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `accounts_with_errors` SET TAGS ('dbx_business_glossary_term' = 'Accounts with Billing Errors');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `ar_posting_status` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Posting Status');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `ar_posting_status` SET TAGS ('dbx_value_regex' = 'pending|posted|failed|reversed');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Duration in Seconds');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Billing Run End Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `error_log_summary` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Error Log Summary');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `gl_batch_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Batch Number');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `invoice_release_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Release Date');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Notes');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Number');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Status');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed|cancelled|suspended');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Type');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'scheduled|manual|correction|supplemental|final|interim');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Billing Run Start Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `total_accounts_processed` SET TAGS ('dbx_business_glossary_term' = 'Total Customer Accounts Processed');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `total_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustment Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `total_billed_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Billed Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `total_invoices_generated` SET TAGS ('dbx_business_glossary_term' = 'Total Invoices Generated');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `total_service_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Service Charge Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `total_usage_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Usage Charge Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`run` ALTER COLUMN `zero_balance_accounts` SET TAGS ('dbx_business_glossary_term' = 'Zero Balance Accounts');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `accident_report_id` SET TAGS ('dbx_business_glossary_term' = 'Accident Report Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `commodity_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Sale Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `contamination_event_id` SET TAGS ('dbx_business_glossary_term' = 'Contamination Event Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `downtime_event_id` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `haul_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Haul Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `load_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Load Ticket Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `on_demand_request_id` SET TAGS ('dbx_business_glossary_term' = 'On Demand Request Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `pickup_event_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Event Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `reversed_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Adjustment Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `rolloff_order_id` SET TAGS ('dbx_business_glossary_term' = 'Rolloff Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `service_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Service Exception Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `sla_term_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Term Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `vehicle_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assignment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `weight_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Weight Ticket Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_value_regex' = '^ADJ-[0-9]{8,12}$');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|escalated');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `bad_debt_flag` SET TAGS ('dbx_business_glossary_term' = 'Bad Debt Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `corrected_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Corrected Charge Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `customer_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `original_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Charge Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovery Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `recovery_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Recovery Eligible Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `revenue_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Impact Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `service_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period End Date');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `service_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period Start Date');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'ORACLE_RM|SAP_FICO|MANUAL|AMCS|WASTE_LOGICS');
ALTER TABLE `waste_management_ecm`.`billing`.`adjustment` ALTER COLUMN `write_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `accident_report_id` SET TAGS ('dbx_business_glossary_term' = 'Accident Report Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Case Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `compliance_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Inspection Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `downtime_event_id` SET TAGS ('dbx_business_glossary_term' = 'Downtime Event Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `driver_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `haul_manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Haul Manifest Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `inbound_load_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Load Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Disputed Line Item Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `load_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Load Ticket Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `on_demand_request_id` SET TAGS ('dbx_business_glossary_term' = 'On Demand Request Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `pickup_event_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Event Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `rolloff_order_id` SET TAGS ('dbx_business_glossary_term' = 'Rolloff Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Address Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `sla_definition_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Definition Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `sla_term_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Term Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `stop_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Stop Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `weight_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Weight Ticket Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Rating');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_value_regex' = '^DSP-[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|under review|resolved|escalated|closed|withdrawn');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `financial_impact_category` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Category');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `financial_impact_category` SET TAGS ('dbx_value_regex' = 'revenue loss|customer retention risk|goodwill gesture|operational cost|no financial impact');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Dispute Priority');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Description');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `sla_target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Resolution Date');
ALTER TABLE `waste_management_ecm`.`billing`.`dispute` ALTER COLUMN `sox_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Compliance Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` SET TAGS ('dbx_subdomain' = 'payment_collections');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `billing_term_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Term Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `auto_pay_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Enabled Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `bankruptcy_case_number` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy Case Number');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `bankruptcy_case_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{5}$');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `bankruptcy_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `bankruptcy_chapter` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy Chapter');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `bankruptcy_chapter` SET TAGS ('dbx_value_regex' = 'chapter_7|chapter_11|chapter_13');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `default_threshold_count` SET TAGS ('dbx_business_glossary_term' = 'Default Threshold Count');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `down_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Down Payment Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `down_payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Down Payment Received Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `enrolled_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Balance Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `final_installment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Final Installment Due Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `first_installment_due_date` SET TAGS ('dbx_business_glossary_term' = 'First Installment Due Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `installment_amount` SET TAGS ('dbx_business_glossary_term' = 'Installment Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Installment Frequency');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `interest_accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrued Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `interest_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percent');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `missed_installment_count` SET TAGS ('dbx_business_glossary_term' = 'Missed Installment Count');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Notes');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `original_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Balance Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan End Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Number');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^PP-[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Start Date');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Status');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|completed|defaulted|cancelled|suspended');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Type');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'residential_hardship|commercial_workout|standard_installment|seasonal_deferral|bankruptcy_arrangement|settlement_plan');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `remaining_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `settlement_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Discount Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `settlement_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Settlement Discount Percent');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `total_installment_count` SET TAGS ('dbx_business_glossary_term' = 'Total Installment Count');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `total_late_fees_assessed` SET TAGS ('dbx_business_glossary_term' = 'Total Late Fees Assessed');
ALTER TABLE `waste_management_ecm`.`billing`.`payment_plan` ALTER COLUMN `total_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Paid Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` SET TAGS ('dbx_subdomain' = 'rate_configuration');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Surcharge ID');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `applicability_customer_type` SET TAGS ('dbx_business_glossary_term' = 'Applicability Customer Type');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `applicability_service_type` SET TAGS ('dbx_business_glossary_term' = 'Applicability Service Type');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `invoice_display_order` SET TAGS ('dbx_business_glossary_term' = 'Invoice Display Order');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `is_prorated` SET TAGS ('dbx_business_glossary_term' = 'Is Prorated Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `is_regulatory_mandated` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Mandated Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Notes');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Rate Value');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|per_service|one_time');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `revenue_category` SET TAGS ('dbx_value_regex' = 'service_revenue|surcharge_revenue|fee_revenue|penalty_revenue|other_revenue');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `surcharge_code` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Code');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `surcharge_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `surcharge_name` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Name');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `surcharge_status` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Status');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `surcharge_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|suspended');
ALTER TABLE `waste_management_ecm`.`billing`.`surcharge` ALTER COLUMN `surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Type');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `rated_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Rated Usage ID');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `surcharge_id` SET TAGS ('dbx_business_glossary_term' = 'Applied Surcharge Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `asset_container_id` SET TAGS ('dbx_business_glossary_term' = 'Container ID');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `load_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Load Ticket Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `on_demand_request_id` SET TAGS ('dbx_business_glossary_term' = 'On Demand Request Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `pickup_event_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Event Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Recycling Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Component ID');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `rolloff_order_id` SET TAGS ('dbx_business_glossary_term' = 'Rolloff Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `route_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Route Execution Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route ID');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Run Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `service_address_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location ID');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `service_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `service_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `service_commitment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Commitment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `service_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Service Enrollment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `service_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Rate Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `service_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Service Schedule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `tax_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Rule Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `vehicle_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assignment Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `weight_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Weight Ticket Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `accounting_period` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `base_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Charge Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `environmental_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Environmental Fee Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `fuel_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `gl_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Date');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Override Reason Code');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_value_regex' = 'CUSTOMER_DISPUTE|PRICING_ERROR|GOODWILL_ADJUSTMENT|CONTRACT_EXCEPTION|SYSTEM_ERROR|RATE_CORRECTION');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `override_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Override Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `rated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rated Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `rating_error_code` SET TAGS ('dbx_business_glossary_term' = 'Rating Error Code');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `rating_error_message` SET TAGS ('dbx_business_glossary_term' = 'Rating Error Message');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `rating_status` SET TAGS ('dbx_value_regex' = 'RATED|PENDING|ERROR|OVERRIDE|REPROCESSED|CANCELLED');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `revenue_recognition_rule` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Rule');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `revenue_recognition_rule` SET TAGS ('dbx_value_regex' = 'IMMEDIATE|DEFERRED|PRORATED|MILESTONE');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `service_type_code` SET TAGS ('dbx_business_glossary_term' = 'Service Type Code');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `service_type_code` SET TAGS ('dbx_value_regex' = 'RESIDENTIAL_COLLECTION|COMMERCIAL_COLLECTION|ROLLOFF|RECYCLING|LANDFILL_DISPOSAL|TRANSFER_STATION');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `subtotal_amount` SET TAGS ('dbx_business_glossary_term' = 'Subtotal Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `total_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charge Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EACH|TON|CUBIC_YARD|DAY|GALLON|POUND');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `usage_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Date');
ALTER TABLE `waste_management_ecm`.`billing`.`rated_usage` ALTER COLUMN `usage_quantity` SET TAGS ('dbx_business_glossary_term' = 'Usage Quantity');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` SET TAGS ('dbx_subdomain' = 'rate_configuration');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `tax_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Rule ID');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `superseded_by_rule_tax_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Tax Rule ID');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `applicable_service_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Types');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Rule Approval Status');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Calculation Method');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'percentage|flat_fee|tiered|per_unit|compound');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `compounding_sequence` SET TAGS ('dbx_business_glossary_term' = 'Tax Compounding Sequence');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `customer_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Customer Type Applicability');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `customer_type_applicability` SET TAGS ('dbx_value_regex' = 'all|residential|commercial|industrial|municipal|government');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `exemption_categories` SET TAGS ('dbx_business_glossary_term' = 'Exemption Categories');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `exemption_certificate_required` SET TAGS ('dbx_business_glossary_term' = 'Exemption Certificate Required Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `gl_cost_center` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Cost Center');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `gl_cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `maximum_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Tax Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `minimum_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Tax Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Rule Notes');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `remittance_due_day` SET TAGS ('dbx_business_glossary_term' = 'Tax Remittance Due Day');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `remittance_frequency` SET TAGS ('dbx_business_glossary_term' = 'Tax Remittance Frequency');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `remittance_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|on_demand');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Reporting Code');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `reporting_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `revenue_recognition_rule` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Rule');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `revenue_recognition_rule` SET TAGS ('dbx_value_regex' = 'immediate|deferred|prorated|milestone');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Rule Code');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Tax Rule Description');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Rule Name');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Rule Status');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `rule_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|expired|superseded');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `tax_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Code');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `tax_authority_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `tax_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Name');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `tax_authority_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Authority Type');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `tax_authority_type` SET TAGS ('dbx_value_regex' = 'state|county|municipality|special_district|federal|tribal');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `tax_base` SET TAGS ('dbx_business_glossary_term' = 'Tax Base');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `tax_base` SET TAGS ('dbx_value_regex' = 'gross_amount|net_amount|tonnage|pickup_count|container_count|service_days');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `tax_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type');
ALTER TABLE `waste_management_ecm`.`billing`.`tax_rule` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'sales_tax|excise_tax|solid_waste_tax|environmental_surcharge|tipping_fee_tax|franchise_fee');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` SET TAGS ('dbx_subdomain' = 'billing_accounts');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `bundle_id` SET TAGS ('dbx_business_glossary_term' = 'Bundle Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `cycle_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Name');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Number');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^BA[0-9]{8,12}$');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Status');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_activation|delinquent|collections');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Type');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal|government|non_profit');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `autopay_enrolled_flag` SET TAGS ('dbx_business_glossary_term' = 'Autopay Enrollment Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `autopay_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Autopay Enrollment Date');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Account Close Date');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `close_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Account Close Reason Code');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `close_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|no_rating');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Currency Code');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `dunning_level` SET TAGS ('dbx_business_glossary_term' = 'Dunning Level');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `last_dunning_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dunning Date');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Notes');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Account Open Date');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `oracle_account_number` SET TAGS ('dbx_business_glossary_term' = 'Oracle Revenue Management Account Number');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `oracle_account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `oracle_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `oracle_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `paperless_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `paperless_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Paperless Enrollment Date');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_value_regex' = 'ach|credit_card|check|wire_transfer|cash');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Flag');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exemption_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exemption_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Expiration Date');
